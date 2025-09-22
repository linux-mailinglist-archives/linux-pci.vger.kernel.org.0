Return-Path: <linux-pci+bounces-36675-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD65B9197E
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 16:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6898424FF9
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 14:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1515F1A238C;
	Mon, 22 Sep 2025 14:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n/8vuWAA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05701990D9;
	Mon, 22 Sep 2025 14:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758550145; cv=none; b=VZBbsZVVUV8+1TQq2aI87YEjD3UXWCbTUC6csGbF0Eq9ThW9/W0HX18qrihfRy9QDq0/8AnWUM8vm+M7o0TjHeOJuHU7h3QAmRQ1BxxvmWTu6j22/wJvHIFCAIBQnc19DXvddAAM4m4otkIjkLTvbIYhwKB5+dvpPK6AdbLc4ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758550145; c=relaxed/simple;
	bh=hR+dZORAkM1FuLefHVjbtsllJasGfjrI/YD41PaH/CQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ozhTA9Uzdd6o1S8xefI2oGRP8tsghi1AR4Ho9EWS0TFjYc1C8rybAMzJv2PoNJ5xd+FRKaUPk1lgFwYXLntRMzjQbT1NjpoxfrCupBabHQtBHEMHVHBgvWeHGEnxUecAL9qlsQ3LOQFVUYhd3xLOzHsYpNSVnOAHEY8H4Ybyc+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n/8vuWAA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95435C4CEF0;
	Mon, 22 Sep 2025 14:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758550144;
	bh=hR+dZORAkM1FuLefHVjbtsllJasGfjrI/YD41PaH/CQ=;
	h=From:To:Cc:Subject:Date:From;
	b=n/8vuWAAjMKxXYntpFPKTjTp988sy+E+VQAcHy8ihLPAUKCqwVDx82cuq//7o2wq+
	 IqgrU7esRF2tRGVBTzI+NXVblNWx0106CmGSlHcfEY0rD0fuqZknvwhPnS2UFBrLol
	 O00tQgHff6Nocr2af5rVrBC8GJNT1PpB7eB/hoMpqXLzaRvBrDhmSXy6tqi8OnG/h7
	 NXMZkIV9X5ooatBrugv65c+suty0ncoYGl4ZKYvthLup50oAA5ytvnaqbTrXbIQXMC
	 IGuREGwNGC6lE9Xsopbnvdm3cvNDdpuzw6fF7fZhm30p4L4KgO0apmMhr1xSt/yOPC
	 m2OqovgKla/TA==
From: Niklas Cassel <cassel@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Vidya Sagar <vidyas@nvidia.com>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Niklas Cassel <cassel@kernel.org>,
	Thierry Reding <treding@nvidia.com>,
	linux-pci@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH v2 0/3] tegra194 PCI endpoint fixes
Date: Mon, 22 Sep 2025 16:08:23 +0200
Message-ID: <20250922140822.519796-5-cassel@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=921; i=cassel@kernel.org; h=from:subject; bh=hR+dZORAkM1FuLefHVjbtsllJasGfjrI/YD41PaH/CQ=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDIuRoR1FWQf+H70YbR+uVnZA4Uz58O7WRMNZq5mfVXcb NDt8m5eRykLgxgXg6yYIovvD5f9xd3uU44r3rGBmcPKBDKEgYtTACayLp/hf+X2Lf8Ypot7H3T1 V3xVH5Il/+ZuyWqT80feTnf+ndPEGsbI8L6vKH6G1/NnT5lmmJquXPpwp42v97tooTPTNPkjZGx mswMA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Hello there,

Shin'ichiro and I have recently been trying to get the Jetson to run the
PCI endpoint kselftests on a tegra based board. These patches ensure that
the BAR test cases and MSI test cases pass. The MSI-X test cases still fail.


Dependency
==========
"PCI: tegra194: Fix broken tegra_pcie_ep_raise_msi_irq()" requires commit
27fce9e8c6f0 ("PCI: endpoint: Drop superfluous pci_epc_features initialization")
which is currently queued on branch pci/endpoint.


Changes since v1:
-Improved commit messages.
-Added CC-stable and Fixes tags.


Niklas Cassel (2):
  PCI: tegra194: Fix broken tegra_pcie_ep_raise_msi_irq()
  PCI: tegra194: Reset BARs when running in PCIe endpoint mode

Vidya Sagar (1):
  PCI: tegra194: Handle errors in BPMP response

 drivers/pci/controller/dwc/pcie-tegra194.c | 33 +++++++++++++++++++---
 1 file changed, 29 insertions(+), 4 deletions(-)

-- 
2.51.0


