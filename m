Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F398260729
	for <lists+linux-pci@lfdr.de>; Tue,  8 Sep 2020 01:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbgIGXeN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Sep 2020 19:34:13 -0400
Received: from kernel.crashing.org ([76.164.61.194]:59762 "EHLO
        kernel.crashing.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727058AbgIGXeM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Sep 2020 19:34:12 -0400
Received: from localhost (gate.crashing.org [63.228.1.57])
        (authenticated bits=0)
        by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 087NXhPt029386
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 7 Sep 2020 18:33:47 -0500
Message-ID: <28d333afc73bd854390f8c39691a735040ba5b39.camel@kernel.crashing.org>
Subject: Re: [PATCH] arm64: Enable PCI write-combine resources under sysfs
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Clint Sbisa <csbisa@amazon.com>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        linux-arm-kernel@lists.infradead.org, will@kernel.org,
        catalin.marinas@arm.com, Leon Romanovsky <leon@kernel.org>
Date:   Tue, 08 Sep 2020 09:33:42 +1000
In-Reply-To: <20200903110844.GB11284@e121166-lin.cambridge.arm.com>
References: <20200831151827.pumm2p54fyj7fz5s@amazon.com>
         <20200902113207.GA27676@e121166-lin.cambridge.arm.com>
         <20200902142922.xc4x6m33unkzewuh@amazon.com>
         <20200902164702.GA30611@e121166-lin.cambridge.arm.com>
         <edae1eeb0da578d941cfa5ad550eb0a0eda5f98e.camel@kernel.crashing.org>
         <20200903110844.GB11284@e121166-lin.cambridge.arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 2020-09-03 at 12:08 +0100, Lorenzo Pieralisi wrote:
> > It's been what other architectures have been doing for mroe than a
> > decade without significant issues... I don't think you should worry
> > too
> > much about this.
> 
> Minus what I wrote above, I agree with you. I'd still be able to
> understand what this patch changes in the mellanox driver HW
> handling though - not sure what they expect from
> arch_can_pci_mmap_wc()
> returning 1.

I don't know enough to get into the finer details but looking a bit it
seems when this is set, they allow extra ioctls to create buffers
mapped with pgprot_writecombine().

I suppose this means faster MMIO backet buffers for small packets (ie,
non-DMA use case).

Also note that mlx5_ib_test_wc() only uses arch_can_pci_mmap_wc() for a
non-ROCE ethernet port on a PF... For anyting else, it just seems to
actually try to do it and see what happens :-)

Leon: Can you clarify the use of arch_can_pci_mmap_wc() in mlx5 and
whether you see an issue with enabling this on arm64 ?

Cheers,
Ben.


