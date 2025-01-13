Return-Path: <linux-pci+bounces-19655-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA59A0B48C
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jan 2025 11:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F386116198C
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jan 2025 10:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724053C1F;
	Mon, 13 Jan 2025 10:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rK9dGLgj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9C0235C07
	for <linux-pci@vger.kernel.org>; Mon, 13 Jan 2025 10:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736764073; cv=none; b=piSeMhlfi3Kkybo64D0CsyzjPoyMF/7sjvhIGMXXaLoKCxdP5J7wQDAhRaZCO88dSJ8G7QDu4P7hDyvDNdeoMBqecZvcV7iGuCvpGtB7mY0LlxLEHgqHOQkjz24tkTa80NPIElHNJnfm0vlhjEpFxH/aNADHfVQAdUcfxpOUGMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736764073; c=relaxed/simple;
	bh=CjA961n7thifjHeeT8f/0KEw4480OgyCf9lH69QrF2g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VkZLcxxZ5HCTCPxAmcG7/mVi7QoDKG5F2S26k+ok0GqqGnYE0PcF+OY8H4jcYhGL3LJH1UGPna2ckjsxLMSc9bqZsB/4Eg602Iw/gUPHastqFn+I/O9Jb3SqSX9wvLtdioht601SSwJBJGNK4w3CvDGxhC1217/4dTJI02FfjaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rK9dGLgj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A71FAC4CED6;
	Mon, 13 Jan 2025 10:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736764072;
	bh=CjA961n7thifjHeeT8f/0KEw4480OgyCf9lH69QrF2g=;
	h=From:To:Cc:Subject:Date:From;
	b=rK9dGLgjxIhZoQjmEAH0qqcYwp32TnsmUlNd9pyx07TeJP+YcdOuUa4GBpaQJa5WZ
	 iHMSRwa7z6JuyjxWWwV6brWGrUHECfsEz5T3u2HhyEcQeB6UJZ0V3tENdBBgESs4ws
	 zZuHDNAZDiaoN1bODQaSXayxOvc3TF8d9rGsLm3u5uSeKCd6XrXO4D1pamNistJFi1
	 dQ66yON6Q2WPq+F83dkOXgCv+6NA4jRHndyH0c9daBMAkPeEIqjd3Kgs/J/YJtE/8j
	 369sx6zkzlfDJ7gQ0c3s76hBeDhDfCrhsmIjhDOA/y6O+8PAZlkUVhn3WPXJgzadmd
	 pZ288373NH6pA==
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
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Udit Kumar <u-kumar1@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH v3 0/6] PCI: endpoint: Add support for resizable BARs
Date: Mon, 13 Jan 2025 11:27:31 +0100
Message-ID: <20250113102730.1700963-8-cassel@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2889; i=cassel@kernel.org; h=from:subject; bh=CjA961n7thifjHeeT8f/0KEw4480OgyCf9lH69QrF2g=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNJbXk0+Ep3juWN+dJYl42fB+5+Ed0UbXVI8FVks0py10 PvSNq6VHaUsDGJcDLJiiiy+P1z2F3e7TzmueMcGZg4rE8gQBi5OAZhI3GdGhomOS2N4b1/O/1al f1AwNvBz5t32R9/mXTDf9jTK73h03CuG/9GhmQ+tbqydJZZx2caXefaHjck3L2zj31OrISC2zYl ZlgEA
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


Texas Instruments kernel developers, if would be very nice if you could
help out with testing on Keystone.


Changes since V2:
-When looping in dw_pcie_ep_init_non_sticky_registers(), use the index
 that we read from PCI_REBAR_CTRL (e.g. a platform could have BARs 0-2
 as programmable, and BARs 3-5 resizable, so we need to read the index).


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
 .../pci/controller/dwc/pcie-designware-ep.c   | 231 +++++++++++++++---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c |  22 +-
 drivers/pci/endpoint/pci-epf-core.c           |   4 +
 include/linux/pci-epc.h                       |   3 +
 5 files changed, 219 insertions(+), 47 deletions(-)

-- 
2.47.1


