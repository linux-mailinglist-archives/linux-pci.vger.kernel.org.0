Return-Path: <linux-pci+bounces-19591-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87962A070D9
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jan 2025 10:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 856A3161BB1
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jan 2025 09:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275FB2010FD;
	Thu,  9 Jan 2025 09:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rTDqH0AH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9157214A70
	for <linux-pci@vger.kernel.org>; Thu,  9 Jan 2025 09:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736413631; cv=none; b=UI/QYN7xsT3QYvamdDorhYv/zYmOu1Mtxgn17kip2wzkQ/RuXVKqXK/FlCKctponJMe8dz1a2Ql49Io6Z8vdUxvl0vfIBfPEaNOyAHARS6x0L/DSSQZtvQSfH2iMxooujiiIwDA5lFlqyGp7mNk9idVltEA23JtI/n94uhriuSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736413631; c=relaxed/simple;
	bh=6KlrG7UfxSvJaPknWB0rSoQau5l3FVtxo3MXEwgzCUE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bUjXAhCIKk7uUnFdgErlUV1LwDV73liux7XTLJsRX7vRLlAiwHskdefvI1XAK6PqNhljidROi1GzusvZD7HNvJZK2tfBsQ/S8AJ5hvbiNSgDt2AcuS2tPIx9hI4CU5cbaSxF+dMvIGJazLUfRgthECbOmMveBumeravT4AYJLVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rTDqH0AH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B31CDC4CED2;
	Thu,  9 Jan 2025 09:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736413630;
	bh=6KlrG7UfxSvJaPknWB0rSoQau5l3FVtxo3MXEwgzCUE=;
	h=From:To:Cc:Subject:Date:From;
	b=rTDqH0AHJ6nvoW+VFen417Pt0QdHWMJKtH/3GbENGtF1YnfNr21m63oE82LyJFKyB
	 9Wv+IUH8j+y3h/EW+g7rbgXlD6L4lBj+Qfcrybeaivm8AkvHlgnzipn48QwTNX/uou
	 jRPNhpkzWipvTz0E17r1VAwS9HwN/jAD+DnArnt+bbH/w7ryJUk2YRj2VTxdtFcqEA
	 nrjkLfxPPs/NI1VehquHkbYo6aV4FqxmtLUDPDMPtaGEYqqb225YaH+qAR1SWgztLp
	 5PRdw8Z+6gK7d/sGodEs7QKm2YZ9F65tnsYEYmx1H1fLxUoChAq2h5e4+GolToi2r9
	 1Q8Hf70hQ4eDw==
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
Subject: [PATCH v2 0/6] PCI: endpoint: Add support for resizable BARs
Date: Thu,  9 Jan 2025 10:06:52 +0100
Message-ID: <20250109090652.110905-8-cassel@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2645; i=cassel@kernel.org; h=from:subject; bh=6KlrG7UfxSvJaPknWB0rSoQau5l3FVtxo3MXEwgzCUE=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNLrJ65RSb/AZanz+7n7qnvJ8btNVvKedXny6KGVRuqeN 3a7Hzz831HKwiDGxSArpsji+8Nlf3G3+5TjindsYOawMoEMYeDiFICJXHJl+Cu+UtuJ3Usif/4K pWvfsquab/QlPV/h79s55Z9l5gG7ZUIM/4tajh9dLf5mu+YqsZ83XlQ1cR0X8fdR1EkVXRWspFo wiwsA
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


Changes since V1:
-Fix Wtautological-constant-out-of-range-compare compiler warning on
 32-bit builds.


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


