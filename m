Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74A6A1B6BDE
	for <lists+linux-pci@lfdr.de>; Fri, 24 Apr 2020 05:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbgDXDXI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Apr 2020 23:23:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:37860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725884AbgDXDXI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 23 Apr 2020 23:23:08 -0400
Received: from localhost (mobile-166-175-187-210.mycingular.net [166.175.187.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86CE42075A;
        Fri, 24 Apr 2020 03:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587698587;
        bh=QGw/dUCZotIbC/RrVmGOtAfKOimSYFvHWBXMT3tuKiQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=RnXjtqZXoxf6opd5HyypjaJ3ypfWW8b8ua2q7NGQPQLLdSh+laadbtGI/68vWCx7Z
         0CwD36NiMJSQ+IAYCtWNgy/H/ukW7AQsheYgVtbXOeMI1B3PCnaBde282yPJzSnyZg
         bUNMzCc7w+VrzYBSzH/B34igSd3JsCxLx7OPGdTM=
Date:   Thu, 23 Apr 2020 22:23:05 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        =?iso-8859-1?Q?Lu=EDs?= Mendes <luis.p.mendes@gmail.com>,
        Todd Poynor <toddpoynor@google.com>
Subject: Re: [GIT PULL] PCI fixes for v5.7
Message-ID: <20200424032305.GA32366@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj7f3HJxmhP_SKQoFwuSx-OQgvp41pbgJN7TtspQj=RUA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 23, 2020 at 11:22:20AM -0700, Linus Torvalds wrote:
> On Thu, Apr 23, 2020 at 10:40 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> >   - Workaround Apex TPU class code issue that prevents resource
> >     assignment (Bjorn Helgaas)
> 
> Hmm.
> 
> I have no objections to that patch, but I do wonder if it might not be
> better to try to actually assign the resource at enable_resource time?
> 
> Put another way: if I read the situation correctly, what happened is
> that the hardware is broken and doesn't have the proper class code,
> and so the resource is not initially assigned at all. But then the
> driver matches on the device ID, and tries to use the device, and then
> we get into trouble at pci_enable_resources().

Exactly.

> But is there any reason we don't just at least try to do
> pci_assign_resource() at that point? Yeah, because we didn't do it at
> bus scanning, maybe there's no room for it, but that's what we do for
> the PCI ROM resources (which I think we also don't claim by default)
> when drivers ask to map them.

That might make sense, but I think we should be consistent with the
checking __dev_sort_resources() does, e.g., skipping
PCI_CLASS_NOT_DEFINED, or at least understand why it's safe to be
different.

> The pci/rom.c code does
> 
>         /* assign the ROM an address if it doesn't have one */
>         if (res->parent == NULL && pci_assign_resource(pdev, PCI_ROM_RESOURCE))
>                 return NULL;
> 
> could we perhaps do the same in enable_resource?
> 
> Your patch is obviously much better for an -rc kernel, so this is more
> of a longer-term "wouldn't it be less fragile to ..." query.
> 
> Alternatively, maybe we should do resource assignment even for
> PCI_CLASS_NOT_DEFINED?

Yeah.  I don't know the history of why we skip PCI_CLASS_NOT_DEFINED.
I did consider about the fact that we're skipping it, to make it
easier to debug next time.

PCI_CLASS_NOT_DEFINED is supposed to be for devices built before the
Class Code field was defined.  That note is at least as old as PCI 2.2
from 1998, so there shouldn't be *that* many of those devices left.

Bjorn

