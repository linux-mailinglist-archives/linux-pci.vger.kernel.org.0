Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8216E16BE3A
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2020 11:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729462AbgBYKFK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Feb 2020 05:05:10 -0500
Received: from mx.socionext.com ([202.248.49.38]:34642 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727016AbgBYKFK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 Feb 2020 05:05:10 -0500
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 25 Feb 2020 19:05:08 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 51B8618008B;
        Tue, 25 Feb 2020 19:05:08 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Tue, 25 Feb 2020 19:05:08 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by kinkan.css.socionext.com (Postfix) with ESMTP id C82F81A0006;
        Tue, 25 Feb 2020 19:05:07 +0900 (JST)
Received: from [10.213.132.48] (unknown [10.213.132.48])
        by yuzu.css.socionext.com (Postfix) with ESMTP id AFFD212013D;
        Tue, 25 Feb 2020 19:05:07 +0900 (JST)
Date:   Tue, 25 Feb 2020 19:05:07 +0900
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH RESEND] PCI: endpoint: Fix clearing start entry in configfs
Cc:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20200221141553.GA15440@e121166-lin.cambridge.arm.com>
References: <1576844677-24933-1-git-send-email-hayashi.kunihiko@socionext.com> <20200221141553.GA15440@e121166-lin.cambridge.arm.com>
Message-Id: <20200225190506.7DFA.4A936039@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.70 [ja]
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

On Fri, 21 Feb 2020 14:15:53 +0000 <lorenzo.pieralisi@arm.com> wrote:

> On Fri, Dec 20, 2019 at 09:24:37PM +0900, Kunihiko Hayashi wrote:
> > The value of 'start' entry is no change whenever writing 0 to configfs.
> > So the endpoint that stopped once can't restart.
> > 
> > The following command lines are an example restarting endpoint and
> > reprogramming configurations after receiving bus-reset.
> > 
> >     echo 0 > controllers/66000000.pcie-ep/start
> >     rm controllers/66000000.pcie-ep/func1
> >     ln -s functions/pci_epf_test/func1 controllers/66000000.pcie-ep/
> >     echo 1 > controllers/66000000.pcie-ep/start
> > 
> > However, the first 'echo' can't set 0 to 'start', so the last 'echo' can't
> > restart endpoint.
> 
> I think your description is not correct - pci_epc_group->start is
> just used to check if an endpoint has been started or not (in
> pci_epc_epf_unlink() and that's a WARN_ON) but nonetheless this
> looks like a bug and ought to be fixed.

When pci_epc_group->start keeps 1 after starting this controller with
'echo 1 > start', we can never unlink the func1 from the controller
because of WARN_ON.

I think that unlink/re-link play initialization role of configfs
through 'unbind' and 'bind' functions. However, we can't re-initialize
configfs.

If this is the intended behavior, my patch will make no sense.

> I need Kishon's ACK to proceed.

I think so, too.

Thank you,

> 
> Thanks,
> Lorenzo
> 
> > Fixes: d74679911610 ("PCI: endpoint: Introduce configfs entry for configuring EP functions")
> > Cc: Kishon Vijay Abraham I <kishon@ti.com>
> > Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> > ---
> >  drivers/pci/endpoint/pci-ep-cfs.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
> > index d1288a0..4fead88 100644
> > --- a/drivers/pci/endpoint/pci-ep-cfs.c
> > +++ b/drivers/pci/endpoint/pci-ep-cfs.c
> > @@ -58,6 +58,7 @@ static ssize_t pci_epc_start_store(struct config_item *item, const char *page,
> >  
> >  	if (!start) {
> >  		pci_epc_stop(epc);
> > +		epc_group->start = 0;
> >  		return len;
> >  	}
> >  
> > -- 
> > 2.7.4
> > 

---
Best Regards,
Kunihiko Hayashi

