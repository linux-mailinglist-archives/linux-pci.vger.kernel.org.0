Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A559D485483
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jan 2022 15:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240901AbiAEO2T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Jan 2022 09:28:19 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:40694 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241049AbiAEO1g (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Jan 2022 09:27:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2DF88B81AAA;
        Wed,  5 Jan 2022 14:27:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3564C36AE9;
        Wed,  5 Jan 2022 14:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641392854;
        bh=NSgu7QgCPyLT3ZEIlC39N6d7jNUd78Bwgc/Chwj5oDI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VXWJ7uqqibiwqgsAy969b8CdKwZ71lURLqu66NixlX2EOUKbGyUhuxJbRi8GCK9hl
         fgTUCo4U9G0NIgUI+ldq/BO43i2udII7TYuFLBCHxYW0OhAm150ZW9171GDZWPWXVB
         YxRH0/EoKi9EF7CgvqrKfcbnTbJpsPYe2NiyEaOgvO3K1XPogMMdU3CfOPYoSNXhSy
         5RDNemHFV+IYnulBV0TXVaZmJMt/XLmB5ZSUMlxP2Mz2/8owgR6XjzI98UxIzFjaET
         DkHZixW7w2DG91pMCpQNtxHtYQ0e4ESLMzPVInKykLxI6ffYtMNeJr4PnUuHVzjY8v
         OcTbXtKM/mtWw==
Received: by mail-ed1-f54.google.com with SMTP id w16so162848869edc.11;
        Wed, 05 Jan 2022 06:27:33 -0800 (PST)
X-Gm-Message-State: AOAM530qv7LmSdYNsCPlj5X4EUtZy75W7b37eSr+QQHMvYizopqOOvpF
        QvG0ar7YR/3w1L1iVjNdJ4R7NuQvlSdjaOR/MQ==
X-Google-Smtp-Source: ABdhPJzFBn6q8wDUS6fWvCfmpw8gFYBPxEWCnp0cCBOIJmp3WJvP6m0YgHUCW4NpuyIjR6cc6EEK64HQPBUs6VtWRcg=
X-Received: by 2002:aa7:cd5a:: with SMTP id v26mr53971278edw.303.1641392852307;
 Wed, 05 Jan 2022 06:27:32 -0800 (PST)
MIME-Version: 1.0
References: <20211031150706.27873-1-kabel@kernel.org> <YY6HYM4T+A+tm85P@robh.at.kernel.org>
 <20220105151444.7b0b216e@thinkpad>
In-Reply-To: <20220105151444.7b0b216e@thinkpad>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 5 Jan 2022 08:27:21 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+HjnDfDb+V6dctNZy78Lbz92ULGzCvkTWwSyop_BKFtA@mail.gmail.com>
Message-ID: <CAL_Jsq+HjnDfDb+V6dctNZy78Lbz92ULGzCvkTWwSyop_BKFtA@mail.gmail.com>
Subject: Re: [PATCH dt + pci 1/2] dt-bindings: Add 'slot-power-limit-milliwatt'
 PCIe port property
To:     =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>
Cc:     devicetree@vger.kernel.org, PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 5, 2022 at 8:14 AM Marek Beh=C3=BAn <kabel@kernel.org> wrote:
>
> On Fri, 12 Nov 2021 09:25:20 -0600
> Rob Herring <robh@kernel.org> wrote:
>
> > On Sun, Oct 31, 2021 at 04:07:05PM +0100, Marek Beh=C3=BAn wrote:
> > > From: Pali Roh=C3=A1r <pali@kernel.org>
> > >
> > > This property specifies slot power limit in mW unit. It is a form-fac=
tor
> > > and board specific value and must be initialized by hardware.
> > >
> > > Some PCIe controllers delegate this work to software to allow hardwar=
e
> > > flexibility and therefore this property basically specifies what shou=
ld
> > > host bridge program into PCIe Slot Capabilities registers.
> > >
> > > The property needs to be specified in mW unit instead of the special =
format
> > > defined by Slot Capabilities (which encodes scaling factor or differe=
nt
> > > unit). Host drivers should convert the value from mW to needed format=
.
> > >
> > > Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> > > Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org>
> > > ---
> > >  Documentation/devicetree/bindings/pci/pci.txt | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/pci/pci.txt b/Document=
ation/devicetree/bindings/pci/pci.txt
> > > index 6a8f2874a24d..7296d599c5ac 100644
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
> > > +- slot-power-limit-miliwatt:
> >
> > Typo.
> >
> > But we shouldn't be adding to pci.txt. This needs to go in the
> > schema[1]. Patch to devicetree-spec list or GH PR is fine.
>
> Hello Rob,
>
> Pali's PR draft https://github.com/devicetree-org/dt-schema/pull/64
> looks like it's going to take some time to work out.
>
> In the meantime, is it possible to somehow get the
> slot-power-limit-milliwatt property merged into pci.txt so that we can st=
art
> putting it into existing device-trees?
>
> Or would it break dt_bindings_check if it isn't put into dt-schema's
> pci-bus.yaml?
>
> Or should we simply put it into current version of pci-bus.yaml and
> work out the split proposed by Pali's PR afterwards?

In the existing pci-bus.yaml is fine.

Rob
