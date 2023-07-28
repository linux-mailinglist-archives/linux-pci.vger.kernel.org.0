Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0397E766821
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jul 2023 11:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234834AbjG1JGI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Jul 2023 05:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233673AbjG1JGH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Jul 2023 05:06:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD0597;
        Fri, 28 Jul 2023 02:06:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 368AF62089;
        Fri, 28 Jul 2023 09:06:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC696C433C7;
        Fri, 28 Jul 2023 09:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690535165;
        bh=QptmNRGvAVVleAso7CRWA+pdBZnB6YfYc/hh8lqFVEg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DOJl4Z0NpkPprlbM3MBP52rD9J6ljQh5TZFxPUiJ8GGimcb91TLUTikpwPRUtoe5A
         j52ocLqmJtDveSZQrZX/WNRYxA9HRPF7GjrUVu3k7dzWQvCaZejgxGRki25jbtGkOY
         tbg1tg5MfLMedYA3ZLqTQ4IFliV+Xj3BLxV3h89QU7bCCLWJsxufzZ8Ju046DHvTLs
         K9d2Xkh+Ckfs1kGF01nNypehgP5I2XFzkH9AX3ULJlHQs37OYFJvdfVEgoVXGD3o6U
         gMjclmR8ImazZACWOioQ4b+IbVhdTsmvRAGIWc4qXZ+kKcI8r3dBFUiQPoVy/0DZCO
         G9aUu66J9YNQA==
Date:   Fri, 28 Jul 2023 11:05:56 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     lorenzo.pieralisi@arm.com, manivannan.sadhasivam@linaro.org,
        bhelgaas@google.com, devicetree@vger.kernel.org,
        gustavo.pimentel@synopsys.com, helgaas@kernel.org,
        imx@lists.linux.dev, kw@linux.com, leoyang.li@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        mani@kernel.org, minghuan.lian@nxp.com, mingkai.hu@nxp.com,
        robh+dt@kernel.org, roy.zang@nxp.com, shawnguo@kernel.org,
        zhiqiang.hou@nxp.com
Subject: Re: [PATCH v5 1/2] PCI: dwc: Implement general suspend/resume
 functionality for L2/L3 transitions
Message-ID: <ZMOE9PJ//y1ClpU+@lpieralisi>
References: <20230724215830.2253112-1-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724215830.2253112-1-Frank.Li@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 24, 2023 at 05:58:29PM -0400, Frank Li wrote:
> Introduced helper function dw_pcie_get_ltssm to retrieve SMLH_LTSS_STATE.
> Added API pme_turn_off and exit_from_l2 for managing L2/L3 state transitions.

Commit logs should not use the past tense but the present tense.

eg s/Introduced/Introduce

Furthermore, read this post from Bjorn and follow it to the letter
please:

https://lore.kernel.org/linux-pci/20171026223701.GA25649@bhelgaas-glaptop.roam.corp.google.com

> 
> Typical L2 entry workflow:
> 
> 1. Transmit PME turn off signal to PCI devices and wait for PME_To_Ack.
> 2. Await link entering L2_IDLE state.
> 3. Transition Root complex to D3 state.
> 
> Typical L2 exit workflow:
> 
> 1. Transition Root complex to D0 state.
> 2. Issue exit from L2 command.
> 3. Reinitialize PCI host.
> 4. Wait for link to become active.

This does not explain what the patch does and why it does it.

Are you describing the L2 entry/exit as implemented in the code ?

> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change from v4 to v5:
> - Closes: https://lore.kernel.org/oe-kbuild-all/202307211904.zExw4Q8H-lkp@intel.com/
> Change from v3 to v4:
> - change according to Manivannan's comments.

I shall wait for Mani's comments on this series since he reviewed the
previous one.

Thanks,
Lorenzo

>   I hope I have not missed anything. quite long discuss thread
> Change from v2 to v3:
> - Basic rewrite whole patch according rob herry suggestion.
>   put common function into dwc, so more soc can share the same logic.
> 
>  .../pci/controller/dwc/pcie-designware-host.c | 95 +++++++++++++++++++
>  drivers/pci/controller/dwc/pcie-designware.h  | 28 ++++++
>  2 files changed, 123 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 9952057c8819..031e1f9c0d0c 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -8,6 +8,7 @@
>   * Author: Jingoo Han <jg1.han@samsung.com>
>   */
>  
> +#include <linux/iopoll.h>
>  #include <linux/irqchip/chained_irq.h>
>  #include <linux/irqdomain.h>
>  #include <linux/msi.h>
> @@ -807,3 +808,97 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(dw_pcie_setup_rc);
> +
> +/*
> + * This resemble the pci_set_power_state() interfaces, but these are for
> + * configuring host controllers, which are bridges *to* PCI devices but
> + * are not PCI devices themselves.
> + */
> +static void dw_pcie_set_dstate(struct dw_pcie *pci, pci_power_t dstate)
> +{
> +	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_PM);
> +	u16 val;
> +
> +	val = dw_pcie_readw_dbi(pci, offset + PCI_PM_CTRL);
> +	val &= ~PCI_PM_CTRL_STATE_MASK;
> +	val |= ((u16 __force)dstate) & PCI_PM_CTRL_STATE_MASK;
> +	dw_pcie_writew_dbi(pci, offset + PCI_PM_CTRL, val);
> +}
> +
> +int dw_pcie_suspend_noirq(struct dw_pcie *pci)
> +{
> +	u8 offset;
> +	u32 val;
> +	int ret;
> +
> +	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> +	/*
> +	 * If L1.1\L1.2 enable, devices (such as NVME) want short
> +	 * resume latency, controller will not enter L2
> +	 */
> +	if (dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKCTL) & PCI_EXP_LNKCTL_ASPM_L1)
> +		return 0;
> +
> +	if (dw_pcie_get_ltssm(pci) <= DW_PCIE_LTSSM_DETECT_ACT)
> +		return 0;
> +
> +	if (!pci->pp.ops->pme_turn_off)
> +		return -EINVAL;
> +
> +	pci->pp.ops->pme_turn_off(&pci->pp);
> +
> +	/*
> +	 * PCI Express Base Specification Rev 4.0
> +	 * 5.3.3.2.1 PME Synchronization
> +	 * Recommand 1ms to 10ms timeout to check L2 ready
> +	 */
> +	ret = read_poll_timeout(dw_pcie_get_ltssm, val, val == DW_PCIE_LTSSM_L2_IDLE,
> +				100, 10000, false, pci);
> +	if (ret) {
> +		dev_err(pci->dev, "PCIe link enter L2 timeout! ltssm = 0x%x\n", val);
> +		return ret;
> +	}
> +
> +	dw_pcie_set_dstate(pci, PCI_D3hot);
> +
> +	pci->suspended = true;
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(dw_pcie_suspend_noirq);
> +
> +int dw_pcie_resume_noirq(struct dw_pcie *pci)
> +{
> +	int ret;
> +
> +	if (!pci->suspended)
> +		return 0;
> +
> +	pci->suspended = false;
> +
> +	dw_pcie_set_dstate(pci, PCI_D0);
> +
> +	if (!pci->pp.ops->exit_from_l2)
> +		return -EINVAL;
> +
> +	pci->pp.ops->exit_from_l2(&pci->pp);
> +
> +	ret = pci->pp.ops->host_init(&pci->pp);
> +	if (ret) {
> +		dev_err(pci->dev, "Host init failed! ret = 0x%x\n", ret);
> +		return ret;
> +	}
> +
> +	dw_pcie_setup_rc(&pci->pp);
> +
> +	ret = dw_pcie_start_link(pci);
> +	if (ret)
> +		return ret;
> +
> +	ret = dw_pcie_wait_for_link(pci);
> +	if (ret)
> +		return ret;
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(dw_pcie_resume_noirq);
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 79713ce075cc..effb07a506e4 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -288,10 +288,21 @@ enum dw_pcie_core_rst {
>  	DW_PCIE_NUM_CORE_RSTS
>  };
>  
> +enum dw_pcie_ltssm {
> +	DW_PCIE_LTSSM_UNKNOWN = 0xFFFFFFFF,
> +	/* Need align PCIE_PORT_DEBUG0 bit0:5 */
> +	DW_PCIE_LTSSM_DETECT_QUIET = 0x0,
> +	DW_PCIE_LTSSM_DETECT_ACT = 0x1,
> +	DW_PCIE_LTSSM_L0 = 0x11,
> +	DW_PCIE_LTSSM_L2_IDLE = 0x15,
> +};
> +
>  struct dw_pcie_host_ops {
>  	int (*host_init)(struct dw_pcie_rp *pp);
>  	void (*host_deinit)(struct dw_pcie_rp *pp);
>  	int (*msi_host_init)(struct dw_pcie_rp *pp);
> +	void (*pme_turn_off)(struct dw_pcie_rp *pp);
> +	void (*exit_from_l2)(struct dw_pcie_rp *pp);
>  };
>  
>  struct dw_pcie_rp {
> @@ -364,6 +375,7 @@ struct dw_pcie_ops {
>  	void    (*write_dbi2)(struct dw_pcie *pcie, void __iomem *base, u32 reg,
>  			      size_t size, u32 val);
>  	int	(*link_up)(struct dw_pcie *pcie);
> +	enum dw_pcie_ltssm (*get_ltssm)(struct dw_pcie *pcie);
>  	int	(*start_link)(struct dw_pcie *pcie);
>  	void	(*stop_link)(struct dw_pcie *pcie);
>  };
> @@ -393,6 +405,7 @@ struct dw_pcie {
>  	struct reset_control_bulk_data	app_rsts[DW_PCIE_NUM_APP_RSTS];
>  	struct reset_control_bulk_data	core_rsts[DW_PCIE_NUM_CORE_RSTS];
>  	struct gpio_desc		*pe_rst;
> +	bool			suspended;
>  };
>  
>  #define to_dw_pcie_from_pp(port) container_of((port), struct dw_pcie, pp)
> @@ -430,6 +443,9 @@ void dw_pcie_iatu_detect(struct dw_pcie *pci);
>  int dw_pcie_edma_detect(struct dw_pcie *pci);
>  void dw_pcie_edma_remove(struct dw_pcie *pci);
>  
> +int dw_pcie_suspend_noirq(struct dw_pcie *pci);
> +int dw_pcie_resume_noirq(struct dw_pcie *pci);
> +
>  static inline void dw_pcie_writel_dbi(struct dw_pcie *pci, u32 reg, u32 val)
>  {
>  	dw_pcie_write_dbi(pci, reg, 0x4, val);
> @@ -501,6 +517,18 @@ static inline void dw_pcie_stop_link(struct dw_pcie *pci)
>  		pci->ops->stop_link(pci);
>  }
>  
> +static inline enum dw_pcie_ltssm dw_pcie_get_ltssm(struct dw_pcie *pci)
> +{
> +	u32 val;
> +
> +	if (pci->ops && pci->ops->get_ltssm)
> +		return pci->ops->get_ltssm(pci);
> +
> +	val = dw_pcie_readl_dbi(pci, PCIE_PORT_DEBUG0);
> +
> +	return (enum dw_pcie_ltssm)FIELD_GET(PORT_LOGIC_LTSSM_STATE_MASK, val);
> +}
> +
>  #ifdef CONFIG_PCIE_DW_HOST
>  irqreturn_t dw_handle_msi_irq(struct dw_pcie_rp *pp);
>  int dw_pcie_setup_rc(struct dw_pcie_rp *pp);
> -- 
> 2.34.1
> 
