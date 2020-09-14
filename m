Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2C802698DD
	for <lists+linux-pci@lfdr.de>; Tue, 15 Sep 2020 00:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbgINWcf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Sep 2020 18:32:35 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:51099 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbgINWcf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Sep 2020 18:32:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1600122755; x=1631658755;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9a01/1QzXUilHHgV2KxnbyNEVyibCeomZvuXR569iKM=;
  b=g+WX87etT0fPEjw5FeqjFT+wdGDR+jWD41nWN2rOoiQ14rCU6/UUioIm
   OThOoDFflacbNoQpDNltQ6gHz6SfDh2OrxKuB+HxTJIRvvbmscAuQF6CF
   c22+UulmtxNc+x7uqqx7BUWMJlRETs7u4n3B+wsZi3yqM1tNUHohvMsgc
   w=;
X-IronPort-AV: E=Sophos;i="5.76,427,1592870400"; 
   d="scan'208";a="67957877"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-c7131dcf.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 14 Sep 2020 22:32:24 +0000
Received: from EX13MTAUWC001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-c7131dcf.us-west-2.amazon.com (Postfix) with ESMTPS id 62990A0716;
        Mon, 14 Sep 2020 22:32:23 +0000 (UTC)
Received: from EX13D02UWC003.ant.amazon.com (10.43.162.199) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 14 Sep 2020 22:32:22 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D02UWC003.ant.amazon.com (10.43.162.199) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 14 Sep 2020 22:32:22 +0000
Received: from dev-dsk-csbisa-2a-37939146.us-west-2.amazon.com (172.19.34.216)
 by mail-relay.amazon.com (10.43.162.232) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Mon, 14 Sep 2020 22:32:22 +0000
Received: by dev-dsk-csbisa-2a-37939146.us-west-2.amazon.com (Postfix, from userid 800212)
        id 6C83C192; Mon, 14 Sep 2020 22:32:21 +0000 (UTC)
Date:   Mon, 14 Sep 2020 22:32:21 +0000
From:   Clint Sbisa <csbisa@amazon.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC:     Jason Gunthorpe <jgg@nvidia.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <will@kernel.org>,
        <catalin.marinas@arm.com>, Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH] arm64: Enable PCI write-combine resources under sysfs
Message-ID: <20200914223221.wqcrwefgms2fuoo2@amazon.com>
References: <20200910171033.GG904879@nvidia.com>
 <44acc22377958a57c738f5139c5b5df2841c2544.camel@kernel.crashing.org>
 <20200910232938.GJ904879@nvidia.com>
 <3110e00a1f4df7b7359ba4f2b7f86a35aa47405e.camel@kernel.crashing.org>
 <20200911214225.hml2wbbq2rofn4re@amazon.com>
 <20200914141726.GA904879@nvidia.com>
 <20200914142406.k44zrnp2wdsandsp@amazon.com>
 <20200914143819.GC904879@nvidia.com>
 <375c478593945a416f3180c3773bcb5240d2e36c.camel@kernel.crashing.org>
 <1d6f2ceb8d3538c906a1fdb8cd3d4c74ccffa42e.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1d6f2ceb8d3538c906a1fdb8cd3d4c74ccffa42e.camel@kernel.crashing.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 15, 2020 at 08:00:27AM +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2020-09-15 at 07:42 +1000, Benjamin Herrenschmidt wrote:
> >
> > > which is back to my original question, how do you do DMA using
> > > /sys/xx/resources? Why not use VFIO like everything else?
> >
> > Note: All this doesnt' change the fact that sys/xx/resources_wc
> > exists
> > for other archs and I see no reasons so far not to have it on ARM...
> 
> Also... it looks like VFIO also doesn't provide a way to do WC yet
> unfortunately :-(
> 
> There was a discussion 2 or 3 years ago while I was at IBM about ways
> to add that functionality, but it doesn't seem to have resulted in
> anything.

And to complete answering the question, the ENA PMD in DPDK also supports vfio,
which-- as Ben pointed out-- doesn't support WC either.

Clint
