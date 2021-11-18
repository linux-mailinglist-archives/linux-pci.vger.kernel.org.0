Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC80455FA3
	for <lists+linux-pci@lfdr.de>; Thu, 18 Nov 2021 16:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbhKRPjP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Nov 2021 10:39:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232354AbhKRPjO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Nov 2021 10:39:14 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6939BC061574
        for <linux-pci@vger.kernel.org>; Thu, 18 Nov 2021 07:36:14 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id d27so12344095wrb.6
        for <linux-pci@vger.kernel.org>; Thu, 18 Nov 2021 07:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ie6Tu2P5Bk+kxdEtWy+/RXXOlEd/vH+F5MzmsBPE6KA=;
        b=djawHILmVTs9ySjuJxTX6LZ2HnM+DoY/FGntdYU7oV3pwghzVv8dyfZ9yPkL/8HVzP
         ym/20/txKspti3cWZOSUjfQCzTliSGN6tafhiDd1/99Kj40jDrp8E5JzcXlDmp7aJzIa
         gAdiemUm+fwz5eFLZVpjs1mqBcxTBJR6JMY5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ie6Tu2P5Bk+kxdEtWy+/RXXOlEd/vH+F5MzmsBPE6KA=;
        b=M4n2iHCpJF2Z4mXdWn5ijewqQVxuEmz01YRADjOkoUPoRhb7M2L/YWE94KYYjcciPQ
         N1up7ZaUBKSpMydOCXlq2QXjKw3dVLTio9Dc0mYHSmhRYcpFe52cXvmbhXRe5ehkWODG
         3NGc2mT1n5l3TtDXMLujJ3j5vxjhaIux5AchwCePUMMEHumnX5OVSFr/edA0lSE3RFFE
         R0e72NErfcZhFuNnSlLo4tFPD7r4U51QBEZudfm5UqdU9tX3F59AiftYEp7z8OFKbbxf
         bFe8Nc7ho0b7nCBeutm5FI6JIU1mv2WNiBkreRLxB0egkSRkMlA4zBjffLZG2G/dTCuo
         +YjQ==
X-Gm-Message-State: AOAM533Ah++tcaaPQP+/SLe/nrOlVYI8kQtXFamr+d7lm8LhmiwRx7/M
        RaXuuDBkJg2trtuajP/b8lu8BtAtp9ujWEMKepMtYg==
X-Google-Smtp-Source: ABdhPJz1KgOsDUS2KKyyRep6AYgiuFNYiPQqbqA2ankF7GprEP1Ao6oVrjXQMoHmP2YGui4LzcLgCSXRj5WCJoKFARw=
X-Received: by 2002:a5d:4b41:: with SMTP id w1mr31339631wrs.437.1637249772824;
 Thu, 18 Nov 2021 07:36:12 -0800 (PST)
MIME-Version: 1.0
References: <20211110221456.11977-1-jim2101024@gmail.com> <20211110221456.11977-6-jim2101024@gmail.com>
 <CAL_Jsq+6g-EhyVCeWTMkjOZmBwsOOVZo2jXpzAkjOXcZaxb2eA@mail.gmail.com>
 <CA+-6iNxfrOQtH1JDEjAdSZQkENoaw1tUDTfVc5+G7P6BAbSc6g@mail.gmail.com>
 <CAL_JsqJno4ROQD38buz8Z-tU5aaQL5b_d1R0-D+c9UwnMKYNOw@mail.gmail.com>
 <20211116205337.ui5sjrsmkef4a53k@pali> <CA+-6iNxz2RSmJ9C1dfjEOPmuTxELPDiGzsWoL-8KkH8FGjN3nA@mail.gmail.com>
 <20211117154512.aelgnqhcnw3gqu5s@pali>
In-Reply-To: <20211117154512.aelgnqhcnw3gqu5s@pali>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Thu, 18 Nov 2021 10:36:00 -0500
Message-ID: <CA+-6iNwUORmdLy9ii748K4JfZQ8J-N48r-q7QO1P9XAZR2W2qw@mail.gmail.com>
Subject: Re: [PATCH v8 5/8] PCI/portdrv: add mechanism to turn on subdev regulators
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     Rob Herring <robh@kernel.org>, Jim Quinlan <jim2101024@gmail.com>,
        PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Sean V Kelley <sean.v.kelley@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Keith Busch <kbusch@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 17, 2021 at 10:45 AM Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> On Wednesday 17 November 2021 10:14:19 Jim Quinlan wrote:
> > On Tue, Nov 16, 2021 at 3:53 PM Pali Roh=C3=A1r <pali@kernel.org> wrote=
:
> > >
> > > On Tuesday 16 November 2021 11:41:22 Rob Herring wrote:
> > > > +Pali
> > > >
> > > > On Mon, Nov 15, 2021 at 2:44 PM Jim Quinlan <james.quinlan@broadcom=
.com> wrote:
> > > > >
> > > > > On Thu, Nov 11, 2021 at 5:57 PM Rob Herring <robh@kernel.org> wro=
te:
> > > > > >
> > > > > > On Wed, Nov 10, 2021 at 4:15 PM Jim Quinlan <jim2101024@gmail.c=
om> wrote:
> > > > > > >
> > > > > > > Adds a mechanism inside the root port device to identify stan=
dard PCIe
> > > > > > > regulators in the DT, allocate them, and turn them on before =
the rest of
> > > > > > > the bus is scanned during pci_host_probe().  A root complex d=
river can
> > > > > > > leverage this mechanism by setting the pci_ops methods add_bu=
s and
> > > > > > > remove_bus to pci_subdev_regulators_{add,remove}_bus.
> > > > > > >
> > > > > > > The allocated structure that contains the regulators is store=
d in
> > > > > > > dev.driver_data.
> > > > > > >
> > > > > > > The unabridge    /* PCIe endpoint */d reason for doing this i=
s as follows.  We would like the
> > > > > > > Broadcom STB PCIe root complex driver (and others) to be able=
 to turn
> > > > > > > off/on regulators[1] that provide power to endpoint[2] device=
s.  Typically,
> > > > > > > the drivers of these endpoint devices are stock Linux drivers=
 that are not
> > > > > > > aware that these regulator(s) exist and must be turned on for=
 the driver to
> > > > > > > be probed.  The simple solution of course is to turn these re=
gulators on at
> > > > > > > boot and keep them on.  However, this solution does not satis=
fy at least
> > > > > > > three of our usage modes:
> > > > > > >
> > > > > > > 1. For example, one customer uses multiple PCIe controllers, =
but wants the
> > > > > > > ability to, by script invoking and unbind, turn any or all of=
 them by and
> > > > > > > their subdevices off to save power, e.g. when in battery mode=
.
> > > > > > >
> > > > > > > 2. Another example is when a watchdog script discovers that a=
n endpoint
> > > > > > > device is in an unresponsive state and would like to unbind, =
power toggle,
> > > > > > > and re-bind just the PCIe endpoint and controller.
> > > > > > >
> > > > > > > 3. Of course we also want power turned off during suspend mod=
e.  However,
> > > > > > > some endpoint devices may be able to "wake" during suspend an=
d we need to
> > > > > > > recognise this case and veto the nominal act of turning off i=
ts regulator.
> > > > > > > Such is the case with Wake-on-LAN and Wake-on-WLAN support wh=
ere PCIe
> > > > > > > end-point device needs to be kept powered on in order to rece=
ive network
> > > > > > > packets and wake-up the system.
> > > > > > >
> > > > > > > In all of these cases it is advantageous for the PCIe control=
ler to govern
> > > > > > > the turning off/on the regulators needed by the endpoint devi=
ce.  The first
> > > > > > > two cases can be done by simply unbinding and binding the PCI=
e controller,
> > > > > > > if the controller has control of these regulators.
> > > > > > >
> > > > > > > [1] These regulators typically govern the actual power supply=
 to the
> > > > > > >     endpoint chip.  Sometimes they may be a the official PCIe=
 socket
> > > > > > >     power -- such as 3.3v or aux-3.3v.  Sometimes they are tr=
uly
> > > > > > >     the regulator(s) that supply power to the EP chip.
> > > > > > >
> > > > > > > [2] The 99% configuration of our boards is a single endpoint =
device
> > > > > > >     attached to the PCIe controller.  I use the term endpoint=
 but it could
> > > > > > >     possible mean a switch as well.
> > > > > > >
> > > > > > > Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> > > > > > > ---
> > > > > > >  drivers/pci/bus.c              | 72 ++++++++++++++++++++++++=
++++++++++
> > > > > > >  drivers/pci/pci.h              |  8 ++++
> > > > > > >  drivers/pci/pcie/portdrv_pci.c | 32 +++++++++++++++
> > > > > > >  3 files changed, 112 insertions(+)
> > > > > > >
> > > > > > > diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> > > > > > > index 3cef835b375f..c39fdf36b0ad 100644
> > > > > > > --- a/drivers/pci/bus.c
> > > > > > > +++ b/drivers/pci/bus.c
> > > > > > > @@ -419,3 +419,75 @@ void pci_bus_put(struct pci_bus *bus)
> > > > > > >         if (bus)
> > > > > > >                 put_device(&bus->dev);
> > > > > > >  }
> > > > > > > +
> > > > > > > +static void *alloc_subdev_regulators(struct device *dev)
> > > > > > > +{
> > > > > > > +       static const char * const supplies[] =3D {
> > > > > > > +               "vpcie3v3",
> > > > > > > +               "vpcie3v3aux",
> > > > > > > +               "vpcie12v",
> > > > > > > +       };
> > > > > > > +       const size_t size =3D sizeof(struct subdev_regulators=
)
> > > > > > > +               + sizeof(struct regulator_bulk_data) * ARRAY_=
SIZE(supplies);
> > > > > > > +       struct subdev_regulators *sr;
> > > > > > > +       int i;
> > > > > > > +
> > > > > > > +       sr =3D devm_kzalloc(dev, size, GFP_KERNEL);
> > > > > > > +
> > > > > > > +       if (sr) {
> > > > > > > +               sr->num_supplies =3D ARRAY_SIZE(supplies);
> > > > > > > +               for (i =3D 0; i < ARRAY_SIZE(supplies); i++)
> > > > > > > +                       sr->supplies[i].supply =3D supplies[i=
];
> > > > > > > +       }
> > > > > > > +
> > > > > > > +       return sr;
> > > > > > > +}
> > > > > > > +
> > > > > > > +
> > > > > > > +int pci_subdev_regulators_add_bus(struct pci_bus *bus)
> > > > > > > +{
> > > > > > > +       struct device *dev =3D &bus->dev;
> > > > > > > +       struct subdev_regulators *sr;
> > > > > > > +       int ret;
> > > > > > > +
> > > > > > > +       if (!pcie_is_port_dev(bus->self))
> > > > > > > +               return 0;
> > > > > > > +
> > > > > > > +       if (WARN_ON(bus->dev.driver_data))
> > > > > > > +               dev_err(dev, "multiple clients using dev.driv=
er_data\n");
> > > > > > > +
> > > > > > > +       sr =3D alloc_subdev_regulators(&bus->dev);
> > > > > > > +       if (!sr)
> > > > > > > +               return -ENOMEM;
> > > > > > > +
> > > > > > > +       bus->dev.driver_data =3D sr;
> > > > > > > +       ret =3D regulator_bulk_get(dev, sr->num_supplies, sr-=
>supplies);
> > > > > > > +       if (ret)
> > > > > > > +               return ret;
> > > > > > > +
> > > > > > > +       ret =3D regulator_bulk_enable(sr->num_supplies, sr->s=
upplies);
> > > > > > > +       if (ret) {
> > > > > > > +               dev_err(dev, "failed to enable regulators for=
 downstream device\n");
> > > > > > > +               return ret;
> > > > > > > +       }
> > > > > > > +
> > > > > > > +       return 0;
> > > > > > > +}
> > > > > > > +EXPORT_SYMBOL_GPL(pci_subdev_regulators_add_bus);
> > > > > >
> > > > > > Can't these just go in the portdrv probe and remove functions n=
ow?
> > > > > >
> > > > > > Rob
> > > > >
> > > > > Not really.  The idea is that  only when a host controller driver=
 does this
> > > > >
> > > > > static struct pci_ops my_pcie_ops =3D {
> > > > >     .add_bus =3D pci_subdev_regulators_add_bus , /* see  note bel=
ow */
> > > > >     .remove_bus =3D pci_subdev_regulators_remove_bus,
> > > > >     ...
> > > > > }
> > > > >
> > > > > does it explicitly want this feature.  Without doing this, every =
PCI
> > > > > port in the world will execute a devm_kzalloc() and
> > > > > devm_regulator_bulk_get() to (likely) grab nothing, and then ther=
e
> > > > > will be three superfluous lines in the boot log:
> > > >
> > > > You can opt-in based on there being a DT node.
> > > >
> > > > > pci_bus 0001:01: 0001:01 supply vpcie12v not found, using dummy r=
egulator
> > > > > pci_bus 0001:01: 0001:01 supply vpcie3v3 not found, using dummy r=
egulator
> > > > > pci_bus 0001:01: 0001:01 supply vpcie3v3aux not found, using dumm=
y regulator
> > > >
> > > > This would be annoying, but not really a reason for how to design t=
his.
> > > >
> > > > > Secondly, our  HW needs to know when the  alloc/get/enable of
> > > > > regulators is done so that the PCIe link can then be attempted.  =
 This
> > > > > is pretty much the cornerstone of this patchset.   To do this the=
 brcm
> > > > > RC driver's call to pci_subdev_regulators_add_bus() is wrapped by
> > > > > brcm_pcie_add_bus() so that we can do this:
> > > > >
> > > > > static struct pci_ops my_pcie_ops =3D {
> > > > >     .add_bus =3D brcm_pcie_add_bus ,   /* calls pci_subdev_regula=
tors_add_bus() */
> > > > >     .remove_bus =3D pci_subdev_regulators_remove_bus,
> > > >
> > > > Do add_bus/remove_bus get called during resume/suspend? If not, how=
 do
> > > > you handle the link during resume?
> > > >
> > > > Maybe there needs to be explicit hooks for link handling. Pali has
> > > > been looking into this some.
> > > >
> > > > Rob
> > >
> > > Yes, I was looking at it... main power (12V/3.3V) and AUX power (3.3V=
)
> > > needs to be supplied at the "correct" time during establishing link
> > > procedure. I wrote it in my RFC email:
> > > https://lore.kernel.org/linux-pci/20211022183808.jdeo7vntnagqkg7g@pal=
i/
> > Hello Pali,
> >
> > I really like your proposal although I would like to get my patchset
> > first :-) :-)
> >
> > Suppose you came up with a patchset for your ideas-- would that include
> > changes to existing RC drivers to use the proposed framework?  If so,
> > I am wary that it would
> > break at least a few of them.  Or would you just present the framework
> > and allow the
> > RC drivers' authors to opt-in, one by one?
>
> My idea is to add new "framework" to allow drivers implement new
> callbacks for this "framework". There would be no change in drivers
> which do not provide these callbacks to ensure that nothing is going to
> be broken. I'm planning to implement these callbacks only for RC drivers
> for which I have hardware and can properly test to not introduce any
> regression. For other existing RC drivers it is up to other authors +
> testers. But to decrease future maintenance cost of all RC drivers I
> expect that new drivers would not implement any ad-hoc solution in their
> "probe" function and instead implement these new callbacks. That is my
> idea.
>
> > At any rate, if you want someone to test some of your ideas I can work
> > with you.
>
> Perfect! If you have any concerns or you see any issues, please reply
> that my RFC email. So I can collect feedback.
>
> Also I sent draft for updating DTS schema for PCIe devices:
> https://github.com/devicetree-org/dt-schema/pull/64

Hi Pali,
I don't see any mention or placement of the regulator nodes for power;
do you agree with where
I proposed we place them, ie in the first bridge under the root-complex,  e=
.g.

            pcie0: pcie@7d500000 {                                /*
root complex */
                    compatible =3D "brcm,bcm2711-pcie";
                    reg =3D <0x0 0x7d500000 0x9310>;

                    /* PCIe bridge */
                    pci@0,0 {
                            #address-cells =3D <3>;
                            #size-cells =3D <2>;
                            reg =3D <0x0 0x0 0x0 0x0 0x0>;
                            compatible =3D "pciclass,0604";
                            device_type =3D "pci";
                            vpcie3v3-supply =3D <&vreg7>;     /*
<------------- HERE  */
                            ranges;

                            pci-ep@0,0 {        /* PCIe endpoint */
                                    assigned-addresses =3D
                                        <0x82010000 0x0 0xf8000000 0x6
0x00000000 0x0 0x2000>;
                                    reg =3D <0x0 0x0 0x0 0x0 0x0>;
                                    compatible =3D "pci14e4,1688";
                                    #address-cells =3D <3>;
                                    #size-cells =3D <2>;

                                    ranges;
                            };
                    };
            };


Regards,
Jim

>
> > Regards,
> > Jim Quinlan
> > Broadcom STB
> >
> >
> > >
> > > I'm not sure if regulator API is the most suitable for this task in P=
CI
> > > core code as there are planty ways how it can be controllers. My idea
> > > presented in that email was that driver provides power callback and c=
ore
> > > pci code would use it.
> > >
> > > Because power needs to be enabled at the "correct" time during link u=
p,
> > > I think that add/remove bus callbacks are unsuitable for this task. T=
his
> > > would just cause adding another msleep() calls on different places to
> > > make correct timing of link up...
> > >
> > > I think it is needed to implement generic function for establishing l=
ink
> > > in pci core code with all required steps.
