Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 326DE756976
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jul 2023 18:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjGQQpk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jul 2023 12:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbjGQQpj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jul 2023 12:45:39 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E0D10CA
        for <linux-pci@vger.kernel.org>; Mon, 17 Jul 2023 09:45:37 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1b89d47ffb6so25968985ad.2
        for <linux-pci@vger.kernel.org>; Mon, 17 Jul 2023 09:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689612337; x=1692204337;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5QsGRkh6jSTBK3lt0PkwQlq6Yn1SGLWvs1rGiyZyQiw=;
        b=ALTAoztWCBNmZ6fN1PurRBYRXLjiLIVJL2YyQWp0DropkX4+GSNg/7RReJVbxxxF9m
         m9iUwe619PtnfAy1yGg/Wzzs9YrH5e6Tf35zL5cLQZBpjoO7s8Ep4nmYmLeat6XmXX2o
         k+eZZ9bOfQQVkdLCHxicc84NH3y+Zq7j4h7cYrUdVezTMjpMMEPjYmnOGVD1Z74VtTPb
         hJqaFdbtxj0QzTnBys8nJQt+pmyZU1zrrOxWIA+tfXJxv0af33yfObybt9U8TFZ4doKJ
         DspHzf6dxQRqShdYk2tzzHBmGYqRdkpR1l75fxgT2DdTFXYQzakefdEcI07CdpDwFUKN
         kaNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689612337; x=1692204337;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5QsGRkh6jSTBK3lt0PkwQlq6Yn1SGLWvs1rGiyZyQiw=;
        b=ESmJas8NsCWX8468Gm8jj1A+spyQ93BASI+Mw7OQ6NqXzNUsQpo2b+rpB8TrCzWz0D
         tXX7ckY/tz62mXO/coOdog2nUWBPYt3ePWqCN6lwfUcHZj6rnKTXCqJTABxw67hY+f31
         S/dP7CdVihypZ+RjX/XfaHUu/FQBnWFR3bdyyMylVqaIisF+/qFUNIv6KCjV1l0KVdwY
         mLZOSdQciSzy7AVLilDBhSq/2AYwZPIbRBXbZaNIMKxnQMHd70qWKj9Y6zElmzZouYqC
         oNREMvMjMp08Ht2hl/73kSjfhCRzA5i53ho+eRuype+Glpgub0lXX5qhDXu2m3CNFwql
         YcJQ==
X-Gm-Message-State: ABy/qLa32eHTkbxDGYJzETpPke8Ptyys1GwuvM63BtK0Ur5YI93Uspn8
        zc5RNgjYoMXa9/QFQTi797fE
X-Google-Smtp-Source: APBJJlEvYNyyUncRVmtB1UAc/qY5Euc5LgKlWHfDLBAhOQZWIBavmpXuRWPiQTEGvgXYWRU23MXhQA==
X-Received: by 2002:a17:902:7c14:b0:1b8:3786:334d with SMTP id x20-20020a1709027c1400b001b83786334dmr2208512pll.18.1689612337328;
        Mon, 17 Jul 2023 09:45:37 -0700 (PDT)
Received: from thinkpad ([117.217.190.73])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c21500b001b7feed285csm133265pll.36.2023.07.17.09.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 09:45:36 -0700 (PDT)
Date:   Mon, 17 Jul 2023 22:15:26 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     helgaas@kernel.org, imx@lists.linux.dev, bhelgaas@google.com,
        devicetree@vger.kernel.org, gustavo.pimentel@synopsys.com,
        kw@linux.com, leoyang.li@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com, minghuan.lian@nxp.com,
        mingkai.hu@nxp.com, robh+dt@kernel.org, roy.zang@nxp.com,
        shawnguo@kernel.org, zhiqiang.hou@nxp.com
Subject: Re: [PATCH v3 1/2] PCI: dwc: Implement general suspend/resume
 functionality for L2/L3 transitions
Message-ID: <20230717164526.GC35455@thinkpad>
References: <20230419164118.596300-1-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230419164118.596300-1-Frank.Li@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 19, 2023 at 12:41:17PM -0400, Frank Li wrote:
> Introduced helper function dw_pcie_get_ltssm to retrieve SMLH_LTSS_STATE.
> Added API pme_turn_off and exit_from_l2 for managing L2/L3 state transitions.
> 
> Typical L2 entry workflow:
> 
> 1. Transmit PME turn off signal to PCI devices.
> 2. Await link entering L2_IDLE state.

AFAIK, typical workflow is to wait for PME_To_Ack.

> 3. Transition Root complex to D3 state.
> 
> Typical L2 exit workflow:
> 
> 1. Transition Root complex to D0 state.
> 2. Issue exit from L2 command.
> 3. Reinitialize PCI host.
> 4. Wait for link to become active.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change from v2 to v3: 
> - Basic rewrite whole patch according rob herry suggestion. 
>   put common function into dwc, so more soc can share the same logic.
>   
>  .../pci/controller/dwc/pcie-designware-host.c | 80 +++++++++++++++++++
>  drivers/pci/controller/dwc/pcie-designware.h  | 28 +++++++
>  2 files changed, 108 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 9952057c8819..ef6869488bde 100644
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
> @@ -807,3 +808,82 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(dw_pcie_setup_rc);
> +
> +/*
> + * There are for configuring host controllers, which are bridges *to* PCI devices
> + * but are not PCI devices themselves.

None of the functions applicable to the devices. So there is no need for this
comment.

> + */
> +static void dw_pcie_set_dstate(struct dw_pcie *pci, u32 dstate)

Please use pci_power_t defines for dstates.

> +{
> +	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_PM);
> +	u32 val;
> +
> +	val = dw_pcie_readw_dbi(pci, offset + PCI_PM_CTRL);

Please use PCI accessors for accessing spec compliant registers.

> +	val &= ~PCI_PM_CTRL_STATE_MASK;
> +	val |= dstate;
> +	dw_pcie_writew_dbi(pci, offset + PCI_PM_CTRL, val);
> +}
> +
> +int dw_pcie_suspend_noirq(struct dw_pcie *pci)
> +{
> +	u32 val;
> +	int ret;
> +
> +	if (dw_pcie_get_ltssm(pci) <= DW_PCIE_LTSSM_DETECT_ACT)
> +		return 0;
> +
> +	pci->pp.ops->pme_turn_off(&pci->pp);

You should first check for the existence of the callback before invoking. This
applies to all callbacks in this patch.

> +
> +	/*
> +	 * PCI Express Base Specification Rev 4.0
> +	 * 5.3.3.2.1 PME Synchronization
> +	 * Recommand 1ms to 10ms timeout to check L2 ready
> +	 */
> +	ret = read_poll_timeout(dw_pcie_get_ltssm, val, val == DW_PCIE_LTSSM_L2_IDLE,
> +				100, 10000, false, pci);

Is there no way to wait for PME_To_Ack TLP?

> +	if (ret) {
> +		dev_err(pci->dev, "PCIe link enter L2 timeout! ltssm = 0x%x\n", val);
> +		return ret;
> +	}
> +
> +	dw_pcie_set_dstate(pci, 0x3);
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
> +	dw_pcie_set_dstate(pci, 0x0);
> +
> +	pci->pp.ops->exit_from_l2(&pci->pp);
> +
> +	/* delay 10 ms to access EP */

Is this delay as part of the DWC spec? If so, please quote the section.

> +	mdelay(10);
> +
> +	ret = pci->pp.ops->host_init(&pci->pp);
> +	if (ret) {
> +		dev_err(pci->dev, "ls_pcie_host_init failed! ret = 0x%x\n", ret);

s/ls_pcie_host_init/Host init

> +		return ret;
> +	}
> +
> +	dw_pcie_setup_rc(&pci->pp);
> +

Don't you need to configure iATU?

> +	ret = dw_pcie_wait_for_link(pci);

Don't you need to start the link beforehand?

> +	if (ret) {
> +		dev_err(pci->dev, "wait link up timeout! ret = 0x%x\n", ret);

dw_pcie_wait_for_link() itself prints error message on failure. So no need to do
the same here.

- Mani

> +		return ret;
> +	}
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

-- 
மணிவண்ணன் சதாசிவம்
