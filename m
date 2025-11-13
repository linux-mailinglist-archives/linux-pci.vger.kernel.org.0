Return-Path: <linux-pci+bounces-41057-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D7FC55C67
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 06:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C391E3AE6C1
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 05:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57A130ACF3;
	Thu, 13 Nov 2025 05:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g6x/AwVc"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E433016E4;
	Thu, 13 Nov 2025 05:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763010814; cv=none; b=P4TCz3yI0UYmZz4QqEnxdUN8yvVfO53sUKF5SkhjF4g8CFuRr3DE3AHz03QbOy6u4WrTZUli2+xYhB8R67KOi95jGOcQpaS2sHugmBQntkLUrzQozXS5zPdZTe08sVszXPsU0b0AVg8cD4wXZAwDjGp/j9swABJD9fW7pKUD/9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763010814; c=relaxed/simple;
	bh=s05zEuX8NlbM7zMqx8k2Ze9DCxOVUEWrwFdlI0JsaOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RTVke9tsqQEqYapgeW/LPK/fYFmcQ/l6M3eViixA+BdcEXH4W1Q+PzMLalKPtifug8uiL43FaX0kepIX73LbCo7IvtNKBGBnb4rCQN4AA+1i0lNPl8dNHHr1HChMuVeOkoKYUpPSqpuR4ID4LSOBltotLO7Et2c44uPakQUVm04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g6x/AwVc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A64EC4CEF5;
	Thu, 13 Nov 2025 05:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763010814;
	bh=s05zEuX8NlbM7zMqx8k2Ze9DCxOVUEWrwFdlI0JsaOs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g6x/AwVcixNKFbv2jgCo/IXVP/GWeu36QSo8Dgzsjf61tRVdAdbvwWAI5eCEihDfc
	 1/l1yVImXhHSJaVue6Db8hUhuCyfs0MxTCU4El/TeEP+2GIu6w2UY9fY6Ml83JKBEE
	 mL1L9FkVwLSAIE7KE/wu9aR3VkYQ0GMSUlSM5Xoit0i6oFIRMrAj1n/XK+miM2Wxf0
	 7O5LdKubTrqnBabufM5hPb2movVzQUUkJZnFDtb7u5MjtPeKX6Sq6zUPP2chlZumwt
	 cFB07oAeVype5ph64twLMplFK8Eaq1CJBjl4wXrsyr+me4QKTEemx0bbR+TgcPPySc
	 dkGHGn+N/N1tQ==
Date: Thu, 13 Nov 2025 10:43:13 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: manivannan.sadhasivam@oss.qualcomm.com, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Hans de Goede <hansg@kernel.org>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-pm@vger.kernel.org, Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH 0/9] Add support for handling PCIe M.2 Key E connectors
 in devicetree
Message-ID: <neymke6rrm764yi6u76d66d7w55kj3r22doojik3gucu5i4qpm@ni5cr6ftbmjq>
References: <20251112-pci-m2-e-v1-0-97413d6bf824@oss.qualcomm.com>
 <CAL_Jsq+rOGUETwhPuzSsC6bhq1Q10k=pCRnZrnoDbCxVYV91YA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_Jsq+rOGUETwhPuzSsC6bhq1Q10k=pCRnZrnoDbCxVYV91YA@mail.gmail.com>

On Wed, Nov 12, 2025 at 03:07:29PM -0600, Rob Herring wrote:
> On Wed, Nov 12, 2025 at 8:45 AM Manivannan Sadhasivam via B4 Relay
> <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> wrote:
> >
> > Hi,
> >
> > This series is the continuation of the series [1] that added the initial support
> > for the PCIe M.2 connectors. This series extends it by adding support for Key E
> > connectors. These connectors are used to connect the Wireless Connectivity
> > devices such as WiFi, BT, NFC and GNSS devices to the host machine over
> > interfaces such as PCIe/SDIO, USB/UART and NFC. This series adds support for
> > connectors that expose PCIe interface for WiFi and UART interface for BT. Other
> > interfaces are left for future improvements.
> >
> > Serdev device support for BT
> > ============================
> >
> > Adding support for the PCIe interface was mostly straightforward and a lot
> > similar to the previous Key M connector. But adding UART interface has proved to
> > be tricky. This is mostly because of the fact UART is a non-discoverable bus,
> > unlike PCIe which is discoverable. So this series relied on the PCI notifier to
> > create the serdev device for UART/BT. This means the PCIe interface will be
> > brought up first and after the PCIe device enumeration, the serdev device will
> > be created by the pwrseq driver. This logic is necessary since the connector
> > driver and DT node don't describe the device, but just the connector. So to make
> > the connector interface Plug and Play, the connector driver uses the PCIe device
> > ID to identify the card and creates the serdev device. This logic could be
> > extended in the future to support more M.2 cards. Even if the M.2 card uses SDIO
> > interface for connecting WLAN, a SDIO notifier could be added to create the
> > serdev device.
> >
> > Open questions
> > ==============
> >
> > Though this series adds the relevant functionality for handling the M.2 Key M
> > connectors, there are still a few open questions exists on the design.
> >
> > 1. I've used the M.2 card model name as the serdev device name. This is found
> > out by comparing the PCIe VID:PID in the notifier. Is this approach acceptable?
> > I did not use the PID as the serdev name since it will vary if the SDIO
> > interface is used in the future.
> >
> > 2. PCIe client drivers of some M.2 WLAN cards like the Qcom QCA6390, rely on
> > the PCIe device DT node to extract properties such as
> > 'qcom,calibration-variant', 'firmware-name', etc... For those drivers, should we
> > add the PCIe DT node in the Root Port in conjunction with the Port node as
> > below?
> >
> > pcie@0 {
> >         wifi@0 {
> >                 compatible = "pci17cb,1103";
> >                 ...
> >                 qcom,calibration-variant = "LE_X13S";
> >         };
> >
> >         port {
> >                 pcie4_port0_ep: endpoint {
> >                         remote-endpoint = <&m2_e_pcie_ep>;
> >                 };
> >         };
> > };
> >
> > This will also require marking the PMU supplies optional in the relevant ath
> > bindings for M.2 cards.
> >
> > 3. Some M.2 cards require specific power up sequence like delays between
> > regulator/GPIO and such. For instance, the WCN7850 card supported in this series
> > requires 50ms delay between powering up an interface and driving it. I've just
> > hardcoded the delay in the driver, but it is a pure hack. Since the pwrseq
> > driver doesn't know anything about the device it is dealing with before powering
> > it ON, how should it handle the device specific power requirements? Should we
> > hardcode the device specific property in the connector node? But then, it will
> > no longer become a generic M.2 connector and sort of defeats the purpose of the
> > connector binding.
> >
> > I hope to address these questions with the help of the relevant subsystem
> > maintainers and the community. Until then, this series is *not* mergeable as a
> > whole.
> >
> > Testing
> > =======
> >
> > This series, together with the devicetree changes [2] was tested on the
> > Qualcomm X1e based Lenovo Thinkpad T14s Laptop which has the WCN7850 WLAN/BT M.2
> > card connected over PCIe and UART.
> >
> > [1] https://lore.kernel.org/linux-pci/20251108-pci-m2-v2-0-e8bc4d7bf42d@oss.qualcomm.com
> > [2] https://github.com/Mani-Sadhasivam/linux/commit/d39b81b3ff1ecfb0d423b4da0771925d41648b5a
> >
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > ---
> > Manivannan Sadhasivam (9):
> >       serdev: Convert to_serdev_device() and to_serdev_controller() helpers to macros
> >       serdev: Add serdev device based driver match support
> >       serdev: Allow passing the serdev device name to serdev_device_add()
> >       serdev: Add an API to find the serdev controller associated with the devicetree node
> >       serdev: Add modalias support for serdev client devices
> >       serdev: Skip registering serdev devices from DT is external connector is used
> >       dt-bindings: connector: Add PCIe M.2 Mechanical Key E connector
> >       Bluetooth: hci_qca: Add support for WCN7850 PCIe M.2 card
> >       power: sequencing: pcie-m2: Add support for PCIe M.2 Key E connectors
> >
> >  .../bindings/connector/pcie-m2-e-connector.yaml    | 154 +++++++++++++++
> >  MAINTAINERS                                        |   1 +
> >  drivers/bluetooth/hci_qca.c                        |  20 ++
> >  drivers/platform/x86/dell/dell-uart-backlight.c    |   2 +-
> >  .../x86/lenovo/yoga-tab2-pro-1380-fastcharger.c    |   2 +-
> >  drivers/platform/x86/x86-android-tablets/core.c    |   2 +-
> >  drivers/power/sequencing/Kconfig                   |   1 +
> >  drivers/power/sequencing/pwrseq-pcie-m2.c          | 218 ++++++++++++++++++++-
> >  drivers/tty/serdev/core.c                          |  77 +++++++-
> >  include/linux/mod_devicetable.h                    |   8 +
> >  include/linux/serdev.h                             |  25 ++-
> >  scripts/mod/devicetable-offsets.c                  |   3 +
> >  scripts/mod/file2alias.c                           |   8 +
> >  13 files changed, 494 insertions(+), 27 deletions(-)
> > ---
> > base-commit: db81ec30672bb228cd7cd809edeeae661d621f2d
> 
> git show db81ec30672bb228cd7cd80
> fatal: ambiguous argument 'db81ec30672bb228cd7cd80': unknown revision
> or path not in the working tree.
> Use '--' to separate paths from revisions, like this:
> 'git <command> [<revision>...] -- [<file>...]'
> 
> This series doesn't apply.
> 

Sorry, I forgot to edit the dependencies with b4. I'll fix it in v2. But if you
are interested to try this one, here are the deps:

message-id: 20251108-pci-m2-v2-0-e8bc4d7bf42d@oss.qualcomm.com
base-commit: v6.18-rc1

- Mani

-- 
மணிவண்ணன் சதாசிவம்

