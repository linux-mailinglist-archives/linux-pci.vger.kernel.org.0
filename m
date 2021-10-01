Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECCDC41EB0D
	for <lists+linux-pci@lfdr.de>; Fri,  1 Oct 2021 12:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353621AbhJAKkH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Oct 2021 06:40:07 -0400
Received: from mga17.intel.com ([192.55.52.151]:21683 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353615AbhJAKkH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 Oct 2021 06:40:07 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10123"; a="205551172"
X-IronPort-AV: E=Sophos;i="5.85,337,1624345200"; 
   d="scan'208";a="205551172"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2021 03:38:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,337,1624345200"; 
   d="scan'208";a="709724066"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 01 Oct 2021 03:38:23 -0700
Received: from debox1-desk1.jf.intel.com (debox1-desk1.jf.intel.com [10.54.75.53])
        by linux.intel.com (Postfix) with ESMTP id 1E93B580223;
        Fri,  1 Oct 2021 03:38:23 -0700 (PDT)
Message-ID: <d988a4b8698b20a151680cc98a6b7434efbaea55.camel@linux.intel.com>
Subject: Re: [PATCH 5/5] platform/x86: Add Intel Software Defined Silicon
 driver
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     lee.jones@linaro.org, hdegoede@redhat.com, mgross@linux.intel.com,
        bhelgaas@google.com, andriy.shevchenko@linux.intel.com,
        srinivas.pandruvada@intel.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pci@vger.kernel.org
Date:   Fri, 01 Oct 2021 03:38:23 -0700
In-Reply-To: <YVa1aiTqS6Ik5cO1@kroah.com>
References: <20211001012815.1999501-1-david.e.box@linux.intel.com>
         <20211001012815.1999501-6-david.e.box@linux.intel.com>
         <YVa1aiTqS6Ik5cO1@kroah.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 2021-10-01 at 09:14 +0200, Greg KH wrote:
> On Thu, Sep 30, 2021 at 06:28:15PM -0700, David E. Box wrote:
> > +static int sdsi_device_open(struct inode *inode, struct file *file)
> > +{
> > +       struct miscdevice *miscdev = file->private_data;
> > +
> > +       get_device(miscdev->this_device);
> 
> Why do you think this is needed?  Shouldn't the misc core handle all of
> this for you already?
> 
> > +
> > +       return 0;
> > +}
> > +
> > +static int sdsi_device_release(struct inode *inode, struct file *file)
> > +{
> > +
> > +       struct miscdevice *miscdev = file->private_data;
> > +       struct sdsi_priv *priv = to_sdsi_priv(miscdev);
> > +
> > +       if (priv->akc_owner == file)
> > +               priv->akc_owner = NULL;
> 
> Why is this needed?
> 
> > +
> > +       put_device(miscdev->this_device);
> 
> I see this matches the open call, but if you do not have this in the
> open call, is it needed here as well?
> 
> > +       ret = devm_add_action_or_reset(priv->miscdev.this_device, sdsi_miscdev_remove, priv);
> > +       if (ret)
> > +               goto deregister_misc;
> 
> I think this is all you need to clean up your device memory, not the
> get/put device in open/release, right?

It does clean up the memory, but it does so immediately after the device has been unregistered, even
if a file is open. The get/put ensures that if files are open, the memory isn't cleaned up until the
files are closed.

I can show that this happens without the get/put,

	open()
	unbind device -> devm action called -> kfree(priv)
	ioctl() -> priv accessed

but it doesn't blow up. I guess because the former location of priv is accessible by container_of on
the miscdev. But that memory was freed right?

David

> 
> thanks,
> 
> greg k-h


