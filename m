Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4F081D7B07
	for <lists+linux-pci@lfdr.de>; Mon, 18 May 2020 16:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbgEROWe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 May 2020 10:22:34 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:5334 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbgEROWe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 May 2020 10:22:34 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ec2999c0001>; Mon, 18 May 2020 07:20:12 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 18 May 2020 07:22:34 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 18 May 2020 07:22:34 -0700
Received: from [10.25.73.9] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 18 May
 2020 14:22:30 +0000
Subject: Re: [PATCH V2] arm64: tegra: Fix flag for 64-bit resources in
 'ranges' property
To:     <robh+dt@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <amurray@thegoodpenguin.co.uk>, <bhelgaas@google.com>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>
References: <20200513191627.8533-1-vidyas@nvidia.com>
 <20200514135437.29814-1-vidyas@nvidia.com>
 <20200518135006.GB31554@e121166-lin.cambridge.arm.com>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <e64ccace-d2b9-0e03-db3f-e65ed6f56230@nvidia.com>
Date:   Mon, 18 May 2020 19:52:24 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200518135006.GB31554@e121166-lin.cambridge.arm.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1589811612; bh=ygS6whssLxUlGMHQFNVShdRPY01pxJPdCk+7KRT+K0o=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Z8q4xTJrqbT3TqukcpA2boW25MUibTcyZk2LOr4lUfXriS67bB4pwTPESL9FzrzoH
         CBq3WfjCqgHNVhdgSy98zJInR9G72eOFGdCyesIGYd7Gxrel/XJL4YoDKBOTOri/AX
         8jmi6Ji88tiLsr3XQy72WCwEsgkcLVmvgJNViG6w71xqOSfEj4b/mlHNCteD4jd1et
         4rNTIsvA0b5QKkpJrz+NSvbKrx7y2YeEDNM7fMzYuCWoiQJnRopAd2284lIPCe8ajU
         dm4nndJFKPtCPixdtaGobNjzyviitrQbytJxzPELLLtE6ejE8EhWhulmuUGAI6q3Yo
         AojcaxMOI5zEA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thanks Lorenzo.
I've moved linux-pci to BCC and included
devicetree and linux-tegra mailing lists to CC.

Rob, Could you please review this patch?

Thanks,
Vidya Sagar

On 18-May-20 7:20 PM, Lorenzo Pieralisi wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Thu, May 14, 2020 at 07:24:37PM +0530, Vidya Sagar wrote:
>> Fix flag in PCIe controllers device-tree nodes 'ranges' property to correctly
>> represent 64-bit resources.
>>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> ---
>> V2:
>> * Extended the change to cover other controllers as well
>>
>>   arch/arm64/boot/dts/nvidia/tegra194.dtsi | 12 ++++++------
>>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> We don't apply DTS patches - so no need to CC linux-pci from now
> onwards on these. Marked as not-applicable.
> 
> Lorenzo
> 
>> diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
>> index e1ae01c2d039..4bc187a4eacd 100644
>> --- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
>> +++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
>> @@ -1405,7 +1405,7 @@
>>
>>                bus-range = <0x0 0xff>;
>>                ranges = <0x81000000 0x0  0x30100000 0x0  0x30100000 0x0 0x00100000   /* downstream I/O (1MB) */
>> -                       0xc2000000 0x12 0x00000000 0x12 0x00000000 0x0 0x30000000   /* prefetchable memory (768MB) */
>> +                       0xc3000000 0x12 0x00000000 0x12 0x00000000 0x0 0x30000000   /* prefetchable memory (768MB) */
>>                          0x82000000 0x0  0x40000000 0x12 0x30000000 0x0 0x10000000>; /* non-prefetchable memory (256MB) */
>>        };
>>
>> @@ -1450,7 +1450,7 @@
>>
>>                bus-range = <0x0 0xff>;
>>                ranges = <0x81000000 0x0  0x32100000 0x0  0x32100000 0x0 0x00100000   /* downstream I/O (1MB) */
>> -                       0xc2000000 0x12 0x40000000 0x12 0x40000000 0x0 0x30000000   /* prefetchable memory (768MB) */
>> +                       0xc3000000 0x12 0x40000000 0x12 0x40000000 0x0 0x30000000   /* prefetchable memory (768MB) */
>>                          0x82000000 0x0  0x40000000 0x12 0x70000000 0x0 0x10000000>; /* non-prefetchable memory (256MB) */
>>        };
>>
>> @@ -1495,7 +1495,7 @@
>>
>>                bus-range = <0x0 0xff>;
>>                ranges = <0x81000000 0x0  0x34100000 0x0  0x34100000 0x0 0x00100000   /* downstream I/O (1MB) */
>> -                       0xc2000000 0x12 0x80000000 0x12 0x80000000 0x0 0x30000000   /* prefetchable memory (768MB) */
>> +                       0xc3000000 0x12 0x80000000 0x12 0x80000000 0x0 0x30000000   /* prefetchable memory (768MB) */
>>                          0x82000000 0x0  0x40000000 0x12 0xb0000000 0x0 0x10000000>; /* non-prefetchable memory (256MB) */
>>        };
>>
>> @@ -1540,7 +1540,7 @@
>>
>>                bus-range = <0x0 0xff>;
>>                ranges = <0x81000000 0x0  0x36100000 0x0  0x36100000 0x0 0x00100000   /* downstream I/O (1MB) */
>> -                       0xc2000000 0x14 0x00000000 0x14 0x00000000 0x3 0x40000000   /* prefetchable memory (13GB) */
>> +                       0xc3000000 0x14 0x00000000 0x14 0x00000000 0x3 0x40000000   /* prefetchable memory (13GB) */
>>                          0x82000000 0x0  0x40000000 0x17 0x40000000 0x0 0xc0000000>; /* non-prefetchable memory (3GB) */
>>        };
>>
>> @@ -1585,7 +1585,7 @@
>>
>>                bus-range = <0x0 0xff>;
>>                ranges = <0x81000000 0x0  0x38100000 0x0  0x38100000 0x0 0x00100000   /* downstream I/O (1MB) */
>> -                       0xc2000000 0x18 0x00000000 0x18 0x00000000 0x3 0x40000000   /* prefetchable memory (13GB) */
>> +                       0xc3000000 0x18 0x00000000 0x18 0x00000000 0x3 0x40000000   /* prefetchable memory (13GB) */
>>                          0x82000000 0x0  0x40000000 0x1b 0x40000000 0x0 0xc0000000>; /* non-prefetchable memory (3GB) */
>>        };
>>
>> @@ -1634,7 +1634,7 @@
>>
>>                bus-range = <0x0 0xff>;
>>                ranges = <0x81000000 0x0  0x3a100000 0x0  0x3a100000 0x0 0x00100000   /* downstream I/O (1MB) */
>> -                       0xc2000000 0x1c 0x00000000 0x1c 0x00000000 0x3 0x40000000   /* prefetchable memory (13GB) */
>> +                       0xc3000000 0x1c 0x00000000 0x1c 0x00000000 0x3 0x40000000   /* prefetchable memory (13GB) */
>>                          0x82000000 0x0  0x40000000 0x1f 0x40000000 0x0 0xc0000000>; /* non-prefetchable memory (3GB) */
>>        };
>>
>> --
>> 2.17.1
>>
