Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4DC139C232
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jun 2021 23:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbhFDVTH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Jun 2021 17:19:07 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:34396 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbhFDVTG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Jun 2021 17:19:06 -0400
Received: by mail-ot1-f41.google.com with SMTP id v27-20020a056830091bb02903cd67d40070so7327637ott.1;
        Fri, 04 Jun 2021 14:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VrpYDmA2bDYdBnxEAitWI5SHLDNVcxWIKBXiEWgGkbU=;
        b=IcUmRhKY7t0zANMd2hJSQLTmxlFqI7OPYK/zlewwUe4OGJw2WLFtW5/qsEPJ7Gf7+g
         N6Yg+qmvGCZvkmTIpbjNBNotYoBFgCncc41y09eyWSUzWQNwjwrxqVVH6O9OgTUcZdSy
         urRm3Oo02YlEBSIGGbrYrAPoETwaTaUevVN4NgovB8C0IKTEmItc+5MtLEJUY049ZKW0
         B33LRqreS28QR6TGLh5yrGkqIpKXYmwjoE4WPLPP3GaLfLWMYRgVfGfEkURjnfd88iQg
         zgDvsqKH1q8L22RctnYj+IjPMpIeCqeaoKZbeTzlnnmRwB7T7cyspJdNmzvVuJid7ws2
         FtYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VrpYDmA2bDYdBnxEAitWI5SHLDNVcxWIKBXiEWgGkbU=;
        b=WGeefmwtx7U3YmnQ3M3GxyJ5AAtRZV4hyxVnUyiiwNbm4iwJXS2OS2SpO8M0CfYl47
         4JW5nRHJHrmiV22PR+h78USuHXI3Tn0FkSUNlqAsSezibBk5AGydXfGj2jID/ksi+238
         yleTzcEqXEeWjRJv67uFLSyKhwMaylbbV6GGyYsZ70MBtVPLUV07PSsPfepslD7KfjFJ
         FPfcH+84dKqNFX3rLwR6DAH/Oos2UDNFkWWyy2LWe2CdQY1OKFQIqV2M47FjdEXhomhd
         dOtS01OgbiNtyEvQavszkK+dFGORFo3nm/n3F4NHqECvRtUOdTlDoVxCXSnBuiZg7G3b
         jgrA==
X-Gm-Message-State: AOAM532Efh9UEhMsI/3HgFEK2VbasJNYm/OEXi9Q4ofWPSQo3Je9qONM
        1wQ8zap80DVN/JrvcBWiuWOjLbNwOtsABQG/z9I=
X-Google-Smtp-Source: ABdhPJz5dL97b+GG9y2RUOQR0MN8RqtrqhZBj75z8mptERR5tBk4fyi+plmEfG1J4qn2/c6C/3Aa1ZdJS6n+5j2hD1w=
X-Received: by 2002:a9d:4f19:: with SMTP id d25mr5336285otl.72.1622841368139;
 Fri, 04 Jun 2021 14:16:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210531131845.ookvz7njj6yrkaeh@pali> <20210604194328.GA2230062@bjorn-Precision-5520>
In-Reply-To: <20210604194328.GA2230062@bjorn-Precision-5520>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Fri, 4 Jun 2021 23:15:56 +0200
Message-ID: <CAMhs-H98efm9bCL4ff85mcbKReBVyGsVmMw-YXRL_FXzPTyw4Q@mail.gmail.com>
Subject: Re: [PATCH 0/4] MIPS: ralink: pci: driver for Pcie controller in
 MT7621 SoCs
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        lorenzo.pieralisi@arm.com,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        John Crispin <john@phrozen.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-staging@lists.linux.dev,
        Greg KH <gregkh@linuxfoundation.org>,
        NeilBrown <neil@brown.name>,
        Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On Fri, Jun 4, 2021 at 9:43 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Mon, May 31, 2021 at 03:18:45PM +0200, Pali Roh=C3=A1r wrote:
> > On Friday 21 May 2021 12:23:38 Thomas Bogendoerfer wrote:
> > > On Wed, May 19, 2021 at 11:18:36PM +0200, Sergio Paracuellos wrote:
> > > > On Wed, May 19, 2021 at 10:36 PM Bjorn Helgaas <helgaas@kernel.org>=
 wrote:
> > > > > But most of the similar drivers are in drivers/pci/controller/, w=
here
> > > > > I think it's easier to keep them up to date with changes in the P=
CI
> > > > > core.  Have you considered putting this one there?
> > > >
> > > > Most pci drivers in 'arch/mips/pci' are still using PCI_LEGACY stuf=
f.
> > > > In contrast mt7621-pci is using current pci generic apis but even m=
ost
> > > > of the code is generic enough, there is one remaining thing which
> > > > depends on mips architecture which is the iocu region configuration
> > > > which must be done in the driver itself. This is the only reason to
> > > > move this driver into 'arch/mips/pci' instead of
> > > > 'drivers/pci/controller/'. So... I am all ears to listen to
> > > > suggestions for the proper place for this driver. Thomas, do you ha=
ve
> > > > any thoughts on this?
> > >
> > > I tried to put a pci-xtalk driver into drivers/pci/controller, but
> > > Lorenzo didn't want it there for being MIPS and not DT based. So this
> > > one is DT based, but still MIPS. I'm perfectly fine putting this
> > > driver into drivers/pci/controller/
> >
> > In my personal opinion this driver could go into drivers/pci/controller=
/
>
> I'm not sure exactly what "PCI_LEGACY" above refers to.

I meant most of the drivers there are not using current generic pci
apis but still using pci legacy ones.

>
> I don't see any direct #includes of arch/mips in the driver.  I do see
> that it uses mips_cps_numiocu(), which is certainly MIPS-specific.

Yes, mips_cps_numiocu is the only stuff needed and arch specific used
by this driver.

>
> But we do have some things in drivers/pci/controller/ that only build
> on certain arches, enforced mostly by Kconfig rules, so I think you
> could do that.  We try to make so things can at least be *compiled* on
> any arch, but I know that's not always possible.
>
> So I think it would be useful to put this in drivers/pci/controller/
> somewhere because it will make it easier to see common patterns and
> refactoring opportunities.

Ok, so I will move the driver into 'drivers/pci/controller/' in v2.

Thanks,
    Sergio Paracuellos
>
> Bjorn
