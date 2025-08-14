Return-Path: <linux-pci+bounces-34054-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5A2B26ABE
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 17:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 849377BF309
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 15:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C6F8F49;
	Thu, 14 Aug 2025 15:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aHoEDBQw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F4FE555
	for <linux-pci@vger.kernel.org>; Thu, 14 Aug 2025 15:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755184929; cv=none; b=iJmweLX8YkjkkP9ihy4T9iLojvek+Afs2xM1JvY3e0lnty8k1KDWkomTrbj5lOedG1aPQbNdqfJ7vVC2gqIFYpxondQ3hTxcCA2BxFs98PJzi8kI1G/XQF0iD0I5eiwSiuoOK+MsPM0REH4lRlbZKeuFSKG+nNmv0kqHgRigu1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755184929; c=relaxed/simple;
	bh=HFPdE8RGsgZmliQvNziBIgCuKtYN0HKbgHHj17R8310=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pGDoBlXa7ozvnpgAgDmfoxaaY1qJZDEdtYz/bEcuJJv1iVpy1ZzNTarR50dxAlhVu6Mqnb2n1Po0aYnaO2xUyG6DURO/jhSIM7ATYphuDfHIJmjeP1hXshuBIQRobyqLU0fLSXgB6rOqB2JdRf9m2A79qpx9kSyv4dUsWUzr7Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aHoEDBQw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAD85C4CEF7;
	Thu, 14 Aug 2025 15:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755184928;
	bh=HFPdE8RGsgZmliQvNziBIgCuKtYN0HKbgHHj17R8310=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aHoEDBQwLJbN/YNr9g+2t6GhNoiML0SonQnAu2Z134RHDbmrZn8ybjw4imQFmD5zP
	 Pjp0Ht/45gysuH/dsn+/1UJCAPHFLdIgaNGvbsiEFPHYz6JFgB5yZ1IK7Z1XbxCaqz
	 U0XA5F4XugfaFPQFxyXmLtEMjDmT0fs1Zaa61JpR3Ew4CXgHeFMxVdLYq1OeZJeglp
	 0KIrnsZgBYAHhg9llVRpQER9sKalhi479OLT21BkexLeFUreRdBrLchGkbkRMD9gyY
	 1Rot4k6YJSktv9ycs+wnkqKkGVURV37NbxhvvVt1nG7nZnIwA8o0PLaBzcfO25VU7i
	 1OJxip9bIst5g==
From: Niklas Cassel <cassel@kernel.org>
To: Jesper Nilsson <jesper.nilsson@axis.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Niklas Cassel <cassel@kernel.org>,
	linux-arm-kernel@axis.com,
	linux-pci@vger.kernel.org
Subject: [PATCH 07/13] PCI: artpec6: Drop superfluous pci_epc_features initialization
Date: Thu, 14 Aug 2025 17:21:26 +0200
Message-ID: <20250814152119.1562063-22-cassel@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814152119.1562063-15-cassel@kernel.org>
References: <20250814152119.1562063-15-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=861; i=cassel@kernel.org; h=from:subject; bh=HFPdE8RGsgZmliQvNziBIgCuKtYN0HKbgHHj17R8310=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDLm/vt++vKTTwtj/l/6yP5unrbsPxbD50snXZd8d4Tv7 J1TvvIOXR2lLAxiXAyyYoosvj9c9hd3u085rnjHBmYOKxPIEAYuTgGYiEY2w/8w69b72eprr2uZ t8ccX3HWYeqlm013Py+dpcOSY/X1fRgjI8Mc9bK+VRsvB70v/utszaVsVeZ/J/efffPK98scmIq WRLMAAA==
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

struct pci_epc_features has static storage duration, so all struct members
are zero initialized implicitly. Thus, remove explicit zero initialization
of struct members.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pcie-artpec6.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-artpec6.c b/drivers/pci/controller/dwc/pcie-artpec6.c
index 234c8cbcae3a..f4a136ee2daf 100644
--- a/drivers/pci/controller/dwc/pcie-artpec6.c
+++ b/drivers/pci/controller/dwc/pcie-artpec6.c
@@ -370,9 +370,7 @@ static int artpec6_pcie_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
 }
 
 static const struct pci_epc_features artpec6_pcie_epc_features = {
-	.linkup_notifier = false,
 	.msi_capable = true,
-	.msix_capable = false,
 };
 
 static const struct pci_epc_features *
-- 
2.50.1


