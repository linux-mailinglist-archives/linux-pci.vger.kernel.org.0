Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D44C088C69
	for <lists+linux-pci@lfdr.de>; Sat, 10 Aug 2019 19:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbfHJRP3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 10 Aug 2019 13:15:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:59522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725884AbfHJRP3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 10 Aug 2019 13:15:29 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B1A02085A;
        Sat, 10 Aug 2019 17:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565457328;
        bh=Km7kz+irNT3mHqZD/ZeNgnP8iM5JKYBbamnbs+426NY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hIeHfQGBLo66Byxc4gWsILL7ponxHh8tKoaMmlqJrXddZOFrWPghxeNYwP55UzB3o
         Hzp7uBfsKloodeGSlWdc4gY0NJLvrG3dpw/jK0UpEZHw873D4CflF7LMEgUGjeCSWh
         hanEnbvBNrZdlnwCNQlNGEqKxLO9nZS88pk/N++M=
Date:   Sat, 10 Aug 2019 12:15:25 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Greg KH <greg@kroah.com>
Cc:     Kelsey Skunberg <skunberg.kelsey@gmail.com>,
        linux-pci@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Linux-kernel-mentees] [PATCH] PCI/IOV: Move sysfs SR-IOV
 functions to iov.c
Message-ID: <20190810171525.GG221706@google.com>
References: <20190809195721.34237-1-skunberg.kelsey@gmail.com>
 <20190810071719.GA16356@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190810071719.GA16356@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Aug 10, 2019 at 09:17:19AM +0200, Greg KH wrote:
> On Fri, Aug 09, 2019 at 01:57:21PM -0600, Kelsey Skunberg wrote:
> > +static struct device_attribute sriov_totalvfs_attr = __ATTR_RO(sriov_totalvfs);
> 
> DEVICE_ATTR_RO() please.  This is a device attribute, not a "raw"
> kobject attribute.

This patch is just a move; here's the source of the line above:

> > -static struct device_attribute sriov_totalvfs_attr = __ATTR_RO(sriov_totalvfs);

I certainly support using DEVICE_ATTR_RO() instead of __ATTR_RO(), but
that should be down with a separate patch so it's not buried in what
is otherwise a simple move.

> > +static struct device_attribute sriov_numvfs_attr =
> > +		__ATTR(sriov_numvfs, (S_IRUGO | S_IWUSR | S_IWGRP),
> > +		       sriov_numvfs_show, sriov_numvfs_store);
> > +static struct device_attribute sriov_offset_attr = __ATTR_RO(sriov_offset);
> > +static struct device_attribute sriov_stride_attr = __ATTR_RO(sriov_stride);
> > +static struct device_attribute sriov_vf_device_attr =
> > +		__ATTR_RO(sriov_vf_device);
> > +static struct device_attribute sriov_drivers_autoprobe_attr =
> > +		__ATTR(sriov_drivers_autoprobe, (S_IRUGO | S_IWUSR | S_IWGRP),
> > +		       sriov_drivers_autoprobe_show,
> > +		       sriov_drivers_autoprobe_store);
> 
> Same for all of these, they should use DEVICE_ATTR* macros.
> 
> And why the odd permissions on 2 of these files?  Are you sure about
> that?

Same for these.  It'd be nice to fix them (and similar cases in
pci-sysfs.c, rpadlpar_sysfs.c, sgi_hotplug.c, slot.c) but in a
separate patch.

I think Kelsey did the right thing here by not mixing unrelated fixes
in with the code move.  A couple additional patches to change the
__ATTR() uses and the permissions (git grep "\<S_" finds several
possibilities) would be icing on the cake, but getting the SR-IOV
code all together is an improvement by itself.

Bjorn
