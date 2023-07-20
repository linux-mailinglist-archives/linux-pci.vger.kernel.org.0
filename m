Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17B2475B12F
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jul 2023 16:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbjGTOZ3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jul 2023 10:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232209AbjGTOZ2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jul 2023 10:25:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D747B2135;
        Thu, 20 Jul 2023 07:25:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 66AF461B07;
        Thu, 20 Jul 2023 14:25:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34046C433C7;
        Thu, 20 Jul 2023 14:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689863125;
        bh=gc0SxsL57xUfme8TPK+aCC7Cs6WOfyxwkhIKcrGjX+k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iDSlCf6GVsEEbCErF39qN+Fat80YPxUlVPc5Qzeilt3TG2HufpJhW9X741EQgGHUI
         rW1pPjWiC67ympDQ6xlkMDhtNzCcm9gMQD3qpx/5BIXntQfkX4uMhoAgB+kMw1VuT/
         pjHT9JuqHDSq22HKZs+aFxOKayaVFFCc1yxBX1DoF3irx6fbevDqFIv2RgcX7A70wi
         Nx7NAy/gVzMoCYQqUi2n8tuqlR5LpzRhy7ZkU7zcc5O2Jv1JU6Sxu7CM34nzKnhQ6k
         zC1wTeS/VDuMV66FBW+jhPxHm8e08kFeG4cx+1vYg3J0fZEXtlxWBlCesfDgQnAp6x
         NKNuWpqBsdjxQ==
Date:   Thu, 20 Jul 2023 19:55:09 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Frank Li <Frank.li@nxp.com>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        helgaas@kernel.org, imx@lists.linux.dev, bhelgaas@google.com,
        devicetree@vger.kernel.org, gustavo.pimentel@synopsys.com,
        kw@linux.com, leoyang.li@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com, minghuan.lian@nxp.com,
        mingkai.hu@nxp.com, robh+dt@kernel.org, roy.zang@nxp.com,
        shawnguo@kernel.org, zhiqiang.hou@nxp.com
Subject: Re: [PATCH v3 1/2] PCI: dwc: Implement general suspend/resume
 functionality for L2/L3 transitions
Message-ID: <20230720142509.GB48270@thinkpad>
References: <20230419164118.596300-1-Frank.Li@nxp.com>
 <20230717164526.GC35455@thinkpad>
 <ZLWKI1lRqxejfUgK@lizhi-Precision-Tower-5810>
 <20230718100400.GB4771@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230718100400.GB4771@thinkpad>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 18, 2023 at 03:34:26PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Jul 17, 2023 at 02:36:19PM -0400, Frank Li wrote:
> > On Mon, Jul 17, 2023 at 10:15:26PM +0530, Manivannan Sadhasivam wrote:
> > > On Wed, Apr 19, 2023 at 12:41:17PM -0400, Frank Li wrote:
> > > > Introduced helper function dw_pcie_get_ltssm to retrieve SMLH_LTSS_STATE.
> > > > Added API pme_turn_off and exit_from_l2 for managing L2/L3 state transitions.
> > > > 
> > > > Typical L2 entry workflow:
> > > > 
> > > > 1. Transmit PME turn off signal to PCI devices.
> > > > 2. Await link entering L2_IDLE state.
> > > 
> > > AFAIK, typical workflow is to wait for PME_To_Ack.
> > 
> > 1 Already wait for PME_to_ACK,  2, just wait for link actual enter L2.
> > I think PCI RC needs some time to set link enter L2 after get ACK from
> > PME.
> > 

One more comment. If you transition the device to L2/L3, then it can loose power
if Vaux was not provided. In that case, can all the devices work after resume?
Most notably NVMe?

- Mani

> > > 
> > > > 3. Transition Root complex to D3 state.
> > > > 
> > > > Typical L2 exit workflow:
> > > > 
> > > > 1. Transition Root complex to D0 state.
> > > > 2. Issue exit from L2 command.
> > > > 3. Reinitialize PCI host.
> > > > 4. Wait for link to become active.
> > > > 
> > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > ---
> > > > Change from v2 to v3: 
> > > > - Basic rewrite whole patch according rob herry suggestion. 
> > > >   put common function into dwc, so more soc can share the same logic.
> > > >   
> > > >  .../pci/controller/dwc/pcie-designware-host.c | 80 +++++++++++++++++++
> > > >  drivers/pci/controller/dwc/pcie-designware.h  | 28 +++++++
> > > >  2 files changed, 108 insertions(+)
> > > > 
> > > > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > index 9952057c8819..ef6869488bde 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > @@ -8,6 +8,7 @@
> > > >   * Author: Jingoo Han <jg1.han@samsung.com>
> > > >   */
> > > >  
> > > > +#include <linux/iopoll.h>
> > > >  #include <linux/irqchip/chained_irq.h>
> > > >  #include <linux/irqdomain.h>
> > > >  #include <linux/msi.h>
> > > > @@ -807,3 +808,82 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
> > > >  	return 0;
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(dw_pcie_setup_rc);
> > > > +
> > > > +/*
> > > > + * There are for configuring host controllers, which are bridges *to* PCI devices
> > > > + * but are not PCI devices themselves.
> > > 
> > > None of the functions applicable to the devices. So there is no need for this
> > > comment.
> > 
> > I copy comments in drivers/pci/controller/dwc/pcie-designware.c.
> > 
> > /*
> >  * These interfaces resemble the pci_find_*capability() interfaces, but these
> >  * are for configuring host controllers, which are bridges *to* PCI devices but
> >  * are not PCI devices themselves.
> >  */
> > static u8 __dw_pcie_find_next_cap(struct dw_pcie *pci, u8 cap_ptr,
> >                                   u8 cap)
> > 
> > 
> > I think it is reasonalble because it is too similar with standard API
> > pci_set_power_state();
> > 
> 
> Ok, then please add this API similarity in the comment as like
> __dw_pcie_find_next_cap(). Also change "There" to "These".
> 
> > > 
> > > > + */
> > > > +static void dw_pcie_set_dstate(struct dw_pcie *pci, u32 dstate)
> > > 
> > > Please use pci_power_t defines for dstates.
> > 
> > Although dwc use the same define, it is difference things. 
> > 
> 
> Sorry, what difference? Could you please clarify?
> 
> > > 
> > > > +{
> > > > +	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_PM);
> > > > +	u32 val;
> > > > +
> > > > +	val = dw_pcie_readw_dbi(pci, offset + PCI_PM_CTRL);
> > > 
> > > Please use PCI accessors for accessing spec compliant registers.
> > 
> > According to comments in pcie-designware.c, it is difference concept
> > even though register define is the same as PCI spec. It was used to
> > control root bridges.
> > 
> 
> Ah, I got slightly confused. This is fine.
> 
> > > 
> > > > +	val &= ~PCI_PM_CTRL_STATE_MASK;
> > > > +	val |= dstate;
> > > > +	dw_pcie_writew_dbi(pci, offset + PCI_PM_CTRL, val);
> > > > +}
> > > > +
> > > > +int dw_pcie_suspend_noirq(struct dw_pcie *pci)
> > > > +{
> > > > +	u32 val;
> > > > +	int ret;
> > > > +
> > > > +	if (dw_pcie_get_ltssm(pci) <= DW_PCIE_LTSSM_DETECT_ACT)
> > > > +		return 0;
> > > > +
> > > > +	pci->pp.ops->pme_turn_off(&pci->pp);
> > > 
> > > You should first check for the existence of the callback before invoking. This
> > > applies to all callbacks in this patch.
> > 
> > Yes, I will update.
> > 
> > > 
> > > > +
> > > > +	/*
> > > > +	 * PCI Express Base Specification Rev 4.0
> > > > +	 * 5.3.3.2.1 PME Synchronization
> > > > +	 * Recommand 1ms to 10ms timeout to check L2 ready
> > > > +	 */
> > > > +	ret = read_poll_timeout(dw_pcie_get_ltssm, val, val == DW_PCIE_LTSSM_L2_IDLE,
> > > > +				100, 10000, false, pci);
> > > 
> > > Is there no way to wait for PME_To_Ack TLP?
> > 
> > 
> > Suppose PME_turn_off should wait for ACK before return. 
> 
> Ok. I didn't see this behavior in the spec, hence curious.
> 
> > Here, just make sure Link enter L2 status. Hardware need some time to put
> > link to L2 after get ACK from bus, even it is very short generally.
> > 
> 
> Fine then. But can we check for PM_LINKST_IN_L2 SII System Information Interface
> (SII) instead of LTSSM state?
> 
> > > 
> > > > +	if (ret) {
> > > > +		dev_err(pci->dev, "PCIe link enter L2 timeout! ltssm = 0x%x\n", val);
> > > > +		return ret;
> > > > +	}
> > > > +
> > > > +	dw_pcie_set_dstate(pci, 0x3);
> > > > +
> > > > +	pci->suspended = true;
> > > > +
> > > > +	return ret;
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(dw_pcie_suspend_noirq);
> > > > +
> > > > +int dw_pcie_resume_noirq(struct dw_pcie *pci)
> > > > +{
> > > > +	int ret;
> > > > +
> > > > +	if (!pci->suspended)
> > > > +		return 0;
> > > > +
> > > > +	pci->suspended = false;
> > > > +
> > > > +	dw_pcie_set_dstate(pci, 0x0);
> > > > +
> > > > +	pci->pp.ops->exit_from_l2(&pci->pp);
> > > > +
> > > > +	/* delay 10 ms to access EP */
> > > 
> > > Is this delay as part of the DWC spec? If so, please quote the section.
> > > 
> > > > +	mdelay(10);
> > > > +
> > > > +	ret = pci->pp.ops->host_init(&pci->pp);
> > > > +	if (ret) {
> > > > +		dev_err(pci->dev, "ls_pcie_host_init failed! ret = 0x%x\n", ret);
> > > 
> > > s/ls_pcie_host_init/Host init
> > > 
> > > > +		return ret;
> > > > +	}
> > > > +
> > > > +	dw_pcie_setup_rc(&pci->pp);
> > > > +
> > > 
> > > Don't you need to configure iATU?
> > > 
> > > > +	ret = dw_pcie_wait_for_link(pci);
> > > 
> > > Don't you need to start the link beforehand?
> > 
> > Suppose need start link, it works at layerscape platform just because dwc
> > have not full power off. some state still kept.
> > 
> 
> It may work for your platform but not for all if the power gets removed. So
> please start the link manually.
> 
> - Mani
> 
> > > 
> > > > +	if (ret) {
> > > > +		dev_err(pci->dev, "wait link up timeout! ret = 0x%x\n", ret);
> > > 
> > > dw_pcie_wait_for_link() itself prints error message on failure. So no need to do
> > > the same here.
> > 
> > Okay
> > 
> > > 
> > > - Mani
> > > 
> > > > +		return ret;
> > > > +	}
> > > > +
> > > > +	return ret;
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(dw_pcie_resume_noirq);
> > > > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > > > index 79713ce075cc..effb07a506e4 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > > > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > > > @@ -288,10 +288,21 @@ enum dw_pcie_core_rst {
> > > >  	DW_PCIE_NUM_CORE_RSTS
> > > >  };
> > > >  
> > > > +enum dw_pcie_ltssm {
> > > > +	DW_PCIE_LTSSM_UNKNOWN = 0xFFFFFFFF,
> > > > +	/* Need align PCIE_PORT_DEBUG0 bit0:5 */
> > > > +	DW_PCIE_LTSSM_DETECT_QUIET = 0x0,
> > > > +	DW_PCIE_LTSSM_DETECT_ACT = 0x1,
> > > > +	DW_PCIE_LTSSM_L0 = 0x11,
> > > > +	DW_PCIE_LTSSM_L2_IDLE = 0x15,
> > > > +};
> > > > +
> > > >  struct dw_pcie_host_ops {
> > > >  	int (*host_init)(struct dw_pcie_rp *pp);
> > > >  	void (*host_deinit)(struct dw_pcie_rp *pp);
> > > >  	int (*msi_host_init)(struct dw_pcie_rp *pp);
> > > > +	void (*pme_turn_off)(struct dw_pcie_rp *pp);
> > > > +	void (*exit_from_l2)(struct dw_pcie_rp *pp);
> > > >  };
> > > >  
> > > >  struct dw_pcie_rp {
> > > > @@ -364,6 +375,7 @@ struct dw_pcie_ops {
> > > >  	void    (*write_dbi2)(struct dw_pcie *pcie, void __iomem *base, u32 reg,
> > > >  			      size_t size, u32 val);
> > > >  	int	(*link_up)(struct dw_pcie *pcie);
> > > > +	enum dw_pcie_ltssm (*get_ltssm)(struct dw_pcie *pcie);
> > > >  	int	(*start_link)(struct dw_pcie *pcie);
> > > >  	void	(*stop_link)(struct dw_pcie *pcie);
> > > >  };
> > > > @@ -393,6 +405,7 @@ struct dw_pcie {
> > > >  	struct reset_control_bulk_data	app_rsts[DW_PCIE_NUM_APP_RSTS];
> > > >  	struct reset_control_bulk_data	core_rsts[DW_PCIE_NUM_CORE_RSTS];
> > > >  	struct gpio_desc		*pe_rst;
> > > > +	bool			suspended;
> > > >  };
> > > >  
> > > >  #define to_dw_pcie_from_pp(port) container_of((port), struct dw_pcie, pp)
> > > > @@ -430,6 +443,9 @@ void dw_pcie_iatu_detect(struct dw_pcie *pci);
> > > >  int dw_pcie_edma_detect(struct dw_pcie *pci);
> > > >  void dw_pcie_edma_remove(struct dw_pcie *pci);
> > > >  
> > > > +int dw_pcie_suspend_noirq(struct dw_pcie *pci);
> > > > +int dw_pcie_resume_noirq(struct dw_pcie *pci);
> > > > +
> > > >  static inline void dw_pcie_writel_dbi(struct dw_pcie *pci, u32 reg, u32 val)
> > > >  {
> > > >  	dw_pcie_write_dbi(pci, reg, 0x4, val);
> > > > @@ -501,6 +517,18 @@ static inline void dw_pcie_stop_link(struct dw_pcie *pci)
> > > >  		pci->ops->stop_link(pci);
> > > >  }
> > > >  
> > > > +static inline enum dw_pcie_ltssm dw_pcie_get_ltssm(struct dw_pcie *pci)
> > > > +{
> > > > +	u32 val;
> > > > +
> > > > +	if (pci->ops && pci->ops->get_ltssm)
> > > > +		return pci->ops->get_ltssm(pci);
> > > > +
> > > > +	val = dw_pcie_readl_dbi(pci, PCIE_PORT_DEBUG0);
> > > > +
> > > > +	return (enum dw_pcie_ltssm)FIELD_GET(PORT_LOGIC_LTSSM_STATE_MASK, val);
> > > > +}
> > > > +
> > > >  #ifdef CONFIG_PCIE_DW_HOST
> > > >  irqreturn_t dw_handle_msi_irq(struct dw_pcie_rp *pp);
> > > >  int dw_pcie_setup_rc(struct dw_pcie_rp *pp);
> > > > -- 
> > > > 2.34.1
> > > > 
> > > 
> > > -- 
> > > மணிவண்ணன் சதாசிவம்
> 
> -- 
> மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்
