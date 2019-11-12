Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98818F83D2
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2019 01:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfKLADh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Nov 2019 19:03:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:40882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726845AbfKLADh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Nov 2019 19:03:37 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 298B62184C;
        Tue, 12 Nov 2019 00:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573517016;
        bh=mTb3POXhOlsPBq7spO5FYEZfdRp43fDidFNghcrVcr8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=UKoWBDNivTk54+l8dAeSA6ZXxx3vnKhMmj8VSDEvEZqGFEYueTUmBYGRBrlJxYtVU
         Dgi6kt/wewbRGc5ebpjaoQc/wrRcoy+Pbfxd68orIyN2LmfVA2bQq46TkL7BgFD/h/
         NZJm13PcaM06aGorDCp/RuigmAOQOCV9XaALi6p8=
Date:   Mon, 11 Nov 2019 18:03:34 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     Doug Anderson <dianders@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Subject: Re: [BUG] rk3399-rockpro64 pcie synchronous external abort
Message-ID: <20191112000334.GA69183@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMdYzYo6mKSMXoDR7St1ynUJ9f3sh=0rgNAbbVvFAfJn82VvVQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Nov 10, 2019 at 10:43:48AM -0500, Peter Geis wrote:

> I plugged in an i350 two port nic and examined the assigned address spaces.
> I've attached it below.
> Judging by the usage, I think this controller has enough address space
> for another two port NIC, and that's about it.
> I'm pretty sure now that the rk3399 controller just doesn't have the
> address space to map larger devices.
> I'm pretty sure the IOMMU would allow us to address system memory as
> pcie address space and overcome this limitation, but I don't know how
> to do that.

I don't think you're out of MMIO space, at least in this instance.  It
looks like you have 32MB available and the two-port NIC on bus 01 only
takes 5MB.

The IOMMU is used for DMA (e.g., reads/writes initiated by the NIC),
while the MMIO space is used for CPU programmed I/O (reads/writes done
by the driver running on the CPU).

> The address space for the nic is below:
> f8000000-f8ffffff : axi-base
> fa000000-fbdfffff : MEM

32MB.

>   fa000000-fa4fffff : PCI Bus 0000:01

5MB.

>     fa000000-fa07ffff : 0000:01:00.0
>       fa000000-fa07ffff : igb
>     fa080000-fa0fffff : 0000:01:00.0
>     fa100000-fa17ffff : 0000:01:00.1
>       fa100000-fa17ffff : igb
>     fa180000-fa1fffff : 0000:01:00.1
>     fa200000-fa27ffff : 0000:01:00.0
>     fa280000-fa2fffff : 0000:01:00.0
>     fa300000-fa37ffff : 0000:01:00.1
>     fa380000-fa3fffff : 0000:01:00.1
>     fa400000-fa403fff : 0000:01:00.0
>       fa400000-fa403fff : igb
>     fa404000-fa407fff : 0000:01:00.1
>       fa404000-fa407fff : igb
> fd000000-fdffffff : f8000000.pcie
