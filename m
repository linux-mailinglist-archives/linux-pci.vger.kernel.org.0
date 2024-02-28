Return-Path: <linux-pci+bounces-4173-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1053E86A9D5
	for <lists+linux-pci@lfdr.de>; Wed, 28 Feb 2024 09:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8D8628B7CC
	for <lists+linux-pci@lfdr.de>; Wed, 28 Feb 2024 08:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96AAF2C848;
	Wed, 28 Feb 2024 08:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="ohL5IzlV"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa5.fujitsucc.c3s2.iphmx.com (esa5.fujitsucc.c3s2.iphmx.com [68.232.159.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30AD2C842;
	Wed, 28 Feb 2024 08:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709108905; cv=fail; b=QUtfdBwAakvFbl1Y1xzgvnLSnzLsw4ZC6OuK/0qK1XvNgmgR24JRALDzFQjcIZ71EBosejLMZYIyhSywx9EXGjOEHn6R/sA+7g/9CzcWzgNW55JxNj9+uD9YavL+eiDb90dLT6CdlL5xJJHnjrvSxfOEWFeflmXOntcanDoP1aw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709108905; c=relaxed/simple;
	bh=lioody+5goEhPwr09LtmoNgns073Z2aRxQnTxg5IMDU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eVoVpU1bZV9MVMl7ekcItZHVyXeszXSU94fAraHtsQpmYWImmBv/nB9j5MOxa0KIhGIseJkrIsyjLpeTeWmXM/iatXhJA4z6xa6H2EmsPg9uo/SpqdcL3X/Jxo9P1PB/APCU5mPNd7QYka6KYvbyahMlETCNvE6BeNX/MGMEmWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=ohL5IzlV; arc=fail smtp.client-ip=68.232.159.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1709108902; x=1740644902;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lioody+5goEhPwr09LtmoNgns073Z2aRxQnTxg5IMDU=;
  b=ohL5IzlVkiafcZDr2YNTNDZVmwCpqiw21/RocHdUzmK6T5b3Wu4BuYoU
   O0RXwP50o32KBfpKscwjrvTphn6P7kCkBeDP8ztXrMTAUAQTp+gBdmcfu
   SC+nG+hF0N2clNt61vCW5Vpy5AqwbKz9Wd/p3V0Orm4vNJt5pX1cUOrV5
   Is9Ptu3YbwDQWq+8/FdmcS2zK4GLlzKg8UvmsrUNY6oyoPGcPoLAU8rks
   h9Bn8sj3Vb5ymF+IuERNDQaO7K1vtdhHrKRbHgC5a0kJ7VneW7zYyuN9m
   qtcO2lKHNJhVxXgsHpAPVTqWPotQcHdqNAEKhLQXuvOIM26ne5D6bNsqr
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="112782120"
X-IronPort-AV: E=Sophos;i="6.06,190,1705330800"; 
   d="scan'208";a="112782120"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 17:28:13 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M6x/1LuUkIXPj5MrKZVVo9xycCCG5CjR6nMFWb30BsZEho5dRJSHlKaIaxu8aFQ1vowV7i+4oOFVgFfl8lJh3vqf4gkACorQZI0g01p738AhTN9LPmX5TbAT31Psr/WmryrwWOgnIhlcO6yKFmi5dH4E3Vpky+srxk/EIVQiZqxjTpVsvXlq8pNGjK1y/otnNoupSPxTOcoXqGJaQ/uzw1y7SICMPWSPc0aWFlgwhMjxRcaz6nk+pGvvtaz674s2YYYRcS1g8BI/j/Eu2SiHVpBk0ZR08UderwTXYQ9y/ZTXJyER92yO/wgsVb3eIImryMxdFrZqARY0hfGB4MbOPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hBWUDwW7nObbAngPcS+x9z2d7k4URqC3yAGxISphQyQ=;
 b=M+oxVWFqv7yQmhDZNcFsmO8pE5YjU7Xo5i0IL0GhcVhvFPht/RtZt/Ekq18961JU+mkqZMYf88DjrlKiNNK9dBDMcizOtxThJ8LZRtobHKqN99zhk64BgYYqCly+qj8oVzW3dqTtQaHy2AtZg8UqR3Lh+YlBwh4jvuQcMalViGwFc2kZCXac3bOBGIEeT+dr0gKtnEWTceFXH37To1RHmEvnh5aRzGJR1WnFKRWu6OG6yp2cqkx6k5beT/TKCLCpBFsGmg6WNfefgmosWYlKh6iqW7w0O+fYdX09I1kQ89XOibLiGXDVnEUwbif4XgazCvnRFpC+HjxBvfWTxgkZCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSAPR01MB7182.jpnprd01.prod.outlook.com (2603:1096:604:141::5)
 by TYCPR01MB10795.jpnprd01.prod.outlook.com (2603:1096:400:297::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.15; Wed, 28 Feb
 2024 08:28:10 +0000
Received: from OSAPR01MB7182.jpnprd01.prod.outlook.com
 ([fe80::6cf0:1fef:737c:37d9]) by OSAPR01MB7182.jpnprd01.prod.outlook.com
 ([fe80::6cf0:1fef:737c:37d9%6]) with mapi id 15.20.7316.037; Wed, 28 Feb 2024
 08:28:10 +0000
From: "Daisuke Kobayashi (Fujitsu)" <kobayashi.da-06@fujitsu.com>
To: 'Bjorn Helgaas' <helgaas@kernel.org>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, "Yasunori Gotou
 (Fujitsu)" <y-goto@fujitsu.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "mj@ucw.cz" <mj@ucw.cz>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>
Subject: RE: [RFC PATCH v2 1/3] Add sysfs attribute for CXL 1.1 device link
 status
Thread-Topic: [RFC PATCH v2 1/3] Add sysfs attribute for CXL 1.1 device link
 status
Thread-Index: AQHaaVdC2CR7/iq6Xkay4ifkTSrZ9rEeZYyAgAECA1A=
Date: Wed, 28 Feb 2024 08:28:10 +0000
Message-ID:
 <OSAPR01MB718293579603A52D4D0F9CF4BA582@OSAPR01MB7182.jpnprd01.prod.outlook.com>
References: <20240227083313.87699-2-kobayashi.da-06@fujitsu.com>
 <20240227164339.GA239446@bhelgaas>
In-Reply-To: <20240227164339.GA239446@bhelgaas>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=055b43ef-c8c7-4f76-b379-d9015236f523;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-02-28T08:07:47Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSAPR01MB7182:EE_|TYCPR01MB10795:EE_
x-ms-office365-filtering-correlation-id: 1035d573-ffca-48f7-01ee-08dc3837328d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 0UKAvWKWeIGGK7HXvZUUjlYpgI2/ekNgs1o7e9yS9X2dZAX/KOvIqJwt3JEmQxADsl8wOw/h9TJZbvhqgzoL9lvzQR/3bHPbY5b2Kx2sI5TIjyoFKhuI34/ueqqtN6hWQlVDvQ1BOgpkMRWXMk93vRHE9TMHMjT9ZRxWW0BGYLhRFHxASLtfkAetUjtN9k/PS74yjDpXQ81bADnHa954+EGuLbTDKH01b6YFEm6v2WrYpXr5V6u5ajNxKnm3Z9UEHujtBqrb8MGL+KYIQbTcasGDE3JpQmqllL/t82yDkw5VZoDVUp3ismjWiSH73OueYjUMn3dDuvL3frbcV+kXbFgXYTUN85kJJ3rDumaSQygoUIXPkC9MuPSvI83hEPXRuVu3ei/cFFSeMcEiK2nJDa41vrYqT87reSfcUzQl9KVCGTNZlw5X4CbAxUM3hdW732uVfi6kiJmnJ6UnT4iu5B8iXwqLKblDsZHrMfJGHfn4a9uYb3a3/7Edj4amyAkXokbFEpVrbBxSp3T/mNh9ce8fFBCwSq6daSicbJuerEWZ1dviiyhnMhRGXb2Ni+CmLck1YGQlPU8Qc+IcVubgb7+cFGHHRgqSRFpGhs2RF+0+RICoWu+DXlAugJoyfeMTdSJ1cE5mSO/NlfrUxa5+O5YDBlf2ApW9ubQpoWfy3zQrDnvhxSi9FGbJLJGWxtl4EMhbKHb3Pk28kd0y9fOPjx+r4jngVdtq40kBHz+7XPSwTW2XXSTgW2LoxeXeFipE
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB7182.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1580799018)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?VmRFOVdKbGFTbUtmSWpMaUE2dWVhZlg3TXdqOXZGSEQ5T0dXTncwQnlX?=
 =?iso-2022-jp?B?TjFWL0VUMCt3bjlDYTRqSk5OMmQzRFJhRUNQczRrSkdXT2l4TTFqZjJG?=
 =?iso-2022-jp?B?UW5nSWRrSEdzRTlwS1FZeEttL0hxblpYVGZldy91T0VHSHo3MnhpeW5H?=
 =?iso-2022-jp?B?SUI2OHA4Y0RXcFk0cTBmdkFwbkltUVZaZnlzR0JaZE5UbWI5ckswYVJE?=
 =?iso-2022-jp?B?dlR3Vlp1MmhnUUFjcXpuVHlqZmJPdWt2VkxMTmY2cVdxaE9uQXFSejVk?=
 =?iso-2022-jp?B?NTdJSEEvdmljRFVDQUdOQ2FuMDI2U3BiYlI1ZVpJZG5iL2phaWxRR0lR?=
 =?iso-2022-jp?B?K1p4RXJwbnJEbFJWeHpiRUdPclF3b0NpNEdRaHI5cWtPQ3JzZllSSUdN?=
 =?iso-2022-jp?B?NUxZd0tqdUtlbUliTTlFeHpSbWNhcDlzMGNnQng5VDQrcEF4UmVVS3Rx?=
 =?iso-2022-jp?B?K3BBMFBIcGQxeHpQcUZvSUI4NFBia2lXb24rSTlSOGNtWUgva2tEdDNS?=
 =?iso-2022-jp?B?MWNmTnpJV0xack5iTGJ4WHVrOXpqeGJpZUNicmxpOEd5Z3N6R1dCRXhD?=
 =?iso-2022-jp?B?OEM2MmwyVVBXOXdHajJlc1FOWGlLc3JXZmR1QkJ4dHVFRTJVZGljMUM5?=
 =?iso-2022-jp?B?VFpINWtNcmIrc2ZhRVdDYm1TZ3QzbzRuT2cvclAxYkJlKzkzZTVFNlBU?=
 =?iso-2022-jp?B?b3Y3UUZ0UTZnejFDLzIzZEs5Ym9qeTRWRlowY21IaStGb1QxZG13R3pr?=
 =?iso-2022-jp?B?eTJSZEFqSUdpNWNJN2YzeE54MGZTYW0wNnBORjJ4TFZFUXVZMSs0Nlcv?=
 =?iso-2022-jp?B?blc0NXJWc1hIeGxvY0dtRndHcmJDbnB1RXJ3TjRJV0xodFg1eTJBWmNW?=
 =?iso-2022-jp?B?eUI1bUlQZUxTV3RWanRlOFBPNmpkcDY0MitoT01TNUxGbDlYT2dUUzUz?=
 =?iso-2022-jp?B?YmF6QzZhZ2c0WWdIV2NBbXA4b0V0K24ycEV1UTJJTGJFYWNTaXJrMGFz?=
 =?iso-2022-jp?B?Q1ZiVVFXRC8vd1FxY2RkL2hCSXRNQkZOWEJNQWVid3pWR3FpTU1uZFhD?=
 =?iso-2022-jp?B?ZzRDeUxKdW80MWNNR3E1bExKT0t4NmplNXVjTm04M1NmOFAreVlIVGQ1?=
 =?iso-2022-jp?B?TEtsc0ExeEo1T29qcU5RSmVweHZtaklKN2pZYUZmL20rcVRtdFREbDNz?=
 =?iso-2022-jp?B?SXAyYjIwVU55d0ovYmJSN1NhdS83Q01wSUJLQVhKYWg2WFRmN004dGlw?=
 =?iso-2022-jp?B?N0xVOHdNVmpXKy91cHRWekRzR21QWDZYTDFEZVZSNnpTNXJkMVp1MlBr?=
 =?iso-2022-jp?B?TG01RHpFZGpGU3dDaTloTERuWG9PRjVLV3Q3VEtsbUtEWTczMVVuME1Y?=
 =?iso-2022-jp?B?MHIxS3ZRSmpwU1ZyYi9iM01jRXBDOG91eUVURjVCSGZTL0dZeHB2ZTMv?=
 =?iso-2022-jp?B?K1ZXQVJrSjMrZFp0eWNGcHk5R3hpWE9BWGQ5TTluaTdNeERYaS9oM0da?=
 =?iso-2022-jp?B?MDFNNDJQUlRKTzZhQTg4OHl2NlVSSUtLS1NaM0x2VVJkVkQvaTZSbUF2?=
 =?iso-2022-jp?B?YndIY1pSSTBMeHZ6Qm5qOGl5MDV1RElCMnBGUVpua2p5dnhuYzlNaENh?=
 =?iso-2022-jp?B?RG1Kam5FUStDa005ZjNJekxZbFB1dkNnS1RDYWM5Tms0V2djY0ViSVNy?=
 =?iso-2022-jp?B?WlFtSTBiVGJTMVBIVXNQOURJREZhMDVOc09GZzdoakNMU0h2RWRMLzZj?=
 =?iso-2022-jp?B?VkRUUVFJOWVrQ1UyUGpYZGMxVmNpZ2FiNVVObitNc0YvZ285Nm5zR2Y5?=
 =?iso-2022-jp?B?TCtnWFFNWlkwSzRuVktCaUlVOVFOSnZSYWYreEIxM3A5bHBLSi9DLzIv?=
 =?iso-2022-jp?B?cFhQYmNHeG5HUEJnQThGNDArNWpLcXQycklRdHhyTFhyS0Z4UzR3UXVF?=
 =?iso-2022-jp?B?dmsrYnRhZlFRa1k2eW92K0J1MDc4cGF5Ny9xWGFReEppY2NyN1hmQ1JF?=
 =?iso-2022-jp?B?alpPaE03YXVVUTEycGRKVTdxbG1nOUVHbnJYS0J4MjNSU3I5U1lQNUFV?=
 =?iso-2022-jp?B?N05MMkRkNzRqMjJyc3RKaE5MK1hCWTJESTB2NEtmNDJlOTVvZDlOU3cr?=
 =?iso-2022-jp?B?SDB6WklNMTVMSnRqWXZtR3AzRTFoQTFHcSt0SlZRL3BQSHNGeVhwWW9U?=
 =?iso-2022-jp?B?dGlDdFg1bWFhaW45MUtnQkE2ZktBUUxPV3ZtY2N2RXNvS0swdWhQUlpD?=
 =?iso-2022-jp?B?UHJKc0ZVWVl5NnFXK3pKL1pRaTMvV1Y3ZDZMYlB4RjRxNEZuNUpueE8v?=
 =?iso-2022-jp?B?RTA1R2ZKM1l6eFp5M0dmMUIxc3VmZ09VRXc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vaNJkywZ3VKZC0kkJoGkSZX3OM3drbHrbRhCZyymVwNnO/qI65cEFCXli42qPVwnCpHXuYYUnUCgCvULDy3Zkblf5NSBzdg0ANopn6pi4iQMM5wMZ7Cll9tyTmoEQxi1ShQF9yBGxfqqE86GsZmxmjk7a7uxoVYeEUwGEhoiOyQql3ZvDV1I1VDSu5m+B8e2On8F5k0l20Et1vwjCrepK1gPnEjfApmreG97Jcus7DOGzODYXVStEosRULNIf70jQRUQ3HItsMleoeoV1H5dFVfKaTmUMsYsI5DHRMJNhpJ91KNxwwxOyv71C3uWs0KS8Ve+B+fyuYPN7MLnQ+YRhjjdOh7oiv0Sjr0q9oXgAMjRmmDmGWN0zan/sJqytSHp4o1YFJG/eCRSFrCE95rpGQWwRJ93vTl0uzvexxs2j9U9EFsTh5+ivvYEY5NQzN2KhCr7rSnN3oHdf2tB8hdrfeTv+naLTl99zCkRtXzPyOxju/Uo0f4A6/hVgOG7s3rUhc5qAV3JRNUqgad3FU/grvDPTnzplODADH72eft0C7RLAEPllMWSi//ygBxBhZKyDdWZV64y9xmz6ZL/4Vailwxyb0taX8341ONGOps+cDOABUpvIMGkzpKoMrottKik
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB7182.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1035d573-ffca-48f7-01ee-08dc3837328d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2024 08:28:10.1673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mJq80ZIoiT0wtWHiqm7v0y7jtBY9qxdMzD4qdDUQ1QL/kYp/ECuTnSlO3V7bDoniTKpT2vK0oqlw2W+gOILq0lPcRTON/CAQr5pb2gnHFTM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10795



> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Wednesday, February 28, 2024 1:44 AM
> To: Kobayashi, Daisuke/=1B$B>.NS=1B(B =1B$BBg2p=1B(B <kobayashi.da-06@fuj=
itsu.com>
> Cc: Kobayashi, Daisuke/=1B$B>.NS=1B(B =1B$BBg2p=1B(B <kobayashi.da-06@fuj=
itsu.com>;
> linux-cxl@vger.kernel.org; Gotou, Yasunori/=1B$B8^Eg=1B(B =1B$B9/J8=1B(B =
<y-goto@fujitsu.com>;
> linux-pci@vger.kernel.org; mj@ucw.cz; dan.j.williams@intel.com
> Subject: Re: [RFC PATCH v2 1/3] Add sysfs attribute for CXL 1.1 device li=
nk
> status
>=20
> On Tue, Feb 27, 2024 at 05:33:11PM +0900, Kobayashi,Daisuke wrote:
> > This patch implements a process to output the link status information
> > of the CXL1.1 device to sysfs. The values of the registers related to
> > the link status are outputted into three separate files.
>=20
> > +static u32 cxl_rcrb_to_linkcap(struct device *dev, resource_size_t rcr=
b)
> > +{
> > +	void __iomem *addr;
> > +	u8 offset =3D 0;
>=20
> Unnecessary initialization.  Also, readw() returns u16.
>=20
> > +	u32 cap_hdr;
> > +	u32 linkcap =3D 0;
>=20
> Ditto.
>=20

Thank you, I will fix them.

> > +
> > +	if (WARN_ON_ONCE(rcrb =3D=3D CXL_RESOURCE_NONE))
> > +		return 0;
> > +
> > +	if (!request_mem_region(rcrb, SZ_4K, dev_name(dev)))
> > +		return 0;
> > +
> > +	addr =3D ioremap(rcrb, SZ_4K);
> > +	if (!addr)
> > +		goto out;
> > +
> > +	offset =3D readw(addr + PCI_CAPABILITY_LIST);
> > +	offset =3D offset & 0x00ff;
> > +	cap_hdr =3D readl(addr + offset);
> > +	while ((cap_hdr & 0x000000ff) !=3D PCI_CAP_ID_EXP) {
> > +		offset =3D (cap_hdr >> 8) & 0x000000ff;
> > +		if (!offset)
> > +			break;
> > +		cap_hdr =3D readl(addr + offset);
> > +	}
>=20
> Hmmm, it's a shame we have to reimplement pci_find_capability() here.
> I see the problem though -- pci_find_capability() does config reads
> and this is in MMIO space, not config space.
>=20
> But you need this several times, so maybe a helper function would
> still be useful so you don't have to repeat the code.
>

I'll take your suggestion and create a helper function.

> > +	if (offset)
> > +		dev_dbg(dev, "found PCIe capability (0x%x)\n", offset);
>=20
> Testing "offset" acknowledges the possibility that it may be NULL, and
> in that case, the readl() below is a NULL pointer dereference.
>=20

I will check them.

> > +	linkcap =3D readl(addr + offset + PCI_EXP_LNKCAP);
> > +	iounmap(addr);
> > +out:
> > +	release_mem_region(rcrb, SZ_4K);
> > +
> > +	return linkcap;
> > +}
>=20
> > @@ -806,6 +1003,9 @@ static int cxl_pci_probe(struct pci_dev *pdev, con=
st
> struct pci_device_id *id)
> >  	if (IS_ERR(mds))
> >  		return PTR_ERR(mds);
> >  	cxlds =3D &mds->cxlds;
> > +	device_create_file(&pdev->dev, &dev_attr_rcd_link_cap);
> > +	device_create_file(&pdev->dev, &dev_attr_rcd_link_ctrl);
> > +	device_create_file(&pdev->dev, &dev_attr_rcd_link_status);
>=20
> Is there a removal issue here?  What if "pdev" is removed?  Or what if
> this module is unloaded?  Do these sysfs files get cleaned up
> automagically somehow?
>=20
> Bjorn

Thank you, I overlooked my consideration of the removal issue.
I will check current code and add a cleanup process.


