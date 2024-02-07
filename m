Return-Path: <linux-pci+bounces-3225-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D85E84D57F
	for <lists+linux-pci@lfdr.de>; Wed,  7 Feb 2024 23:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B5541F2B655
	for <lists+linux-pci@lfdr.de>; Wed,  7 Feb 2024 22:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FDD1384BF;
	Wed,  7 Feb 2024 21:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aVG2fZPS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E376128374
	for <linux-pci@vger.kernel.org>; Wed,  7 Feb 2024 21:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707342033; cv=none; b=nvNwldbtZOGKoe2eS42+hREbJnRvz0++V5eWvNJdifapd10XdWMGxe6Pu+FjZkMPmb6cDZZSpFu8dL/Av2WEYQaWxXRO4UnkPK4fpvzDFQUOch4PAdynHCiUSPMx9JPXq5EPoZsvvR4szm56FlqcMPx25GI2Rh44kDHTfEXwNWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707342033; c=relaxed/simple;
	bh=N7ZKqHPGXfWt+MkG5VO8F2GODx04e0Kf0WyC2JoHZzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QAoEeiGa7C/Nd6S7MivVlX48o1fyy8kjRC3fWLG7c2ATLanrfmd7hAnNMVkt7JFpKm9rcXJMK9SFph/AcF1Pnilp37RG/Nvd6tBN2qhcrhDFM6owUDAhLLDnrAJ5BTu0RXGxfXfdcnps6Luqk5e/d5PcPLkbWj/1+YU4pJbajO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aVG2fZPS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19338C433A6;
	Wed,  7 Feb 2024 21:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707342032;
	bh=N7ZKqHPGXfWt+MkG5VO8F2GODx04e0Kf0WyC2JoHZzY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aVG2fZPS6yGNkMtEzj9ohXqxM4zDnz74e9NgVV8mCcpsnX2X7pnWu8tGYMKdYlwMk
	 bUSdxeStVcWFIoNUNMTEDpYpjRouGiIIBLlzklcJUEMyLWerOyIgCltp/Z/MsBNOTO
	 iFPOVG3hd8l/CfHHkFN019MsmrQGg/gATyUoFE+mdpkFL4av/nZCSLDfn4wEArR2w4
	 PIC5D4jPyWCzeYUjkW40WIyaonD3YTdt9q4H5KMk66PViFSiuW/FKWN9obHxapToBM
	 6WhvawAmlCsywJbvTbvB2bX8eLAoObqN/7Eru8uvpl+ILzh7u7Gd9S2sP+fAYzISBH
	 LXjH0v7ppt80w==
From: Niklas Cassel <cassel@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH v2 3/4] PCI: endpoint: pci-epf-test: remove superfluous checks
Date: Wed,  7 Feb 2024 22:39:16 +0100
Message-ID: <20240207213922.1796533-4-cassel@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207213922.1796533-1-cassel@kernel.org>
References: <20240207213922.1796533-1-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove superfluous alignment checks, these checks are already done by
pci_epf_alloc_space().

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 15bfa7d83489..981894e40681 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -841,12 +841,6 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
 	}
 	test_reg_size = test_reg_bar_size + msix_table_size + pba_size;
 
-	if (epc_features->bar_fixed_size[test_reg_bar]) {
-		if (test_reg_size > bar_size[test_reg_bar])
-			return -ENOMEM;
-		test_reg_size = bar_size[test_reg_bar];
-	}
-
 	base = pci_epf_alloc_space(epf, test_reg_size, test_reg_bar,
 				   epc_features, PRIMARY_INTERFACE);
 	if (!base) {
@@ -888,8 +882,6 @@ static void pci_epf_configure_bar(struct pci_epf *epf,
 		bar_fixed_64bit = !!(epc_features->bar_fixed_64bit & (1 << i));
 		if (bar_fixed_64bit)
 			epf_bar->flags |= PCI_BASE_ADDRESS_MEM_TYPE_64;
-		if (epc_features->bar_fixed_size[i])
-			bar_size[i] = epc_features->bar_fixed_size[i];
 	}
 }
 
-- 
2.43.0


