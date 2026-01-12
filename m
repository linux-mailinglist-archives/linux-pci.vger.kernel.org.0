Return-Path: <linux-pci+bounces-44517-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D260D13FB8
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 17:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 092A4300CAD3
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 16:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF875366DC3;
	Mon, 12 Jan 2026 16:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cQufjzlZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D25365A09;
	Mon, 12 Jan 2026 16:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768235313; cv=none; b=sOfW6MpPJgjzD766lBjmWZGfyTDXy3KoIOqaQaCRfJd0gRK1tpCqBl3TKwWW6GwLWR0Xko4BE6EX2gwJx8lPFIO693ghpuByjdTUKNgkAO+fqeewkCmulbCxx/p/qsxntSFk82d8IGJTzQJ/gRH0eoneDYySCmTtG/vFfh6F/OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768235313; c=relaxed/simple;
	bh=9S9KztO8/ZYkPDYvEOYZP3UT7oEj1fzgnUHdhGGOUPY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PKvviIxhvV1LKMth2aYpAn6kasMxz9OqhwjMOHrrNk7it+8Qi1YCz4lZ4gUxWoPxzlvv5ynyoSeXU309ACluBA1LNlbR4KA/7oS5CMFSauHczP3cZWzH2Vu+thAq0naaeJjDI+fkkz5JB17EdrdNp3xasn2gwD/8aEZKp1mDFkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cQufjzlZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DFBCBC116D0;
	Mon, 12 Jan 2026 16:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768235313;
	bh=9S9KztO8/ZYkPDYvEOYZP3UT7oEj1fzgnUHdhGGOUPY=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=cQufjzlZ2QA792AyEfJV6UOyuuAG93SMg3NeKSMHWjtWf2QwDp33o7XHbSjfsC0cH
	 RBRZ4mvvd7KdCRg6lQIlIX/gskUjlbfX+jtVWu8yOE2p8Mi24pKRZrtBkjNq5M+BBv
	 Nwjilu5z9QnRgHQ2NphMFy+JDouQ7xerqzmkWbkjLC0Y6lPAGxgWVIKPO9FcR4cYe9
	 g0Fy97SdQSxGon0gr7tqlr5XiivnEXHrSw7KeuoGM5I4Tc/rIWardPEt9axmp3vUpr
	 5QjYjT7SISj73wTym5M25hv2bcABQ7q4CF2dRYMzohY0OF0HqrYFNrVPrEEG3iWIf8
	 SZFNQbdja0PEA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A1CC9EC7A;
	Mon, 12 Jan 2026 16:28:32 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Subject: [PATCH v4 0/9] Add support for handling PCIe M.2 Key E connectors
 in devicetree
Date: Mon, 12 Jan 2026 21:55:59 +0530
Message-Id: <20260112-pci-m2-e-v4-0-eff84d2c6d26@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJcgZWkC/3WQ3WrDMAxGXyX4eg624p8kV32PsQvXVlbD0rR2a
 lpK331KyiBs3Y3gEz5Hlu4sY4qYWV/dWcISc5yOFNRbxfzBHT+Rx0CZgQAtpQR+8pGPwJF3ynT
 a+S4YbRk9PyUc4nVVvX9QPsQ8T+m2motcui8kRXLBO6tkE8x+aEHtppzr88V9+WkcaypscRXY8
 KA3PBDfQAsmoLDe63/45oc3Qkqx4Rvi1eAQbRBBO3zBP57LJTxf6Dzzc0M2Ys5uPU9f/f7XavU
 aWqHAoVP2r5Wce5eRL40491UxtWx58pLmPb4BaKXlIpYBAAA=
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
 Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 linux-pm@vger.kernel.org, Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 linux-acpi@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=7020;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=9S9KztO8/ZYkPDYvEOYZP3UT7oEj1fzgnUHdhGGOUPY=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpZSEtGGfSh/B1nXp79dZ8tN42YNlOmlhU2XEVl
 IfM9hdzOWaJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaWUhLQAKCRBVnxHm/pHO
 9eATB/9I4PeXTjoeXCEcZ8gzOFHC+k+q1MX2Q0KbtUm5/UeLw3/wtmHj8kFe+mC3UfGbn6hud5V
 Ehx1diBiHlWBykDmTFJQTEkFhMdu/1Xq1h7j1osWieFndkoob+y4ThvytUW1Q1ua5awlGWooixA
 0yIABdgB/RikR5nLcyUZqUOvD9SuGQRn7Cihks4FXyC32sTULnvNoOvBhhMLLMwTN6ab7YWxe8u
 k9Rzjl533ObbpeGrV14Hlvdv9d+uONSWQDHHeIVrMpMwtDVseM+fCxGwxSyP8NRsp9GvbSDF6Gq
 dHFOzGmcl0AOu8aOTi43GLennHP5oa4w2XPj+dl6A2Pwvd2u
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

1. Created a dynamic 'bluetooth' node with the compatible property matching the
WCN7850 device and attached it to the serdev device. This allowed reusing the
existing OF based BT driver without much modifications.

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
Changes in v4:
- Switched to dynamic OF node for serdev instead of swnode and dropped all
  swnode related patches
- Link to v3: https://lore.kernel.org/r/20260110-pci-m2-e-v3-0-4faee7d0d5ae@oss.qualcomm.com

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
Manivannan Sadhasivam (9):
      serdev: Convert to_serdev_*() helpers to macros and use container_of_const()
      serdev: Add an API to find the serdev controller associated with the devicetree node
      serdev: Do not return -ENODEV from of_serdev_register_devices() if external connector is used
      dt-bindings: serial: Document the graph port
      dt-bindings: connector: Add PCIe M.2 Mechanical Key E connector
      dt-bindings: connector: m2: Add M.2 1620 LGA soldered down connector
      Bluetooth: hci_qca: Add M.2 Bluetooth device support using pwrseq
      power: sequencing: pcie-m2: Add support for PCIe M.2 Key E connectors
      power: sequencing: pcie-m2: Create serdev device for WCN7850 bluetooth

 .../bindings/connector/pcie-m2-e-connector.yaml    | 161 ++++++++++++
 .../devicetree/bindings/serial/serial.yaml         |   3 +
 MAINTAINERS                                        |   1 +
 drivers/bluetooth/hci_qca.c                        |   9 +
 drivers/power/sequencing/Kconfig                   |   1 +
 drivers/power/sequencing/pwrseq-pcie-m2.c          | 278 ++++++++++++++++++++-
 drivers/tty/serdev/core.c                          |  25 +-
 include/linux/serdev.h                             |  24 +-
 8 files changed, 482 insertions(+), 20 deletions(-)
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



