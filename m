Return-Path: <linux-pci+bounces-13910-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5F7992362
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 06:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E5491F22779
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 04:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0DA27442;
	Mon,  7 Oct 2024 04:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJzb3hlL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0C73C2F;
	Mon,  7 Oct 2024 04:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728274342; cv=none; b=C0sF0SAhp19PG/alED/gIGPRNwVcK28/oxzuuZrd66ed7qTVYd6N8QMRd+5hB1WTX49qdZvy81Hw0yWvjgdrX8tG+ZYaI6NeKOXHX/aG4jQ5B+xRh5Ni7ib1bDgBP7sxCh7NlTZNzjOODhXNDnszSLFpax6HCFWTqSdQet+YGi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728274342; c=relaxed/simple;
	bh=pBd4mpQbBt2uBbtEczYEejdQ6FSxmXUytAe+feLiGd8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qR1yGqqthxvMIPN2+k9mxm9yRD36DKSV0tWtt77GP2VQe+yxC5BFoTWxtULXtKzc/WQc4ZQB1fqqh5aZ43Zq5X+S9fbqJqp3kjMZetsqSYk8R54heNx0JE4ofsAWBqvFxgk3WF+o5SDwqTnUaSJTkcit+GZXYyIF5oODSzHdQVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gJzb3hlL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDCC2C4CEC6;
	Mon,  7 Oct 2024 04:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728274342;
	bh=pBd4mpQbBt2uBbtEczYEejdQ6FSxmXUytAe+feLiGd8=;
	h=From:To:Cc:Subject:Date:From;
	b=gJzb3hlLIGeNwg2h5HQYF02ldUMLXclzAE+Y4MITxeM/pPn8bRL3cvs0csIHhnVtm
	 sR+NvRGwHIabPnsPiW0rWCzwtb3qxChjHWciLiokc7Ocjt7MwoKtENUugCVluNKp29
	 /abhzrx+IFGUJXEKWigGqBI56ugP70nD/Ke79PtZ0zTIptxwkLGfbDZ8tlWZuEkbO+
	 eMBWKI+V0OCV2Puhaa/u0vzJ6BLVIjJamCI3G7dx5zaJIsIG4g1/fX1oxEVpFjRaF0
	 jVwhM+AF6uf6NmyM+Ei4q0kd8PsXw2LCIULfw8FAHte+NUBdvuWuJLewVk+scb0R/u
	 uRG1C1syfYtgA==
From: Damien Le Moal <dlemoal@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-pci@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org
Cc: linux-rockchip@lists.infradead.org,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v3 00/12] 
Date: Mon,  7 Oct 2024 13:12:06 +0900
Message-ID: <20241007041218.157516-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series is the second part of the former version 2 of the
patch series "Improve PCI memory mapping API". This second part is split
out as it deals solely with the rockchip/rk3399 PCI endpoint controller
driver.

This series is organized as follows:
 - Patch 1 fixes the rockchip ATU programming
 - Patch 2, 3 and 4 introduce small code improvments
 - Patch 5 implements the .map_align() operation to make the rk3399
   endpoint controller driver fully functional
 - Patch 6, 7 and 8 refactor the driver code to make it more readable
 - Patch 9 introduces the .stop() endpoint controller operation to
   correctly disable the endpopint controller after use
 - Patch 10 improves link training
 - Patch 11 and 12 implement handling of the #PERST signal

Changes from v2:
 - Split the patch series
 - Corrected patch 11 to add the missing "maxItem"

Changes from v1:
 - Changed pci_epc_check_func() to pci_epc_function_is_valid() in patch
   1.
 - Removed patch "PCI: endpoint: Improve pci_epc_mem_alloc_addr()"
   (former patch 2 of v1)
 - Various typos cleanups all over. Also fixed some blank space
   indentation.
 - Added review tags

Damien Le Moal (11):
  PCI: rockchip-ep: Fix address translation unit programming
  PCI: rockchip-ep: Use a macro to define EP controller .align feature
  PCI: rockchip-ep: Improve rockchip_pcie_ep_unmap_addr()
  PCI: rockchip-ep: Improve rockchip_pcie_ep_map_addr()
  PCI: rockchip-ep: Implement the .map_align() controller operation
  PCI: rockchip-ep: Refactor rockchip_pcie_ep_probe() memory allocations
  PCI: rockchip-ep: Refactor rockchip_pcie_ep_probe() MSI-X hiding
  PCI: rockchip-ep: Refactor endpoint link training enable
  PCI: rockship-ep: Introduce rockchip_pcie_ep_stop()
  PCI: rockchip-ep: Improve link training
  PCI: rockchip-ep: Handle PERST# signal in endpoint mode

Wilfred Mallawa (1):
  dt-bindings: pci: rockchip,rk3399-pcie-ep: Add ep-gpios property

 .../bindings/pci/rockchip,rk3399-pcie-ep.yaml |   4 +
 drivers/pci/controller/pcie-rockchip-ep.c     | 392 +++++++++++++++---
 drivers/pci/controller/pcie-rockchip.c        |  17 +-
 drivers/pci/controller/pcie-rockchip.h        |  22 +
 4 files changed, 358 insertions(+), 77 deletions(-)

-- 
2.46.2


