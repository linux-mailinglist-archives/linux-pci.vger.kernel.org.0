Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D791F2AA51C
	for <lists+linux-pci@lfdr.de>; Sat,  7 Nov 2020 13:54:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbgKGMyv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 7 Nov 2020 07:54:51 -0500
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:26454 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727264AbgKGMyu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 7 Nov 2020 07:54:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1604753686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=DM5/cisW5hyBXovQeTQEPLEaghMCwqhlyj8qSGZyNXA=;
        b=BpSB3+aW8GQlz24n1VQab/tcH6qq8xXdLoA09wvz4AK15uKccEvb6t5FNATbgjgvBXc26u
        L64hS1XskuxRsgRKgjv1nFkROk+1u0YsyWvnesk/99hqK+vZP8qtXj6MTqcjnvRoeZZiQ/
        tDKb7JldNRWza0/3Cxc92yx4vDOEb9c=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2058.outbound.protection.outlook.com [104.47.13.58]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-40-Fn2uB74bMIumZmHagVzHWw-1; Sat, 07 Nov 2020 13:54:44 +0100
X-MC-Unique: Fn2uB74bMIumZmHagVzHWw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aI47dmeG1CRu5zciONrOIkLUVZsoIWV+T90Y5ELR15cB1gre2mNrct4i+8SeuKGduvs25i+FprBxoYdn3tmvs+zeve+GJtHyD9sZke5IRqupS8jWLA2DNGfOJO4VFGm2SVhZhcsSPcXok5LIBIadTMfWK2sF56yAmBf79PpgMmwhXd1Ok8TIVATzMQXC0Iub1s0+YLJkN4bYvrNps8AVDWQ5kGK+/Fd1ZKOqE9wLKnKzbOO+7NDDQDjVk5Ff2aOyQrRvQrMqwnvoeMAS5nVkzkKKG/jTt5HXPx8Ap3qGb7AFjmuxnlq1c8vwuFzBxX4EuFm12ZZnoTRTmc1DGj/DOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LLO303r0K9fGq3zFTaw+IzdhWW0Rd1vnrNQj9dXon88=;
 b=YkUUqtu1Mq5VlZ+59hNFi2kIL4bzXJBcVSNA3Q4Fr9Xn3GdxduF8gJu+AnOQeP0RIwYZTi0Myihb2eaVYuTimDCWMhdH/QH0bOYATJyZcg8hhTHkKWZrdyCjG+HZej1nWlvjk4sVpLhdte0Dq92OozE1INiKhd3f8UGVszV5eEpkaVvIF56A2xjD/ddUmTNki5Jifj2S5EUFP9lPS/ShCofDZW3FiQNzBcO9KyecPTPfqSRLe/IKjI0bWsHrCRr/7xZn5spw8teCHEc3joTowEvrrEN5eB5kUW09mVG73f5W04vSTkzmfOv4YRWod40sXfPujx7QgGz0JgIPs4GRcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=suse.com;
Received: from PA4PR04MB7533.eurprd04.prod.outlook.com (2603:10a6:102:f1::19)
 by PA4PR04MB7504.eurprd04.prod.outlook.com (2603:10a6:102:e6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Sat, 7 Nov
 2020 12:54:42 +0000
Received: from PA4PR04MB7533.eurprd04.prod.outlook.com
 ([fe80::545:8a04:2a5c:f4c7]) by PA4PR04MB7533.eurprd04.prod.outlook.com
 ([fe80::545:8a04:2a5c:f4c7%6]) with mapi id 15.20.3541.022; Sat, 7 Nov 2020
 12:54:42 +0000
Subject: Re: [PATCH 1/2] PCI: rockchip: Make some regulators non-optional
To:     Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     heiko@sntech.de, linux-pci@vger.kernel.org,
        shawn.lin@rock-chips.com, lgirdwood@gmail.com,
        linux-rockchip@lists.infradead.org, broonie@kernel.org,
        bhelgaas@google.com, andrew.murray@arm.com,
        linux-arm-kernel@lists.infradead.org
References: <1eebc002101931012d337cda23d18f85b0326361.1573908530.git.robin.murphy@arm.com>
 <20191120170532.GC3279@e121166-lin.cambridge.arm.com>
 <e8a91353-49ab-7581-f2a8-b8b4729072bf@suse.com>
 <4885f7f6-f71e-7d07-6096-7eb061001815@arm.com>
From:   Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0GFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPokBTQQTAQgAOAIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJdnDWhAAoJEMI9kfOhJf6oZgoH
 90uqoGyUh5UWtiT9zjUcvlMTCpd/QSgwagDuY+tEdVPaKlcnTNAvZKWSit8VuocjrOFbTLwb
 vZ43n5f/l/1QtwMgQei/RMY2XhW+totimzlHVuxVaIDwkF+zc+pUI6lDPnULZHS3mWhbVr9N
 vZAAYVV7GesyyFpZiNm7GLvLmtEdYbc9OnIAOZb3eKfY3mWEs0eU0MxikcZSOYy3EWY3JES7
 J9pFgBrCn4hF83tPH2sphh1GUFii+AUGBMY/dC6VgMKbCugg+u/dTZEcBXxD17m+UcbucB/k
 F2oxqZBEQrb5SogdIq7Y9dZdlf1m3GRRJTX7eWefZw10HhFhs1mwx7kBDQRZ1YGvAQgAqlPr
 YeBLMv3PAZ75YhQIwH6c4SNcB++hQ9TCT5gIQNw51+SQzkXIGgmzxMIS49cZcE4KXk/kHw5h
 ieQeQZa60BWVRNXwoRI4ib8okgDuMkD5Kz1WEyO149+BZ7HD4/yK0VFJGuvDJR8T7RZwB69u
 VSLjkuNZZmCmDcDzS0c/SJOg5nkxt1iTtgUETb1wNKV6yR9XzRkrEW/qShChyrS9fNN8e9c0
 MQsC4fsyz9Ylx1TOY/IF/c6rqYoEEfwnpdlz0uOM1nA1vK+wdKtXluCa79MdfaeD/dt76Kp/
 o6CAKLLcjU1Iwnkq1HSrYfY3HZWpvV9g84gPwxwxX0uXquHxLwARAQABiQE8BBgBCAAmAhsM
 FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2cNa4FCQlqTn8ACgkQwj2R86El/qhXBAf/eXLP
 HDNTkHRPxoDnwhscIHJDHlsszke25AFltJQ1adoaYCbsQVv4Mn5rQZ1Gon54IMdxBN3r/B08
 rGVPatIfkycMCShr+rFHPKnExhQ7Wr555fq+sQ1GOwOhr1xLEqAhBMp28u9m8hnkqL36v+AF
 hjTwRtS+tRMZfoG6n72xAj984l56G9NPfs/SOKl6HR0mCDXwJGZAOdtyRmqddi53SXi5N4H1
 jWX1xFshp7nIkRm6hEpISEWr/KKLbAiKKbP0ql5tP5PinJeIBlDv4g/0+aGoGg4dELTnfEVk
 jMC8cJ/LiIaR/OEOF9S2nSeTQoBmusTz+aqkbogvvYGam6uDYw==
Message-ID: <b96b1149-d2fd-c131-c329-3e1c0cf3689d@suse.com>
Date:   Sat, 7 Nov 2020 20:54:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <4885f7f6-f71e-7d07-6096-7eb061001815@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [149.28.201.231]
X-ClientProxiedBy: SJ0PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::32) To PA4PR04MB7533.eurprd04.prod.outlook.com
 (2603:10a6:102:f1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by SJ0PR03CA0027.namprd03.prod.outlook.com (2603:10b6:a03:33a::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Sat, 7 Nov 2020 12:54:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd51b5e9-23dc-4082-ea64-08d8831c4b39
X-MS-TrafficTypeDiagnostic: PA4PR04MB7504:
X-Microsoft-Antispam-PRVS: <PA4PR04MB750426DDBF187D16B9B0AAD5D6EC0@PA4PR04MB7504.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FkLcOWylSCbwci5nwdhMmzcYrQLruaE/tYtMxvXlflQyBQB17Jw0tdfCf/L1BbNnbFZIMYGvg/Z0k3AqvJMaxwkqD+/Hiz8oBiPVTJszTmFWD5VPm+S4/mpFfDNxoAwXLeKMEqFETdwhTBt7RydteU6/CaYt7ZvepUYrO1JBxfXVOsqfDjP10/pDt1qy4hOD/giSua2bajIKakGLTbaDhYcnCb1IayLXwk430rwyaPTePI4ADV18ok0shWt9KRdUBsKLAt4ihVAH4D0+8KrDvYgOBAqXVr8qZfixTABzb4UKIY9ythBcnQ9uNx4qixLF2fVfTLyJCwUEYhEiqSy/IUo0C8mt/jvUBm3NLK8Nrt+DLmk1gK/MEPvkwSx3g1SUxN+R9zQiAW2klSNlHXTiLgNEvZIUEfSUoJ1uwqsioxqf0yDOygGFtlkA/HVBQNWbz0ju7e6MrF+6rL+88pSRbKz+73BPOJUD4rYfjwnVn88=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7533.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(136003)(346002)(396003)(366004)(86362001)(6706004)(6666004)(83380400001)(316002)(2906002)(16576012)(66946007)(16526019)(36756003)(8676002)(6486002)(110136005)(5660300002)(956004)(8936002)(31686004)(186003)(31696002)(2616005)(4326008)(478600001)(966005)(53546011)(26005)(66556008)(52116002)(7416002)(66476007)(78286007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: YCdHCBsmFTWxKm4xAKxdnKysbr6U5UHXUoma1Moswfpc5jwzdVg60DvUarxFbhl/vNg5V/azD8R4j7KkPgVawnb2OKzlWbprTLXIkh4iJZ6g1td0N423Q5/3P2ERHBjAGHpiyqgXJw5uz0vEaJAziGhEOGRzsQIsRyM7ewe7mpYCeqlNOii1Q2liFUuPrwD302Y1ZLrAqDUvm46BB3hUdqd4AIOhhNJxyYhPWSfJGPtl204cmg87GHxCWtSpPZIySjKwnrL86cFk3YLm1paK8+pLxHDm9CoPsr0ugGx3ocFoWpTYi591ZmFGPL6lr9mc6Hq5P1CdSa7IUYjNUbuptm2K6EOb6Z5lHLnNzxzWD+Pqi4U22bVll9YOC4avMOxAk0m9o3qg/ebiahMLiDgAHn2iqsP1kqn6JAiMARiPQD3QFXwlYaY8+zpbAjv2ttY8Q+QUQ3eiPIFiGoTC6qRlJ4riNHZJUyk6uA1HCWLAqt1EvYbqRY3RhTjxopNvgaBZn+WEw/Fkh2uTuenKmXP0p/GPuhAcnXggLlCqDDLWws6EglTTT9tnD4HxNUOKHP2I3dHSfQEPv9SigyBOgCmDuTzatSIWocYu47yksp31xffVSzCbnhyNH3paNprWpO3y3J1Dwf/yjRfMROww4XoV+A==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd51b5e9-23dc-4082-ea64-08d8831c4b39
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7533.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2020 12:54:41.8758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EeinOJTo/8ZFiCiZTT8Y8fhSlNSUxGoV84SjNB+be8LzF42pVafAaFFSlnknkxPq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7504
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2020/11/7 =E4=B8=8B=E5=8D=888:47, Robin Murphy wrote:
> On 2020-11-07 11:36, Qu Wenruo wrote:
>>
>>
>> On 2019/11/21 =E4=B8=8A=E5=8D=881:05, Lorenzo Pieralisi wrote:
>>> On Sat, Nov 16, 2019 at 12:54:19PM +0000, Robin Murphy wrote:
>>>> The 0V9 and 1V8 supplies power the PCIe block in the SoC itself, and
>>>> are thus fundamental to PCIe being usable at all. As such, it makes
>>>> sense to treat them as non-optional and rely on dummy regulators if
>>>> not explicitly described.
>>>>
>>>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>>>> ---
>>>> =C2=A0 drivers/pci/controller/pcie-rockchip-host.c | 69
>>>> ++++++++-------------
>>>> =C2=A0 1 file changed, 25 insertions(+), 44 deletions(-)
>>>
>>> Applied to pci/rockchip, thanks.
>>
>> Sorry, this commit is cause regression for RK3399 boards unable to
>> detect the controller anymore.
>>
>> The 1v8 (and 0v9) is causing -517 and reject the controller
>> initialization.
>=20
> That's -EPROBE_DEFER, which must mean that a regulator *is* described,
> but you're missing the relevant driver - that's an issue with your
> config/initrd. Being optional should only change the behaviour if the
> supply is totally absent (i.e. you get -ENODEV instead of a dummy
> regulator), so I don't see that it would make any difference in this
> situation anyway :/
>=20
>> I'm not a PCI guy, but a quick google search shows these two voltages
>> are not related to PCIE core functionality, especially considering the
>> controller used in RK3399 are mostly to provide NVME support.
>=20
> Unlike the 12V and 3V3 supplies to the slot, these supplies are to the
> PCIE_AVDD_0V9 and PCIE_AVDD_1V8 pins on the SoC itself, which the
> datasheet describe as "Supply voltage for PCIE". Having power is kind of
> important for the I/O circuits on all the signal pins to work.
>=20
> Now it's almost certainly true that these supplies technically belong to
> the phy rather than the controller, but it's a bit late to change the
> bindings for the sake of semantics.
>=20
>> This bug makes all RK3399 users who put root fs into NVME driver unable
>> to boot the device.
>>
>> I really hope some one could test the patch before affecting the end
>> users or at least try to understand how most users would use the PCIE
>> interface for.
>=20
> I *am* that end user in this case - I use an M.2 NVME on my board, which
> prompted me to take a look at the regulator handling here in the first
> place, to see if it might be possible to shut up the annoying message
> about a 12V supply that is entirely irrelevant to a board without a
> full-size PCIe slot. I use a mainline-based distro, so I've been running
> this change for nearly a year since it landed in v5.5, and I'm sure many
> others have too. I've not heard of any other complaints in that time...

Sorry for the wrong wording, thank you for your contribution first.

It really makes RK3399 the primary testing bed for 64K page size, and
save me a lot of time.

I'm wondering how the -EPROBE_DEFER happens.
I have only tested two kernel versions, v5.9-rc4 and v5.10-rc2.
The config works for rc4, unless something big changed in rc2, it
shouldn't change much, right?

The 1v8 and 0v9 is just alwayson regulator, IMHO it doesn't really need
special driver.
Or does it?

Thanks,
Qu

>=20
> Robin.
>=20
>>
>> Thanks,
>> Qu
>>
>>>
>>> Lorenzo
>>>
>>>> diff --git a/drivers/pci/controller/pcie-rockchip-host.c
>>>> b/drivers/pci/controller/pcie-rockchip-host.c
>>>> index ef8e677ce9d1..68525f8ac4d9 100644
>>>> --- a/drivers/pci/controller/pcie-rockchip-host.c
>>>> +++ b/drivers/pci/controller/pcie-rockchip-host.c
>>>> @@ -620,19 +620,13 @@ static int rockchip_pcie_parse_host_dt(struct
>>>> rockchip_pcie *rockchip)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_info(dev, "=
no vpcie3v3 regulator found\n");
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> =C2=A0 -=C2=A0=C2=A0=C2=A0 rockchip->vpcie1v8 =3D devm_regulator_get_o=
ptional(dev,
>>>> "vpcie1v8");
>>>> -=C2=A0=C2=A0=C2=A0 if (IS_ERR(rockchip->vpcie1v8)) {
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (PTR_ERR(rockchip->vpci=
e1v8) !=3D -ENODEV)
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn PTR_ERR(rockchip->vpcie1v8);
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_info(dev, "no vpcie1v8=
 regulator found\n");
>>>> -=C2=A0=C2=A0=C2=A0 }
>>>> +=C2=A0=C2=A0=C2=A0 rockchip->vpcie1v8 =3D devm_regulator_get(dev, "vp=
cie1v8");
>>>> +=C2=A0=C2=A0=C2=A0 if (IS_ERR(rockchip->vpcie1v8))
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return PTR_ERR(rockchip->v=
pcie1v8);
>>>> =C2=A0 -=C2=A0=C2=A0=C2=A0 rockchip->vpcie0v9 =3D devm_regulator_get_o=
ptional(dev,
>>>> "vpcie0v9");
>>>> -=C2=A0=C2=A0=C2=A0 if (IS_ERR(rockchip->vpcie0v9)) {
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (PTR_ERR(rockchip->vpci=
e0v9) !=3D -ENODEV)
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn PTR_ERR(rockchip->vpcie0v9);
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_info(dev, "no vpcie0v9=
 regulator found\n");
>>>> -=C2=A0=C2=A0=C2=A0 }
>>>> +=C2=A0=C2=A0=C2=A0 rockchip->vpcie0v9 =3D devm_regulator_get(dev, "vp=
cie0v9");
>>>> +=C2=A0=C2=A0=C2=A0 if (IS_ERR(rockchip->vpcie0v9))
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return PTR_ERR(rockchip->v=
pcie0v9);
>>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>>> =C2=A0 }
>>>> @@ -658,27 +652,22 @@ static int rockchip_pcie_set_vpcie(struct
>>>> rockchip_pcie *rockchip)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> =C2=A0 -=C2=A0=C2=A0=C2=A0 if (!IS_ERR(rockchip->vpcie1v8)) {
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D regulator_enable(r=
ockchip->vpcie1v8);
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (err) {
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 de=
v_err(dev, "fail to enable vpcie1v8 regulator\n");
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 go=
to err_disable_3v3;
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> +=C2=A0=C2=A0=C2=A0 err =3D regulator_enable(rockchip->vpcie1v8);
>>>> +=C2=A0=C2=A0=C2=A0 if (err) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_err(dev, "fail to enab=
le vpcie1v8 regulator\n");
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto err_disable_3v3;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> =C2=A0 -=C2=A0=C2=A0=C2=A0 if (!IS_ERR(rockchip->vpcie0v9)) {
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D regulator_enable(r=
ockchip->vpcie0v9);
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (err) {
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 de=
v_err(dev, "fail to enable vpcie0v9 regulator\n");
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 go=
to err_disable_1v8;
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> +=C2=A0=C2=A0=C2=A0 err =3D regulator_enable(rockchip->vpcie0v9);
>>>> +=C2=A0=C2=A0=C2=A0 if (err) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_err(dev, "fail to enab=
le vpcie0v9 regulator\n");
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto err_disable_1v8;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>>> =C2=A0 =C2=A0 err_disable_1v8:
>>>> -=C2=A0=C2=A0=C2=A0 if (!IS_ERR(rockchip->vpcie1v8))
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 regulator_disable(rockchip=
->vpcie1v8);
>>>> +=C2=A0=C2=A0=C2=A0 regulator_disable(rockchip->vpcie1v8);
>>>> =C2=A0 err_disable_3v3:
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!IS_ERR(rockchip->vpcie3v3))
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 regulator_disab=
le(rockchip->vpcie3v3);
>>>> @@ -897,8 +886,7 @@ static int __maybe_unused
>>>> rockchip_pcie_suspend_noirq(struct device *dev)
>>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rockchip_pcie_disable_clocks(roc=
kchip);
>>>> =C2=A0 -=C2=A0=C2=A0=C2=A0 if (!IS_ERR(rockchip->vpcie0v9))
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 regulator_disable(rockchip=
->vpcie0v9);
>>>> +=C2=A0=C2=A0=C2=A0 regulator_disable(rockchip->vpcie0v9);
>>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>>>> =C2=A0 }
>>>> @@ -908,12 +896,10 @@ static int __maybe_unused
>>>> rockchip_pcie_resume_noirq(struct device *dev)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct rockchip_pcie *rockchip =3D dev_=
get_drvdata(dev);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int err;
>>>> =C2=A0 -=C2=A0=C2=A0=C2=A0 if (!IS_ERR(rockchip->vpcie0v9)) {
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D regulator_enable(r=
ockchip->vpcie0v9);
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (err) {
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 de=
v_err(dev, "fail to enable vpcie0v9 regulator\n");
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn err;
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> +=C2=A0=C2=A0=C2=A0 err =3D regulator_enable(rockchip->vpcie0v9);
>>>> +=C2=A0=C2=A0=C2=A0 if (err) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_err(dev, "fail to enab=
le vpcie0v9 regulator\n");
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return err;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D rockchip_pcie_enable_clo=
cks(rockchip);
>>>> @@ -939,8 +925,7 @@ static int __maybe_unused
>>>> rockchip_pcie_resume_noirq(struct device *dev)
>>>> =C2=A0 err_pcie_resume:
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rockchip_pcie_disable_clocks(rockchip);
>>>> =C2=A0 err_disable_0v9:
>>>> -=C2=A0=C2=A0=C2=A0 if (!IS_ERR(rockchip->vpcie0v9))
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 regulator_disable(rockchip=
->vpcie0v9);
>>>> +=C2=A0=C2=A0=C2=A0 regulator_disable(rockchip->vpcie0v9);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return err;
>>>> =C2=A0 }
>>>> =C2=A0 @@ -1081,10 +1066,8 @@ static int rockchip_pcie_probe(struct
>>>> platform_device *pdev)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 regulator_disab=
le(rockchip->vpcie12v);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!IS_ERR(rockchip->vpcie3v3))
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 regulator_disab=
le(rockchip->vpcie3v3);
>>>> -=C2=A0=C2=A0=C2=A0 if (!IS_ERR(rockchip->vpcie1v8))
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 regulator_disable(rockchip=
->vpcie1v8);
>>>> -=C2=A0=C2=A0=C2=A0 if (!IS_ERR(rockchip->vpcie0v9))
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 regulator_disable(rockchip=
->vpcie0v9);
>>>> +=C2=A0=C2=A0=C2=A0 regulator_disable(rockchip->vpcie1v8);
>>>> +=C2=A0=C2=A0=C2=A0 regulator_disable(rockchip->vpcie0v9);
>>>> =C2=A0 err_set_vpcie:
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rockchip_pcie_disable_clocks(rockchip);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return err;
>>>> @@ -1108,10 +1091,8 @@ static int rockchip_pcie_remove(struct
>>>> platform_device *pdev)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 regulator_disab=
le(rockchip->vpcie12v);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!IS_ERR(rockchip->vpcie3v3))
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 regulator_disab=
le(rockchip->vpcie3v3);
>>>> -=C2=A0=C2=A0=C2=A0 if (!IS_ERR(rockchip->vpcie1v8))
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 regulator_disable(rockchip=
->vpcie1v8);
>>>> -=C2=A0=C2=A0=C2=A0 if (!IS_ERR(rockchip->vpcie0v9))
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 regulator_disable(rockchip=
->vpcie0v9);
>>>> +=C2=A0=C2=A0=C2=A0 regulator_disable(rockchip->vpcie1v8);
>>>> +=C2=A0=C2=A0=C2=A0 regulator_disable(rockchip->vpcie0v9);
>>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>>> =C2=A0 }
>>>> --=C2=A0
>>>> 2.17.1
>>>>
>>>
>>> _______________________________________________
>>> linux-arm-kernel mailing list
>>> linux-arm-kernel@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>>
>>
>=20

