Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4408A69E
	for <lists+linux-pci@lfdr.de>; Mon, 12 Aug 2019 20:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbfHLSwI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Aug 2019 14:52:08 -0400
Received: from mga01.intel.com ([192.55.52.88]:60457 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726656AbfHLSwI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Aug 2019 14:52:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Aug 2019 11:52:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,378,1559545200"; 
   d="scan'208";a="259888773"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 12 Aug 2019 11:52:07 -0700
Received: from [10.54.74.33] (skuppusw-desk.jf.intel.com [10.54.74.33])
        by linux.intel.com (Postfix) with ESMTP id 1FABD5806A0;
        Mon, 12 Aug 2019 11:52:07 -0700 (PDT)
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v2 1/4] PCI: pciehp: Add pciehp_set_indicators() to
 jointly set LED indicators
From:   sathyanarayanan kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Denis Efremov <efremov@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190811195944.23765-1-efremov@linux.com>
 <20190811195944.23765-2-efremov@linux.com>
 <925a00be-c2b6-697d-d46b-a279856105b4@linux.intel.com>
Organization: Intel
Message-ID: <d243b4e7-acd9-790f-9332-2654a908cf6e@linux.intel.com>
Date:   Mon, 12 Aug 2019 11:49:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <925a00be-c2b6-697d-d46b-a279856105b4@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 8/12/19 11:25 AM, sathyanarayanan kuppuswamy wrote:
> Hi,
>
> On 8/11/19 12:59 PM, Denis Efremov wrote:
>> Add pciehp_set_indicators() to set power and attention indicators with a
>> single register write. Thus, avoiding waiting twice for Command 
>> Complete.
>> enum pciehp_indicator introduced to switch between the indicators 
>> statuses.
>>
>> Signed-off-by: Denis Efremov <efremov@linux.com>
>> ---
>>   drivers/pci/hotplug/pciehp.h     | 14 ++++++++++++
>>   drivers/pci/hotplug/pciehp_hpc.c | 38 ++++++++++++++++++++++++++++++++
>>   include/uapi/linux/pci_regs.h    |  2 ++
>>   3 files changed, 54 insertions(+)
>>
>> diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
>> index 8c51a04b8083..17305a6f01f1 100644
>> --- a/drivers/pci/hotplug/pciehp.h
>> +++ b/drivers/pci/hotplug/pciehp.h
>> @@ -150,6 +150,17 @@ struct controller {
>>   #define NO_CMD_CMPL(ctrl)    ((ctrl)->slot_cap & PCI_EXP_SLTCAP_NCCS)
>>   #define PSN(ctrl)        (((ctrl)->slot_cap & PCI_EXP_SLTCAP_PSN) 
>> >> 19)
>>   +enum pciehp_indicator {
>> +    ATTN_NONE  = -1,
>> +    ATTN_ON    =  1,
>> +    ATTN_BLINK =  2,
>> +    ATTN_OFF   =  3,
>> +    PWR_NONE   = -1,
>> +    PWR_ON     =  1,
>> +    PWR_BLINK  =  2,
>> +    PWR_OFF    =  3,
>> +};
>> +
>>   void pciehp_request(struct controller *ctrl, int action);
>>   void pciehp_handle_button_press(struct controller *ctrl);
>>   void pciehp_handle_disable_request(struct controller *ctrl);
>> @@ -167,6 +178,9 @@ int pciehp_power_on_slot(struct controller *ctrl);
>>   void pciehp_power_off_slot(struct controller *ctrl);
>>   void pciehp_get_power_status(struct controller *ctrl, u8 *status);
>>   +void pciehp_set_indicators(struct controller *ctrl,
>> +               enum pciehp_indicator pwr,
>> +               enum pciehp_indicator attn);
>>   void pciehp_set_attention_status(struct controller *ctrl, u8 status);
>>   void pciehp_get_latch_status(struct controller *ctrl, u8 *status);
>>   int pciehp_query_power_fault(struct controller *ctrl);
>> diff --git a/drivers/pci/hotplug/pciehp_hpc.c 
>> b/drivers/pci/hotplug/pciehp_hpc.c
>> index bd990e3371e3..5a690b1579ec 100644
>> --- a/drivers/pci/hotplug/pciehp_hpc.c
>> +++ b/drivers/pci/hotplug/pciehp_hpc.c
>> @@ -443,6 +443,44 @@ void pciehp_set_attention_status(struct 
>> controller *ctrl, u8 value)
>>            pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, slot_cmd);
>>   }
>>   +void pciehp_set_indicators(struct controller *ctrl,
>> +               enum pciehp_indicator pwr,
>> +               enum pciehp_indicator attn)
>> +{
>> +    u16 cmd = 0, mask = 0;
>> +
>> +    if ((!PWR_LED(ctrl)  || pwr  == PWR_NONE) &&
>> +        (!ATTN_LED(ctrl) || attn == ATTN_NONE))
>> +        return;

Also I think this condition needs to expand to handle the case whether 
pwr != PWR_NONE and !PWR_LED(ctrl) is true.

you need to return for case, pwr = PWR_ON, !PWR_LED(ctrl)=true , 
!ATTN_LED(ctrl)=false, attn=on

>> +
>> +    switch (pwr) {
>> +    case PWR_ON:
>> +    case PWR_BLINK:
>> +    case PWR_OFF:
>> +        cmd = pwr << PCI_EXP_SLTCTL_PWR_IND_OFFSET;
>> +        mask = PCI_EXP_SLTCTL_PIC;
>> +        break;
>> +    default:
>> +        break;
>> +    }
> Do we need to switch case here ? if (pwr > 0) {} should work right ?
>> +
>> +    switch (attn) {
>> +    case ATTN_ON:
>> +    case ATTN_BLINK:
>> +    case ATTN_OFF:
>> +        cmd |= attn << PCI_EXP_SLTCTL_ATTN_IND_OFFSET;
>> +        mask |= PCI_EXP_SLTCTL_AIC;
>> +        break;
>> +    default:
>> +        break;
>> +    }
> Same here. if (attn > 0) {}
>> +
>> +    pcie_write_cmd_nowait(ctrl, cmd, mask);
>> +    ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
>> +         pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL,
>> +         cmd);
>> +}
>> +
>>   void pciehp_green_led_on(struct controller *ctrl)
>>   {
>>       if (!PWR_LED(ctrl))
>> diff --git a/include/uapi/linux/pci_regs.h 
>> b/include/uapi/linux/pci_regs.h
>> index f28e562d7ca8..18722d1f54a0 100644
>> --- a/include/uapi/linux/pci_regs.h
>> +++ b/include/uapi/linux/pci_regs.h
>> @@ -591,10 +591,12 @@
>>   #define  PCI_EXP_SLTCTL_CCIE    0x0010    /* Command Completed 
>> Interrupt Enable */
>>   #define  PCI_EXP_SLTCTL_HPIE    0x0020    /* Hot-Plug Interrupt 
>> Enable */
>>   #define  PCI_EXP_SLTCTL_AIC    0x00c0    /* Attention Indicator 
>> Control */
>> +#define  PCI_EXP_SLTCTL_ATTN_IND_OFFSET 0x6   /* Attention Indicator 
>> Offset */
>>   #define  PCI_EXP_SLTCTL_ATTN_IND_ON    0x0040 /* Attention 
>> Indicator on */
>>   #define  PCI_EXP_SLTCTL_ATTN_IND_BLINK 0x0080 /* Attention 
>> Indicator blinking */
>>   #define  PCI_EXP_SLTCTL_ATTN_IND_OFF   0x00c0 /* Attention 
>> Indicator off */
>>   #define  PCI_EXP_SLTCTL_PIC    0x0300    /* Power Indicator Control */
>> +#define  PCI_EXP_SLTCTL_PWR_IND_OFFSET 0x8    /* Power Indicator 
>> Offset */
>>   #define  PCI_EXP_SLTCTL_PWR_IND_ON     0x0100 /* Power Indicator on */
>>   #define  PCI_EXP_SLTCTL_PWR_IND_BLINK  0x0200 /* Power Indicator 
>> blinking */
>>   #define  PCI_EXP_SLTCTL_PWR_IND_OFF    0x0300 /* Power Indicator 
>> off */
>
-- 
Sathyanarayanan Kuppuswamy
Linux kernel developer

