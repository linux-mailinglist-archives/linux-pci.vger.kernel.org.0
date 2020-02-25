Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4A8E16BE6F
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2020 11:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729129AbgBYKSb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Feb 2020 05:18:31 -0500
Received: from foss.arm.com ([217.140.110.172]:48730 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728958AbgBYKSb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 Feb 2020 05:18:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C3F4330E;
        Tue, 25 Feb 2020 02:18:30 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 159A93F6CF;
        Tue, 25 Feb 2020 02:18:29 -0800 (PST)
Date:   Tue, 25 Feb 2020 10:18:25 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] PCI: endpoint: Fix clearing start entry in
 configfs
Message-ID: <20200225101825.GA4029@e121166-lin.cambridge.arm.com>
References: <1576844677-24933-1-git-send-email-hayashi.kunihiko@socionext.com>
 <20200221141553.GA15440@e121166-lin.cambridge.arm.com>
 <20200225190506.7DFA.4A936039@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200225190506.7DFA.4A936039@socionext.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 25, 2020 at 07:05:07PM +0900, Kunihiko Hayashi wrote:
> Hi Lorenzo,
> 
> On Fri, 21 Feb 2020 14:15:53 +0000 <lorenzo.pieralisi@arm.com> wrote:
> 
> > On Fri, Dec 20, 2019 at 09:24:37PM +0900, Kunihiko Hayashi wrote:
> > > The value of 'start' entry is no change whenever writing 0 to configfs.
> > > So the endpoint that stopped once can't restart.
> > > 
> > > The following command lines are an example restarting endpoint and
> > > reprogramming configurations after receiving bus-reset.
> > > 
> > >     echo 0 > controllers/66000000.pcie-ep/start
> > >     rm controllers/66000000.pcie-ep/func1
> > >     ln -s functions/pci_epf_test/func1 controllers/66000000.pcie-ep/
> > >     echo 1 > controllers/66000000.pcie-ep/start
> > > 
> > > However, the first 'echo' can't set 0 to 'start', so the last 'echo' can't
> > > restart endpoint.
> > 
> > I think your description is not correct - pci_epc_group->start is
> > just used to check if an endpoint has been started or not (in
> > pci_epc_epf_unlink() and that's a WARN_ON) but nonetheless this
> > looks like a bug and ought to be fixed.
> 
> When pci_epc_group->start keeps 1 after starting this controller with
> 'echo 1 > start', we can never unlink the func1 from the controller
> because of WARN_ON.

To me "I can never unlink" means that it can't be done, which
is not what's happening. What's happening is that unlinking triggers
a warning, which is different.

> I think that unlink/re-link play initialization role of configfs
> through 'unbind' and 'bind' functions. However, we can't re-initialize
> configfs.
> 
> If this is the intended behavior, my patch will make no sense.

Your patch makes sense, your commit log does not, see above.

> > I need Kishon's ACK to proceed.

Yes - then I am happy to merge this patch with a rewritten
commit log.

Thanks,
Lorenzo

> I think so, too.
> 
> Thank you,
> 
> > 
> > Thanks,
> > Lorenzo
> > 
> > > Fixes: d74679911610 ("PCI: endpoint: Introduce configfs entry for configuring EP functions")
> > > Cc: Kishon Vijay Abraham I <kishon@ti.com>
> > > Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> > > ---
> > >  drivers/pci/endpoint/pci-ep-cfs.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
> > > index d1288a0..4fead88 100644
> > > --- a/drivers/pci/endpoint/pci-ep-cfs.c
> > > +++ b/drivers/pci/endpoint/pci-ep-cfs.c
> > > @@ -58,6 +58,7 @@ static ssize_t pci_epc_start_store(struct config_item *item, const char *page,
> > >  
> > >  	if (!start) {
> > >  		pci_epc_stop(epc);
> > > +		epc_group->start = 0;
> > >  		return len;
> > >  	}
> > >  
> > > -- 
> > > 2.7.4
> > > 
> 
> ---
> Best Regards,
> Kunihiko Hayashi
> 
