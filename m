Return-Path: <linux-pci+bounces-18867-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C8D9F8E0A
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 09:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E66518968C8
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 08:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A6713B58C;
	Fri, 20 Dec 2024 08:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N8UEOfBd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4529F19F11F
	for <linux-pci@vger.kernel.org>; Fri, 20 Dec 2024 08:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734683843; cv=none; b=j2G8Q6PfQuqmwuujqY+M9msgETA/vSDadxvvTGASpKTWkVUe5ei0rrXBH6+z6eAZ71lyUdaiQ2KNDj6dLBvnPKpTpQ49REoIiUd4JRzY1yjW+9ybEZNXUZXGcwq8pAsVep2z1o9HKXqAihvGStlFGZxCFjRgOp9I2iCk9yoYgrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734683843; c=relaxed/simple;
	bh=ftCOy6rBlbR19qyi83VAykTq2PpfGu3pQ08nFyHwmCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eysRwaipvg7sgkrpTsLDQ33IO9WTtEz52dylXC7k/FM2UNx35I5HzMLwuBUrrVkKvVnaCIBsHIJt6SP759vCTplqGkN1xLmuWH2p1QefziTGRcjlv2PFNHFe3qKijbpkv5qUpMA1UeVgqsyT+zqpVw+AVMIGowLmLbkBmuqN3ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N8UEOfBd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 453C8C4CECD;
	Fri, 20 Dec 2024 08:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734683842;
	bh=ftCOy6rBlbR19qyi83VAykTq2PpfGu3pQ08nFyHwmCk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=N8UEOfBdAwNnsQZdW5W8JFMu8JsS02iHjyYJ0l6hBXm3yHWsMwOBoIFrDIGjrhyaO
	 BFoL/uJmB1yQfHz6j5GEYUCHLsqTjsR0WFh3MpWZ9bFulQlSobh1M+NPF9DCHurpyy
	 FguqJPUkFKTNuJtW69G4o+E94nI754E6AHTy0kLz3NZ8/sC1pKZN3avr8cq+cg4FK5
	 ZatPN5c0Ypn2wEb5AuZlDjcO0LCJSmS9F4n4wjMTlZ8eex8whNlWHQMz2256xGve5G
	 nVRtvF+IkVruvhuinCyQrak7CiDe8vHlkgOU9yz4TVI7BF18JLWNHN7K30VdTMuIDm
	 MH+F8WXAgCN9w==
Message-ID: <5dd769dd-9ab8-4811-8394-24f1c8e17935@kernel.org>
Date: Fri, 20 Dec 2024 17:37:20 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 18/18] Documentation: Document the NVMe PCI endpoint
 target driver
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-pci@vger.kernel.org, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kw@linux.com>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Rick Wertenbroek <rick.wertenbroek@gmail.com>,
 Niklas Cassel <cassel@kernel.org>
References: <20241220035441.600193-1-dlemoal@kernel.org>
 <20241220035441.600193-19-dlemoal@kernel.org>
 <20241220081428.k45ydh2sl3m3vnhl@thinkpad>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20241220081428.k45ydh2sl3m3vnhl@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/20/24 17:14, Manivannan Sadhasivam wrote:
> On Fri, Dec 20, 2024 at 12:54:41PM +0900, Damien Le Moal wrote:
>> Add a documentation file
>> (Documentation/nvme/nvme-pci-endpoint-target.rst) for the new NVMe PCI
>> endpoint target driver. This provides an overview of the driver
>> requirements, capabilities and limitations. A user guide describing how
>> to setup a NVMe PCI endpoint device using this driver is also provided.
>>
>> This document is made accessible also from the PCI endpoint
>> documentation using a link. Furthermore, since the existing nvme
>> documentation was not accessible from the top documentation index, an
>> index file is added to Documentation/nvme and this index listed as
>> "NVMe Subsystem" in the "Storage interfaces" section of the subsystem
>> API index.
>>
>> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks.

> [...]
> 
>> +Configure the function using any device ID (the vendor ID for the device will
>> +be automatically set to the same value as the NVMe target subsystem vendor
>> +ID)::
>> +
>> +        # cd /sys/kernel/config/pci_ep/functions/nvmet_pci_epf
>> +        # echo 0xBEEF > nvmepf.0/deviceid
> 
> It'd be good to mention that the vendor id set with nvmet configfs will be
> reused here.

Please re-read the sentence above the commands. I added exactly that :)

-- 
Damien Le Moal
Western Digital Research

