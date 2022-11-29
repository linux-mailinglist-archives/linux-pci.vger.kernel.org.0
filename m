Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE0F63C51E
	for <lists+linux-pci@lfdr.de>; Tue, 29 Nov 2022 17:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233851AbiK2Q1r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Nov 2022 11:27:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234009AbiK2Q1q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Nov 2022 11:27:46 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E066B91
        for <linux-pci@vger.kernel.org>; Tue, 29 Nov 2022 08:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669739264; x=1701275264;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NYi/8N6DlFu+e8mUYHCXilFTZbhJT6NGM8/+QoysgLI=;
  b=GhtehPIYh/IvksuuRA1Y1N6M5Nj3ZoqgS2thHEPf1J7ccVxd+8m4fZB6
   yils826d4rck1pGm4glaAuQ/C0Is95t9r3i7zEoUSmFC6sX6v+cKq64bx
   UEefqCqPZoYU9t1iGTgibQtMv7+Q89PfqYx1LD0mYQszQI1rBcAaM2ivI
   xpyPOprQ4hYFBSpURys4LNgX52yJgpaJ1PVCH55Rf3Zxj9BadeYten7a6
   mMnrG+3Dp/Eks3Mvj8EYO1J5CIMtIlkFxcJsppcKQgg8t/z45dFOUNvU+
   yIKEfRCd85h/Xx+HvoVKBnfa6DZ4qAorvmVm3nXM7i7Dp5oEtr/x6Voh5
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="379418621"
X-IronPort-AV: E=Sophos;i="5.96,203,1665471600"; 
   d="scan'208";a="379418621"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 08:27:43 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="676479494"
X-IronPort-AV: E=Sophos;i="5.96,203,1665471600"; 
   d="scan'208";a="676479494"
Received: from kichangj-mobl1.amr.corp.intel.com (HELO [10.212.162.3]) ([10.212.162.3])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 08:27:43 -0800
Message-ID: <b201a410-8593-6718-f76a-ea27ee5ab930@linux.intel.com>
Date:   Tue, 29 Nov 2022 08:27:43 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH] PCI/DPC: Add Software Trigger as reset method
Content-Language: en-US
To:     Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
        linux-pci@vger.kernel.org
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Amey Narkhede <ameynarkhede03@gmail.com>,
        Keith Busch <kbusch@kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi Kishore Koppuravuri <ravi.kishore.koppuravuri@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
References: <9c1533fd42e9002bd6d2020656fa1dd0e3e3bf3a.1669706952.git.lukas@wunner.de>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <9c1533fd42e9002bd6d2020656fa1dd0e3e3bf3a.1669706952.git.lukas@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lukas,

On 11/28/22 11:35 PM, Lukas Wunner wrote:
> Add DPC Software Trigger as a reset method to be used for silicon
> validation among other things:
> 
>   # echo dpc_sw_trigger > reset_method
>   # echo 1 > reset
> 
> After validating DPC, the default reset_method(s) may be reinstated:
> 
>   # echo default > reset_method
> 
> Writing the DPC Control Register requires that control was granted by
> firmware, so expose the reset_method only if DPC is native.  (And AER,
> which must always be granted or denied in unison per PCI Firmware Spec
> r3.3 table 4-5.)
> 
> The reset attribute in sysfs is meant to reset a single PCI Function,
> but DPC resets the entire hierarchy below the parent.  So only expose
> the reset method on PCI Functions without siblings or children.
> Checking for that may happen both *before* the PCI Function has been
> added to the bus list (via pci_device_add() -> pci_init_capabilities())
> and *after* (via reset_method_store()), hence differentiate between
> those two cases on reset probing.

Does this mean you want to only allow this reset method for DPC capable
ports without any devices attached to it? If yes, why not use other
reset methods available?

> 
> It would be useful for silicon validation to have a separate sysfs
> attribute for PCI bridges to reset their downstream hierarchy.  Prepare
> for introduction of such an attribute by adding separate functions
> pci_dpc_sw_trigger() (to reset the hierarchy below a bridge) and
> pci_dpc_sw_trigger_parent() (to reset a single PCI Function), where the
> latter calls the former to trigger DPC on the parent bridge.

To reset downstream hierarchy, DPC SW trigger bit can be modified using
setpci aswell right. Any reason to add special sysfs for it?

> 
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---
>  drivers/pci/pci.c             |  1 +
>  drivers/pci/pci.h             |  2 ++
>  drivers/pci/pcie/dpc.c        | 57 +++++++++++++++++++++++++++++++++++
>  include/linux/pci.h           |  2 +-
>  include/uapi/linux/pci_regs.h |  1 +
>  5 files changed, 62 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index fba95486caaf..f561f84a8bca 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5225,6 +5225,7 @@ static const struct pci_reset_fn_method pci_reset_fn_methods[] = {
>  	{ pci_af_flr, .name = "af_flr" },
>  	{ pci_pm_reset, .name = "pm" },
>  	{ pci_reset_bus_function, .name = "bus" },
> +	{ pci_dpc_sw_trigger_parent, .name = "dpc_sw_trigger" },
>  };
>  
>  static ssize_t reset_method_show(struct device *dev,
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 9ed3b5550043..da2a3af4c46c 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -425,11 +425,13 @@ void pci_dpc_init(struct pci_dev *pdev);
>  void dpc_process_error(struct pci_dev *pdev);
>  pci_ers_result_t dpc_reset_link(struct pci_dev *pdev);
>  bool pci_dpc_recovered(struct pci_dev *pdev);
> +int pci_dpc_sw_trigger_parent(struct pci_dev *pdev, bool probe);
>  #else
>  static inline void pci_save_dpc_state(struct pci_dev *dev) {}
>  static inline void pci_restore_dpc_state(struct pci_dev *dev) {}
>  static inline void pci_dpc_init(struct pci_dev *pdev) {}
>  static inline bool pci_dpc_recovered(struct pci_dev *pdev) { return false; }
> +static inline int pci_dpc_sw_trigger_parent(struct pci_dev *pdev, bool probe) { return -ENOTTY; }
>  #endif
>  
>  #ifdef CONFIG_PCIEPORTBUS
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index f5ffea17c7f8..47fd69d0a9c2 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -322,6 +322,63 @@ static irqreturn_t dpc_irq(int irq, void *context)
>  	return IRQ_HANDLED;
>  }
>  
> +static int pci_dpc_sw_trigger(struct pci_dev *pdev, bool probe)
> +{
> +	struct pci_host_bridge *host;
> +	u16 cap, ctl;
> +
> +	if (probe) {
> +		if (!pdev->dpc_cap)
> +			return -ENOTTY;
> +
> +		host = pci_find_host_bridge(pdev->bus);
> +		if (!host->native_dpc && !pcie_ports_dpc_native)
> +			return -ENOTTY;
> +
> +		if (!pcie_aer_is_native(pdev))
> +			return -ENOTTY;
> +
> +		pci_read_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CAP,
> +				     &cap);
> +		if (!(cap & PCI_EXP_DPC_CAP_SW_TRIGGER))
> +			return -ENOTTY;
> +
> +		return 0;
> +	}
> +
> +	pci_read_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, &ctl);
> +	ctl |= PCI_EXP_DPC_CTL_SW_TRIGGER;
> +	pci_write_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, ctl);
> +	return 0;
> +}
> +
> +int pci_dpc_sw_trigger_parent(struct pci_dev *pdev, bool probe)
> +{
> +	if (probe) {
> +		/*
> +		 * Reset must only affect @pdev, so bail out if it has siblings
> +		 * or descendants.  Need to differentiate whether @pdev has
> +		 * already been added to the bus list or not:
> +		 */
> +		if (list_empty(&pdev->bus_list) &&
> +		    !list_empty(&pdev->bus->devices))
> +			return -ENOTTY;
> +
> +		if (!list_empty(&pdev->bus_list) &&
> +		    !list_is_singular(&pdev->bus->devices))
> +			return -ENOTTY;
> +
> +		if (pdev->subordinate &&
> +		    !list_empty(&pdev->subordinate->devices))
> +			return -ENOTTY;
> +
> +		if (!pdev->bus->self)
> +			return -ENOTTY;
> +	}
> +
> +	return pci_dpc_sw_trigger(pdev->bus->self, probe);
> +}
> +
>  void pci_dpc_init(struct pci_dev *pdev)
>  {
>  	u16 cap;
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 28af4414f789..7890cd4eb97d 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -50,7 +50,7 @@
>  			       PCI_STATUS_PARITY)
>  
>  /* Number of reset methods used in pci_reset_fn_methods array in pci.c */
> -#define PCI_NUM_RESET_METHODS 7
> +#define PCI_NUM_RESET_METHODS 8
>  
>  #define PCI_RESET_PROBE		true
>  #define PCI_RESET_DO_RESET	false
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 1c3591c8e09e..73b3ccdffb3a 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -1035,6 +1035,7 @@
>  #define PCI_EXP_DPC_CTL			0x06	/* DPC control */
>  #define  PCI_EXP_DPC_CTL_EN_FATAL	0x0001	/* Enable trigger on ERR_FATAL message */
>  #define  PCI_EXP_DPC_CTL_EN_NONFATAL	0x0002	/* Enable trigger on ERR_NONFATAL message */
> +#define  PCI_EXP_DPC_CTL_SW_TRIGGER	0x0040	/* Software Trigger */
>  #define  PCI_EXP_DPC_CTL_INT_EN		0x0008	/* DPC Interrupt Enable */
>  
>  #define PCI_EXP_DPC_STATUS		0x08	/* DPC Status */

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
