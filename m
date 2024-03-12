Return-Path: <linux-pci+bounces-4750-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 881EF879277
	for <lists+linux-pci@lfdr.de>; Tue, 12 Mar 2024 11:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E74FCB23C96
	for <lists+linux-pci@lfdr.de>; Tue, 12 Mar 2024 10:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E25369D19;
	Tue, 12 Mar 2024 10:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CzVsGs74"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1052572
	for <linux-pci@vger.kernel.org>; Tue, 12 Mar 2024 10:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710240747; cv=none; b=Xc+OT1PkOwx2nYcMILg9fwc67FAjzwu9H96kraNgxqEjchmbxVVzPLhVhubcNfVLI3sN6v904tR3LPdXP94KXGGgJTm3S5dV54WNazRNzRQ5ewhFqf54DHghbzEFgBEV/BSOF3SquObz9jQUoV9jm68xl2fRALvscmop/4OgSQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710240747; c=relaxed/simple;
	bh=gLB2KAEejr4yFbPG8yMOboe39FhTnoO5eBMwKPyo8g4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lkz9Kdj5qzEJGYUH2WRIUkUMQ2Uml+t2WQdlK0V7wJfjSaiKUQ2xMe7nNDPDzt8V8w2Ooe0p2j6RWX/2rE3yn5ykPavBUIuDSapEYX0rAZTlw5lNru7xPY3t/5LVitmgmrt+C1r1I4ri7+AiBCazN6QWqTNd6sVJQBTF+LApyOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CzVsGs74; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60213C433F1;
	Tue, 12 Mar 2024 10:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710240746;
	bh=gLB2KAEejr4yFbPG8yMOboe39FhTnoO5eBMwKPyo8g4=;
	h=From:To:Cc:Subject:Date:From;
	b=CzVsGs74ke+htWoFS1y92ISAzn84V9qYO620OqY4AaIRCoxZICT4QVvVOsI6RmJlY
	 joo81K7vtNGO3Ve1YuFQCMgJABzfhXHYDMf0ydEXD0Ey5PbEtv1N3CVyy6hECWxbyh
	 xb1uTmvupOXY2JFGcMbCFX5IR6VY9tvIu9rXIQgzSV6KCbVew6r0WzxhIBh8bS/4Ix
	 ll/dhYFRaZVwnnJ4iBvaQWVNctgDvg6hWPCNNJjDi1pDZzdnMLpc3vTvMqrh9u0Dwz
	 HemhIiE41ruFqblUSjv5c1HhnMSnlrYkYFza8n6hmvI6cgrKwfb5JSzBsR6w1OYmkx
	 4oNxChfd0Xr+w==
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Shradha Todi <shradha.t@samsung.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/9] PCI: endpoint: set prefetchable bit for 64-bit BARs
Date: Tue, 12 Mar 2024 11:51:40 +0100
Message-ID: <20240312105152.3457899-1-cassel@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Shradha Todi wanted to add prefetchable BAR support by adding more things
to epc_features:
https://lore.kernel.org/linux-pci/20240228134448.56372-1-shradha.t@samsung.com/T/#t

The series starts off with some generic cleanups and fixes which was needed
to make the implementation of the actual feature easier.

The final patch in the series sets the prefetchable bit for all backing memory
that the EPF core allocates for a 64-bit BAR.


Kind regards,
Niklas


Changes since V2:
-Addressed my own comments.
-Added additional clean up patches.


Niklas Cassel (9):
  PCI: endpoint: pci-epf-test: Fix incorrect loop increment
  PCI: endpoint: Allocate a 64-bit BAR if that is the only option
  PCI: endpoint: pci-epf-test: Remove superfluous code
  PCI: endpoint: pci-epf-test: Simplify pci_epf_test_alloc_space() loop
  PCI: endpoint: pci-epf-test: Simplify pci_epf_test_set_bar() loop
  PCI: endpoint: pci-epf-test: Clean up pci_epf_test_unbind()
  PCI: cadence: Set a 64-bit BAR if requested
  PCI: rockchip-ep: Set a 64-bit BAR if requested
  PCI: endpoint: Set prefetch when allocating memory for 64-bit BARs

 .../pci/controller/cadence/pcie-cadence-ep.c  |  5 +-
 drivers/pci/controller/pcie-rockchip-ep.c     |  2 +-
 drivers/pci/endpoint/functions/pci-epf-test.c | 67 +++++++------------
 drivers/pci/endpoint/pci-epf-core.c           | 10 ++-
 4 files changed, 33 insertions(+), 51 deletions(-)

-- 
2.44.0


