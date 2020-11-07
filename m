Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0602E2AA562
	for <lists+linux-pci@lfdr.de>; Sat,  7 Nov 2020 14:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbgKGNbc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 7 Nov 2020 08:31:32 -0500
Received: from de-smtp-delivery-102.mimecast.com ([51.163.158.102]:42990 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727084AbgKGNbb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 7 Nov 2020 08:31:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1604755886;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=1B5rOeLa9aZXljZ7GWy8NIb3QDW1l/SLNGMbmqM5mLg=;
        b=IIgIsMvwIp+qNcuEVa7DSm4061ohC1NHCLG4OQnyBBhdLmxfsskMP3O7Ja3ByvRL7g9koQ
        obVORmuMwIthMuE741HgWuiW/8R2X+2Gj8DT5iHvx4YfMQ6s9SuzV3N/fNYz/9PCz9gSOf
        MeOepthc5eMGe25GZ4hjxyGt014HIZ4=
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur03lp2056.outbound.protection.outlook.com [104.47.10.56]) (Using
 TLS) by relay.mimecast.com with ESMTP id de-mta-9-VTt4XM0oPYyE0QC3eGTHOQ-1;
 Sat, 07 Nov 2020 14:31:25 +0100
X-MC-Unique: VTt4XM0oPYyE0QC3eGTHOQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D3lnQmduKPxhgrFlTpRCxVDJlb/iD/fPhd4vUfejiuyEnFk2daGiYDXUPyQxteEJ0eLj9YQhinHUCNCV1Xu3ZkPkGLFYs1hIOECI0rNmq/Fqzh+xlq5xKYseRhJQ20tAW9ukd/be7BApiKFhhxx+hrajIRVrIlUlOc6TSJV4AlQ4ql9yEqZEd/L16zB5VZr75wK7IcdDiD9LF3BDsh1UlpGsiyQJX/mchUwZ89ZMyIQiiomhZhYY/7NobOO9EHR68oC0Pvo/k0KYo4kBDpiYo6HjwcuM7lFElFEryx8PSloWoqnHSgCv+GpD1CY7Cj0DBOMybeCma1vrGjzyTfSk7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bqzfnpa5n+bW/XxI6rhbx+lrLJnFxsqUW3yU3abLI5M=;
 b=Gi44jWer4giqLYlAb/eJt26ST7AvrULUtMMSwko4PBT9PKuyLA+UL7+4NUkjjxtrrL62G9QwPq2faiocdim8MQa0TQvukbrjL61ajClUxm0Kiz1lF1N0jUqUsWvKr9wkWunjVqm0ikFQ2v5ukXGYviqV4QjjmAtBY4Wa0H7kXj7A9nCZDhN41uiu0/uoIKZCHMsRmfLoCZyAmZ5rxfwUd1EVtqC5ELMHUApgPVx66F9U5wU8PJZr4/paiNCFT3VlL3b9g/0mmAeWFyw6RK//q0PjGr5Bu0ueiO8aC0Sty4lhEAaPBrIRpsOpo+sA8Vk982AT9ZUfMwvGmBalkFcwLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=suse.com;
Received: from PA4PR04MB7533.eurprd04.prod.outlook.com (2603:10a6:102:f1::19)
 by PR3PR04MB7435.eurprd04.prod.outlook.com (2603:10a6:102:88::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Sat, 7 Nov
 2020 13:31:24 +0000
Received: from PA4PR04MB7533.eurprd04.prod.outlook.com
 ([fe80::545:8a04:2a5c:f4c7]) by PA4PR04MB7533.eurprd04.prod.outlook.com
 ([fe80::545:8a04:2a5c:f4c7%6]) with mapi id 15.20.3541.022; Sat, 7 Nov 2020
 13:31:24 +0000
Subject: Re: [PATCH 1/2] PCI: rockchip: Make some regulators non-optional
From:   Qu Wenruo <wqu@suse.com>
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
 <b96b1149-d2fd-c131-c329-3e1c0cf3689d@suse.com>
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
Message-ID: <510f7f70-f6cf-0a5f-4aef-500619f237f2@suse.com>
Date:   Sat, 7 Nov 2020 21:30:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <b96b1149-d2fd-c131-c329-3e1c0cf3689d@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [149.28.201.231]
X-ClientProxiedBy: SJ0PR05CA0103.namprd05.prod.outlook.com
 (2603:10b6:a03:334::18) To PA4PR04MB7533.eurprd04.prod.outlook.com
 (2603:10a6:102:f1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by SJ0PR05CA0103.namprd05.prod.outlook.com (2603:10b6:a03:334::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.13 via Frontend Transport; Sat, 7 Nov 2020 13:31:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d0489002-cf17-40b7-95df-08d883216bf7
X-MS-TrafficTypeDiagnostic: PR3PR04MB7435:
X-Microsoft-Antispam-PRVS: <PR3PR04MB74358FCB7C61E225CA7CAB22D6EC0@PR3PR04MB7435.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mmz94QtgYO3ZNVbAMlj+Kp/EZQCr14M7F3HrcRvydy5LH9hpXrmEq/eZRs0kuclDs/kn0Ha1Ao5FrgKHOyUth7rtQRaWn30FjcPgrPFZsCbtjSSBU16WpR1cFFcbGQpPooofZmHtidEiihfOtTfUDutRDelQjjnmPSVmcnc1xSX8ge4Fk9xO/KZaDc8pzwX+VRgHAYzZ2xiWx1wja2M0WlMR3KU4PBm9GkF6TP4o4lir0Hu87iI/cWvzlT4RNR1AGIU9ZcNtZcoq8OxUoF85QX8m7/2yECGGNpreU8aajvs3jHUK6ApmicaZ2nnwUaodAzMi8XE5GacnIeKzzMC2iO2x1Rdq7uzsoUUPqQXOIdkYTQS4Z5FlhvYxepUqaDumbkF7ynBfdIn2LELG3++bNulIb8/Z3LWosFVJiUn7GfEey8/JDuvghcYrQJdNCbKhxWNJIqzJiAfXdsBDD+MX5DrYauU4t9Xk6F6+Xq7QtGM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7533.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(136003)(346002)(366004)(376002)(31696002)(6486002)(83380400001)(30864003)(36756003)(5660300002)(8936002)(26005)(16526019)(186003)(66476007)(956004)(316002)(16576012)(2906002)(2616005)(966005)(52116002)(6706004)(110136005)(478600001)(4326008)(8676002)(31686004)(86362001)(6666004)(7416002)(53546011)(66946007)(66556008)(78286007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: PvapzNB+uynf2aHDgZJ6xJPrzeWRH2nuyzzY80ezyJtPRqcmDjHU/9nJuHykI0wlYMLPBmzXK2+iwSfNAkI7ktrovlfXIq+RFnmr76Q+cMMhxv8uGiZ/V+/6tazIjSFCTIXn2Ac11NiZ7iJ5NpB18fdYY5iBGe9+yQHZLuMsZHuSHllXcXtX61OhqhQvdDtz2utZETktP+L412OtbBjlWsePk1pAMaw1602AaTkZKDAqfe67DPkZDorHWFCLFteCHB0/Gqey3roUqpk7qIrIL3QeTgitdeP72SE12xYfQmNhga7nBBXUv/bDlgKqzW37QTNxH/Bmcjv2W+rkj7fk82QtEEjuFUA1CD5TDYwCK1D74HoXdPMa4YaRG3A5igvsjFBXq+lNPjl4s0C5vn5cbKeRD1u0XG/r/IdPYmYKpe92Ih/6r13jqQdasslyU+Xdf9dR2kRsn6HKqBNruBGTMv3M09YQ/KPAp7WRN55dOToh0fuSj285f6BKEVRodkenlwO/DCmBplbapkU53m9iSfnTm6EhjAruhydf0wLZ+6ypT6ZgyEajZNx5Zgh1AmgAAiuRGgEAWesfEcI3XC4Y0Dqvm5LSn/Qu+Vs+37Q21FVPsQxcY3yfLcyW0iDX3Glxj222rjcxIwpoCgyYXL2ngA==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0489002-cf17-40b7-95df-08d883216bf7
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7533.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2020 13:31:24.2388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Up24C5FyQh29FfBzCK+o2dQSncigRTEuaMKbe1CqLePkTl03AdLxzO2UzFaJAiXJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7435
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2020/11/7 =E4=B8=8B=E5=8D=888:54, Qu Wenruo wrote:
>=20
>=20
> On 2020/11/7 =E4=B8=8B=E5=8D=888:47, Robin Murphy wrote:
>> On 2020-11-07 11:36, Qu Wenruo wrote:
>>>
>>>
>>> On 2019/11/21 =E4=B8=8A=E5=8D=881:05, Lorenzo Pieralisi wrote:
>>>> On Sat, Nov 16, 2019 at 12:54:19PM +0000, Robin Murphy wrote:
>>>>> The 0V9 and 1V8 supplies power the PCIe block in the SoC itself, and
>>>>> are thus fundamental to PCIe being usable at all. As such, it makes
>>>>> sense to treat them as non-optional and rely on dummy regulators if
>>>>> not explicitly described.
>>>>>
>>>>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>>>>> ---
>>>>> =C2=A0 drivers/pci/controller/pcie-rockchip-host.c | 69
>>>>> ++++++++-------------
>>>>> =C2=A0 1 file changed, 25 insertions(+), 44 deletions(-)
>>>>
>>>> Applied to pci/rockchip, thanks.
>>>
>>> Sorry, this commit is cause regression for RK3399 boards unable to
>>> detect the controller anymore.
>>>
>>> The 1v8 (and 0v9) is causing -517 and reject the controller
>>> initialization.
>>
>> That's -EPROBE_DEFER, which must mean that a regulator *is* described,
>> but you're missing the relevant driver - that's an issue with your
>> config/initrd. Being optional should only change the behaviour if the
>> supply is totally absent (i.e. you get -ENODEV instead of a dummy
>> regulator), so I don't see that it would make any difference in this
>> situation anyway :/
>>
>>> I'm not a PCI guy, but a quick google search shows these two voltages
>>> are not related to PCIE core functionality, especially considering the
>>> controller used in RK3399 are mostly to provide NVME support.
>>
>> Unlike the 12V and 3V3 supplies to the slot, these supplies are to the
>> PCIE_AVDD_0V9 and PCIE_AVDD_1V8 pins on the SoC itself, which the
>> datasheet describe as "Supply voltage for PCIE". Having power is kind of
>> important for the I/O circuits on all the signal pins to work.
>>
>> Now it's almost certainly true that these supplies technically belong to
>> the phy rather than the controller, but it's a bit late to change the
>> bindings for the sake of semantics.
>>
>>> This bug makes all RK3399 users who put root fs into NVME driver unable
>>> to boot the device.
>>>
>>> I really hope some one could test the patch before affecting the end
>>> users or at least try to understand how most users would use the PCIE
>>> interface for.
>>
>> I *am* that end user in this case - I use an M.2 NVME on my board, which
>> prompted me to take a look at the regulator handling here in the first
>> place, to see if it might be possible to shut up the annoying message
>> about a 12V supply that is entirely irrelevant to a board without a
>> full-size PCIe slot. I use a mainline-based distro, so I've been running
>> this change for nearly a year since it landed in v5.5, and I'm sure many
>> others have too. I've not heard of any other complaints in that time...
>=20
> Sorry for the wrong wording, thank you for your contribution first.
>=20
> It really makes RK3399 the primary testing bed for 64K page size, and
> save me a lot of time.
>=20
> I'm wondering how the -EPROBE_DEFER happens.
> I have only tested two kernel versions, v5.9-rc4 and v5.10-rc2.
> The config works for rc4, unless something big changed in rc2, it
> shouldn't change much, right?
>=20
> The 1v8 and 0v9 is just alwayson regulator, IMHO it doesn't really need
> special driver.
> Or does it?

Not a regulator guys by all means, but the dtsi shows the 1v8 and 0v9
are all provided by rk808, while the dmesg shows:

[    0.195604] reg-fixed-voltage vcc3v3-pcie-regulator: Looking up
vin-supply from device tree
[    0.196096] reg-fixed-voltage vcc3v3-pcie-regulator: vcc3v3_pcie
supplying 3300000uV
[    0.197724] reg-fixed-voltage vcc5v0-host-regulator: Looking up
vin-supply from device tree
[    0.198211] reg-fixed-voltage vcc5v0-host-regulator: vcc5v0_host
supplying 0uV
[    0.198581] reg-fixed-voltage vcc5v0-typec-regulator: Looking up
vin-supply from device tree
[    0.199082] reg-fixed-voltage vcc5v0-typec-regulator: vcc5v0_typec
supplying 0uV
[    0.199395] reg-fixed-voltage vcc3v3-phy-regulator: vcc_lan supplying
3300000uV
[    1.074253] rockchip-pcie f8000000.pcie: no vpcie12v regulator found
[    1.086470] pwm-regulator vdd-log: Looking up pwm-supply from device tre=
e
[    1.086484] pwm-regulator vdd-log: Looking up pwm-supply property in
node /vdd-log failed
[    1.086501] vdd_log: supplied by regulator-dummy
[    1.402500] rk808-regulator rk808-regulator: there is no dvs0 gpio
[    1.403104] rk808-regulator rk808-regulator: there is no dvs1 gpio
[    1.419856] rk808 0-001b: failed to register 12 regulator
[    1.422801] rk808-regulator: probe of rk808-regulator failed with
error -22

So this means something wrong with the rk808, resulting no voltage
provided from rk808 and screwing up the pcie controller?

Thanks,
Qu
>=20
> Thanks,
> Qu
>=20
>>
>> Robin.
>>
>>>
>>> Thanks,
>>> Qu
>>>
>>>>
>>>> Lorenzo
>>>>
>>>>> diff --git a/drivers/pci/controller/pcie-rockchip-host.c
>>>>> b/drivers/pci/controller/pcie-rockchip-host.c
>>>>> index ef8e677ce9d1..68525f8ac4d9 100644
>>>>> --- a/drivers/pci/controller/pcie-rockchip-host.c
>>>>> +++ b/drivers/pci/controller/pcie-rockchip-host.c
>>>>> @@ -620,19 +620,13 @@ static int rockchip_pcie_parse_host_dt(struct
>>>>> rockchip_pcie *rockchip)
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_info(dev, =
"no vpcie3v3 regulator found\n");
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>> =C2=A0 -=C2=A0=C2=A0=C2=A0 rockchip->vpcie1v8 =3D devm_regulator_get_=
optional(dev,
>>>>> "vpcie1v8");
>>>>> -=C2=A0=C2=A0=C2=A0 if (IS_ERR(rockchip->vpcie1v8)) {
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (PTR_ERR(rockchip->vpc=
ie1v8) !=3D -ENODEV)
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
eturn PTR_ERR(rockchip->vpcie1v8);
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_info(dev, "no vpcie1v=
8 regulator found\n");
>>>>> -=C2=A0=C2=A0=C2=A0 }
>>>>> +=C2=A0=C2=A0=C2=A0 rockchip->vpcie1v8 =3D devm_regulator_get(dev, "v=
pcie1v8");
>>>>> +=C2=A0=C2=A0=C2=A0 if (IS_ERR(rockchip->vpcie1v8))
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return PTR_ERR(rockchip->=
vpcie1v8);
>>>>> =C2=A0 -=C2=A0=C2=A0=C2=A0 rockchip->vpcie0v9 =3D devm_regulator_get_=
optional(dev,
>>>>> "vpcie0v9");
>>>>> -=C2=A0=C2=A0=C2=A0 if (IS_ERR(rockchip->vpcie0v9)) {
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (PTR_ERR(rockchip->vpc=
ie0v9) !=3D -ENODEV)
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
eturn PTR_ERR(rockchip->vpcie0v9);
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_info(dev, "no vpcie0v=
9 regulator found\n");
>>>>> -=C2=A0=C2=A0=C2=A0 }
>>>>> +=C2=A0=C2=A0=C2=A0 rockchip->vpcie0v9 =3D devm_regulator_get(dev, "v=
pcie0v9");
>>>>> +=C2=A0=C2=A0=C2=A0 if (IS_ERR(rockchip->vpcie0v9))
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return PTR_ERR(rockchip->=
vpcie0v9);
>>>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>>>> =C2=A0 }
>>>>> @@ -658,27 +652,22 @@ static int rockchip_pcie_set_vpcie(struct
>>>>> rockchip_pcie *rockchip)
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>> =C2=A0 -=C2=A0=C2=A0=C2=A0 if (!IS_ERR(rockchip->vpcie1v8)) {
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D regulator_enable(=
rockchip->vpcie1v8);
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (err) {
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=
ev_err(dev, "fail to enable vpcie1v8 regulator\n");
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g=
oto err_disable_3v3;
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>> +=C2=A0=C2=A0=C2=A0 err =3D regulator_enable(rockchip->vpcie1v8);
>>>>> +=C2=A0=C2=A0=C2=A0 if (err) {
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_err(dev, "fail to ena=
ble vpcie1v8 regulator\n");
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto err_disable_3v3;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>> =C2=A0 -=C2=A0=C2=A0=C2=A0 if (!IS_ERR(rockchip->vpcie0v9)) {
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D regulator_enable(=
rockchip->vpcie0v9);
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (err) {
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=
ev_err(dev, "fail to enable vpcie0v9 regulator\n");
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g=
oto err_disable_1v8;
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>> +=C2=A0=C2=A0=C2=A0 err =3D regulator_enable(rockchip->vpcie0v9);
>>>>> +=C2=A0=C2=A0=C2=A0 if (err) {
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_err(dev, "fail to ena=
ble vpcie0v9 regulator\n");
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto err_disable_1v8;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>>>> =C2=A0 =C2=A0 err_disable_1v8:
>>>>> -=C2=A0=C2=A0=C2=A0 if (!IS_ERR(rockchip->vpcie1v8))
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 regulator_disable(rockchi=
p->vpcie1v8);
>>>>> +=C2=A0=C2=A0=C2=A0 regulator_disable(rockchip->vpcie1v8);
>>>>> =C2=A0 err_disable_3v3:
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!IS_ERR(rockchip->vpcie3v3))
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 regulator_disa=
ble(rockchip->vpcie3v3);
>>>>> @@ -897,8 +886,7 @@ static int __maybe_unused
>>>>> rockchip_pcie_suspend_noirq(struct device *dev)
>>>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rockchip_pcie_disable_clocks(ro=
ckchip);
>>>>> =C2=A0 -=C2=A0=C2=A0=C2=A0 if (!IS_ERR(rockchip->vpcie0v9))
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 regulator_disable(rockchi=
p->vpcie0v9);
>>>>> +=C2=A0=C2=A0=C2=A0 regulator_disable(rockchip->vpcie0v9);
>>>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>>>>> =C2=A0 }
>>>>> @@ -908,12 +896,10 @@ static int __maybe_unused
>>>>> rockchip_pcie_resume_noirq(struct device *dev)
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct rockchip_pcie *rockchip =3D dev=
_get_drvdata(dev);
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int err;
>>>>> =C2=A0 -=C2=A0=C2=A0=C2=A0 if (!IS_ERR(rockchip->vpcie0v9)) {
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D regulator_enable(=
rockchip->vpcie0v9);
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (err) {
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=
ev_err(dev, "fail to enable vpcie0v9 regulator\n");
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
eturn err;
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>> +=C2=A0=C2=A0=C2=A0 err =3D regulator_enable(rockchip->vpcie0v9);
>>>>> +=C2=A0=C2=A0=C2=A0 if (err) {
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_err(dev, "fail to ena=
ble vpcie0v9 regulator\n");
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return err;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D rockchip_pcie_enable_cl=
ocks(rockchip);
>>>>> @@ -939,8 +925,7 @@ static int __maybe_unused
>>>>> rockchip_pcie_resume_noirq(struct device *dev)
>>>>> =C2=A0 err_pcie_resume:
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rockchip_pcie_disable_clocks(rockchip)=
;
>>>>> =C2=A0 err_disable_0v9:
>>>>> -=C2=A0=C2=A0=C2=A0 if (!IS_ERR(rockchip->vpcie0v9))
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 regulator_disable(rockchi=
p->vpcie0v9);
>>>>> +=C2=A0=C2=A0=C2=A0 regulator_disable(rockchip->vpcie0v9);
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return err;
>>>>> =C2=A0 }
>>>>> =C2=A0 @@ -1081,10 +1066,8 @@ static int rockchip_pcie_probe(struct
>>>>> platform_device *pdev)
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 regulator_disa=
ble(rockchip->vpcie12v);
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!IS_ERR(rockchip->vpcie3v3))
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 regulator_disa=
ble(rockchip->vpcie3v3);
>>>>> -=C2=A0=C2=A0=C2=A0 if (!IS_ERR(rockchip->vpcie1v8))
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 regulator_disable(rockchi=
p->vpcie1v8);
>>>>> -=C2=A0=C2=A0=C2=A0 if (!IS_ERR(rockchip->vpcie0v9))
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 regulator_disable(rockchi=
p->vpcie0v9);
>>>>> +=C2=A0=C2=A0=C2=A0 regulator_disable(rockchip->vpcie1v8);
>>>>> +=C2=A0=C2=A0=C2=A0 regulator_disable(rockchip->vpcie0v9);
>>>>> =C2=A0 err_set_vpcie:
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rockchip_pcie_disable_clocks(rockchip)=
;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return err;
>>>>> @@ -1108,10 +1091,8 @@ static int rockchip_pcie_remove(struct
>>>>> platform_device *pdev)
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 regulator_disa=
ble(rockchip->vpcie12v);
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!IS_ERR(rockchip->vpcie3v3))
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 regulator_disa=
ble(rockchip->vpcie3v3);
>>>>> -=C2=A0=C2=A0=C2=A0 if (!IS_ERR(rockchip->vpcie1v8))
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 regulator_disable(rockchi=
p->vpcie1v8);
>>>>> -=C2=A0=C2=A0=C2=A0 if (!IS_ERR(rockchip->vpcie0v9))
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 regulator_disable(rockchi=
p->vpcie0v9);
>>>>> +=C2=A0=C2=A0=C2=A0 regulator_disable(rockchip->vpcie1v8);
>>>>> +=C2=A0=C2=A0=C2=A0 regulator_disable(rockchip->vpcie0v9);
>>>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>>>> =C2=A0 }
>>>>> --=C2=A0
>>>>> 2.17.1
>>>>>
>>>>
>>>> _______________________________________________
>>>> linux-arm-kernel mailing list
>>>> linux-arm-kernel@lists.infradead.org
>>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>>>
>>>
>>
>=20
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>=20

