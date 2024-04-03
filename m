Return-Path: <linux-pci+bounces-5642-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE64897AE8
	for <lists+linux-pci@lfdr.de>; Wed,  3 Apr 2024 23:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4057A1C26A5A
	for <lists+linux-pci@lfdr.de>; Wed,  3 Apr 2024 21:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6631156C63;
	Wed,  3 Apr 2024 21:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="W7Ta8l8C"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023B8156C42
	for <linux-pci@vger.kernel.org>; Wed,  3 Apr 2024 21:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712180357; cv=none; b=jqHUOWUQzpgVgo5KBA4gd1LD6DqICp25a77H0EyW+mRJA+9Ra8mIIkHVGiCfOy6WXJ5zF5BYRSfHvI1/rCjVEH6Qb4/g4z91NlkHoMx4EDqJJ3FfLFSdY/I3/CbQfyszh7LRo3d6SAHEQYR53eT351ZTww4dqlpIvxjWfBuin+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712180357; c=relaxed/simple;
	bh=mFt0kePq04lVv/Rknfvgm1KNEwPrbqEyqKRKO/wG1lI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type; b=E6QZDmHiT6rbrTO+5T2fFRtWQNylYMjZUITzAko75QQm02hYOuWMoxII7INinAbGQxQ0+8KtOYkdkbpkhQmxEw+BBws6/z5Tylg+Q7DyYtjcxDQW1bBFDxgh4/gCufA5Tf7Zs92z0h2SbLsHXn+I8I2THDE4OlgQ0uxIhPac1Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=W7Ta8l8C; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6992f97ec8eso1568216d6.3
        for <linux-pci@vger.kernel.org>; Wed, 03 Apr 2024 14:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1712180354; x=1712785154; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vE2LPsga+WKK4JD8xeA1n7y5E3JX3N88WiTNIOgHNDs=;
        b=W7Ta8l8CgLAh0QcBhS2cp18RXuV0NPvtDohDz8w3f1WRw8Cu8a6WSSs5mAbdDo3hKs
         mtmtHoOxY/4ybst2BFpnSd9Z4T1j/x0JqK+/Jub7/ok5JWfC7J2FzcOYKpOBf2EhS8yw
         3vr9VLnVekQoqVPugqgcYEfh2xaEhFUe9vVG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712180354; x=1712785154;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vE2LPsga+WKK4JD8xeA1n7y5E3JX3N88WiTNIOgHNDs=;
        b=vjYbsP8cS+eoKkaKoz4h65Vh0DZFyeb800G9tobb8fhuHfIpIpBRLLP9pDLUMTVLq7
         F6gC5kmZimWlKShShNKEz0Knl6PZ9x0i0lfwrtWJIKj17H/SNa91cCt9pQTZfioj6rv4
         lP4bK0aPNTu+I/PmXSLZZ6GKWDmzpn0onnsVkkXUzMCOa2SEzZccQw8nnT9udkLwP+Xh
         RWr0p/9HvGATJwFywlfX6tHXbagYX0uzwhuNtXQGzSDA7m2UyOQ5jqKw8KGpJIYvac+/
         +aujzldzYlHs/PLdBuOo27kw1THUpHOBjA5Dk/kOMP4O9qnN0O0xD75fg6ZqFHvdCKmj
         0EbA==
X-Gm-Message-State: AOJu0Yx3VwdLlMO6mN08pdA/Tb/H+0f5iJoqAqpqboW2x7oxC/6c1ojc
	pq3mM5C4te/NiWtcNtR0vxVPrREf4ZsIhsdJQGAHWnTxdKk+J7MrgkE5N5YcwIh8mQRgGdqnEwp
	bEid/CXywcIILDVf6pNkhBUB/YOriH92g2cY0EExD/UOywHRWS8FEgC1N+9J7EBWQzH/l1c4NYX
	XNxBgExrFbsAqiABwkO6OabtpCc5h0NDcYsD9jF+9+Bmv46w==
X-Google-Smtp-Source: AGHT+IEHIbfZzH0t9D4V73xu9p99DhY7+YlU0VQbO0wuo5EI9n1h0BpaFDA8+9I9YA7R78bzaSuruQ==
X-Received: by 2002:ad4:596a:0:b0:699:209f:285a with SMTP id eq10-20020ad4596a000000b00699209f285amr617024qvb.33.1712180354006;
        Wed, 03 Apr 2024 14:39:14 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id pi10-20020a0562144a8a00b0069903cddc96sm1750739qvb.18.2024.04.03.14.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 14:39:13 -0700 (PDT)
From: Jim Quinlan <james.quinlan@broadcom.com>
To: linux-pci@vger.kernel.org,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Phil Elwell <phil@raspberrypi.com>,
	bcm-kernel-feedback-list@broadcom.com,
	james.quinlan@broadcom.com
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Jim Quinlan <jim2101024@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v9 4/4] PCI: brcmstb: Configure HW CLKREQ# mode appropriate for downstream device
Date: Wed,  3 Apr 2024 17:39:01 -0400
Message-Id: <20240403213902.26391-5-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240403213902.26391-1-james.quinlan@broadcom.com>
References: <20240403213902.26391-1-james.quinlan@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000d19f180615380dc5"
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

--000000000000d19f180615380dc5

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
activating L1SS power savings from STB/CM customers, which requires
"default" mode.  In addition, a bug was filed for RPi4 CM platform because
most devices did not work in "no-l1ss" mode (see link below).

Note that the mode is specified by the DT property "brcm,clkreq-mode".  If
this property is omitted, then "default" mode is chosen.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=217276

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 79 ++++++++++++++++++++++++---
 1 file changed, 70 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 3d08b92d5bb8..3dc8511e6f58 100644
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
@@ -1100,13 +1106,73 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 	return 0;
 }
 
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
@@ -1138,6 +1204,8 @@ static int brcm_pcie_start_link(struct brcm_pcie *pcie)
 	 */
 	brcm_extend_internal_bus_timeout(pcie, BRCM_LTR_MAX_NS + 1000);
 
+	brcm_config_clkreq(pcie);
+
 	if (pcie->gen)
 		brcm_pcie_set_gen(pcie, pcie->gen);
 
@@ -1156,13 +1224,6 @@ static int brcm_pcie_start_link(struct brcm_pcie *pcie)
 		 pci_speed_string(pcie_link_speed[cls]), nlw,
 		 ssc_good ? "(SSC)" : "(!SSC)");
 
-	/*
-	 * Refclk from RC should be gated with CLKREQ# input when ASPM L0s,L1
-	 * is enabled => setting the CLKREQ_DEBUG_ENABLE field to 1.
-	 */
-	tmp = readl(base + PCIE_MISC_HARD_PCIE_HARD_DEBUG);
-	tmp |= PCIE_MISC_HARD_PCIE_HARD_DEBUG_CLKREQ_DEBUG_ENABLE_MASK;
-	writel(tmp, base + PCIE_MISC_HARD_PCIE_HARD_DEBUG);
 
 	return 0;
 }
-- 
2.17.1


--000000000000d19f180615380dc5
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
MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDJrhUmxrQ6Ar75yn4/C2JnbvGBJOPD
SOUIEmwSdT9YAzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNDA0
MDMyMTM5MTRaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQME
AgEwDQYJKoZIhvcNAQEBBQAEggEAdO5s5aQd6Hus1G2kyr7gtU6GPFZQbTRHTVtf1Q9hkz21Z2JL
EYGWJlSNUrAxayK9y/2JnE3rGgxLqUQ8IW1l1Q2JnOIsUOHquNNIr17AU19+XUaYLyxhiS2W3P+N
IVSGi8sYGuRyivGId/vFUpRmXVl+R0K8bvsbqVGDHWsf3KLVgif2o3mErBe1MSwLSf20mQ6zkIJw
8j4IZx7J057zu2pYbKhnRpBxAoDmiCl6infqkOcQRlrdok88lgzMqWRrs0SYu3Irq/2NE4n9jtWv
iOh8NKpou6JNfmbgULA682iM2TGylfsU6zhNUc1bxww07RbPOm0Cwf7epE0ciAlGAw==
--000000000000d19f180615380dc5--

