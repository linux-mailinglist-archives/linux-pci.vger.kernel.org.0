Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB57F475DE1
	for <lists+linux-pci@lfdr.de>; Wed, 15 Dec 2021 17:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245005AbhLOQvq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Dec 2021 11:51:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244983AbhLOQvq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Dec 2021 11:51:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D0EC061574
        for <linux-pci@vger.kernel.org>; Wed, 15 Dec 2021 08:51:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C2A4EB8201D
        for <linux-pci@vger.kernel.org>; Wed, 15 Dec 2021 16:51:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCD71C36AE2;
        Wed, 15 Dec 2021 16:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639587103;
        bh=vMQsNr0NeQOxw0Kg7kSbPxAbl+2m2Im1J0P/kk9IFjY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K6/kAoG9yCTh3xtVydujoehP0IoWGZqG4bZipIg6E4yVq/cAk3dzjH3W9DFbdldP7
         pNlNoQENfnshxUm2X13SkVolPA3zknyfOWx87wkuY0F2N+G2raKji8YOK0kC1A2xtK
         PV6Y6WCw0VeT5ve4yGraA/MCav9H2x0wwMAtDZho8XJ2U8jFpW+ZlTM/xStNugCUrB
         P/aGrULxT395uNvu0vRGIHmMR3ci4F66xlWw+oHtmSjCr6q2+Kn4QyFENOrzUbZHpC
         Ze5fBAqSFc1b4vcnu2dONN/e24Akt2WkffSrKHjUv8YqecUbdTDvjihka1nwiAmZ/L
         fqwAf6rnSfapg==
Date:   Wed, 15 Dec 2021 08:51:40 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Barry Long <barry@epiqsolutions.com>
Subject: Re: IMX8MM PCIe performance evaluated with NVMe
Message-ID: <20211215165140.GA4164278@dhcp-10-100-145-180.wdc.com>
References: <CAJ+vNU0OZvy4RamHZ18aJ6+AiO3BxXQx-3-sQYop6sF1QRMmwA@mail.gmail.com>
 <20211203233131.GE3839336@dhcp-10-100-145-180.wdc.com>
 <CAJ+vNU3rEgc+G67ETAcSo6FaLc39AoMzwrxmY8jQLN0VOShkyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ+vNU3rEgc+G67ETAcSo6FaLc39AoMzwrxmY8jQLN0VOShkyA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 15, 2021 at 08:26:37AM -0800, Tim Harvey wrote:
> On Fri, Dec 3, 2021 at 3:31 PM Keith Busch <kbusch@kernel.org> wrote:
> > On Fri, Dec 03, 2021 at 01:52:17PM -0800, Tim Harvey wrote:
> > > What would a more appropriate way of testing PCIe performance be?
> >
> > Beyond the protocol overhead, 'dd' is probably not going to be the best
> > way to meausre a device's performance. This sends just one command at a
> > time, so you are also measuring the full software stack latency, which
> > includes a system call and interrupt driven context switches. The PCIe
> > traffic would be idle during this overhead when running at just qd1.
> >
> > I am guessing your x86 is simply faster at executing through this
> > software stack than your imx8mm, so the software latency is lower.
> >
> > A better approach may be to use higher queue depths with batched
> > submissions so that your software overhead can occur concurrently with
> > your PCIe traffic. Also, you can eliminate interrupt context switches if
> > you use polled IO queues.
> 
> Thanks for the response!
> 
> The roughly 266MB/s performance results I've got on IMX8MM gen2 x1
> using NVMe and plain old 'dd' is on par with what another has found
> using a custom PCIe device of theirs and a simple loopback test so I
> feel that the 'software stack' isn't the bottleneck here (as that's
> removed in his situation). I'm leaning towards something like
> interrupt latency. I'll have to dig into the NVMe device driver and
> see if there is a way to hack it to poll to see what the difference
> is.

You don't need to hack anything, the driver already supports polling.
You just need to enable the poll queues (they're off by default). For
example, you can turn on 2 polled queues with kernel parameter:

  nvme.poll_queues=2

After booting with that, you just need to submit IO with the HIPRI flag.
The 'dd' command can't do that, so I think you'll need to use 'fio'. An
example command that will run the same workload as your 'dd' example,
but with polling:

  fio --name=global --filename=/dev/nvme1n1 --rw=read --ioengine=pvsync2 --bs=1M --direct=1 --hipri --name=test

To verify that polling is actually happening, the fio output for "cpu"
stats should show something like "sys=99%".
