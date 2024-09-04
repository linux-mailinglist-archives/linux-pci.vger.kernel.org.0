Return-Path: <linux-pci+bounces-12720-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9667F96B27B
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 09:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E52A1F25895
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 07:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D3F146A69;
	Wed,  4 Sep 2024 07:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uk5kzlyM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B5314658C;
	Wed,  4 Sep 2024 07:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725433922; cv=none; b=UTGzqwlO6OXqKY3bZzKb0E0UjryM23UrGFq6xsXANOMNl4lpDtpKcVfL85CdIWFWkJ1v8rF5Pv5tSo3MixsgtVKAtsK7u7Xir8WXZNahsDBKvoNC/IxGMqM1vfAAaatwYjX/FQidPxeE5hjeu+SEReNKa7hf5Z7tcoDkmkxyjxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725433922; c=relaxed/simple;
	bh=6q4KWgmKWVsBZi0g6hTPDwqUsyptyC8WQz2AyBrV3xg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ESbkE+WSx26YKjBe+26AlljtF8FqTTD8FEkdaKeIdmEVh+DG7y/v2ieS+Q3mm5QhQo4Ur5Xb28bflC3GQG9+NSERly3ZVfhqZPDL2idRJVQm//EabQgnD8Gq5OhdxTZtRaRgNijQddnSqiqsfmhyJc6VjIy/UVhXXdBcCYZB0lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uk5kzlyM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1A267C4CECB;
	Wed,  4 Sep 2024 07:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725433922;
	bh=6q4KWgmKWVsBZi0g6hTPDwqUsyptyC8WQz2AyBrV3xg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=uk5kzlyMJM8HKOZ7t9e32L1IYF/hoRuqxp3MLmpimdNDKtWeIgd5pEfPf6l4KFJIl
	 HcIVHhGLGIk1JkLl8lGVIupB/0PahZe2tZcH4P6v/jorqwEB03v22cuJQBl5diP4+t
	 1rM+3z7lVd75UvK9yhvDc/L4j0+t7kE5iS0vDJvQFLFci+qOmGZtYnRbaroyic5y7h
	 b3U76mHsSLb/XJRnXSp3GI+K2JYiH7G9eUifwCCH2eRG93iH+cOnHtvGwd7y6XzBvi
	 zsZciQqzMKvLexLJ4ICb9N13K+w0SusaM8OWmjAqkl1QbJerUk1b2cLOwxGW6D6oKh
	 ej0zTOfa99ygA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08BA2CD3431;
	Wed,  4 Sep 2024 07:12:02 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Wed, 04 Sep 2024 12:41:58 +0530
Subject: [PATCH v6 2/4] PCI: dwc: Always cache the maximum link speed value
 in dw_pcie::max_link_speed
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240904-pci-qcom-gen4-stability-v6-2-ec39f7ae3f62@linaro.org>
References: <20240904-pci-qcom-gen4-stability-v6-0-ec39f7ae3f62@linaro.org>
In-Reply-To: <20240904-pci-qcom-gen4-stability-v6-0-ec39f7ae3f62@linaro.org>
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
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 abel.vesa@linaro.org, johan+linaro@kernel.org, 
 Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2426;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=D8fhqlsKz3xyqSNMvnVSSeaKQj4RuRyuF4B9yBERg8c=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBm2Ag+gHgv/70oSE6q/WC7SNywmP6sofcRgja3k
 ZSHRiTMBGeJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZtgIPgAKCRBVnxHm/pHO
 9WjuCACnCHbZaYumklhb1N/5rQObm+rKLZHjTx8nDFsA+BUdz3qBaZJ9G7cXIzxhtxrjWVrQgZ1
 KfykKJC4/hQxPZvtuDY7n20z04Q8yja6vmmY4rU4GPK88klgKPHZc/X8Bi3wsWCT4qTCzvhvEm5
 q2W8t/sySpwuMSyu4qnIgmIMtuydHUVs3FKbXcEZpE+ZfVvK4lhjk146BG1rPEOKfY7t5xajIEW
 cg2fx92lMu+4Ek/q6o+HhGNyqpEzTvumEwr0SDMdD1IO3uKAlj9pn8ORUEQ6SuleP+GZIHblIxx
 wXkdgvbLtCQ1YEtaF9thtq6Cjk8UgWZ5MWXjWEvVCJmCGAGu
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

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-designware.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 86c49ba097c6..0704853daa85 100644
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
+	if (pci->max_link_speed < 0) {
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



