Return-Path: <linux-pci+bounces-40664-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B75C44DEF
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 04:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A531B4E1FFD
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 03:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0847828C5B1;
	Mon, 10 Nov 2025 03:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K7NbbK+8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144CA28A72F
	for <linux-pci@vger.kernel.org>; Mon, 10 Nov 2025 03:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762747125; cv=none; b=QS0OAteyYx51nsdFrKVZOzWKS7iTvFiGaq0ZP2Hgd7fyY/wSiFykFnCLZEe8t4e1a93JWohZ221qju3TZ3o38B13viZkL9NCiUSWl3iZC12zpBiYQOpx0x+3IbDBrsOIU8CFI9y0MzNPEQuyR0YUUVWdGZgpxMN394PHXmn71pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762747125; c=relaxed/simple;
	bh=IR4tchos/E8hgWZcbbM8s8lqpQ1h4sKfPoc9AVB+plI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NQLQmRldseV6zwgkuOQOTxx5rQhz7izUqBivBGb7g/ee5c2ReyLOBaVbF5mddT+b72616M2OmfNy49OuSNd129g0KAnjshT2CIMEFIqbXVYMn9GtIzu8NCmXX1tN2hf28IVQYZvFXMchgTFI0iz955SXLwjwjHx1AL0MtmxSKYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K7NbbK+8; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762747124; x=1794283124;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IR4tchos/E8hgWZcbbM8s8lqpQ1h4sKfPoc9AVB+plI=;
  b=K7NbbK+83kvCvDgc+j3n9dxhldmSYLhcvOnjqLXQthn9DZ0PCgP+FyBP
   mfGcVZgO94P2yyrKBw9Jj7O+WPXQ/fzQSKH2gwi0LxBjIkMQY/cQHJcj/
   11Uw8W28Kqd6VI0VBB9GOqz2wZL8EMLGRwZxDMTU/Wuu8uooZH22ezZtm
   wnGx7DNq8m0AoFEyx9Bd16jTHzsEWzP+5+UidIkk0aZ2EBjqRiIvQWU4J
   x/GbtG4FBBCkNLZ81Wa6/aSEJJdAaXgYMHdvgeiVflHF0P1wDKRhjwZQj
   lPBG9WTnZ04b3eenNFqm4NPYH8PdLbsX/YAA6JR/xaZvXgbwvYzJ+eKwn
   w==;
X-CSE-ConnectionGUID: jaUMMdU6TaWbFzSgtN2+TQ==
X-CSE-MsgGUID: UcPQz58IStOVYZin/rtmUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11608"; a="75406017"
X-IronPort-AV: E=Sophos;i="6.19,292,1754982000"; 
   d="scan'208";a="75406017"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2025 19:58:43 -0800
X-CSE-ConnectionGUID: lItjY3QqSGGOFJMfltOF7w==
X-CSE-MsgGUID: Xx1VV85/Q2OleUdn3aWbWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,292,1754982000"; 
   d="scan'208";a="219299468"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa001.fm.intel.com with ESMTP; 09 Nov 2025 19:58:41 -0800
Date: Mon, 10 Nov 2025 11:44:19 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-pci@vger.kernel.org, linux-coco@lists.linux.dev,
	gregkh@linuxfoundation.org, aik@amd.com, aneesh.kumar@kernel.org,
	Lukas Wunner <lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: Re: [PATCH v8 4/9] PCI/TSM: Establish Secure Sessions and Link
 Encryption
Message-ID: <aRFfk14DJWEVhC/R@yilunxu-OptiPlex-7050>
References: <20251031212902.2256310-1-dan.j.williams@intel.com>
 <20251031212902.2256310-5-dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031212902.2256310-5-dan.j.williams@intel.com>

> +#ifdef CONFIG_PCI_TSM
> +int pci_tsm_register(struct tsm_dev *tsm_dev);
> +void pci_tsm_unregister(struct tsm_dev *tsm_dev);
> +int pci_tsm_link_constructor(struct pci_dev *pdev, struct pci_tsm *tsm,
> +			     struct tsm_dev *tsm_dev);
> +int pci_tsm_pf0_constructor(struct pci_dev *pdev, struct pci_tsm_pf0 *tsm,
> +			    struct tsm_dev *tsm_dev);
> +void pci_tsm_pf0_destructor(struct pci_tsm_pf0 *tsm);
> +int pci_tsm_doe_transfer(struct pci_dev *pdev, u8 type, const void *req,
> +			 size_t req_sz, void *resp, size_t resp_sz);
> +#else
> +static inline int pci_tsm_register(struct tsm_dev *tsm_dev)
> +{
> +	return 0;
> +}
> +static inline void pci_tsm_unregister(struct tsm_dev *tsm_dev)
> +{
> +}
> +static inline int pci_tsm_doe_transfer(struct pci_dev *pdev, u8 type,
> +				       const void *req, size_t req_sz,
> +				       void *resp, size_t resp_sz)

Any concern to keep the stub without PCI_TSM?
pci_tsm_pf0_constructor/destructor() don't do this.

> +{
> +	return -ENXIO;
> +}
> +#endif

[...]

> diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
> new file mode 100644
> index 000000000000..6a2849f77adc
> --- /dev/null
> +++ b/drivers/pci/tsm.c
> @@ -0,0 +1,643 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Interface with platform TEE Security Manager (TSM) objects as defined by
> + * PCIe r7.0 section 11 TEE Device Interface Security Protocol (TDISP)
> + *
> + * Copyright(c) 2024-2025 Intel Corporation. All rights reserved.
> + */
> +
> +#define dev_fmt(fmt) "PCI/TSM: " fmt
> +
> +#include <linux/bitfield.h>

No need the bitfield.h

> +#include <linux/pci.h>
> +#include <linux/pci-doe.h>
> +#include <linux/pci-tsm.h>
> +#include <linux/sysfs.h>
> +#include <linux/tsm.h>
> +#include <linux/xarray.h>

No need the xarray.h

Anyway, they are all minor and cause no impact, I don't expect a new
version.

Reviewed-by: Xu Yilun <yilun.xu@linux.intel.com>


