Return-Path: <linux-pci+bounces-35353-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE317B415F1
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 09:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A59B71BA0150
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 07:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39AC92D9EE8;
	Wed,  3 Sep 2025 07:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="In/zw0Bw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029392D8776;
	Wed,  3 Sep 2025 07:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756883614; cv=none; b=mhyctR6BTJZ3AciOov3nzmGgg5jlhGH4v923USgMMM7Qp3owitZj54LuO2bxcB3k5TBNwHF5T0K642k9ya/MqT8rtbzu+VUdRJR5RK5rxVxi8X6Q4C/qe9tetAG8GvUbM4L+izCV6Jz5XXzozkqyaSvNvgHJ5b3Qil+0ObXVkWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756883614; c=relaxed/simple;
	bh=CjWEsI0D1WEENvjg5BgWaePrND9PK9GPQKlp2IJGocc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lP2+tQZsH6B7rEqfoc3KfuOlbXwBirlRvGiGdzEFBXZsRGWOOUD/9tZvztG9SeP8TdZziQEEozc6MbGFR7xGCrt1K8JEOQIQ3Fnio+XtPu/XIoOiLbXrH1eN4HxEU2Qjk8uMoteJ1/xuDVeS7lRGhMOVvhb6q8c0+bfjZYQaDLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=In/zw0Bw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 84CF7C4CEF0;
	Wed,  3 Sep 2025 07:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756883613;
	bh=CjWEsI0D1WEENvjg5BgWaePrND9PK9GPQKlp2IJGocc=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=In/zw0Bwi0BMPezPTtpYpKpV/1SK7697YfokqLjuYFrf/bbr36tJZ7KjqN7zTQMZI
	 nOCu6n6hDkWTbuzWEkRMJYYN287RyXoJyTOnywlqsobXKRYAM3CSbNd4LBbTh+UDQu
	 +EqnIonw0T8bUcgTEATkFXa9Xcil/vQZ9YkguBQBmuBhSxvvLvYseZs4U1P19lvLwN
	 ibcvHkxscoDFid9h//EA4oqBELKfOFYDLnCPS4k4BbsZIrynLagBjm/mBNaX9LMexS
	 IBkAZ8nsKDCu4OcMMSEfZaQ95GnVw0yT47jr7Dx2ZoOqpg4MYmenJUqRPhO62aK9DQ
	 jod0SxeFBvcDQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C93CCA0FF2;
	Wed,  3 Sep 2025 07:13:33 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Subject: [PATCH v2 0/5] PCI/pwrctrl: Allow pwrctrl framework to control
 PERST# if available
Date: Wed, 03 Sep 2025 12:43:22 +0530
Message-Id: <20250903-pci-pwrctrl-perst-v2-0-2d461ed0e061@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJLqt2gC/22NzQ6CMBCEX4Xs2SWlAQuefA/Dgf4omwCtXUQN4
 d2tJN68TPJNMt+swC6SYzhlK0S3EJOfEshDBqbvpptDsolBClmJuqgxGMLwjGaOAwYXeUahtbL
 2KHVVSki7EN2VXrvz0ibuiWcf3/vFUnzbn635Y1sKFFhqVTaqtlIIdfbM+f3RDcaPY54C2m3bP
 m2pPqW5AAAA
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
 stable+noautosel@kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6128;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=CjWEsI0D1WEENvjg5BgWaePrND9PK9GPQKlp2IJGocc=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBot+qahLcTsVR64Sssq95Ewa30gNa8yStCg7VQb
 +JSdC8Y4i6JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaLfqmgAKCRBVnxHm/pHO
 9SBoB/9baU5hLiZITOWBpw8czXI0iQaeYmcT+NZDrH5AOZZfiwY7/2y35TeCcDZpwgjZR4KC2vY
 iBnEZVXwb0GVI1P8NVH820LrcHo6efKJCek5snfH1l6RNryyNoK/Y5nNLRayuRwXmrshcwOpUi1
 +lFSMrYjn4tqhVe/0Csmzy8YbPQTSma2gp6ezlurp+/1tQCgezs+Nr1ahtKuzw05KKz/CII6L97
 vXPeUsnHIiga7JaPHLOCDSBKWY+IygbE38vXS9BvThx+XPIEGwRnAHo5hm8fPVouKz7FegPcTkj
 yXCq2VUn4DPpEs3xHwKzdMvPIgBRCwmMQsUXWfmvneRb+sTV
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
the electromechanical specs.

Proposal
========

To fix this issue, the pwrctrl framework has to control the PERST# signal. But
unfortunately, it is not straightforward. This is mostly due to controller
drivers still need to assert PERST# as a part of their own initialization
sequence. The controller drivers will parse PERST# from the devicetree nodes
even before the pwrctrl drivers get probed. So the PERST# control needs to be
shared between both drivers in a logical manner.

This is achieved by adding a new callback, 'pci_host_bridge::toggle_perst'. This
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
toggles PERST# and implements the delay as per the CEM spec (which seem to
satisfy the delay requirements of other electromechanical specs also). Since the
Qcom driver supports both legacy DT binding (all Root Port properties in host
bridge node) and new binding (Root Port properies in Root Port node), I've moved
the PERST# handling to pwrctrl driver only if new binding is used. A recently
merged patch to PCI tree [2] makes sure that the pwrctrl slot driver is selected
with the RC driver.

DT binding requirement
======================

This series has some assumptions on the DT binding. But some of them are not
enforced right now:

1. Pwrctrl driver requires the PCIe device node to have atleast one -supply
property. Those supplies are already documented in the dtschema [3], but they
are optional. So if those supplies are not present, pwrctrl driver will not get
probed. For platforms having a fixed power supply to the endpoint, they should
describe those fixed supplies in DT. Otherwise, they cannot use pwrctrl drivers.
(NOT ENFROCED)

2. Optional PERST# GPIO (reset-gpios property) is only allowed in the bridge
node in the DT binding [4]. So for looking up the PERST# for an endpoint node,
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
QCS6490 based RB3Gen2 board with both legacy and new DT binding.

[1] https://lore.kernel.org/linux-pci/20250707-pci-pwrctrl-perst-v1-0-c3c7e513e312@kernel.org/
[2] https://lore.kernel.org/linux-pci/20250722091151.1423332-2-quic_wenbyao@quicinc.com/
[3] https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/pci/pci-bus-common.yaml#L173
[4] https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/pci/pci-bus-common.yaml#L141

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
Changes in v2:
- Reworked the PERST# lookup logic to use the node pointer instead of BDF
- Added PWRCTRL guard to the toggle_perst callback
- Link to v1: https://lore.kernel.org/r/20250819-pci-pwrctrl-perst-v1-0-4b74978d2007@oss.qualcomm.com

Changes since RFC:
* Implemented PERST# toggling using a callback since GPIO based PERST# is not
  available on all platforms. This also moves all PERST# handling to the
  controller drivers allowing them to add any additional post-link_up logic.

---
Manivannan Sadhasivam (5):
      PCI: qcom: Wait for PCIE_RESET_CONFIG_WAIT_MS after PERST# deassert
      PCI/pwrctrl: Move pci_pwrctrl_init() before turning ON the supplies
      PCI/pwrctrl: Add support for toggling PERST#
      PCI: qcom: Parse PERST# from all PCIe bridge nodes
      PCI: qcom: Allow pwrctrl core to toggle PERST# for new DT binding

 drivers/pci/controller/dwc/pcie-qcom.c   | 186 ++++++++++++++++++++++++++-----
 drivers/pci/pwrctrl/core.c               |  27 +++++
 drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c |   4 +-
 drivers/pci/pwrctrl/slot.c               |   4 +-
 include/linux/pci.h                      |   3 +
 5 files changed, 190 insertions(+), 34 deletions(-)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250818-pci-pwrctrl-perst-0bb7dd62b542

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>



