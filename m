Return-Path: <linux-pci+bounces-44115-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A8DCFA8F9
	for <lists+linux-pci@lfdr.de>; Tue, 06 Jan 2026 20:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F55131785BE
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jan 2026 18:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499A73358BF;
	Tue,  6 Jan 2026 18:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WxeSJo2Q"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866C01D8E10;
	Tue,  6 Jan 2026 18:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767724049; cv=none; b=Gb8ABoQtmc1CROHIOxm8mdRK9YsKeIP9vQn6XpXPbT2CMDLVd7CcgXsrr2paQQ3uif7g4lcj6svkPth6ulz/EMIwdeUvveToho3ukKdKno8rnhAhQ3ZlBQ8SuDJwef/EsFzo/lVISWtZYuZw9zLnoguAEVg01nY4/IC1eXzt8xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767724049; c=relaxed/simple;
	bh=PGRGf+O29+7KRPYgeQfPdYvyGWl3voYDTWrAkoOsUhw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dmZ5EwFlGiR9qQNl0YecALbs4RGQIu/wE2ZgAyHfVs5Bn5gVUZ9ROIorUH1BcplrWQk03x8g9R4PoJIAOty6eWvuqxQOXa/hoAN9wCqxIIdhwWcS8EA0zzxa8n9N5vnGcoZOnvAaKTEtm4pm6ujyUI7MwAdUzLLsrc+SvyELpNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WxeSJo2Q; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767724048; x=1799260048;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PGRGf+O29+7KRPYgeQfPdYvyGWl3voYDTWrAkoOsUhw=;
  b=WxeSJo2QNYq84eaQZA91EWn+OVVTnOcS7+5mll2bFrRulq67E0VnUoYR
   +Mu5iaE4xRIiuVnnt61bbCfVMea8RS6lgwl9Xus2bV4e6wXIREtuFHdB4
   xGSeHCan6cA1tbp7uwD0sErNrPCZKeWN3mpEoiHauT/dMHKN+s0bO42Wf
   evfZR5ANuFwiZIFDoavm2WI2HIE59D0wUt/CguRdE4uqJW7qq5mcT46D5
   XWr2PVAZ/8LD+TAD/PsLY+Ilbkhgac1X2G9X/cD0MDgI00F8EZrhfabKX
   SX6gsC98tWndk/ktxevDxMsAbPkCLG0spLGSe7XoGxCmVaEmRRW2VvyJr
   w==;
X-CSE-ConnectionGUID: yCHPPR1MSO6+/ZEE3ZLl1A==
X-CSE-MsgGUID: PxE8pE5PS0ez0tXdzqIH6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11663"; a="80544498"
X-IronPort-AV: E=Sophos;i="6.21,206,1763452800"; 
   d="scan'208";a="80544498"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2026 10:27:27 -0800
X-CSE-ConnectionGUID: 010MR2iNRXylDp0CsyqRwQ==
X-CSE-MsgGUID: yr8Mo8EWRxi/NWjvcuUb4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,206,1763452800"; 
   d="scan'208";a="202782885"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.109.101]) ([10.125.109.101])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2026 10:27:27 -0800
Message-ID: <8b627a53-a7c4-4d8e-887d-1594f699e035@intel.com>
Date: Tue, 6 Jan 2026 11:27:25 -0700
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
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Feng Tang <feng.tang@linux.alibaba.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260106182025.1398-1-atharvatiwarilinuxdev@gmail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260106182025.1398-1-atharvatiwarilinuxdev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/6/26 11:20 AM, Atharva Tiwari wrote:
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

You probably want to do this as a PCI quirk rather than adding a vendor specific line in a generic function. See drivers/pci/quirks.c.

DJ
>  		services |= PCIE_PORT_SERVICE_AER;
>  #endif
>  


