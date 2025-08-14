Return-Path: <linux-pci+bounces-34057-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E93B26AF8
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 17:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFBC85E2A56
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 15:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E4421C18C;
	Thu, 14 Aug 2025 15:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o3JLKSrz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2118521B9CF
	for <linux-pci@vger.kernel.org>; Thu, 14 Aug 2025 15:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755184937; cv=none; b=rKKdFACldlymhPgiYI/RReWz4QUPAEwG+s1FBJK++xyHXtgFqI8qLNiiqcLu0TnGlojZ7U3p1xKLT9oNWDXIOE6hgXsyq/OI4RJsL3o63SNyZa0W7SUYMRdyyUkCuG2xfSnrF0j/39vZ9NnCGMxdgUXuUc1v3Z6P4JODthyDjFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755184937; c=relaxed/simple;
	bh=Kais377woRCaAR4BnKqnki/mOYL4zj5QzR74SDMYF4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mi8YDJJ3HysMQw9eHw9AK4RoB429e8dLgm78sAhyL5sAp5PASm3InLZI48N9sokiDPMlHJq8me1Pwe8uI0qEui/Zy7JpYDQT/Aah3YMqsjNUB+NDpwt70Pt20QtWB8vNubXMU++hmJ46L1dpBdrhv2ZZPuWKcs1l8T1ROySuJYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o3JLKSrz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E27C4C4CEF6;
	Thu, 14 Aug 2025 15:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755184936;
	bh=Kais377woRCaAR4BnKqnki/mOYL4zj5QzR74SDMYF4k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o3JLKSrzgLbCx6JISX+VLYlsYBsoQi0u4f1bmdGrxXm6ftpX3TvzWD7mKXiOMu/e+
	 XVGiKFmhZJMRfGvkLzeMaNs2+aM4sEOvvfvkHjLo5+CRHkg70bwQIARe7qPlWiJ9CV
	 xvkRNTqj73pGEEZtncRHV3KnLv0TOk+7zpDHirIeAlrqoEQr5apEbxnbH2CoclGf40
	 fLJkDy7qEwjCrxQlk63DFKZ/RILyc5YJWZBE31oJPiBIwi7r3bK/8I1E9yLzrLepcp
	 45nnUcVywOtugmlTNL/FEXaGFhiA83Bruwr9BXrdWjQnCuvLIW1Cjy+1Z2zrBoYdLy
	 sZzc8486fKitA==
From: Niklas Cassel <cassel@kernel.org>
To: Srikanth Thokala <srikanth.thokala@intel.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH 10/13] PCI: keembay: Drop superfluous pci_epc_features initialization
Date: Thu, 14 Aug 2025 17:21:29 +0200
Message-ID: <20250814152119.1562063-25-cassel@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814152119.1562063-15-cassel@kernel.org>
References: <20250814152119.1562063-15-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=857; i=cassel@kernel.org; h=from:subject; bh=Kais377woRCaAR4BnKqnki/mOYL4zj5QzR74SDMYF4k=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDLm/vsRns15+F5BxrmAqK59X+q49jzouPfHonOy7kQmv stWrZw/OkpZGMS4GGTFFFl8f7jsL+52n3Jc8Y4NzBxWJpAhDFycAjCRoEkM/wyKcg7E+trHltdc aVZcb7l91TGnmstHL+xVZjvwyuH7gmeMDIv3/U24+1D6Kz/Dryf8vTOdY5oO9LzVSnqzS3SJ4PZ Te/kB
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

struct pci_epc_features has static storage duration, so all struct members
are zero initialized implicitly. Thus, remove explicit zero initialization
of struct members.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pcie-keembay.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-keembay.c b/drivers/pci/controller/dwc/pcie-keembay.c
index 67dd3337b447..60e74ac782af 100644
--- a/drivers/pci/controller/dwc/pcie-keembay.c
+++ b/drivers/pci/controller/dwc/pcie-keembay.c
@@ -309,7 +309,6 @@ static int keembay_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
 }
 
 static const struct pci_epc_features keembay_pcie_epc_features = {
-	.linkup_notifier	= false,
 	.msi_capable		= true,
 	.msix_capable		= true,
 	.bar[BAR_0]		= { .only_64bit = true, },
-- 
2.50.1


