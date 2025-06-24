Return-Path: <linux-pci+bounces-30535-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9A1AE6E66
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 20:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDF2516ACA5
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 18:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F102E7F28;
	Tue, 24 Jun 2025 18:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cmCIg+dZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907B22E6D2D
	for <linux-pci@vger.kernel.org>; Tue, 24 Jun 2025 18:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750788816; cv=none; b=Sp+cDQ/GZkDisYNvq/AZnZ3jWVqRpy3fSnwaMFlrGTiqljX/S4NQAM5Soc+c4sgb7uxI0MXMeoMUgmllmDtZmYqMgYQqwqsYqG+Rcvy1pVG4Pqu9VL9Y1eYkKwrbSaZTf/sirpZY3tMShzgsU++JtnFtfAOtvUb+zcfposYcUCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750788816; c=relaxed/simple;
	bh=J8TT+WhHV0NXcGwS8iHfxRUE5Ckyt+pAeY8Bp8jczbo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PHC8M9gassy/V/0fvr8+iT/SzG2UwAuH6UXxV9K512dPN9OzfGGyE3Y2hpfqCmHrS7ydO+79RD23OlVYyRDzmrDtKwtNN36/6d0Qdi97dAG/4g0Q3LucDlxWQhQB2sjswKRw1rKBhYHkeA/z0yH3VbM0zEz1NJRZhbAeCwigT1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cmCIg+dZ; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750788815; x=1782324815;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=J8TT+WhHV0NXcGwS8iHfxRUE5Ckyt+pAeY8Bp8jczbo=;
  b=cmCIg+dZK/xMSMn/xVEaUwyRgApZI1WcH2W/O4CRkGh/jqmU/BBdMez+
   gPxoEICafbvigTkWEZ2uOG6y+e+S3if38CUbQv4Z5W9iFYmrjNCqLA9Mh
   xJvCq4sRgoaMW6YigL1HVRFh1HSpg7goli1Tv7UhgQivWKRFCM1GDjTQB
   zB8iGemsZIbXohMeXIqfIcTJTDU0bWtpePCFh6P652u2E1VyqdP1HFWaM
   z/XAf46yn0RP0Z/Os2iJ7tmeusitHIxToplvzqZs4El4nk/zZree1cFkk
   FwUD3d2axOcYslK28/fqw3aWv88gB7Acjv+OPKxe/96WQpjQsJdQF/OPa
   A==;
X-CSE-ConnectionGUID: bofLcilgRLemz/wZk+Kz6Q==
X-CSE-MsgGUID: q0FDUIPKTUq1YwgnAVrplg==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="64473933"
X-IronPort-AV: E=Sophos;i="6.16,262,1744095600"; 
   d="scan'208";a="64473933"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 11:13:35 -0700
X-CSE-ConnectionGUID: O+g+Mc5mQwma91JgOs5lzA==
X-CSE-MsgGUID: 1wBTr6BFSTC/AYaDbUVLlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,262,1744095600"; 
   d="scan'208";a="189171307"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 11:13:34 -0700
Received: from [10.124.223.82] (unknown [10.124.223.82])
	by linux.intel.com (Postfix) with ESMTP id 3C1F020B5736;
	Tue, 24 Jun 2025 11:13:33 -0700 (PDT)
Message-ID: <b08df1b0-a2ba-402d-93b2-59cf03eff1df@linux.intel.com>
Date: Tue, 24 Jun 2025 11:13:32 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Fix link speed calculation on retrain failure
To: Bjorn Helgaas <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>
Cc: Andrew <andreasx0@protonmail.com>,
 Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
 "Maciej W. Rozycki" <macro@orcam.me.uk>,
 Matthew W Carlis <mattc@purestorage.com>, linux-pci@vger.kernel.org,
 Jiwei Sun <sunjw10@lenovo.com>, Adrian Huang12 <ahuang12@lenovo.com>
References: <20250624164846.GA1482201@bhelgaas>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20250624164846.GA1482201@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 6/24/25 9:48 AM, Bjorn Helgaas wrote:
> [+cc Sathy, Jiwei, Adrian]
>
> On Mon, Jun 23, 2025 at 03:22:14PM +0200, Lukas Wunner wrote:
>> When pcie_failed_link_retrain() fails to retrain, it tries to revert to
>> the previous link speed.  However it calculates that speed from the Link
>> Control 2 register without masking out non-speed bits first.
>>
>> PCIE_LNKCTL2_TLS2SPEED() converts such incorrect values to
>> PCI_SPEED_UNKNOWN, which in turn causes a WARN splat in
>> pcie_set_target_speed():
>>
>>    pci 0000:00:01.1: [1022:14ed] type 01 class 0x060400 PCIe Root Port
>>    pci 0000:00:01.1: broken device, retraining non-functional downstream link at 2.5GT/s
>>    pci 0000:00:01.1: retraining failed
>>    WARNING: CPU: 1 PID: 1 at drivers/pci/pcie/bwctrl.c:168 pcie_set_target_speed
>>    RDX: 0000000000000001 RSI: 00000000000000ff RDI: ffff9acd82efa000
>>    pcie_failed_link_retrain
>>    pci_device_add
>>    pci_scan_single_device
>>    pci_scan_slot
>>    pci_scan_child_bus_extend
>>    acpi_pci_root_create
>>    pci_acpi_scan_root
>>    acpi_pci_root_add
>>    acpi_bus_attach
>>    device_for_each_child
>>    acpi_dev_for_each_child
>>    acpi_bus_attach
>>    device_for_each_child
>>    acpi_dev_for_each_child
>>    acpi_bus_attach
>>    acpi_bus_scan
>>    acpi_scan_init
>>    acpi_init
>>
>> Per the calling convention of the System V AMD64 ABI, the arguments to
>> pcie_set_target_speed(struct pci_dev *, enum pci_bus_speed, bool) are
>> stored in RDI, RSI, RDX.  As visible above, RSI contains 0xff, i.e.
>> PCI_SPEED_UNKNOWN.
>>
>> Fixes: f68dea13405c ("PCI: Revert to the original speed after PCIe failed link retraining")
>> Reported-by: Andrew <andreasx0@protonmail.com>
>> Closes: https://lore.kernel.org/r/7iNzXbCGpf8yUMJZBQjLdbjPcXrEJqBxy5-bHfppz0ek-h4_-G93b1KUrm106r2VNF2FV_sSq0nENv4RsRIUGnlYZMlQr2ZD2NyB5sdj5aU=@protonmail.com/
>> Signed-off-by: Lukas Wunner <lukas@wunner.de>
>> Cc: stable@vger.kernel.org # v6.12+
> I like the brevity of this patch, but I do worry that if we ever have
> other users of PCIE_LNKCTL2_TLS2SPEED(), we might have the same
> problem again.
>
> Also, it looks like PCIE_LNKCAP_SLS2SPEED() has the same problem.
>
> f68dea13405c predates PCIE_LNKCTL2_TLS2SPEED(), and I don't think this
> problem existed as of f68dea13405c.  I think the Fixes: tag should be
> for de9a6c8d5dbf ("PCI/bwctrl: Add pcie_set_target_speed() to set PCIe
> Link Speed"), which added PCIE_LNKCTL2_TLS2SPEED() and
> PCIE_LNKCAP_SLS2SPEED() without masking out the other bits.
>
> I think I'll take Jiwei's patch [1], which fixes
> PCIE_LNKCTL2_TLS2SPEED() and PCIE_LNKCAP_SLS2SPEED() without requiring
> changes in the users.  I'll add the details of Andrew's report to the
> commit log.

Agree.  It is better to fix it in the macro.

>
> [1] https://lore.kernel.org/all/20250123055155.22648-2-sjiwei@163.com/
>
>> ---
>>   drivers/pci/quirks.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index d7f4ee6..deaaf4f 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -108,7 +108,7 @@ int pcie_failed_link_retrain(struct pci_dev *dev)
>>   	pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &lnkctl2);
>>   	pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
>>   	if (!(lnksta & PCI_EXP_LNKSTA_DLLLA) && pcie_lbms_seen(dev, lnksta)) {
>> -		u16 oldlnkctl2 = lnkctl2;
>> +		u16 oldlnkctl2 = lnkctl2 & PCI_EXP_LNKCTL2_TLS;
>>   
>>   		pci_info(dev, "broken device, retraining non-functional downstream link at 2.5GT/s\n");
>>   
>> -- 
>> 2.47.2
>>
-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


