Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCCCC41EBE8
	for <lists+linux-pci@lfdr.de>; Fri,  1 Oct 2021 13:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353881AbhJALba (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Oct 2021 07:31:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:33990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353865AbhJALba (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 Oct 2021 07:31:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 20BE360EBD;
        Fri,  1 Oct 2021 11:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1633087785;
        bh=AOesFciQFfqDQGdIEvwsqkxbyxwJeoyuNHwKVFmlXTw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CEFUt//w51BGtH8mXtgvC3OzuQ1ev0Lx2QYUAumKwZPK8Gc8Bj44+kbreBUoKmM96
         6GAXqe/0X9FQx+gZwzCSCAW4839Om4mmzyHBzGPmjEgkysUb/cT4Gv9ikI+/l4AlRA
         HIaztO5U58IOPrUn5s8DY4qnvwZ6bTdCLhc9orOw=
Date:   Fri, 1 Oct 2021 13:29:42 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     lee.jones@linaro.org, hdegoede@redhat.com, mgross@linux.intel.com,
        bhelgaas@google.com, andriy.shevchenko@linux.intel.com,
        srinivas.pandruvada@intel.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 5/5] platform/x86: Add Intel Software Defined Silicon
 driver
Message-ID: <YVbxJjjn4I97nnmv@kroah.com>
References: <20211001012815.1999501-1-david.e.box@linux.intel.com>
 <20211001012815.1999501-6-david.e.box@linux.intel.com>
 <YVa1aiTqS6Ik5cO1@kroah.com>
 <d988a4b8698b20a151680cc98a6b7434efbaea55.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d988a4b8698b20a151680cc98a6b7434efbaea55.camel@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 01, 2021 at 03:38:23AM -0700, David E. Box wrote:
> On Fri, 2021-10-01 at 09:14 +0200, Greg KH wrote:
> > On Thu, Sep 30, 2021 at 06:28:15PM -0700, David E. Box wrote:
> > > +static int sdsi_device_open(struct inode *inode, struct file *file)
> > > +{
> > > +       struct miscdevice *miscdev = file->private_data;
> > > +
> > > +       get_device(miscdev->this_device);
> > 
> > Why do you think this is needed?  Shouldn't the misc core handle all of
> > this for you already?
> > 
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static int sdsi_device_release(struct inode *inode, struct file *file)
> > > +{
> > > +
> > > +       struct miscdevice *miscdev = file->private_data;
> > > +       struct sdsi_priv *priv = to_sdsi_priv(miscdev);
> > > +
> > > +       if (priv->akc_owner == file)
> > > +               priv->akc_owner = NULL;
> > 
> > Why is this needed?
> > 
> > > +
> > > +       put_device(miscdev->this_device);
> > 
> > I see this matches the open call, but if you do not have this in the
> > open call, is it needed here as well?
> > 
> > > +       ret = devm_add_action_or_reset(priv->miscdev.this_device, sdsi_miscdev_remove, priv);
> > > +       if (ret)
> > > +               goto deregister_misc;
> > 
> > I think this is all you need to clean up your device memory, not the
> > get/put device in open/release, right?
> 
> It does clean up the memory, but it does so immediately after the device has been unregistered, even
> if a file is open. The get/put ensures that if files are open, the memory isn't cleaned up until the
> files are closed.
> 
> I can show that this happens without the get/put,
> 
> 	open()
> 	unbind device -> devm action called -> kfree(priv)
> 	ioctl() -> priv accessed
> 
> but it doesn't blow up. I guess because the former location of priv is accessible by container_of on
> the miscdev. But that memory was freed right?

You are dealing with two different structures with two different
lifecycles and reference counts.  Yes, you can kind of try to tie them
together here, but really, that way lies madness.  Why not just drop the
misc device entirely and only use the struct device that the kernel
created for you?  That would make everything much simpler.

thanks,

greg k-h
