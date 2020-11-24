Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C32B2C22BB
	for <lists+linux-pci@lfdr.de>; Tue, 24 Nov 2020 11:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731896AbgKXKUc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Nov 2020 05:20:32 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:9293 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731895AbgKXKUN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Nov 2020 05:20:13 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fbcde5d0000>; Tue, 24 Nov 2020 02:20:13 -0800
Received: from [10.19.34.61] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 24 Nov
 2020 10:20:05 +0000
Subject: Re: [PATCH V2] PCI: dwc: Add support to configure for ECRC
From:   Vidya Sagar <vidyas@nvidia.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Jingoo Han <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
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
References: <20201111222937.GA977451@bjorn-Precision-5520>
 <a2246e67-4874-f01c-d1bf-1d8a05ffa4b4@nvidia.com>
Message-ID: <40a89fcd-7f8f-fd68-2a01-4008be345c32@nvidia.com>
Date:   Tue, 24 Nov 2020 15:50:01 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <a2246e67-4874-f01c-d1bf-1d8a05ffa4b4@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606213213; bh=MJrpVXD+AsCg7mJmySF5iw8CammHJ6WJGkHPz9F+gXE=;
        h=Subject:From:To:CC:References:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=NZKHPOZNF+D5b6uTw+0bcq6++1iBrEbOr5jr80MSmKt/QuO6XuOQ7XIbAPNd099YZ
         E6ZVXF3I+VkC/Qw9bkuCN878IqdKtyFzCABYgcffRGAZJWb+Giof5ZGoKactSrvF1d
         /6mpe9BDkSHdY8R3Z0UTPxJmJD+MgvypXcFTY7jdrkJrT4CKGijEJWAwEijXfcCv6Q
         hhgfnRxBfVup/+Oo6iHJf1mMoYkGwXbThRXC545quQY6JBIZu0/oEIWaSK7lBPPMwY
         l06WE2V81Gmmc/WW1ZeL68nKOPpFxkESl2/g3YQ2QtQG+iPGppRaDsYypYSJYVx7oC
         AJZu/RsBfiyYw==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,
Please let me know if this patch needs any further modifications

Thanks,
Vidya Sagar

On 11/12/2020 10:32 PM, Vidya Sagar wrote:
> External email: Use caution opening links or attachments
>=20
>=20
> On 11/12/2020 3:59 AM, Bjorn Helgaas wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On Wed, Nov 11, 2020 at 10:21:46PM +0530, Vidya Sagar wrote:
>>>
>>>
>>> On 11/11/2020 9:57 PM, Jingoo Han wrote:
>>>> External email: Use caution opening links or attachments
>>>>
>>>>
>>>> On 11/11/20, 7:12 AM, Vidya Sagar wrote:
>>>>>
>>>>> DesignWare core has a TLP digest (TD) override bit in one of the=20
>>>>> control
>>>>> registers of ATU. This bit also needs to be programmed for proper ECR=
C
>>>>> functionality. This is currently identified as an issue with=20
>>>>> DesignWare
>>>>> IP version 4.90a.
>>>>>
>>>>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>>>>> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>>>>> ---
>>>>> V2:
>>>>> * Addressed Bjorn's comments
>>>>>
>>>>> =C2=A0=C2=A0 drivers/pci/controller/dwc/pcie-designware.c | 52=20
>>>>> ++++++++++++++++++--
>>>>> =C2=A0=C2=A0 drivers/pci/controller/dwc/pcie-designware.h |=C2=A0 1 +
>>>>> =C2=A0=C2=A0 2 files changed, 49 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/drivers/pci/controller/dwc/pcie-designware.c=20
>>>>> b/drivers/pci/controller/dwc/pcie-designware.c
>>>>> index c2dea8fc97c8..ec0d13ab6bad 100644
>>>>> --- a/drivers/pci/controller/dwc/pcie-designware.c
>>>>> +++ b/drivers/pci/controller/dwc/pcie-designware.c
>>>>> @@ -225,6 +225,46 @@ static void dw_pcie_writel_ob_unroll(struct=20
>>>>> dw_pcie *pci, u32 index, u32 reg,
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dw_pcie_writel_atu(pci, of=
fset + reg, val);
>>>>> =C2=A0=C2=A0 }
>>>>>
>>>>> +static inline u32 dw_pcie_enable_ecrc(u32 val)
>>>>
>>>> What is the reason to use inline here?
>>>
>>> Actually, I wanted to move the programming part inside the respective=20
>>> APIs
>>> but then I wanted to give some details as well in comments so to avoid
>>> duplication, I came up with this function. But, I'm making it inline fo=
r
>>> better code optimization by compiler.
>>
>> I don't really care either way, but I'd be surprised if the compiler
>> didn't inline this all by itself even without the explicit "inline".
> I just checked it and you are right that compiler is indeed inlining it
> without explicitly mentioning 'inline'.
> I hope it is ok to leave it that way.
>=20
>>
>>>>> +{
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * DesignWare core version 4.90A has t=
his strange design issue
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * where the 'TD' bit in the Control r=
egister-1 of the ATU=20
>>>>> outbound
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * region acts like an override for th=
e ECRC setting i.e. the=20
>>>>> presence
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * of TLP Digest(ECRC) in the outgoing=
 TLPs is solely=20
>>>>> determined by
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * this bit. This is contrary to the P=
CIe spec which says=20
>>>>> that the
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * enablement of the ECRC is solely de=
termined by the AER=20
>>>>> registers.
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Because of this, even when the ECRC=
 is enabled through AER
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * registers, the transactions going t=
hrough ATU won't have=20
>>>>> TLP Digest
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * as there is no way the AER sub-syst=
em could program the TD=20
>>>>> bit which
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * is specific to DesignWare core.
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * The best way to handle this scenari=
o is to program the TD bit
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * always. It affects only the traffic=
 from root port to=20
>>>>> downstream
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * devices.
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * At this point,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * When ECRC is enabled in AER registe=
rs, everything works=20
>>>>> normally
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * When ECRC is NOT enabled in AER reg=
isters, then,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * on Root Port:- TLP Digest (DWord si=
ze) gets appended to=20
>>>>> each packet
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 even through it is n=
ot required. Since=20
>>>>> downstream
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TLPs are mostly for =
configuration accesses=20
>>>>> and BAR
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 accesses, they are n=
ot in critical path and=20
>>>>> won't
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 have much negative e=
ffect on the performance.
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * on End Point:- TLP Digest is receiv=
ed for some/all the=20
>>>>> packets coming
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from the root port. =
TLP Digest is ignored=20
>>>>> because,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 as per the PCIe Spec=
 r5.0 v1.0 section 2.2.3
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "TLP Digest Rules", =
when an endpoint=20
>>>>> receives TLP
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Digest when its ECRC=
 check functionality is=20
>>>>> disabled
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 in AER registers, re=
ceived TLP Digest is=20
>>>>> just ignored.
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Since there is no issue or error re=
ported either side,=20
>>>>> best way to
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * handle the scenario is to program T=
D bit by default.
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>>> +
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 return val | PCIE_ATU_TD;
>>>>> +}
