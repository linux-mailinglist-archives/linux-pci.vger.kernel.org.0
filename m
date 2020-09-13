Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 507B6268013
	for <lists+linux-pci@lfdr.de>; Sun, 13 Sep 2020 18:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbgIMQEl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 13 Sep 2020 12:04:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:37116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbgIMQEj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 13 Sep 2020 12:04:39 -0400
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBD6121D80;
        Sun, 13 Sep 2020 16:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600013079;
        bh=861pDV1Q/RTdka0NF2nW8MAIWL5dIsU0iOY+sFyo2Qc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=slcH3TzozVcnrhC1id8P6rvQ9DWxOjYknOuL/kx9TKujeUt+s2W5SpemqlPtd52EA
         5abbBhe91+8bMAwW1lMtMrxcOtJ9lj5LdfixvYIiIbiyEFiTMkEoIpxxWtU6/aC7Yr
         IsWYZ8acSOul1WGsWTzyyzBjYmX+276H1axZts2w=
Date:   Sun, 13 Sep 2020 11:04:37 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        linux-pci@vger.kernel.org, Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: Re: [PATCH 2/2] PCI/portdrv: Don't disable pci device during shutdown
Message-ID: <20200913160437.GA1188602@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1599818977-25425-2-git-send-email-chenhc@lemote.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 11, 2020 at 06:09:37PM +0800, Huacai Chen wrote:
> Don't call pci_disable_device() in pcie_port_device_remove() during the
> portdrv's shutdown. This can avoid some poweroff/reboot failures.
> 
> The poweroff/reboot failures can easily reproduce on Loongson platforms.
> I think this is not a Loongson-specific problem, instead, is a problem
> related to some specific PCI hosts. On some x86 platforms, radeon/amdgpu
> devices can cause the same problem, and commit faefba95c9e8ca3a523831c2e
> ("drm/amdgpu: just suspend the hw on pci shutdown") can resolve it.
> 
> Radeon driver is more difficult than amdgpu due to its confusing symbol
> names, and I have maintained an out-of-tree patch for a long time [1].
> Recently, we found more and more devices can cause the same problem, and
> it is very difficult to modify all problematic drivers as radeon/amdgpu
> does. So, I think modify the PCIe port driver is a simple and effective
> way.

This needs to explain in more detail what the failure is and how this
patch fixes it.

The main thing pci_disable_device() does is turn off bus mastering, so
I assume this has to do with DMA during shutdown or reboot.  This
change is in portdrv, so it affects PCIe Root Ports and Switch Ports,
which of course are type 1 (bridge) devices.  Clearing
PCI_COMMAND_MASTER on bridges prevents them from forwarding memory or
I/O requests in the upstream direction, i.e., it prevents DMA from
devices below the bridge.

But if the problem is DMA, the same problem may occur with Root
Complex Integrated Endpoints or conventional PCI devices, since
portdrv may not be involved in those topologies.

> [1] https://github.com/chenhuacai/linux/commit/6612f9c1fc290d42a14618ce9a7d03014d8ebb1a
> 
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  drivers/pci/pcie/portdrv_core.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
> index 50a9522..1991aca 100644
> --- a/drivers/pci/pcie/portdrv_core.c
> +++ b/drivers/pci/pcie/portdrv_core.c
> @@ -491,7 +491,6 @@ void pcie_port_device_remove(struct pci_dev *dev)
>  {
>  	device_for_each_child(&dev->dev, NULL, remove_iter);
>  	pci_free_irq_vectors(dev);
> -	pci_disable_device(dev);
>  }
>  
>  /**
> -- 
> 2.7.0
> 
