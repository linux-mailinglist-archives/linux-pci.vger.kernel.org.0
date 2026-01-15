Return-Path: <linux-pci+bounces-44931-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E14D23F1B
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 11:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D6B56301D2C5
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 10:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9D336A017;
	Thu, 15 Jan 2026 10:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mTAMhOX7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E228435CBD3;
	Thu, 15 Jan 2026 10:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768473017; cv=none; b=tKAKaWPtDzLLfWDH6ekuCx8t61Y6uHbowTWu7aNaYfaWsUSJYz57xfpK4/64hxNVwLpkJMuoRjpnIYWdf9GeeP0xvlLBOifSrA0px9mHesZyvIlQBQexVjxJHB9JOvUBoEfvbqSAV8u4qKTRvuGXeMoFuR3uGnYoZkAPd3kF31w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768473017; c=relaxed/simple;
	bh=9OCR6Ca6AuZoPX8A29sd1wcDstFialVmBPp+6yUduaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MwaQyWOnkK1zd3moXBh8HgnnNdlNZN/MIRL/ytKl7bpNGt2pogsWqCcJSDKnK2ZLFuugdIrKKyAgctA1ErntkxOothWvUgdXmtGZGJuwn92ZkF3ok1B4vEIN6kb5kYGyplaDy95xXOfgYPmqK/cRXpUHqbEULOtNpEXpxyGV0Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mTAMhOX7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19BA5C19424;
	Thu, 15 Jan 2026 10:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768473016;
	bh=9OCR6Ca6AuZoPX8A29sd1wcDstFialVmBPp+6yUduaA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mTAMhOX79uyIEiuo//R2zzN+3YTmjwS4nYW4IpuECej+biBiCCYWqIfYSrTiywVu5
	 4Mv2zoeIBXVLG6mS5ZWToTPrCgulKM8Aeuuw0G4po4UD28tlzENYY+f01D9DOcYooQ
	 HhQeKRPtDZoFBJOG2+zDV3rGI10hg1eeVrmn4g+WzUcV8iBdtPRnxTIL6RqDmkj6Vx
	 TQSFDhRBo0idjQCZd+6zYxCcviJ6IjlQbzKfF/0IFdRD09Y3fXAw/5eCh1kbYRsFg7
	 vpmCWYUiDz1B4u0EdaUbpVcl+k05DespLzg0xylLfYEd9S5w0ggDeYoUyLJw6UNRjK
	 SqnoIoqAsAU+A==
Message-ID: <49d82723-2389-4d6f-a07e-2b522c52bde8@kernel.org>
Date: Thu, 15 Jan 2026 11:30:09 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/9] Add support for handling PCIe M.2 Key E connectors
 in devicetree
To: manivannan.sadhasivam@oss.qualcomm.com, Rob Herring <robh@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nicolas.schier@linux.dev>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 "Derek J. Clark" <derekjohn.clark@gmail.com>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Marcel Holtmann <marcel@holtmann.org>,
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
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20260112-pci-m2-e-v4-0-eff84d2c6d26@oss.qualcomm.com>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <20260112-pci-m2-e-v4-0-eff84d2c6d26@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mani,

On 12-Jan-26 17:25, Manivannan Sadhasivam via B4 Relay wrote:
> Hi,
> 
> This series is the continuation of the series [1] that added the initial support
> for the PCIe M.2 connectors. This series extends it by adding support for Key E
> connectors. These connectors are used to connect the Wireless Connectivity
> devices such as WiFi, BT, NFC and GNSS devices to the host machine over
> interfaces such as PCIe/SDIO, USB/UART and NFC. This series adds support for
> connectors that expose PCIe interface for WiFi and UART interface for BT. Other
> interfaces are left for future improvements.

Thank you for your work on this.

I've tested this on a ThinkPad T14s gen 6 together with your DTS changes
for the T14s.

I started out with CONFIG_POWER_SEQUENCING_PCIE_M2=m and that does not work.
I think it might be easiest to just change that option to a boolean option.

Tested-by: Hans de Goede <johannes.goede@oss.qualcomm.com> # ThinkPad T14s gen6 (arm64)

Regards,

Hans







> Serdev device support for BT
> ============================
> 
> Adding support for the PCIe interface was mostly straightforward and a lot
> similar to the previous Key M connector. But adding UART interface has proved to
> be tricky. This is mostly because of the fact UART is a non-discoverable bus,
> unlike PCIe which is discoverable. So this series relied on the PCI notifier to
> create the serdev device for UART/BT. This means the PCIe interface will be
> brought up first and after the PCIe device enumeration, the serdev device will
> be created by the pwrseq driver. This logic is necessary since the connector
> driver and DT node don't describe the device, but just the connector. So to make
> the connector interface Plug and Play, the connector driver uses the PCIe device
> ID to identify the card and creates the serdev device. This logic could be
> extended in the future to support more M.2 cards. Even if the M.2 card uses SDIO
> interface for connecting WLAN, a SDIO notifier could be added to create the
> serdev device.
> 
> Open questions
> ==============
> 
> Though this series adds the relevant functionality for handling the M.2 Key M
> connectors, there are still a few open questions exists on the design. 
> 
> 1. Created a dynamic 'bluetooth' node with the compatible property matching the
> WCN7850 device and attached it to the serdev device. This allowed reusing the
> existing OF based BT driver without much modifications.
> 
> 2. PCIe client drivers of some M.2 WLAN cards like the Qcom QCA6390, rely on
> the PCIe device DT node to extract properties such as
> 'qcom,calibration-variant', 'firmware-name', etc... For those drivers, should we
> add the PCIe DT node in the Root Port in conjunction with the Port node as
> below?
> 
> pcie@0 {
> 	wifi@0 {
> 		compatible = "pci17cb,1103";
> 		...
> 		qcom,calibration-variant = "LE_X13S";
> 	};
> 
> 	port {
> 		pcie4_port0_ep: endpoint {
> 			remote-endpoint = <&m2_e_pcie_ep>;
> 		};
> 	};
> };
> 
> This will also require marking the PMU supplies optional in the relevant ath
> bindings for M.2 cards.
> 
> 3. Some M.2 cards require specific power up sequence like delays between
> regulator/GPIO and such. For instance, the WCN7850 card supported in this series
> requires 50ms delay between powering up an interface and driving it. I've just
> hardcoded the delay in the driver, but it is a pure hack. Since the pwrseq
> driver doesn't know anything about the device it is dealing with before powering
> it ON, how should it handle the device specific power requirements? Should we
> hardcode the device specific property in the connector node? But then, it will
> no longer become a generic M.2 connector and sort of defeats the purpose of the
> connector binding.
> 
> I hope to address these questions with the help of the relevant subsystem
> maintainers and the community. 
> 
> Testing
> =======
> 
> This series, together with the devicetree changes [2] was tested on the
> Qualcomm X1e based Lenovo Thinkpad T14s Laptop which has the WCN7850 WLAN/BT
> 1620 LGA card connected over PCIe and UART.
> 
> Dependency
> ==========
> 
> This series is dependent on the M.2 Key M series [1] on top of v6.19-rc1.
> 
> [1] https://lore.kernel.org/linux-pci/20260107-pci-m2-v5-0-8173d8a72641@oss.qualcomm.com
> [2] https://github.com/Mani-Sadhasivam/linux/commit/753033861360171f2af1fdd56e8985ff916e1ac2
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
> Changes in v4:
> - Switched to dynamic OF node for serdev instead of swnode and dropped all
>   swnode related patches
> - Link to v3: https://lore.kernel.org/r/20260110-pci-m2-e-v3-0-4faee7d0d5ae@oss.qualcomm.com
> 
> Changes in v3:
> - Switched to swnode for the serdev device and dropped the custom
>   serdev_device_id related patches
> - Added new swnode APIs to match the swnode with existing of_device_id
> - Incorporated comments in the bindings patch
> - Dropped the UIM interface from binding since it is not clear how it should get
>   wired
> - Incorporated comments in the pwrseq driver patch
> - Splitted the pwrseq patch into two
> - Added the 1620 LGA compatible with Key E fallback based on Stephan's finding
> - Link to v2: https://lore.kernel.org/r/20251125-pci-m2-e-v2-0-32826de07cc5@oss.qualcomm.com
> 
> Changes in v2:
> - Used '-' for GPIO names in the binding and removed led*-gpios properties
> - Described the endpoint nodes for port@0 and port@1 nodes
> - Added the OF graph port to the serial binding
> - Fixed the hci_qca driver to return err if devm_pwrseq_get() fails
> - Incorporated various review comments in pwrseq driver
> - Collected Ack
> - Link to v1: https://lore.kernel.org/r/20251112-pci-m2-e-v1-0-97413d6bf824@oss.qualcomm.com
> 
> ---
> Manivannan Sadhasivam (9):
>       serdev: Convert to_serdev_*() helpers to macros and use container_of_const()
>       serdev: Add an API to find the serdev controller associated with the devicetree node
>       serdev: Do not return -ENODEV from of_serdev_register_devices() if external connector is used
>       dt-bindings: serial: Document the graph port
>       dt-bindings: connector: Add PCIe M.2 Mechanical Key E connector
>       dt-bindings: connector: m2: Add M.2 1620 LGA soldered down connector
>       Bluetooth: hci_qca: Add M.2 Bluetooth device support using pwrseq
>       power: sequencing: pcie-m2: Add support for PCIe M.2 Key E connectors
>       power: sequencing: pcie-m2: Create serdev device for WCN7850 bluetooth
> 
>  .../bindings/connector/pcie-m2-e-connector.yaml    | 161 ++++++++++++
>  .../devicetree/bindings/serial/serial.yaml         |   3 +
>  MAINTAINERS                                        |   1 +
>  drivers/bluetooth/hci_qca.c                        |   9 +
>  drivers/power/sequencing/Kconfig                   |   1 +
>  drivers/power/sequencing/pwrseq-pcie-m2.c          | 278 ++++++++++++++++++++-
>  drivers/tty/serdev/core.c                          |  25 +-
>  include/linux/serdev.h                             |  24 +-
>  8 files changed, 482 insertions(+), 20 deletions(-)
> ---
> base-commit: cb6649f6217c0331b885cf787f1d175963e2a1d2
> change-id: 20251112-pci-m2-e-94695ac9d657
> prerequisite-message-id: 20251125-pci-m2-v3-0-c528042aea47@oss.qualcomm.com
> prerequisite-patch-id: 58778d8eb97ab86008cd48fb5d28ed6cc0bbbc1b
> prerequisite-patch-id: 2dd7d793a67f59ef6e6b5137e69436896198b965
> prerequisite-patch-id: 8ccaa5fdd95e64e69cd942f93c26e89b827d0453
> prerequisite-patch-id: 3d3e1bb7959ab1e140c5024acdd8655e7a7e99ef
> 
> Best regards,


