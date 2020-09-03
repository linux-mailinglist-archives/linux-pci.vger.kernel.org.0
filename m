Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5DE225CD71
	for <lists+linux-pci@lfdr.de>; Fri,  4 Sep 2020 00:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbgICW0v (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Sep 2020 18:26:51 -0400
Received: from kernel.crashing.org ([76.164.61.194]:54290 "EHLO
        kernel.crashing.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728127AbgICW0v (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Sep 2020 18:26:51 -0400
Received: from localhost (gate.crashing.org [63.228.1.57])
        (authenticated bits=0)
        by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 083MQOD4014891
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 3 Sep 2020 17:26:28 -0500
Message-ID: <56d2f113acef3055d3bf771fa6cd7c976fc6da65.camel@kernel.crashing.org>
Subject: Re: [PATCH] arm64: Enable PCI write-combine resources under sysfs
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Clint Sbisa <csbisa@amazon.com>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        linux-arm-kernel@lists.infradead.org, will@kernel.org,
        catalin.marinas@arm.com
Date:   Fri, 04 Sep 2020 08:26:23 +1000
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
> "Additional Guidance on the Prefetchable Bit in Memory Space BARs"
> 
> I read it 100 times and I still have no idea how it can be
> implemented,
> it sorts of acknowledges that read side-effects memory can be marked
> as a prefetchable BAR *if* the system meets some criteria.
> 
> As if endpoint designers knew the system where their endpoint is
> plugged into (+ bit (3) in a BAR is read-only).
> 
> I think that that implementation note must be removed from the
> specifications - if anyone dares to follow it this whole
> WC resource mapping can trigger trouble.

Ah that one ! Yes you are right its completely broken.

This part of the spec aims at working around the fact that bridges only
have 64-bit prefetchable windows, so anything non-pref has to go below
a 32-bit bridge window (effectively making most 64-bit non-pref BARs a
pointless waste of silicon).

The right fix of course would have been to create a new type of bridge
window. But PCI...

If you're going to mess around with the SIG, I would suggest that a
better approach short of the above would be to allow system software to
put 64-bit non-pref BARs below bridge pref windows on PCIe (provided
the various otehr restrictions in that note are honored such as bridges
not prefetching) and leave it at that. (Unless they already do
somewhere else, I forgot ...).

This should be sufficient to address the space concern without killing
the meaning of the prefetchable bit.

As for enabling the _wc files in sysfs, well, you need some serious
priviledge to be able to access them, so I don't see a big issue 
allowing them to exist when "prefetchable" is set regardless of that
rule. The Mellanox case might be different.

Cheers,
Ben.

