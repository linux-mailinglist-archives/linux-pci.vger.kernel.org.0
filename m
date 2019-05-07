Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3B7E161BF
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2019 12:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbfEGKMC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 May 2019 06:12:02 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:19486 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbfEGKMC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 May 2019 06:12:02 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cd159ed0000>; Tue, 07 May 2019 03:11:57 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 07 May 2019 03:12:01 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 07 May 2019 03:12:01 -0700
Received: from [10.25.73.250] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 7 May
 2019 10:11:54 +0000
Subject: Re: [PATCH V5 13/16] arm64: tegra: Enable PCIe slots in P2972-0000
 board
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
 <20190424052004.6270-14-vidyas@nvidia.com> <20190503112751.GG32400@ulmo>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <ed191c29-a10e-e420-2bc0-55cefdecf6ee@nvidia.com>
Date:   Tue, 7 May 2019 15:41:51 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190503112751.GG32400@ulmo>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1557223917; bh=vq50Jt+k6FTdyIXHkyAqZgXq1yOp1zXcB8xjDiE9XEU=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=gjV+r7YKL4OGCshwVRXkMzkPIrMJxasj/gy8YXmNPclvZ9VRpSBWAycpFPiNrUAGX
         zL4WVEsuRQnqAWk30Yphy56oZT1zr01UTeIWM+xguz7yj70LDTxWliL5xdt/058Hnh
         GWZa3YaMfzuSBX2iLSJRgD1nzdGoCnMUnRZHEfa1kpRKdBTLX16RCYAKDJDd1fJsB8
         nVeHRaUjtHpuArdRcc8qIeL8Xzd4mKK1ZxnDdUyW9gh4stdgIDT/NZqmGXBUNyh88H
         5MC9oHyIe4xXUrJ4rVhdoON+QbkhB4DNDfcgxcp/A74Bach3EZzZfK8uBf4Wx6L2Xi
         fk5yiIzFpTJrA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 5/3/2019 4:57 PM, Thierry Reding wrote:
> On Wed, Apr 24, 2019 at 10:50:01AM +0530, Vidya Sagar wrote:
>> Enable PCIe controller nodes to enable respective PCIe slots on
>> P2972-0000 board. Following is the ownership of slots by different
>> PCIe controllers.
>> Controller-0 : M.2 Key-M slot
>> Controller-1 : On-board Marvell eSATA controller
>> Controller-3 : M.2 Key-E slot
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
>> * Changed P2U label names to reflect new format that includes 'hsio'/'nvhs'
>>    strings to reflect UPHY brick they belong to
>>
>> Changes since [v1]:
>> * Dropped 'pcie-' from phy-names property strings
>>
>>   .../arm64/boot/dts/nvidia/tegra194-p2888.dtsi |  2 +-
>>   .../boot/dts/nvidia/tegra194-p2972-0000.dts   | 41 +++++++++++++++++++
>>   2 files changed, 42 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi b/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
>> index 0fd5bd29fbf9..30a83d4c5b69 100644
>> --- a/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
>> +++ b/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
>> @@ -191,7 +191,7 @@
>>   						regulator-boot-on;
>>   					};
>>   
>> -					sd3 {
>> +					vdd_1v8ao: sd3 {
>>   						regulator-name = "VDD_1V8AO";
>>   						regulator-min-microvolt = <1800000>;
>>   						regulator-max-microvolt = <1800000>;
>> diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts b/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
>> index b62e96945846..7411c64e24a6 100644
>> --- a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
>> +++ b/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
>> @@ -169,4 +169,45 @@
>>   			};
>>   		};
>>   	};
>> +
>> +	pcie@14180000 {
> [...]
>> +	pcie@14100000 {
> [...]
> 
> Again, these should be sorted by unit-address.
Done.

> 
> Thierry
> 

