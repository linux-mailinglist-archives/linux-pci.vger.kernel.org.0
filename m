Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62CF9451C9E
	for <lists+linux-pci@lfdr.de>; Tue, 16 Nov 2021 01:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346905AbhKPAVw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Nov 2021 19:21:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351949AbhKOUjG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Nov 2021 15:39:06 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2162C06120E
        for <linux-pci@vger.kernel.org>; Mon, 15 Nov 2021 12:26:34 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id p3-20020a05600c1d8300b003334fab53afso199598wms.3
        for <linux-pci@vger.kernel.org>; Mon, 15 Nov 2021 12:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rtClDjxdghzCsVQI3nsX7TGdSn82gtZi7XTwGqeLHrs=;
        b=JS5rvbSXAWtKlPJ8B7LUosSWT7l6DXS1NRH0rhLNhvnze/zVfC4AeXqu0h4OS+qf3i
         zXtBhGvNCNfKyohfA0YPT9koY77EXjNBBKiwWgW+GU3511wJcaev8LcAlxktQU9BKJWT
         AqU76N5SEvnzODg7izZp/+sKrDP3k/R/t5Wcc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rtClDjxdghzCsVQI3nsX7TGdSn82gtZi7XTwGqeLHrs=;
        b=1BsUbTB59+vqlCfNrRQ0MpEb5X9ACecs48radRAlSCgA5r0X383+X2UZFrmD6IaUEh
         ixZJRuPK1ibU5b8gAX9EnJZXEQT0XvhsBuT/nDZB/O/w7PPDyQmTkQuRyNwn7GlYb+ec
         lIIE41AMnV7LUw7lL9cysLxvxosso3wB0j8KcH4JnnlMAzfRSJ1FRuineT04zFR83fch
         7BkAoBsXmziifGWiKovhI6OK58W/ldD1LTolTHr4rlrOzNvg05dYh6mj18Sdh1y61FG+
         Q1so3okEyCZaoCjvZs9ongryVv2FmHfJbESPKb2kxJxVvXSIe84pCq7xJh8uaPphUWLX
         SoIQ==
X-Gm-Message-State: AOAM530JpaiKMVXHg2JSlSum3A/JlwQrlNsBCogxvU8kVXI+JwI8bPDm
        DguLcj/9IW/IOT0vgBzGcEk/no5Um8sKXFcZRtU9iQ==
X-Google-Smtp-Source: ABdhPJxROxosvWQMHyhtWc+Dq97i7VhhG2bj9pN6A5U2BR6OAoV2iJOEF4NKwlyCsU6MPcvuEgGNpkI26YB14O81Myo=
X-Received: by 2002:a05:600c:40b:: with SMTP id q11mr1320917wmb.185.1637007993378;
 Mon, 15 Nov 2021 12:26:33 -0800 (PST)
MIME-Version: 1.0
References: <20211110221456.11977-1-jim2101024@gmail.com> <20211110221456.11977-6-jim2101024@gmail.com>
 <YY2pdNMnYQ/EcQoo@rocinante>
In-Reply-To: <YY2pdNMnYQ/EcQoo@rocinante>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Mon, 15 Nov 2021 15:26:22 -0500
Message-ID: <CA+-6iNzyduQskgfEkQMiU15N8f2-gRAoqx=eNfYtOEQiV38SAg@mail.gmail.com>
Subject: Re: [PATCH v8 5/8] PCI/portdrv: add mechanism to turn on subdev regulators
To:     =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Jim Quinlan <jim2101024@gmail.com>,
        "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
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

On Thu, Nov 11, 2021 at 6:38 PM Krzysztof Wilczy=C5=84ski <kw@linux.com> wr=
ote:
>
> Hi Jim,
>
> [...]
> > [1] These regulators typically govern the actual power supply to the
> >     endpoint chip.  Sometimes they may be a the official PCIe socket
>
> In the above, did you mean to say "be at the"?
Yep.
>
> > +static void *alloc_subdev_regulators(struct device *dev)
> > +{
> > +     static const char * const supplies[] =3D {
> > +             "vpcie3v3",
> > +             "vpcie3v3aux",
> > +             "vpcie12v",
> > +     };
> > +     const size_t size =3D sizeof(struct subdev_regulators)
> > +             + sizeof(struct regulator_bulk_data) * ARRAY_SIZE(supplie=
s);
>
> [...]
> > +int pci_subdev_regulators_add_bus(struct pci_bus *bus)
> > +{
> > +     struct device *dev =3D &bus->dev;
> > +     struct subdev_regulators *sr;
> > +     int ret;
> > +
> > +     if (!pcie_is_port_dev(bus->self))
> > +             return 0;
> > +
> > +     if (WARN_ON(bus->dev.driver_data))
> > +             dev_err(dev, "multiple clients using dev.driver_data\n");
>
> I have to ask - is the WARN_ON() above adding value given the nature of t=
he
> error?  Would dumping a stack be of interest to someone?
Hello Krzysztof,

It doesn't need to be a warning.  You are right, the backtrace will
not help anyone figure out how to fix the problem.

>
> Having said that, why do we even need to assert this?  Can there be some
> sort of a race condition with access happening here?
This commit-set is claiming the driver_data field of the PCIe port
device and I am concerned  that something else in the future would
unknowingly do the same.  It would not be a race, just two separate
pieces of code stomping on the same variable.  If I am over-worrying I
can use a dev_err or nothing at all.


>
> I am asking as pci_subdev_regulators_remove_bus() does not seem to be
> concerned about this sort of thing yet it also accesses the same driver
> data, and such.
Yes, but when pci_subdev_regulators_remove_bus() accesses the port
driver driver_data and it is non-NULL  it  does not  know whether it
is the expected pointer or something else.

>
> [...]
> > +/* forward declaration */
> > +static struct pci_driver pcie_portdriver;
>
> The comment above might not be needed as it's quite obvious what the code
> at this line is for, I believe.
Okay.
>
> [...]
> > @@ -131,6 +155,13 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
> >       if (status)
> >               return status;
> >
> > +     if (dev->bus->ops &&
> > +         dev->bus->ops->add_bus &&
> > +         dev->bus->dev.driver_data) {
> > +             pcie_portdriver.resume =3D subdev_regulator_resume;
> > +             pcie_portdriver.suspend =3D subdev_regulator_suspend;
> > +     }
> > +
> >       pci_save_state(dev);
>
> [...]
> > @@ -237,6 +268,7 @@ static struct pci_driver pcie_portdriver =3D {
> >       .err_handler    =3D &pcie_portdrv_err_handler,
> >
> >       .driver.pm      =3D PCIE_PORTDRV_PM_OPS,
> > +     /* Note: suspend and resume may be set during probe */
>
> This comment here is for the "driver.pm" line above, correct?  If so, the=
n
> I would move it above the statement.  It's a little bit confusing
> otherwise.
I'm planning to remove this comment and the code that sets
pcie_portdriver.{resume,suspend} and instead put this code into the
int pcie_port_device_{suspend,remove}() functions.

Regards,
Jim Quinlan
Broadcom STB

>
>         Krzysztof
>
