Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4A1455989
	for <lists+linux-pci@lfdr.de>; Thu, 18 Nov 2021 12:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245742AbhKRLDr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Nov 2021 06:03:47 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:60255 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235730AbhKRLDq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Nov 2021 06:03:46 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=zhangliguang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UxCJ72c_1637233244;
Received: from 30.225.24.22(mailfrom:zhangliguang@linux.alibaba.com fp:SMTPD_---0UxCJ72c_1637233244)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 18 Nov 2021 19:00:44 +0800
Message-ID: <6bbac280-8f6f-2834-c51b-c7e72c22d504@linux.alibaba.com>
Date:   Thu, 18 Nov 2021 19:00:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH] PCI: pciehp: clear cmd_busy bit when Command Completed in
 polling mode
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lukas Wunner <lukas@wunner.de>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Amey Narkhede <ameynarkhede03@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211111054258.7309-1-zhangliguang@linux.alibaba.com>
From:   luanshi <zhangliguang@linux.alibaba.com>
In-Reply-To: <20211111054258.7309-1-zhangliguang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn & Lukas & Kuppuswamy & Amey,

Gentle ping! Any comments on this patch?


在 2021/11/11 13:42, Liguang Zhang 写道:
> This patch fixes this problem that on driver probe from system startup,
> pciehp checks the Presence Detect State bit in the Slot Status register
> to bring up an occupied slot or bring down an unoccupied slot. If empty
> slot's power status is on, turn power off. The Hot-Plug interrupt isn't
> requested yet, so avoid triggering a notification by calling
> pcie_disable_notification().
>
> Both the CCIE and HPIE bits are masked in pcie_disable_notification(),
> when we issue a hotplug command, pcie_wait_cmd() will polling the
> Command Completed bit instead of waiting for an interrupt. But cmd_busy
> bit was not cleared when Command Completed which results in timeouts
> like this in pciehp_power_off_slot() and pcie_init_notification():
>
>    pcieport 0000:00:03.0: pciehp: Timeout on hotplug command 0x01c0
> (issued 2264 msec ago)
>    pcieport 0000:00:03.0: pciehp: Timeout on hotplug command 0x05c0
> (issued 2288 msec ago)
>
> Signed-off-by: Liguang Zhang <zhangliguang@linux.alibaba.com>
> ---
>   drivers/pci/hotplug/pciehp_hpc.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index 83a0fa119cae..8698aefc6041 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -98,6 +98,8 @@ static int pcie_poll_cmd(struct controller *ctrl, int timeout)
>   		if (slot_status & PCI_EXP_SLTSTA_CC) {
>   			pcie_capability_write_word(pdev, PCI_EXP_SLTSTA,
>   						   PCI_EXP_SLTSTA_CC);
> +			ctrl->cmd_busy = 0;
> +			smp_mb();
>   			return 1;
>   		}
>   		msleep(10);
