Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10BBD44D4F0
	for <lists+linux-pci@lfdr.de>; Thu, 11 Nov 2021 11:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbhKKKXm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Nov 2021 05:23:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:57490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230256AbhKKKXi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Nov 2021 05:23:38 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7651761268;
        Thu, 11 Nov 2021 10:20:49 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.misterjones.org)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1ml7CJ-004nqD-6t; Thu, 11 Nov 2021 10:20:47 +0000
Date:   Thu, 11 Nov 2021 10:20:46 +0000
Message-ID: <87pmr7803l.wl-maz@kernel.org>
From:   Marc Zyngier <maz@kernel.org>
To:     Christian Zigotzky <chzigotzky@xenosoft.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "bhelgaas@google.com >> Bjorn Helgaas" <bhelgaas@google.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        lorenzo.pieralisi@arm.com, Rob Herring <robh@kernel.org>,
        Matthew Leaman <matthew@a-eon.biz>,
        Darren Stevens <darren@stevens-zone.net>,
        mad skateman <madskateman@gmail.com>,
        "R.T.Dickinson" <rtd2@xtra.co.nz>,
        Christian Zigotzky <info@xenosoft.de>, axboe@kernel.dk,
        damien.lemoal@opensource.wdc.com, kw@linux.com,
        Arnd Bergmann <arnd@arndb.de>, robert@swiecki.net,
        Olof Johansson <olof@lixom.net>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PASEMI] Nemo board doesn't recognize any ATA disks with the pci-v5.16 updates
In-Reply-To: <f40294c6-a088-af53-eeea-4dfbd255c5c9@xenosoft.de>
References: <78308692-02e6-9544-4035-3171a8e1e6d4@xenosoft.de>
        <20211110184106.GA1251058@bhelgaas>
        <87sfw3969l.wl-maz@kernel.org>
        <8cc64c3b-b0c0-fb41-9836-2e5e6a4459d1@xenosoft.de>
        <87r1bn88rt.wl-maz@kernel.org>
        <f40294c6-a088-af53-eeea-4dfbd255c5c9@xenosoft.de>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: chzigotzky@xenosoft.de, helgaas@kernel.org, bhelgaas@google.com, alyssa@rosenzweig.io, lorenzo.pieralisi@arm.com, robh@kernel.org, matthew@a-eon.biz, darren@stevens-zone.net, madskateman@gmail.com, rtd2@xtra.co.nz, info@xenosoft.de, axboe@kernel.dk, damien.lemoal@opensource.wdc.com, kw@linux.com, arnd@arndb.de, robert@swiecki.net, olof@lixom.net, linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 11 Nov 2021 07:47:08 +0000,
Christian Zigotzky <chzigotzky@xenosoft.de> wrote:
> 
> On 11 November 2021 at 08:13 am, Marc Zyngier wrote:
> > On Thu, 11 Nov 2021 05:24:52 +0000,
> > Christian Zigotzky <chzigotzky@xenosoft.de> wrote:
> >> Hello Marc,
> >> 
> >> Here you are:
> >> https://forum.hyperion-entertainment.com/viewtopic.php?p=54406#p54406
> > This is not what I asked. I need the actual source file, or at the
> > very least the compiled object (the /sys/firmware/fdt file, for
> > example). Not an interpretation that I can't feed to the kernel.
> > 
> > Without this, I can't debug your problem.
> > 
> >> We are very happy to have the patch for reverting the bad commit
> >> because we want to test the new PASEMI i2c driver with support for the
> >> Apple M1 [1] on our Nemo boards.
> > You can revert the patch on your own. At this stage, we're not blindly
> > reverting things in the tree, but instead trying to understand what
> > is happening on your particular system.
> > 
> > Thanks,
> > 
> > 	M.
> > 
> I added a download link for the fdt file to the post [1]. Please read
> also Darren's comments in this post.

Thanks for that. The DT looks absolutely bonkers, no wonder that
things break with something like that.

But Darren's comments made me jump a bit, and I quote them here for
everyone to see:

<quote>
[...]

The dtb passed by the CFE firmware has a number of issues, which up till
now have been fixed by use of patches applied to the mainline kernel.
This occasionally causes problems with changes made to mainline.

[...]
</quote>

Am I right in understanding that the upstream kernel does not support
the machine out of the box, and that you actually have to apply out of
tree patches to make it work? That these patches have to do with the
IRQ routing?

If so, I wonder why upstream should revert a patch to work on a system
that isn't supported upstream the first place. I will still try and
come up with a solution for you. But asking for the revert of a patch
on these grounds is not, IMHO, acceptable. Also, please provide these
patches on the list so that I can help you to some extend (and I mean
*on the list*, not on a random forum that collects my information).

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.
