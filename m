Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62EE537EE28
	for <lists+linux-pci@lfdr.de>; Thu, 13 May 2021 00:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346115AbhELVLl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 May 2021 17:11:41 -0400
Received: from forward100o.mail.yandex.net ([37.140.190.180]:50247 "EHLO
        forward100o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1382753AbhELUiP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 May 2021 16:38:15 -0400
Received: from forward100q.mail.yandex.net (forward100q.mail.yandex.net [IPv6:2a02:6b8:c0e:4b:0:640:4012:bb97])
        by forward100o.mail.yandex.net (Yandex) with ESMTP id 5C9C44AC0389;
        Wed, 12 May 2021 23:36:48 +0300 (MSK)
Received: from vla1-b67ee7b88a11.qloud-c.yandex.net (vla1-b67ee7b88a11.qloud-c.yandex.net [IPv6:2a02:6b8:c0d:3789:0:640:b67e:e7b8])
        by forward100q.mail.yandex.net (Yandex) with ESMTP id 56BE57080002;
        Wed, 12 May 2021 23:36:48 +0300 (MSK)
Received: from vla5-47b3f4751bc4.qloud-c.yandex.net (vla5-47b3f4751bc4.qloud-c.yandex.net [2a02:6b8:c18:3508:0:640:47b3:f475])
        by vla1-b67ee7b88a11.qloud-c.yandex.net (mxback/Yandex) with ESMTP id Gjmc3gmvNr-amI0TsCL;
        Wed, 12 May 2021 23:36:48 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1620851808;
        bh=V8Ux2fmBLrUWCWlnYdbeVm97FFnT4+x+mBhC/t21xis=;
        h=In-Reply-To:Cc:To:From:Subject:Message-ID:References:Date;
        b=mp5RrhKFvF945voP4e1Ob4bQ6fY7jxnYX8Yy6JJniQKxi3bw4k7lVQf4MjLRVdmhV
         OJHMqpJXsbLbFcm9Xkm2f72u1TdoHZ6gjcrAA5390ObZuhiCxGHgVDa/Ub2mz/Pjp5
         ooOpYMummOxLJS7uhkaMVDfZ0YjD9h6ekxx/cs38=
Authentication-Results: vla1-b67ee7b88a11.qloud-c.yandex.net; dkim=pass header.i=@yandex.ru
Received: by vla5-47b3f4751bc4.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id ZoulYOWW3x-alMqeaZd;
        Wed, 12 May 2021 23:36:47 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Message-ID: <949ea2de32241807b781f119fb14390e92845081.camel@yandex.ru>
Subject: Re: [PATCH] PCI: don't power-off apple thunderbolt controller on
 s2idle
From:   Konstantin Kharlamov <hi-angel@yandex.ru>
To:     Bjorn Helgaas <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>
Cc:     linux-pci@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andreas Noever <andreas.noever@gmail.com>,
        linux-pm@vger.kernel.org
Date:   Wed, 12 May 2021 23:36:47 +0300
In-Reply-To: <8ddea02fc6d37f7c444a1e90c9f03d7656ffe957.camel@yandex.ru>
References: <20210507133002.GA1499665@bjorn-Precision-5520>
         <8ddea02fc6d37f7c444a1e90c9f03d7656ffe957.camel@yandex.ru>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Bjorn: so, given this and other comments, what's the decision on this patch? Any
particular changes I should do for it to be accepted?

On Fri, 2021-05-07 at 17:08 +0300, Konstantin Kharlamov wrote:
> On Fri, 2021-05-07 at 08:30 -0500, Bjorn Helgaas wrote:
> > On Fri, May 07, 2021 at 12:07:38AM +0200, Lukas Wunner wrote:
> > > On Thu, May 06, 2021 at 04:48:42PM -0500, Bjorn Helgaas wrote:
> > > > On Thu, May 06, 2021 at 08:38:20PM +0300, Konstantin Kharlamov wrote:
> > > > > On Macbook 2013 resuming from s2idle results in external monitor no
> > > > > longer being detected, and dmesg having errors like:
> > > > > 
> > > > >     pcieport 0000:06:00.0: can't change power state from D3hot to D0
> > > > > (config space inaccessible)
> > > > > 
> > > > > and a stacktrace. The reason turned out that the hw that the quirk
> > > > > powers off does not get powered on back on resume.
> > > > 
> > > > quirk_apple_poweroff_thunderbolt() was added in 2014 by 1df5172c5c25
> > > > ("PCI: Suspend/resume quirks for Apple thunderbolt").  It claims
> > > > "power is automatically restored before resume," so there must be
> > > > something special about s2idle that prevents the power-on.
> > > 
> > > With s2idle, the machine isn't suspended via ACPI, so the AML code
> > > which powers the controller off isn't executed.  The dance to prepare
> > > the controller for power-off consequently isn't necessary but rather
> > > harmful.
> > > 
> > > To get the same power savings as with ACPI suspend, the controller
> > > needs to be powered off via runtime suspend.  I posted patches for
> > > that back in 2016.  I'm using them on my laptop, they need some
> > > polishing and rebasing before I can repost them due to massive
> > > changes that have happened in the thunderbolt driver in the meantime.
> > > Without these patches, the controller sucks 1.5W of power in s2idle.
> > > 
> > > > Obviously the *hardware* hasn't changed since 1df5172c5c25.  Is s2idle
> > > > something that wasn't tested back then, or is this problem connected
> > > > to an s2idle change since then?  Can we identify a commit that
> > > > introduced this problem?  That would help with backporting or stable
> > > > tags.
> > > 
> > > Yes I believe the quirk predates the introduction of s2idle by a couple
> > > of years.
> > 
> > In an ideal world, we would know which commit introduced s2idle and
> > hence the possibility of hitting this bug, and we would add a Fixes:
> > tag for that commit so we could connect this fix with it.
> > 
> > Apart from that, what I don't like about this (and about the original
> > 1df5172c5c25) is that there's no connection to a spec or to documented
> > behavior of the device or of suspend/resume.
> 
> I did some research, and found that s2idle was first introduced in 2013 in
> commit 7e73c5ae6e799 (except it wasn't called "s2idle", by that name it goes
> since around 2016 as Lukas mentioned. In 7e73c5ae6e799 it is called "freeze").
> This is before 1df5172c5c25 which was added in 2014, so I guess we can add a:
> 
>         Fixes: 1df5172c5c25 ("PCI: Suspend/resume quirks for Apple
> thunderbolt")
> 
> > For example, "With s2idle, the machine isn't suspended via ACPI, so
> > the AML code which powers the controller off isn't executed."  AFAICT
> > that isn't actually a required, documented property of s2idle, but
> > rather it reaches into the internal implementation.
> > 
> > The code comment "If suspend mode is s2idle, power won't get restored
> > on resume" is similar.  !pm_suspend_via_firmware() tells us that
> > platform firmware won't be invoked.  But the connection between *that*
> > and "power won't get restored" is unexplained.
> 
> Sorry, I can't comment anything regarding AML and power management in general
> since I am really new to all of this. However, regarding the usage of the
> `pm_suspend_via_firmware()`: yeah, I also think it is unclear what this does,
> and I was thinking about adding a wrapper function something like
> `is_s2idle()` to the suspend.h, which would simply call
> `pm_suspend_via_firmware` internally. I didn't do that because I thought that
> usage of pm_suspend_via_firmware() for that task is just something people
> working with power management are supposed to know, but if someone else
> questions it too, I can make such wrapper, it's just a 3 lines-of-code change.
> 
> FWIW, originally I found out that pm_suspend_via_firmware() can be used for
> detecting s2idle by simply asking about it on linux-pm:
> https://marc.info/?l=linux-pm&m=162029296108775&w=2
> 


