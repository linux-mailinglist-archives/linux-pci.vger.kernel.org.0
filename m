Return-Path: <linux-pci+bounces-5250-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC7488E13E
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 13:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1156FB26AB1
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 12:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F551154BE0;
	Wed, 27 Mar 2024 12:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M+UqjwJH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449BB15445C;
	Wed, 27 Mar 2024 12:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541730; cv=none; b=nRFcEZp0ZEKRJKcR7rAZg6d/pXpLgon8POGER/ZsFKKSKYVChbbcxp72L9Z3uTC542g27FOOUDqcwEuN0lWFCImISi8H7iR0AodofJ+f+M7JpdX5nf23lLp5mWn/cYiftOqCvlDw6tCxMVKQeFventLa6uuDYxUTbm4RqvcTSVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541730; c=relaxed/simple;
	bh=wrZTQbrVj9b5R7s1P6kRnjBvlV5rKs/bx6EK5CO82fg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ABizjUbQzQohPv8zOwVPlY2TPg0k5TCqaoTK7QhpXHN1mYPxGFzKYC7bPeAcTaP0zBR7whcMeXS9AjKjbIM/yGWmWhsUOpuvirLao4SqWwmZhpNbXPWZaa4gz5F9+n9//gunIKiZ4WvNJMNUbw6eKHCoVsuyreEDPkGON2dJGVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M+UqjwJH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E355C433C7;
	Wed, 27 Mar 2024 12:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541729;
	bh=wrZTQbrVj9b5R7s1P6kRnjBvlV5rKs/bx6EK5CO82fg=;
	h=From:To:Cc:Subject:Date:From;
	b=M+UqjwJHPPAYFkskYEovVioP7ZwwITe52sgL1MdEwugkHvHfaJ8cKP+6mUPwzFkMD
	 6wFtOnu5O6itfHZ5tt6fkobaUmFv8gzKQA4K5QxGC3+cArb1aTl34lF/UMFve1MSwG
	 vQc3NPVH5ItmazqcShSC17oKNkj2BLG/Y8F3XmVU3MHJuPi+C0kn6jR5DpjU1XC3I0
	 KnWvmNl/YAmLPaY3e1rHY7VdT2E0ElhzdLDow77WtsXpQ43MHt0xCzeFIhIYKYERvb
	 Vld7DFMQt6CJcha+Q6pEeVmBol0QVmfhscV4A1OjEouWvtJtwQt9UYDLFFo95oqlxf
	 d+Wm2Ci0DZpFA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	manivannan.sadhasivam@linaro.org
Cc: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "PCI: qcom: Enable BDF to SID translation properly" failed to apply to 5.15-stable tree
Date: Wed, 27 Mar 2024 08:15:27 -0400
Message-ID: <20240327121528.2831926-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From bf79e33cdd89db498e00a6131e937259de5f2705 Mon Sep 17 00:00:00 2001
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Thu, 7 Mar 2024 16:35:15 +0530
Subject: [PATCH] PCI: qcom: Enable BDF to SID translation properly
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Qcom SoCs making use of ARM SMMU require BDF to SID translation table in
the driver to properly map the SID for the PCIe devices based on their BDF
identifier. This is currently achieved with the help of
qcom_pcie_config_sid_1_9_0() function for SoCs supporting the 1_9_0 config.

But With newer Qcom SoCs starting from SM8450, BDF to SID translation is
set to bypass mode by default in hardware. Due to this, the translation
table that is set in the qcom_pcie_config_sid_1_9_0() is essentially
unused and the default SID is used for all endpoints in SoCs starting from
SM8450.

This is a security concern and also warrants swapping the DeviceID in DT
while using the GIC ITS to handle MSIs from endpoints. The swapping is
currently done like below in DT when using GIC ITS:

      /*
	* MSIs for BDF (1:0.0) only works with Device ID 0x5980.
	* Hence, the IDs are swapped.
	*/
      msi-map = <0x0 &gic_its 0x5981 0x1>,
		<0x100 &gic_its 0x5980 0x1>;

Here, swapping of the DeviceIDs ensure that the endpoint with BDF (1:0.0)
gets the DeviceID 0x5980 which is associated with the default SID as per
the iommu mapping in DT. So MSIs were delivered with IDs swapped so far.
But this also means the Root Port (0:0.0) won't receive any MSIs (for PME,
AER etc...)

So let's fix these issues by clearing the BDF to SID bypass mode for all
SoCs making use of the 1_9_0 config. This allows the PCIe devices to use
the correct SID, thus avoiding the DeviceID swapping hack in DT and also
achieving the isolation between devices.

Fixes: 4c9398822106 ("PCI: qcom: Add support for configuring BDF to SID mapping for SM8250")
Link: https://lore.kernel.org/linux-pci/20240307-pci-bdf-sid-fix-v1-1-9423a7e2d63c@linaro.org
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Cc: stable@vger.kernel.org # 5.11
---
 drivers/pci/controller/dwc/pcie-qcom.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 8554482debe86..02bfe415c7ac8 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -53,6 +53,7 @@
 #define PARF_SLV_ADDR_SPACE_SIZE		0x358
 #define PARF_DEVICE_TYPE			0x1000
 #define PARF_BDF_TO_SID_TABLE_N			0x2000
+#define PARF_BDF_TO_SID_CFG			0x2c00
 
 /* ELBI registers */
 #define ELBI_SYS_CTRL				0x04
@@ -120,6 +121,9 @@
 /* PARF_DEVICE_TYPE register fields */
 #define DEVICE_TYPE_RC				0x4
 
+/* PARF_BDF_TO_SID_CFG fields */
+#define BDF_TO_SID_BYPASS			BIT(0)
+
 /* ELBI_SYS_CTRL register fields */
 #define ELBI_SYS_CTRL_LT_ENABLE			BIT(0)
 
@@ -1030,11 +1034,17 @@ static int qcom_pcie_config_sid_1_9_0(struct qcom_pcie *pcie)
 	u8 qcom_pcie_crc8_table[CRC8_TABLE_SIZE];
 	int i, nr_map, size = 0;
 	u32 smmu_sid_base;
+	u32 val;
 
 	of_get_property(dev->of_node, "iommu-map", &size);
 	if (!size)
 		return 0;
 
+	/* Enable BDF to SID translation by disabling bypass mode (default) */
+	val = readl(pcie->parf + PARF_BDF_TO_SID_CFG);
+	val &= ~BDF_TO_SID_BYPASS;
+	writel(val, pcie->parf + PARF_BDF_TO_SID_CFG);
+
 	map = kzalloc(size, GFP_KERNEL);
 	if (!map)
 		return -ENOMEM;
-- 
2.43.0





