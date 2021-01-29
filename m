Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE1BB3082C1
	for <lists+linux-pci@lfdr.de>; Fri, 29 Jan 2021 01:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbhA2A5J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Jan 2021 19:57:09 -0500
Received: from magic.merlins.org ([209.81.13.136]:38518 "EHLO
        mail1.merlins.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbhA2A5J (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Jan 2021 19:57:09 -0500
Received: from [204.250.24.206] (port=54620 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92 #3)
        id 1l5I5K-0000Av-Lm by authid <merlins.org> with srv_auth_plain; Thu, 28 Jan 2021 16:56:26 -0800
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc_nouveau@merlins.org>)
        id 1l5I5K-0008IY-7Q; Thu, 28 Jan 2021 16:56:26 -0800
Date:   Thu, 28 Jan 2021 16:56:26 -0800
From:   Marc MERLIN <marc_nouveau@merlins.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     nouveau@lists.freedesktop.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: 5.9.11 still hanging 2mn at each boot and looping on nvidia-gpu
 0000:01:00.3: PME# enabled (Quadro RTX 4000 Mobile)
Message-ID: <20210129005626.GP29348@merlins.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210128205946.GA27855@bjorn-Precision-5520>
 <20210127213300.GA3046575@bjorn-Precision-5520>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
X-Broken-Reverse-DNS: no host name for IP address 204.250.24.206
X-SA-Exim-Connect-IP: 204.250.24.206
X-SA-Exim-Mail-From: marc_nouveau@merlins.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 27, 2021 at 03:33:00PM -0600, Bjorn Helgaas wrote:
> Hi Marc, I appreciate your persistence on this.  I am frankly
> surprised that you've put up with this so long.
 
Well, been using linux for 27 years, but also it's not like I have much
of a choice outside of switching to windows, as tempting as it's getting
sometimes ;)

> > after boot, when it gets the right trigger (not sure which ones), it
> > loops on this evern 2 seconds, mostly forever.
> > 
> > I'm not sure if it's nouveau's fault or the kernel's PCI PME's fault, or something else.
> 
> IIUC there are basically two problems:
> 
>   1) A 2 minute delay during boot
> Another random thought: is there any chance the boot delay could be
> related to crypto waiting for entropy?

So, the 2mn hang went away after I added the nouveau firwmare in initrd.
The only problem is that the nouveau driver does not give a very good
clue as to what's going on and what to do.
For comparison the intel iwlwifi driver is very clear about firmware
it's trying to load, if it can't and what exact firmware you need to
find on the internet (filename)

>   2) Some sort of event every 2 seconds that kills your battery life
> Your machine doesn't sound unusual, and I haven't seen a flood of
> similar reports, so maybe there's something unusual about your config.
> But I really don't have any guesses for either one.

Honestly, there are not too many thinpad P73 running linux out there. I
wouldn't be surprised if it's only a handful or two.

> It sounds like v5.5 worked fine and you first noticed the slow boot
> problem in v5.8.  We *could* try to bisect it, but I know that's a lot
> of work on your part.

I've done that in the past, to be honest now that it works after I added
the firmware that nouveau started needing, and didn't need before, the
hang at boot is gone for sure.
The PCI PM wakeup issues on batteries happen sometimes still, but they
are much more rare now.

> Grasping for any ideas for the boot delay; could you boot with
> "initcall_debug" and collect your "lsmod" output?  I notice async_tx
> in some of your logs, but I have no idea what it is.  It's from
> crypto, so possibly somewhat unusual?

Is this still neeeded? I think of nouveau does a better job of helping
the user correct the issue if firmware is missing (I think intel even
gives a URL in printk), that would probably be what's needed for the
most part.

[   12.832547] async_tx: api initialized (async) comes from ./crypto/async_tx/async_tx.c

Thanks for your answer, let me know if there is anything else useful I
can give, I think I'm otherwise mostly ok now.

Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
