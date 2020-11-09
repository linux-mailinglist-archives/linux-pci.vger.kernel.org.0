Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C08A42AB885
	for <lists+linux-pci@lfdr.de>; Mon,  9 Nov 2020 13:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729174AbgKIMpS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Nov 2020 07:45:18 -0500
Received: from de-smtp-delivery-52.mimecast.com ([62.140.7.52]:48511 "EHLO
        de-smtp-delivery-52.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727077AbgKIMpO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Nov 2020 07:45:14 -0500
X-Greylist: delayed 303 seconds by postgrey-1.27 at vger.kernel.org; Mon, 09 Nov 2020 07:45:10 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1604925909;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=FaiMvJHCHm6rmzLKEIItXmgXqQ98HYUDsUCaABJOiCg=;
        b=aix27zbc/Cx9oSrkT8vebbxMMm9P1jTqcm0kNRxlAwQA56WncDe+MaVx1fJLwikgmWY/Rm
        rbd/HD+xF3CzmHaHLYP41XwrEkeNNWdy0hkp8F2rouWnKsi+KwPHcu8qqYqNuBFe4wUUP+
        3aqaCPOanPfQbVb6gIpBGvwcSFnnMB0=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2059.outbound.protection.outlook.com [104.47.13.59]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-23-c6TN2BnPNsiyfzDOgYW2PA-1; Mon, 09 Nov 2020 13:39:01 +0100
X-MC-Unique: c6TN2BnPNsiyfzDOgYW2PA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TI84PYtwOYvE4Mxyq/lXK2kAipZ9ohe4n/EC7s3ClYRiscsRMjX3BzBzrktt3JaHi0ICwL0dnIZZ5uB9bFsaMjiTATWTJjo06gyA4TszgrGkwONodb1g358on1oLq+H7j72n12hxQD0YpLKuEWrgj0o/Rw9vDVPqXSObg2f98gzc8/Ai9OKvPRvoc9DL5HqnPFj0/scaQxJsFDenXGLyyyUTQYeFlS5FpfWoKA7v4K+00YI/pYE1pfX8q1/qr61xtQKGuGrjdGw7aB0JmvUHDTtcVdlsxLtduWQvIKiJPjLOCvhMlhHKekIE9Zt2/0nvTvLR/9CXvihyZ1W2yjQZXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5FG4KgDZzT1PhUlSpIEocihGwpg3SxvNxERZNAcu1G4=;
 b=msWEnufbJI0nyIeX/HMQiJx4XImygXn5+lD7rhlRR3tZnf1mf3Dva2OheMgOYa9phWijd6U8BFbY0Izy1Wev8cdr4dgHTGDTQBbXOTh98PkTeWpor7qlrQpt5NtdwKeQl9J4WFlpjnOibSuamt/BNiZJxE9vpr8u23i6/jfFE/xNZs5OSJT4gvwiYfzyRjf5qicnsp33g9SkR8NLiVFueG8MZbRsmhPs1qRtx8yTr6d8YQRuKaDMYDES92F/Riy8HjpLDXtqa6AtemOrQZ+pDH9kG+oQ84xddKsIikVKBhTSijmtPDIUVCBjb7UISxNCN2l9zeoHnFjmA0iVdh/S/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=suse.com;
Received: from PA4PR04MB7533.eurprd04.prod.outlook.com (2603:10a6:102:f1::19)
 by PR3PR04MB7306.eurprd04.prod.outlook.com (2603:10a6:102:81::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Mon, 9 Nov
 2020 12:39:00 +0000
Received: from PA4PR04MB7533.eurprd04.prod.outlook.com
 ([fe80::545:8a04:2a5c:f4c7]) by PA4PR04MB7533.eurprd04.prod.outlook.com
 ([fe80::545:8a04:2a5c:f4c7%6]) with mapi id 15.20.3541.025; Mon, 9 Nov 2020
 12:39:00 +0000
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
 <b96b1149-d2fd-c131-c329-3e1c0cf3689d@suse.com>
 <510f7f70-f6cf-0a5f-4aef-500619f237f2@suse.com>
 <74abf5b6-4595-fc72-6029-e4475fef1a1f@arm.com>
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
Message-ID: <59dcb8d4-59c8-17b9-1891-9b3d1989a204@suse.com>
Date:   Mon, 9 Nov 2020 20:38:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <74abf5b6-4595-fc72-6029-e4475fef1a1f@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [149.28.201.231]
X-ClientProxiedBy: SJ0PR13CA0164.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::19) To PA4PR04MB7533.eurprd04.prod.outlook.com
 (2603:10a6:102:f1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by SJ0PR13CA0164.namprd13.prod.outlook.com (2603:10b6:a03:2c7::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.10 via Frontend Transport; Mon, 9 Nov 2020 12:38:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ee73908-7a62-44ac-5d5f-08d884ac6eb4
X-MS-TrafficTypeDiagnostic: PR3PR04MB7306:
X-Microsoft-Antispam-PRVS: <PR3PR04MB7306ABCA716C4C04012343B5D6EA0@PR3PR04MB7306.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XPftjwGuNHShg4wO2dcb9ggweavx1ljB0QHvNyzid+Gtt6i9fb8uH10fuVmIuy4c5Z5krm6RuSGnhPJhKYL/+uJn5fZW1qura5/rrS9myu6X/HEfiOtJiPX0q8pC7fwSSoSG0U37wEP+jyQ53iL0S9py/F5BXYBTAFHJQq6C1X30zHCrS3W5s8wyC7P2rVplC/lvaUHQw7BqLK4bCXPK6FbNYTg9Tskl4RotOGbUd4xshAfZDdJ7EjpIWOll+4p4gO6rjiS8gztY0KF13qsp7NFqwEdqXqK8cTfSz45MvxkYrlbWzVmW7NV9N6SSD8u304t1MtJ7nHBXdgfaKQwbiye4+0/cUnUo7Y7vDl3FEE1Y6OeT/yaCVw2tUPPex70Wm/CZ53e6TsmhqmXQPWZafw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7533.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(346002)(366004)(136003)(396003)(110136005)(2906002)(53546011)(8676002)(8936002)(16576012)(31696002)(86362001)(956004)(66556008)(478600001)(316002)(2616005)(66476007)(6666004)(16526019)(31686004)(66946007)(52116002)(83380400001)(186003)(26005)(5660300002)(7416002)(36756003)(6706004)(4326008)(6486002)(78286007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 44JfBPE7iHY5WgkcZUmBOZXhORJxOgC0jsmKW5HzvUg/tvwxJAC13NhCxAc6mr3nyS9AUhxMgTMcrheBy2+GKs9bZh48NOvgOraMUi/5L/UWWa9duOFRXHjBlitviHbd0evNwPyrUTlW9VNmFy1xuTB1s39ELKS2BU4eZ2k8Ffc7AhtXgTsxRxoombQVdohL/Ahp81pvf8CE5j+dO3fWOru4bpyEoI5Oo6j5J+w9456mjYYlEg81g/rRG84kgp4DUd39RFeIdGGqq6S3H1KPnqcuqej93vL/TrmSl0ouWYRVZQ64CXrdjZPvHwp+FHBe/MmNNVcd9lwp4yE3/1xQQu7i8SUALIu5IW8/v75bRARmaTb9NbrrmjuryYLXf3+SIqjk+PAN1zfp99qfgIosh73114pCgsxf5dv1H/Cno7Ov2XvQ/VuDxL4IM6rpcZAna5lacGMA1FVv8/x9//gbnQdhPIwVdrjMtO39Qok6Br0UZS52oTs7pxvA1l6G4hYUu2atzCn00rsvkMzwhsrv8gxA8YsMSv/DvdjPfwcSEL/Oi3q8lhbOFclDSdrXZe37BMha6/6bKqQZIExsaCIi8J0BQ6iqEgMGCeWPkxwgzaSLU/vjgYM+p+hhYCelizo5z7wE/8RLNoIRBPphSxr7cQ==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ee73908-7a62-44ac-5d5f-08d884ac6eb4
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7533.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2020 12:39:00.2168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zITup+Z0nYzo8NUavm2mtqce0BF5D0CY9rnDv9hs80LZr70zNgCu3RU7FdLy4QLG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7306
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2020/11/9 =E4=B8=8B=E5=8D=888:00, Robin Murphy wrote:
> On 2020-11-07 13:30, Qu Wenruo wrote:
>>
>>
>> On 2020/11/7 =E4=B8=8B=E5=8D=888:54, Qu Wenruo wrote:
>>>
>>>
>>> On 2020/11/7 =E4=B8=8B=E5=8D=888:47, Robin Murphy wrote:
>>>> On 2020-11-07 11:36, Qu Wenruo wrote:
>>>>>
>>>>>
>>>>> On 2019/11/21 =E4=B8=8A=E5=8D=881:05, Lorenzo Pieralisi wrote:
>>>>>> On Sat, Nov 16, 2019 at 12:54:19PM +0000, Robin Murphy wrote:
>>>>>>> The 0V9 and 1V8 supplies power the PCIe block in the SoC itself, an=
d
>>>>>>> are thus fundamental to PCIe being usable at all. As such, it makes
>>>>>>> sense to treat them as non-optional and rely on dummy regulators if
>>>>>>> not explicitly described.
>>>>>>>
>>>>>>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>>>>>>> ---
>>>>>>> =C2=A0=C2=A0 drivers/pci/controller/pcie-rockchip-host.c | 69
>>>>>>> ++++++++-------------
>>>>>>> =C2=A0=C2=A0 1 file changed, 25 insertions(+), 44 deletions(-)
>>>>>>
>>>>>> Applied to pci/rockchip, thanks.
>>>>>
>>>>> Sorry, this commit is cause regression for RK3399 boards unable to
>>>>> detect the controller anymore.
>>>>>
>>>>> The 1v8 (and 0v9) is causing -517 and reject the controller
>>>>> initialization.
>>>>
>>>> That's -EPROBE_DEFER, which must mean that a regulator *is* described,
>>>> but you're missing the relevant driver - that's an issue with your
>>>> config/initrd. Being optional should only change the behaviour if the
>>>> supply is totally absent (i.e. you get -ENODEV instead of a dummy
>>>> regulator), so I don't see that it would make any difference in this
>>>> situation anyway :/
>>>>
>>>>> I'm not a PCI guy, but a quick google search shows these two voltages
>>>>> are not related to PCIE core functionality, especially considering th=
e
>>>>> controller used in RK3399 are mostly to provide NVME support.
>>>>
>>>> Unlike the 12V and 3V3 supplies to the slot, these supplies are to the
>>>> PCIE_AVDD_0V9 and PCIE_AVDD_1V8 pins on the SoC itself, which the
>>>> datasheet describe as "Supply voltage for PCIE". Having power is
>>>> kind of
>>>> important for the I/O circuits on all the signal pins to work.
>>>>
>>>> Now it's almost certainly true that these supplies technically
>>>> belong to
>>>> the phy rather than the controller, but it's a bit late to change the
>>>> bindings for the sake of semantics.
>>>>
>>>>> This bug makes all RK3399 users who put root fs into NVME driver
>>>>> unable
>>>>> to boot the device.
>>>>>
>>>>> I really hope some one could test the patch before affecting the end
>>>>> users or at least try to understand how most users would use the PCIE
>>>>> interface for.
>>>>
>>>> I *am* that end user in this case - I use an M.2 NVME on my board,
>>>> which
>>>> prompted me to take a look at the regulator handling here in the first
>>>> place, to see if it might be possible to shut up the annoying message
>>>> about a 12V supply that is entirely irrelevant to a board without a
>>>> full-size PCIe slot. I use a mainline-based distro, so I've been
>>>> running
>>>> this change for nearly a year since it landed in v5.5, and I'm sure
>>>> many
>>>> others have too. I've not heard of any other complaints in that time..=
.
>>>
>>> Sorry for the wrong wording, thank you for your contribution first.
>>>
>>> It really makes RK3399 the primary testing bed for 64K page size, and
>>> save me a lot of time.
>>>
>>> I'm wondering how the -EPROBE_DEFER happens.
>>> I have only tested two kernel versions, v5.9-rc4 and v5.10-rc2.
>>> The config works for rc4, unless something big changed in rc2, it
>>> shouldn't change much, right?
>>>
>>> The 1v8 and 0v9 is just alwayson regulator, IMHO it doesn't really need
>>> special driver.
>>> Or does it?
>>
>> Not a regulator guys by all means, but the dtsi shows the 1v8 and 0v9
>> are all provided by rk808, while the dmesg shows:
>>
>> [=C2=A0=C2=A0=C2=A0 0.195604] reg-fixed-voltage vcc3v3-pcie-regulator: L=
ooking up
>> vin-supply from device tree
>> [=C2=A0=C2=A0=C2=A0 0.196096] reg-fixed-voltage vcc3v3-pcie-regulator: v=
cc3v3_pcie
>> supplying 3300000uV
>> [=C2=A0=C2=A0=C2=A0 0.197724] reg-fixed-voltage vcc5v0-host-regulator: L=
ooking up
>> vin-supply from device tree
>> [=C2=A0=C2=A0=C2=A0 0.198211] reg-fixed-voltage vcc5v0-host-regulator: v=
cc5v0_host
>> supplying 0uV
>> [=C2=A0=C2=A0=C2=A0 0.198581] reg-fixed-voltage vcc5v0-typec-regulator: =
Looking up
>> vin-supply from device tree
>> [=C2=A0=C2=A0=C2=A0 0.199082] reg-fixed-voltage vcc5v0-typec-regulator: =
vcc5v0_typec
>> supplying 0uV
>> [=C2=A0=C2=A0=C2=A0 0.199395] reg-fixed-voltage vcc3v3-phy-regulator: vc=
c_lan supplying
>> 3300000uV
>> [=C2=A0=C2=A0=C2=A0 1.074253] rockchip-pcie f8000000.pcie: no vpcie12v r=
egulator found
>> [=C2=A0=C2=A0=C2=A0 1.086470] pwm-regulator vdd-log: Looking up pwm-supp=
ly from
>> device tree
>> [=C2=A0=C2=A0=C2=A0 1.086484] pwm-regulator vdd-log: Looking up pwm-supp=
ly property in
>> node /vdd-log failed
>> [=C2=A0=C2=A0=C2=A0 1.086501] vdd_log: supplied by regulator-dummy
>> [=C2=A0=C2=A0=C2=A0 1.402500] rk808-regulator rk808-regulator: there is =
no dvs0 gpio
>> [=C2=A0=C2=A0=C2=A0 1.403104] rk808-regulator rk808-regulator: there is =
no dvs1 gpio
>> [=C2=A0=C2=A0=C2=A0 1.419856] rk808 0-001b: failed to register 12 regula=
tor
>> [=C2=A0=C2=A0=C2=A0 1.422801] rk808-regulator: probe of rk808-regulator =
failed with
>> error -22
>>
>> So this means something wrong with the rk808, resulting no voltage
>> provided from rk808 and screwing up the pcie controller?
>=20
> Frankly PCIe is the least of your worries there - if the system PMIC is
> failing to probe then pretty much everything will be degraded: cpufreq
> won't work, some SD card modes won't work, on some boards entire
> peripherals like ethernet might not work if they're wired up to use the
> opposite I/O domain voltage setting from the SoC's power-on default.
>=20
> Focusing on PCIe getting probe-deferred seems a bit like complaining
> that the carpets on the Titanic are wet ;)

That's true. Thankfully bisect lead to the cause. It's even deeper in
the core regulator code.

Commit aea6cb99703e ("regulator: resolve supply after creating
regulator") makes the RK808 unable to register.

And fix for that commit is already merged in upstream.

Sorry for the disruption.

Thanks,
Qu

>=20
> Robin.
>=20

