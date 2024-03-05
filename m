Return-Path: <linux-pci+bounces-4486-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AABC3871222
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 01:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 270CB1F214A3
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 00:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97027DDD5;
	Tue,  5 Mar 2024 00:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="eKrMvAVy";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="sbM9w8O9"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964C0DDC5;
	Tue,  5 Mar 2024 00:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709600070; cv=fail; b=UEFgIbNm8MJpSHhjcT3fzrGVDNYvZhpZhgLDrI7Ok3p5d8/aN/9kiE7Nvl8cjnbWcxj+oKCrW5QCHFnmYR/pMobeqe7am0pHtX2obv7v4YcG6QZ5Knli8czWEvGxPFjCJetD/6LcBnaz83SyMXlP2LKyRLCsb2c6ruP3s8m8fcc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709600070; c=relaxed/simple;
	bh=SWh8cwSDArzXWmIqgGFzmEFc9oii/+Yjsf0QAkABfx0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TrtIhsVos5y4V8sK37/J2sbl2JQVV/6rqRSKYPMFktGA208oPaFgK+PROHCo7M+jUzHwu4z6ktX28tYawZr4vMhRYEVC5sO/0oEKf3hzGfmwvJoZrbaSigAAKyx/pKLKL0PN1mQhOTMMkYJiOxr8IARyP42lCYdC1YyJYn6SLpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=eKrMvAVy; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=sbM9w8O9; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1709600068; x=1741136068;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=SWh8cwSDArzXWmIqgGFzmEFc9oii/+Yjsf0QAkABfx0=;
  b=eKrMvAVyClbdoBgRDWpnWK7GSHoSfJyBcCtTmVUL1AYDiyMe5ccM+b9Y
   YCKbNLEa1RGHzdLO4XyK8QQiGGHClInjcaqmSQFRgQfFrMqN3AGl+Yi56
   o1sd1//EiNIwQKeW2B0yJ3YG/ckMzRh5WJjm4j77uDhQaAHGFUU1kDGEd
   KZFXUG2/rMWl0SMiubJmLt80uaZigVgWKBuVQSP8TTsWeIskiovQgjU+q
   2CppKmmRf80vgHk4dWACLL2jmiyCMHs0SNXrNtcfy+bbP3b0OPJdw66dg
   BHM4sXk7WWpvL23mkS5n+0054X0WtB4heqxsssZaIGjn0D5b4p3tryIbu
   w==;
X-CSE-ConnectionGUID: UtN4ci90SHy9N3cKnig5kQ==
X-CSE-MsgGUID: +dTWcRFuQrCwmbR8SY0viw==
X-IronPort-AV: E=Sophos;i="6.06,204,1705334400"; 
   d="scan'208";a="10647784"
Received: from mail-bn8nam12lp2169.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.169])
  by ob1.hgst.iphmx.com with ESMTP; 05 Mar 2024 08:54:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AviuqZJ2aoIvqbvP0g+gesFPiDPujnnLNyUlYIBeskeH0d8ttM9BxQCxjj3uyrGLTcVWNUKD5MmIC3qOfHb3yXDs8eNq/cc9Y5vaAza31gZVHPtojOLPNoWd84HplvWIIikMKx3YWF9y3oArb8AQ8m8epDxyPLH02s7yv1AViswY4lr5kJAay9bxuXNYnHxzzqPx/PbFeQkkIEz7m3svKtQB6mz/tMyPnZgAsTCpSsUqhCpJ5ioW1CBkkC/CJDwtbCJljqM0MiqAudRNgysn0UGqlbWcRu+Qxg4/PYD7qqTmAZwCQnEAANJzuUCK1bjkVIa/O1H3AB10TJDfs9jC+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SWh8cwSDArzXWmIqgGFzmEFc9oii/+Yjsf0QAkABfx0=;
 b=eeedsNkU13ZDiBTY6hKQUdwVHBy5Isw50pXoo9CVgsI2hLO1AiY7rCsxrUgZGniKyK1efto18MJ1lQCn4u/78yyZRWbisCNfhtojKnww7eDmMKhZXvIU+kxi9H3s/jzDDcWsERq3DAX91dR/Bj5PXxRzGPZLR14sEhaij8/uSETJaoODoUCkyK2TxtDq9Nap2FPcdYkvoCd3GHU1egtamr8PQNi7EjaromxUz+KdkT/MVTSgfoB4lZ7mtaI3bpxv34ncJirr8O91MFxSREfnoZx0qIcDPRy+PigfM5a+pFG7WRyEASAxSf8AEQlMu7hEiVZlhNRz2fwU0aRm2y23LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SWh8cwSDArzXWmIqgGFzmEFc9oii/+Yjsf0QAkABfx0=;
 b=sbM9w8O9nPqGUdEKM48B1B4cBPAEAvN9PDcxBSRVlecE1go+xISnko9tU+M7HxUcJPldF7Fbm0miJrmorgLiZNFNX936bMksgtVRaq6HAI/KPuZS8XlgDioSh6WbxSFqtn4hESjTPnUYLr48pn1XDjzcEX6nePeGJCf50YBQt08=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BY5PR04MB6278.namprd04.prod.outlook.com (2603:10b6:a03:1eb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Tue, 5 Mar
 2024 00:54:18 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c9e3:b196:e5ea:909b]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c9e3:b196:e5ea:909b%4]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 00:54:18 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Hans de Goede <hdegoede@redhat.com>
CC: =?iso-8859-1?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, Andy
 Shevchenko <andy@kernel.org>, "danilrybakov249@gmail.com"
	<danilrybakov249@gmail.com>, Lukas Wunner <lukas@wunner.de>, Klara Modin
	<klarasmodin@gmail.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "platform-driver-x86@vger.kernel.org"
	<platform-driver-x86@vger.kernel.org>
Subject: Re: [RFC 1/1] platform/x86: p2sb: On Goldmont only cache P2SB and SPI
 devfn BAR
Thread-Topic: [RFC 1/1] platform/x86: p2sb: On Goldmont only cache P2SB and
 SPI devfn BAR
Thread-Index: AQHabjoIGS8drYkTYESgSSRDG5wTmbEnysmAgACID4A=
Date: Tue, 5 Mar 2024 00:54:18 +0000
Message-ID: <j4ezzqwp4lmgd3lx3utjebaeydacpvivq47xcmfolvz5ww4qyx@iz64qlexsxhy>
References: <20240304134356.305375-1-hdegoede@redhat.com>
 <20240304134356.305375-2-hdegoede@redhat.com>
 <be1c9329-1d24-4f49-b200-c8ac551b1fe2@redhat.com>
In-Reply-To: <be1c9329-1d24-4f49-b200-c8ac551b1fe2@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BY5PR04MB6278:EE_
x-ms-office365-filtering-correlation-id: 0dfcc23d-1369-4b4a-65b4-08dc3caec9cc
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 4NTppobIA7gwKhzTfG4P+gR447YI0zjWjp30evUjTqMPjL1IVKzfgAUOHGYKhzt19ZXkqp1aP8l2zc9MK5WRliEPjEfWuk9bVWjuekCqlEbyZVFIo3wQXT+iiPN6jpOpA4zDpvTK9TfWrRhIIQwvVbfipbzclN97Loth/AZlwn71CVqFKNtVFYPmpN4YXvkynG21ycK27hfQPjnginaB9AZRX4tKIjTj1AqzmqThOXXePi4i2TbheWOavdeacKtdBBDlmOzD62b8IhW7CpIiyr0GKafH2dHRsu6ad0VVlGX4JxiPzXAIOUXJC1WEU4IZv3M6qEUJ+qbKwYIYoGVxQ/n7UX3wZ5/qEFl+cGqkgffvrcCvQncobVC4fHCd09OIMEsGhLIdo3eFJPuovZIxDgnax9Gp82Cn1nhSUyM1GMGYEsYChJ6v1Y+3USSfE7KMghdzv5fmxEhLZCXTklOCQLFVqn8VklGsJxvQj7SzFH8pyIgLI02FRoQm8WULCp/1CKgbTrq667UChL+osqtFgn7HN6cO0OlBcDdSvDn9obKjM5C9ZGJJ20kx3TDnd0v8RuYz+9bobUVpxfm8uWwD9CbO2pXOBsby1PYHCqtihkxRYWu9londZU9jZwE9nTfV535wlSwK2Zr0jTFquDn9ztcrVlyYHf7ZanJug0q82h0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Jg23X5C7AZQYk134GVia5XhC9i4+dQjYPSIuEjKcg7wEBhOM/QddKx3Gbh?=
 =?iso-8859-1?Q?ZneLHH+v1QRBJ/e0jdWzQS/dsURXxsnLdSFeAQo2K3pZmxuzvpxK0KiIyp?=
 =?iso-8859-1?Q?6Vn80I5IQYuWlXQPj+WIuLhml8CmTT9mcKGJtDO6DW8H++fRVoO26u0PK3?=
 =?iso-8859-1?Q?STLQh65tnnlIe1JdAVQIArXa3SXppznNq4PpCdz2N7RTliudf2BlPB472G?=
 =?iso-8859-1?Q?MjDjW+3iD0D6Eo7KVPktGTfnmQ56SAP7U/7uMI8dJE8BIWVUMD1IGqF8jG?=
 =?iso-8859-1?Q?LsqEukgsUZMEAXNVxmPu2QxT3xdWmdFznvPuaiMNYbkbMwuhO5PravN0KS?=
 =?iso-8859-1?Q?pGGdKfMMhpxTi0cuKkEkh1f2TjHnMzNG63Fj+9PWulpWReToQs853Fkzer?=
 =?iso-8859-1?Q?+oGVsAzpFiRR5AQP9qMFbjdyzu3Cs9NWiMtSHnkVYziN89ayzGjaAbOckH?=
 =?iso-8859-1?Q?W0jlxheEhX/Z0is8gl0e0Fj/AXNOM73KceeVWxWMPUlMD8TPevKgA456nI?=
 =?iso-8859-1?Q?AQ1IrZyrmNm29Q2V5TknTCkrv2xy/Vg5nRgmi7pfvlYJxD5BjCx/gipHbr?=
 =?iso-8859-1?Q?k61Uvluc8ztF7UdqpxZzRx8oRPp0ZkAYuP6cBwzCiKj+u0vmYYLa6+FO4o?=
 =?iso-8859-1?Q?VAYFXxcPdpkfIIlJygOytl6hzMaAslmIVcQf+rxyn3CWOHeTrqDIU/dDK+?=
 =?iso-8859-1?Q?YUm093fwgBV/qmaJunteWG/PVelYBJ8tAimN+sf+d8c8S0nSia9vYFLM77?=
 =?iso-8859-1?Q?dAZu+JMyOL+teh4VnKAjcIBAvgM/Mc6G8gSFLL/vO4otH3dTDZJZrRlmI4?=
 =?iso-8859-1?Q?haW7MSqwjNOmMDaRTql5gXAC7PkUxJac4GYTrCVkhL6wdn4Hn42bicnXYg?=
 =?iso-8859-1?Q?zSv8+UuUo+ik1/Zfy6Cfaynw16RiXi9JgCLyljlX0PpSa0qM9LCl04kFUD?=
 =?iso-8859-1?Q?Bq3/R+LPTpHe3IZXqDRmZ+fd4eVU7ptjQLgGVPQr5ABjTZsiJYpauvdSld?=
 =?iso-8859-1?Q?I8uB/f3t5Op93ejq6yR03CumBllEP6OotqehG28rUsdLWhl7/95ESBLm0T?=
 =?iso-8859-1?Q?O1pvZOfTXVVcx3ddBm/SgsnDQw4lQSFtsrsjxOdUSS7BKeo1VXOoXiaCU2?=
 =?iso-8859-1?Q?ceM31k/L5b3aPcbev8otkgccCyCUZQfgEDifDo2hZQ5xYeqzipjTqyccho?=
 =?iso-8859-1?Q?l84UbSibGKikbBHeBQD8u+RUuRNUo2zm3uhWqwFdjrd7Tvl+piei82yw7E?=
 =?iso-8859-1?Q?FU9Nc0cuoiuptqEiDO/bbYqVD/LW36PsEwaSIjLcsLCXGn0hr62mQWabAK?=
 =?iso-8859-1?Q?4Re6g5XNQ0Ir96ku0+tA22JnGDCbTd8TX5vrISU6iIPEPjEMVMrnPY938H?=
 =?iso-8859-1?Q?7FGxbjHvSBPy3gc3azmP6ACE3AIF4nzq0iqSCSu8wQdXqx4yPx/BTHDHeU?=
 =?iso-8859-1?Q?sn0CCrZZioVt/5D/eaBG1FnZM1r6BRwD//gLfurlUIsS9YV4VKnWiBm7U+?=
 =?iso-8859-1?Q?WRGZ9pzxSDsF+uIRwjeDClNcC1l40Mjm82SflTMVWNzjVIGfFgV2cd45PO?=
 =?iso-8859-1?Q?MSOZ//GhS0nHJHuUT5TY+R4paNXE5Z4W78bFnWGYO54VAAA0bGgUU29FB6?=
 =?iso-8859-1?Q?hR7OtGlqF66d60stQCrfeJjyr9ZTQvM0AQiYYx+u2ibiz8poA/PvU1Gfb+?=
 =?iso-8859-1?Q?p8btXpOphH8nv5Bk0jY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <FC442EFA7F66AC4297450242D736487E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EaC84DTOFzLTFBfkzEz5dmC3hnIjRx7Q3kmx5kHmHrWU9bowsk7I4edm1cnMwQWUJWNHMatwoma6SIEK+2VEWDtBrfjhM8Z+TkXHVhh7oaSUZ1b0klw0VrxyXiDyPzAgC7OYhRpf4BrEqrkYdaFOqNnjvRiGYTreCrzuUnjtPfW/9ZLpX93PR+9xkFrTmtu2Vj8Rf8ojzn0WLDhXO1banGBIpt1YUcQrdET4AfPwYEXdwlxHlRqVRJ5slmewQcUemmTXQiuO933GUDjvM3ffgR+zXAdWrgKAwcnqC6LH0HrYp1RhoUzxtC5+mq9nmxoAywRX2Fxxge/Zk5IdIgsGtoZIPLLTAYRkbsdDwavZcfOu0Iu4QL8MmdpOFHIV9weHIVmxzTdm+6zABGYspUBGvSePWjrvS5/A+IE9Gm/WShBNEgo1s37IhQXdbMfO0GabTEc/MsJ7QhCVPTurHxNDTYsjqBxPnNlHFswXqwu6GiqRtXKCbXXgNjzVB2ML3KL45k9H0iRy2DoVEYke1Kkq5EeDGdiK0bCYslvaAoQII/pqK23nEOwaZWXbYPlpA95HGq/5+3jZTHH21r+GWEpthTOFSB/ZYw8c5rWwPXQa+Sgbuxos6RMLw0kvriFKt/pA
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dfcc23d-1369-4b4a-65b4-08dc3caec9cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2024 00:54:18.7335
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6kd61TDjJzbtJ/tF2r8Qf1fPRJp8Yas93gyIhq9iGJPi5B0rMYAqdo0wxpznQEkhOT4UWCBoC/gYMS4eFJ868rIFFc83r2yVuJYq0HD3k9c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6278

On Mar 04, 2024 / 17:47, Hans de Goede wrote:
> Hi All,
>=20
> On 3/4/24 14:43, Hans de Goede wrote:
> > On Goldmont p2sb_bar() only ever gets called for 2 devices, the actual =
P2SB
> > devfn 13,0 and the SPI controller which is part of the P2SB, devfn 13,2=
.
> >=20
> > But the current p2sb code tries to cache BAR0 info for all of
> > devfn 13,0 to 13,7 . This involves calling pci_scan_single_device()
> > for device 13 functions 0-7 and the hw does not seem to like
> > pci_scan_single_device() getting called for some of the other hidden
> > devices. E.g. on an ASUS VivoBook D540NV-GQ065T this leads to continuou=
s
> > ACPI errors leading to high CPU usage.
> >=20
> > Fix this by only caching BAR0 info and thus only calling
> > pci_scan_single_device() for the P2SB and the SPI controller.
> >=20
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D218531 [1]
> > Fixes: 5913320eb0b3 ("platform/x86: p2sb: Allow p2sb_bar() calls during=
 PCI device probe")
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>=20
> Good news Danil Rybakov has just confirmed in bugzilla
> that simple patch fixes things. So IMHO this is the way
> to move forward to fix this.

Agreed. This simpler fix is the better.

The functions other than 0 and 2 were totally in my blind spot.
Thank you very much for finding out the good solution.

>=20
> Shin'ichiro, any objections from you against this fix ?

No objection!

>=20
> Danil, is it ok if I credit you for all your testing by adding:
>=20
> Reported-by: Danil Rybakov <danilrybakov249@gmail.com>
> Tested-by: Danil Rybakov <danilrybakov249@gmail.com>
>=20
> to the commit message for the patch while merging it ?
>=20
> Regards,
>=20
> Hans=

