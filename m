Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C38D8436535
	for <lists+linux-pci@lfdr.de>; Thu, 21 Oct 2021 17:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbhJUPMj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Oct 2021 11:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbhJUPMi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Oct 2021 11:12:38 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9DFCC061220;
        Thu, 21 Oct 2021 08:10:22 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id u6so644303ple.2;
        Thu, 21 Oct 2021 08:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nBZl56cwXIMS5MrYNm3KnDDaTcN98ZdLkMKDc078ljY=;
        b=HdkoSvfcTUXobi9Chvh9ved3HASn3xYwiDKYDXWN4rdB7A+yhWpPRtnoUM4EhsGWnI
         RyMbK4qETKb+a9y3fsQ4FTniSkNxvQUJMgkVUsTzlcsew7Fo8MCnGi00jDpbApEI3UyX
         Zu4yr3qeC01mj4DlX3sK38LUlIy0jakLtEB+vYwx5i1O6kPJSTYohXR9kobvKdBWI8rJ
         UTL2AhCcunsJ78c21ku9rLh81UciA1R+N1nnHnJsZ6cQcIarQy8m0iPBx8ztP55G4Kv7
         TwPKY8qwmWy3Tldytyg5Zq94nKgpgK/qRdr/w6yzCSWpkFM2iOEIRQ6P0W4wlT13zVd+
         UKow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nBZl56cwXIMS5MrYNm3KnDDaTcN98ZdLkMKDc078ljY=;
        b=yvgjZDWVLCrd/oKsqTM/4op/m2RB8eEgYKUJZ6k/ksIl/idWLNR2Uxw3Wd0lGWDvCU
         torTXjizNwRdLqyEQoHcHAg6GiLk5VST0mPLb1oZpipkWCVmGCgjLdfNG3eHODjFZinY
         YtchGDfzsYa/J+cMWHPrSARDonkizXYVmUSJL64fOMwlkqmF5cx9CKV9hryElfto4Mwo
         2Y/5iPSh67Yr0AusIGPTukbWAzngg3Dxkj51iQIUNO9tiPwUdDMlH8lHxT6M5Haileyq
         BdEk3sb+q1c76vEp2QfRWuuWBU9gFLO/5yoGz5I4YelrGLfjKD6m8H3CdoIyYj9jEX5H
         4O/Q==
X-Gm-Message-State: AOAM5312+U5wkAlFf+pMX5hVohnwAWi/GdGheaT9HDr62YQJfXl46QSC
        QoLYZVBac5T7fL0J4KawDqk=
X-Google-Smtp-Source: ABdhPJzFJV86fZ2NHUP1FR2UDK+UElhuVdbXO1ta6lVEh1vuhS2K9/0lYIzgoDVOhedSsVR8HXOyOw==
X-Received: by 2002:a17:90b:4d88:: with SMTP id oj8mr5119693pjb.175.1634829022270;
        Thu, 21 Oct 2021 08:10:22 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:29a4:d874:a949:6890:f95f])
        by smtp.gmail.com with ESMTPSA id c9sm5508027pgq.58.2021.10.21.08.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 08:10:21 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v3 04/25] PCI: Remove redundant error fabrication when device read fails
Date:   Thu, 21 Oct 2021 20:37:29 +0530
Message-Id: <b30f9ca658703da793345dc6803ffc77f7504e1f.1634825082.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1634825082.git.naveennaidu479@gmail.com>
References: <cover.1634825082.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

An MMIO read from a PCI device that doesn't exist or doesn't respond
causes a PCI error. There's no real data to return to satisfy the
CPU read, so most hardware fabricates ~0 data.

The host controller drivers sets the error response values (~0) and
returns an error when faulty hardware read occurs. But the error
response value (~0) is already being set in PCI_OP_READ and
PCI_USER_READ_CONFIG whenever a read by host controller driver fails.

Thus, it's no longer necessary for the host controller drivers to
fabricate any error response.

This helps unify PCI error response checking and make error check
consistent and easier to find.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
---
 drivers/pci/access.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index a6bcbad04d89..2705a4412e69 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -83,10 +83,8 @@ int pci_generic_config_read(struct pci_bus *bus, unsigned int devfn,
 	void __iomem *addr;
 
 	addr = bus->ops->map_bus(bus, devfn, where);
-	if (!addr) {
-		*val = ~0;
+	if (!addr)
 		return PCIBIOS_DEVICE_NOT_FOUND;
-	}
 
 	if (size == 1)
 		*val = readb(addr);
@@ -125,10 +123,8 @@ int pci_generic_config_read32(struct pci_bus *bus, unsigned int devfn,
 	void __iomem *addr;
 
 	addr = bus->ops->map_bus(bus, devfn, where & ~0x3);
-	if (!addr) {
-		*val = ~0;
+	if (!addr)
 		return PCIBIOS_DEVICE_NOT_FOUND;
-	}
 
 	*val = readl(addr);
 
-- 
2.25.1

