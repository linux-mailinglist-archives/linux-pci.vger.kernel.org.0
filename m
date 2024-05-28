Return-Path: <linux-pci+bounces-7896-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA7B8D1C12
	for <lists+linux-pci@lfdr.de>; Tue, 28 May 2024 15:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A73A11C22FEC
	for <lists+linux-pci@lfdr.de>; Tue, 28 May 2024 13:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763B474E11;
	Tue, 28 May 2024 13:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jmtS5UpB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECDB16D9AC;
	Tue, 28 May 2024 13:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716901259; cv=none; b=rdgv7i0f5Sri+KEU77lZFUhtwFWvFmEenwF8Ch8rvbH+irC4H3PYpsR1O25G/mr9nElMF+bTiuYw204mWwc2Xp9Ib6eIA7V231ycjobkT+EiNy76BjJNgWesEsVqhcOmSqk0sxKSrd6SUbn8CKECjbQbGICFQNrN2r+/h+EdzIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716901259; c=relaxed/simple;
	bh=NcRAmy3b90mQ51Kyo7/npjFxFXRRqDagv1+GRNTpMO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mu8WHiDSL7BEjzT/Gm+QYQqu73D0rhTnkW6Qvb3GgCusox8p6MfcGqRi6DTGtYWQVTt6Lf5/EPoKtlL7HT+bYdkk2bynDmsqqwHGivQ8/aQt8ZIdev54Y8IFjQDdsaL47N6J3XMmrtEVA1YzeLXqayLvfrNx1e/GBrd+CPTo9D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jmtS5UpB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24B89C4AF0C;
	Tue, 28 May 2024 13:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716901258;
	bh=NcRAmy3b90mQ51Kyo7/npjFxFXRRqDagv1+GRNTpMO8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jmtS5UpBTS7r+WNcz4Xm8wGmNHPhe4RDv5V2xBSZyZ+uE/uDkz5j+33aPZz3bJxG0
	 VGX0jatdIc0whlbEkfU0sYhdN7OISdRm8bJ/LJUEUCQ7wZy6O2isu6RW40Pw9g9D9J
	 X56la93TXUqC9UB+Kyaw05kxRFTDB0ijLI+5MMN5Bw/5Eh1TrLUsIZosDkr4EyYPa/
	 m4aqVBqUNel//4OG+7hY/r+spGO/DfB3X322ihUrKOoRwWI+mYm+wDCAMsttufsehP
	 QHHAYvKbc0CUJDhL0LpemxrJkdQgAsnCoWRimjdivlfhOtwmP7C39+kTf8r7p+SvBV
	 d7t9YsaS9O4nA==
From: Niklas Cassel <cassel@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Niklas Cassel <cassel@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	kernel test robot <lkp@intel.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH 3/3] PCI: tegra194: Make use of dw_pcie_ep_deinit_notify()
Date: Tue, 28 May 2024 15:00:39 +0200
Message-ID: <20240528130035.1472871-8-cassel@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240528130035.1472871-5-cassel@kernel.org>
References: <20240528130035.1472871-5-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1327; i=cassel@kernel.org; h=from:subject; bh=NcRAmy3b90mQ51Kyo7/npjFxFXRRqDagv1+GRNTpMO8=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNJCr5Z0xEbIpFyvkIs6lsac79XOs7bWXYufJbDY2ehT0 Nsb5ikdpSwMYlwMsmKKLL4/XPYXd7tPOa54xwZmDisTyBAGLk4BmIinI8NfETOVo7oK/C8XS+mv z0m70VbPv2Zmrtofh63HY/Q/l0dtZfjDr7h7xhaJD8v81r8sUp4r/ktzgtL8xC6m+sc9N2YtKnj JBgA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

By using dw_pcie_ep_deinit_notify(), the init and deinit notification is
performed using the same API layer. This makes the driver more consistent.

It also fixes a linker error where pci_epc_deinit_notify() would fail to
link in certain Kconfig combinations, because the PCI endpoint API layer
does not provide any dummy implementations.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202405130815.BwBrIepL-lkp@intel.com
Fixes: f94f2844f28c ("PCI: endpoint: Introduce 'epc_deinit' event and notify the EPF drivers")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 4b28f8beedfe..be1f10cadf1d 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1715,7 +1715,7 @@ static void pex_ep_event_pex_rst_assert(struct tegra_pcie_dw *pcie)
 	if (ret)
 		dev_err(pcie->dev, "Failed to go Detect state: %d\n", ret);
 
-	pci_epc_deinit_notify(pcie->pci.ep.epc);
+	dw_pcie_ep_deinit_notify(&pcie->pci.ep);
 	dw_pcie_ep_cleanup(&pcie->pci.ep);
 
 	reset_control_assert(pcie->core_rst);
-- 
2.45.1


