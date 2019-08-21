Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF39898845
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2019 02:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729434AbfHVABR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Aug 2019 20:01:17 -0400
Received: from mga04.intel.com ([192.55.52.120]:7312 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728304AbfHVABR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 21 Aug 2019 20:01:17 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Aug 2019 17:01:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,414,1559545200"; 
   d="scan'208";a="190379464"
Received: from skuppusw-desk.jf.intel.com (HELO skuppusw-desk.amr.corp.intel.com) ([10.54.74.33])
  by orsmga002.jf.intel.com with ESMTP; 21 Aug 2019 17:01:16 -0700
Date:   Wed, 21 Aug 2019 16:58:24 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Denis Efremov <efremov@linux.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] PCI: pciehp: Add pciehp_set_indicators() to
 jointly set LED indicators
Message-ID: <20190821235824.GC28404@skuppusw-desk.amr.corp.intel.com>
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
References: <20190819160643.27998-1-efremov@linux.com>
 <20190819160643.27998-2-efremov@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819160643.27998-2-efremov@linux.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 19, 2019 at 07:06:40PM +0300, Denis Efremov wrote:
> Add pciehp_set_indicators() to set power and attention indicators with a
> single register write. Thus, avoiding waiting twice for Command Complete.
> 
> Signed-off-by: Denis Efremov <efremov@linux.com>
> ---
>  drivers/pci/hotplug/pciehp.h     |  1 +
>  drivers/pci/hotplug/pciehp_hpc.c | 29 +++++++++++++++++++++++++++++
>  include/uapi/linux/pci_regs.h    |  2 ++
>  3 files changed, 32 insertions(+)
> 
> diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
> index 8c51a04b8083..0e272bf3deb4 100644
> --- a/drivers/pci/hotplug/pciehp.h
> +++ b/drivers/pci/hotplug/pciehp.h
> @@ -167,6 +167,7 @@ int pciehp_power_on_slot(struct controller *ctrl);
>  void pciehp_power_off_slot(struct controller *ctrl);
>  void pciehp_get_power_status(struct controller *ctrl, u8 *status);
>  
> +void pciehp_set_indicators(struct controller *ctrl, int pwr, int attn);
>  void pciehp_set_attention_status(struct controller *ctrl, u8 status);
>  void pciehp_get_latch_status(struct controller *ctrl, u8 *status);
>  int pciehp_query_power_fault(struct controller *ctrl);
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index bd990e3371e3..5474b9854a7f 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -443,6 +443,35 @@ void pciehp_set_attention_status(struct controller *ctrl, u8 value)
>  		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, slot_cmd);
>  }
>  
> +void pciehp_set_indicators(struct controller *ctrl, int pwr, int attn)
> +{
> +	u16 cmd = 0, mask = 0;
> +
> +	if (PWR_LED(ctrl))
> +		switch (pwr) {
> +		case PCI_EXP_SLTCTL_PWR_IND_ON:
> +		case PCI_EXP_SLTCTL_PWR_IND_BLINK:
> +		case PCI_EXP_SLTCTL_PWR_IND_OFF:
> +			cmd |= pwr;
> +			mask |= PCI_EXP_SLTCTL_PIC;
> +		}
> +
> +	if (ATTN_LED(ctrl))
> +		switch (attn) {
> +		case PCI_EXP_SLTCTL_ATTN_IND_ON:
> +		case PCI_EXP_SLTCTL_ATTN_IND_BLINK:
> +		case PCI_EXP_SLTCTL_ATTN_IND_OFF:
> +			cmd |= attn;
> +			mask |= PCI_EXP_SLTCTL_AIC;
> +		}
> +
> +	if (cmd) {
> +		pcie_write_cmd_nowait(ctrl, cmd, mask);
> +		ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
> +			 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, cmd);
> +	}
> +}
> +
>  void pciehp_green_led_on(struct controller *ctrl)
>  {
>  	if (!PWR_LED(ctrl))
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index f28e562d7ca8..291788b58f3a 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -591,10 +591,12 @@
>  #define  PCI_EXP_SLTCTL_CCIE	0x0010	/* Command Completed Interrupt Enable */
>  #define  PCI_EXP_SLTCTL_HPIE	0x0020	/* Hot-Plug Interrupt Enable */
>  #define  PCI_EXP_SLTCTL_AIC	0x00c0	/* Attention Indicator Control */
> +#define  PCI_EXP_SLTCTL_ATTN_IND_NONE  0x0    /* Attention Indicator noop */
>  #define  PCI_EXP_SLTCTL_ATTN_IND_ON    0x0040 /* Attention Indicator on */
>  #define  PCI_EXP_SLTCTL_ATTN_IND_BLINK 0x0080 /* Attention Indicator blinking */
>  #define  PCI_EXP_SLTCTL_ATTN_IND_OFF   0x00c0 /* Attention Indicator off */
>  #define  PCI_EXP_SLTCTL_PIC	0x0300	/* Power Indicator Control */
> +#define  PCI_EXP_SLTCTL_PWR_IND_NONE   0x0    /* Power Indicator noop */
Nitpick: Since the current patch does not use it, May be you can create a
new patch for these #defines ? or you could add some info about its
usage in comment section.
>  #define  PCI_EXP_SLTCTL_PWR_IND_ON     0x0100 /* Power Indicator on */
>  #define  PCI_EXP_SLTCTL_PWR_IND_BLINK  0x0200 /* Power Indicator blinking */
>  #define  PCI_EXP_SLTCTL_PWR_IND_OFF    0x0300 /* Power Indicator off */
> -- 
> 2.21.0
> 

-- 
-- 
Sathyanarayanan Kuppuswamy
Linux kernel developer
