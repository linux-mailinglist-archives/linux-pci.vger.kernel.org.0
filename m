Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3798F76C422
	for <lists+linux-pci@lfdr.de>; Wed,  2 Aug 2023 06:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbjHBE2D (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Aug 2023 00:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231517AbjHBE16 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Aug 2023 00:27:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AABA10D4;
        Tue,  1 Aug 2023 21:27:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7867F617BF;
        Wed,  2 Aug 2023 04:27:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D64E7C433C8;
        Wed,  2 Aug 2023 04:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690950475;
        bh=ARGKpRK5ccFF2WBp3+o3ZTCFCi+lfX0QrM54lqQi0UI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kRG+gKVSB7Mblt8WIHhzCa/OClFhK1yeWc5s+AthWAvAdW5Ta+iCcOvQR2KKRlr86
         xpinFfXVKCXYpA0j/LtQ45hIK2rXuaTd+DKKJTOBYvM5Mq/U3NXOrhhqwfATdw+a5n
         jAM46Dau1s3Y78/ZzWy1IqRt1ch0MxzpY8OzBWPvzFHy9wMvqtoA7Idk7pdrlJEv1u
         s3ek3MEVhjX6GyvL7AsWPVB4WsYackSprXdvCoyu1bl/cor0/1sYvyoFefEs2NkaQN
         GvL4BZ/a3NF4qMCFoDp+IDVz+Lr3u+l11m7AbnZLSbeEfN3WXVk7u1XFUYIH9NaOP5
         gW4pO65QuhDPg==
Date:   Wed, 2 Aug 2023 09:57:38 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     lpieralisi@kernel.org, bhelgaas@google.com,
        devicetree@vger.kernel.org, gustavo.pimentel@synopsys.com,
        helgaas@kernel.org, imx@lists.linux.dev, kw@linux.com,
        leoyang.li@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lorenzo.pieralisi@arm.com,
        manivannan.sadhasivam@linaro.org, minghuan.lian@nxp.com,
        mingkai.hu@nxp.com, robh+dt@kernel.org, roy.zang@nxp.com,
        shawnguo@kernel.org, zhiqiang.hou@nxp.com
Subject: Re: [PATCH v6 1/2] PCI: dwc: Implement general suspend/resume
 functionality for L2/L3 transitions
Message-ID: <20230802042738.GD2370@thinkpad>
References: <20230731194010.73016-1-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230731194010.73016-1-Frank.Li@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 31, 2023 at 03:40:09PM -0400, Frank Li wrote:
> Introduce helper function dw_pcie_get_ltssm to retrieve SMLH_LTSS_STATE.
> 
> Add callback .pme_turn_off and .exit_from_l2 for platform specific PME
> handle.

s/handle/handling

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
> ---
> Change from v5 to v6:
> - refine commit message
>   change according to Manivannan's comments.
>   - remove reduncate step dw_pcie_set_dstate()
>   - return 0 when .pme_turn_off is zero
>   - call host_deinit() in suspend
>   - check .host_deinit and .host_init point before call.
> 
> Change from v4 to v5:
> - Closes: https://lore.kernel.org/oe-kbuild-all/202307211904.zExw4Q8H-lkp@intel.com/
> Change from v3 to v4:
> - change according to Manivannan's comments.
>   I hope I have not missed anything. quite long discuss thread
> Change from v2 to v3:
> - Basic rewrite whole patch according rob herry suggestion.
>   put common function into dwc, so more soc can share the same logic.
> 
>  .../pci/controller/dwc/pcie-designware-host.c | 78 +++++++++++++++++++
>  drivers/pci/controller/dwc/pcie-designware.h  | 28 +++++++
>  2 files changed, 106 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 9952057c8819c..1822c04d370b2 100644
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
> @@ -807,3 +808,80 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
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
> +	/*
> +	 * PCI Express Base Specification Rev 4.0 5.3.3.2.1 PME Synchronization

Rev 4.0 Section 5.3.3.2.1

> +	 * Recommands 1ms to 10ms timeout to check L2 ready

Recommends

Also add a full stop at the end of line.

> +	 */
> +	ret = read_poll_timeout(dw_pcie_get_ltssm, val, val == DW_PCIE_LTSSM_L2_IDLE,
> +				100, 10000, false, pci);

sleep_us value should be 1000 for 1ms.

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
> +			dev_err(pci->dev, "Host init failed! ret = 0x%x\n", ret);

Why do you want to print "ret" in hex?

How about,

dev_err(pci->dev, "Host init failed: %d\n", ret);

Rest looks good!

- Mani

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
