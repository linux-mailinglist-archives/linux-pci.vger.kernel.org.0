Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62F9D8A7C2
	for <lists+linux-pci@lfdr.de>; Mon, 12 Aug 2019 22:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfHLUDW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Aug 2019 16:03:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:32958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727129AbfHLUDW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Aug 2019 16:03:22 -0400
Received: from localhost (c-73-15-1-175.hsd1.ca.comcast.net [73.15.1.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 876B4206C2;
        Mon, 12 Aug 2019 20:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565640201;
        bh=WDZPJLpabw45zOa10gt8lYsQMFOf95gicJwip9MeM/E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JY28O+jeZX9DjBmev9G2MtGrPwX97ZRopib/FN7ZdO09LqRbS3vxKucmzXQIMPmPR
         MJyV8Y/Kqpl760lrJ3M55JWqPciVKtiruIujNE+a8wVmYAgj+Gel1vdb9SU1h89B8H
         FDMqwW6IaAdgYFih23IDd3oW7S3YvdDihP3A5Eaw=
Date:   Mon, 12 Aug 2019 15:03:19 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Denis Efremov <efremov@linux.com>
Cc:     Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] PCI: pciehp: Add pciehp_set_indicators() to
 jointly set LED indicators
Message-ID: <20190812200319.GG11785@google.com>
References: <20190811195944.23765-1-efremov@linux.com>
 <20190811195944.23765-2-efremov@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190811195944.23765-2-efremov@linux.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Aug 11, 2019 at 10:59:41PM +0300, Denis Efremov wrote:
> Add pciehp_set_indicators() to set power and attention indicators with a
> single register write. Thus, avoiding waiting twice for Command Complete.
> enum pciehp_indicator introduced to switch between the indicators statuses.
> 
> Signed-off-by: Denis Efremov <efremov@linux.com>
> ---
>  drivers/pci/hotplug/pciehp.h     | 14 ++++++++++++
>  drivers/pci/hotplug/pciehp_hpc.c | 38 ++++++++++++++++++++++++++++++++
>  include/uapi/linux/pci_regs.h    |  2 ++
>  3 files changed, 54 insertions(+)
> 
> diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
> index 8c51a04b8083..17305a6f01f1 100644
> --- a/drivers/pci/hotplug/pciehp.h
> +++ b/drivers/pci/hotplug/pciehp.h
> @@ -150,6 +150,17 @@ struct controller {
>  #define NO_CMD_CMPL(ctrl)	((ctrl)->slot_cap & PCI_EXP_SLTCAP_NCCS)
>  #define PSN(ctrl)		(((ctrl)->slot_cap & PCI_EXP_SLTCAP_PSN) >> 19)
>  
> +enum pciehp_indicator {
> +	ATTN_NONE  = -1,
> +	ATTN_ON    =  1,
> +	ATTN_BLINK =  2,
> +	ATTN_OFF   =  3,
> +	PWR_NONE   = -1,
> +	PWR_ON     =  1,
> +	PWR_BLINK  =  2,
> +	PWR_OFF    =  3,
> +};
> +
>  void pciehp_request(struct controller *ctrl, int action);
>  void pciehp_handle_button_press(struct controller *ctrl);
>  void pciehp_handle_disable_request(struct controller *ctrl);
> @@ -167,6 +178,9 @@ int pciehp_power_on_slot(struct controller *ctrl);
>  void pciehp_power_off_slot(struct controller *ctrl);
>  void pciehp_get_power_status(struct controller *ctrl, u8 *status);
>  
> +void pciehp_set_indicators(struct controller *ctrl,
> +			   enum pciehp_indicator pwr,
> +			   enum pciehp_indicator attn);
>  void pciehp_set_attention_status(struct controller *ctrl, u8 status);
>  void pciehp_get_latch_status(struct controller *ctrl, u8 *status);
>  int pciehp_query_power_fault(struct controller *ctrl);
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index bd990e3371e3..5a690b1579ec 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -443,6 +443,44 @@ void pciehp_set_attention_status(struct controller *ctrl, u8 value)
>  		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, slot_cmd);
>  }
>  
> +void pciehp_set_indicators(struct controller *ctrl,
> +			   enum pciehp_indicator pwr,
> +			   enum pciehp_indicator attn)
> +{
> +	u16 cmd = 0, mask = 0;
> +
> +	if ((!PWR_LED(ctrl)  || pwr  == PWR_NONE) &&
> +	    (!ATTN_LED(ctrl) || attn == ATTN_NONE))
> +		return;
> +
> +	switch (pwr) {
> +	case PWR_ON:
> +	case PWR_BLINK:
> +	case PWR_OFF:
> +		cmd = pwr << PCI_EXP_SLTCTL_PWR_IND_OFFSET;
> +		mask = PCI_EXP_SLTCTL_PIC;

Since you initialized cmd and mask above, I would use "|=" here so PWR
and ATTN are handled identically.

One thing I don't like about this is the implicit connection between
the pciehp_indicator enum values and the PCI_EXP_SLTCTL_ATTN_IND_ON
definitions and the fact that grepping for PCI_EXP_SLTCTL_ATTN_IND_ON
is now useless.  It was *mostly* useless before, but here we might
have a chance to make it useful.

What would it look like if you had the caller pass in those values
directly, e.g.,

  pciehp_set_indicators(ctrl, PCI_EXP_SLTCTL_PWR_IND_OFF,
                              PCI_EXP_SLTCTL_ATTN_IND_ON);

I guess you'd still have to define a "NONE" value to mean "leave the
indicator unchanged", but you wouldn't need to define the shift, and
it would make it one step easier to find places that turn on an
indicator.

> +		break;
> +	default:
> +		break;

The "default:" case is superfluous.

> +	}
> +
> +	switch (attn) {
> +	case ATTN_ON:
> +	case ATTN_BLINK:
> +	case ATTN_OFF:
> +		cmd |= attn << PCI_EXP_SLTCTL_ATTN_IND_OFFSET;
> +		mask |= PCI_EXP_SLTCTL_AIC;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	pcie_write_cmd_nowait(ctrl, cmd, mask);
> +	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
> +		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL,
> +		 cmd);
> +}
> +
>  void pciehp_green_led_on(struct controller *ctrl)
>  {
>  	if (!PWR_LED(ctrl))
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index f28e562d7ca8..18722d1f54a0 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -591,10 +591,12 @@
>  #define  PCI_EXP_SLTCTL_CCIE	0x0010	/* Command Completed Interrupt Enable */
>  #define  PCI_EXP_SLTCTL_HPIE	0x0020	/* Hot-Plug Interrupt Enable */
>  #define  PCI_EXP_SLTCTL_AIC	0x00c0	/* Attention Indicator Control */
> +#define  PCI_EXP_SLTCTL_ATTN_IND_OFFSET 0x6   /* Attention Indicator Offset */

This is typically named *_SHIFT and expressed in decimal.

>  #define  PCI_EXP_SLTCTL_ATTN_IND_ON    0x0040 /* Attention Indicator on */
>  #define  PCI_EXP_SLTCTL_ATTN_IND_BLINK 0x0080 /* Attention Indicator blinking */
>  #define  PCI_EXP_SLTCTL_ATTN_IND_OFF   0x00c0 /* Attention Indicator off */
>  #define  PCI_EXP_SLTCTL_PIC	0x0300	/* Power Indicator Control */
> +#define  PCI_EXP_SLTCTL_PWR_IND_OFFSET 0x8    /* Power Indicator Offset */
>  #define  PCI_EXP_SLTCTL_PWR_IND_ON     0x0100 /* Power Indicator on */
>  #define  PCI_EXP_SLTCTL_PWR_IND_BLINK  0x0200 /* Power Indicator blinking */
>  #define  PCI_EXP_SLTCTL_PWR_IND_OFF    0x0300 /* Power Indicator off */
> -- 
> 2.21.0
> 
