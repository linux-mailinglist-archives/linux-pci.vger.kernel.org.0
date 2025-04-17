Return-Path: <linux-pci+bounces-26130-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 233FCA923B0
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 19:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3371716B53D
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 17:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F84D2550B0;
	Thu, 17 Apr 2025 17:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJUH06Sv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6463619DF9A;
	Thu, 17 Apr 2025 17:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744910197; cv=none; b=fKI0gQONF3M3b/3dlcAX4R5xnaJ7VfcLJBs7SQiiCN9HwODAWZZHPm5YegPOlzqxyHD9MB5IiSU6GZEaLNVp9aWCLUrMYZE/pIf9DEprz1DryUAcXt4ZHVZIK6foDjfSRvmzgWyQpYU9wV6ODgR6jFORIvC/riVoocO0jRxbB6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744910197; c=relaxed/simple;
	bh=PvCdeV/T71+XdJMLiE0kUIteJDGjHav14JPcDUzEWbk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NfR+7pFe6C/DEGDdRoTucByMy6DxLvVwUCk4k5avQHl9W8m4SSvtJLfxmqE/L6+FVc1KmS92T6T9ebjgFA40nfqsONt7gYqLB83mFj+BQN2+JSg2WwqRgc+12A8Kkc7vrxQq/nrdSeXTYl3J/IPgGiEKCd3DCv3KGcfEpkKkfEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WJUH06Sv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D8B20C4CEE4;
	Thu, 17 Apr 2025 17:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744910196;
	bh=PvCdeV/T71+XdJMLiE0kUIteJDGjHav14JPcDUzEWbk=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=WJUH06SvY8Ksr0nzZ7DCUDo5Di7SQoeF6dFkQW3NemsP8cvNAqoOA2s91iIo/YvyP
	 k8PRMNjQcOKH/9qx1cGBSCmXEy1AkfKAbY9p/1EFc6OibXdq3cS8C1N4jR0U22F9B7
	 W0Mq3sdRJb3z+Ug37awsk8cybqi79w5JHv/3aZx3JoDqMr61t0D6KO0Wj564qRrpb8
	 d6MynBi239RebUcYGwk4k5O8IYV9nKdcGVEFQV4eSqmexy4cCSx1u9MLtbSnyQjjQa
	 cAzceTCkgC5T+uLRuBJ/nqlefijOwNmjG2C/HENazcMKuxN0vsjHcJ/4VWqsqsOw/4
	 3XVhPEI7Vg37g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4343C369C9;
	Thu, 17 Apr 2025 17:16:36 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Subject: [PATCH v3 0/5] PCI: Add support for resetting the slots in a
 platform specific way
Date: Thu, 17 Apr 2025 22:46:26 +0530
Message-Id: <20250417-pcie-reset-slot-v3-0-59a10811c962@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGo3AWgC/3XNzQrDIAzA8VcpnudQ+2Hdae8xdrAutoFSSyyyU
 frusz1tjB3/IfllZREIIbJLsTKChBHDlKM8FcwNduqB4yM3U0LVohIVnx0CJ4iw8DiGhetSdN5
 qafMGy1czgcfnId7uuQeMS6DX8SDJffrfSpILblpTKyPbzhtxHXGyFM6BerZjSX0AsvkFVAbAg
 246pVsnv4Ft2977FJM68AAAAA==
X-Change-ID: 20250404-pcie-reset-slot-730bfa71a202
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
 Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Zhou Wang <wangzhou1@hisilicon.com>, 
 Will Deacon <will@kernel.org>, Robert Richter <rric@kernel.org>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Marc Zyngier <maz@kernel.org>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Daire McNamara <daire.mcnamara@microchip.com>
Cc: dingwei@marvell.com, cassel@kernel.org, Lukas Wunner <lukas@wunner.de>, 
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4498;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=PvCdeV/T71+XdJMLiE0kUIteJDGjHav14JPcDUzEWbk=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBoATdtxd9VXuCzJQXALX9GONRBJRZvlq1rHHO2E
 vixk5tx8BOJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaAE3bQAKCRBVnxHm/pHO
 9SGZB/9wO83g2WQiJXUe+pmJAGWUVZyOgslNdIVc+RJ1hJtslE2h7Sab5a93Ifm+nv6wpK569OR
 i1gjAn8JYIjUYRKqe549owUx0d61b6uUI9aqgk5KorUfpMWpCuCwZlALyUoR58nsedoG1u105el
 9BQX6K3r57OIC5YGIdFwZu+126TXcX02ygDt7e+aG1XmFJRjKOD3ir8NJRHge2Lweh1AkFMZ+by
 ApXkVlkdI1rqHa9ZDPwn/4UTjM2scyba3TkffP72FPsDzVQd7lhe65j6UpqS7AsaDkpkDAim/3z
 zqhI1xMxVGFaNU4cJ0tX3GrjjkOBQ8njtMdysDf6f6fkzXyf
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@linaro.org/default with auth_id=185
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reply-To: manivannan.sadhasivam@linaro.org

Hi,

Currently, in the event of AER/DPC, PCI core will try to reset the slot and its
subordinate devices by invoking bridge control reset and FLR. But in some
cases like AER Fatal error, it might be necessary to reset the slots using the
PCI host bridge drivers in a platform specific way (as indicated by the TODO in
the pcie_do_recovery() function in drivers/pci/pcie/err.c). Otherwise, the PCI
link won't be recovered successfully.

So this series adds a new callback 'pci_host_bridge::reset_slot' for the host
bridge drivers to reset the slot when a fatal error happens.

Also, this series allows the host bridge drivers to handle PCI link down event
by resetting the slots and recovering the bus. This is accomplished by the
help of a new API 'pci_host_handle_link_down()'. Host bridge drivers are
expected to call this API (preferrably from a threaded IRQ handler) when a link
down event is detected. The API will reuse the pcie_do_recovery() function to
recover the link if AER support is enabled, otherwise it will directly call the
reset_slot() callback of the host bridge driver (if exists).

For reference, I've modified the pcie-qcom driver to call
pci_host_handle_link_down() after receiving LINK_DOWN global_irq event and
populated the 'pci_host_bridge::reset_slot()' callback to reset the controller
(there by slots). Since the Qcom PCIe controllers support only a single root
port (slot) per controller instance, reset_slot() callback is going to be
invoked only once. For multi root port controllers, this callback is supposed to
identify the slots using the supplied 'pci_dev' pointer and reset them.

NOTE
====

This series is a reworked version of the earlier series [1] that I submitted for
handling PCI link down event. In this series, I've made use of the AER helpers
to recover the link as it allows notifying the device drivers and also
allows saving/restoring the config space.

Testing
=======

This series is tested on Qcom RB5 and SA8775p Ride boards by triggering the link
down event manually by writing to LTSSM register. For the error recovery to
succeed (if AER is enabled), all the drivers in the bridge hierarchy should have
the 'err_handlers' populated. Otherwise, the link recovery will fail.

[1] https://lore.kernel.org/linux-pci/20250221172309.120009-1-manivannan.sadhasivam@linaro.org

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
Changes in v3:
- Made the pci-host-common driver as a common library for host controller
  drivers
- Moved the reset slot code to pci-host-common library
- Link to v2: https://lore.kernel.org/r/20250416-pcie-reset-slot-v2-0-efe76b278c10@linaro.org

Changes in v2:
- Moved calling reset_slot() callback from pcie_do_recovery() to pcibios_reset_secondary_bus()
- Link to v1: https://lore.kernel.org/r/20250404-pcie-reset-slot-v1-0-98952918bf90@linaro.org

---
Manivannan Sadhasivam (5):
      PCI/ERR: Remove misleading TODO regarding kernel panic
      PCI/ERR: Add support for resetting the slots in a platform specific way
      PCI: host-common: Make the driver as a common library for host controller drivers
      PCI: host-common: Add link down handling for host bridges
      PCI: qcom: Add support for resetting the slot due to link down event

 drivers/pci/controller/Kconfig                    |  8 +-
 drivers/pci/controller/dwc/Kconfig                |  1 +
 drivers/pci/controller/dwc/pcie-hisi.c            |  1 +
 drivers/pci/controller/dwc/pcie-qcom.c            | 90 ++++++++++++++++++++++-
 drivers/pci/controller/pci-host-common.c          | 64 +++++++++++++++-
 drivers/pci/controller/pci-host-common.h          | 17 +++++
 drivers/pci/controller/pci-host-generic.c         |  2 +
 drivers/pci/controller/pci-thunder-ecam.c         |  2 +
 drivers/pci/controller/pci-thunder-pem.c          |  1 +
 drivers/pci/controller/pcie-apple.c               |  2 +
 drivers/pci/controller/plda/pcie-microchip-host.c |  1 +
 drivers/pci/pci.c                                 | 13 ++++
 drivers/pci/pcie/err.c                            |  7 +-
 include/linux/pci-ecam.h                          |  6 --
 include/linux/pci.h                               |  1 +
 15 files changed, 196 insertions(+), 20 deletions(-)
---
base-commit: 08733088b566b58283f0f12fb73f5db6a9a9de30
change-id: 20250404-pcie-reset-slot-730bfa71a202

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>



