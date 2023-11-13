Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 465707EA324
	for <lists+linux-pci@lfdr.de>; Mon, 13 Nov 2023 19:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbjKMS4a (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Nov 2023 13:56:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231633AbjKMS42 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Nov 2023 13:56:28 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E20191732
        for <linux-pci@vger.kernel.org>; Mon, 13 Nov 2023 10:56:21 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6d648679605so1662637a34.1
        for <linux-pci@vger.kernel.org>; Mon, 13 Nov 2023 10:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1699901780; x=1700506580; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QFLUwPbhAK8KL2sS8xKKBk8SAihGxOiR6O3XHnyiDA8=;
        b=Nw+NchThLusddzuj+wTMOyetRMDg5c+qwFP7uX11urOFeZ+UI7gtuqMz+0MDxrA1he
         hXLKj6xEg73Kb2yNKUYI9YmYBaXrdtXqvpmoR3ieo61GWXqD52PyptXrzM0v+srOv+V9
         bZwc+eeZC3oPUy90j0pAK2Q/pBT7MZfVk/8eM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699901780; x=1700506580;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QFLUwPbhAK8KL2sS8xKKBk8SAihGxOiR6O3XHnyiDA8=;
        b=q3CMo4fMwgWnCMDSRg/tMzM03RQOKAifavLUqVf6vp9eOoQegzbkmIJSm0a8t/Q2+g
         fIp9t2RgR5HYDdvFd1I67QV3Uuw4tLmKvGJInNeFMmCZw0goGfXi07L0mM0yIjCuJTrp
         sGxBbFmOv740NzKw4LoOS0zPCrRVoo30v1aPhMnPWU0YpCIOL7k6LItA4IuwjrHJuJ8J
         SUZTU7YlWP9onVi2cUB9Hrk8vDoVUTEAYDhwATd1P6govyp4vagZnkqKg9yF9ogkXr0a
         W+ZV83p1hM9hDpWcjTrJusfHK9enMWi3QWzj9p8F/0Bw3b3gwdSA/Yh990MirADYhvtM
         fjHw==
X-Gm-Message-State: AOJu0YwMwtMumtavKPMfmkmFJw01xws3d1240VqHHI4zpUwUVIArH38G
        OXBfEh0H7UcEeBySfsUpsM1Xdk0Mq+82KNgY3NCSA98h3lmDiQeAIUGemaIkL3Xtwz3crd9/CRF
        WbKtX317ShovWR36GtULSNmtjxxiHsyhB8a+2CZ+ObcI63hlaOhz3ogQvcF1XQfqs6gxz2mZoQm
        PfunZD95zNHYnv
X-Google-Smtp-Source: AGHT+IGTh/KyA5dECzRRX3EVc9zFgbnRoZJt/r0AYNA2AGwrAN9MWuRFwcHqI4sR25QsfkDvUIYJPQ==
X-Received: by 2002:a05:6830:446:b0:6ce:2c8e:79f0 with SMTP id d6-20020a056830044600b006ce2c8e79f0mr284otc.21.1699901779933;
        Mon, 13 Nov 2023 10:56:19 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id b187-20020a6334c4000000b0056b27af8715sm4366421pga.43.2023.11.13.10.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 10:56:19 -0800 (PST)
From:   Jim Quinlan <james.quinlan@broadcom.com>
To:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        Phil Elwell <phil@raspberrypi.com>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com
Cc:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Jim Quinlan <jim2101024@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v8 2/2] PCI: brcmstb: Configure HW CLKREQ# mode appropriate for downstream device
Date:   Mon, 13 Nov 2023 13:56:06 -0500
Message-Id: <20231113185607.1756-3-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231113185607.1756-1-james.quinlan@broadcom.com>
References: <20231113185607.1756-1-james.quinlan@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000c942d9060a0d390b"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        MIME_HEADER_CTYPE_ONLY,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_TVD_MIME_NO_HEADERS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--000000000000c942d9060a0d390b

The Broadcom STB/CM PCIe HW core, which is also used in RPi SOCs, must be
deliberately set by the PCIe RC HW into one of three mutually exclusive
modes:

"safe" -- No CLKREQ# expected or required, refclk is always provided.  This
    mode should work for all devices but is not be capable of any refclk
    power savings.

"no-l1ss" -- CLKREQ# is expected to be driven by the downstream device for
    CPM and ASPM L0s and L1.  Provides Clock Power Management, L0s, and L1,
    but cannot provide L1 substate (L1SS) power savings. If the downstream
    device connected to the RC is L1SS capable AND the OS enables L1SS, all
    PCIe traffic may abruptly halt, potentially hanging the system.

"default" -- Bidirectional CLKREQ# between the RC and downstream device.
    Provides ASPM L0s, L1, and L1SS, but not compliant to provide Clock
    Power Management; specifically, may not be able to meet the T_CLRon max
    timing of 400ns as specified in "Dynamic Clock Control", section
    3.2.5.2.2 of the PCIe Express Mini CEM 2.1 specification.  This
    situation is atypical and should happen only with older devices.

Previously, this driver always set the mode to "no-l1ss", as almost all
STB/CM boards operate in this mode.  But now there is interest in
activating L1SS power savings from STB/CM customers, which requires "aspm"
mode.  In addition, a bug was filed for RPi4 CM platform because most
devices did not work in "no-l1ss" mode.

Note that the mode is specified by the DT property "brcm,clkreq-mode".  If
this property is omitted, then "default" mode is chosen.

Note: Since L1 substates are now possible, a modification was made
regarding an internal bus timeout: During long periods of the PCIe RC HW
being in an L1SS sleep state, there may be a timeout on an internal bus
access, even though there may not be any PCIe access involved.  Such a
timeout will cause a subsequent CPU abort.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=217276

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 96 ++++++++++++++++++++++++---
 1 file changed, 86 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index f9dd6622fe10..5b0730c3891b 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -48,6 +48,9 @@
 #define PCIE_RC_CFG_PRIV1_LINK_CAPABILITY			0x04dc
 #define  PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_ASPM_SUPPORT_MASK	0xc00
 
+#define PCIE_RC_CFG_PRIV1_ROOT_CAP			0x4f8
+#define  PCIE_RC_CFG_PRIV1_ROOT_CAP_L1SS_MODE_MASK	0xf8
+
 #define PCIE_RC_DL_MDIO_ADDR				0x1100
 #define PCIE_RC_DL_MDIO_WR_DATA				0x1104
 #define PCIE_RC_DL_MDIO_RD_DATA				0x1108
@@ -121,9 +124,12 @@
 
 #define PCIE_MISC_HARD_PCIE_HARD_DEBUG					0x4204
 #define  PCIE_MISC_HARD_PCIE_HARD_DEBUG_CLKREQ_DEBUG_ENABLE_MASK	0x2
+#define  PCIE_MISC_HARD_PCIE_HARD_DEBUG_L1SS_ENABLE_MASK		0x200000
 #define  PCIE_MISC_HARD_PCIE_HARD_DEBUG_SERDES_IDDQ_MASK		0x08000000
 #define  PCIE_BMIPS_MISC_HARD_PCIE_HARD_DEBUG_SERDES_IDDQ_MASK		0x00800000
-
+#define  PCIE_CLKREQ_MASK \
+	  (PCIE_MISC_HARD_PCIE_HARD_DEBUG_CLKREQ_DEBUG_ENABLE_MASK | \
+	   PCIE_MISC_HARD_PCIE_HARD_DEBUG_L1SS_ENABLE_MASK)
 
 #define PCIE_INTR2_CPU_BASE		0x4300
 #define PCIE_MSI_INTR2_BASE		0x4500
@@ -1028,13 +1034,89 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 	return 0;
 }
 
+/*
+ * This extends the timeout period for an access to an internal bus.  This
+ * access timeout may occur during L1SS sleep periods, even without the
+ * presence of a PCIe access.
+ */
+static void brcm_extend_rbus_timeout(struct brcm_pcie *pcie)
+{
+	/* TIMEOUT register is two registers before RGR1_SW_INIT_1 */
+	const unsigned int REG_OFFSET = PCIE_RGR1_SW_INIT_1(pcie) - 8;
+	u32 timeout_us = 4000000; /* 4 seconds, our setting for L1SS */
+
+	/* Each unit in timeout register is 1/216,000,000 seconds */
+	writel(216 * timeout_us, pcie->base + REG_OFFSET);
+}
+
+static void brcm_config_clkreq(struct brcm_pcie *pcie)
+{
+	static const char err_msg[] = "invalid 'brcm,clkreq-mode' DT string\n";
+	const char *mode = "default";
+	u32 clkreq_cntl;
+	int ret, tmp;
+
+	ret = of_property_read_string(pcie->np, "brcm,clkreq-mode", &mode);
+	if (ret && ret != -EINVAL) {
+		dev_err(pcie->dev, err_msg);
+		mode = "safe";
+	}
+
+	/* Start out assuming safe mode (both mode bits cleared) */
+	clkreq_cntl = readl(pcie->base + PCIE_MISC_HARD_PCIE_HARD_DEBUG);
+	clkreq_cntl &= ~PCIE_CLKREQ_MASK;
+
+	if (strcmp(mode, "no-l1ss") == 0) {
+		/*
+		 * "no-l1ss" -- Provides Clock Power Management, L0s, and
+		 * L1, but cannot provide L1 substate (L1SS) power
+		 * savings. If the downstream device connected to the RC is
+		 * L1SS capable AND the OS enables L1SS, all PCIe traffic
+		 * may abruptly halt, potentially hanging the system.
+		 */
+		clkreq_cntl |= PCIE_MISC_HARD_PCIE_HARD_DEBUG_CLKREQ_DEBUG_ENABLE_MASK;
+		/*
+		 * We want to un-advertise L1 substates because if the OS
+		 * tries to configure the controller into using L1 substate
+		 * power savings it may fail or hang when the RC HW is in
+		 * "no-l1ss" mode.
+		 */
+		tmp = readl(pcie->base + PCIE_RC_CFG_PRIV1_ROOT_CAP);
+		u32p_replace_bits(&tmp, 2, PCIE_RC_CFG_PRIV1_ROOT_CAP_L1SS_MODE_MASK);
+		writel(tmp, pcie->base + PCIE_RC_CFG_PRIV1_ROOT_CAP);
+
+	} else if (strcmp(mode, "default") == 0) {
+		/*
+		 * "default" -- Provides L0s, L1, and L1SS, but not
+		 * compliant to provide Clock Power Management;
+		 * specifically, may not be able to meet the Tclron max
+		 * timing of 400ns as specified in "Dynamic Clock Control",
+		 * section 3.2.5.2.2 of the PCIe spec.  This situation is
+		 * atypical and should happen only with older devices.
+		 */
+		clkreq_cntl |= PCIE_MISC_HARD_PCIE_HARD_DEBUG_L1SS_ENABLE_MASK;
+		brcm_extend_rbus_timeout(pcie);
+
+	} else {
+		/*
+		 * "safe" -- No power savings; refclk is driven by RC
+		 * unconditionally.
+		 */
+		if (strcmp(mode, "safe") != 0)
+			dev_err(pcie->dev, err_msg);
+		mode = "safe";
+	}
+	writel(clkreq_cntl, pcie->base + PCIE_MISC_HARD_PCIE_HARD_DEBUG);
+
+	dev_info(pcie->dev, "clkreq-mode set to %s\n", mode);
+}
+
 static int brcm_pcie_start_link(struct brcm_pcie *pcie)
 {
 	struct device *dev = pcie->dev;
 	void __iomem *base = pcie->base;
 	u16 nlw, cls, lnksta;
 	bool ssc_good = false;
-	u32 tmp;
 	int ret, i;
 
 	/* Unassert the fundamental reset */
@@ -1059,6 +1141,8 @@ static int brcm_pcie_start_link(struct brcm_pcie *pcie)
 		return -ENODEV;
 	}
 
+	brcm_config_clkreq(pcie);
+
 	if (pcie->gen)
 		brcm_pcie_set_gen(pcie, pcie->gen);
 
@@ -1077,14 +1161,6 @@ static int brcm_pcie_start_link(struct brcm_pcie *pcie)
 		 pci_speed_string(pcie_link_speed[cls]), nlw,
 		 ssc_good ? "(SSC)" : "(!SSC)");
 
-	/*
-	 * Refclk from RC should be gated with CLKREQ# input when ASPM L0s,L1
-	 * is enabled => setting the CLKREQ_DEBUG_ENABLE field to 1.
-	 */
-	tmp = readl(base + PCIE_MISC_HARD_PCIE_HARD_DEBUG);
-	tmp |= PCIE_MISC_HARD_PCIE_HARD_DEBUG_CLKREQ_DEBUG_ENABLE_MASK;
-	writel(tmp, base + PCIE_MISC_HARD_PCIE_HARD_DEBUG);
-
 	return 0;
 }
 
-- 
2.17.1


--000000000000c942d9060a0d390b
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
mOAplh6h3nMZUZxBguxG3g2p3iD4EgibUYneEzqOQafIQB/naf2uetKb8y9jKgWJxq2Y4y8Jqg2u
uVIO1AyOJjWwqdgN+QhuIlat+qZd03P48Gim9ZPEMDUCAwEAAaOCAdswggHXMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJQYDVR0R
BB4wHIEaamFtZXMucXVpbmxhbkBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYBBQUHAwQwHwYD
VR0jBBgwFoAUljPR5lgXWzR1ioFWZNW+SN6hj88wHQYDVR0OBBYEFGx/E27aeGBP2eJktrILxlhK
z8f6MA0GCSqGSIb3DQEBCwUAA4IBAQBdQQukiELsPfse49X4QNy/UN43dPUw0I1asiQ8wye3nAuD
b3GFmf3SZKlgxBTdWJoaNmmUFW2H3HWOoQBnTeedLtV9M2Tb9vOKMncQD1f9hvWZR6LnZpjBIlKe
+R+v6CLF07qYmBI6olvOY/Rsv9QpW9W8qZYk+2RkWHz/fR5N5YldKlJHP0NDT4Wjc5fEzV+mZC8A
AlT80qiuCVv+IQP08ovEVSLPhUp8i1pwsHT9atbWOfXQjbq1B/ditFIbPzwmwJPuGUc7n7vpmtxB
75sSFMj27j4JXl5W9vORgHR2YzuPBzfzDJU1ul0DIofSWVF6E1dx4tZohRED1Yl/T/ZGMYICbTCC
AmkCAQEwazBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UE
AxMoR2xvYmFsU2lnbiBHQ0MgUjMgUGVyc29uYWxTaWduIDIgQ0EgMjAyMAIMSO43VW7D5NP1X/KD
MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCC97qkeuOZ6OxBB5uns0n2SiBn/K39k
e0k0cFdt+B4mxjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMzEx
MTMxODU2MjBaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQME
AgEwDQYJKoZIhvcNAQEBBQAEggEAUr9r8h4ZC3TEIJAAGDW0QzXFeyZSbRdFlr1cPf2s5/+4TtZB
Aj/ZAImAmztG8dKkZpdiv2VdEummumlVVy8O4kZQZ3xsxI68bs6vieKkctfdMCDjDulVCQAfgSjK
PuanzBR1jxNwEQHJP3x70O64WTtdYxV7kUG/MGkIyEs1nZK+EWro+ONSJAPLmHOEU7lpIBgnqh1n
nRJ1lSsZvwPEEBhFn80SNLaUK7OBoea69xDZZU0c5v56ngTyZ4SkPrb5wEQ6chVq0L0A/DmmlayW
EJKNThBLVPFpR8S2x7kGphUznxJa+EKJIfj+9x4ESIL2bTT27/71VliIymq8vbzTJQ==
--000000000000c942d9060a0d390b--
