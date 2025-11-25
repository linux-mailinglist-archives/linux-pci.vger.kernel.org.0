Return-Path: <linux-pci+bounces-42048-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7719C85829
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 15:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 873693B4BAF
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 14:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583E53271ED;
	Tue, 25 Nov 2025 14:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dL4O+H3y"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86719324B2E;
	Tue, 25 Nov 2025 14:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764081911; cv=none; b=rxWNtK9JKNGYChyhtknrZSVU5hM4x7extJtt09FX/d4B73d6AODF/WqE/lOfP3AtM362Dn+bCGW0/ZALHW3ohx9slEClqFCNdU5A/T5R76mjOHXwno3KVATjK6HEiQ7Y/6/bOpig6wEU41w7mkFTT2G4xFgqKwJzeNgnmVl2yr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764081911; c=relaxed/simple;
	bh=uTECYDxx3v1bGzayL89lryGm1s4nv9vi4GpwLXVtnRY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SRv3yF9fD350BLnmnQX7BoZMBMGU7DiVGiXqmTrawn7LiRnSKBI5ttEHQYZdQyiicER/NHsTKFGTie3/2t6fZKqTNWPoRmwB8MuiSm32m4k5hOWjAZj86w9EpGdf25QbdD92sXHCaAdaWh0vd0w+sygy6DYmvlA/dxcQkZ5mX78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dL4O+H3y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EF823C4CEF1;
	Tue, 25 Nov 2025 14:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764081911;
	bh=uTECYDxx3v1bGzayL89lryGm1s4nv9vi4GpwLXVtnRY=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=dL4O+H3ykDcy2uUZ6vMaf+aASZpinT///lkx7BvJsJGjHJFGlCFNSziI7vYYtoTKs
	 xyop0BHzyCBVG6AD99UcjYGU5Dob2fi/5X0VLgsWadAamhh7cDdg5YhAGV83jQjeqZ
	 9WC6TfdmnO3x4Oj+SBVQykg3a8sEB/mDgGJupSkxAdyjrz0ORbnwKBhvrvNSCrn5TJ
	 QROP18q5ZwbfMpWmU8xTHv6sa3BaPVs/hXZ3H41RygiJDIO4MlUDlmb+ZYWtuH5D3q
	 /vi2xevwO4VTUOvcTnGClv0jXT/K5QvXDl4ij8rkpO5YDbPFmTnVnzK6r34FXfsAp7
	 jwoSNm+h4mVkg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D51CAD0E6C6;
	Tue, 25 Nov 2025 14:45:10 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Subject: [PATCH v2 00/10] Add support for handling PCIe M.2 Key E
 connectors in devicetree
Date: Tue, 25 Nov 2025 20:15:04 +0530
Message-Id: <20251125-pci-m2-e-v2-0-32826de07cc5@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPDAJWkC/23OzwrCMAwG8FcZPZuxxnZ/PPkeskPtohacm80sy
 vDdjRNPegl8IfzyzYopBmK1yWYVKQUOw0UCrjLlT+5yJAidZIUFWq01wugD9AgEjSkb63zTlbZ
 Scj5GOoT7Qu1ayafA0xAfi5z0e/sHSRoKaCqj1125P9RotgNzfr25sx/6Ppeh2ucHj3S9Sb3p8
 0H1xOyWetJ2cdF+3bQW1VusC4OOnKl+VTH3jgneizBtslTmuobotfx7vgCNIuqzFgEAAA==
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
 Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 linux-pm@vger.kernel.org, Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6676;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=uTECYDxx3v1bGzayL89lryGm1s4nv9vi4GpwLXVtnRY=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpJcDxM2Jy7w/KJCb/fDPfjtzVC0c80RYMWpVsy
 RvZgIAfyuaJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaSXA8QAKCRBVnxHm/pHO
 9SCLB/9+huQ91JOYLD8k5L9pr5D9iwA3Gzsmtnb/InTVHyMNpl1ZcaLZLnG0TfekdU7Uucs3bqW
 lbQhzehgnPRjA1ZceIAMl8GWm6e4bFtKBsCXDGgaczsr02Z+dmjkbvo2IbHr0fpFf//0cQM/yTm
 2kUEK1Q/uPAI1FdE/BuLRfuOWqsyVGWuhROsSF/+1S7nHFXNJi0e26wWBsEbh+WzTOVIgbKCDnW
 kSweB+UBaV2L30XXTlVr0SEXmDsKu/UJpM8/2K6Vyd5k1TI99JeUuCH1j13tHLRdIWEM/JNu2L6
 WNSTvfD68P+VA7dWeawbyXi9P2Q4dauUHpyBYI/3kRcYeRWD
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

1. I've used the M.2 card model name as the serdev device name. This is found
out by comparing the PCIe VID:PID in the notifier. Is this approach acceptable?
I did not use the PID as the serdev name since it will vary if the SDIO
interface is used in the future.

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
Qualcomm X1e based Lenovo Thinkpad T14s Laptop which has the WCN7850 WLAN/BT M.2
card connected over PCIe and UART.

Dependency
==========

This series is dependent on the M.2 Key M series [1] on top of v6.18-rc1.

[1] https://lore.kernel.org/linux-pci/20251125-pci-m2-v3-0-c528042aea47@oss.qualcomm.com
[2] https://github.com/Mani-Sadhasivam/linux/commit/acbee74a5c90fc8839bb7b6f326c677ee1c0d89c

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
Changes in v2:
- Used '-' for GPIO names in the binding and removed led*-gpios properties
- Described the endpoint nodes for port@0 and port@1 nodes
- Added the OF graph port to the serial binding
- Fixed the hci_qca driver to return err if devm_pwrseq_get() fails
- Incorporated various review comments in pwrseq driver
- Collected Ack
- Link to v1: https://lore.kernel.org/r/20251112-pci-m2-e-v1-0-97413d6bf824@oss.qualcomm.com

---
Manivannan Sadhasivam (10):
      serdev: Convert to_serdev_*() helpers to macros and use container_of_const()
      serdev: Add serdev device based driver match support
      serdev: Allow passing the serdev device name to serdev_device_add()
      serdev: Add an API to find the serdev controller associated with the devicetree node
      serdev: Add modalias support for serdev client devices
      dt-bindings: serial: Document the graph port
      serdev: Do not return -ENODEV from of_serdev_register_devices() if external connector is used
      dt-bindings: connector: Add PCIe M.2 Mechanical Key E connector
      Bluetooth: hci_qca: Add support for WCN7850 PCIe M.2 card
      power: sequencing: pcie-m2: Add support for PCIe M.2 Key E connectors

 .../bindings/connector/pcie-m2-e-connector.yaml    | 178 ++++++++++++++++++
 .../devicetree/bindings/serial/serial.yaml         |   3 +
 MAINTAINERS                                        |   1 +
 drivers/bluetooth/hci_qca.c                        |  19 ++
 drivers/platform/x86/dell/dell-uart-backlight.c    |   2 +-
 .../x86/lenovo/yoga-tab2-pro-1380-fastcharger.c    |   2 +-
 drivers/platform/x86/x86-android-tablets/core.c    |   2 +-
 drivers/power/sequencing/Kconfig                   |   1 +
 drivers/power/sequencing/pwrseq-pcie-m2.c          | 205 ++++++++++++++++++++-
 drivers/tty/serdev/core.c                          |  76 +++++++-
 include/linux/mod_devicetable.h                    |   8 +
 include/linux/serdev.h                             |  30 +--
 scripts/mod/devicetable-offsets.c                  |   3 +
 scripts/mod/file2alias.c                           |   8 +
 14 files changed, 505 insertions(+), 33 deletions(-)
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



