Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0D93FECAD
	for <lists+linux-pci@lfdr.de>; Thu,  2 Sep 2021 13:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237667AbhIBLJr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Sep 2021 07:09:47 -0400
Received: from elvis.franken.de ([193.175.24.41]:60890 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231133AbhIBLJp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 2 Sep 2021 07:09:45 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1mLkaL-0002IW-01; Thu, 02 Sep 2021 13:08:45 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 4297DC0A09; Thu,  2 Sep 2021 13:08:35 +0200 (CEST)
Date:   Thu, 2 Sep 2021 13:08:35 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-staging@lists.linux.dev, NeilBrown <neil@brown.name>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] staging: mt7621-pci: set end limit for
 'ioport_resource'
Message-ID: <20210902110835.GB7614@alpha.franken.de>
References: <20210822161005.22467-1-sergio.paracuellos@gmail.com>
 <20210822161005.22467-4-sergio.paracuellos@gmail.com>
 <YSip4/kMNOG4uYC3@kroah.com>
 <CAMhs-H_0ytYCoBLj9GJDjHSPPHLC6_oBsm-V9s4FjhE7NY8TCw@mail.gmail.com>
 <YTCWR7oyLWgTDbQe@kroah.com>
 <CAMhs-H8U-crQHFVQj6j4Y5qs-S2NaW9trH8twKH8AwDR+AAYgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMhs-H8U-crQHFVQj6j4Y5qs-S2NaW9trH8twKH8AwDR+AAYgg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 02, 2021 at 12:15:12PM +0200, Sergio Paracuellos wrote:
> On Thu, Sep 2, 2021 at 11:15 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Sun, Aug 29, 2021 at 05:14:27PM +0200, Sergio Paracuellos wrote:
> > > On Fri, Aug 27, 2021 at 11:01 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Sun, Aug 22, 2021 at 06:10:05PM +0200, Sergio Paracuellos wrote:
> > > > > We have increase IO_SPACE_LIMIT for ralink platform to get PCI IO resources
> > > > > properly handled using PCI core APIs. To align those changes with driver
> > > > > code we have to set 'ioport_resource' end limit to IO_SPACE_LIMIT to avoid
> > > > > errors.
> > > > >
> > > > > Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > > >
> > > > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > >
> > > Thanks. Since I am planning to move 'mt7621-pci' from staging to
> > > 'drivers/pci/controller' and send v3 after the next merge window, I
> > > prefer this patch to go through the staging tree. For the other two I
> > > don't have any preference and it is ok for me to go through mips or
> > > pci trees. So, Bjorn and Thomas is up to you if you are ok with the
> > > changes.
> >
> > Yes, I would need acks for the other patches in the series if this is to
> > come through the staging tree.
> 
> Yes, I know it. Let's wait for Thomas and Bjorn preference for those
> remaining two.

I've sent my acked-by for the MIPS patch. 

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
