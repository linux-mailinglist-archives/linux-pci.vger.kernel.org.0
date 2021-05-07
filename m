Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0A7D376662
	for <lists+linux-pci@lfdr.de>; Fri,  7 May 2021 15:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237284AbhEGNtq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 May 2021 09:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233394AbhEGNtq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 May 2021 09:49:46 -0400
Received: from forward101j.mail.yandex.net (forward101j.mail.yandex.net [IPv6:2a02:6b8:0:801:2::101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC19C061574;
        Fri,  7 May 2021 06:48:46 -0700 (PDT)
Received: from myt5-6c0659e8c6cb.qloud-c.yandex.net (myt5-6c0659e8c6cb.qloud-c.yandex.net [IPv6:2a02:6b8:c12:271e:0:640:6c06:59e8])
        by forward101j.mail.yandex.net (Yandex) with ESMTP id D50E61BE05A3;
        Fri,  7 May 2021 16:48:42 +0300 (MSK)
Received: from myt6-016ca1315a73.qloud-c.yandex.net (myt6-016ca1315a73.qloud-c.yandex.net [2a02:6b8:c12:4e0e:0:640:16c:a131])
        by myt5-6c0659e8c6cb.qloud-c.yandex.net (mxback/Yandex) with ESMTP id K5FUyg2S2D-mgJ4cvpM;
        Fri, 07 May 2021 16:48:42 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1620395322;
        bh=4pQdm6lW2CSFKNQkRPGSkPTFUxNMrdCXnEtaNzASlCM=;
        h=In-Reply-To:Cc:To:From:Subject:Message-ID:References:Date;
        b=f4LuAhYh8Y3eSh2FgfE9PsafjrO2RUtxXDddYAIn/Gl5RKdhCZYWXhKQhD6J+9bsU
         25PUfQ1TYWWVREOppAKs+RS/nXLOUQ3tYprAQVj/89aeXCJYegtibBYoJUfQQFWSkw
         cAJOru6ZbvJFLHfg4os9C0FMxkxk0Q6UeaRLCCCQ=
Authentication-Results: myt5-6c0659e8c6cb.qloud-c.yandex.net; dkim=pass header.i=@yandex.ru
Received: by myt6-016ca1315a73.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id 2yzLWyRUGG-mfLOVpFS;
        Fri, 07 May 2021 16:48:41 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Message-ID: <5a241026101100958745fb5ca786df92a5d4518b.camel@yandex.ru>
Subject: Re: [PATCH] PCI: don't power-off apple thunderbolt controller on
 s2idle
From:   Konstantin Kharlamov <hi-angel@yandex.ru>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andreas Noever <andreas.noever@gmail.com>,
        linux-pm@vger.kernel.org, Lukas Wunner <lukas@wunner.de>
Date:   Fri, 07 May 2021 16:48:41 +0300
In-Reply-To: <20210507130724.GA1499364@bjorn-Precision-5520>
References: <20210507130724.GA1499364@bjorn-Precision-5520>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.0 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 2021-05-07 at 08:07 -0500, Bjorn Helgaas wrote:
> [+cc Lukas]
> 
> On Fri, May 07, 2021 at 12:32:20PM +0300, Konstantin Kharlamov wrote:
> > On Thu, 2021-05-06 at 16:48 -0500, Bjorn Helgaas wrote:
> > > [+cc Rafael, Andreas, linux-pm]
> > > 
> > > On Thu, May 06, 2021 at 08:38:20PM +0300, Konstantin Kharlamov wrote:
> > > > On Macbook 2013 resuming from s2idle results in external monitor no
> > > > longer being detected, and dmesg having errors like:
> > > > 
> > > >     pcieport 0000:06:00.0: can't change power state from D3hot to D0
> > > > (config
> > > > space inaccessible)
> > > > 
> > > > and a stacktrace. The reason turned out that the hw that the quirk
> > > > powers off does not get powered on back on resume.
> > > 
> > > quirk_apple_poweroff_thunderbolt() was added in 2014 by 1df5172c5c25
> > > ("PCI: Suspend/resume quirks for Apple thunderbolt").  It claims
> > > "power is automatically restored before resume," so there must be
> > > something special about s2idle that prevents the power-on.
> > > 
> > > IIUC this change will reduce the s2idle power savings.  I would feel
> > > better about this if we understood what the difference was.  
> > > 
> > > > Thus, add a check for s2idle to the quirk, and do nothing if the suspend
> > > > mode is s2idle.
> > > 
> > > Obviously the *hardware* hasn't changed since 1df5172c5c25.  Is s2idle
> > > something that wasn't tested back then, or is this problem connected
> > > to an s2idle change since then?  Can we identify a commit that
> > > introduced this problem?  That would help with backporting or stable
> > > tags.
> > > 
> > > > Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=212767
> > > 
> > > Thanks for this!  Would you mind attaching the output of
> > > "sudo lspci -vvv"?  If you attach any other dmesg, could you
> > > use "dmesg --color=never" so the log doesn't include all the
> > > escape characters?
> > 
> > Thank you! So, just to be clear: in lieu of Lukas Wunner's reply, do
> > you still want `lspci` and `dmesg` outputs, or are you okay with the
> > information Lukas provided?
> 
> Yes, please attach at least lspci output.  It helps understand the
> topology and may be useful in the future.  I wish we had a similar
> bugzilla with more information about the original 1df5172c5c25.

Thanks! I attached the `sudo lspci -vvv` output to the bugreport, here's a direct link to the attachment https://bugzilla.kernel.org/attachment.cgi?id=296689

