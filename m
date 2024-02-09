Return-Path: <linux-pci+bounces-3289-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5B184F8E4
	for <lists+linux-pci@lfdr.de>; Fri,  9 Feb 2024 16:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5766E1C20BF9
	for <lists+linux-pci@lfdr.de>; Fri,  9 Feb 2024 15:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23BD374E28;
	Fri,  9 Feb 2024 15:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bcJ7UIcw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E2273186;
	Fri,  9 Feb 2024 15:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707493911; cv=none; b=J54ODNm2JEM0AnFfjmu+V9+Txo7UwlQudqZGF0w/KbUfRWA/LiTb8KDc8ZBSZE+1WjXCEXlK0Jy6wk2MAFx506kh8dE1xkaGRcB5XhuM3DxFpkwYGqftzoTvT3HsXWJ+TJHLRVmLCRPh9K1p1K6Muzz/0u7whteDd9hxrIU/V44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707493911; c=relaxed/simple;
	bh=VYi7wNnGDrwLDkWKIlgehziEgPpnTMsmOXbHTBLjb3E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fhJWxIzfGEGg1qEJOT58LYxQDFujwmPlxLp7Y7QmZ4u0TSSFP7m4D16n5nK9zC9AzgNlYY+5JGJqyew7fZtCemxIgJCoa9o06GvxCU2JaGXZEHWgcjWrJ7TR7RA8SArGf1ohiW3GK2/j9uRM9usuThMsutWCfCJK5PkBJyGF9Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bcJ7UIcw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D9ECC433F1;
	Fri,  9 Feb 2024 15:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707493910;
	bh=VYi7wNnGDrwLDkWKIlgehziEgPpnTMsmOXbHTBLjb3E=;
	h=Date:From:To:Cc:Subject:From;
	b=bcJ7UIcwLZXLMpKo6GgqYe928EJAoD7nqBPSfAVEZWz71wK3taoBzGEHVkSLOp6dT
	 zO6qV27OfQP1h4hEMsczoi7EkQdTSlhhzkaXf0uooGw8veFBBIaeZl7lZjoImVT8bb
	 bYBpfovDnCCHxsWbRZZyVfVnjlHYzIoeySlTQCa7Udpw36Pdx3EY/FAv7u1UpwTS16
	 26sjyCECGOcJoPzDfMaBtk4URFdgYjXi0DNg7B3ZqcLUvQt84SIvdVUv2/EECyB1Sd
	 fx42y1A4UIe8Jl6YehPosDzer/PJdKL9NCzy84j03q3NoToLN9HUc4+bplzqO/CXKO
	 lzEokHLcKZemA==
Date: Fri, 9 Feb 2024 09:51:48 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [GIT PULL] PCI fixes for v6.8
Message-ID: <20240209155148.GA1001467@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.8-fixes-2

for you to fetch changes up to 67057f48df79a3d73683385f521215146861684b:

  PCI: dwc: Clean up dw_pcie_ep_raise_msi_irq() alignment (2024-02-07 13:10:00 -0600)

----------------------------------------------------------------
- Fix an unintentional truncation of DWC MSI-X address to 32 bits and
  update similar MSI code to match (Dan Carpenter)

----------------------------------------------------------------
Dan Carpenter (2):
      PCI: dwc: Fix a 64bit bug in dw_pcie_ep_raise_msix_irq()
      PCI: dwc: Clean up dw_pcie_ep_raise_msi_irq() alignment

 drivers/pci/controller/dwc/pcie-designware-ep.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

