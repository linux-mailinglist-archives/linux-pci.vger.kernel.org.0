Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3228107F80
	for <lists+linux-pci@lfdr.de>; Sat, 23 Nov 2019 17:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbfKWQvM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 23 Nov 2019 11:51:12 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35710 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbfKWQvM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 23 Nov 2019 11:51:12 -0500
Received: by mail-ot1-f67.google.com with SMTP id 23so7188109otf.2;
        Sat, 23 Nov 2019 08:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Upjd5FUUY2gldqhTrP6G3VfXwkiVp2ftazHWWknqWA4=;
        b=f4EoZznNRknE5+5KvGz4gn6nVLdgpGkAnfbkGyUIqGaP+UAxcV/BrOLd2UxApPRrEY
         GK5bvfrDftwMSeSG2J5qWQsQbZKNzEWE1UscURDcyZ/Mf2IozhUK2hD7H7Wk6P+fr+Lj
         vYt3DfrNbNBDK2yymxFGV/wFQn08Y+ugjt/BabLIUwHrZDgdzC99OIHCsK3JPAOKI3Fl
         E0wzoBe1QNhnGqHxm235gEr3NX3lPvqWuX5gUSiK5gp+50CKyLWdeQC3cHqdNJ1vHc0O
         Pu1CfHPZkXkBFCovetMk4xuIxH7tOZ0Zyl87WOiEm3Q62Gxg8qmKNTjf1qf5qKp1IeyI
         ugIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Upjd5FUUY2gldqhTrP6G3VfXwkiVp2ftazHWWknqWA4=;
        b=lV1OOhOx6mTrp0h6VAeyGX94uoAVikfnib2J1JOyJGUA6THZasdy4t//ZqCb58crYA
         cayougm6bGPybiKAYBA52JO+u4KqrfUcZzNUPHcOn1bE2tsj3bREcBvdkOVa2CqSzU3t
         yZYq8fcFqoNuUb0E9AllUSbIMmqEhzCYmNTV5ZDvpE0MdP2mqWRLdn2lDDqs6Y7sg5Wv
         O03azfqZc9I4uii6E1dDoPrZYef/ofqp1LSpdNTfn3y2V+GCvUcEzdLJD08D0gRmOhRp
         WoTeFB40abF4q4lpPucsx7y9RlhLJSiuKZyjQifd+zB1/dqWH+7fg4/aqq1zO5GyVuVr
         pk3Q==
X-Gm-Message-State: APjAAAUN/jTY37W352O1BRnlfa6xQbUHW7+unwXnprld0dGbaCBm4rU2
        e7XtEuXKFCicTacJ+CL6wfI=
X-Google-Smtp-Source: APXvYqy/FuuHH8tC1YjzsbuxoICI/PjIU8E8OEmgejzSAAA40pPWUGyBa/f/fjeP66p0eSxGD/kxCw==
X-Received: by 2002:a9d:7399:: with SMTP id j25mr5600107otk.155.1574527870570;
        Sat, 23 Nov 2019 08:51:10 -0800 (PST)
Received: from ubuntu-x2-xlarge-x86 ([2604:1380:4111:8b00::7])
        by smtp.gmail.com with ESMTPSA id n5sm609133oie.16.2019.11.23.08.51.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 23 Nov 2019 08:51:09 -0800 (PST)
Date:   Sat, 23 Nov 2019 09:51:08 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jens Axboe <axboe@kernel.dk>, Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paul Burton <paulburton@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
        linux-acpi@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        James Hogan <jhogan@kernel.org>, Len Brown <lenb@kernel.org>,
        devicetree@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-mips@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] dma-mapping: treat dev->bus_dma_mask as a DMA limit
Message-ID: <20191123165108.GA15306@ubuntu-x2-xlarge-x86>
References: <20191121092646.8449-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191121092646.8449-1-nsaenzjulienne@suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 21, 2019 at 10:26:44AM +0100, Nicolas Saenz Julienne wrote:
> Using a mask to represent bus DMA constraints has a set of limitations.
> The biggest one being it can only hold a power of two (minus one). The
> DMA mapping code is already aware of this and treats dev->bus_dma_mask
> as a limit. This quirk is already used by some architectures although
> still rare.
> 
> With the introduction of the Raspberry Pi 4 we've found a new contender
> for the use of bus DMA limits, as its PCIe bus can only address the
> lower 3GB of memory (of a total of 4GB). This is impossible to represent
> with a mask. To make things worse the device-tree code rounds non power
> of two bus DMA limits to the next power of two, which is unacceptable in
> this case.
> 
> In the light of this, rename dev->bus_dma_mask to dev->bus_dma_limit all
> over the tree and treat it as such. Note that dev->bus_dma_limit should
> contain the higher accesible DMA address.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
<snip>
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 041066f3ec99..0cc702a70a96 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -421,8 +421,7 @@ static dma_addr_t iommu_dma_alloc_iova(struct iommu_domain *domain,
>  	if (iova_len < (1 << (IOVA_RANGE_CACHE_MAX_SIZE - 1)))
>  		iova_len = roundup_pow_of_two(iova_len);
>  
> -	if (dev->bus_dma_mask)
> -		dma_limit &= dev->bus_dma_mask;
> +	dma_limit = min_not_zero(dma_limit, dev->bus_dma_limit);
>  
>  	if (domain->geometry.force_aperture)
>  		dma_limit = min(dma_limit, domain->geometry.aperture_end);

Just as an FYI, this introduces a warning on arm32 allyesconfig for me:

In file included from ../include/linux/list.h:9,
                 from ../include/linux/kobject.h:19,
                 from ../include/linux/of.h:17,
                 from ../include/linux/irqdomain.h:35,
                 from ../include/linux/acpi.h:13,
                 from ../include/linux/acpi_iort.h:10,
                 from ../drivers/iommu/dma-iommu.c:11:
../drivers/iommu/dma-iommu.c: In function 'iommu_dma_alloc_iova':
../include/linux/kernel.h:851:29: warning: comparison of distinct pointer types lacks a cast
  851 |   (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
      |                             ^~
../include/linux/kernel.h:865:4: note: in expansion of macro '__typecheck'
  865 |   (__typecheck(x, y) && __no_side_effects(x, y))
      |    ^~~~~~~~~~~
../include/linux/kernel.h:875:24: note: in expansion of macro '__safe_cmp'
  875 |  __builtin_choose_expr(__safe_cmp(x, y), \
      |                        ^~~~~~~~~~
../include/linux/kernel.h:884:19: note: in expansion of macro '__careful_cmp'
  884 | #define min(x, y) __careful_cmp(x, y, <)
      |                   ^~~~~~~~~~~~~
../include/linux/kernel.h:917:39: note: in expansion of macro 'min'
  917 |  __x == 0 ? __y : ((__y == 0) ? __x : min(__x, __y)); })
      |                                       ^~~
../drivers/iommu/dma-iommu.c:424:14: note: in expansion of macro 'min_not_zero'
  424 |  dma_limit = min_not_zero(dma_limit, dev->bus_dma_limit);
      |              ^~~~~~~~~~~~

Cheers,
Nathan
