Return-Path: <linux-pci+bounces-27903-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C00ABA65E
	for <lists+linux-pci@lfdr.de>; Sat, 17 May 2025 01:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4F8AA24CB0
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 23:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0C422C35D;
	Fri, 16 May 2025 23:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iBoIwwvZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4A41DE2CD;
	Fri, 16 May 2025 23:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747437290; cv=none; b=lu5MpTQuAmZnR//KQ5bg8Vp19BcQX1H9QZt/JRHiwywCPvgVuP7l31Uh1LSxAP5J6g3S+9ZNqlIZpRBQwqlRZP+CvIxDOUpFHv56C34r7TDSSygf8ytsMaQ0DkYmwt+820Qke6JJeVcJJILlXDHOCFxADaeAN7rd+dua6cTAcQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747437290; c=relaxed/simple;
	bh=PHSF/GQelpbTFixsSKKvinSFQZDIOLsx35wwaHp6R4s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oERwYV/XPIJMOWGvnEZTIiAED5xDlZdH5DKQGufOpoY4zh+X4leAnbzLXWWFON2nB3Zp7KfPsRX8nWRqKKrrvTICTFvSbV4DwYVoS//5+N5SsrUS6tonEfJfuYZHNnFq64QcOHYwzRvd/+hJ21cFXdpNwEj4XbLessViJKqTLLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iBoIwwvZ; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747437289; x=1778973289;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PHSF/GQelpbTFixsSKKvinSFQZDIOLsx35wwaHp6R4s=;
  b=iBoIwwvZyizXRRRxGVCWZT2b7nd611BqC2f4wj8UVEKwAnQjAVQ/rN+7
   wzFnAnnGfa1/uFxXsMW4V8q/6WKNIiJTizQ25J/oPyxxBmIx+uAf4QcEF
   s3h/qsy17FzQ1Wq3xAMLuhuCxUhcf9ERFtKNzyrWhMombIE9sfXU523GC
   FX/2FTN9VAiTpGiShQNkYHnkmtEfFEC5KLWFt1thgHXnt2vXFthKTUNVf
   eNVjkw8+qkjeuDNn7qwoNNdlopIXgduuBjWS+Xj9KEMDyQhKZ79Idljjx
   At2tQ2oShi4W6nMiPgVsdunLHn8fqta42ivwhDu5oc4arVZxO3Z4M/D+0
   g==;
X-CSE-ConnectionGUID: JF5eZDpmQYm8pCptX7AuyA==
X-CSE-MsgGUID: hiZxludkQ+qDCw2iMIC/ng==
X-IronPort-AV: E=McAfee;i="6700,10204,11435"; a="49489639"
X-IronPort-AV: E=Sophos;i="6.15,295,1739865600"; 
   d="scan'208";a="49489639"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 16:14:48 -0700
X-CSE-ConnectionGUID: js51SXZoQrO+DUpr7Ypkqw==
X-CSE-MsgGUID: j2yxrjfiQcuEn8ANbRWW8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,295,1739865600"; 
   d="scan'208";a="143698813"
Received: from tfalcon-desk.amr.corp.intel.com (HELO [10.124.220.15]) ([10.124.220.15])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 16:14:48 -0700
Message-ID: <d399dd38-b26f-413f-ab02-49680ff87ed1@linux.intel.com>
Date: Fri, 16 May 2025 16:14:47 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] PCI: Remove hybrid-devres region requests
To: Philipp Stanner <phasta@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Bjorn Helgaas <bhelgaas@google.com>, Mark Brown <broonie@kernel.org>,
 David Lechner <dlechner@baylibre.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Zijun Hu <quic_zijuhu@quicinc.com>, Yang Yingliang
 <yangyingliang@huawei.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20250516174141.42527-1-phasta@kernel.org>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20250516174141.42527-1-phasta@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 5/16/25 10:41 AM, Philipp Stanner wrote:
> Changes in v2:
>    - Drop patch for removing forgotten header. Patch is unrelated. Will
>      resend seperately. (Andy)
>    - Make docu patch headline "Documentation/driver-api:". There seems to
>      be no canonical way, but this style is quite frequent. (Andy)
>    - Apply Andy's RBs where applicable.
>
> Howdy,
>
> the great day has finally arrived, I managed to get rid of one of the
> big three remaining problems in the PCI devres API (the other two being
> MSI having hybrid-devres, too, and the good old pcim_iomap_tablle)!
>
> It turned out that there aren't even that many users of the hybrid API,
> where pcim_enable_device() switches certain functions in pci.c into
> managed devres mode, which we want to remove.
>
> The affected drivers can be found with:
>
> grep -rlZ "pcim_enable_device" | xargs -0 grep -l "pci_request"
>
> These were:
>
> 	ASoC [1]
> 	alsa [2]
> 	cardreader [3]
> 	cirrus [4]
> 	i2c [5]
> 	mmc [6]
> 	mtd [7]
> 	mxser [8]
> 	net [9]
> 	spi [10]
> 	vdpa [11]
> 	vmwgfx [12]
>
> All of those have been merged and are queued up for the merge window.
> The only possible exception is vdpa, but it seems to be ramped up right
> now; vdpa, however, doesn't even use the hybrid behavior, so that patch
> is just for generic cleanup anyways.
>
> With the users of the hybrid feature gone, the feature itself can
> finally be burned.
>
> So I'm sending out this series now to probe whether it's judged to be
> good enough for the upcoming merge window. If we could take it, we would
> make it impossible that anyone adds new users of the hybrid thing.
>
> If it's too late for the merge window, then that's what it is, of
> course.
>
> In any case I'm glad we can get rid of most of that legacy stuff now.

Looks good to me.

Reviewed-by: Kuppuswamy Sathyanarayanan 
<sathyanarayanan.kuppuswamy@linux.intel.com>


>
> Regards,
> Philipp
>
> [1] https://lore.kernel.org/all/174657893832.4155013.12131767110464880040.b4-ty@kernel.org/
> [2] https://lore.kernel.org/all/8734dy3tvz.wl-tiwai@suse.de/
> [3] https://lore.kernel.org/all/20250417091532.26520-2-phasta@kernel.org/ (private confirmation mail from Greg KH)
> [4] https://lore.kernel.org/dri-devel/e7c45c099f8981257866396e01a91df1afcfbf97.camel@mailbox.org/
> [5] https://lore.kernel.org/all/l26azmnpceka2obq4gtwozziq6lbilb2owx57aajtp3t6jhd3w@llmeikgjvqyh/
> [6] https://lore.kernel.org/all/CAPDyKFqqV2VEqi17UHmFE0b9Y+h5q2YaNfHTux8U=7DgF+svEw@mail.gmail.com/
> [7] https://lore.kernel.org/all/174591865790.993381.15992314896975862083.b4-ty@bootlin.com/
> [8] https://lore.kernel.org/all/20250417081333.20917-2-phasta@kernel.org/ (private confirmation mail from Greg KH)
> [9] https://lore.kernel.org/all/174588423950.1081621.6688170836136857875.git-patchwork-notify@kernel.org/
> [10] https://lore.kernel.org/all/174492457740.248895.3318833401427095151.b4-ty@kernel.org/
> [11] https://lore.kernel.org/all/20250515072724-mutt-send-email-mst@kernel.org/
> [12] https://lore.kernel.org/dri-devel/CABQX2QNQbO4dMq-Hi6tvpi7OTwcVfjM62eCr1OGkzF8Phy-Shw@mail.gmail.com/
>
> Philipp Stanner (6):
>    PCI: Remove hybrid devres nature from request functions
>    Documentation/driver-api: Update pcim_enable_device()
>    PCI: Remove pcim_request_region_exclusive()
>    PCI: Remove request_flags relict from devres
>    PCI: Remove redundant set of request funcs
>    PCI: Remove hybrid-devres hazzard warnings from doc
>
>   .../driver-api/driver-model/devres.rst        |   2 +-
>   drivers/pci/devres.c                          | 201 +++---------------
>   drivers/pci/iomap.c                           |  16 --
>   drivers/pci/pci.c                             |  42 ----
>   drivers/pci/pci.h                             |   3 -
>   5 files changed, 32 insertions(+), 232 deletions(-)
>
-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


