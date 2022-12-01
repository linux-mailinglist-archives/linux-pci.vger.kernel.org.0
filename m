Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6D263F062
	for <lists+linux-pci@lfdr.de>; Thu,  1 Dec 2022 13:24:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbiLAMYI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Dec 2022 07:24:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbiLAMYH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Dec 2022 07:24:07 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 397C59581C;
        Thu,  1 Dec 2022 04:24:05 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669897443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=lcbWOkps8CeeBrRGflRpGB2RwbFNdBrHgzFXj1dkdtI=;
        b=EmnCdR1SsPJYlHfskYAEPFbQWb/6iyPe8V1uAjh4ETIAjLvKJvMyLbReICsa2XZ8w+Mm0y
        WBK14hVm8D4rbIVwFTCMFDo0BVeb4lWPDr74gRIK9sp/C835XyoSjqzmk56xtx6qPqtybd
        TS28Rxw2prBvA3m5/tEKCZ4f9JKyRQYiDwBm2p6RzbkOYOUGkC0lxlJfwoH8ee6qH4xLFi
        x/kB+Pfpy++XVVqhesHXoTZN3s2IyZ1fAwY69D3vUw8Nf3q9SLEt+SeIAjxw3hQsDHzblL
        bmPc3/5GT5xCSyWfV3FHkYRs1FDIIlwxFbyYU65csXNgeuvnyPkDYwtOfl0Xdw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669897443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=lcbWOkps8CeeBrRGflRpGB2RwbFNdBrHgzFXj1dkdtI=;
        b=Vr3+KtQqVhPyhAM/sHxP6CWxpoD/A9ye2g03+XWns2x05aYJdVkmvF7jVICbmwQltjP/gs
        pGI+jUTGBSwgyrAw==
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ashok Raj <ashok.raj@intel.com>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: [patch 19/33] genirq/msi: Provide msi_desc::msi_data
In-Reply-To: <878rk1ectk.ffs@tglx>
Date:   Thu, 01 Dec 2022 13:24:03 +0100
Message-ID: <87cz93s464.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Jason!

On Wed, Nov 23 2022 at 19:38, Thomas Gleixner wrote:
> On Wed, Nov 23 2022 at 12:58, Jason Gunthorpe wrote:
>> I find your perspective on driver authors as the enemy quite
>> interesting :)
>
> I'm not seeing them as enemies. Just my expectations are rather low by
> now :)

This made me think about it for a while. Let me follow up on that.

When I set out to add real-time capabilities to the kernel about 20 years
ago, I did a thorough analysis of the kernel design and code base.

It turned out that aside of well encapsulated infrastructure, e.g. mm,
vfs, scheduler, network core, quite some of the rest was consisting of
blatant layering violations held together with duct tape, super glue and
haywire-circuit.

It was immediately clear to me, that this needs a lot of consolidation
and cleanup work to get me even close to the point where RT becomes
feasible as an integral part of the kernel. But not only this became
clear, I also realized that a continuation of this model will end up in
a maintenance nightmare sooner than later.

Me and the other people interested in RT estimated back then that it'll
take 5-10 years to get this done.

Boy, we were young and naive back then and completely underestimating
the efforts required. Obviously we were also underestimating the
concurrent influx of new stuff.

Just to give you an example. Our early experiments with substituting
spinlocks was just the start of the horrors. Instead of working on the
actual substitution mechanisms and the required other modifications, we
spent a vast amount of our time chasing dead locks all over the place.
My main test machine had not a single device driver which was correct
and working out of the box. What's worse is that we had to debate with
some of the driver people about the correctness of our locking analysis
and fight for stuff getting fixed.

This ended in writing and integrating lockdep, which has thankfully
taken this burden of our plate.

When I started to look into interrupt handling to add support for
threaded interrupts, which are a fundamental prerequisite for RT, the
next nightmare started to unfold.

The "generic" core code was a skeleton and everything real was
implemented in architecture specific code in completely incompatible
ways. It was not even possible to change common data structures without
breaking the world.  What was even worse, drivers fiddled in the
interrupt descriptors just to scratch an itch.

What I learned pretty fast is that most driver writers try to work
around short-comings in common infrastructure instead of tackling the
problem at the root or talking to the developers/maintainers of that
infrastructure.

The consequence of that is: if you want to change core infrastructure
you end up mopping up the driver tree in order not to break things all
over the place. There are clearly better ways to spend your time.

So I started to encapsulate things more strictly - admittedly to make my
own life easier. But at the same time I always tried hard to make these
encapsulations easy to use, to provide common infrastructure in order to
replace boilerplate code and to help with resource management, which is
one of the common problems in driver code. I'm also quite confident that
I carefully listened to the needs of driver developers and I think the
whole discussion about IMS last year is a good example for that. I
surely have opinions, but who doesn't?

So no, I'm not seeing driver writers as enemies. I'm just accepting the
reality that quite some of the drivers are written in "get it out the
door" mode. I'm well aware that there are other folks who stay around for
a long time and do proper engineering and maintenance, but that's sadly
the minority.

Being responsible for core infrastructure is an interesting challenge
especially with the zoo of legacy to keep alive and the knowledge that
you can break the world with a trivial and obviously "correct"
change. Been there, done that. :)

Thanks,

        Thomas
