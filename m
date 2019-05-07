Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7BA2161B4
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2019 12:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbfEGKK2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 May 2019 06:10:28 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:14359 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbfEGKK2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 May 2019 06:10:28 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cd159700000>; Tue, 07 May 2019 03:09:53 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 07 May 2019 03:10:27 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 07 May 2019 03:10:27 -0700
Received: from [10.25.73.250] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 7 May
 2019 10:10:22 +0000
Subject: Re: [PATCH V5 12/16] arm64: tegra: Add P2U and PCIe controller nodes
 to Tegra194 DT
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <kishon@ti.com>, <catalin.marinas@arm.com>,
        <will.deacon@arm.com>, <jingoohan1@gmail.com>,
        <gustavo.pimentel@synopsys.com>, <mperttunen@nvidia.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20190424052004.6270-1-vidyas@nvidia.com>
 <20190424052004.6270-13-vidyas@nvidia.com> <20190503112637.GF32400@ulmo>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <d2c6dedd-05ed-d8f8-4e3a-e782e5d3806e@nvidia.com>
Date:   Tue, 7 May 2019 15:40:19 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190503112637.GF32400@ulmo>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1557223793; bh=I7FKGwlXUUIi3Ic8/bqewqRmtRJND8Hs1jm4hHNZSVM=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=ZPB44Zla0Hj6jvONalz/wZSPhhaBAYtPa8kjQQSqVqWBU2SmihsmZB9V6xdg+Yx8N
         lVEuLvk02RTLft8E7zc6OVbyun28y0wxzIyYLmAaDTcb0L9ZDEVDrGyoU5/RF59PeG
         Twz5ho4omO9hHiyOSIbgh7eYKlb+esqBrkfFIOUEnwCNF0DPYJETBbi2O/dGWy+cTv
         nP0kIWKfkt+ZDtGFIwR3gOb5MZkaKUIOSNfTHkyBQzK1j5BfZrsqJr5WV1HAnlUJST
         7l6HFXPHBbCAcc3HuZtDkucg8jOLtPZegeZ5W9BN1xMo0q4ZZORFe3LV1l19u0Uf7+
         9CDFsL/MbZ0tw==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 5/3/2019 4:56 PM, Thierry Reding wrote:
> On Wed, Apr 24, 2019 at 10:50:00AM +0530, Vidya Sagar wrote:
>> Add P2U (PIPE to UPHY) and PCIe controller nodes to device tree.
>> The Tegra194 SoC contains six PCIe controllers and twenty P2U instances
>> grouped into two different PHY bricks namely High-Speed IO (HSIO-12 P2Us)
>> and NVIDIA High Speed (NVHS-8 P2Us) respectively.
>>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> ---
>> Changes since [v4]:
>> * None
>>
>> Changes since [v3]:
>> * None
>>
>> Changes since [v2]:
>> * Included 'hsio' or 'nvhs' in P2U node's label names to reflect which brick
>>    they belong to
>> * Removed leading zeros in unit address
>>
>> Changes since [v1]:
>> * Flattened all P2U nodes by removing 'hsio-p2u' and 'nvhs-p2u' super nodes
>> * Changed P2U nodes compatible string from 'nvidia,tegra194-phy-p2u' to 'nvidia,tegra194-p2u'
>> * Changed reg-name from 'base' to 'ctl'
>> * Updated all PCIe nodes according to the changes made to DT documentation file
>>
>>   arch/arm64/boot/dts/nvidia/tegra194.dtsi | 449 +++++++++++++++++++++++
>>   1 file changed, 449 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
>> index c77ca211fa8f..dc433b446ff5 100644
>> --- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
>> +++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> [...]
>> +	pcie@14180000 {
> [...]
>> +		ranges = <0x81000000 0x0 0x38100000 0x0 0x38100000 0x0 0x00100000    /* downstream I/O (1MB) */
>> +			  0xc2000000 0x18 0x00000000 0x18 0x00000000 0x3 0x40000000  /* prefetchable memory (13GB) */
>> +			  0x82000000 0x0 0x40000000 0x1B 0x40000000 0x0 0xC0000000>; /* non-prefetchable memory (3GB) */
> 
> Please be consistent in the capitalization of hexadecimal numbers. You
> use lowercase hexdigits in one place and upprecase in others. Just stick
> to one (preferably lowercase since that's already used elsewhere in this
> file).
Ok.

> 
>> +	};
>> +
>> +	pcie@14100000 {
> 
> Also, entries should be sorted by unit-address, so controller 0 above
> needs to go further down.
Ok.

> 
> Thierry
> 

