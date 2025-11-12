Return-Path: <linux-pci+bounces-40995-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AB627C52D14
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 15:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 03B7634EEB3
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 14:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8D6342534;
	Wed, 12 Nov 2025 14:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DD47qKdS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5695E340DA1;
	Wed, 12 Nov 2025 14:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762958731; cv=none; b=sAdGrUIut7I21WjmBA31FMP7c1hFZgvU8v6OctXRFepWhRTygjX/bqfR8QKBdyajC8SfESqd9am6maSeAU3f0Bx5zbGmn9g2z0JyYgT5ULWBi6JuSMqQOEIsyfEhOpUwho1ABABHhDt+NRRBORv3dFnnKBm41rJA+71av1MrkE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762958731; c=relaxed/simple;
	bh=fcOLB6aV+fb9mRzie6Oop52h19x8OdlUrwUv/AKoKFg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JSyWC3Te7D6FADdb7XhMzMxFFhtC2dSiM2WFmtl1DKZF0W7S0tmOA3dyAgbPgOcBKHpAjdYQYF7p329XkTtJqNBupimuDog9qldCWCTSrnOIRmX0M0PyKy0a2bSpWTgr6SCmI4pR1BIL9aUKO4bVJ/WDuIyvclR4f6PUV9sRVVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DD47qKdS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DA33FC4CEF7;
	Wed, 12 Nov 2025 14:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762958730;
	bh=fcOLB6aV+fb9mRzie6Oop52h19x8OdlUrwUv/AKoKFg=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=DD47qKdSYQ2MPF/TkXcFFe0n9leIQo0XfMLbzvkaLamsT0/2HIWyknK4dmpk/dJlR
	 dX21PGHPhCCkzk8lfNWXAUzVbhlINu8tPnh1KG4uzX7ZabO4ql3vIUzJpBRI25y+I6
	 SpoeJWQPQT65DqXLpNWqI0q9CtgAbgIz/QWoRL1KZwSyKhNGx76t5EkzxTgd1CttrZ
	 rCbzwnGZotWelmt1HGXJ4WD+FaQUEUS5d4Li+T1qppL0jd0RH4juRL3c5a8UwZvRpn
	 WY5CkaMk4qz5iPaPqqImA1GAF260TzRQKqGzGzpHhf7MU9imtKis0bzrDNw/VHwYS/
	 3dliOTMtOMdhg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7606CCF9E3;
	Wed, 12 Nov 2025 14:45:30 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Subject: [PATCH 0/9] Add support for handling PCIe M.2 Key E connectors in
 devicetree
Date: Wed, 12 Nov 2025 20:15:12 +0530
Message-Id: <20251112-pci-m2-e-v1-0-97413d6bf824@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHidFGkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDQ0Mj3YLkTN1cI91UXUsTM0vTxGTLFDNTcyWg8oKi1LTMCrBR0bG1tQB
 YQKlsWgAAAA==
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
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5716;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=fcOLB6aV+fb9mRzie6Oop52h19x8OdlUrwUv/AKoKFg=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpFJ2G7KlzBgIqqLqxlA+KZvF2LQnt5o2J4sC6m
 5T22DpFW/+JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaRSdhgAKCRBVnxHm/pHO
 9QjrB/9XHscvM2AZEr4cvvGDU7LjMbW+6OH13K8HChauuQQq1sQCyda01k1+C75y7jgDegnxjIn
 r/fanARmC5BGZzRB7ZqmyhtHbsc6bfXuHVAYY9mf21mbN04Yt15eeIDlBTlrblXStHlXP14Iu7H
 gjw3GxZ8oMZM/6oaqpcjJjFUNGRC1TWsWnL1V84Ao9qRMJ75TN2fLZyG+4Pd7m803HQEDmIjFZR
 qvZfU3tT96zNXbmmhFkxKgPsvOk9XV104b84AvbJlgjDhuYnU7Y2j4x7J1Y5kdZGUa6zIHnXUiD
 OUpq3nlOAZCKUrLvb5zIfglGBLIUYTafIbPLj2me6+pJP+Cg
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
maintainers and the community. Until then, this series is *not* mergeable as a
whole.

Testing
=======

This series, together with the devicetree changes [2] was tested on the
Qualcomm X1e based Lenovo Thinkpad T14s Laptop which has the WCN7850 WLAN/BT M.2
card connected over PCIe and UART.

[1] https://lore.kernel.org/linux-pci/20251108-pci-m2-v2-0-e8bc4d7bf42d@oss.qualcomm.com
[2] https://github.com/Mani-Sadhasivam/linux/commit/d39b81b3ff1ecfb0d423b4da0771925d41648b5a

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
Manivannan Sadhasivam (9):
      serdev: Convert to_serdev_device() and to_serdev_controller() helpers to macros
      serdev: Add serdev device based driver match support
      serdev: Allow passing the serdev device name to serdev_device_add()
      serdev: Add an API to find the serdev controller associated with the devicetree node
      serdev: Add modalias support for serdev client devices
      serdev: Skip registering serdev devices from DT is external connector is used
      dt-bindings: connector: Add PCIe M.2 Mechanical Key E connector
      Bluetooth: hci_qca: Add support for WCN7850 PCIe M.2 card
      power: sequencing: pcie-m2: Add support for PCIe M.2 Key E connectors

 .../bindings/connector/pcie-m2-e-connector.yaml    | 154 +++++++++++++++
 MAINTAINERS                                        |   1 +
 drivers/bluetooth/hci_qca.c                        |  20 ++
 drivers/platform/x86/dell/dell-uart-backlight.c    |   2 +-
 .../x86/lenovo/yoga-tab2-pro-1380-fastcharger.c    |   2 +-
 drivers/platform/x86/x86-android-tablets/core.c    |   2 +-
 drivers/power/sequencing/Kconfig                   |   1 +
 drivers/power/sequencing/pwrseq-pcie-m2.c          | 218 ++++++++++++++++++++-
 drivers/tty/serdev/core.c                          |  77 +++++++-
 include/linux/mod_devicetable.h                    |   8 +
 include/linux/serdev.h                             |  25 ++-
 scripts/mod/devicetable-offsets.c                  |   3 +
 scripts/mod/file2alias.c                           |   8 +
 13 files changed, 494 insertions(+), 27 deletions(-)
---
base-commit: db81ec30672bb228cd7cd809edeeae661d621f2d
change-id: 20251112-pci-m2-e-94695ac9d657

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>



