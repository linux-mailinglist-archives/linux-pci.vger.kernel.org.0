Return-Path: <linux-pci+bounces-14242-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD7799953E
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 00:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CFBE286358
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 22:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408811BBBC4;
	Thu, 10 Oct 2024 22:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PEAUnbow"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1667A1A2645;
	Thu, 10 Oct 2024 22:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728599499; cv=none; b=q3yGm8hShZYTG9V1h3GvsTLNlRmOCFqpFJPi29rveSKEFHFbHwYTCWUqo5I6OnmwQ5TdVBU88a9q/er4BbxcFBo/66jrue2KgWpqOoP6i+HxcJFQo9gqzfefCnRmLK9OF235Wvzp2wIcMHmHPzVWxisxWO0H+TRDzoNOpLt+Efs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728599499; c=relaxed/simple;
	bh=bFO4DmRffhott1966dfnOLbsiTu6pSb4c8w8UhTpjXc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=pLbjcSIORo6c6eb5DPsYIZDafUj/QZM27WmqGFswMHeJ68qBtiCH0c+M35R9PM5EW/VAnOqrV3W7q0PCJ8qwi5JrEkRu5RhF+Uk0NZUmDTf6qXOxdpZpCuTlaposUDOzMzXnLPWU3rKecE4WbZtfOGumitQt97BHh4TSOCgPrPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PEAUnbow; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61B36C4CEC5;
	Thu, 10 Oct 2024 22:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728599498;
	bh=bFO4DmRffhott1966dfnOLbsiTu6pSb4c8w8UhTpjXc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=PEAUnbowtl1iVcHAPwHU1Q38imbBuUiqwNoWd50OCPaB4jsUM6LQw1WuKjTB48RIO
	 7HiIdcjJuaQ0A3ce0FKdRqF8XcG8HWIjsKAnRGscfKJncDpv8gzhIXhyuw5TwwLK74
	 UUpYyXUW2Vqu2y4cRLnW8epl5/c17nkM4+RwsPIFihOHpxTJpb6YMfKIvtjcS0e11+
	 oVIx5/bpC3sgBKAN7uuBfLbnbaI9squHZBhiXegc3O68/t/RxqPZ8+wKLT8tg6LoYE
	 zfpglkVb5ySM6KYWzptrrBu7GQiDsm2LJN15GGhmZ51pk3R3RLjskbXEZz2kdp30fW
	 eCViZKQgBpUXQ==
Date: Thu, 10 Oct 2024 17:31:36 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: =?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>
Cc: linux-pci@vger.kernel.org, intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Michal Wajdeczko <michal.wajdeczko@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Matt Roper <matthew.d.roper@intel.com>
Subject: Re: [PATCH v3 1/5] PCI/IOV: Restore VF resizable BAR state after
 reset
Message-ID: <20241010223136.GA581380@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241010103203.382898-2-michal.winiarski@intel.com>

On Thu, Oct 10, 2024 at 12:31:59PM +0200, Michał Winiarski wrote:
> Similar to regular resizable BAR, VF BAR can also be resized, e.g. by
> the system firmware, or the PCI subsystem itself.
> Add the capability ID and restore it as a part of IOV state.
> See PCIe r4.0, sec 9.3.7.4.

Add blank line between paragraphs.

> Signed-off-by: Michał Winiarski <michal.winiarski@intel.com>
> ---
>  drivers/pci/iov.c             | 29 ++++++++++++++++++++++++++++-
>  include/uapi/linux/pci_regs.h |  1 +
>  2 files changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index aaa33e8dc4c97..fd5c059b29c13 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -7,6 +7,7 @@
>   * Copyright (C) 2009 Intel Corporation, Yu Zhao <yu.zhao@intel.com>
>   */
>  
> +#include <linux/bitfield.h>
>  #include <linux/pci.h>
>  #include <linux/slab.h>
>  #include <linux/export.h>
> @@ -862,6 +863,30 @@ static void sriov_release(struct pci_dev *dev)
>  	dev->sriov = NULL;
>  }
>  
> +static void sriov_restore_vf_rebar_state(struct pci_dev *dev)
> +{
> +	unsigned int pos, nbars, i;
> +	u32 ctrl;
> +
> +	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_VF_REBAR);
> +	if (!pos)
> +		return;
> +
> +	pci_read_config_dword(dev, pos + PCI_REBAR_CTRL, &ctrl);
> +	nbars = FIELD_GET(PCI_REBAR_CTRL_NBAR_MASK, ctrl);
> +
> +	for (i = 0; i < nbars; i++, pos += 8) {
> +		int bar_idx, size;
> +
> +		pci_read_config_dword(dev, pos + PCI_REBAR_CTRL, &ctrl);
> +		bar_idx = ctrl & PCI_REBAR_CTRL_BAR_IDX;
> +		size = pci_rebar_bytes_to_size(dev->sriov->barsz[bar_idx]);
> +		ctrl &= ~PCI_REBAR_CTRL_BAR_SIZE;
> +		ctrl |= FIELD_PREP(PCI_REBAR_CTRL_BAR_SIZE, size);
> +		pci_write_config_dword(dev, pos + PCI_REBAR_CTRL, ctrl);
> +	}
> +}
> +
>  static void sriov_restore_state(struct pci_dev *dev)
>  {
>  	int i;
> @@ -1021,8 +1046,10 @@ resource_size_t pci_sriov_resource_alignment(struct pci_dev *dev, int resno)
>   */
>  void pci_restore_iov_state(struct pci_dev *dev)
>  {
> -	if (dev->is_physfn)
> +	if (dev->is_physfn) {
> +		sriov_restore_vf_rebar_state(dev);
>  		sriov_restore_state(dev);
> +	}
>  }
>  
>  /**
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 12323b3334a9c..a0cf701c4c3af 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -740,6 +740,7 @@
>  #define PCI_EXT_CAP_ID_L1SS	0x1E	/* L1 PM Substates */
>  #define PCI_EXT_CAP_ID_PTM	0x1F	/* Precision Time Measurement */
>  #define PCI_EXT_CAP_ID_DVSEC	0x23	/* Designated Vendor-Specific */
> +#define PCI_EXT_CAP_ID_VF_REBAR 0x24	/* VF Resizable BAR */
>  #define PCI_EXT_CAP_ID_DLF	0x25	/* Data Link Feature */
>  #define PCI_EXT_CAP_ID_PL_16GT	0x26	/* Physical Layer 16.0 GT/s */
>  #define PCI_EXT_CAP_ID_NPEM	0x29	/* Native PCIe Enclosure Management */
> -- 
> 2.47.0
> 

