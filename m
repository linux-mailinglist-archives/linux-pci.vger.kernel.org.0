Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76FFB2F6291
	for <lists+linux-pci@lfdr.de>; Thu, 14 Jan 2021 15:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbhANN7i (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jan 2021 08:59:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:43518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbhANN7i (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 14 Jan 2021 08:59:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D30B123A69;
        Thu, 14 Jan 2021 13:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610632737;
        bh=JuYT1GxneNabSoFH3WZkBMhsNU+ayJ6vKtjnmLGo5UU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iWXUZyilQSXoQ+iBcLZPhjuW4vX6gHfo5CdcnHkIUt/CKiLIrVK1F9jgYP5WGgDyR
         J4wWJOYjIvKcAnTEInUdsEVgAqNjkzgNYO0YI1YB3Ltiquo8FV3zHOmddp1n11v25D
         pquNvzxWrL+MTp9VvffODGZ9zTYbobGQrExRQgtM=
Date:   Thu, 14 Jan 2021 14:58:54 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Pierre Morel <pmorel@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Viktor Mihajlovski <mihajlov@linux.ibm.com>
Subject: Re: [RFC 1/1] s390/pci: expose UID checking state in sysfs
Message-ID: <YABOHuejsuriwSPn@kroah.com>
References: <20210113185500.GA1918216@bjorn-Precision-5520>
 <675aa466-59ea-cf8a-6eec-caa6478ba4cd@linux.ibm.com>
 <20210114134453.bkfik4zjt5ehz6d5@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210114134453.bkfik4zjt5ehz6d5@wittgenstein>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 14, 2021 at 02:44:53PM +0100, Christian Brauner wrote:
> On Thu, Jan 14, 2021 at 02:20:10PM +0100, Niklas Schnelle wrote:
> > 
> > 
> > On 1/13/21 7:55 PM, Bjorn Helgaas wrote:
> > > On Wed, Jan 13, 2021 at 08:47:58AM +0100, Niklas Schnelle wrote:
> > >> On 1/12/21 10:50 PM, Bjorn Helgaas wrote:
> > >>> On Mon, Jan 11, 2021 at 10:38:57AM +0100, Niklas Schnelle wrote:
> > >>>> We use the UID of a zPCI adapter, or the UID of the function zero if
> > >>>> there are multiple functions in an adapter, as PCI domain if and only if
> > >>>> UID Checking is turned on.
> > >>>> Otherwise we automatically generate domains as devices appear.
> > >>>>
> > >>>> The state of UID Checking is thus essential to know if the PCI domain
> > >>>> will be stable, yet currently there is no way to access this information
> > >>>> from userspace.
> > >>>> So let's solve this by showing the state of UID checking as a sysfs
> > >>>> attribute in /sys/bus/pci/uid_checking
> > > 
> > >>>> +/* Global zPCI attributes */
> > >>>> +static ssize_t uid_checking_show(struct kobject *kobj,
> > >>>> +				 struct kobj_attribute *attr, char *buf)
> > >>>> +{
> > >>>> +	return sprintf(buf, "%i\n", zpci_unique_uid);
> > >>>> +}
> > >>>> +
> > >>>> +static struct kobj_attribute sys_zpci_uid_checking_attr =
> > >>>> +	__ATTR(uid_checking, 0444, uid_checking_show, NULL);
> > >>>
> > >>> Use DEVICE_ATTR_RO instead of __ATTR.
> > >>
> > >> It's my understanding that DEVICE_ATTR_* is only for
> > >> per device attributes. This one is global for the entire
> > >> Z PCI. I just tried with BUS_ATTR_RO instead
> > >> and that works but only if I put the attribute at
> > >> /sys/bus/pci/uid_checking instead of with a zpci
> > >> subfolder. This path would work for us too, we
> > >> currently don't have any other global attributes
> > >> that we are planning to expose but those could of
> > >> course come up in the future.
> > > 
> > > Ah, I missed the fact that this is a kobj_attribute, not a
> > > device_attribute.  Maybe KERNEL_ATTR_RO()?  Very few uses so far, but
> > > seems like it might fit?
> > > 
> > > Bjorn
> > > 
> > 
> > KERNEL_ATTR_* is currently not exported in any header. After
> > adding it to include/linuc/sysfs.h it indeed works perfectly.
> > Adding Christian Brauner as suggested by get_maintainers for
> > their opinion. I'm of course willing to provide a patch
> 
> Hey Niklas et al. :)
> 
> I think this will need input from Greg. He should be best versed in
> sysfs attributes. The problem with KERNEL_ATTR_* to me seems that it's
> supposed to be kernel internal. Now, that might just be a matter of
> renaming the macro but let's see whether Greg has any better idea or
> more questions. :)

The big question is, why are you needing this?

No driver or driver subsystem should EVER be messing with a "raw"
kobject like this.  Just use the existing DEVICE_* macros instead
please.

If you are using a raw kobject, please ask me how to do this properly,
as that is something that should NEVER show up in the /sys/devices/*
tree.  Otherwise userspace tools will break.

thanks,

greg k-h
