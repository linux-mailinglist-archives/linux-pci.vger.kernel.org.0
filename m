Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFD9537A8E8
	for <lists+linux-pci@lfdr.de>; Tue, 11 May 2021 16:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbhEKOTk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 May 2021 10:19:40 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:2633 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbhEKOTk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 May 2021 10:19:40 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Ffg2Z0CKpzklhk;
        Tue, 11 May 2021 22:16:22 +0800 (CST)
Received: from [10.67.103.235] (10.67.103.235) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Tue, 11 May 2021 22:18:32 +0800
Subject: Re: [PATCH V2 0/5] PCI: Enable 10-Bit tag support for PCIe devices
To:     <helgaas@kernel.org>, <hch@infradead.org>,
        <linux-pci@vger.kernel.org>
References: <1620741585-53304-1-git-send-email-liudongdong3@huawei.com>
From:   Dongdong Liu <liudongdong3@huawei.com>
Message-ID: <0372e995-d9c4-d557-8c14-3392c36ad871@huawei.com>
Date:   Tue, 11 May 2021 22:18:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <1620741585-53304-1-git-send-email-liudongdong3@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.235]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patchset missed a patch [PATCH V2 5/5], ignore the patchset,
I will resend.

On 2021/5/11 21:59, Dongdong Liu wrote:
> 10-Bit Tag capability, introduced in PCIe-4.0 increases the total Tag
> field size from 8 bits to 10 bits.
>
> This patchset is to enable 10-Bit tag for PCIe EP devices (include VF) and
> RP devices.
>
> V1->V2: Fix some comments by Christoph.
> - Store the devcap2 value in the pci_dev instead of reading it multiple
>   times.
> - Change pci_info to pci_dbg to avoid the noisy log.
> - Rename ext_10bit_tag_comp_path to ext_10bit_tag.
> - Fix the compile error.
> - Rebased on v5.13-rc1.
>
> Dongdong Liu (5):
>   PCI: Use cached Device Capabilities 2 Register
>   PCI: Add 10-Bit Tag register definitions
>   PCI: Enable 10-Bit tag support for PCIe Endpoint devices
>   PCI/IOV: Enable 10-Bit tag support for PCIe VF devices
>   PCI: Enable 10-Bit tag support for PCIe RP devices
>
>  drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c |  4 +-
>  drivers/pci/iov.c                               |  8 +++
>  drivers/pci/pci.c                               |  8 +--
>  drivers/pci/pcie/portdrv_pci.c                  | 76 +++++++++++++++++++++++++
>  drivers/pci/probe.c                             | 54 ++++++++++++++++--
>  include/linux/pci.h                             |  3 +
>  include/uapi/linux/pci_regs.h                   |  5 ++
>  7 files changed, 144 insertions(+), 14 deletions(-)
>
> --
> 2.7.4
>
> .
>
