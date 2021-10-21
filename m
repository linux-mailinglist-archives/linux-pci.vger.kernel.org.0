Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9534D4361F1
	for <lists+linux-pci@lfdr.de>; Thu, 21 Oct 2021 14:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbhJUMmp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Oct 2021 08:42:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:42136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230190AbhJUMmo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 Oct 2021 08:42:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 973E860E97;
        Thu, 21 Oct 2021 12:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634820029;
        bh=gbmpXmeM0c4N6qsFqTfy8xE6riZVnWgkiKU8PU2YW3c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ui8SkaTA47Wv1qCa5J3fF60indGFN1e/4dQfZoELT8KXpHXdVWGeCZ7979w6DyBpF
         MMajpXjrspCNPILc4dvZVeVuGOnt/51bNK+TFZwd9dVD72Wx36Sl4eIm03DK7YoEU7
         WlOdE1ZRR6sJRTdan9VGKi+rqBKhlqGnnz4TrHCGL7lnVCGg0JSWjBD86vOs0JHjWr
         e84laDPHCKUvCkH3AFIlXay8pF+GQv1JW7kdAADSURF6nsIdjyY55myT23v7AHOXaK
         H1a0ts+Lkt6cJ2SITFYaeFzcOJ495gJl3fHGW/sDf10rqnXdaRTaoo6VK7zpNHmsmR
         Nz9KHqL7xWjrg==
Date:   Thu, 21 Oct 2021 13:40:18 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Krzysztof =?UTF-8?B?V2ls?= =?UTF-8?B?Y3p5xYRza2k=?= 
        <kw@linux.com>, Songxiaowei <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v14 05/11] PCI: kirin: give more time for PERST# reset
 to finish
Message-ID: <20211021134018.58db2fcb@sal.lan>
In-Reply-To: <20211021122728.GB12568@lpieralisi>
References: <cover.1634622716.git.mchehab+huawei@kernel.org>
        <9a365cffe5af9ec5a1f79638968c3a2efa979b65.1634622716.git.mchehab+huawei@kernel.org>
        <20211021122728.GB12568@lpieralisi>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Em Thu, 21 Oct 2021 13:27:29 +0100
Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> escreveu:

> On Tue, Oct 19, 2021 at 07:06:42AM +0100, Mauro Carvalho Chehab wrote:
> > Before code refactor, the PERST# signals were sent at the
> > end of the power_on logic. Then, the PCI core would probe for
> > the buses and add them.
> > 
> > The new logic changed it to send PERST# signals during
> > add_bus operation. That altered the timings.
> > 
> > Also, HiKey 970 require a little more waiting time for
> > the PCI bridge - which is outside the SoC - to finish
> > the PERST# reset, and then initialize the eye diagram.
> >   
> 
> Ok, now you explained it and we should move this explanation
> in the commit log that this change is affecting (I mean we
> should squash this patch with the patch that actually requires it
> - I am not sure whether it is patch 6 or another one).

IMO, having it on a separate patch has the advantage of better documenting
this single line change, but yeah, this is part of the change needed to
handle PERST# on a more portable way to work for both chipsets.

> I can do it for you; I thought it would be a standalone change
> but it actually isn't, because it is brought about by the
> changes you are making and therefore there it belongs.

Feel free to squash this patch if you prefer so. whatever works best for you.

> Thanks for explaining it and apologies for the churn.

No problem.
 
> 
> Lorenzo
> 
> > So, increase the waiting time for the PERST# signals to
> > what's required for it to also work with HiKey 970.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> > 
> > See [PATCH v14 00/11] at: https://lore.kernel.org/all/cover.1634622716.git.mchehab+huawei@kernel.org/
> > 
> >  drivers/pci/controller/dwc/pcie-kirin.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
> > index de375795a3b8..bc329673632a 100644
> > --- a/drivers/pci/controller/dwc/pcie-kirin.c
> > +++ b/drivers/pci/controller/dwc/pcie-kirin.c
> > @@ -113,7 +113,7 @@ struct kirin_pcie {
> >  #define CRGCTRL_PCIE_ASSERT_BIT		0x8c000000
> >  
> >  /* Time for delay */
> > -#define REF_2_PERST_MIN		20000
> > +#define REF_2_PERST_MIN		21000
> >  #define REF_2_PERST_MAX		25000
> >  #define PERST_2_ACCESS_MIN	10000
> >  #define PERST_2_ACCESS_MAX	12000
> > -- 
> > 2.31.1
> >   
