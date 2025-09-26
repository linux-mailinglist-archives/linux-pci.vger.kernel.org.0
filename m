Return-Path: <linux-pci+bounces-37078-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E06EBA27EC
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 08:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59FC24A6D78
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 06:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80384276047;
	Fri, 26 Sep 2025 06:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HVvWPWQw"
X-Original-To: linux-pci@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011054.outbound.protection.outlook.com [52.101.65.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7460A264614;
	Fri, 26 Sep 2025 06:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758867007; cv=fail; b=WaeIhhUb8bchckkmATJzmVphM2KbLKAIllcbOFWZ+5M1eupxWp+QBeQ6c6wyeeHfCGO50rPICqq4Bg9SyZElSYjYkRJ9WnTpkS77eKNzU2HStXOKK1mdwrUnnEhMdV7ovU+3HLDjjFfvGZgcMQDGLTJksNqJ2liuEtT++ZojZto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758867007; c=relaxed/simple;
	bh=/La+avdPJRLedryVgPC7S4cD7ipFdb+86gN0Pe58XRE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rFNqwFzOh7xtk49n8Dj9bocuJmnMA7Xz/ORMhCC6m4BB8I3ZJ3JvijxaBz6rBzCJetIu6rAr8rqas0Qx8c/b3laYARLcAzR+qB3lVq+DyUGAByOurFtEjtsqAx0Q/9iHNMk2Y8p9Mcsg+/GjziV97LIW6ilST/471ToTGlj/vCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HVvWPWQw; arc=fail smtp.client-ip=52.101.65.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZTuxParlisKtrsVRtqx25JQlhlQfs24vBrx7GEKNnKbsitFRsqCMFRH2wU5b9qFBzDMbj4O/k7rgijqyU+fzYFXboVYGcvAqchU5qdNWaAOTuSzqCUAZ7JDbGgbXh+NRG+iyIRwwdZwIrEhIJvJf33JRDb8HmPyPSYEsuml+iaWWgX3PbLq4hZGkyBvEETIVE9+3m7qjzza4XAvwDuVCXmbcOaD9yTGt4PjOCy7Zp3d39nhJpWdLgdEbltbfbCB5wt1maYugx/RMVi1oCWCm29gAE1j/6K4ZkOlCmPFu48vUDLcWKXqc9LzziVd4rohsAXmhcE3dcPSk0F+nDEOtjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/La+avdPJRLedryVgPC7S4cD7ipFdb+86gN0Pe58XRE=;
 b=h18Qv80sHJYYjoEQRoqlXrjYhn8thO+01D9X9S/BwK6OlCkS5AV+TJBPEPQUZ0ohTVVa+lh80tBHzKTXot+wFnLM3QUz+KjXxd7rd86+OJ01bj5YptPV7wieBZBXdHyl7MdQHoY75NmHCpfmsPS09wAXxiGWwp6mLVdR4dZiOXflJxplAbaN878EXv2fwvRcVuw9u1ZFGKkT4NFkQHhptG4xVmV3ayBOgiZexxwmNuw7ccZywn4Oi3UIcsfjZZN7UkAno6L+sSBQD7U+r+R1chXeHfqQdvv8OTK4wRUMBmTd0tF3OTtbnOjarIW/k7SHo+5wDqvKD1qe/2SKPJ329Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/La+avdPJRLedryVgPC7S4cD7ipFdb+86gN0Pe58XRE=;
 b=HVvWPWQwShdOsulJ5qeBZfp4YkgTDlTgpjP0H6RpaANSoQOanrVVN5MblqKwt5WC5mDSCRv97YJLsrTsvqx0NSC5h4Q4sviCxCP2V6UOnE4Dm+bIz4qUMZHzFKc2VnYnpHL3VkIXjaUOaY5334q51kitHUkN7vgwjwsgZKfxDghEk6mbVkGhfhvaqCSqKi7DWuxfmdDU5g3zr627twKccACifGxLgjgfQh9UsNQO6j+mbHp3pR1bWA52JovPJUiTtyeBnLHX/XMh9g1XFryyXWiuS4KBwvAczKpOFM32kdAxXw/LXzaGotngfkpn4pwpdq0eOP1vUqpdQwdLb71Smw==
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by VI1PR04MB7086.eurprd04.prod.outlook.com (2603:10a6:800:121::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Fri, 26 Sep
 2025 06:09:59 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%3]) with mapi id 15.20.9160.011; Fri, 26 Sep 2025
 06:09:59 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Frank Li <frank.li@nxp.com>, "jingoohan1@gmail.com"
	<jingoohan1@gmail.com>, "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kwilczynski@kernel.org"
	<kwilczynski@kernel.org>, "mani@kernel.org" <mani@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v6 3/4] PCI: dwc: Skip PME_Turn_Off message if there is no
 endpoint connected
Thread-Topic: [PATCH v6 3/4] PCI: dwc: Skip PME_Turn_Off message if there is
 no endpoint connected
Thread-Index: AQHcLSQ2s+NXydOpPE2jgrY6l1YK5rSiwU+AgAI1uzA=
Date: Fri, 26 Sep 2025 06:09:59 +0000
Message-ID:
 <AS8PR04MB8833B3F0E22A8E77B24FB7938C1EA@AS8PR04MB8833.eurprd04.prod.outlook.com>
References: <20250924072324.3046687-4-hongxing.zhu@nxp.com>
 <20250924195955.GA2132329@bhelgaas>
In-Reply-To: <20250924195955.GA2132329@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8833:EE_|VI1PR04MB7086:EE_
x-ms-office365-filtering-correlation-id: df03b1e8-01c8-41db-91e4-08ddfcc352c0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|19092799006|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?gb2312?B?YkFGck1objBUbXdtZ01hZW04czVNbHFaVXE2SU1OaXhkTEUvSXhlZE9tNVM3?=
 =?gb2312?B?eW45ZXp3QWkyb2tnVzJMYTZzSXFaS25tZTcvcFJQWXB0T29HYmdsME9UeU1Q?=
 =?gb2312?B?VmhmT2x0UFMyZGh1dkd6SURwUGh4YkswclAzcmFOWC9XdG1DWDlmWHBiTXIv?=
 =?gb2312?B?M1FRcWk3QVl1SUNFY0VieFI2Ri82MlBMSnFROGZUcDRoV1F3QXhoZEt4Q2Zx?=
 =?gb2312?B?c1Vmbm5ocFJJRnlEY0tHY0I0Y25iZDZCNkVnTTBFb3l1aFpNNm9qMGNCMHY4?=
 =?gb2312?B?REx2RDhCQUZ6ZnZtN0c3emF0bEVtYUpBaU5vYmNGQm1kRkc4TGgvL3l1TEhL?=
 =?gb2312?B?bmJGdEFEZlBoUlUrbnZpWWFmd01KVEkxZ3Axc25YZUs2YUp1SFZiMDg0R2dD?=
 =?gb2312?B?NmVDVFZtOGkyTnhxWDhERHZvR1R4UlBjZFVYUGRxc3NydkR6TDlQKzY5SjBr?=
 =?gb2312?B?ZWlRcTZZbFdpc1JrdEdUVlIxYzdvZWdkOC9uQlVUWGtmMXgydTk4eXEySms4?=
 =?gb2312?B?N1paMTJTNjA4Y1ZxL1VDYXRiRm5KTFlnQjVhTXh2c2dDNVdSdWRsSVQ3eE5Q?=
 =?gb2312?B?cUVFYjIrUkJYOUN2THlPWkRZRklkSzROeW95Si80SENqR3RXNlNvOFI4bVZZ?=
 =?gb2312?B?VkJPRTlBQXd0NmJvTXdCVHNMakxZZ1hqSlhPdyt4TTBsUVk2SysyMmNhUy81?=
 =?gb2312?B?OURybWczRThscVZxbjhLSi9SSE5FQzRYNzFMRmJndmJwUWJKVmd5TTdtbzFE?=
 =?gb2312?B?N0tLZTBLNHh4NHcrWDVnYzNRRyt0dGhBZ2hXLy80cG5SbldGVnhsYWlYOU5u?=
 =?gb2312?B?djQrQmZyYm5Od2ZYcURtdWpvQjMvQy9qZlc3OC8xaHpzK3RmUVM1RGgvMncy?=
 =?gb2312?B?R1ZpU2xOUXVDUWtXZkxvSkV4RTZoTTJSOGZHWVRWN0ljZmpBUlJhV3BOemJZ?=
 =?gb2312?B?TjlwdHBZWlNhdEVFdy8wVmNPdklMNS9kZ3NsbHZ0bmtKVGdpc3NKVTluQ3l1?=
 =?gb2312?B?Z0VjSzE3ZWd0RitKWkZZMVZtSDlOUEp0RXNCQXFYRkV4NzJSa1F1VmJ2Ty9p?=
 =?gb2312?B?ekluMEkwUFZQemxXbHY5WEloSnpZMTFvbGtLaXl4L2xXdncxVmUzbkZwVE9B?=
 =?gb2312?B?US9TWE5sK0lVNmxZd1REVVEwMUZFMTVwNTV6U2lEU2NuQ3p3QWh5UmJQSzMy?=
 =?gb2312?B?by95OE9nc2ZMQXFwZkp1N0w1M0pZVUtUbDhweFBRT0lESThtd0JFamRyeUZv?=
 =?gb2312?B?c0IzL01OeUFkVzJ0L1BzeDFUUjN6UHFJT29WN29LZ0liZ3ZIUTNOVE5nQ1hL?=
 =?gb2312?B?OFR0RzdoOEJCZXkvUE9ibVlLZWZkc1NjRGhJS05RTnJsNDlIN21iZS80Mmkv?=
 =?gb2312?B?aVBBbVBXU2NUUDUyZnZUbUtlRVI5RDhCQWw1OWZydmpXdVowNmVQV01ESnRR?=
 =?gb2312?B?WTEzR0d2WE9RMHJ1aklSOVdvbGtydUFrZlo4YzVLNUdtM1VueXBXS0lXSTBF?=
 =?gb2312?B?QW5oa1FmaE00S1hqaU9DakpJZnJmVThvVGJXQUhBYXcrK2Y4ajQvL2YrcjhO?=
 =?gb2312?B?bEVONkhQb3R6YUs0VXJDQks3QzNWdDlSMml3Q3JJeGxvdk1OZVhqNFYxRWFj?=
 =?gb2312?B?QytrYmJ6aW9zeGlNUXIwdmtEZnVUQ0FHQXYxNVVzL2ZjTzNQZ2Y2SmdYWEJz?=
 =?gb2312?B?UFpGeHE4TmxPdjhDcm1PVjNlSzZCZzk0U09lQXpoVWcwNFRsbTFsUUY5RVc0?=
 =?gb2312?B?UFBEclpjVEZlRnA2UWQwNzVYREJOc2wvZS93QzNFdXNCY3NtcGd3Y2xsZ1hR?=
 =?gb2312?B?UTJIYWFNcHNKcWpGajFTSGs2NWZzOVc0R2ZkZkd5Y3pmRGlML2RpTFRHZnRq?=
 =?gb2312?B?NEFNRVhyWERKaURIdXZRK3RpeVE4Q1lkcE1kOVNwbTdCZHd4S0ZkcDl4cGN4?=
 =?gb2312?B?aytydWU1eWllWjlTajVhWmduSVR5YUREM1RRYWxRTlNtY3Z3bml2VnZES05N?=
 =?gb2312?B?L3ByT0VPcS9BPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(19092799006)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?aHJDd2ZDV1c2L01ybk02aXRDS1A4djhtOWtlWG91djIvV3N0ZVZ6R0h6am9x?=
 =?gb2312?B?WTFuY0xZQUJndC9NN2pvOXVDT3VHcFRiUmN3dnVyWGZQd1g1VWcvK1ZjZTFY?=
 =?gb2312?B?NFJIYWRMNTlrTU5HbDMxR0FhWkFld2pqZTIzNjJuMWR5LzNSTG5YeENkejIv?=
 =?gb2312?B?SCtKbHVkejBabk9TN1ZmTk5iOXdVTXVWM2dIeks3TkhYK0JwVFBVUmp4WVBq?=
 =?gb2312?B?NTF3akVmdVFrQXovZzIrczRCa3h6Y3hWYUw3V3ZGWjZZV2JvcllmMjBVM0kx?=
 =?gb2312?B?ZXA2amVVdjA3cE5jY0hCdmEzVm16NkF4M0RXT25kSnpqWVcrN3RTdHZ5UUpL?=
 =?gb2312?B?WlhVREh0UFlOanAyb3VWNW02Rk43ckFsQXZXcjdTekJ3T3B1UFdaWDh3ZTVU?=
 =?gb2312?B?QmhUdGVkUUlQRUJCckE5WFFYZXRZY3hOVURReFJqazdvQUU5czcvcFMvWDB3?=
 =?gb2312?B?eGNQNVBOZnM3SGNqcVFzNjErd1pGcVZUMzZjK09KMm1nR0xHY0xPWUdGdVFI?=
 =?gb2312?B?T2VrOWhDYjViT3ZTaUM5YkRGQVdhRDZtR3JBVTVZV0ZTL2gxKyt6Yk5UTVND?=
 =?gb2312?B?LzlYanZzSnZRTVZTbE9mcVBWZk8wcG91bWQ0Y25SR1daMGNkaFZ2d0t5ZG5W?=
 =?gb2312?B?U0hyVHYzNzZ3VElSeFZ0L3hPVDdTV2o4K01XMHZmdDczUHRKUllENW43MFNr?=
 =?gb2312?B?YzBPeHpHNlp1N1ZtaVV2aUhNTmtibGt1NlBSMGxWZUE2ZklHb2h3dXE1ZUsz?=
 =?gb2312?B?dGQ5RlFiZkxYMm5VSi9tWmtHS3VzbGJ2elpWdXZhbE1PRXUzeC9wSkRtWGUv?=
 =?gb2312?B?cy84RytUcEdyWEFKTXhrTytKUDFsNGIrYUJ0TlVndXMyV3pOYzBmejVnVEhw?=
 =?gb2312?B?akx3dGNDWnFNUjhHSG1vZlY0SEw3L3p3aTlqdDdFOXZzaEhoZTI2dzB0Nm9X?=
 =?gb2312?B?MHFXc0I1SHptVkJZcWEvMlVFODNRbVByOHNjSzRLUTBZRDNFYWs2MVJIUFls?=
 =?gb2312?B?RkQraUlzdXZqVlh4QjVhdmZUL241MmxQcEs0NUFVT1R2QzhYTkJONld2ZEhO?=
 =?gb2312?B?VTRDKy8yVENDaFpsSkNMYWxrc09QTEwyMFpwdzQxem5ha0NPRkgweUs5ZFd0?=
 =?gb2312?B?R1o1akFOdXBMaHVoRTViUnFMeTBUcitJVmpEVnRvak1Gb2xLY0JyZEJzQkVP?=
 =?gb2312?B?V0VaMUQ2TUtiRlh4dWxzSGRIZlpONlVmL3RmM2N4by9FWU0wTExvd1ZsTVBG?=
 =?gb2312?B?YmJHVVNMK3JRMTRqVXhNVTc5ajlDTFVXbC9GajJiM0lJaWcrWlVCeVlWOXlO?=
 =?gb2312?B?MW9QYnh6NkkzbnVrOGNQVzFPWkwzbnZmWFZGOHM5YkVNeFlvWTVUeXdBYXBK?=
 =?gb2312?B?WWhXNWxJRlBiY3gvK0R6TzQrQmN2bFZzMmlvZm9lMTNYazJMK3E0Y0pRc0k5?=
 =?gb2312?B?VHVzcHV2TFV4ZS9aTndrNlZoVTJzU1RyRUlxdHdDc3M3UThyWVZsQmxINjV5?=
 =?gb2312?B?YzZSNHZWTUVXeklyc2VoRk5KMjRKVGltRHlpeWM5ck5YckdUYTdaVTNLbjJM?=
 =?gb2312?B?U3FvWnVuOE1aL2taMEFMRXNaUjE2MkM4WEFndUs1MElmRDJzTW9DQ0gxNEhz?=
 =?gb2312?B?T3VuOWtZcGIwZE5jWUlxbnRrWmk0S3FQWE1ISDIxaXJuL1BkOEU1Z0ZNeG4z?=
 =?gb2312?B?bzdZWU01Q2JUN2l3cU9FUGoreDBlZnhaaWNuV0NIV29ZR0FXN09Ud3FuWGx6?=
 =?gb2312?B?ZUdvZElMYm9GMGhacTFIdzlFdG43dFQvMmpwQTcwZ1Z4VTE5N1QwVHFyRmoy?=
 =?gb2312?B?aWtnQ3ZtVGJROTVrZTZLajRNbTBwQi9IRkszdlBVYkFwY2szc0RjVncrRjE4?=
 =?gb2312?B?Q1VIY21tNlZPVlc1K3J4Qk1kZEFlUDdFbWxPVkJVVmxSTjZkMld6TWh2TEtH?=
 =?gb2312?B?bEhqS0ZHbFRPR2lsclFuZnJnWHY2VXdHKzdhR282YUtoa3dDdVJTdlhIbmRz?=
 =?gb2312?B?U3RSRnluRHJsLy8vV2p0Y1BKa1kvYzFKdHd1NlJacTI1L21KOEpGNVlqQkpa?=
 =?gb2312?B?L2ZZL1cyZXdDTVQ0dGc3TEVBUDQ3aVBjK3h5dVVvMmwrUzkyZXhUekJnRnBG?=
 =?gb2312?Q?J6IA=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df03b1e8-01c8-41db-91e4-08ddfcc352c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2025 06:09:59.3103
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bAeyzd8N5VYWxma3rqVqO4dKNHKBFtWakZTo4id5g0uT1vS+2oAn4FhbeSZ5a87xNV1rgUr1l7IqAkoQJBOv9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7086

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCam9ybiBIZWxnYWFzIDxoZWxn
YWFzQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjXE6jnUwjI1yNUgNDowMA0KPiBUbzogSG9uZ3hp
bmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gQ2M6IEZyYW5rIExpIDxmcmFuay5saUBu
eHAuY29tPjsgamluZ29vaGFuMUBnbWFpbC5jb207DQo+IGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU7
IGxwaWVyYWxpc2lAa2VybmVsLm9yZzsga3dpbGN6eW5za2lAa2VybmVsLm9yZzsNCj4gbWFuaUBr
ZXJuZWwub3JnOyByb2JoQGtlcm5lbC5vcmc7IGJoZWxnYWFzQGdvb2dsZS5jb207DQo+IHNoYXdu
Z3VvQGtlcm5lbC5vcmc7IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7IGtlcm5lbEBwZW5ndXRyb25p
eC5kZTsNCj4gZmVzdGV2YW1AZ21haWwuY29tOyBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOw0K
PiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGlteEBsaXN0cy5saW51eC5k
ZXY7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IHN0YWJsZUB2Z2VyLmtlcm5lbC5v
cmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NiAzLzRdIFBDSTogZHdjOiBTa2lwIFBNRV9UdXJu
X09mZiBtZXNzYWdlIGlmIHRoZXJlIGlzIG5vDQo+IGVuZHBvaW50IGNvbm5lY3RlZA0KPiANCj4g
T24gV2VkLCBTZXAgMjQsIDIwMjUgYXQgMDM6MjM6MjNQTSArMDgwMCwgUmljaGFyZCBaaHUgd3Jv
dGU6DQo+ID4gQSBjaGlwIGZyZWV6ZSBpcyBvYnNlcnZlZCBvbiBpLk1YN0Qgd2hlbiBQQ0llIFJD
IGtpY2tzIG9mZiB0aGUgUE1fUE1FDQo+ID4gbWVzc2FnZSBhbmQgbm8gYW55IGRldmljZXMgYXJl
IGNvbm5lY3RlZCBvbiB0aGUgcG9ydC4NCj4gDQo+IHMvbm8gYW55L25vLw0KPiANCj4gPiBUbyB3
b3JrYXJvdWQgc3VjaCBraW5kIG9mIGlzc3VlLCBza2lwIFBNRV9UdXJuX09mZiBtZXNzYWdlIGlm
IHRoZXJlIGlzDQo+ID4gbm8gZW5kcG9pbnQgY29ubmVjdGVkLg0KPiANCj4gcy93b3JrYXJvdWQv
d29yayBhcm91bmQvDQo+IA0KPiA+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+ID4gRml4
ZXM6IDQ3NzRmYWY4NTRmNSAoIlBDSTogZHdjOiBJbXBsZW1lbnQgZ2VuZXJpYyBzdXNwZW5kL3Jl
c3VtZQ0KPiA+IGZ1bmN0aW9uYWxpdHkiKQ0KPiA+IEZpeGVzOiBhNTI4ZDFhNzI1OTcgKCJQQ0k6
IGlteDY6IFVzZSBEV0MgY29tbW9uIHN1c3BlbmQgcmVzdW1lDQo+ID4gbWV0aG9kIikNCj4gPiBT
aWduZWQtb2ZmLWJ5OiBSaWNoYXJkIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+ID4gUmV2
aWV3ZWQtYnk6IEZyYW5rIExpIDxGcmFuay5MaUBueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2
ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUtaG9zdC5jIHwgMTUNCj4gPiAr
KysrKysrKystLS0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgNiBk
ZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVy
L2R3Yy9wY2llLWRlc2lnbndhcmUtaG9zdC5jDQo+ID4gYi9kcml2ZXJzL3BjaS9jb250cm9sbGVy
L2R3Yy9wY2llLWRlc2lnbndhcmUtaG9zdC5jDQo+ID4gaW5kZXggNTdhMWJhMDhjNDI3Li5iMzAz
YTc0YjBmZDcgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNp
ZS1kZXNpZ253YXJlLWhvc3QuYw0KPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdj
L3BjaWUtZGVzaWdud2FyZS1ob3N0LmMNCj4gPiBAQCAtMTAwOCwxMiArMTAwOCwxNSBAQCBpbnQg
ZHdfcGNpZV9zdXNwZW5kX25vaXJxKHN0cnVjdCBkd19wY2llICpwY2kpDQo+ID4gIAl1MzIgdmFs
Ow0KPiA+ICAJaW50IHJldDsNCj4gPg0KPiA+IC0JaWYgKHBjaS0+cHAub3BzLT5wbWVfdHVybl9v
ZmYpIHsNCj4gPiAtCQlwY2ktPnBwLm9wcy0+cG1lX3R1cm5fb2ZmKCZwY2ktPnBwKTsNCj4gPiAt
CX0gZWxzZSB7DQo+ID4gLQkJcmV0ID0gZHdfcGNpZV9wbWVfdHVybl9vZmYocGNpKTsNCj4gPiAt
CQlpZiAocmV0KQ0KPiA+IC0JCQlyZXR1cm4gcmV0Ow0KPiA+ICsJLyogU2tpcCBQTUVfVHVybl9P
ZmYgbWVzc2FnZSBpZiB0aGVyZSBpcyBubyBlbmRwb2ludCBjb25uZWN0ZWQgKi8NCj4gPiArCWlm
IChkd19wY2llX2dldF9sdHNzbShwY2kpID4gRFdfUENJRV9MVFNTTV9ERVRFQ1RfV0FJVCkgew0K
PiANCj4gVGhpcyBsb29rcyByYWN5IGFuZCBpdCBzb3VuZHMgbGlrZSB0aGlzIGlzIGEgd29ya2Fy
b3VuZCBmb3IgYW4gaS5NWDdEIGRlZmVjdC4NCj4gU2hvdWxkIGl0IGJlIHNvbWUga2luZCBvZiBx
dWlyayBqdXN0IGZvciBpLk1YN0Q/DQpVcCB0byBub3csIGl0IGlzIHVzZWQgdG8gZml4IHRoZSBp
c3N1ZSBlbmNvdW50ZXJlZCBieSBpLk1YN0QgUENJZS4NCklmIHRoZSBMVFNTTSBzdGF0IGlzIGNo
YW5nZWQsIGZvciBleGFtcGxlIG9uZSBkZXZpY2UgaXMgbmV3IGluc2VydGVkIGlmIEhvdC1QbHVn
DQogaXMgc3VwcG9ydGVkLiBUaGUgcHJvY2VkdXJlIG9mIFBNRV9UdXJuX09mZiBraWNrIG9mZiB3
b3VsZCB0ZXJtaW5hdGVkIGJ5IHRoZQ0KIGhvdC1wbHVnIGV2ZW50IEkgdGhpbmsuDQoNCkJlc3Qg
UmVnYXJkcw0KUmljaGFyZCBaaHUNCj4gDQo+ID4gKwkJaWYgKHBjaS0+cHAub3BzLT5wbWVfdHVy
bl9vZmYpIHsNCj4gPiArCQkJcGNpLT5wcC5vcHMtPnBtZV90dXJuX29mZigmcGNpLT5wcCk7DQo+
ID4gKwkJfSBlbHNlIHsNCj4gPiArCQkJcmV0ID0gZHdfcGNpZV9wbWVfdHVybl9vZmYocGNpKTsN
Cj4gPiArCQkJaWYgKHJldCkNCj4gPiArCQkJCXJldHVybiByZXQ7DQo+ID4gKwkJfQ0KPiA+ICAJ
fQ0KPiA+DQo+ID4gIAlpZiAoZHdjX3F1aXJrKHBjaSwgUVVJUktfTk9MMlBPTExfSU5fUE0pKSB7
DQo+ID4gLS0NCj4gPiAyLjM3LjENCj4gPg0KPiA+DQo=

