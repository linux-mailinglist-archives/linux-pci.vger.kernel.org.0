Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4BC43FEB14
	for <lists+linux-pci@lfdr.de>; Thu,  2 Sep 2021 11:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245074AbhIBJRU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Sep 2021 05:17:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:44562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245231AbhIBJQw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 2 Sep 2021 05:16:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ACCE860FE6;
        Thu,  2 Sep 2021 09:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1630574154;
        bh=dPw6G1yVOra8rqEBvFu7lWMDGR3IWQFgtT1jvbbgnNM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=URutCE4KcIzFWRrXltEliCz1MNdQ7Hhhqk+ZzrDXLHKpoOzXyL5ugAk4AWL2vrzmd
         v3zdkB0m8gN3PLf+MOuHkLNdXOMknoif29QRJKNEH8ktAmtVfKWm/IxEPQ9VhXx6Wu
         kng2BzSy7Hqw1snV8Lg5Mx9PkHtUpQaINBGlx0WM=
Date:   Thu, 2 Sep 2021 11:15:51 +0200
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
Message-ID: <YTCWR7oyLWgTDbQe@kroah.com>
References: <20210822161005.22467-1-sergio.paracuellos@gmail.com>
 <20210822161005.22467-4-sergio.paracuellos@gmail.com>
 <YSip4/kMNOG4uYC3@kroah.com>
 <CAMhs-H_0ytYCoBLj9GJDjHSPPHLC6_oBsm-V9s4FjhE7NY8TCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMhs-H_0ytYCoBLj9GJDjHSPPHLC6_oBsm-V9s4FjhE7NY8TCw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Aug 29, 2021 at 05:14:27PM +0200, Sergio Paracuellos wrote:
> On Fri, Aug 27, 2021 at 11:01 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Sun, Aug 22, 2021 at 06:10:05PM +0200, Sergio Paracuellos wrote:
> > > We have increase IO_SPACE_LIMIT for ralink platform to get PCI IO resources
> > > properly handled using PCI core APIs. To align those changes with driver
> > > code we have to set 'ioport_resource' end limit to IO_SPACE_LIMIT to avoid
> > > errors.
> > >
> > > Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> >
> > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Thanks. Since I am planning to move 'mt7621-pci' from staging to
> 'drivers/pci/controller' and send v3 after the next merge window, I
> prefer this patch to go through the staging tree. For the other two I
> don't have any preference and it is ok for me to go through mips or
> pci trees. So, Bjorn and Thomas is up to you if you are ok with the
> changes.

Yes, I would need acks for the other patches in the series if this is to
come through the staging tree.

thanks,

greg k-h
