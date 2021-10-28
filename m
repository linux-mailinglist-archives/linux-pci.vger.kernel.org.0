Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 131A143DE45
	for <lists+linux-pci@lfdr.de>; Thu, 28 Oct 2021 11:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbhJ1KB7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Oct 2021 06:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhJ1KB4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Oct 2021 06:01:56 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768FDC061570;
        Thu, 28 Oct 2021 02:59:29 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id q13so10466161uaq.2;
        Thu, 28 Oct 2021 02:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HGGQ7RqFpKeC9CxBW+k8kpLsGeNQocDgaLhurL7DcEI=;
        b=WizV7VgtkLy3fe2e0o1pfzbFecHihzXI0Id4xUaMYbtMTOAMqXIFLdyS9M2duUuMz3
         r4sFwt/CYjnK4bgu+1DyEQBwyR7Q70aPYhsqJjPF996z3shUdkBl967YF0ymWY+a448g
         RTpxrT300XgMMtmHX6u+JD3WXsmClh4yO8nD24YFkfG5hM9kBja7+RxxEAHj7KT+s3in
         OYXDsbbCrU723hxPx87IcrPx+np95xU3p5LQWXav9tDIgrBgEPuXZ2+tr8maaJwA2H51
         q9DJ/uCnkinwqQzQ+hi9u5xE13GOCSClyqmv5hLl+X8gb6qnnZB59b1sNvh6/EGc+1+C
         oNiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HGGQ7RqFpKeC9CxBW+k8kpLsGeNQocDgaLhurL7DcEI=;
        b=OFuMP/0IEBFBNKjsTxECz80gpPGkucrPlVbjxnQXvITrVGboH5ZlZYLeu9y1lAj4Gl
         x3MEaveCScFzIu9QZNlf7v3SwgZ2Wtz9untYK/rkD/jwOG7geiZNPMFSREgL46hWK9tQ
         N4mGRuNMIJoHdaia8Wno3Cd53rJ058K7YqqsL7ZzsWOyp0DqqzDt7bjIbVL006dOWaXj
         u4wEn2u7EWfMHcbPlj/NPtO0YI0m96mjXyjUUeLbWtQuV5uvUqkWnFQWYNEnu2fG6bus
         Yx7TVonPiSmPCIfnG0qOABaJzP+9qMibkRCwBmoVXNbfcImd37EPwHfrO7VWhKjuQWNA
         BY1Q==
X-Gm-Message-State: AOAM531FhFcN0GS1Tgm/ASUMlI4vTuGaEW356E28Tj+mU2+QaZn0SJm+
        nnmpoC0zpkxa51kRx31oxJaUF4C9e8GE+k94KLCNqIazttg=
X-Google-Smtp-Source: ABdhPJzrE18emHRymB8uKvYxaQU2LsVWX8ihdn4v4ExoK4X3tzhQ0bdB6x4Z47vqjrm3sGQ67yZI4DOVVN9myD89gWE=
X-Received: by 2002:ab0:3cab:: with SMTP id a43mr3208667uax.98.1635415168662;
 Thu, 28 Oct 2021 02:59:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1635390750.git.siyanteng@loongson.cn> <112fea0c8c1b65a762ac98412216239160721263.1635390750.git.siyanteng@loongson.cn>
 <CAMhs-H9LUQ6Km=sA992LH=+E0MbGuMf9YhM6w2HoyeqE0QbzJQ@mail.gmail.com>
 <20211028092318.GA6574@alpha.franken.de> <CAMhs-H_m=pz4jU_cY-A6PRjR3OYy2zKH0=HN=vFDF2XOk60xBg@mail.gmail.com>
In-Reply-To: <CAMhs-H_m=pz4jU_cY-A6PRjR3OYy2zKH0=HN=vFDF2XOk60xBg@mail.gmail.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Thu, 28 Oct 2021 11:59:17 +0200
Message-ID: <CAMhs-H8HoO7dsfiTFaTRie1-DB-DF5st-gFmS=AF2tfHP_gsVw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] MIPS: cm/cpc: export some missing symbols to be
 able to use them from driver code
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Yanteng Si <siyanteng01@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Yanteng Si <siyanteng@loongson.cn>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, kw@linux.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        chenhuacai@kernel.org, sterlingteng@gmail.com,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 28, 2021 at 11:34 AM Sergio Paracuellos
<sergio.paracuellos@gmail.com> wrote:
>
> Hi Thomas,
>
> On Thu, Oct 28, 2021 at 11:24 AM Thomas Bogendoerfer
> <tsbogend@alpha.franken.de> wrote:
> >
> > On Thu, Oct 28, 2021 at 06:11:18AM +0200, Sergio Paracuellos wrote:
> > > On Thu, Oct 28, 2021 at 6:05 AM Yanteng Si <siyanteng01@gmail.com> wrote:
> > > >
> > > > Since commit 2bdd5238e756 ("PCI: mt7621: Add MediaTek MT7621 PCIe host controller driver")
> > > > the MT7621 PCIe host controller driver is built as a module but modpost complains once these
> > > > drivers become modules.
> > > >
> > > > ERROR: modpost: "mips_cm_unlock_other" [drivers/pci/controller/pcie-mt7621.ko] undefined!
> > > > ERROR: modpost: "mips_cpc_base" [drivers/pci/controller/pcie-mt7621.ko] undefined!
> > > > ERROR: modpost: "mips_cm_lock_other" [drivers/pci/controller/pcie-mt7621.ko] undefined!
> > > > ERROR: modpost: "mips_cm_is64" [drivers/pci/controller/pcie-mt7621.ko] undefined!
> > > > ERROR: modpost: "mips_gcr_base" [drivers/pci/controller/pcie-mt7621.ko] undefined!
> > > >
> > > > Let's just export them.
> > > >
> > > > Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> > > > ---
> > > >  arch/mips/kernel/mips-cm.c  | 5 +++++
> > > >  arch/mips/kernel/mips-cpc.c | 1 +
> > > >  2 files changed, 6 insertions(+)
> > > >
> > >
> > > Reviewed-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> >
> > could we instead make the pcie-mt761 driver non modular ? Exporting
> > all MIPS specific stuff for just making an essential driver modular
> > doesn't IMHO make much sense.
>
> The driver is modular because I have been advised other times that new
> drivers should be able to be compiled as modules and we should avoid
> using 'bool' in Kconfig for new drivers. That's the only reason. I am
> also always including as 'y' the driver since for me not having pci in
> my boards has no sense... I am ok in changing Kconfig to be 'bool'
> instead of 'tristate', but I don't know what should be the correct
> thing to do in this case. Thoughts?

I guess we also want the driver to at least be compile tested in
'allmodconfig' and other similars...

>
> Best regards,
>     Sergio Paracuellos
>
> >
> > Thomas.
> >
> > --
> > Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
> > good idea.                                                [ RFC1925, 2.3 ]
