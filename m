Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22DB1116E89
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2019 15:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbfLIOHF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Dec 2019 09:07:05 -0500
Received: from foss.arm.com ([217.140.110.172]:33462 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726687AbfLIOHF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 9 Dec 2019 09:07:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C42E328;
        Mon,  9 Dec 2019 06:07:05 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 543EA3F718;
        Mon,  9 Dec 2019 06:07:04 -0800 (PST)
Subject: Re: [Question] rk3399 vfio-pci/sr-iov support
To:     Peter Geis <pgwipeout@gmail.com>, Heiko Stuebner <heiko@sntech.de>
Cc:     "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-pci@vger.kernel.org
References: <CAMdYzYoPXWbv4zXet6c9JQEMbqcJi6ZEOui_n82NVmrqNLy_pw@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <b597b9a6-870a-8fbd-6490-59734c04367f@arm.com>
Date:   Mon, 9 Dec 2019 14:07:02 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAMdYzYoPXWbv4zXet6c9JQEMbqcJi6ZEOui_n82NVmrqNLy_pw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 09/12/2019 1:28 pm, Peter Geis wrote:
> Good Morning,
> 
> I'm back with more pcie fun on the rk3399.
> I'm trying to get pcie passthrough working for a vm on the rk3399, and
> have encountered some roadblocks.
> 
> First, vfio-pci doesn't work on the rk3399, as the pcie controller
> doesn't bind explicitly to a iommu.
> [37528.138212] vfio-pci 0000:01:00.0: assign IRQ: got 226
> [37528.138254] vfio-pci: probe of 0000:01:00.0 failed with error -22
> 
> # find /sys/kernel/iommu_groups/ -type l
> /sys/kernel/iommu_groups/1/devices/ff8f0000.vop
> /sys/kernel/iommu_groups/2/devices/ff900000.vop
> 
> # virsh start openwrt
> error: Failed to start domain openwrt
> error: internal error: Process exited prior to exec: libvirt:  error :
> internal error: Invalid device 0000:01:00.0 iommu_group file
> /sys/bus/pci/devices/0000:01:00.0/iommu_group is not a symlink

That much I can help with somewhat: the major impediment is that RK3399 
doesn't have an IOMMU in front of PCIe. As far as I'm aware your only 
option is to resort to the "here be dragons" CONFIG_VFIO_NOIOMMU mode 
(which I don't know an awful lot about beyond that it's a thing).

Robin.

> Second, sr-iov support is broken.
> root@rockpro64:/sys/bus/pci/devices/0000:01:00.0# echo 1 > sriov_numvfs
> bash: echo: write error: Input/output error
> [37352.907558] pci 0000:01:10.0: [8086:1520] type 7f class 0xffffff
> [37352.907578] pci 0000:01:10.0: unknown header type 7f, ignoring device
> 
> Do any of y'all have some insight into these issues?
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
> 
