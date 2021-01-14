Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C08D2F6247
	for <lists+linux-pci@lfdr.de>; Thu, 14 Jan 2021 14:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725961AbhANNpj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jan 2021 08:45:39 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:57667 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727333AbhANNpj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jan 2021 08:45:39 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1l02vn-0003FL-4a; Thu, 14 Jan 2021 13:44:55 +0000
Date:   Thu, 14 Jan 2021 14:44:53 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Pierre Morel <pmorel@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Viktor Mihajlovski <mihajlov@linux.ibm.com>
Subject: Re: [RFC 1/1] s390/pci: expose UID checking state in sysfs
Message-ID: <20210114134453.bkfik4zjt5ehz6d5@wittgenstein>
References: <20210113185500.GA1918216@bjorn-Precision-5520>
 <675aa466-59ea-cf8a-6eec-caa6478ba4cd@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <675aa466-59ea-cf8a-6eec-caa6478ba4cd@linux.ibm.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 14, 2021 at 02:20:10PM +0100, Niklas Schnelle wrote:
> 
> 
> On 1/13/21 7:55 PM, Bjorn Helgaas wrote:
> > On Wed, Jan 13, 2021 at 08:47:58AM +0100, Niklas Schnelle wrote:
> >> On 1/12/21 10:50 PM, Bjorn Helgaas wrote:
> >>> On Mon, Jan 11, 2021 at 10:38:57AM +0100, Niklas Schnelle wrote:
> >>>> We use the UID of a zPCI adapter, or the UID of the function zero if
> >>>> there are multiple functions in an adapter, as PCI domain if and only if
> >>>> UID Checking is turned on.
> >>>> Otherwise we automatically generate domains as devices appear.
> >>>>
> >>>> The state of UID Checking is thus essential to know if the PCI domain
> >>>> will be stable, yet currently there is no way to access this information
> >>>> from userspace.
> >>>> So let's solve this by showing the state of UID checking as a sysfs
> >>>> attribute in /sys/bus/pci/uid_checking
> > 
> >>>> +/* Global zPCI attributes */
> >>>> +static ssize_t uid_checking_show(struct kobject *kobj,
> >>>> +				 struct kobj_attribute *attr, char *buf)
> >>>> +{
> >>>> +	return sprintf(buf, "%i\n", zpci_unique_uid);
> >>>> +}
> >>>> +
> >>>> +static struct kobj_attribute sys_zpci_uid_checking_attr =
> >>>> +	__ATTR(uid_checking, 0444, uid_checking_show, NULL);
> >>>
> >>> Use DEVICE_ATTR_RO instead of __ATTR.
> >>
> >> It's my understanding that DEVICE_ATTR_* is only for
> >> per device attributes. This one is global for the entire
> >> Z PCI. I just tried with BUS_ATTR_RO instead
> >> and that works but only if I put the attribute at
> >> /sys/bus/pci/uid_checking instead of with a zpci
> >> subfolder. This path would work for us too, we
> >> currently don't have any other global attributes
> >> that we are planning to expose but those could of
> >> course come up in the future.
> > 
> > Ah, I missed the fact that this is a kobj_attribute, not a
> > device_attribute.  Maybe KERNEL_ATTR_RO()?  Very few uses so far, but
> > seems like it might fit?
> > 
> > Bjorn
> > 
> 
> KERNEL_ATTR_* is currently not exported in any header. After
> adding it to include/linuc/sysfs.h it indeed works perfectly.
> Adding Christian Brauner as suggested by get_maintainers for
> their opinion. I'm of course willing to provide a patch

Hey Niklas et al. :)

I think this will need input from Greg. He should be best versed in
sysfs attributes. The problem with KERNEL_ATTR_* to me seems that it's
supposed to be kernel internal. Now, that might just be a matter of
renaming the macro but let's see whether Greg has any better idea or
more questions. :)

Christian
