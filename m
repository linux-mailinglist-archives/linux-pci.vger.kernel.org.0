Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8191F9A4E
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jun 2020 16:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730197AbgFOOdC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Jun 2020 10:33:02 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42922 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730355AbgFOOdB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Jun 2020 10:33:01 -0400
Received: from mail-qv1-f70.google.com ([209.85.219.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <ian.may@canonical.com>)
        id 1jkqAV-0002Kk-TP
        for linux-pci@vger.kernel.org; Mon, 15 Jun 2020 14:33:00 +0000
Received: by mail-qv1-f70.google.com with SMTP id v1so13188439qvx.8
        for <linux-pci@vger.kernel.org>; Mon, 15 Jun 2020 07:32:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vsJNT2TWpnUybypxagc9dd0eSr67HV57qO0wSdP9VQM=;
        b=WCfSmQWcssGQmK0085xGqr7ubQs/FH2D8MdUzlqQFLoFz0FvRUoRG2WP2B+pPh7d38
         NdC9EaIWec5dJWhNYQuFJtGtXnHbNDP/WHSXKIc+IB6M3OU4EAmLAZAOSDj4fCdNTb4w
         oopj1IOQzmSNQUwqATcPenDHwMOGEaBztNMouxSqOK0h7M3dP6eFygtJnOu//lHLCliu
         XGFMqnjgPXoXRw48eoVW3SNm6Vm0bPfYbu0NKsszTUQgsvYv4HF0j7v/n0O6JNiftdoc
         v3WeGyPTB2Nj27Ec4dkmzHzvnIVSzaVFtns9cIpvZSNix+LnbR8DhUFsAaNYJr2Twnl4
         7Z0Q==
X-Gm-Message-State: AOAM531Wc41zSkKfcot6sZ9FaijaTKsvqESGdnImgobWsGmkqK+1GZZM
        DtzY0xI0KPzkPf2kfEjVhIgv0Hl1ENciBd4yuDszWRcnqVEBNfrNmsNh5WlmpB5Z2K6BA2S7ipL
        crhFbRyOa768gzCHSM7WrszTnLJ1dYiIZLYekag==
X-Received: by 2002:aed:2d87:: with SMTP id i7mr16403741qtd.291.1592231578769;
        Mon, 15 Jun 2020 07:32:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJygd6WFLi8rMUS5G1ubyzipA2/N7D7MjH3+e/+ruf02ll8n64B95rz7xYRMLtgEyuvD3vSYJw==
X-Received: by 2002:aed:2d87:: with SMTP id i7mr16403710qtd.291.1592231578499;
        Mon, 15 Jun 2020 07:32:58 -0700 (PDT)
Received: from localhost.localdomain ([2001:67c:1562:8007::aac:44bb])
        by smtp.gmail.com with ESMTPSA id u10sm12744675qth.32.2020.06.15.07.32.57
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 07:32:58 -0700 (PDT)
From:   Ian May <ian.may@canonical.com>
To:     linux-pci@vger.kernel.org
Subject: [PATCH 2/2] PCIe hotplug interrupt and AER pci_slot_mutex deadlock
Date:   Mon, 15 Jun 2020 09:32:50 -0500
Message-Id: <20200615143250.438252-3-ian.may@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200615143250.438252-1-ian.may@canonical.com>
References: <20200615143250.438252-1-ian.may@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In the AER recovery code path, pci_bus_error_reset acquires the pci_slot_mutex,
unlock and relock in call to pci_slot_reset around controller reset to lock in
same order as the hotplug code path.

        Hotplug                                AER
----------------------------       ---------------------------
down_read(&ctrl->reset_lock)	   mutex_lock(&pci_slot_mutex)
mutex_lock(&pci_slot_mutex)	   down_write(&ctrl->reset_lock)

Signed-off-by: Ian May <ian.may@canonical.com>
---
 drivers/pci/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e32c5a1a706e..4eeca8b18664 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5229,6 +5229,7 @@ static int pci_slot_reset(struct pci_slot *slot, int probe)
 
 	if (!probe)
 	{
+		mutex_unlock(&pci_slot_mutex);
 		slot->hotplug->ops->reset_lock(slot->hotplug);
 		pci_slot_lock(slot);
 	}
@@ -5241,6 +5242,7 @@ static int pci_slot_reset(struct pci_slot *slot, int probe)
 	{
 		pci_slot_unlock(slot);
 		slot->hotplug->ops->reset_unlock(slot->hotplug);
+		mutex_lock(&pci_slot_mutex);
 	}
 
 	return rc;
-- 
2.25.1

