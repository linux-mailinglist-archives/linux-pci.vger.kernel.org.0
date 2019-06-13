Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0C9244D4B
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2019 22:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729707AbfFMUVi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jun 2019 16:21:38 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33300 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbfFMUVi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Jun 2019 16:21:38 -0400
Received: by mail-ot1-f68.google.com with SMTP id p4so482313oti.0
        for <linux-pci@vger.kernel.org>; Thu, 13 Jun 2019 13:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8C1DPfN32M3hy89DclQbm10r/6nHw68ntXJVKpP7b9Y=;
        b=f8QwnyQT51rXgqH07uWM2kqXhbWRJNnV74LW/yRvR2x776SPj5Pfk2O+kG2AmGkO8T
         trYSPptgpa5/GXF/WDtITF1+EbHojK5NlrUWtkmk/zSrRfZi5l9VktyZN13ffa5Hc6Ev
         0msFAvfYWphm24CFoDY7wyxaucG4FVHRbGTisLD6oBUXsztdH3fUW9TN5VMHOpT3cvr0
         sCPmY0lNjqi+LcWw5XMhpewNnmhVYTSePA2WSDRkeUne9k6nQVV9YwwkLBcNkm4aAYQp
         hwiX33VeD0WOTvpFOoQcm71sdbaOX7SnxHZ9aM2nx+Itu4NnNsqFxSwSt5OwJVwaJq25
         COoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8C1DPfN32M3hy89DclQbm10r/6nHw68ntXJVKpP7b9Y=;
        b=qM3Q1R3msjx5EqeQQpD/68sReQcuxuMR/tb7FKo6oXNjFCTMnBdzhvYPFZWX2w5iTB
         4Ef89QZbyNEqaDm7YZD77t8G4YVd0PmXmmZCPNSJ7QI5qe8Kgf6iG/IggxHPIKs+kUTR
         +xFG2joai4o0LhcnZ6qMUx9xKQ3NIxL/y3sTXncwLAlWbRaI3wJZhnZIRujdEfowM5v4
         cQuT2Z1B1f1BmafSVKmFgdNw8a1GNO1OpN83NNjqnYtPooyRmv4GPBbRUfNuAfKScHGb
         +qiIyVYW9X+nRY7vq7WD1n1zju+pm8y2lqmmSmIVVuyc32xw8MYLdcf8t0vX84l0iXUG
         5xgg==
X-Gm-Message-State: APjAAAUXw17V6JLFpeEqJhB+fw1V0a0LCCr/j2nBA7+UD7kh+7KKJnT4
        7MZMH6HOJvhuYwM/IdE7sZnIoVL/iLNrcvYgL9Ns4g==
X-Google-Smtp-Source: APXvYqyjtP3QbVJvzI3dCCMhA8qeDJqydQ8D7TK+PF2b5eiWZzF3IhMkwvK4lONxsyfmaoM/M+8Dcj6PJdtpVy6CFmg=
X-Received: by 2002:a9d:7248:: with SMTP id a8mr1406727otk.363.1560457298006;
 Thu, 13 Jun 2019 13:21:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190613094326.24093-1-hch@lst.de> <CAPcyv4jBdwYaiVwkhy6kP78OBAs+vJme1UTm47dX4Eq_5=JgSg@mail.gmail.com>
 <283e87e8-20b6-0505-a19b-5d18e057f008@deltatee.com>
In-Reply-To: <283e87e8-20b6-0505-a19b-5d18e057f008@deltatee.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 13 Jun 2019 13:21:27 -0700
Message-ID: <CAPcyv4hx=ng3SxzAWd8s_8VtAfoiiWhiA5kodi9KPc=jGmnejg@mail.gmail.com>
Subject: Re: dev_pagemap related cleanups
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        nouveau@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, Linux MM <linux-mm@kvack.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>, linux-pci@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 13, 2019 at 1:18 PM Logan Gunthorpe <logang@deltatee.com> wrote=
:
>
>
>
> On 2019-06-13 12:27 p.m., Dan Williams wrote:
> > On Thu, Jun 13, 2019 at 2:43 AM Christoph Hellwig <hch@lst.de> wrote:
> >>
> >> Hi Dan, J=C3=A9r=C3=B4me and Jason,
> >>
> >> below is a series that cleans up the dev_pagemap interface so that
> >> it is more easily usable, which removes the need to wrap it in hmm
> >> and thus allowing to kill a lot of code
> >>
> >> Diffstat:
> >>
> >>  22 files changed, 245 insertions(+), 802 deletions(-)
> >
> > Hooray!
> >
> >> Git tree:
> >>
> >>     git://git.infradead.org/users/hch/misc.git hmm-devmem-cleanup
> >
> > I just realized this collides with the dev_pagemap release rework in
> > Andrew's tree (commit ids below are from next.git and are not stable)
> >
> > 4422ee8476f0 mm/devm_memremap_pages: fix final page put race
> > 771f0714d0dc PCI/P2PDMA: track pgmap references per resource, not globa=
lly
> > af37085de906 lib/genalloc: introduce chunk owners
> > e0047ff8aa77 PCI/P2PDMA: fix the gen_pool_add_virt() failure path
> > 0315d47d6ae9 mm/devm_memremap_pages: introduce devm_memunmap_pages
> > 216475c7eaa8 drivers/base/devres: introduce devm_release_action()
> >
> > CONFLICT (content): Merge conflict in tools/testing/nvdimm/test/iomap.c
> > CONFLICT (content): Merge conflict in mm/hmm.c
> > CONFLICT (content): Merge conflict in kernel/memremap.c
> > CONFLICT (content): Merge conflict in include/linux/memremap.h
> > CONFLICT (content): Merge conflict in drivers/pci/p2pdma.c
> > CONFLICT (content): Merge conflict in drivers/nvdimm/pmem.c
> > CONFLICT (content): Merge conflict in drivers/dax/device.c
> > CONFLICT (content): Merge conflict in drivers/dax/dax-private.h
> >
> > Perhaps we should pull those out and resend them through hmm.git?
>
> Hmm, I've been waiting for those patches to get in for a little while now=
 ;(

Unless Andrew was going to submit as v5.2-rc fixes I think I should
rebase / submit them on current hmm.git and then throw these cleanups
from Christoph on top?
