Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 712B42791C5
	for <lists+linux-pci@lfdr.de>; Fri, 25 Sep 2020 22:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbgIYUMa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Sep 2020 16:12:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:41634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728153AbgIYUKa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 25 Sep 2020 16:10:30 -0400
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B37A239D0;
        Fri, 25 Sep 2020 19:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601063018;
        bh=XcyxD7o3T4uxEDDHeyvxWOgJX8D+176T3V+2nhs+oro=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=EBQLJ1lwD9UoT5W8rggPDIUh3MigsRiKEnbCQBvVLLjqQoFJuAuRIDOhfGywFfr6C
         TzM1PDVgxrHN7FlMYbuxGMeK8FqhLVmGAPxa+zPyJHHhu8emHagtgvzufS+rcuODsV
         iHBw6vA5mcISTtNJwuJjocKmfNkjPX68ekU4eGTs=
Date:   Fri, 25 Sep 2020 14:43:35 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Oliver O'Halloran <oohall@gmail.com>
Cc:     Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] rpadlpar_io:Add MODULE_DESCRIPTION entries to kernel
 modules
Message-ID: <20200925194335.GA2453596@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOSf1CEv3v940FR_we70qCBME0qFXPizPT8EFbf3XyK2-fPDrw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 24, 2020 at 04:41:39PM +1000, Oliver O'Halloran wrote:
> On Thu, Sep 24, 2020 at 3:15 PM Mamatha Inamdar
> <mamatha4@linux.vnet.ibm.com> wrote:
> >
> > This patch adds a brief MODULE_DESCRIPTION to rpadlpar_io kernel modules
> > (descriptions taken from Kconfig file)
> >
> > Signed-off-by: Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>
> > ---
> >  drivers/pci/hotplug/rpadlpar_core.c |    1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/pci/hotplug/rpadlpar_core.c b/drivers/pci/hotplug/rpadlpar_core.c
> > index f979b70..bac65ed 100644
> > --- a/drivers/pci/hotplug/rpadlpar_core.c
> > +++ b/drivers/pci/hotplug/rpadlpar_core.c
> > @@ -478,3 +478,4 @@ static void __exit rpadlpar_io_exit(void)
> >  module_init(rpadlpar_io_init);
> >  module_exit(rpadlpar_io_exit);
> >  MODULE_LICENSE("GPL");
> > +MODULE_DESCRIPTION("RPA Dynamic Logical Partitioning driver for I/O slots");
> 
> RPA as a spec was superseded by PAPR in the early 2000s. Can we rename
> this already?
> 
> The only potential problem I can see is scripts doing: modprobe
> rpadlpar_io or similar
> 
> However, we should be able to fix that with a module alias.

Is MODULE_DESCRIPTION() connected with how modprobe works?

If this patch just improves documentation, without breaking users of
modprobe, I'm fine with it, even if it would be nice to rename to PAPR
or something in the future.

But, please use "git log --oneline drivers/pci/hotplug/rpadlpar*" and
match the style, and also look through the rest of drivers/pci/ to see
if we should do the same thing to any other modules.

Bjorn
