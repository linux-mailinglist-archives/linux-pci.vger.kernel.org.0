Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D97AD15F4F
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2019 10:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbfEGIZy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 May 2019 04:25:54 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:13467 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbfEGIZy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 May 2019 04:25:54 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cd1410d0000>; Tue, 07 May 2019 01:25:49 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 07 May 2019 01:25:53 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 07 May 2019 01:25:53 -0700
Received: from [10.25.73.250] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 7 May
 2019 08:25:45 +0000
Subject: Re: [PATCH V5 07/16] dt-bindings: PCI: designware: Add binding for
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
References: <20190424052004.6270-1-vidyas@nvidia.com>
 <20190424052004.6270-8-vidyas@nvidia.com> <20190426143247.GA25107@bogus>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <031df2ca-27de-2388-5f23-078320203f5d@nvidia.com>
Date:   Tue, 7 May 2019 13:55:42 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190426143247.GA25107@bogus>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1557217549; bh=wQ9iFk4m3fdncdNS9i5YNta0RWRMl3LzCyGnAnhJj9I=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=MXC5lAAu50cq3hcFNtv/ibtbTWSvcfLsti/Ltt4G90H4fHzLcszsONMpsbKMU89py
         K+yHYQJGaymZrZ77yP4ZLznqCFZmaQWJ0EL+cVWghKUsEYXv7I/m7kW0uyrDvTzNQn
         b0A30eKLoCXb6eMa58CghegvrAlpHctPi0czTxKeLlqv98zAYugihXRX+QXA6DaiV+
         YsnqDDvZaVFIyfmXda/ugcfBOsSKkX8zG1lv7+Xzrlpd2xBnlLDYtdBOYNbFomc1vR
         O3fykmhmO1wPrlWc9fLP4UV65i6+iUIA7uH25j2FJEBFDc64C0fzC+nNsZnuHCmVMo
         D0A4wPfcoQjCg==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/26/2019 8:02 PM, Rob Herring wrote:
> On Wed, Apr 24, 2019 at 10:49:55AM +0530, Vidya Sagar wrote:
>> Add support to enable CDM (Configuration Dependent Module) registers check
>> for any data corruption. CDM registers include standard PCIe configuration
>> space registers, Port Logic registers and iATU and DMA registers.
>> Refer Section S.4 of Synopsys DesignWare Cores PCI Express Controller Databook
>> Version 4.90a
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
> 
> This needs a vendor prefix.
Why only for this? Since this whole file is for Synopsys DesignWare core based PCIe IP,
I thought there is specific prefix required. Am I wrong? Also, CDM checking is a feature
of IP and DWC based implementations can choose either to enable this feature at hardware level
or not. And whoever enabled it at hardware level (like Tegra194) can set this flag to
enable corresponding software support.

> 
>> +   automatic checking of CDM (Configuration Dependent Module) registers
>> +   for data corruption. CDM registers include standard PCIe configuration
>> +   space registers, Port Logic registers, DMA and iATU (internal Address
>> +   Translation Unit) registers.
>>   RC mode:
>>   - num-viewport: number of view ports configured in hardware. If a platform
>>     does not specify it, the driver assumes 2.
>> -- 
>> 2.17.1
>>

