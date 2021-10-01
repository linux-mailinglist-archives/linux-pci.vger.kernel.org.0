Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A68B41EBDE
	for <lists+linux-pci@lfdr.de>; Fri,  1 Oct 2021 13:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353202AbhJAL2q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Oct 2021 07:28:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:32978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230257AbhJAL2q (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 Oct 2021 07:28:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 31CBC60EBD;
        Fri,  1 Oct 2021 11:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1633087622;
        bh=snll772tuAXi5Uw2v4DZzndnf/mewVu8LU/QYyBpTbs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G3sWq6kh/kXiWsiGj8xsHASKIDmnuHfADfcckTx5IrnX1IcZVcc7D1Y2EKzersl5i
         KoDudRAXq8doVyrHYMPDsUdDlJoed5QjXKHI87DhWg5N5hZOxqGHUBvyd0D0AOFjqQ
         5DwoY1X51MYoXThzzMUq7JKzaZ8YTKolsReTN5r4=
Date:   Fri, 1 Oct 2021 13:26:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     lee.jones@linaro.org, hdegoede@redhat.com, mgross@linux.intel.com,
        bhelgaas@google.com, andriy.shevchenko@linux.intel.com,
        srinivas.pandruvada@intel.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 5/5] platform/x86: Add Intel Software Defined Silicon
 driver
Message-ID: <YVbwgkncsQtWuh/k@kroah.com>
References: <20211001012815.1999501-1-david.e.box@linux.intel.com>
 <20211001012815.1999501-6-david.e.box@linux.intel.com>
 <YVa46eU1VX7CM+Xd@kroah.com>
 <45b6454a3421ac064dff3ba159e02985d3e55440.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <45b6454a3421ac064dff3ba159e02985d3e55440.camel@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 01, 2021 at 04:13:58AM -0700, David E. Box wrote:
> On Fri, 2021-10-01 at 09:29 +0200, Greg KH wrote:
> > On Thu, Sep 30, 2021 at 06:28:15PM -0700, David E. Box wrote:
> > > +static long sdsi_device_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> > > +{
> > > +       struct miscdevice *miscdev = file->private_data;
> > > +       struct sdsi_priv *priv = to_sdsi_priv(miscdev);
> > > +       void __user *argp = (void __user *)arg;
> > > +       long ret = -EINVAL;
> > > +
> > > +       if (!priv->dev_present)
> > > +               return -ENODEV;
> > > +
> > > +       if (!priv->sdsi_enabled)
> > > +               return -EPERM;
> > > +
> > > +       if (cmd == SDSI_IF_READ_STATE)
> > > +               return sdsi_if_read_state_cert(priv, argp);
> > > +
> > > +       mutex_lock(&priv->akc_lock);
> > > +       switch (cmd) {
> > > +       case SDSI_IF_PROVISION_AKC:
> > > +               /*
> > > +                * While writing an authentication certificate disallow other openers
> > > +                * from using AKC or CAP.
> > > +                */
> > > +               if (!priv->akc_owner)
> > > +                       priv->akc_owner = file;
> > > +
> > > +               if (priv->akc_owner != file) {
> > 
> > Please explain how this test would ever trigger and how you tested it?
> > 
> > What exactly are you trying to protect from here?  If userspace has your
> > file descriptor, it can do whatever it wants, don't try to be smarter
> > than it as you will never win.
> > 
> > And why are you using ioctls at all here?  As you are just
> > reading/writing to the hardware directly, why not just use a binary
> > sysfs file to be that pipe?  What requires an ioctl at all?
> 
> So an original internal version of this did use binary attributes. But there was concern during
> review that a flow, particularly when doing the two write operations, could not be handled
> atomically while exposed as separate files. Above is the attempt to handle the situation in the
> ioctl. That is, whichever opener performs AKC write first would lock out all other openers from
> performing any write until that file is closed. This is to avoid interfering with that process,
> should the opener also decide to perform a CAP operation.

Unfortunately, your code here does not prevent that at all, so your
moving off of a binary sysfs attribute changed nothing.

You can "prevent" this from happening just as easily through a sysfs
attribute as you can a character device node.

> There may be future commands requiring RW ioctls as well.

How am I or anyone else supposed to know that?  We write code and review
it for _today_, not what might be sometime in the future someday.  As
that will be dealt with when it actually happens.

greg k-h
