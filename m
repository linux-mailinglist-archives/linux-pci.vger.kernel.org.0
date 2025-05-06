Return-Path: <linux-pci+bounces-27264-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5087AAABCB0
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 10:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 602E85A17FA
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 07:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA8572638;
	Tue,  6 May 2025 07:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ORtYcfgG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C1272637;
	Tue,  6 May 2025 07:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746517200; cv=none; b=EK9d48H+f98uXwuK2znl7q8qzL7bD6FR/PJioi4Qqf9BGh7fBX+QItawOXfEM5ym/EQFgE+atpR5fVRLLxQRxY2EYXe9hty5k2AZ9GhPi/5FkXRT76S6yXKmZwYIIM+A6npctG1IDZR3PgrQMh5OYDqp4yxJi8ri5UrWwDkRBwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746517200; c=relaxed/simple;
	bh=aDBAcDbQGOt5Xv5cthyXK3A/bSsdny7PtcfYNAzg71I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oXBDhwdOpk8pJZZUOJKWbfO8jtSFl8kHuInWmrQbid7rmiiwofJmAgsWWHQL60TrxZo9PvqguNIkPvQtlLWEp5IDCRAYT7+Cjkapdt+21cv5KuUCRLCF1xHEPzfZP2godqwFXf4tf5Z+h6LEMmoy8SuBlIIPmpbdoK8+L9vzhL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ORtYcfgG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39EB4C4CEE4;
	Tue,  6 May 2025 07:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746517200;
	bh=aDBAcDbQGOt5Xv5cthyXK3A/bSsdny7PtcfYNAzg71I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ORtYcfgGYTZGn6p83DHwBgXNrpNQk4f8CgPSNJYfF2fAkWhD4MSzEVlRSyPEoxO8y
	 evdaYl1MvivN+dcfLkrvDe5iD8elHpUaRYWa0eOP+Psu0aFXOXfSxCnU6DODhxlMQd
	 4laVsr4+WfY2PnytmfjsCrSq236Kg4ByWNLHPx9KLmC7eARuavfaQ6icStkuI2N/w4
	 eU1f4XQvBOZ7omzpPZchAnTNP6iKGo1FEQBaEahAZDnpI31bazRfc/ws41nNPP8okw
	 nZXBJjCpK87+3PxSbPOwSifp4mOABYv36tanhmHQlWW3cPeOoMkBocKcDNtrw+vYCT
	 rpY4H7JJfWEnw==
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
	linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 4/4] PCI: qcom: Replace PERST sleep time with proper macro
Date: Tue,  6 May 2025 09:39:39 +0200
Message-ID: <20250506073934.433176-10-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250506073934.433176-6-cassel@kernel.org>
References: <20250506073934.433176-6-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=847; i=cassel@kernel.org; h=from:subject; bh=aDBAcDbQGOt5Xv5cthyXK3A/bSsdny7PtcfYNAzg71I=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDIk9+wxX3jdfJpAn9gxhSVlt8/ccHoWfWrDObkss9ssW 9fqtGnN6ihlYRDjYpAVU2Tx/eGyv7jbfcpxxTs2MHNYmUCGMHBxCsBE2v4zMnyyXhm4cFGixL1f ZdbW006ErG+7uc9vVfq7TQrfqhcp/9vMyDD309udgjKftA9JP5Q1bF6sc5UpozPxdcwSRcHXy70 97vABAA==
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Replace the PERST sleep time with the proper macro (PCIE_T_PVPERL_MS).
No functional change.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 01a60d1f372a..fa689e29145f 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -289,7 +289,7 @@ static void qcom_ep_reset_assert(struct qcom_pcie *pcie)
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


