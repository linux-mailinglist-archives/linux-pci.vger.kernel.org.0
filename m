Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCF31029DC
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2019 17:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbfKSQzG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Nov 2019 11:55:06 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39646 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728527AbfKSQzG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Nov 2019 11:55:06 -0500
Received: by mail-qt1-f196.google.com with SMTP id t8so25379908qtc.6
        for <linux-pci@vger.kernel.org>; Tue, 19 Nov 2019 08:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WS7CgNbVTLnXI+F//St0LEaj4tnKGZAzwSTTN2+gQVc=;
        b=iVAYjQHLPSEvwSFNlSCeOYv+886dqBtEdSB9f197Q+2nfx9MYsTdaFER/T+YT3sU4F
         2sV2cUTWCgHWA/Sy8/JS1sLjB3RmPldgWEzHpDH3Zshmlx9sUeJd3WCjr0zJdBai7b+T
         zy0kDiCzrL33Em9pVCTZenB2tDXqNlQKDuCoq8qOeSxuw5syY2PYyALR4CmEkS3xxRkF
         KqdBDYqlUyjmKLg0jfLiPHNdfpwXCKAj7llRkxZqK0EAlnUnUfe1TveheX+AtLUcLsQM
         5aonmzsTTQd9WPPpdNsJ0+Co3d3w0ppLUo0gKmx956jS+2Y6gtYKaBK+c/0EDbMVCE7m
         wyCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WS7CgNbVTLnXI+F//St0LEaj4tnKGZAzwSTTN2+gQVc=;
        b=aKu6H0zufXj8Kuz2mZhrlxMaAx6eY+/fkPXj8IyfkriAyPDQw8ixJt9NkHpgFixIZ1
         LDIDLd10MsQPtL+TlSbmRRj4BChqonyZjm/7zUJBz45aLh6NF3aUvh2H0WS0n/COgTvo
         xlctqSA/3P9hE5djy402mR0DQcDLI0RLRaROilpz4t5xw9S+pAZfMTVJLYRrEKXWYMgi
         jNeF6eIdHt0rqdQJ7ui3JEwTQhWvNLEf/flAKmPQBIBf/xYDzT60d4EyvpfrBc2Zpw3l
         TzuRfK081mZDbgpcPgZTux+fTQJTglv8viNpI1RmXUdyGfpaBa5tP8Yy2Ldb5Jg3Y71r
         /NyQ==
X-Gm-Message-State: APjAAAWbvbMV4n3VrjU1XsUH2RZDdRPysn50Ald75V2VPHuB+cuL9COD
        CtR4ZauYQqTfDAA36umSoaIF1g==
X-Google-Smtp-Source: APXvYqzkFUvos9MykZsh27TV/+hmzGyyLBxh0y1ceE3cL9LAkahX/1j2YfuXdRVTSUCh1q0oLUrsfw==
X-Received: by 2002:ac8:6757:: with SMTP id n23mr875894qtp.345.1574182503733;
        Tue, 19 Nov 2019 08:55:03 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id v186sm10479291qkb.42.2019.11.19.08.55.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Nov 2019 08:55:02 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iX6mM-0001Yp-4X; Tue, 19 Nov 2019 12:55:02 -0400
Date:   Tue, 19 Nov 2019 12:55:02 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Andrew Murray <andrew.murray@arm.com>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-rdma@vger.kernel.org, maz@kernel.org, phil@raspberrypi.org,
        iommu@lists.linux-foundation.org,
        linux-rockchip@lists.infradead.org, f.fainelli@gmail.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org, mbrugger@suse.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        jeremy.linton@arm.com, Tom Joseph <tjoseph@cadence.com>,
        wahrenst@gmx.net, james.quinlan@broadcom.com,
        Robin Murphy <robin.murphy@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Tariq Toukan <tariqt@mellanox.com>
Subject: Re: [PATCH v2 1/6] linux/log2.h: Add roundup/rounddown_pow_two64()
 family of functions
Message-ID: <20191119165502.GB4991@ziepe.ca>
References: <20191112155926.16476-1-nsaenzjulienne@suse.de>
 <20191112155926.16476-2-nsaenzjulienne@suse.de>
 <20191119111320.GP43905@e119886-lin.cambridge.arm.com>
 <052d07fb4eb79b29dd58cab577d59bab6684329a.camel@suse.de>
 <56cbba61d92f9bc7d0a33c1de379bcd5cf411cb8.camel@suse.de>
 <20191119162849.GT43905@e119886-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191119162849.GT43905@e119886-lin.cambridge.arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 19, 2019 at 04:28:50PM +0000, Andrew Murray wrote:
> On Tue, Nov 19, 2019 at 01:43:39PM +0100, Nicolas Saenz Julienne wrote:
> > On Tue, 2019-11-19 at 12:30 +0100, Nicolas Saenz Julienne wrote:
> > > Hi Andrew, thanks for the review.
> > > > > +/**
> > > > > + * __roundup_pow_of_two64() - round 64bit value up to nearest power of
> > > > > two
> > > > > + * @n: value to round up
> > > > > + */
> > > > > +static inline __attribute__((const)) __u64 __roundup_pow_of_two64(__u64
> > > > > n)
> > > > 
> > > > To be consistent with other functions in the same file (__ilog_u64) you may
> > > > want to rename this to __roundup_pow_of_two_u64.
> > > 
> > > Sounds good to me.
> > > 
> > > > Also do you know why u64 is used in some places and __u64 in others?
> > > 
> > > That's unwarranted, it should be __u64 everywhere.
> > 
> > Sorry, now that I look deeper into it, it should be u64.
> 
> Do you know the reason why? I'd be interested to know.

__u64 must be used in header files that are under uapi - ie it is the
name of the symbol in userspace, and u64 does not exist.

u64 should be used in all code that is only inside the kernel, ie .c
files, internal headers, etc

I routinely discourage use of __uXX in kernel native code.

Jason
