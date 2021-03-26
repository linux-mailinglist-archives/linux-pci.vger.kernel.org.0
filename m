Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB20234A541
	for <lists+linux-pci@lfdr.de>; Fri, 26 Mar 2021 11:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbhCZKEy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Mar 2021 06:04:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:47862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229961AbhCZKEe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 26 Mar 2021 06:04:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 948A061A42;
        Fri, 26 Mar 2021 10:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616753073;
        bh=TVjO1AgSnLF3zZLd3P64jcFvlXrVSK+z3MXa7jHaaAc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YU+Y18IR4hpvzDGRoGZC78qc8DlcNDZaFKKaqPjUrX47Y7e5ie4Udn4g1hfz9HJpj
         gh722YJGt1fpF7VUCp275WTLTP2U91km927sH72u2vcErNTvGXR0IHtCCuPwyY/1MD
         v8wo0SbdNRqXq9rJSdHc9l+VuKsaEeKpz64ecApTXkJxSPN7q32pb60QwyQsb4Wn7O
         4zBUckFBQz5lDLIsstusVjt60FdxLRfdzE6qZT1Nj75QKkt9yM4XBkwLYxkQ/j/xm+
         At2b20h/CAtRIG0R7tLeJnohILB/OzllacIod4qxrSCiujDKuL3MZ30+JwnsRp2gIw
         xAYNtEdUeSrng==
Date:   Fri, 26 Mar 2021 11:04:28 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Rob Herring <robh@kernel.org>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 04/11] PCI: dwc: pcie-kirin: add support for Kirin
 970 PCIe controller
Message-ID: <20210326110428.51a0abc9@coco.lan>
In-Reply-To: <20210326085102.GA25371@work>
References: <cover.1612335031.git.mchehab+huawei@kernel.org>
        <4c9d6581478aa966698758c0420933f5defab4dd.1612335031.git.mchehab+huawei@kernel.org>
        <CAL_JsqK7_hAw4aacHyiqJWE6zSWiMez5695+deaCSHfeWuX-XA@mail.gmail.com>
        <20210326093936.02ba3a03@coco.lan>
        <20210326085102.GA25371@work>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Em Fri, 26 Mar 2021 14:21:02 +0530
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> escreveu:

> On Fri, Mar 26, 2021 at 09:39:36AM +0100, Mauro Carvalho Chehab wrote:
> > Em Wed, 3 Feb 2021 08:34:21 -0600
> > Rob Herring <robh@kernel.org> escreveu:
> >   
> > > On Wed, Feb 3, 2021 at 1:02 AM Mauro Carvalho Chehab
> > > <mchehab+huawei@kernel.org> wrote:  
> > > >
> > > > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > >
> > > > Add support for HiSilicon Kirin 970 (hi3670) SoC PCIe controller, based
> > > > on Synopsys DesignWare PCIe controller IP.
> > > >
> > > > [mchehab+huawei@kernel.org: fix merge conflicts]
> > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > > > ---
> > > >  drivers/pci/controller/dwc/pcie-kirin.c | 723 +++++++++++++++++++++++-
> > > >  1 file changed, 707 insertions(+), 16 deletions(-)
> > > >
> > > > diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
> > > > index 026fd1e42a55..5925d2b345a8 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-kirin.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-kirin.c
> > > > @@ -29,6 +29,7 @@  
> > >   
> 
> [...]
> 
> > > This looks like it is almost all phy related. I think it should all be
> > > moved to a separate phy driver. Yes, we have some other PCI drivers
> > > controlling their phys directly where the phy registers are
> > > intermingled with the PCI host registers, but I think those either
> > > predate the phy subsystem or are really simple. I also have a dream to
> > > move all the phy control to the DWC core code.  
> > 
> > Please notice that this patch was not written by me, but, instead,
> > by Mannivannan. So, I can't change it.  
> 
> Feel free to move the PHY pieces to a separate PHY driver as suggested.
> My driver code was merely WIP one and I don't have any objection to
> change the patch.
> 
> I'd be happy if you add my Co-developed tag to the PCIe driver patch with
> the SoB ofc.

Ok.

> > What I can certainly do is to
> > write a separate patch at the end of this series moving the Kirin 970
> > phy to a separate driver. Would this be accepted?
> >   
> 
> Ah, please don't do that. I know that you've already followed the same
> process for other HiSi drivers but that looks messy IMO.

The problem is related to licensing issues and US export regulations. 

By preserving the patches from the original authors, I played safe.

> 
> > Btw, what should be done with the Kirin 960 PHY code that it is
> > already embedded on this driver, and whose some of the DT properties
> > are for its phy layer? 
> >   
> 
> You might need to create a PHY driver for both 960 and 970. I don't see
> any harm there. But please make sure you test the patches on both boards.

Testing on Kirin 960 will be harder. Well, I can get my hands on one
such board, but right now I don't have any M.2 device I can spare with,
in order to test.

This will also break DT backward compatibility, as, for instance, the
PERST# gpio seems to be part of the Kirin 960 PHY, as Kirin 970 has
different PERST# logic: on Kirin 970, there's one PERST# GPIO per PCIe
device.

So, before starting such change, I need to know if DT maintainers
are OK with that.

Thanks,
Mauro
