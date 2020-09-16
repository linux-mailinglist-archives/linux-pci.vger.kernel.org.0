Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04D4126CA57
	for <lists+linux-pci@lfdr.de>; Wed, 16 Sep 2020 21:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbgIPT4K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Sep 2020 15:56:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:48192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727213AbgIPRgT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Sep 2020 13:36:19 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E48F20672;
        Wed, 16 Sep 2020 12:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600260490;
        bh=gGkHjWjs9t1Y0tRqxb4uEA1F6lmm4+9IJ9If5CWfkNs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cjP3VKTYnjltiS+BtFUMrZzU3rJT5mSlnTcc2sOHnE2VAYK7PI2/0iOlked/4d8U/
         b1cVdjh1WgIU3x6ESQE+xqky/retMs+cmdj9AQ8VI0VZPTbL1f3iItlc9Mgh1F4Zaf
         UImnFttDfsD1rueURa06IQbf4nBnmjszy1MMFOl8=
Date:   Wed, 16 Sep 2020 15:48:06 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Clint Sbisa <csbisa@amazon.com>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        linux-arm-kernel@lists.infradead.org, will@kernel.org,
        catalin.marinas@arm.com
Subject: Re: [PATCH] arm64: Enable PCI write-combine resources under sysfs
Message-ID: <20200916124806.GJ486552@unreal>
References: <20200914143819.GC904879@nvidia.com>
 <375c478593945a416f3180c3773bcb5240d2e36c.camel@kernel.crashing.org>
 <1d6f2ceb8d3538c906a1fdb8cd3d4c74ccffa42e.camel@kernel.crashing.org>
 <20200914225740.GP904879@nvidia.com>
 <2b539df4c9ec703458e46da2fc879ee3b310b31c.camel@kernel.crashing.org>
 <20200915101831.GA2616@e121166-lin.cambridge.arm.com>
 <20200915110511.GQ904879@nvidia.com>
 <bcb95faafa72734478b942084a9d24a61ae9887f.camel@kernel.crashing.org>
 <20200915234006.GI1573713@nvidia.com>
 <701012f288231d0d0733bf1c2c8fdbd9caa074fd.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <701012f288231d0d0733bf1c2c8fdbd9caa074fd.camel@kernel.crashing.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 16, 2020 at 05:59:24PM +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2020-09-15 at 20:40 -0300, Jason Gunthorpe wrote:
>
> > Like I said, the case where the driver can't self test probably
> > doesn't intersect with the ARM implementations that can't do write
> > combining, and if it did, the users probably run the out of tree
> > driver that has the hacky stuff to make it use DEVICE_GRE.
>
> Ok. So you are saying to go for it and ignore that Mellanox case then ?
> :-)

Regarding Mellanox, as I wrote it in the beginning of this thread, you
can ignore mlx5 driver.
https://lore.kernel.org/linux-pci/20200910105419.GH421756@unreal/

Thanks
