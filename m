Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 136D28A654
	for <lists+linux-pci@lfdr.de>; Mon, 12 Aug 2019 20:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbfHLSaL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Aug 2019 14:30:11 -0400
Received: from mga05.intel.com ([192.55.52.43]:24975 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbfHLSaK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Aug 2019 14:30:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Aug 2019 11:30:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,378,1559545200"; 
   d="scan'208";a="178432066"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 12 Aug 2019 11:30:09 -0700
Received: from [10.54.74.33] (skuppusw-desk.jf.intel.com [10.54.74.33])
        by linux.intel.com (Postfix) with ESMTP id 8FF125806A0;
        Mon, 12 Aug 2019 11:30:09 -0700 (PDT)
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v2 2/4] PCI: pciehp: Switch LED indicators with a single
 write
To:     Denis Efremov <efremov@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190811195944.23765-1-efremov@linux.com>
 <20190811195944.23765-3-efremov@linux.com>
From:   sathyanarayanan kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Organization: Intel
Message-ID: <e96f6fe1-c76d-f264-7692-fc3d1c40cba4@linux.intel.com>
Date:   Mon, 12 Aug 2019 11:27:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190811195944.23765-3-efremov@linux.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 8/11/19 12:59 PM, Denis Efremov wrote:
> This patch replaces all consecutive switches of power and attention
> indicators with pciehp_set_indicators() call. Thus, performing only
> single write to a register.
>
> Reviewed-by: Lukas Wunner <lukas@wunner.de>
> Signed-off-by: Denis Efremov <efremov@linux.com>
Reviewed-by: Kuppuswamy Sathyanarayanan 
<sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>   drivers/pci/hotplug/pciehp_ctrl.c | 14 +++++---------
>   drivers/pci/hotplug/pciehp_hpc.c  |  3 +--
>   2 files changed, 6 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
> index 631ced0ab28a..258a4060466d 100644
> --- a/drivers/pci/hotplug/pciehp_ctrl.c
> +++ b/drivers/pci/hotplug/pciehp_ctrl.c
> @@ -42,8 +42,7 @@ static void set_slot_off(struct controller *ctrl)
>   		msleep(1000);
>   	}
>   
> -	pciehp_green_led_off(ctrl);
> -	pciehp_set_attention_status(ctrl, 1);
> +	pciehp_set_indicators(ctrl, PWR_OFF, ATTN_ON);
>   }
>   
>   /**
> @@ -90,8 +89,7 @@ static int board_added(struct controller *ctrl)
>   		}
>   	}
>   
> -	pciehp_green_led_on(ctrl);
> -	pciehp_set_attention_status(ctrl, 0);
> +	pciehp_set_indicators(ctrl, PWR_ON, ATTN_OFF);
>   	return 0;
>   
>   err_exit:
> @@ -172,8 +170,7 @@ void pciehp_handle_button_press(struct controller *ctrl)
>   				  slot_name(ctrl));
>   		}
>   		/* blink green LED and turn off amber */
> -		pciehp_green_led_blink(ctrl);
> -		pciehp_set_attention_status(ctrl, 0);
> +		pciehp_set_indicators(ctrl, PWR_BLINK, ATTN_OFF);
>   		schedule_delayed_work(&ctrl->button_work, 5 * HZ);
>   		break;
>   	case BLINKINGOFF_STATE:
> @@ -187,12 +184,11 @@ void pciehp_handle_button_press(struct controller *ctrl)
>   		cancel_delayed_work(&ctrl->button_work);
>   		if (ctrl->state == BLINKINGOFF_STATE) {
>   			ctrl->state = ON_STATE;
> -			pciehp_green_led_on(ctrl);
> +			pciehp_set_indicators(ctrl, PWR_ON, ATTN_OFF);
>   		} else {
>   			ctrl->state = OFF_STATE;
> -			pciehp_green_led_off(ctrl);
> +			pciehp_set_indicators(ctrl, PWR_OFF, ATTN_OFF);
>   		}
> -		pciehp_set_attention_status(ctrl, 0);
>   		ctrl_info(ctrl, "Slot(%s): Action canceled due to button press\n",
>   			  slot_name(ctrl));
>   		break;
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index 5a690b1579ec..68b880bc30db 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -676,8 +676,7 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
>   	if ((events & PCI_EXP_SLTSTA_PFD) && !ctrl->power_fault_detected) {
>   		ctrl->power_fault_detected = 1;
>   		ctrl_err(ctrl, "Slot(%s): Power fault\n", slot_name(ctrl));
> -		pciehp_set_attention_status(ctrl, 1);
> -		pciehp_green_led_off(ctrl);
> +		pciehp_set_indicators(ctrl, PWR_OFF, ATTN_ON);
>   	}
>   
>   	/*

-- 
Sathyanarayanan Kuppuswamy
Linux kernel developer

