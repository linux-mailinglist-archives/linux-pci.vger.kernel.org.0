Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC5604382A4
	for <lists+linux-pci@lfdr.de>; Sat, 23 Oct 2021 11:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbhJWJd2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 23 Oct 2021 05:33:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:38156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229818AbhJWJd2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 23 Oct 2021 05:33:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 728C26105A;
        Sat, 23 Oct 2021 09:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634981464;
        bh=+QiwhdJWgBM1NcDkCRuru67R0eaS3X7NMMBJ5F1SkZY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OjqFkHuRE5AD5G7g5ZRRojvYZ6FzO8cHfn0pv14AQad3g/TM1MOGx414QDw1jfKoy
         DS1lfaxNMWWD62hptSOJBZEnbMrzztOFdEgvkAy2E2DK79Z81w/KZ7Ag5SulR2OGgo
         2zTbvl2EBM3Mijp3jx6RCKlV7UIU9fSYmXuhud0jaWyU97gTBs3Z53ooeIrsFqgvUc
         69+doSWCMB5gRV0vw2MpLjmnze/4y0yMmfbsnC+j9rVT9SooBFpOZz5VAsGQ2uKzvu
         g8ZnJAO4QJHs71zHPJi1MkbYmq1m+Cpmmj58SgI6h2twv++vhCoeszlUzMfkrpMRZj
         AYB8o24UHwkrw==
Date:   Sat, 23 Oct 2021 10:30:59 +0100
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
Message-ID: <20211023103059.6add00e6@sal.lan>
In-Reply-To: <20211022151624.mgsgobjsjgyevnyt@pali>
References: <cover.1634622716.git.mchehab+huawei@kernel.org>
        <9a365cffe5af9ec5a1f79638968c3a2efa979b65.1634622716.git.mchehab+huawei@kernel.org>
        <20211022151624.mgsgobjsjgyevnyt@pali>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Pali,

Em Fri, 22 Oct 2021 17:16:24 +0200
Pali Roh=C3=A1r <pali@kernel.org> escreveu:

> On Tuesday 19 October 2021 07:06:42 Mauro Carvalho Chehab wrote:
> > Before code refactor, the PERST# signals were sent at the
> > end of the power_on logic. Then, the PCI core would probe for
> > the buses and add them.
> >=20
> > The new logic changed it to send PERST# signals during
> > add_bus operation. That altered the timings.
> >=20
> > Also, HiKey 970 require a little more waiting time for
> > the PCI bridge - which is outside the SoC - to finish
> > the PERST# reset, and then initialize the eye diagram. =20
>=20
> Hello! Which PCIe port do you mean by PCI bridge device? Do you mean
> PCIe Root Port? Or upstream port on some external PCIe switch connected
> via PCIe bus to the PCIe Root Port? Because all of these (virtual) PCIe
> devices are presented as PCI bridge devices, so it is not clear to which
> device it refers.

HiKey 970 uses an external PCI bridge chipset (a Broadcom PEX 8606[1]),
with 3 elements connected to the bus: an Ethernet card, a M.2 slot and
a mini PCIe slot. It seems HiKey 970 is unique with regards to PERST# signa=
l,
as there are 4 independent PERST# signals there:

	- one for PEX 8606 (the PCIe root port);
	- one for Ethernet;
	- one for M.2;
	- one for mini-PCIe.

After sending the PCIe PERST# signals, the device has to wait for 21 ms
before adjusting the eye diagram.

[1] https://docs.broadcom.com/docs/PEX_8606_AIC_RDK_HRM_v1.3_06Aug10.pdf

> Normally PERST# signal is used to reset endpoint card, other end of PCIe
> link and so PERST# signal should not affect PCIe Root Port at all.

That's not the case, as PEX 8606 needs to complete its reset sequence
for the rest of the devices to be visible. If the wait time is reduced
or removed, the devices behind it won't be detected.

> > So, increase the waiting time for the PERST# signals to
> > what's required for it to also work with HiKey 970. =20
>=20
> Because PERST# signal resets endpoint card, this reset timeout should
> not be driver or controller specific.

Not sure if it would be possible to implement it at the core without
breaking devices like this one where there's a separate chip to actually
implement the PCIe bus.
=20
> Mauro, if you understand this issue more deeply, could you look at my
> email? https://lore.kernel.org/linux-pci/20210310110535.zh4pnn4vpmvzwl5q@=
pali/
>=20
> I think that kernel PCI subsystem does not properly handle PCIe Warm
> Reset and correct initialization of endpoint cards. Because similar
> "random PERST# timeout patches" were applied to lot of native controller
> drivers.

I don't know enough about PCIe documentation in order to help with that.
Yet, if the PCI/PCIe specs doesn't define a maximum time for PERST# to
finish, hardware manufacturers will do whatever they please. So, finding
a common value is impossible.=20

Well, even if specs define it, vendors may still violate that. So, whatever=
=20
implementation is done, some quirks may be needed.

Sending PERST# signals to the devices connected to the bridge too early
will cause the bridge to not detect the devices behind it. That's what
happens with HiKey 970: lower reset values cause it to miss devices.

Looking from harware perspective, I'd say that the reset time pretty
much depends on how the PCIe bridges are implemented: if it is FPGA, it is=
=20
probably slower than if it is a dedicated hardware. It can be even slower
if the bridge uses a microcontroller and needs to read the firmware from=20
some place.

> PS: I'm not opposing this patch, I'm just trying to understand what is
> happening here and why particular number "21000" was chosen. It is
> defined in some standard? Or was it just randomly chosen and measures
> that with this number is initialization working fine?

It is the value used by the HiKey 970 PCIe out-of-tree driver. The patch
which added support for it at the pcie-kirin increased the time out there.

I tried to preserve the previous value, but that cause some devices to
be missed during PCI probe time.

Btw, PEX 8606 datasheet says:

	`Reset Circuit

	 The PEX 8606BA-AIC1U1D RDK accepts a PERST# from the host PC via card edg=
e connector P1. This signal is
	 OR=E2=80=99d with a manual reset circuit. The manual reset circuit consis=
ts of a pushbutton (SW7, upper left corner) that
	 feeds into a reset timer. The reset timer monitors its power rail and res=
et input. If the reset input is low or the
	 supply rail is out of range, the reset output is held. Once both conditio=
ns no longer exist, the reset output will de-
	 assert after a programmable reset timeout period (capacitor adjustable, d=
efault value 128 msec). The OR=E2=80=99d reset
	 signal goes to the PEX 8606 device=E2=80=99s PEX_PERST# input pin, and th=
e downstream slots=E2=80=99 PERST# connector
	 pins. PERST# to Slot J1 can be controlled by the PEX 8606 device=E2=80=99=
s Hot-Plug interface.'

If I understood it well, the PERST# time is hardware-configurable, by
changing the value of a capacitor.

Regards,
Mauro
>=20
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >=20
> > See [PATCH v14 00/11] at: https://lore.kernel.org/all/cover.1634622716.=
git.mchehab+huawei@kernel.org/
> >=20
> >  drivers/pci/controller/dwc/pcie-kirin.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/cont=
roller/dwc/pcie-kirin.c
> > index de375795a3b8..bc329673632a 100644
> > --- a/drivers/pci/controller/dwc/pcie-kirin.c
> > +++ b/drivers/pci/controller/dwc/pcie-kirin.c
> > @@ -113,7 +113,7 @@ struct kirin_pcie {
> >  #define CRGCTRL_PCIE_ASSERT_BIT		0x8c000000
> > =20
> >  /* Time for delay */
> > -#define REF_2_PERST_MIN		20000
> > +#define REF_2_PERST_MIN		21000
> >  #define REF_2_PERST_MAX		25000
> >  #define PERST_2_ACCESS_MIN	10000
> >  #define PERST_2_ACCESS_MAX	12000
> > --=20
> > 2.31.1
> >  =20
