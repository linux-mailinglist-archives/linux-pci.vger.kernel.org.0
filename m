Return-Path: <linux-pci+bounces-4376-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5FA086F327
	for <lists+linux-pci@lfdr.de>; Sun,  3 Mar 2024 00:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 562FEB20B87
	for <lists+linux-pci@lfdr.de>; Sat,  2 Mar 2024 23:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2664AED4;
	Sat,  2 Mar 2024 23:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="duWKjSfH";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="iEc+H7rz"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DB08F5D;
	Sat,  2 Mar 2024 23:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709422668; cv=fail; b=EsyhJjyZxkzYinNq9ns8hKnjg08ZZdGGsOi3pVLW8m/SC4Wq4XtaJq+KHe2YMButufpD9JH1IHu3TtudwkZsLUt+2EO5Wbv2A8DAZdDVJkBW4rN7QUka2ZxuWn09aU3zNsc2Xj2RDDfK6CANztQF5l4bwkYHpeYeNZmiS14eYTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709422668; c=relaxed/simple;
	bh=Tqv5mdgCtUCUkHfK037pt8xbMrxlWDNIL+EwsQSzcm8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sJlxIQOkd+aPi0epRLQC6b37CAVq3fToqt/79Wg5Qm0J6f9oa7qOsEOianZTNUVnm4B2MoCOxdYySzch0zvBM2uoH9yPCA9TlGXRjBP6SdelcGtssWjCl7H4JczB7q6RaSsUfvfAC/LWCJWCKpnfdCqvu1fKJ4qmIDA3on3gwVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=duWKjSfH; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=iEc+H7rz; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1709422666; x=1740958666;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Tqv5mdgCtUCUkHfK037pt8xbMrxlWDNIL+EwsQSzcm8=;
  b=duWKjSfHvg8twNpcI/XhLiIebFegkHWfkJUOdg4byIWmslm4NXLCuWyR
   vSEcLiWb78EjHjRvHh2WRZMZ1oH9kpH55vRspaOD+HJvHt/Vm/BvZSznK
   sOZcnJQNQix7nr455LKJRXVlOJUNZJEgvHjeUdBuqKGYdqIynCe4luc84
   jzkp7AMA6FSFLfCq/g2cgqd0aVPMYL7wFftfswVqDyg3jOUJMHOGAcZPj
   14OC+3oA4MGMm+jzM6N9M96loOcUQVuDfgilOq1g0YQlku0X0Rr+JHlO6
   /pHGUiUeZAb9k0Tqm9AFCOhp6AtyecP+/rrH2dHaJFWQQyAcKB4kpW3Tn
   Q==;
X-CSE-ConnectionGUID: W4Tvz3LFRFOqoTdgJqEsyA==
X-CSE-MsgGUID: r/g0/wseRReiyDL8VoHlaw==
X-IronPort-AV: E=Sophos;i="6.06,200,1705334400"; 
   d="scan'208";a="10218445"
Received: from mail-sn1nam02lp2041.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.41])
  by ob1.hgst.iphmx.com with ESMTP; 03 Mar 2024 07:37:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AJWTC5gG4Y4uD80fl4a9r+2PMhqjXmbfw9GN79vSoANahAnwf4FtfjHX28bPZsXYvyZXbSSCBcm0hWeAvmXZeL50G35esIt25EEQjCXjIdNCdSOJtWoE20PTmctv1xVcb49+lttTBOe2WtgvMNIndQoqU7q2Cnpt+Qp1Bx+B2scwyHgcxNAsyNuK05EZiuYoTPce4zRzVrwTOsiW8yvv7jPqS9DS0J600uEq3Q+H+8XRmC0DHSBX3lILcpBkQc2eu0OJ8Fi3YIda1+M9gg1S0HfHNk/3vUO9a3g1fp3PF5F2WKj5KKGVudz9I7IdETU1USjjj5nQrF6gJl9egKhSiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rn8ELVFMJhOElt8dl2GQxNZS8OfCUc2HIXBS2BluaVw=;
 b=a76iIgELf4lvf4azAWlMfCgDaN0rChPZuQYkmbTWLNhkKGNBaA4SWUsn8Y3x8uJsbA7Je2LQh/DwCRhSeqNmvTq+tHU1X7R0aTDU1ql46pVbHYbhHKOH0eQSRx7uMAPyjdgbm0/8O/R7PA5qgRNVK4f2lhkOVSB9tpG4m/6FU+h2ZLHyUu/updwYKdBzzWlMEdJQI9PMnIdgGVXq+ZeOz5kVDAndTTGZSsOEqaBg/cTn99c7QSl66QeKAWQQu7yZSEpabdGylhwjMcu3RWD1ZvoNEmwFaQYqcbyNfGYWflUzcJwOuqPQCr+mne3XAOILJJgN9FCBEdUJxYcbqYmuDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rn8ELVFMJhOElt8dl2GQxNZS8OfCUc2HIXBS2BluaVw=;
 b=iEc+H7rzwVLp+/QmllusEc+NeAnn9KpDCtcbzAMY07RdLfIjVJFhLMh2jkYFLsJJP4+aomfbGj8M/3EFsmRK9XU7j1uzzYk9CmvCbQUxw/BKPStmQtx17Nngpn02ftHoRxmv37KGkPlfP3YvBXLDtuSQhGVfBaP22eX2tu3KRYc=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 PH0PR04MB8338.namprd04.prod.outlook.com (2603:10b6:510:d9::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.39; Sat, 2 Mar 2024 23:37:39 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c9e3:b196:e5ea:909b]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c9e3:b196:e5ea:909b%4]) with mapi id 15.20.7339.035; Sat, 2 Mar 2024
 23:37:39 +0000
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
Thread-Index: AQHabEDqvjYLP9d8aESjxeYsLpcDnLEkDfgAgABHMYCAAMeNAA==
Date: Sat, 2 Mar 2024 23:37:39 +0000
Message-ID: <r6ezdjqb5hz5jvvaj2beyulr2adwht2sonxw3bhcjdvwduyt66@2hlsmnppfsk2>
References: <20240302012813.2011111-1-shinichiro.kawasaki@wdc.com>
 <gl7rsalwdwdo4rdes6akcnd7llrz75jjje2hchy5cdvzse6vei@367ddi3u6n2e>
 <a26554d3-bee9-4030-a06c-f886ba2fffb0@redhat.com>
In-Reply-To: <a26554d3-bee9-4030-a06c-f886ba2fffb0@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|PH0PR04MB8338:EE_
x-ms-office365-filtering-correlation-id: 6884efc4-8838-4db7-86f7-08dc3b11bf85
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 hXCCW/oNtC5dTsGMFamgLNGhrLpHPdmwzK4lox4LEjURGcAgOcvKWhfzlkxhvRs2oZ3dXsRlnjGeX5/uT1QZxxglC+qo7mf1OUNgzaVBh6SdpKC/Sj1X11KtrOF1ey/FrkcR/Dpj7/DUgkJlhSGWWiJeT08F24Npw14ptXkQFZj+qF0xxjbrvFr1I0KI1nwvr3LtuFwV6sCAoFl7TZLpZqy3ejAO4B9tO47ZAGdesTXcY4qulOEicEyn7q2Rq6D+NIe1INble7crr4d8DZ0G7NrEU82CwBIaCBB6+P+cHBoJ39wQw5GuuGNwn3Mohm06B698IfRNTo2Ta0D79ZVh4o5Yi0++CBVf68NtTMMLUFl3HBeB5ZBRuJL0NdjxNmEXKL3qAXVHhYSRE/qiPI3Vhcd826sVCKZei7FNXQLQYmVu5Xt962to79qfoBIfZXGoSEbB218/lu5txhMuF6BdWbDjF5Kps9+xdZg5VbtpYt32UXG9bAF13BTuzkW/rO29699RxOarZx3eAbyVye6ee4KVDLD1x944D/XifnHZGBmIqSSpCpGgO+lOtqA1GXVwBni7+uPmpPn8g1vrVlrfX6Ny3Ut3ENYwpDq3kSnZfaqQmlXXiqrAb/sgO0M5jR93MRVdelie6Q4MHbpfvsrQ0CLfibQRdZS/gF3WvzFofLw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Q6f/r5/yxrn3UwyPIG0yO4er9IEJ0Ww4xflaJC2wXlXnSciiacTW5lZHT8?=
 =?iso-8859-1?Q?sErgLOW0onTCRCNDiesq55McxQGHxGKhrPjoQSs7LMLgBqIxunXfwsHJr9?=
 =?iso-8859-1?Q?u2A48XhtzMuK6RvIIv4141EQcXrqr0Jgl3poAub5rHbWE5+4ZWBTdOLtze?=
 =?iso-8859-1?Q?oOWy6/rOOeAVOQBDF4Vvz+29s3YBD+fDYjxjis0Jw51r1aK/oklskdC3K6?=
 =?iso-8859-1?Q?Bxr6Xom1Z7j97hnmXoqkwQCxFZdYxt0hNLorfp1cWf0bSKqfq/hKS1l55+?=
 =?iso-8859-1?Q?wr/Tho2O3loUQHfuHQcDRvs4DZLTi8KnH2XsSPROZW+COHybUK5bDxn1zz?=
 =?iso-8859-1?Q?SD1PrZwuRLwz8lH+ScmwkF+eEwrreR/Nv34qyTTGL6HkEz7mnLnxClUv1V?=
 =?iso-8859-1?Q?Jomt6KuvCfUh8fdl6VHdnTVqZKs528aCec6Js8Om5PHHU2wU7y11u+1aZb?=
 =?iso-8859-1?Q?0nti7qeKgxqYay0JkCx+M5SB3AU/O9FtUXQ9r5HBZJ4KcpH0rePnIu5zQV?=
 =?iso-8859-1?Q?yGS3GPCaK5XKlzY6ket8eFV0XLHEVn1m9vZ+cvWugWmpzVHqz9mmsa6pRI?=
 =?iso-8859-1?Q?Tam2XN4q+mMZwFZy2n7EoPatJoBlx7oCusD7IrA7ibL0j4edzh6LvT7GSI?=
 =?iso-8859-1?Q?BpUX7NO1j8ZeqczAGmlJko2mzFpZH+27uXvqPsxnMti5CHLuOy3VbcDKdd?=
 =?iso-8859-1?Q?YFgXSCUIQEpZEMzTlcKDwTqdgTwldfLZ801i5k6fgvXirDudwUuQmSao/T?=
 =?iso-8859-1?Q?i/Y5E5PMGzZ+8snM/+uuMayGCmdFhNdxEraR2VWnZ5kxG2otXl56INU3ue?=
 =?iso-8859-1?Q?BMOKv1glbCH93l7TNaDR4bOGVqBY/7PuBBBsRLs1fEw5ANR8B5EONQqMgQ?=
 =?iso-8859-1?Q?XKecrIeD5QEBX54YcSJB1faOjVYkoSTzyi9DVAxg1KaamzHwyQdEyJK9+v?=
 =?iso-8859-1?Q?dWA66hJjSj10YNhmT4CEm5K9tyHI3Ixla/PhnZZ5X2sKc8RSGpebiicMfC?=
 =?iso-8859-1?Q?rM+T42ynC6b9BcbUM3t4VZDQTT3gZg10x3AA32mUdiF7dTfx4DD6sbWN/Y?=
 =?iso-8859-1?Q?DZTxXkDhi2jFMl9WzaFytHyw+9kgoR0eHiGnKc9Qt1UF+BuQXq67diq06n?=
 =?iso-8859-1?Q?GQTvdSPbh54BLyy81Db7c/nO8iNnMQcBe483aBlTxM/TvdX2WjZJSj+Yqo?=
 =?iso-8859-1?Q?zNxRAH4EwLN+FPjMV4b6ttvAnB+x9LUO1HGdOKkmgwB0fIA6+k494FN6TK?=
 =?iso-8859-1?Q?rxsxYmF0cp5xcW8QBITkBIITo/gsaWc84nV97a6bwF+w3hAhqIZcMpJAuo?=
 =?iso-8859-1?Q?690yisxo+My7NOTzCzfP1yjZPeiWVXLRnv8Sv4sI9okQ85lBH90bF9W4Px?=
 =?iso-8859-1?Q?DqVayq1qpafogyvqoUL3XguGTqY1/+xmrrOAT2Z1pz/m5KSVMWtJUedAsp?=
 =?iso-8859-1?Q?ijGo8Gkj4PDDxWHBVCk9f9rTaA3sjA766CTwKaB+YnzOozvdkxqgOOEbHa?=
 =?iso-8859-1?Q?8KOUXmMydd665Xds2F9w6e6/6EkW8gioqelkx6zhfL5NyNj93sgRowQxTY?=
 =?iso-8859-1?Q?fNJo76KV6C+FrAhpl+Jxn2S7W92//FBR8c/hyksxoiMb4qivBELjRhUuF1?=
 =?iso-8859-1?Q?WgTuYvd/Nz/ZnwZZAwdjtemwQ9TeUwAjaeBg3z9xO42anyvZevz9UaY0v8?=
 =?iso-8859-1?Q?qWyUTmt4x8B8XokQtNY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <75B23DE95D897A4E8294D9DC2A290643@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fGwO6Fipu5b8uZooqmlUHHon0jNmW6RAGmsUW5IKRbRyJambDou1UFBwnIFswO6jzPP83E9lMWKB5V71IRYVuGD8OX4UcCW3MbI9bVG7DaGEFZeN6XpBzLvk/+E7yXjXpyG7S7UAcFpqS0ct+hg0cecHbeTAUsdLkgaf6EnWmTdZ6Wq3EKpZzxulWIVX1LRw27wlRDeCKVPQEVGPFq94i77Cg3xTwb4o2c0rNGcZp2xXLraFiqBJ+r1+iAAjsKYltyeu8UXY4wfhoTLPomTYsLOJvOUhg610dE0+MlHND59ueYzOOGLzhMymcCwaIKtiJV0dfxlYF58Dai2FljCJME39EhG5Q/d1IojWK6fv9SVwFpnr8oATKnRrtguNWiEFAHpOhdmpA/RsZoSj5itrVcnzXRDBFDNQFfjaDEeXgL+306T1WJiM9M6q9qIWG3Lmyxe7vW4E8fzVNT1bRtONnttkGZ4E8nmtI0M/hDAAwDd+SLQaUls1wnCBf6PFlgaOYISMshNsXCBvaOlcQJbnpl0tD+h8+BI0/BE0cO9bOjcQYTVo4TZylRA//axNwR19gbeQr4YHG79WK9ScMPCAsNZBvhaCSywiAsjzvlMNeRcbL1zI0XdkdgcvfF0jR38Z
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6884efc4-8838-4db7-86f7-08dc3b11bf85
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2024 23:37:39.3391
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oJw8v3LU3Z895Xxg+HY70AIKrupKdp0YkSWAdGIR7GGCyZhICNg0EFSP5p87Z3Iv6bZdEoi8WiXrDtS/CrVdhaGtWglottGxS8oUU7zHVmY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8338

On Mar 02, 2024 / 12:43, Hans de Goede wrote:
> Hi Shinichiro,
>=20
> Thank you for your work on this.
>=20
> On 3/2/24 08:28, Shinichiro Kawasaki wrote:
> > On Mar 02, 2024 / 10:28, Shin'ichiro Kawasaki wrote:
> >> The commit 5913320eb0b3 ("platform/x86: p2sb: Allow p2sb_bar() calls
> >> during PCI device probe") triggered repeated ACPI errors on ASUS
> >> VivoBook D540NV-GQ065T [1]. It was confirmed that the P2SB device scan
> >> and remove at the fs_initcall stage triggered the errors.
> >>
> >> To avoid the error, defer the P2SB device scan on the concerned device=
.
> >> The error was observed on the system with Pentium N4200 in Goldmont mi=
cro-
> >> architecture, and on which P2SB has function 0. Then refer to the P2SB
> >> function to decide whether to defer or not.
> >>
> >> When the device scan is deferred, do the scan later when p2sb_bar() is
> >> called for the first time. If this first scan is triggered by sysfs
> >> pci bus rescan, deadlock happens. In most cases, the scan happens duri=
ng
> >> system boot process, then there is no chance of deadlock.
> >>
> >> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D218531 [1]
> >> Fixes: 5913320eb0b3 ("platform/x86: p2sb: Allow p2sb_bar() calls durin=
g PCI device probe")
> >> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> >=20
> > Let me drop this patch. danilrybakov found that the ACPI errors are sti=
ll
> > reported even with this patch. Will try another fix approach.
>=20
> Can we not simply just skip scanning function 0 all together when
> on Goldmont? I don't think any drivers actually ask for the bar
> of function 0 on Goldmont ?

Hi Hans, thank you for the idea. If we can take this appraoch, the fix patc=
h
will be simpler.

>=20
> This is likely also why we never had the issue with the old p2sb_bar()
> code, because that never touched function 0.
>=20
> I think this is actually what you did in one of your first test
> patches in the bugzilla, right ?

To be precise, the first test patch did P2SB scan only for the function 2.
To make sure your idea works, it's the better to test to scan all the funct=
ion
numbers except 0, from 1 to 7.

>=20
> So maybe audit all the callers of p2sb_bar() and see if any
> caller asks for function 0 on goldmont ?
>=20
> Let me know if you need help with this audit.

Help for the audit will be appreciated.

With the quick grep for p2sb_bar() [2], there are five p2sb_bar() callers:

 1) edac/pnd2_edac             devfn =3D 0
 2) i2c/busses/i2c-i801        devfn =3D 0
 3) mfd/lpc_ich for pinctrl    devfn =3D 0
 4) mfd/lpc_ich for spi        devfn =3D PCI_DEVFN(13, 2)
 5) watchdog/simatic-ipc-wdt   devfn =3D 0

Four out of the five callers specify devfn =3D 0, which means devfn is the =
P2SB
default PCI_DEVFN(13, 0) on Goldmont. So the question is if the four driver=
s are
used on Goldmont platform or not. And I have no clue...

[2]

$ git grep p2sb_bar
drivers/edac/pnd2_edac.c:                       ret =3D p2sb_bar(NULL, 0, &=
r);
drivers/i2c/busses/i2c-i801.c:  ret =3D p2sb_bar(pci_dev->bus, 0, res);
drivers/mfd/lpc_ich.c:  ret =3D p2sb_bar(dev->bus, 0, &base);
drivers/mfd/lpc_ich.c:          ret =3D p2sb_bar(dev->bus, PCI_DEVFN(13, 2)=
, res);
drivers/platform/x86/p2sb.c: * p2sb_bar - Get Primary to Sideband (P2SB) br=
idge device BAR
drivers/platform/x86/p2sb.c:int p2sb_bar(struct pci_bus *bus, unsigned int =
devfn, struct resource *mem)
drivers/platform/x86/p2sb.c:EXPORT_SYMBOL_GPL(p2sb_bar);
drivers/watchdog/simatic-ipc-wdt.c:             ret =3D p2sb_bar(NULL, 0, r=
es);
include/linux/platform_data/x86/p2sb.h:int p2sb_bar(struct pci_bus *bus, un=
signed int devfn, struct resource *mem);
include/linux/platform_data/x86/p2sb.h:static inline int p2sb_bar(struct pc=
i_bus *bus, unsigned int devfn, struct resource *mem)=

