Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B29E413633
	for <lists+linux-pci@lfdr.de>; Tue, 21 Sep 2021 17:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233860AbhIUP3k (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Sep 2021 11:29:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:57192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233821AbhIUP3j (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 21 Sep 2021 11:29:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9B6F461186;
        Tue, 21 Sep 2021 15:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632238091;
        bh=V87W35buudncgpwodJtfOSyNRpRSP2nRzOMxEHbJ6Ng=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L7kXW1QmwHxvxEyDZtTAHONgIrrW7Par9SVjEBp5YB40xjEL1gMnnl36EBn5rH9qw
         9hVCEvyWoksbijklQ+hBS7Q9QpO5nO78wr2khcqC956vFkSd6bOzfQa6HpTK+6/2mW
         3dkUDS1rlA0xkHMvEqqNSaJ+Wy+f4iIhJP62XIag=
Date:   Tue, 21 Sep 2021 17:28:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-staging@lists.linux.dev, NeilBrown <neil@brown.name>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] staging: mt7621-pci: set end limit for
 'ioport_resource'
Message-ID: <YUn6BmP/4EvFmawz@kroah.com>
References: <20210822161005.22467-1-sergio.paracuellos@gmail.com>
 <20210822161005.22467-4-sergio.paracuellos@gmail.com>
 <YSip4/kMNOG4uYC3@kroah.com>
 <CAMhs-H_0ytYCoBLj9GJDjHSPPHLC6_oBsm-V9s4FjhE7NY8TCw@mail.gmail.com>
 <YTCWR7oyLWgTDbQe@kroah.com>
 <CAMhs-H8U-crQHFVQj6j4Y5qs-S2NaW9trH8twKH8AwDR+AAYgg@mail.gmail.com>
 <20210902110835.GB7614@alpha.franken.de>
 <CAMhs-H_1U=X25+q=wDnQ+FGbxXMx1vFpefEMJviFxOc7T0jwjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMhs-H_1U=X25+q=wDnQ+FGbxXMx1vFpefEMJviFxOc7T0jwjA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 02, 2021 at 01:19:53PM +0200, Sergio Paracuellos wrote:
> On Thu, Sep 2, 2021 at 1:08 PM Thomas Bogendoerfer
> <tsbogend@alpha.franken.de> wrote:
> >
> > On Thu, Sep 02, 2021 at 12:15:12PM +0200, Sergio Paracuellos wrote:
> > > On Thu, Sep 2, 2021 at 11:15 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Sun, Aug 29, 2021 at 05:14:27PM +0200, Sergio Paracuellos wrote:
> > > > > On Fri, Aug 27, 2021 at 11:01 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > > >
> > > > > > On Sun, Aug 22, 2021 at 06:10:05PM +0200, Sergio Paracuellos wrote:
> > > > > > > We have increase IO_SPACE_LIMIT for ralink platform to get PCI IO resources
> > > > > > > properly handled using PCI core APIs. To align those changes with driver
> > > > > > > code we have to set 'ioport_resource' end limit to IO_SPACE_LIMIT to avoid
> > > > > > > errors.
> > > > > > >
> > > > > > > Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > > > > >
> > > > > > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > >
> > > > > Thanks. Since I am planning to move 'mt7621-pci' from staging to
> > > > > 'drivers/pci/controller' and send v3 after the next merge window, I
> > > > > prefer this patch to go through the staging tree. For the other two I
> > > > > don't have any preference and it is ok for me to go through mips or
> > > > > pci trees. So, Bjorn and Thomas is up to you if you are ok with the
> > > > > changes.
> > > >
> > > > Yes, I would need acks for the other patches in the series if this is to
> > > > come through the staging tree.
> > >
> > > Yes, I know it. Let's wait for Thomas and Bjorn preference for those
> > > remaining two.
> >
> > I've sent my acked-by for the MIPS patch.
> 
> Thanks!

Ok, I took patches 1 and 3 in my tree now.  Please submit patch 2 to the
PCI developers and maintainer, as that is up to them to take, not me.

thanks,

greg k-h
