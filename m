Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC42F407607
	for <lists+linux-pci@lfdr.de>; Sat, 11 Sep 2021 12:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235513AbhIKKPI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 11 Sep 2021 06:15:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:48824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235443AbhIKKPI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 11 Sep 2021 06:15:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2F29A60F43;
        Sat, 11 Sep 2021 10:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631355236;
        bh=lSHSgBwx6gMurY95a9FVLbeSHUtaSl0ni5yzqPG/SAc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R9h7m91vmMmsY+nTu5NFZMpPV+3IHglqDli4uvl1uQmewAgzcLU76GDTow+EKLlW7
         A41u7HiLXbTLa5ll6zF6skYw6VnwP+NEWrTsoMrgsTei11WZv5DYRt2YX5DooFA+Hd
         D52mPe4N5KqLDQdW/6rZb/LG3piKnCbhP/JqoF80=
Date:   Sat, 11 Sep 2021 12:13:33 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/4] PCI/sysfs: Add pci_dev_resource_attr_is_visible()
 helper
Message-ID: <YTyBTZ/IyNU5Layt@kroah.com>
References: <YSjWWWVC6ImWA5Qe@kroah.com>
 <20210827222331.GA3896976@bjorn-Precision-5520>
 <YTtm4e9a/gS5Swga@kroah.com>
 <20210910172101.GA1314672@rocinante>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210910172101.GA1314672@rocinante>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 10, 2021 at 07:21:01PM +0200, Krzysztof Wilczyński wrote:
> Hi Greg,
> 
> [...]
> > >   pci_dev_config_attr_is_visible(..., struct bin_attribute *a, ...)
> > >   {
> > >     a->size = PCI_CFG_SPACE_SIZE;    # <-- set size in global attr
> > >     ...
> > >   }
> > > 
> > >   static struct bin_attribute *pci_dev_config_attrs[] = {
> > >     &bin_attr_config, NULL,
> > >   };
> > >   static const struct attribute_group pci_dev_config_attr_group = {
> > >     .bin_attrs = pci_dev_config_attrs,
> > >     .is_bin_visible = pci_dev_config_attr_is_visible,
> > >   };
> > > 
> > >   pci_device_add
> > >     device_add
> > >       device_add_attrs
> > >         device_add_groups
> > >           sysfs_create_groups
> > >             internal_create_groups
> > >               internal_create_group
> > >                 create_files
> > >                   grp->is_bin_visible()
> > >                   sysfs_add_file_mode_ns
> > >                     size = battr->size      # <-- copy size from attr
> > >                     __kernfs_create_file(..., size, ...)
> > >                       kernfs_new_node
> > >                         __kernfs_new_node
> > > 
> > 
> > You can create a dynamic attribute and register that.  I think some
> > drivers/busses do that today to handle this type of thing.
> 
> Some static attributes users don't set size today or simply set it to 0, so
> then we report 0 bytes in userspace for each such attribute via the backing
> i-node.
> 
> Would you be open to the idea of adding a .size() callback so that static
> attributes users could set size using more proper channels, or do you think
> leaving it being set to 0 is fine?

I think leaving it at 0 is fine, are userspace tools really needing to
know the size ahead of time for sysfs files?  What would changing this
help out with?

thanks,

greg k-h
