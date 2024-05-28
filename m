Return-Path: <linux-pci+bounces-7895-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A623B8D1C11
	for <lists+linux-pci@lfdr.de>; Tue, 28 May 2024 15:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 445801F21482
	for <lists+linux-pci@lfdr.de>; Tue, 28 May 2024 13:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0038116EC13;
	Tue, 28 May 2024 13:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aGazNDdL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB69A16D9AC;
	Tue, 28 May 2024 13:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716901255; cv=none; b=rIZ6oW/Joqs/jk69bqCTcn6zkJAVutDXGt3sIJidJcOTF7PNW/X2eQOOlUPZHVz8+GD0tm0uv2wNxY/OO46k0nL42nuJrz2YI4RmdpVyJQjyA/DH7uEO65ugD2lI0f+wswI6nC6tEpnSu12FP74msSqwUT6YokWBrxmtFKhiaL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716901255; c=relaxed/simple;
	bh=o5YaV/F8okH3+THu/qvPwFBoRhLEWm6VUfwNDyMYEKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c0zXZ8frjzxFGRs91GyinaJ5L/SE0sRLW+zHDyXIuDPKzrQHBvw4Rs9PoqcxBnglZZdxZ3V1pVAn524epf7s82AWrUUbvU7AC7RxFxmhPb2x0XA4CBwpH6fWj9it8qHP51EvQdfG1XOVRgS3ow7DeFRM7gE5VqqtTpx2a7Wn2is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aGazNDdL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 587BBC3277B;
	Tue, 28 May 2024 13:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716901255;
	bh=o5YaV/F8okH3+THu/qvPwFBoRhLEWm6VUfwNDyMYEKI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aGazNDdL2OCx9AsxfndwJOeTFQIRvuAMMrjm1yMwbFNaiYPbsFlM9DGTAHazC/RHh
	 H4rvHdcSUOcitAsglzj90rMz7kjxZ4QdLYORqe/OfRQUsHUqx5eO7zLzI+TLJgpQSJ
	 aR/jTzJUisAjfjUldVkkSGMwbVBgkkR0Mtkm34HFwTuBOljY4sRkVMRLIjJFagis2l
	 a82qytHg+gpwI7lagzL+e0q1U270hZa69Ah/3UEfCcsqEdQG2n1iIZl6ZtBP0wFu4z
	 wHVdnfHFtOHNwEZZoMxh5thm0qb+KWB5FNcFMoXlfk5r8XNEYJ/ACWnNlG2LKAYGHs
	 BS/6oM0R7atGA==
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: [PATCH 2/3] PCI: qcom-ep: Make use of dw_pcie_ep_deinit_notify()
Date: Tue, 28 May 2024 15:00:38 +0200
Message-ID: <20240528130035.1472871-7-cassel@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240528130035.1472871-5-cassel@kernel.org>
References: <20240528130035.1472871-5-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=863; i=cassel@kernel.org; h=from:subject; bh=o5YaV/F8okH3+THu/qvPwFBoRhLEWm6VUfwNDyMYEKI=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNJCr5bMOniD3YDVY6GSWo0sc8/9j0tOnnihfeWSntuUx JWTMi887ChlYRDjYpAVU2Tx/eGyv7jbfcpxxTs2MHNYmUCGMHBxCsBENO0ZGVb9lwtQ6lq16lec 1EeVigb71mDN3PV9pUpLG5851zI3ZTP801z/L8VsKbt0+4d/iz+edDP327+A18H3wP9Ua/nrOvU NrAA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

By using dw_pcie_ep_deinit_notify(), the init and deinit notification is
performed using the same API layer. This makes the driver more consistent.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index b6a5010cc1a7..25bf790e9725 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -507,7 +507,7 @@ static void qcom_pcie_perst_assert(struct dw_pcie *pci)
 		return;
 	}
 
-	pci_epc_deinit_notify(pci->ep.epc);
+	dw_pcie_ep_deinit_notify(&pci->ep);
 	dw_pcie_ep_cleanup(&pci->ep);
 	qcom_pcie_disable_resources(pcie_ep);
 	pcie_ep->link_status = QCOM_PCIE_EP_LINK_DISABLED;
-- 
2.45.1


