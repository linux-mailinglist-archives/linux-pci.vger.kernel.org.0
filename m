Return-Path: <linux-pci+bounces-4415-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E68C870100
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 13:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1830B1F21BFE
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 12:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F78C3BB2F;
	Mon,  4 Mar 2024 12:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FLWeHiuL";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="nU86KIzP"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE426224DF;
	Mon,  4 Mar 2024 12:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709554409; cv=fail; b=LcQecvD2r14MZ63grWRaGdmxT9BphbW9q15XR8d2JXOh19hFV+oGGemczy5yUejVK+TxDtE9+0XqwAm3Mrq5E6A5tYUfRVM6Zrdd1tB/uMMmWuJXSZ5ODOE0LImLyhYIvFd6ga4x/olZMtghlZaa2DzycrYPNNBDg3m0lX4m4mY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709554409; c=relaxed/simple;
	bh=8Wmb4/SDHtpglGifqngIn0k4mCv6v/VAILbYiMc7Eh0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eVxZ+/So80vFy1KgvDY/gsek/Ba+fgZQzzlTWIYCvBeEBz23bKOmVMNn7sjC7NCO/2LQ0jG53Vkumtoyxc78LA57EnVs0BjmZpKMoKxm6cUVHI6dYUIYOJO2icEjflbNjXPP96Pua8AmzLas1LQadX1nwGHdEAvNY/vE4H36giM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=FLWeHiuL; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=nU86KIzP; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1709554407; x=1741090407;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=8Wmb4/SDHtpglGifqngIn0k4mCv6v/VAILbYiMc7Eh0=;
  b=FLWeHiuLwzfgX6O2AHMfoJQHIEwwUQNTfLZk0EUYZb5C7JroB2khOTZ1
   3evbaISZOBBcSIqG+htSBtmnyoau4vXnnSSyXnmb7vEctClQLijKyCaDM
   mzNEVn4odGoCjE9tR1cpUQSDgrnB7ETE4iID8YoCF/74v4Xv3upyZt7a7
   nAg8bViIPSlV1XV4vTCRkp+d5UUSj0Ux+kSXWN9IjPQN0kksxHWw/joH+
   ArHyBxGzT3OUc1IE8ImyYVGHuV37I/Mnz+5Sj0xDuaQLY7bbT9tJXoIj9
   9fCRDCydWvGomnf55wJ7ina9qmQRVrbXTlrdgg4rzJuLLUQl7ntj9SZNx
   Q==;
X-CSE-ConnectionGUID: bb66REfdQQqW5mlffuChJg==
X-CSE-MsgGUID: 5grDp1dtQO66GHsuCHZ7Cw==
X-IronPort-AV: E=Sophos;i="6.06,203,1705334400"; 
   d="scan'208";a="10721704"
Received: from mail-co1nam11lp2168.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.168])
  by ob1.hgst.iphmx.com with ESMTP; 04 Mar 2024 20:13:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kaxJJGJ0R/01VlV8vFRTHkFYkNU1gtdA9rNVktNT3Ofn8ZM+s7XRW3odECvzXo4vhCHuXPZTXcIDrpyevCuPzmpNK71owr+XhHlnT1piVYONW9kkEppcrrrQix8foiG9QAYcr32irZ8mKAIYT4WRxqx8o+t9QcBIJrxFPa8W9rWrvESvkh6txcsi1qz86OWeyhSuPiMd4dN1YePGm+svuV/CD4/Uwi6gI4IkWEgZdMnEe7rFZpRGGeXQT+z1K5tE7cvqE8m1LxBJcnFHmoBbmhCJG5LJoIBqlq7eJVcOqOMJDA2NBPkFjILpFtGwAxhfCmIThBjF2h2t/rmn+AOGTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ygJtFPAkFBsLY/lOONsZ8N7pjSaeG1bLQm4+EfP3l8g=;
 b=DY77e+R11KDvO95rf38mFPZIT3Lb0dj8WNX7DOMeOR329TE8hWchAH3hmtmOi2Bli7RK34gpzuQfiSgMBr6TQF1CYTvcKrXqYCwI78E5+TooYhHxmGrCOUPiKV61ahZN4THjiXcd7SkK8gcYaD/mm9VX5wkq2rJbZPjgl+7tR/XR3wunr+onVA6Yu+g3nglqCrY2QEhZoPRu6fupzBl7F8+Pb7bszd5UKA7a8+VrqOdDHKl0olo9C/U6+JlxyoigI09z3fkUKHlS1K4LPIQklHoVVdbWZCYnEaxL/KYbAmP/5hrV7zkOZnrpy4D2Avwz6uo14OVSzCaSfqBLc2moMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ygJtFPAkFBsLY/lOONsZ8N7pjSaeG1bLQm4+EfP3l8g=;
 b=nU86KIzPGHMSWoQT233/6rlObFcejd+fkdRfG7n8cSJJZkBNHkfkrBhOelZVO/S0+IBpkGJhTP9a7milnQBT2ACR6udTZzLr8co9vGuS7m07oaM8KMfOPsHKMN4L1hLnaQIxuyispzXtgLPrxJQJqyHFsnI2Hxq/P7abUMJOjtk=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 PH0PR04MB7287.namprd04.prod.outlook.com (2603:10b6:510:1c::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7339.38; Mon, 4 Mar 2024 12:13:17 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c9e3:b196:e5ea:909b]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c9e3:b196:e5ea:909b%4]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 12:13:17 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Hans de Goede <hdegoede@redhat.com>
CC: "platform-driver-x86@vger.kernel.org"
	<platform-driver-x86@vger.kernel.org>, =?iso-8859-1?Q?Ilpo_J=E4rvinen?=
	<ilpo.jarvinen@linux.intel.com>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, "danilrybakov249@gmail.com"
	<danilrybakov249@gmail.com>, Lukas Wunner <lukas@wunner.de>, Klara Modin
	<klarasmodin@gmail.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2] platform/x86: p2sb: Defer P2SB device scan when P2SB
 device has func 0
Thread-Topic: [PATCH v2] platform/x86: p2sb: Defer P2SB device scan when P2SB
 device has func 0
Thread-Index:
 AQHabEDqvjYLP9d8aESjxeYsLpcDnLEkDfgAgABHMYCAAMeNAIABToyAgACBqICAAG6vAIAAE0MAgAATTgA=
Date: Mon, 4 Mar 2024 12:13:17 +0000
Message-ID: <2c3gyhvwncqgfa6t3tb6fj3fk3nkbzpmlgfyzwjgwmmlnhxssu@d25ihdnpwado>
References: <20240302012813.2011111-1-shinichiro.kawasaki@wdc.com>
 <gl7rsalwdwdo4rdes6akcnd7llrz75jjje2hchy5cdvzse6vei@367ddi3u6n2e>
 <a26554d3-bee9-4030-a06c-f886ba2fffb0@redhat.com>
 <r6ezdjqb5hz5jvvaj2beyulr2adwht2sonxw3bhcjdvwduyt66@2hlsmnppfsk2>
 <7935add6-a643-43dd-82a8-b7bcfb94d297@redhat.com>
 <6sbllfapnclmu5sjdtjcs4tyzkkr76ipg3i3rtqyyj7syhtkwd@d2l6zq2co7zt>
 <a5dac02b-c16a-45d1-8157-0dae1b034418@redhat.com>
 <d6a95bd9-dac2-4464-af84-9394a36b7090@redhat.com>
In-Reply-To: <d6a95bd9-dac2-4464-af84-9394a36b7090@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|PH0PR04MB7287:EE_
x-ms-office365-filtering-correlation-id: 059eef5d-d14c-46e5-a58b-08dc3c44796e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 1+1laZBL0R4c1+l2rJdQoSWbF5cVBeRkuR4arQ7NlBIbqRY9UsPhnke0dj7PpwoaIvqhxJbVBSnVHMhac5bTilIzawPHMkiM7JezgDPfkO2zll6bliGOTuaNwqzUdVNq9EOX0aVq4NyhXykL71MgHFanhyYDw7GlOwRMiLBH+HWnBLOyM+vnuMkOSSu3eSBLtaQlhXPwXraAKJKMXdFasrRDVOOpAue+FWzlp2kwcLquKIK5BsF5ExqP6NaGW0IpfJELoKv9xOljGXaqxEtZ04CDQV92lAiZnDGSE1KJAawpoLMlZI2Ux8f7nMt5D2UtNCMcpe5VtwcrXXzvTArvbibF1bOuA0mHpyQb9UpyuV0YCTpG5KMcmNu11c+c1H1Q8/FgGe7fvvYXtKOFG2klOiKLvNBLP8nw4R9aNQmhSMEeiTNcHLlU9BF3Q60J6vceg9/4cjYZMrGygGa735B8IyYPYwbZmjnNV4WbZfKL4U8Hhwte3OEvvNwrK/B7ysQtIE0M6XhJZZrM1TImh6AdTg87HFFaUhWTc4ta9aziAqFLuA5easb2ocRYlsdVmHE+rfqMHAWfDGH7hXHeJPODcXTjMBLoRHL1uTe+LALvkihOUiSBK+JVWlaVpxSA34ksIuwQCUR0aIfdlLs3bgfMD12iwdMLJHULOXGlHUrf73aQXCssO1LIJxbxDqUqWGu6cKKpYANMX22j74SahRNs1Q==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?t5qvOB5z+UJihCCnBSNYqubAHLcDwBtLphWHZOSWwEd/HU8ZNPzKXgpFEJ?=
 =?iso-8859-1?Q?Q3zTGYENx3imvbwePTveO/ZlWf7lw8CSE+PpHtaRYS3vBhVEyV46Hwsrvy?=
 =?iso-8859-1?Q?oHdpyCJGURGyZunCvbOruNfyT69H8822NrjaZ5CIqMJvBDCpRW3HkwEReo?=
 =?iso-8859-1?Q?GwJXaNHa75lfrrfBMX8tLkSyhGMaczdZM876DI3iTkS1epNBN7EZYYuKh9?=
 =?iso-8859-1?Q?o087br8zat96FwNPX25Ti+NOnRxAxF2ADk6PaGBCypMHXrIEDVRaIJQueD?=
 =?iso-8859-1?Q?htzAo5jZWfCkANaFx5+jFY0oruLdbTRyY73mwb5YuBn4NACM76bMGTuibZ?=
 =?iso-8859-1?Q?brIidQ3ydN5JVoVW1pLjRkM1HSeB59WUGdJsWP0s2ad+56fDAMTQAO0W8P?=
 =?iso-8859-1?Q?2frkeOy7YaZh04bP9le6g62205Ugn9efuYvo9Thtek4IB9LRr1MgcBS3EN?=
 =?iso-8859-1?Q?eUbj8qzLvprOygt2P0DXTDN18gMK4UZsnPFVcco2F7/6rr86ZYwbQD8w/m?=
 =?iso-8859-1?Q?sjn3wb7ItQXAKXwnVp3nvLFQU63tbC6iHnVztH9oHxYETmyasUe8ntuTCN?=
 =?iso-8859-1?Q?nX5zd4EUtfnSSZBryCjUeTwYnj5D1WZjVtnro6tWmB5hpB8R0kkjhJrn+7?=
 =?iso-8859-1?Q?YXC3V5b37Z5RJRV4WLvITLnrspY1KPFPFVr4HYGagYF0j1sQ6exNwpguwt?=
 =?iso-8859-1?Q?64GngrYOVcYrOghq2uvg7ycnBZkIgomN6NRM9FHhGp1GslnH4mcb88qmYr?=
 =?iso-8859-1?Q?6g3Fcvsx0Jp/aMtDa0hITKSTX+8phIFg5zB01TmXJ2UvvhIyccZiFM2/uV?=
 =?iso-8859-1?Q?yeAm0O/3IxfFrdYvLl4+nkTfctm4Yi+PAv3m/jv1jnLFwqpkh+XRH6ns5p?=
 =?iso-8859-1?Q?UrScaYsmoY2fKaDoqb8GV0MsF0/8GjMrr0EtRnt3JOG6wb1fA1gDz0Dc7I?=
 =?iso-8859-1?Q?QnreKhVoyp7fX5mQAUW02dG2IJvK5OuxEtUk741cajvgmxCZbeLHY7H2OE?=
 =?iso-8859-1?Q?Yqzrt8a/Psn+qrWnXxH26lzuHy48GCCNoSN3p+x/2HLLq15P+58xieHuWC?=
 =?iso-8859-1?Q?yOripY9GiZrnj4Y85xroOWNqgY+wpSUw6zP8zJpnT9Vw/HCxQC24+ozjW4?=
 =?iso-8859-1?Q?xW3HWd5joOadAgCLngnVf1fY8zRvi0wIOTStf6OFzKVtchjJdIFJ/z48GH?=
 =?iso-8859-1?Q?bBQUGmVg3y9JpI98j52XuoJKetvXhl1DLVHbXvCwwFm3gD5I1l/DkzlJ9o?=
 =?iso-8859-1?Q?hScddsjdflOExzTRF8QatEPcczAf4bCd3g3uGWQ8rLHvegXHapfuaWI61R?=
 =?iso-8859-1?Q?ySPGYxf4YHm54vAFl1AVb8J1XqcLG39T+2Q41fivduOTUP5gpvpQGIGbQc?=
 =?iso-8859-1?Q?Kgbb2FRkP6rVkF8S/Stpjw1i4RKTBfTUMrMGcJAUjP2J4rvJcRgP/9LkJN?=
 =?iso-8859-1?Q?NHg539nbsL8K4xbsUKpE3F1PKa/bavW4g5t772YcW3Em/kto8ZcMhPk5HM?=
 =?iso-8859-1?Q?UpK8J5WcrZzzGe7COnzUY32WVyuIUJszeoPJfvVQdy6KG68ltkn5YrOk9+?=
 =?iso-8859-1?Q?LCqi8Pv/3FwLQcxZs1kS+XSt+VFE1fyHHVbYzdHGlsyGAiyzzg3cn4T3ov?=
 =?iso-8859-1?Q?asAXRiX3pmb4yzK9SGPJ3vQAdSMh/ejhqJfy7w0iW4YQqCxV38AT4WRjb/?=
 =?iso-8859-1?Q?fhHVOw8eNMkZbGVk5KU=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <A885EF2E9925B04BAD860A1E59630782@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZwDF+C4RMCOsALxKc9rZMo+Kysg/jNTXzFvevQh0VybH5ARl0jW9uPJ3+jPFxwk1qFMMe/NVraSrOPC/dIVClxZE4RODrls59W64+vrjEWKpuOzCx9MPX7yw6bCDzLM69X3S9CGStKwTdnEVINJ0d1XZ4GnciuJg+CtJXFeVMH3zCKcJF3xqca58PgJwa3s6lnWqih1EfCvjoraC11bby4bnFZWPrg2s5auRgeGdVDGZ5OtSeNhw+yQU605yLRamztjO4iRhpureIbefUg1Shh8Xg9FwJ2Jcc7SBGJThWwOUeXtjpPgxQOAUYdCEErQHmtn8d09jZc7LqS5waoFyraVzU7igtZhE6YOsrzrGgUx5rRLgRnPq4UlilerKlpALSkygMfeYm1xE3mgbaFNCEwScXH/H2U5cYtAtUfqigGFfQzPwzoOzppqMO2FUWHm5ylUIBficpbkTG4Xar5Gv1lUlEOsBW3Dwbi8yUDbUmcy4VoV9iUbqbcJO1+erPZq/dx3rTERRDmYYiecnZHGML3bPSwh1WZD/rk8iSx0szMbCia7MuUQTV3Ufjegrh/nnpagYFO+/Bn/dKgNZX/Ss9BgeTrhrk/DUcnDbzQY7TBzQNJEHEqu3rqIHD24YMqhW
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 059eef5d-d14c-46e5-a58b-08dc3c44796e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2024 12:13:17.1966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uBngqHgNXrb/8LUyv0EojI6bTaIfqseV4N3kXyL6GoClakr/8aPYgUFkzML2mj3OmdWP5iXLcMoyBPxBeXtfEKQ05qWzeeaiZyb+Z2KTkX0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7287

On Mar 04, 2024 / 12:04, Hans de Goede wrote:
...
> So the p2sb_bar(devfn=3D0) call actually only happens on Goldmont from:
>=20
> 3) mfd/lpc_ich for pinctrl    devfn =3D 0
>=20
> and then only when the ACPI tables fail to properly describe the GPIO
> controllers as ACPI devices, if the GPIO controllers are described
> in ACPI, which they are on the ASUS VivoBook D540NV-GQ065T then that
> call gets skipped.
>=20
> So on the ASUS VivoBook D540NV-GQ065T p2sb_bar(devfn=3D0) gets never
> called. Which explains why not caching it fixes things. I assume that thi=
s
> laptop just seems not likes the P2SB is touched at all and by not caching
> the BAR for the P2SB it ends up not getting touched at all.

Thanks for sharing the insights.

>=20
> This also means that likely the P2SB devfn itself generally speaking is
> often not touched on Goldmont platforms. So we can avoid the lockdep
> issue on PCI bus rescan there by caching the SPI controller
> PCI_DEVFN(13, 2) devfn from fs_initcall(), since that will be the only
> devfn for which p2sb_bar() will get called (except on hw with the
> GPIO controller missing from the ACPI tables which should be rare).

Oh, this sounds a great idea.

>=20
> I have prepared a follow up patch to your v3 to cache the
> SPI controller devfn instead of the P2SB devfn at fs_initcall()
> time. I'll post this shortly and I'll also ask the bug reporter
> to test the combination of our 2 patches.

Thanks a lot. Looking forward to the results.=

