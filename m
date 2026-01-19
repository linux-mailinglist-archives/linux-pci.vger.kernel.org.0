Return-Path: <linux-pci+bounces-45175-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B44D3A984
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 13:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CAAE53005E85
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 12:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B1A35C1B4;
	Mon, 19 Jan 2026 12:53:13 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A0A35A95D;
	Mon, 19 Jan 2026 12:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768827193; cv=none; b=tC/HyW7kgA0Mx/W/9ZxSfJStznI66ZtyZGIv1yU3CFKZbDq2Jps/uWW51qLcww6izDYp9SI03XfUnwAPBqa/lOWTY19XfUnJox/UwRUAgohGBbkbSjl4gMaxNAGcXr9u+EeE6102oF/76wFQjcA02Y7exBPpqqKquGWk1t2tJlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768827193; c=relaxed/simple;
	bh=cGzPxUmaEhFMDDElzlC+0Cv5UBY7+PeNviT+AavSgPM=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:Content-Type; b=XBy6lM7v3xJ0xJpMYMM6NT+KDEG/F1FpeD4+fdrhVa5dfM23+kr1PTCAWxp3PAlgZLnwM/cy9JH5Gak4z8+nxfsUK+7q19696Do4/8X7fBxmYdGzS9Tk/FhtRvarN5bRUqvOjee9bEh6AaZ7U9OlAouFB7VF7Lmp9xCJ91V6TlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=green-communications.fr; spf=pass smtp.mailfrom=green-communications.fr; arc=none smtp.client-ip=217.72.192.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=green-communications.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=green-communications.fr
Received: from [192.168.0.66] ([88.171.60.104]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1M3lLh-1vhXll1nPv-00BvaZ; Mon, 19 Jan 2026 13:53:02 +0100
Message-ID: <154d0ccb-00d8-4e7b-ab6e-c798c86c5e96@green-communications.fr>
Date: Mon, 19 Jan 2026 13:53:01 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, "Rob Herring (Arm)"
 <robh@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Jason Gunthorpe <jgg@nvidia.com>, regressions@lists.linux.dev
References: <a1d926f0-4cb5-4877-a4df-617902648d80@green-communications.fr>
 <eb94b379-6e0b-4beb-aaa7-413a4e7f04b9@green-communications.fr>
 <3780eb61-68e2-42ce-939e-7458cd3a63cb@green-communications.fr>
 <4da29d46-9a80-4ec4-b6b8-6c9457eed481@arm.com>
Content-Language: en-US
From: Nicolas Cavallari <Nicolas.Cavallari@green-communications.fr>
Autocrypt: addr=Nicolas.Cavallari@green-communications.fr; keydata=
 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
Subject: Re: [REGRESSION] Re: imx8 PCI regression since "iommu: Get DT/ACPI
 parsing into the proper probe path"
In-Reply-To: <4da29d46-9a80-4ec4-b6b8-6c9457eed481@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:qvKrgniDhCDttoq4hx/KpwZ7wvT16Hg+QjDEhqguqFoZvTWbYYU
 TAdm6qt5OYVkrkzIV5BNU900bXM0nA2ibuHysJmVsMFcS3Dg0a4BXevHAaml5stE7+brjh3
 G4BzfnZqu694rkvzCdqJNoOeJi8QMlhuL9ygtzBVxeOTgA/J20A8OqLub9ESDr49En8OwaK
 +/xqqWg7onaVG+Ll/CRpQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:EzNrFn9xkI4=;8DWpBIhuMNpzgSwAxfQ7dLLhNe9
 rJznxzuVIOeaoZU+8zdc6bMAZaWOX191m6YuvJF5zlTkEmbgVD76qPgO2Y1+coVr+LuwZ7JnS
 vWk0I9WuOlH+m1ytpblAoqYRY96llCe8Pzci9ZO5u1kt1mBzaXWEMUW+eHPPHvvm4cSRd/JXv
 ah4YpGGGRpYevF3UGKuYeVBPCSL1qwF0iA4n3tRK+B9nx2MHdGv06+qTWpErTQCTYvQy7yok4
 gdkp/Ee6x25tSvq77PZnH2qECgCo1ZJK7lkeJgCwmtlREFQ0Bnhu8jnkseS6K2SXEinx1v2hf
 SmZRjmJZQ058ec6scJu2PqT2n3HQq77r41V4DfU+krCzqwEVajaS8roagNgmgcDA1MrzI/bG2
 UQBgtjxbXPlRYbTf+s4QCcPDfXBSn9NN2gQZLM5L6Uq00VcdMD7ddzpLKIenPuWkA7gIJ6K/x
 agvLGJ8nCORN15CgDuHgfbh/y2il346tDwqB5nvxV/R1SfZX4JUBBGLCpkmrhYY9rGdNLYAQG
 roa/daAv/oxjZ4Tvek6wb/Mz7MwDrjQG93OxqqtaTdKGjnTK5ySOEVf+igyeCP9fpfA+AK7oa
 sSYgMYB0tYEGZVwMXI+NqxaamqdrtpyjpWHHDYF1wfZ/H6qWkIDmYqmIAMeeYZMsmjFeODxtz
 VGJmFV9wwn75kCh+EbzZ3Fz19QtoKTBD8ozTOUfoYVJkXdwYV9rbTdRTCg4EImIUH4c/KDrhT
 S7wllpqjgmIWJMkRlIKRwhwMghd8Us8Cyibhid1SnTJwVxh8RGhy/xzqhCpqObd+1TALqC4t/
 RvHHBbe2TMKQvDM5YKb7idT9v9u4NxABJnzrj2ergxqCnhy+QqsE6yXaEiKA56jbJ+oC7dkcz
 IESEsG8o1x/twrNAYL1vWJ92u/xPAlfjPn6nb3zFeT2U7ohRnZ6ggzFl6ckw+1mX8lDJXgl2Y
 F4xyRlSgc6Obeo3vXuF7K+lIfkiWOXILcOQIBec7VzgRmdLKxJ73BdNuG0FMpQ7oD+8Nq3krC
 +1hR2NDLjxYnvTotm0+fW9PPWIud2zy5I7DT8YImSXU1wK2vFBfj6x9WZXb/2PshORP4fECPi
 WodrPNUNlqFRPVKI6F50ZHUHZUqJpZpNyBKOG+BEKybe6TH9x/nMy3YSl/HvLf0lb2CqHb8tY
 KunLjb+t/RYsMZTzWCxqTwKbqyb9L4mm+S3sPyztpRu3Y5wkBOnO8AGJkA1WsSFZcAVwIcWZG
 JkVlZW3t5a3LBU6y0p8aSU0V723JuuewIFxWJ+nfdsOU2yeKlyIg4PVeeWgzmez+OVMI9k81I
 dymPt+Cbi4LKFwE2rNpcP/m39WetK5OxfAjAb42vnG6ZGZlVmdm7Z/4sHpXBtXyThpm99aTzX
 Ett3mzhWu6Wf3B61dj08mRdMuNJWlC9VxeGO1cIOChKqEGGKkhGiaAzUaaIgDakSURwIURcFF
 ePlfCCSyvVNrywAEcPG8i9zJ7glah4NRtSXEswqJqfieME0kgE4k2qhwRXI+4wnWlWjfqDVPq
 XRbp+KH4wfyRdQCXXJeh7i11vrZWRNfa8a3E+gH0Xj/jRe9D8d80h5OXHpzKXGUuPPPQoZI/a
 njzlisWadfTYQDLM6Z4xZhCXxsouGvGNld9dXQji/2C1NWCpSLmAnXP1vj2E9rGGoJ41GXA/8
 o0d+fXB7Lzn7lioyi0zaeWREgrmHOHgWsxvOc7WkP+8yrij30gT8zTp8TZp5B6SSVBTbnVLTR
 3A+45Nf6RjQgu1oaPsoP/Dd9+Ao7WG9EY07XFd4J9JRPvzEsXsUgCqQqy7X5jiodVkYqg1mqB
 Sjcp

Le 16/01/2026 à 18:24, Robin Murphy a écrit :
> On 2026-01-16 4:52 pm, Nicolas Cavallari wrote:
>> +cc regressions ML
>>
>> Le 13/01/2026 à 10:17, Nicolas Cavallari a écrit :
>>> +cc patch author & reviewers
>>>
>>> On 1/9/26 17:22, Nicolas Cavallari wrote:
>>>> When upgrading from 6.12 to a 6.18 kernel, I noticed that a PCI
>>>> Ethernet adapter (Microchip LAN7430) would hang under load and not
>>>> recover.  When that happens, some of its registers indicate it is
>>>> failing to do DMA reads, so cannot reclaim entries on its ring buffer.
>>>>
>>>> I bisected the problem into this commit:
>>>>
>>>> commit bcb81ac6ae3c2ef95b44e7b54c3c9522364a245c
>>>> Author: Robin Murphy <robin.murphy@arm.com>
>>>> Date:   Fri Feb 28 15:46:33 2025 +0000
>>>>
>>>>        iommu: Get DT/ACPI parsing into the proper probe path
>>>>
>>>> The problem still exists on 6.19-rc1, on pci/next (29a77b4897f1) and on
>>>> iommu/master (360e85353769) trees.  Reverting the commit fixes the
>>>> issue.
>>
>> The problem persists on 6.19-rc5
>>
>>>> The system is a Gateworks GW7200, which is a i.MX 8 Mini connected to a
>>>> Pericom
>>>> PI7C9X2G404 4-port switch connected to the LAN7430 chip.
>>>>
>>>> -[0000:00]---00.0-[01-ff]----00.0-[02-05]--+-01.0-[03]----00.0
>>>>                                               +-02.0-[04]--
>>>>                                               \-03.0-[05]----00.0
>>>>
>>>> The problem only occurs when there is at least another PCI device in use
>>>> on the
>>>> switch.  It does not happen if the LAN7430 is the only PCI device, or if
>>>> the
>>>> other devices are not actively used.  For example i can reproduce it
>>>> with an
>>>> ath9k wireless network adapter when it is up and running, but not when
>>>> it is
>>>> down or its driver is not loaded.
>>>>
>>>> I suspect that other PCI devices have similar issues, but the LAN7430 is
>>>> the
>>>> easiest one to diagnose, as it hangs within seconds with an iperf3 --
>>>> bidir -u
>>>> -b 200M and its register map are public.
>>>>
>>>> I couldn't find an way to dump the PCI address translation mapping from
>>>> userspace.
>>>> I would be happy to provide more information or test patches.
>>
>> I debugged it further, it seems to be mostly a PCI issue since the
>> system does not actually have an IOMMU.
> 
> Indeed, I was figuring this had to be another case of a switch with
> wonky ACS - do Mani's patches adjusting ACS enablement make any difference?
> 
> https://lore.kernel.org/all/20260102-pci_acs-v3-1-72280b94d288@oss.qualcomm.com/

With this series, ACS is still enabled and eth1 is still failing under load.

> Although in this case I guess the issue is arguably more that we're
> requesting ACS at all, before we know that there's actually an IOMMU
> present to warrant it. Clearly the best option would be to figure out if
> the switch behaviour itself can be fixed somehow, but perhaps something
> like this might help paper over the issue for now (but I'd have to test
> it to make sure it doesn't break IOMMUs again...)
> 
> ----->8-----
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index 6b989a62def2..837cc0b5ace4 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -141,10 +141,12 @@ int of_iommu_configure(struct device *dev, struct
> device_node *master_np,
>    			.np = master_np,
>    		};
> 
> -		pci_request_acs();
>    		err = pci_for_each_dma_alias(to_pci_dev(dev),
>    					     of_pci_iommu_init, &info);
> -		of_pci_check_device_ats(dev, master_np);
> +		if (!err) {
> +			pci_request_acs();
> +			of_pci_check_device_ats(dev, master_np);
> +		}
>    	} else {
>    		err = of_iommu_configure_device(master_np, dev, id);
>    	}
> -----8<-----

With this, ACS is indeed disabled and eth1 no longer fails under load, but I 
have also identified an errata on the PCIe switch that causes ACS to fail. I've 
sent another message in this thread.

