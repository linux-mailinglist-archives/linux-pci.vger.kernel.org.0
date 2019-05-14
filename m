Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6ABF1C1CB
	for <lists+linux-pci@lfdr.de>; Tue, 14 May 2019 07:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725935AbfENF1N (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 May 2019 01:27:13 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:15437 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbfENF1N (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 May 2019 01:27:13 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cda51b60000>; Mon, 13 May 2019 22:27:19 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 13 May 2019 22:27:12 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 13 May 2019 22:27:12 -0700
Received: from [10.24.47.172] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 14 May
 2019 05:27:06 +0000
Subject: Re: [PATCH V6 06/15] dt-bindings: PCI: designware: Add binding for
 CDM register check
To:     Rob Herring <robh@kernel.org>
CC:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <mark.rutland@arm.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <kishon@ti.com>, <catalin.marinas@arm.com>,
        <will.deacon@arm.com>, <jingoohan1@gmail.com>,
        <gustavo.pimentel@synopsys.com>, <mperttunen@nvidia.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20190513050626.14991-1-vidyas@nvidia.com>
 <20190513050626.14991-7-vidyas@nvidia.com> <20190513151038.GA30653@bogus>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <bdffcc1e-062a-a39e-1a3d-bc48e78f9668@nvidia.com>
Date:   Tue, 14 May 2019 10:57:04 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190513151038.GA30653@bogus>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1557811639; bh=Dq8qnb1ysO5RsRvY1YBGjeDlfEbkkUSeJAsfidt5wpQ=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=GWsXtVm0irwfCt46TdsXdVGHhKZ9q888BDruFt5aAi9LxMNGaaumFAq7MIX/j2Ed+
         EeQx0ggPp1kqnzq/M1zeYmDAU3f8dgCu43hjNwZbLbJeJE3BvFxQ/hjLwBUg9SXgYs
         Ao0UdVfoAkAHe0h9G+rpfQp4l8Kxl4IoRj/KMr4ddnaOiHzjKpTq24d4kUt2cN86fY
         zLQ4wEo/Sqj/8v9ys5GwXNjXNVH+W+xtI8/CiItwIw2tyXDwaIriMmsxGpWclU9NHg
         IwPPAp7xxXyay8xLmm+kolhyLoQemXTdisK6RM2j7m3CDMR+71rFljtXg3ka8QLUsa
         ym5Aix8T+vEFg==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 5/13/2019 8:40 PM, Rob Herring wrote:
> On Mon, May 13, 2019 at 10:36:17AM +0530, Vidya Sagar wrote:
>> Add support to enable CDM (Configuration Dependent Module) registers check
>> for any data corruption. CDM registers include standard PCIe configuration
>> space registers, Port Logic registers and iATU and DMA registers.
>> Refer Section S.4 of Synopsys DesignWare Cores PCI Express Controller Databook
>> Version 4.90a
>>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> ---
>> Changes since [v5]:
>> * None
>>
>> Changes since [v4]:
>> * None
>>
>> Changes since [v3]:
>> * None
>>
>> Changes since [v2]:
>> * Changed flag name from 'cdm-check' to 'enable-cdm-check'
>> * Added info about Port Logic and DMA registers being part of CDM
>>
>> Changes since [v1]:
>> * This is a new patch in v2 series
>>
>>   Documentation/devicetree/bindings/pci/designware-pcie.txt | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/designware-pcie.txt b/Documentation/devicetree/bindings/pci/designware-pcie.txt
>> index 5561a1c060d0..85b872c42a9f 100644
>> --- a/Documentation/devicetree/bindings/pci/designware-pcie.txt
>> +++ b/Documentation/devicetree/bindings/pci/designware-pcie.txt
>> @@ -34,6 +34,11 @@ Optional properties:
>>   - clock-names: Must include the following entries:
>>   	- "pcie"
>>   	- "pcie_bus"
>> +- enable-cdm-check: This is a boolean property and if present enables
>> +   automatic checking of CDM (Configuration Dependent Module) registers
>> +   for data corruption. CDM registers include standard PCIe configuration
>> +   space registers, Port Logic registers, DMA and iATU (internal Address
>> +   Translation Unit) registers.
> 
> snps,enable-cdm-check
Ok. Done.

> 
>>   RC mode:
>>   - num-viewport: number of view ports configured in hardware. If a platform
>>     does not specify it, the driver assumes 2.
>> -- 
>> 2.17.1
>>

