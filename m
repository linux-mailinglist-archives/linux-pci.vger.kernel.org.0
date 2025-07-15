Return-Path: <linux-pci+bounces-32161-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5384DB06177
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 16:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73C155A653E
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 14:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9C62857F6;
	Tue, 15 Jul 2025 14:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mbb/bWM3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D82285419;
	Tue, 15 Jul 2025 14:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752589271; cv=none; b=XMIzd96xoBbaAhuKJBpev7/U2wa9C2+E5SBZPNIMUpkEXzro15YJidCLWPsWHrUaZKKHiwG264zQjlgSCG+DCpkpSp6moU4T/YsCuIRg3693B2gJ2tvhz8n5OKoyuY+rHohA8vyDpQwcGFeje2fJVCWrdrWLHZL2o8Ot2UFiAGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752589271; c=relaxed/simple;
	bh=zVWl88t69qvQmJNOvzdu2b/qBUVRE3wqytBfM1uLa58=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=W/6HGo2DUGAZTmUPjW6n2lyZxVKiZb8ioc5BOQuK6BO+qu/8a4fAlCePEw7n2exazj0POEheJl2Abo4KPJxQpskxtWG7RuwsIKXnS8LXMgOap6hADwyCNTC8GRxGI5AU3Wgh+ELui1YgfA35V6ZF22jF7NCWvzKNXQAFVC0Ri90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mbb/bWM3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DBCD9C4CEE3;
	Tue, 15 Jul 2025 14:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752589270;
	bh=zVWl88t69qvQmJNOvzdu2b/qBUVRE3wqytBfM1uLa58=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=mbb/bWM3x7efQzejnFD5YQ5YLOKKZ+Q95pR2aliWDujkBQJGREaovmDRQr6l0e2US
	 jzTYAdgl0Wi577UiVHBtqE9yZxB1bEtdFDBpjPpwBXeD0Rf2+/E6SZB8RAnKRDg2DP
	 P7H5bvY6mp0s9uezBWP7+EYhOfCAc6uS1UUghKlw/kDyjjWqoaAFXx9O6yb5yS4Bpe
	 SigNuWxO0hA+0dDlfXphv4+BWvZg3Vxh+MJQapPjx9TeoH5viQPOIKUSmbHDSsKOe5
	 Zb2V5dU61NENPF2fvmtiTfMMBJ/Bw+2/LfpZBdMzHpAnR8AVvjbJFiNoqz1AsI6g60
	 2OHBeYl0J1Eug==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D16F0C83F22;
	Tue, 15 Jul 2025 14:21:10 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Subject: [PATCH v6 0/4] PCI: Add support for resetting the Root Ports in a
 platform specific way
Date: Tue, 15 Jul 2025 19:51:03 +0530
Message-Id: <20250715-pci-port-reset-v6-0-6f9cce94e7bb@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANBjdmgC/3WMQQ6CQAxFr0K6tmQYKQgr72FYIFOliTA4RaIh3
 N2RvZufvJ+8t4JyEFaokxUCL6LixwjFIYGub8c7o7jIYI0lU2aEUyc4+TBjYOUZc1dRVlFpMnu
 EKE2Bb/Leg5cmci86+/DZ+wv93r+phdCgLVpytjy5a27OXjV9vtpH54chjQPNtm1fRDtzprMAA
 AA=
X-Change-ID: 20250715-pci-port-reset-4d9519570123
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
 Oliver O'Halloran <oohall@gmail.com>, Will Deacon <will@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
 linux-arm-msm@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 Niklas Cassel <cassel@kernel.org>, 
 Wilfred Mallawa <wilfred.mallawa@wdc.com>, 
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
 mani@kernel.org, Lukas Wunner <lukas@wunner.de>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
 Manivannan Sadhasivam <mani@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4632;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=zVWl88t69qvQmJNOvzdu2b/qBUVRE3wqytBfM1uLa58=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBodmPTpP68PeP7S5mOvihNYGZRu6k0UgqJY+bSa
 wL0Q1raTaCJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaHZj0wAKCRBVnxHm/pHO
 9VrVB/sEOpRz2jWfexpNikVYAvlqnyV+VsE/hzfg9+9mkMJYFMgNFPJsfEVbeY0aUttZ2LAVAww
 9MddGux+8kU7nT0VGLY7iSFSK3Fv4knmzzPko07sVZlkFLb8Dwd5TnO9Czmcfrw8/giROuJizsX
 HjOUGxsR0uVIAbYHKTJH7LBXf/cY9stFc5Mran7/fIDOJ3igthjnnYZsKA8tYd4ojiz+Ow/LtZ2
 P8IpC3GgQ6zeoYz0OCVBuyxtcBMlE+WW4y9g23+AgI6+f+3uvlw+wgS3sS7f4FywokyToEMABdq
 mFgDl2cPx3QBIOFhCdKVwia609sG4ESLZpX27ALw8Obj7gSv
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

Hi,

Currently, in the event of AER/DPC, PCI core will try to reset the slot (Root
Port) and its subordinate devices by invoking bridge control reset and FLR. But
in some cases like AER Fatal error, it might be necessary to reset the Root
Ports using the PCI host bridge drivers in a platform specific way (as indicated
by the TODO in the pcie_do_recovery() function in drivers/pci/pcie/err.c).
Otherwise, the PCI link won't be recovered successfully.

So this series adds a new callback 'pci_host_bridge::reset_root_port' for the
host bridge drivers to reset the Root Port when a fatal error happens.

Also, this series allows the host bridge drivers to handle PCI link down event
by resetting the Root Ports and recovering the bus. This is accomplished by the
help of the new 'pci_host_handle_link_down()' API. Host bridge drivers are
expected to call this API (preferrably from a threaded IRQ handler) with
relevant Root Port 'pci_dev' when a link down event is detected for the port.
The API will reuse the pcie_do_recovery() function to recover the link if AER
support is enabled, otherwise it will directly call the reset_root_port()
callback of the host bridge driver (if exists).

For reference, I've modified the pcie-qcom driver to call
pci_host_handle_link_down() API with Root Port 'pci_dev' after receiving the
LINK_DOWN global_irq event and populated 'pci_host_bridge::reset_root_port()'
callback to reset the Root Port. Since the Qcom PCIe controllers support only
a single Root Port (slot) per controller instance, the API is going to be
invoked only once. For multi Root Port controllers, the controller driver is
expected to detect the Root Port that received the link down event and call
the pci_host_handle_link_down() API with 'pci_dev' of that Root Port.

Testing
-------

I've lost access to my test setup now. So Krishna (Cced) will help with testing
on the Qcom platform and Wilfred or Niklas should be able to test it on Rockchip
platform. For the moment, this series is compile tested only.

Changes in v6:
- Incorporated the patch: https://lore.kernel.org/all/20250524185304.26698-2-manivannan.sadhasivam@linaro.org/
- Link to v5: https://lore.kernel.org/r/20250715-pci-port-reset-v5-0-26a5d278db40@oss.qualcomm.com

Changes in v5:
* Reworked the pci_host_handle_link_down() to accept Root Port instead of
  resetting all Root Ports in the event of link down.
* Renamed 'reset_slot' to 'reset_root_port' to avoid confusion as both terms
  were used interchangibly and the series is intended to reset Root Port only.
* Added the Rockchip driver change to this series.
* Dropped the applied patches and review/tested tags due to rework.
* Rebased on top of v6.16-rc1.

Changes in v4:
- Handled link down first in the irq handler
- Updated ICC & OPP bandwidth after link up in reset_slot() callback
- Link to v3: https://lore.kernel.org/r/20250417-pcie-reset-slot-v3-0-59a10811c962@linaro.org

Changes in v3:
- Made the pci-host-common driver as a common library for host controller
  drivers
- Moved the reset slot code to pci-host-common library
- Link to v2: https://lore.kernel.org/r/20250416-pcie-reset-slot-v2-0-efe76b278c10@linaro.org

Changes in v2:
- Moved calling reset_slot() callback from pcie_do_recovery() to pcibios_reset_secondary_bus()
- Link to v1: https://lore.kernel.org/r/20250404-pcie-reset-slot-v1-0-98952918bf90@linaro.org

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
Manivannan Sadhasivam (3):
      PCI/ERR: Add support for resetting the Root Ports in a platform specific way
      PCI: host-common: Add link down handling for Root Ports
      PCI: qcom: Add support for resetting the Root Port due to link down event

Wilfred Mallawa (1):
      PCI: dw-rockchip: Add support to reset Root Port upon link down event

 drivers/pci/controller/dwc/Kconfig            |   2 +
 drivers/pci/controller/dwc/pcie-dw-rockchip.c |  91 ++++++++++++++++++-
 drivers/pci/controller/dwc/pcie-qcom.c        | 120 ++++++++++++++++++++++++--
 drivers/pci/controller/pci-host-common.c      |  33 +++++++
 drivers/pci/controller/pci-host-common.h      |   1 +
 drivers/pci/pci.c                             |  21 +++++
 drivers/pci/pcie/err.c                        |   6 +-
 include/linux/pci.h                           |   1 +
 8 files changed, 260 insertions(+), 15 deletions(-)
---
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
change-id: 20250715-pci-port-reset-4d9519570123

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>



