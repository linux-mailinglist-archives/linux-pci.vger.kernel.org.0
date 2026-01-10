Return-Path: <linux-pci+bounces-44417-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D10DED0D0F8
	for <lists+linux-pci@lfdr.de>; Sat, 10 Jan 2026 07:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC2013034348
	for <lists+linux-pci@lfdr.de>; Sat, 10 Jan 2026 06:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A84346768;
	Sat, 10 Jan 2026 06:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uKisoEgG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53EA3126B6;
	Sat, 10 Jan 2026 06:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768028226; cv=none; b=tfectDwtglI55m0uczqz6QOkOgISXTskHIEwX4v0/2xtz4TA1ZdrcwS6pa+isFE0HndUYBjrx611W+zeTr/S6erD3r/lM+Dx19NzjB1lw+raqntxz5OWh6l7yAyDGJKw9V6lATlzGad+dzWulQkLPU1SXVpn4yc6dMa/R0XVqgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768028226; c=relaxed/simple;
	bh=/lmr5R1V4hK43zv0BnO4dkyfmN+kPBiDyJMM/7lu7/A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZTyJShxkrHtdZLKv5x78tsNyNZXzO+YmBxAa1hISelSr4jhe81UzwIN9wPB/Hxbo2srdZ8EQpbDiWqsN/d6jOz+01KTe4KeRE/zpOWPchbdbX+8+UAg6Y+xlstHl+uhe8ZyZl57hfV1xwgMpbKd6dZRzZare/VFRQ5qa39U46q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uKisoEgG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 60FC9C4CEF1;
	Sat, 10 Jan 2026 06:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768028225;
	bh=/lmr5R1V4hK43zv0BnO4dkyfmN+kPBiDyJMM/7lu7/A=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=uKisoEgGZr/3dnP17aPbaV1hkKQn2COhxnxX4706deUOcDzjNfEKIF5SsEgAVtS5d
	 WpsT+M/iqtnvS2A8UaTky4jTd/8fe7OanYVCaYcZqKjHZVzlqZ8UPCpg6ChxSx+WQ4
	 3oA1q7ewaJH2zsEkWd4bkRhvaCxEly/xNc7AjVmuNm8nUnz25PO1QE3QY6DDDf2M2a
	 xHV51vs94Cuy+XpfuXFJbrt5IN628yikvKKTCCOIRKQWHyeOgNBxQ2LEJ2jyrNEh9f
	 6GPYwB6fFy2MW6jVATg0pyjHHq7KvQ9C/zwUWASzzCR7sbHdJkWKq6JUsiUEMoLTVD
	 3MscD5+w0dRRw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 481C1D277C2;
	Sat, 10 Jan 2026 06:57:05 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Subject: [PATCH v3 00/14] Add support for handling PCIe M.2 Key E
 connectors in devicetree
Date: Sat, 10 Jan 2026 12:26:18 +0530
Message-Id: <20260110-pci-m2-e-v3-0-4faee7d0d5ae@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABL4YWkC/22PzY7CMAyEX6XKGVeNm6Q/J94DcQipWSJRCnGJd
 oV493XLBe1ysTSW5/PMQzGlSKz64qES5chxuoioN4UKJ3/5IoiDaIUVWq01wjVEGBEIOuM660M
 3ONsoOb8mOsbvFbXbiz5Fnqf0s5KzXrYfIFlDBV1jdD24w7FFs52Yy9vdn8M0jqUMtbAyvvnRv
 vlR/DW26AaqmhDsB//zFS7R7S715ldCNRKzX+v1xV9uroUaLLaVQU/eNP+pwjx4JlgWce6L7Er
 dQgpa/j1/ATUWXx5WAQAA
X-Change-ID: 20251112-pci-m2-e-94695ac9d657
To: Rob Herring <robh@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nicolas Schier <nicolas.schier@linux.dev>, Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Mark Pearson <mpearson-lenovo@squebb.ca>, 
 "Derek J. Clark" <derekjohn.clark@gmail.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 linux-pm@vger.kernel.org, Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 linux-acpi@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 Sui Jingfeng <sui.jingfeng@linux.dev>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=7267;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=/lmr5R1V4hK43zv0BnO4dkyfmN+kPBiDyJMM/7lu7/A=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpYfg3x6ypVlkBQJwmswe2FXMz7G7MGJ1fDpFln
 1pFCH7X1TiJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaWH4NwAKCRBVnxHm/pHO
 9VtWB/4naD0ChYSkykbh0J0iwlyz5udE3fk8jhSBChLmrtWJLfi2jntQOHRi08EqMhbLvTqMzpK
 GZiH2UeTTs3vUPilgQewA7LdK4uJjupNGeGx5LI8gHj63Zxdu46vl/Vi8M+nrTsQQ9gVVzKrsxL
 NZIVGd1NblOCf7qa0p8xiHJ02fVWISndBgUoEKABCZZ3Ifqw+skTjEvnDNt+d5hM8rQI0ffeaZT
 xarDVP5JWAd2lcnzo1k5bMZkjIt7ZB2mVVyQbPG8zyIiDbS3vnH/opbGo2m9EOohLQshlR7CiJ5
 nVT1ILMw5/wPBTf7ocB+WrgoZKbn8PngWEGplUdTj7df/liT
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

Hi,

This series is the continuation of the series [1] that added the initial support
for the PCIe M.2 connectors. This series extends it by adding support for Key E
connectors. These connectors are used to connect the Wireless Connectivity
devices such as WiFi, BT, NFC and GNSS devices to the host machine over
interfaces such as PCIe/SDIO, USB/UART and NFC. This series adds support for
connectors that expose PCIe interface for WiFi and UART interface for BT. Other
interfaces are left for future improvements.

Serdev device support for BT
============================

Adding support for the PCIe interface was mostly straightforward and a lot
similar to the previous Key M connector. But adding UART interface has proved to
be tricky. This is mostly because of the fact UART is a non-discoverable bus,
unlike PCIe which is discoverable. So this series relied on the PCI notifier to
create the serdev device for UART/BT. This means the PCIe interface will be
brought up first and after the PCIe device enumeration, the serdev device will
be created by the pwrseq driver. This logic is necessary since the connector
driver and DT node don't describe the device, but just the connector. So to make
the connector interface Plug and Play, the connector driver uses the PCIe device
ID to identify the card and creates the serdev device. This logic could be
extended in the future to support more M.2 cards. Even if the M.2 card uses SDIO
interface for connecting WLAN, a SDIO notifier could be added to create the
serdev device.

Open questions
==============

Though this series adds the relevant functionality for handling the M.2 Key M
connectors, there are still a few open questions exists on the design. 

1. I've used the DT compatible for the serdev swnode to match the existing OF
device_id of the bluetooth driver. This avoids implementing custom serdev id
matching as implemented till v2.

2. PCIe client drivers of some M.2 WLAN cards like the Qcom QCA6390, rely on
the PCIe device DT node to extract properties such as
'qcom,calibration-variant', 'firmware-name', etc... For those drivers, should we
add the PCIe DT node in the Root Port in conjunction with the Port node as
below?

pcie@0 {
	wifi@0 {
		compatible = "pci17cb,1103";
		...
		qcom,calibration-variant = "LE_X13S";
	};

	port {
		pcie4_port0_ep: endpoint {
			remote-endpoint = <&m2_e_pcie_ep>;
		};
	};
};

This will also require marking the PMU supplies optional in the relevant ath
bindings for M.2 cards.

3. Some M.2 cards require specific power up sequence like delays between
regulator/GPIO and such. For instance, the WCN7850 card supported in this series
requires 50ms delay between powering up an interface and driving it. I've just
hardcoded the delay in the driver, but it is a pure hack. Since the pwrseq
driver doesn't know anything about the device it is dealing with before powering
it ON, how should it handle the device specific power requirements? Should we
hardcode the device specific property in the connector node? But then, it will
no longer become a generic M.2 connector and sort of defeats the purpose of the
connector binding.

I hope to address these questions with the help of the relevant subsystem
maintainers and the community. 

Testing
=======

This series, together with the devicetree changes [2] was tested on the
Qualcomm X1e based Lenovo Thinkpad T14s Laptop which has the WCN7850 WLAN/BT
1620 LGA card connected over PCIe and UART.

Dependency
==========

This series is dependent on the M.2 Key M series [1] on top of v6.19-rc1.

[1] https://lore.kernel.org/linux-pci/20260107-pci-m2-v5-0-8173d8a72641@oss.qualcomm.com
[2] https://github.com/Mani-Sadhasivam/linux/commit/753033861360171f2af1fdd56e8985ff916e1ac2

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
Changes in v3:
- Switched to swnode for the serdev device and dropped the custom
  serdev_device_id related patches
- Added new swnode APIs to match the swnode with existing of_device_id
- Incorporated comments in the bindings patch
- Dropped the UIM interface from binding since it is not clear how it should get
  wired
- Incorporated comments in the pwrseq driver patch
- Splitted the pwrseq patch into two
- Added the 1620 LGA compatible with Key E fallback based on Stephan's finding
- Link to v2: https://lore.kernel.org/r/20251125-pci-m2-e-v2-0-32826de07cc5@oss.qualcomm.com

Changes in v2:
- Used '-' for GPIO names in the binding and removed led*-gpios properties
- Described the endpoint nodes for port@0 and port@1 nodes
- Added the OF graph port to the serial binding
- Fixed the hci_qca driver to return err if devm_pwrseq_get() fails
- Incorporated various review comments in pwrseq driver
- Collected Ack
- Link to v1: https://lore.kernel.org/r/20251112-pci-m2-e-v1-0-97413d6bf824@oss.qualcomm.com

---
Manivannan Sadhasivam (13):
      serdev: Convert to_serdev_*() helpers to macros and use container_of_const()
      serdev: Add an API to find the serdev controller associated with the devicetree node
      software node: Add software_node_match_device() API
      software node: Add software_node_device_uevent() API
      software node: Add software_node_device_modalias() API
      serdev: Do not return -ENODEV from of_serdev_register_devices() if external connector is used
      serdev: Add support for swnode based driver matching and uevent/modalias
      dt-bindings: serial: Document the graph port
      dt-bindings: connector: Add PCIe M.2 Mechanical Key E connector
      dt-bindings: connector: m2: Add M.2 1620 LGA soldered down connector
      Bluetooth: hci_qca: Add M.2 Bluetooth device support using pwrseq
      power: sequencing: pcie-m2: Add support for PCIe M.2 Key E connectors
      power: sequencing: pcie-m2: Create serdev device for WCN7850 bluetooth

Sui Jingfeng (1):
      software node: Implement device_get_match_data fwnode callback

 .../bindings/connector/pcie-m2-e-connector.yaml    | 161 ++++++++++++++
 .../devicetree/bindings/serial/serial.yaml         |   3 +
 MAINTAINERS                                        |   1 +
 drivers/base/swnode.c                              |  71 +++++++
 drivers/bluetooth/hci_qca.c                        |   9 +
 drivers/power/sequencing/Kconfig                   |   1 +
 drivers/power/sequencing/pwrseq-pcie-m2.c          | 234 ++++++++++++++++++++-
 drivers/tty/serdev/core.c                          |  45 +++-
 include/linux/property.h                           |   5 +
 include/linux/serdev.h                             |  24 +--
 10 files changed, 528 insertions(+), 26 deletions(-)
---
base-commit: cb6649f6217c0331b885cf787f1d175963e2a1d2
change-id: 20251112-pci-m2-e-94695ac9d657
prerequisite-message-id: 20251125-pci-m2-v3-0-c528042aea47@oss.qualcomm.com
prerequisite-patch-id: 58778d8eb97ab86008cd48fb5d28ed6cc0bbbc1b
prerequisite-patch-id: 2dd7d793a67f59ef6e6b5137e69436896198b965
prerequisite-patch-id: 8ccaa5fdd95e64e69cd942f93c26e89b827d0453
prerequisite-patch-id: 3d3e1bb7959ab1e140c5024acdd8655e7a7e99ef

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>



