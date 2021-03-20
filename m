Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12E91342D7C
	for <lists+linux-pci@lfdr.de>; Sat, 20 Mar 2021 16:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbhCTO7v (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 20 Mar 2021 10:59:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32294 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229634AbhCTO7u (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 20 Mar 2021 10:59:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616252389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YLVzrWQgbgfLtaL/xiaXF4nkjYeSkIQsVEf8ccE5VFE=;
        b=L6ycEbdywJ5+X/qJ2CtAwq2t56TjEbgTZQSg9CO8hS8v6dz54quZbmHBS7rsapxcMkNI5W
        hRnN40QF1J1WikIppwUT3mZZPm76iy/vdhULz73VFS59Ft1+QuDrLVA422I+VugDsrGdSB
        RqPHTN7uqFNOa00AW9wOGKm6QTvDkjA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-5nMUD_74MNyvTTgOkMkBAg-1; Sat, 20 Mar 2021 10:59:45 -0400
X-MC-Unique: 5nMUD_74MNyvTTgOkMkBAg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D0A9A593A0;
        Sat, 20 Mar 2021 14:59:43 +0000 (UTC)
Received: from x1.home.shazbot.org (ovpn-112-120.phx2.redhat.com [10.3.112.120])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0EA581A86B;
        Sat, 20 Mar 2021 14:59:43 +0000 (UTC)
Date:   Sat, 20 Mar 2021 08:59:42 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Amey Narkhede <ameynarkhede03@gmail.com>,
        raphael.norwitz@nutanix.com, linux-pci@vger.kernel.org,
        bhelgaas@google.com, linux-kernel@vger.kernel.org,
        alay.shah@nutanix.com, suresh.gumpula@nutanix.com,
        shyam.rajendran@nutanix.com, felipe@nutanix.com
Subject: Re: [PATCH 4/4] PCI/sysfs: Allow userspace to query and set device
 reset mechanism
Message-ID: <20210320085942.3cefcc48@x1.home.shazbot.org>
In-Reply-To: <YFW78AfbhYpn16H4@unreal>
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
        <YFW78AfbhYpn16H4@unreal>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, 20 Mar 2021 11:10:08 +0200
Leon Romanovsky <leon@kernel.org> wrote:
> On Fri, Mar 19, 2021 at 10:23:13AM -0600, Alex Williamson wrote: 
> > 
> > What if we taint the kernel or pci_warn() for cases where either all
> > the reset methods are disabled, ie. 'echo none > reset_method', or any
> > time a device specific method is disabled?  
> 
> What does it mean "none"? Does it mean nothing supported? If yes, I think that
> pci_warn() will be enough. At least for me, taint is usable during debug stages,
> probably if device doesn't crash no one will look to see /proc/sys/kernel/tainted.

"none" as implemented in this patch, clearing the enabled function
reset methods.

> > I'd almost go so far as to prevent disabling a device specific reset
> > altogether, but for example should a device specific reset that fixes
> > an aspect of FLR behavior prevent using a bus reset?  I'd prefer in that
> > case if direct FLR were disabled via a device flag introduced with the
> > quirk and the remaining resets can still be selected by preference.  
> 
> I don't know enough to discuss the PCI details, but you raised good point.
> This sysfs is user visible API that is presented as is from device point
> of view. It can be easily run into problems if PCI/core doesn't work with
> user's choice.
> 
> > 
> > Theoretically all the other reset methods work and are available, it's
> > only a policy decision which to use, right?  
> 
> But this patch was presented as a way to overcome situations where
> supported != working and user magically knows which reset type to set.

It's not magic, the new sysfs attributes expose which resets are
enabled and the order that they're used, the user can simply select the
next one.  Being able to bypass a broken reset method is a helpful side
effect of getting to select a preferred reset method.

> If you want to take this patch to be policy decision tool,
> it will need to accept "reset_type1,reset_type2,..." sort of input,
> so fallback will work natively.

I don't see that as a requirement.  We have fall-through support in the
kernel, but for a given device we're really only ever going to make use
of one of those methods.  If a user knows enough about a device to have
a preference, I think it can be singular.  That also significantly
simplifies the interface and supporting code.  Thanks,

Alex

