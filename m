Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81733286F77
	for <lists+linux-pci@lfdr.de>; Thu,  8 Oct 2020 09:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbgJHHbu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Oct 2020 03:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbgJHHbu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Oct 2020 03:31:50 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3028C0613D2
        for <linux-pci@vger.kernel.org>; Thu,  8 Oct 2020 00:31:49 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id m7so5399201oie.0
        for <linux-pci@vger.kernel.org>; Thu, 08 Oct 2020 00:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ogkw1NmOSWleETzvxYwVZZIizSINMS0qQkiw0aowwRQ=;
        b=dAa4UrodoeKqvvGBic2n/ikfUtGXIrA84JDvhHoeTG0wQyvzwM6zRb58ASAp90bOAP
         Z0Gq9W2/rAIbo9tt/Rdw3PX+Bn1vOefBbbpajIIFIeMsYr0JsELM1frkf/Q6RzY+4q6w
         KwDjwJvmHbSV+DyPoGD+FRH2axWgRzr70NSco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ogkw1NmOSWleETzvxYwVZZIizSINMS0qQkiw0aowwRQ=;
        b=A8E0sHq6f2Qa0gCjT8h699QUA2jqJx5WrDaRBd27boasu1bm4XJdF5Sgso5oVU5XBM
         hQj0ONZx+lBGGlB7V6w+YGHRZHXpcREM/kJ72VcKru4wdqQTA3CeqteTLecbQKWL5mVX
         qWdWf/KgQWPpys8ysmPHAdApBh+qCkpKMWZaYZcDbLs3UYrQrktGlSaIYL1K682cCcFI
         Xq+foHjExExiaB4sA4zE+eViDVHjZIw17iBrZalQ86dQVLzfKDihF2lyjIE3iKiDBikO
         8ho/Eydp471l4ytsJu45XAMd4rFkUdyx2pXSyYqsdwS30LHKRoaV+/yDeWw++Ti8Ce6p
         yxhw==
X-Gm-Message-State: AOAM532vomKuI5kMw4CdY0Y84iifpQ+G8CbNYZWevy6LbQv95MDZx/Lt
        yxM22tJFou5wZjShUDmCZOeFAggE4m1d35+NqhztcQ==
X-Google-Smtp-Source: ABdhPJx491RwkFJI9puzs4morldhkHhy8TQN885mw0wtSqvJNbvAlJbcViFwT+IWX3hheU/oD67HmER0Hab3kMQkGCo=
X-Received: by 2002:aca:6083:: with SMTP id u125mr4379406oib.14.1602142309051;
 Thu, 08 Oct 2020 00:31:49 -0700 (PDT)
MIME-Version: 1.0
References: <20201007164426.1812530-1-daniel.vetter@ffwll.ch>
 <20201007164426.1812530-11-daniel.vetter@ffwll.ch> <CAPcyv4hBL68A7CZa+YnooufDH2tevoxrx32DTJMQ6OHRnec7QQ@mail.gmail.com>
 <20201007232448.GC5177@ziepe.ca>
In-Reply-To: <20201007232448.GC5177@ziepe.ca>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Thu, 8 Oct 2020 09:31:37 +0200
Message-ID: <CAKMK7uF6pdQScwcihBq+9BZ7bSrNXimi-ddN8w7zg2ANhSduWw@mail.gmail.com>
Subject: Re: [PATCH 10/13] PCI: revoke mappings like devmem
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        "Linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Jan Kara <jack@suse.cz>, Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 8, 2020 at 1:24 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Wed, Oct 07, 2020 at 12:33:06PM -0700, Dan Williams wrote:
> > On Wed, Oct 7, 2020 at 11:11 AM Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
> > >
> > > Since 3234ac664a87 ("/dev/mem: Revoke mappings when a driver claims
> > > the region") /dev/kmem zaps ptes when the kernel requests exclusive
> > > acccess to an iomem region. And with CONFIG_IO_STRICT_DEVMEM, this is
> > > the default for all driver uses.
> > >
> > > Except there's two more ways to access pci bars: sysfs and proc mmap
> > > support. Let's plug that hole.
> >
> > Ooh, yes, lets.
> >
> > >
> > > For revoke_devmem() to work we need to link our vma into the same
> > > address_space, with consistent vma->vm_pgoff. ->pgoff is already
> > > adjusted, because that's how (io_)remap_pfn_range works, but for the
> > > mapping we need to adjust vma->vm_file->f_mapping. Usually that's done
> > > at ->open time, but that's a bit tricky here with all the entry points
> > > and arch code. So instead create a fake file and adjust vma->vm_file.
> >
> > I don't think you want to share the devmem inode for this, this should
> > be based off the sysfs inode which I believe there is already only one
> > instance per resource. In contrast /dev/mem can have multiple inodes
> > because anyone can just mknod a new character device file, the same
> > problem does not exist for sysfs.
>
> The inode does not come from the filesystem char/mem.c creates a
> singular anon inode in devmem_init_inode()
>
> Seems OK to use this more widely, but it feels a bit weird to live in
> char/memory.c.
>
> This is what got me thinking maybe this needs to be a bit bigger
> generic infrastructure - eg enter this scheme from fops mmap and
> everything else is in mm/user_iomem.c

Yeah moving it to iomem and renaming it to have an iomem_prefix
instead of devmem sounds like a good idea.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
