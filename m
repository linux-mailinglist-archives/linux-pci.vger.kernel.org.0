Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4B72268D75
	for <lists+linux-pci@lfdr.de>; Mon, 14 Sep 2020 16:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726745AbgINOYp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Sep 2020 10:24:45 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:60402 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbgINOYe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Sep 2020 10:24:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1600093474; x=1631629474;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IT81N7TrAfwYmLVOGjn/uSAZG0vmUEVcGJxsly/zgK8=;
  b=Ps1hf/LqKZMf56Leomk3d9Rd3YOeBhHYjppT71gI6EuetElE68JvBjV6
   J6QP7MieMz/cRkA7+1Mf64tXcGV9TuA5kABz6k7EqTXIDEYddwH+SHdhL
   Ri3t4uPgIzlznMaxCjzUzkJxi1xmH4gJpzNXn3XY18i56hHUn6a7bjJcW
   M=;
X-IronPort-AV: E=Sophos;i="5.76,426,1592870400"; 
   d="scan'208";a="67827301"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1e-27fb8269.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 14 Sep 2020 14:24:09 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-1e-27fb8269.us-east-1.amazon.com (Postfix) with ESMTPS id E3B72A0660;
        Mon, 14 Sep 2020 14:24:07 +0000 (UTC)
Received: from EX13D37UEA003.ant.amazon.com (10.43.61.137) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 14 Sep 2020 14:24:07 +0000
Received: from EX13MTAUEA002.ant.amazon.com (10.43.61.77) by
 EX13D37UEA003.ant.amazon.com (10.43.61.137) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 14 Sep 2020 14:24:07 +0000
Received: from dev-dsk-csbisa-2a-37939146.us-west-2.amazon.com (172.19.34.216)
 by mail-relay.amazon.com (10.43.61.169) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Mon, 14 Sep 2020 14:24:07 +0000
Received: by dev-dsk-csbisa-2a-37939146.us-west-2.amazon.com (Postfix, from userid 800212)
        id 20C52193; Mon, 14 Sep 2020 14:24:06 +0000 (UTC)
Date:   Mon, 14 Sep 2020 14:24:06 +0000
From:   Clint Sbisa <csbisa@amazon.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <will@kernel.org>,
        <catalin.marinas@arm.com>, Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH] arm64: Enable PCI write-combine resources under sysfs
Message-ID: <20200914142406.k44zrnp2wdsandsp@amazon.com>
References: <28d333afc73bd854390f8c39691a735040ba5b39.camel@kernel.crashing.org>
 <20200910094600.GA22840@e121166-lin.cambridge.arm.com>
 <20200910123758.GC904879@nvidia.com>
 <20200910151721.GA25809@e121166-lin.cambridge.arm.com>
 <20200910171033.GG904879@nvidia.com>
 <44acc22377958a57c738f5139c5b5df2841c2544.camel@kernel.crashing.org>
 <20200910232938.GJ904879@nvidia.com>
 <3110e00a1f4df7b7359ba4f2b7f86a35aa47405e.camel@kernel.crashing.org>
 <20200911214225.hml2wbbq2rofn4re@amazon.com>
 <20200914141726.GA904879@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200914141726.GA904879@nvidia.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 14, 2020 at 11:17:26AM -0300, Jason Gunthorpe wrote:
> On Fri, Sep 11, 2020 at 09:42:25PM +0000, Clint Sbisa wrote:
> 
> > There's no DMA involved with this BAR-- the driver writes a portion of the
> > packet contents in addition to the descriptors, which generally increases the
> > number of TLPs if write-combine isn't used. Furthermore, this BAR is only used
> > for writes and never for reads.
> 
> You use DPDK without DMA? How does receive work?

That was not worded well. DMA is used, but the first X bytes of the packet are
written directly to this BAR instead of being DMA'd-- the rest of the data is
DMA'd.

> 
> > As Jason noted in the other reply to this email, the Linux ENA driver makes use
> > of WC by using devm_ioremap_wc().
> 
> As Ben noted we don't have kernel accessors to make this portable or
> safe :(

And therein lies our dilemma...

Clint
