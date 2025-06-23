Return-Path: <linux-pci+bounces-30397-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B03AE4577
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 15:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5C71179C9D
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 13:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266134C7F;
	Mon, 23 Jun 2025 13:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XwkIatOC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EF1248F4A
	for <linux-pci@vger.kernel.org>; Mon, 23 Jun 2025 13:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750686565; cv=none; b=FUJshXg2oH1UxgSK569ZilrFAeKhi/Hy8lEMHYtHZce92LAJZ7NfgIw/D9cqasjTO36GiEdzJuKC24Fbrou70GMOnaTw8ybODyTrYcyLbWI/HhK7XdthBeFYAjTJg0qvdLnwNk2AFU0N/JVJsUq5TiXTENQg6sdMKN/rg1YOFDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750686565; c=relaxed/simple;
	bh=qRWbrLxFMCvS3y/bv2h5074rDl0kC+0ZQVfPZSGa86I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T+IwQJLMMbFwQpggdyw+Xu1BkTVapzRHgTKFqKAqG1Zc3vqaWt6U8+1xIybYQvrMTFxrgdk1GKGAw84rbIN4zCyGigPa7Ia2oKBYA5WBP+krQRJ8m4UFWj0VOTlnrtjAcjtYfM0XxBx1+Oqg9DdyVm/R3K6DRsRGJcQAI/Fhqus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XwkIatOC; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750686564; x=1782222564;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qRWbrLxFMCvS3y/bv2h5074rDl0kC+0ZQVfPZSGa86I=;
  b=XwkIatOCBCyoReDt29PEMkdPj+PPnYjRVL1lhGvFXjDFz9gsd/Y0ZYVH
   4nMrMhAvbqOog0C550HUrAJsF3UirAVQzH0liHFqGRyrgJGlq2ZuB36Eo
   /H9CSTAiXs7Q8QhLUGNtdcxZ1n6dA48m46fOoO2PNHNI+nqcybx+rXchD
   /PkawMTf5IixTdZYv72pD3kpmJ8QLGnw3I0SA4Kn7QdBnWvKG4C3aBD87
   Tjqw4GKzP28AGhnI5ndpP1ZV1hUe5de1RNy3Hwk3sRXYkcNfmPepa9UIv
   i2bReA8O/3TBJOgjgN0Gr7JNVax0PQPSlwDIXD7XFWkHHp5zQ+NpthAH7
   w==;
X-CSE-ConnectionGUID: VPEp7dfoRj2Jop7d4lPiug==
X-CSE-MsgGUID: y7jjJc8vS2+euW58OCsLYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="52764543"
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="52764543"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 06:49:20 -0700
X-CSE-ConnectionGUID: PdWtcdcqSk29lpk7x6tpoA==
X-CSE-MsgGUID: 62hoYChfSX+WZLzZwhFIAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="175215448"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 06:49:20 -0700
Received: from [10.124.222.140] (unknown [10.124.222.140])
	by linux.intel.com (Postfix) with ESMTP id AA0DE20B5736;
	Mon, 23 Jun 2025 06:49:18 -0700 (PDT)
Message-ID: <41071b2e-cb40-4ecf-a084-9dac15e6aa46@linux.intel.com>
Date: Mon, 23 Jun 2025 06:49:18 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Fix link speed calculation on retrain failure
To: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>
Cc: Andrew <andreasx0@protonmail.com>,
 Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
 "Maciej W. Rozycki" <macro@orcam.me.uk>,
 Matthew W Carlis <mattc@purestorage.com>, linux-pci@vger.kernel.org
References: <1c92ef6bcb314ee6977839b46b393282e4f52e74.1750684771.git.lukas@wunner.de>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <1c92ef6bcb314ee6977839b46b393282e4f52e74.1750684771.git.lukas@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 6/23/25 6:22 AM, Lukas Wunner wrote:
> When pcie_failed_link_retrain() fails to retrain, it tries to revert to
> the previous link speed.  However it calculates that speed from the Link
> Control 2 register without masking out non-speed bits first.
>
> PCIE_LNKCTL2_TLS2SPEED() converts such incorrect values to
> PCI_SPEED_UNKNOWN, which in turn causes a WARN splat in
> pcie_set_target_speed():
>
>    pci 0000:00:01.1: [1022:14ed] type 01 class 0x060400 PCIe Root Port
>    pci 0000:00:01.1: broken device, retraining non-functional downstream link at 2.5GT/s
>    pci 0000:00:01.1: retraining failed
>    WARNING: CPU: 1 PID: 1 at drivers/pci/pcie/bwctrl.c:168 pcie_set_target_speed
>    RDX: 0000000000000001 RSI: 00000000000000ff RDI: ffff9acd82efa000
>    pcie_failed_link_retrain
>    pci_device_add
>    pci_scan_single_device
>    pci_scan_slot
>    pci_scan_child_bus_extend
>    acpi_pci_root_create
>    pci_acpi_scan_root
>    acpi_pci_root_add
>    acpi_bus_attach
>    device_for_each_child
>    acpi_dev_for_each_child
>    acpi_bus_attach
>    device_for_each_child
>    acpi_dev_for_each_child
>    acpi_bus_attach
>    acpi_bus_scan
>    acpi_scan_init
>    acpi_init
>
> Per the calling convention of the System V AMD64 ABI, the arguments to
> pcie_set_target_speed(struct pci_dev *, enum pci_bus_speed, bool) are
> stored in RDI, RSI, RDX.  As visible above, RSI contains 0xff, i.e.
> PCI_SPEED_UNKNOWN.
>
> Fixes: f68dea13405c ("PCI: Revert to the original speed after PCIe failed link retraining")
> Reported-by: Andrew <andreasx0@protonmail.com>
> Closes: https://lore.kernel.org/r/7iNzXbCGpf8yUMJZBQjLdbjPcXrEJqBxy5-bHfppz0ek-h4_-G93b1KUrm106r2VNF2FV_sSq0nENv4RsRIUGnlYZMlQr2ZD2NyB5sdj5aU=@protonmail.com/
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org # v6.12+
> ---

Looks good to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>   drivers/pci/quirks.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index d7f4ee6..deaaf4f 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -108,7 +108,7 @@ int pcie_failed_link_retrain(struct pci_dev *dev)
>   	pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &lnkctl2);
>   	pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
>   	if (!(lnksta & PCI_EXP_LNKSTA_DLLLA) && pcie_lbms_seen(dev, lnksta)) {
> -		u16 oldlnkctl2 = lnkctl2;
> +		u16 oldlnkctl2 = lnkctl2 & PCI_EXP_LNKCTL2_TLS;
>   
>   		pci_info(dev, "broken device, retraining non-functional downstream link at 2.5GT/s\n");
>   

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


