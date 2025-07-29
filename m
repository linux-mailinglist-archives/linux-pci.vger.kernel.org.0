Return-Path: <linux-pci+bounces-33124-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC76B15063
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jul 2025 17:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1E293ADF0C
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jul 2025 15:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE222951BA;
	Tue, 29 Jul 2025 15:45:13 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D29295537;
	Tue, 29 Jul 2025 15:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753803913; cv=none; b=rjnVLzFueUNwPxK8V5uShp80yS7HfmDl/vLx0WSQ7utd01W7+01qvnD1HT8BKf5H71Zuz4XhNqLKkdMpVpg8UvZwlIittaQw6Wa4oFrvVErlPJZcxoEBoGWlv0Uk1HcbLR4M8NOrb9O7yKi2u/aMDBiSUVlI01wRLseuUJvwsqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753803913; c=relaxed/simple;
	bh=mUET2hrlkYFUUNugZUgBdMHpUYwzeILIBgsoNlq+e3A=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QTwnb7VVygdccpZMoLwtMqZPFMENjSIxX939okBv+v8EtH2H+tj0foQcGbg0TdEMluuHi/fH+2cK9aQ8hi56BwpLAdbaMH+Hyl3bSbRlmiy5etD8Tw8E/z1PvR6IXjF5/b1FHI5YWStA7BqwNdh4qs57wLK/qGY1BSUxk9PYAXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bs0416yxfz6K5Xn;
	Tue, 29 Jul 2025 23:43:13 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id E271B1402FB;
	Tue, 29 Jul 2025 23:45:06 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 29 Jul
 2025 17:45:06 +0200
Date: Tue, 29 Jul 2025 16:45:04 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bhelgaas@google.com>, <aik@amd.com>,
	<lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>, Yilun Xu
	<yilun.xu@linux.intel.com>
Subject: Re: [PATCH v4 07/10] PCI/IDE: Add IDE establishment helpers
Message-ID: <20250729164504.00000ec2@huawei.com>
In-Reply-To: <20250717183358.1332417-8-dan.j.williams@intel.com>
References: <20250717183358.1332417-1-dan.j.williams@intel.com>
	<20250717183358.1332417-8-dan.j.williams@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 17 Jul 2025 11:33:55 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> There are two components to establishing an encrypted link, provisioning
> the stream in Partner Port config-space, and programming the keys into
> the link layer via IDE_KM (IDE Key Management). This new library,
> drivers/pci/ide.c, enables the former. IDE_KM, via a TSM low-level
> driver, is saved for later.
> 
> With the platform TSM implementations of SEV-TIO and TDX Connect in mind
> this library abstracts small differences in those implementations. For
> example, TDX Connect handles Root Port register setup while SEV-TIO
> expects System Software to update the Root Port registers. This is the
> rationale for fine-grained 'setup' + 'enable' verbs.
> 
> The other design detail for TSM-coordinated IDE establishment is that
> the TSM may manage allocation of Stream IDs, this is why the Stream ID
> value is passed in to pci_ide_stream_setup().
> 
> The flow is:
> 
> pci_ide_stream_alloc()
>   Allocate a Selective IDE Stream Register Block in each Partner Port
>   (Endpoint + Root Port), and reserve a host bridge / platform stream
>   slot. Gather Partner Port specific stream settings like Requester ID.
> pci_ide_stream_register()
>   Publish the stream in sysfs after allocating a Stream ID. In the TSM
>   case the TSM allocates the Stream ID for the Partner Port pair.
> pci_ide_stream_setup()
>   Program the stream settings to a Partner Port. Caller is responsible
>   for optionally calling this for the Root Port as well if the TSM
>   implementation requires it.
> pci_ide_stream_enable()
>   Try to run the stream after IDE_KM.
> 
> In support of system administrators auditing where platform, Root Port,
> and Endpoint IDE stream resources are being spent, the allocated stream
> is reflected as a symlink from the host bridge to the endpoint with the
> name:
> 
>     stream%d.%d.%d
> 
> Where the tuple of integers reflects the allocated platform, Root Port,
> and Endpoint stream index (Selective IDE Stream Register Block) values.
> 
> Thanks to Wu Hao for a draft implementation of this infrastructure.
> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: Samuel Ortiz <sameo@rivosinc.com>
> Co-developed-by: Alexey Kardashevskiy <aik@amd.com>
> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
> Co-developed-by: Yilun Xu <yilun.xu@linux.intel.com>
> Signed-off-by: Yilun Xu <yilun.xu@linux.intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

A few minor things inline.

> diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
> index e15937cdb2a4..cdc773a8b381 100644
> --- a/drivers/pci/ide.c
> +++ b/drivers/pci/ide.c
> @@ -5,6 +5,8 @@
>  


> +/**
> + * pci_ide_stream_enable() - try to enable a Selective IDE Stream
> + * @pdev: PCIe device object for either a Root Port or Endpoint Partner Port
> + * @ide: registered and setup IDE settings descriptor
> + *
> + * Activate the stream by writing to the Selective IDE Stream Control
> + * Register, report whether the state successfully transitioned to
> + * secure mode.
and report

> ... Note that the state may go "insecure" at any point after
> + * this check, but that is handled via asynchronous error reporting.
> + */
> +int pci_ide_stream_enable(struct pci_dev *pdev, struct pci_ide *ide)
> +{
> +	struct pci_ide_partner *settings = pci_ide_to_settings(pdev, ide);
> +	int pos;
> +	u32 val;
> +
> +	if (!settings)
> +		return -ENXIO;
> +
> +	pos = sel_ide_offset(pdev, settings);
> +
> +	set_ide_sel_ctl(pdev, ide, pos, true);
> +
> +	pci_read_config_dword(pdev, pos + PCI_IDE_SEL_STS, &val);
> +	if (FIELD_GET(PCI_IDE_SEL_STS_STATE_MASK, val) !=
> +	    PCI_IDE_SEL_STS_STATE_SECURE) {
> +		set_ide_sel_ctl(pdev, ide, pos, false);
> +		return -ENXIO;
> +	}
> +
> +	settings->enable = 1;
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pci_ide_stream_enable);

> diff --git a/include/linux/pci-ide.h b/include/linux/pci-ide.h
> new file mode 100644
> index 000000000000..89c1ef0de841
> --- /dev/null
> +++ b/include/linux/pci-ide.h
> @@ -0,0 +1,70 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright(c) 2024 Intel Corporation. All rights reserved. */
...

> +/**
> + * struct pci_ide_partner - Per port pair Selective IDE Stream settings
> + * @rid_start: Partner Port Requester ID range start
> + * @rid_start: Partner Port Requester ID range end
> + * @stream_index: Selective IDE Stream Register Block selection
> + * @setup: flag to track whether to run pci_ide_stream_teardown for this parnter slot

partner.

> + * @enable: flag whether to run pci_ide_stream_disable for this parnter slot

same again.

> + */
> +struct pci_ide_partner {
> +	u16 rid_start;
> +	u16 rid_end;
> +	u8 stream_index;
> +	unsigned int setup:1;
> +	unsigned int enable:1;
> +};
> +
> +/**
> + * struct pci_ide - PCIe Selective IDE Stream descriptor
> + * @pdev: PCIe Endpoint in the pci_ide_partner pair
> + * @partner: Per-partner settings
per-partner maybe?  Capitalization seems a little random
as mostly you have used them for spec terms, but Per-partner probably
isn't one?

> + * @host_bridge_stream: track platform Stream ID
> + * @stream_id: unique Stream ID (within Partner Port pairing)
> + * @name: name of the established Selective IDE Stream in sysfs
> + *
> + * Negative @stream_id values indicate "uninitialized" on the
> + * expectation that with TSM established IDE the TSM owns the stream_id
> + * allocation.
> + */
> +struct pci_ide {
> +	struct pci_dev *pdev;
> +	struct pci_ide_partner partner[PCI_IDE_PARTNER_MAX];
> +	u8 host_bridge_stream;
> +	int stream_id;
> +	const char *name;
> +};

> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index a7353df51fea..cc83ae274601 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -538,6 +538,8 @@ struct pci_dev {
>  	u16		ide_cap;	/* Link Integrity & Data Encryption */
>  	u8		nr_ide_mem;	/* Address association resources for streams */
>  	u8		nr_link_ide;	/* Link Stream count (Selective Stream offset) */
> +	u8		nr_sel_ide;	/* Selective Stream count (register block allocator) */
> +	DECLARE_BITMAP(ide_stream_map, CONFIG_PCI_IDE_STREAM_MAX);
>  	unsigned int	ide_cfg:1;	/* Config cycles over IDE */
>  	unsigned int	ide_tee_limit:1; /* Disallow T=0 traffic over IDE */
>  #endif
> @@ -607,6 +609,10 @@ struct pci_host_bridge {
>  	int		domain_nr;
>  	struct list_head windows;	/* resource_entry */
>  	struct list_head dma_ranges;	/* dma ranges resource list */
> +#ifdef CONFIG_PCI_IDE
> +	u8 nr_ide_streams;		/* Track available vs in-use streams */

Which does it do?  Confusing comment.

> +	DECLARE_BITMAP(ide_stream_map, CONFIG_PCI_IDE_STREAM_MAX);
> +#endif

