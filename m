Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AACF2CD533
	for <lists+linux-pci@lfdr.de>; Thu,  3 Dec 2020 13:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgLCMLl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Dec 2020 07:11:41 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:12561 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbgLCMLl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Dec 2020 07:11:41 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fc8d5d40000>; Thu, 03 Dec 2020 04:11:00 -0800
Received: from [10.25.75.116] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 3 Dec
 2020 12:10:55 +0000
Subject: Re: [PATCH V2] PCI: dwc: Add support to configure for ECRC
To:     Bjorn Helgaas <helgaas@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC:     Jingoo Han <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "amurray@thegoodpenguin.co.uk" <amurray@thegoodpenguin.co.uk>,
        "robh@kernel.org" <robh@kernel.org>,
        "treding@nvidia.com" <treding@nvidia.com>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kthota@nvidia.com" <kthota@nvidia.com>,
        "mmaddireddy@nvidia.com" <mmaddireddy@nvidia.com>,
        "sagar.tv@gmail.com" <sagar.tv@gmail.com>
References: <20201124210228.GA589610@bjorn-Precision-5520>
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <42ebcbe2-7d24-558a-3c33-beb7818d5516@nvidia.com>
Date:   Thu, 3 Dec 2020 17:40:50 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20201124210228.GA589610@bjorn-Precision-5520>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606997460; bh=R1dR3vQ5KvZ/4VXGbEQg2PvUIku7NFOP5kXlOWhL1Bw=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=PbM0mrz5mA/+QowbQYM1yd23iJ+Mi16qXhKsyrUbdpy1eHJBRsCWnI1Rk8ig93xpQ
         sODCvdsLYqS4ZEigtKYRQLf0Mr7DQ0QwWKWgApjSAWc9iHngupgxiIMhNwf/J359eA
         syG53DkzlIqaTVgg1JOBqHAuvK8q+vjZlfpUPc9jEGhwx1Q+aZ6akYAhW9StrtZjQp
         y8HY8KwNUKTkvS87QFMEzXSuHgCg2hsFo3LdbVvwjKhT9IA/QwmJkRDhJMP8r4qR4f
         SqfiHQzRJURCSL0+5Q5+mjGkiPdH6tPEAm1WJ78xcpKqNmFpAB76rfZIdVIndL4sTR
         iP+2gAgiTvCBA==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 11/25/2020 2:32 AM, Bjorn Helgaas wrote:
> External email: Use caution opening links or attachments
>=20
>=20
> On Tue, Nov 24, 2020 at 03:50:01PM +0530, Vidya Sagar wrote:
>> Hi Bjorn,
>> Please let me know if this patch needs any further modifications
>=20
> I'm fine with it, but of course Lorenzo will take care of it.
Thanks Bjorn.

Hi Lorenzo,
Please let me know if you have any comments for this patch.

Thanks,
Vidya Sagar

>=20
>> On 11/12/2020 10:32 PM, Vidya Sagar wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On 11/12/2020 3:59 AM, Bjorn Helgaas wrote:
>>>> External email: Use caution opening links or attachments
>>>>
>>>>
>>>> On Wed, Nov 11, 2020 at 10:21:46PM +0530, Vidya Sagar wrote:
>>>>>
>>>>>
>>>>> On 11/11/2020 9:57 PM, Jingoo Han wrote:
>>>>>> External email: Use caution opening links or attachments
>>>>>>
>>>>>>
>>>>>> On 11/11/20, 7:12 AM, Vidya Sagar wrote:
>>>>>>>
>>>>>>> DesignWare core has a TLP digest (TD) override bit in
>>>>>>> one of the control
>>>>>>> registers of ATU. This bit also needs to be programmed for proper E=
CRC
>>>>>>> functionality. This is currently identified as an issue
>>>>>>> with DesignWare
>>>>>>> IP version 4.90a.
>>>>>>>
>>>>>>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>>>>>>> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>>>>>>> ---
>>>>>>> V2:
>>>>>>> * Addressed Bjorn's comments
>>>>>>>
>>>>>>>     drivers/pci/controller/dwc/pcie-designware.c | 52
>>>>>>> ++++++++++++++++++--
>>>>>>>     drivers/pci/controller/dwc/pcie-designware.h |=C2=A0 1 +
>>>>>>>     2 files changed, 49 insertions(+), 4 deletions(-)
>>>>>>>
>>>>>>> diff --git
>>>>>>> a/drivers/pci/controller/dwc/pcie-designware.c
>>>>>>> b/drivers/pci/controller/dwc/pcie-designware.c
>>>>>>> index c2dea8fc97c8..ec0d13ab6bad 100644
>>>>>>> --- a/drivers/pci/controller/dwc/pcie-designware.c
>>>>>>> +++ b/drivers/pci/controller/dwc/pcie-designware.c
>>>>>>> @@ -225,6 +225,46 @@ static void
>>>>>>> dw_pcie_writel_ob_unroll(struct dw_pcie *pci, u32 index,
>>>>>>> u32 reg,
>>>>>>>          dw_pcie_writel_atu(pci, offset + reg, val);
>>>>>>>     }
>>>>>>>
>>>>>>> +static inline u32 dw_pcie_enable_ecrc(u32 val)
>>>>>>
>>>>>> What is the reason to use inline here?
>>>>>
>>>>> Actually, I wanted to move the programming part inside the
>>>>> respective APIs
>>>>> but then I wanted to give some details as well in comments so to avoi=
d
>>>>> duplication, I came up with this function. But, I'm making it inline =
for
>>>>> better code optimization by compiler.
>>>>
>>>> I don't really care either way, but I'd be surprised if the compiler
>>>> didn't inline this all by itself even without the explicit "inline".
>>> I just checked it and you are right that compiler is indeed inlining it
>>> without explicitly mentioning 'inline'.
>>> I hope it is ok to leave it that way.
>>>
>>>>
>>>>>>> +{
>>>>>>> +     /*
>>>>>>> +      * DesignWare core version 4.90A has this strange design issu=
e
>>>>>>> +      * where the 'TD' bit in the Control register-1 of
>>>>>>> the ATU outbound
>>>>>>> +      * region acts like an override for the ECRC
>>>>>>> setting i.e. the presence
>>>>>>> +      * of TLP Digest(ECRC) in the outgoing TLPs is
>>>>>>> solely determined by
>>>>>>> +      * this bit. This is contrary to the PCIe spec
>>>>>>> which says that the
>>>>>>> +      * enablement of the ECRC is solely determined by
>>>>>>> the AER registers.
>>>>>>> +      *
>>>>>>> +      * Because of this, even when the ECRC is enabled through AER
>>>>>>> +      * registers, the transactions going through ATU
>>>>>>> won't have TLP Digest
>>>>>>> +      * as there is no way the AER sub-system could
>>>>>>> program the TD bit which
>>>>>>> +      * is specific to DesignWare core.
>>>>>>> +      *
>>>>>>> +      * The best way to handle this scenario is to program the TD =
bit
>>>>>>> +      * always. It affects only the traffic from root
>>>>>>> port to downstream
>>>>>>> +      * devices.
>>>>>>> +      *
>>>>>>> +      * At this point,
>>>>>>> +      * When ECRC is enabled in AER registers,
>>>>>>> everything works normally
>>>>>>> +      * When ECRC is NOT enabled in AER registers, then,
>>>>>>> +      * on Root Port:- TLP Digest (DWord size) gets
>>>>>>> appended to each packet
>>>>>>> +      *                even through it is not required.
>>>>>>> Since downstream
>>>>>>> +      *                TLPs are mostly for
>>>>>>> configuration accesses and BAR
>>>>>>> +      *                accesses, they are not in
>>>>>>> critical path and won't
>>>>>>> +      *                have much negative effect on the performanc=
e.
>>>>>>> +      * on End Point:- TLP Digest is received for
>>>>>>> some/all the packets coming
>>>>>>> +      *                from the root port. TLP Digest
>>>>>>> is ignored because,
>>>>>>> +      *                as per the PCIe Spec r5.0 v1.0 section 2.2.=
3
>>>>>>> +      *                "TLP Digest Rules", when an
>>>>>>> endpoint receives TLP
>>>>>>> +      *                Digest when its ECRC check
>>>>>>> functionality is disabled
>>>>>>> +      *                in AER registers, received TLP
>>>>>>> Digest is just ignored.
>>>>>>> +      * Since there is no issue or error reported
>>>>>>> either side, best way to
>>>>>>> +      * handle the scenario is to program TD bit by default.
>>>>>>> +      */
>>>>>>> +
>>>>>>> +     return val | PCIE_ATU_TD;
>>>>>>> +}
