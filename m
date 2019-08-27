Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC8D39F648
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2019 00:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbfH0Wjv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Aug 2019 18:39:51 -0400
Received: from mga02.intel.com ([134.134.136.20]:60493 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbfH0Wju (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Aug 2019 18:39:50 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2019 15:39:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,438,1559545200"; 
   d="scan'208";a="192395592"
Received: from skuppusw-desk.jf.intel.com (HELO skuppusw-desk.amr.corp.intel.com) ([10.54.74.33])
  by orsmga002.jf.intel.com with ESMTP; 27 Aug 2019 15:39:50 -0700
Date:   Tue, 27 Aug 2019 15:36:53 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Denis Efremov <efremov@linux.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] PCI: pciehp: Switch LED indicators with a single
 write
Message-ID: <20190827223653.GD28404@skuppusw-desk.amr.corp.intel.com>
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
References: <20190819160643.27998-1-efremov@linux.com>
 <20190819160643.27998-3-efremov@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819160643.27998-3-efremov@linux.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 19, 2019 at 07:06:41PM +0300, Denis Efremov wrote:
> This patch replaces all consecutive switches of power and attention
> indicators with pciehp_set_indicators() call. Thus, performing only
> single write to a register.
> 
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Reviewed-by: Lukas Wunner <lukas@wunner.de>
> Signed-off-by: Denis Efremov <efremov@linux.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>  drivers/pci/hotplug/pciehp_ctrl.c | 19 ++++++++++---------
>  drivers/pci/hotplug/pciehp_hpc.c  |  4 ++--
>  2 files changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
> index 631ced0ab28a..232f7bfcfce9 100644
> --- a/drivers/pci/hotplug/pciehp_ctrl.c
> +++ b/drivers/pci/hotplug/pciehp_ctrl.c
> @@ -42,8 +42,8 @@ static void set_slot_off(struct controller *ctrl)
>  		msleep(1000);
>  	}
>  
> -	pciehp_green_led_off(ctrl);
> -	pciehp_set_attention_status(ctrl, 1);
> +	pciehp_set_indicators(ctrl, PCI_EXP_SLTCTL_PWR_IND_OFF,
> +			      PCI_EXP_SLTCTL_ATTN_IND_ON);
>  }
>  
>  /**
> @@ -90,8 +90,8 @@ static int board_added(struct controller *ctrl)
>  		}
>  	}
>  
> -	pciehp_green_led_on(ctrl);
> -	pciehp_set_attention_status(ctrl, 0);
> +	pciehp_set_indicators(ctrl, PCI_EXP_SLTCTL_PWR_IND_ON,
> +			      PCI_EXP_SLTCTL_ATTN_IND_OFF);
>  	return 0;
>  
>  err_exit:
> @@ -172,8 +172,8 @@ void pciehp_handle_button_press(struct controller *ctrl)
>  				  slot_name(ctrl));
>  		}
>  		/* blink green LED and turn off amber */
> -		pciehp_green_led_blink(ctrl);
> -		pciehp_set_attention_status(ctrl, 0);
> +		pciehp_set_indicators(ctrl, PCI_EXP_SLTCTL_PWR_IND_BLINK,
> +				      PCI_EXP_SLTCTL_ATTN_IND_OFF);
>  		schedule_delayed_work(&ctrl->button_work, 5 * HZ);
>  		break;
>  	case BLINKINGOFF_STATE:
> @@ -187,12 +187,13 @@ void pciehp_handle_button_press(struct controller *ctrl)
>  		cancel_delayed_work(&ctrl->button_work);
>  		if (ctrl->state == BLINKINGOFF_STATE) {
>  			ctrl->state = ON_STATE;
> -			pciehp_green_led_on(ctrl);
> +			pciehp_set_indicators(ctrl, PCI_EXP_SLTCTL_PWR_IND_ON,
> +					      PCI_EXP_SLTCTL_ATTN_IND_OFF);
>  		} else {
>  			ctrl->state = OFF_STATE;
> -			pciehp_green_led_off(ctrl);
> +			pciehp_set_indicators(ctrl, PCI_EXP_SLTCTL_PWR_IND_OFF,
> +					      PCI_EXP_SLTCTL_ATTN_IND_OFF);
>  		}
> -		pciehp_set_attention_status(ctrl, 0);
>  		ctrl_info(ctrl, "Slot(%s): Action canceled due to button press\n",
>  			  slot_name(ctrl));
>  		break;
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index 5474b9854a7f..aa4252d11be2 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -667,8 +667,8 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
>  	if ((events & PCI_EXP_SLTSTA_PFD) && !ctrl->power_fault_detected) {
>  		ctrl->power_fault_detected = 1;
>  		ctrl_err(ctrl, "Slot(%s): Power fault\n", slot_name(ctrl));
> -		pciehp_set_attention_status(ctrl, 1);
> -		pciehp_green_led_off(ctrl);
> +		pciehp_set_indicators(ctrl, PCI_EXP_SLTCTL_PWR_IND_OFF,
> +				      PCI_EXP_SLTCTL_ATTN_IND_ON);
>  	}
>  
>  	/*
> -- 
> 2.21.0
> 

-- 
-- 
Sathyanarayanan Kuppuswamy
Linux kernel developer
