Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CADE7342C93
	for <lists+linux-pci@lfdr.de>; Sat, 20 Mar 2021 12:54:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbhCTLxy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 20 Mar 2021 07:53:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:34460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230095AbhCTLxn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 20 Mar 2021 07:53:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6080C61973;
        Sat, 20 Mar 2021 09:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616231413;
        bh=jESRaHQQjcAoWFFL1XrKb8MAdftiII5rPd4gYd4p+gM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hITO8Ymn1Mr9SNuYa5khrjZyN0cKc/fwqBtNTjtI1xfKkGCMUXgn5GmJXmpu8ewmq
         X765KzYSDTCriBH8tWQw8obBnvxTjCgaZyr+/ST3Tv1WPbezc/mPZh8RbsDRQayrf0
         uxhRLtDuiJM+SNKwJ5RZMhUUdAHBUaAvqvWBY9OuuioA/VJzHRA6P9Mzc0qTvDKOu6
         pHkGgmzDbWbvbfZZSAtWo6NAPf4sJKDP9XglUkAp6n8uK+9SYz3SpXnzEIxCG4koev
         1Nu4NLCGkJ8tVk2DCj1VXkHnnfd3j8UFhHI//s3qnQc+FDl8bCScr3O8gqIQGhwQ4f
         2ywX0cXik6oBw==
Date:   Sat, 20 Mar 2021 11:10:08 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Amey Narkhede <ameynarkhede03@gmail.com>,
        raphael.norwitz@nutanix.com, linux-pci@vger.kernel.org,
        bhelgaas@google.com, linux-kernel@vger.kernel.org,
        alay.shah@nutanix.com, suresh.gumpula@nutanix.com,
        shyam.rajendran@nutanix.com, felipe@nutanix.com
Subject: Re: [PATCH 4/4] PCI/sysfs: Allow userspace to query and set device
 reset mechanism
Message-ID: <YFW78AfbhYpn16H4@unreal>
References: <YFHsW/1MF6ZSm8I2@unreal>
 <20210317131718.3uz7zxnvoofpunng@archlinux>
 <YFILEOQBOLgOy3cy@unreal>
 <20210317113140.3de56d6c@omen.home.shazbot.org>
 <YFMYzkg101isRXIM@unreal>
 <20210318103935.2ec32302@omen.home.shazbot.org>
 <YFOMShJAm4j/3vRl@unreal>
 <a2b9dc7e-e73a-3a70-5899-8ed37a8ef700@metux.net>
 <YFSgQ2RWqt4YyIV4@unreal>
 <20210319102313.179e9969@omen.home.shazbot.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319102313.179e9969@omen.home.shazbot.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 19, 2021 at 10:23:13AM -0600, Alex Williamson wrote:
> On Fri, 19 Mar 2021 14:59:47 +0200
> Leon Romanovsky <leon@kernel.org> wrote:
> 
> > On Thu, Mar 18, 2021 at 07:34:56PM +0100, Enrico Weigelt, metux IT consult wrote:
> > > On 18.03.21 18:22, Leon Romanovsky wrote:
> > >   
> > > > Which email client do you use?
> > > > Your responses are grouped as one huge block without any chance to respond
> > > > to you on specific point or answer to your question.  
> > > 
> > > I'm reading this thread in Tbird, and threading / quoting all looks
> > > nice.  
> > 
> > I'm not talking about threading or quoting but about response itself.
> > See it here https://lore.kernel.org/lkml/20210318103935.2ec32302@omen.home.shazbot.org/
> > Alex's response is one big chunk without any separations to paragraphs.
> 
> I've never known paragraph breaks to be required to interject a reply.

Of course not, but as Bjorn said if you don't do paragraphs, we will
need manually break your message, fix ">" quotation marks and half
sentences.

I just wanted to be sure that this is not my mail client.

> 
> Back on topic...
> 
> > >   
> > > > I see your flow and understand your position, but will repeat my
> > > > position. We need to make sure that vendors will have incentive to
> > > > supply quirks.  
> 
> What if we taint the kernel or pci_warn() for cases where either all
> the reset methods are disabled, ie. 'echo none > reset_method', or any
> time a device specific method is disabled?

What does it mean "none"? Does it mean nothing supported? If yes, I think that
pci_warn() will be enough. At least for me, taint is usable during debug stages,
probably if device doesn't crash no one will look to see /proc/sys/kernel/tainted.

> 
> I'd almost go so far as to prevent disabling a device specific reset
> altogether, but for example should a device specific reset that fixes
> an aspect of FLR behavior prevent using a bus reset?  I'd prefer in that
> case if direct FLR were disabled via a device flag introduced with the
> quirk and the remaining resets can still be selected by preference.

I don't know enough to discuss the PCI details, but you raised good point.
This sysfs is user visible API that is presented as is from device point
of view. It can be easily run into problems if PCI/core doesn't work with
user's choice.

> 
> Theoretically all the other reset methods work and are available, it's
> only a policy decision which to use, right?

But this patch was presented as a way to overcome situations where
supported != working and user magically knows which reset type to set.

If you want to take this patch to be policy decision tool,
it will need to accept "reset_type1,reset_type2,..." sort of input,
so fallback will work natively.

I think that it will be much more robust and cleaner solution than it is now.
Something like that:
cat /sys/..../reset_policy
reset_type1,reset_type2,...,reset_typeX
echo "reset_type3,reset_type1" > /sys/..../reset_policy
cat /sys/..../reset_policy
reset_type3,reset_type1

Thanks
