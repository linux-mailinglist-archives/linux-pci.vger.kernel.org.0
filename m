Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFADB2667D3
	for <lists+linux-pci@lfdr.de>; Fri, 11 Sep 2020 19:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725908AbgIKRxV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Sep 2020 13:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbgIKRwx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Sep 2020 13:52:53 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48728C06179B
        for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2020 10:52:53 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id q4so2063830pjh.5
        for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2020 10:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CAsd0lfLhGdtYzIhDWiAOt5Ix2ZTt+xk0ksVScxXx2g=;
        b=ZWOCr3RKOsnOz6vmCHZqrEm5RTzpR7JZbsRZ2f1pus16wRpO0wK7xrZ3wLr68zqnmB
         02gqw0k/zbAXJkyiEcGn3XDT5HMD5u2o3fNgImbkKxDbe+rlaILzxaAb5jQklkaCcY+5
         KK1i3nGL2hxytpVf65AuEcyDxILKKzI9+AoiA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CAsd0lfLhGdtYzIhDWiAOt5Ix2ZTt+xk0ksVScxXx2g=;
        b=P3t3MR5uATeoa5/QcW/Sz4qabHI0UqcqbmUj4z+vF57WtCnUYpxm1XBpHcApHOk4Df
         iqcAAyoumcFwLthKewfxUNTOBJYMgvQkEtrqGeKgWvuGQq/7GkvRFU9s8zhltk5+qNW4
         MHJyvW1DSWZKDSySoKnHSg8DPo/QJjOk/FZENzwuJRsVLH1wQMpLxOxFY9oIgjNmxqZq
         2EMHpRvdJYcv/dzlXWVDRQGR7IDvQ9AG0e9DPCL64ikbbmSUl4DZOPlQrU3igP3jAUR3
         kX2HJi6qFi42nBHB4yONWXj8jGjS6PvmHHISldF3MLVgtxWJuDWOjtw1oIAEw/h8aP9U
         cKYw==
X-Gm-Message-State: AOAM531GWzyIl11ORk9u09GC+tJX9gnObtWxOaZfRJN9loKU724JGBy+
        midvQ++cQbz0z+e4nmE3Lc725MLAXEr4bPl2SrwLhmOak4bvRWk6AaOQ51gDgRgOezKOS8buNOE
        Z0i8/tF7sxvkGvzLHBgUCKqC/Qk6zIql1QgMlOIhsXZhNZj0B/2ihvA5SA5UJxPY4Z2vlfWQD73
        jmKBbe
X-Google-Smtp-Source: ABdhPJyNpi0B8FqBQteBt9Mxyg/UKGJLdhKZ1qEJChAppRodLS7WIa6ypXxkSuQXjycHODtKZqvXJw==
X-Received: by 2002:a17:90a:a591:: with SMTP id b17mr1063630pjq.159.1599846771761;
        Fri, 11 Sep 2020 10:52:51 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id d77sm2871963pfd.121.2020.09.11.10.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 10:52:51 -0700 (PDT)
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
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v12 05/10] PCI: brcmstb: Add bcm7278 PERST# support
Date:   Fri, 11 Sep 2020 13:52:25 -0400
Message-Id: <20200911175232.19016-6-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200911175232.19016-1-james.quinlan@broadcom.com>
References: <20200911175232.19016-1-james.quinlan@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000091c5b105af0d5aeb"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--00000000000091c5b105af0d5aeb

From: Jim Quinlan <jquinlan@broadcom.com>

The PERST# bit was moved to a different register in 7278-type STB chips.
In addition, the polarity of the bit was also changed; for other chips
writing a 1 specified assert; for 7278-type chips, writing a 0 specifies
assert.  Of course, PERST# is a PCIe asserted-low signal.

While we are here, also change the bridge_sw_init_set() functions so like
the perst_set() functions they are chip specific and we no longer rely on
data wrt chip specific field mask and shift values.

Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 97 +++++++++++++++++++--------
 1 file changed, 69 insertions(+), 28 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 7f5e7848df47..947cf3115eb0 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -83,6 +83,7 @@
 
 #define PCIE_MISC_PCIE_CTRL				0x4064
 #define  PCIE_MISC_PCIE_CTRL_PCIE_L23_REQUEST_MASK	0x1
+#define PCIE_MISC_PCIE_CTRL_PCIE_PERSTB_MASK		0x4
 
 #define PCIE_MISC_PCIE_STATUS				0x4068
 #define  PCIE_MISC_PCIE_STATUS_PCIE_PORT_MASK		0x80
@@ -125,6 +126,11 @@
 #define  PCIE_RGR1_SW_INIT_1_PERST_MASK			0x1
 #define  PCIE_RGR1_SW_INIT_1_PERST_SHIFT		0x0
 
+#define RGR1_SW_INIT_1_INIT_GENERIC_MASK		0x2
+#define RGR1_SW_INIT_1_INIT_GENERIC_SHIFT		0x1
+#define RGR1_SW_INIT_1_INIT_7278_MASK			0x1
+#define RGR1_SW_INIT_1_INIT_7278_SHIFT			0x0
+
 /* PCIe parameters */
 #define BRCM_NUM_PCIE_OUT_WINS		0x4
 #define BRCM_INT_PCI_MSI_NR		32
@@ -157,6 +163,23 @@
 #define DATA_ADDR(pcie)			(pcie->reg_offsets[EXT_CFG_DATA])
 #define PCIE_RGR1_SW_INIT_1(pcie)	(pcie->reg_offsets[RGR1_SW_INIT_1])
 
+/* Rescal registers */
+#define PCIE_DVT_PMU_PCIE_PHY_CTRL				0xc700
+#define  PCIE_DVT_PMU_PCIE_PHY_CTRL_DAST_NFLDS			0x3
+#define  PCIE_DVT_PMU_PCIE_PHY_CTRL_DAST_DIG_RESET_MASK		0x4
+#define  PCIE_DVT_PMU_PCIE_PHY_CTRL_DAST_DIG_RESET_SHIFT	0x2
+#define  PCIE_DVT_PMU_PCIE_PHY_CTRL_DAST_RESET_MASK		0x2
+#define  PCIE_DVT_PMU_PCIE_PHY_CTRL_DAST_RESET_SHIFT		0x1
+#define  PCIE_DVT_PMU_PCIE_PHY_CTRL_DAST_PWRDN_MASK		0x1
+#define  PCIE_DVT_PMU_PCIE_PHY_CTRL_DAST_PWRDN_SHIFT		0x0
+
+/* Forward declarations */
+struct brcm_pcie;
+static inline void brcm_pcie_bridge_sw_init_set_7278(struct brcm_pcie *pcie, u32 val);
+static inline void brcm_pcie_bridge_sw_init_set_generic(struct brcm_pcie *pcie, u32 val);
+static inline void brcm_pcie_perst_set_7278(struct brcm_pcie *pcie, u32 val);
+static inline void brcm_pcie_perst_set_generic(struct brcm_pcie *pcie, u32 val);
+
 enum {
 	RGR1_SW_INIT_1,
 	EXT_CFG_INDEX,
@@ -175,19 +198,10 @@ enum pcie_type {
 };
 
 struct pcie_cfg_data {
-	const int *reg_field_info;
 	const int *offsets;
 	const enum pcie_type type;
-};
-
-static const int pcie_reg_field_info[] = {
-	[RGR1_SW_INIT_1_INIT_MASK] = 0x2,
-	[RGR1_SW_INIT_1_INIT_SHIFT] = 0x1,
-};
-
-static const int pcie_reg_field_info_bcm7278[] = {
-	[RGR1_SW_INIT_1_INIT_MASK] = 0x1,
-	[RGR1_SW_INIT_1_INIT_SHIFT] = 0x0,
+	void (*perst_set)(struct brcm_pcie *pcie, u32 val);
+	void (*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
 };
 
 static const int pcie_offsets[] = {
@@ -197,9 +211,10 @@ static const int pcie_offsets[] = {
 };
 
 static const struct pcie_cfg_data generic_cfg = {
-	.reg_field_info	= pcie_reg_field_info,
 	.offsets	= pcie_offsets,
 	.type		= GENERIC,
+	.perst_set	= brcm_pcie_perst_set_generic,
+	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
 };
 
 static const int pcie_offset_bcm7278[] = {
@@ -209,15 +224,17 @@ static const int pcie_offset_bcm7278[] = {
 };
 
 static const struct pcie_cfg_data bcm7278_cfg = {
-	.reg_field_info = pcie_reg_field_info_bcm7278,
 	.offsets	= pcie_offset_bcm7278,
 	.type		= BCM7278,
+	.perst_set	= brcm_pcie_perst_set_7278,
+	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_7278,
 };
 
 static const struct pcie_cfg_data bcm2711_cfg = {
-	.reg_field_info	= pcie_reg_field_info,
 	.offsets	= pcie_offsets,
 	.type		= BCM2711,
+	.perst_set	= brcm_pcie_perst_set_generic,
+	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
 };
 
 struct brcm_msi {
@@ -244,8 +261,13 @@ struct brcm_pcie {
 	u64			msi_target_addr;
 	struct brcm_msi		*msi;
 	const int		*reg_offsets;
-	const int		*reg_field_info;
 	enum pcie_type		type;
+	struct reset_control	*rescal;
+	int			num_memc;
+	u64			memc_size[PCIE_BRCM_MAX_MEMC];
+	u32			hw_rev;
+	void			(*perst_set)(struct brcm_pcie *pcie, u32 val);
+	void			(*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
 };
 
 /*
@@ -670,17 +692,37 @@ static struct pci_ops brcm_pcie_ops = {
 	.write = pci_generic_config_write,
 };
 
-static inline void brcm_pcie_bridge_sw_init_set(struct brcm_pcie *pcie, u32 val)
+static inline void brcm_pcie_bridge_sw_init_set_generic(struct brcm_pcie *pcie, u32 val)
 {
-	u32 tmp, mask =  pcie->reg_field_info[RGR1_SW_INIT_1_INIT_MASK];
-	u32 shift = pcie->reg_field_info[RGR1_SW_INIT_1_INIT_SHIFT];
+	u32 tmp, mask =  RGR1_SW_INIT_1_INIT_GENERIC_MASK;
+	u32 shift = RGR1_SW_INIT_1_INIT_GENERIC_SHIFT;
 
 	tmp = readl(pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
 	tmp = (tmp & ~mask) | ((val << shift) & mask);
 	writel(tmp, pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
 }
 
-static inline void brcm_pcie_perst_set(struct brcm_pcie *pcie, u32 val)
+static inline void brcm_pcie_bridge_sw_init_set_7278(struct brcm_pcie *pcie, u32 val)
+{
+	u32 tmp, mask =  RGR1_SW_INIT_1_INIT_7278_MASK;
+	u32 shift = RGR1_SW_INIT_1_INIT_7278_SHIFT;
+
+	tmp = readl(pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
+	tmp = (tmp & ~mask) | ((val << shift) & mask);
+	writel(tmp, pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
+}
+
+static inline void brcm_pcie_perst_set_7278(struct brcm_pcie *pcie, u32 val)
+{
+	u32 tmp;
+
+	/* Perst bit has moved and assert value is 0 */
+	tmp = readl(pcie->base + PCIE_MISC_PCIE_CTRL);
+	u32p_replace_bits(&tmp, !val, PCIE_MISC_PCIE_CTRL_PCIE_PERSTB_MASK);
+	writel(tmp, pcie->base +  PCIE_MISC_PCIE_CTRL);
+}
+
+static inline void brcm_pcie_perst_set_generic(struct brcm_pcie *pcie, u32 val)
 {
 	u32 tmp;
 
@@ -770,13 +812,11 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 	u32 tmp, aspm_support;
 
 	/* Reset the bridge */
-	brcm_pcie_bridge_sw_init_set(pcie, 1);
-	brcm_pcie_perst_set(pcie, 1);
-
+	pcie->bridge_sw_init_set(pcie, 1);
 	usleep_range(100, 200);
 
 	/* Take the bridge out of reset */
-	brcm_pcie_bridge_sw_init_set(pcie, 0);
+	pcie->bridge_sw_init_set(pcie, 0);
 
 	tmp = readl(base + PCIE_MISC_HARD_PCIE_HARD_DEBUG);
 	tmp &= ~PCIE_MISC_HARD_PCIE_HARD_DEBUG_SERDES_IDDQ_MASK;
@@ -842,7 +882,7 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 		brcm_pcie_set_gen(pcie, pcie->gen);
 
 	/* Unassert the fundamental reset */
-	brcm_pcie_perst_set(pcie, 0);
+	pcie->perst_set(pcie, 0);
 
 	/*
 	 * Give the RC/EP time to wake up, before trying to configure RC.
@@ -962,7 +1002,7 @@ static void brcm_pcie_turn_off(struct brcm_pcie *pcie)
 	if (brcm_pcie_link_up(pcie))
 		brcm_pcie_enter_l23(pcie);
 	/* Assert fundamental reset */
-	brcm_pcie_perst_set(pcie, 1);
+	pcie->perst_set(pcie, 1);
 
 	/* Deassert request for L23 in case it was asserted */
 	tmp = readl(base + PCIE_MISC_PCIE_CTRL);
@@ -975,7 +1015,7 @@ static void brcm_pcie_turn_off(struct brcm_pcie *pcie)
 	writel(tmp, base + PCIE_MISC_HARD_PCIE_HARD_DEBUG);
 
 	/* Shutdown PCIe bridge */
-	brcm_pcie_bridge_sw_init_set(pcie, 1);
+	pcie->bridge_sw_init_set(pcie, 1);
 }
 
 static int brcm_pcie_suspend(struct device *dev)
@@ -999,7 +1039,7 @@ static int brcm_pcie_resume(struct device *dev)
 	clk_prepare_enable(pcie->clk);
 
 	/* Take bridge out of reset so we can access the SERDES reg */
-	brcm_pcie_bridge_sw_init_set(pcie, 0);
+	pcie->bridge_sw_init_set(pcie, 0);
 
 	/* SERDES_IDDQ = 0 */
 	tmp = readl(base + PCIE_MISC_HARD_PCIE_HARD_DEBUG);
@@ -1080,8 +1120,9 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 	pcie->dev = &pdev->dev;
 	pcie->np = np;
 	pcie->reg_offsets = data->offsets;
-	pcie->reg_field_info = data->reg_field_info;
 	pcie->type = data->type;
+	pcie->perst_set = data->perst_set;
+	pcie->bridge_sw_init_set = data->bridge_sw_init_set;
 
 	pcie->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pcie->base))
-- 
2.17.1


--00000000000091c5b105af0d5aeb
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
AgwTv2xmtR4KOmK4QvMwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEILdzqAUZCwDe
2/AqZPTSbVGEB69WnwTPqdq3W6FS9kJkMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIwMDkxMTE3NTI1MlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAU51G0vQNlqHTELBUjyO+EmywbIfMi
U3hYpX+sdYG93GCgQ4sdFNYwXSxEpLi43PBAIXVLG2oyQuIfPqxFz/XJinaEf5DsHEPP+nRrvzfi
XZPBpZg4SmsiifuSjPUgWcka7DN5DVRvBR/Op8dq7EwjhOpqIq4ridmrkrJb4C/3wFHf1AR1Z6eB
3BF6q5XQJocXlRG92uJEKJla4TxjE0OriaEk3sKbTG+LgKmvJqCE0hAed5xh+40Az/wn0E7BsBsP
ndBeyPFqcth6Ola63vR3jw5xjNYuLQ3YdW+/JJkDUdWIIN0rqRgaOD/2ZDxOGjMnO567TD22E3+f
oqbderkw
--00000000000091c5b105af0d5aeb--
