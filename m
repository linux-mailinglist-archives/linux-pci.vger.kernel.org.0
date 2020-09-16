Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE94426CE75
	for <lists+linux-pci@lfdr.de>; Thu, 17 Sep 2020 00:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbgIPWP0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Sep 2020 18:15:26 -0400
Received: from kernel.crashing.org ([76.164.61.194]:40880 "EHLO
        kernel.crashing.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbgIPWP0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Sep 2020 18:15:26 -0400
Received: from localhost (gate.crashing.org [63.228.1.57])
        (authenticated bits=0)
        by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 08GLTCG0028056
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 16 Sep 2020 16:29:15 -0500
Message-ID: <f0b11a226e084cee1a02f76cfe0975bba72feb00.camel@kernel.crashing.org>
Subject: Re: [PATCH] arm64: Enable PCI write-combine resources under sysfs
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Clint Sbisa <csbisa@amazon.com>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Leon Romanovsky <leon@kernel.org>
Date:   Thu, 17 Sep 2020 07:29:11 +1000
In-Reply-To: <20200916170058.GD3122@gaia>
References: <1d6f2ceb8d3538c906a1fdb8cd3d4c74ccffa42e.camel@kernel.crashing.org>
         <20200914225740.GP904879@nvidia.com>
         <2b539df4c9ec703458e46da2fc879ee3b310b31c.camel@kernel.crashing.org>
         <20200915101831.GA2616@e121166-lin.cambridge.arm.com>
         <20200915110511.GQ904879@nvidia.com>
         <bcb95faafa72734478b942084a9d24a61ae9887f.camel@kernel.crashing.org>
         <20200915234006.GI1573713@nvidia.com>
         <20200916083315.GC27496@willie-the-truck> <20200916084851.GA3122@gaia>
         <20200916141502.GB20770@e121166-lin.cambridge.arm.com>
         <20200916170058.GD3122@gaia>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 2020-09-16 at 18:00 +0100, Catalin Marinas wrote:
> > That we don't know but if a prefetchable BAR can't tolerate read
> > side effects this would be already a problem on eg x86 - that's
> > the best we can hope for given the current PCI specs.
> > 
> > +1 on normal NC. The only open point is whether we should make
> > arch_can_pci_mmap_wc() return false on platforms like TX2.
> 
> I lost track in this thread whether it matters. TX2 would need Device
> GRE for optimal performance but the kernel doesn't currently provide
> it anyway. We could expose a new memory type, aligned_wc ;).

Or ignore TX2 :-) Though Lorenzo has a point about making it return
false for arch_can_pci_mmap_wc() if we really care enough.

Cheers,
Ben.


