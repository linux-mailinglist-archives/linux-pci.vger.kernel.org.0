Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD49B2B58E0
	for <lists+linux-pci@lfdr.de>; Tue, 17 Nov 2020 05:41:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgKQEit (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Nov 2020 23:38:49 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:3039 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbgKQEis (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Nov 2020 23:38:48 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fb353e20001>; Mon, 16 Nov 2020 20:38:58 -0800
Received: from [10.25.99.52] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 17 Nov
 2020 04:38:39 +0000
Subject: Re: [PATCH 0/3] Add support to handle prefetchable memory
From:   Vidya Sagar <vidyas@nvidia.com>
To:     Thierry Reding <treding@nvidia.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>
CC:     "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
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
Message-ID: <92d5ead4-a3d2-42ba-a542-3e305f3d5523@nvidia.com>
Date:   Tue, 17 Nov 2020 10:08:35 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <53277a71-13e5-3e7e-7c51-aca367b99d31@nvidia.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605587938; bh=LWTX7EIE05huuVD68czK2CHeNKaLvf8HX1JxbzKZqZ4=;
        h=Subject:From:To:CC:References:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=hlMpZPVK5IWiVWi4hFo60n3Z5dQl78lATnhNAnJ6T8ZAUJCg+LOqptVJJ5zF7HB/4
         QOG09llSqyX93OQQgYSeTt+N6Gd78USCu7AZABR4UvTSJkMccU4JpfEzdJq9G88Xkh
         tIHxJFAUw6A642o59EgP8Pm+jdDbQ2q8JXfIOo9qRBz0wwrwciuOqe54/e8KbSm/r5
         WBn7qK/ogKGiLBLlUipVBv5rlMsezqqpHUsxbgDHRTrWXK9zJod+WludPVsmSbEj0/
         o2TZVJbXJOhgwq8ZdyVbnh4Fse4WDSMIlac7hoOufMLxLRQnI+hOPOLpRGHPfgcaJo
         jYemra8sL9H9g==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo & Bjorn,
Sorry to bother you.
Could you please take a look at the patches-1 & 2 from this series?

Thanks,
Vidya Sagar

On 11/4/2020 1:16 PM, Vidya Sagar wrote:
> External email: Use caution opening links or attachments
>=20
>=20
> Lorenzo / Bjorn,
> Could you please review patches-1 & 2 in this series?
> For the third patch, we already went with Rob's patch @
> http://patchwork.ozlabs.org/project/linux-pci/patch/20201026154852.221483=
-1-robh@kernel.org/=20
>=20
>=20
> Thanks,
> Vidya Sagar
>=20
> On 10/26/2020 6:02 PM, Thierry Reding wrote:
>> On Sat, Oct 24, 2020 at 04:03:41AM +0000, Jingoo Han wrote:
>>> On 10/23/20, 3:57 PM, Vidya Sagar wrote:
>>>>
>>>> This patch series adds support for configuring the DesignWare IP's ATU
>>>> region for prefetchable memory translations.
>>>> It first starts by flagging a warning if the size of non-prefetchable
>>>> aperture goes beyond 32-bit as PCIe spec doesn't allow it.
>>>> And then adds required support for programming the ATU to handle highe=
r
>>>> (i.e. >4GB) sizes and then finally adds support for differentiating
>>>> between prefetchable and non-prefetchable regions and configuring=20
>>>> one of
>>>> the ATU regions for prefetchable memory translations purpose.
>>>>
>>>> Vidya Sagar (3):
>>>> =A0=A0 PCI: of: Warn if non-prefetchable memory aperture size is > 32-=
bit
>>>> =A0=A0 PCI: dwc: Add support to program ATU for >4GB memory aperture s=
izes
>>>> =A0=A0 PCI: dwc: Add support to handle prefetchable memory mapping
>>>
>>> For 2nd & 3rd,
>>> Acked-by: Jingoo <jingoohan1@gmail.com>
>>> But, I still want someone to ack 1st patch, not me.
>>>
>>> To Vidya,
>>> If possible, can you ask your coworker to give 'Tested-by'? It will=20
>>> be very helpful.
>>> Thank you.
>>
>> On next-20201026 (but also going back quite a while) I'm seeing this
>> during boot on Jetson AGX Xavier (Tegra194):
>>
>> [=A0=A0=A0 3.493382] ahci 0001:01:00.0: version 3.0
>> [=A0=A0=A0 3.493889] ahci 0001:01:00.0: SSS flag set, parallel bus scan=
=20
>> disabled
>> [=A0=A0=A0 4.497706] ahci 0001:01:00.0: controller reset failed (0xfffff=
fff)
>> [=A0=A0=A0 4.498114] ahci: probe of 0001:01:00.0 failed with error -5
>>
>> After applying this series, AHCI over PCI is back to normal:
>>
>> [=A0=A0=A0 3.543230] ahci 0001:01:00.0: AHCI 0001.0000 32 slots 1 ports =
6=20
>> Gbps 0x1 impl SATA mode
>> [=A0=A0=A0 3.550841] ahci 0001:01:00.0: flags: 64bit ncq sntf led only p=
mp=20
>> fbs pio slum part sxs
>> [=A0=A0=A0 3.559747] scsi host0: ahci
>> [=A0=A0=A0 3.561998] ata1: SATA max UDMA/133 abar m512@0x1230010000 port=
=20
>> 0x1230010100 irq 63
>>
>> So for the series:
>>
>> Tested-by: Thierry Reding <treding@nvidia.com>
>>
