Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9E768A682
	for <lists+linux-pci@lfdr.de>; Mon, 12 Aug 2019 20:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfHLSsK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Aug 2019 14:48:10 -0400
Received: from mga01.intel.com ([192.55.52.88]:60127 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbfHLSsJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Aug 2019 14:48:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Aug 2019 11:48:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,378,1559545200"; 
   d="scan'208";a="175974444"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 12 Aug 2019 11:48:04 -0700
Received: from [10.54.74.33] (skuppusw-desk.jf.intel.com [10.54.74.33])
        by linux.intel.com (Postfix) with ESMTP id 780E55806E7;
        Mon, 12 Aug 2019 11:48:04 -0700 (PDT)
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v2 4/4] PCI: pciehp: Replace
 pciehp_green_led_{on,off,blink}()
To:     Denis Efremov <efremov@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190811195944.23765-1-efremov@linux.com>
 <20190811195944.23765-5-efremov@linux.com>
From:   sathyanarayanan kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Organization: Intel
Message-ID: <2a17806f-7d4a-2988-08a8-a35b65265f66@linux.intel.com>
Date:   Mon, 12 Aug 2019 11:45:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190811195944.23765-5-efremov@linux.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 8/11/19 12:59 PM, Denis Efremov wrote:
> This patch replaces pciehp_green_led_{on,off,blink}() with
> pciehp_set_indicators().
>
> Reviewed-by: Lukas Wunner <lukas@wunner.de>
> Signed-off-by: Denis Efremov <efremov@linux.com>
Reviewed-by: Kuppuswamy Sathyanarayanan 
<sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>   drivers/pci/hotplug/pciehp.h     | 12 ++++++++---
>   drivers/pci/hotplug/pciehp_hpc.c | 36 --------------------------------
>   2 files changed, 9 insertions(+), 39 deletions(-)
>
> diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
> index 9a2a2d0db9d2..6cdcb1ca561f 100644
> --- a/drivers/pci/hotplug/pciehp.h
> +++ b/drivers/pci/hotplug/pciehp.h
> @@ -183,9 +183,6 @@ void pciehp_set_indicators(struct controller *ctrl,
>   			   enum pciehp_indicator attn);
>   void pciehp_get_latch_status(struct controller *ctrl, u8 *status);
>   int pciehp_query_power_fault(struct controller *ctrl);
> -void pciehp_green_led_on(struct controller *ctrl);
> -void pciehp_green_led_off(struct controller *ctrl);
> -void pciehp_green_led_blink(struct controller *ctrl);
>   bool pciehp_card_present(struct controller *ctrl);
>   bool pciehp_card_present_or_link_active(struct controller *ctrl);
>   int pciehp_check_link_status(struct controller *ctrl);
> @@ -202,6 +199,15 @@ int pciehp_get_raw_indicator_status(struct hotplug_slot *h_slot, u8 *status);
>   #define pciehp_set_attention_status(ctrl, status) \
>   	pciehp_set_indicators(ctrl, PWR_NONE, (status == 0 ? ATTN_OFF : status))
>   
> +#define pciehp_green_led_on(ctrl) \
> +	pciehp_set_indicators(ctrl, PWR_ON, ATTN_NONE)
> +
> +#define pciehp_green_led_off(ctrl) \
> +	pciehp_set_indicators(ctrl, PWR_OFF, ATTN_NONE)
> +
> +#define pciehp_green_led_blink(ctrl) \
> +	pciehp_set_indicators(ctrl, PWR_BLINK, ATTN_NONE)
> +
>   static inline const char *slot_name(struct controller *ctrl)
>   {
>   	return hotplug_slot_name(&ctrl->hotplug_slot);
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index fb4bea16063a..8362d24405fd 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -456,42 +456,6 @@ void pciehp_set_indicators(struct controller *ctrl,
>   		 cmd);
>   }
>   
> -void pciehp_green_led_on(struct controller *ctrl)
> -{
> -	if (!PWR_LED(ctrl))
> -		return;
> -
> -	pcie_write_cmd_nowait(ctrl, PCI_EXP_SLTCTL_PWR_IND_ON,
> -			      PCI_EXP_SLTCTL_PIC);
> -	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
> -		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL,
> -		 PCI_EXP_SLTCTL_PWR_IND_ON);
> -}
> -
> -void pciehp_green_led_off(struct controller *ctrl)
> -{
> -	if (!PWR_LED(ctrl))
> -		return;
> -
> -	pcie_write_cmd_nowait(ctrl, PCI_EXP_SLTCTL_PWR_IND_OFF,
> -			      PCI_EXP_SLTCTL_PIC);
> -	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
> -		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL,
> -		 PCI_EXP_SLTCTL_PWR_IND_OFF);
> -}
> -
> -void pciehp_green_led_blink(struct controller *ctrl)
> -{
> -	if (!PWR_LED(ctrl))
> -		return;
> -
> -	pcie_write_cmd_nowait(ctrl, PCI_EXP_SLTCTL_PWR_IND_BLINK,
> -			      PCI_EXP_SLTCTL_PIC);
> -	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
> -		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL,
> -		 PCI_EXP_SLTCTL_PWR_IND_BLINK);
> -}
> -
>   int pciehp_power_on_slot(struct controller *ctrl)
>   {
>   	struct pci_dev *pdev = ctrl_dev(ctrl);

-- 
Sathyanarayanan Kuppuswamy
Linux kernel developer

