Return-Path: <linux-pci+bounces-45072-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F95D37A63
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 18:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8828D30D5CA0
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 17:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21633939BE;
	Fri, 16 Jan 2026 17:35:40 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B63233B96A;
	Fri, 16 Jan 2026 17:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768584940; cv=none; b=QXPHJUPrA+pLuM1/qHDR7nON1AHSHBvxJpSAWaq9b1RM5TYHPmshIO9Y3p7dfc/x4A516G0taCAW4JG1/xR/NRcylnwUAn1ZHLekwCU8ZT6JLoH4eXITAFv79K+muBBHJgkRSGo9B4q+cRtpRUnkizoEuAkXZWVNntteyzAe7s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768584940; c=relaxed/simple;
	bh=eRYEce1Bqi1IMbyX0gjKe256Q/w/UQgKFjS+32AVKLc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KEKJApgwAhKOnI6JqOmA2xBARfTIdYjOlt9klBUWbgx5okf25wDT4GmEiC/2WBJBGdAQzXaRqx0JIqwP60meu6oOLGjAOiqcZWNA+vZtlkoUNHWpBb1IF5+pvT9K4h/JcOsADMfQ17QDC0OWjOYrOXP5tSsmfnWHAkIh9Jr7qRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D64011516;
	Fri, 16 Jan 2026 09:35:31 -0800 (PST)
Received: from [10.57.49.133] (unknown [10.57.49.133])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BCB053F59E;
	Fri, 16 Jan 2026 09:35:36 -0800 (PST)
Message-ID: <d3f008bf-a9cb-43a8-807b-2ba1d6d9ff3c@arm.com>
Date: Fri, 16 Jan 2026 17:35:34 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Re: imx8 PCI regression since "iommu: Get DT/ACPI
 parsing into the proper probe path"
To: Jason Gunthorpe <jgg@nvidia.com>,
 Nicolas Cavallari <Nicolas.Cavallari@green-communications.fr>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, "Rob Herring (Arm)" <robh@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Joerg Roedel <jroedel@suse.de>,
 regressions@lists.linux.dev
References: <a1d926f0-4cb5-4877-a4df-617902648d80@green-communications.fr>
 <eb94b379-6e0b-4beb-aaa7-413a4e7f04b9@green-communications.fr>
 <3780eb61-68e2-42ce-939e-7458cd3a63cb@green-communications.fr>
 <20260116171048.GP961588@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260116171048.GP961588@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-01-16 5:10 pm, Jason Gunthorpe wrote:
> On Fri, Jan 16, 2026 at 05:52:36PM +0100, Nicolas Cavallari wrote:
>> I debugged it further, it seems to be mostly a PCI issue since the system
>> does not actually have an IOMMU.
>>
>> When examining changes in the PCI configuration (lspci -vvvv), the main
>> difference is that, with the patch, Access Control Services are enabled on
>> the PCI switch.
>>
>>          Capabilities: [220 v1] Access Control Services
>>                  ACSCap: SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+
>> UpstreamFwd+ EgressCtrl+ DirectTrans+
>> -               ACSCtl: SrcValid- TransBlk- ReqRedir- CmpltRedir-
>> UpstreamFwd- EgressCtrl- DirectTrans-
>> +               ACSCtl: SrcValid+ TransBlk- ReqRedir+ CmpltRedir+
>> UpstreamFwd+ EgressCtrl- DirectTrans-
>>
>> If I manually patch the config space in sysfs and re-disable ACS on the port
>> connected to the LAN7430, I cannot reproduce the problem.  In fact,
>> disabling only ReqRedir is enough to work around the issue.
> 
> My guess would be your system has some kind of address alias going on?
> 
> Assuming you are not facing an errata, ACS generally changes the
> routing of TLPs so if you have a DMA address that could go to two
> different places then messing with ACS will give you different
> behaviors.
> 
> In specific when you turn all those ACS settings you cannot do P2P
> traffic anymore. If your system expects this for some reason then you
> must use the kernel command line option to disable acs.
> 
> If you are just doing normal netdev stuff then it is doubtful that you
> are doing P2P at all, so I might guess a bug in the microchip ethernet
> driver doing a wild DMA? Stricter ACS settings cause it to AER and the
> device cannot recover?
> 
> It will be hard to get the bottom of the defect without a PCI trace
> 
> I don't know why your bisection landed on bcb8 - the intention was
> that pci_enable_acs() is always called, and I didn't notice an obvious
> reason why that wouldn't happen prior to bcb8.. It is called directly
> from pci_device_add() Maybe investigating that angle would be
> informative..

The difference is that bcb8 moves the pci_request_acs() call on OF 
systems back early enough to actually have an effect - that's spent the 
last 6 years being pretty much a no-op since 6bf6c24720d3 ("iommu/of: 
Request ACS from the PCI core when configuring IOMMU linkage")...

Thanks,
Robin.

>> I also read up on AER and I'm surprised that I don't see anything in dmesg
>> when the problem occurs, even through UERcvd+ start appearing on the root
>> context and AdvNonFatalErr+ appears on the switch.
> 
> Though UE and AdvNonFatalErr sure are weird indications for an
> addressing error.. Is there some kind of special embedded system thing
> going on? Vendor messages over PCI perhaps?
> 
> Jason


