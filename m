Return-Path: <linux-pci+bounces-18639-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A889F4DEE
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 15:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AA2E18884C5
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 14:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA801F428B;
	Tue, 17 Dec 2024 14:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y8iSMH60"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E581F239E
	for <linux-pci@vger.kernel.org>; Tue, 17 Dec 2024 14:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734446135; cv=none; b=iwEANPoVL1Rz3szkJQU7cYqpwdgQuANXJ3VZE2JIbrs1AVUvzwcTNvWbeaeCAfZV/giayOzNLBxVjDkTzOUp+6LtPIIezN4SN5Q2Z0u4IsJKmwl9asL9vNFl2JIdjLjYdENeCa7FYW1cPNPpuVNnBJpon93oy6ybmwjNGcrfG8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734446135; c=relaxed/simple;
	bh=DIznGnkD+cJkT6D4uFZk4PFQcwNNI1dPTclUv+wTHsk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qj1Ae4a70R6QfDs8wFMKWPwWwmicuJKBJp1IHTyJ2IOyCjoQR3MSBsSmz6GwLhyE3/ecOfS8xzR9X4p0rKvAC0ygRoOA+GVjLjn/7At2Ia28Mme8AbcSqAAitjQtaNR8qnJvA5H0RKTOrj1qyTNXGcqUZuxgvj/4iKHcSH/eOPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y8iSMH60; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C007C4CED3;
	Tue, 17 Dec 2024 14:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734446135;
	bh=DIznGnkD+cJkT6D4uFZk4PFQcwNNI1dPTclUv+wTHsk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Y8iSMH60BxhEKFfWuK2qQ1/VdCBNC8/Uk5bOHNPcp3nlRfNMHJTclOpFLNznUsS90
	 Z+48iO3vMWVPpe5rbwydryUDjgbXdFQ5UjnRLnZWPD/+DWLi4VUgaieiRLbwFa36+f
	 eJG6RcOGDTnAYHJFDVvnBlpstPqCY1hdzDd+Rgzk8YP4Lbbrm9FtAxt/TsacSUDvPL
	 2od15LNXLs6Q9OgF1PVl3msw6M69jMY/WRp7Pp52vSQe6Cna4o/doPMn65n24fehhy
	 35YQHE58NqzhhjFjCMCGSRp1CUSS4VuHnZUsxWin5qrUjnYmDHZEz+AdB/3sSWkujr
	 DA7CVnfm3A+0A==
Message-ID: <4015e54a-54a5-4ac7-ae1c-3d2fb935b20f@kernel.org>
Date: Tue, 17 Dec 2024 06:35:33 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 17/18] nvmet: New NVMe PCI endpoint target driver
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-pci@vger.kernel.org, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kw@linux.com>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Rick Wertenbroek <rick.wertenbroek@gmail.com>,
 Niklas Cassel <cassel@kernel.org>
References: <20241212113440.352958-1-dlemoal@kernel.org>
 <20241212113440.352958-18-dlemoal@kernel.org>
 <20241217085355.y6bqqisqbr5kbxkl@thinkpad>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20241217085355.y6bqqisqbr5kbxkl@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/12/17 0:53, Manivannan Sadhasivam wrote:
> [...]
> 
>> +/*
>> + * PCI EPF driver private data.
>> + */
>> +struct nvmet_pciep_epf {
> 
> nvmet_pci_epf?
> 
>> +	struct pci_epf			*epf;
>> +
>> +	const struct pci_epc_features	*epc_features;
>> +
>> +	void				*reg_bar;
>> +	size_t				msix_table_offset;
>> +
>> +	unsigned int			irq_type;
>> +	unsigned int			nr_vectors;
>> +
>> +	struct nvmet_pciep_ctrl		ctrl;
>> +
>> +	struct dma_chan			*dma_tx_chan;
>> +	struct mutex			dma_tx_lock;
>> +	struct dma_chan			*dma_rx_chan;
>> +	struct mutex			dma_rx_lock;
>> +
>> +	struct mutex			mmio_lock;
>> +
>> +	/* PCI endpoint function configfs attributes */
>> +	struct config_group		group;
>> +	bool				dma_enable;
>> +	__le16				portid;
>> +	char				subsysnqn[NVMF_NQN_SIZE];
>> +	unsigned int			mdts_kb;
>> +};
>> +
>> +static inline u32 nvmet_pciep_bar_read32(struct nvmet_pciep_ctrl *ctrl, u32 off)
>> +{
>> +	__le32 *bar_reg = ctrl->bar + off;
>> +
>> +	return le32_to_cpu(READ_ONCE(*bar_reg));
> 
> Looks like you can use readl/writel variants here. Any reason to not use them?

A bar memory comes from dma_alloc_coherent(), which is a "void *" pointer and
*not* iomem. So using readl/writel for accessing that memory seems awefully
wrong to me.

>> +static bool nvmet_pciep_epf_init_dma(struct nvmet_pciep_epf *nvme_epf)
>> +{
>> +	struct pci_epf *epf = nvme_epf->epf;
>> +	struct device *dev = &epf->dev;
>> +	struct nvmet_pciep_epf_dma_filter filter;
>> +	struct dma_chan *chan;
>> +	dma_cap_mask_t mask;
>> +
>> +	mutex_init(&nvme_epf->dma_rx_lock);
>> +	mutex_init(&nvme_epf->dma_tx_lock);
>> +
>> +	dma_cap_zero(mask);
>> +	dma_cap_set(DMA_SLAVE, mask);
>> +
>> +	filter.dev = epf->epc->dev.parent;
>> +	filter.dma_mask = BIT(DMA_DEV_TO_MEM);
>> +
>> +	chan = dma_request_channel(mask, nvmet_pciep_epf_dma_filter, &filter);
>> +	if (!chan)
>> +		return false;
> 
> You should also destroy mutexes in error path.

Good catch. Will add that.

[...]

>> +static int nvmet_pciep_epf_dma_transfer(struct nvmet_pciep_epf *nvme_epf,
>> +		struct nvmet_pciep_segment *seg, enum dma_data_direction dir)
>> +{
>> +	struct pci_epf *epf = nvme_epf->epf;
>> +	struct dma_async_tx_descriptor *desc;
>> +	struct dma_slave_config sconf = {};
>> +	struct device *dev = &epf->dev;
>> +	struct device *dma_dev;
>> +	struct dma_chan *chan;
>> +	dma_cookie_t cookie;
>> +	dma_addr_t dma_addr;
>> +	struct mutex *lock;
>> +	int ret;
>> +
>> +	switch (dir) {
>> +	case DMA_FROM_DEVICE:
>> +		lock = &nvme_epf->dma_rx_lock;
>> +		chan = nvme_epf->dma_rx_chan;
>> +		sconf.direction = DMA_DEV_TO_MEM;
>> +		sconf.src_addr = seg->pci_addr;
>> +		break;
>> +	case DMA_TO_DEVICE:
>> +		lock = &nvme_epf->dma_tx_lock;
>> +		chan = nvme_epf->dma_tx_chan;
>> +		sconf.direction = DMA_MEM_TO_DEV;
>> +		sconf.dst_addr = seg->pci_addr;
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	mutex_lock(lock);
>> +
>> +	dma_dev = dmaengine_get_dma_device(chan);
>> +	dma_addr = dma_map_single(dma_dev, seg->buf, seg->length, dir);
>> +	ret = dma_mapping_error(dma_dev, dma_addr);
>> +	if (ret)
>> +		goto unlock;
>> +
>> +	ret = dmaengine_slave_config(chan, &sconf);
>> +	if (ret) {
>> +		dev_err(dev, "Failed to configure DMA channel\n");
>> +		goto unmap;
>> +	}
>> +
>> +	desc = dmaengine_prep_slave_single(chan, dma_addr, seg->length,
>> +					   sconf.direction, DMA_CTRL_ACK);
>> +	if (!desc) {
>> +		dev_err(dev, "Failed to prepare DMA\n");
>> +		ret = -EIO;
>> +		goto unmap;
>> +	}
>> +
>> +	cookie = dmaengine_submit(desc);
>> +	ret = dma_submit_error(cookie);
>> +	if (ret) {
>> +		dev_err(dev, "DMA submit failed %d\n", ret);
>> +		goto unmap;
>> +	}
>> +
>> +	if (dma_sync_wait(chan, cookie) != DMA_COMPLETE) {
> 
> Why do you need to do sync tranfer all the time? This defeats the purpose of
> using DMA.

You may be getting confused about the meaning of sync here. This simply means
"spin wait for the completion of the transfer". I initially was using the
completion callback like in pci-epf-tets and othe EPF drivers doing DMA, but
that causes a context switch for every transfer, even small ones, which really
hurts performance. Switching to using dma_sync_wait() avoids this context switch
while achieving what we need, which is to wait for the end of the transfer. I
nearly doubled the max IOPS for small IOs with this.

Note that we cannot easily do asynchronous DMA transfers with the current DMA
slave API, unless we create some special work item responsible for DMA transfers.

I did not try to micro optimize this driver too much for this first drop. Any
improvement around how data transfers are done can come later. The preformance I
am getting with this code is decent enough as it is.

[...]

>> +static inline int nvmet_pciep_epf_transfer(struct nvmet_pciep_epf *nvme_epf,
> 
> No need to add 'inline' keyword in .c files.

Yes there is. Because that funtion is tiny and I really want it to be forced to
be inlined.

[...]

>> +invalid_offset:
>> +	dev_err(ctrl->dev, "PRPs list invalid offset\n");
>> +	kfree(prps);
>> +	iod->status = NVME_SC_PRP_INVALID_OFFSET | NVME_STATUS_DNR;
>> +	return -EINVAL;
>> +
>> +invalid_field:
>> +	dev_err(ctrl->dev, "PRPs list invalid field\n");
>> +	kfree(prps);
>> +	iod->status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
>> +	return -EINVAL;
>> +
>> +internal:
>> +	dev_err(ctrl->dev, "PRPs list internal error\n");
>> +	kfree(prps);
>> +	iod->status = NVME_SC_INTERNAL | NVME_STATUS_DNR;
>> +	return -EINVAL;
> 
> Can't you organize the labels in such a way that there is only one return path?
> Current code makes it difficult to read and also would confuse the static
> checkers.

I do not see how this is difficult to read... But sure, I can try to simplify this.


> [...]
> 
>> +static void nvmet_pciep_init_bar(struct nvmet_pciep_ctrl *ctrl)
>> +{
>> +	struct nvmet_ctrl *tctrl = ctrl->tctrl;
>> +
>> +	ctrl->bar = ctrl->nvme_epf->reg_bar;
>> +
>> +	/* Copy the target controller capabilities as a base */
>> +	ctrl->cap = tctrl->cap;
>> +
>> +	/* Contiguous Queues Required (CQR) */
>> +	ctrl->cap |= 0x1ULL << 16;
>> +
>> +	/* Set Doorbell stride to 4B (DSTRB) */
>> +	ctrl->cap &= ~GENMASK(35, 32);
>> +
>> +	/* Clear NVM Subsystem Reset Supported (NSSRS) */
>> +	ctrl->cap &= ~(0x1ULL << 36);
>> +
>> +	/* Clear Boot Partition Support (BPS) */
>> +	ctrl->cap &= ~(0x1ULL << 45);
>> +
>> +	/* Clear Persistent Memory Region Supported (PMRS) */
>> +	ctrl->cap &= ~(0x1ULL << 56);
>> +
>> +	/* Clear Controller Memory Buffer Supported (CMBS) */
>> +	ctrl->cap &= ~(0x1ULL << 57);
> 
> Can you use macros for these?

I could. But that would mean defining *all* bits of the cap register, which is a
lot... The NVMe code does not have all these defined now. That is a cleanup that
can come later I think.

[...]

>> +	if (epc_features->msix_capable) {
>> +		size_t pba_size;
>> +
>> +		msix_table_size = PCI_MSIX_ENTRY_SIZE * epf->msix_interrupts;
>> +		nvme_epf->msix_table_offset = reg_size;
>> +		pba_size = ALIGN(DIV_ROUND_UP(epf->msix_interrupts, 8), 8);
>> +
>> +		reg_size += msix_table_size + pba_size;
>> +	}
>> +
>> +	reg_bar_size = ALIGN(reg_size, max(epc_features->align, 4096));
> 
> From where does this 4k alignment comes from? NVMe spec? If so, is it OK to use
> fixed_size BAR?

NVMe BAR cannot be fixed size as its size depends on the number of queue pairs
the controller can support. Will check if the 4K alignment is mandated by the
specs. But it sure does not hurt...

[...]

>> +	/* Create the target controller. */
>> +	ret = nvmet_pciep_create_ctrl(nvme_epf, max_nr_queues);
>> +	if (ret) {
>> +		dev_err(&epf->dev,
>> +			"Create NVMe PCI target controller failed\n");
> 
> Failed to create NVMe PCI target controller

How is that better ?

> 
>> +		return ret;
>> +	}
>> +
>> +	if (epf->vfunc_no <= 1) {
> 
> Are you really supporting virtual functions? If supported, 'vfunc_no < 1' is not
> possible.

NVMe does support virtual functions and nothing in the configuration path
prevents the user from setting one such function. So yes, this is supposed to
work if the endpoint controller supports it. Though I must say that I have not
tried/tested yet.

> 
>> +		/* Set device ID, class, etc */
>> +		epf->header->vendorid = ctrl->tctrl->subsys->vendor_id;
>> +		epf->header->subsys_vendor_id =
>> +			ctrl->tctrl->subsys->subsys_vendor_id;
> 
> Why these are coming from somewhere else and not configured within the EPF
> driver?

They are set through the nvme target configfs. So there is no need to have these
again setup through the epf configfs. We just grab the values set for the NVME
target subsystem config.

>> +static int nvmet_pciep_epf_link_up(struct pci_epf *epf)
>> +{
>> +	struct nvmet_pciep_epf *nvme_epf = epf_get_drvdata(epf);
>> +	struct nvmet_pciep_ctrl *ctrl = &nvme_epf->ctrl;
>> +
>> +	dev_info(nvme_epf->ctrl.dev, "PCI link up\n");
> 
> These prints are supposed to come from the controller drivers. So no need to
> have them here also.

Nope, the controller driver does not print anything. At least the DWC driver
does not print anything.

>> +static ssize_t nvmet_pciep_epf_dma_enable_store(struct config_item *item,
>> +					     const char *page, size_t len)
>> +{
>> +	struct config_group *group = to_config_group(item);
>> +	struct nvmet_pciep_epf *nvme_epf = to_nvme_epf(group);
>> +	int ret;
>> +
>> +	if (nvme_epf->ctrl.tctrl)
>> +		return -EBUSY;
>> +
>> +	ret = kstrtobool(page, &nvme_epf->dma_enable);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return len;
>> +}
>> +
>> +CONFIGFS_ATTR(nvmet_pciep_epf_, dma_enable);
> 
> What is the use of making this option user configurable? It is purely a hardware
> capability and I don't think users would want to have their NVMe device working
> without DMA voluntarily.

If you feel strongly about it, I can drop this. But it is useful for debugging
purpose to check that the DMA API is being used and working correctly.

>> +static int __init nvmet_pciep_init_module(void)
>> +{
>> +	int ret;
>> +
>> +	ret = pci_epf_register_driver(&nvmet_pciep_epf_driver);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = nvmet_register_transport(&nvmet_pciep_fabrics_ops);
> 
> What is the need to register the transport so early? You should consider moving
> the registration to bind() so that the transport can be removed once the driver
> is unbind with the controller.

This registration is needed to enable the configfs configuration of the nvme
target subsystem and port. Withoutn this, setting a port transporet type to
"pci" would fail to find the pci transport implemented here and the
configuration would fail. This configuration of the nvme target susbsystem and
port must come before configuring the EPF and binding it.




-- 
Damien Le Moal
Western Digital Research

