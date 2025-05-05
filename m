Return-Path: <linux-pci+bounces-27143-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E489AA8F89
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 11:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C71D17573E
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 09:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB341F9F73;
	Mon,  5 May 2025 09:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="frxeHQUi"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734451FAC46;
	Mon,  5 May 2025 09:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746437194; cv=none; b=cLimtGbRaUTrdbDCbE0udyIECXEd7y9mTAVLy8HKZSGEVOddFvojPGAnSAoSiXNmrg8OTh4bmlevxmMMgFzAdaACmuWbPO4y07yqZ6F+nZI5197eFJ8TQe+FdSiTCrMUHxJeYKI+u90jN2KK6p7LesitHQ/VA+H2W9MAaEFrceE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746437194; c=relaxed/simple;
	bh=qCdUaJHFqgD/+5CjmePFtJd+YRcnSD56LhRxRAdBUtc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ajU5DLd5qI32X6ZfQBvDXf2c1Gbb4eXWhH5kLQ8G2uA9dwqmPwA/0TOOwlJJKCYjmulMFVTRKJlnb4MSA4pqIVmzhHUmL/ZPAiT5oemtTky29+EVRq6z195NdibIuyHg7PSLVpdLFS4CBNrb9BoGo4hHXvqRcT7/pHV6qA3j4NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=frxeHQUi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C51D0C4CEEF;
	Mon,  5 May 2025 09:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746437194;
	bh=qCdUaJHFqgD/+5CjmePFtJd+YRcnSD56LhRxRAdBUtc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=frxeHQUi0mj4FD3O2Y7DmjIrjJ+jKojsPGWlQLBJa20ut4V00R2ceSg6rp82jpohO
	 NH8Fun4ktB2qkKGu5A4TSxDEbIqUdeu3VwvkrMMJkzF//1oH4I0JJ2+YxP/AQEJcN3
	 XwlwjezPL4F0xjiedhtK2f3GRTsYRb+zwXYpB7nRnqA5agQLiFeYjs8e1XjI8lJKLa
	 UVd6I5opRorEfUeU7dbNJps3scc3/TkQ5GwROfUw6e/GkjoNoBaeb+qhBvE0EtiC1D
	 aAJDg4RHilEdBP2VbyVXNSCGc8PyOFCCiU1WLcbe2aL4DxapB7V+O2RVcY8gQj+OCN
	 FMwj8QX/T4GoA==
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Hans Zhang <18255117159@163.com>,
	Laszlo Fiat <laszlo.fiat@proton.me>,
	Niklas Cassel <cassel@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH 4/4] PCI: qcom: Replace PERST sleep time with proper macro
Date: Mon,  5 May 2025 11:26:08 +0200
Message-ID: <20250505092603.286623-10-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250505092603.286623-6-cassel@kernel.org>
References: <20250505092603.286623-6-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=847; i=cassel@kernel.org; h=from:subject; bh=qCdUaJHFqgD/+5CjmePFtJd+YRcnSD56LhRxRAdBUtc=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDIkWnRj+fsyPOy7Xu9ZNk9GNqb60z21JY85FS0rk5fsL 7DPd3jfUcrCIMbFICumyOL7w2V/cbf7lOOKd2xg5rAygQxh4OIUgInsnMjI8EBEJeTGkr7UogUH jNb3N71SP7Lb5tD9b/PWvsv8+5Z1+keGfyqdp5I5Uk2yfnw6r3KCw0RRgkEr9+1J0/8c3l+cZ77 RZgAA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Replace the PERST sleep time with the proper macro (PCIE_T_PVPERL_MS).
No functional change.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 5cef5e92b173..b1b89d5cb86a 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -301,7 +301,7 @@ static void qcom_ep_reset_assert(struct qcom_pcie *pcie)
 static void qcom_ep_reset_deassert(struct qcom_pcie *pcie)
 {
 	/* Ensure that PERST has been asserted for at least 100 ms */
-	msleep(100);
+	msleep(PCIE_T_PVPERL_MS);
 	gpiod_set_value_cansleep(pcie->reset, 0);
 	usleep_range(PERST_DELAY_US, PERST_DELAY_US + 500);
 }
-- 
2.49.0


