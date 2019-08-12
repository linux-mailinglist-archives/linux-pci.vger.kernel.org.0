Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33AE48A7C4
	for <lists+linux-pci@lfdr.de>; Mon, 12 Aug 2019 22:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbfHLUDd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Aug 2019 16:03:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:33086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727312AbfHLUDd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Aug 2019 16:03:33 -0400
Received: from localhost (c-73-15-1-175.hsd1.ca.comcast.net [73.15.1.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25C242075B;
        Mon, 12 Aug 2019 20:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565640212;
        bh=txgLwBXJO7Nquw+xRaIsH0AHlPk07h2y7m3am637S9o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ttcLOwJiQ7o3Z1gXS0SSfbnD3lgHSYEQxVWk+BiQFA07c2EYp0mtoPMdq8gGlmGXO
         e41oBxxivbLPIJm1d/AkU/JrV0vWJSLDfQiqE4wXUXEIunzyj+HJePP4svfpZHvxm9
         8ca3mdpFs0xbpgowxST348sUMmFV8N51FU6z5b/w=
Date:   Mon, 12 Aug 2019 15:03:30 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Denis Efremov <efremov@linux.com>
Cc:     Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] PCI: pciehp: Replace
 pciehp_green_led_{on,off,blink}()
Message-ID: <20190812200330.GH11785@google.com>
References: <20190811195944.23765-1-efremov@linux.com>
 <20190811195944.23765-5-efremov@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190811195944.23765-5-efremov@linux.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Aug 11, 2019 at 10:59:44PM +0300, Denis Efremov wrote:
> This patch replaces pciehp_green_led_{on,off,blink}() with
> pciehp_set_indicators().
> 
> Reviewed-by: Lukas Wunner <lukas@wunner.de>
> Signed-off-by: Denis Efremov <efremov@linux.com>
> ---
>  drivers/pci/hotplug/pciehp.h     | 12 ++++++++---
>  drivers/pci/hotplug/pciehp_hpc.c | 36 --------------------------------
>  2 files changed, 9 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
> index 9a2a2d0db9d2..6cdcb1ca561f 100644
> --- a/drivers/pci/hotplug/pciehp.h
> +++ b/drivers/pci/hotplug/pciehp.h
> @@ -183,9 +183,6 @@ void pciehp_set_indicators(struct controller *ctrl,
>  			   enum pciehp_indicator attn);
>  void pciehp_get_latch_status(struct controller *ctrl, u8 *status);
>  int pciehp_query_power_fault(struct controller *ctrl);
> -void pciehp_green_led_on(struct controller *ctrl);
> -void pciehp_green_led_off(struct controller *ctrl);
> -void pciehp_green_led_blink(struct controller *ctrl);
>  bool pciehp_card_present(struct controller *ctrl);
>  bool pciehp_card_present_or_link_active(struct controller *ctrl);
>  int pciehp_check_link_status(struct controller *ctrl);
> @@ -202,6 +199,15 @@ int pciehp_get_raw_indicator_status(struct hotplug_slot *h_slot, u8 *status);
>  #define pciehp_set_attention_status(ctrl, status) \
>  	pciehp_set_indicators(ctrl, PWR_NONE, (status == 0 ? ATTN_OFF : status))
>  
> +#define pciehp_green_led_on(ctrl) \
> +	pciehp_set_indicators(ctrl, PWR_ON, ATTN_NONE)
> +
> +#define pciehp_green_led_off(ctrl) \
> +	pciehp_set_indicators(ctrl, PWR_OFF, ATTN_NONE)
> +
> +#define pciehp_green_led_blink(ctrl) \
> +	pciehp_set_indicators(ctrl, PWR_BLINK, ATTN_NONE)

You must have a reason, but why didn't you completely remove
pciehp_green_led_on(), etc, and change the callers to use
pciehp_set_indicators() instead?

>  static inline const char *slot_name(struct controller *ctrl)
>  {
>  	return hotplug_slot_name(&ctrl->hotplug_slot);
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index fb4bea16063a..8362d24405fd 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -456,42 +456,6 @@ void pciehp_set_indicators(struct controller *ctrl,
>  		 cmd);
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
