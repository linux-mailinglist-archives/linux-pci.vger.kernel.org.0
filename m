Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56C884DB13
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2019 22:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbfFTUS3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jun 2019 16:18:29 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38790 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbfFTUS0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jun 2019 16:18:26 -0400
Received: by mail-ot1-f67.google.com with SMTP id d17so4032973oth.5
        for <linux-pci@vger.kernel.org>; Thu, 20 Jun 2019 13:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/1ACPvah6cwlc4NoiRokzPOQoMSdzU57I7vjUDE0u7s=;
        b=0EpvstXhVkgDZVnlntes/LFoX5DbZzZfI4fZKY04r9MHAG+jDljwalCR+pzVQcd5N+
         jCgyhrr3z4Vih61nMLUyzbi6vguWMjoCs1yxx/m+W0PmEJEir3NhOjhOIncQC8xeJlnA
         ScqRQG53Crt+W9L4aXkuF/pOTp6b6HcbioEWgVQ0Wdd8ra6AaL+LteJRGmJeMFvabjaQ
         FrxPttS8gc75CExD+3TgsHNERiQopSJetDSK5cOZIibVeewsYrEdl3fG1sHBqc0jfOZ8
         KAFi8QIcJEtIjVvj0Knw5iTcv8ArOmARLOERSJ98/s/7kGp4XUBuQ9hyjg2QbAGOBYHJ
         8+Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/1ACPvah6cwlc4NoiRokzPOQoMSdzU57I7vjUDE0u7s=;
        b=Wn507xp60o1AnWiUQ5SyH+6ZY7YPzJI9uU/7qvQkBymG1O831eoSdu3V/yQm3eKx7Z
         MledI+srFpZSce/6En2pKZapvjADer+aEn2qyBcxgtjRedx0fS+xxT4q5mqG8JNps/jQ
         q/DFEm3vMh24jxNmqHwkTdMsNWkMBUROgF8agilxqxEfyPCfLd9dRwitYo8QzxKi6aAz
         LETioE5m84aeITAwMKhxA4dsazz5vHlkjAzXt6iA1Y7A85Al+p/2W16DN087EKd1Id5K
         kAnZ9zoGK2EzLtfCGRMzx5//QTAmVPBtrbJyRscFsznZLxYfIc5PmHztl8h8KtS/CtlX
         wMIg==
X-Gm-Message-State: APjAAAVOC7gD5CfJdxVjixsKgeRJkPRWSoDJFWA/sCjWdf9kjRNPSlsY
        HWZmuSGzfNh78yhaODYAtm4kDu8A0JNBOiHhT0dsPA==
X-Google-Smtp-Source: APXvYqyamVcYjA+tR+olDR6UwLLdjY5DvyoCREZvBR4JUnDzN9QbxbjICVUWXIInA4FtacuQ6q6CVYes9j/gU6KU7Aw=
X-Received: by 2002:a9d:470d:: with SMTP id a13mr40714284otf.126.1561061905657;
 Thu, 20 Jun 2019 13:18:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190620161240.22738-1-logang@deltatee.com> <CAPcyv4ijztOK1FUjLuFing7ps4LOHt=6z=eO=98HHWauHA+yog@mail.gmail.com>
 <20190620193353.GF19891@ziepe.ca>
In-Reply-To: <20190620193353.GF19891@ziepe.ca>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 20 Jun 2019 13:18:13 -0700
Message-ID: <CAPcyv4jyNRBvtWhr9+aHbzWP6=D4qAME+=hWMtOYJ17BVHdy2w@mail.gmail.com>
Subject: Re: [RFC PATCH 00/28] Removing struct page from P2PDMA
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-rdma <linux-rdma@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>,
        Stephen Bates <sbates@raithlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 20, 2019 at 12:34 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Thu, Jun 20, 2019 at 11:45:38AM -0700, Dan Williams wrote:
>
> > > Previously, there have been multiple attempts[1][2] to replace
> > > struct page usage with pfn_t but this has been unpopular seeing
> > > it creates dangerous edge cases where unsuspecting code might
> > > run accross pfn_t's they are not ready for.
> >
> > That's not the conclusion I arrived at because pfn_t is specifically
> > an opaque type precisely to force "unsuspecting" code to throw
> > compiler assertions. Instead pfn_t was dealt its death blow here:
> >
> > https://lore.kernel.org/lkml/CA+55aFzON9617c2_Amep0ngLq91kfrPiSccdZakxir82iekUiA@mail.gmail.com/
> >
> > ...and I think that feedback also reads on this proposal.
>
> I read through Linus's remarks and it he seems completely right that
> anything that touches a filesystem needs a struct page, because FS's
> rely heavily on that.
>
> It is much less clear to me why a GPU BAR or a NVME CMB that never
> touches a filesystem needs a struct page.. The best reason I've seen
> is that it must have struct page because the block layer heavily
> depends on struct page.
>
> Since that thread was so DAX/pmem centric (and Linus did say he liked
> the __pfn_t), maybe it is worth checking again, but not for DAX/pmem
> users?
>
> This P2P is quite distinct from DAX as the struct page* would point to
> non-cacheable weird memory that few struct page users would even be
> able to work with, while I understand DAX use cases focused on CPU
> cache coherent memory, and filesystem involvement.

What I'm poking at is whether this block layer capability can pick up
users outside of RDMA, more on this below...

>
> > My primary concern with this is that ascribes a level of generality
> > that just isn't there for peer-to-peer dma operations. "Peer"
> > addresses are not "DMA" addresses, and the rules about what can and
> > can't do peer-DMA are not generically known to the block layer.
>
> ?? The P2P infrastructure produces a DMA bus address for the
> initiating device that is is absolutely a DMA address. There is some
> intermediate CPU centric representation, but after mapping it is the
> same as any other DMA bus address.

Right, this goes back to the confusion caused by the hardware / bus /
address that a dma-engine would consume directly, and Linux "DMA"
address as a device-specific translation of host memory.

Is the block layer representation of this address going to go through
a peer / "bus" address translation when it reaches the RDMA driver? In
other words if we tried to use this facility with other drivers how
would the driver know it was passed a traditional Linux DMA address,
vs a peer bus address that the device may not be able to handle?

> The map function can tell if the device pair combination can do p2p or
> not.

Ok, if this map step is still there then reduce a significant portion
of my concern and it becomes a quibble about the naming and how a
non-RDMA device driver might figure out if it was handled an address
it can't handle.

>
> > Again, what are the benefits of plumbing this RDMA special case?
>
> It is not just RDMA, this is interesting for GPU and vfio use cases
> too. RDMA is just the most complete in-tree user we have today.
>
> ie GPU people wouuld really like to do read() and have P2P
> transparently happen to on-GPU pages. With GPUs having huge amounts of
> memory loading file data into them is really a performance critical
> thing.

A direct-i/o read(2) into a page-less GPU mapping? Through a regular
file or a device special file?
