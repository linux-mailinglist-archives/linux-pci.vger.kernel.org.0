Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71E8C31627D
	for <lists+linux-pci@lfdr.de>; Wed, 10 Feb 2021 10:39:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbhBJJjO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Feb 2021 04:39:14 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:12508 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbhBJJhG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Feb 2021 04:37:06 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DbF3Q5lGBzjLj2;
        Wed, 10 Feb 2021 17:34:58 +0800 (CST)
Received: from [127.0.0.1] (10.69.38.196) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.498.0; Wed, 10 Feb 2021
 17:36:19 +0800
Subject: Re: [PATCHv2 0/5] aer handling fixups
To:     Keith Busch <kbusch@kernel.org>, <linux-pci@vger.kernel.org>,
        "Bjorn Helgaas" <helgaas@kernel.org>
References: <20210104230300.1277180-1-kbusch@kernel.org>
From:   Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <6202386d-2783-ed08-4573-6b51ec55cc98@hisilicon.com>
Date:   Wed, 10 Feb 2021 17:36:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20210104230300.1277180-1-kbusch@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.38.196]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

I've tested the serial on Kunpeng 920 arm64 server and it works well.

Thanks.

On 2021/1/5 7:02, Keith Busch wrote:
> Changes from v1:
> 
>   Added received Acks
> 
>   Split the kernel print identifying the port type being reset.
> 
>   Added a patch for the portdrv to ensure the slot_reset happens without
>   relying on a downstream device driver..
> 
> Keith Busch (5):
>   PCI/ERR: Clear status of the reporting device
>   PCI/AER: Actually get the root port
>   PCI/ERR: Retain status from error notification
>   PCI/AER: Specify the type of port that was reset
>   PCI/portdrv: Report reset for frozen channel
> 
>  drivers/pci/pcie/aer.c         |  5 +++--
>  drivers/pci/pcie/err.c         | 16 +++++++---------
>  drivers/pci/pcie/portdrv_pci.c |  3 ++-
>  3 files changed, 12 insertions(+), 12 deletions(-)
> 

