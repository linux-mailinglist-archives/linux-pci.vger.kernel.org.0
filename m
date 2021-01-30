Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4D03093D6
	for <lists+linux-pci@lfdr.de>; Sat, 30 Jan 2021 10:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbhA3J7Y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 30 Jan 2021 04:59:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:46614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231962AbhA3J7U (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 30 Jan 2021 04:59:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 28A7264E18;
        Sat, 30 Jan 2021 07:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611991111;
        bh=w3NoZDwgJGdNpBoNCAmeyp2xfAh1cXR7l50GWZpwLuY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VeaqaicBY/GLXbBUhhtz3Uj8p+/OgZOlv2EfiT58cb6h5klgaUIt1I9GGSZl/xVF9
         jhCras6YCxAh4DKPYMYyYdwHibryfhx5pYJTkrEIRUchCBdKXjNlgfUoC+e9KM2Jfq
         MMyyMiLc6o6Z5owwHGkYLv9HLGxs3Ztbsx/YTbYQUkf8VR1JRrOot85BmIr56f9Vww
         XiY3RxsRI9EIWmJZV2yLqFEoOOuqTFwLvtBeQEWOmzZLm0Bi7Dm6NnHR2L2setQUXu
         uHjJejmTOLrXlLP/ZGoMEsvTTlAD7Qisk1yPmx4RzFHBrmzqOpyV401jeFCc9Lqs7O
         UZdJola29d76A==
Date:   Sat, 30 Jan 2021 08:18:26 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        PCI <linux-pci@vger.kernel.org>, devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Joey.Gouly@arm.com
Subject: Re: Enabling PCIe support on Hikey 970
Message-ID: <20210130081826.41d172f6@coco.lan>
In-Reply-To: <CAL_JsqLN2XESoCW5=uhbzd4EP+dO0xVMmS7W4f6EgMv_j_xTpg@mail.gmail.com>
References: <20210129173057.30288c9d@coco.lan>
        <CAL_JsqLN2XESoCW5=uhbzd4EP+dO0xVMmS7W4f6EgMv_j_xTpg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Em Fri, 29 Jan 2021 17:32:28 -0600
Rob Herring <robh+dt@kernel.org> escreveu:

> On Fri, Jan 29, 2021 at 10:31 AM Mauro Carvalho Chehab
> <mchehab+huawei@kernel.org> wrote:
> >
> > Hi Bjorn/Rob,
> >
> > I've been trying to make a Hikey 970 board to work properly upstream.
> >
> > This specific hardware is similar to a previous model (Hikey 960),
> > and it uses the same PCIe driver, with a few additions
> > (drivers/pci/controller/dwc/pcie-kirin.c).
> >
> > The major difference between those two models is that, on Hikey 960,
> > the PCIe is mapped as [1]:
> >
> >         +---------+      +--------+
> >         |Kirin 960|----> |PCIe M.2|
> >         |  SoC    |      |        |
> >         +---------+      +--------+
> >
> > While, on Hikey 970, the connection is more complex[2]:
> >
> >         +---------+      +--------+
> >         |         |      |        |     +--------+
> >         |         |      |        |---->|PCIe M.2|-->M.2 slot
> >         |         |      |        |     +--------+
> >         |         |      |        |
> >         |         |      |        |     +--------+
> >         |Kirin 970|----> |Switch  |---->|Mini 1x |-->mini PCIe slot
> >         |         |      |PEX 8606|     +--------+
> >         |  SoC    |      |        |
> >         |         |      |        |     +-------+
> >         |         |      |        |---->|RTL8169|---> Ethernet
> >         |         |      |        |     +-------+
> >         +---------+      +--------+
> >
> >
> >
> > [1] see https://www.96boards.org/documentation/consumer/hikey/hikey960/=
hardware-docs/hardware-user-manual.md.html
> > [2] see https://www.96boards.org/documentation/consumer/hikey/hikey970/=
hardware-docs/files/hikey970-schematics.pdf
> >
> > When the driver is properly loaded, this is what can be seen there:
> >
> >         $ lspci
> >         00:00.0 PCI bridge: Huawei Technologies Co., Ltd. Device 3670 (=
rev 01)
> >         01:00.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Por=
t PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
> >         02:01.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Por=
t PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
> >         02:04.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Por=
t PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
> >         02:05.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Por=
t PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
> >         02:07.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Por=
t PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
> >         02:09.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Por=
t PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
> >         06:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RT=
L8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 07)
> >
> > (without anything connected to M.2 or mini 1x slots)
> >
> > All devices after the SoC require a regulator line to be
> > enabled (LDO33). Starting the PCIe bus before turning them on
> > causes PCIe probe to fail.
> >
> > There are also separate PERST lines for the switch (Broadcom PEX 8606),
> > PCIe M.2, Mini 1x and for the Ethernet hardware (RTL 8169).
> >
> > To make it a little more fun, the M.2, the Mini 1x and the
> > RTL 8169 also requires a clockreq in order to work. =20
>=20
> Nice. Yet another case of a 'probeable' bus with non-probeable
> additions. Second one recently for PCI[1][2].

I wouldn't doubt that more similar designs may happen, as this
controller uses a DesignWare PCI Core. I won't doubt that similar
design decisions could happen on other hardware using the same IP.

> > Both the 4 PERST reset lines and the 3 CLOCKREQ lines are initialized
> > during the PCIe power on logic, at probing time.
> >
> > I'm currently thinking about the best way to report this via
> > device tree.
> >
> > It sounds to me that the best would be to add those 4 data at the DTS f=
ile:
> >
> >         reset-gpios =3D <&gpio7 0 0 >, <&gpio25 2 0 >,
> >                       <&gpio3 1 0 >, <&gpio27 4 0 >;
> >         reset-names =3D "pcie_switch_reset", "pcie_eth_reset",
> >                       "pcie_m_2_reset",    "pcie_mini1_reset"; =20
>=20
> 'reset-names' is paired with 'resets', so this doesn't work. The name
> of the gpio is in the property name.

I noticed that this produces a warning. I could name it as
reset-gpios-names, in order to avoid the conflict.

>=20
> >         clkreq-gpios =3D <&gpio20 6 0 >, <&gpio27 3 0 >,
> >                        <&gpio17 0 0 >;
> >         clkreq-names =3D "pcie_eth_clkreq", "pcie_m_2_clkreq",
> >                        "pcie_mini1_clkreq"; =20
>=20
> The larger problem here is this will work for exactly one board. Soon
> as you have a different topology, you'll have to change all this. If
> it's just assert/deassert all the GPIOs at once, then it could kind of
> work. If you need to know the mapping (which adding the names seems to
> imply), then it definitely doesn't work.

The names are not important. They're all initialized altogether:

	for (i =3D 0; i < kirin_pcie->n_gpio_resets; i++) {
		ret =3D devm_gpio_request(dev, kirin_pcie->gpio_id_reset[i],
					kirin_pcie->reset_names[i]);
		if (ret)
			return ret;
	}

	for (i =3D 0; i < kirin_pcie->n_gpio_clkreq; i++) {
		ret =3D devm_gpio_request(dev, kirin_pcie->gpio_id_clkreq[i],
					kirin_pcie->clkreq_names[i]);
		if (ret)
			return ret;
	}

And the GPIO direction is also initialized altogether, during power on,
on, at kirin970_pcie_power_on():

	regmap_write(kirin_pcie->sysctrl, SCTRL_PCIE_CMOS_OFFSET, SCTRL_PCIE_CMOS_=
BIT);
	usleep_range(TIME_CMOS_MIN, TIME_CMOS_MAX);
	kirin_pcie_oe_enable(kirin_pcie);

	for (i =3D 0; i < kirin_pcie->n_gpio_clkreq; i++) {
		ret =3D gpio_direction_output(kirin_pcie->gpio_id_clkreq[i], 0);
		if (ret)
			return ret;
	}

	/*
	 * This function initialize this part of DT:
	 *		clocks =3D <&crg_ctrl HI3670_CLK_GATE_PCIEPHY_REF>,
	 *			 <&crg_ctrl HI3670_CLK_GATE_PCIEAUX>,
	 *			 <&crg_ctrl HI3670_PCLK_GATE_PCIE_PHY>,
	 *			 <&crg_ctrl HI3670_PCLK_GATE_PCIE_SYS>,
	 *			 <&crg_ctrl HI3670_ACLK_GATE_PCIE>;
	 */
	ret =3D kirin_pcie_clk_ctrl(kirin_pcie, true);
	if (ret)
		return ret;

	/* some PCIe controller init code */
	...

	/* perst assert Endpoints */
	usleep_range(21000, 23000);
	for (i =3D 0; i < kirin_pcie->n_gpio_resets; i++) {
		ret =3D gpio_direction_output(kirin_pcie->gpio_id_reset[i], 1);
		if (ret)
			return ret;
	}
	usleep_range(10000, 11000);

	/* More init code */
	ret =3D is_pipe_clk_stable(kirin_pcie);
	if (!ret)
		goto close_clk;

	kirin970_pcie_set_eyeparam(kirin_pcie);

	ret =3D kirin970_pcie_noc_power(kirin_pcie, false);
	if (ret)
		goto close_clk;


I opted to store the names at DT for two reasons:

1. it better documents the meaning of each gpio;
2. devm_gpio_request() needs an unique name.

We could live removing the name and letting the driver call them
internally as something like "pcie_persist_%d" and "pcie_clkreq_%d",
if preferred.

In any case, with or without the names, this should work with
all boards using a similar design.

> You are going to need DT nodes representing the hierarchy you drew
> above with GPIO properties added to the appropriate child nodes.

Hmm... not sure how to do that. Do you have an example?

>=20
> Controlling the regulator should be specific to the device.
> Controlling the GPIOs could be done by the PCI core given those are
> standard signals for PCI.

I'm not convinced that this could be done by the PCI core.
=46rom the above power-on code, it sounds that the init sequence
should be kept inside the PCI driver. See, the power on sequence
seems to be:

	1. reset the PCIe SoC;
	2. initialize the clkreq GPIOs and clock lines;
	3. Set a series of registers at PCIe SoC;
	4. Set PERST assert to all endpoints;
	5. Wait for the hardware to be in a stable state;
	6. Initialize the eye diagram;
	7. Power on the PCIe hardware.

Maybe initializing clkreq GPIOs earlier could work, but it sounds
to me that the PERST assert should happen in the middle of the
power on sequence.

Thanks,
Mauro
