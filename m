Return-Path: <linux-pci+bounces-15112-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC849AC747
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 12:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CB711F211CA
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 10:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA20E17C222;
	Wed, 23 Oct 2024 10:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lHv9gLr6"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2052.outbound.protection.outlook.com [40.107.247.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701DD137742;
	Wed, 23 Oct 2024 10:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729677796; cv=fail; b=uPp2Ai2coL+O3ipv3/HTgQ8zNfeEhhK3Rd2zSnhjuypE90FG1OoN1+VdWSsy2448aySCWewuLO4IgmcDfl+kuS5bxN2K0AfaWkU8R/+Ih+Yc9DDqk9F50A0et+ltb5C447Ez4MYDzo5tasL3KpATCsI+tixo2qUDEeDOKQ3+DqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729677796; c=relaxed/simple;
	bh=JEbAv7UxM6fu3UvZNKXTfzMPa6dH6y5abx9P9ck7do0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J9ZeUIDC7cCg4w1hIQ4wgMAu5z0CFfc7gWxxjijb8MQqNVISdulYgpgoUHBvJ4HyKN6Re8LXj0BSWqxJnSTsEqxmC6STE3AnmQ5/cb5iYHILY+83MbgSTkQzTuI5X9G4Dh3jtoxJuVo/kBNE4n0Ss0161Tkn3v1vutnIh7wFfpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lHv9gLr6; arc=fail smtp.client-ip=40.107.247.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=psSrF7u7Bwhemj4A1JXFqq06EMkCzULbm/5F5pgW8MgT0BYX+UPsbcM/Om0LeyM2ZTHKv+m6AnMAuM96jKNSsXlqQiLQxBWIHo6+Mb9YA5RlivV/Scw1xgeuI7ZTCIoPyO3/j3VxsGxHDp3fIN1cxHJRXFLp88ZLcEGHcLOvQcQtpeV7GQOAKzZHAf0XAp5FqbfbaCZ8x/NaeGPH46F9i5qA37b/jFT2XKj80fottFfsxqr/oAqoxBQymJVpi+o/cdcDos+5RxtiT5vFG/Ygq4vD88br1b2VCgRpMikXDzikIupZSp8xagGxtr3I66nhi0b/JwzTJT7iTJ26ITCotg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JEbAv7UxM6fu3UvZNKXTfzMPa6dH6y5abx9P9ck7do0=;
 b=WEk4I2Bwsw7cP1czV8oY6XghrIk3e2JdCztJM4htT9qgxpM03M2+zbMu6TeMuCp+2riH8nDmAzpkgcESQHdIpAlzi2vPyfpd+avIJtoyxZOWDD9tZO7HxbqmAy0tJ4wXJj39PXedlIhplgvj9WVc9DAbym0tDG6SnJxPuMxuI4c7gwljRR/qTBhqwSNwHHNpeAge8XqD3SvZGixefKPfQEaqvc05pZWzl9CnHzTrzcshLWHoJ8235enPfRJb43AsjhrAb2TLaYQ+OKRXHVJ6LjOj7urABv7rrWlKipJvYbuXtT64QQxwV1iYutRR65OljLHhPmI5PpFaNCMAtKjbjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JEbAv7UxM6fu3UvZNKXTfzMPa6dH6y5abx9P9ck7do0=;
 b=lHv9gLr6SwLXuEYtZJqVLCj3jWu1RulF3tL+M8W5uPzfGx5VqIR2VRTHJgEwkdKuuWgXsD/BJ7Zv1CTtw1UFneyC8HQBMY09+1yBgTqbNqJEsS68/oMnl3bsozZFIqOG/xA61Zj0cj/uMdxanxHLzjXru8o3QgyaL4WPXu1b/jW+VyeebodyJqcVYiO68NUEsWU88K2wWGQWo7kSNrYtJyBbZrCtLOrwukM5nq+paMc8VvEFu+fk1rxU6KthdeV1PkqOfWPVODMPKg+uD0a5A3X7GgdlqEAsEVuSb+uCj5Xvpj/yQxyYjaod70jMNua4LJSN0c0E/7Ev0EL1fytLoA==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM9PR04MB8923.eurprd04.prod.outlook.com (2603:10a6:20b:40a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Wed, 23 Oct
 2024 10:03:11 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8069.027; Wed, 23 Oct 2024
 10:03:11 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>, Claudiu
 Manoil <claudiu.manoil@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, Frank Li
	<frank.li@nxp.com>, "christophe.leroy@csgroup.eu"
	<christophe.leroy@csgroup.eu>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"horms@kernel.org" <horms@kernel.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>
Subject: RE: [PATCH v4 net-next 03/13] dt-bindings: net: add bindings for NETC
 blocks control
Thread-Topic: [PATCH v4 net-next 03/13] dt-bindings: net: add bindings for
 NETC blocks control
Thread-Index: AQHbJEi1opWCvzFL8kS18Y10TWXurLKT6McAgAAQObCAABEvAIAAEJ5A
Date: Wed, 23 Oct 2024 10:03:10 +0000
Message-ID:
 <PAXPR04MB85101A3DFF08F8C8DD7513F8884D2@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241022055223.382277-1-wei.fang@nxp.com>
 <20241022055223.382277-4-wei.fang@nxp.com>
 <xx4l4bs4iqmtgafs63ly2labvqzul2a7wkpyvxkbde257hfgs2@xgfs57rcdsk6>
 <PAXPR04MB851034FDAC4E63F1866356B4884D2@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <f7064783-983a-44bd-a9db-fd20f4e50e33@kernel.org>
In-Reply-To: <f7064783-983a-44bd-a9db-fd20f4e50e33@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AM9PR04MB8923:EE_
x-ms-office365-filtering-correlation-id: 300bb01a-8a2d-43be-08c2-08dcf349e6d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?N29HNTdJSVpBVHdXMGRsbCtuU0dHVGdsZmdqc2xibFRKZ3FMYlFqdWsyYVhi?=
 =?utf-8?B?RVNIY2x2WXQzNVRpRWl3VGd4ckhTeVZKVlN4VUx2NWIrS3ROVWxBd3pXRktl?=
 =?utf-8?B?aFVoNG5xUmIzOE9FQWd2c3BMVXNXUERPa0FEWmZtRWgzNGxxNHBubTVTQzNZ?=
 =?utf-8?B?S0d6cHd1czFjWXdBQSs2YmI2Wjh4QVZxV2NFRVNCdEtUR2lZTldyei9YZEty?=
 =?utf-8?B?L1dERXoyREw3cjA0N3ZZYzV4VEhDdDFQSnhoTHZGcDJkeXVmb21pdmpzcmtL?=
 =?utf-8?B?c3BWOW9wREc4VHlSenNWUVdSUUF4SFpSSnhQdEc3T0U3NVN4d1dUWkZKbEd6?=
 =?utf-8?B?bVJOV0tPQjB0dklFSWNQSWtRem8wWHVSTDJWUW1kMjRxTlhUQWV6aVltQXk0?=
 =?utf-8?B?SjBKbCtSQXlaY3JZY09nRHRLcG5OV1hLekF6cUlscHJhM2xLR0xWSm5oNUFQ?=
 =?utf-8?B?K3dZTHZqdS9keXJkTGlmZElacWFrTCtadXV2WXV5eENVcTc2Z1lreXJ1Vkp5?=
 =?utf-8?B?blpHcHo2dmhXQW40Slc5TkdKaUhZUTl3dkc2ckt2ZElQOWpqRktMN3hRaE9x?=
 =?utf-8?B?Q1FBN284YlZaNkMvcnhuYnZHWVl6UGtkS2h1MEVHNUxLNXI2T29hcFFCOHZQ?=
 =?utf-8?B?RTZWdXZiR3N0REFib2hkRHZzN2xiV05ZMnk3cGswOVAxZWRYeTc0aDRHUlFi?=
 =?utf-8?B?M2pnclNlUWMrc2FEUHJNOHlaMDhzZk02U2pLVWNIVlZEWENwc0JQSW1zcWtl?=
 =?utf-8?B?ekswaFU1S2I5ZXhKUUx4WlgwbkFoU1dSd0Zzd3ppYWljcFRwYkh1VGprNnFq?=
 =?utf-8?B?WUlYOHRsWks2Z2RGTHNDWFh1RXR2bXBUN1ZiZ0RXc3dwb2FaemM2bjNoUFJB?=
 =?utf-8?B?UmxINzdoTUt1RHhZSU13RjdrNG9wRS91ZnZjQVFWMzBKaks2Qms4UU9FTGhh?=
 =?utf-8?B?NVk1QmRWSWwvZGhsRE5td0dVUjlKWUxEancvUlNZMit2RlJUaHF6QUwxVzE1?=
 =?utf-8?B?OUYzbWc5cEpEbG1NZFBzK2ovdEprQkRlaWZCTWN4Mlh1MU1Zak0ydCtOTWd3?=
 =?utf-8?B?VXRaTXQzMUtOcmpPWWg5dnZPN05LaWpweHY3anprV0ZWVll1OTN3V3Vibllm?=
 =?utf-8?B?RXV1S3JHWDVFK0RJYWJIanB6TGN2c1FiOE9zc3V6b2NwWTYxdW5tSnFYUUdG?=
 =?utf-8?B?UzdROFlITi9aZnhJOXlwdTdtRnpiQThmYVl1NWVCUzNNRGczaWpHYlFDeG56?=
 =?utf-8?B?b2ZtLzY1cE8vemhkdHVSSHRoSUFPSGdtS2dzdjE2N3F1b01VTnFDQ1ZSb3d6?=
 =?utf-8?B?M3hqcFoxditJRE5wTkFkUW4yZ3VwSEJwc3p1ak5SVlVoQWhLZlFYUmhoaWdj?=
 =?utf-8?B?LzAvVnprRW9leXp5ZUp4YXRsRnZ2ZUdxWXVXVVdzWnZaS0xOSjFXeFVZSDN2?=
 =?utf-8?B?L3pUSWdYNms3c0JQUEMzVnBvWlcva01oYVI3RU8vVXhQSjRuaDA1OVhVUDJs?=
 =?utf-8?B?WnFKN2JnZThGWjRmb0ZhNkgwcm9iemVEcUMvWjVnL2lrNStoNytic3dmdXIx?=
 =?utf-8?B?cjNMVVMwYUVqZ1dSeTFJb0VWOWJ5d0hRTUNBaTZBUDIzUEMyUllPV3NNaGFa?=
 =?utf-8?B?cTQwV1g3WEEyTngvVi90alFVYm85cGdMUHNwRFk1RE9FV3p4SlFKcEsxL2R3?=
 =?utf-8?B?clFtc2xKbEpqOS9Lek42NDB6MHd4RjFZbkdXSlpJZWlOZkR5SmxVYkVpOXZ3?=
 =?utf-8?B?TGcyMTl4Vkh3VFdGRHI0WmdPRTh2S2RmR0tITTBCNVhnVUp2SjNuTHduTzRs?=
 =?utf-8?Q?fRUp7/Wx7RLLBVLRZ0bh6xn3+eYpdCpsNxJSg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Skd3SnVJQUVWMStaODZQMG9UQko2MXBwRXBWWXZKTmNGWnhkcmtlWkdSNDE3?=
 =?utf-8?B?SWUza0paVFZSa0lwcnZsL3ZSTEt2Z0tBcTgzVEsvclUzMXg0Q0dsbW9oTWlH?=
 =?utf-8?B?cW9kdmEwNGlXTjRyRDFiR2JZSHVQNjd6ZWUya3hCaExPcU9vRjlMT091dnh5?=
 =?utf-8?B?MmRnK1ZGOUI2bnBoOEpaeUJSM21CV3ZWdStwYjRvZFpUSW5JcW5OVUtTMXRq?=
 =?utf-8?B?dmh4dFRiR1VLZm8wYnFPUFFSRzVGUFZiRFpYUEtwUHRGOFZPSWVJeXJ4VDhL?=
 =?utf-8?B?KzBQdUVJTHFpNyt0eDFXTm9MeEhHaFMwUktnSU1ZSjQrVmhac0tLcFhUTzFh?=
 =?utf-8?B?NXRzbkxaS2o5Q1RHdFMxYXNFK1pzZTVQWFN5d1hGV3JLTHFNRzZLWVVLZ0Rt?=
 =?utf-8?B?S0VhM01QMzg2eFg3Tnd4WmljSkJPNC81Y1lEUkNVNjdIMEJKaG1CRVFPaC8z?=
 =?utf-8?B?R3BrMEQzeUhGanU4Rk9JY0QxQVc5Y1BHTjFMNVVzVDRPMEtIeGJnWmxIdldH?=
 =?utf-8?B?VjZpYXh5NEMxNTFZSXdYOEEvVjNIMWc3M3duT3ZWeDVIVGVwaWdrVkp0K2F3?=
 =?utf-8?B?YWZ5UmpBVWpzdEJ4YTNTQW9IRnJTblNHcytjMmR4b010MndycFBVYlVYb3RI?=
 =?utf-8?B?N05lajZSbW5WYlhSUE5weHlTT3hPWGk3U2w1bHZZaVhUNTgwd0xJelVHMVhE?=
 =?utf-8?B?cE81Q0lGNnBJVEVEYWF1Um56Uy9TWGxYQ2o5MkR0eHh0Rlg2R3RaSGp4b012?=
 =?utf-8?B?SmdDTmxEOFVZRUJBV1RybWRickQ0UFVyQmhpenRtY0VnNUp2K2NjRGt6cndy?=
 =?utf-8?B?YitzS1U5QU5HdjVpY1dCdEp4aFQ0N0djMHFJUThzaVNMMVNLU1dFc2o5bEs4?=
 =?utf-8?B?em96MGttMGp1eitzT0FNMW1iQ2N3NllkL1pYODRVNjIwZ1NRdzlGQ1o5TUg4?=
 =?utf-8?B?cUdkUEVkQzNJd0I2ajhRT3V6a3dLVFIvK3JQSzR0QWo0SHBsL0NaRVFtb2R2?=
 =?utf-8?B?YnFTNVRsWEpGeUd2b2dPNGFRODE2ZktqTVJIYWVjN1kvcG1MbUN2RzR5SEMv?=
 =?utf-8?B?ME5rVFI5Mm5Pd0JUUSt5dklBYzdRRitpbzBncXBvQTZxNlAzUEhCbzJOQzll?=
 =?utf-8?B?VWJ5cXpkRjljNkZMTFNLWEoxaldvbDk2L1Voa1YydHVOMWVyaFdKZzNBMm9n?=
 =?utf-8?B?YklBYnFINXZSdnBkZlNLWGpkZjdxY25TK3JlaGlVWlFkaEJRcUl2U0x5ZytR?=
 =?utf-8?B?dVJOeUNiZTBsemdSZWpROTRzaU5tWitGRkF3aVUyaUhNYnpUZ0xXU0I2SHhF?=
 =?utf-8?B?VDFMOHp4ZE9WbHhsbXJXc2MveC9keDMvWWtmcGpBN3hvVEVhdld1UFIxc3pU?=
 =?utf-8?B?NzQ0dnZRa1Jia0FaMEhRRi9vSk5xb1ZNTS9STVJJa3I0MCtaZ1JJQVQ3QnNZ?=
 =?utf-8?B?dXpheE1YNER2Y3UrNHhRRExjT3o0T0RCNHlxSzQ2aDRidmo2U1ltYzNkdVZL?=
 =?utf-8?B?d2sxNFR2K0ZXaWxNdXR0RmRqMTl3VjFlMnRGUFBUdmNIeWdlWGg0TmtQUmww?=
 =?utf-8?B?ZFFSc0FlZzMwR2xCSmVXSU9uMGVRemtkODhOYkJhZmlFVnkvTGQ5WWVTNlRK?=
 =?utf-8?B?RW9JS1FsNGxma3N0SGxPaEF5OEIxYkczR0o2YTRsbGFJME0zdk9sUkwzcUFl?=
 =?utf-8?B?eDN4Rmc0a212TWRXclM1NlhWRG9mMVJjM2oxS0ZuYUd1aE1CeElzTWxJVlpQ?=
 =?utf-8?B?VTkyd2IxNGJEeGNDbXBvTTBZVkt1ZlFCOUJScGZvRldOWjFmcnZ0MWMyR0FG?=
 =?utf-8?B?MzZVeWpYMFFRQTdhajRjbm91dS8zd2owaVprbVZNZzNOY04xVWdIRS8vYm9E?=
 =?utf-8?B?MUVtMHZUSjZqZnpWQUtTRDgxa1hQY0V3WE9NYWozWHpEeVQweW50c1p6eEZm?=
 =?utf-8?B?Umc4U1YySWlpVDlwV1N1T0hkOUFQaUtRWWxaUjNGWUp2YnF0Q1c0TmZXS3li?=
 =?utf-8?B?cktKNllnOUFmZmNHWG91MEh1bkdxNzhuZ2JPalhkYVVLemZaYnVSbjZxUitU?=
 =?utf-8?B?NVNROUN5MCt0OUxZNzZuaFUyMTVpeThtMlRMZnFuMUt2dXk2aXAzeUZPd3d2?=
 =?utf-8?Q?gw2s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 300bb01a-8a2d-43be-08c2-08dcf349e6d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2024 10:03:11.0369
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QDwvbadPavhgPcRvoPryKUZkMzcHSzLU2/H+igi88YvpYeDzw86Nxu0LuMcC4/qpd6eFbzufndk9DAWb3HwDDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8923

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tp
IDxrcnprQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjTlubQxMOaciDIz5pelIDE2OjU2DQo+IFRv
OiBXZWkgRmFuZyA8d2VpLmZhbmdAbnhwLmNvbT4NCj4gQ2M6IGRhdmVtQGRhdmVtbG9mdC5uZXQ7
IGVkdW1hemV0QGdvb2dsZS5jb207IGt1YmFAa2VybmVsLm9yZzsNCj4gcGFiZW5pQHJlZGhhdC5j
b207IHJvYmhAa2VybmVsLm9yZzsga3J6aytkdEBrZXJuZWwub3JnOw0KPiBjb25vcitkdEBrZXJu
ZWwub3JnOyBWbGFkaW1pciBPbHRlYW4gPHZsYWRpbWlyLm9sdGVhbkBueHAuY29tPjsgQ2xhdWRp
dQ0KPiBNYW5vaWwgPGNsYXVkaXUubWFub2lsQG54cC5jb20+OyBDbGFyayBXYW5nIDx4aWFvbmlu
Zy53YW5nQG54cC5jb20+Ow0KPiBGcmFuayBMaSA8ZnJhbmsubGlAbnhwLmNvbT47IGNocmlzdG9w
aGUubGVyb3lAY3Nncm91cC5ldTsNCj4gbGludXhAYXJtbGludXgub3JnLnVrOyBiaGVsZ2Fhc0Bn
b29nbGUuY29tOyBob3Jtc0BrZXJuZWwub3JnOw0KPiBpbXhAbGlzdHMubGludXguZGV2OyBuZXRk
ZXZAdmdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsNCj4gYWxl
eGFuZGVyLnN0ZWluQGV3LnRxLWdyb3VwLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IG5l
dC1uZXh0IDAzLzEzXSBkdC1iaW5kaW5nczogbmV0OiBhZGQgYmluZGluZ3MgZm9yIE5FVEMNCj4g
YmxvY2tzIGNvbnRyb2wNCj4gDQo+IE9uIDIzLzEwLzIwMjQgMTA6MTgsIFdlaSBGYW5nIHdyb3Rl
Og0KPiA+Pj4gK21haW50YWluZXJzOg0KPiA+Pj4gKyAgLSBXZWkgRmFuZyA8d2VpLmZhbmdAbnhw
LmNvbT4NCj4gPj4+ICsgIC0gQ2xhcmsgV2FuZyA8eGlhb25pbmcud2FuZ0BueHAuY29tPg0KPiA+
Pj4gKw0KPiA+Pj4gK3Byb3BlcnRpZXM6DQo+ID4+PiArICBjb21wYXRpYmxlOg0KPiA+Pj4gKyAg
ICBlbnVtOg0KPiA+Pj4gKyAgICAgIC0gbnhwLGlteDk1LW5ldGMtYmxrLWN0cmwNCj4gPj4+ICsN
Cj4gPj4+ICsgIHJlZzoNCj4gPj4+ICsgICAgbWluSXRlbXM6IDINCj4gPj4+ICsgICAgbWF4SXRl
bXM6IDMNCj4gPj4NCj4gPj4gWW91IGhhdmUgb25lIGRldmljZSwgd2h5IHRoaXMgaXMgZmxleGli
bGU/IERldmljZSBlaXRoZXIgaGFzIGV4YWN0bHkNCj4gPj4gMiBvciBleGFjdGx5IDMgSU8gc3Bh
Y2VzLCBub3QgYm90aCBkZXBlbmRpbmcgb24gdGhlIGNvbnRleHQuDQo+ID4+DQo+ID4NCj4gPiBU
aGVyZSBhcmUgdGhyZWUgcmVnaXN0ZXIgYmxvY2tzLCBJRVJCIGFuZCBQUkIgYXJlIGluc2lkZSBO
RVRDIElQLCBidXQNCj4gPiBORVRDTUlYIGlzIG91dHNpZGUgTkVUQy4gVGhlcmUgYXJlIGRlcGVu
ZGVuY2llcyBiZXR3ZWVuIHRoZXNlIHRocmVlDQo+ID4gYmxvY2tzLCBzbyBpdCBpcyBiZXR0ZXIg
dG8gY29uZmlndXJlIHRoZW0gaW4gb25lIGRyaXZlci4gQnV0IGZvciBvdGhlcg0KPiA+IHBsYXRm
b3JtcyBsaWtlIFMzMiwgaXQgZG9lcyBub3QgaGF2ZSBORVRDTUlYLCBzbyBORVRDTUlYIGlzIG9w
dGlvbmFsLg0KPiANCj4gQnV0IGhvdyBzMzIgaXMgcmVsYXRlZCBoZXJlPyBUaGF0J3MgYSBkaWZm
ZXJlbnQgZGV2aWNlLg0KPiANCg0KVGhlIFMzMiBTb0MgYWxzbyB1c2VzIHRoZSBORVRDIElQLCBz
byB0aGlzIFlBTUwgc2hvdWxkIGJlIGNvbXBhdGlibGUgd2l0aA0KUzMyIFNvQy4gT3IgZG8geW91
IG1lYW4gd2hlbiBTMzIgTkVUQyBpcyBzdXBwb3J0ZWQsIHdlIHRoZW4gYWRkIHJlc3RyaWN0aW9u
cw0KdG8gdGhlIHJlZyBwcm9wZXJ0eSBmb3IgUzMyPw0KDQo=

