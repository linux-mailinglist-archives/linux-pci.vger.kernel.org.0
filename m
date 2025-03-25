Return-Path: <linux-pci+bounces-24683-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5291A70546
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 16:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85E883A3F26
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 15:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6711A23A2;
	Tue, 25 Mar 2025 15:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ja/IxPfo"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA3819F11B;
	Tue, 25 Mar 2025 15:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742917083; cv=none; b=IS67PK+CKV4CpojCyNlhbtKwuatretMCV+0Qy2xj6xaUiEWv9RTtnCAedNYCRaNs/Ox1CodwosL2GkgQCtHA8DzOvSu/TCuU+Dxb9VXNzdgWiVWr3wwmNCe0mgUtk0PknAdefT8qbkAou9RFMj1+Bq5FoZWnL328qmMDkyH6qyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742917083; c=relaxed/simple;
	bh=UlkXuWlxNcnGydiEel7UdDVy85Yb+diTaZ3PA7XIBBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ovVP8UHiLgvHRbnJkBTTRx9W5QEhtXLs4kVsjJz8BHixkzPijMiKXQ8tvGGHBEhE6ZGKFfS5CqRS2oqvhELI6g9glsWWkubeGMAW1HIWyXhUOwz6o+SLsRmNn7F0/UvvcvMuwC5ggGlOpgJzTL1Qjf6qrTyAZupvGB8GoPk2v6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ja/IxPfo; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=HOSLfaxhpKM24eFOt6f0UecDBgxY8chcrkVNaQallLQ=;
	b=ja/IxPfo5WuC7qyQ7SONjnBQ9GqbWNH5aNpkLQmqv5PFhDnJUDLw3aDGwRL4mv
	CCTKfAAj3Ck81e05KE6gP7XW1bVGrN7gw0kHlOamUQVMYFvHy8+x8eBLR+XAUHJe
	7w/JPdNiOIFDrHsVvnPri+xC4/gqtjSihQy7+Ag+Mp8ow=
Received: from [192.168.71.89] (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3_7O1zeJnrH2CBw--.39786S2;
	Tue, 25 Mar 2025 23:37:25 +0800 (CST)
Message-ID: <9118fcc0-e5a5-40f2-be4b-7e06b4b20601@163.com>
Date: Tue, 25 Mar 2025 23:37:25 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v6 3/5] PCI: cadence: Use common PCI host bridge APIs for
 finding the capabilities
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org,
 robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com,
 thomas.richard@bootlin.com, linux-pci@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <20250323164852.430546-1-18255117159@163.com>
 <20250323164852.430546-4-18255117159@163.com>
 <f467056d-8d4a-9dab-2f0a-ca589adfde53@linux.intel.com>
 <d370b69a-3b70-4e3b-94a3-43e0bc1305cd@163.com>
 <a3462c68-ec1b-0b1a-fee7-612bd1109819@linux.intel.com>
 <3d9b2fa9-98bf-4f47-aa76-640a4f82cb2f@163.com>
 <26dcba54-93c1-dda4-c5e2-e324e9d50b09@linux.intel.com>
 <f2725090-e199-493d-9ae3-e807d65f647b@163.com>
 <de6ce71c-ba82-496e-9c72-7c9c61b37906@163.com>
 <ddabf340-a00f-75b1-2b6b-d9ab550a984f@linux.intel.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <ddabf340-a00f-75b1-2b6b-d9ab550a984f@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3_7O1zeJnrH2CBw--.39786S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Gr1rKFWUGw47uF4kGF4fuFg_yoW8JryxpF
	4Yg3WIk3WDGFs7CF4xGF4DAFWYk393Gry5Ar9xXry8tr4kX3Z2qF9akayYyF9xuF4kta12
	qFyjqFZ7Aas8Aa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UVMKtUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDwcbo2fix+Cg6AAAsa



On 2025/3/25 23:18, Ilpo Järvinen wrote:>>
>> Hi Ilpo,
>>
>> Another question comes to mind:
>> If working in EP mode, devm_pci_alloc_host_bridge will not be executed and
>> there will be no struct pci_host_bridge.
>>
>> Don't know if you have anything to add?
> 
> Hi Hans,
> 
> No, I don't have further ideas at this point, sorry. It seems it isn't
> realistic without something more substantial that currently isn't there.
> 
> This lack of way to have a generic way to read the config before the main
> struct are instanciated by the PCI core seems to be the limitation that
> hinders sharing code between controller drivers and it would have been
> nice to address it.
> 
> But please still make the capability list parsing code common, it should
> be relatively straightforward using a macro which can take different read
> functions similar to read_poll_timeout. That will avoid at least some
> amount of code duplication.
> 
> Thanks for trying to come up with a solution (or thinking enough to say
> it doesn't work)!
> 

Hi Ilpo,

It's okay. It's what I'm supposed to do. Thank you very much for your 
discussion with me. I'll try a macro definition like read_poll_timeout. 
Will share the revised patches soon for your feedback.

Best regards,
Hans



