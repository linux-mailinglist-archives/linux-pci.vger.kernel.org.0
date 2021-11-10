Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47FB844CC63
	for <lists+linux-pci@lfdr.de>; Wed, 10 Nov 2021 23:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233769AbhKJWUc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Nov 2021 17:20:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233640AbhKJWU0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Nov 2021 17:20:26 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD22C0432C2;
        Wed, 10 Nov 2021 14:15:27 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id nh10-20020a17090b364a00b001a69adad5ebso3056870pjb.2;
        Wed, 10 Nov 2021 14:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fphIdUDXSUqQoN+550Js8LMURtYvUNV04vrXLaftqCA=;
        b=ln4adG2D4DDbq+rFf48o0HcEK0FDmocia0H8rr3LEwkHDfo2H/+WjFR9ays+LbzTcu
         fFzPxWA3n+Cvq0bS3Q+eX3qtnO19Qoext6nY+slmvdD4XGOM8VHcfdne05O2u6TMzpRy
         Sp93MFXN9qp3dNlJKnsLsXLy06pbdUog0MIAPlgt2wb7H/s/hQxXZkOg4PmCrgiYNrsI
         sYb2cz2VzuaOVHCdKVfq/UWQHCU4mylRjZP/sd/JYUyA8JRtzHPv3ax1XpqOr69Smsmc
         a+jw/hWmXgTt6AKyeKrm5SJk/6ogV0vJm7c6yWOd0JZQgholaOnlOaP2gVVf1hrCJ/rf
         0X3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fphIdUDXSUqQoN+550Js8LMURtYvUNV04vrXLaftqCA=;
        b=pQARcVpWtQXOK+7442nzgNqMl9T7/6rH2omSRAefOmzreKWWGTRLMdiXxAGYGXv9xJ
         iDEjGf25c+LehQbpf/uRGD+ubmEXCjKnBer76aAl/NlqugpEV9Nub9f8r4elmDax3HgR
         k7dWUQSbJve26XWaNg8mfTrHWKT+6W7k5Mm2tqFeDjmUwk2dmAvCMQC7i0xAS6CzSeFF
         AxxzWaF98KMuzGC8Lv6XFlc0yxapNmyR9+Sa3uViQMnDBSDKTeAa8R0E0KSO4j0ywIPV
         C5nyr0SEgefQMUcYIMZ0MHIoXUZRvjE7rLyuEm7dxKKhtN+daMBacM91bSYCTrGpKDqS
         J5nQ==
X-Gm-Message-State: AOAM531ZomHQTlsUxFnaWQ9zvFhjbI1Uq82/3y867kipRu9GV5ghXPYl
        Hb0lq9wosMMwF+U8cCCr2UNRGXu23CYR3w==
X-Google-Smtp-Source: ABdhPJyQQlP061pJeeiR5E45HKt/hY21coyGMCUv9LXIeukPDxZPkugMJD4lzg5n7VjYO33voos8CQ==
X-Received: by 2002:a17:90a:4701:: with SMTP id h1mr2725940pjg.184.1636582526604;
        Wed, 10 Nov 2021 14:15:26 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id q11sm611774pfk.192.2021.11.10.14.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 14:15:26 -0800 (PST)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        james.quinlan@broadcom.com
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v8 8/8] PCI: brcmstb: Add control of subdevice voltage regulators
Date:   Wed, 10 Nov 2021 17:14:48 -0500
Message-Id: <20211110221456.11977-9-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211110221456.11977-1-jim2101024@gmail.com>
References: <20211110221456.11977-1-jim2101024@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This Broadcom STB PCIe RC driver has one port and connects directly to one
device, be it a switch or an endpoint.  We want to be able to leverage
the recently added mechansim that allocates and turns on/off subdevice
regulators.

All that needs to be done is to put the regulator DT nodes in the bridge
below host and to set the pci_ops methods add_bus and remove_bus.

Note that the pci_subdev_regulators_add_bus() method is wrapped for two
reasons:

   1. To acheive linkup after the voltage regulators are turned on.

   2. If, in the case of an unsuccessful linkup, to redirect
      any PCIe accesses to subdevices, e.g. the scan for
      DEV/ID.  This redirection is needed because the Broadcom
      PCIe HW wil issue a CPU abort if such an access is made when
      there is no linkup.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 56 ++++++++++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 1a841c240abb..692df3dda77a 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -191,6 +191,7 @@ static inline void brcm_pcie_bridge_sw_init_set_generic(struct brcm_pcie *pcie,
 static inline void brcm_pcie_perst_set_4908(struct brcm_pcie *pcie, u32 val);
 static inline void brcm_pcie_perst_set_7278(struct brcm_pcie *pcie, u32 val);
 static inline void brcm_pcie_perst_set_generic(struct brcm_pcie *pcie, u32 val);
+static int brcm_pcie_add_bus(struct pci_bus *bus);
 
 enum {
 	RGR1_SW_INIT_1,
@@ -295,6 +296,7 @@ struct brcm_pcie {
 	u32			hw_rev;
 	void			(*perst_set)(struct brcm_pcie *pcie, u32 val);
 	void			(*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
+	bool			refusal_mode;
 };
 
 /*
@@ -711,6 +713,18 @@ static void __iomem *brcm_pcie_map_conf(struct pci_bus *bus, unsigned int devfn,
 	/* Accesses to the RC go right to the RC registers if slot==0 */
 	if (pci_is_root_bus(bus))
 		return PCI_SLOT(devfn) ? NULL : base + where;
+	if (pcie->refusal_mode) {
+		/*
+		 * At this point we do not have link.  There will be a CPU
+		 * abort -- a quirk with this controller --if Linux tries
+		 * to read any config-space registers besides those
+		 * targeting the host bridge.  To prevent this we hijack
+		 * the address to point to a safe access that will return
+		 * 0xffffffff.
+		 */
+		writel(0xffffffff, base + PCIE_MISC_RC_BAR2_CONFIG_HI);
+		return base + PCIE_MISC_RC_BAR2_CONFIG_HI + (where & 0x3);
+	}
 
 	/* For devices, write to the config space index register */
 	idx = PCIE_ECAM_OFFSET(bus->number, devfn, 0);
@@ -722,6 +736,8 @@ static struct pci_ops brcm_pcie_ops = {
 	.map_bus = brcm_pcie_map_conf,
 	.read = pci_generic_config_read,
 	.write = pci_generic_config_write,
+	.add_bus = brcm_pcie_add_bus,
+	.remove_bus = pci_subdev_regulators_remove_bus,
 };
 
 static inline void brcm_pcie_bridge_sw_init_set_generic(struct brcm_pcie *pcie, u32 val)
@@ -1242,6 +1258,34 @@ static const struct of_device_id brcm_pcie_match[] = {
 	{},
 };
 
+static int brcm_pcie_add_bus(struct pci_bus *bus)
+{
+	struct pci_host_bridge *hb;
+	struct brcm_pcie *pcie;
+	int ret;
+
+	if (!pcie_is_port_dev(bus->self))
+		return 0;
+
+	hb = pci_find_host_bridge(bus);
+	pcie = (struct brcm_pcie *) hb->sysdata;
+
+	ret = pci_subdev_regulators_add_bus(bus);
+	if (ret)
+		return ret;
+
+	/*
+	 * If we have failed linkup there is no point to return an error as
+	 * currently it will cause a WARNING() from pci_alloc_child_bus().
+	 * We return 0 and turn on the "refusal_mode" so that any further
+	 * accesses to the pci_dev just get 0xffffffff
+	 */
+	if (brcm_pcie_linkup(pcie) != 0)
+		pcie->refusal_mode = true;
+
+	return 0;
+}
+
 static int brcm_pcie_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node, *msi_np;
@@ -1333,7 +1377,17 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, pcie);
 
-	return pci_host_probe(bridge);
+	ret = pci_host_probe(bridge);
+	if (!ret && !brcm_pcie_link_up(pcie))
+		ret = -ENODEV;
+
+	if (ret) {
+		brcm_pcie_remove(pdev);
+		return ret;
+	}
+
+	return 0;
+
 fail:
 	__brcm_pcie_remove(pcie);
 	return ret;
-- 
2.17.1

