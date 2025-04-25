Return-Path: <linux-pci+bounces-26774-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6499AA9CE35
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 18:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5835A16DADB
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 16:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B871A00ED;
	Fri, 25 Apr 2025 16:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dygSeYVb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5255119F115
	for <linux-pci@vger.kernel.org>; Fri, 25 Apr 2025 16:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745598841; cv=none; b=BaFYdZvhkoBeyHQQiQHPa0TyZzyh3i3BSIJYbUbmCsp6zdor8C+POlf05ixWGC4MZ5N2yREIalwZatxEGMN5P0+kvIkoJebrUJ1R/3XHA98W1/CctXvXKCk1UfesU/vhHWGl71EGCrwl/UsG7iEcgO5c1H7Q6D22cLQg0JjVAUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745598841; c=relaxed/simple;
	bh=u1V74D4vVu2FoZASwEnzWG7Nqf24mqXLJWj3A4SEvw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a29aa27On/2vgxOhpOyEnaUl6++6yl6FFsFjTVIFaUk9v2iUuQfJ+dw/OMMzAWgtRdOIm7eAQk3GPA4YIoFbdkngFQlN6yVSDmqLSoNqzDAnHA3jLNdpIIQ7oKMKBrd+T7GIyin0iA6GscqZH6zc9jF4FllFWZ6tKGCFbBbITMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dygSeYVb; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745598841; x=1777134841;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u1V74D4vVu2FoZASwEnzWG7Nqf24mqXLJWj3A4SEvw4=;
  b=dygSeYVbkPmCukY5WIRVBO+KNyNOVdiHLISchZGiY7dNTv/xuA7cMqrT
   GO5BBRgCTCkgF4mheyx6ye9ebIL+u/3wOUUDC/SqtEBlOFn6+x/lUZ7FJ
   JLCgVWjBtMybZPvobk5ivCzyHbH6ZWkC58GnYcDovCAAh0qrsVDVLzOsq
   bu7nnKBZp2EoG3GWGnCNYPlnG+JJd7twT527dUb1LHAKnTAXJ4S8N9ykT
   Dw6QjdLpw1O0IWhbqv894vmV4XXeKv7dVN2OfOBqTghS+lF/fLoeRQJy1
   N/xYqVErAqIVaMvco1lBrY0Ioam0nATz8kcelZhTynMew/YVExb+JJEF2
   A==;
X-CSE-ConnectionGUID: pByvUzCxT0aG/VWq3vxZ+Q==
X-CSE-MsgGUID: 4nQA2iyRQVOV0azqXH5XwA==
X-IronPort-AV: E=McAfee;i="6700,10204,11414"; a="47280790"
X-IronPort-AV: E=Sophos;i="6.15,238,1739865600"; 
   d="scan'208";a="47280790"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2025 09:34:00 -0700
X-CSE-ConnectionGUID: PGn7jOLuSSW2LxL5u14jeQ==
X-CSE-MsgGUID: RJnnuV3bTsOQcX+WI45Vrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,238,1739865600"; 
   d="scan'208";a="132820919"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa010.jf.intel.com with ESMTP; 25 Apr 2025 09:33:56 -0700
Date: Sat, 26 Apr 2025 00:29:17 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Alexey Kardashevskiy <aik@amd.com>, gregkh@linuxfoundation.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 08/11] PCI/IDE: Add IDE establishment helpers
Message-ID: <aAu4XanJRnSuFXr/@yilunxu-OptiPlex-7050>
References: <174107245357.1288555.10863541957822891561.stgit@dwillia2-xfh.jf.intel.com>
 <174107250147.1288555.16948528371146013276.stgit@dwillia2-xfh.jf.intel.com>
 <yq5a7c3edot5.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5a7c3edot5.fsf@kernel.org>

On Mon, Apr 21, 2025 at 11:43:58AM +0530, Aneesh Kumar K.V wrote:
> Dan Williams <dan.j.williams@intel.com> writes:
> 
> > There are two components to establishing an encrypted link, provisioning
> > the stream in Partner Port config-space, and programming the keys into
> > the link layer via IDE_KM (IDE Key Management). This new library,
> > drivers/pci/ide.c, enables the former. IDE_KM, via a TSM low-level
> > driver, is saved for later.
> >
> ....
> 
> > +/**
> > + * pci_ide_stream_setup() - program settings to Selective IDE Stream registers
> > + * @pdev: PCIe device object for either a Root Port or Endpoint Partner Port
> > + * @ide: registered IDE settings descriptor
> > + *
> > + * When @pdev is a PCI_EXP_TYPE_ENDPOINT then the PCI_IDE_EP partner
> > + * settings are written to @pdev's Selective IDE Stream register block,
> > + * and when @pdev is a PCI_EXP_TYPE_ROOT_PORT, the PCI_IDE_RP settings
> > + * are selected.
> > + */
> > +void pci_ide_stream_setup(struct pci_dev *pdev, struct pci_ide *ide)
> > +{
> > +	struct pci_ide_partner *settings = to_settings(pdev, ide);
> > +	int pos;
> > +	u32 val;
> > +
> > +	if (!settings)
> > +		return;
> > +
> > +	pos = sel_ide_offset(pdev->nr_link_ide, settings->stream_index,
> > +			     pdev->nr_ide_mem);
> >
> 
> This and the similar offset caclulation below needs the EXT_CAP_ID_IDE offset 
> 
> modified   drivers/pci/ide.c
> @@ -10,11 +10,13 @@
>  #include <linux/bitfield.h>
>  #include "pci.h"
>  
> -static int sel_ide_offset(int nr_link_ide, int stream_index, int nr_ide_mem)
> +static int sel_ide_offset(struct pci_dev *pdev, int nr_link_ide,
> +			  int stream_index, int nr_ide_mem)
>  {
>  	int offset;
>  
> -	offset = PCI_IDE_LINK_STREAM_0 + nr_link_ide * PCI_IDE_LINK_BLOCK_SIZE;
> +	offset = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_IDE);
> +	offset += PCI_IDE_LINK_STREAM_0 + nr_link_ide * PCI_IDE_LINK_BLOCK_SIZE;

ide_cap, nr_link_ide, nr_ide_mem are all cached in pci_dev structure at
the end of pci_ide_init().

So either use all cached value in pdev (not for pci_ide_init()):

  static int sel_ide_offset(struct pci_dev *pdev, int stream_index)

or don't use any cached value:

  static int sel_ide_offset(u16 dev_cap, int nr_link_ide, int stream_index, int nr_ide_mem)

or keep sel_ide_offset() unchanged, alway do:

  ide_cap + sel_ide_offset()

>  
>  	/*
>  	 * Assume a constant number of address association resources per
> @@ -66,7 +68,7 @@ void pci_ide_init(struct pci_dev *pdev)
>  	nr_streams = min(1 + FIELD_GET(PCI_IDE_CAP_SEL_NUM_MASK, val),
>  			 CONFIG_PCI_IDE_STREAM_MAX);
>  	for (int i = 0; i < nr_streams; i++) {
> -		int offset = sel_ide_offset(nr_link_ide, i, nr_ide_mem);
> +		int offset = sel_ide_offset(pdev, nr_link_ide, i, nr_ide_mem);
>  		int nr_assoc;
>  		u32 val;

With your change, the next line will be broken:

-		pci_read_config_dword(pdev, ide_cap + offset, &val);
+		pci_read_config_dword(pdev, offset, &val);

Thanks,
Yilun

