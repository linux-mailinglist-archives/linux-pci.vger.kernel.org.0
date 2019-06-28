Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0A295A4D3
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jun 2019 21:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbfF1TJi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Jun 2019 15:09:38 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41383 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726931AbfF1TJi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Jun 2019 15:09:38 -0400
Received: by mail-pl1-f196.google.com with SMTP id m7so3735169pls.8
        for <linux-pci@vger.kernel.org>; Fri, 28 Jun 2019 12:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=V6v+ChBPjDEkXeOyVL5WvJjC6m+aI/H7zTWv+Pb4ySg=;
        b=ApiOTl2ueSukYFkNah+vjl4vAZhsxgdyJZ8GrApbUEHrL2ifv9zSROVGfq52Y1UHv3
         jYH9POnFQ9yngjkv85OxF/I8nZeG5jD5N8uRS5l/zb+IqKwuhJg/5vMXa02pMvXuOsz3
         HYQ+xUuy27yxIlFhLsVFlMKlZLJZc94cLwpg/yeqydRHEGGVDt64rtPn82MK03shusAr
         m/TrdHQQ3aV6n6Vv+9bS2cn7+Uka0KOu++iK+9dh2XdTRy5tLMzGSOFDxjJp6yn2agbI
         ln7WGR3VdDUrbjU8q8uQacYahDvy3e3E1eFzr8b1eY415IHxqTLqpwkOgcDugYjeH+i7
         +sHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=V6v+ChBPjDEkXeOyVL5WvJjC6m+aI/H7zTWv+Pb4ySg=;
        b=Yh/8wRdM3fhyPZ8f7TNpdp3aXXJ/B8LxpRcctqAISE3UoAZQDWPC8YJWytL8eG/3u/
         xp1XTYH9hUV2fFLs4eLclwU5kPhCIhpluQ336tNKzf24XO6vkcFCc6Ij9OydIaU8vbkj
         +gcwWnQypvf6VietXVvgf3mGKQyVsgqTkqZBX/KQ1e82IhB1K3Ihmej7pzxXkt9YLZFP
         FGz0HAd+0L2tRF7brlKS0RHvvBmpB85z9lvK/laQoeNskaLXbtzlK3dRU6mqirxrZbky
         K/oswOVu9xyowxl9ieaj4zTiE9g1UufhypJSnxinMPj6mr6cRTV3ia5nyJQYqfoqm9Ao
         h1fg==
X-Gm-Message-State: APjAAAUPp2fmk1YL50QXXBCVJNYqntYJaweU+G7YaTHDnw0tHUVag4VL
        prpuY4MaDbg+q7bwnzZv6Hqzyw==
X-Google-Smtp-Source: APXvYqwFQy/tc32tInYqRQ3bQI7rptoLYbxDx6uCGkLXXCzcIjRb+a+mrA3L2cQ2IbpjP7BiMBXHuw==
X-Received: by 2002:a17:902:f089:: with SMTP id go9mr13409423plb.81.1561748977536;
        Fri, 28 Jun 2019 12:09:37 -0700 (PDT)
Received: from ziepe.ca ([216.9.110.14])
        by smtp.gmail.com with ESMTPSA id r88sm2982578pjb.8.2019.06.28.12.09.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Jun 2019 12:09:36 -0700 (PDT)
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hgwFX-0004Gx-D3; Fri, 28 Jun 2019 16:09:31 -0300
Date:   Fri, 28 Jun 2019 16:09:31 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [RFC PATCH 00/28] Removing struct page from P2PDMA
Message-ID: <20190628190931.GC3877@ziepe.ca>
References: <20190626210018.GB6392@ziepe.ca>
 <c25d3333-dcd5-3313-089b-7fbbd6fbd876@deltatee.com>
 <20190627063223.GA7736@ziepe.ca>
 <6afe4027-26c8-df4e-65ce-49df07dec54d@deltatee.com>
 <20190627163504.GB9568@ziepe.ca>
 <4894142c-3233-a3bb-f9a3-4a4985136e9b@deltatee.com>
 <20190628045705.GD3705@ziepe.ca>
 <8022a2a4-4069-d256-11da-e6d9b2ffbf60@deltatee.com>
 <20190628172926.GA3877@ziepe.ca>
 <25a87c72-630b-e1f1-c858-9c8b417506fc@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25a87c72-630b-e1f1-c858-9c8b417506fc@deltatee.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 28, 2019 at 12:29:32PM -0600, Logan Gunthorpe wrote:
> 
> 
> On 2019-06-28 11:29 a.m., Jason Gunthorpe wrote:
> > On Fri, Jun 28, 2019 at 10:22:06AM -0600, Logan Gunthorpe wrote:
> > 
> >>> Why not?  If we have a 'bar info' structure that could have data
> >>> transfer op callbacks, infact, I think we might already have similar
> >>> callbacks for migrating to/from DEVICE_PRIVATE memory with DMA..
> >>
> >> Well it could, in theory be done, but It just seems wrong to setup and
> >> wait for more DMA requests while we are in mid-progress setting up
> >> another DMA request. Especially when the block layer has historically
> >> had issues with stack sizes. It's also possible you might have multiple
> >> bio_vec's that have to each do a migration and with a hook here they'd
> >> have to be done serially.
> > 
> > *shrug* this is just standard bounce buffering stuff...
> 
> I don't know of any "standard" bounce buffering stuff that uses random
> other device's DMA engines where appropriate.

IMHO, it is conceptually the same as memcpy.. And probably we will not
ever need such optimization in dma map. Other copy places might be
different at least we have the option.
 
> IMO the bouncing in the DMA layer isn't a desirable thing, it was a
> necessary addition to work around various legacy platform issues and
> have existing code still work correctly. 

Of course it is not desireable! But there are many situations where we
do not have the luxury to work around the HW limits in the caller, so
those callers either have to not do DMA or they have to open code
bounce buffering - both are wrong.

> > What I see as the question is how to layout the BIO. 
> > 
> > If we agree the bio should only have phys_addr_t then we need some
> > 'bar info' (ie at least the offset) in the dma map and some 'bar info'
> > (ie the DMA device) during the bio construciton.
> 
> Per my other email, it was phys_addr_t plus hints on how to map the
> memory (bus address, dma_map_resource, or regular). This requires
> exactly two flag bits in the bio_vec and no interval tree or hash table.
> I don't want to have to pass bar info, other hooks, or anything like
> that to the block layer.

This scheme makes the assumption that the dma mapping struct device is
all you need, and we never need to know the originating struct device
during dma map. This is clearly safe if the two devices are on the
same PCIe segment

However, I'd feel more comfortable about that assumption if we had
code to support the IOMMU case, and know for sure it doesn't require
more info :(

But I suppose it is also reasonable that only the IOMMU case would
have the expensive 'bar info' lookup or something.

Maybe you can hide these flags as some dma_map helper, then the
layering might be nicer:

  dma_map_set_bio_p2p_flags(bio, phys_addr, source dev, dest_dev) 

?

ie the choice of flag scheme to use is opaque to the DMA layer.

> > If we can spare 4-8 bits in the bio then I suggest a 'perfect hash
> > table'. Assign each registered P2P 'bar info' a small 4 bit id and
> > hash on that. It should be fast enough to not worry about the double
> > lookup.
> 
> This feels like it's just setting us up to run into nasty limits based
> on the number of bits we actually have. The number of bits in a bio_vec
> will always be a precious resource. If I have a server chassis that
> exist today with 24 NVMe devices, and each device has a CMB, I'm already
> using up 6 of those bits. Then we might have DEVICE_PRIVATE and other
> uses on top of that.

A hash is an alternative data structure to a interval tree that has
better scaling for small numbers of BARs, which I think is our
case.

Jason
