Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93AB11C1DC
	for <lists+linux-pci@lfdr.de>; Tue, 14 May 2019 07:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfENF3m (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 May 2019 01:29:42 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:18457 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbfENF3l (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 May 2019 01:29:41 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cda521b0000>; Mon, 13 May 2019 22:28:59 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 13 May 2019 22:29:39 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 13 May 2019 22:29:39 -0700
Received: from [10.24.47.172] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 14 May
 2019 05:29:34 +0000
Subject: Re: [PATCH V5 07/16] dt-bindings: PCI: designware: Add binding for
 CDM register check
To:     Rob Herring <robh@kernel.org>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        <sagar.tv@gmail.com>
References: <20190424052004.6270-1-vidyas@nvidia.com>
 <20190424052004.6270-8-vidyas@nvidia.com> <20190426143247.GA25107@bogus>
 <031df2ca-27de-2388-5f23-078320203f5d@nvidia.com>
 <CAL_JsqKvES6OuPRgu8A009j6L4rkc11rB9TyxPe1iUJhvk1O8w@mail.gmail.com>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <f340cb14-a6df-340b-ce37-227685f78b80@nvidia.com>
Date:   Tue, 14 May 2019 10:59:31 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKvES6OuPRgu8A009j6L4rkc11rB9TyxPe1iUJhvk1O8w@mail.gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1557811740; bh=cqJjsaktR+J8Rzac06BPbRbkXCQMRbYeXEjs18+haNc=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=DqVGD9SpIGwB+ICy+zXbqihOzxwZF83U/SQ2oW9SUGBCiTUWbFM2evWjeZaNNRcXp
         OUdYxDyeRXV/BmgAiiVD8BOefyvDaY7i6G3qmcv8B1QWNg9oUGJEloYXLeAlR6GTP+
         5ft4GbFstcouTV1VmsB5acuJkkQpCXPpm4vYhS6kxxYf7AeOYnfOn77cwsU7UEU5BC
         qecBcnP7PkPZzkcP0DGTgZ5euLnpKNLHgMv25PXeahLET5puUlat8Tgp13WbKdDq3L
         cc4MwKxr2dL0MMXQGuzeZT8NQi4r0U/0uogEF/Q9Fd3KDRQCoVbAwAvbR2vJzBSjH8
         j4wCRmXxcqTew==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 5/13/2019 8:45 PM, Rob Herring wrote:
> On Tue, May 7, 2019 at 3:25 AM Vidya Sagar <vidyas@nvidia.com> wrote:
>>
>> On 4/26/2019 8:02 PM, Rob Herring wrote:
>>> On Wed, Apr 24, 2019 at 10:49:55AM +0530, Vidya Sagar wrote:
>>>> Add support to enable CDM (Configuration Dependent Module) registers check
>>>> for any data corruption. CDM registers include standard PCIe configuration
>>>> space registers, Port Logic registers and iATU and DMA registers.
>>>> Refer Section S.4 of Synopsys DesignWare Cores PCI Express Controller Databook
>>>> Version 4.90a
>>>>
>>>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>>>> ---
>>>> Changes since [v4]:
>>>> * None
>>>>
>>>> Changes since [v3]:
>>>> * None
>>>>
>>>> Changes since [v2]:
>>>> * Changed flag name from 'cdm-check' to 'enable-cdm-check'
>>>> * Added info about Port Logic and DMA registers being part of CDM
>>>>
>>>> Changes since [v1]:
>>>> * This is a new patch in v2 series
>>>>
>>>>    Documentation/devicetree/bindings/pci/designware-pcie.txt | 5 +++++
>>>>    1 file changed, 5 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/pci/designware-pcie.txt b/Documentation/devicetree/bindings/pci/designware-pcie.txt
>>>> index 5561a1c060d0..85b872c42a9f 100644
>>>> --- a/Documentation/devicetree/bindings/pci/designware-pcie.txt
>>>> +++ b/Documentation/devicetree/bindings/pci/designware-pcie.txt
>>>> @@ -34,6 +34,11 @@ Optional properties:
>>>>    - clock-names: Must include the following entries:
>>>>       - "pcie"
>>>>       - "pcie_bus"
>>>> +- enable-cdm-check: This is a boolean property and if present enables
>>>
>>> This needs a vendor prefix.
>> Why only for this? Since this whole file is for Synopsys DesignWare core based PCIe IP,
>> I thought there is specific prefix required. Am I wrong? Also, CDM checking is a feature
>> of IP and DWC based implementations can choose either to enable this feature at hardware level
>> or not. And whoever enabled it at hardware level (like Tegra194) can set this flag to
>> enable corresponding software support.
> 
> TBC, I meant a Synopsys vendor prefix, not NVIDIA.
> 
> Any property that's not from a common binding should have a vendor
> prefix. That hasn't always happened, so we do have lots of examples
> without.
Ok. got it. I'm going to take care of this in V7 series.

> 
> Rob
> 

