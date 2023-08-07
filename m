Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E92ED7725E6
	for <lists+linux-pci@lfdr.de>; Mon,  7 Aug 2023 15:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234206AbjHGNfy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Aug 2023 09:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234050AbjHGNfx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Aug 2023 09:35:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01EA9198D;
        Mon,  7 Aug 2023 06:35:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E7F961B6D;
        Mon,  7 Aug 2023 13:35:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9428CC433C7;
        Mon,  7 Aug 2023 13:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691415347;
        bh=gJOtkQtXecuWCK12Nmw1Cjef3JhnXue4TG090jJoSqg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G0PRBms6EYNMfwVzMVUT85wVaExvcHx+XMI+gUXLWXcm0YPLUb5Fnm9rLukXHzMDl
         6APb7WyPqAS+WiIApmlSgZfaIkQ28OyB2P/d0J7LZDyBmVzTQweIDYb62nAhvlf2TY
         HAp7IPkJYRZ5cqtL6f69ftV6wlLRjrohU1n90CYfuuJ1mNDUH/OjJBWrqZui6+CyCP
         lwPlI8JOQkVi7VZhsnFLKlPyddz20Kn6+AGXt+CekGfQVe/OOgPjINBQptDsZ5E8fh
         YBWF2+JV5YJNvRUbSI0ElaALiKvorvRP7naVf9GpyAVaVaAgdWbqaH83vrkl4FY4cZ
         nOgMnWQpv3SpQ==
Date:   Mon, 7 Aug 2023 19:05:29 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     helgaas@kernel.org, bhelgaas@google.com,
        devicetree@vger.kernel.org, gustavo.pimentel@synopsys.com,
        imx@lists.linux.dev, kw@linux.com, leoyang.li@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com, lpieralisi@kernel.org,
        manivannan.sadhasivam@linaro.org, minghuan.lian@nxp.com,
        mingkai.hu@nxp.com, robh+dt@kernel.org, roy.zang@nxp.com,
        shawnguo@kernel.org, zhiqiang.hou@nxp.com
Subject: Re: [PATCH v9 2/3] PCI: dwc: Implement general suspend/resume
 functionality for L2/L3 transitions
Message-ID: <20230807133529.GD18257@thinkpad>
References: <20230804180637.462573-1-Frank.Li@nxp.com>
 <20230804180637.462573-3-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230804180637.462573-3-Frank.Li@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 04, 2023 at 02:06:36PM -0400, Frank Li wrote:
> Introduce helper function dw_pcie_get_ltssm() to retrieve SMLH_LTSS_STATE.
> 
> Add callback .pme_turn_off and .exit_from_l2 for platform specific PME
> handling.
> 
> Add common dw_pcie_suspend(resume)_noirq() API to avoid duplicated code
> in dwc pci host controller platform driver.
> 
> Typical L2 entry workflow/dw_pcie_suspend_noirq()
> 
> 1. Transmit PME turn off signal to PCI devices and wait for PME_To_Ack.
> 2. Await link entering L2_IDLE state.
> 
> Typical L2 exit workflow/dw_pcie_resume_noirq()
> 
> 1. Issue exit from L2 command.
> 2. Reinitialize PCI host.
> 3. Wait for link to become active.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Minor nits below. With that,

Acked-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
>  .../pci/controller/dwc/pcie-designware-host.c | 76 +++++++++++++++++++
>  drivers/pci/controller/dwc/pcie-designware.h  | 28 +++++++
>  2 files changed, 104 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 9952057c8819c..7d87ed61e2bf9 100644
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
> @@ -16,6 +17,7 @@
>  #include <linux/pci_regs.h>
>  #include <linux/platform_device.h>
>  
> +#include "../../pci.h"
>  #include "pcie-designware.h"
>  
>  static struct pci_ops dw_pcie_ops;
> @@ -807,3 +809,77 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(dw_pcie_setup_rc);
> +
> +int dw_pcie_suspend_noirq(struct dw_pcie *pci)
> +{
> +	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> +	u32 val;
> +	int ret;
> +
> +	/*
> +	 * If L1SS is supported, then do not put the link into L2 as some
> +	 * devices such as NVMe expect low resume latency.
> +	 */
> +	if (dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKCTL) & PCI_EXP_LNKCTL_ASPM_L1)
> +		return 0;
> +
> +	if (dw_pcie_get_ltssm(pci) <= DW_PCIE_LTSSM_DETECT_ACT)
> +		return 0;
> +
> +	if (!pci->pp.ops->pme_turn_off)
> +		return 0;
> +
> +	pci->pp.ops->pme_turn_off(&pci->pp);
> +
> +	ret = read_poll_timeout(dw_pcie_get_ltssm, val, val == DW_PCIE_LTSSM_L2_IDLE,
> +				PCIE_PME_TO_L2_TIMEOUT_US/10,
> +				PCIE_PME_TO_L2_TIMEOUT_US, false, pci);
> +	if (ret) {
> +		dev_err(pci->dev, "Timeout waiting for L2 entry! LTSSM: 0x%x\n", val);
> +		return ret;
> +	}
> +
> +	if (pci->pp.ops->host_deinit)
> +		pci->pp.ops->host_deinit(&pci->pp);
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
> +	if (!pci->pp.ops->exit_from_l2)
> +		return 0;
> +
> +	pci->pp.ops->exit_from_l2(&pci->pp);
> +
> +	if (pci->pp.ops->host_init) {
> +		ret = pci->pp.ops->host_init(&pci->pp);
> +		if (ret) {
> +			dev_err(pci->dev, "Host init failed! ret = %d\n", ret);

Please remove "ret = " and just print, "Host init failed: %d"

> +			return ret;
> +		}
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
> index 79713ce075cc1..cbba3ed19b3c0 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -288,10 +288,21 @@ enum dw_pcie_core_rst {
>  	DW_PCIE_NUM_CORE_RSTS
>  };
>  
> +enum dw_pcie_ltssm {
> +	DW_PCIE_LTSSM_UNKNOWN = 0xFFFFFFFF,

Move this to the end as UNKNOWN doesn't have the value of 0.

- Mani

> +	/* Need to align with PCIE_PORT_DEBUG0 bits 0:5 */
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

-- 
மணிவண்ணன் சதாசிவம்
