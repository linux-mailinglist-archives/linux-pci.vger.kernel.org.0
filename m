Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E921E3EAB6C
	for <lists+linux-pci@lfdr.de>; Thu, 12 Aug 2021 22:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236112AbhHLT7w (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Aug 2021 15:59:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:48000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230171AbhHLT7w (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 12 Aug 2021 15:59:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A137E60FBF;
        Thu, 12 Aug 2021 19:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628798367;
        bh=M9MyqYO47NUoI+rSK25M9cleAgWnxVJ7RNwXJaCJ784=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=S0sstHONAg47gnc8TuM9hdMaI4FuTs1ssboJ4GN5T8mHA68t/zt66QenDgukc3poP
         7Cu2sGQ0rNJlPfWQeS9AvsoiYxHAnYfvXf6xAkh+ij3s4n3mSRtGAyLy6LWSK+LIvj
         ktTJrQoJn0UBhc2u06NNNSfdeLzytl8dZ5MQFA65emz3+V5PnrdvcfMfeOG4U+Od10
         5Hrz7WavVye8gbcn+lqvXJJNzaHVPqZZwhphJGmUb6s5iTMrRMocF11fOQsZJKZx3U
         W1iOsn8cHPY3pqIJkzpTB0yH8hUthUs7TGrnbLq9ylbBqXAXb13rQ+VtzZSlmtoShY
         vnreubjLEnGtA==
Date:   Thu, 12 Aug 2021 14:59:25 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Barry Song <21cnbao@gmail.com>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
        maz@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linuxarm@huawei.com,
        robin.murphy@arm.com, will@kernel.org, lorenzo.pieralisi@arm.com,
        dwmw@amazon.co.uk, Barry Song <song.bao.hua@hisilicon.com>
Subject: Re: [PATCH v2 0/2] msi: extend msi_irqs sysfs entries to platform
 devices
Message-ID: <20210812195925.GA2503574@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210812105341.51657-1-21cnbao@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 12, 2021 at 10:53:39PM +1200, Barry Song wrote:
> From: Barry Song <song.bao.hua@hisilicon.com>
> 
> Just like pci devices have msi_irqs which can be used by userspace irq affinity
> tools or applications to bind irqs, platform devices also widely support msi
> irqs.
> For platform devices, for example ARM SMMU, userspaces also care about its msi
> irqs as applications can know the mapping between devices and irqs and then
> make smarter decision on handling irq affinity. For example, for SVA mode,
> it is better to pin io page fault to the numa node applications are running
> on. Otherwise, io page fault will get a remote page from the node iopf happens
> rather than from the node applications are running on.
> 
> The first patch extracts the sysfs populate/destory code from PCI to
> MSI core. The 2nd patch lets platform-msi export msi_irqs entry so that
> userspace can know the mapping between devices and irqs for platform
> devices.
> 
> -v2:
>   extract common code for msi_irqs sysfs populate/destory from PCI to MSI core,
>   platform_device can directly reuse common code;
> 
> -v1:
>   https://lore.kernel.org/lkml/20210811105020.12980-1-song.bao.hua@hisilicon.com/
> 
> Barry Song (2):
>   genirq/msi: extract common sysfs populate entries to msi core from pci
>   platform-msi: Add ABI to show msi_irqs of platform devices
> 
>  Documentation/ABI/testing/sysfs-bus-platform |  14 +++
>  drivers/base/platform-msi.c                  |  10 ++
>  drivers/pci/msi.c                            | 124 ++-----------------------
>  include/linux/msi.h                          |   4 +
>  kernel/irq/msi.c                             | 134 +++++++++++++++++++++++++++
>  5 files changed, 171 insertions(+), 115 deletions(-)

I assume the IRQ guys will take care of this.

For the drivers/pci/ part:

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

But I would update the commit logs to consistently capitalize
initialisms.  Currently it's a mix of "PCI", "pci", "MSI", "msi",
"numa", "irq", "io", etc.

Also, if you rewrap the 2/2 commit log to fit in 75 columns, you won't
have a line that becomes 83 columns when "git log" indents it.  Maybe
also indent quoted things like the "ls" output by 2 spaces and add a
blank line before so the text doesn't run into them.
