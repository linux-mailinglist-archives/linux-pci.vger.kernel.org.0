Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D779A1088CB
	for <lists+linux-pci@lfdr.de>; Mon, 25 Nov 2019 07:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725828AbfKYGzT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Nov 2019 01:55:19 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:6863 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbfKYGzT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Nov 2019 01:55:19 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ddb7ad90000>; Sun, 24 Nov 2019 22:55:22 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 24 Nov 2019 22:55:18 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 24 Nov 2019 22:55:18 -0800
Received: from [10.25.75.126] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 25 Nov
 2019 06:55:14 +0000
Subject: Re: [PATCH 5/6] arm64: tegra: Enable GPIO controllers nodes for
 P2972-0000 platform
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <jonathanh@nvidia.com>,
        <andrew.murray@arm.com>, <kishon@ti.com>,
        <gustavo.pimentel@synopsys.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20191122104505.8986-1-vidyas@nvidia.com>
 <20191122104505.8986-6-vidyas@nvidia.com> <20191122132007.GC1315704@ulmo>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <4a09729b-9a77-65a1-645a-a31e6e62ad1e@nvidia.com>
Date:   Mon, 25 Nov 2019 12:25:11 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191122132007.GC1315704@ulmo>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1574664922; bh=dZm59GUkaOsNMNa4wcA2Fs2VFYZ5cQM3eTAH8Kq6GxM=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=p9Gy1z3oS4qCpf5Tt+L15YV34yFk8wEmfoXyb+rFiEH4jEhMeHhmJvGHEHbDBAsQw
         3NA5vl4A/ygey/Upu97VRWgQ8ZiBIgf3OyivONITooLQNn9a4Rj/hQC+MP58jB7006
         5nGE2GqsGojSNTHYaMKIEOLE9+unATmsTPiImhFy72dipKgv9MXbi05ZuIOJEfZeXL
         O8L0TnveJLRxVYO+idQs3lJCrQyJqvREKgVdI2CEwWvmWBQUNvZQrHec2LzXEGzMBh
         bBBbgykMn4OequUElLaktRwlQkI04NglDMbjjImyKkDf9S5dbGAYLBDl49ADKFL+Tq
         VZz/aCcO12GDQ==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/22/2019 6:50 PM, Thierry Reding wrote:
> On Fri, Nov 22, 2019 at 04:15:04PM +0530, Vidya Sagar wrote:
>> Enable GPIO controllers nodes for P2972-0000 platform which are required
>> by other controllers in the SoC for example when PCIe C5 controller
>> operates in endpoint mode.
>>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> ---
>>   arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts | 8 ++++++++
>>   1 file changed, 8 insertions(+)
> 
> The GPIO controllers are enabled by default, so there's no need to
> explicitly enable them.
Yup. I'll remove this patch.
Since I didn't see 'status' entry in GPIO nodes in tegra194.dtsi file, I thought
it means 'disabled'. But, contrary to my understanding, absence of 'status' entry
seems to mean 'okay'.

- Vidya Sagar
> 
> Thierry
> 
>>
>> diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts b/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
>> index 353a6a22196d..7eb64b816e08 100644
>> --- a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
>> +++ b/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
>> @@ -37,6 +37,14 @@
>>   			status = "okay";
>>   		};
>>   
>> +		gpio@2200000 {
>> +			status = "okay";
>> +		};
>> +
>> +		gpio@c2f0000 {
>> +			status = "okay";
>> +		};
>> +
>>   		pwm@c340000 {
>>   			status = "okay";
>>   		};
>> -- 
>> 2.17.1
>>

