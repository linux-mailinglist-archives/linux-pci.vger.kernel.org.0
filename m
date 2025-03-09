Return-Path: <linux-pci+bounces-23235-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2557A582CD
	for <lists+linux-pci@lfdr.de>; Sun,  9 Mar 2025 10:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 447A8188AA1C
	for <lists+linux-pci@lfdr.de>; Sun,  9 Mar 2025 09:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292C61B043D;
	Sun,  9 Mar 2025 09:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="DZmnhS/l"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3DC1AC43A;
	Sun,  9 Mar 2025 09:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741513799; cv=none; b=iPMmP2WzFJmjSmer4o/O+LwusvyJHiHUu1bCFKvkn1fwKotmFQ+SYSEbp4Q+GPdGeDFkFm3Gsij0+ZHlqBWtpB8Q34wg0YRCdmiSdTxrieNScyb8EsW5ntTcRluJE3oj6lWK0p5ZkrEs0e4XE8gzDXr7Y81xMeDUNJtAsdK5G9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741513799; c=relaxed/simple;
	bh=VxJvVn6qaRu0WEzuAQdi5gaBI4IgpefPj5pgizkVmH4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Htgz5yp/yyFQ0dRT23503ut/nzh5tGrT/L4WociWPOxe1J8nfY2Mkr4akdDsKRZy8sbENJuc4ytYaVQFpOIh54VJ9gUNg5nGNZisRu6VReejm1v64N4/JU6ljc8HOmkBcL1q8VJCFNGZPLFbOrbJr1yYStmHc0+z5Dg1C+kIdRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=DZmnhS/l; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=D0D4APOoeYC81PF9TRG8I9kzmofvMySqAZ9SAcnxvBs=;
	b=DZmnhS/lIVwn/yubSTMxmdq6LpOYSPKVJUiGEZ1x2JQXNhdMJnIzdLeIV2Qdg6
	r8o7cPHgyoIneXfvYgM+62HyXpFP+WlcBIycoGQszZ99GL/SwwOEq4j8e2q0W3fb
	eHD2lnckm0BEOGql1FguTlTczGvihYaLf8DWRShHdkjyk=
Received: from [192.168.71.45] (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wBHf_oWZM1n+J9ZRg--.21878S2;
	Sun, 09 Mar 2025 17:49:10 +0800 (CST)
Message-ID: <bf9fc865-58b9-45ed-a346-ce82899d838c@163.com>
Date: Sun, 9 Mar 2025 17:49:09 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2] PCI: cadence: Add configuration space capability search API
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org,
 robh@kernel.org, bhelgaas@google.com, bwawrzyn@cisco.com,
 thomas.richard@bootlin.com, wojciech.jasko-EXT@continental-corporation.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250308133903.322216-1-18255117159@163.com>
 <20250309023839.2cakdpmsbzn6pm7g@uda0492258>
 <3e6645a8-6de9-4125-8444-fa1a4f526881@163.com>
 <20250309054835.4ydiq4xpguxtbvkf@uda0492258>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20250309054835.4ydiq4xpguxtbvkf@uda0492258>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wBHf_oWZM1n+J9ZRg--.21878S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCFyfXFWDAFWUJw4UtryrZwb_yoWrGF48pa
	yDXFyFkF4kJrW29rs2gan0qFyFq3s3JryUG34DGw15Zrn09F12yF4I9r45uF97CrZ7uF1Y
	v390qrZ7Xan8A37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uf739UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWw0Lo2fNW1rYVAAAsZ



On 2025/3/9 13:48, Siddharth Vadapalli wrote:
> On Sun, Mar 09, 2025 at 11:18:21AM +0800, Hans Zhang wrote:
>>
>>
>> On 2025/3/9 10:38, Siddharth Vadapalli wrote:
>>> On Sat, Mar 08, 2025 at 09:39:03PM +0800, Hans Zhang wrote:
>>>> Add configuration space capability search API using struct cdns_pcie*
>>>> pointer.
>>>>
>>>> The offset address of capability or extended capability designed by
>>>> different SOC design companies may not be the same. Therefore, a flexible
>>>> public API is required to find the offset address of a capability or
>>>> extended capability in the configuration space.
>>>>
>>>> Signed-off-by: Hans Zhang <18255117159@163.com>
>>>> ---
>>>> Changes since v1:
>>>> https://lore.kernel.org/linux-pci/20250123070935.1810110-1-18255117159@163.com
>>>>
>>>> - Added calling the new API in PCI-Cadence ep.c.
>>>> - Add a commit message reason for adding the API.
>>>
>>> In reply to your v1 patch, you have mentioned the following:
>>> "Our controller driver currently has no plans for upstream and needs to
>>> wait for notification from the boss."
>>> at:
>>> https://lore.kernel.org/linux-pci/fcfd4827-4d9e-4bcd-b1d0-8f9e349a6be7@163.com/
>>>
>>> Since you have posted this patch, does it mean that you will be
>>> upstreaming your driver as well? If not, we still end up in the same
>>> situation as earlier where the Upstream Linux has APIs to support a
>>> Downstream driver.
>>>
>>> Bjorn indicated the above already at:
>>> https://lore.kernel.org/linux-pci/20250123170831.GA1226684@bhelgaas/
>>> and you did agree to do so. But this patch has no reference to the
>>> upstream driver series which shall be making use of the APIs in this
>>> patch.
>>
>> Hi Siddharth,
>>
>>
>> Bjorn:
>>    If/when you upstream code that needs this interface, include this
>>    patch as part of the series.  As Siddharth pointed out, we avoid
>>    merging code that has no upstream users.
>>
>>
>> Hans: This user is: pcie-cadence-ep.c. I think this is an optimization of
>> Cadence common code. I think this is an optimization of Cadence common code.
>> Siddharth, what do you think?
> 
> This seems to be an extension of the driver rather than an optimization.
> At first glance, though it seems like this patch is enabling code-reuse,
> it is actually attempting to walk through the config space registers to
> identify a capability. Prior to this patch, those offsets were hard-coded,
> saving the trouble of having to walk through the capability pointers to
> arrive at the capability.

Hi Siddharth,

Prior to this patch, I don't think hard-coded is that reasonable. 
Because the SOC design of each company does not guarantee that the 
offset of each capability is the same. This parameter can be configured 
when selecting PCIe configuration options. The current code that just 
happens to hit the offset address is the same.

You can refer to the pci_find_*capability() or dw_pcie_find_*capability 
API. The meaning of their appearance is the same as what I said, and the 
design of each company may be different.

Best regards,
Hans

> 
> This patch will affect the following functions:
> 01. cdns_pcie_get_fn_from_vfn()
> 02. cdns_pcie_ep_write_header()
> 03. cdns_pcie_ep_set_msi()
> 04. cdns_pcie_ep_get_msi()
> 05. cdns_pcie_ep_get_msix()
> 06. cdns_pcie_ep_set_msix()
> 07. cdns_pcie_ep_send_msi_irq()
> 08. cdns_pcie_ep_map_msi_irq()
> 09. cdns_pcie_ep_send_msix_irq()
> 10. cdns_pcie_ep_start()
> which will now take longer to get to the capability whose offset was
> known. I understand that you wish to extend these functions to support
> your SoC where the offsets don't match the hard-coded ones.
>
In my opinion, hard-coded is not universal.

> I will let Bjorn and others share their views on this patch.
> 
> Regards,
> Siddharth.


