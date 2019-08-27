Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEF69F667
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2019 00:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbfH0Wut (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Aug 2019 18:50:49 -0400
Received: from mga05.intel.com ([192.55.52.43]:54470 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbfH0Wut (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Aug 2019 18:50:49 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2019 15:50:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,439,1559545200"; 
   d="scan'208";a="331971435"
Received: from skuppusw-desk.jf.intel.com (HELO skuppusw-desk.amr.corp.intel.com) ([10.54.74.33])
  by orsmga004.jf.intel.com with ESMTP; 27 Aug 2019 15:50:48 -0700
Date:   Tue, 27 Aug 2019 15:47:51 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Denis Efremov <efremov@linux.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] PCI: pciehp: Remove pciehp_set_attention_status()
Message-ID: <20190827224751.GE28404@skuppusw-desk.amr.corp.intel.com>
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
References: <20190819160643.27998-1-efremov@linux.com>
 <20190819160643.27998-4-efremov@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819160643.27998-4-efremov@linux.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 19, 2019 at 07:06:42PM +0300, Denis Efremov wrote:
> Remove pciehp_set_attention_status() and use pciehp_set_indicators()
> instead, since the code is mostly the same.
> 
> Signed-off-by: Denis Efremov <efremov@linux.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>  drivers/pci/hotplug/pciehp.h      |  1 -
>  drivers/pci/hotplug/pciehp_core.c |  7 ++++++-
>  drivers/pci/hotplug/pciehp_hpc.c  | 25 -------------------------
>  include/uapi/linux/pci_regs.h     |  1 +
>  4 files changed, 7 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
> index 0e272bf3deb4..acda513f37d7 100644
> --- a/drivers/pci/hotplug/pciehp.h
> +++ b/drivers/pci/hotplug/pciehp.h
> @@ -168,7 +168,6 @@ void pciehp_power_off_slot(struct controller *ctrl);
>  void pciehp_get_power_status(struct controller *ctrl, u8 *status);
>  
>  void pciehp_set_indicators(struct controller *ctrl, int pwr, int attn);
> -void pciehp_set_attention_status(struct controller *ctrl, u8 status);
>  void pciehp_get_latch_status(struct controller *ctrl, u8 *status);
>  int pciehp_query_power_fault(struct controller *ctrl);
>  void pciehp_green_led_on(struct controller *ctrl);
> diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
> index 6ad0d86762cb..7a86ea90ed94 100644
> --- a/drivers/pci/hotplug/pciehp_core.c
> +++ b/drivers/pci/hotplug/pciehp_core.c
> @@ -102,8 +102,13 @@ static int set_attention_status(struct hotplug_slot *hotplug_slot, u8 status)
>  	struct controller *ctrl = to_ctrl(hotplug_slot);
>  	struct pci_dev *pdev = ctrl->pcie->port;
>  
> +	if (status)
> +		status <<= PCI_EXP_SLTCTL_ATTN_IND_SHIFT;
> +	else
> +		status = PCI_EXP_SLTCTL_ATTN_IND_OFF;
> +
>  	pci_config_pm_runtime_get(pdev);
> -	pciehp_set_attention_status(ctrl, status);
> +	pciehp_set_indicators(ctrl, PCI_EXP_SLTCTL_PWR_IND_NONE, status);
>  	pci_config_pm_runtime_put(pdev);
>  	return 0;
>  }
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index aa4252d11be2..8f894fd5cd27 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -418,31 +418,6 @@ int pciehp_set_raw_indicator_status(struct hotplug_slot *hotplug_slot,
>  	return 0;
>  }
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
>  void pciehp_set_indicators(struct controller *ctrl, int pwr, int attn)
>  {
>  	u16 cmd = 0, mask = 0;
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 291788b58f3a..27d9f5bc1812 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -591,6 +591,7 @@
>  #define  PCI_EXP_SLTCTL_CCIE	0x0010	/* Command Completed Interrupt Enable */
>  #define  PCI_EXP_SLTCTL_HPIE	0x0020	/* Hot-Plug Interrupt Enable */
>  #define  PCI_EXP_SLTCTL_AIC	0x00c0	/* Attention Indicator Control */
> +#define  PCI_EXP_SLTCTL_ATTN_IND_SHIFT 6      /* Attention Indicator shift */
>  #define  PCI_EXP_SLTCTL_ATTN_IND_NONE  0x0    /* Attention Indicator noop */
>  #define  PCI_EXP_SLTCTL_ATTN_IND_ON    0x0040 /* Attention Indicator on */
>  #define  PCI_EXP_SLTCTL_ATTN_IND_BLINK 0x0080 /* Attention Indicator blinking */
> -- 
> 2.21.0
> 

-- 
-- 
Sathyanarayanan Kuppuswamy
Linux kernel developer
