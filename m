Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C745D64B4A
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2019 19:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbfGJROa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Jul 2019 13:14:30 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:13796 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbfGJRO3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Jul 2019 13:14:29 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d261cf30000>; Wed, 10 Jul 2019 10:14:27 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 10 Jul 2019 10:14:28 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 10 Jul 2019 10:14:28 -0700
Received: from [10.25.74.6] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 10 Jul
 2019 17:14:23 +0000
Subject: Re: [PATCH V13 08/12] dt-bindings: Add PCIe supports-clkreq property
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     <bhelgaas@google.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <kishon@ti.com>, <catalin.marinas@arm.com>,
        <will.deacon@arm.com>, <jingoohan1@gmail.com>,
        <gustavo.pimentel@synopsys.com>, <digetx@gmail.com>,
        <mperttunen@nvidia.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20190710062212.1745-1-vidyas@nvidia.com>
 <20190710062212.1745-9-vidyas@nvidia.com>
 <20190710152856.GB8781@e121166-lin.cambridge.arm.com>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <95103fa2-9181-247e-3fd5-1b0bd95e8bb9@nvidia.com>
Date:   Wed, 10 Jul 2019 22:44:20 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190710152856.GB8781@e121166-lin.cambridge.arm.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1562778867; bh=CCe2cpbcTfj8PcVYEgcYHWQ29tSTq4v82/vz3Ha3bvM=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=IDIaT7hwrXY0e2aFy5qoHGyfhPqHrmC06v3yAqQpH3QWKIbHjK1TiJmxlfbYnvK+S
         11zGdae9e8G8gihUUhW8kewo+e9ilAfgeFBoZ6Fw8gPOKv6e/txU0NMcDqiEtaRKEK
         nfjc3NjcplCTdBkmDWuQKtPF8gvWVcHdOLmd8B+xEWGloRMLXsSJ9LNmF/xNat9Ffw
         ToQVm9aCL62P0BKMp1MbCu4L/p/+IkCC1wR+OOHO27FYKLmI7dEYTALN03dkFL6fyq
         NOwTeOBDzk3shnZQTTwy/+4zQYXF54Qk5sh0dbt5bJhpdi3fB0jhyWPLT40R75GATG
         tJwWeTIf914CQ==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 7/10/2019 8:58 PM, Lorenzo Pieralisi wrote:
> On Wed, Jul 10, 2019 at 11:52:08AM +0530, Vidya Sagar wrote:
>> Some host controllers need to know the existence of clkreq signal routing to
>> downstream devices to be able to advertise low power features like ASPM L1
>> substates. Without clkreq signal routing being present, enabling ASPM L1 sub
>> states might lead to downstream devices falling off the bus. Hence a new device
> 
> You mean "being disconnected from the bus" right ? I will update it.
Yes. I meant the same.

> 
> Lorenzo
> 
>> tree property 'supports-clkreq' is added to make such host controllers
>> aware of clkreq signal routing to downstream devices.
>>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> Reviewed-by: Thierry Reding <treding@nvidia.com>
>> ---
>> V13:
>> * None
>>
>> V12:
>> * Rebased on top of linux-next top of the tree
>>
>> V11:
>> * None
>>
>> V10:
>> * None
>>
>> V9:
>> * None
>>
>> V8:
>> * None
>>
>> V7:
>> * None
>>
>> V6:
>> * s/Documentation\/devicetree/dt-bindings/ in the subject
>>
>> V5:
>> * None
>>
>> V4:
>> * Rebased on top of linux-next top of the tree
>>
>> V3:
>> * None
>>
>> V2:
>> * This is a new patch in v2 series
>>
>>   Documentation/devicetree/bindings/pci/pci.txt | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/pci.txt b/Documentation/devicetree/bindings/pci/pci.txt
>> index 2a5d91024059..29bcbd88f457 100644
>> --- a/Documentation/devicetree/bindings/pci/pci.txt
>> +++ b/Documentation/devicetree/bindings/pci/pci.txt
>> @@ -27,6 +27,11 @@ driver implementation may support the following properties:
>>   - reset-gpios:
>>      If present this property specifies PERST# GPIO. Host drivers can parse the
>>      GPIO and apply fundamental reset to endpoints.
>> +- supports-clkreq:
>> +   If present this property specifies that CLKREQ signal routing exists from
>> +   root port to downstream device and host bridge drivers can do programming
>> +   which depends on CLKREQ signal existence. For example, programming root port
>> +   not to advertise ASPM L1 Sub-States support if there is no CLKREQ signal.
>>   
>>   PCI-PCI Bridge properties
>>   -------------------------
>> -- 
>> 2.17.1
>>

