Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1CE426DD9C
	for <lists+linux-pci@lfdr.de>; Thu, 17 Sep 2020 16:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbgIQOKx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Sep 2020 10:10:53 -0400
Received: from foss.arm.com ([217.140.110.172]:47238 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726827AbgIQOKr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 Sep 2020 10:10:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2851730E;
        Thu, 17 Sep 2020 07:01:23 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DFC2C3F718;
        Thu, 17 Sep 2020 07:01:21 -0700 (PDT)
Date:   Thu, 17 Sep 2020 15:01:16 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Clint Sbisa <csbisa@amazon.com>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        linux-arm-kernel@lists.infradead.org, will@kernel.org,
        catalin.marinas@arm.com, Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH] arm64: Enable PCI write-combine resources under sysfs
Message-ID: <20200917140116.GA4893@e121166-lin.cambridge.arm.com>
References: <2b539df4c9ec703458e46da2fc879ee3b310b31c.camel@kernel.crashing.org>
 <20200915101831.GA2616@e121166-lin.cambridge.arm.com>
 <20200915110511.GQ904879@nvidia.com>
 <bcb95faafa72734478b942084a9d24a61ae9887f.camel@kernel.crashing.org>
 <20200915234006.GI1573713@nvidia.com>
 <701012f288231d0d0733bf1c2c8fdbd9caa074fd.camel@kernel.crashing.org>
 <20200916121226.GN1573713@nvidia.com>
 <28082ccc715a9fba349ae6052d5c917ae02d40fa.camel@kernel.crashing.org>
 <20200917102819.GA2284@e121166-lin.cambridge.arm.com>
 <20200917113221.GG3699@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917113221.GG3699@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 17, 2020 at 08:32:21AM -0300, Jason Gunthorpe wrote:
> On Thu, Sep 17, 2020 at 11:28:19AM +0100, Lorenzo Pieralisi wrote:
> > Unfortunately if we merge this patch we _do_ know from this thread
> > that userspace will suffer from a perf regression on TX2.
> > 
> > Either we ignore it or we write some code to prevent it
> > (ie first step make arch_can_pci_mmap_wc() return 0 on TX2 -
> > possibly using the arm64 errata detection mechanism).
> 
> If anyone complains they can send the change to arch_can_pci_mmap_wc()
> - I'm pretty sure nobody will complain due to mlx5

If that's the case we can go ahead and merge this patch with a
reworded commit log - this thread was very useful nonetheless
for my own information (and others hopefully) so thank you.

For VFIO WC + "message push ioremap" - to be continued.

Clint, please reword the commit and resend, not sure we can hit
v5.10 but we shall try.

Thanks,
Lorenzo
