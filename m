Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6455F2D7743
	for <lists+linux-pci@lfdr.de>; Fri, 11 Dec 2020 15:02:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391254AbgLKN7h (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Dec 2020 08:59:37 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:9706 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388214AbgLKN7W (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Dec 2020 08:59:22 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fd37b110001>; Fri, 11 Dec 2020 05:58:41 -0800
Received: from [10.40.169.64] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 11 Dec
 2020 13:58:30 +0000
Subject: Re: [PATCH V2] PCI: dwc: Add support to configure for ECRC
From:   Vidya Sagar <vidyas@nvidia.com>
To:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
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
        "sagar.tv@gmail.com" <sagar.tv@gmail.com>,
        "Bjorn Helgaas" <helgaas@kernel.org>
References: <20201124210228.GA589610@bjorn-Precision-5520>
 <42ebcbe2-7d24-558a-3c33-beb7818d5516@nvidia.com>
Message-ID: <49e3a6a4-9621-0734-99f1-b4f616dbcb7d@nvidia.com>
Date:   Fri, 11 Dec 2020 19:28:25 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <42ebcbe2-7d24-558a-3c33-beb7818d5516@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1607695121; bh=J2irPRBhjSNccNHMXWtkhnk7Ke+VeqIj3V6Q8oHLeBo=;
        h=Subject:From:To:CC:References:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=T2lsTkguHKdFIuFKdl+v6YkJj2lqG0Or9xGYc8AQeZ6oot9VVIscsB5nMI1makPv4
         QT4HODPPx0KTLvS1B7i5l0Zv/p/brSNxHkKfHL/voKOGT/sozF4sOgXWQCvPUGGYX1
         KqrB8h/OpQ1kSlhCMSJozhy/2Eb2wYhev7rkP0/IoOwkqbmkLXuHPn2o/+iHqkvFYy
         KIFnJJ7KG6x3O/R9o7ztNOPhJotkNOiGK1ukE3Hsak4bD/eD9KVPScxvKTsxQBf+n1
         r1Vy6hyV+WcIntZPlEjoI8J3iVDr1+l/dy3ZgA4uD2xGZSx/MqbABvTBzB3xztU3oH
         k35B861CazI9w==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,
Apologies to bug you, but wondering if you have any further comments on=20
this patch that I need to take care of?

Thanks,
Vidya Sagar

On 12/3/2020 5:40 PM, Vidya Sagar wrote:
>=20
>=20
> On 11/25/2020 2:32 AM, Bjorn Helgaas wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On Tue, Nov 24, 2020 at 03:50:01PM +0530, Vidya Sagar wrote:
>>> Hi Bjorn,
>>> Please let me know if this patch needs any further modifications
>>
>> I'm fine with it, but of course Lorenzo will take care of it.
> Thanks Bjorn.
>=20
> Hi Lorenzo,
> Please let me know if you have any comments for this patch.
>=20
> Thanks,
> Vidya Sagar
>=20
>>
>>> On 11/12/2020 10:32 PM, Vidya Sagar wrote:
>>>> External email: Use caution opening links or attachments
>>>>
>>>>
>>>> On 11/12/2020 3:59 AM, Bjorn Helgaas wrote:
>>>>> External email: Use caution opening links or attachments
>>>>>
>>>>>
>>>>> On Wed, Nov 11, 2020 at 10:21:46PM +0530, Vidya Sagar wrote:
>>>>>>
>>>>>>
>>>>>> On 11/11/2020 9:57 PM, Jingoo Han wrote:
>>>>>>> External email: Use caution opening links or attachments
>>>>>>>
>>>>>>>
>>>>>>> On 11/11/20, 7:12 AM, Vidya Sagar wrote:
>>>>>>>>
>>>>>>>> DesignWare core has a TLP digest (TD) override bit in
>>>>>>>> one of the control
>>>>>>>> registers of ATU. This bit also needs to be programmed for=20
>>>>>>>> proper ECRC
>>>>>>>> functionality. This is currently identified as an issue
>>>>>>>> with DesignWare
>>>>>>>> IP version 4.90a.
>>>>>>>>
>>>>>>>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>>>>>>>> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>>>>>>>> ---
>>>>>>>> V2:
>>>>>>>> * Addressed Bjorn's comments
>>>>>>>>
>>>>>>>> =C2=A0=C2=A0=C2=A0 drivers/pci/controller/dwc/pcie-designware.c | =
52
>>>>>>>> ++++++++++++++++++--
>>>>>>>> =C2=A0=C2=A0=C2=A0 drivers/pci/controller/dwc/pcie-designware.h |=
=C2=A0 1 +
>>>>>>>> =C2=A0=C2=A0=C2=A0 2 files changed, 49 insertions(+), 4 deletions(=
-)
>>>>>>>>
>>>>>>>> diff --git
>>>>>>>> a/drivers/pci/controller/dwc/pcie-designware.c
>>>>>>>> b/drivers/pci/controller/dwc/pcie-designware.c
>>>>>>>> index c2dea8fc97c8..ec0d13ab6bad 100644
>>>>>>>> --- a/drivers/pci/controller/dwc/pcie-designware.c
>>>>>>>> +++ b/drivers/pci/controller/dwc/pcie-designware.c
>>>>>>>> @@ -225,6 +225,46 @@ static void
>>>>>>>> dw_pcie_writel_ob_unroll(struct dw_pcie *pci, u32 index,
>>>>>>>> u32 reg,
>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dw_pcie_writel_at=
u(pci, offset + reg, val);
>>>>>>>> =C2=A0=C2=A0=C2=A0 }
>>>>>>>>
>>>>>>>> +static inline u32 dw_pcie_enable_ecrc(u32 val)
>>>>>>>
>>>>>>> What is the reason to use inline here?
>>>>>>
>>>>>> Actually, I wanted to move the programming part inside the
>>>>>> respective APIs
>>>>>> but then I wanted to give some details as well in comments so to=20
>>>>>> avoid
>>>>>> duplication, I came up with this function. But, I'm making it=20
>>>>>> inline for
>>>>>> better code optimization by compiler.
>>>>>
>>>>> I don't really care either way, but I'd be surprised if the compiler
>>>>> didn't inline this all by itself even without the explicit "inline".
>>>> I just checked it and you are right that compiler is indeed inlining i=
t
>>>> without explicitly mentioning 'inline'.
>>>> I hope it is ok to leave it that way.
>>>>
>>>>>
>>>>>>>> +{
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * DesignWare core version 4.90A ha=
s this strange design=20
>>>>>>>> issue
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * where the 'TD' bit in the Contro=
l register-1 of
>>>>>>>> the ATU outbound
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * region acts like an override for=
 the ECRC
>>>>>>>> setting i.e. the presence
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * of TLP Digest(ECRC) in the outgo=
ing TLPs is
>>>>>>>> solely determined by
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * this bit. This is contrary to th=
e PCIe spec
>>>>>>>> which says that the
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * enablement of the ECRC is solely=
 determined by
>>>>>>>> the AER registers.
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Because of this, even when the E=
CRC is enabled through AER
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * registers, the transactions goin=
g through ATU
>>>>>>>> won't have TLP Digest
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * as there is no way the AER sub-s=
ystem could
>>>>>>>> program the TD bit which
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * is specific to DesignWare core.
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * The best way to handle this scen=
ario is to program the=20
>>>>>>>> TD bit
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * always. It affects only the traf=
fic from root
>>>>>>>> port to downstream
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * devices.
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * At this point,
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * When ECRC is enabled in AER regi=
sters,
>>>>>>>> everything works normally
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * When ECRC is NOT enabled in AER =
registers, then,
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * on Root Port:- TLP Digest (DWord=
 size) gets
>>>>>>>> appended to each packet
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 even through it i=
s not required.
>>>>>>>> Since downstream
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TLPs are mostly f=
or
>>>>>>>> configuration accesses and BAR
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 accesses, they ar=
e not in
>>>>>>>> critical path and won't
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 have much negativ=
e effect on the=20
>>>>>>>> performance.
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * on End Point:- TLP Digest is rec=
eived for
>>>>>>>> some/all the packets coming
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from the root por=
t. TLP Digest
>>>>>>>> is ignored because,
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 as per the PCIe S=
pec r5.0 v1.0 section=20
>>>>>>>> 2.2.3
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "TLP Digest Rules=
", when an
>>>>>>>> endpoint receives TLP
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Digest when its E=
CRC check
>>>>>>>> functionality is disabled
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 in AER registers,=
 received TLP
>>>>>>>> Digest is just ignored.
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Since there is no issue or error=
 reported
>>>>>>>> either side, best way to
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * handle the scenario is to progra=
m TD bit by default.
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>>>>>> +
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 return val | PCIE_ATU_TD;
>>>>>>>> +}
