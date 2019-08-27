Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8DEC9F66F
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2019 00:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbfH0WwG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Aug 2019 18:52:06 -0400
Received: from mga14.intel.com ([192.55.52.115]:42055 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725997AbfH0WwG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Aug 2019 18:52:06 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2019 15:52:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,439,1559545200"; 
   d="scan'208";a="188046761"
Received: from skuppusw-desk.jf.intel.com (HELO skuppusw-desk.amr.corp.intel.com) ([10.54.74.33])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Aug 2019 15:52:05 -0700
Date:   Tue, 27 Aug 2019 15:49:09 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Denis Efremov <efremov@linux.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] PCI: pciehp: Remove
 pciehp_green_led_{on,off,blink}()
Message-ID: <20190827224909.GF28404@skuppusw-desk.amr.corp.intel.com>
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
References: <20190819160643.27998-1-efremov@linux.com>
 <20190819160643.27998-5-efremov@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819160643.27998-5-efremov@linux.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 19, 2019 at 07:06:43PM +0300, Denis Efremov wrote:
> Remove pciehp_green_led_{on,off,blink}() and use pciehp_set_indicators()
> instead, since the code is mostly the same.
> 
> Signed-off-by: Denis Efremov <efremov@linux.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>  drivers/pci/hotplug/pciehp.h      |  3 ---
>  drivers/pci/hotplug/pciehp_ctrl.c | 12 ++++++++---
>  drivers/pci/hotplug/pciehp_hpc.c  | 36 -------------------------------
>  3 files changed, 9 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
> index acda513f37d7..da429345cf70 100644
> --- a/drivers/pci/hotplug/pciehp.h
> +++ b/drivers/pci/hotplug/pciehp.h
> @@ -170,9 +170,6 @@ void pciehp_get_power_status(struct controller *ctrl, u8 *status);
>  void pciehp_set_indicators(struct controller *ctrl, int pwr, int attn);
>  void pciehp_get_latch_status(struct controller *ctrl, u8 *status);
>  int pciehp_query_power_fault(struct controller *ctrl);
> -void pciehp_green_led_on(struct controller *ctrl);
> -void pciehp_green_led_off(struct controller *ctrl);
> -void pciehp_green_led_blink(struct controller *ctrl);
>  bool pciehp_card_present(struct controller *ctrl);
>  bool pciehp_card_present_or_link_active(struct controller *ctrl);
>  int pciehp_check_link_status(struct controller *ctrl);
> diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
> index 232f7bfcfce9..862fe86e87cc 100644
> --- a/drivers/pci/hotplug/pciehp_ctrl.c
> +++ b/drivers/pci/hotplug/pciehp_ctrl.c
> @@ -65,7 +65,9 @@ static int board_added(struct controller *ctrl)
>  			return retval;
>  	}
>  
> -	pciehp_green_led_blink(ctrl);
> +	pciehp_set_indicators(ctrl, PCI_EXP_SLTCTL_PWR_IND_BLINK,
> +			      PCI_EXP_SLTCTL_ATTN_IND_NONE);
> +
>  
>  	/* Check link training status */
>  	retval = pciehp_check_link_status(ctrl);
> @@ -124,7 +126,9 @@ static void remove_board(struct controller *ctrl, bool safe_removal)
>  	}
>  
>  	/* turn off Green LED */
> -	pciehp_green_led_off(ctrl);
> +	pciehp_set_indicators(ctrl, PCI_EXP_SLTCTL_PWR_IND_OFF,
> +			      PCI_EXP_SLTCTL_ATTN_IND_NONE);
> +
>  }
>  
>  static int pciehp_enable_slot(struct controller *ctrl);
> @@ -311,7 +315,9 @@ static int pciehp_enable_slot(struct controller *ctrl)
>  	pm_runtime_get_sync(&ctrl->pcie->port->dev);
>  	ret = __pciehp_enable_slot(ctrl);
>  	if (ret && ATTN_BUTTN(ctrl))
> -		pciehp_green_led_off(ctrl); /* may be blinking */
> +		/* may be blinking */
> +		pciehp_set_indicators(ctrl, PCI_EXP_SLTCTL_PWR_IND_OFF,
> +				      PCI_EXP_SLTCTL_ATTN_IND_NONE);
>  	pm_runtime_put(&ctrl->pcie->port->dev);
>  
>  	mutex_lock(&ctrl->state_lock);
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index 8f894fd5cd27..9dc1ecd703b9 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -447,42 +447,6 @@ void pciehp_set_indicators(struct controller *ctrl, int pwr, int attn)
>  	}
>  }
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
>  int pciehp_power_on_slot(struct controller *ctrl)
>  {
>  	struct pci_dev *pdev = ctrl_dev(ctrl);
> -- 
> 2.21.0
> 

-- 
-- 
Sathyanarayanan Kuppuswamy
Linux kernel developer
