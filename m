Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 774F026E57A
	for <lists+linux-pci@lfdr.de>; Thu, 17 Sep 2020 21:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbgIQQP6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Sep 2020 12:15:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:35232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728338AbgIQQPz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 Sep 2020 12:15:55 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 257BF2247F;
        Thu, 17 Sep 2020 16:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600358938;
        bh=ttvB4OUNNmeDsS2MqYdXTGsv6URd9V52SiIkUAs6uBs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x+GWWFhq0ymF8oHCA/FdvpTpMsgTPwTcwky/RzCx7L+rFnIFtRzEGB4mKq1np/Wfc
         EHcBUk66klPKKVlXCyPz2bpH4dfwj0R21c6ne1aXcW/qnCGTDm7X6ybhUMCVAAgrh/
         kOibnw8i0EaZQkPBxYFz6ppEmNcMAclJ1wv9Y4Bk=
Date:   Thu, 17 Sep 2020 17:08:53 +0100
From:   Will Deacon <will@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Clint Sbisa <csbisa@amazon.com>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH] arm64: Enable PCI write-combine resources under sysfs
Message-ID: <20200917160851.GA29999@willie-the-truck>
References: <20200915101831.GA2616@e121166-lin.cambridge.arm.com>
 <20200915110511.GQ904879@nvidia.com>
 <bcb95faafa72734478b942084a9d24a61ae9887f.camel@kernel.crashing.org>
 <20200915234006.GI1573713@nvidia.com>
 <701012f288231d0d0733bf1c2c8fdbd9caa074fd.camel@kernel.crashing.org>
 <20200916121226.GN1573713@nvidia.com>
 <28082ccc715a9fba349ae6052d5c917ae02d40fa.camel@kernel.crashing.org>
 <20200917102819.GA2284@e121166-lin.cambridge.arm.com>
 <20200917113221.GG3699@nvidia.com>
 <20200917140116.GA4893@e121166-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917140116.GA4893@e121166-lin.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 17, 2020 at 03:01:16PM +0100, Lorenzo Pieralisi wrote:
> On Thu, Sep 17, 2020 at 08:32:21AM -0300, Jason Gunthorpe wrote:
> > On Thu, Sep 17, 2020 at 11:28:19AM +0100, Lorenzo Pieralisi wrote:
> > > Unfortunately if we merge this patch we _do_ know from this thread
> > > that userspace will suffer from a perf regression on TX2.
> > > 
> > > Either we ignore it or we write some code to prevent it
> > > (ie first step make arch_can_pci_mmap_wc() return 0 on TX2 -
> > > possibly using the arm64 errata detection mechanism).
> > 
> > If anyone complains they can send the change to arch_can_pci_mmap_wc()
> > - I'm pretty sure nobody will complain due to mlx5
> 
> If that's the case we can go ahead and merge this patch with a
> reworded commit log - this thread was very useful nonetheless
> for my own information (and others hopefully) so thank you.
> 
> For VFIO WC + "message push ioremap" - to be continued.
> 
> Clint, please reword the commit and resend, not sure we can hit
> v5.10 but we shall try.

If you ack it, I'll queue it ;)

Will
