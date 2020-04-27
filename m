Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C30331B97B1
	for <lists+linux-pci@lfdr.de>; Mon, 27 Apr 2020 08:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbgD0Gqh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Apr 2020 02:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbgD0Gqh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Apr 2020 02:46:37 -0400
Received: from vultr.net.flygoat.com (vultr.net.flygoat.com [IPv6:2001:19f0:6001:3633:5400:2ff:fe8c:553])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4CAC061A0F;
        Sun, 26 Apr 2020 23:46:37 -0700 (PDT)
Received: from flygoat-x1e (unknown [IPv6:240e:390:491:f2b0::d68])
        by vultr.net.flygoat.com (Postfix) with ESMTPSA id 491202049F;
        Mon, 27 Apr 2020 06:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com; s=vultr;
        t=1587969996; bh=87cY8c65SZbqmYxYzk6T3jS7ROhx/jS7jol+umwWuSU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ipmZLB70pSVEu9CTWQUAPnv8VwbpFKilRfFvtvs2qQqppq+N6gnGsLm272ScTwsAT
         pQOSD3mKgw1ZTRqT7P7EKI1Lgm7jEDUPAYpZJRW3emSSkbETQupWpVcLckr+fRsdS1
         WIGijRv/PVDI/Uqt82jPlUetvVCk4jW4a4UF2H0v3dU8a5drnVxoPFYx0eGXc3vO49
         INyafcEamxMEuTGOXCwS5H2uRvboiBRjuOte/zrPwWWini+IkfBdXRgdHFNucyPbTZ
         CLUVS2jO7mdz1TeqKEsmLmAEFGammRDOnWMziS23ni9A8OKCcnY42fU+nJ1LJA2Yrj
         eBUmFNS0uCXIg==
Date:   Mon, 27 Apr 2020 14:46:18 +0800
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     "open list:MIPS" <linux-mips@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Paul Burton <paulburton@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 2/5] PCI: Add Loongson PCI Controller support
Message-ID: <20200427144618.1e7a642a@flygoat-x1e>
In-Reply-To: <CAAhV-H6JpHUJ_aQ0zSzMquSQBkA5Roo6bOUqhLys_AZhbp1UmA@mail.gmail.com>
References: <20200427060551.1372591-1-jiaxun.yang@flygoat.com>
        <20200427060551.1372591-3-jiaxun.yang@flygoat.com>
        <CAAhV-H6JpHUJ_aQ0zSzMquSQBkA5Roo6bOUqhLys_AZhbp1UmA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 27 Apr 2020 14:29:34 +0800
Huacai Chen <chenhc@lemote.com> wrote:

> Hi, Jiaxun,
> 
> On Mon, Apr 27, 2020 at 2:06 PM Jiaxun Yang <jiaxun.yang@flygoat.com>
> wrote:
> >
> > This controller can be found on Loongson-2K SoC, Loongson-3
> > systems with RS780E/LS7A PCH.
> >
> > The RS780E part of code was previously located at
> > arch/mips/pci/ops-loongson3.c and now it can use generic PCI
> > driver implementation.
> >
> > Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> >
> > --
> > v2:
> >         - Clean up according to rob's suggestions
> >         - Claim that it can't work as a module
> > v3:
> >         - Fix a typo
> > v4:
> >         - More clean-ups: Drop flag check, use devfn
> > ---
> >  drivers/pci/controller/Kconfig        |  10 +
> >  drivers/pci/controller/Makefile       |   1 +
> >  drivers/pci/controller/pci-loongson.c | 251

[...]

> > +static const struct of_device_id loongson_pci_of_match[] = {
> > +       { .compatible = "loongson,rs780e-pci",
> > +               .data = (void *)(FLAG_CFG0), },
> > +       { .compatible = "loongson,ls2k-pci",
> > +               .data = (void *)(FLAG_CFG0 | FLAG_CFG1 |
> > FLAG_DEV_FIX), },
> > +       { .compatible = "loongson,ls7a-pci",
> > +               .data = (void *)(FLAG_CFG0 | FLAG_CFG1 |
> > FLAG_DEV_FIX), },  
> I suggest to use alpha-betical order here: ls2k, ls7a and rs780 at
> last.

Thanks for pointing out this minor issue.
I put rs780e at first at it appears to be the first system using this
driver.
If there is no more review suggestion I'll send out next revision very
soon. 

[...]

--
Jiaxun Yang
