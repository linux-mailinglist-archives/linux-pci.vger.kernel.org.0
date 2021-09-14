Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2571A40A5B9
	for <lists+linux-pci@lfdr.de>; Tue, 14 Sep 2021 07:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239316AbhINFIT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Sep 2021 01:08:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:46620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232829AbhINFIS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Sep 2021 01:08:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BEBAA60238;
        Tue, 14 Sep 2021 05:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631596021;
        bh=XpTmFshm8nUSeVHWxfgHh63I8rbup51CEQ4UTto3dhA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V4LfmlawCcxJmaP6QJF5SdpUkxrUNBKaLoefHqyfZy3QcZBRctIYxBq/Gnt0s8fmF
         UizMJjBW/qHqE4OnwCGkuFxLuSpZxNuKHADWOdxGjzN0xA5D7cjRkAbUXVt62j0+7p
         9ACSU7kD6KgqOeeSSbVZHOGwjJ7zLzRh/SkjfF2o=
Date:   Tue, 14 Sep 2021 07:06:40 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/4] PCI/sysfs: Add pci_dev_resource_attr_is_visible()
 helper
Message-ID: <YUAt4JVeZ57eDbaT@kroah.com>
References: <YTyBTZ/IyNU5Layt@kroah.com>
 <20210913194756.GA1348809@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210913194756.GA1348809@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 13, 2021 at 02:47:56PM -0500, Bjorn Helgaas wrote:
> On Sat, Sep 11, 2021 at 12:13:33PM +0200, Greg Kroah-Hartman wrote:
> > On Fri, Sep 10, 2021 at 07:21:01PM +0200, Krzysztof Wilczyński wrote:
> > > Hi Greg,
> > > 
> > > [...]
> > > > >   pci_dev_config_attr_is_visible(..., struct bin_attribute *a, ...)
> > > > >   {
> > > > >     a->size = PCI_CFG_SPACE_SIZE;    # <-- set size in global attr
> > > > >     ...
> > > > >   }
> > > > > 
> > > > >   static struct bin_attribute *pci_dev_config_attrs[] = {
> > > > >     &bin_attr_config, NULL,
> > > > >   };
> > > > >   static const struct attribute_group pci_dev_config_attr_group = {
> > > > >     .bin_attrs = pci_dev_config_attrs,
> > > > >     .is_bin_visible = pci_dev_config_attr_is_visible,
> > > > >   };
> > > > > 
> > > > >   pci_device_add
> > > > >     device_add
> > > > >       device_add_attrs
> > > > >         device_add_groups
> > > > >           sysfs_create_groups
> > > > >             internal_create_groups
> > > > >               internal_create_group
> > > > >                 create_files
> > > > >                   grp->is_bin_visible()
> > > > >                   sysfs_add_file_mode_ns
> > > > >                     size = battr->size      # <-- copy size from attr
> > > > >                     __kernfs_create_file(..., size, ...)
> > > > >                       kernfs_new_node
> > > > >                         __kernfs_new_node
> > > > > 
> > > > 
> > > > You can create a dynamic attribute and register that.  I think some
> > > > drivers/busses do that today to handle this type of thing.
> > > 
> > > Some static attributes users don't set size today or simply set it to 0, so
> > > then we report 0 bytes in userspace for each such attribute via the backing
> > > i-node.
> > > 
> > > Would you be open to the idea of adding a .size() callback so that static
> > > attributes users could set size using more proper channels, or do you think
> > > leaving it being set to 0 is fine?
> > 
> > I think leaving it at 0 is fine, are userspace tools really needing to
> > know the size ahead of time for sysfs files?  What would changing this
> > help out with?
> 
> We currently set the inode size for BARs (resource0, resource1, etc)
> to the BAR size.  I don't think lspci uses that inode size; it looks
> at the addresses in "resource" and computes the size from that [1].
> 
> But I doubt we can set the "resourceN" sizes to 0, since somebody else
> might be using that information.
> 
> I'm curious to know what other static attribute users set .size.
> Maybe they're all singleton cases, as opposed to the per-device cases
> we're interested in.

Most are singleton cases from what I have seen.  Or they just leave the
file size at 0.  There are not that many binary sysfs files around,
thankfully.

thanks,

greg k-h
