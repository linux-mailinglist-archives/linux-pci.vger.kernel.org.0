Return-Path: <linux-pci+bounces-10412-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 857559333A3
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 23:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A949D1C228CB
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 21:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6679B145A02;
	Tue, 16 Jul 2024 21:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HXWQxZgV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06E71411E6
	for <linux-pci@vger.kernel.org>; Tue, 16 Jul 2024 21:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721165530; cv=none; b=jsDt5eGRevWxa0fT9qutUUg/1KSwkduAknasP0jN/uZ5PWTNGq3b8n5pGAL/OlM/bqvoDkoKxYztiURDRpBruVBduvAkGZ7ul7OR9v4DsicuHVk9Tm14zUAtdByOBEPgOkHp9CsgQGHFtNnOlAp9O9pqGfKZ43OwIafprj9NSIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721165530; c=relaxed/simple;
	bh=UCqbxCQdkx6VBRZexx0+Cn68RR4Zg17QY3Bc93dODxE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type; b=F+DZ3xc+ZRoF0MTzcV4KNk7IcvdKzok7TlR8wP9siucmOI7sIsDdHbDw1Lj8qSkA4Kusui9FvpYRzsZEo/TTpjhVp5PHzAl8Fuoq/aZldY39eA0+LEqz4kf5pZtx8gHUQKwMv8idN3VcrVowdXTdj8tSn8X/M6np1ck6Db2KBz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=HXWQxZgV; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-78c84837564so2409436a12.3
        for <linux-pci@vger.kernel.org>; Tue, 16 Jul 2024 14:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1721165528; x=1721770328; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+pyiUAb7p4STfXsJ/emlUrsA1NC1nfalZ2FHcpYfjAc=;
        b=HXWQxZgVoNjbu+0QA8n4ZX/M6sVogA87g1iPiNOPESRcc3XCGEN1ldvERb5/b/MVBe
         0AOIgDw+7Jq12plew9UzQ76Jlz2N08NM2eqlTtg65pqIMdWEekbrdBnPaU1/Gg9btMLn
         D69U9fcJrEMNe8vGmkrvFaKgCaRX+7PoTXHlI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721165528; x=1721770328;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+pyiUAb7p4STfXsJ/emlUrsA1NC1nfalZ2FHcpYfjAc=;
        b=pbA6dmtXnYElrfV3OaTWtyWCFSYKZZ78TpYaCID4fiT404OBi92HjN6bQ210O+LZ8v
         q61R2U/MqS3V5QRhgH/QC93dXduML9r3Bb5137lp9eQflo3Y9q6x8dYZPNWh3Bc8P6AB
         +K3d+PBgZEJw4CV5pxmwDFsNQnr8Q3YR5d/IkONXhe7hb/HdNM8j5/bJR79ufyG808kI
         aAE+mPK0qF1WgFLCf+T+G/cbfXH+3VUrFFH+jkIHlgUnkrEqWyl2QKzDrHUuvF17ryd5
         CnkuoerQ5+BvpYtXkYruhAANUo84PoCkM/q9PXBO8tAmtVD9u7rOzJ+A5cXZ4sAGUQJM
         4oog==
X-Gm-Message-State: AOJu0YxUcElkj3RroPkjS5hz5kHmaOQldg75lZQlISnjhVrmVlFkDOWZ
	bP6tl1jAXkMIJ2mkfFTU3qpIj7u9rtVYKMhGsMpMS4KX52+jOLNtv3KzdwMOO1CWMJUTVuTEM1U
	nWGTVsCW7Icyw1xPbExRIZOPad8EYgY+of9/ggUa0I7bpc5kiBSwrMrM6FkQNIj7xIaScsygmyL
	YI7Kw6tYf5q9NSBeck5GVWxvXbR8FHdpVoaOQEfUxhY/Pq2lwI
X-Google-Smtp-Source: AGHT+IHMq7sIS5fikUr98UkxmIBVwJilGApJCxfCRLVg1iE2jvb1wLcaHJgx2XWdM6RSZ2NA/mSTgg==
X-Received: by 2002:a05:6a21:9985:b0:1be:c947:f17a with SMTP id adf61e73a8af0-1c3f122bb89mr4312395637.24.1721165527534;
        Tue, 16 Jul 2024 14:32:07 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7eb9e20fsm6812828b3a.31.2024.07.16.14.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 14:32:06 -0700 (PDT)
From: Jim Quinlan <james.quinlan@broadcom.com>
To: linux-pci@vger.kernel.org,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Stanimir Varbanov <svarbanov@suse.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	bcm-kernel-feedback-list@broadcom.com,
	jim2101024@gmail.com,
	james.quinlan@broadcom.com
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 08/12] PCI: brcmstb: Don't conflate the reset rescal with phy ctrl
Date: Tue, 16 Jul 2024 17:31:23 -0400
Message-Id: <20240716213131.6036-9-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240716213131.6036-1-james.quinlan@broadcom.com>
References: <20240716213131.6036-1-james.quinlan@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000e80923061d6413d4"
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

--000000000000e80923061d6413d4

We've been assuming that if an SOC has a "rescal" reset controller that we
should automatically invoke brcm_phy_cntl(...).  This will not be true in
future SOCs, so we create a bool "has_phy" and adjust the cfg_data
appropriately (we need to give 7216 its own cfg_data structure instead of
sharing one).

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
Reviewed-by: Stanimir Varbanov <svarbanov@suse.de>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index dfb404748ad8..8ab5a8ca05b4 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -222,6 +222,7 @@ enum pcie_type {
 struct pcie_cfg_data {
 	const int *offsets;
 	const enum pcie_type type;
+	const bool has_phy;
 	void (*perst_set)(struct brcm_pcie *pcie, u32 val);
 	void (*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
 };
@@ -272,6 +273,7 @@ struct brcm_pcie {
 	void			(*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
 	struct subdev_regulators *sr;
 	bool			ep_wakeup_capable;
+	bool			has_phy;
 };
 
 static inline bool is_bmips(const struct brcm_pcie *pcie)
@@ -1311,12 +1313,12 @@ static int brcm_phy_cntl(struct brcm_pcie *pcie, const int start)
 
 static inline int brcm_phy_start(struct brcm_pcie *pcie)
 {
-	return pcie->rescal ? brcm_phy_cntl(pcie, 1) : 0;
+	return pcie->has_phy ? brcm_phy_cntl(pcie, 1) : 0;
 }
 
 static inline int brcm_phy_stop(struct brcm_pcie *pcie)
 {
-	return pcie->rescal ? brcm_phy_cntl(pcie, 0) : 0;
+	return pcie->has_phy ? brcm_phy_cntl(pcie, 0) : 0;
 }
 
 static void brcm_pcie_turn_off(struct brcm_pcie *pcie)
@@ -1559,12 +1561,20 @@ static const struct pcie_cfg_data bcm2711_cfg = {
 	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
 };
 
+static const struct pcie_cfg_data bcm7216_cfg = {
+	.offsets	= pcie_offset_bcm7278,
+	.type		= BCM7278,
+	.perst_set	= brcm_pcie_perst_set_7278,
+	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_7278,
+	.has_phy	= true,
+};
+
 static const struct of_device_id brcm_pcie_match[] = {
 	{ .compatible = "brcm,bcm2711-pcie", .data = &bcm2711_cfg },
 	{ .compatible = "brcm,bcm4908-pcie", .data = &bcm4908_cfg },
 	{ .compatible = "brcm,bcm7211-pcie", .data = &generic_cfg },
 	{ .compatible = "brcm,bcm7278-pcie", .data = &bcm7278_cfg },
-	{ .compatible = "brcm,bcm7216-pcie", .data = &bcm7278_cfg },
+	{ .compatible = "brcm,bcm7216-pcie", .data = &bcm7216_cfg },
 	{ .compatible = "brcm,bcm7445-pcie", .data = &generic_cfg },
 	{ .compatible = "brcm,bcm7435-pcie", .data = &bcm7435_cfg },
 	{ .compatible = "brcm,bcm7425-pcie", .data = &bcm7425_cfg },
@@ -1612,6 +1622,7 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 	pcie->type = data->type;
 	pcie->perst_set = data->perst_set;
 	pcie->bridge_sw_init_set = data->bridge_sw_init_set;
+	pcie->has_phy = data->has_phy;
 
 	pcie->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pcie->base))
-- 
2.17.1


--000000000000e80923061d6413d4
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
MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCB2QQnbSNhFE7H1mYZ+EWaMCZkFv59v
657SYTvhl5gv+TAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNDA3
MTYyMTMyMDhaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQME
AgEwDQYJKoZIhvcNAQEBBQAEggEADkD5Fr0HXEN1GDNW1h88x2acWCDx/8lGC48EjmoTZYn4TJ4M
w6pz/P90o3okF5l72qQiGE207stHPn5xYb+0/aOP7YIuZw8kJ10GOEvEVYTJK237qw9js0aJmUSZ
aiQ+F+BT8TODuVVteYgirWy7iJJKAPoZ1I/RF85uqifAx8gV4+EUjBLK2GMLFC3fJVaRIspeprgy
7bIzw/vw61o+dAF08TkFuPIXbV2a1h3cZPzmTGKeJUO9e9f5ZXTQSnfz8XyejLT6JsoURa0QAMpc
mYFyw8JBN9ghByiNl1qY2dGeCdu0y5GVlpYOFOHL0ypWrmVtEd03xVhRg2YBu6VwFg==
--000000000000e80923061d6413d4--

