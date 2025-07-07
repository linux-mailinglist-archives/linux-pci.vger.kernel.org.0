Return-Path: <linux-pci+bounces-31631-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA81AFBA81
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jul 2025 20:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C389175C60
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jul 2025 18:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DABE202F7C;
	Mon,  7 Jul 2025 18:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kxg2uEnP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E74A21ABAA;
	Mon,  7 Jul 2025 18:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751912330; cv=none; b=eqQlDuwlk8VB/pKWxmD5F6iU4Hoabk7l+hNC6QX6GiGUvc7ObAwCfzVjUaySbgL6UGTfQNco4ZzWwKXlbYnLXFnGuyGma+G8/Z2lYB0BagzYi/E/CqVulK9BR1oPbtee6ShkKx61d+gslXIsZrSAxCIU325wI97vmSKGBG77oGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751912330; c=relaxed/simple;
	bh=sDDdUBLO7rC2YYGWesgvXZ0daCjQh0IW352GnBaKumQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Kfw+oK7F6xhwxr8SXYPfcqg2vi95rsfFIzkqctuTZR6cqMSMyRQQwvilKbxvROYQFargnZvNXqOK5BwNdQ8mHj3WgbSxNtThqSuSUC6KztDf0VPUdylzFGmLgkxSG7lyipKAQpelCRRn0MR2PJWbdBEdWn5CtkHeuWv9g7fQs8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kxg2uEnP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2158CC4CEEF;
	Mon,  7 Jul 2025 18:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751912329;
	bh=sDDdUBLO7rC2YYGWesgvXZ0daCjQh0IW352GnBaKumQ=;
	h=From:Subject:Date:To:Cc:From;
	b=Kxg2uEnP+Y40kmuIEvoAJXIAhYKTJ8s5ObCavDwCoVxpJLtX1WwuFlkUG86ZBf/X9
	 cITzUARG/Mq1yMnrb86HDKKf8g9kkq7OALroPqA4jkvIVMUidCR0GzgPmeehc/PTaf
	 da0cYjRXaciOuM6XPl0lCAylHzhqC3lF+zo2IIjjYlSUs9VU3WaZ0IrAeWrJ6M7o9D
	 ZlaPd9tm6pUjYCRIh57HhR3tTsoHjURXSgcdfeHFtX5+iJxdZzdcJR0FN9IIiq1gEj
	 4xnJ8xmT4zsq0ML4HEG9WDUMHx77jXZkENRakqIp/gjSsTRrf7BdExArQfpkXkCFL8
	 fRC38B+/dLh7w==
From: Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH RFC 0/3] PCI/pwrctrl: Allow pwrctrl framework to control
 PERST# GPIO if available
Date: Mon, 07 Jul 2025 23:48:37 +0530
Message-Id: <20250707-pci-pwrctrl-perst-v1-0-c3c7e513e312@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH0PbGgC/x3MwQpAQBCA4VfRnE0tG8pVeQBXOTAGU2KbFUre3
 eb4Hf7/Ac8q7KGMHlA+xcu+BSRxBLT028woYzCkJs1MYQp0JOgupUNXdKz+wGGknG3eW5sRhM4
 pT3L/zxaauoLufT8TwNUQaAAAAA==
X-Change-ID: 20250707-pci-pwrctrl-perst-bdc6e36a335c
To: Bartosz Golaszewski <brgl@bgdev.pl>, 
 Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, 
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
 Brian Norris <briannorris@chromium.org>, 
 Manivannan Sadhasivam <mani@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3377; i=mani@kernel.org;
 h=from:subject:message-id; bh=sDDdUBLO7rC2YYGWesgvXZ0daCjQh0IW352GnBaKumQ=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBobA+Fs0zzgYQqTjHKf/77UAXqqwJTQ0knFXAr6
 evoLtmbFCiJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaGwPhQAKCRBVnxHm/pHO
 9WxbB/9Td06WHubjenC8ICseGSYxphZAZWKm6sxjclqR+wRlE3FbmXFom7O4ehOT5+NEQM/29C/
 987uhU6iLorn8JgcDNOXcsptkEXmqxc4S4crY0r0XUc8J1TH39WqK63UTnep6sYqFZ+LGDZtvBF
 MR7OIn5cX6U0074hgNwagC8e44rP9UR1E8HotA2txPMGRFdIys/b147PeQd2s0w9TZyOTKwcxxA
 oQ/UZHFsWk/VMlms24ox2cRvkpigiaCOUcCBJ4eQpJ62qHjcLaunyX8tOr9nAgHdpFzxRrEn8gr
 UYuUk2NpOS3q7TFvr5s+XpvoSI56Z1qOW7n3+a9hmliaGzJ5
X-Developer-Key: i=mani@kernel.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

Hi,

This series is an RFC to propose pwrctrl framework to control the PERST# GPIO
instead of letting the controller drivers to do so (which is a mistake btw).

Right now, the pwrctrl framework is controlling the power supplies to the
components (endpoints and such), but it is not controlling PERST#. This was
pointed out by Brian during a related conversation [1]. But we cannot just move
the PERST# control from controller drivers due to the following reasons:

1. Most of the controller drivers need to assert PERST# during the controller
initialization sequence. This is mostly as per their hardware reference manual
and should not be changed.

2. Controller drivers still need to toggle PERST# when pwrctrl is not used i.e.,
when the power supplies are not accurately described in PCI DT node. This can
happen on unsupported platforms and also for platforms with legacy DTs.

For this reason, I've kept the PERST# retrieval logic in the controller drivers
and just passed the gpio descriptors (for each slot) to the pwrctrl framework.
This will allow both the controller drivers and pwrctrl framework to share the
PERST# (which is ugly but can't be avoided). But care must be taken to ensure
that the controller drivers only assert PERST# and not deassert when pwrctrl is
used. I've added the change for the Qcom driver as a reference. The Qcom driver
is a slight mess because, it now has to support both new DT binding (PERST# and
PHY in Root Port node) and legacy (both in Host Bridge node). So I've allowed
the PERST# control only for the new binding (which is always going to use
pwrctrl framework to control the component supplies).

Testing
=======

This series is tested on Lenovo Thinkpad T14s laptop (with out-of-tree patch
enabling PCIe WLAN card) and on RB3 Gen2 with TC9563 switch (also with the not
yet merged series [2]). A big take away from this series is that, it is now
possible to get rid of the controversial {start/stop}_link() callback proposed
in the above mentioned switch pwrctrl driver [3].

- Mani

[1] https://lore.kernel.org/linux-pci/Z_6kZ7x7gnoH-P7x@google.com/
[2] https://lore.kernel.org/linux-pci/20250412-qps615_v4_1-v5-0-5b6a06132fec@oss.qualcomm.com/ 
[3] https://lore.kernel.org/linux-pci/20250412-qps615_v4_1-v5-4-5b6a06132fec@oss.qualcomm.com/

Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
---
Manivannan Sadhasivam (3):
      PCI/pwrctrl: Move pci_pwrctrl_init() before turning ON the supplies
      PCI/pwrctrl: Allow pwrctrl core to control PERST# GPIO if available
      PCI: qcom: Allow pwrctrl framework to control PERST#

 drivers/pci/controller/dwc/pcie-designware-host.c |  1 +
 drivers/pci/controller/dwc/pcie-designware.h      |  1 +
 drivers/pci/controller/dwc/pcie-qcom.c            | 26 ++++++++++++++-
 drivers/pci/pwrctrl/core.c                        | 39 +++++++++++++++++++++++
 drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c          |  4 +--
 drivers/pci/pwrctrl/slot.c                        |  4 +--
 include/linux/pci-pwrctrl.h                       |  2 ++
 include/linux/pci.h                               |  2 ++
 8 files changed, 74 insertions(+), 5 deletions(-)
---
base-commit: 00f0defc332be94b7f1fdc56ce7dcb6528cdf002
change-id: 20250707-pci-pwrctrl-perst-bdc6e36a335c

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


