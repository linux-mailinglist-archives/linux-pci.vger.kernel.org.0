Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE65C3945FE
	for <lists+linux-pci@lfdr.de>; Fri, 28 May 2021 18:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235043AbhE1QoM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 May 2021 12:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235662AbhE1QoL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 May 2021 12:44:11 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852A8C061574
        for <linux-pci@vger.kernel.org>; Fri, 28 May 2021 09:42:32 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id v13-20020a17090abb8db029015f9f7d7290so7545897pjr.0
        for <linux-pci@vger.kernel.org>; Fri, 28 May 2021 09:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C2jxe27zNoikjjbuJFgKZe+oxQrU6V9q0/3tiGab1dQ=;
        b=Z7LJAW3HwBGZGVULTqzc95f55mS7lTbDD5P856wnr5M8VgCLeUOHJedidD0RsjUVSd
         lrx3M3IVNfjyL4Na0UPY5y2gKWJgP64KnJ3/juVZ2ZIyWOW/2/EjMM5Lw6UBkTNG3s96
         mpPWyQs9CkOvYl79O5RSJX6Y0halSMnyQEktwTXjddaCgsBI5Y26MVfK+6YQXg43z7zb
         D7+eSgL6BxFHzRvi3zCRGDhdKezYxjaMUpFJ67Ay8Mlg7Ba33RTxKTHIEYBuGKZAjgrL
         ZUNNnHc2Jyx9n/4jQh2d4bR0iQTHEsmMbAex8Wv37RurVq/EnQNjMMQDaUNm1n/NqVGD
         kN7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C2jxe27zNoikjjbuJFgKZe+oxQrU6V9q0/3tiGab1dQ=;
        b=jNvU7YdIpcu/2Z+9FJNzeZr+NUnaPEs3/D8bQLWGK9m6STOWbrYkC02Bs/WBzOJXxt
         w8NiIoultLQ0URZtu5r0gRePBpdAWIYhcKmK+0hwmrq+p3fS9uzbTNghUSmCzdIF5esi
         Xe7lhbjRbj1sUVHg6lkO9VAYugZ6qrjaWDK+0vK1rKFlOv17jPlrN7pKSABkrh8P+mfy
         FtFAbo8pIQIN3GeBlbQEKlUJbfU1UrxRYBOaBetPqzJSiVnm+fUZq7qAMwtlAVFpBYDd
         U8S7XufzGrCAqCzB+bF219x4xgaWFNIMjjsdid/0pyNSSLqnQpfuORbfs7yBZyNmYo/h
         8XyA==
X-Gm-Message-State: AOAM532OJqRGTUTGoQOyqOYqkiLquIyozSwZMv1gduKh313I3Gp6Swyv
        ytYptsWvg0Behxs1U9c9GfzeFsB6AA/z0c4jHPhX9w==
X-Google-Smtp-Source: ABdhPJxOUA/H3NRekn2/HiHu+yqiL4sP/RYDoJwpkpiTsVjbUIZYCa2U9/oziH6gWZNEyjQE244y6Fj57/4ixJ1YzYg=
X-Received: by 2002:a17:902:8203:b029:101:26a8:764d with SMTP id
 x3-20020a1709028203b029010126a8764dmr3202057pln.79.1622220151953; Fri, 28 May
 2021 09:42:31 -0700 (PDT)
MIME-Version: 1.0
References: <159009507306.847224.8502634072429766747.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20210527205845.GA1421476@bjorn-Precision-5520> <CAPcyv4j-ygPddjuZqq8PMvsN-E8rJQszc+WuUu1MBXVXiQZddg@mail.gmail.com>
 <7eaf4c10-292e-18d7-e8ce-3a6b72122381@redhat.com>
In-Reply-To: <7eaf4c10-292e-18d7-e8ce-3a6b72122381@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 28 May 2021 09:42:20 -0700
Message-ID: <CAPcyv4hjyMuvy3fNy8gdqWT6VSJA+U70x__q=Q89cLeJnHkj4Q@mail.gmail.com>
Subject: Re: [PATCH v4] /dev/mem: Revoke mappings when a driver claims the region
To:     David Hildenbrand <david@redhat.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Russell King <linux@arm.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 28, 2021 at 1:58 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 27.05.21 23:30, Dan Williams wrote:
> > On Thu, May 27, 2021 at 1:58 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >>
> >> [+cc Daniel, Krzysztof, Jason, Christoph, linux-pci]
> >>
> >> On Thu, May 21, 2020 at 02:06:17PM -0700, Dan Williams wrote:
> >>> Close the hole of holding a mapping over kernel driver takeover event of
> >>> a given address range.
> >>>
> >>> Commit 90a545e98126 ("restrict /dev/mem to idle io memory ranges")
> >>> introduced CONFIG_IO_STRICT_DEVMEM with the goal of protecting the
> >>> kernel against scenarios where a /dev/mem user tramples memory that a
> >>> kernel driver owns. However, this protection only prevents *new* read(),
> >>> write() and mmap() requests. Established mappings prior to the driver
> >>> calling request_mem_region() are left alone.
> >>>
> >>> Especially with persistent memory, and the core kernel metadata that is
> >>> stored there, there are plentiful scenarios for a /dev/mem user to
> >>> violate the expectations of the driver and cause amplified damage.
> >>>
> >>> Teach request_mem_region() to find and shoot down active /dev/mem
> >>> mappings that it believes it has successfully claimed for the exclusive
> >>> use of the driver. Effectively a driver call to request_mem_region()
> >>> becomes a hole-punch on the /dev/mem device.
> >>
> >> This idea of hole-punching /dev/mem has since been extended to PCI
> >> BARs via [1].
> >>
> >> Correct me if I'm wrong: I think this means that if a user process has
> >> mmapped a PCI BAR via sysfs, and a kernel driver subsequently requests
> >> that region via pci_request_region() or similar, we punch holes in the
> >> the user process mmap.  The driver might be happy, but my guess is the
> >> user starts seeing segmentation violations for no obvious reason and
> >> is not happy.
> >>
> >> Apart from the user process issue, the implementation of [1] is
> >> problematic for PCI because the mmappable sysfs attributes now depend
> >> on iomem_init_inode(), an fs_initcall, which means they can't be
> >> static attributes, which ultimately leads to races in creating them.
> >
> > See the comments in iomem_get_mapping(), and revoke_iomem():
> >
> >          /*
> >           * Check that the initialization has completed. Losing the race
> >           * is ok because it means drivers are claiming resources before
> >           * the fs_initcall level of init and prevent iomem_get_mapping users
> >           * from establishing mappings.
> >           */
> >
> > ...the observation being that it is ok for the revocation inode to
> > come on later in the boot process because userspace won't be able to
> > use the fs yet. So any missed calls to revoke_iomem() would fall back
> > to userspace just seeing the resource busy in the first instance. I.e.
> > through the normal devmem_is_allowed() exclusion.
> >
> >>
> >> So I'm raising the question of whether this hole-punch is the right
> >> strategy.
> >>
> >>    - Prior to revoke_iomem(), __request_region() was very
> >>      self-contained and really only depended on the resource tree.  Now
> >>      it depends on a lot of higher-level MM machinery to shoot down
> >>      mappings of other tasks.  This adds quite a bit of complexity and
> >>      some new ordering constraints.
> >>
> >>    - Punching holes in the address space of an existing process seems
> >>      unfriendly.  Maybe the driver's __request_region() should fail
> >>      instead, since the driver should be prepared to handle failure
> >>      there anyway.
> >
> > It's prepared to handle failure, but in this case it is dealing with a
> > root user of 2 minds.
> >
> >>
> >>    - [2] suggests that the hole punch protects drivers from /dev/mem
> >>      writers, especially with persistent memory.  I'm not really
> >>      convinced.  The hole punch does nothing to prevent a user process
> >>      from mmapping and corrupting something before the driver loads.
> >
> > The motivation for this was a case that was swapping between /dev/mem
> > access and /dev/pmem0 access and they forgot to stop using /dev/mem
> > when they switched to /dev/pmem0. If root wants to use /dev/mem it can
> > use it, if root wants to stop the driver from loading it can set
> > mopdrobe policy or manually unbind, and if root asks the kernel to
> > load the driver while it is actively using /dev/mem something has to
> > give. Given root has other options to stop a driver the decision to
> > revoke userspace access when root messes up and causes a collision
> > seems prudent to me.
> >
>
> Is there a real use case for mapping pmem via /dev/mem or could we just
> prohibit the access to these areas completely?

The kernel offers conflicting access to iomem resources and a
long-standing mechanism to enforce mutual exclusion
(CONFIG_IO_STRICT_DEVMEM) between those interfaces. That mechanism was
found to be incomplete for the case where a /dev/mem mapping is
maintained after a kernel driver is attached, and incomplete for other
mechanisms to map iomem like pci-sysfs. This was found with PMEM, but
the issue is larger and applies to userspace drivers / debug in
general.

> What's the use case for "swapping between /dev/mem access and /dev/pmem0
> access" ?

"Who knows". I mean, I know in this case it was a platform validation
test using /dev/mem for "reasons", but I am not sure that is relevant
to the wider concern. If CONFIG_IO_STRICT_DEVMEM=n exclusion is
enforced when drivers pass the IORESOURCE_EXCLUSIVE flag, if
CONFIG_IO_STRICT_DEVMEM=y exclusion is enforced whenever the kernel
marks a resource IORESOURCE_BUSY, and if kernel lockdown is enabled
the driver state is moot as LOCKDOWN_DEV_MEM and LOCKDOWN_PCI_ACCESS
policy is in effect.
