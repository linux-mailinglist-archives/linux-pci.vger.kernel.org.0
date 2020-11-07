Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1862AA4D5
	for <lists+linux-pci@lfdr.de>; Sat,  7 Nov 2020 12:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbgKGL5l (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 7 Nov 2020 06:57:41 -0500
Received: from de-smtp-delivery-102.mimecast.com ([51.163.158.102]:20487 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727084AbgKGL5k (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 7 Nov 2020 06:57:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1604750255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=Vz1u/3L7SjfQYeRgbd6bjB8qPPSUa+yeblNuhVO3jLg=;
        b=fGD94/eq/pTJXWpZz5TXOgUaIwXoddoAoWIn7sR22gBnKcCOeVplm+EW+esbVr/8YLEL5e
        abvYeijLh3qTRpJIGl24sgEURh/9rwQaPTDji5s3M+itibBxsaCiiJ4VCza0eayTGCk30O
        qzX38rx9cozG8VWoMAXM6y5XjSwDoAY=
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur02lp2054.outbound.protection.outlook.com [104.47.4.54]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-31-cCOpCt28Mg-F7BzJ5b0Y7Q-1; Sat, 07 Nov 2020 12:57:33 +0100
X-MC-Unique: cCOpCt28Mg-F7BzJ5b0Y7Q-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d+6vgWdxRLy/IJuz9Gnp2OdCw6vAbNoWFCw3yv7KL9LZXhcCLEwtnRe0f1W5I8jQV3MdtjNQWTD8M6tAkCKzLxXUxloXfdIdgKMn9LpK0+ZiwOHswNcA9Z4TCgXa/JwHx3NshpbHDjPCTg3J6hiCwLRXf1GJXLFGp/Ya0zZyJGXCBs7G8HN7HvdL52p8wLG/e6CziQ+ZHqvWgif3eZHrvzobi06yLI6GZTzJv9KexccK2EP+cXRV6iEWt1AGVUSBQZt5DHOLABd+DG+w26o22VMfpT91Z9AV02i1UhKPH1dcckAcU2klC88JgUu7Xn1y4ebesF3eWm3TvJo28bgFVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+aYPPTjseWHql79dS8YarCmkA4PrZoN2mUr1HeMgn3E=;
 b=ORoAIeNrn0iesX6wQm8W8s6QCYcpbRVA7jYMo5S087ERWG3uMTYCfTB9Bl+ektF7yi3U+LFFDHfwJ1enxUTG6VWFlaY06E/s41qcbesVk2sVEmrD7b4a47fGL4VA6U8XHSorzGr4RCT5dkmh+M1v70nFjnxXa2iDiFfbAb+YP80BEekUw1VCYVC3LzRKuVKUpCAZQdmnbjJjP9lBeRcCo2RZs9ixuTOjs4qoXQ6jRkWJAb2NHvQw5E/5WUeLgAk76KYKwQETsg81hE/Nsx3GQ9XbWG5n464j8gyjt8dJUHfqLkO/Z6JxcskEWyZhbKK1cP53QDdVWcZgGbH45sJMBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=suse.com;
Received: from PA4PR04MB7533.eurprd04.prod.outlook.com (2603:10a6:102:f1::19)
 by PR3PR04MB7242.eurprd04.prod.outlook.com (2603:10a6:102:91::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.25; Sat, 7 Nov
 2020 11:57:32 +0000
Received: from PA4PR04MB7533.eurprd04.prod.outlook.com
 ([fe80::545:8a04:2a5c:f4c7]) by PA4PR04MB7533.eurprd04.prod.outlook.com
 ([fe80::545:8a04:2a5c:f4c7%6]) with mapi id 15.20.3541.022; Sat, 7 Nov 2020
 11:57:32 +0000
Subject: Re: [PATCH 1/2] PCI: rockchip: Make some regulators non-optional
From:   Qu Wenruo <wqu@suse.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Robin Murphy <robin.murphy@arm.com>
CC:     heiko@sntech.de, linux-pci@vger.kernel.org,
        shawn.lin@rock-chips.com, lgirdwood@gmail.com,
        linux-rockchip@lists.infradead.org, broonie@kernel.org,
        bhelgaas@google.com, andrew.murray@arm.com,
        linux-arm-kernel@lists.infradead.org
References: <1eebc002101931012d337cda23d18f85b0326361.1573908530.git.robin.murphy@arm.com>
 <20191120170532.GC3279@e121166-lin.cambridge.arm.com>
 <e8a91353-49ab-7581-f2a8-b8b4729072bf@suse.com>
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
Message-ID: <2ed040d3-bcea-c15c-dbda-fb589d6e2c27@suse.com>
Date:   Sat, 7 Nov 2020 19:57:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <e8a91353-49ab-7581-f2a8-b8b4729072bf@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [149.28.201.231]
X-ClientProxiedBy: BYAPR01CA0063.prod.exchangelabs.com (2603:10b6:a03:94::40)
 To PA4PR04MB7533.eurprd04.prod.outlook.com (2603:10a6:102:f1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BYAPR01CA0063.prod.exchangelabs.com (2603:10b6:a03:94::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27 via Frontend Transport; Sat, 7 Nov 2020 11:57:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd4bd156-a968-4c0f-00e3-08d883144ee2
X-MS-TrafficTypeDiagnostic: PR3PR04MB7242:
X-Microsoft-Antispam-PRVS: <PR3PR04MB72425D493D16C7AF45EBC48AD6EC0@PR3PR04MB7242.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: faB62e8UgJCMudvElap6f7UaXm9Uxmvif+MLvCiFYtupHkXOeDEXyIkBLV4EW96jq6F5GzwwDMp7oqH0NO2w6T/guHJEczcDykiYxKqt9503O1qXle5YU5LRNjGlxfPxY8caBHMGLGsSd1+iaQ+LqpR9M3OqBTh4ibQDkEJpVTu/TJlkT8GXyxpBqp5BVhrSRXdhDgQbPxHrCu0JY8wNVlvCTlq7Hby67t85XRNZ7W98Atz/IiD8uhHT79kakydQ8lx1Gj35ddwhou7zf9xTlPVIRbiedoDGbZcV0qs3ojewKagvtPKN/tUN8hap8QdUvJ7Rs3AjsP5q+bNd9er6IQG8C9L+PHXqULjiNHJF0NRC9wsb0UWypYtU+/eIjeLsVTNV3sJLbJpjG9HF1wnDLOB56VmjuglrACDc6hid6xbPeibEuPKGT1NMnQWMolsRBrZ3nxxAHGVbJ9FeiqPG8Zl5B2PIVb6u/hTVG2IGZVo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7533.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(346002)(136003)(39860400002)(396003)(956004)(86362001)(83380400001)(6666004)(52116002)(6706004)(966005)(4326008)(5660300002)(7416002)(31686004)(2906002)(316002)(2616005)(6486002)(186003)(66946007)(8676002)(66556008)(31696002)(66476007)(8936002)(16576012)(36756003)(110136005)(16526019)(26005)(478600001)(78286007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: wgkSOawnKt/J/LGybptAEZkwJctDxMDu5osSIJOYGIpN9OCWsD9BBFXsjwkDdOkMkwCflJvmlQsHHDUWlSkk3S15PlxJjQktYiAsMcvxX8OMt+y5AEXgVmYE3NV0VNcZg9ZwN5VU5rwT0nRymODyUBkZHRZ8QS7U5tHZ1vE6mZUPZCOUYO1TfNsfEKOIOSUK7ti8UqLRTcGTj3TyIDVofMroBcL6bKQ66BfZM1hpGcsBWL8VlRQOfOOsyo1mn81+Wl409yh9TvLohCC+z+L501y8ay/A9Vpp79V0IG84T9+9hOmPnDD5N5PQ9jL54xxF7zOzQylAqunHWU8RV8pK5JL57wCuKBWa7E0hL83JVRgyIeem4vypqy5DX/RBL0dmyCjySI/olJQkp+zP3MVYRCHh7fzbElZ38aAbxSooXCBk5OO2nRGNNCCy+xeaZNuaac/hVM8T529RNguZkMZmxU4MExtf+Kik0NyLGi3n/G5UXm9vWF4IAW4gywfqGWhrdeYx9eTap7p4GIPO8dDIbuNopwW3tjV8lFWBzfnrJ9XruD+5uVLvdf8h4lhlujgy/hLaPXmp3CMZdKUNtUuxdevqXaLO+VYcyckUiD3uB0JrY2xq3qbykOkfBpTyuF7EHAdYJKrdPGkIRH+8BvdAEA==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd4bd156-a968-4c0f-00e3-08d883144ee2
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7533.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2020 11:57:32.1442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5eQdWZLpSlxVVksGCq2NOYjL5MEWk1PbUevRKS1l8eNT2UyIiPuqjlvARQmCf6Ki
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7242
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2020/11/7 =E4=B8=8B=E5=8D=887:36, Qu Wenruo wrote:
>=20
>=20
> On 2019/11/21 =E4=B8=8A=E5=8D=881:05, Lorenzo Pieralisi wrote:
>> On Sat, Nov 16, 2019 at 12:54:19PM +0000, Robin Murphy wrote:
>>> The 0V9 and 1V8 supplies power the PCIe block in the SoC itself, and
>>> are thus fundamental to PCIe being usable at all. As such, it makes
>>> sense to treat them as non-optional and rely on dummy regulators if
>>> not explicitly described.
>>>
>>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>>> ---
>>>  drivers/pci/controller/pcie-rockchip-host.c | 69 ++++++++-------------
>>>  1 file changed, 25 insertions(+), 44 deletions(-)
>>
>> Applied to pci/rockchip, thanks.
>=20
> Sorry, this commit is cause regression for RK3399 boards unable to
> detect the controller anymore.
>=20
> The 1v8 (and 0v9) is causing -517 and reject the controller initializatio=
n.
>=20
> I'm not a PCI guy, but a quick google search shows these two voltages
> are not related to PCIE core functionality, especially considering the
> controller used in RK3399 are mostly to provide NVME support.
>=20
> This bug makes all RK3399 users who put root fs into NVME driver unable
> to boot the device.
>=20
> I really hope some one could test the patch before affecting the end
> users or at least try to understand how most users would use the PCIE
> interface for.

My bad, it's not that easy. The dtsi has vpcie1v8 and vpcie0v9 defined.
It should be something else wrong.

Thanks,
Qu
>=20
> Thanks,
> Qu
>=20
>>
>> Lorenzo
>>
>>> diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/=
controller/pcie-rockchip-host.c
>>> index ef8e677ce9d1..68525f8ac4d9 100644
>>> --- a/drivers/pci/controller/pcie-rockchip-host.c
>>> +++ b/drivers/pci/controller/pcie-rockchip-host.c
>>> @@ -620,19 +620,13 @@ static int rockchip_pcie_parse_host_dt(struct roc=
kchip_pcie *rockchip)
>>>  		dev_info(dev, "no vpcie3v3 regulator found\n");
>>>  	}
>>> =20
>>> -	rockchip->vpcie1v8 =3D devm_regulator_get_optional(dev, "vpcie1v8");
>>> -	if (IS_ERR(rockchip->vpcie1v8)) {
>>> -		if (PTR_ERR(rockchip->vpcie1v8) !=3D -ENODEV)
>>> -			return PTR_ERR(rockchip->vpcie1v8);
>>> -		dev_info(dev, "no vpcie1v8 regulator found\n");
>>> -	}
>>> +	rockchip->vpcie1v8 =3D devm_regulator_get(dev, "vpcie1v8");
>>> +	if (IS_ERR(rockchip->vpcie1v8))
>>> +		return PTR_ERR(rockchip->vpcie1v8);
>>> =20
>>> -	rockchip->vpcie0v9 =3D devm_regulator_get_optional(dev, "vpcie0v9");
>>> -	if (IS_ERR(rockchip->vpcie0v9)) {
>>> -		if (PTR_ERR(rockchip->vpcie0v9) !=3D -ENODEV)
>>> -			return PTR_ERR(rockchip->vpcie0v9);
>>> -		dev_info(dev, "no vpcie0v9 regulator found\n");
>>> -	}
>>> +	rockchip->vpcie0v9 =3D devm_regulator_get(dev, "vpcie0v9");
>>> +	if (IS_ERR(rockchip->vpcie0v9))
>>> +		return PTR_ERR(rockchip->vpcie0v9);
>>> =20
>>>  	return 0;
>>>  }
>>> @@ -658,27 +652,22 @@ static int rockchip_pcie_set_vpcie(struct rockchi=
p_pcie *rockchip)
>>>  		}
>>>  	}
>>> =20
>>> -	if (!IS_ERR(rockchip->vpcie1v8)) {
>>> -		err =3D regulator_enable(rockchip->vpcie1v8);
>>> -		if (err) {
>>> -			dev_err(dev, "fail to enable vpcie1v8 regulator\n");
>>> -			goto err_disable_3v3;
>>> -		}
>>> +	err =3D regulator_enable(rockchip->vpcie1v8);
>>> +	if (err) {
>>> +		dev_err(dev, "fail to enable vpcie1v8 regulator\n");
>>> +		goto err_disable_3v3;
>>>  	}
>>> =20
>>> -	if (!IS_ERR(rockchip->vpcie0v9)) {
>>> -		err =3D regulator_enable(rockchip->vpcie0v9);
>>> -		if (err) {
>>> -			dev_err(dev, "fail to enable vpcie0v9 regulator\n");
>>> -			goto err_disable_1v8;
>>> -		}
>>> +	err =3D regulator_enable(rockchip->vpcie0v9);
>>> +	if (err) {
>>> +		dev_err(dev, "fail to enable vpcie0v9 regulator\n");
>>> +		goto err_disable_1v8;
>>>  	}
>>> =20
>>>  	return 0;
>>> =20
>>>  err_disable_1v8:
>>> -	if (!IS_ERR(rockchip->vpcie1v8))
>>> -		regulator_disable(rockchip->vpcie1v8);
>>> +	regulator_disable(rockchip->vpcie1v8);
>>>  err_disable_3v3:
>>>  	if (!IS_ERR(rockchip->vpcie3v3))
>>>  		regulator_disable(rockchip->vpcie3v3);
>>> @@ -897,8 +886,7 @@ static int __maybe_unused rockchip_pcie_suspend_noi=
rq(struct device *dev)
>>> =20
>>>  	rockchip_pcie_disable_clocks(rockchip);
>>> =20
>>> -	if (!IS_ERR(rockchip->vpcie0v9))
>>> -		regulator_disable(rockchip->vpcie0v9);
>>> +	regulator_disable(rockchip->vpcie0v9);
>>> =20
>>>  	return ret;
>>>  }
>>> @@ -908,12 +896,10 @@ static int __maybe_unused rockchip_pcie_resume_no=
irq(struct device *dev)
>>>  	struct rockchip_pcie *rockchip =3D dev_get_drvdata(dev);
>>>  	int err;
>>> =20
>>> -	if (!IS_ERR(rockchip->vpcie0v9)) {
>>> -		err =3D regulator_enable(rockchip->vpcie0v9);
>>> -		if (err) {
>>> -			dev_err(dev, "fail to enable vpcie0v9 regulator\n");
>>> -			return err;
>>> -		}
>>> +	err =3D regulator_enable(rockchip->vpcie0v9);
>>> +	if (err) {
>>> +		dev_err(dev, "fail to enable vpcie0v9 regulator\n");
>>> +		return err;
>>>  	}
>>> =20
>>>  	err =3D rockchip_pcie_enable_clocks(rockchip);
>>> @@ -939,8 +925,7 @@ static int __maybe_unused rockchip_pcie_resume_noir=
q(struct device *dev)
>>>  err_pcie_resume:
>>>  	rockchip_pcie_disable_clocks(rockchip);
>>>  err_disable_0v9:
>>> -	if (!IS_ERR(rockchip->vpcie0v9))
>>> -		regulator_disable(rockchip->vpcie0v9);
>>> +	regulator_disable(rockchip->vpcie0v9);
>>>  	return err;
>>>  }
>>> =20
>>> @@ -1081,10 +1066,8 @@ static int rockchip_pcie_probe(struct platform_d=
evice *pdev)
>>>  		regulator_disable(rockchip->vpcie12v);
>>>  	if (!IS_ERR(rockchip->vpcie3v3))
>>>  		regulator_disable(rockchip->vpcie3v3);
>>> -	if (!IS_ERR(rockchip->vpcie1v8))
>>> -		regulator_disable(rockchip->vpcie1v8);
>>> -	if (!IS_ERR(rockchip->vpcie0v9))
>>> -		regulator_disable(rockchip->vpcie0v9);
>>> +	regulator_disable(rockchip->vpcie1v8);
>>> +	regulator_disable(rockchip->vpcie0v9);
>>>  err_set_vpcie:
>>>  	rockchip_pcie_disable_clocks(rockchip);
>>>  	return err;
>>> @@ -1108,10 +1091,8 @@ static int rockchip_pcie_remove(struct platform_=
device *pdev)
>>>  		regulator_disable(rockchip->vpcie12v);
>>>  	if (!IS_ERR(rockchip->vpcie3v3))
>>>  		regulator_disable(rockchip->vpcie3v3);
>>> -	if (!IS_ERR(rockchip->vpcie1v8))
>>> -		regulator_disable(rockchip->vpcie1v8);
>>> -	if (!IS_ERR(rockchip->vpcie0v9))
>>> -		regulator_disable(rockchip->vpcie0v9);
>>> +	regulator_disable(rockchip->vpcie1v8);
>>> +	regulator_disable(rockchip->vpcie0v9);
>>> =20
>>>  	return 0;
>>>  }
>>> --=20
>>> 2.17.1
>>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>

