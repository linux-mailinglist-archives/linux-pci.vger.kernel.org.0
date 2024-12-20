Return-Path: <linux-pci+bounces-18911-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B70569F9637
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 17:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 543827A2433
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 16:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89BA9218E9F;
	Fri, 20 Dec 2024 16:19:50 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCB929405
	for <linux-pci@vger.kernel.org>; Fri, 20 Dec 2024 16:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734711590; cv=none; b=OsVLEphPwVG626+n7cPB9SABSK6ONBjgYyYRrZs0p17X4fpE9MRjypk8f5M5VV0uRkTnBAdv5nwPDMJyfb4YDKDBdkMYTpV3vQ+12HNMCg9Hs7C0KO8Dt+6TDJibMwiGRfthJYEtUWmpM50gGJRyhOiJe1/xY9J+UMwN0GQTM/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734711590; c=relaxed/simple;
	bh=7J9SseknIGmbe1UHiGUdTV9SbtBgNqo5OgqusejBfGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AFBjRZitpAm/yP0PN7rTaFho97P9SpahJ+SFjrWy2IthWidPDpVFhmn+DJf8+RPqtquUHiBiZFv79ndnAW1Dw7bq+yFUKCU11opUejw8NUE/xksKSVcb+8l3R8hjCz6m/yjGiaW9HK//CVYkg3eKoYLcEHvrxbQLU9kFaPGnWso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2161eb95317so21024525ad.1
        for <linux-pci@vger.kernel.org>; Fri, 20 Dec 2024 08:19:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734711588; x=1735316388;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ehY0BRtTi774oOyk6/6hLQ1XGvflXkt1M7GGFhFmz3g=;
        b=Yb5R2evwIFb9rOqkPoHFDBSHJ7M/PBaQ9iXprJnBsEv9niFzMwijcREP0ZERwSlSaw
         KizGigJ76yKUkFX94xBNvaJD+J07K6B8VfmW8+VEAxjEHU9UieGHGpgTRSwlUsBfnJtk
         YifUnOr4urToJFyS/3db3Aa7NMbOgOszQ7Ht9faN5YWEQ+I8heHg4DAsQhOoluJj5OGV
         +/6IqpMpDxtTXohV645MZk/4WSgcZp1Vvf1QJc+wCr+ay2bSAdSHDvNrD/J9mxGC1u5i
         5B6DwhNb1kWb5D90YUWN+pL6ItbG1t4ruGNuOBpcKa5VOfYF8i6XUsUDY0KNLY4rUC/R
         9KEw==
X-Forwarded-Encrypted: i=1; AJvYcCXQS74qNfUtSFAuByZUrnOY98lY07RFgwgT8U82lTjE6mMeUGWJJZoyrkwCRl9P+vdgHQ5wV5ywNbc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxozLiTL1YchtIHGT94HDioPXunIqeFs/Ppdr1HIQCf/5+3JGkB
	Z5NJgsB5AjRNT6alPg450rCRgAcHiMvECwJysWdoOgcgL0D/XzK9
X-Gm-Gg: ASbGncsXmJCRYWg92Io0auY3VS0BnL7vh7BUOW/yuafD8jFtftcLeJLLJyTmjplRNtX
	m1/+2yV/np7A4LluMVkqRwmVI/Dy8ZE6xQ2xnbOycNsMq9COB8lf+8tE/oTmqIifHvlZqnytird
	3YYpE9h5F9HUkQ1tQhpWe6ay8VjfzIQXUkyhJ59ZGDWOERqaQ8kRnY3lUJNI3N7FfoCzDw9ASUb
	ahPGHwFbeSpe2A2IrE459+aWyPsMYG1v3T14HhbhN4Irtv2ub67x1JFtcLSYw4ng1SRcfA6jlgz
	bnWtvLdQqFxvb0k=
X-Google-Smtp-Source: AGHT+IEU39pi1xaCFza1oWqMrRusspYhLQuHLpR3Dl5Zp1BO28lOcWxiz4a0FUcQJG3s1UYPwg/9bQ==
X-Received: by 2002:a17:902:eccc:b0:216:53fa:634f with SMTP id d9443c01a7336-219e6f27f90mr46704135ad.48.1734711587602;
        Fri, 20 Dec 2024 08:19:47 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9d4441sm30163595ad.129.2024.12.20.08.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 08:19:46 -0800 (PST)
Date: Sat, 21 Dec 2024 01:19:45 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-pci@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v7 17/18] nvmet: New NVMe PCI endpoint function target
 driver
Message-ID: <20241220161945.GA1007198@rocinante>
References: <20241220095108.601914-1-dlemoal@kernel.org>
 <20241220095108.601914-18-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241220095108.601914-18-dlemoal@kernel.org>

Hello,

> Implement a PCI target driver using the PCI endpoint framework. This
> requires hardware with a PCI controller capable of executing in endpoint
> mode.

This is an excellent work which was a pleasure to review, and I only have
few minor review comments, neither of which are blockers.

Otherwise, with pleasure:

  Reviewed-by: Krzysztof Wilczyński <kwilczynski@kernel.org>

> +config NVME_TARGET_PCI_EPF
> +	tristate "NVMe PCI Endpoint Function target support"
> +	depends on NVME_TARGET && PCI_ENDPOINT
> +	help
> +	  This enables the NVMe PCI endpoint function target driver support,
> +	  which allows creating a NVMe PCI controller using an endpoint mode
> +	  capable PCI controller.
> +

Perhaps:

  This enables the NVMe PCI Endpoint Function target support, which allows
  for the creation of an NVMe PCI controller using an endpoint mode capable
  PCI Express controller.

The above is a slightly different wordings and also keeps capitalisation
consistent with rest of the code base.

> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * NVMe PCI Endpoint Function driver.

To keep things consistent:

  NVMe PCI Endpoint Function target driver.

> +struct nvmet_pci_epf_iod {
> +	struct list_head		link;
> +
> +	struct nvmet_req		req;
> +	struct nvme_command		cmd;
> +	struct nvme_completion		cqe;
> +	unsigned int			status;
> +
> +	struct nvmet_pci_epf_ctrl	*ctrl;
> +
> +	struct nvmet_pci_epf_queue	*sq;
> +	struct nvmet_pci_epf_queue	*cq;
> +
> +	/* Data transfer size and direction for the command. */
> +	size_t				data_len;
> +	enum dma_data_direction		dma_dir;
> +
> +	/*
> +	 * RC PCI address data segments: if nr_data_segs is 1, we use only
> +	 * @data_seg. Otherwise, the array of segments @data_segs is allocated
> +	 * to manage multiple PCI address data segments. @data_sgl and @data_sgt
> +	 * are used to setup the command request for execution by the target
> +	 * core.
> +	 */

What about:

  PCI Root Complex (RC) address data segments: ...

> +static int nvmet_pci_epf_dma_transfer(struct nvmet_pci_epf *nvme_epf,
> +		struct nvmet_pci_epf_segment *seg, enum dma_data_direction dir)
> +{
> +	struct pci_epf *epf = nvme_epf->epf;
> +	struct dma_async_tx_descriptor *desc;
> +	struct dma_slave_config sconf = {};
> +	struct device *dev = &epf->dev;
> +	struct device *dma_dev;
> +	struct dma_chan *chan;
> +	dma_cookie_t cookie;
> +	dma_addr_t dma_addr;
> +	struct mutex *lock;
> +	int ret;
> +
> +	switch (dir) {
> +	case DMA_FROM_DEVICE:
> +		lock = &nvme_epf->dma_rx_lock;
> +		chan = nvme_epf->dma_rx_chan;
> +		sconf.direction = DMA_DEV_TO_MEM;
> +		sconf.src_addr = seg->pci_addr;
> +		break;
> +	case DMA_TO_DEVICE:
> +		lock = &nvme_epf->dma_tx_lock;
> +		chan = nvme_epf->dma_tx_chan;
> +		sconf.direction = DMA_MEM_TO_DEV;
> +		sconf.dst_addr = seg->pci_addr;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	mutex_lock(lock);
> +
> +	dma_dev = dmaengine_get_dma_device(chan);
> +	dma_addr = dma_map_single(dma_dev, seg->buf, seg->length, dir);
> +	ret = dma_mapping_error(dma_dev, dma_addr);
> +	if (ret)
> +		goto unlock;
> +
> +	ret = dmaengine_slave_config(chan, &sconf);
> +	if (ret) {
> +		dev_err(dev, "Failed to configure DMA channel\n");
> +		goto unmap;
> +	}
> +
> +	desc = dmaengine_prep_slave_single(chan, dma_addr, seg->length,
> +					   sconf.direction, DMA_CTRL_ACK);
> +	if (!desc) {
> +		dev_err(dev, "Failed to prepare DMA\n");
> +		ret = -EIO;
> +		goto unmap;
> +	}
> +
> +	cookie = dmaengine_submit(desc);
> +	ret = dma_submit_error(cookie);
> +	if (ret) {
> +		dev_err(dev, "DMA submit failed %d\n", ret);
> +		goto unmap;
> +	}

To keep the verb first and for consistency with other error messages:

  dev_err(dev, "Failed to submit DMA %d\n", ret);

Or:

  dev_err(dev, "Failed to do DMA submit %d\n", ret);

Some drivers seem to favour the latter.

> +
> +	if (dma_sync_wait(chan, cookie) != DMA_COMPLETE) {
> +		dev_err(dev, "DMA transfer failed\n");
> +		ret = -EIO;
> +	}

As there is a timeout involved, perhaps:

  dev_err(dev, "Failed while waiting for DMA transfer\n");

Or:

  dev_err(dev, "Failed to wait for DMA completion\n");

> +static void nvmet_pci_epf_raise_irq(struct nvmet_pci_epf_ctrl *ctrl,
> +		struct nvmet_pci_epf_queue *cq, bool force)
> +{
> +	struct nvmet_pci_epf *nvme_epf = ctrl->nvme_epf;
> +	struct pci_epf *epf = nvme_epf->epf;
> +	int ret = 0;
> +
> +	if (!test_bit(NVMET_PCI_EPF_Q_LIVE, &cq->flags))
> +		return;
> +
> +	mutex_lock(&ctrl->irq_lock);
> +
> +	if (!nvmet_pci_epf_should_raise_irq(ctrl, cq, force))
> +		goto unlock;
> +
> +	switch (nvme_epf->irq_type) {
> +	case PCI_IRQ_MSIX:
> +	case PCI_IRQ_MSI:
> +		ret = pci_epc_raise_irq(epf->epc, epf->func_no, epf->vfunc_no,
> +					nvme_epf->irq_type, cq->vector + 1);
> +		if (!ret)
> +			break;
> +		/*
> +		 * If we got an error, it is likely because the host is using
> +		 * legacy IRQs (e.g. BIOS, grub).
> +		 */
> +		fallthrough;
> +	case PCI_IRQ_INTX:
> +		ret = pci_epc_raise_irq(epf->epc, epf->func_no, epf->vfunc_no,
> +					PCI_IRQ_INTX, 0);
> +		break;
> +	default:
> +		WARN_ON_ONCE(1);
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +	if (ret)
> +		dev_err(ctrl->dev, "Raise IRQ failed %d\n", ret);

Also, for consistency:

  dev_err(ctrl->dev, "Failed to raise IRQ %d\n", ret);

> +static int nvmet_pci_epf_iod_parse_prp_list(struct nvmet_pci_epf_ctrl *ctrl,
> +					    struct nvmet_pci_epf_iod *iod)
> +{
> +	struct nvme_command *cmd = &iod->cmd;
> +	struct nvmet_pci_epf_segment *seg;
> +	size_t size = 0, ofst, prp_size, xfer_len;
> +	size_t transfer_len = iod->data_len;
> +	int nr_segs, nr_prps = 0;
> +	u64 pci_addr, prp;
> +	int i = 0, ret;
> +	__le64 *prps;
> +
> +	prps = kzalloc(ctrl->mps, GFP_KERNEL);
> +	if (!prps)
> +		goto err_internal;
> +
> +	/*
> +	 * Allocate PCI segments for the command: this considers the worst case
> +	 * scenario where all prps are discontiguous, so get as many segments
> +	 * as we can have prps. In practice, most of the time, we will have
> +	 * far less PCI segments than prps.
> +	 */
> +	prp = le64_to_cpu(cmd->common.dptr.prp1);
> +	if (!prp)
> +		goto err_invalid_field;
> +
> +	ofst = nvmet_pci_epf_prp_ofst(ctrl, prp);
> +	nr_segs = (transfer_len + ofst + ctrl->mps - 1) >> ctrl->mps_shift;
> +
> +	ret = nvmet_pci_epf_alloc_iod_data_segs(iod, nr_segs);
> +	if (ret)
> +		goto err_internal;
> +
> +	/* Set the first segment using prp1 */
> +	seg = &iod->data_segs[0];
> +	seg->pci_addr = prp;
> +	seg->length = nvmet_pci_epf_prp_size(ctrl, prp);
> +
> +	size = seg->length;
> +	pci_addr = prp + size;
> +	nr_segs = 1;
> +
> +	/*
> +	 * Now build the PCI address segments using the PRP lists, starting
> +	 * from prp2.
> +	 */
> +	prp = le64_to_cpu(cmd->common.dptr.prp2);
> +	if (!prp)
> +		goto err_invalid_field;
> +
> +	while (size < transfer_len) {
> +		xfer_len = transfer_len - size;
> +
> +		if (!nr_prps) {
> +			/* Get the PRP list */
> +			nr_prps = nvmet_pci_epf_get_prp_list(ctrl, prp,
> +							     xfer_len, prps);
> +			if (nr_prps < 0)
> +				goto err_internal;
> +
> +			i = 0;
> +			ofst = 0;
> +		}
> +
> +		/* Current entry */
> +		prp = le64_to_cpu(prps[i]);
> +		if (!prp)
> +			goto err_invalid_field;
> +
> +		/* Did we reach the last PRP entry of the list ? */

Small nit pick: no space before a question or exclamation mark in English.

> +		if (xfer_len > ctrl->mps && i == nr_prps - 1) {
> +			/* We need more PRPs: PRP is a list pointer */
> +			nr_prps = 0;
> +			continue;
> +		}
> +
> +		/* Only the first PRP is allowed to have an offset */
> +		if (nvmet_pci_epf_prp_ofst(ctrl, prp))
> +			goto err_invalid_offset;
> +
> +		if (prp != pci_addr) {
> +			/* Discontiguous prp: new segment */
> +			nr_segs++;
> +			if (WARN_ON_ONCE(nr_segs > iod->nr_data_segs))
> +				goto err_internal;
> +
> +			seg++;
> +			seg->pci_addr = prp;
> +			seg->length = 0;
> +			pci_addr = prp;
> +		}
> +
> +		prp_size = min_t(size_t, ctrl->mps, xfer_len);
> +		seg->length += prp_size;
> +		pci_addr += prp_size;
> +		size += prp_size;
> +
> +		i++;
> +	}
> +
> +	iod->nr_data_segs = nr_segs;
> +	ret = 0;
> +
> +	if (size != transfer_len) {
> +		dev_err(ctrl->dev, "PRPs transfer length mismatch %zu / %zu\n",
> +			size, transfer_len);
> +		goto err_internal;
> +	}

This makes me think of "got" vs "want", for example:

  dev_err(ctrl->dev, "PRPs transfer length mismatch; got %zu B, want %zu B\n",
          size, transfer_len);

Or using format of messages used here already:

  dev_err(ctrl->dev, "PRPs transfer length mismatch %zu (need %zu)\n",
          size, transfer_len);

> +static int nvmet_pci_epf_iod_parse_prp_simple(struct nvmet_pci_epf_ctrl *ctrl,
> +					      struct nvmet_pci_epf_iod *iod)
> +{
> +	struct nvme_command *cmd = &iod->cmd;
> +	size_t transfer_len = iod->data_len;
> +	int ret, nr_segs = 1;
> +	u64 prp1, prp2 = 0;
> +	size_t prp1_size;
> +
> +	/* prp1 */
> +	prp1 = le64_to_cpu(cmd->common.dptr.prp1);
> +	prp1_size = nvmet_pci_epf_prp_size(ctrl, prp1);

The comment above is very succinct, might not add anything useful here. :)

> +static void nvmet_pci_epf_complete_iod(struct nvmet_pci_epf_iod *iod)
> +{
> +	struct nvmet_pci_epf_queue *cq = iod->cq;
> +	unsigned long flags;
> +
> +	/* Do not print an error message for AENs */
> +	iod->status = le16_to_cpu(iod->cqe.status) >> 1;
> +	if (iod->status && iod->cmd.common.opcode != nvme_admin_async_event)
> +		dev_err(iod->ctrl->dev,
> +			"CQ[%d]: Command %s (0x%x) status 0x%0x\n",
> +			iod->sq->qid, nvmet_pci_epf_iod_name(iod),
> +			iod->cmd.common.opcode, iod->status);

Was this dev_err() here intended to be like the other similarly looking
dev_dbg() invocations?  I wonder whether it would make sense to keep this
a debug message, if needed, and then turn this into an error message.

> +static int nvmet_pci_epf_create_ctrl(struct nvmet_pci_epf *nvme_epf,
> +				     unsigned int max_nr_queues)
> +{
> +	struct nvmet_pci_epf_ctrl *ctrl = &nvme_epf->ctrl;
> +	struct nvmet_alloc_ctrl_args args = {};
> +	char hostnqn[NVMF_NQN_SIZE];
> +	uuid_t id;
> +	int ret;
> +
> +	memset(ctrl, 0, sizeof(*ctrl));
> +	ctrl->dev = &nvme_epf->epf->dev;
> +	mutex_init(&ctrl->irq_lock);
> +	ctrl->nvme_epf = nvme_epf;
> +	ctrl->mdts = nvme_epf->mdts_kb * SZ_1K;
> +	INIT_DELAYED_WORK(&ctrl->poll_cc, nvmet_pci_epf_poll_cc_work);
> +	INIT_DELAYED_WORK(&ctrl->poll_sqs, nvmet_pci_epf_poll_sqs_work);
> +
> +	ret = mempool_init_kmalloc_pool(&ctrl->iod_pool,
> +					max_nr_queues * NVMET_MAX_QUEUE_SIZE,
> +					sizeof(struct nvmet_pci_epf_iod));
> +	if (ret) {
> +		dev_err(ctrl->dev, "Failed to initialize iod mempool\n");
> +		return ret;
> +	}

To keep the case consistent:

  dev_err(ctrl->dev, "Failed to initialize IOD mempool\n");

> +static int nvmet_pci_epf_bind(struct pci_epf *epf)
> +{
> +	struct nvmet_pci_epf *nvme_epf = epf_get_drvdata(epf);
> +	const struct pci_epc_features *epc_features;
> +	struct pci_epc *epc = epf->epc;
> +	int ret;
> +
> +	if (!epc) {
> +		dev_err(&epf->dev, "No endpoint controller\n");
> +		return -EINVAL;
> +	}

What about:

  No endpoint controller found

Or:

  No endpoint controller detected

> +#define to_nvme_epf(epf_group)	\
> +	container_of(epf_group, struct nvmet_pci_epf, group)

This is added immediately before where its used, but I wonder whether we
could move it to the top immediately after the struct nvmet_pci_epf
declaration.

> +MODULE_DESCRIPTION("NVMe PCI Endpoint Function target driver");
> +MODULE_AUTHOR("Damien Le Moal <dlemoal@kernel.org>");
> +MODULE_LICENSE("GPL");

A few other things:

  - Settle on the "IO" vs "I/O", and "BAR0" vs "BAR 0" (even thought the
    latter is better for readibility), within messages and code comments.

  - The "INTX" as "INTx", etc.  Also, PCIe over PCI where PCI Express was
    really meant, or where it makes sense.

  - Choose one of the following styles:

    1. dev_err(dev, "DMA submit failed %d\n", ret)
    2. dev_err(dev, "DMA submit failed: %d\n", ret)
    3. dev_err(dev, "DMA submit failed (err=%d)\n", ret);
    4. dev_err(dev, "DMA submit failed (ret=%d)\n", ret);

    Then use consistently throughout the code base.  Current a few
    different styles are used.

  - Add missing full-stop to sentences in code comments, especially any
    longer ones.

  - Would be nice to include references to the NVMe specification every
    time the standard is cited or quoted.
    
Again, thank you for an amazing driver and an interesting new feature!
        
	Krzysztof

