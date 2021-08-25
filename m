Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 311A23F77DD
	for <lists+linux-pci@lfdr.de>; Wed, 25 Aug 2021 16:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239939AbhHYO6v (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Aug 2021 10:58:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:55320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231975AbhHYO6u (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 25 Aug 2021 10:58:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E54BC610E6;
        Wed, 25 Aug 2021 14:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629903484;
        bh=XuKq1zIIMq/OtChRUdQ0vOQzAnhzbI0dxtVr4wcAgDA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YvV8UlOvjbvsB0RkZMgL4YbyeKBKjZqzYhbbkQKcATpLeGd2BrN9PpesAoyiWbIhC
         GeWvz7A9Lb/XXxEkUf6+NTd9Cyfno/JEZLq8JHsx1KPe71/46buyRZqnUAc+sKZHRF
         qEnJrMf1uWfNIsab9i7m2F0cK/tUCg+i+Gc1qoXekwpq/eJc8dqoH1XyL0jlDVoDmR
         qgWgdHPfvxWvM7kSa8P+DQnWJuKXseZhaARLJRcmVp5109C0BVruamxYinLk8G6tRv
         IhN41+5Q53W5fyLDDuxZKPE37LRWPtYdS+c8l7lDW6Ex0UmXG5RRXWca5lOhBSy2QE
         s60AFQLQRsDig==
Received: by mail-ed1-f45.google.com with SMTP id q3so37444789edt.5;
        Wed, 25 Aug 2021 07:58:04 -0700 (PDT)
X-Gm-Message-State: AOAM533OoH12hbMccK6ITunfktWPZQaXXfmOKYJGJd1EfQ9oiPwFyNIK
        SqD5U9BNZw/E/78Yn+FrqHhRTNuD5GcKoo9bGw==
X-Google-Smtp-Source: ABdhPJwPn9HhyJ/B+5FAoAdEgoxYV2mtd8rUO27aqvKNxs57ww2VmIrdKZuZXvoWjCyEPb5V7XMr2dA7WkL3ZPQqLek=
X-Received: by 2002:a50:9b52:: with SMTP id a18mr49080750edj.165.1629903483580;
 Wed, 25 Aug 2021 07:58:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210820160023.3243-1-pali@kernel.org> <20210820160023.3243-2-pali@kernel.org>
 <YSURxtc7UAaSEfSy@robh.at.kernel.org> <20210824161409.2mxzpy5r32tm3kgu@pali>
In-Reply-To: <20210824161409.2mxzpy5r32tm3kgu@pali>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 25 Aug 2021 09:57:52 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL1NzTp8v+kw1M_aS5OmJMuRiuys4RKYTT2yYy4pKNzJA@mail.gmail.com>
Message-ID: <CAL_JsqL1NzTp8v+kw1M_aS5OmJMuRiuys4RKYTT2yYy4pKNzJA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] dt-bindings: Add 'slot-power-limit' PCIe port property
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>,
        PCI <linux-pci@vger.kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 24, 2021 at 11:14 AM Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> On Tuesday 24 August 2021 10:35:34 Rob Herring wrote:
> > On Fri, Aug 20, 2021 at 06:00:21PM +0200, Pali Roh=C3=A1r wrote:
> > > This property specifies slot power limit in mW unit. It is form-facto=
r and
> > > board specific value and must be initialized by hardware.
> > >
> > > Some PCIe controllers delegates this work to software to allow hardwa=
re
> > > flexibility and therefore this property basically specifies what shou=
ld
> > > host bridge programs into PCIe Slot Capabilities registers.
> > >
> > > Property needs to be specified in mW unit, and not in special format
> > > defined by Slot Capabilities (which encodes scaling factor or differe=
nt
> > > unit). Host drivers should convert value from mW unit to their format=
.
> > >
> > > Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> > > ---
> > >  Documentation/devicetree/bindings/pci/pci.txt | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> >
> > This needs to be in dtschema schemas/pci/pci-bus.yaml instead.
> >
> > (pci.txt is still here because it needs to be relicensed to move all th=
e
> > descriptions to pci-bus.yaml.)
>
> Ok, this is just a proposal for a new DTS property. So documentation
> issues will be fixed in real patch.
>
> > >
> > > diff --git a/Documentation/devicetree/bindings/pci/pci.txt b/Document=
ation/devicetree/bindings/pci/pci.txt
> > > index 6a8f2874a24d..e67d5db21514 100644
> > > --- a/Documentation/devicetree/bindings/pci/pci.txt
> > > +++ b/Documentation/devicetree/bindings/pci/pci.txt
> > > @@ -32,6 +32,12 @@ driver implementation may support the following pr=
operties:
> > >     root port to downstream device and host bridge drivers can do pro=
gramming
> > >     which depends on CLKREQ signal existence. For example, programmin=
g root port
> > >     not to advertise ASPM L1 Sub-States support if there is no CLKREQ=
 signal.
> > > +- slot-power-limit:
> > > +   If present this property specifies slot power limit in mW unit. H=
ost drivers
> >
> > As mentioned, this should have a unit suffix. I'm not sure it is
> > beneficial to share with SFP in this case though.
> >
> > > +   can parse this slot power limit and use it for programming Root P=
ort or host
> > > +   bridge, or for composing and sending PCIe Set_Slot_Power_Limit me=
ssage
> > > +   through the Root Port or host bridge when transitioning PCIe link=
 from a
> > > +   non-DL_Up Status to a DL_Up Status.
> >
> > I no nothing about how this mechanism works, but I think this belongs i=
n
> > the next section as for PCIe, a slot is always below a PCI-PCI bridge.
> > If we have N slots, then there's N bridges and needs to be N
> > slot-power-limit properties, right?
> >
> > (The same is probably true for all the properties here except
> > linux,pci-domain.) There's no distinction between host and PCI bridges
> > in pci-bus.yaml though.
> >
> > Rob
>
> This slot-power-limit property belongs to same place where are also
> other slot properties (link speed, reset gpios, clkreq). So I put it in
> place where others are.
>
> But I'm not sure where it should be as it affects link/slot. Because
> link has two sides. I guess that link speed and slot power limit could
> belong to the root/downstream port and reset gpio to the endpoint card
> or upstream port...

I wasn't debating whether it goes upstream or downstream, but just
that it can apply to more than just the host bridge or root port(s).
We have that now already with reset-gpios. Look at the hikey970 case
that's queued for 5.15. It's got RP -> switch -> slots/devices with
reset gpio on each slot.

As for upstream vs. downstream side, this is one of those cases where
we didn't represent the downstream side in DT, so everything gets
stuffed in the upstream side. As PCIe is point to point, it doesn't
matter so much. It would be a bigger issue on old PCI.

Rob
