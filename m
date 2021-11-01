Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B640441BFF
	for <lists+linux-pci@lfdr.de>; Mon,  1 Nov 2021 14:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbhKAN6E (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Nov 2021 09:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbhKAN6D (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Nov 2021 09:58:03 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D0FC061714;
        Mon,  1 Nov 2021 06:55:30 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0cfa00550d50f28aca2b2a.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:fa00:550d:50f2:8aca:2b2a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D02BC1EC0372;
        Mon,  1 Nov 2021 14:55:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1635774928;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GcU1HWR5qISsDwTHBiKEg0sBai14OP3L0fM0QZX4Ol4=;
        b=g/e5Vr8DDlHPO8e9O2574sKCmZupwyOws8NUFT0VlaThZsQVTgTc6DxawEV0bEDjFpwO2i
        5QAX5PlDEluAbZmTZRvvsdYy6wp7ZreqlKJSFYR1zdIPDeYaJgDKjGbrJczKAQGNh2hrNK
        6rheWjYP3HBic0N8dgpxodhEE6OyWpo=
Date:   Mon, 1 Nov 2021 14:55:26 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Xuesong Chen <xuesong.chen@linux.alibaba.com>
Cc:     Will Deacon <will@kernel.org>, helgaas@kernel.org,
        catalin.marinas@arm.com, lorenzo.pieralisi@arm.com,
        james.morse@arm.com, rafael@kernel.org, tony.luck@intel.com,
        mingo@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/4] PCI MCFG consolidation and APEI resource filtering
Message-ID: <YX/xzjsoSVgHl1vz@zn.tnic>
References: <YW5OTMz+x8zrsqkF@Dennis-MBP.local>
 <20211027081035.53370-1-xuesong.chen@linux.alibaba.com>
 <e387413f-dbe8-e0f1-257b-141362d74e3a@linux.alibaba.com>
 <20211101093618.GA27400@willie-the-truck>
 <286ac625-e712-d7e9-2f5d-923f1572b5d1@linux.alibaba.com>
 <YX/cIhZDgUGI3FKd@zn.tnic>
 <19fde29a-5a63-3fe7-2e83-307a974c80ad@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <19fde29a-5a63-3fe7-2e83-307a974c80ad@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 01, 2021 at 09:32:31PM +0800, Xuesong Chen wrote:
> Actually that's my original intention

There's a misunderstanding here - I don't think your original intention
is to get ignored indefinitely.

> especially when you take lots of serious effors to rework it round by
> round, but no one say YES or NO, which is really frustrating.

Well, try to put yourself in the maintainer's shoes, maybe that would
answer some of that frustration:

- Most of the maintainers are overworked and backlogged until forever.

- If you rework something and you don't get an answer, maybe the
maintainer is not sure yet and is thinking about the pros and cons of
taking that patch.

Greg has formulated this particular issue of the maintainers very
nicely:

"Seriously. It's easier for the maintainer to not accept your code at
all. To accept it, it takes time to review it, apply it, send it on up
the development chain, handle any problems that might happen with the
patch, accept responsibility for the patch, possibly fix any problems
that happen later on when you disappear, and maintain it for the next 20
years.

That's a lot of work that you are asking someone else to do on your
behalf…

So your goal is, when sending a patch, to give me no excuse to not
accept it. To make it such that if I ignore it, or reject it, I am the
one that is the problem here, not you."

And this thing is not really clear to all submitters - once their
patch(es) is applied, they're done. But maintainers have to deal with
that code forever.

So before you send your patchset, try to think as a maintainer and
think whether your change makes sense for the *whole* tree and whether
maintaining it forward would be easy.

- Did I say that maintainers are overworked?

Submitters don't see the amount of work maintainers do in the
background, testing everything and fixing build issues and bugs. Because
most of the time, submitters submit and the cleanups and bugs get mopped
after them by the maintainers - not the submitters.

Look at how some trees resort to maintainer *groups* because a single
maintainer simply doesn't scale, at the risk of a burnout or whatever
nasty.

And those maintainer groups have *all* their hands full.

> Hopefully the newbies can also be treated fairly in the community.

Newbies are treated fairly in the community - especially those who come
prepared and try to understand why the maintainers say things they way
they do and listen to feedback.

If there are examples against that, we would all like to know about
them.

I sincerely hope that explains the situation and hope that it'll help
you see it from the maintainers' POV too and maybe help you deal with
future submissions a lot better.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
