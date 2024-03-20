Return-Path: <linux-pci+bounces-4959-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCFD881100
	for <lists+linux-pci@lfdr.de>; Wed, 20 Mar 2024 12:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 759C61F21382
	for <lists+linux-pci@lfdr.de>; Wed, 20 Mar 2024 11:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77423D984;
	Wed, 20 Mar 2024 11:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VEcpMUl9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F063D961
	for <linux-pci@vger.kernel.org>; Wed, 20 Mar 2024 11:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710934348; cv=none; b=gUPBhzc4VbLslDIvEVpqslCLVO/0/JYwU7Q4Q67WQ3sBd+gSRxcTqwIsFY4gaUFk4yK5Ds9BoI7/s52lTm0aRpvLdLAIrVqeWL4AQ6KOemHQeIHocSNMG37ak8kBFophPbQ166IRehbJUfIXPGmEX58UvNihsw1MzcsFhIslK94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710934348; c=relaxed/simple;
	bh=ZMXXAd43rYk7lswNbM6lIgq88PzjCi6FS81oQyedQPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qXc6Fxz8nDUA7fJXEVAcfFo7ssgicc+seDDd7P8LLjHV5sjnRcU1Lf2Yj1C8PvTzFr8VDiBAlARhyb+mAtTCabmNcojII2WE/fx2M7ZBeX4PVJ18K7KY51F2P24egMneR/2qfylAmG6EQZTei0Ilhn0DtcYWbSV7X0DsaEo83qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VEcpMUl9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ABEDC433F1;
	Wed, 20 Mar 2024 11:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710934348;
	bh=ZMXXAd43rYk7lswNbM6lIgq88PzjCi6FS81oQyedQPQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VEcpMUl9n9MeIv6rL8etLPAh/SloUKza+EalKpNtB1/UAIhaPTNVEPQF3djJEvfZP
	 2v0RpTV2RblinD0tpJGQZMMvlDc9vCjy/TOsAkz+eRLlgKslFO6pwui96BnLIah6K2
	 /YpRB+I53nDK6jfsOEBkL2vyc4ytlwFctP7yMoMKPFZFlhiGSBDGViYfgGrMq1+Pnw
	 4EZu/YOc7fRU2gmABSkSo64VO04d8ewzVLTCGdm3Wr3n/GdQucMNJsJ3lu0wvbBDOA
	 T4XD7PvNcv5T76wCToshQ/mUNbeR+kRvKJpyz45NiRD8D2y/Oe8/GsnfFK9rI4r7D3
	 FAp2k3EsEsHrA==
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Shradha Todi <shradha.t@samsung.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH v4 6/7] PCI: cadence: Set a 64-bit BAR if requested
Date: Wed, 20 Mar 2024 12:31:53 +0100
Message-ID: <20240320113157.322695-7-cassel@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240320113157.322695-1-cassel@kernel.org>
References: <20240320113157.322695-1-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ever since commit f25b5fae29d4 ("PCI: endpoint: Setting a BAR size > 4 GB
is invalid if 64-bit flag is not set") it has been impossible to get the
.set_bar() callback with a BAR size > 2 GB (yes, 2GB!), if the BAR was
also not requested to be configured as a 64-bit BAR.

Thus, forcing setting the 64-bit flag for BARs larger than 2 GB in the
lower level driver is dead code and can be removed.

It is however possible that an EPF driver configures a BAR as 64-bit,
even if the requested size is < 4 GB.

Respect the requested BAR configuration, just like how it is already
repected with regards to the prefetchable bit.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/cadence/pcie-cadence-ep.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
index 2d0a8d78bffb..de10e5edd1b0 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
@@ -99,14 +99,11 @@ static int cdns_pcie_ep_set_bar(struct pci_epc *epc, u8 fn, u8 vfn,
 		ctrl = CDNS_PCIE_LM_BAR_CFG_CTRL_IO_32BITS;
 	} else {
 		bool is_prefetch = !!(flags & PCI_BASE_ADDRESS_MEM_PREFETCH);
-		bool is_64bits = sz > SZ_2G;
+		bool is_64bits = !!(flags & PCI_BASE_ADDRESS_MEM_TYPE_64);
 
 		if (is_64bits && (bar & 1))
 			return -EINVAL;
 
-		if (is_64bits && !(flags & PCI_BASE_ADDRESS_MEM_TYPE_64))
-			epf_bar->flags |= PCI_BASE_ADDRESS_MEM_TYPE_64;
-
 		if (is_64bits && is_prefetch)
 			ctrl = CDNS_PCIE_LM_BAR_CFG_CTRL_PREFETCH_MEM_64BITS;
 		else if (is_prefetch)
-- 
2.44.0


