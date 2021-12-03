Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2938468064
	for <lists+linux-pci@lfdr.de>; Sat,  4 Dec 2021 00:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354241AbhLCXfB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Dec 2021 18:35:01 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:58632 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240573AbhLCXe7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Dec 2021 18:34:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B2DA62D33
        for <linux-pci@vger.kernel.org>; Fri,  3 Dec 2021 23:31:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 330ACC53FAD;
        Fri,  3 Dec 2021 23:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638574293;
        bh=mot38KtECLsQ87UtpV2RGOesj9zR4Kju+CbMI3hZmcA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gciqKgLDo9u7pQaA73InGrZWgBcxdVSN3h7+zQrlqeuGhaoWTcO4SA8ibf5jPcOcd
         nqJhBOJ+kqFxDgogm1BdSXvMhGWPXhmt8dIxmoQ/bE44B/6WpDAZWSLUR9HlXH4jDn
         LNO1NHc4nmxXoENc56RalaM4DJmVd7m6IwEbfH1rW4WAmt9cYfmHVonqhiQbYuwMzN
         HWU65lsoClpKEbMMNMfFwNYOxCenOx2LNuaz2hLDIOiLNEhWaXyYg5XpVDRpX5M5E5
         tRtL89D6Uom4tXHEgtrNOxhJcC7Pi1yWM8D2+k86KIx7WuJBzDkCN+/4KB1u0Weg9G
         9KRQRhJB2uzlw==
Date:   Fri, 3 Dec 2021 15:31:31 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Richard Zhu <hongxing.zhu@nxp.com>
Subject: Re: IMX8MM PCIe performance evaluated with NVMe
Message-ID: <20211203233131.GE3839336@dhcp-10-100-145-180.wdc.com>
References: <CAJ+vNU0OZvy4RamHZ18aJ6+AiO3BxXQx-3-sQYop6sF1QRMmwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ+vNU0OZvy4RamHZ18aJ6+AiO3BxXQx-3-sQYop6sF1QRMmwA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 03, 2021 at 01:52:17PM -0800, Tim Harvey wrote:
> Greetings,
> 
> I'm using PCIe on the IMX8M Mini and testing PCIe performance with a
> NVMe constrained to 1 lane. The NVMe in question is a Samsung SSD980
> 500GB which claims 3500MB/s read speed (with a gen3 x4 link).
> 
> My understanding of PCIe performance would give the following
> theoretical max bandwidth based on clock and encoding:
> pcie gen1 x1 : 2500MT/s*1lane*80% (8B/10B encoding) = 2000Mbps = 250MB/s
> pcie gen2 x1 : 5000MT/s*1lane*80% (8B/10B encoding) = 4000Mbps = 500MB/s
> pcie gen3 x1 : 8000MT/s*1lane*98.75% (128B/130B encoding) = 7900Mbps = 987.5MB/s
> pcie gen3 x4 : 8000MT/s*4lane*98.75% (128B/130B encoding) = 31600Mbps = 3950MB/s
> 
> My assumption is an NVMe would have very little data overhead and thus
> be a simple way to test PCIe bus performance.

Your 'dd' output is only reporting the user data throughput, but there
is more happening on the link than just user data.

You've accounted for the bit encoding, but there's more from the PCIe
protocol: the PHY layer (SOS), DLLP (Ack, FC), and TLP (headers,
sequences, checksums). 

NVMe itself also adds some overhead in the form of SQE, CQE, PRP, and
MSIx.

All told, the best theoretical bandwidth that user data will be able to
utilize out of the link is going to end up being ~85-90%, depending on
your PCIe MPS (Max Payload Size) setting.
 
> Testing this NVMe with 'dd if=/dev/nvme0n1 of=/dev/null bs=1M
> count=500 iflag=nocache' on various systems gives me the following:

If using 'dd', I think you want to use 'iflag=direct' rather than 'nocache'.

> - x86 gen3 x4: 2700MB/s (vs theoretical max of ~4GB/s)
> - x86 gen3 x1: 840MB/s
> - x86 gen2 x1: 390MB/s
> - cn8030 gen3 x1: 352MB/s (Cavium OcteonTX)
> - cn8030 gen2 x1: 193MB/s (Cavium OcteonTX)
> - imx8mm gen2 x1: 266MB/s
> 
> The various x86 tests were not all done on the same PC or the same
> kernel or kernel config... I used what I had around with whatever
> Linux OS was on them just to get a feel for performance and in all
> cases but the x4 case lanes 2/3/4 were masked off with kapton tape to
> force a 1-lane link.
> 
> Why do you think the IMX8MM running at gen2 x1 would have such a lower
> than expected performance (266MB/s vs the 390MB/s an x86 gen2 x1 could
> get)?
> 
> What would a more appropriate way of testing PCIe performance be?

Beyond the protocol overhead, 'dd' is probably not going to be the best
way to meausre a device's performance. This sends just one command at a
time, so you are also measuring the full software stack latency, which
includes a system call and interrupt driven context switches. The PCIe
traffic would be idle during this overhead when running at just qd1.

I am guessing your x86 is simply faster at executing through this
software stack than your imx8mm, so the software latency is lower.

A better approach may be to use higher queue depths with batched
submissions so that your software overhead can occur concurrently with
your PCIe traffic. Also, you can eliminate interrupt context switches if
you use polled IO queues.
