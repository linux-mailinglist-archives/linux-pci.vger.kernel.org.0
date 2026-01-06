Return-Path: <linux-pci+bounces-44120-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F1BCFAB81
	for <lists+linux-pci@lfdr.de>; Tue, 06 Jan 2026 20:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A40031E8924
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jan 2026 19:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D133093CA;
	Tue,  6 Jan 2026 19:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DgscR4Pm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B7D3064B2;
	Tue,  6 Jan 2026 19:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767726055; cv=none; b=NT2iKmyxEu1Ix6fc7wdtXzcXNjsbL5nZaSK/C2mh1S5p52cN5QROmEtOMZrk7C8cer8Vw7APS+6AmNumgzS7Krrt9Ul2xX8aLjkk1UNtb1g6OXyODAjJ5ESl3GCK2vsqOWMbl7yK+UAwDM8P/BKyYdPdQ1QJwfc1WmA8hDUiTxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767726055; c=relaxed/simple;
	bh=nupLE+oPtW6HoDAyTx9Sr3Iw1tygfmCO5ohk/AbD+RA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ETyupiz4mHNS+se6koVej/bGSjEfOq7dw5lGLtKVQ3e09vVOZjlvR3Js8P5khEBcPhmOpDnvGvoEJGEhFntb53ctMe/v8CWgkVwBgrNnEw6gYJhV0SlDjcO9XpHVmxAapAIvzCP97wJPzwdzT8Lux7cRPKWR89ihfzw98z3YjLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DgscR4Pm; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767726054; x=1799262054;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nupLE+oPtW6HoDAyTx9Sr3Iw1tygfmCO5ohk/AbD+RA=;
  b=DgscR4PmbvvK+bpjQdrcWSOk6O573FHsjcLwqHUV513YE+xlWrTVwVwo
   wwxfgT6NysW00BZGfMAwtUKdOzQfINJErMapUORn8iU0zUaXlgQNMqUIO
   hZlyOyz5FsyFKy4e7mvu52GHwzOr3RJtbQrKkXboz6hBHSu0sliayFZDv
   UkxaQqnbIk1S0qfLixGYITAHKsM87/dUUfokHIPp3BJNdgoK7PdEqlCA0
   LLDOy3uXlW8nuVwRgAXIf+Hc/sqgOmz6egFQTAd1FIsDJjVzfTae04/27
   Y9aT9IAgX0TR/hlhoAvkUKrgQT4q5Mvxmce5GWdFiEU+bRr/fLVZ4nfk/
   w==;
X-CSE-ConnectionGUID: Nnr6+aDYQCKYaw3xY8grWg==
X-CSE-MsgGUID: L5oecB23QGChF2RZ39RDVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11663"; a="79730599"
X-IronPort-AV: E=Sophos;i="6.21,206,1763452800"; 
   d="scan'208";a="79730599"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2026 11:00:53 -0800
X-CSE-ConnectionGUID: dXzZ0zL1QdWZo/yVEsxesQ==
X-CSE-MsgGUID: VbMcLBtDQYWcS66i/Fwv1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,206,1763452800"; 
   d="scan'208";a="202629713"
Received: from soc-pf446t5c.clients.intel.com (HELO [10.24.81.126]) ([10.24.81.126])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2026 11:00:53 -0800
Message-ID: <e45f4544-7ff4-4e75-b8d0-3ec3480b1444@linux.intel.com>
Date: Tue, 6 Jan 2026 11:00:52 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/portdev: Disable AER for Titan Ridge 4C 2018
To: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
 Dave Jiang <dave.jiang@intel.com>, Feng Tang <feng.tang@linux.alibaba.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260106182025.1398-1-atharvatiwarilinuxdev@gmail.com>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20260106182025.1398-1-atharvatiwarilinuxdev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/6/2026 10:20 AM, Atharva Tiwari wrote:
> Disable AER for Intel Titan Ridge 4C 2018
> (used in T2 iMacs, where the warnings appear)
> that generates continuous pcieport warnings. such as:
> 
> pcieport 0000:00:1c.4: AER: Correctable error message received from 0000:07:00.0
> pcieport 0000:07:00.0: PCIe Bus Error: severity=Correctable, type=Data Link Layer, (Receiver ID)
> pcieport 0000:07:00.0:   device [8086:15ea] error status/mask=00000080/00002000
> pcieport 0000:07:00.0:    [ 7] BadDLLP
> 
> (see: https://bugzilla.kernel.org/show_bug.cgi?id=220651)
> 
> macOS also disables AER for Thunderbolt devices and controllers in their drivers.
> 

Why not disable it in BIOS or use noaer command line option?

> Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
> ---
>  drivers/pci/pcie/portdrv.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
> index 38a41ccf79b9..5330a679fcff 100644
> --- a/drivers/pci/pcie/portdrv.c
> +++ b/drivers/pci/pcie/portdrv.c
> @@ -240,7 +240,9 @@ static int get_port_device_capability(struct pci_dev *dev)
>  	if ((pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
>               pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC) &&
>  	    dev->aer_cap && pci_aer_available() &&
> -	    (pcie_ports_native || host->native_aer))
> +	    (pcie_ports_native || host->native_aer) &&
> +	    !(dev->vendor == PCI_VENDOR_ID_INTEL &&
> +		    (dev->device >= 0x15EA && dev->device <= 0x15EC)))
>  		services |= PCIE_PORT_SERVICE_AER;
>  #endif
>  

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


