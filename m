Return-Path: <linux-pci+bounces-13047-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD93F97570E
	for <lists+linux-pci@lfdr.de>; Wed, 11 Sep 2024 17:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5982B297DF
	for <lists+linux-pci@lfdr.de>; Wed, 11 Sep 2024 15:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227001AC453;
	Wed, 11 Sep 2024 15:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GIYBAUeV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4F31AB6FE;
	Wed, 11 Sep 2024 15:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726068390; cv=none; b=HfZ9EOWW/VH5Pu6Sg+JnRA9u2/QUAUR+HwOE+9yNgOQU5T0XNboYykXA+AMxVT140Yjwx/SE2hgvKPcGchI92PCfq2vdiQ4IBIYvujEOD63TvYyZSzBCyOJKc/A3b1RQ1KA4kMGh8WbzDb2KbBsnYXiiTW0KiQ47GCSdegcA6BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726068390; c=relaxed/simple;
	bh=uReZcaZmhuTx7hytarOp5sjgfzxmW0949wLV45B1VrU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dQAY1QxtczLJPZHuOvCmWwqoJoo39eSN/xb+UwxIITJjkS3jdCC5FLyDTka6n5e5a7IP8hH+JvmNCsRsk/X9Cp74b0KUB0NBEwWCjlFFHGtsRZUraAOUK7ZEKOCxChlmHuxyXf4dBzFnRe09VVX/q/qNyAWI69CTUj7ht5Soh18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GIYBAUeV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 64E70C4CECE;
	Wed, 11 Sep 2024 15:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726068390;
	bh=uReZcaZmhuTx7hytarOp5sjgfzxmW0949wLV45B1VrU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=GIYBAUeVoEX1hw6zjgqoahdTiEfNFUKIyiun5/iQp5ZPS+5Tbsso0tc6LPz8b5BKN
	 L8ERI7vtpdAezTT4zGgmepXPvY0+ouX7mfNNIS8iaPZfazm/lQ/ZUqJjtXBFpJkxSu
	 JIr/Rrs2hVmxZJ9Md6KLUDRbi43jia7OKbIb2lg2u8YJhfwBOFaeEqDXWVZfXdIL8m
	 gxNNyc+bM/5J2ERTKivtrBtorxIEYkfUjbIeiIg/MdrTPoK5uxzIzMSq+kRwFG9YOO
	 3wsbnxhcn56syKmdhxpxs7pfYMBASFBiKTO7rbpyI8w468HfnqgO9NGDTQvDLYMsF7
	 Rv1adgLj/IaQg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C03FEE57C0;
	Wed, 11 Sep 2024 15:26:30 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Wed, 11 Sep 2024 20:56:27 +0530
Subject: [PATCH v7 2/4] PCI: dwc: Always cache the maximum link speed value
 in dw_pcie::max_link_speed
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-pci-qcom-gen4-stability-v7-2-743f5c1fd027@linaro.org>
References: <20240911-pci-qcom-gen4-stability-v7-0-743f5c1fd027@linaro.org>
In-Reply-To: <20240911-pci-qcom-gen4-stability-v7-0-743f5c1fd027@linaro.org>
To: Richard Zhu <hongxing.zhu@nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Jingoo Han <jingoohan1@gmail.com>, 
 Chuanhua Lei <lchuanhua@maxlinear.com>, 
 Marek Vasut <marek.vasut+renesas@gmail.com>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 Pratyush Anand <pratyush.anand@gmail.com>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 abel.vesa@linaro.org, johan+linaro@kernel.org, 
 Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>, 
 linux-tegra@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2572;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=/m0D3VhQoRtBu+iAIP7ukQZibxzd0TZMHoHNWuugw4g=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBm4bajwE+7XsT98PbZu6z/xKeE6l7lneaPs9NDW
 rVKZjBfGwqJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZuG2owAKCRBVnxHm/pHO
 9eTjB/48I+vJMP8fVdR5OJwBQB3TnmPP51CESri1oOcsInJjuPdK6gxd4iKS6FgxvO6cjF/HM8U
 SfwE3I1N3dSBGcSWG4HpCxZ9h1AsJ4dDp7mrCshz8irKiLWFD0lj6NK7+FCkzbHH3Un7NvffRQ3
 PloYijxoskNDj8JBowMS7yqoz8R+SkBUAC3hEC6wnT3zNEkx0hPh0b9eEzxmlT09fUui6QqEGdX
 tEXcqf2zc1svKgOnNtpriF1X6XWzW4soohgU0D2M4xo0lXwQ9AnMt6ZcA5+TFMoBC+iqJdWlsFX
 4bdOTCcomHA7okIUxUAHP03ZGBO+ZlIcmi7gUVPbcGDbU5Lh
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@linaro.org/default with auth_id=185
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reply-To: manivannan.sadhasivam@linaro.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Currently, dw_pcie::max_link_speed has a valid value only if the controller
driver restricts the maximum link speed in the driver or if the platform
does so in the devicetree using the 'max-link-speed' property.

But having the maximum supported link speed of the platform would be
helpful for the vendor drivers to configure any link specific settings.
So in the case of non-valid value in dw_pcie::max_link_speed, just cache
the hardware default value from Link Capability register.

While at it, let's also remove the 'max_link_speed' argument to the
dw_pcie_link_set_max_speed() function since the value can be retrieved
within the function.

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Tested-by: Johan Hovold <johan+linaro@kernel.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-designware.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 86c49ba097c6..7c4e316eb749 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -687,16 +687,27 @@ void dw_pcie_upconfig_setup(struct dw_pcie *pci)
 }
 EXPORT_SYMBOL_GPL(dw_pcie_upconfig_setup);
 
-static void dw_pcie_link_set_max_speed(struct dw_pcie *pci, u32 max_link_speed)
+static void dw_pcie_link_set_max_speed(struct dw_pcie *pci)
 {
 	u32 cap, ctrl2, link_speed;
 	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
 
 	cap = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
+
+	/*
+	 * Even if the platform doesn't want to limit the maximum link speed,
+	 * just cache the hardware default value so that the vendor drivers can
+	 * use it to do any link specific configuration.
+	 */
+	if (pci->max_link_speed < 1) {
+		pci->max_link_speed = FIELD_GET(PCI_EXP_LNKCAP_SLS, cap);
+		return;
+	}
+
 	ctrl2 = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCTL2);
 	ctrl2 &= ~PCI_EXP_LNKCTL2_TLS;
 
-	switch (pcie_link_speed[max_link_speed]) {
+	switch (pcie_link_speed[pci->max_link_speed]) {
 	case PCIE_SPEED_2_5GT:
 		link_speed = PCI_EXP_LNKCTL2_TLS_2_5GT;
 		break;
@@ -1058,8 +1069,7 @@ void dw_pcie_setup(struct dw_pcie *pci)
 {
 	u32 val;
 
-	if (pci->max_link_speed > 0)
-		dw_pcie_link_set_max_speed(pci, pci->max_link_speed);
+	dw_pcie_link_set_max_speed(pci);
 
 	/* Configure Gen1 N_FTS */
 	if (pci->n_fts[0]) {

-- 
2.25.1



