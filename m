Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B484317C4A8
	for <lists+linux-pci@lfdr.de>; Fri,  6 Mar 2020 18:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgCFRmn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Mar 2020 12:42:43 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37043 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbgCFRmn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Mar 2020 12:42:43 -0500
Received: by mail-qk1-f195.google.com with SMTP id y126so3093897qke.4
        for <linux-pci@vger.kernel.org>; Fri, 06 Mar 2020 09:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PxT02ryeWyx7p1SBqN6kTMwWdglwMPqc7wMiUtKckm8=;
        b=fceAxzqKtPxKpBdyBHvIYC/k/jeNtyEFzrsgn7TJvkxLs22sR9WiBM6453QdPTwvJ2
         93UYmt1Orc9z4jHue6YWkq4c44RthUiPb/T9rH7qfZN2eZY2Xq3DFtWCpEtWlaAber1f
         HTsaHpVQnQu0i950k23k9hzTJEjKD+BN7/Y/tDId6MCXM2Jq/oAfQ5infM5paw03g9Vz
         fDBMIkB8bceHTgGX1/Vpyp9g9uOcrHu05i9iMph/9UxfrLbjUIDtwqwEFe+QO0y6kUt5
         zKGrPWs4/zh+Z5lFrLMK9wdgK1uWKJWRJ5Z5s7FtAiUywEXkXWhLK89r07oF90jjf8ZV
         UsTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PxT02ryeWyx7p1SBqN6kTMwWdglwMPqc7wMiUtKckm8=;
        b=k6Wrcp4FB9qR/dJ+WzmuPkLBjZT2qTJ0jTcAaJ7aIJK3jO0nmccd16vdOnC8mJsLeA
         EGtLO8qkB4+Ggh3+ste5HBu4n0EI4iJzAwc2p0S2Aa5vrXVnQJyDKJhXDJszFkAJYIIm
         dN44VIQ978vO1OOGh+XmK3uGXGz31+aKicThl5u/DwhRW7Ev3T4D8okdPaJxYglPxp2Z
         AQPslidFAGZpMzUPapBb1U5Bmrlz+7DixDY5hcE9F/NEMwysteTUIvEu2MvYJWEhHlMf
         l7g+jKxVQW8hNiXwIGK7XI/Tr1zdHtwf1HV+959oT06Srb05In9HMTakgg6CE5G9a1sW
         A3MA==
X-Gm-Message-State: ANhLgQ0xTRjSM28njbywbgP68nDzX5HoQPLtUiuMKFCh3PHXsu9MiYkQ
        l9Lluyr6+wzvSOfYMd98nQBRsRzTjbfw1w==
X-Google-Smtp-Source: ADFU+vsWbhZAJApLkHJjK1rpJphwwDR2QESHx2duAJgFhBpEHJLxHbOgXJEEbadil5uHQfcoM+kVpg==
X-Received: by 2002:a37:a44a:: with SMTP id n71mr2362594qke.210.1583516560952;
        Fri, 06 Mar 2020 09:42:40 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id g15sm14342523qtq.71.2020.03.06.09.42.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Mar 2020 09:42:40 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jAGzf-00060f-N3; Fri, 06 Mar 2020 13:42:39 -0400
Date:   Fri, 6 Mar 2020 13:42:39 -0400
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
Message-ID: <20200306174239.GM31668@ziepe.ca>
References: <20200225140814.GW31668@ziepe.ca>
 <20200228143935.GA2156@myrica>
 <20200228144844.GQ31668@ziepe.ca>
 <20200228150427.GF2156@myrica>
 <20200228151339.GS31668@ziepe.ca>
 <20200306095614.GA50020@myrica>
 <20200306130919.GJ31668@ziepe.ca>
 <20200306143556.GA99609@myrica>
 <20200306145245.GK31668@ziepe.ca>
 <20200306161519.GB99609@myrica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200306161519.GB99609@myrica>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 06, 2020 at 05:15:19PM +0100, Jean-Philippe Brucker wrote:
> On Fri, Mar 06, 2020 at 10:52:45AM -0400, Jason Gunthorpe wrote:
> > On Fri, Mar 06, 2020 at 03:35:56PM +0100, Jean-Philippe Brucker wrote:
> > > On Fri, Mar 06, 2020 at 09:09:19AM -0400, Jason Gunthorpe wrote:
> > > > On Fri, Mar 06, 2020 at 10:56:14AM +0100, Jean-Philippe Brucker wrote:
> > > > > I tried to keep it simple like that: normally mmu_notifier_get() is called
> > > > > in bind(), and mmu_notifier_put() is called in unbind(). 
> > > > > 
> > > > > Multiple device drivers may call bind() with the same mm. Each bind()
> > > > > calls mmu_notifier_get(), obtains the same io_mm, and returns a new bond
> > > > > (a device<->mm link). Each bond is freed by calling unbind(), which calls
> > > > > mmu_notifier_put().
> > > > > 
> > > > > That's the most common case. Now if the process is killed and the mm
> > > > > disappears, we do need to avoid use-after-free caused by DMA of the
> > > > > mappings and the page tables. 
> > > > 
> > > > This is why release must do invalidate all - but it doesn't need to do
> > > > any more - as no SPTE can be established without a mmget() - and
> > > > mmget() is no longer possible past release.
> > > 
> > > In our case we don't have SPTEs, the whole pgd is shared between MMU and
> > > IOMMU (isolated using PASID tables).
> > 
> > Okay, but this just means that 'invalidate all' also requires
> > switching the PASID to use some pgd that is permanently 'all fail'.
> > 
> > > At this point no one told the device to stop working on this queue,
> > > it may still be doing DMA on this address space.
> > 
> > Sure, but there are lots of cases where a defective user space can
> > cause pages under active DMA to disappear, like munmap for
> > instance. Process exit is really no different, the PASID should take
> > errors and the device & driver should do whatever error flow it has.
> 
> We do have the possibility to shut things down in order, so to me this
> feels like a band-aid. 

->release() is called by exit_mmap which is called by mmput. There are
over a 100 callsites to mmput() and I'm not totally sure what the
rules are for release(). We've run into problems before with things
like this.

IMHO, due to this, it is best for release to be simple and have
conservative requirements on context like all the other notifier
callbacks. It is is not a good place to put complex HW fencing driver
code.

In particular that link you referenced is suggesting the driver tear
down could take minutes - IMHO it is not OK to block mmput() for
minutes.

> The idea has come up before though [1], and I'm not strongly opposed
> to this model, but I'm still not convinced it's necessary. It does
> add more complexity to IOMMU drivers, to avoid printing out the
> errors that we wouldn't otherwise see, whereas device drivers need
> in any case to implement the logic that forces stop DMA.

Errors should not be printed to the kernel log for PASID cases
anyhow. PASID will be used by unpriv user, and unpriv user should not
be able to trigger kernel prints at will, eg by doing dma to nmap VA
or whatever. 

Process exit is just another case of this, and should not be treated
specially.

Jason
