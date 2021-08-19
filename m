Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F01A33F1B40
	for <lists+linux-pci@lfdr.de>; Thu, 19 Aug 2021 16:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240364AbhHSOKO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Aug 2021 10:10:14 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:57696 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238385AbhHSOKO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Aug 2021 10:10:14 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 17JE9FoE071629;
        Thu, 19 Aug 2021 09:09:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1629382155;
        bh=uwn5s8WFWAJxAIMlEF0ntZ/7TmV8w7aPCcWjcaig714=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=JT6Weh/EKqM0MQhK8LBisilSpS5E2vAsxyBpMl8s5rOHkIrWDpcOJwGVT83fV5wH3
         bZlgLclgh7WuGQ/LrWZWZFCOp4Az/owzR6jxSqIfGQMuvTOzmO1zZ8uICrhVMNqyY4
         Al0AadtySRi+O1VKX/D3TSpO/aeW6//yFfd54LY8=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 17JE9F3w060433
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 19 Aug 2021 09:09:15 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 19
 Aug 2021 09:09:15 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 19 Aug 2021 09:09:15 -0500
Received: from [10.250.233.32] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 17JE9BsK069201;
        Thu, 19 Aug 2021 09:09:11 -0500
Subject: Re: [PATCH v3 0/5] PCI: Add support for J7200 and AM64
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tom Joseph <tjoseph@cadence.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <nadeem@cadence.com>
References: <20210811123336.31357-1-kishon@ti.com>
 <a618e0af-d95f-8e25-5b86-eff7fd14d186@ti.com>
 <20210819134418.GB26966@lpieralisi>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <b70bd865-920d-f736-9e6c-a6bb4442476f@ti.com>
Date:   Thu, 19 Aug 2021 19:39:10 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210819134418.GB26966@lpieralisi>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

On 19/08/21 7:14 pm, Lorenzo Pieralisi wrote:
> On Thu, Aug 19, 2021 at 06:12:54PM +0530, Kishon Vijay Abraham I wrote:
>> Hi Lorenzo,
>>
>> On 11/08/21 6:03 pm, Kishon Vijay Abraham I wrote:
>>> This series adds the compatible specific to J7200 and AM64 and
>>> applies the erratas and configuration specific to them.
>>>
>>> This series also includes Nadeem's patch that adds a quirk in
>>> Cadence driver which is used by J7200 [1].
>>>
>>> The DT binding for both J7200 and AM64 is already merged.
>>>
>>> v1 of the patch series can be found at [2]
>>> v2 of the patch series can be found at [3]
>>
>> Gentle ping on this series.
>>
>> I've dropped "misc: pci_endpoint_test: Do not request or allocate IRQs
>> in probe" [A] from the previous version of the series which you had
>> concerns with.
>>
>> [A] -> http://lore.kernel.org/r/02c1ddb7-539e-20a0-1bef-e10e76922a0e@ti.com
> 
> Understood. The question is, how did you solve the issue that was
> forcing you to have that patch in place in the updated series.

That issue only prevents more than 5 pci-endpoint-test devices to be
tested simultaneously.

For the GIC ITS issue, I'm planning to post the workaround mentioned in
the errata document.

Errata ID #i2101 GIC: ITS Misbehavior
(https://www.ti.com/lit/er/sprz455a/sprz455a.pdf).

Also the GIC ITS issue is not present in J7200 and AM64 which this
series is planning to address. It's present only in J721E and AM65.

Thanks
Kishon

> 
> Thanks,
> Lorenzo
> 
>>
>> Thanks
>> Kishon
>>
>>>
>>> Changes from v2:
>>> 1) Drop the patch that does not request or allocate IRQs in probe for
>>> J721E/AM654
>>> 2) Fix other minor comments given by Lorenzo
>>>
>>> Changes from v1:
>>> 1) As suggested by Bjorn, used unsigned int :1, instead of bool for
>>> structure members
>>> 2) Removed using unnecessary local variables and also fixed some
>>> code alignment
>>>
>>> [1] -> https://lore.kernel.org/r/20210528155626.21793-1-nadeem@cadence.com
>>> [2] -> https://lore.kernel.org/r/20210706105035.9915-1-kishon@ti.com
>>> [3] -> https://lore.kernel.org/r/20210803074932.19820-1-kishon@ti.com
>>>
>>> Kishon Vijay Abraham I (4):
>>>   PCI: cadence: Use bitfield for *quirk_retrain_flag* instead of bool
>>>   PCI: j721e: Add PCIe support for J7200
>>>   PCI: j721e: Add PCIe support for AM64
>>>   misc: pci_endpoint_test: Add deviceID for AM64 and J7200
>>>
>>> Nadeem Athani (1):
>>>   PCI: cadence: Add quirk flag to set minimum delay in LTSSM
>>>     Detect.Quiet state
>>>
>>>  drivers/misc/pci_endpoint_test.c              |  8 +++
>>>  drivers/pci/controller/cadence/pci-j721e.c    | 61 +++++++++++++++++--
>>>  .../pci/controller/cadence/pcie-cadence-ep.c  |  4 ++
>>>  .../controller/cadence/pcie-cadence-host.c    |  3 +
>>>  drivers/pci/controller/cadence/pcie-cadence.c | 16 +++++
>>>  drivers/pci/controller/cadence/pcie-cadence.h | 17 +++++-
>>>  6 files changed, 103 insertions(+), 6 deletions(-)
>>>
