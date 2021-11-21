Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 139E9458171
	for <lists+linux-pci@lfdr.de>; Sun, 21 Nov 2021 02:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237643AbhKUBxo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 20 Nov 2021 20:53:44 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:36157 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237631AbhKUBxo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 20 Nov 2021 20:53:44 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R941e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=zhangliguang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UxSv4gj_1637459437;
Received: from 30.39.229.109(mailfrom:zhangliguang@linux.alibaba.com fp:SMTPD_---0UxSv4gj_1637459437)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 21 Nov 2021 09:50:38 +0800
Message-ID: <d226b80f-8e11-dcf9-084b-af22f4803b93@linux.alibaba.com>
Date:   Sun, 21 Nov 2021 09:50:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH] PCI: pciehp: clear cmd_busy bit when Command Completed in
 polling mode
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Amey Narkhede <ameynarkhede03@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211111054258.7309-1-zhangliguang@linux.alibaba.com>
 <20211119120012.GC9692@wunner.de>
From:   luanshi <zhangliguang@linux.alibaba.com>
In-Reply-To: <20211119120012.GC9692@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi，thanks for your comments.

在 2021/11/19 20:00, Lukas Wunner 写道:
> On Thu, Nov 11, 2021 at 01:42:58PM +0800, Liguang Zhang wrote:
>> Both the CCIE and HPIE bits are masked in pcie_disable_notification(),
>> when we issue a hotplug command, pcie_wait_cmd() will polling the
>> Command Completed bit instead of waiting for an interrupt. But cmd_busy
>> bit was not cleared when Command Completed which results in timeouts
>> like this in pciehp_power_off_slot() and pcie_init_notification():
>>
>>    pcieport 0000:00:03.0: pciehp: Timeout on hotplug command 0x01c0
>> (issued 2264 msec ago)
>>    pcieport 0000:00:03.0: pciehp: Timeout on hotplug command 0x05c0
>> (issued 2288 msec ago)
> The first timeout occurs with the following bits set in ctrl->slot_ctrl:
>    PCI_EXP_SLTCTL_PWR_IND_ON | PCI_EXP_SLTCTL_ATTN_IND_OFF

After some debug, the first timeout occurs:

     pciehp_power_off_slot

         pcie_write_cmd(ctrl, PCI_EXP_SLTCTL_PWR_OFF, PCI_EXP_SLTCTL_PCC)

             pcie_do_write_cmd

                     /*
                      * Always wait for any previous command that might 
still be in progress
                      */
                     pcie_wait_cmd(ctrl);  // at the beginning

                         if (!ctrl->cmd_busy)  // cmd_busy was not zero
                             return;


Why cmd_busy was not flase, because in function 
pcie_disable_notification cmd_busy was not setting correctly:

     pcie_disable_notification  //  Both the CCIE and HPIE bits are masked

         pcie_write_cmd

             pcie_do_write_cmd

                 ctrl->cmd_busy = 1  // cmd_busy was setting to 1

                 pcie_wait_cmd

                     pcie_poll_cmd // pcie_wait_cmd() will polling the 
Command Completed bit instead of waiting for an interrupt

                          After debug we found Command Completed can be 
signaled without cmd_busy was setting to 0.


If we use interrupt mode pciehp_isr:

         pciehp_isr

             if (events & PCI_EXP_SLTSTA_CC) {
                 ctrl->cmd_busy = 0;  //  cmd_busy was setting to zero, 
this was left in pcie_poll_cmd.


Thanks,

Liguang

>
> Those bits are set by:
>    board_added()
>      pciehp_set_indicators()
>
>
> The second timeout occurs with:
>    PCI_EXP_SLTCTL_PWR_IND_ON | PCI_EXP_SLTCTL_ATTN_IND_OFF |
>    PCI_EXP_SLTCTL_PWR_OFF
>
> This might be triggered by:
>    remove_board()
>      pciehp_power_off_slot()
>
>
> So it seems Command Completed is not signaled when changing the
> Power Indicator, Attention Indicator and Power Controller Control
> bits in the Slot Control register.  But apparently it works for
> the other bits.
>
> We know there are hotplug controllers out there which suffer from
> broken Command Completed support.  They support it for the bits
> mentioned above but not the others.  So the inverse behavior from
> your hotplug controller.  See this code comment in pcie_do_write_cmd():
>
> 	/*
> 	 * Controllers with the Intel CF118 and similar errata advertise
> 	 * Command Completed support, but they only set Command Completed
> 	 * if we change the "Control" bits for power, power indicator,
> 	 * attention indicator, or interlock.  If we only change the
> 	 * "Enable" bits, they never set the Command Completed bit.
> 	 */
>
>
>> --- a/drivers/pci/hotplug/pciehp_hpc.c
>> +++ b/drivers/pci/hotplug/pciehp_hpc.c
>> @@ -98,6 +98,8 @@ static int pcie_poll_cmd(struct controller *ctrl, int timeout)
>>   		if (slot_status & PCI_EXP_SLTSTA_CC) {
>>   			pcie_capability_write_word(pdev, PCI_EXP_SLTSTA,
>>   						   PCI_EXP_SLTSTA_CC);
>> +			ctrl->cmd_busy = 0;
>> +			smp_mb();
>>   			return 1;
>>   		}
>>   		msleep(10);
> I suspect that this patch merely papers over the problem and that
> the real solution would be to either apply quirk_cmd_compl or a
> similar quirk to your hotplug controller.
>
> Please open a bug on bugzilla.kernel.org and attach full output
> of lspci -vv and dmesg.  Be sure to add the following to the
> command line:
>    pciehp.pciehp_debug=1 dyndbg="file pciehp* +p"
>
> Once you've done that, please report the bugzilla link here
> so that we can analyze the issue properly.
>
> Thanks,
>
> Lukas
