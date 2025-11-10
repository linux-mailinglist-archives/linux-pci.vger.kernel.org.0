Return-Path: <linux-pci+bounces-40669-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA469C44F1D
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 06:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BC133B0C64
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 05:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228B12E6CA6;
	Mon, 10 Nov 2025 05:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DnZZ+JpP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6840134D395
	for <linux-pci@vger.kernel.org>; Mon, 10 Nov 2025 05:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762751029; cv=none; b=kXe7zZEg+VQvaxy2zjaIID6xOthfzbrivhHTPPj5PdDRl4TlLdtZaAqLeezKVlt0SyDA9EUonaDP+UQ20MXUP2fpCDnavuBwwpZi9e1rKWNKN78EaltU64tvGxBsEiz5YEc/AqiXwGMUUaKBMptL9bCk68goqd4P2Li9XbYo5DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762751029; c=relaxed/simple;
	bh=1hGjb/Di2zX64C6GwMgF3nsBBBIdZwQBDq8ZftFONJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ae7/ARaBBHpzM7WyPngEsnQ4IxrwWzi1HV0uQ0pEM3DSvNyKmV4GEe8vtNvJjvQRt+xnknxKHViXfdy2u9hocrHTC9U1J+iUP3+/0NkhTwA1a8wCTzvXDZ2fNRu079+13/wa83PF0z7J3csrt8wcTtpRYnKOq9L9IySo8zGJ2YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DnZZ+JpP; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762751027; x=1794287027;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1hGjb/Di2zX64C6GwMgF3nsBBBIdZwQBDq8ZftFONJs=;
  b=DnZZ+JpPUs50zL+/PeCCrZySkfaekQyGUok7jLrMgemSA3ScQXyB0nDQ
   OZ51Wv9n3XBKY/LkZNIa7PVZWePvOELbZaL9tQgoq6f+aHgcUIX3LL61G
   nr6480s420vLbZWretyHVICMOaFeYWOspMZ/xBRedLrxoV6quNoiYDkMy
   kv0u+kcqVqPLo0bzzVQ7OXJ5r2VQxbr3XmBTpDZNDZuOruec+RjNTLPcQ
   r2IfOJa97Vyy6wpKiOXx36M9rA1JBDJt7hrMeQflAnxMKjB7P2EIqJGjS
   jDhSYH0YwyOk61Wu7bUqUgRIxyqOQYdkJzJEK5Okp+lg3oTUjZC2nyNtI
   w==;
X-CSE-ConnectionGUID: VDI3eTKSQAamgJiH5vqoZw==
X-CSE-MsgGUID: ldgpVSrSSX+VjxnLjVJ//g==
X-IronPort-AV: E=McAfee;i="6800,10657,11608"; a="64708888"
X-IronPort-AV: E=Sophos;i="6.19,292,1754982000"; 
   d="scan'208";a="64708888"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2025 21:03:46 -0800
X-CSE-ConnectionGUID: NJOIT8ewSICf+9TOOWn/6g==
X-CSE-MsgGUID: 12Ql8C77TiO6t3UK8FNdJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,292,1754982000"; 
   d="scan'208";a="193758234"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa005.jf.intel.com with ESMTP; 09 Nov 2025 21:03:44 -0800
Date: Mon, 10 Nov 2025 12:49:22 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-pci@vger.kernel.org, linux-coco@lists.linux.dev,
	gregkh@linuxfoundation.org, aik@amd.com, aneesh.kumar@kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: Re: [PATCH v8 8/9] PCI/IDE: Report available IDE streams
Message-ID: <aRFu0q6/tdrfU8Qo@yilunxu-OptiPlex-7050>
References: <20251031212902.2256310-1-dan.j.williams@intel.com>
 <20251031212902.2256310-9-dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031212902.2256310-9-dan.j.williams@intel.com>

On Fri, Oct 31, 2025 at 02:29:00PM -0700, Dan Williams wrote:
> The limited number of link-encryption (IDE) streams that a given set of
> host bridges supports is a platform specific detail. Provide
> pci_ide_init_nr_streams() as a generic facility for either platform TSM

Should be updated to pci_ide_set_nr_streams().

> drivers, or PCI core native IDE, to report the number available streams.
> After invoking pci_ide_init_nr_streams() an "available_secure_streams"

I suppose should also be pci_ide_set_nr_streams() here.

> attribute appears in PCI host bridge sysfs to convey that count.

I don't see how it appears later. 

> +static umode_t pci_ide_attr_visible(struct kobject *kobj, struct attribute *a, int n)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct pci_host_bridge *hb = to_pci_host_bridge(dev);
> +
> +	if (a == &dev_attr_available_secure_streams.attr)
> +		if (!hb->nr_ide_streams)
> +			return 0;

The previous patch unconditionally initializes nr_ide_streams to 256, so
this check is not functional for "appear later". Maybe remove it.

> +
> +	return a->mode;
> +}
> +
> +const struct attribute_group pci_ide_attr_group = {
> +	.attrs = pci_ide_attrs,
> +	.is_visible = pci_ide_attr_visible,
> +};
> +
> +/**
> + * pci_ide_set_nr_streams() - sets size of the pool of IDE Stream resources
> + * @hb: host bridge boundary for the stream pool
> + * @nr: number of streams
> + *
> + * Platform PCI init and/or expert test module use only. Limit IDE
> + * Stream establishment by setting the number of stream resources
> + * available at the host bridge. Platform init code must set this before
> + * the first pci_ide_stream_alloc() call if the platform has less than the
> + * default of 256 streams per host-bridge.
> + *
> + * The "PCI_IDE" symbol namespace is required because this is typically
> + * a detail that is settled in early PCI init. I.e. this export is not
> + * for endpoint drivers.
> + */
> +void pci_ide_set_nr_streams(struct pci_host_bridge *hb, u16 nr)
> +{
> +	hb->nr_ide_streams = min(nr, 256);
> +	WARN_ON_ONCE(!ida_is_empty(&hb->ide_stream_ida));
> +	sysfs_update_group(&hb->dev.kobj, &pci_ide_attr_group);

Also no need to update group, is it?


Should be easy to address these concerns. I believe I can also:

Reviewed-by: Xu Yilun <yilun.xu@linux.intel.com>

> +}

