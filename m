Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4482E2C8FB7
	for <lists+linux-pci@lfdr.de>; Mon, 30 Nov 2020 22:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388361AbgK3VNR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Nov 2020 16:13:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387806AbgK3VNQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Nov 2020 16:13:16 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F63C061A04
        for <linux-pci@vger.kernel.org>; Mon, 30 Nov 2020 13:12:01 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id q3so3116283pgr.3
        for <linux-pci@vger.kernel.org>; Mon, 30 Nov 2020 13:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=N+dv1puWjuuHFk1vB/1bZGWJVxjJ3xtSrAAsl7L7E0U=;
        b=fTzmEsyjjZMbE69z4iIFel5mrlfwBUwdQNpCm6FxrpslxxJaiH+Lgi86cpk0GHo36F
         dKahKC/Z6liuxmrXptNjY81P4YQTu2QFVCqjgVFFankzWtJjjyfDbza6hc6NUfDrE5k3
         5nD7Ux5lRYZ1X3z2r5CUgPBYl6ue2eKG6aSSM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=N+dv1puWjuuHFk1vB/1bZGWJVxjJ3xtSrAAsl7L7E0U=;
        b=XHlVbFjwQllXQ6Dws2/RbBCVsWyiSuNLJ7ES3bDqLU7+o2004UhDmCFGsoMKnhpMXN
         prFbqDz+Oq+JcUzp0aiCq8ApKOumqDqQXkmHaVvt1y8w5V3M0rgn6LaoEalhc2GJPkU3
         5j+c0N7D2Q+Y/5zTjrhde6uLdivty7gUYntYPxtNqz8x4P8k+M36BaWtV8x/gBGMeSL7
         r/kReExQ5//fvArec5XD4af+J/LukTIBw7wMZM03RWfraYEzsZCs1vS/Nrlnbe5HWyvy
         Nq6OfMOXtweDv8/X+GR0O5EgUGzl5EJFk5yj0NouwlXQxa0VoJjR408prXxRwPTa42db
         3s6Q==
X-Gm-Message-State: AOAM532JR/t5Sq4Yg1egaH9MUNBLZtqZWconNvUNyp+wwWQu8CYOLcBs
        4AbrC4xGTX9Sbl/eadyEO5gJ8OvWgEHko07EP/KWQoVTPZclU8K8d57eDlz31NNnH1U3prGGT1D
        PFkeNsn0f5peJ2A43Py8x44Kb+wlD9VCYSv3Q7/hMRML7EaOtLJ2ZojQJFpqWYiESRe39+//m0i
        dUj6jZ
X-Google-Smtp-Source: ABdhPJyHBCo7iM248BtvpqWTbsJ0GkYgf/jABwj6sSm8Vv9BQUDHDXCYGUikE3aZ3W10dMjC8J8+ZQ==
X-Received: by 2002:a63:1d55:: with SMTP id d21mr19699914pgm.324.1606770720817;
        Mon, 30 Nov 2020 13:12:00 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id m7sm18320441pfh.72.2020.11.30.13.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 13:12:00 -0800 (PST)
From:   Jim Quinlan <james.quinlan@broadcom.com>
To:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        broonie@kernel.org, bcm-kernel-feedback-list@broadcom.com,
        james.quinlan@broadcom.com
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/6] PCI: brcmstb: Add control of EP voltage regulator(s)
Date:   Mon, 30 Nov 2020 16:11:39 -0500
Message-Id: <20201130211145.3012-3-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201130211145.3012-1-james.quinlan@broadcom.com>
References: <20201130211145.3012-1-james.quinlan@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000013fc7405b5597683"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--00000000000013fc7405b5597683

Control of EP regulators by the RC is needed because of the chicken-and-egg
situation: although the regulator is "owned" by the EP and would be best
handled on its driver, the EP cannot be discovered and probed unless its
regulator is already turned on.

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 38 ++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index bea86899bd5d..9d4ac42b3bee 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -23,6 +23,7 @@
 #include <linux/of_platform.h>
 #include <linux/pci.h>
 #include <linux/printk.h>
+#include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
@@ -210,6 +211,10 @@ enum pcie_type {
 	BCM2711,
 };
 
+static const char * const ep_regulator_names[] = {
+	"vpcie12v", "vpcie3v3", "vpcie1v8", "vpcie0v9",
+};
+
 struct pcie_cfg_data {
 	const int *offsets;
 	const enum pcie_type type;
@@ -287,8 +292,25 @@ struct brcm_pcie {
 	u32			hw_rev;
 	void			(*perst_set)(struct brcm_pcie *pcie, u32 val);
 	void			(*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
+	struct regulator_bulk_data supplies[ARRAY_SIZE(ep_regulator_names)];
 };
 
+static void brcm_set_regulators(struct brcm_pcie *pcie, bool on)
+{
+	struct device *dev = pcie->dev;
+	int ret;
+
+	if (on)
+		ret = regulator_bulk_enable(ARRAY_SIZE(ep_regulator_names),
+					    pcie->supplies);
+	else
+		ret = regulator_bulk_disable(ARRAY_SIZE(ep_regulator_names),
+					     pcie->supplies);
+	if (ret)
+		dev_err(dev, "failed to %s EP regulators\n",
+			on ? "enable" : "disable");
+}
+
 /*
  * This is to convert the size of the inbound "BAR" region to the
  * non-linear values of PCIE_X_MISC_RC_BAR[123]_CONFIG_LO.SIZE
@@ -1139,6 +1161,7 @@ static int brcm_pcie_suspend(struct device *dev)
 	brcm_pcie_turn_off(pcie);
 	ret = brcm_phy_stop(pcie);
 	clk_disable_unprepare(pcie->clk);
+	brcm_set_regulators(pcie, false);
 
 	return ret;
 }
@@ -1151,6 +1174,7 @@ static int brcm_pcie_resume(struct device *dev)
 	int ret;
 
 	base = pcie->base;
+	brcm_set_regulators(pcie, true);
 	clk_prepare_enable(pcie->clk);
 
 	ret = brcm_phy_start(pcie);
@@ -1189,6 +1213,7 @@ static void __brcm_pcie_remove(struct brcm_pcie *pcie)
 	brcm_phy_stop(pcie);
 	reset_control_assert(pcie->rescal);
 	clk_disable_unprepare(pcie->clk);
+	brcm_set_regulators(pcie, false);
 }
 
 static int brcm_pcie_remove(struct platform_device *pdev)
@@ -1218,7 +1243,7 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 	struct pci_host_bridge *bridge;
 	const struct pcie_cfg_data *data;
 	struct brcm_pcie *pcie;
-	int ret;
+	int ret, i;
 
 	bridge = devm_pci_alloc_host_bridge(&pdev->dev, sizeof(*pcie));
 	if (!bridge)
@@ -1246,6 +1271,16 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 	if (IS_ERR(pcie->clk))
 		return PTR_ERR(pcie->clk);
 
+	for (i = 0; i < ARRAY_SIZE(ep_regulator_names); i++)
+		pcie->supplies[i].supply = ep_regulator_names[i];
+
+	ret = devm_regulator_bulk_get(pcie->dev, ARRAY_SIZE(ep_regulator_names),
+				      pcie->supplies);
+	if (ret) {
+		dev_err(pcie->dev, "failed to get regulators\n");
+		return ret;
+	}
+
 	ret = of_pci_get_max_link_speed(np);
 	pcie->gen = (ret < 0) ? 0 : ret;
 
@@ -1273,6 +1308,7 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	brcm_set_regulators(pcie, true);
 	ret = brcm_pcie_setup(pcie);
 	if (ret)
 		goto fail;
-- 
2.17.1


--00000000000013fc7405b5597683
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
AgwTv2xmtR4KOmK4QvMwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIMSvmOePIYvr
S9u2ZmFwEltHeaje82PUsO13OjEEx/0gMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIwMTEzMDIxMTIwMVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAzAC8WhdBTBkhMNugRbxklrQC7It56
TXMWgYXHuNRGOZeiWlb0vQbLoqzjSl5Z+8tHoQVPxJUuTArQu19iPFM/W/n6yoGXh2WmfepZHhOY
SfSpP2L8nIe2CQF1Kd/2ORgHXwh0gztmoZDn3f/IkobOVJhqcdpTOhljr6onR/PXPwn9mn/GIYzY
NfdKrTGttlj++QOJvF4n17pDflc+J28OzqjMmxy6PWO914/fKFSP1ybDDoqnfT/yV1zNGAX2HW1u
CNSA5497qStJvdtIr0fZOrU2pDPjiQvpWrQ526/Q1i+rtIdU97Fd5nrgW4URlQOjnORKN8EjXn0H
eDrk75pi
--00000000000013fc7405b5597683--
