Return-Path: <linux-pci+bounces-19453-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4735FA0490A
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 19:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABBC93A5F58
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 18:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E761F2C35;
	Tue,  7 Jan 2025 18:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R/oRDHZ1"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48FA1EF09E
	for <linux-pci@vger.kernel.org>; Tue,  7 Jan 2025 18:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736273726; cv=none; b=P3eY6Yh+QBV8+Oik9UDCZ0dBb4uGp2DRGhvGJSFytKGNuwbbkzl73DZrg4P0tBBI7WBreRHBKeEonUuv17w0WPCoU0hjp3YQyHh82oEJbPhzLV8C8v8QEoEuH6iF/RT/Xfa0dhvehP4toxuhgKkDmbblfJj2R+OmVBetEzqezOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736273726; c=relaxed/simple;
	bh=HBHcmiYhdV1i4DCHsk2yrqZrt9sMvcGZpjOw1kIPmYg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kWsg+HKhkbaTJ1tj9yNPH2PA8n3QMo2+NLW+1cjCep3QH3xgfIeAFvkcwQBgbUns/FpDO0QI9Clr58/T872mWpBZgnl4nOsnNi8cOKmd2nLDn8x1sWR7jSRGdBxX7vh3BWb9+UXdsyzbI54Dok06oQUN4VITMok6Qc4Vi/+Q7LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R/oRDHZ1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F558C4CED6;
	Tue,  7 Jan 2025 18:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736273725;
	bh=HBHcmiYhdV1i4DCHsk2yrqZrt9sMvcGZpjOw1kIPmYg=;
	h=From:To:Cc:Subject:Date:From;
	b=R/oRDHZ1ZZT+orMFLLX76WpaXpgt3NZL1kwo0oQrmKl83504ib50B/6/n5QXTpONS
	 WrPp78wn2KU6NSs1TMbZ8Z581qkDl02ZY1u3xeVkw46pGmecYpZhHVHD2k3pfjL1KJ
	 h813PUx+WE8/pfnDPn4bwwudKiph4OTr4eVRWRLEXQg8HHOo5bO52TA1ttuMBZjhSR
	 n3xm4g15xorFkAubYAkc92O+n4xTViWPaEYDsKwT8X+BhQiqAUj8PES/AYIIwa2KAa
	 uFYfwLIwkIlry1mHWdzdjiU1ERjfB2VOEgxB+vFywuZcP8v/UkyabQWaweGDlsDD05
	 bwHrtO2bymmZA==
From: Niklas Cassel <cassel@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH 0/6] PCI: endpoint: Add support for resizable BARs
Date: Tue,  7 Jan 2025 19:14:50 +0100
Message-ID: <20250107181450.3182430-8-cassel@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2535; i=cassel@kernel.org; h=from:subject; bh=HBHcmiYhdV1i4DCHsk2yrqZrt9sMvcGZpjOw1kIPmYg=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNJr86XkFW1NSuLvlzoyr1h2c96f+yqlrpfTfF2OztFYP 812JcO5jlIWBjEuBlkxRRbfHy77i7vdpxxXvGMDM4eVCWQIAxenAEzk325GhuMOr+Xer/iTvb9l Xvomy68+6YaMl//N4DK+4r1ynsUsLm+Gv9JG7xbfFLzUtNOUee1vx1nr4qqqD2l8Efswa8dG1dg Dh9gB
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

The PCI endpoint framework currently does not support resizable BARs.

Add a new BAR type BAR_RESIZABLE, so that EPC drivers can support resizable
BARs properly.

For a resizable BAR, we will only allow a single supported size.
This is by design, as we do not need/want the complexity of the host side
resizing our resizable BAR.

In the DWC driver specifically, the DWC driver currently handles resizable
BARs using an ugly hack where a resizable BAR is force set to a fixed size
BAR with 1 MB size if detected. This is bogus, as a resizable BAR can be
configured to sizes other than 1 MB.

With these changes, an EPF driver will be able to call pci_epc_set_bar()
to configure a resizable BAR to an arbitrary size, just like for
BAR_PROGRAMMABLE. Thus, DWC based EPF drivers will no longer be forced to
a bogus 1 MB forced size for resizable BARs.


Tested/verified on a Radxa Rock 5b (rk3588) by:
-Modifying pci-epf-test.c to request BAR sizes that are larger than 1 MB:
 -static size_t bar_size[] = { 512, 512, 1024, 16384, 131072, 1048576 };
 +static size_t bar_size[] = { SZ_1M, SZ_1M, SZ_2M, SZ_2M, SZ_4M, SZ_4M };
 (Make sure to set CONFIG_CMA_ALIGNMENT=10 such that dma_alloc_coherent()
  calls are aligned even for allocations larger than 1 MB.)
-Rebooting the host to make sure that the DWC EP driver configures the BARs
 correctly after receiving a link down event.
-Modifying EPC features to configure a BAR as 64-bit, to make sure that we
 handle 64-bit BARs correctly.
-Modifying the DWC EP driver to set a size larger than 2 GB, to make sure
 we handle BAR sizes larger than 2 GB (for 64-bit BARs) correctly.
-Running the consecutive BAR test in pci_endpoint_test.c to make sure that
 the address translation works correctly.


Kind regards,
Niklas

Niklas Cassel (6):
  PCI: endpoint: Add BAR type BAR_RESIZABLE
  PCI: dwc: ep: Move dw_pcie_ep_find_ext_capability()
  PCI: dwc: endpoint: Add support for BAR type BAR_RESIZABLE
  PCI: keystone: Describe resizable BARs as resizable BARs
  PCI: keystone: Specify correct alignment requirement
  PCI: dw-rockchip: Describe resizable BARs as resizable BARs

 drivers/pci/controller/dwc/pci-keystone.c     |   6 +-
 .../pci/controller/dwc/pcie-designware-ep.c   | 228 +++++++++++++++---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c |  22 +-
 drivers/pci/endpoint/pci-epf-core.c           |   4 +
 include/linux/pci-epc.h                       |   3 +
 5 files changed, 216 insertions(+), 47 deletions(-)

-- 
2.47.1


