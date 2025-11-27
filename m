Return-Path: <linux-pci+bounces-42219-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81AE1C8F927
	for <lists+linux-pci@lfdr.de>; Thu, 27 Nov 2025 17:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4019B3A819E
	for <lists+linux-pci@lfdr.de>; Thu, 27 Nov 2025 16:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A36D2D59FA;
	Thu, 27 Nov 2025 16:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="p12BYw7G"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459012D97BD;
	Thu, 27 Nov 2025 16:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764262762; cv=none; b=Ydo6Wh8tpuH1k6GBkwEmlLeBB6VtIcsA8prRFiwBuC84z26s5ybdCpnVSC3vB8tfa+hcViNptpfXtREDs86FibyJ3RSbDFT+o97Gdbg5IgYbezoD7ZpZKupVyA2Am4Hruco4emvxT/69k4ufg8Iv94aze6ky9QxVgF+TXSsNCRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764262762; c=relaxed/simple;
	bh=uLDeQ8AtfeC+jPLabg0at7BqWYyxSADJB8FiCXwGQ6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=coJcyG/hvEDyENpLLwhFs031NOM3ZnzQZylILU5Zsx18iEtPvPi3qdzau/lk8pzaB1q0nHIPuyylRJS6IpVPgRH6Vl1MtvcAIlRF6Kvlg0SL7PtnoauVAyCMTlscGm0vq7ddP7KOCGSu+xWA1GZxHC/qw+A5X/tx+ix5wjt3mqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=p12BYw7G; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=2B76zoWhuwGSjr962yskSX1jRYL5m0tGEi12IlYEVJk=;
	b=p12BYw7GqhcWlruCyHJfO0Xy44NJmi/ED79T7wyquR1xxPay+JyFOr977QRovt
	FlxvGdxydBCzFARzCPv+HHBWCOYKhsRYEW6vshFlRNeUpv4rTb+fgRM5y97KVcQd
	6J48vx8tu+Csg6wBGQG76gJs+4ae+Dhws6WYwI9vdm1H0=
Received: from [IPV6:240e:b8f:927e:1000:9218:e74d:98cf:7e7c] (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wAHwIcfgyhpz7drCg--.4876S2;
	Fri, 28 Nov 2025 00:58:08 +0800 (CST)
Message-ID: <74a61ccd-c694-44d7-a54c-a40da2df823e@163.com>
Date: Fri, 28 Nov 2025 00:58:07 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] PCI: Configure Root Port MPS during host probing
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com,
 heiko@sntech.de, mani@kernel.org, yue.wang@amlogic.com, pali@kernel.org,
 neil.armstrong@linaro.org, robh@kernel.org, jingoohan1@gmail.com,
 khilman@baylibre.com, jbrunet@baylibre.com,
 martin.blumenstingl@googlemail.com, cassel@kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-rockchip@lists.infradead.org
References: <20251126235432.GA2726707@bhelgaas>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20251126235432.GA2726707@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wAHwIcfgyhpz7drCg--.4876S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGryUXry7CFW3CFW5CFy8Krg_yoW5trWxpa
	yUXa1FyFs3WryfZayDZ3W5CFy5tayvy3y5tr98trW0vFs8ZFyDJFyqyFZ5G3s7CrWfXw1a
	vFn8X34xAFn8ZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UszVnUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOgITo2kofAzE7wAAsS

Hi Bjorn,

Thank you very much for your reply and the problems you pointed out. The 
next version will modify it.

Best regards,
Hans

On 2025/11/27 07:54, Bjorn Helgaas wrote:
> On Wed, Nov 05, 2025 at 12:51:24AM +0800, Hans Zhang wrote:
>> Current PCIe initialization logic may leave Root Ports (root bridges)
>> operating with non-optimal Maximum Payload Size (MPS) settings. Existing
>> code in pci_configure_mps() returns early for devices without an upstream
>> bridge (!bridge) which includes Root Ports, so their MPS values remain
>> at firmware/hardware defaults. This fails to utilize the controller's full
>> capabilities, leading to suboptimal data transfer efficiency across the
>> PCIe hierarchy.
>>
>> With this patch, during the host controller probing phase:
>> - When PCIe bus tuning is enabled (not PCIE_BUS_TUNE_OFF), and
>> - The device is a Root Port without an upstream bridge (!bridge),
>> The Root Port's MPS is set to its hardware-supported maximum value
>> (128 << dev->pcie_mpss).
>>
>> Note that this initial maximum MPS setting may be reduced later, during
>> downstream device enumeration, if any downstream device does not suppor
>> the Root Port's maximum MPS.
>>
>> This change ensures Root Ports are properly initialized before downstream
>> devices negotiate MPS, while maintaining backward compatibility via the
>> PCIE_BUS_TUNE_OFF check.
> 
> "Properly" is sort of a junk word for me because all it really says is
> we were stupid before, and we're smarter now, but it doesn't explain
> exactly *what* was wrong and why this new thing is "proper."
> 
> It's obvious that the Max_Payload_Size power-on default (128 bytes) is
> suboptimal in some situations, so you don't even need to say that.
> And I think 128 bytes *is* optimal in the PCIE_BUS_PEER2PEER case.
> 
> s/Root Ports (root bridges)/Root Ports/
> s/bridge (!bridge)/bridge/     # a couple times
> s/hardware-supported//         # unnecessary
> s/(128 << dev->pcie_mpss)//    # we can read the spec
> s/suppor/support/
> 
>> Suggested-by: Niklas Cassel <cassel@kernel.org>
>> Suggested-by: Manivannan Sadhasivam <mani@kernel.org>
>> Signed-off-by: Hans Zhang <18255117159@163.com>
>> ---
>>   drivers/pci/probe.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index 0ce98e18b5a8..2459def3af9b 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -2196,6 +2196,18 @@ static void pci_configure_mps(struct pci_dev *dev)
>>   		return;
>>   	}
>>   
>> +	/*
>> +	 * Unless MPS strategy is PCIE_BUS_TUNE_OFF (don't touch MPS at all),
>> +	 * start off by setting Root Ports' MPS to MPSS. This only applies to
>> +	 * Root Ports without an upstream bridge (root bridges), as other Root
>> +	 * Ports will have downstream bridges.
> 
> I can't parse this sentence.  *No* Root Port has an upstream bridge.
> So I don't know what "other Root Ports" would be or why they would
> have downstream bridges (any Root Port is likely to have downstream
> endpoints or bridges).
> 
>> +	   ... Depending on the MPS strategy
>> +	 * and MPSS of downstream devices, the Root Port's MPS may be
>> +	 * overridden later.
>> +	 */
>> +	if (!bridge && pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT &&
>> +	    pcie_bus_config != PCIE_BUS_TUNE_OFF)
>> +		pcie_set_mps(dev, 128 << dev->pcie_mpss);
>> +
>>   	if (!bridge || !pci_is_pcie(bridge))
>>   		return;
>>   
>> -- 
>> 2.34.1
>>


