Return-Path: <linux-pci+bounces-35988-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E98BB54598
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 10:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D46E1B23EC4
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 08:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583432D5436;
	Fri, 12 Sep 2025 08:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jFC4YKLZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1425927057B;
	Fri, 12 Sep 2025 08:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757666122; cv=none; b=aZa9mpOHi8FjbMhUepgT/5JCTEF+FvccVomKF8xhfpMTDvZMzT0Ctlonwl9BKjYtYugyLiFWZXPiGhk94NrAU7wvsEppItyBIeZlcxHQ77++avDNxcwVL+kd9D2BrDbn1gd0vPEQ2WN4AeiCukZtjIz5hgkXUj6hmhSRcuEgC5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757666122; c=relaxed/simple;
	bh=qyyu6lVr8aS+pwNpu2pxm2nQHlu6k5+BhoJaWT8jQsw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=h6iqRSz8cEic7orkTF+leGnrsO1zvKQWMfHLGRS/rMXnSeB6I8g3FYLAovAF/fd8FUYyKVbbXKN5m5YnZXZDDPZgkDCaCKS0qam4vjBf3CZH7juVyH0e0EjS2N1AbvOuCPSvRvskqF7+zAI/vi4mIRY9JapxM0OPrj7iTFBBnWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jFC4YKLZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8EE7EC4CEF4;
	Fri, 12 Sep 2025 08:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757666121;
	bh=qyyu6lVr8aS+pwNpu2pxm2nQHlu6k5+BhoJaWT8jQsw=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=jFC4YKLZg4ZbsE9yxOXo4QhDWOqTv8tjEafMd+i7BqaLflOrs0ZXGxsYpGYHTtyWC
	 mwMUQnyrKX7229cEkf8RUyTKdYzZIyxU/6PJ+tKrBGeBMNTVh5wKE3PDYI5Jx+ucyd
	 HGrrG55jhnT7j44xjPy4VqnhLG54j6Z8YN4Imbqtr+Uh0bBjgPbPVRJxDYqDeebWqC
	 wJt/yrnHmmilQIbwoMV5b0V0q9yAqBDkGozSwNSBqcC2qKUq65mS/sTC6Ks3mNtr7n
	 0QSzgDDq7OKvVPaQm2Q0Df08yQkbuoWXezmczmnHzte787Yw82ebsipZu9jEeng7Sd
	 hc/cof3RKZBAw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC0ECAC593;
	Fri, 12 Sep 2025 08:35:21 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Subject: [PATCH v3 0/4] PCI/pwrctrl: Allow pwrctrl framework to control
 PERST# if available
Date: Fri, 12 Sep 2025 14:05:00 +0530
Message-Id: <20250912-pci-pwrctrl-perst-v3-0-3c0ac62b032c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADTbw2gC/23NSw7CIBCA4as0rKUZKH258h7GRYHRkrSCUFHT9
 O7SJsZNN5P8k8w3MwnoDQZyzGbiMZpg7D1FcciI6rv7DanRqQkHXkLDGuqUoe7l1eQH6tCHiYK
 UtdYVl6XgJN05j1fz3szzJXVvwmT9Z3sR2br9ae2OFhkFKmQt2rrRHKA+2RDyx7MblB3HPA2yo
 pH/oRaKPYgniGtRMdSAULEdaFmWL++6HykCAQAA
X-Change-ID: 20250818-pci-pwrctrl-perst-0bb7dd62b542
To: Manivannan Sadhasivam <mani@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Saravana Kannan <saravanak@google.com>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
 Brian Norris <briannorris@chromium.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
 Bjorn Helgaas <helgaas@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6268;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=qyyu6lVr8aS+pwNpu2pxm2nQHlu6k5+BhoJaWT8jQsw=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBow9tH4sj+7abdCzaJm5sybCBQUIhypL2tNyEbN
 DOK7mxLyjWJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaMPbRwAKCRBVnxHm/pHO
 9dCsCACOiqSBWO6U6Yc8SFQLOvnVQ+8M1S9l5b/fj1r/NKFeg1umUjpEaQW+4pxCu8xKBi2V15B
 LVgYRfhENYTRYnftMMHhvZvKSYMifbzpaMyNkbhBhsGbM6lH/9/suD9U7pnrWB3wz007VRPzp/A
 FO0+uc3TQbkFpyleK5h2AT5kghoW53an/ICC4v83CLIn+LZzOYxI5dmRzTpUNZL7XzUkOzTskcD
 kNqT+R4gWzqWVry9V+bM6bCdkXYyONUsbJ9k4itKkfPGMnzQNQ4vPjLsEWpMUVazWN7Y4w2VpaO
 RYIlt+lsmNhC3x44Z9VpxDuI6OWCoNEE2aGYJy6r5k/9Y6iD
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

Hi,

This series is the proper version for toggling PERST# from the pwrctrl
framework after the initial RFC posted earlier [1].

Problem statement
=================

Pwrctrl framework is intented to control the supplies to the components on the
PCI bus. However, if the platform supports the PERST# signal, it should be
toggled as per the requirements in the electromechanical specifications like
PCIe CEM, Mini, and M.2. Since the pwrctrl framework is controlling the power
supplies, it should also toggle PERST# as per the requirements in the above
mentioned specifications. Right now, it is just controlling the power to the
components and rely on controller drivers to toggle PERST#, which goes against
the specs. For instance, controller drivers will deassert PERST# even before the
pwrctrl driver enables the supplies. This causes the device to see PERST#
deassert immediately after power on, thereby violating the delay requirements in
the PCI Electromechanical specs.

Proposal
========

To fix this issue, the pwrctrl framework has to control the PERST# signal. But
unfortunately, it is not straightforward. This is mostly due to controller
drivers still need to assert PERST# as a part of their own initialization
sequence. The controller drivers will parse PERST# from the devicetree nodes
even before the pwrctrl drivers get probed. So the PERST# control needs to be
shared between both drivers in a logical manner.

This is achieved by adding a new callback, 'pci_host_bridge::perst_assert'. This
callback if available, will be called by the pwrctrl framework during the power
on and power off scenarios. The callback implementation in the controller driver
has to take care of asserting/deasserting PERST# in an implementation specific
way i.e., if the PERST# signal is a GPIO, then it should be toggled using gpiod
APIs, or if the signal is implemented as a CSR, then the relevant registers
should be written.

Ideally, the PERST# delay requirements should be implemented in the pwrctrl
framework (before/after calling the callback), but some controller drivers
perform some post-link_up operations requiring them to control the delay within
the driver. Those drivers may use this callback to assert/deassert PERST# and
perform post-link_up operations.

For reference, I've implemented the callback in the Qcom RC driver where it just
asserts/deasserts PERST# and handles delay. Since the Qcom driver supports both
legacy DT binding (all Root Port properties in host bridge node) and new binding
(Root Port properies in Root Port node), I've moved the PERST# handling to
pwrctrl driver only if the newly introduced 'qcom_pcie::legacy_binding' flag is
not set. This flag if set, implies that the platform is using the legacy DT
binding, so the controller driver has to control PERST#. 

DT binding requirement
======================

This series has some assumptions on the DT binding. But some of them are not
enforced right now:

1. Pwrctrl driver requires the PCIe device node to have atleast one -supply
property. Those supplies are already documented in the dtschema [2], but they
are optional. So if those supplies are not present, pwrctrl driver will not get
probed. For platforms having a fixed power supply to the components, they should
describe those fixed supplies in DT. Otherwise, they cannot use pwrctrl drivers.
(NOT ENFROCED)

2. Optional PERST# GPIO (reset-gpios property) is only allowed in the bridge
node in the DT binding [3]. So for looking up the PERST# for an endpoint node,
the controller driver has to look up the parent node where PERST# would be
available. (ENFORCED)

3. If shared PERST# is implemented, all the bridge nodes (Root port and switch
downstream) should have the same 'reset-gpios' property. This way, the
controller drivers parsing PERST# could know if it is shared and invoke relevant
gpiod APIs/flags. (NOT ENFORCED)

I don't know how we can make sure DT binding enforces option 1 and 3.

Testing
=======

This series is tested on Qcom X1E based T14s laptop, SM8250 based RB5 board, and
QCS6490 based RB3Gen2 board with DTS specifying Root Port properties in host
bridge node and in Root Port node.

[1] https://lore.kernel.org/linux-pci/20250707-pci-pwrctrl-perst-v1-0-c3c7e513e312@kernel.org/
[2] https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/pci/pci-bus-common.yaml#L173
[3] https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/pci/pci-bus-common.yaml#L141

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
Changes in v3:
- Dropped the pci_pwrctrl_init() move patch as it is no longer required
- Added a patch to cleanup the usage of 'phy' and 'reset' pointers
- Renamed the callback from 'toggle_perst' to 'perst_assert'
- Reworded the patch descriptions
- Link to v2: https://lore.kernel.org/r/20250903-pci-pwrctrl-perst-v2-0-2d461ed0e061@oss.qualcomm.com

Changes in v2:
- Reworked the PERST# lookup logic to use the node pointer instead of BDF
- Added PWRCTRL guard to the toggle_perst callback
- Link to v1: https://lore.kernel.org/r/20250819-pci-pwrctrl-perst-v1-0-4b74978d2007@oss.qualcomm.com

Changes since RFC:
* Implemented PERST# toggling using a callback since GPIO based PERST# is not
  available on all platforms. This also moves all PERST# handling to the
  controller drivers allowing them to add any additional post-link_up logic.

---
Manivannan Sadhasivam (4):
      PCI/pwrctrl: Add support for asserting/deasserting PERST#
      PCI: qcom: Move host bridge 'phy' and 'reset' pointers to struct qcom_pcie_port
      PCI: qcom: Parse PERST# from all PCIe bridge nodes
      PCI: qcom: Allow pwrctrl core to control PERST# if 'reset-gpios' property is available

 drivers/pci/controller/dwc/pcie-qcom.c | 269 ++++++++++++++++++++++++---------
 drivers/pci/pwrctrl/core.c             |  27 ++++
 include/linux/pci.h                    |   3 +
 3 files changed, 227 insertions(+), 72 deletions(-)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250818-pci-pwrctrl-perst-0bb7dd62b542

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>



