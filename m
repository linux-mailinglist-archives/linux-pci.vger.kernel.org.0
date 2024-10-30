Return-Path: <linux-pci+bounces-15582-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A52349B6038
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 11:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14430B22D01
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 10:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7463E1E32C7;
	Wed, 30 Oct 2024 10:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gCJNAHsK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4871E32B7;
	Wed, 30 Oct 2024 10:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730284383; cv=none; b=Mnhf6hOVMMQUnjoxKBI4szpg49+7UEXRGFfA6C2aUIkL6wDxroFtp1oexNrghuXGqI4CoSPcJ0mrvB7ZddZyXJCwkmiHJt96mWUhF2JZHd8MZ03Yh721op0CyGAnFoID8xTNo6fBacTKX2VINBKQA8Apc68ubeAXgKKtLtArtTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730284383; c=relaxed/simple;
	bh=lD2G8vLB+s4Fdwlswb1NADkCClyIt175699FyF+UkD8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Os7sBhhR1Z4nOxKae6WxHvkQMM4j9devkLBMq7r008RfCn+oTMlA76fWjynmBKLA+jtFTAPT2DaIWpjekysRKviKA6z9N2XXNCJxssTgS9B1J1evv7gKWh6LBwVRdwezdYq1tVBZxu98qnd06ncxS2t6Dw0i5qtfKLnMQkosB1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gCJNAHsK; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a9a2209bd7fso975050866b.2;
        Wed, 30 Oct 2024 03:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730284379; x=1730889179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sqXpApSaq9z4kEfno9SWP+axiJEGg7lOjQcw9jShE5k=;
        b=gCJNAHsKjlYtzi2vspQAjTKoKqNGcSEv1ezaGXu81OVxvwIr4WWs9d2xjRY1GIBFYW
         hn93aGcoWB3038S79qbZkbYOn0lvAL2ruTSeXA7MC801YzV2cc5NuufTw/fqeR05tQ33
         8lGKEcN8ydyDRsstmOjyuzy1bVhafCsqZ31/wcxUdYFUciOdVnbG/Sw09b0+Hee7D+KF
         yVcg58UFmuAbQA3Sgf7k7yk+jQ6itqiC5aSqmulcHEpIz0RZOcqdEz5IiBjr3pYiV94f
         zyYp6g0KvtJFjGAtG0fzFPs8SlrBZ62evpjqKRLV0agsoKWYAKKuYXTHmqxz9Fp2tsFV
         rwHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730284379; x=1730889179;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sqXpApSaq9z4kEfno9SWP+axiJEGg7lOjQcw9jShE5k=;
        b=nP3fRHvq93SWKxlUGcl+u9Y6KsAvJ/I3c2i98kIZeYEk8ydMVl5AEbm1yLaX9wdyd5
         NUPQZ5iXIrfuRtO9EM1PksXwKQDB2+Yc1n5qkjW21GOlTXNuQujuIHGJC5RPC2Dnkc5D
         G/goQFt4xh9Cj88Zr0v2u665Z3HC9pC4/AhEdzRr8bv8kGdgWnUflqa97rJVp89/ANBv
         A1zIcUKWAjr+6tJMwPeIwZ/doCLjPIqi47DDcgySOMPxLbbJykrKEcjPqAJN7FMoExs5
         5yQ2ZTlRtgBhFXOcsqlvlJrlN/ix/Ss8Pqq1Fxp4FLmSpzzaMKROiu1mTXEqbDPhK531
         IykQ==
X-Forwarded-Encrypted: i=1; AJvYcCU46/5ITWo5By67otP24bFZ0Z+h4QrA6OD8bmQ7u0i/v7+6w9i7sSUtfYifVrUI3jg4oOEXdZqHdFNyZ24=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxeb4uibNBR+oWr79YgXMOovFFXrAj5IvP8O0ALfCBnJo0vzSn3
	ua3Jggh5hHJtYiMotJOSh0eiufy55irFVjTFJe9uFILsnrEMgSxA
X-Google-Smtp-Source: AGHT+IGLvSmLJ/TmkoRPP82DnWy5nxXzkBa8lz5d0ru2At6NU0LtMQ8rQCXEQsjp4PkOyzFW9D7irw==
X-Received: by 2002:a17:907:2daa:b0:a9a:33c:f6e4 with SMTP id a640c23a62f3a-a9de61669b5mr1458266766b.40.1730284378989;
        Wed, 30 Oct 2024 03:32:58 -0700 (PDT)
Received: from eichest-laptop.corp.toradex.com (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1e1a6b81sm558178466b.43.2024.10.30.03.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 03:32:58 -0700 (PDT)
From: Stefan Eichenberger <eichest@gmail.com>
To: hongxing.zhu@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	bhelgaas@google.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	francesco.dolcini@toradex.com,
	Frank.li@nxp.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: [PATCH v4] PCI: imx6: Add suspend/resume support for i.MX6QDL
Date: Wed, 30 Oct 2024 11:32:45 +0100
Message-ID: <20241030103250.83640-1-eichest@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

The suspend/resume functionality is currently broken on the i.MX6QDL
platform, as documented in the NXP errata (ERR005723):
https://www.nxp.com/docs/en/errata/IMX6DQCE.pdf

This patch addresses the issue by sharing most of the suspend/resume
sequences used by other i.MX devices, while avoiding modifications to
critical registers that disrupt the PCIe functionality. It targets the
same problem as the following downstream commit:
https://github.com/nxp-imx/linux-imx/commit/4e92355e1f79d225ea842511fcfd42b343b32995

Unlike the downstream commit, this patch also resets the connected PCIe
device if possible. Without this reset, certain drivers, such as ath10k
or iwlwifi, will crash on resume. The device reset is also done by the
driver on other i.MX platforms, making this patch consistent with
existing practices.

Without this patch, suspend/resume will fail on i.MX6QDL devices if a
PCIe device is connected. Upon resuming, the kernel will hang and
display an error. Here's an example of the error encountered with the
ath10k driver:
ath10k_pci 0000:01:00.0: Unable to change power state from D3hot to D0, device inaccessible
Unhandled fault: imprecise external abort (0x1406) at 0x0106f944

Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
---
Changes in v4:
- Improve commit message (Bjorn)
- Fix style issue on comments (Bjorn)
- s/msi/MSI (Bjorn)

Changes in v3:
- Added a new flag to the driver data to indicate that the suspend/resume
  is broken on the i.MX6QDL platform. (Frank)
- Fix comments to be more relevant (Mani)
- Use imx_pcie_assert_core_reset in suspend (Mani)

 drivers/pci/controller/dwc/pci-imx6.c | 57 +++++++++++++++++++++------
 1 file changed, 46 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 808d1f1054173..c8d5c90aa4d45 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -82,6 +82,11 @@ enum imx_pcie_variants {
 #define IMX_PCIE_FLAG_HAS_SERDES		BIT(6)
 #define IMX_PCIE_FLAG_SUPPORT_64BIT		BIT(7)
 #define IMX_PCIE_FLAG_CPU_ADDR_FIXUP		BIT(8)
+/*
+ * Because of ERR005723 (PCIe does not support L2 power down) we need to
+ * workaround suspend resume on some devices which are affected by this errata.
+ */
+#define IMX_PCIE_FLAG_BROKEN_SUSPEND		BIT(9)
 
 #define imx_check_flag(pci, val)	(pci->drvdata->flags & val)
 
@@ -1237,9 +1242,19 @@ static int imx_pcie_suspend_noirq(struct device *dev)
 		return 0;
 
 	imx_pcie_msi_save_restore(imx_pcie, true);
-	imx_pcie_pm_turnoff(imx_pcie);
-	imx_pcie_stop_link(imx_pcie->pci);
-	imx_pcie_host_exit(pp);
+	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_BROKEN_SUSPEND)) {
+		/*
+		 * The minimum for a workaround would be to set PERST# and to
+		 * set the PCIE_TEST_PD flag. However, we can also disable the
+		 * clock which saves some power.
+		 */
+		imx_pcie_assert_core_reset(imx_pcie);
+		imx_pcie->drvdata->enable_ref_clk(imx_pcie, false);
+	} else {
+		imx_pcie_pm_turnoff(imx_pcie);
+		imx_pcie_stop_link(imx_pcie->pci);
+		imx_pcie_host_exit(pp);
+	}
 
 	return 0;
 }
@@ -1253,14 +1268,32 @@ static int imx_pcie_resume_noirq(struct device *dev)
 	if (!(imx_pcie->drvdata->flags & IMX_PCIE_FLAG_SUPPORTS_SUSPEND))
 		return 0;
 
-	ret = imx_pcie_host_init(pp);
-	if (ret)
-		return ret;
-	imx_pcie_msi_save_restore(imx_pcie, false);
-	dw_pcie_setup_rc(pp);
+	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_BROKEN_SUSPEND)) {
+		ret = imx_pcie->drvdata->enable_ref_clk(imx_pcie, true);
+		if (ret)
+			return ret;
+		ret = imx_pcie_deassert_core_reset(imx_pcie);
+		if (ret)
+			return ret;
+		/*
+		 * Using PCIE_TEST_PD seems to disable MSI and powers down the
+		 * root complex. This is why we have to setup the rc again and
+		 * why we have to restore the MSI register.
+		 */
+		ret = dw_pcie_setup_rc(&imx_pcie->pci->pp);
+		if (ret)
+			return ret;
+		imx_pcie_msi_save_restore(imx_pcie, false);
+	} else {
+		ret = imx_pcie_host_init(pp);
+		if (ret)
+			return ret;
+		imx_pcie_msi_save_restore(imx_pcie, false);
+		dw_pcie_setup_rc(pp);
 
-	if (imx_pcie->link_is_up)
-		imx_pcie_start_link(imx_pcie->pci);
+		if (imx_pcie->link_is_up)
+			imx_pcie_start_link(imx_pcie->pci);
+	}
 
 	return 0;
 }
@@ -1485,7 +1518,9 @@ static const struct imx_pcie_drvdata drvdata[] = {
 	[IMX6Q] = {
 		.variant = IMX6Q,
 		.flags = IMX_PCIE_FLAG_IMX_PHY |
-			 IMX_PCIE_FLAG_IMX_SPEED_CHANGE,
+			 IMX_PCIE_FLAG_IMX_SPEED_CHANGE |
+			 IMX_PCIE_FLAG_BROKEN_SUSPEND |
+			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
 		.dbi_length = 0x200,
 		.gpr = "fsl,imx6q-iomuxc-gpr",
 		.clk_names = imx6q_clks,
-- 
2.43.0


