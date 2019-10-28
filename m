Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B07D3E6E8E
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2019 09:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733246AbfJ1Iyq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Oct 2019 04:54:46 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44365 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730954AbfJ1Iyq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Oct 2019 04:54:46 -0400
Received: by mail-pg1-f194.google.com with SMTP id e10so6450098pgd.11
        for <linux-pci@vger.kernel.org>; Mon, 28 Oct 2019 01:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tz/eLS9GWjuONE2SqgYz3LI8GYDdc5KRtTV4JcWn9cM=;
        b=Wgxq6MBEIWzvIM5FQYlmEILX9B4hTz8Lq5H0AZEGCC3df+NSklJRlKh7ikkgdg2hDn
         JdlFmC/500vMuLjZP7BSjT/B6+dkLjiSDamfs68neMQFck1GBqYtiBynf/N02j4IcUsD
         0b9X0RsxoSmP21mZWUvjLxU86H3qjpz6LidqepRp5pCZ6RrUsl3sJ/snGLq3lpmzvLxa
         zEa7HUcgAKEoEZRSB23bri46zw4ymywIoT4V4agEqRS6IMiXTgVJohr9z/k1kzudAe0S
         j4kBQjlqdLWsAJmz3ohTfNKuS3M8aU0bMgDTFMQMsMFxDwNgXVUTDRv9ducssDBwp235
         eMsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tz/eLS9GWjuONE2SqgYz3LI8GYDdc5KRtTV4JcWn9cM=;
        b=GES3QlWe8y0gd7iYUe6gRZ5klM2b5FdEnSQWc+WEj425OkS86ZYPdFVjZSzHfnYpVJ
         9VBLoRerZ5yB+VTQHW6BEVmKemm4HbGkTTcE9KklQoMLc5AvMoDampKsdtgMNr45ph9E
         amFrOX3WkwD/+BDgQeu4y/wZ3/wqv6/P6jOo3uM7Uy/Dv6aZWWypBW4IkNc7NO1JClrV
         AcWB2oOf1YWrhp3bSz5IpKd/8wrNficOmuPwZO7yd5vMY2aF944+oL7epnfHa43lMCe+
         k8zj63b9YeyYQxsjWcDxqCSNsV4ScPlspU49dhFf6UsoQWGs0gbVxovm8QlMIUdm5sPP
         t+tg==
X-Gm-Message-State: APjAAAW+bcX1c4yIZQUKkZfO6I59vy/NYY96sk/49gL2tPBuL29a8/7m
        +IYNzeWky3a9aJ4sp8Uj3pN3WawwtRI=
X-Google-Smtp-Source: APXvYqzs5kotA0RconlUqusn0ksFnt4u5f65QNQXt+doD15LRKJ87F1+51WeR3xnNdC7u12LuIQJGg==
X-Received: by 2002:a63:d50c:: with SMTP id c12mr18190381pgg.199.1572252885260;
        Mon, 28 Oct 2019 01:54:45 -0700 (PDT)
Received: from wafer.ozlabs.ibm.com ([122.99.82.10])
        by smtp.gmail.com with ESMTPSA id l24sm10046115pff.151.2019.10.28.01.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 01:54:44 -0700 (PDT)
From:   Oliver O'Halloran <oohall@gmail.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     aik@ozlabs.ru, shawn@anastas.io, linux-pci@vger.kernel.org
Subject: [PATCH v2 2/3] powerpc/pci: Fix pcibios_setup_device() ordering
Date:   Mon, 28 Oct 2019 19:54:23 +1100
Message-Id: <20191028085424.12006-2-oohall@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191028085424.12006-1-oohall@gmail.com>
References: <20191028085424.12006-1-oohall@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Shawn Anastasio <shawn@anastas.io>

Move PCI device setup from pcibios_add_device() and pcibios_fixup_bus() to
pcibios_bus_add_device(). This ensures that platform-specific DMA and IOMMU
setup occurs after the device has been registered in sysfs, which is a
requirement for IOMMU group assignment to work

This fixes IOMMU group assignment for hotplugged devices on pseries, where
the existing behavior results in IOMMU assignment before registration.

Thanks to Lukas Wunner <lukas@wunner.de> for the suggestion.

Signed-off-by: Shawn Anastasio <shawn@anastas.io>
Tested-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/kernel/pci-common.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 1c448cf..b89925ed 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -261,12 +261,6 @@ int pcibios_sriov_disable(struct pci_dev *pdev)
 
 #endif /* CONFIG_PCI_IOV */
 
-void pcibios_bus_add_device(struct pci_dev *pdev)
-{
-	if (ppc_md.pcibios_bus_add_device)
-		ppc_md.pcibios_bus_add_device(pdev);
-}
-
 static resource_size_t pcibios_io_size(const struct pci_controller *hose)
 {
 #ifdef CONFIG_PPC64
@@ -987,15 +981,17 @@ static void pcibios_setup_device(struct pci_dev *dev)
 		ppc_md.pci_irq_fixup(dev);
 }
 
-int pcibios_add_device(struct pci_dev *dev)
+void pcibios_bus_add_device(struct pci_dev *pdev)
 {
-	/*
-	 * We can only call pcibios_setup_device() after bus setup is complete,
-	 * since some of the platform specific DMA setup code depends on it.
-	 */
-	if (dev->bus->is_added)
-		pcibios_setup_device(dev);
+	/* Perform platform-specific device setup */
+	pcibios_setup_device(pdev);
+
+	if (ppc_md.pcibios_bus_add_device)
+		ppc_md.pcibios_bus_add_device(pdev);
+}
 
+int pcibios_add_device(struct pci_dev *dev)
+{
 #ifdef CONFIG_PCI_IOV
 	if (ppc_md.pcibios_fixup_sriov)
 		ppc_md.pcibios_fixup_sriov(dev);
@@ -1037,9 +1033,6 @@ void pcibios_fixup_bus(struct pci_bus *bus)
 
 	/* Now fixup the bus bus */
 	pcibios_setup_bus_self(bus);
-
-	/* Now fixup devices on that bus */
-	pcibios_setup_bus_devices(bus);
 }
 EXPORT_SYMBOL(pcibios_fixup_bus);
 
-- 
2.9.5

