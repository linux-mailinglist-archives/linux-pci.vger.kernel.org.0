Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAB002667E1
	for <lists+linux-pci@lfdr.de>; Fri, 11 Sep 2020 19:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725945AbgIKRyQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Sep 2020 13:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgIKRxE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Sep 2020 13:53:04 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91331C06179F
        for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2020 10:53:01 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id m5so7154131pgj.9
        for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2020 10:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=s171ISrLCqrZg+lz/LKmx38rbaVG/MrDiA63Yj6bUaQ=;
        b=YGpCueX6zEpzOcmpaucltpEtXBgOTFxUAx6PzG3r1Oma7IjpX0KXtJN7bjotXlmgCM
         MlPScxKgrTFqXDXUh8mMks5XNwQKPn2T6og687dL9YPY22r+RvBZma7iT2eQ64dpbfnd
         rkvaTwF2R4j02LK3E24V3htTSVBQn/9V3kUKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=s171ISrLCqrZg+lz/LKmx38rbaVG/MrDiA63Yj6bUaQ=;
        b=TjD24QQFANLSeqexM0miWhUU0byqE+PeiFdXJhKxbBjV1syAAgpmtSlZDUD9KggO2v
         /FeCoKUCh3PRe+1ico0SA47BwvOS9m9OHOBNIVKW34NTXvWAm4SksZwJccfMEKAb0Uxq
         /JiqV9FWc8znL/hBiCiHpXiUl9iUISqtVNIACm0AyHGajPdkB+xlHgrtauSrNPwcbjYw
         YIuVCyjIESlhGNzn20hTWY0lNhKJwUn70y6YzzKhNlOhhcAs8zZEE8I8Mx+lGTdNko4P
         OOqCPB9eF1r9IguL9n1gw88JtSGhce803nADGkBNGFehIU7dnoqMl0MoHcPFp52bwY8G
         dCIQ==
X-Gm-Message-State: AOAM533SVpmLUFnm1tBfV+enw7kgA3jegr/Z9H0IyzzCbUW1190IMIn3
        sot5eEl9VJb5tu7+/eK9+2IyUs+jwxubufXUvPlTtAhPcNTIdF1ASOyGwnkhcJRlYkvAv45ii6f
        EAe8IcYbyuBHKq0dk2YxnMEUr+JduzEDpiiffGrssKG8KR59TFZMz78rL64fiyKrpX1JjRXDhCR
        sS1Ryq
X-Google-Smtp-Source: ABdhPJxltOzL/Ye4exWYkU6ZupMaj7q8ZuP7qwcR7fNEQtFp+LuBDu7yqJT0S/hOgAXo+3t4EUfAoA==
X-Received: by 2002:a63:36cc:: with SMTP id d195mr2525990pga.426.1599846780295;
        Fri, 11 Sep 2020 10:53:00 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id d77sm2871963pfd.121.2020.09.11.10.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 10:52:59 -0700 (PDT)
From:   Jim Quinlan <james.quinlan@broadcom.com>
To:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com
Cc:     Jim Quinlan <jquinlan@broadcom.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v12 08/10] PCI: brcmstb: Accommodate MSI for older chips
Date:   Fri, 11 Sep 2020 13:52:28 -0400
Message-Id: <20200911175232.19016-9-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200911175232.19016-1-james.quinlan@broadcom.com>
References: <20200911175232.19016-1-james.quinlan@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000001325f005af0d5b08"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--0000000000001325f005af0d5b08

From: Jim Quinlan <jquinlan@broadcom.com>

Older BrcmSTB chips do not have a separate register for MSI interrupts; the
MSIs are in a register that also contains unrelated interrupts.  In
addition, the interrupts lie in bits [31..24] for these legacy chips.  This
commit provides common code for both legacy and non-legacy MSI interrupt
registers.

Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/pcie-brcmstb.c | 70 +++++++++++++++++++--------
 1 file changed, 49 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 330f68c5b579..10449384380f 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -83,7 +83,8 @@
 #define PCIE_MISC_MSI_BAR_CONFIG_HI			0x4048
 
 #define PCIE_MISC_MSI_DATA_CONFIG			0x404c
-#define  PCIE_MISC_MSI_DATA_CONFIG_VAL			0xffe06540
+#define  PCIE_MISC_MSI_DATA_CONFIG_VAL_32		0xffe06540
+#define  PCIE_MISC_MSI_DATA_CONFIG_VAL_8		0xfff86540
 
 #define PCIE_MISC_PCIE_CTRL				0x4064
 #define  PCIE_MISC_PCIE_CTRL_PCIE_L23_REQUEST_MASK	0x1
@@ -95,6 +96,9 @@
 #define  PCIE_MISC_PCIE_STATUS_PCIE_PHYLINKUP_MASK	0x10
 #define  PCIE_MISC_PCIE_STATUS_PCIE_LINK_IN_L23_MASK	0x40
 
+#define PCIE_MISC_REVISION				0x406c
+#define  BRCM_PCIE_HW_REV_33				0x0303
+
 #define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_LIMIT		0x4070
 #define  PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_LIMIT_LIMIT_MASK	0xfff00000
 #define  PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_LIMIT_BASE_MASK	0xfff0
@@ -115,10 +119,14 @@
 #define  PCIE_MISC_HARD_PCIE_HARD_DEBUG_CLKREQ_DEBUG_ENABLE_MASK	0x2
 #define  PCIE_MISC_HARD_PCIE_HARD_DEBUG_SERDES_IDDQ_MASK		0x08000000
 
-#define PCIE_MSI_INTR2_STATUS				0x4500
-#define PCIE_MSI_INTR2_CLR				0x4508
-#define PCIE_MSI_INTR2_MASK_SET				0x4510
-#define PCIE_MSI_INTR2_MASK_CLR				0x4514
+
+#define PCIE_INTR2_CPU_BASE		0x4300
+#define PCIE_MSI_INTR2_BASE		0x4500
+/* Offsets from PCIE_INTR2_CPU_BASE and PCIE_MSI_INTR2_BASE */
+#define  MSI_INT_STATUS			0x0
+#define  MSI_INT_CLR			0x8
+#define  MSI_INT_MASK_SET		0x10
+#define  MSI_INT_MASK_CLR		0x14
 
 #define PCIE_EXT_CFG_DATA				0x8000
 
@@ -138,6 +146,8 @@
 /* PCIe parameters */
 #define BRCM_NUM_PCIE_OUT_WINS		0x4
 #define BRCM_INT_PCI_MSI_NR		32
+#define BRCM_INT_PCI_MSI_LEGACY_NR	8
+#define BRCM_INT_PCI_MSI_SHIFT		0
 
 /* MSI target adresses */
 #define BRCM_MSI_TARGET_ADDR_LT_4GB	0x0fffffffcULL
@@ -253,6 +263,12 @@ struct brcm_msi {
 	int			irq;
 	/* used indicates which MSI interrupts have been alloc'd */
 	unsigned long		used;
+	bool			legacy;
+	/* Some chips have MSIs in bits [31..24] of a shared register. */
+	int			legacy_shift;
+	int			nr; /* No. of MSI available, depends on chip */
+	/* This is the base pointer for interrupt status/set/clr regs */
+	void __iomem		*intr_base;
 };
 
 /* Internal PCIe Host Controller Information.*/
@@ -463,8 +479,10 @@ static void brcm_pcie_msi_isr(struct irq_desc *desc)
 	msi = irq_desc_get_handler_data(desc);
 	dev = msi->dev;
 
-	status = readl(msi->base + PCIE_MSI_INTR2_STATUS);
-	for_each_set_bit(bit, &status, BRCM_INT_PCI_MSI_NR) {
+	status = readl(msi->intr_base + MSI_INT_STATUS);
+	status >>= msi->legacy_shift;
+
+	for_each_set_bit(bit, &status, msi->nr) {
 		virq = irq_find_mapping(msi->inner_domain, bit);
 		if (virq)
 			generic_handle_irq(virq);
@@ -481,7 +499,7 @@ static void brcm_msi_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 
 	msg->address_lo = lower_32_bits(msi->target_addr);
 	msg->address_hi = upper_32_bits(msi->target_addr);
-	msg->data = (0xffff & PCIE_MISC_MSI_DATA_CONFIG_VAL) | data->hwirq;
+	msg->data = (0xffff & PCIE_MISC_MSI_DATA_CONFIG_VAL_32) | data->hwirq;
 }
 
 static int brcm_msi_set_affinity(struct irq_data *irq_data,
@@ -493,8 +511,9 @@ static int brcm_msi_set_affinity(struct irq_data *irq_data,
 static void brcm_msi_ack_irq(struct irq_data *data)
 {
 	struct brcm_msi *msi = irq_data_get_irq_chip_data(data);
+	const int shift_amt = data->hwirq + msi->legacy_shift;
 
-	writel(1 << data->hwirq, msi->base + PCIE_MSI_INTR2_CLR);
+	writel(1 << shift_amt, msi->intr_base + MSI_INT_CLR);
 }
 
 
@@ -510,7 +529,7 @@ static int brcm_msi_alloc(struct brcm_msi *msi)
 	int hwirq;
 
 	mutex_lock(&msi->lock);
-	hwirq = bitmap_find_free_region(&msi->used, BRCM_INT_PCI_MSI_NR, 0);
+	hwirq = bitmap_find_free_region(&msi->used, msi->nr, 0);
 	mutex_unlock(&msi->lock);
 
 	return hwirq;
@@ -559,8 +578,7 @@ static int brcm_allocate_domains(struct brcm_msi *msi)
 	struct fwnode_handle *fwnode = of_node_to_fwnode(msi->np);
 	struct device *dev = msi->dev;
 
-	msi->inner_domain = irq_domain_add_linear(NULL, BRCM_INT_PCI_MSI_NR,
-						  &msi_domain_ops, msi);
+	msi->inner_domain = irq_domain_add_linear(NULL, msi->nr, &msi_domain_ops, msi);
 	if (!msi->inner_domain) {
 		dev_err(dev, "failed to create IRQ domain\n");
 		return -ENOMEM;
@@ -597,7 +615,10 @@ static void brcm_msi_remove(struct brcm_pcie *pcie)
 
 static void brcm_msi_set_regs(struct brcm_msi *msi)
 {
-	writel(0xffffffff, msi->base + PCIE_MSI_INTR2_MASK_CLR);
+	u32 val = __GENMASK(31, msi->legacy_shift);
+
+	writel(val, msi->intr_base + MSI_INT_MASK_CLR);
+	writel(val, msi->intr_base + MSI_INT_CLR);
 
 	/*
 	 * The 0 bit of PCIE_MISC_MSI_BAR_CONFIG_LO is repurposed to MSI
@@ -608,8 +629,8 @@ static void brcm_msi_set_regs(struct brcm_msi *msi)
 	writel(upper_32_bits(msi->target_addr),
 	       msi->base + PCIE_MISC_MSI_BAR_CONFIG_HI);
 
-	writel(PCIE_MISC_MSI_DATA_CONFIG_VAL,
-	       msi->base + PCIE_MISC_MSI_DATA_CONFIG);
+	val = msi->legacy ? PCIE_MISC_MSI_DATA_CONFIG_VAL_8 : PCIE_MISC_MSI_DATA_CONFIG_VAL_32;
+	writel(val, msi->base + PCIE_MISC_MSI_DATA_CONFIG);
 }
 
 static int brcm_pcie_enable_msi(struct brcm_pcie *pcie)
@@ -634,6 +655,17 @@ static int brcm_pcie_enable_msi(struct brcm_pcie *pcie)
 	msi->np = pcie->np;
 	msi->target_addr = pcie->msi_target_addr;
 	msi->irq = irq;
+	msi->legacy = pcie->hw_rev < BRCM_PCIE_HW_REV_33;
+
+	if (msi->legacy) {
+		msi->intr_base = msi->base + PCIE_INTR2_CPU_BASE;
+		msi->nr = BRCM_INT_PCI_MSI_LEGACY_NR;
+		msi->legacy_shift = 24;
+	} else {
+		msi->intr_base = msi->base + PCIE_MSI_INTR2_BASE;
+		msi->nr = BRCM_INT_PCI_MSI_NR;
+		msi->legacy_shift = 0;
+	}
 
 	ret = brcm_allocate_domains(msi);
 	if (ret)
@@ -904,12 +936,6 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 	tmp &= ~PCIE_MISC_RC_BAR3_CONFIG_LO_SIZE_MASK;
 	writel(tmp, base + PCIE_MISC_RC_BAR3_CONFIG_LO);
 
-	/* Mask all interrupts since we are not handling any yet */
-	writel(0xffffffff, pcie->base + PCIE_MSI_INTR2_MASK_SET);
-
-	/* clear any interrupts we find on boot */
-	writel(0xffffffff, pcie->base + PCIE_MSI_INTR2_CLR);
-
 	if (pcie->gen)
 		brcm_pcie_set_gen(pcie, pcie->gen);
 
@@ -1245,6 +1271,8 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		goto fail;
 
+	pcie->hw_rev = readl(pcie->base + PCIE_MISC_REVISION);
+
 	msi_np = of_parse_phandle(pcie->np, "msi-parent", 0);
 	if (pci_msi_enabled() && msi_np == pcie->np) {
 		ret = brcm_pcie_enable_msi(pcie);
-- 
2.17.1


--0000000000001325f005af0d5b08
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
mOxPm7sNHsn0TVdPryi9+T2d8fVC/kUmuEdTYP/Hdu4W4b4T9BcW57fInYrmaJ+uotS6X59rAgMB
AAGjggHRMIIBzTAOBgNVHQ8BAf8EBAMCBaAwgZ4GCCsGAQUFBwEBBIGRMIGOME0GCCsGAQUFBzAC
hkFodHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc3BlcnNvbmFsc2lnbjJzaGEy
ZzNvY3NwLmNydDA9BggrBgEFBQcwAYYxaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL2dzcGVy
c29uYWxzaWduMnNoYTJnMzBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYm
aHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBEBgNVHR8E
PTA7MDmgN6A1hjNodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzcGVyc29uYWxzaWduMnNoYTJn
My5jcmwwJQYDVR0RBB4wHIEaamFtZXMucXVpbmxhbkBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYI
KwYBBQUHAwQwHwYDVR0jBBgwFoAUaXKCYjFnlUSFd5GAxAQ2SZ17C2EwHQYDVR0OBBYEFNYm4GDl
4WOt3laB3gNKFfYyaM8bMA0GCSqGSIb3DQEBCwUAA4IBAQBD+XYEgpG/OqeRgXAgDF8sa+lQ/00T
wCP/3nBzwZPblTyThtDE/iaL/YZ5rdwqXwdCnSFh9cMhd/bnA+Eqw89clgTixvz9MdL9Vuo8LACI
VpHO+sxZ2Cu3bO5lpK+UVCyr21y1zumOICsOuu4MJA5mtkpzBXQiA7b/ogjGxG+5iNjt9FAMX4JP
V6GuAMmRknrzeTlxPy40UhUcRKk6Nm8mxl3Jh4KB68z7NFVpIx8G5w5I7S5ar1mLGNRjtFZ0RE4O
lcCwKVGUXRaZMgQGrIhxGVelVgrcBh2vjpndlv733VI2VKE/TvV5MxMGU18RnogYSm66AEFA/Zb+
5ztz1AtIMYICbzCCAmsCAQEwbTBdMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBu
di1zYTEzMDEGA1UEAxMqR2xvYmFsU2lnbiBQZXJzb25hbFNpZ24gMiBDQSAtIFNIQTI1NiAtIEcz
AgwTv2xmtR4KOmK4QvMwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIPU5YP/t2hmF
HjlkIYbb80xw6eNyGQKDvGz+vGqt6E0qMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIwMDkxMTE3NTMwMFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBeQDFYVyMhYf4BohgfRAZ4OvLZILwS
2DOU1QRuuHCqMxIJlMMnugzHQ6ibftHSsXh/dJXurNy+K1zMZbzxteClebT7GcbjE1Dp6ut/Y9ef
Xr4RAfNIK8f4fzvnG5UEWCtw5lRffOoVI0hzfasCAnyPBfuVTjQcW6oQJN+o2s2ls5vhve4wHLu7
+mgmv5ZyTef28PR+8SLYpRtPwxHvj5PwE8Rfr6vokQYSYrVMvho5kyLzkGwL7nrvHVIyUiTzzekC
ZueelavVM+PPBBTpnik96EiI3xpDrKN0y6O6y+Un0zp62d42PhdCdw82WSJ/Sam4o+aTjoA9QfqK
jEwt5wIF
--0000000000001325f005af0d5b08--
