Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4994549A6
	for <lists+linux-pci@lfdr.de>; Wed, 17 Nov 2021 16:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbhKQPRf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Nov 2021 10:17:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbhKQPRc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Nov 2021 10:17:32 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 579F0C061764
        for <linux-pci@vger.kernel.org>; Wed, 17 Nov 2021 07:14:33 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 133so2591668wme.0
        for <linux-pci@vger.kernel.org>; Wed, 17 Nov 2021 07:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=P6SoxW2lGSajncF0WVtOEB3pPO66nCefvhPT+KFGJ68=;
        b=X/mfS0OmOuHQcvU7ohnSyf5Xw3JUVfwfwhjymDZJ/SgLJkkOMymys37V6jXe9Y965p
         nDvKlPP4UhJeIsz/IoHbVdFxQJgR12G92WYIZCs2naW3Zj0Ipe9DgOx/ERpciULF9ye4
         COO3WxuCDoTvhcDFpKuS4iTqhZHXv+DPxZckQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=P6SoxW2lGSajncF0WVtOEB3pPO66nCefvhPT+KFGJ68=;
        b=CDCJG4zvGLapAh8qmbS0gy0eNegn+5QA5ca1rUDs9+wWad9b4FtoGK2SLvR9XZXR3w
         mbT1SJf+06yEpzrJTYUE3f5gT9pW3FViGTcFmQP+9WYJaCNLX9QtBd0FrenPVihyi+ND
         hptVXhKhj8M0rm4ayvulYxQWO5ZAGIbYWy0zT44mOtQ8/LT8XVX4FmouRWRt/uVieneM
         4VaH2TtDdO7p8pabOINy3vT7b8Ar6Vq1VPBCtdmegksoBC7h87eSVFGyw1E32PHqvS/q
         uJ3GcGHVPTAsuJZCIDK2RuwFSh9fcUDo8qrkMQRHkCtbZiusAr+CGg2HMd3Jx2Cn78W+
         IAnw==
X-Gm-Message-State: AOAM5312VjsqmHPxHIfCN846o76O7Kv+vJLFHd9fOjF5S1LNfoLQc1k5
        TK1o/RAZa4TIkvPED3sx6wmVrh0V8tJ9UOjK5WSYFg==
X-Google-Smtp-Source: ABdhPJzu+3c8ZTni6st08tZgc4h/Jdv/t4I/myKIK+6+6RugDZLW13bA+yySTKcC2JlT2lUiYUiN2Y4hpppSCvzV1JI=
X-Received: by 2002:a7b:cc11:: with SMTP id f17mr486609wmh.122.1637162071782;
 Wed, 17 Nov 2021 07:14:31 -0800 (PST)
MIME-Version: 1.0
References: <20211110221456.11977-1-jim2101024@gmail.com> <20211110221456.11977-6-jim2101024@gmail.com>
 <CAL_Jsq+6g-EhyVCeWTMkjOZmBwsOOVZo2jXpzAkjOXcZaxb2eA@mail.gmail.com>
 <CA+-6iNxfrOQtH1JDEjAdSZQkENoaw1tUDTfVc5+G7P6BAbSc6g@mail.gmail.com>
 <CAL_JsqJno4ROQD38buz8Z-tU5aaQL5b_d1R0-D+c9UwnMKYNOw@mail.gmail.com> <20211116205337.ui5sjrsmkef4a53k@pali>
In-Reply-To: <20211116205337.ui5sjrsmkef4a53k@pali>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Wed, 17 Nov 2021 10:14:19 -0500
Message-ID: <CA+-6iNxz2RSmJ9C1dfjEOPmuTxELPDiGzsWoL-8KkH8FGjN3nA@mail.gmail.com>
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

On Tue, Nov 16, 2021 at 3:53 PM Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> On Tuesday 16 November 2021 11:41:22 Rob Herring wrote:
> > +Pali
> >
> > On Mon, Nov 15, 2021 at 2:44 PM Jim Quinlan <james.quinlan@broadcom.com=
> wrote:
> > >
> > > On Thu, Nov 11, 2021 at 5:57 PM Rob Herring <robh@kernel.org> wrote:
> > > >
> > > > On Wed, Nov 10, 2021 at 4:15 PM Jim Quinlan <jim2101024@gmail.com> =
wrote:
> > > > >
> > > > > Adds a mechanism inside the root port device to identify standard=
 PCIe
> > > > > regulators in the DT, allocate them, and turn them on before the =
rest of
> > > > > the bus is scanned during pci_host_probe().  A root complex drive=
r can
> > > > > leverage this mechanism by setting the pci_ops methods add_bus an=
d
> > > > > remove_bus to pci_subdev_regulators_{add,remove}_bus.
> > > > >
> > > > > The allocated structure that contains the regulators is stored in
> > > > > dev.driver_data.
> > > > >
> > > > > The unabridged reason for doing this is as follows.  We would lik=
e the
> > > > > Broadcom STB PCIe root complex driver (and others) to be able to =
turn
> > > > > off/on regulators[1] that provide power to endpoint[2] devices.  =
Typically,
> > > > > the drivers of these endpoint devices are stock Linux drivers tha=
t are not
> > > > > aware that these regulator(s) exist and must be turned on for the=
 driver to
> > > > > be probed.  The simple solution of course is to turn these regula=
tors on at
> > > > > boot and keep them on.  However, this solution does not satisfy a=
t least
> > > > > three of our usage modes:
> > > > >
> > > > > 1. For example, one customer uses multiple PCIe controllers, but =
wants the
> > > > > ability to, by script invoking and unbind, turn any or all of the=
m by and
> > > > > their subdevices off to save power, e.g. when in battery mode.
> > > > >
> > > > > 2. Another example is when a watchdog script discovers that an en=
dpoint
> > > > > device is in an unresponsive state and would like to unbind, powe=
r toggle,
> > > > > and re-bind just the PCIe endpoint and controller.
> > > > >
> > > > > 3. Of course we also want power turned off during suspend mode.  =
However,
> > > > > some endpoint devices may be able to "wake" during suspend and we=
 need to
> > > > > recognise this case and veto the nominal act of turning off its r=
egulator.
> > > > > Such is the case with Wake-on-LAN and Wake-on-WLAN support where =
PCIe
> > > > > end-point device needs to be kept powered on in order to receive =
network
> > > > > packets and wake-up the system.
> > > > >
> > > > > In all of these cases it is advantageous for the PCIe controller =
to govern
> > > > > the turning off/on the regulators needed by the endpoint device. =
 The first
> > > > > two cases can be done by simply unbinding and binding the PCIe co=
ntroller,
> > > > > if the controller has control of these regulators.
> > > > >
> > > > > [1] These regulators typically govern the actual power supply to =
the
> > > > >     endpoint chip.  Sometimes they may be a the official PCIe soc=
ket
> > > > >     power -- such as 3.3v or aux-3.3v.  Sometimes they are truly
> > > > >     the regulator(s) that supply power to the EP chip.
> > > > >
> > > > > [2] The 99% configuration of our boards is a single endpoint devi=
ce
> > > > >     attached to the PCIe controller.  I use the term endpoint but=
 it could
> > > > >     possible mean a switch as well.
> > > > >
> > > > > Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> > > > > ---
> > > > >  drivers/pci/bus.c              | 72 ++++++++++++++++++++++++++++=
++++++
> > > > >  drivers/pci/pci.h              |  8 ++++
> > > > >  drivers/pci/pcie/portdrv_pci.c | 32 +++++++++++++++
> > > > >  3 files changed, 112 insertions(+)
> > > > >
> > > > > diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> > > > > index 3cef835b375f..c39fdf36b0ad 100644
> > > > > --- a/drivers/pci/bus.c
> > > > > +++ b/drivers/pci/bus.c
> > > > > @@ -419,3 +419,75 @@ void pci_bus_put(struct pci_bus *bus)
> > > > >         if (bus)
> > > > >                 put_device(&bus->dev);
> > > > >  }
> > > > > +
> > > > > +static void *alloc_subdev_regulators(struct device *dev)
> > > > > +{
> > > > > +       static const char * const supplies[] =3D {
> > > > > +               "vpcie3v3",
> > > > > +               "vpcie3v3aux",
> > > > > +               "vpcie12v",
> > > > > +       };
> > > > > +       const size_t size =3D sizeof(struct subdev_regulators)
> > > > > +               + sizeof(struct regulator_bulk_data) * ARRAY_SIZE=
(supplies);
> > > > > +       struct subdev_regulators *sr;
> > > > > +       int i;
> > > > > +
> > > > > +       sr =3D devm_kzalloc(dev, size, GFP_KERNEL);
> > > > > +
> > > > > +       if (sr) {
> > > > > +               sr->num_supplies =3D ARRAY_SIZE(supplies);
> > > > > +               for (i =3D 0; i < ARRAY_SIZE(supplies); i++)
> > > > > +                       sr->supplies[i].supply =3D supplies[i];
> > > > > +       }
> > > > > +
> > > > > +       return sr;
> > > > > +}
> > > > > +
> > > > > +
> > > > > +int pci_subdev_regulators_add_bus(struct pci_bus *bus)
> > > > > +{
> > > > > +       struct device *dev =3D &bus->dev;
> > > > > +       struct subdev_regulators *sr;
> > > > > +       int ret;
> > > > > +
> > > > > +       if (!pcie_is_port_dev(bus->self))
> > > > > +               return 0;
> > > > > +
> > > > > +       if (WARN_ON(bus->dev.driver_data))
> > > > > +               dev_err(dev, "multiple clients using dev.driver_d=
ata\n");
> > > > > +
> > > > > +       sr =3D alloc_subdev_regulators(&bus->dev);
> > > > > +       if (!sr)
> > > > > +               return -ENOMEM;
> > > > > +
> > > > > +       bus->dev.driver_data =3D sr;
> > > > > +       ret =3D regulator_bulk_get(dev, sr->num_supplies, sr->sup=
plies);
> > > > > +       if (ret)
> > > > > +               return ret;
> > > > > +
> > > > > +       ret =3D regulator_bulk_enable(sr->num_supplies, sr->suppl=
ies);
> > > > > +       if (ret) {
> > > > > +               dev_err(dev, "failed to enable regulators for dow=
nstream device\n");
> > > > > +               return ret;
> > > > > +       }
> > > > > +
> > > > > +       return 0;
> > > > > +}
> > > > > +EXPORT_SYMBOL_GPL(pci_subdev_regulators_add_bus);
> > > >
> > > > Can't these just go in the portdrv probe and remove functions now?
> > > >
> > > > Rob
> > >
> > > Not really.  The idea is that  only when a host controller driver doe=
s this
> > >
> > > static struct pci_ops my_pcie_ops =3D {
> > >     .add_bus =3D pci_subdev_regulators_add_bus , /* see  note below *=
/
> > >     .remove_bus =3D pci_subdev_regulators_remove_bus,
> > >     ...
> > > }
> > >
> > > does it explicitly want this feature.  Without doing this, every PCI
> > > port in the world will execute a devm_kzalloc() and
> > > devm_regulator_bulk_get() to (likely) grab nothing, and then there
> > > will be three superfluous lines in the boot log:
> >
> > You can opt-in based on there being a DT node.
> >
> > > pci_bus 0001:01: 0001:01 supply vpcie12v not found, using dummy regul=
ator
> > > pci_bus 0001:01: 0001:01 supply vpcie3v3 not found, using dummy regul=
ator
> > > pci_bus 0001:01: 0001:01 supply vpcie3v3aux not found, using dummy re=
gulator
> >
> > This would be annoying, but not really a reason for how to design this.
> >
> > > Secondly, our  HW needs to know when the  alloc/get/enable of
> > > regulators is done so that the PCIe link can then be attempted.   Thi=
s
> > > is pretty much the cornerstone of this patchset.   To do this the brc=
m
> > > RC driver's call to pci_subdev_regulators_add_bus() is wrapped by
> > > brcm_pcie_add_bus() so that we can do this:
> > >
> > > static struct pci_ops my_pcie_ops =3D {
> > >     .add_bus =3D brcm_pcie_add_bus ,   /* calls pci_subdev_regulators=
_add_bus() */
> > >     .remove_bus =3D pci_subdev_regulators_remove_bus,
> >
> > Do add_bus/remove_bus get called during resume/suspend? If not, how do
> > you handle the link during resume?
> >
> > Maybe there needs to be explicit hooks for link handling. Pali has
> > been looking into this some.
> >
> > Rob
>
> Yes, I was looking at it... main power (12V/3.3V) and AUX power (3.3V)
> needs to be supplied at the "correct" time during establishing link
> procedure. I wrote it in my RFC email:
> https://lore.kernel.org/linux-pci/20211022183808.jdeo7vntnagqkg7g@pali/
Hello Pali,

I really like your proposal although I would like to get my patchset
first :-) :-)

Suppose you came up with a patchset for your ideas-- would that include
changes to existing RC drivers to use the proposed framework?  If so,
I am wary that it would
break at least a few of them.  Or would you just present the framework
and allow the
RC drivers' authors to opt-in, one by one?

At any rate, if you want someone to test some of your ideas I can work
with you.

Regards,
Jim Quinlan
Broadcom STB


>
> I'm not sure if regulator API is the most suitable for this task in PCI
> core code as there are planty ways how it can be controllers. My idea
> presented in that email was that driver provides power callback and core
> pci code would use it.
>
> Because power needs to be enabled at the "correct" time during link up,
> I think that add/remove bus callbacks are unsuitable for this task. This
> would just cause adding another msleep() calls on different places to
> make correct timing of link up...
>
> I think it is needed to implement generic function for establishing link
> in pci core code with all required steps.
