Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A73714CD6B
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2020 16:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgA2PaG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jan 2020 10:30:06 -0500
Received: from mta-02.yadro.com ([89.207.88.252]:55796 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727097AbgA2PaF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Jan 2020 10:30:05 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 1C9FB4763A;
        Wed, 29 Jan 2020 15:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1580311804; x=1582126205; bh=KmV3hNPn7rKXFMzBEaQhlsXjxbcPu4B8Qcn
        sWgcAriE=; b=vE43uwmkmDO1eg2FoQh6i2DvpOlmKI8sgGRa4xEYfbwTu9MACBr
        ZI5zV+i2eDC/84XFjdE98T1eqJbbppEEnw6v20ZWe8dfL5T7MqC3J6VL+feTfbro
        1SSlNgppQ9ZPkDTc6vAcuXC1bRdeiIh+cmXoTR9PuUtf+sC/quqfPJlk=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id iQ7Yf_K5I6yF; Wed, 29 Jan 2020 18:30:04 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id CE1124761D;
        Wed, 29 Jan 2020 18:29:54 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.136) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Wed, 29
 Jan 2020 18:29:54 +0300
From:   Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>, Stefan Roese <sr@denx.de>,
        <linux@yadro.com>,
        Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH v7 21/26] PCI: hotplug: Don't disable the released bridge windows immediately
Date:   Wed, 29 Jan 2020 18:29:32 +0300
Message-ID: <20200129152937.311162-22-s.miroshnichenko@yadro.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200129152937.311162-1-s.miroshnichenko@yadro.com>
References: <20200129152937.311162-1-s.miroshnichenko@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.17.15.136]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On a hotplug event with enabled BAR movement, calculating the new bridge
windows takes some time. During this procedure, the structures that
represent these windows are "released" - means marked for recalculation by
setting to zero.

When the new bridge windows are ready, they are written to the registers of
every bridge via pci_setup_bridges().

Currently, bridge's registers are updated immediately after releasing a
window to disable it. But if a driver doesn't yet support movable BARs, it
doesn't stop MEM transactions during the hotplug, so disabled bridge
windows will break them.

Let the bridge windows remain operating after releasing, as they will be
updated to the new values in the end of a hotplug event.

Signed-off-by: Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
---
 drivers/pci/setup-bus.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 573d5c67c136..dd94b4ed7358 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1708,7 +1708,8 @@ static void pci_bridge_release_resources(struct pci_bus *bus,
 		/* Avoiding touch the one without PREF */
 		if (type & IORESOURCE_PREFETCH)
 			type = IORESOURCE_PREFETCH;
-		__pci_setup_bridge(bus, type);
+		if (!pci_can_move_bars)
+			__pci_setup_bridge(bus, type);
 		/* For next child res under same bridge */
 		r->flags = old_flags;
 	}
-- 
2.24.1

