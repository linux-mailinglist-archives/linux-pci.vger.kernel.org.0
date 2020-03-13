Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 058D2184F2D
	for <lists+linux-pci@lfdr.de>; Fri, 13 Mar 2020 20:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgCMTN2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Mar 2020 15:13:28 -0400
Received: from mail-qv1-f66.google.com ([209.85.219.66]:41850 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbgCMTN2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Mar 2020 15:13:28 -0400
Received: by mail-qv1-f66.google.com with SMTP id a10so5208545qvq.8
        for <linux-pci@vger.kernel.org>; Fri, 13 Mar 2020 12:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PPCktG6nEvhXmf9moRkI6GaBpVzb4qfjuLIfr4oX24U=;
        b=oMwn2l4h8Tx8PfqTSSs7jcFo6p6SGfbk2paFxxCwDo4UjReV48Ea0WeynOCfP0UESg
         D5Wx42yUB6XE+ECNQi7oshT1K/ITK0SF6QPuBytfQjClq48PdGDZYZkEX2mV44jsJSIZ
         JmfVZzlPCGi2MhuzvTGwSFBdDoRlPsRM31IIJc35bnTCaDgjPvUbOxtPlMnxXel6a7FY
         S2aBIZ8kX+EntSYh+k5ozLPfkAcPFTOlfbRQwTdgkhhTV0n44gq50oUncZS8eLjHICPI
         cRSxnBCKNdjtgvnQfhAC9bltqGz7vdFDc4E/CspLPEX7CV9xxZf3RANkXlRVD60eUYDj
         pyIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PPCktG6nEvhXmf9moRkI6GaBpVzb4qfjuLIfr4oX24U=;
        b=c/GfqPH35/f65niEZpv4zASJ+1H+4YNgwV1gYlkXDdpOm47RWIoy+BlArRm+LUAqh4
         u8E2swKKu9Dfz1JsWsAWogNTSIVI/NGnjFY6CKH+/wwRNHZ3CfINhTA04hBv6chUVWYV
         t/OwIQVWeIbwmfFi92tZTpLmtmH6T4Na38yLyn6sfCroBPfYaOSVT9EsBxG9pygKE2/m
         daGWaLbmNXZrm3td1CXZWu/nK+BkkL2bSMTrT6BTKF6au1JOb93rwe87AUcNwu+KIXMt
         1b4h0OFmqXq7pcSP2MbF26f5ktfYHVWUNo8YAKq3ZOT30YJL+ooRx8m6dxCBMX/V1JTg
         ecSQ==
X-Gm-Message-State: ANhLgQ3o3yfrM+Ce2rd69oWKUU3qFU0msniAU9cBPwgMiljjFrLOt3uI
        A78Vu41X50yBGl29jmXhaY01+Q==
X-Google-Smtp-Source: ADFU+vutgg3YrWNjonghOGBQTDVm29PBDy/u3g+sX5DbKZ/TP9j/X7cNOJItzK6P4dCcACQHzOv8kg==
X-Received: by 2002:ad4:458d:: with SMTP id x13mr13168915qvu.155.1584126806856;
        Fri, 13 Mar 2020 12:13:26 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id b10sm9121866qto.60.2020.03.13.12.13.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Mar 2020 12:13:26 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jCpkK-000463-VD; Fri, 13 Mar 2020 16:13:24 -0300
Date:   Fri, 13 Mar 2020 16:13:24 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     mark.rutland@arm.com, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, will@kernel.org,
        Dimitri Sivanich <sivanich@sgi.com>, catalin.marinas@arm.com,
        zhangfei.gao@linaro.org, devicetree@vger.kernel.org,
        kevin.tian@intel.com, Arnd Bergmann <arnd@arndb.de>,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        iommu@lists.linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        robin.murphy@arm.com, christian.koenig@amd.com
Subject: Re: [PATCH v4 01/26] mm/mmu_notifiers: pass private data down to
 alloc_notifier()
Message-ID: <20200313191324.GG31668@ziepe.ca>
References: <20200228144844.GQ31668@ziepe.ca>
 <20200228150427.GF2156@myrica>
 <20200228151339.GS31668@ziepe.ca>
 <20200306095614.GA50020@myrica>
 <20200306130919.GJ31668@ziepe.ca>
 <20200306143556.GA99609@myrica>
 <20200306145245.GK31668@ziepe.ca>
 <20200306161519.GB99609@myrica>
 <20200306174239.GM31668@ziepe.ca>
 <20200313184929.GC2574@myrica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313184929.GC2574@myrica>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 13, 2020 at 07:49:29PM +0100, Jean-Philippe Brucker wrote:
> On Fri, Mar 06, 2020 at 01:42:39PM -0400, Jason Gunthorpe wrote:
> > On Fri, Mar 06, 2020 at 05:15:19PM +0100, Jean-Philippe Brucker wrote:
> > > On Fri, Mar 06, 2020 at 10:52:45AM -0400, Jason Gunthorpe wrote:
> > > > On Fri, Mar 06, 2020 at 03:35:56PM +0100, Jean-Philippe Brucker wrote:
> > > > > On Fri, Mar 06, 2020 at 09:09:19AM -0400, Jason Gunthorpe wrote:
> > > > > > On Fri, Mar 06, 2020 at 10:56:14AM +0100, Jean-Philippe Brucker wrote:
> > > > > > > I tried to keep it simple like that: normally mmu_notifier_get() is called
> > > > > > > in bind(), and mmu_notifier_put() is called in unbind(). 
> > > > > > > 
> > > > > > > Multiple device drivers may call bind() with the same mm. Each bind()
> > > > > > > calls mmu_notifier_get(), obtains the same io_mm, and returns a new bond
> > > > > > > (a device<->mm link). Each bond is freed by calling unbind(), which calls
> > > > > > > mmu_notifier_put().
> > > > > > > 
> > > > > > > That's the most common case. Now if the process is killed and the mm
> > > > > > > disappears, we do need to avoid use-after-free caused by DMA of the
> > > > > > > mappings and the page tables. 
> > > > > > 
> > > > > > This is why release must do invalidate all - but it doesn't need to do
> > > > > > any more - as no SPTE can be established without a mmget() - and
> > > > > > mmget() is no longer possible past release.
> > > > > 
> > > > > In our case we don't have SPTEs, the whole pgd is shared between MMU and
> > > > > IOMMU (isolated using PASID tables).
> > > > 
> > > > Okay, but this just means that 'invalidate all' also requires
> > > > switching the PASID to use some pgd that is permanently 'all fail'.
> > > > 
> > > > > At this point no one told the device to stop working on this queue,
> > > > > it may still be doing DMA on this address space.
> > > > 
> > > > Sure, but there are lots of cases where a defective user space can
> > > > cause pages under active DMA to disappear, like munmap for
> > > > instance. Process exit is really no different, the PASID should take
> > > > errors and the device & driver should do whatever error flow it has.
> > > 
> > > We do have the possibility to shut things down in order, so to me this
> > > feels like a band-aid. 
> > 
> > ->release() is called by exit_mmap which is called by mmput. There are
> > over a 100 callsites to mmput() and I'm not totally sure what the
> > rules are for release(). We've run into problems before with things
> > like this.
> 
> A concrete example of something that could go badly if mmput() takes too
> long would greatly help. Otherwise I'll have a hard time justifying the
> added complexity.

It is not just takes too long, but also accidently causing locking
problems by doing very complex code in the release callback. Unless
you audit all the mmput call sites to define the calling conditions I
can't even say what the risk is here. 

Particularly, calling something with impossible to audit locking like
the dma_fence stuff from release is probably impossible to prove
safety and then keep safe.

It is easy enough to see where takes too long can have a bad impact,
mmput is called all over the place. Just in the RDMA code slowing it
down would block ODP page faulting completely for all processes.
This is not acceptable.

For this reason release callbacks must be simple/fast and must have
trivial locking.

> > Errors should not be printed to the kernel log for PASID cases
> > anyhow. PASID will be used by unpriv user, and unpriv user should not
> > be able to trigger kernel prints at will, eg by doing dma to nmap VA
> > or whatever. 
> 
> I agree. There is a difference, though, between invalid mappings and the
> absence of a pgd. The former comes from userspace issuing DMA on unmapped
> buffers, while the latter is typically a device/driver error which
> normally needs to be reported.

Why not make the pgd present as I suggested? Point it at a static
dummy pgd that always fails to page fault during release? Make the pgd
not present only once the PASID is fully destroyed.

That really is the only thing release is supposed to mean -> unmap all
VAs.

Jason
