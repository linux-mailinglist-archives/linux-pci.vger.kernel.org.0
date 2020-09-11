Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A88F2667D7
	for <lists+linux-pci@lfdr.de>; Fri, 11 Sep 2020 19:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725905AbgIKRxv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Sep 2020 13:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbgIKRw7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Sep 2020 13:52:59 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06459C06179E
        for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2020 10:52:59 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id q4so2063921pjh.5
        for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2020 10:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+0qudZAbM8/T6YE3XAfSWYaJ7gKJcoImrCKBsYCbNvA=;
        b=a7kru0KkeJ8p6/HLx/YgHYSmyIw19jLl/a6Roh7Hg7n+xGRAm4pOf2mGmIm/i5mb/M
         wmGdxi5NNy+uINoPLGNsf0pCwUKrsCplHomyo2Vlb7ZYAqvob4O6b/CpmPw5lIkYZwNY
         QEhrhGvQBNyjnQ3WRctxdCJdVu46z+upbGGU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+0qudZAbM8/T6YE3XAfSWYaJ7gKJcoImrCKBsYCbNvA=;
        b=ckJc4vcqFnUz44Wdex+x1VFt3xa8T9k7T/HluTVPxr3xgt48YuDGdvwOfNTL358vXt
         yJuMtFHHOi9YtA6NmOIaPTwWzyKU63ubkdT739S+qv3JPouz0U8AZMDNVM/VBwJGjw9V
         mbyRihdUSl/CWRy33pxZsViYAfUXSi1eDJ5ibcnEl9DSndKNjlL5Dre4G5r76tSzR60s
         dPLZXk/MYEAvgHhIF/4zden4Hmd62LdRGseGDytvXUCk5/vWUjotfZebpvom3H7KrYF+
         vYKkkyFL6pl8nOPtXsmbtZ2OwvCVBUs8RibZkDV9HQKxeKoQ5vvckKORO6NHMY+9Eewn
         0f1g==
X-Gm-Message-State: AOAM5303nGyXNgv3xbOz+rtNOFpI54lghE8Kof0sb0/oWFvrFYISWhI3
        gtneL+JEZxGd1B9fmnsaDvBOdD7ngT/xs90uCFYKYj7I7+I/H7IEAWVSWipNxvJNayxcq65/Fj2
        coP/NdTMW2+nf0vzYg40s+YbuhN2q5vnIdDWSVrAQovthzthCCSMNXd8Lv3LYdmXwNdK1FXRY8f
        Ylc6uA
X-Google-Smtp-Source: ABdhPJyHOXUq+eIxWdPk/FmdERUDomyyriLd4N9G41eP73dbkeiuIM38nD0ROjLBrxqretI3wsGfNw==
X-Received: by 2002:a17:90a:df91:: with SMTP id p17mr3287426pjv.29.1599846777460;
        Fri, 11 Sep 2020 10:52:57 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id d77sm2871963pfd.121.2020.09.11.10.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 10:52:56 -0700 (PDT)
From:   Jim Quinlan <james.quinlan@broadcom.com>
To:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v12 07/10] PCI: brcmstb: Set additional internal memory DMA viewport sizes
Date:   Fri, 11 Sep 2020 13:52:27 -0400
Message-Id: <20200911175232.19016-8-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200911175232.19016-1-james.quinlan@broadcom.com>
References: <20200911175232.19016-1-james.quinlan@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000e7dfa105af0d5ad3"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--000000000000e7dfa105af0d5ad3

The Raspberry Pi (RPI) is currently the only chip using this driver
(pcie-brcmstb.c).  There, only one memory controller is used, without an
extension region, and the SCB0 viewport size is set to the size of the
first and only dma-range region.  Other BrcmSTB SOCs have more complicated
memory configurations that require setting additional viewport sizes.

BrcmSTB PCIe controllers are intimately connected to the memory
controller(s) on the SOC.  The SOC may have one to three memory
controllers; they are indicated by the term SCBi.  Each controller has a
base region and an optional extension region.  In physical memory, the base
and extension regions of a controller are not adjacent, but in PCIe-space
they are.

There is a "viewport" for each memory controller that allows DMA from
endpoint devices.  Each viewport's size must be set to a power of two, and
that size must be equal to or larger than the amount of memory each
controller supports which is the sum of base region and its optional
extension.  Further, the 1-3 viewports are also adjacent in PCIe-space.

Unfortunately the viewport sizes cannot be ascertained from the
"dma-ranges" property so they have their own property, "brcm,scb-sizes".
This is because dma-range information does not indicate what memory
controller it is associated.  For example, consider the following case
where the size of one dma-range is 2GB and the second dma-range is 1GB:

    /* Case 1: SCB0 size set to 4GB */
    dma-range0: 2GB (from memc0-base)
    dma-range1: 1GB (from memc0-extension)

    /* Case 2: SCB0 size set to 2GB, SCB1 size set to 1GB */
    dma-range0: 2GB (from memc0-base)
    dma-range1: 1GB (from memc0-extension)

By just looking at the dma-ranges information, one cannot tell which
situation applies. That is why an additional property is needed.  Its
length indicates the number of memory controllers being used and each value
indicates the viewport size.

Note that the RPI DT does not have a "brcm,scb-sizes" property value,
as it is assumed that it only requires one memory controller and no
extension.  So the optional use of "brcm,scb-sizes" will be backwards
compatible.

One last layer of complexity exists: all of the viewports sizes must be
added and rounded up to a power of two to determine what the "BAR" size is.
Further, an offset must be given that indicates the base PCIe address of
this "BAR".  The use of the term BAR is typically associated with endpoint
devices, and the term is used here because the PCIe HW may be used as an RC
or an EP.  In the former case, all of the system memory appears in a single
"BAR" region in PCIe memory.  As it turns out, BrcmSTB PCIe HW is rarely
used in the EP role and its system of mapping memory is an artifact that
requires multiple dma-ranges regions.

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/pcie-brcmstb.c | 67 ++++++++++++++++++++-------
 1 file changed, 49 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 8a84811972bd..330f68c5b579 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -57,6 +57,9 @@
 #define  PCIE_MISC_MISC_CTRL_MAX_BURST_SIZE_MASK	0x300000
 #define  PCIE_MISC_MISC_CTRL_MAX_BURST_SIZE_128		0x0
 #define  PCIE_MISC_MISC_CTRL_SCB0_SIZE_MASK		0xf8000000
+#define  PCIE_MISC_MISC_CTRL_SCB1_SIZE_MASK		0x07c00000
+#define  PCIE_MISC_MISC_CTRL_SCB2_SIZE_MASK		0x0000001f
+#define  SCB_SIZE_MASK(x) PCIE_MISC_MISC_CTRL_SCB ## x ## _SIZE_MASK
 
 #define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LO		0x400c
 #define PCIE_MEM_WIN0_LO(win)	\
@@ -159,6 +162,7 @@
 #define SSC_STATUS_OFFSET		0x1
 #define SSC_STATUS_SSC_MASK		0x400
 #define SSC_STATUS_PLL_LOCK_MASK	0x800
+#define PCIE_BRCM_MAX_MEMC		3
 
 #define IDX_ADDR(pcie)			(pcie->reg_offsets[EXT_CFG_INDEX])
 #define DATA_ADDR(pcie)			(pcie->reg_offsets[EXT_CFG_DATA])
@@ -737,22 +741,44 @@ static inline int brcm_pcie_get_rc_bar2_size_and_offset(struct brcm_pcie *pcie,
 							u64 *rc_bar2_offset)
 {
 	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
-	struct device *dev = pcie->dev;
 	struct resource_entry *entry;
+	struct device *dev = pcie->dev;
+	u64 lowest_pcie_addr = ~(u64)0;
+	int ret, i = 0;
+	u64 size = 0;
 
-	entry = resource_list_first_type(&bridge->dma_ranges, IORESOURCE_MEM);
-	if (!entry)
-		return -ENODEV;
+	resource_list_for_each_entry(entry, &bridge->dma_ranges) {
+		u64 pcie_beg = entry->res->start - entry->offset;
 
+		size += entry->res->end - entry->res->start + 1;
+		if (pcie_beg < lowest_pcie_addr)
+			lowest_pcie_addr = pcie_beg;
+	}
 
-	/*
-	 * The controller expects the inbound window offset to be calculated as
-	 * the difference between PCIe's address space and CPU's. The offset
-	 * provided by the firmware is calculated the opposite way, so we
-	 * negate it.
-	 */
-	*rc_bar2_offset = -entry->offset;
-	*rc_bar2_size = 1ULL << fls64(entry->res->end - entry->res->start);
+	if (lowest_pcie_addr == ~(u64)0) {
+		dev_err(dev, "DT node has no dma-ranges\n");
+		return -EINVAL;
+	}
+
+	ret = of_property_read_variable_u64_array(pcie->np, "brcm,scb-sizes", pcie->memc_size, 1,
+						  PCIE_BRCM_MAX_MEMC);
+
+	if (ret <= 0) {
+		/* Make an educated guess */
+		pcie->num_memc = 1;
+		pcie->memc_size[0] = 1ULL << fls64(size - 1);
+	} else {
+		pcie->num_memc = ret;
+	}
+
+	/* Each memc is viewed through a "port" that is a power of 2 */
+	for (i = 0, size = 0; i < pcie->num_memc; i++)
+		size += pcie->memc_size[i];
+
+	/* System memory starts at this address in PCIe-space */
+	*rc_bar2_offset = lowest_pcie_addr;
+	/* The sum of all memc views must also be a power of 2 */
+	*rc_bar2_size = 1ULL << fls64(size - 1);
 
 	/*
 	 * We validate the inbound memory view even though we should trust
@@ -804,12 +830,11 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 	void __iomem *base = pcie->base;
 	struct device *dev = pcie->dev;
 	struct resource_entry *entry;
-	unsigned int scb_size_val;
 	bool ssc_good = false;
 	struct resource *res;
 	int num_out_wins = 0;
 	u16 nlw, cls, lnksta;
-	int i, ret;
+	int i, ret, memc;
 	u32 tmp, aspm_support;
 
 	/* Reset the bridge */
@@ -844,11 +869,17 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 	writel(upper_32_bits(rc_bar2_offset),
 	       base + PCIE_MISC_RC_BAR2_CONFIG_HI);
 
-	scb_size_val = rc_bar2_size ?
-		       ilog2(rc_bar2_size) - 15 : 0xf; /* 0xf is 1GB */
 	tmp = readl(base + PCIE_MISC_MISC_CTRL);
-	u32p_replace_bits(&tmp, scb_size_val,
-			  PCIE_MISC_MISC_CTRL_SCB0_SIZE_MASK);
+	for (memc = 0; memc < pcie->num_memc; memc++) {
+		u32 scb_size_val = ilog2(pcie->memc_size[memc]) - 15;
+
+		if (memc == 0)
+			u32p_replace_bits(&tmp, scb_size_val, SCB_SIZE_MASK(0));
+		else if (memc == 1)
+			u32p_replace_bits(&tmp, scb_size_val, SCB_SIZE_MASK(1));
+		else if (memc == 2)
+			u32p_replace_bits(&tmp, scb_size_val, SCB_SIZE_MASK(2));
+	}
 	writel(tmp, base + PCIE_MISC_MISC_CTRL);
 
 	/*
-- 
2.17.1


--000000000000e7dfa105af0d5ad3
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
AgwTv2xmtR4KOmK4QvMwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIAgNoN2cPVmA
OXrrYrmTd5aimqary+B5gRSpWe+Iy3mHMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIwMDkxMTE3NTI1OFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCYS409xjwxw00MHfNJq1w6pkAEreHA
IZ04ED3GRSLpRFx1XGq6ChecZchsrDLn2ZMwYkvRu7CrxpDotixR/OgJVWZTATW+Wwg4DrKVJOT3
1HuB4cGpixS/0TkvvgtQkgj+rtLfHP2NbGc8cQKXjXg24lWh0g4DYHXC1Styj+ZuXl/XPu007ajv
GygiECCleT2GxBy+n8XaA3aCG0v+YM/+JAU626J4mnhJMvnyM5EFR1f6Lo+OtQ6hpv9svX7OuDUn
gpZ8YnrL2jhB1PRUck0GqxUSa4qprT15rj5CFFGgL8cJdneUlfewJNbgXpRbz+5TAqyPOSAxv9w0
w2wkR6ke
--000000000000e7dfa105af0d5ad3--
