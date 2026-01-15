Return-Path: <linux-pci+bounces-44909-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFEBD22D80
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 08:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 407523022D27
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 07:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031C932E690;
	Thu, 15 Jan 2026 07:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hBAsVHfA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9299D32BF41;
	Thu, 15 Jan 2026 07:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768462152; cv=none; b=hrqPXQFfhRuehHUYnW9EHbNFUy9arB1LdRJdFNYEiOuiTdKhvzowSmAp6Nrkb59ZBUGX6dVKg9IciKGPKr81oJQWY4xxSQaLgy+/1HwqLHOLKycmRAlCfJPbzPP/e+8LNHO1itwWrjzMyIFa7pqJ3rpADKkAx14Sd3h0hgGaSRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768462152; c=relaxed/simple;
	bh=pGreCKbWaPlPVwmAXPkYouFI6RCKPNuKxNZUczycMJc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P6iDSKR3GkH1s7ReaM1yjoRpr+YMwK1xVcatAIhCCdGw4XNdGI2Bmj/nbneqvoGsiR8U1LfRFcbxor3D8ItvR1McSJAPQ2XrtJmaXxRjrhHYY9oXpyP46pWDHIEmAaV1UAhRHZ1D0kJks8F4yBVClhx6hrw+TZV0zTxGzmVkB6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hBAsVHfA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2DAD7C4AF14;
	Thu, 15 Jan 2026 07:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768462152;
	bh=pGreCKbWaPlPVwmAXPkYouFI6RCKPNuKxNZUczycMJc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=hBAsVHfAghT+O7vX0IlNGZv4FWE1AIJVYIZ/zqKzCNQszaptTYTLDg+9Enm+XvisY
	 mBlJ3AsE93SsEKdNH4Hebers8phK4aGJf4Ck/3O+L0RLQBInLpAYLDSHC4FtxcObFu
	 5P8L+92pWwDlmgiBnx88ft/ikj4yfwp8U1h2N0mkrP6/T6ZAx2ajOL+1zXWPxrXvql
	 0F4rjdIDbh1Oj+vEnOKRGXXTIbxQbRSfU03UBx5CIFFx6bd39XjQ7L22kdyg1LKw9B
	 vjKe6b71GPZKpU1XcjyYyZVRKBHegp+dn6i+ESRtL76rRd/b2i2XVNwgDKn0YJH6aD
	 Gwv9b55mKSm9g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 238D3D3CCBB;
	Thu, 15 Jan 2026 07:29:12 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Thu, 15 Jan 2026 12:59:07 +0530
Subject: [PATCH v5 15/15] PCI: qcom: Rename PERST# assert/deassert helpers
 for uniformity
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-pci-pwrctrl-rework-v5-15-9d26da3ce903@oss.qualcomm.com>
References: <20260115-pci-pwrctrl-rework-v5-0-9d26da3ce903@oss.qualcomm.com>
In-Reply-To: <20260115-pci-pwrctrl-rework-v5-0-9d26da3ce903@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Bartosz Golaszewski <brgl@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, Jingoo Han <jingoohan1@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@kernel.org>, 
 Brian Norris <briannorris@chromium.org>, 
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
 Niklas Cassel <cassel@kernel.org>, Alex Elder <elder@riscstar.com>, 
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2814;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=kQooLkyC5qifzywZ79U+6BAgUebWpp8I5aiLs13WZ/k=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpaJdCfKH9LP+YN4xn+brCDqYhun2rxPxNp9ob4
 mhqW6Py/R+JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaWiXQgAKCRBVnxHm/pHO
 9erVB/4v+/HFL5NEYPWBicvocPxzenVnGa73DJ9j9p14CQ4FY9lL5CII5/EiPConmZJdgUVuDxW
 U3K+LnLr8E4NLpi8g3ihRn9NzvxTS9yAsgSV55EBBpzOptQ0RfUwd3YpBRLJYLoF7f2BeeH3DXr
 AuRvn5WGUeDOVR2XcUYTNP8zJu6zfmyaAbgWeeLe+dhK0E2+V+lFdJZROBS6orau0BVZUGsnIME
 26tn6PUf5aqop2ly82c8EpkKcLqi9C4ysmSAQTzK68j/EnI9Sz5j6PLjoat5QYtiTl8wcFUW+Zf
 RLMF3z5NT9vCmh0NDxqxaAZvg3dAV10Sn8xzUPZJ16yQc7+e
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Rename the PERST# assert/deassert helpers from
qcom_ep_reset_{assert/deassert}() to qcom_pcie_perst_{assert/deassert}() to
maintain uniformity.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 2a47f71d936a..43fdf1d4a753 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -290,7 +290,7 @@ struct qcom_pcie {
 
 #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
 
-static void qcom_perst_assert(struct qcom_pcie *pcie, bool assert)
+static void __qcom_pcie_perst_assert(struct qcom_pcie *pcie, bool assert)
 {
 	struct qcom_pcie_port *port;
 	int val = assert ? 1 : 0;
@@ -301,16 +301,16 @@ static void qcom_perst_assert(struct qcom_pcie *pcie, bool assert)
 	usleep_range(PERST_DELAY_US, PERST_DELAY_US + 500);
 }
 
-static void qcom_ep_reset_assert(struct qcom_pcie *pcie)
+static void qcom_pcie_perst_assert(struct qcom_pcie *pcie)
 {
-	qcom_perst_assert(pcie, true);
+	__qcom_pcie_perst_assert(pcie, true);
 }
 
-static void qcom_ep_reset_deassert(struct qcom_pcie *pcie)
+static void qcom_pcie_perst_deassert(struct qcom_pcie *pcie)
 {
 	/* Ensure that PERST has been asserted for at least 100 ms */
 	msleep(PCIE_T_PVPERL_MS);
-	qcom_perst_assert(pcie, false);
+	__qcom_pcie_perst_assert(pcie, false);
 }
 
 static int qcom_pcie_start_link(struct dw_pcie *pci)
@@ -1289,7 +1289,7 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
 	struct qcom_pcie *pcie = to_qcom_pcie(pci);
 	int ret;
 
-	qcom_ep_reset_assert(pcie);
+	qcom_pcie_perst_assert(pcie);
 
 	ret = pcie->cfg->ops->init(pcie);
 	if (ret)
@@ -1313,7 +1313,7 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
 			goto err_pwrctrl_power_off;
 	}
 
-	qcom_ep_reset_deassert(pcie);
+	qcom_pcie_perst_deassert(pcie);
 
 	if (pcie->cfg->ops->config_sid) {
 		ret = pcie->cfg->ops->config_sid(pcie);
@@ -1324,7 +1324,7 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
 	return 0;
 
 err_assert_reset:
-	qcom_ep_reset_assert(pcie);
+	qcom_pcie_perst_assert(pcie);
 err_pwrctrl_power_off:
 	pci_pwrctrl_power_off_devices(pci->dev);
 err_pwrctrl_destroy:
@@ -1343,7 +1343,7 @@ static void qcom_pcie_host_deinit(struct dw_pcie_rp *pp)
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct qcom_pcie *pcie = to_qcom_pcie(pci);
 
-	qcom_ep_reset_assert(pcie);
+	qcom_pcie_perst_assert(pcie);
 
 	/*
 	 * No need to destroy pwrctrl devices as this function only gets called

-- 
2.48.1



