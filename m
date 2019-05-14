Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B91C91C33C
	for <lists+linux-pci@lfdr.de>; Tue, 14 May 2019 08:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbfENGZ7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 May 2019 02:25:59 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:13974 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbfENGZ6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 May 2019 02:25:58 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cda5f700000>; Mon, 13 May 2019 23:25:52 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 13 May 2019 23:25:56 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 13 May 2019 23:25:56 -0700
Received: from [10.24.47.172] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 14 May
 2019 06:25:51 +0000
Subject: Re: [PATCH V5 10/16] dt-bindings: PCI: tegra: Add device tree support
 for T194
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
 <20190424052004.6270-11-vidyas@nvidia.com> <20190426154306.GA16455@bogus>
 <504abd8f-9eb3-1089-953c-a6372c34b346@nvidia.com>
 <CAL_JsqLEw+HAeqd2TD33cSVBjwDUNMb5amk2wGsW9m_4Z6CucQ@mail.gmail.com>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <4b1fe488-c99f-3deb-e6f0-a67eb65b2278@nvidia.com>
Date:   Tue, 14 May 2019 11:55:48 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqLEw+HAeqd2TD33cSVBjwDUNMb5amk2wGsW9m_4Z6CucQ@mail.gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1557815152; bh=aymdfMw16yHSs7vet1wRgqNK0BlRIZ7Ycz6RCAS99N0=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=aey9i1BRHiCSfhSf1vClKCQmwTvcMOR82sYIz9bKYoXRvI3vXJ/Oha8Hds/elNyEJ
         6E7I3LEGq2Q+hHWAr6WlxEE3ubFXOb9I8WilE6OBU8E/dJumpE34n2UHeklhKy3iMw
         HDQQpyi0ojbwzbB5Nt10qCtZa8aCAPpQDT/8Cl0SmP1id2XoCxwVKlRdJLVCBHmqQV
         LKjZhwNPds3PjPDGsyn1rwNfOe9pkq+97sC2EiQU2L4qLYcKUCjp1Uq6FzKyfUBU3+
         OJQXPGukJJkaBw0Qg2QoRell9a16uzVDniOyvrWBukg9GbZBVbA9o9TGzSF8yVZ8n7
         O/cob961AVKhA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 5/13/2019 8:50 PM, Rob Herring wrote:
> On Tue, May 7, 2019 at 4:20 AM Vidya Sagar <vidyas@nvidia.com> wrote:
>>
>> On 4/26/2019 9:13 PM, Rob Herring wrote:
>>> On Wed, Apr 24, 2019 at 10:49:58AM +0530, Vidya Sagar wrote:
>>>> Add support for Tegra194 PCIe controllers. These controllers are based
>>>> on Synopsys DesignWare core IP.
>>>>
>>>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>>>> ---
> 
>>>> +- nvidia,bpmp: Must contain a phandle to BPMP controller node.
>>>> +- nvidia,controller-id : Controller specific ID
>>>> +    0: C0
>>>> +    1: C1
>>>> +    2: C2
>>>> +    3: C3
>>>> +    4: C4
>>>> +    5: C5
>>>
>>> We don't normal put device indexes into DT. Why do you need this.
>>> Perhaps for accessing the BPMP? If so, make nvidia,bpmp a phandle+cell.
>> BPMP needs to know the controller number to enable it hence it needs to be
>> passed to BPMP. Just for accessing BPMP, I already added 'nvidia,bpmp' property.
> 
> Then make nvidia,bpmp take the phandle and this number.
Ok. I'll take care of it in next patch series.

> 
> 
>>>> +- nvidia,disable-aspm-states: Controls advertisement of ASPM states
>>>> +    bit-0 to '1': Disables advertisement of ASPM-L0s
>>>> +    bit-1 to '1': Disables advertisement of ASPM-L1. This also disables
>>>> +                   advertisement of ASPM-L1.1 and ASPM-L1.2
>>>> +    bit-2 to '1': Disables advertisement of ASPM-L1.1
>>>> +    bit-3 to '1': Disables advertisement of ASPM-L1.2
>>>
>>> Can't this cover what 'supports-clkreq' does?
>> Well, they are related partially. i.e. if a platform doesn't have 'supports-clkreq' set,
>> then, by definition, it can't advertise support for ASPM L1.1 and L1.2 states. But, ASPM-L0s
>> and ASPM-L1 states don't depend on 'supports-clkreq' property.
>> Having this property gives more granularity as to support for which particular ASPM state
>> shouldn't be advertised by the root port.
> 
> Okay, then it should be a common property then.
I'm planning to remove this given we have sysfs way (Heiner's patch series @
http://patchwork.ozlabs.org/project/linux-pci/list/?series=107392 to control which ASPM states
can be enabled run time. In case if that is not going to work for a given use case, I'll push
patches separately for controlling ASPM states advertisement/working.

> 
> Rob
> 

