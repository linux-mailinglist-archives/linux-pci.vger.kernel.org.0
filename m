Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 401BC4383D6
	for <lists+linux-pci@lfdr.de>; Sat, 23 Oct 2021 15:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbhJWNr7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 23 Oct 2021 09:47:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:47188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229870AbhJWNr7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 23 Oct 2021 09:47:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6A0E460EFE;
        Sat, 23 Oct 2021 13:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634996740;
        bh=TW+Roz9vJE/O1Rr8K0ynZMMGy4CyOfFDhlfknx5JVB8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=E5wlEgw1jgD31xIHfnBEdm1lcaJKQouSBKfKP1XGf2PICCE2odGfKmsAQb+CLnisd
         xjHzomBEjYmVsyimsnRUY/C2IP21Rt/sbuueM2VkBcuPt4yheBAD+Z0iyoV7ikLP6M
         yASX76ou/5OjIQ9dztyJz6RJBNBsecLsd89mfvf5n8F/WJAIA5V1F2i9I/n7Wm342J
         mu6DOBtYv+NCHRp/72mGy1PgvrBt/VXI336v6NjsaLLcvD7LV1ABFE+B9K1FU3SreB
         U+UCLVz0CLP5RPtLPFGLegqVkZkAIQPKk7yL48e/tXbNvceTRN261SH0/EZxWUZ2+Z
         xVt0UCZgmV35g==
Date:   Sat, 23 Oct 2021 14:45:34 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linuxarm@huawei.com,
        mauro.chehab@huawei.com,
        Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kw@linux.com>,
        Songxiaowei <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v14 05/11] PCI: kirin: give more time for PERST# reset
 to finish
Message-ID: <20211023144534.55aaecf9@sal.lan>
In-Reply-To: <20211023104011.zmj7y7vtplpnmhwd@pali>
References: <cover.1634622716.git.mchehab+huawei@kernel.org>
 <9a365cffe5af9ec5a1f79638968c3a2efa979b65.1634622716.git.mchehab+huawei@kernel.org>
 <20211022151624.mgsgobjsjgyevnyt@pali>
 <20211023103059.6add00e6@sal.lan>
 <20211023104011.zmj7y7vtplpnmhwd@pali>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Importance: high
X-Priority: 1 (Highest)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Em Sat, 23 Oct 2021 12:40:11 +0200
Pali Roh=C3=A1r <pali@kernel.org> escreveu:

> Hello!
>=20
> On Saturday 23 October 2021 10:30:59 Mauro Carvalho Chehab wrote:
> > Hi Pali,
> >=20
> > Em Fri, 22 Oct 2021 17:16:24 +0200
> > Pali Roh=C3=A1r <pali@kernel.org> escreveu:
> >  =20
> > > On Tuesday 19 October 2021 07:06:42 Mauro Carvalho Chehab wrote: =20
> > > > Before code refactor, the PERST# signals were sent at the
> > > > end of the power_on logic. Then, the PCI core would probe for
> > > > the buses and add them.
> > > >=20
> > > > The new logic changed it to send PERST# signals during
> > > > add_bus operation. That altered the timings.
> > > >=20
> > > > Also, HiKey 970 require a little more waiting time for
> > > > the PCI bridge - which is outside the SoC - to finish
> > > > the PERST# reset, and then initialize the eye diagram.   =20
> > >=20
> > > Hello! Which PCIe port do you mean by PCI bridge device? Do you mean
> > > PCIe Root Port? Or upstream port on some external PCIe switch connect=
ed
> > > via PCIe bus to the PCIe Root Port? Because all of these (virtual) PC=
Ie
> > > devices are presented as PCI bridge devices, so it is not clear to wh=
ich
> > > device it refers. =20
> >=20
> > HiKey 970 uses an external PCI bridge chipset (a Broadcom PEX 8606[1]),=
 =20
>=20
> Ok! Now I understood. You have probably one PCIe Root Port on your board
> and to this port you have connected (external) PCIe switch card from
> Broadcom to increase number of PCIe ports for endpoint cards.

Yes.

> It is classic setup for boards with just one PCIe port.
>=20
> > with 3 elements connected to the bus: an Ethernet card, a M.2 slot and
> > a mini PCIe slot. It seems HiKey 970 is unique with regards to PERST# s=
ignal,
> > as there are 4 independent PERST# signals there:
> >=20
> > 	- one for PEX 8606 (the PCIe root port);
> > 	- one for Ethernet;
> > 	- one for M.2;
> > 	- one for mini-PCIe. =20
>=20
> This is not unique setup, its pretty normal. Every PCIe card has (own)
> PERST# pin and obviously you want to control each pin separately via SW.
> And because PCIe switch is also (upstream) PCIe device it has also
> PERST# pin.

Based on the discussions we had to add per-port DT PERST# gpios, it
sounded to me that this is was not a typical setup ;-)

It seems that the typical setup is to have a single PERST# connected
to all devices inside the bus.

>=20
> > After sending the PCIe PERST# signals, the device has to wait for 21 ms
> > before adjusting the eye diagram. =20
>=20
> "the device" which has to wait is HiKey970 or PEX8606?

I guess both need, but not really sure.=20

Kirin 970 (the SoC used on HiKey 970 board) needs to wait for PEX8606 to=20
reset, in order to adjust the eye diagram.

The bus probing code needs to wait after sending the PERST# signals to=20
the devices behind PEX8606, as otherwise they aren't detected.

> > [1] https://docs.broadcom.com/docs/PEX_8606_AIC_RDK_HRM_v1.3_06Aug10.pdf
> >  =20
> > > Normally PERST# signal is used to reset endpoint card, other end of P=
CIe
> > > link and so PERST# signal should not affect PCIe Root Port at all. =20
> >=20
> > That's not the case, as PEX 8606 needs to complete its reset sequence
> > for the rest of the devices to be visible. If the wait time is reduced
> > or removed, the devices behind it won't be detected. =20
>=20
> Well, "endpoint card" for HiKey970 PCIe link is here PEX8606. And if you
> connect PEX8606 to any other board (which could have totally different
> PCIe controller), it means that same wait timeouts are required for that
> other board.
>=20
> So this wait timeout 21 ms is not HiKey970 specific, but rather PEX8606
> specific, right?

I guess so.

> > > > So, increase the waiting time for the PERST# signals to
> > > > what's required for it to also work with HiKey 970.   =20
> > >=20
> > > Because PERST# signal resets endpoint card, this reset timeout should
> > > not be driver or controller specific. =20
> >=20
> > Not sure if it would be possible to implement it at the core without
> > breaking devices like this one where there's a separate chip to actually
> > implement the PCIe bus. =20
>=20
> I think it should be possible. Probably not so easy, would need more
> testing, etc... But as I wrote above, this setup is not unique, it is
> really normal and kernel is prepared to work PCI and PCIe topologies
> when one or more PCIe switches, PCIe-to-PCI bridges or even more
> PCI-to-PCI bridges are used and connected to system board.

Yeah, technically, it is doable, but applying change like that requires
testing the code with all affected devices in order to avoid regressions.

> I send email with proposal / idea how could be PCI subsystem extended to
> handle initialization of native PCIe controller drivers:
> https://lore.kernel.org/linux-pci/20211022183808.jdeo7vntnagqkg7g@pali/
> (if you have some more points, feel free to reply)

Ok. Will try to reply to it later.

> > > Mauro, if you understand this issue more deeply, could you look at my
> > > email? https://lore.kernel.org/linux-pci/20210310110535.zh4pnn4vpmvzw=
l5q@pali/
> > >=20
> > > I think that kernel PCI subsystem does not properly handle PCIe Warm
> > > Reset and correct initialization of endpoint cards. Because similar
> > > "random PERST# timeout patches" were applied to lot of native control=
ler
> > > drivers. =20
> >=20
> > I don't know enough about PCIe documentation in order to help with that.
> > Yet, if the PCI/PCIe specs doesn't define a maximum time for PERST# to
> > finish, hardware manufacturers will do whatever they please. So, finding
> > a common value is impossible.  =20
>=20
> Well, it is possible that just I was not able to "find and decode" this
> timeout from specifications. So I'm just asking if somebody else was
> able to do it :-)

My past experiences with other drivers/devices show that, even for things
that are clearly documented at the specs, hardware vendors end missing
some things. That's why there are lots of quicks at USB and PCI code
all over the drivers.

> > Well, even if specs define it, vendors may still violate that. So, what=
ever=20
> > implementation is done, some quirks may be needed. =20
>=20
> Of course, we know it and kernel has hooks and corrections for such
> situation. Fixes are in most cases in one place: drivers/pci/quirks.c

There are PCI quirks outside PCI core. For instance, on media, we had to add
several quicks to avoid PCI2PCI data transfers with some broken hardware,
where enabing it would cause disk data corruption (see bt8xx, saa7134 and
cx88 drivers, for instance).

> > Sending PERST# signals to the devices connected to the bridge too early
> > will cause the bridge to not detect the devices behind it. That's what
> > happens with HiKey 970: lower reset values cause it to miss devices. =20
>=20
> Just to make sure, that I understand your problem. Is your setup looks
> like this?
>=20
>           +-------------------------------------PERST#--+---+
>           |                                             |eth|
>           |                 +------PERST#--+  +--PCIe---+---+
>           |                 |              |  |
>   +-------------+ +-------------+        +-------+      +---+
>   |GPIO-HiKey970| |PCIe-HiKey970|--PCIe--|PEX8606|-PCIe-|m.2|
>   +-------------+ +-------------+        +-------+      +---+
>           |           |          +-----+        |         |
>           |           +--PERST#--|mPCIe|--PCIe--+         |
>           |                      +-----+                  |
>           +---------------------------------------PERST#--+

It is:


           +-------------------------------------PERST#--+---+
           |                                             |eth|
           |   +--------------------PERST#--+  +--PCIe---+---+
           |   |                            |  |
   +-------------+ +------------+        +-------+      +---+
   |Kirin970 GPIO| |Kirin970    |--PCIe--|PEX8606|-PCIe-|m.2|
   |             | |DWC and PHY |        +-------+      +---+
   +-------------+ +------------+                |         |
           |  |                   +-----+        |         |
           |  +---PERST#----------|mPCIe|--PCIe--+         |
           |                      +-----+                  |
           +--------------------------------------PERST#---+

You can see more details by looking at the schematics of the board.=20
It is available at:

	https://www.96boards.org/documentation/consumer/hikey/hikey970/hardware-do=
cs/files/hikey970-schematics.pdf

> And if yes, in which order you need to assert individual PERST# signals
> and in which order to de-assert them?

As requested by Rob, the current code triggers a PERST# signal to=20
PEX8606 at the end of the power-on sequence:

        if (!gpio_request(kirin_pcie->gpio_id_dwc_perst, "pcie_perst_bridge=
")) {
                ret =3D gpio_direction_output(kirin_pcie->gpio_id_dwc_perst=
, 1);
                if (ret)
                        goto err;
        }

        usleep_range(PERST_2_ACCESS_MIN, PERST_2_ACCESS_MAX);

Then, it sends a per-slot reset during add_bus ops:

	static int kirin_pcie_add_bus(struct pci_bus *bus)
	{
	        struct dw_pcie *pci =3D to_dw_pcie_from_pp(bus->sysdata);
	        struct kirin_pcie *kirin_pcie =3D to_kirin_pcie(pci);
	        int i, ret;
=09
	        if (!kirin_pcie->num_slots)
	                return 0;
=09
	        /* Send PERST# to each slot */
	        for (i =3D 0; i < kirin_pcie->num_slots; i++) {
	                ret =3D gpio_direction_output(kirin_pcie->gpio_id_reset[i]=
, 1);
	                if (ret) {
	                        dev_err(pci->dev, "PERST# %s error: %d\n",
	                                kirin_pcie->reset_names[i], ret);
	                }
	        }
	        usleep_range(PERST_2_ACCESS_MIN, PERST_2_ACCESS_MAX);
=09
	        return 0;
	}

> > Looking from harware perspective, I'd say that the reset time pretty
> > much depends on how the PCIe bridges are implemented: if it is FPGA, it=
 is=20
> > probably slower than if it is a dedicated hardware. It can be even slow=
er
> > if the bridge uses a microcontroller and needs to read the firmware fro=
m=20
> > some place.
> >  =20
> > > PS: I'm not opposing this patch, I'm just trying to understand what is
> > > happening here and why particular number "21000" was chosen. It is
> > > defined in some standard? Or was it just randomly chosen and measures
> > > that with this number is initialization working fine? =20
> >=20
> > It is the value used by the HiKey 970 PCIe out-of-tree driver. The patch
> > which added support for it at the pcie-kirin increased the time out the=
re.
> >=20
> > I tried to preserve the previous value, but that cause some devices to
> > be missed during PCI probe time.
> >=20
> > Btw, PEX 8606 datasheet says:
> >=20
> > 	`Reset Circuit
> >=20
> > 	 The PEX 8606BA-AIC1U1D RDK accepts a PERST# from the host PC via card=
 edge connector P1. This signal is
> > 	 OR=E2=80=99d with a manual reset circuit. The manual reset circuit co=
nsists of a pushbutton (SW7, upper left corner) that
> > 	 feeds into a reset timer. The reset timer monitors its power rail and=
 reset input. If the reset input is low or the
> > 	 supply rail is out of range, the reset output is held. Once both cond=
itions no longer exist, the reset output will de-
> > 	 assert after a programmable reset timeout period (capacitor adjustabl=
e, default value 128 msec). The OR=E2=80=99d reset
> > 	 signal goes to the PEX 8606 device=E2=80=99s PEX_PERST# input pin, an=
d the downstream slots=E2=80=99 PERST# connector
> > 	 pins. PERST# to Slot J1 can be controlled by the PEX 8606 device=E2=
=80=99s Hot-Plug interface.'
> >=20
> > If I understood it well, the PERST# time is hardware-configurable, by
> > changing the value of a capacitor. =20
>=20
> Hm... this is something different. It says: "Once both conditions no
> longer exist, the reset output will de-assert after a programmable reset
> timeout period (capacitor adjustable, default value 128 msec)."
>=20
> I understand this part that if signal is no longer in reset that then
> this capacitor cause that reset is held for another 128 ms. So if host
> stops reset signal then it has to wait 128 ms prior doing something
> (to ensure that reset finished), right?

It seems that a 0 -> 1 transition at the GPIO triggers PEX8606 code to
send the PERST# signal to the time configured via the capacitor (128 ms
by default). There's no need to change the GPIO back to 0.

Regards,
Mauro
