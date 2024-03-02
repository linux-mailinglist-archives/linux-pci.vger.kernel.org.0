Return-Path: <linux-pci+bounces-4369-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE5D86EF25
	for <lists+linux-pci@lfdr.de>; Sat,  2 Mar 2024 08:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 428E6B23DB5
	for <lists+linux-pci@lfdr.de>; Sat,  2 Mar 2024 07:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A70011724;
	Sat,  2 Mar 2024 07:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XSbpJ04G";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="JHne2aQx"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B06D11712;
	Sat,  2 Mar 2024 07:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709364530; cv=fail; b=Ea96FIjtN9dDfdTFZ/txDejxPFvlr1gJzn8/cToeV+sPL65j5vA6xdlsYvFhwzM4DYzNNOfeq6/DnddYQLOjnD2r9XZJZ/vn5Ii1GucIgZCoXRAY4VUotbQGWXwEnlmXmKdKcFFvgPO2ftJkQ3ki9uEycDOStMsWERChw11md/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709364530; c=relaxed/simple;
	bh=fanuiE+cnbowu+k8MOXlAfYy7HVGiLyIdzJ1OqwW3FI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bDfZx9Somem5QBdrdFpEJrMn04jSgKViMYMU1UxhmlsMtgbv+7TuJ3Ek6llOjV45h2HuAJtrXMI9C24XQarLzsoi25FESEJ24pE09jfyGhfEYsIBpbyOLIGmCWUreyG/qPhWK4JhuIB8cHRSZ+yZh+LhvoVeZV2dh+5GXWo0zlk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=XSbpJ04G; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=JHne2aQx; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1709364528; x=1740900528;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=fanuiE+cnbowu+k8MOXlAfYy7HVGiLyIdzJ1OqwW3FI=;
  b=XSbpJ04GGVjWOVrh6dYSUHtQ9Vi+lTBecw+h9ty8jYdqzCkg9ncW3BoD
   2NYxszqIpeTDNgwWAz5tFW3l4r5SPc2UqsHbmFW3VzPa98y1FJh4O34/D
   cdM8ymvfGRvXsftqOqyt/MNyRF8STzycmRrqg/GurZT9VU2lsP4ViVLeE
   36epjJ8Ea+VcDQN1o7CzFGuQ6ANY1XHl7JpBno+QszZk4XcSgcr6b34z2
   Qxkx4OET2dJIuGE5GY9kmh+VHxfrtbGRXdUL4Rb1mYjFRpKTOfJkKvQpk
   DD3SwJQ8oHtYJhl55JW9Qxzg6w8T9N4xKjwMs2oOiQaSkwT80lS1btc0q
   w==;
X-CSE-ConnectionGUID: Fwlp9oktT+mATqi3SJVSKw==
X-CSE-MsgGUID: dtAR/oZoQdm1JLnRfmaVpQ==
X-IronPort-AV: E=Sophos;i="6.06,199,1705334400"; 
   d="scan'208";a="10879951"
Received: from mail-bn1nam02lp2040.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.40])
  by ob1.hgst.iphmx.com with ESMTP; 02 Mar 2024 15:28:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oVoaHKkxEYVK1BcKM1r/bwsLNGrY0iyYtdF2uNrM0JXx9I+iJO2UQjkGN2uFPnEeya9BS9aeVxIrP6NdE314Ew9GSx60QirIMl5Xt4zycM+x0a+6BD/eEQg072T8HTkP8HRdGlitKzKrLBZ/Y+6OdolcfdWaQ7gsNt9K4e0nh8Eu3pjmpioUhT9V/X20xPMx8ynoi0Ej+v4r2KEpqskLvnZJUL1DzBs2AXmAKKaD8h3MEt2Na898zG4u2BWm8QJZ77mpWKXaHfdpxbXmrDbn4Xp0i4ALDRSxVkSLc0NqqCYoHPSyin5zyl3Amq9R+0jHcRpEyO8WopR2aIvZVVaBLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fanuiE+cnbowu+k8MOXlAfYy7HVGiLyIdzJ1OqwW3FI=;
 b=e81stZaTb5zfrS9U/prN74ftAXZXgKCVXa/AhWqNFDuJXQ3JUlU8a6pcvYd1fWnVjuXTxpusrP3ZVG6+GZ492Vz08uEDJpK60Nvk69DKL2L8Oup8+rx2vtmR2fGGFx6FmF+jlGTZxfYjPY890fPcL8IDUaFey2gzszM8zPFQMHkWvmGgrEwA1BguEOmJAClIJJINKMdrqic6ZfHaYMMVyJPrwhQVfOD0RWyqsdfa8eXDEwesPgfgkhv4pG6CI4uvLz4cVFESMCx8qHfmk/LA04Ue068LKPbmh5wS/XSceFWHci5akERamh/hy5gL1fV8TCFTRK7hofuJvSZdW3+cJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fanuiE+cnbowu+k8MOXlAfYy7HVGiLyIdzJ1OqwW3FI=;
 b=JHne2aQxmLiqatdH6SvE0R2u4unnRgXCd6Y6MZ4Tor33BavncC3KM6PNzCRZ3Ksq7qVROPEQdSeub+8NBmxIQX6ZuT1KVb355N20aYcG1zMOBb4K9gLmSL4zgzlU5iqOhSqI/w3Lr2+HrookZYQjCtqqwKLSekNPPIdvRRvfEL8=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 MN2PR04MB6701.namprd04.prod.outlook.com (2603:10b6:208:1ef::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Sat, 2 Mar
 2024 07:28:37 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c9e3:b196:e5ea:909b]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c9e3:b196:e5ea:909b%4]) with mapi id 15.20.7339.033; Sat, 2 Mar 2024
 07:28:37 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "platform-driver-x86@vger.kernel.org"
	<platform-driver-x86@vger.kernel.org>
CC: Hans de Goede <hdegoede@redhat.com>, =?iso-8859-1?Q?Ilpo_J=E4rvinen?=
	<ilpo.jarvinen@linux.intel.com>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, "danilrybakov249@gmail.com"
	<danilrybakov249@gmail.com>, Lukas Wunner <lukas@wunner.de>, Klara Modin
	<klarasmodin@gmail.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2] platform/x86: p2sb: Defer P2SB device scan when P2SB
 device has func 0
Thread-Topic: [PATCH v2] platform/x86: p2sb: Defer P2SB device scan when P2SB
 device has func 0
Thread-Index: AQHabEDqvjYLP9d8aESjxeYsLpcDnLEkDfgA
Date: Sat, 2 Mar 2024 07:28:36 +0000
Message-ID: <gl7rsalwdwdo4rdes6akcnd7llrz75jjje2hchy5cdvzse6vei@367ddi3u6n2e>
References: <20240302012813.2011111-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20240302012813.2011111-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|MN2PR04MB6701:EE_
x-ms-office365-filtering-correlation-id: 7e33dc36-f0ed-44d5-1ba5-08dc3a8a5fef
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 fK1bp5Wp5GqwPLRllHL+laHsBHOHA3ssR6xbJvYrzEaFfZ0xNJb890zSjbplM8GGCULvBWBbxZZcw+mCaTafDHi1RC+x7CGWCoyhQ+Y3xhbhRLXQtLE0SgOwtF4iMuUkzBENo1TzWmP0vj2xtaLm1eL5IrClfUmd1e5ZozOQ0gWbNsN553xeHSBxpdn1nXrXxfSPdOAQx3kr0AdtjNcCfDuKquo+xE6T1RLdZMQeXWHGObNRbS5+8rBsk24CJztlEwtIMu3yBDgWVX6oqePK1l39fvbWmgp9xSDqgeFzdmMFZfccx1bVEUzJhS0/vL0VvMTN/2SN0xoxqmGETQbO/a/bASilO0aYR3X+ab84oE+1sg42B5PaXVzr1N4dn4VTWkL9MJ1uixnwobzb5WmfKNpyVpBB8P9QRD27uEra4R7O9ULFwEmcY5v61Krv7J9iMIdC73YGh7oXZr8VITA4EywfQ5WzMxenfPmaGgQ89PfbKP+wtGBUPL1H5WnBxBTeYuXZjCz7VySbQTUrCqiROOG5dAqDubvVMJzv+s59vlwgFaO6ptO0GnhHiED2LgcwEm+TCVE+tik1mnHRZykTnTu7F5yWY3uHAyMkkrf3U2P660L2YQgy5qXH4Kjka13ZrlokCFJubNLSCFo28xMJL0CDPKDZQadHbBHG0oHlmO8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?l12WfWRAU0oWK9aLEmAE1mW432owvi8He8qefjnXoboqUdl71UQmlvpofc?=
 =?iso-8859-1?Q?Fg3E9GfFS7ZS31AQIOEbWqIreVwAhhYIsC9cNG5kxs5K6GOWNXIaa4wxtc?=
 =?iso-8859-1?Q?48COKXp1Ya+Wnxk1VW9qI6Bln6QNnffcvZrgX9THDsZLsJM3IS8ap9lgVT?=
 =?iso-8859-1?Q?18SiIEv/mj0c+kD/hyPrWCnvyyay6Per9hL37fEEs8z5bbhBT3lOTbo/Tn?=
 =?iso-8859-1?Q?sCJvpFnL3KcuM1kNDkiNmtoceJXTaTA1cCSaJBIbRbAgc7IF9D28cXm1lf?=
 =?iso-8859-1?Q?v/Gc0UW8Vdrw4U+dl5tKwmPfnkXb0B0bHzUup7lRnAiQ9ko27VFzIVoFft?=
 =?iso-8859-1?Q?K8ZmO24HXkANNuJKDlt3WlH2ykda2ew13TfW8NxDGLAIhqfqZqC85jGJaZ?=
 =?iso-8859-1?Q?Owuy76RrDryyL/7NBVcBuCVq4z9aPJmBhp7ox490YtjLESnJkU9VTnQN8y?=
 =?iso-8859-1?Q?H/GJv2jmFyJ1TfEnhSt9CMA45/6VoXvKi0IDMM3/BME3TUUp4uajjJ9YCA?=
 =?iso-8859-1?Q?ZRlOAravICL3Now6ojEJnFbGIwLSkAGq2dHBAvAqMT0kVcE1HU7CwdgCws?=
 =?iso-8859-1?Q?cZOAqLFze9I8Siod4pa5Ax02JagR+pIiQgN+454Ycc8nKDEIC9DxUvSNUI?=
 =?iso-8859-1?Q?0/QplcsjBj/Q3z2l4gcljNbEwyDw3IusSXrQTFY6XVFwGQpdhgRqz/KGwf?=
 =?iso-8859-1?Q?EiT/PubuO1ZAoFxUrnHHUc8VQHFAm8bv6Wr6RaBSFCmdHU0o2HBQAWNEZh?=
 =?iso-8859-1?Q?VJ92vco6tJlVL4imv2HV+C8cFY4uMWWgXgL65DLwyJNr3p6xVDRvgtDzCi?=
 =?iso-8859-1?Q?RPHRq2MtJgpVy2rOjmU9RkEdNgYR1Rcj2cm+u+pqQ+I3ffwwBEeWPlPro7?=
 =?iso-8859-1?Q?J//EOR2vHzHO7vmpcCyc/IlHH0iBJ2aNIH2QB0sK55Jgg0zUTid47Q8+5R?=
 =?iso-8859-1?Q?HTHSPcewfYr0naELGmhAiY1ILp4fN6VQhbeITWEYRGZMVQuDXRjOgum7os?=
 =?iso-8859-1?Q?LTz5IDME5LBdx50cR7+YTdHz1UykB8fIQiM6T8ocDWcNOOL9NMFBM4iSb4?=
 =?iso-8859-1?Q?ZVwQzXZHGXRgE+rXFtd56RoUqIrzw88xYCCuFHC98Ms7WwZDJQItJyxxWe?=
 =?iso-8859-1?Q?ago3S8iqelAnp/y6vRyjuS86MWbg6DuMb4bUuzoowEgeYo/XLKZ5g+CTrE?=
 =?iso-8859-1?Q?JikKhF2S5WkmJh0RZ16hBGPH6B+2N3IBTYEyyqfa+nNPawOs19mvfhP3s7?=
 =?iso-8859-1?Q?HvxTj7D4RiNORXsGW1+OEnLQiaG3gVisBbxu0f9SuxhKlVzqn+rG/xqZEX?=
 =?iso-8859-1?Q?mlaeg9cbbyVwSKJA9/2ZIIqDLnlldmZjHxG+GtIhwf0nCGsbxH4D8Nf45v?=
 =?iso-8859-1?Q?dw9Wu6SGj5POKZHln3XOJ4pBCxKxIaiYtENjTsKSN+nCQo7vsWB9iPUcPL?=
 =?iso-8859-1?Q?y8a11jbZTjKFFxBS3xXMcAdzgcHwNjtwgg+midsp76sKFMboUgRrH/nbo+?=
 =?iso-8859-1?Q?wc+/PIeIuLA6FC4JJu4TqmS0A/ATs/my+V/rdKbTeErAy432w9jjLLuwFG?=
 =?iso-8859-1?Q?LTJwZhY9hueor79d+EIihWT46k3e+iWvUdjLxoHBAe+7gX3Ffjhx8w5X37?=
 =?iso-8859-1?Q?ywLlG9VwYcsZHvVIBl3maXhaz2Ia2AsahaOJUqYhOsk8QkEx1M6huxHIgJ?=
 =?iso-8859-1?Q?7bdg/QTb51lbGpjj9rQ=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <50E115E33D67F04C81A7034BB41B5781@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3N0tfHy5xyVYvGXmCzNDnD9UWGmoh1o7DNjKsOcJy4A7yNL0y0TMnESnZzN5epeFox40Iaxo4RDmIDYfIhxh4QI535paMe7ofpomwK7SypTTDKhWVOmcl+CDVZJVFufbUoKpFe71UgLQTMUM0W50Z8yl0+B0c3xBrZFxPananVqhJij2pnSF0XL/wZ1n5MN6dWQiN0Z4oOzN2sbNgWAFb1jO/W3ZikBS79W9rAlikUHUcVGYLQsLEEGOgHr9HfS1VBOEwuoDG1NBAeg0IJYKcfLTOM+pqqHRk4ZdDuTVo3miCIMFLYBCMzEOG1uSzffz5NzayJFmnQCOnUFW0auJFPNYbJoiZLfBEFSgX78Fj9QAOVD0cngPVrfNpLTWKJy2O2CBBOQwgEnph65hhqDfqyvxFvrypcOONzxocc7w5TtN4iNmQqYQxCJNCP5DrobBgQhHuQrUrsx0eeLyZknMYxTl7zMlrNQFbD/6j7nQzUC8p91MzgVxcOcjF6jYn2Dj3jFVzti4OMw7r0NSPdvYWQUt+tyqhjjx5zn1TMS3oXf4Qc+5PCfJ5ikKQN5BlyvyMXMHfMVBVmKoJAwCSlt7qQZxyELYO6PGwQv5Mm6nvmap8zTJ5/Cz5pYo78kGUrP8
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e33dc36-f0ed-44d5-1ba5-08dc3a8a5fef
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2024 07:28:36.9136
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ns8t64MlWpQBBwP8Rxnkp16llqNaRBX3g18PlWqcx+ByAv242QrkNmV0HGMOFf3bx8aQ+HfQuDqcfMPmg76z92gUaKP4PunuSM0J9aXVUXE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6701

On Mar 02, 2024 / 10:28, Shin'ichiro Kawasaki wrote:
> The commit 5913320eb0b3 ("platform/x86: p2sb: Allow p2sb_bar() calls
> during PCI device probe") triggered repeated ACPI errors on ASUS
> VivoBook D540NV-GQ065T [1]. It was confirmed that the P2SB device scan
> and remove at the fs_initcall stage triggered the errors.
>=20
> To avoid the error, defer the P2SB device scan on the concerned device.
> The error was observed on the system with Pentium N4200 in Goldmont micro=
-
> architecture, and on which P2SB has function 0. Then refer to the P2SB
> function to decide whether to defer or not.
>=20
> When the device scan is deferred, do the scan later when p2sb_bar() is
> called for the first time. If this first scan is triggered by sysfs
> pci bus rescan, deadlock happens. In most cases, the scan happens during
> system boot process, then there is no chance of deadlock.
>=20
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D218531 [1]
> Fixes: 5913320eb0b3 ("platform/x86: p2sb: Allow p2sb_bar() calls during P=
CI device probe")
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

Let me drop this patch. danilrybakov found that the ACPI errors are still
reported even with this patch. Will try another fix approach.=

