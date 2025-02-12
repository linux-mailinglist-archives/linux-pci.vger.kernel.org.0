Return-Path: <linux-pci+bounces-21287-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1817AA327F2
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 15:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B01F73A2B1A
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 14:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B1020E6F3;
	Wed, 12 Feb 2025 14:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="BZqz+PMT"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD6320AF62;
	Wed, 12 Feb 2025 14:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739369065; cv=none; b=tB+RWyxAgAfKamhORjJBd1GwV3/rUJ/+OUbrTE01omnHnIVny1ANH0nwIzPnLCfmaRiZdB0dH+Dc2wgwiN6mwi3NCCvjhNRi73wWsaCm9NUhzq7iLU3KXlBO1DPNJD2iUBF5O6i7eKu5hKhWVQWBxVZVGM/jgY9HxThNPRNqZjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739369065; c=relaxed/simple;
	bh=kkHearOQsdIh49mchxJVzszhh4miLNu92TKqOARKaGY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eo+rbETUKgJgxF21209fiJ77YzlgbB9qTNq7CNBWQ+2g9NQiogGyyLQmGCWHkfxC2Q+ZJ6oiPB2sxeBUUAYui0L3kCrCdMMlmJxJQmii5IVmEj4fWgCM8Kv1bknszcLbx93hzI1jtg81ZZoZBa6JmxDpog17javpmrYxIrDMYyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=BZqz+PMT; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=3rPEv+OpCQsqOisf3ZwycCoUtkDWnaoLlzqXtadB8Fk=;
	b=BZqz+PMTKBVNBY0iYeTWFQWo0ty9eAuj4tUirsuaGFfZtxE6BMR4llu+DcOW5F
	0wSJl/ibzhpmtObkSEdiRWsVFrpTzVgUTfSOVNOD0yV9CYXdC/hwO9lmqlgmJnmE
	/NH0GtajkUiO7ahmNlbNkbujCC65YMWzk7Lwaryc+yo1U=
Received: from [192.168.243.52] (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wCXHlI4qqxnp2cGLQ--.10645S2;
	Wed, 12 Feb 2025 22:03:38 +0800 (CST)
Message-ID: <40c3d54b-677b-422d-b002-2155dc7ac66c@163.com>
Date: Wed, 12 Feb 2025 22:03:43 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2] PCI: dwc: Add the debugfs property to provide the LTSSM
 status of the PCIe link
To: Shradha Todi <shradha.t@samsung.com>, jingoohan1@gmail.com
Cc: manivannan.sadhasivam@linaro.org, lpieralisi@kernel.org, kw@linux.com,
 robh@kernel.org, bhelgaas@google.com, Frank.Li@nxp.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, rockswang7@gmail.com
References: <CGME20250206151446epcas5p43a35270da73181b97deb628ff49f3ddd@epcas5p4.samsung.com>
 <20250206151343.26779-1-18255117159@163.com>
 <000001db7d42$d6b56fd0$84204f70$@samsung.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <000001db7d42$d6b56fd0$84204f70$@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wCXHlI4qqxnp2cGLQ--.10645S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Aryxtw43WrW8ZF4DZr1rCrg_yoW8WFyxpa
	95Xw4Ykr48Arn5Wr1fuF4IvrySya95uF43AanFgw4Svw17tF12qF1YkayUAry3Gr1Ykr12
	kF4Yqw1YvF1DXrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UBrWwUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiDxfxo2espdU8HwAAsS



On 2025/2/12 19:39, Shradha Todi wrote:
>> @@ -463,6 +495,7 @@ struct dw_pcie {
>>   	struct reset_control_bulk_data	core_rsts[DW_PCIE_NUM_CORE_RSTS];
>>   	struct gpio_desc		*pe_rst;
>>   	bool			suspended;
>> +	struct dentry		*debugfs;
> 
> This pointer to main directory dentry is already present as rasdes_dir in struct dwc_pcie_rasdes_info.
> So struct dentry *debugfs is duplicating it.
> 
> We have a few options to solve this:
> 1. Remove struct dentry *rasdes_dir from dwc_pcie_rasdes_info and continue to have 2 pointers exposed
> in struct dw_pcie.
> 
> struct dwc_pcie_rasdes_info {
>          u32 ras_cap_offset;
>          struct mutex reg_lock;
> };
> struct dw_pcie {
>         .
>         .
>         struct dentry           *debugfs;
>          void                    *rasdes_info;
>   };
> 
> 2. Change rasdes_info to debugfs info:
> 
> struct dwc_pcie_rasdes_info {
>          u32 ras_cap_offset;
>          struct mutex reg_lock;
> };
> struct dwc_pcie_debugfs_info {
>          struct dwc_pcie_rasdes_info *rinfo;
>          struct dentry           *debugfs;
> };
> struct dw_pcie {
>         .
>         .
>          void                    *debugfs_info;
>   };
> 
> 3. Let ras related info get initialized to 0 even when rasdes cap is not present:
> 
> struct dwc_pcie_debugfs_info {
>          u32 ras_cap_offset;
>          struct mutex reg_lock;
>          struct dentry *debugfs;
> };
> struct dw_pcie {
>         .
>         .
>          void                    *debugfs_info;
>   };
> 
> I think option 2 would be the best, though it will need a bit of changes in my files. What do you suggest?
> 

I couldn't agree more. Can you build the debugfs framework? I or other 
developers can add some other debugfs nodes to this framework, not only 
dwc_pcie_rasdes_debugfs_init, but also dwc_pcie_debugfs_init.

I will add my patch with your next version. Please CC email me.

Best regards
Hans


