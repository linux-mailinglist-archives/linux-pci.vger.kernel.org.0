Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 106832B6BD5
	for <lists+linux-pci@lfdr.de>; Tue, 17 Nov 2020 18:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbgKQRfL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Nov 2020 12:35:11 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:16663 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbgKQRfL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Nov 2020 12:35:11 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fb409c50000>; Tue, 17 Nov 2020 09:35:01 -0800
Received: from [10.25.99.52] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 17 Nov
 2020 17:35:01 +0000
Subject: Re: [PATCH 0/3] Add support to handle prefetchable memoryg
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Thierry Reding <treding@nvidia.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "amurray@thegoodpenguin.co.uk" <amurray@thegoodpenguin.co.uk>,
        "robh@kernel.org" <robh@kernel.org>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kthota@nvidia.com" <kthota@nvidia.com>,
        "mmaddireddy@nvidia.com" <mmaddireddy@nvidia.com>,
        "sagar.tv@gmail.com" <sagar.tv@gmail.com>
References: <20201023195655.11242-1-vidyas@nvidia.com>
 <SLXP216MB04777D651A59246A60D036A8AA1B0@SLXP216MB0477.KORP216.PROD.OUTLOOK.COM>
 <20201026123012.GA356750@ulmo>
 <53277a71-13e5-3e7e-7c51-aca367b99d31@nvidia.com>
 <92d5ead4-a3d2-42ba-a542-3e305f3d5523@nvidia.com>
 <20201117121011.GA6050@e121166-lin.cambridge.arm.com>
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <f4d87b99-5a5b-e7de-e72a-18407a875aeb@nvidia.com>
Date:   Tue, 17 Nov 2020 23:04:57 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201117121011.GA6050@e121166-lin.cambridge.arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605634501; bh=BveVLnsDjnYJ3hmmRmttCms4YrIKDQZf7HcE5RYng70=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=EH00Z/kCnd6eL6XI3vVuskJdBgpGlBiA0cFummLuDNm4lipW4ucZAa9noOh2GuD2C
         KW6LNh7b0xWzfNlmZlQgk9jDvAank+x//Zx8WUJiIRSaCqeG9Mk1Eb8bKHKxhNZaV9
         iEzqLpXyem4iy8ymUkf8CFDdKCjeAImrWxJbI4EUymAnMfHvDH73z3yFAYe9CoDdli
         G4I8BdUmH6VSUdRUsrLfu+HsewxvGp/nhf4Hob3q2J0DPKry7BOdBrsHj+v3y/U3k0
         LSD6RA+q//bQ0ISW4xELs5yg6HQ7fdGdzOXA+ZO6pLg70lfd0jvXi1aEU1MxurnisS
         Itrj6fy0QYjng==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 11/17/2020 5:40 PM, Lorenzo Pieralisi wrote:
> External email: Use caution opening links or attachments
>=20
>=20
> On Tue, Nov 17, 2020 at 10:08:35AM +0530, Vidya Sagar wrote:
>> Hi Lorenzo & Bjorn,
>> Sorry to bother you.
>> Could you please take a look at the patches-1 & 2 from this series?
>=20
> IIUC we should:
>=20
> (1) apply https://patchwork.kernel.org/project/linux-pci/patch/2020102618=
1652.418729-1-robh@kernel.org
> (2) apply [1,2] from this series
>=20
> For (2), are they rebased against v5.10-rc3 with (1) applied ? I need to
> check but I will probably have to use v5.10-rc3 as baseline owing to
> commit:
>=20
> 9fff3256f93d
>=20
> (1) depends on it.
>=20
> Lorenzo
My patches [1,2] from this series apply cleanly on v5.10-rc3. But with=20
(1) applied first, there is a trivial rebase required. Let me know if=20
you want me to send the trivial rebased version (of patch-2 particularly).

Thanks,
Vidya Sagar
>=20
>> Thanks,
>> Vidya Sagar
>>
>> On 11/4/2020 1:16 PM, Vidya Sagar wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> Lorenzo / Bjorn,
>>> Could you please review patches-1 & 2 in this series?
>>> For the third patch, we already went with Rob's patch @
>>> http://patchwork.ozlabs.org/project/linux-pci/patch/20201026154852.2214=
83-1-robh@kernel.org/
>>>
>>>
>>> Thanks,
>>> Vidya Sagar
>>>
>>> On 10/26/2020 6:02 PM, Thierry Reding wrote:
>>>> On Sat, Oct 24, 2020 at 04:03:41AM +0000, Jingoo Han wrote:
>>>>> On 10/23/20, 3:57 PM, Vidya Sagar wrote:
>>>>>>
>>>>>> This patch series adds support for configuring the DesignWare IP's A=
TU
>>>>>> region for prefetchable memory translations.
>>>>>> It first starts by flagging a warning if the size of non-prefetchabl=
e
>>>>>> aperture goes beyond 32-bit as PCIe spec doesn't allow it.
>>>>>> And then adds required support for programming the ATU to handle hig=
her
>>>>>> (i.e. >4GB) sizes and then finally adds support for differentiating
>>>>>> between prefetchable and non-prefetchable regions and
>>>>>> configuring one of
>>>>>> the ATU regions for prefetchable memory translations purpose.
>>>>>>
>>>>>> Vidya Sagar (3):
>>>>>>     PCI: of: Warn if non-prefetchable memory aperture size is > 32-b=
it
>>>>>>     PCI: dwc: Add support to program ATU for >4GB memory aperture si=
zes
>>>>>>     PCI: dwc: Add support to handle prefetchable memory mapping
>>>>>
>>>>> For 2nd & 3rd,
>>>>> Acked-by: Jingoo <jingoohan1@gmail.com>
>>>>> But, I still want someone to ack 1st patch, not me.
>>>>>
>>>>> To Vidya,
>>>>> If possible, can you ask your coworker to give 'Tested-by'? It
>>>>> will be very helpful.
>>>>> Thank you.
>>>>
>>>> On next-20201026 (but also going back quite a while) I'm seeing this
>>>> during boot on Jetson AGX Xavier (Tegra194):
>>>>
>>>> [=C2=A0=C2=A0=C2=A0 3.493382] ahci 0001:01:00.0: version 3.0
>>>> [=C2=A0=C2=A0=C2=A0 3.493889] ahci 0001:01:00.0: SSS flag set, paralle=
l bus scan
>>>> disabled
>>>> [=C2=A0=C2=A0=C2=A0 4.497706] ahci 0001:01:00.0: controller reset fail=
ed (0xffffffff)
>>>> [=C2=A0=C2=A0=C2=A0 4.498114] ahci: probe of 0001:01:00.0 failed with =
error -5
>>>>
>>>> After applying this series, AHCI over PCI is back to normal:
>>>>
>>>> [=C2=A0=C2=A0=C2=A0 3.543230] ahci 0001:01:00.0: AHCI 0001.0000 32 slo=
ts 1 ports 6
>>>> Gbps 0x1 impl SATA mode
>>>> [=C2=A0=C2=A0=C2=A0 3.550841] ahci 0001:01:00.0: flags: 64bit ncq sntf=
 led only pmp
>>>> fbs pio slum part sxs
>>>> [=C2=A0=C2=A0=C2=A0 3.559747] scsi host0: ahci
>>>> [=C2=A0=C2=A0=C2=A0 3.561998] ata1: SATA max UDMA/133 abar m512@0x1230=
010000 port
>>>> 0x1230010100 irq 63
>>>>
>>>> So for the series:
>>>>
>>>> Tested-by: Thierry Reding <treding@nvidia.com>
>>>>
