Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9080402CF8
	for <lists+linux-pci@lfdr.de>; Tue,  7 Sep 2021 18:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344420AbhIGQjp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Sep 2021 12:39:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:53908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344478AbhIGQjp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 7 Sep 2021 12:39:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D418760E77;
        Tue,  7 Sep 2021 16:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631032719;
        bh=kM4x6R7FRoHUCOnGXVz/Y0FnaHvMZjmGIfLn42Hpaso=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=kgIy3BUhv2UT6NbQOChJDvdO/ddqyb+6TdoPWIQSGyG0EZbk/qLuWzTimoMpC+HH5
         bwX+/ZfHBVLxuGEChqx5IyxN0z46QnZOPUp0zMXmb0lpcl062y0vMY+JXDu48u3XCx
         0wd2ByqQdRofvst0nS4V54iGJnDo1Es/FBimcg/RmdCrHGULjBs2TexrBHb7prHuCl
         RjtZGpzzbLyiQNYxTeWFm6kyFImNgbTk60ye10VyP3P+pcpI+/LKQCYbSnB4Uujxef
         X0ABVPjXHtLiE3QFE0p7R5MJimNBUekSXsZduzlGc5FfYHtSGdHkH/nxec/lHTrRHM
         OpweP7+y/xQIw==
Date:   Tue, 7 Sep 2021 11:38:37 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jan Beulich <jbeulich@suse.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 10/12] xen-pcifront: this module is PV-only
Message-ID: <20210907163837.GA747361@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82a99bb4-85bd-61cc-85de-f8dd9d1f98ed@suse.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 07, 2021 at 06:14:16PM +0200, Jan Beulich wrote:
> On 07.09.2021 17:30, Bjorn Helgaas wrote:
> > Update subject to follow conventions (use "git log --oneline
> > drivers/pci/Kconfig").  Should say what this patch does.
> 
> I can change that; I don't think it'll carry any different information.

It might not be different information, but if you use the same
sentence structure and formatting as all the other subject lines,
they're easier to read as a group.

> > Commit log below should also say what this patch does.  Currently it's
> > part of the rationale for the change, but doesn't say what the patch
> > does.
> 
> "There's no point building ..." to me is as good as "Don't build ...".
> But oh well, I can adjust ...
> 
> > On Tue, Sep 07, 2021 at 02:10:41PM +0200, Jan Beulich wrote:
> >> It's module init function does a xen_pv_domain() check first thing.
> >> Hence there's no point building it in non-PV configurations.
> > 
> > s/It's/<name of function that calls xen_pv_domain()/   # pcifront_init()?
> 
> I don't understand this - how is "module init function" not clear
> enough?

Saying "module init function" makes the reader do extra work to
figure out what function you are referring to.  I had to look
at drivers/pci/Makefile to find the module name, then look at
drivers/pci/xen-pcifront.c to look for the init function.
Saying pcifront_init() makes it trivial to look *there*.

> > s/building it/building <name of module>/               # xen-pcifront.o?
> 
> The driver name is already part of the subject; I didn't think I
> need to repeat that one here.

Why be vague when it's so easy to be explicit and save everybody else
the effort?  Part of the disconnect here is that the subject line is
not *part* of the commit log, so the commit log should make sense even
if you can't see the subject line.  It's like an essay that should
make sense without its title.

Most of this *is* trivial, I agree.  Just minor hiccups in the process
of reading.

> > I see that CONFIG_XEN_PV is only mentioned in arch/x86, so
> > CONFIG_XEN_PV=y cannot be set on other arches.  Is the current
> > "depends on X86" just a reflection of that, or is it because of some
> > other x86 dependency in the code?
> > 
> > The connection between xen_pv_domain() and CONFIG_XEN_PV is not
> > completely obvious.
> > 
> > If you only build xen-pcifront.o when CONFIG_XEN_PV=y, and
> > xen_pv_domain() is true if and only if CONFIG_XEN_PV=y, why bother
> > calling xen_pv_domain() at all?
> 
> Because XEN_PV=y only _enables_ the kernel to run in PV mode. It
> may be enabled to also run in HVM and/or PVH modes. And it may
> then _run_ in any of the enabled modes. IOW xen_pv_domain() will
> always return false when !XEN_PV; no other implication is valid.
> I don't think this basic concept needs explaining in a simple
> patch like this. Instead I think the config option in question,
> despite living in drivers/pci/Kconfig, should be under "XEN
> HYPERVISOR INTERFACE" maintainership. I realize that's not even
> expressable in ./MAINTAINERS. I wonder why the option was put
> there in the first place, rather than in drivers/xen/Kconfig.

No doubt it's obvious to Xen experts.  Unfortunately I am not one.

Evidently there's no real dependency on the X86 arch, which makes me
wonder why the "depends on X86" was there in the first place.

Bjorn
