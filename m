Return-Path: <linux-pci+bounces-29332-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C91AD3B15
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 16:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1445317ABB7
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 14:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1CC29ACE5;
	Tue, 10 Jun 2025 14:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lHpoivDl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD9323ABAB;
	Tue, 10 Jun 2025 14:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749565610; cv=none; b=I6DjbVZmB3dwt6jh3Z2Wm1GhVOZgP7bl1pV+Elyj04Wt2NHEgMRM0WK9b5D6TMy+W8gp7rFUVNB3f6+Pojh5KJakvv6aIKM7irXu+1fIzA42uJeNKtY7naQ2WivEM/EANuT4jCInVgdGsZ85GHEhr7W0mmigQv4kH84mBHAEhVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749565610; c=relaxed/simple;
	bh=vz1nAUweOsDg+/9C202unoGCbmjQh4vHOai/zYujLsc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ONX9K2ZKUzZGO2CGIZB5sRJrZnuHJi8ewtj468j8UQb1xtLirdarmCO/0LUDavC0nIKb83lFOtk+d32mD/FP6D+nyFvWlN5RM5VOyHeR4Ve40jYjqfKZiFfrH0t05gpQ4z6xfGSUfyg2FwCf+bJvCrQdc6RRw4Vlctt5Utxm9YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lHpoivDl; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749565609; x=1781101609;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=vz1nAUweOsDg+/9C202unoGCbmjQh4vHOai/zYujLsc=;
  b=lHpoivDlYFLOFDGipohnetziNcbbPshSRxnzy8RH4dFp6XuSdt3GmHpX
   p4KWANNfPpFUB2xumcumMO8uWplfYeHLRbrrkolUuNiKRy6w19a5Q8BeX
   7PwKo+WwIapUZk6WRnQr/Nkb826eCNaWg9DiJ0NFXc/0zrllRBjUKa71Q
   TC2ohTDXJbaqM6FRYJlbi6yIFYvTwT4pNto7ASmeZljkSLPNOsFF9x8v4
   OqxXMuizpEL6qYeHCRtCJs5PzbitIKRSD1DYKt2QfFzxXsBXu2C+9YhsQ
   X8ILlhxJaId9xolHABpFSvX7wBIR2sl2pu5RDcD8co9Ck/1PbOMqBWgJl
   Q==;
X-CSE-ConnectionGUID: uyEt1HE2QruZRwM13BgUkA==
X-CSE-MsgGUID: eEayWQtxRDywWomVFNFDnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="51819952"
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; 
   d="scan'208";a="51819952"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 07:26:49 -0700
X-CSE-ConnectionGUID: UeWs0NXfSjGsmMwagVEc+g==
X-CSE-MsgGUID: fZfMCgGjTCiAoRdXez3fJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; 
   d="scan'208";a="152101705"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 07:26:48 -0700
Received: from [10.124.220.93] (unknown [10.124.220.93])
	by linux.intel.com (Postfix) with ESMTP id B420B20B5736;
	Tue, 10 Jun 2025 07:26:47 -0700 (PDT)
Message-ID: <00847d0e-d231-45df-83b3-8a6f5db4d008@linux.intel.com>
Date: Tue, 10 Jun 2025 07:26:47 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] PCI: Use header type defines in pci_setup_device()
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250610105820.7126-1-ilpo.jarvinen@linux.intel.com>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20250610105820.7126-1-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 6/10/25 3:58 AM, Ilpo Järvinen wrote:
> Replace literals with PCI_HEADER_TYPE_* defines in pci_setup_device().
>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>   drivers/pci/probe.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 4b8693ec9e4c..c00634e5a2ed 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1985,8 +1985,8 @@ int pci_setup_device(struct pci_dev *dev)
>   	dev->sysdata = dev->bus->sysdata;
>   	dev->dev.parent = dev->bus->bridge;
>   	dev->dev.bus = &pci_bus_type;
> -	dev->hdr_type = hdr_type & 0x7f;
> -	dev->multifunction = !!(hdr_type & 0x80);
> +	dev->hdr_type = FIELD_GET(PCI_HEADER_TYPE_MASK, hdr_type);
> +	dev->multifunction = FIELD_GET(PCI_HEADER_TYPE_MFD, hdr_type);
>   	dev->error_state = pci_channel_io_normal;
>   	set_pcie_port_type(dev);
>   
>
> base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


