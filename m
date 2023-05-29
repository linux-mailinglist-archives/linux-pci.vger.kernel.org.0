Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B17BD714EF9
	for <lists+linux-pci@lfdr.de>; Mon, 29 May 2023 19:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbjE2Ric (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 May 2023 13:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjE2Rib (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 May 2023 13:38:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65841AB;
        Mon, 29 May 2023 10:38:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E89166215D;
        Mon, 29 May 2023 17:38:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B713C433D2;
        Mon, 29 May 2023 17:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685381908;
        bh=BcptRJMJlcnUYUvoqWq/afyC9AvdhFG2DLnFCC2jcqk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N2Xhtlq+R+eMSWPYviKxJ7Fx6JhscEBtrq17/MwvV0wD4hyx6j4sg9bmgcGf7+oZx
         b1PexLNt7DnJ+OhZhJYv2szm3xNbUFu+Sv38f1QgQH214fhr00q3zBSB6IHTsJvzcj
         JyHfZU6A5Vw49mVZdcOjgjXBVx6w77r6iWGhQjA3N+KbHO4kYjXPP3e5XB8+ZQyWx0
         DlLXdx/TnSfCElQ8KA1IxxcSeWU1Ch0DL0xtDQeaWWYQ4Pa7M8beEtiiwLWNjbQTNj
         Q6RsvbKGDKEoA9vz5C7gmatZ+4bsxTrdFCJ4XUELNygjMSs5DglI2otDKOfbq5VMOB
         cf+E+Pzjwx12A==
Date:   Mon, 29 May 2023 23:08:15 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        kw@linux.com, kishon@kernel.org, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v4 7/7] PCI: endpoint: Add PCI Endpoint function driver
 for MHI bus
Message-ID: <20230529173815.GG5633@thinkpad>
References: <20230519144215.25167-1-manivannan.sadhasivam@linaro.org>
 <20230519144215.25167-8-manivannan.sadhasivam@linaro.org>
 <ZHSkdakXJegKRD+q@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZHSkdakXJegKRD+q@lpieralisi>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 29, 2023 at 03:11:17PM +0200, Lorenzo Pieralisi wrote:
> On Fri, May 19, 2023 at 08:12:15PM +0530, Manivannan Sadhasivam wrote:
> > Add PCI Endpoint driver for the Qualcomm MHI (Modem Host Interface) bus.
> > The driver implements the MHI function over PCI in the endpoint device
> > such as SDX55 modem. The MHI endpoint function driver acts as a
> > controller driver for the MHI Endpoint stack and carries out all PCI
> > related activities like mapping the host memory using iATU, triggering
> > MSIs etc...
> > 
> > Reviewed-by: Kishon Vijay Abraham I <kishon@kernel.org>
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/pci/endpoint/functions/Kconfig       |  10 +
> >  drivers/pci/endpoint/functions/Makefile      |   1 +
> >  drivers/pci/endpoint/functions/pci-epf-mhi.c | 454 +++++++++++++++++++
> >  3 files changed, 465 insertions(+)
> >  create mode 100644 drivers/pci/endpoint/functions/pci-epf-mhi.c
> > 
> > diff --git a/drivers/pci/endpoint/functions/Kconfig b/drivers/pci/endpoint/functions/Kconfig
> > index 9fd560886871..f5171b4fabbe 100644
> > --- a/drivers/pci/endpoint/functions/Kconfig
> > +++ b/drivers/pci/endpoint/functions/Kconfig
> > @@ -37,3 +37,13 @@ config PCI_EPF_VNTB
> >  	  between PCI Root Port and PCIe Endpoint.
> >  
> >  	  If in doubt, say "N" to disable Endpoint NTB driver.
> > +
> > +config PCI_EPF_MHI
> > +	tristate "PCI Endpoint driver for MHI bus"
> > +	depends on PCI_ENDPOINT && MHI_BUS_EP
> > +	help
> > +	   Enable this configuration option to enable the PCI Endpoint
> > +	   driver for Modem Host Interface (MHI) bus in Qualcomm Endpoint
> > +	   devices such as SDX55.
> > +
> > +	   If in doubt, say "N" to disable Endpoint driver for MHI bus.
> > diff --git a/drivers/pci/endpoint/functions/Makefile b/drivers/pci/endpoint/functions/Makefile
> > index 5c13001deaba..696473fce50e 100644
> > --- a/drivers/pci/endpoint/functions/Makefile
> > +++ b/drivers/pci/endpoint/functions/Makefile
> > @@ -6,3 +6,4 @@
> >  obj-$(CONFIG_PCI_EPF_TEST)		+= pci-epf-test.o
> >  obj-$(CONFIG_PCI_EPF_NTB)		+= pci-epf-ntb.o
> >  obj-$(CONFIG_PCI_EPF_VNTB) 		+= pci-epf-vntb.o
> > +obj-$(CONFIG_PCI_EPF_MHI)		+= pci-epf-mhi.o
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
> > new file mode 100644
> > index 000000000000..df924fb10e4d
> > --- /dev/null
> > +++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c

[...]

> > +#define MHI_EP_CHANNEL_CONFIG_UL(ch_num, ch_name)	\
> > +	{						\
> > +		.num = ch_num,				\
> > +		.name = ch_name,			\
> > +		.dir = DMA_TO_DEVICE,			\
> > +	}
> > +
> > +#define MHI_EP_CHANNEL_CONFIG_DL(ch_num, ch_name)	\
> > +	{						\
> > +		.num = ch_num,				\
> > +		.name = ch_name,			\
> > +		.dir = DMA_FROM_DEVICE,			\
> > +	}
> 
> You can define it as:
> 
> #define MHI_EP_CHANNEL_CONFIG(ch_num, ch_name, dir)	\
> 	{						\
> 		.num = ch_num,				\
> 		.name = ch_name,			\
> 		.dir = dir,				\
> 	}
> 
> #define MHI_EP_CHANNEL_CONFIG_DL(ch_num, ch_name)	\
> 	MHI_EP_CHANNEL_CONFIG(ch_num, ch_name, DMA_FROM_DEVICE)
> 
> 
> etc.

Ok.

> 
> 		
> > +
> > +static const struct mhi_ep_channel_config mhi_v1_channels[] = {
> > +	MHI_EP_CHANNEL_CONFIG_UL(0, "LOOPBACK"),
> > +	MHI_EP_CHANNEL_CONFIG_DL(1, "LOOPBACK"),
> > +	MHI_EP_CHANNEL_CONFIG_UL(2, "SAHARA"),
> > +	MHI_EP_CHANNEL_CONFIG_DL(3, "SAHARA"),
> > +	MHI_EP_CHANNEL_CONFIG_UL(4, "DIAG"),
> > +	MHI_EP_CHANNEL_CONFIG_DL(5, "DIAG"),
> > +	MHI_EP_CHANNEL_CONFIG_UL(6, "SSR"),
> > +	MHI_EP_CHANNEL_CONFIG_DL(7, "SSR"),
> > +	MHI_EP_CHANNEL_CONFIG_UL(8, "QDSS"),
> > +	MHI_EP_CHANNEL_CONFIG_DL(9, "QDSS"),
> > +	MHI_EP_CHANNEL_CONFIG_UL(10, "EFS"),
> > +	MHI_EP_CHANNEL_CONFIG_DL(11, "EFS"),
> > +	MHI_EP_CHANNEL_CONFIG_UL(12, "MBIM"),
> > +	MHI_EP_CHANNEL_CONFIG_DL(13, "MBIM"),
> > +	MHI_EP_CHANNEL_CONFIG_UL(14, "QMI"),
> > +	MHI_EP_CHANNEL_CONFIG_DL(15, "QMI"),
> > +	MHI_EP_CHANNEL_CONFIG_UL(16, "QMI"),
> > +	MHI_EP_CHANNEL_CONFIG_DL(17, "QMI"),
> > +	MHI_EP_CHANNEL_CONFIG_UL(18, "IP-CTRL-1"),
> > +	MHI_EP_CHANNEL_CONFIG_DL(19, "IP-CTRL-1"),
> > +	MHI_EP_CHANNEL_CONFIG_UL(20, "IPCR"),
> > +	MHI_EP_CHANNEL_CONFIG_DL(21, "IPCR"),
> > +	MHI_EP_CHANNEL_CONFIG_UL(32, "DUN"),
> > +	MHI_EP_CHANNEL_CONFIG_DL(33, "DUN"),
> > +	MHI_EP_CHANNEL_CONFIG_UL(46, "IP_SW0"),
> > +	MHI_EP_CHANNEL_CONFIG_DL(47, "IP_SW0"),
> > +};
> > +
> > +static const struct mhi_ep_cntrl_config mhi_v1_config = {
> > +	.max_channels = 128,
> > +	.num_channels = ARRAY_SIZE(mhi_v1_channels),
> > +	.ch_cfg = mhi_v1_channels,
> > +	.mhi_version = MHI_VERSION_1_0,
> > +};
> > +
> > +static struct pci_epf_header sdx55_header = {
> > +	.vendorid = PCI_VENDOR_ID_QCOM,
> > +	.deviceid = 0x0306,
> > +	.baseclass_code = PCI_BASE_CLASS_COMMUNICATION,
> > +	.subclass_code = PCI_CLASS_COMMUNICATION_MODEM & 0xff,
> > +	.interrupt_pin	= PCI_INTERRUPT_INTA,
> > +};
> > +
> > +static const struct pci_epf_mhi_ep_info sdx55_info = {
> > +	.config = &mhi_v1_config,
> > +	.epf_header = &sdx55_header,
> > +	.bar_num = BAR_0,
> > +	.epf_flags = PCI_BASE_ADDRESS_MEM_TYPE_32,
> > +	.msi_count = 32,
> > +	.mru = 0x8000,
> > +};
> > +
> > +struct pci_epf_mhi {
> > +	const struct pci_epf_mhi_ep_info *info;
> > +	struct mhi_ep_cntrl mhi_cntrl;
> > +	struct pci_epf *epf;
> > +	struct mutex lock;
> > +	void __iomem *mmio;
> > +	resource_size_t mmio_phys;
> > +	u32 mmio_size;
> > +	int irq;
> > +	bool mhi_registered;
> 
> Do we really need this variable ? Can't it be inferred from
> the framework ?
> 

Looks like yes. More below.

> > +};
> > +
> > +static int pci_epf_mhi_alloc_map(struct mhi_ep_cntrl *mhi_cntrl, u64 pci_addr,
> > +				 phys_addr_t *phys_ptr, void __iomem **virt, size_t size)
> > +{
> > +	struct pci_epf_mhi *epf_mhi = container_of(mhi_cntrl, struct pci_epf_mhi, mhi_cntrl);
> > +	struct pci_epf *epf = epf_mhi->epf;
> > +	struct pci_epc *epc = epf_mhi->epf->epc;
> > +	size_t offset = pci_addr & (epc->mem->window.page_size - 1);
> > +	void __iomem *virt_addr;
> > +	phys_addr_t phys_addr;
> > +	int ret;
> > +
> > +	virt_addr = pci_epc_mem_alloc_addr(epc, &phys_addr, size + offset);
> > +	if (!virt_addr)
> > +		return -ENOMEM;
> > +
> > +	ret = pci_epc_map_addr(epc, epf->func_no, epf->vfunc_no, phys_addr, pci_addr - offset,
> > +			       size + offset);
> > +	if (ret) {
> > +		pci_epc_mem_free_addr(epc, phys_addr, virt_addr, size + offset);
> > +
> > +		return ret;
> > +	}
> > +
> > +	*phys_ptr = phys_addr + offset;
> > +	*virt = virt_addr + offset;
> > +
> > +	return 0;
> > +}
> > +
> > +static void pci_epf_mhi_unmap_free(struct mhi_ep_cntrl *mhi_cntrl, u64 pci_addr,
> > +				   phys_addr_t phys_addr, void __iomem *virt_addr, size_t size)
> > +{
> > +	struct pci_epf_mhi *epf_mhi = container_of(mhi_cntrl, struct pci_epf_mhi, mhi_cntrl);
> > +	struct pci_epf *epf = epf_mhi->epf;
> > +	struct pci_epc *epc = epf->epc;
> > +	size_t offset = pci_addr & (epc->mem->window.page_size - 1);
> > +
> > +	pci_epc_unmap_addr(epc, epf->func_no, epf->vfunc_no, phys_addr - offset);
> > +	pci_epc_mem_free_addr(epc, phys_addr - offset, virt_addr - offset, size + offset);
> > +}
> > +
> > +static void pci_epf_mhi_raise_irq(struct mhi_ep_cntrl *mhi_cntrl, u32 vector)
> > +{
> > +	struct pci_epf_mhi *epf_mhi = container_of(mhi_cntrl, struct pci_epf_mhi, mhi_cntrl);
> > +	struct pci_epf *epf = epf_mhi->epf;
> > +	struct pci_epc *epc = epf->epc;
> > +
> > +	/*
> > +	 * Vector is incremented by 1 here as the DWC core will decrement it before
> > +	 * writing to iATU.
> 
> This isn't OK. It is an API, you can't write code explicitly relying on
> the underlying implementation. I assume the API is not well specified,
> that's why we need these tricks ?
> 

Well, this is not an API issue but rather an implementation detail of the DWC EP
core driver. The DWC driver expects the interrupt vectors to be 1 based, so it
decrements it before writing to the MSI address:
[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/dwc/pcie-designware-ep.c#n537

> > +	 */
> > +	pci_epc_raise_irq(epc, epf->func_no, epf->vfunc_no, PCI_EPC_IRQ_MSI, vector + 1);
> > +}
> > +
> > +static int pci_epf_mhi_read_from_host(struct mhi_ep_cntrl *mhi_cntrl, u64 from, void __iomem *to,
> > +			       size_t size)
> > +{
> > +	struct pci_epf_mhi *epf_mhi = container_of(mhi_cntrl, struct pci_epf_mhi, mhi_cntrl);
> > +	struct pci_epf *epf = epf_mhi->epf;
> > +	struct pci_epc *epc = epf_mhi->epf->epc;
> > +	void __iomem *tre_buf;
> > +	phys_addr_t tre_phys;
> > +	size_t offset = from % 0x1000;
> 
> Explain what 0x1000 represents - make it a macro if that
> helps
> 

Ok.

> > +	int ret;
> > +
> > +	mutex_lock(&epf_mhi->lock);
> > +
> > +	tre_buf = pci_epc_mem_alloc_addr(epc, &tre_phys, size + offset);
> > +	if (!tre_buf) {
> > +		mutex_unlock(&epf_mhi->lock);
> > +		return -ENOMEM;
> > +	}
> > +
> > +	ret = pci_epc_map_addr(epc, epf->func_no, epf->vfunc_no, tre_phys, from - offset,
> > +			       size + offset);
> > +	if (ret) {
> > +		pci_epc_mem_free_addr(epc, tre_phys, tre_buf, size + offset);
> > +		mutex_unlock(&epf_mhi->lock);
> 
> I'd prefer a single goto label instead of repeating the code for every
> branch taken but that's up to you.
> 

Ok.

> > +		return ret;
> > +	}
> > +
> > +	memcpy_fromio(to, tre_buf + offset, size);
> > +
> > +	pci_epc_unmap_addr(epc, epf->func_no, epf->vfunc_no, tre_phys);
> > +	pci_epc_mem_free_addr(epc, tre_phys, tre_buf, size + offset);
> > +
> > +	mutex_unlock(&epf_mhi->lock);
> > +
> > +	return 0;
> > +}
> > +

[...]

> > +static int pci_epf_mhi_link_up(struct pci_epf *epf)
> > +{
> > +	struct pci_epf_mhi *epf_mhi = epf_get_drvdata(epf);
> > +	const struct pci_epf_mhi_ep_info *info = epf_mhi->info;
> > +	struct mhi_ep_cntrl *mhi_cntrl = &epf_mhi->mhi_cntrl;
> > +	struct pci_epc *epc = epf->epc;
> > +	struct device *dev = &epf->dev;
> > +	int ret;
> > +
> > +	mhi_cntrl->mmio = epf_mhi->mmio;
> > +	mhi_cntrl->irq = epf_mhi->irq;
> > +	mhi_cntrl->mru = info->mru;
> > +
> > +	/* Assign the struct dev of PCI EP as MHI controller device */
> > +	mhi_cntrl->cntrl_dev = epc->dev.parent;
> > +	mhi_cntrl->raise_irq = pci_epf_mhi_raise_irq;
> > +	mhi_cntrl->alloc_map = pci_epf_mhi_alloc_map;
> > +	mhi_cntrl->unmap_free = pci_epf_mhi_unmap_free;
> > +	mhi_cntrl->read_from_host = pci_epf_mhi_read_from_host;
> > +	mhi_cntrl->write_to_host = pci_epf_mhi_write_to_host;
> > +
> > +	/* Register the MHI EP controller */
> > +	ret = mhi_ep_register_controller(mhi_cntrl, info->config);
> > +	if (ret) {
> > +		dev_err(dev, "Failed to register MHI EP controller: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	epf_mhi->mhi_registered = true;
> 
> I don't like this. It should be part of mhi_ep_register_controller();
> 

Hmm, I could use the "mhi_dev" pointer instead of a dedicated variable.

> > +
> > +	return 0;
> > +}
> > +
> > +static int pci_epf_mhi_link_down(struct pci_epf *epf)
> > +{
> > +	struct pci_epf_mhi *epf_mhi = epf_get_drvdata(epf);
> > +	struct mhi_ep_cntrl *mhi_cntrl = &epf_mhi->mhi_cntrl;
> > +
> > +	if (epf_mhi->mhi_registered) {
> > +		mhi_ep_power_down(mhi_cntrl);
> > +		mhi_ep_unregister_controller(mhi_cntrl);
> > +		epf_mhi->mhi_registered = false;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int pci_epf_mhi_bme(struct pci_epf *epf)
> > +{
> > +	struct pci_epf_mhi *epf_mhi = epf_get_drvdata(epf);
> > +	struct mhi_ep_cntrl *mhi_cntrl = &epf_mhi->mhi_cntrl;
> > +	struct device *dev = &epf->dev;
> > +	int ret;
> > +
> > +	/* Power up the MHI EP stack if link is up and stack is in power down state */
> > +	if (!mhi_cntrl->enabled && epf_mhi->mhi_registered) {
> > +		ret = mhi_ep_power_up(mhi_cntrl);
> > +		if (ret) {
> > +			dev_err(dev, "Failed to power up MHI EP: %d\n", ret);
> > +			mhi_ep_unregister_controller(mhi_cntrl);
> > +			epf_mhi->mhi_registered = false;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int pci_epf_mhi_bind(struct pci_epf *epf)
> > +{
> > +	struct pci_epf_mhi *epf_mhi = epf_get_drvdata(epf);
> > +	struct pci_epc *epc = epf->epc;
> > +	struct platform_device *pdev = to_platform_device(epc->dev.parent);
> > +	struct device *dev = &epf->dev;
> > +	struct resource *res;
> > +	int ret;
> > +
> > +	if (WARN_ON_ONCE(!epc))
> > +		return -EINVAL;
> > +
> > +	/* Get MMIO base address from Endpoint controller */
> > +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "mmio");
> > +	epf_mhi->mmio_phys = res->start;
> > +	epf_mhi->mmio_size = resource_size(res);
> > +
> > +	epf_mhi->mmio = ioremap_wc(epf_mhi->mmio_phys, epf_mhi->mmio_size);
> 
> ioremap_wc(). Why wc mappings ? Please explain.
> 

I saw a reference to write combined access requirement for the MMIO region but
couldn't verify it now. Will revert to non_wc mapping.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
