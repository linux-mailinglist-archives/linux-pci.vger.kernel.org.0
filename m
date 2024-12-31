Return-Path: <linux-pci+bounces-19112-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 211E39FEE78
	for <lists+linux-pci@lfdr.de>; Tue, 31 Dec 2024 10:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 169C63A2C00
	for <lists+linux-pci@lfdr.de>; Tue, 31 Dec 2024 09:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996ED194C6A;
	Tue, 31 Dec 2024 09:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AOpMt+iK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598BA19047A;
	Tue, 31 Dec 2024 09:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735638254; cv=none; b=dIouyvxQKWlwsteBrmeuqQMy5YOhEYiU5amQ3P+okGVqcm7P/dc5k2rK+WzncD1R9aQPhWFNsU26M3Zt9OBJOuS6Bq6EDiDvbd2ElzznKQQD+3eDK1oDOpXfTywsIDUMlNUitnqHfdbv4ErfNj1NG3PFw2jtWcSc9xqJADzaeV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735638254; c=relaxed/simple;
	bh=RpiwBlHdPMGD4+MQEjX5Hf9AEzulvxLAiyeOBn8eUos=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IEYbqYCPmFgA/p2kx7i1eDK8Gd5YLxC+QE9t2FpK2FRVh/+dVCLCCBujwxIGEvqLLKOBn5p3Ga0Bn/3lzzhGHI245bMPE5/PEw6RoXGZaGmC7aL+NRjcHSi1JtHfa6pi8SPRD0XiCgG1AGJ2C5iSgtot3o/4wSjbUp/KLiYuit8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AOpMt+iK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D09FBC4CED6;
	Tue, 31 Dec 2024 09:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735638253;
	bh=RpiwBlHdPMGD4+MQEjX5Hf9AEzulvxLAiyeOBn8eUos=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=AOpMt+iKQ9PnviZGOtOJHYbANwz+mnKyG1voa14+KKYIYuXh1dlH3xrUtWvGsdb6K
	 b0IQsHhI1yXiimXSvuszavVxd5/gFwrEIPI9EZOEtp5r3XUv/myALm79QhX4mnCOQC
	 FwZ3O68eGakS49BANayuDDPFKKint6G0UBH/jJVDH19himIxwptf7VDGfRJD9FAGkV
	 4jJrzvyJk0FDJsSLTM/IRD2oQLR0Y92UYH8Ou0JbEBEKx5DJOclzpojLcF6y5A54W6
	 TkVC/dJqrvq84/nMqNkxhaOldp9ibxj8m0ODx1U5yOY0Csh3YJ00jAe19OIZ4BUQy1
	 lNRxqRybljjLw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B77C7E77188;
	Tue, 31 Dec 2024 09:44:13 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Subject: [PATCH v2 0/6] PCI/pwrctrl: Rework pwrctrl driver integration and
 add driver for PCI slot
Date: Tue, 31 Dec 2024 15:13:41 +0530
Message-Id: <20241231-pci-pwrctrl-slot-v2-0-6a15088ba541@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM28c2cC/32NQQrCMBBFr1Jm7cgkRi2uvId0EeK0HQhNmYSql
 N7d2AO4fA/++ytkVuEMt2YF5UWypKmCPTQQRj8NjPKsDJasM9YQzkFwfmkoGjHHVJBsIA6Xk7n
 aHupsVu7lvScfXeVRckn62R8W87N/YotBQvbszuzalhzdo0xe0zHpAN22bV96fvsusQAAAA==
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Qiang Yu <quic_qianyu@quicinc.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 kernel test robot <lkp@intel.com>, Lukas Wunner <lukas@wunner.de>, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3392;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=RpiwBlHdPMGD4+MQEjX5Hf9AEzulvxLAiyeOBn8eUos=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBnc7zllJBJR1ndBGOzKIQsX3DLr3Nn1hcoWnhry
 A1o8MdJ97mJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZ3O85QAKCRBVnxHm/pHO
 9WQcCACHW6KvqSl8aplMdIQzTTmlQOYyPvBPRXjyrfGUxbH8ibF7W8TxXDo74u4BwVNJoYS6lTb
 nvRbCxkK7NEZRNfSRSv/bW1MliRouX/bgGCMIglW/DNPKwxqZ1zWR3Y9Wg2NBz8AQsKs88YCH46
 XYJp+jgRZUHl4ZFLrVY2GoJrAtyuwmLGld3toCar14JLcWncrvw3s7moqNCN5rJqqwyY9LR25I0
 mFxWmcIrFhiqU+hREbgjcY7tlUM3lKUwJ0qfY+EMIuYUORN+UyX0bQ6Z+oRsmAjS642mXu0Y/NZ
 lBPJiuMMFX19DJSF8S6wEtDYJ4f+38ii5XJx0kwqSgjvpsbn
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@linaro.org/default with auth_id=185
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reply-To: manivannan.sadhasivam@linaro.org

Hi,

This series reworks the PCI pwrctrl integration (again) by moving the creation
and removal of pwrctrl devices to pci_scan_device() and pci_destroy_dev() APIs.
This is based on the suggestion provided by Lukas Wunner [1][2]. With this
change, it is now possible to create pwrctrl devices for PCI bridges as well.
This is required to control the power state of the PCI slots in a system. Since
the PCI slots are not explicitly defined in devicetree, the agreement is to
define the supplies for PCI slots in PCI bridge nodes itself [3].

Based on this, a pwrctrl driver to control the supplies of PCI slots are also
added in patch 4. With this driver, it is now possible to control the voltage
regulators powering the PCI slots defined in PCI bridge nodes as below:

```
pcie@0 {
	compatible "pciclass,0604"
	...

	vpcie12v-supply = <&vpcie12v_reg>;
	vpcie3v3-supply = <&vpcie3v3_reg>;
	vpcie3v3aux-supply = <&vpcie3v3aux_reg>;
};
```

To make use of this driver, the PCI bridge DT node should also have the
compatible "pciclass,0604". But adding this compatible triggers the following
checkpatch warning:

WARNING: DT compatible string vendor "pciclass" appears un-documented --
check ./Documentation/devicetree/bindings/vendor-prefixes.yaml

For fixing it, I added patch 3. But due to some reason, checkpatch is not
picking the 'pciclass' vendor prefix alone, and requires adding the full
compatible 'pciclass,0604' in the vendor-prefixes list. Since my perl skills are
not great, I'm leaving it in the hands of Rob to fix the checkpatch script.

[1] https://lore.kernel.org/linux-pci/Z0yLDBMAsh0yKWf2@wunner.de
[2] https://lore.kernel.org/linux-pci/Z0xAdQ2ozspEnV5g@wunner.de
[3] https://github.com/devicetree-org/dt-schema/issues/145

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
Changes in v2:
- Added new patch to skip the device scan if pwrctrl device is found
- Added a new patch to fix the build issue
- Collected tags
- Link to v1: https://lore.kernel.org/r/20241210-pci-pwrctrl-slot-v1-0-eae45e488040@linaro.org

---
Manivannan Sadhasivam (6):
      regulator: Guard of_regulator_bulk_get_all() with CONFIG_OF
      PCI/pwrctrl: Move creation of pwrctrl devices to pci_scan_device()
      PCI/pwrctrl: Move pci_pwrctrl_unregister() to pci_destroy_dev()
      PCI/pwrctrl: Skip scanning for the device further if pwrctrl device is created
      dt-bindings: vendor-prefixes: Document the 'pciclass' prefix
      PCI/pwrctrl: Add pwrctrl driver for PCI Slots

 .../devicetree/bindings/vendor-prefixes.yaml       |  2 +-
 drivers/pci/bus.c                                  | 43 ----------
 drivers/pci/probe.c                                | 41 ++++++++++
 drivers/pci/pwrctrl/Kconfig                        | 11 +++
 drivers/pci/pwrctrl/Makefile                       |  3 +
 drivers/pci/pwrctrl/core.c                         |  2 +-
 drivers/pci/pwrctrl/slot.c                         | 93 ++++++++++++++++++++++
 drivers/pci/remove.c                               |  2 +-
 include/linux/regulator/consumer.h                 | 17 ++--
 9 files changed, 160 insertions(+), 54 deletions(-)
---
base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
change-id: 20241210-pci-pwrctrl-slot-02c0ec63172f

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>



