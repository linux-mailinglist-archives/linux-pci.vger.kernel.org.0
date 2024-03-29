Return-Path: <linux-pci+bounces-5374-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F9F891568
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 10:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 302951F22367
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 09:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C819B2C6AA;
	Fri, 29 Mar 2024 09:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Veru5V0j"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A370239FC1
	for <linux-pci@vger.kernel.org>; Fri, 29 Mar 2024 09:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711703388; cv=none; b=Go+pr5pukD+0pSfDJCjHGKQyWx+A7fBqkaR7XSLvOsPEy5ogXPWKyXoalZ8Mj2ZHLbGrWrPHYLVoOzzCMLuJvDsDTKT6SyiS8fc6oYNNqBIrIE3mV903AqjL0ybCnZPI28fnz2U+YtDAWpNVC7mGyb6glDI5n/pamJiTtd24O3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711703388; c=relaxed/simple;
	bh=Dns6q7IizAxpZ6/WuC6UXLxjt1Ab4FRhj9skuvhtcic=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UzJZz8ylVQvukdrd99aqNr92zmoqLJkag9uUkLq8eV9sKzKTQMFIMSVt6BTm0rmerGoNxYXYdaA1hokN58XStaT674CPJRLqCIn+3HxwgzPxaCdVk3NOfj+DD/4Q5X1fPzC6gdN6FDUXnl3BvNvpJpPir4kV98P95QazKZkcmGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Veru5V0j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07566C433F1;
	Fri, 29 Mar 2024 09:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711703388;
	bh=Dns6q7IizAxpZ6/WuC6UXLxjt1Ab4FRhj9skuvhtcic=;
	h=From:To:Cc:Subject:Date:From;
	b=Veru5V0jW0B9aV4qODEM6vLN3soCI9Vs2g3Gaxwt4l7zuJcqOjKHrDfdil0lv0aiq
	 kn3v2M2GTxvzWo1/T5sNi+MMvamoSqEFtRnAOCINLltfftE8THGQRADmfQanGUIjjN
	 RVoOcqVpPFqWfM/bLAbLNMIYAVoDGxQUfTZznMod8pOTBHss8slIb2OLWkxprMzPPt
	 haP+Wviagu6j0Rj/rhXNWfWhY203vmFJfzE14bbVsTQl6FKKw1keBdZ+5JGhCEkU/l
	 gy5Bu5eDhw+T3+hCDzisMRWR4CjBa7yVUpzWmjwa6nEcp37bod3lCsQ6eRCIbKWS+D
	 WLr2zo8wJvscA==
From: Damien Le Moal <dlemoal@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-pci@vger.kernel.org
Cc: linux-rockchip@lists.infradead.org
Subject: [PATCH 00/19] Improve PCI memory mapping API
Date: Fri, 29 Mar 2024 18:09:26 +0900
Message-ID: <20240329090945.1097609-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series introduces the new functions pci_epc_map_align(),
pci_epc_mem_map() and pci_epc_mem_unmap() to improve handling of the
PCI address mapping alignment constraints of endpoint controllers in a
controller independent manner.

The issue fixed is that the fixed alignment defined by the "align" field
of struct pci_epc_features assumes that the alignment of the endpoint
memory used to map a RC PCI address range is independent of the PCI
address being mapped. But that is not the case for the rk3399 SoC
controller: in endpoint mode, this controller uses the lower bits of the
local endpoint memory address as the lower bits for the PCI addresses
for data transfers. That is, when mapping local memory, one must take
into account the number of bits of the RC PCI address that change from
the start address of the mapping.

To fix this, the new endpoint controller method .map_align is introduced
and called from pci_epc_map_align(). This method is optional and for
controllers that do not define it, the mapping information returned
is based of the fixed alignment constraint as defined by the align
feature.

The functions pci_epc_mem_map() is a helper function which obtains
mapping information, allocates endpoint controller memory according to
the mapping size obtained and maps the memory. pci_epc_mem_map() unmaps
and frees the endpoint memory.

This series is organized as follows:
 - Patch 1 and 2 tidy up the epc core code
 - Patch 3 and 4 introduces the new endpoint controller method and epc
   functions.
 - Patch 5 to 7 modify the test endpoint driver to use these new
   functions and improve the code of this driver.
 - Finally, Patch 8 to 19 fix the rk3399 endpoint driver, defining a
   .map_align method for it and improving its overall code readability
   and features.

Damien Le Moal (18):
  PCI: endpoint: Introduce pci_epc_check_func()
  PCI: endpoint: Improve pci_epc_mem_alloc_addr()
  PCI: endpoint: Introduce pci_epc_map_align()
  PCI: endpoint: Introduce pci_epc_mem_map()/unmap()
  PCI: endpoint: test: Use pci_epc_mem_map/unmap()
  PCI: endpoint: test: Synchronously cancel command handler work
  PCI: endpoint: test: Implement link_down event operation
  PCI: rockchip-ep: Fix address translation unit programming
  PCI: rockchip-ep: use macro to define EP controller .align feature
  PCI: rockchip-ep: Improve rockchip_pcie_ep_unmap_addr()
  PCI: rockchip-ep: Improve rockchip_pcie_ep_map_addr()
  PCI: rockchip-ep: Implement the map_info endpoint controller operation
  PCI: rockchip-ep: Refactor rockchip_pcie_ep_probe() memory allocations
  PCI: rockchip-ep: Refactor rockchip_pcie_ep_probe() MSIX hiding
  PCI: rockchip-ep: Refactor endpoint link training enable
  PCI: rockship-ep: Introduce rockchip_pcie_ep_stop()
  PCI: rockchip-ep: Improve link training
  PCI: rockchip-ep: Handle PERST signal in endpoint mode

Wilfred Mallawa (1):
  dt-bindings: pci: rockchip,rk3399-pcie-ep: Add ep-gpios property

 .../bindings/pci/rockchip,rk3399-pcie-ep.yaml |   3 +
 drivers/pci/controller/pcie-rockchip-ep.c     | 395 ++++++++++++++----
 drivers/pci/controller/pcie-rockchip.c        |  17 +-
 drivers/pci/controller/pcie-rockchip.h        |  22 +
 drivers/pci/endpoint/functions/pci-epf-test.c | 390 +++++++++--------
 drivers/pci/endpoint/pci-epc-core.c           | 212 +++++++---
 drivers/pci/endpoint/pci-epc-mem.c            |   9 +-
 include/linux/pci-epc.h                       |  39 ++
 8 files changed, 774 insertions(+), 313 deletions(-)

-- 
2.44.0


