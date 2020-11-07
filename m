Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 863912AA4B5
	for <lists+linux-pci@lfdr.de>; Sat,  7 Nov 2020 12:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbgKGLhM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 7 Nov 2020 06:37:12 -0500
Received: from de-smtp-delivery-102.mimecast.com ([51.163.158.102]:35760 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726242AbgKGLhL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 7 Nov 2020 06:37:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1604749028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=/sVbUwGz/jb3cVXnd+6Z9Z/er2Ya+C9N3ChN63655TY=;
        b=iH3nDyh5eHKRW5LYxsXJeN1JujzkIW/CM+7QLeBZy7S9f8R8a3JxZ6gbO/2fkHGj9m8+xz
        gccT2j1wtqLbthho5M4P6qINp/3AR0+yK6NccZ0s8hrwN4rjpLjGx6eqC254VAA8bNz5iv
        13q9DO7/sxnJqvh2BX9xkuD9pho/jjg=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2057.outbound.protection.outlook.com [104.47.14.57]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-19-BhjcTjdiO1-tVePm3qF8dA-1; Sat, 07 Nov 2020 12:37:04 +0100
X-MC-Unique: BhjcTjdiO1-tVePm3qF8dA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=esu5mAxZ7tO2+GUmjb6iA5RKHhk4Ov6K66oBXnCLN1SrMa3j2jnZetuI0cXHadOPu9BKinqN2HmD3I5Z5N01uJwIhTVPYZ6W0XJwcpkBJoTMXGI3CELsLjkg7vl7zrw6e4PLfQMi9WHP0ZxEE6m+lusHYB3IfVVoVn3pTU7IwhvoZ1WAmIpbC8BNxRHBh2M6eBTuGkFTdhpboQAYIIu+UL2ZaFTR9TLn84erFuY3j8Dyfgc1Cse0UlqwRQ3CAPUhnOA4IAii32WMv3nnBGJJxzaRcoULiYinKL5Q2emm7vZApTejfuWFa68AiVecaPbDbQQEegfwq6Lx9uSTmFnhjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bk8LqKDMvJIm3hBdlLwFqvtkTI7AsOPtbo9UEgYW/hM=;
 b=SAvEy3u0nKQUPL40yboT1eqjlEgeQodU3yHA+zDBtf1VHtcncLB14I4UU3rvD3TBoZB+OSRz1s26jb2O1KYGMnXIC8mO3LnjyqJcpwrOIi8zgSWCO/iBDl3OXly1/XaBPzv3n/lfHLOZHoh31NDQbNuZm5Ftq7SzUljiCRFUW+VS6YDDDOTivDhJKyqOd0IrOhW2ufyP/1H69MYfbjj6a+3PmrOQEVDsOgXf9yReD1B7c4t7NCqHW14DBiHTTCddlCIpdxf8UafP/2Lq458D4tdioLdzvqQyRp5WRllnItLCfvfEoSHo+0LtwayWpoqu8T1UDR7Tm80skIqhe9ukAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=suse.com;
Received: from PA4PR04MB7533.eurprd04.prod.outlook.com (2603:10a6:102:f1::19)
 by PA4PR04MB7952.eurprd04.prod.outlook.com (2603:10a6:102:b8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Sat, 7 Nov
 2020 11:37:02 +0000
Received: from PA4PR04MB7533.eurprd04.prod.outlook.com
 ([fe80::545:8a04:2a5c:f4c7]) by PA4PR04MB7533.eurprd04.prod.outlook.com
 ([fe80::545:8a04:2a5c:f4c7%6]) with mapi id 15.20.3541.022; Sat, 7 Nov 2020
 11:37:02 +0000
Subject: Re: [PATCH 1/2] PCI: rockchip: Make some regulators non-optional
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Robin Murphy <robin.murphy@arm.com>
CC:     heiko@sntech.de, linux-pci@vger.kernel.org,
        shawn.lin@rock-chips.com, lgirdwood@gmail.com,
        linux-rockchip@lists.infradead.org, broonie@kernel.org,
        bhelgaas@google.com, andrew.murray@arm.com,
        linux-arm-kernel@lists.infradead.org
References: <1eebc002101931012d337cda23d18f85b0326361.1573908530.git.robin.murphy@arm.com>
 <20191120170532.GC3279@e121166-lin.cambridge.arm.com>
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
Message-ID: <e8a91353-49ab-7581-f2a8-b8b4729072bf@suse.com>
Date:   Sat, 7 Nov 2020 19:36:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <20191120170532.GC3279@e121166-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [149.28.201.231]
X-ClientProxiedBy: BY5PR20CA0018.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::31) To PA4PR04MB7533.eurprd04.prod.outlook.com
 (2603:10a6:102:f1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BY5PR20CA0018.namprd20.prod.outlook.com (2603:10b6:a03:1f4::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Sat, 7 Nov 2020 11:36:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd659c27-2d81-49bf-371d-08d8831171da
X-MS-TrafficTypeDiagnostic: PA4PR04MB7952:
X-Microsoft-Antispam-PRVS: <PA4PR04MB79528854EFC5BB50757C8138D6EC0@PA4PR04MB7952.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SM66tJZFlQkhyHsjIs6BUy5hdmvJeC5kEa79r8rKKTZyQzvmXmj8Q1261MhaZxz+xvKI077byNIyBMe+guCdp3NG0ISfZbj0ltnf5KlzxWOc3oQNCGZHvIeNy0ZVOdL+oCWMuliJteB68R2KzV7pSA1Jk2iFnuwR3Ts6TwVsNxsQom4y13YIAsOMtFz4p/UR/qRGVmgyjl/8Ob+9XjfDoe73j+EccFS3kiwLUYOcyKXC4QWv86JufW+lKlE6APkqlIuRrvykKiJhYnGMweYpfyz0M6ViEwJtcx/2+1/L9eHkQK/VdU9J1wexHYTdGgg7tkdZBhYdUjOCpvUeZoK8qoug2F52Sj9Ttlws1T2B6bi4w3nUv6agM9eauabaV8+N9AHQCZYrK6d5eTNhPbylQgwp9gQFTLmNg2UYDmv1FYFjTI2zJlnUJ6uBVd/awx/0gO+hEvmtbGMD1ARJQtJZgltY/j7mt7qHpRb82lPj69Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7533.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(136003)(366004)(376002)(346002)(26005)(5660300002)(6706004)(16526019)(31696002)(186003)(110136005)(52116002)(966005)(4326008)(66946007)(316002)(7416002)(478600001)(66476007)(66556008)(6486002)(31686004)(16576012)(8676002)(36756003)(6666004)(83380400001)(2906002)(86362001)(2616005)(956004)(8936002)(78286007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: E1/Sfv5eG9a7TnBQBajY46gR4YEvjOcONf7rHop4MndaNLMcbRzxn+BScZoUdJ8Qm83sNatVqeuucnKbK7uJAXrMqocnDq621gMPEcqzWxrrymKEjCObkie/kE9Yrd3Qn57jgT1GyebIcQk4+XaTAXlEA0eUGbg4qbuyLO8J19WAjFRUCdeZIk0RH/TG5eQtqs0Eb+NX9F3JW6CrwSh4rpHS8g7IcUU/Hlv5WyR+V+oC/hrikbC3HoIzOZTVKe4IkE9Z+metDbCufTOHT6xULu4xmKvLyLC14W66qYsF12x+W7jW3AOeWnjHMcA3HeJoEY7we1K+KDDsuLKIB+xwvPX9NV2WkEbX7qG+frHccb80n77ySYSyWmqrRNvbakeHPuPqZ4BzMe8E4fNh7cuYssKWXpSXKAlFKpdfSsx1dzOKDQvMNsMBoGP3bQIry9a+2sRlapI66oaBIHh+fpWNbeGXkELl7QL7FtTzi8cJMd6XPNrBIRPNhKjOULqKYytsdOXj4yOdFWc5qITvqxjlRSoAOugCXFyCGekmCJ50Fro53Vw+wTaRbzjnmB0XhTBngJGArmxdtkd8oXcQNLhtD/eO0bH+zvN69trlcVjHjA8tc4/SiqDm/ejrY60NgKzHn9tqLI+kOEMeIBFNPfzBbg==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd659c27-2d81-49bf-371d-08d8831171da
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7533.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2020 11:37:02.5154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YR81QprKu1TMyYMxp9QRTGGC1KkXaG+NNwA4cXizh+PHG73V7YhxDBzv4RkrF2HS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7952
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2019/11/21 =E4=B8=8A=E5=8D=881:05, Lorenzo Pieralisi wrote:
> On Sat, Nov 16, 2019 at 12:54:19PM +0000, Robin Murphy wrote:
>> The 0V9 and 1V8 supplies power the PCIe block in the SoC itself, and
>> are thus fundamental to PCIe being usable at all. As such, it makes
>> sense to treat them as non-optional and rely on dummy regulators if
>> not explicitly described.
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>  drivers/pci/controller/pcie-rockchip-host.c | 69 ++++++++-------------
>>  1 file changed, 25 insertions(+), 44 deletions(-)
>=20
> Applied to pci/rockchip, thanks.

Sorry, this commit is cause regression for RK3399 boards unable to
detect the controller anymore.

The 1v8 (and 0v9) is causing -517 and reject the controller initialization.

I'm not a PCI guy, but a quick google search shows these two voltages
are not related to PCIE core functionality, especially considering the
controller used in RK3399 are mostly to provide NVME support.

This bug makes all RK3399 users who put root fs into NVME driver unable
to boot the device.

I really hope some one could test the patch before affecting the end
users or at least try to understand how most users would use the PCIE
interface for.

Thanks,
Qu

>=20
> Lorenzo
>=20
>> diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/c=
ontroller/pcie-rockchip-host.c
>> index ef8e677ce9d1..68525f8ac4d9 100644
>> --- a/drivers/pci/controller/pcie-rockchip-host.c
>> +++ b/drivers/pci/controller/pcie-rockchip-host.c
>> @@ -620,19 +620,13 @@ static int rockchip_pcie_parse_host_dt(struct rock=
chip_pcie *rockchip)
>>  		dev_info(dev, "no vpcie3v3 regulator found\n");
>>  	}
>> =20
>> -	rockchip->vpcie1v8 =3D devm_regulator_get_optional(dev, "vpcie1v8");
>> -	if (IS_ERR(rockchip->vpcie1v8)) {
>> -		if (PTR_ERR(rockchip->vpcie1v8) !=3D -ENODEV)
>> -			return PTR_ERR(rockchip->vpcie1v8);
>> -		dev_info(dev, "no vpcie1v8 regulator found\n");
>> -	}
>> +	rockchip->vpcie1v8 =3D devm_regulator_get(dev, "vpcie1v8");
>> +	if (IS_ERR(rockchip->vpcie1v8))
>> +		return PTR_ERR(rockchip->vpcie1v8);
>> =20
>> -	rockchip->vpcie0v9 =3D devm_regulator_get_optional(dev, "vpcie0v9");
>> -	if (IS_ERR(rockchip->vpcie0v9)) {
>> -		if (PTR_ERR(rockchip->vpcie0v9) !=3D -ENODEV)
>> -			return PTR_ERR(rockchip->vpcie0v9);
>> -		dev_info(dev, "no vpcie0v9 regulator found\n");
>> -	}
>> +	rockchip->vpcie0v9 =3D devm_regulator_get(dev, "vpcie0v9");
>> +	if (IS_ERR(rockchip->vpcie0v9))
>> +		return PTR_ERR(rockchip->vpcie0v9);
>> =20
>>  	return 0;
>>  }
>> @@ -658,27 +652,22 @@ static int rockchip_pcie_set_vpcie(struct rockchip=
_pcie *rockchip)
>>  		}
>>  	}
>> =20
>> -	if (!IS_ERR(rockchip->vpcie1v8)) {
>> -		err =3D regulator_enable(rockchip->vpcie1v8);
>> -		if (err) {
>> -			dev_err(dev, "fail to enable vpcie1v8 regulator\n");
>> -			goto err_disable_3v3;
>> -		}
>> +	err =3D regulator_enable(rockchip->vpcie1v8);
>> +	if (err) {
>> +		dev_err(dev, "fail to enable vpcie1v8 regulator\n");
>> +		goto err_disable_3v3;
>>  	}
>> =20
>> -	if (!IS_ERR(rockchip->vpcie0v9)) {
>> -		err =3D regulator_enable(rockchip->vpcie0v9);
>> -		if (err) {
>> -			dev_err(dev, "fail to enable vpcie0v9 regulator\n");
>> -			goto err_disable_1v8;
>> -		}
>> +	err =3D regulator_enable(rockchip->vpcie0v9);
>> +	if (err) {
>> +		dev_err(dev, "fail to enable vpcie0v9 regulator\n");
>> +		goto err_disable_1v8;
>>  	}
>> =20
>>  	return 0;
>> =20
>>  err_disable_1v8:
>> -	if (!IS_ERR(rockchip->vpcie1v8))
>> -		regulator_disable(rockchip->vpcie1v8);
>> +	regulator_disable(rockchip->vpcie1v8);
>>  err_disable_3v3:
>>  	if (!IS_ERR(rockchip->vpcie3v3))
>>  		regulator_disable(rockchip->vpcie3v3);
>> @@ -897,8 +886,7 @@ static int __maybe_unused rockchip_pcie_suspend_noir=
q(struct device *dev)
>> =20
>>  	rockchip_pcie_disable_clocks(rockchip);
>> =20
>> -	if (!IS_ERR(rockchip->vpcie0v9))
>> -		regulator_disable(rockchip->vpcie0v9);
>> +	regulator_disable(rockchip->vpcie0v9);
>> =20
>>  	return ret;
>>  }
>> @@ -908,12 +896,10 @@ static int __maybe_unused rockchip_pcie_resume_noi=
rq(struct device *dev)
>>  	struct rockchip_pcie *rockchip =3D dev_get_drvdata(dev);
>>  	int err;
>> =20
>> -	if (!IS_ERR(rockchip->vpcie0v9)) {
>> -		err =3D regulator_enable(rockchip->vpcie0v9);
>> -		if (err) {
>> -			dev_err(dev, "fail to enable vpcie0v9 regulator\n");
>> -			return err;
>> -		}
>> +	err =3D regulator_enable(rockchip->vpcie0v9);
>> +	if (err) {
>> +		dev_err(dev, "fail to enable vpcie0v9 regulator\n");
>> +		return err;
>>  	}
>> =20
>>  	err =3D rockchip_pcie_enable_clocks(rockchip);
>> @@ -939,8 +925,7 @@ static int __maybe_unused rockchip_pcie_resume_noirq=
(struct device *dev)
>>  err_pcie_resume:
>>  	rockchip_pcie_disable_clocks(rockchip);
>>  err_disable_0v9:
>> -	if (!IS_ERR(rockchip->vpcie0v9))
>> -		regulator_disable(rockchip->vpcie0v9);
>> +	regulator_disable(rockchip->vpcie0v9);
>>  	return err;
>>  }
>> =20
>> @@ -1081,10 +1066,8 @@ static int rockchip_pcie_probe(struct platform_de=
vice *pdev)
>>  		regulator_disable(rockchip->vpcie12v);
>>  	if (!IS_ERR(rockchip->vpcie3v3))
>>  		regulator_disable(rockchip->vpcie3v3);
>> -	if (!IS_ERR(rockchip->vpcie1v8))
>> -		regulator_disable(rockchip->vpcie1v8);
>> -	if (!IS_ERR(rockchip->vpcie0v9))
>> -		regulator_disable(rockchip->vpcie0v9);
>> +	regulator_disable(rockchip->vpcie1v8);
>> +	regulator_disable(rockchip->vpcie0v9);
>>  err_set_vpcie:
>>  	rockchip_pcie_disable_clocks(rockchip);
>>  	return err;
>> @@ -1108,10 +1091,8 @@ static int rockchip_pcie_remove(struct platform_d=
evice *pdev)
>>  		regulator_disable(rockchip->vpcie12v);
>>  	if (!IS_ERR(rockchip->vpcie3v3))
>>  		regulator_disable(rockchip->vpcie3v3);
>> -	if (!IS_ERR(rockchip->vpcie1v8))
>> -		regulator_disable(rockchip->vpcie1v8);
>> -	if (!IS_ERR(rockchip->vpcie0v9))
>> -		regulator_disable(rockchip->vpcie0v9);
>> +	regulator_disable(rockchip->vpcie1v8);
>> +	regulator_disable(rockchip->vpcie0v9);
>> =20
>>  	return 0;
>>  }
>> --=20
>> 2.17.1
>>
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>=20

