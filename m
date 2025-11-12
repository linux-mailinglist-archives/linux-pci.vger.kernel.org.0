Return-Path: <linux-pci+bounces-41020-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 349F9C548B5
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 22:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 74D664E0EDA
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 21:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BBD22D97B5;
	Wed, 12 Nov 2025 21:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aULWBmZ3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB30B2D8799
	for <linux-pci@vger.kernel.org>; Wed, 12 Nov 2025 21:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762981663; cv=none; b=fA/QgVcNH49zxUcbX9SoC6aSDkZawYrqlE0nyPqYoIRV9EQ+YofPsKiYGVHWpugZLZ5oNIWCgKeHMuRXJubatUw4kqWJYRQUwxF/7ykuCFiw6Y8RTL7CgdeWKXL2v2sURK7tKibsLj0T7WwkGc9MIvXLYJXOaYIaYkxlrcbyZNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762981663; c=relaxed/simple;
	bh=u8q2TZF20ibeYFuY8h4yCLkgQDj7Xrhx2gKQ62/nSkk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dppwb/zwk80tr58MbWKqJQGeBRpYkyQxLHuh1DBMKWIUXAotSo+AMNiQT9/h6+QeulMuQeI+JpwDzcMZKlaGmmpo90nAqgtSiuhzTFxhhoy2f2pG5ss4cRFcMN1zV2/f9Oy3X9CO6pk4TzeF/GFH7bWJvWI/v+xOgsMhsl+YE8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aULWBmZ3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8931FC19422
	for <linux-pci@vger.kernel.org>; Wed, 12 Nov 2025 21:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762981662;
	bh=u8q2TZF20ibeYFuY8h4yCLkgQDj7Xrhx2gKQ62/nSkk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aULWBmZ3rD1NOHg1GcQ4Dq2EBVHRlCDrSxReNcyrhsRiK1A2FuL00TwRxPiGuN4Db
	 OKIrCUVIDLpK8jqGmMEAEZvERB8tg6pMwBoAiH4CsPX0gnoN+1qcTm+mxekJWDG+9G
	 XgM8haSqwQasnU2/WgQCSpjtRUpEg+ytNyBljhB8bPSMB3jcrBn4aNlywo2AAlqTOl
	 MWMANIebhQ1TxnenHMk2MDfOXtC8a2P8AZjlXo5da3Ts9/Kx00vg7gtFqYVpRUFxvA
	 HcOZNzSR+8nmU8KV1v59K2b+h6WZxg8f9EB4/qrujfwGgn6fQlSZy7FZz2Futss1Rf
	 Xne5czQMN2nQg==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6417313bddaso160111a12.3
        for <linux-pci@vger.kernel.org>; Wed, 12 Nov 2025 13:07:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVJywEnMNweLs1yjlwROFRP2WOomwW4LOt3gjQiK4ytpyFJWKlU1nR68bjyyjJOANYAgHsZ2YFfzE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmOCPYBTubhLNpzKehlqzwjAnCeNgZil5tZDHB0mwJh+zAtrNn
	hbYq2kT8ZSCL1LUE2Aq39jw5BGS59epLkgpMhZonKLAn+5fynHSmoh/IQ9oAHJm8qq7uLni8okY
	nX/wkV4UGeqoS0ovvUwclV/xI8spA/w==
X-Google-Smtp-Source: AGHT+IEIy21Sb3B7FBrgAI8SVidk1uSmlkEpW+/mXMU6zQinRFFusx79rk2YkYD+SPkgL7pLFxsxRVnlBhzaVvKVnfk=
X-Received: by 2002:a05:6402:2106:b0:641:27d8:ec72 with SMTP id
 4fb4d7f45d1cf-6431a39656dmr3803888a12.4.1762981660959; Wed, 12 Nov 2025
 13:07:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112-pci-m2-e-v1-0-97413d6bf824@oss.qualcomm.com>
In-Reply-To: <20251112-pci-m2-e-v1-0-97413d6bf824@oss.qualcomm.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 12 Nov 2025 15:07:29 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+rOGUETwhPuzSsC6bhq1Q10k=pCRnZrnoDbCxVYV91YA@mail.gmail.com>
X-Gm-Features: AWmQ_bkhxcdj-NsfzZ0QRxOltuG2xQHMKmcPZ2R7l6HHsGWU07rxfsx54qGm66Y
Message-ID: <CAL_Jsq+rOGUETwhPuzSsC6bhq1Q10k=pCRnZrnoDbCxVYV91YA@mail.gmail.com>
Subject: Re: [PATCH 0/9] Add support for handling PCIe M.2 Key E connectors in devicetree
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Hans de Goede <hansg@kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-pm@vger.kernel.org, Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 8:45=E2=80=AFAM Manivannan Sadhasivam via B4 Relay
<devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> wrote:
>
> Hi,
>
> This series is the continuation of the series [1] that added the initial =
support
> for the PCIe M.2 connectors. This series extends it by adding support for=
 Key E
> connectors. These connectors are used to connect the Wireless Connectivit=
y
> devices such as WiFi, BT, NFC and GNSS devices to the host machine over
> interfaces such as PCIe/SDIO, USB/UART and NFC. This series adds support =
for
> connectors that expose PCIe interface for WiFi and UART interface for BT.=
 Other
> interfaces are left for future improvements.
>
> Serdev device support for BT
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>
> Adding support for the PCIe interface was mostly straightforward and a lo=
t
> similar to the previous Key M connector. But adding UART interface has pr=
oved to
> be tricky. This is mostly because of the fact UART is a non-discoverable =
bus,
> unlike PCIe which is discoverable. So this series relied on the PCI notif=
ier to
> create the serdev device for UART/BT. This means the PCIe interface will =
be
> brought up first and after the PCIe device enumeration, the serdev device=
 will
> be created by the pwrseq driver. This logic is necessary since the connec=
tor
> driver and DT node don't describe the device, but just the connector. So =
to make
> the connector interface Plug and Play, the connector driver uses the PCIe=
 device
> ID to identify the card and creates the serdev device. This logic could b=
e
> extended in the future to support more M.2 cards. Even if the M.2 card us=
es SDIO
> interface for connecting WLAN, a SDIO notifier could be added to create t=
he
> serdev device.
>
> Open questions
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Though this series adds the relevant functionality for handling the M.2 K=
ey M
> connectors, there are still a few open questions exists on the design.
>
> 1. I've used the M.2 card model name as the serdev device name. This is f=
ound
> out by comparing the PCIe VID:PID in the notifier. Is this approach accep=
table?
> I did not use the PID as the serdev name since it will vary if the SDIO
> interface is used in the future.
>
> 2. PCIe client drivers of some M.2 WLAN cards like the Qcom QCA6390, rely=
 on
> the PCIe device DT node to extract properties such as
> 'qcom,calibration-variant', 'firmware-name', etc... For those drivers, sh=
ould we
> add the PCIe DT node in the Root Port in conjunction with the Port node a=
s
> below?
>
> pcie@0 {
>         wifi@0 {
>                 compatible =3D "pci17cb,1103";
>                 ...
>                 qcom,calibration-variant =3D "LE_X13S";
>         };
>
>         port {
>                 pcie4_port0_ep: endpoint {
>                         remote-endpoint =3D <&m2_e_pcie_ep>;
>                 };
>         };
> };
>
> This will also require marking the PMU supplies optional in the relevant =
ath
> bindings for M.2 cards.
>
> 3. Some M.2 cards require specific power up sequence like delays between
> regulator/GPIO and such. For instance, the WCN7850 card supported in this=
 series
> requires 50ms delay between powering up an interface and driving it. I've=
 just
> hardcoded the delay in the driver, but it is a pure hack. Since the pwrse=
q
> driver doesn't know anything about the device it is dealing with before p=
owering
> it ON, how should it handle the device specific power requirements? Shoul=
d we
> hardcode the device specific property in the connector node? But then, it=
 will
> no longer become a generic M.2 connector and sort of defeats the purpose =
of the
> connector binding.
>
> I hope to address these questions with the help of the relevant subsystem
> maintainers and the community. Until then, this series is *not* mergeable=
 as a
> whole.
>
> Testing
> =3D=3D=3D=3D=3D=3D=3D
>
> This series, together with the devicetree changes [2] was tested on the
> Qualcomm X1e based Lenovo Thinkpad T14s Laptop which has the WCN7850 WLAN=
/BT M.2
> card connected over PCIe and UART.
>
> [1] https://lore.kernel.org/linux-pci/20251108-pci-m2-v2-0-e8bc4d7bf42d@o=
ss.qualcomm.com
> [2] https://github.com/Mani-Sadhasivam/linux/commit/d39b81b3ff1ecfb0d423b=
4da0771925d41648b5a
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.=
com>
> ---
> Manivannan Sadhasivam (9):
>       serdev: Convert to_serdev_device() and to_serdev_controller() helpe=
rs to macros
>       serdev: Add serdev device based driver match support
>       serdev: Allow passing the serdev device name to serdev_device_add()
>       serdev: Add an API to find the serdev controller associated with th=
e devicetree node
>       serdev: Add modalias support for serdev client devices
>       serdev: Skip registering serdev devices from DT is external connect=
or is used
>       dt-bindings: connector: Add PCIe M.2 Mechanical Key E connector
>       Bluetooth: hci_qca: Add support for WCN7850 PCIe M.2 card
>       power: sequencing: pcie-m2: Add support for PCIe M.2 Key E connecto=
rs
>
>  .../bindings/connector/pcie-m2-e-connector.yaml    | 154 +++++++++++++++
>  MAINTAINERS                                        |   1 +
>  drivers/bluetooth/hci_qca.c                        |  20 ++
>  drivers/platform/x86/dell/dell-uart-backlight.c    |   2 +-
>  .../x86/lenovo/yoga-tab2-pro-1380-fastcharger.c    |   2 +-
>  drivers/platform/x86/x86-android-tablets/core.c    |   2 +-
>  drivers/power/sequencing/Kconfig                   |   1 +
>  drivers/power/sequencing/pwrseq-pcie-m2.c          | 218 +++++++++++++++=
+++++-
>  drivers/tty/serdev/core.c                          |  77 +++++++-
>  include/linux/mod_devicetable.h                    |   8 +
>  include/linux/serdev.h                             |  25 ++-
>  scripts/mod/devicetable-offsets.c                  |   3 +
>  scripts/mod/file2alias.c                           |   8 +
>  13 files changed, 494 insertions(+), 27 deletions(-)
> ---
> base-commit: db81ec30672bb228cd7cd809edeeae661d621f2d

git show db81ec30672bb228cd7cd80
fatal: ambiguous argument 'db81ec30672bb228cd7cd80': unknown revision
or path not in the working tree.
Use '--' to separate paths from revisions, like this:
'git <command> [<revision>...] -- [<file>...]'

This series doesn't apply.

Rob

