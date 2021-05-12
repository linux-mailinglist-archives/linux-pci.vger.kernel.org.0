Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0672137EE05
	for <lists+linux-pci@lfdr.de>; Thu, 13 May 2021 00:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbhELVH0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 May 2021 17:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358191AbhELSnF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 May 2021 14:43:05 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6136BC06138E
        for <linux-pci@vger.kernel.org>; Wed, 12 May 2021 11:41:03 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id d21so23129547oic.11
        for <linux-pci@vger.kernel.org>; Wed, 12 May 2021 11:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XmDVrHusp4k4TH4Rdds8NJAp7ze1VCqnR4KQ0dA02nk=;
        b=cPiUw8YKF0IlUEvOkwooUMppYUibeTT+1Zm71RcrPyneGieTvof4BZfCFGB2zlY8Xe
         a9mHHvlfJe8o8wWTt60H9qUplhz5axzLKmjBzr1Q5lCvms+VIkbuDIdWgjXPIus/+hhn
         trHBoqby3bveL7IFhFVfLqDemFHKFd8MktxmCUJA216ZT2jLMHa9bRRFi6/jOHYO3V6X
         48LDR0UgxIFTyvdJSW13Jgj+O5Pe5dIkJJsmgB+rcvJ4d2SCdpcaE8zSy5xMFKJKOfx8
         FYAXywDrWCLliHnFwNgGRmTQamSKpWTBlMm9RynkpOmmg3rl6kXzALbCZZzsSod3Ltb9
         yCjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XmDVrHusp4k4TH4Rdds8NJAp7ze1VCqnR4KQ0dA02nk=;
        b=UZ4cOmnTnxJSOMD0q/ulgKuPSRk/QqEHZ+uG46QsGlQsihkaghQ47c9Fg1ilGt5acl
         8EMLUBMGrLwa6dzAXmYPntufm0v37Oo/noXfFwSFeR3eV40nxyMA1rGpWK5F2BdOZ1o7
         iawi+SfRiFC22rtVrUpywOJBZwOUlpoYX0wcNvX0GGJ579JWNTYFJc06RdIut3ZZ/O3J
         prU+uceHoad4z5FxSrA3enLkLHwrYXeYDZOzZTDXWm9SbAyJsAprx4aRiv+akQizUxD1
         YbQS2GP/i7eZSxQ8e7TSSyUSq9RwEDPgC0lSR3gW+mNELRX/jis3NKPwNUq6QAfpj7Kt
         Uv2Q==
X-Gm-Message-State: AOAM5319dlwwHVHp7XEP86D9Z3JkWzXojVMuOYGvnYYLvngn70E8HdTP
        cIAwe2t6+PuzfcIODIQEatM=
X-Google-Smtp-Source: ABdhPJxsFh1OjdlMaKOCeIzMXu3fgb8RyPetNQYo+w2MJstEs8Brpdo+0bp5yklgNKEp/pmPaAWkgg==
X-Received: by 2002:a05:6808:d:: with SMTP id u13mr11221249oic.103.1620844862861;
        Wed, 12 May 2021 11:41:02 -0700 (PDT)
Received: from localhost.localdomain ([14.141.145.218])
        by smtp.gmail.com with ESMTPSA id o1sm137432otj.39.2021.05.12.11.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 11:41:02 -0700 (PDT)
From:   Stuart Hayes <stuart.w.hayes@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Lukas Wunner <lukas@wunner.de>,
        Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: [PATCH] PCI/portdrv: Use link bandwidth notification capability bit
Date:   Thu, 13 May 2021 00:10:50 +0530
Message-Id: <20210512184050.2915-1-stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pcieport driver can fail to attach to a downstream port that doesn't
support bandwidth notificaion.  This can happen when, in
pcie_port_device_register(), pci_init_service_irqs() tries (and fails) to
set up a bandwidth notificaion IRQ for a device that doesn't support it.

This patch changes get_port_device_capability() to look at the link
bandwidth notification capability bit in the link capabilities register of
the port, instead of assuming that all downstream ports have that
capability.

Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
---
 drivers/pci/pcie/portdrv_core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index e1fed6649c41..3ee63968deaa 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -257,8 +257,13 @@ static int get_port_device_capability(struct pci_dev *dev)
 		services |= PCIE_PORT_SERVICE_DPC;
 
 	if (pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM ||
-	    pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
-		services |= PCIE_PORT_SERVICE_BWNOTIF;
+	    pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT) {
+		u32 linkcap;
+
+		pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &linkcap);
+		if (linkcap & PCI_EXP_LNKCAP_LBNC)
+			services |= PCIE_PORT_SERVICE_BWNOTIF;
+	}
 
 	return services;
 }
-- 
2.27.0

