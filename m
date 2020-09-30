Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F49027E966
	for <lists+linux-pci@lfdr.de>; Wed, 30 Sep 2020 15:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbgI3NWr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Sep 2020 09:22:47 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:45942 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgI3NWr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Sep 2020 09:22:47 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08UDMXgv023331;
        Wed, 30 Sep 2020 08:22:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601472153;
        bh=4V0e4kqtterMUYXsLqJjv3LDGmCqZY7hgAlR/HaanLw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ka8/io88KSXJKAY5i9z43PiR36sES2Z5o+CSjDvUaqNhxZSDUOy8GGcsd+bTzkEuu
         ur7W+JsMXjk3BuVvVqqSuWtFzNmUQnefear+d9gHgOlLOiVw11c8+m2nxj+t3nwqVi
         mrOFvXsa10/dDpsgyJR3SVNpdlQr9VmkZmda5QlE=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08UDMWQg093361
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 30 Sep 2020 08:22:32 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 30
 Sep 2020 08:22:32 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 30 Sep 2020 08:22:32 -0500
Received: from [10.250.232.108] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08UDMTTb096260;
        Wed, 30 Sep 2020 08:22:30 -0500
Subject: Re: [PATCH] PCI: dwc: Added link up check in map_bus of
 dw_child_pcie_ops
To:     Rob Herring <robh@kernel.org>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
CC:     "Z.q. Hou" <zhiqiang.hou@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Michael Walle <michael@walle.cc>,
        Ard Biesheuvel <ardb@kernel.org>
References: <20200916054130.8685-1-Zhiqiang.Hou@nxp.com>
 <CAL_JsqJwgNUpWFTq2YWowDUigndSOB4rUcVm0a_U=FEpEmk94Q@mail.gmail.com>
 <HE1PR0402MB3371F8191538F47E8249F048843F0@HE1PR0402MB3371.eurprd04.prod.outlook.com>
 <CAL_JsqLdQY_DqpduaTv4hMDM_-cvZ_+s8W+HdOuZVVYjTO4yxw@mail.gmail.com>
 <HE1PR0402MB337180458625B05D1529535384390@HE1PR0402MB3371.eurprd04.prod.outlook.com>
 <20200928093911.GB12010@e121166-lin.cambridge.arm.com>
 <HE1PR0402MB33713A623A37D08AE3253DEB84320@HE1PR0402MB3371.eurprd04.prod.outlook.com>
 <DM5PR12MB1276D80424F88F8A9243D5E2DA320@DM5PR12MB1276.namprd12.prod.outlook.com>
 <CAL_JsqJJxq2jZzbzZffsrPxnoLJdWLLS-7bG-vaqyqs5NkQhHQ@mail.gmail.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <9ac53f04-f2e8-c5f9-e1f7-e54270ec55a0@ti.com>
Date:   Wed, 30 Sep 2020 18:52:28 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJJxq2jZzbzZffsrPxnoLJdWLLS-7bG-vaqyqs5NkQhHQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 29/09/20 10:41 pm, Rob Herring wrote:
> On Tue, Sep 29, 2020 at 10:24 AM Gustavo Pimentel
> <Gustavo.Pimentel@synopsys.com> wrote:
>>
>> On Tue, Sep 29, 2020 at 5:5:41, Z.q. Hou <zhiqiang.hou@nxp.com> wrote:
>>
>>> Hi Lorenzo,
>>>
>>> Thanks a lot for your comments!
>>>
>>>> -----Original Message-----
>>>> From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>>>> Sent: 2020年9月28日 17:39
>>>> To: Z.q. Hou <zhiqiang.hou@nxp.com>
>>>> Cc: Rob Herring <robh@kernel.org>; linux-kernel@vger.kernel.org; PCI
>>>> <linux-pci@vger.kernel.org>; Bjorn Helgaas <bhelgaas@google.com>;
>>>> Gustavo Pimentel <gustavo.pimentel@synopsys.com>; Michael Walle
>>>> <michael@walle.cc>; Ard Biesheuvel <ardb@kernel.org>
>>>> Subject: Re: [PATCH] PCI: dwc: Added link up check in map_bus of
>>>> dw_child_pcie_ops
>>>>
>>>> On Thu, Sep 24, 2020 at 04:24:47AM +0000, Z.q. Hou wrote:
>>>>> Hi Rob,
>>>>>
>>>>> Thanks a lot for your comments!
>>>>>
>>>>>> -----Original Message-----
>>>>>> From: Rob Herring <robh@kernel.org>
>>>>>> Sent: 2020年9月18日 23:28
>>>>>> To: Z.q. Hou <zhiqiang.hou@nxp.com>
>>>>>> Cc: linux-kernel@vger.kernel.org; PCI <linux-pci@vger.kernel.org>;
>>>>>> Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>; Bjorn Helgaas
>>>>>> <bhelgaas@google.com>; Gustavo Pimentel
>>>>>> <gustavo.pimentel@synopsys.com>; Michael Walle
>>>> <michael@walle.cc>;
>>>>>> Ard Biesheuvel <ardb@kernel.org>
>>>>>> Subject: Re: [PATCH] PCI: dwc: Added link up check in map_bus of
>>>>>> dw_child_pcie_ops
>>>>>>
>>>>>> On Fri, Sep 18, 2020 at 5:02 AM Z.q. Hou <zhiqiang.hou@nxp.com>
>>>> wrote:
>>>>>>>
>>>>>>> Hi Rob,
>>>>>>>
>>>>>>> Thanks a lot for your comments!
>>>>>>>
>>>>>>>> -----Original Message-----
>>>>>>>> From: Rob Herring <robh@kernel.org>
>>>>>>>> Sent: 2020年9月17日 4:29
>>>>>>>> To: Z.q. Hou <zhiqiang.hou@nxp.com>
>>>>>>>> Cc: linux-kernel@vger.kernel.org; PCI
>>>>>>>> <linux-pci@vger.kernel.org>; Lorenzo Pieralisi
>>>>>>>> <lorenzo.pieralisi@arm.com>; Bjorn Helgaas
>>>>>>>> <bhelgaas@google.com>; Gustavo Pimentel
>>>>>>>> <gustavo.pimentel@synopsys.com>; Michael Walle
>>>>>> <michael@walle.cc>;
>>>>>>>> Ard Biesheuvel <ardb@kernel.org>
>>>>>>>> Subject: Re: [PATCH] PCI: dwc: Added link up check in map_bus of
>>>>>>>> dw_child_pcie_ops
>>>>>>>>
>>>>>>>> On Tue, Sep 15, 2020 at 11:49 PM Zhiqiang Hou
>>>>>> <Zhiqiang.Hou@nxp.com>
>>>>>>>> wrote:
>>>>>>>>>
>>>>>>>>> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>>>>>>>>>
>>>>>>>>> On NXP Layerscape platforms, it results in SError in the
>>>>>>>>> enumeration of the PCIe controller, which is not connecting
>>>>>>>>> with an Endpoint device. And it doesn't make sense to
>>>>>>>>> enumerate the Endpoints when the PCIe link is down. So this
>>>>>>>>> patch added the link up check to avoid to fire configuration
>>>> transactions on link down bus.
>>>>>>>>
>>>>>>>> Michael reported the same issue as well.
>>>>>>>>
>>>>>>>> What happens if the link goes down between the check and the
>>>> access?
>>>>>>>
>>>>>>> This patch cannot cover this case, and will get the SError.
>>>>>>> But I think it makes sense to avoid firing transactions on link down bus.
>>>>>>
>>>>>> That's impossible to do without a race even in h/w.
>>>>>
>>>>> Agree.
>>>>>
>>>>>>
>>>>>>>> It's a racy check. I'd like to find an alternative solution.
>>>>>>>> It's even worse if Layerscape is used in ECAM mode. I looked at
>>>>>>>> the EDK2 setup for layerscape[1] and it looks like root ports
>>>>>>>> are just skipped if link
>>>>>> is down.
>>>>>>>> Maybe a link down just never happens once up, but if so, then we
>>>>>>>> only need to check it once and fail probe.
>>>>>>>
>>>>>>> Many customers connect the FPGA Endpoint, which may establish PCIe
>>>>>>> link after the PCIe enumeration and then rescan the PCIe bus, so I
>>>>>>> think it should not exit the probe of root port even if there is
>>>>>>> not link up
>>>>>> during enumeration.
>>>>>>
>>>>>> That's a good reason. I want to unify the behavior here as it varies
>>>>>> per platform currently and wasn't sure which way to go.
>>>>>>
>>>>>>
>>>>>>>> I've dug into this a bit more and am curious about the
>>>>>>>> PCIE_ABSERR register setting which is set to:
>>>>>>>>
>>>>>>>> #define PCIE_ABSERR_SETTING 0x9401 /* Forward error of
>>>>>>>> non-posted request */
>>>>>>>>
>>>>>>>> It seems to me this is not what we want at least for config
>>>>>>>> accesses, but commit 84d897d6993 where this was added seems to
>>>>>>>> say otherwise. Is it not possible to configure the response per access
>>>> type?
>>>>>>>
>>>>>>> Thanks a lot for your investigation!
>>>>>>> The story is like this: Some customers worry about these silent
>>>>>>> error (DWC PCIe IP won't forward the error of outbound non-post
>>>>>>> request by default), so we were pushed to enable the error
>>>>>>> forwarding to AXI in the commit
>>>>>>> 84d897d6993 as you saw. But it cannot differentiate the config
>>>>>>> transactions from the MEM_rd, except the Vendor ID access, which
>>>>>>> is controlled by a separate bit and it was set to not forward
>>>>>>> error of access
>>>>>> of Vendor ID.
>>>>>>> So we think it's okay to enable the error forwarding, the SError
>>>>>>> should not occur, because after the enumeration it won't access
>>>>>>> the
>>>>>> non-existent functions.
>>>>>>
>>>>>> We've rejected upstream support for platforms aborting on config
>>>>>> accesses[1]. I think there's clear consensus that aborting is the
>>>>>> wrong behavior.
>>>>>>
>>>>>> Do MEM_wr errors get forwarded? Seems like that would be enough.
>>>>>> Also, wouldn't page faults catch most OOB accesses anyways? You need
>>>>>> things page aligned anyways with an IOMMU and doing userspace access
>>>>>> or guest assignment.
>>>>>
>>>>> Yes, errors of MEM_wr can be forwarded.
>>>>>
>>>>>>
>>>>>> Here's another idea, how about only enabling forwarding errors if
>>>>>> the link is up? If really would need to be configured any time the
>>>>>> link state changes rather than just at probe. I'm not sure if you
>>>>>> have a way to disable it on link down though.
>>>>>
>>>>> Dug deeper into this issue and found the setting of not forwarding
>>>>> error of non-existent Vender ID access counts on the link partner: 1.
>>>>> When there is a link partner (namely link up), it will return 0xffff
>>>>> when read non-existent function Vendor ID and won't forward error to
>>>>> AXI.  2. When no link partner (link down), it will forward the error
>>>>> of reading non-existent function Vendor ID to AXI and result in
>>>>> SError.
>>>>>
>>>>> I think this is a DWC PCIe IP specific issue but not get feedback from
>>>>> design team.  I'm thinking to disable this error forwarding just like
>>>>> other platforms, since when these errors (UR, CA and CT) are detected,
>>>>> AER driver can also report the error and try to recover.
>>>>
>>>> I take this as you shall send a patch to fix this issue shortly, is this correct ?
>>>
>>> The issue becomes complex:
>>> I reviewed the DWC PCIe databook of verion 4.40a which is used on Layerscape platforms, and it said that " Your RC application should not generate CFG requests until it has confirmed that the link is up by sampling the smlh_link_up and rmlh_link_up outputs".
>>> So, the link up checking should not be remove before each outbound CFG access.
>>> Gustavo, can you share more details on the link up checking? Does it only exist in the 4.40a?
>>
>> Hi Zhiqiang,
>>
>> According to the information that I got from the IP team you are correct,
>> the same requirement still exists on the newer IP versions.
> 
> How is that possible in a race free way?
> 
> Testing on meson and layerscape (with the forwarding of errors
> disabled) shows a link check is not needed. But then dra7xx seems to
> need one (or has some f/w setup).

Yeah, I don't see any registers in the DRA7x PCIe wrapper for disabling
error forwarding.

Thanks
Kishon
