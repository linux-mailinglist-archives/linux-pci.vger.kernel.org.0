Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 900087E718
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2019 02:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730943AbfHBAOx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Aug 2019 20:14:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:42514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730929AbfHBAOx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Aug 2019 20:14:53 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 626B32080C;
        Fri,  2 Aug 2019 00:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564704892;
        bh=6LB0zjszgMbs3BLC4rQPwCa2WzIIdR8I70JOe6BQ8vc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1YSbDyIiuIWYZUMZwvVwkvNbtBeA8F4/gCG2hN8CQDaafhXz2pLCogkVeEKGFOpel
         gy5WeDt7nGcxLQm3pP8hxamV0RYkWRD7wqKF2O4Tx7lRxVyMz3INb9klXDd4AwL4HV
         77dRr8pRnnKcWqoycJ20mEVf2ubFsXV4uTi1GM4o=
Date:   Thu, 1 Aug 2019 19:14:51 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Young Xiao <92siuyang@gmail.com>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI/hotplug: fix potential null pointer deference
Message-ID: <20190802001451.GH151852@google.com>
References: <1560516085-3101-1-git-send-email-92siuyang@gmail.com>
 <CAHp75VcnqpQPTEFsG_bDmAJa4EHucgwoGvyw_XukC6vntdDhow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VcnqpQPTEFsG_bDmAJa4EHucgwoGvyw_XukC6vntdDhow@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 14, 2019 at 04:56:32PM +0300, Andy Shevchenko wrote:
> On Fri, Jun 14, 2019 at 3:40 PM Young Xiao <92siuyang@gmail.com> wrote:
> >
> > There is otherwise a risk of a null pointer dereference.
> 
> Had you analyze the code?
> How come that prevnode can become NULL?

Dropping this for now.  Young, if there's a scenario where prevnode
can actually be NULL, please mention that in the changelog and repost
this.

> > Signed-off-by: Young Xiao <92siuyang@gmail.com>
> > ---
> >  drivers/pci/hotplug/cpqphp_ctrl.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/pci/hotplug/cpqphp_ctrl.c b/drivers/pci/hotplug/cpqphp_ctrl.c
> > index b7f4e1f..3c8399f 100644
> > --- a/drivers/pci/hotplug/cpqphp_ctrl.c
> > +++ b/drivers/pci/hotplug/cpqphp_ctrl.c
> > @@ -598,10 +598,11 @@ static struct pci_resource *get_io_resource(struct pci_resource **head, u32 size
> >                         *head = node->next;
> >                 } else {
> >                         prevnode = *head;
> > -                       while (prevnode->next != node)
> > +                       while (prevnode && prevnode->next != node)
> >                                 prevnode = prevnode->next;
> >
> > -                       prevnode->next = node->next;
> > +                       if (prevnode)
> > +                               prevnode->next = node->next;
> >                 }
> >                 node->next = NULL;
> >                 break;
> > @@ -788,10 +789,11 @@ static struct pci_resource *get_resource(struct pci_resource **head, u32 size)
> >                         *head = node->next;
> >                 } else {
> >                         prevnode = *head;
> > -                       while (prevnode->next != node)
> > +                       while (prevnode && prevnode->next != node)
> >                                 prevnode = prevnode->next;
> >
> > -                       prevnode->next = node->next;
> > +                       if (prevnode)
> > +                               prevnode->next = node->next;
> >                 }
> >                 node->next = NULL;
> >                 break;
> > --
> > 2.7.4
> >
> 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
