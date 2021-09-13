Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C83B8409D63
	for <lists+linux-pci@lfdr.de>; Mon, 13 Sep 2021 21:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347738AbhIMTtS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Sep 2021 15:49:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:48818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347671AbhIMTtO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Sep 2021 15:49:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2207D610FE;
        Mon, 13 Sep 2021 19:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631562478;
        bh=kU464LDWH7a8TJ7+IF/ehkm5IuKZOpKPzMjFVX5VsXI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=QwJmYa63chD6aE0w9BkqOn4l4gu622qL1IIuoOdZ9A7rttxKQ2vL0Hc0CgFM8Bz+U
         /IcZj5RqQ2jvAv8YEHeswD2x+C1R0xlGYSJ2aR7KUhKRqctFlScrfdCmf/cFvxDe1S
         V4XOUdRWu7tXR5hlPXS9bEQauJbPW+UXOG/4C1v7U2vikgi7fuwpT68+WmSa4FHyj3
         Ejm8mdUGIO0VqZrOR+OyRtITnX3tRwQQkINTrIWgwb6ktyyLl43D0fIIhKxiCweeCn
         rlvB7zz/a+b3j3hVABJ2dV21DQPlGX76ldzmXDtJb36DVWvNOVMiPK2sZ0rAy28DiG
         YqsqUVplekQgg==
Date:   Mon, 13 Sep 2021 14:47:56 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/4] PCI/sysfs: Add pci_dev_resource_attr_is_visible()
 helper
Message-ID: <20210913194756.GA1348809@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YTyBTZ/IyNU5Layt@kroah.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Sep 11, 2021 at 12:13:33PM +0200, Greg Kroah-Hartman wrote:
> On Fri, Sep 10, 2021 at 07:21:01PM +0200, Krzysztof Wilczyński wrote:
> > Hi Greg,
> > 
> > [...]
> > > >   pci_dev_config_attr_is_visible(..., struct bin_attribute *a, ...)
> > > >   {
> > > >     a->size = PCI_CFG_SPACE_SIZE;    # <-- set size in global attr
> > > >     ...
> > > >   }
> > > > 
> > > >   static struct bin_attribute *pci_dev_config_attrs[] = {
> > > >     &bin_attr_config, NULL,
> > > >   };
> > > >   static const struct attribute_group pci_dev_config_attr_group = {
> > > >     .bin_attrs = pci_dev_config_attrs,
> > > >     .is_bin_visible = pci_dev_config_attr_is_visible,
> > > >   };
> > > > 
> > > >   pci_device_add
> > > >     device_add
> > > >       device_add_attrs
> > > >         device_add_groups
> > > >           sysfs_create_groups
> > > >             internal_create_groups
> > > >               internal_create_group
> > > >                 create_files
> > > >                   grp->is_bin_visible()
> > > >                   sysfs_add_file_mode_ns
> > > >                     size = battr->size      # <-- copy size from attr
> > > >                     __kernfs_create_file(..., size, ...)
> > > >                       kernfs_new_node
> > > >                         __kernfs_new_node
> > > > 
> > > 
> > > You can create a dynamic attribute and register that.  I think some
> > > drivers/busses do that today to handle this type of thing.
> > 
> > Some static attributes users don't set size today or simply set it to 0, so
> > then we report 0 bytes in userspace for each such attribute via the backing
> > i-node.
> > 
> > Would you be open to the idea of adding a .size() callback so that static
> > attributes users could set size using more proper channels, or do you think
> > leaving it being set to 0 is fine?
> 
> I think leaving it at 0 is fine, are userspace tools really needing to
> know the size ahead of time for sysfs files?  What would changing this
> help out with?

We currently set the inode size for BARs (resource0, resource1, etc)
to the BAR size.  I don't think lspci uses that inode size; it looks
at the addresses in "resource" and computes the size from that [1].

But I doubt we can set the "resourceN" sizes to 0, since somebody else
might be using that information.

I'm curious to know what other static attribute users set .size.
Maybe they're all singleton cases, as opposed to the per-device cases
we're interested in.

[1] https://git.kernel.org/pub/scm/utils/pciutils/pciutils.git/tree/lib/sysfs.c?id=v3.7.0#n152
