Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5235E8CD42
	for <lists+linux-pci@lfdr.de>; Wed, 14 Aug 2019 09:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbfHNHx1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Aug 2019 03:53:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:60222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725928AbfHNHx1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 14 Aug 2019 03:53:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E5D42054F;
        Wed, 14 Aug 2019 07:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565769206;
        bh=jmEspuA7KfuzsBgRx20ueACmvcLnL7OVWc2d3mTSYG8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vwX2LKGabCD7qoZ++5QKS2NVnr7C54bfswvICGwLBoCgCiwBOnRL8qfI7JH4hUpGZ
         bbVDrY/Hmp1r+Rnbq+uzEGzFV+Rd2MLVeDwMUagLFwsU92axHNLES9xPmH0BSLZfB+
         xDcwtPbZEpKUDYfHAnN9gPaA1wdfNB7MaON8qpUs=
Date:   Wed, 14 Aug 2019 09:53:24 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Kelsey Skunberg <skunberg.kelsey@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Bodong Wang <bodong@mellanox.com>,
        Donald Dutile <ddutile@redhat.com>
Subject: Re: [Linux-kernel-mentees] [PATCH v2 2/3] PCI: sysfs: Change
 permissions from symbolic to octal
Message-ID: <20190814075324.GB4067@kroah.com>
References: <20190809195721.34237-1-skunberg.kelsey@gmail.com>
 <20190813204513.4790-1-skunberg.kelsey@gmail.com>
 <20190813204513.4790-3-skunberg.kelsey@gmail.com>
 <20190814053846.GA253360@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814053846.GA253360@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 14, 2019 at 12:38:46AM -0500, Bjorn Helgaas wrote:
> [+cc Bodong, Don, Greg for permission question]
> 
> On Tue, Aug 13, 2019 at 02:45:12PM -0600, Kelsey Skunberg wrote:
> > Symbolic permissions such as "(S_IWUSR | S_IWGRP)" are not
> > preferred and octal permissions should be used instead. Change all
> > symbolic permissions to octal permissions.
> > 
> > Example of old:
> > 
> > "(S_IWUSR | S_IWGRP)"
> > 
> > Example of new:
> > 
> > "0220"
> 
> 
> >  static DEVICE_ATTR_RO(sriov_totalvfs);
> > -static DEVICE_ATTR(sriov_numvfs, (S_IRUGO | S_IWUSR | S_IWGRP),
> > -				  sriov_numvfs_show, sriov_numvfs_store);
> > +static DEVICE_ATTR(sriov_numvfs, 0664, sriov_numvfs_show, sriov_numvfs_store);
> >  static DEVICE_ATTR_RO(sriov_offset);
> >  static DEVICE_ATTR_RO(sriov_stride);
> >  static DEVICE_ATTR_RO(sriov_vf_device);
> > -static DEVICE_ATTR(sriov_drivers_autoprobe, (S_IRUGO | S_IWUSR | S_IWGRP),
> > -		   sriov_drivers_autoprobe_show, sriov_drivers_autoprobe_store);
> > +static DEVICE_ATTR(sriov_drivers_autoprobe, 0664, sriov_drivers_autoprobe_show,
> > +		   sriov_drivers_autoprobe_store);
> 
> Greg noticed that sriov_numvfs and sriov_drivers_autoprobe have
> "unusual" permissions.  These were added by:
> 
>   0e7df22401a3 ("PCI: Add sysfs sriov_drivers_autoprobe to control VF driver binding")
>   1789382a72a5 ("PCI: SRIOV control and status via sysfs")
> 
> Kelsey's patch correctly preserves the existing permissions, but we
> should double-check that they are the permissions they want, and
> possibly add a comment about why they're different from the rest.

I agree.  And if those permissions are ok, please put a HUGE comment in
here saying why they are what they are and why they need to stay that
way so we don't have this conversation again in a few years :)

thanks,

greg k-h
