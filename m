Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 862C71E3D02
	for <lists+linux-pci@lfdr.de>; Wed, 27 May 2020 11:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388339AbgE0JBp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 May 2020 05:01:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:35522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388213AbgE0JBp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 27 May 2020 05:01:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CC1F20723;
        Wed, 27 May 2020 09:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590570104;
        bh=Ly0PPgLoVOdP2MHz53CmBLAFstCS5mfpl1WpLZ15gps=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=onCoAOhnzHO9z1pUO0//RWYJLmKfFMRTqXoBIY+gdObr+17e6nwXXsvWN0RMThy9e
         uwLwAnL2f9xW9oLDKOWZn/Nzmaln1ON7ULTIQPpaM1zsoyYnkrxXXpwhUkArhx2hE2
         yEEIJrw8f7A1SPpbRQGH1EvlHjbsZMtVrqHdWmVk=
Date:   Wed, 27 May 2020 11:01:42 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Zhangfei Gao <zhangfei.gao@linaro.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        jean-philippe <jean-philippe@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        kenneth-lee-2012@foxmail.com, Wangzhou <wangzhou1@hisilicon.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] PCI: Introduce PCI_FIXUP_IOMMU
Message-ID: <20200527090142.GC179718@kroah.com>
References: <1590493749-13823-1-git-send-email-zhangfei.gao@linaro.org>
 <1590493749-13823-2-git-send-email-zhangfei.gao@linaro.org>
 <20200526144644.GA20784@infradead.org>
 <39144dc0-3b04-3127-978b-bd8487dd06e0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <39144dc0-3b04-3127-978b-bd8487dd06e0@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 26, 2020 at 11:09:57PM +0800, Zhangfei Gao wrote:
> Hi, Christoph
> 
> On 2020/5/26 下午10:46, Christoph Hellwig wrote:
> > On Tue, May 26, 2020 at 07:49:08PM +0800, Zhangfei Gao wrote:
> > > Some platform devices appear as PCI but are actually on the AMBA bus,
> > > and they need fixup in drivers/pci/quirks.c handling iommu_fwnode.
> > > Here introducing PCI_FIXUP_IOMMU, which is called after iommu_fwnode
> > > is allocated, instead of reusing PCI_FIXUP_FINAL since it will slow
> > > down iommu probing as all devices in fixup final list will be
> > > reprocessed.
> > Who is going to use this?  I don't see a single user in the series.
> We will add iommu fixup in drivers/pci/quirks.c, handling
> 
> fwspec->can_stall, which is introduced in
> 
> https://www.spinics.net/lists/linux-pci/msg94559.html
> 
> Unfortunately, the patch does not catch v5.8, so we have to wait.
> And we want to check whether this is a right method to solve this issue.

We can't take new apis without a real user, so please submit them all at
once.

thanks,

greg k-h
