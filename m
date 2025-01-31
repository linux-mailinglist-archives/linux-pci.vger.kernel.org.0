Return-Path: <linux-pci+bounces-20602-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9DFA24295
	for <lists+linux-pci@lfdr.de>; Fri, 31 Jan 2025 19:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 672753A8785
	for <lists+linux-pci@lfdr.de>; Fri, 31 Jan 2025 18:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79C91F1512;
	Fri, 31 Jan 2025 18:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dJEZSktz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9301F381B9
	for <linux-pci@vger.kernel.org>; Fri, 31 Jan 2025 18:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738348218; cv=none; b=mw0HdanJRkKiJDE/NSPQ9/f9tMMcsVVrDjWeabRsQp2FBLEigzNQvGrUjYGMuRqfK5o9L/rtkkcJQVPRmbz7bkBRe5yjArLJEslbqcalK7OaYseb2VsvjhAvV6qmFYw3iZOli941Dyni9taFB+D0VFl+uAk9WNe2qELLv/3399Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738348218; c=relaxed/simple;
	bh=x1/ZVTQMmRVVIFw2D8Gr10vnmzAC84NLSgrZVeSMY4k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aJqW6VgP7N+AT30wOmJUH7Q47Wh+PJAOw1J6F45ZdC2DWEl8a6F46T5GcTs3+njw4z5HcmEBd1LGQgQS1gjlJEJRq8lAEyZzowRKkWCV7F62LWe+aqf62FD19fz3zSWw2audvP9dBt4jN8+dbHB7AB2vDg20leS+1ksVXRKPU2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dJEZSktz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC2D3C4CED3;
	Fri, 31 Jan 2025 18:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738348218;
	bh=x1/ZVTQMmRVVIFw2D8Gr10vnmzAC84NLSgrZVeSMY4k=;
	h=From:To:Cc:Subject:Date:From;
	b=dJEZSktz5FLTnjBKggCmDQ+cF20eNIvEicD8Qri2LrNwp1nBYz62AcoRip0qmZEUv
	 g4mluErZ0wUSKrq328HmKOzJG4an0GZrkkSo2Kcs8iYlU+qwBUVM9niRd0FaDBp1Bf
	 LNA8ci6vkIgu+RNXdak7ofjwTdwwe50KfVWw+AqxQgy40Gon9VsLqPhqK1nwvPGRec
	 /TqOOnzceSs7rPhgY2NhdYLVAxy93nCLISjUcckTgQwal1gjDS9Ch55US3u6Ugsdof
	 LtMNkvRR0G8xrRVtOi9fBszxeeEFeV+TlamXqIxMZAFCmlx4gRC4hoC0TpwQVBE3ZD
	 njMF+arfTIrng==
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
Subject: [PATCH v4 0/7] PCI: endpoint: Allow EPF drivers to configure the size of Resizable BARs
Date: Fri, 31 Jan 2025 19:29:49 +0100
Message-ID: <20250131182949.465530-9-cassel@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2780; i=cassel@kernel.org; h=from:subject; bh=x1/ZVTQMmRVVIFw2D8Gr10vnmzAC84NLSgrZVeSMY4k=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNLnis29v4317lKnK6de7N60dwaL4S0GWwuuaFPRWyVZV 51XdRnf6ChlYRDjYpAVU2Tx/eGyv7jbfcpxxTs2MHNYmUCGMHBxCsBEDu1k+Gcn8CNCyEhi58+e lFfb/0TKPDbQf1fpI7OSY/rywBalD84M/6sFGDnLJp+MWd926feOuZyZU6RvNZhvYmHadH/aHYv zT3kB
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


Changes since V3:
-Picked up tags.
-Addressed comments from Mani.


Kind regards,
Niklas

Niklas Cassel (7):
  PCI: endpoint: Allow EPF drivers to configure the size of Resizable
    BARs
  PCI: endpoint: Add pci_epc_bar_size_to_rebar_cap()
  PCI: dwc: ep: Move dw_pcie_ep_find_ext_capability()
  PCI: dwc: endpoint: Allow EPF drivers to configure the size of
    Resizable BARs
  PCI: keystone: Describe Resizable BARs as Resizable BARs
  PCI: keystone: Specify correct alignment requirement
  PCI: dw-rockchip: Describe Resizable BARs as Resizable BARs

 drivers/pci/controller/dwc/pci-keystone.c     |   6 +-
 .../pci/controller/dwc/pcie-designware-ep.c   | 218 +++++++++++++++---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c |  22 +-
 drivers/pci/endpoint/pci-epc-core.c           |  31 +++
 drivers/pci/endpoint/pci-epf-core.c           |   4 +
 include/linux/pci-epc.h                       |   5 +
 6 files changed, 239 insertions(+), 47 deletions(-)

-- 
2.48.1


