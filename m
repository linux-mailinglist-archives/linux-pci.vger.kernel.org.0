Return-Path: <linux-pci+bounces-25688-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 119B0A865EE
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 21:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F58B8C6D17
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 19:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5EA270EBE;
	Fri, 11 Apr 2025 19:11:53 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E97202C50;
	Fri, 11 Apr 2025 19:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744398713; cv=none; b=G+HHIcnBE+1KDrrwyN5tCrz1GttPgS/a9NGwqgcVzQQFPvBeoB4+1FUwqHLNOkyA3V5QQYvSjTfvT4xXYf5YP2Nr2Mk2/NgVdPkXvc9Gl5Njq3icsjmwTWHOSAiHS5ptNhRXK8mqCYJm6Fs8gdcPbzt2VmZwznBzXqHIczU1tds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744398713; c=relaxed/simple;
	bh=BO1ibUlep/whjAnhTU7bWrZmrU4wsai7V2ZchfCcIUE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=jRroiuyzpml6GxXCzyXL0HRdKqtQDiyDIXYX5XUXMt1UQ3tkH/Tpj8WyG626gC5a2SYZRSmH5GPgOT829AQZSCgS+uFQ6UElONMeC0rRgIoB1KArg3RQkmIuzQmJhMuh2tWb0wJpOIpIHnRNnGvj1sDkYxw8B3mjMb7RlpFX374=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8BCF6106F;
	Fri, 11 Apr 2025 12:11:49 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2A5DB3F59E;
	Fri, 11 Apr 2025 12:11:48 -0700 (PDT)
Message-ID: <03e6283e-2ef7-498c-9460-8411114711e2@arm.com>
Date: Fri, 11 Apr 2025 20:11:46 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: arm64: juno-r2: SSD detect failed on mainline and next
From: Robin Murphy <robin.murphy@arm.com>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>, iommu@lists.linux.dev,
 open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
 Linux Regressions <regressions@lists.linux.dev>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
 Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 Anders Roxell <anders.roxell@linaro.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <CA+G9fYt0F_vR-zOV4P8m4HTv6AecT-eEnrL+t5wgAaKPodi0mQ@mail.gmail.com>
 <6e0ef5cc-b692-4d39-bec4-a75c1af3f0aa@arm.com>
 <CA+G9fYs_nUN2x8fFJ0cfudHWbCOLSJK=OhEK0Efd1ifcjq_LRg@mail.gmail.com>
 <5a277d1d-c7b1-430c-a463-1e307a2823f6@arm.com>
Content-Language: en-GB
In-Reply-To: <5a277d1d-c7b1-430c-a463-1e307a2823f6@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/04/2025 4:36 pm, Robin Murphy wrote:
> On 09/04/2025 4:56 pm, Naresh Kamboju wrote:
>> On Wed, 2 Apr 2025 at 21:04, Robin Murphy <robin.murphy@arm.com> wrote:
>>>
>>> On 31/03/2025 5:03 am, Naresh Kamboju wrote:
>>>> Regressions on arm64 Juno-r2 devices detect SSD tests failed on the
>>>> Linux next and Linux mainline.
>>>>
>>>> First seen on the v6.14-7245-g5c2a430e8599
>>>>    Good: v6.14
>>>>    Bad: v6.14-7422-gacb4f33713b9
>>>
>>> Sorry, I can't seem to reproduce this on my end, both today's mainline
>>> and acb4f33713b9 with my config, and even acb4f33713b9 with the linked
>>> LKFT config, all work OK on my Juno r2 (using a SATA SSD and PCIe
>>> networking). The only thing which stands out in your log is that PCI
>>> seems to give up probing and assigning resources beyond the switch
>>> downstream ports (so SATA and ethernet are never discovered), whereas on
>>> mine it does[2]. However that all happens before the first IOMMU
>>> instance probes (which conveniently is the PCIe one), so it's hard to
>>> imagine how that could have an effect anyway...
>>>
>>> The only obvious difference is that I'm using EDK2 rather than U-Boot,
>>> so that's done all the PCIe configuration once already, but it doesn't
>>> seem like that's significant - looking back at a random older log[1],
>>> the on-board endpoints were still being picked up right after
>>> reconfiguring the switch, well before the IOMMU comes into the picture.
>>>
>>
>> Since it is a still issue on mainline and next,
>>
>> Bisected and reverted patch ^ causing kernel warnings at boot time
>> but finding the SSD drive,
>>
>>    [bcb81ac6ae3c2ef95b44e7b54c3c9522364a245c]
>>    iommu: Get DT/ACPI parsing into the proper probe path
>>
>> pcieport 0000:00:00.0: late IOMMU probe at driver bind, something 
>> fishy here!
>> WARNING: at drivers/iommu/iommu.c:559 __iommu_probe_device
>>
>> I see boot warnings [1]
>> I am happy to test debug patches if you have any.
> 
> Seeing the warning after reverting the commit which introduced the 
> warning mostly just means the conflict resolution in the revert wasn't 
> right (there were some subsequent fixups...)
> 
> Anyway, I have now managed to get my Juno booting with the same antique 
> version of U-Boot and finally reproduce the issue. It seems to be 
> somehow connected to bus->dma_configure() being called in the 
> device_add() notifier (even though the rest of the IOMMU setup doesn't 
> run at that point since the driver hasn't registered yet), but how and 
> why that prevents the buses behind the switch downstream ports being 
> probed, and why *that* only happens when the switch isn't already 
> configured, remains a mystery so far. I'm still digging...

OK, I found it, but I'm still not sure what exactly to make of it - it's 
the pci_request_acs() in of_iommu_configure(), now being called early 
enough to actually have an effect. Booting with EDK2 already using PCI 
prior to Linux, here's what I get for `sudo lspci -vv | grep ACSctl` 
with 6.15-rc1:

		ACSCtl:	SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ 
EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ 
EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ 
EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ 
EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ 
EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ 
EgressCtrl- DirectTrans-

whereas with the 6.14 behaviour they are all '-'. I don't have a working 
root filesystem with the U-Boot setup, but if I boot it with 
"pci=config_acs=000000@pci:0:0" then the kernel does assign the bridge 
windows and discover the ethernet/SATA endpoints again. I can spend some 
time getting NFS working next week, but if you're able to get lspci 
output off a machine in the "broken" state easily that would be handy to 
compare.

So at this point it would seem to be something about how Linux 
configures ACS when doing it from scratch. What I don't really know is 
where to go from there. I do know Juno's possibly a bit odd in that the 
switch supports ACS, but both the root port and endpoints either side of 
it don't. Could this be tickling some subtle bug in the PCI layer, and 
what is EDK2 doing that makes it not happen?

Thanks,
Robin.

