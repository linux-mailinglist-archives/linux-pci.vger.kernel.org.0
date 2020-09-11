Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C00B266A33
	for <lists+linux-pci@lfdr.de>; Fri, 11 Sep 2020 23:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbgIKVmc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Sep 2020 17:42:32 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:50473 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbgIKVma (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Sep 2020 17:42:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1599860550; x=1631396550;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IdnIDFsiwAZkehmai403Jyy1EHMK8CrnB8uhwtXVeVE=;
  b=tP0scIHG6OF5m+G9fkn85ATjBCauGE3SUv3lk0phh9kz+1tiXGo4RyJZ
   pDwzdFFlzPR9ePvlTAURvN3SyZoQFmtKw4KldpogkOw/q0xPlcF+bMsv4
   1YlCrd9iyBigyzEoA0d7XuvLbzjo1F1/jelU/hnVoScl2AcQqTOjx0m79
   Y=;
X-IronPort-AV: E=Sophos;i="5.76,417,1592870400"; 
   d="scan'208";a="53305519"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1a-807d4a99.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 11 Sep 2020 21:42:29 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-1a-807d4a99.us-east-1.amazon.com (Postfix) with ESMTPS id 32393A0547;
        Fri, 11 Sep 2020 21:42:26 +0000 (UTC)
Received: from EX13D25UEA001.ant.amazon.com (10.43.61.173) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 11 Sep 2020 21:42:26 +0000
Received: from EX13MTAUEA002.ant.amazon.com (10.43.61.77) by
 EX13D25UEA001.ant.amazon.com (10.43.61.173) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 11 Sep 2020 21:42:26 +0000
Received: from dev-dsk-csbisa-2a-37939146.us-west-2.amazon.com (172.19.34.216)
 by mail-relay.amazon.com (10.43.61.169) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Fri, 11 Sep 2020 21:42:26 +0000
Received: by dev-dsk-csbisa-2a-37939146.us-west-2.amazon.com (Postfix, from userid 800212)
        id E6B8C1A8; Fri, 11 Sep 2020 21:42:25 +0000 (UTC)
Date:   Fri, 11 Sep 2020 21:42:25 +0000
From:   Clint Sbisa <csbisa@amazon.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC:     Jason Gunthorpe <jgg@nvidia.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <will@kernel.org>,
        <catalin.marinas@arm.com>, Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH] arm64: Enable PCI write-combine resources under sysfs
Message-ID: <20200911214225.hml2wbbq2rofn4re@amazon.com>
References: <edae1eeb0da578d941cfa5ad550eb0a0eda5f98e.camel@kernel.crashing.org>
 <20200903110844.GB11284@e121166-lin.cambridge.arm.com>
 <28d333afc73bd854390f8c39691a735040ba5b39.camel@kernel.crashing.org>
 <20200910094600.GA22840@e121166-lin.cambridge.arm.com>
 <20200910123758.GC904879@nvidia.com>
 <20200910151721.GA25809@e121166-lin.cambridge.arm.com>
 <20200910171033.GG904879@nvidia.com>
 <44acc22377958a57c738f5139c5b5df2841c2544.camel@kernel.crashing.org>
 <20200910232938.GJ904879@nvidia.com>
 <3110e00a1f4df7b7359ba4f2b7f86a35aa47405e.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3110e00a1f4df7b7359ba4f2b7f86a35aa47405e.camel@kernel.crashing.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 11, 2020 at 10:39:16AM +1000, Benjamin Herrenschmidt wrote:
> > > > > That's why I looped you in - that's what worries me about
> > > > > "enabling"
> > > > > arch_can_pci_mmap_wc() on arm64. If we enable it and we have perf
> > > > > regressions that's not OK.
> > > > >
> > > > > Or we *can* enable arch_can_pci_mmap_wc() but force the mellanox
> > > > > driver (or more broadly all drivers following this message push
> > > > > semantics) to use "something else" for WC detection.
> > > >
> > > > arch_can_pci_mmap_wc() really only controls the sysfs resource file
> > > > and it seems very unclear who in userspace uses that these days.
> > >
> > > dpdk under some circumstances afaik.
> >
> > And something gross for DMA then? Not sure dpdk is useful without
> > DMA. Why not use CONFIG_VFIO_NOIOMMU for such a non-secure thing?
> 
> Clint, can you elaborate on the use case ?
> 

The use-case I'm targeting is the ENA pmd in DPDK. For performance reasons
(many of which are very similar to what Jason has described for mlx5), we need
to generate full-sized TLPs instead of many partial TLPs to improve efficiency.

Here's an excerpt describing the write-combine usage from
./Documentation/networking/device_drivers/ethernet/amazon/ena.rst:

- Low Latency Queue (LLQ) mode or "push-mode".
  * In this mode the driver pushes the transmit descriptors and the
    first 128 bytes of the packet directly to the ENA device memory
    space. The rest of the packet payload is fetched by the
    device. For this operation mode, the driver uses a dedicated PCI
    device memory BAR, which is mapped with write-combine capability.

There's no DMA involved with this BAR-- the driver writes a portion of the
packet contents in addition to the descriptors, which generally increases the
number of TLPs if write-combine isn't used. Furthermore, this BAR is only used
for writes and never for reads.

As Jason noted in the other reply to this email, the Linux ENA driver makes use
of WC by using devm_ioremap_wc(). The DPDK code here uses the same mechanism in
user-space to enable write-combining by mapping the resourceX_wc file if the
driver uses RTE_PCI_DRV_WC_ACTIVATE.

Clint
