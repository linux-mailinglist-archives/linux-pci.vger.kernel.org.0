Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 477988A657
	for <lists+linux-pci@lfdr.de>; Mon, 12 Aug 2019 20:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbfHLSbP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Aug 2019 14:31:15 -0400
Received: from mga01.intel.com ([192.55.52.88]:58790 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726236AbfHLSbP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Aug 2019 14:31:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Aug 2019 11:31:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,378,1559545200"; 
   d="scan'208";a="327440707"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 12 Aug 2019 11:31:14 -0700
Received: from [10.54.74.33] (skuppusw-desk.jf.intel.com [10.54.74.33])
        by linux.intel.com (Postfix) with ESMTP id 330565806A0;
        Mon, 12 Aug 2019 11:31:14 -0700 (PDT)
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v2 3/4] PCI: pciehp: Replace pciehp_set_attention_status()
To:     Denis Efremov <efremov@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190811195944.23765-1-efremov@linux.com>
 <20190811195944.23765-4-efremov@linux.com>
From:   sathyanarayanan kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Organization: Intel
Message-ID: <50d00be6-c904-af0c-2704-389965aae666@linux.intel.com>
Date:   Mon, 12 Aug 2019 11:28:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190811195944.23765-4-efremov@linux.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 8/11/19 12:59 PM, Denis Efremov wrote:
> This patch replaces pciehp_set_attention_status() with
> pciehp_set_indicators().
>
> Signed-off-by: Denis Efremov <efremov@linux.com>
Reviewed-by: Kuppuswamy Sathyanarayanan 
<sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>   drivers/pci/hotplug/pciehp.h     |  4 +++-
>   drivers/pci/hotplug/pciehp_hpc.c | 25 -------------------------
>   2 files changed, 3 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
> index 17305a6f01f1..9a2a2d0db9d2 100644
> --- a/drivers/pci/hotplug/pciehp.h
> +++ b/drivers/pci/hotplug/pciehp.h
> @@ -181,7 +181,6 @@ void pciehp_get_power_status(struct controller *ctrl, u8 *status);
>   void pciehp_set_indicators(struct controller *ctrl,
>   			   enum pciehp_indicator pwr,
>   			   enum pciehp_indicator attn);
> -void pciehp_set_attention_status(struct controller *ctrl, u8 status);
>   void pciehp_get_latch_status(struct controller *ctrl, u8 *status);
>   int pciehp_query_power_fault(struct controller *ctrl);
>   void pciehp_green_led_on(struct controller *ctrl);
> @@ -200,6 +199,9 @@ int pciehp_get_attention_status(struct hotplug_slot *hotplug_slot, u8 *status);
>   int pciehp_set_raw_indicator_status(struct hotplug_slot *h_slot, u8 status);
>   int pciehp_get_raw_indicator_status(struct hotplug_slot *h_slot, u8 *status);
>   
> +#define pciehp_set_attention_status(ctrl, status) \
> +	pciehp_set_indicators(ctrl, PWR_NONE, (status == 0 ? ATTN_OFF : status))
> +
>   static inline const char *slot_name(struct controller *ctrl)
>   {
>   	return hotplug_slot_name(&ctrl->hotplug_slot);
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index 68b880bc30db..fb4bea16063a 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -418,31 +418,6 @@ int pciehp_set_raw_indicator_status(struct hotplug_slot *hotplug_slot,
>   	return 0;
>   }
>   
> -void pciehp_set_attention_status(struct controller *ctrl, u8 value)
> -{
> -	u16 slot_cmd;
> -
> -	if (!ATTN_LED(ctrl))
> -		return;
> -
> -	switch (value) {
> -	case 0:		/* turn off */
> -		slot_cmd = PCI_EXP_SLTCTL_ATTN_IND_OFF;
> -		break;
> -	case 1:		/* turn on */
> -		slot_cmd = PCI_EXP_SLTCTL_ATTN_IND_ON;
> -		break;
> -	case 2:		/* turn blink */
> -		slot_cmd = PCI_EXP_SLTCTL_ATTN_IND_BLINK;
> -		break;
> -	default:
> -		return;
> -	}
> -	pcie_write_cmd_nowait(ctrl, slot_cmd, PCI_EXP_SLTCTL_AIC);
> -	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
> -		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, slot_cmd);
> -}
> -
>   void pciehp_set_indicators(struct controller *ctrl,
>   			   enum pciehp_indicator pwr,
>   			   enum pciehp_indicator attn)

-- 
Sathyanarayanan Kuppuswamy
Linux kernel developer

