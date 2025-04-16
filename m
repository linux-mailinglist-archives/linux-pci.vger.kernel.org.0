Return-Path: <linux-pci+bounces-26019-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0743DA908F2
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 18:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6E397AC58E
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 16:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B0F212B34;
	Wed, 16 Apr 2025 16:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B1IUL+59"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8754211A3D;
	Wed, 16 Apr 2025 16:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744820955; cv=none; b=Nkfr7PzhZDyANkzEL2p9vbPxVpKMFsv11GAjiPe7liOc60t6JGx4jdSF+xXxWC8ix7eJMfJtDTEboi5/HwALjzNp0nPDuSzMYgtCc/pF4ZIG7ifcWHOz93BDZ/D1l6ybq0r1ueZcObbwgWMYN1T3Jhl0dbWoYZ9HuNtNlP7n96A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744820955; c=relaxed/simple;
	bh=qkB19ebsdB7yF8JrqmDzhAIvjQoXMD7T3mmriNCrqxE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XCXxP0wPqibYjbzVi1m6RG51gF3DaDAnVse/sOK53jOqkNMFE5EedeMEMJKKDAEL8dGlKI5mrwspakovslpJzNvm03M3+fKki97ROjqM4VZYXrM0SkWJATm4H0YS0zOBKwyZb4pXCNBat8kbtMh9jhiiT/wNP5oFzCUCiKXWi4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B1IUL+59; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2650BC4CEE2;
	Wed, 16 Apr 2025 16:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744820955;
	bh=qkB19ebsdB7yF8JrqmDzhAIvjQoXMD7T3mmriNCrqxE=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=B1IUL+59kGeD7mqga7bCyxPIxG2tp3cXVrKCvl5dVtHYI0OhB5uCNAOGJiOc0bp+l
	 HsYGTqjEsLaHjBoX4CofSq+N9qa3eKcmpemd67bkz6OaFrkFLEkyLMD+1OE8YbB0lG
	 KLv12g/nY3FdONOL1EgWm3Xw4t8o0vKBbJuJSzLNnFufjeaKx3lfX1dZDk6RPSJOng
	 oAQCbEQd1tTf6NwWRPx5fSaohAq4P5rcqnD3z+EgBYIuR7vOFa6VklFzFzPOJGwxpH
	 zu86cEMnCqpkacuKS0dZhcYisejR0kc+z2kDbH66j8nILxYuGVpK2rSjNJJQn4MHUN
	 5SfMBNL6P3Jfg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F1ECC369BA;
	Wed, 16 Apr 2025 16:29:15 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Subject: [PATCH v2 0/4] PCI: Add support for resetting the slots in a
 platform specific way
Date: Wed, 16 Apr 2025 21:59:02 +0530
Message-Id: <20250416-pcie-reset-slot-v2-0-efe76b278c10@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM/a/2cC/3WNwQqDMBBEf0X23C1Jqmh66n8UD9FudEES2UhoE
 f+9qfce3zDzZodEwpTgXu0glDlxDAXMpYJxdmEi5FdhMMo0qlY1riMTCiXaMC1xw/amBu9a7Uo
 DymoV8vw+jc++8Mxpi/I5D7L+pf9dWaNC29nGWN0N3qrHwsFJvEaZoD+O4wsJP+HXrwAAAA==
X-Change-ID: 20250404-pcie-reset-slot-730bfa71a202
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
 Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>
Cc: dingwei@marvell.com, cassel@kernel.org, Lukas Wunner <lukas@wunner.de>, 
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3553;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=qkB19ebsdB7yF8JrqmDzhAIvjQoXMD7T3mmriNCrqxE=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBn/9rVLvxXFkai8cVNkg23+3JBYRdthOY/lxQwa
 fbOegB4XfmJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZ//a1QAKCRBVnxHm/pHO
 9SGRB/40rRHb9fGiMK5kD1aBd/MewJxI5StivHVa5Erzx+HMuFj97jziyHXdpUsz4ffhJ4XQFoQ
 EMKPxKj+ocduRoORbAYIa33SUHBLn9X5/XInHvLBEw/E47p6YBkQDFCSXZOAgZ+9FX0D0Te5tNb
 2CDt7KVi+T2IKCwkbBX+pLkKJfs0hbfGBijN3F6/qNXG/stthtJKfzrFg9VYRmfOjaLGXksNq1d
 OiiXevAEEKFNC81mjU+Y6fQGpvjisAiglcBeql266ba4ZFT+yV17zxaxnd1oV7XdMRq/Nmthza6
 b/hxtehyr4BdSL0Vhz0u0SENUH1/6Tv88cWuux5Xhjrb+IJ7
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
Changes in v2:
- Moved calling reset_slot() callback from pcie_do_recovery() to pcibios_reset_secondary_bus()
- Link to v1: https://lore.kernel.org/r/20250404-pcie-reset-slot-v1-0-98952918bf90@linaro.org

---
Manivannan Sadhasivam (4):
      PCI/ERR: Remove misleading TODO regarding kernel panic
      PCI/ERR: Add support for resetting the slots in a platform specific way
      PCI: Add link down handling for host bridges
      PCI: qcom: Add support for resetting the slot due to link down event

 drivers/pci/controller/dwc/pcie-qcom.c | 89 +++++++++++++++++++++++++++++++++-
 drivers/pci/pci.c                      | 12 +++++
 drivers/pci/pci.h                      | 21 ++++++++
 drivers/pci/pcie/err.c                 | 33 ++++++++++---
 drivers/pci/probe.c                    |  7 +++
 include/linux/pci.h                    |  2 +
 6 files changed, 156 insertions(+), 8 deletions(-)
---
base-commit: 08733088b566b58283f0f12fb73f5db6a9a9de30
change-id: 20250404-pcie-reset-slot-730bfa71a202

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>



