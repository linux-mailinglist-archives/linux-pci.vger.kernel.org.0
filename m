Return-Path: <linux-pci+bounces-34050-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D238B26ADD
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 17:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 535B39E57BB
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 15:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484FC2746C;
	Thu, 14 Aug 2025 15:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PhTbI8+N"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246018F49
	for <linux-pci@vger.kernel.org>; Thu, 14 Aug 2025 15:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755184918; cv=none; b=lCU37INJgzzl+Zzy5b6wOl7zcJuEIGOhr7Ttze6nWYKSb98lzVr5XIK7x4L9rtL0kiySrmuwfdYnrcWufcKYVTuje1n4FMgl43TfRSpNPz+oAU98YBZLwsT3DFZ0IGZ2ITuTjWDcnPw7D95WAQTu9doj9L0y4SMK90rtAP8xCHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755184918; c=relaxed/simple;
	bh=bnwImDFP8yprdZXpvaKvJiFlBgbcOtPQck+heCkeftQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GY+eK+9kr8wIwx5pIBtOSXliQx2l2K4McN8Ldnb1gYJqdPV9IhqK1hzQF2QPUOFZWX8haR4hWeXEU7jJEOq+yDUab2G/Hvhv0j8yokUU6Ln5Pmgv7yrp0WH5b7pYb4juMxV7gNlsjtQCc4yHLE6PoVeTM/qRWpG3z6Iu6RSeY2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PhTbI8+N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C7BCC4CEED;
	Thu, 14 Aug 2025 15:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755184916;
	bh=bnwImDFP8yprdZXpvaKvJiFlBgbcOtPQck+heCkeftQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PhTbI8+NO0IIFwKPy7fVDrmaYPg/p5Xad/MBUrPF556R+eUA/2I9z1+uyKCjFcckg
	 y8E+W5FnEtfQZpS+nYRnaAqWCHsrPsEmb2mqykDGimVeWj/5uc4rnQPH50+ohNhcUg
	 XtE4LZG9Ts6xZXyUk2Aw1DZLYZ6Qk2CCasFvbVRpuR3dqslLFQZjND2Cz19vLc+EVr
	 n7pxQeno98873Hn6H5OPtPqmFFDuM2Uhk5BNK1Y4nbX+/2dj3EB3UN46dPRGvysthW
	 dq3zG3e1pq0/cWwoCFIm4a3iCUjKrUQi6XqkKZD5mqI9ZC+YrXuiZFqN9Z0k7hxy/f
	 ZGPFTeA4Urcgg==
From: Niklas Cassel <cassel@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 03/13] PCI: rockchip-ep: Drop superfluous pci_epc_features initialization
Date: Thu, 14 Aug 2025 17:21:22 +0200
Message-ID: <20250814152119.1562063-18-cassel@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814152119.1562063-15-cassel@kernel.org>
References: <20250814152119.1562063-15-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=864; i=cassel@kernel.org; h=from:subject; bh=bnwImDFP8yprdZXpvaKvJiFlBgbcOtPQck+heCkeftQ=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDLm/vsW1JF8eq6k5e/8m3mzeWexPv6SkKLdXvEq5d/ax slTFqS/7ihlYRDjYpAVU2Tx/eGyv7jbfcpxxTs2MHNYmUCGMHBxCsBEngszMnybnpNoXtm3rvNM byDX69dKXd3mYSrm+/Mbr8YsTvdRvMLI8Dhte0rJ5f9nTpx4XR50MPTdzKD5nyIuOIurL6nbryk WyAkA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

struct pci_epc_features has static storage duration, so all struct members
are zero initialized implicitly. Thus, remove explicit zero initialization
of struct members.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/pcie-rockchip-ep.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
index 300cd85fa035..799461335762 100644
--- a/drivers/pci/controller/pcie-rockchip-ep.c
+++ b/drivers/pci/controller/pcie-rockchip-ep.c
@@ -694,7 +694,6 @@ static int rockchip_pcie_ep_setup_irq(struct pci_epc *epc)
 static const struct pci_epc_features rockchip_pcie_epc_features = {
 	.linkup_notifier = true,
 	.msi_capable = true,
-	.msix_capable = false,
 	.intx_capable = true,
 	.align = ROCKCHIP_PCIE_AT_SIZE_ALIGN,
 };
-- 
2.50.1


