Return-Path: <linux-pci+bounces-14293-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2D699A38A
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 14:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E3641C217C6
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 12:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D974216450;
	Fri, 11 Oct 2024 12:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IG2E0WoE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA45921500F;
	Fri, 11 Oct 2024 12:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728648851; cv=none; b=Kj8OUk9+SPFERum3F6OeWDFBZVO/uxgqqxTf5DoZWswF7f0bEttDyHP80S61f8rxE1xe1UWHZ9xIWPa6G5gdVPVqcuUkJFaE5iPog9lYVyeSPThcQqYNoP49nvCars3JkichfYCAxx+YMApzB+iATi40dPikYuUbIlhOS8LWUbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728648851; c=relaxed/simple;
	bh=kd54sH6YhOnXIo+Km/qLp2CNCHxAoohftut1wYnFYkA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QrR00KhGO7pIZqiOBOAfIwUGUC3v6qsyx9zBuMhkMRkTO0lxKjbKgXpgV2DlFTOdZM/KMHbFHxord071GZOETloukWow13YVw+xiWtrQLRhNvqcL72akufzpFgsT0BiWvrR9gsEyLn33T5FIbBMixPb0ju/17PNqPqzjwjoOOaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IG2E0WoE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77999C4CEC3;
	Fri, 11 Oct 2024 12:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728648851;
	bh=kd54sH6YhOnXIo+Km/qLp2CNCHxAoohftut1wYnFYkA=;
	h=From:To:Cc:Subject:Date:From;
	b=IG2E0WoEvJqxcUAcVv7v+asTeHVwM4c49eBztyYcm3w0sc4waRiB1fPn5c/1VbENl
	 aUC2UzQ8g8A2YYQSrpRYyizf9JG0QUFjEteTADfPS7dZ7NviEG/jUaUB8Htr2aVy5z
	 KPPGT9N1ZtoqiEjYkxs9+c97rcgFu7EwlXHmwpk0cfPnfNcv1FOnt5brbdAEHsyLNU
	 Kkwf80MESHV4GgRsHgDZwcNUnqcO/+tfqPU0qO9vVb7E/0t6OF/i3DwMNqwN+Eknl6
	 XTV+0zvUVmyfOMuUhwStPxPl6snRszjjqoZKYBVbl/7Iq/2wkWp1Aw8SMj3eqQ78pK
	 f/x2ukcFEMAvQ==
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
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v4 00/12] Fix and improve the Rockchip endpoint driver
Date: Fri, 11 Oct 2024 21:13:56 +0900
Message-ID: <20241011121408.89890-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series fix the PCI address mapping handling of the Rockchip
endpoint driver, refactor some of its code, improves link training and
adds handling of the #PERST signal.

This series is organized as follows:
 - Patch 1 fixes the rockchip ATU programming
 - Patch 2, 3 and 4 introduce small code improvments
 - Patch 5 implements the .get_mem_map() operation to make the RK3399
   endpoint controller driver fully functional with the new
   pci_epc_mem_map() function
 - Patch 6, 7, 8 and 9 refactor the driver code to make it more readable
 - Patch 10 introduces the .stop() endpoint controller operation to
   correctly disable the endpopint controller after use
 - Patch 11 improves link training
 - Patch 12 implements handling of the #PERST signal

This patch series depends on the PCI endpoint core patches from the
V5 series "Improve PCI memory mapping API". The patches were tested
using a Pine Rockpro64 board used as an endpoint with the test endpoint
function driver and a prototype nvme endpoint function driver.

Changes from v3:
 - Addressed Mani's comments (see mailing list for details).
 - Removed old patch 11 (dt-binding changes) and instead use in patch 12
   the already defined reset_gpios property.
 - Added patch 6
 - Added review tags

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

Damien Le Moal (12):
  PCI: rockchip-ep: Fix address translation unit programming
  PCI: rockchip-ep: Use a macro to define EP controller .align feature
  PCI: rockchip-ep: Improve rockchip_pcie_ep_unmap_addr()
  PCI: rockchip-ep: Improve rockchip_pcie_ep_map_addr()
  PCI: rockchip-ep: Implement the pci_epc_ops::get_mem_map() operation
  PCI: rockchip-ep: Rename rockchip_pcie_parse_ep_dt()
  PCI: rockchip-ep: Refactor rockchip_pcie_ep_probe() memory allocations
  PCI: rockchip-ep: Refactor rockchip_pcie_ep_probe() MSI-X hiding
  PCI: rockchip-ep: Refactor endpoint link training enable
  PCI: rockship-ep: Implement the pci_epc_ops::stop_link() operation
  PCI: rockchip-ep: Improve link training
  PCI: rockchip-ep: Handle PERST# signal in endpoint mode

 drivers/pci/controller/pcie-rockchip-ep.c   | 408 ++++++++++++++++----
 drivers/pci/controller/pcie-rockchip-host.c |   4 +-
 drivers/pci/controller/pcie-rockchip.c      |  21 +-
 drivers/pci/controller/pcie-rockchip.h      |  24 +-
 4 files changed, 370 insertions(+), 87 deletions(-)

-- 
2.47.0


