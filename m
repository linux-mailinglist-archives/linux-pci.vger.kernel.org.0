Return-Path: <linux-pci+bounces-6581-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 470FF8AEAF1
	for <lists+linux-pci@lfdr.de>; Tue, 23 Apr 2024 17:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECC1C1F23718
	for <lists+linux-pci@lfdr.de>; Tue, 23 Apr 2024 15:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA6113C3C7;
	Tue, 23 Apr 2024 15:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oCsfVJTT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8DE5820E;
	Tue, 23 Apr 2024 15:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713885846; cv=none; b=mS4+dr9uAQyeaWf4F91Vu7E01+U6fd/EZ6QLrBBlMW4v+KtIfA/GFTa5NzV2HEMtQmVi4XWS6t/wwbwxqo69welVd2cCmYC7vtzqfzfjo/unisXpOdRG60K9RnQPESsq9t4azVgemLiaSH1pvd/Q15YO2W1EVauFzHnhGSqa8as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713885846; c=relaxed/simple;
	bh=mD0vvUwgdC13kb4/PXO2KQ82sAyp3j2+v63zyLz5Ris=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H0G8UPOhvYlCd2zmDDTohWumR+LiAS6azymN51D41u4wnKvLqFDupeUruDJO1zs2kvVoq7wt7R2lZU+bZgju5nVs/I4K+U/7PvGdbaM9osegBotaEKoAdT95Ct+GT9eXVdqtN/XcML7UCoI+VIGNHZPhvslRV4Fr5iJ8HEvE8Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oCsfVJTT; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713885844; x=1745421844;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mD0vvUwgdC13kb4/PXO2KQ82sAyp3j2+v63zyLz5Ris=;
  b=oCsfVJTTyMdwi1Y7ZO8J66sR1FA5lmh4lzCLfTrxonVLpw9cDCx/IHme
   iXDPN/k3jaop83LN3TPpfbssSxzAnK3kNYNU8JDGZRYM5zZFrq9UIO+Zy
   eZLnsXQdjCEN+K7sR0wznZ/CxE9MgYwgJNt2wqRuAo/uyTukUxrFGSKFJ
   XN2evV0ZRu20WJnpCWhQshiNqGK1Kj+cDcM/OPREDcrO4T85v2+7Q4/xO
   Zl8OtovZYhh/kAHrPraPlFFilPLCdmQvP5z2wwW8H9kyYf30ctUP2/XTO
   4I6M9JtaV7BUmos8fLyjOTemnYrAee3zT7jzzluiJSojvJ0stjQLfGmYl
   w==;
X-CSE-ConnectionGUID: dTvUyiMzSoW9QfJEEYzIlg==
X-CSE-MsgGUID: Y97Sd2eaRG2j3SUdlhoarA==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="13262477"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="13262477"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 08:24:03 -0700
X-CSE-ConnectionGUID: lKSM7utiRrOhAMNiblA3QA==
X-CSE-MsgGUID: SSpv677+TW+q4Epka+axrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24440874"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.108.21]) ([10.212.108.21])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 08:24:03 -0700
Message-ID: <c7a6bcb9-5727-46c0-8efb-6430604cd344@intel.com>
Date: Tue, 23 Apr 2024 08:24:02 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] cxl/core/regs: Add rcd_regs initialization at
 __rcrb_to_component()
To: "Daisuke Kobayashi (Fujitsu)" <kobayashi.da-06@fujitsu.com>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Cc: "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "mj@ucw.cz" <mj@ucw.cz>, "dan.j.williams@intel.com"
 <dan.j.williams@intel.com>
References: <20240412070715.16160-1-kobayashi.da-06@fujitsu.com>
 <20240412070715.16160-2-kobayashi.da-06@fujitsu.com>
 <dcf61e50-2a56-4e1e-a21d-c887e3c07427@intel.com>
 <OSAPR01MB71823658767F3088CDA09489BA112@OSAPR01MB7182.jpnprd01.prod.outlook.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <OSAPR01MB71823658767F3088CDA09489BA112@OSAPR01MB7182.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/23/24 1:33 AM, Daisuke Kobayashi (Fujitsu) wrote:
> Dave Jiang wrote:
>> On 4/12/24 12:07 AM, Kobayashi,Daisuke wrote:
>>> Add rcd_regs and its initialization at __rcrb_to_component() to cache
>>> the cxl1.1 device link status information. Reduce access to the memory
>>> map area where the RCRB is located by caching the cxl1.1 device
>>> link status information.
>>>
>>> Signed-off-by: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
>>> ---
>>>  drivers/cxl/core/regs.c | 16 ++++++++++++++++
>>>  drivers/cxl/cxl.h       |  3 +++
>>>  2 files changed, 19 insertions(+)
>>>
>>> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
>>> index 372786f80955..e0e96be0ca7d 100644
>>> --- a/drivers/cxl/core/regs.c
>>> +++ b/drivers/cxl/core/regs.c
>>> @@ -514,6 +514,8 @@ resource_size_t __rcrb_to_component(struct device
>> *dev, struct cxl_rcrb_info *ri
>>>  	u32 bar0, bar1;
>>>  	u16 cmd;
>>>  	u32 id;
>>> +	u16 offset;
>>> +	u32 cap_hdr;
>>>
>>>  	if (which == CXL_RCRB_UPSTREAM)
>>>  		rcrb += SZ_4K;
>>> @@ -537,6 +539,20 @@ resource_size_t __rcrb_to_component(struct device
>> *dev, struct cxl_rcrb_info *ri
>>>  	cmd = readw(addr + PCI_COMMAND);
>>>  	bar0 = readl(addr + PCI_BASE_ADDRESS_0);
>>>  	bar1 = readl(addr + PCI_BASE_ADDRESS_1);
>>> +	offset = FIELD_GET(GENMASK(7, 0), readw(addr +
>> PCI_CAPABILITY_LIST));
>>
>> Maybe
>> #define PCI_RCRB_CAPABILITY_LIST_ID_MASK	GENMASK(7, 0)
>>
>>> +	cap_hdr = readl(addr + offset);
>>> +	while ((cap_hdr & GENMASK(7, 0)) != PCI_CAP_ID_EXP) {
>>
>> while ((FIELD_GET(PCI_RCRB_CAP_HDR_ID_MASK, cap_hdr) !=
>> PCI_CAP_ID_EXP) {
>>
>> Also I think you need to add a check and see if the loop went beyond SZ_4K that
>> was mapped.
>>
>>> +		offset = (cap_hdr >> 8) & GENMASK(7, 0);
>>
>> #define PCI_RCRB_CAP_HDR_NEXT_MASK	GENMASK(15, 8);
>> offset = FIELD_GET(PCI_RCRB_CAP_HDR_NEXT_MASK, cap_hdr);
> 
> Thank you for your comment. In the next patch I will define and use additional masks.
> 
>>> +		if (offset == 0)
>>> +			break;
>>> +		cap_hdr = readl(addr + offset);
>>> +	}
>>> +	if (offset) {
>>> +		ri->rcd_lnkcap = readl(addr + offset + PCI_EXP_LNKCAP);
>>> +		ri->rcd_lnkctrl = readl(addr + offset + PCI_EXP_LNKCTL);
>>> +		ri->rcd_lnkstatus = readl(addr + offset + PCI_EXP_LNKSTA);
>>> +	}
>>> +
>>>  	iounmap(addr);
>>>  	release_mem_region(rcrb, SZ_4K);
>>>
>>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>>> index 003feebab79b..2dc827c301a1 100644
>>> --- a/drivers/cxl/cxl.h
>>> +++ b/drivers/cxl/cxl.h
>>> @@ -647,6 +647,9 @@ cxl_find_dport_by_dev(struct cxl_port *port, const
>> struct device *dport_dev)
>>>  struct cxl_rcrb_info {
>>>  	resource_size_t base;
>>>  	u16 aer_cap;
>>> +	u16 rcd_lnkctrl;
>>> +	u16 rcd_lnkstatus;
>>> +	u32 rcd_lnkcap;
>>>  };
>>>
>>>  /**
> 
> Please let me know if any revisions are necessary for merging this patch.

Yes please send out a revision with updates. I'd also like to see a review tag from one of the other maintainers before merging. Thanks! 


