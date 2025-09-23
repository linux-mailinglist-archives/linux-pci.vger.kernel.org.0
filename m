Return-Path: <linux-pci+bounces-36751-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B5BB952C0
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 11:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DC5D16D80B
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 09:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4D33203AE;
	Tue, 23 Sep 2025 09:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OeLOpF6I"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010012.outbound.protection.outlook.com [52.101.84.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C3C31FEEE;
	Tue, 23 Sep 2025 09:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758618705; cv=fail; b=pLMs6jqke8ytpEMBlucxZIePY8DV2ToFCDdo6x4jxoBWFto1i0f6BvvPphKlrPjrMlTnJ4qJ9rFJytRty7UBwmNWXokhQtkYF67OrJ4+kuBZyJ39kQgr+kST6z3nqGFFgxYJy4xS0u5y0JnbnBp/1m8J1+cfgIds8Vdzx060QTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758618705; c=relaxed/simple;
	bh=p4P25JLwqhRYxpGOvAWoiYRvwX5K8K8qEHYqsjkME5M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ql3GbKkt2+tXnuje1S20B5goAl3pI6kraqleG5weIxDN2ChwSKiEsR7UNfOPm5iD2CtPLu19XQlr0VEnanPyqKaJicM+gn+xFR2hTLOQ4iHFJTyCBf04eOMw1IUmAsMVFLE0qpCfirsP3ZtfEEPKY/2utvtT1qD+Un26fUtA/VU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OeLOpF6I; arc=fail smtp.client-ip=52.101.84.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gBQ5/NM02oWKYRq7ew6feC+YtWyuQtjCt0l5E4/cfeuYHfWPglmGG7kBj6R7FKkmAY3MJzrWfAuBfHuADZUoLG1uEcuCqkEI7ZwkXUS46GZ8PD1c6k6F6CbOf3/TbrFNRbXKJBXgA0kFmwP7uWH2hwJpgU7gzkafFCHpIIKp2352aJOo4kNNddAVQGfy/zSq7ieBqsr7hhlMalvUXWjr03viU5co46tFnOsUMviy6nuVMtfPYzEr67SKH33a0SN4tS1MQLRTvhnRweYEj//Ksi2jZshqdP9eBGz+FX3z+2mb5wAZlrYe+QeGL/ZbQAccgOJMBrhKbOekotPkijAUTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p4P25JLwqhRYxpGOvAWoiYRvwX5K8K8qEHYqsjkME5M=;
 b=S3q4JVPcPerPOlHFLbb8uay66NHDKv6JvuUWOkegKRRbk/zi7+vmhn5vF4scRL2QAntlaOSntMEP3o86Fn+R7zR1LQA27Qsb12tJj0RxoTer3kie2s6ZWDcAGeMfQCFP/2b/BZkiStXYfkKuGH1qwbL4Kj7dnilW4wR8iKw1HtJIHUZJrsyFVfBoGSk/meWPJnCUmk6/0h+FvX6a0DLD5K2gE84WFGS1PDU3OKic3qgHTdY3QDcBnnmwDWBHGmZIPALhmU4oQmH0i/Ko/ZFOk0LYZa+9z3OWA/GkIc/nRrN3WfZAbAUtmogDn/fFqh2VbOyRk134GR5z85o5gqcW+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p4P25JLwqhRYxpGOvAWoiYRvwX5K8K8qEHYqsjkME5M=;
 b=OeLOpF6Iz5L8IxzNBuEiDQAKdc9v3NF6x+g8/IH2FmzonaUDiBS26SYtBB9kgGNQFdtwbLu7y88XdFDTPQnl1tPFjo3rT9+MNX1zFrcK2gy+0DwWPf6CQPa+bnCPFFHXs4FevKvUb1wLA75VVECPFPtSbesIzAuUZZaHNJmIL5uW9z9iH9QT+C7afbLkgDyMB4rVeohIYoSpiub7YZGtTuCdQkm6gLekXu8GIcR3CKcldOXMUOvWLAQ3cApYg3zcgFoedJoEfR4PzUR+xN9wkFNjVW20GZzqz5qykXQWdMYn1N/Mdh3o167eV/yULbRzOBUYo9VMp64W51lS6YiNMA==
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by AM9PR04MB8257.eurprd04.prod.outlook.com (2603:10a6:20b:3b6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Tue, 23 Sep
 2025 09:11:38 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%3]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 09:11:36 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>
CC: Frank Li <frank.li@nxp.com>, "jingoohan1@gmail.com"
	<jingoohan1@gmail.com>, "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kwilczynski@kernel.org"
	<kwilczynski@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 2/6] PCI: dwc: Don't poll L2 if QUIRK_NOL2POLL_IN_PM is
 existing in suspend
Thread-Topic: [PATCH v5 2/6] PCI: dwc: Don't poll L2 if QUIRK_NOL2POLL_IN_PM
 is existing in suspend
Thread-Index: AQHcG9/1u0f50jbABE640+M7pBCkeLSbt/EAgANRQBCAACZ7gIABbDyg
Date: Tue, 23 Sep 2025 09:11:35 +0000
Message-ID:
 <AS8PR04MB8833BF38F270A6EE5700D0498C1DA@AS8PR04MB8833.eurprd04.prod.outlook.com>
References: <20250902080151.3748965-1-hongxing.zhu@nxp.com>
 <20250902080151.3748965-3-hongxing.zhu@nxp.com>
 <p4hqjnhpih2uy5hzf7llrd3ah7ov6sijkuqjecpvv5j2iqrsji@kxj5xwb7a5p4>
 <AS8PR04MB88335CEA526C3B5E957EF0C88C12A@AS8PR04MB8833.eurprd04.prod.outlook.com>
 <agtozwcmgwj7kfmzkrglqcba5vaqmd2hv3matzmksbckkrrno3@zdteyblgvpyr>
In-Reply-To: <agtozwcmgwj7kfmzkrglqcba5vaqmd2hv3matzmksbckkrrno3@zdteyblgvpyr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8833:EE_|AM9PR04MB8257:EE_
x-ms-office365-filtering-correlation-id: fcb2ac7d-f26d-480e-6b7d-08ddfa813263
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|7416014|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?bldCb3pGcHpENEhJVjI5alIrSEtTVWVvSC9xbHB5WUNXRyt6dEhrajFQUEgr?=
 =?utf-8?B?K2ZsSFVUU21VbzMwUndhRW1lWGdnaERrSDBWY2xQTW1aTEJwMmhCQktoSFFi?=
 =?utf-8?B?djRaNXNpcEI1Mk5LNlpGNFR0UHhTdzZLZE52azVuaTl5czBRMUhDcHhMQWxv?=
 =?utf-8?B?NjFuNkxPQWxFOXRhK0pGL2NhYWlRZkdIcTU2a1drV1FPa2EvVU1zWVYxbTUr?=
 =?utf-8?B?VURhc1Mrc2FmY2ROam0xQmJFQ21Rd0xWT0g2dmc5bGcwZzIvM2hVT2pYSzRT?=
 =?utf-8?B?d3pITnZlS3ZqL1NoN2kycnBCeklkbER5Z2dEZ3JSV1ZDRWkvT1VGeHVWNDdt?=
 =?utf-8?B?amdFYTlSYXJZNVRnM1FwY0NwMlM0bjErVUlqZWFlSmhQZERCa0ovazc5d3RY?=
 =?utf-8?B?aUt3TVdUeEdGdEJRNFVtQ29LS3RzL0pDOElJRDhiWW9SK2JNa1RLcGQ5YmZR?=
 =?utf-8?B?N3FRUFBseWVhcTh4SmsxY3VZN3pFY3k5RkRWbTVXK2Y5aVBOOUR6Nzl4YlFj?=
 =?utf-8?B?RlExTFBGUVhoMm80MmhmaVMyZzlabnk1NGEzYUpvMnRkODJ2T0tjajJ2M3RG?=
 =?utf-8?B?b2ExYnlWVmJEZ1FIQjBYQWI0bGQyWncrTVo1MVVoTFk3Q1lCRHI4dEp4OVZJ?=
 =?utf-8?B?WStLMXhiMHJBK0VmUG1JaEZpc1VJV0tpcUhmUmxQQkdYR2JZcnc5QjBPQ2Vk?=
 =?utf-8?B?RnF3WWErOEswd1NhQmc5WkVyYzhORldzMHpqQkxocktudmJhNXpRZ1RlU25t?=
 =?utf-8?B?NlIwUno0Z01EdVZNQnlIR3VVVlVzbnJndFphelBmamFwcU9jV3p5V1p3OW9J?=
 =?utf-8?B?M0RIWUFsZVNQUlh4RkRCdFlxcGZNckRDblc4REptUVJOUlBsblNBT1o2S1FU?=
 =?utf-8?B?aUNub2prNXduVFpacDk4TGd3eDRKNGdlaDlreXN5RzdoRnVLVkU0a0NGYWtY?=
 =?utf-8?B?b2Qyb0pLN2ZXOS9nWWMzc3FISWxWalBwZExqMi91R0RSNGlpc0NyWFRtSENt?=
 =?utf-8?B?eUdlMWlHSWxQWnI3U2pOQWdpQ1JMZU84MXFoWGZQSEhmR3E4aHJuZW9FME1P?=
 =?utf-8?B?TEtNUnR5UC83aWFhUFlyQnpNVnJzU0E3M3JlNVpFRlZVeG1DNEltdnZQSUlE?=
 =?utf-8?B?bk9ZZnpRMEg3WDBSdDFNb3lhVnFkS1BwcjRlWVlRdkdKeTNYcE8ybE9rcWlH?=
 =?utf-8?B?Q3FrcjFWQkNUYlVmY2czcGZmbmpYdStBaWF1RHVUUExWeUMvWUdvaU9zU3Jj?=
 =?utf-8?B?K1YwVlZ2a0w4Sms5LzJBREhzaUVNYnozY2hydjZ6emw1ZUFoM2tRdlRGdUgw?=
 =?utf-8?B?UllKdzVnRFh3Y2lWYnJoSE5sNjdwRFpTWFVnRUlRbExDNEUxWG85SnFtcVRU?=
 =?utf-8?B?ZVRhVmhuYUpHS2xRTnkyQmxpWHFjRjBQdm05ZVhrQktVM1M4Z2FpZzB1cEUy?=
 =?utf-8?B?LzJGMUcxYVc2QWJjSXYxS2pMTlF1bzY0MWNDMDdlT0lNRkhoWVlaaDBFenB3?=
 =?utf-8?B?VERxNkltUWV0NU43dis1bWZMNyt5d3FDZ3BQUjRlZ005MXBtVnZqZTdjZUdN?=
 =?utf-8?B?UVBlYnNWc3VjV205dHN0SGl1bXRVNkVtRCtod2JiOG90b1cxdDRwclJJY3Nt?=
 =?utf-8?B?Unk2eUFGV2dwcUJPUmxiZVdiaWIzak9Ld25OeTlESlU2TjRqM2puVFVQdDlQ?=
 =?utf-8?B?VE5jU204MFUvbnBjTjNSSnVac0NDbWNCeXpmQ1hVTWkyUmlmL2tnMkx4Y1ZY?=
 =?utf-8?B?d2RrUnR2RzNrbWN5ZVJDNTZ4b0tvY0lzVGQ3NDQ3WGtIOVFid2h3Q0lySGtZ?=
 =?utf-8?B?dTRURm00SHpKR2h6MEtaV3B4THdBQUo1SUxDTlRxdFN4eHppWU9CbGRuU2lC?=
 =?utf-8?B?V2Rzb0VYOEJ0SHEvdUQrMTJLQVBPdWpDRUZXV1lacXdGTEJocU1oWCtHLzRG?=
 =?utf-8?B?RmRSSm5UVC9GYkdzS01ka1BmZVNLQ21WT3c1TWtSR2JaWlptTlBMd3NYNzY4?=
 =?utf-8?Q?qdMRRS03xr9NeOpCTDbM7DeKVxjIsU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b0pvck5lTklNWGxXdTc2MUd5bEVpWHFOaXJQZk1BZjJMWlJBTlgyTmVOTDVC?=
 =?utf-8?B?eW93eldpRTZ4d2E1dXJFekN0b3pQai9JTXR2VlEzT25IVVgzS1hRcDVvNGFO?=
 =?utf-8?B?c0liVitnclV3SUU0RGFtY1ZDQVBHc1pYMC9FdUtkUHdrUVAzOFZyaExBWDF2?=
 =?utf-8?B?b3JqLzh1N3MxdTFjUGdYTFp2d2o4YVVxb0JUVklXYndIckV2ckFmOWpEeUNl?=
 =?utf-8?B?Y01XM295VGRqMXA0emJ6Mk1SL0hyMFd5UzJrMXB6YzlSM21rc2xPSElEWHYw?=
 =?utf-8?B?dFZ5akFCeTk2dlVIVi80R0Y5MVNGSUVJaUg4U3lKS3BvNHIvVDNoOTltYzNP?=
 =?utf-8?B?b1owaUU2SlpOWmpQYVRHTllKdGkxOW0xQkNrMVk3N2xtQURyTitHQVBkY1hI?=
 =?utf-8?B?Mkt0VGJHT2ZwNnRjYTVvempudDREdDZKTzhFSHltTG9yZFlYTTU0VWxXSG9n?=
 =?utf-8?B?WmFFTDZvVFpHSzc0dldNNmdOOS9TUk9EUlBJYVpQSVhZYy94d01Zb3RGTHYx?=
 =?utf-8?B?YnRZekVPVTFyZGtTVGxYMXBnVCtKakxrR011aEQ1SWNmMWRTL2FOaFkwVUtE?=
 =?utf-8?B?TTFFY1RIZkwwOXJLc1Zvd1FVM0ZrZFB3NGR4Ym01dGQrRG1qb0hSbDlubFBh?=
 =?utf-8?B?Z3Z0UTQ0SElJeE96dGRTRDJmLzA2K0tzNkVienJXOWNTVVUxWk54UXRsQktU?=
 =?utf-8?B?YkhUTDFFakVkRVlqRmxMRG9zeXo0WWY0VkVjZWdsSGdvTkQ1Q3dZR21pQUEr?=
 =?utf-8?B?MzZmYjNQb2JDNEF2bXgrSlR0Vlg5c0ZvVVBISzFOSUEyMi9UVVQ3Vmpnemxy?=
 =?utf-8?B?SjdUd3N5M3F4ak9HbkZnSFROb0J1clcwOFlRakg3V0l1LzZSb0l3cGJLY0JN?=
 =?utf-8?B?WmR6K2p5Q0tORWVjcks4T1ZGYld6cDdwYmUvTlB5aUFWUEdhR05nZFdvOEh4?=
 =?utf-8?B?TEd1ZVpUR3ZlbGFvaXRIYUppZGZqNU94VlplQW1ZamZBU3U5Qld4eWtrRTlV?=
 =?utf-8?B?ZER6YlhFVjFEcFdwWFRzK2FYbXdrUjRNeDA4a1llam1Eaktybk9Gd2pMbDZP?=
 =?utf-8?B?SFZrL0p5TkZpTVpkajIwdy9wWkxsanNxcHRpVDlxVndHTDBMbjB0TDRnSG5l?=
 =?utf-8?B?Y3JHRFRyckxxdkZaNHpMQW1kUUZSaVg4UHJqVU8yMVhBdnBCdm5WcVIwV2Zn?=
 =?utf-8?B?WjY1TmQ0amZuYlFLTkhyOEhPUXk0cjZ3dkpQb1pLNE11a25ST1VnZmRaazFW?=
 =?utf-8?B?di9aODcxOWZPTWt6dnozbjBOR0E5Y0NzV3FXaDY1dEVYYzJERGgyeVB6Zmtt?=
 =?utf-8?B?bUVUcFc1UFRpRU1WdkFqRVNpWVNKVFlZV3B5dVNsbjYxZm9VM0psS1VmMlNp?=
 =?utf-8?B?RlJZLzU4elZ5ZEhKNWVnS3dSM0dCMTVUVlU4QXNiR2FPUW91OFljbUdTaDJj?=
 =?utf-8?B?ZWpEYUFjY3BialQ3Y1p2ZlYrL2U2d2hpNUdyMjRJVWprZ2w1OXUza3RZYW9C?=
 =?utf-8?B?VWQ3SEpJdjNuYk00Wk12RWpKTmJxZVNJMFMyYThjRHd3dVVDelluK21YZkdX?=
 =?utf-8?B?TENiQVFMRUVvNTFoblJ1VTQySUFYaENRVzByVjNFVFpvd01IQ3BzYnJxYnBT?=
 =?utf-8?B?MXpWWmpwcEFmWG9QWm0vdEc1MEJNSnJkK1RBOVBoeGRNNndUSTl0UTRDWFE5?=
 =?utf-8?B?RUl5VWtTNnZ4RTZUUUo0cTFhQnFHZVA3RVVjTUNDd0trQWJtKzZKcDVzL1RG?=
 =?utf-8?B?Mlh1c2J1eWIyRXNpdUVLaVFhUU1YUXpHb081ZC9JaXhLMFg2aUdBdDdieTFt?=
 =?utf-8?B?RGdydzE5SVh5T0dWZGtUSVl5QTYrM0cxZWFRSGRCOGg5Z1oyM3o5TzV3ZnJP?=
 =?utf-8?B?bjJsdFpWV2xjcmF2dFBEL04rOXBQOWdYT2NQdUdVVi8vVm1rOHQwT0FYamJm?=
 =?utf-8?B?TEFpLy9ETzdWK2NpKzdWYU9zRzNPVUtvOUI0ZXJKRnBhOFNCVjZuQkcrV3o2?=
 =?utf-8?B?VTkrQmRlT3I4RDNkdWpMZDRGTVVXV1B5NUlCRGxlQ0x6LzRKdFp2T0trKzla?=
 =?utf-8?B?dHpUNkNVNlhDV2U4T1hjeXdYdXRyS3BOdTZSL0JBWjNzOXBMVUpYdWNCOTBo?=
 =?utf-8?Q?isP0=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcb2ac7d-f26d-480e-6b7d-08ddfa813263
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2025 09:11:35.8540
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: es3zL6q7L6y5GCqsoAs2y9WeQHlQA4uW/yrTmECam68afS1B74tH9gXo2ttZltLip1yt7Py7RQXnammJXLgDgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8257

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYW5pdmFubmFuIFNhZGhhc2l2
YW0gPG1hbmlAa2VybmVsLm9yZz4NCj4gU2VudDogMjAyNeW5tDnmnIgyMuaXpSAxOToyNg0KPiBU
bzogSG9uZ3hpbmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gQ2M6IEZyYW5rIExpIDxm
cmFuay5saUBueHAuY29tPjsgamluZ29vaGFuMUBnbWFpbC5jb207DQo+IGwuc3RhY2hAcGVuZ3V0
cm9uaXguZGU7IGxwaWVyYWxpc2lAa2VybmVsLm9yZzsga3dpbGN6eW5za2lAa2VybmVsLm9yZzsN
Cj4gcm9iaEBrZXJuZWwub3JnOyBiaGVsZ2Fhc0Bnb29nbGUuY29tOyBzaGF3bmd1b0BrZXJuZWwu
b3JnOw0KPiBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGZl
c3RldmFtQGdtYWlsLmNvbTsNCj4gbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJt
LWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiBpbXhAbGlzdHMubGludXguZGV2OyBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgMi82XSBQ
Q0k6IGR3YzogRG9uJ3QgcG9sbCBMMiBpZiBRVUlSS19OT0wyUE9MTF9JTl9QTQ0KPiBpcyBleGlz
dGluZyBpbiBzdXNwZW5kDQo+IA0KPiBPbiBNb24sIFNlcCAyMiwgMjAyNSBhdCAwOToxODoyMEFN
ICswMDAwLCBIb25neGluZyBaaHUgd3JvdGU6DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KPiA+ID4gRnJvbTogTWFuaXZhbm5hbiBTYWRoYXNpdmFtIDxtYW5pQGtlcm5lbC5vcmc+
DQo+ID4gPiBTZW50OiAyMDI15bm0OeaciDIw5pelIDE0OjI5DQo+ID4gPiBUbzogSG9uZ3hpbmcg
Wmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gPiA+IENjOiBGcmFuayBMaSA8ZnJhbmsubGlA
bnhwLmNvbT47IGppbmdvb2hhbjFAZ21haWwuY29tOw0KPiA+ID4gbC5zdGFjaEBwZW5ndXRyb25p
eC5kZTsgbHBpZXJhbGlzaUBrZXJuZWwub3JnOw0KPiA+ID4ga3dpbGN6eW5za2lAa2VybmVsLm9y
Zzsgcm9iaEBrZXJuZWwub3JnOyBiaGVsZ2Fhc0Bnb29nbGUuY29tOw0KPiA+ID4gc2hhd25ndW9A
a2VybmVsLm9yZzsgcy5oYXVlckBwZW5ndXRyb25peC5kZTsga2VybmVsQHBlbmd1dHJvbml4LmRl
Ow0KPiA+ID4gZmVzdGV2YW1AZ21haWwuY29tOyBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOw0K
PiA+ID4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiA+ID4gaW14QGxp
c3RzLmxpbnV4LmRldjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiA+ID4gU3ViamVj
dDogUmU6IFtQQVRDSCB2NSAyLzZdIFBDSTogZHdjOiBEb24ndCBwb2xsIEwyIGlmDQo+ID4gPiBR
VUlSS19OT0wyUE9MTF9JTl9QTSBpcyBleGlzdGluZyBpbiBzdXNwZW5kDQo+ID4gPg0KPiA+ID4g
T24gVHVlLCBTZXAgMDIsIDIwMjUgYXQgMDQ6MDE6NDdQTSArMDgwMCwgUmljaGFyZCBaaHUgd3Jv
dGU6DQo+ID4gPiA+IFJlZmVyIHRvIFBDSWUgcjYuMCwgc2VjIDUuMiwgZmlnIDUtMSBMaW5rIFBv
d2VyIE1hbmFnZW1lbnQgU3RhdGUNCj4gPiA+ID4gRmxvdyBEaWFncmFtLiBCb3RoIEwwIGFuZCBM
Mi9MMyBSZWFkeSBjYW4gYmUgdHJhbnNmZXJyZWQgdG8gTERuDQo+IGRpcmVjdGx5Lg0KPiA+ID4g
Pg0KPiA+ID4gPiBJdCdzIGhhcm1sZXNzIHRvIGxldCBkd19wY2llX3N1c3BlbmRfbm9pcnEoKSBw
cm9jZWVkIHN1c3BlbmQgYWZ0ZXINCj4gPiA+ID4gdGhlIFBNRV9UdXJuX09mZiBpcyBzZW50IG91
dCwgd2hhdGV2ZXIgdGhlIExUU1NNIHN0YXRlIGlzIGluIEwyIG9yDQo+ID4gPiA+IEwzIGFmdGVy
IGEgcmVjb21tZW5kZWQgMTBtcyBtYXggd2FpdCByZWZlciB0byBQQ0llIHI2LjAsIHNlYw0KPiA+
ID4gPiA1LjMuMy4yLjEgUE1FIFN5bmNocm9uaXphdGlvbi4NCj4gPiA+ID4NCj4gPiA+ID4gVGhl
IExUU1NNIHN0YXRlcyBhcmUgaW5hY2Nlc3NpYmxlIG9uIGkuTVg2UVAgYW5kIGkuTVg3RCBhZnRl
ciB0aGUNCj4gPiA+ID4gUE1FX1R1cm5fT2ZmIGlzIHNlbnQgb3V0Lg0KPiA+ID4gPg0KPiA+ID4N
Cj4gPiA+IFRoaXMgc3RhdGVtZW50IGlzIG5vdCBhY2N1cmF0ZS4gQSBzaW5nbGUgcmVnaXN0ZXIg
cmVhZCBjYW5ub3QgY2F1c2UgaGFuZw0KPiBBRkFJSy4NCj4gPiA+IEknbSBndWVzc2luZyB0aGF0
IHRoZSBsaW5rIGRvd24gKExEbikgaGFwcGVucyBhZnRlciBpbml0aWF0aW5nDQo+ID4gPiBQTUVf
VHVybl9PZmYgYW5kIHRoZSBhY2Nlc3MgdG8gQ1NSIHJlZ2lzdGVyIChMVFNTTSkgY2F1c2VzIGhh
bmcuDQo+ID4gPg0KPiA+ID4gSXMgbXkgdW5kZXJzdGFuZGluZyBjb3JyZWN0Pw0KPiA+IFRoZSBh
Y2Nlc3Mgb2YgTFRTU00gaXMgbm90IHJlbGllZCBvbiB0aGUgbGluayBpcyB1cCBvciBub3QuIEZv
cg0KPiA+IGV4YW1wbGUsICB0aGUgTFRTU00gc3RhdHMgY2FuIGJlIGFjY2Vzc2VkIHdoZW4gdGhl
IGxpbmsgaXMgaW4gdGhlDQo+ID4gdHJhaW5pbmcgIGFuZCBub3QgdXAgeWV0Lg0KPiA+DQo+ID4g
UGVyIHRvIHRoZSBkaXNjdXNzaW9uIHdpdGggQmpvcm4sIHRoZSBtb3N0IHBvc3NpYmxlIHJlYXNv
biBpcyB0aGF0IHRoZQ0KPiA+IExUU1NNIGlzbid0IHBvd2VyZWQgYW55bW9yZSBvbiBpLk1YNi83
IHdoZW4gUE1FX1R1cm5fT2ZmIGlzIGtpY2tlZCBvZmYuDQo+ID4gaHR0cHM6Ly9ldXIwMS5zYWZl
bGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGbG9yZQ0KPiA+
IC5rZXJuZWwub3JnJTJGaW14JTJGMjAyNTA4MTkxOTI4MzguR0E1MjYwNDUlNDBiaGVsZ2FhcyUy
RiZkYXRhPTANCj4gNSU3QzAyDQo+ID4gJTdDaG9uZ3hpbmcuemh1JTQwbnhwLmNvbSU3QzdlNGVk
NjIwM2UwNTQ4NDMzODQ0MDhkZGY5Y2FkZjY4JTdDDQo+IDY4NmVhMWQNCj4gPg0KPiAzYmMyYjRj
NmZhOTJjZDk5YzVjMzAxNjM1JTdDMCU3QzAlN0M2Mzg5NDEzNzE4OTk1NDcwOTElN0NVbmtubw0K
PiB3biU3Q1RXRg0KPiA+DQo+IHBiR1pzYjNkOGV5SkZiWEIwZVUxaGNHa2lPblJ5ZFdVc0lsWWlP
aUl3TGpBdU1EQXdNQ0lzSWxBaU9pSlhhVzR6DQo+IE1pSXNJDQo+ID4NCj4ga0ZPSWpvaVRXRnBi
Q0lzSWxkVUlqb3lmUSUzRCUzRCU3QzAlN0MlN0MlN0Mmc2RhdGE9bndQOTQyc3N6WDUzMg0KPiBE
ZnRLNG8NCj4gPiB6ZEo4dkhMMmtsenNSaERiWmJqJTJCblNMayUzRCZyZXNlcnZlZD0wDQo+ID4N
Cj4gDQo+IEknbSBub3Qgc3VyZSB0aG91Z2guIENvdWxkIHlvdSB0cnkgdG8gcmVhZCBhbnkgREJJ
IHJlZ2lzdGVyIGF0IHRoaXMgcG9pbnQgYW5kIHNlZQ0KPiBpZiB0aGUgaGFuZyBpcyBvYnNlcnZl
ZCBvciBub3Q/DQo+IA0KPiBMVFNTTSBzdGF0ZXMgYXJlIGV4cHJlc3NlZCB0aHJvdWdoIHRoZSBE
QkkgcmVnaXN0ZXJzLiBTbyBhcyBwZXIgbXkNCj4gdW5kZXJzdGFuZGluZywgdW5sZXNzIHRoZSB3
aG9sZSBEQkkgcmVnaXN0ZXIgc3BhY2UgaXMgaW5hY2Nlc3NpYmxlLCBMVFNTTQ0KPiByZWdpc3Rl
cnMgc2hvdWxkIGJlIGFjY2Vzc2libGUuW1JpY2hhcmQgWmh1XSANCkhpIE1hbmk6DQpSZS1jb25m
aXJtZWQgaW4gdGVzdHMsIHRoZSBvdGhlciBEQkkgcmVnaXN0ZXJzIGNhbid0IGJlIGFjY2Vzc2li
bGUgZWl0aGVyLg0KDQpCZXN0IFJlZ2FyZHMNClJpY2hhcmQgWmh1DQo+IA0KPiAtIE1hbmkNCj4g
DQo+ID4gQmVzdCBSZWdhcmRzDQo+ID4gUmljaGFyZCBaaHUNCj4gPiA+DQo+ID4gPiA+IFRvIHN1
cHBvcnQgdGhpcyBjYXNlLCBkb24ndCBwb2xsIEwyIHN0YXRlIGFuZCBhcHBseSBhIHNpbXBsZSBk
ZWxheQ0KPiA+ID4gPiBvZg0KPiA+ID4gPiBQQ0lFX1BNRV9UT19MMl9USU1FT1VUX1VTKDEwbXMp
IGlmIHRoZSBRVUlSS19OT0wyUE9MTF9JTl9QTQ0KPiBmbGFnDQo+ID4gPiBpcw0KPiA+ID4gPiBz
ZXQgaW4gc3VzcGVuZC4NCj4gPiA+ID4NCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogUmljaGFyZCBa
aHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiA+ID4gPiBSZXZpZXdlZC1ieTogRnJhbmsgTGkg
PEZyYW5rLkxpQG54cC5jb20+DQo+ID4gPg0KPiA+ID4gV2UgbmVlZCBGaXhlcyB0YWcgYWxzbyBh
bmQgeW91IGRvIG5lZWQgdG8gc2V0IHRoZSBmbGFnIGluIHJlbGV2YW50DQo+ID4gPiBnbHVlIGRy
aXZlciBpbiB0aGlzIHBhdGNoIGl0c2VsZiBzbyB0aGF0IGl0IGNhbiBjbGVhbmx5IGJlIGJhY2tw
b3J0ZWQuDQo+ID4gPg0KPiA+ID4gLSBNYW5pDQo+ID4gPg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4g
IC4uLi9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLWhvc3QuYyB8IDM0DQo+ID4g
PiA+ICsrKysrKysrKysrKystLS0tLS0gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUt
ZGVzaWdud2FyZS5oDQo+ID4gPiA+ICsrKysrKysrKysrKyt8DQo+ID4gPiA+IDQgKysrDQo+ID4g
PiA+ICAyIGZpbGVzIGNoYW5nZWQsIDI4IGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQ0K
PiA+ID4gPg0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2Mv
cGNpZS1kZXNpZ253YXJlLWhvc3QuYw0KPiA+ID4gPiBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIv
ZHdjL3BjaWUtZGVzaWdud2FyZS1ob3N0LmMNCj4gPiA+ID4gaW5kZXggOWQ0NmQxZjAzMzRiLi41
N2ExYmEwOGM0MjcgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIv
ZHdjL3BjaWUtZGVzaWdud2FyZS1ob3N0LmMNCj4gPiA+ID4gKysrIGIvZHJpdmVycy9wY2kvY29u
dHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLWhvc3QuYw0KPiA+ID4gPiBAQCAtMTAxNiwxNSAr
MTAxNiwyOSBAQCBpbnQgZHdfcGNpZV9zdXNwZW5kX25vaXJxKHN0cnVjdCBkd19wY2llDQo+ICpw
Y2kpDQo+ID4gPiA+ICAJCQlyZXR1cm4gcmV0Ow0KPiA+ID4gPiAgCX0NCj4gPiA+ID4NCj4gPiA+
ID4gLQlyZXQgPSByZWFkX3BvbGxfdGltZW91dChkd19wY2llX2dldF9sdHNzbSwgdmFsLA0KPiA+
ID4gPiAtCQkJCXZhbCA9PSBEV19QQ0lFX0xUU1NNX0wyX0lETEUgfHwNCj4gPiA+ID4gLQkJCQl2
YWwgPD0gRFdfUENJRV9MVFNTTV9ERVRFQ1RfV0FJVCwNCj4gPiA+ID4gLQkJCQlQQ0lFX1BNRV9U
T19MMl9USU1FT1VUX1VTLzEwLA0KPiA+ID4gPiAtCQkJCVBDSUVfUE1FX1RPX0wyX1RJTUVPVVRf
VVMsIGZhbHNlLCBwY2kpOw0KPiA+ID4gPiAtCWlmIChyZXQpIHsNCj4gPiA+ID4gLQkJLyogT25s
eSBsb2cgbWVzc2FnZSB3aGVuIExUU1NNIGlzbid0IGluIERFVEVDVCBvciBQT0xMICovDQo+ID4g
PiA+IC0JCWRldl9lcnIocGNpLT5kZXYsICJUaW1lb3V0IHdhaXRpbmcgZm9yIEwyIGVudHJ5ISBM
VFNTTTogMHgleFxuIiwNCj4gPiA+IHZhbCk7DQo+ID4gPiA+IC0JCXJldHVybiByZXQ7DQo+ID4g
PiA+ICsJaWYgKGR3Y19xdWlyayhwY2ksIFFVSVJLX05PTDJQT0xMX0lOX1BNKSkgew0KPiA+ID4g
PiArCQkvKg0KPiA+ID4gPiArCQkgKiBBZGQgdGhlIFFVSVJLX05PTDJfUE9MTF9JTl9QTSBjYXNl
IHRvIGF2b2lkIHRoZSByZWFkDQo+IGhhbmcsDQo+ID4gPiA+ICsJCSAqIHdoZW4gTFRTU00gaXMg
bm90IHBvd2VyZWQgaW4gTDIvTDMvTERuIHByb3Blcmx5Lg0KPiA+ID4gPiArCQkgKg0KPiA+ID4g
PiArCQkgKiBSZWZlciB0byBQQ0llIHI2LjAsIHNlYyA1LjIsIGZpZyA1LTEgTGluayBQb3dlciBN
YW5hZ2VtZW50DQo+ID4gPiA+ICsJCSAqIFN0YXRlIEZsb3cgRGlhZ3JhbS4gQm90aCBMMCBhbmQg
TDIvTDMgUmVhZHkgY2FuIGJlDQo+ID4gPiA+ICsJCSAqIHRyYW5zZmVycmVkIHRvIExEbiBkaXJl
Y3RseS4gT24gdGhlIExUU1NNIHN0YXRlcyBwb2xsIGJyb2tlbg0KPiA+ID4gPiArCQkgKiBwbGF0
Zm9ybXMsIGFkZCBhIG1heCAxMG1zIGRlbGF5IHJlZmVyIHRvIFBDSWUgcjYuMCwNCj4gPiA+ID4g
KwkJICogc2VjIDUuMy4zLjIuMSBQTUUgU3luY2hyb25pemF0aW9uLg0KPiA+ID4gPiArCQkgKi8N
Cj4gPiA+ID4gKwkJbWRlbGF5KFBDSUVfUE1FX1RPX0wyX1RJTUVPVVRfVVMvMTAwMCk7DQo+ID4g
PiA+ICsJfSBlbHNlIHsNCj4gPiA+ID4gKwkJcmV0ID0gcmVhZF9wb2xsX3RpbWVvdXQoZHdfcGNp
ZV9nZXRfbHRzc20sIHZhbCwNCj4gPiA+ID4gKwkJCQkJdmFsID09IERXX1BDSUVfTFRTU01fTDJf
SURMRSB8fA0KPiA+ID4gPiArCQkJCQl2YWwgPD0gRFdfUENJRV9MVFNTTV9ERVRFQ1RfV0FJVCwN
Cj4gPiA+ID4gKwkJCQkJUENJRV9QTUVfVE9fTDJfVElNRU9VVF9VUy8xMCwNCj4gPiA+ID4gKwkJ
CQkJUENJRV9QTUVfVE9fTDJfVElNRU9VVF9VUywgZmFsc2UsIHBjaSk7DQo+ID4gPiA+ICsJCWlm
IChyZXQpIHsNCj4gPiA+ID4gKwkJCS8qIE9ubHkgbG9nIG1lc3NhZ2Ugd2hlbiBMVFNTTSBpc24n
dCBpbiBERVRFQ1Qgb3IgUE9MTCAqLw0KPiA+ID4gPiArCQkJZGV2X2VycihwY2ktPmRldiwgIlRp
bWVvdXQgd2FpdGluZyBmb3IgTDIgZW50cnkhIExUU1NNOg0KPiA+ID4gPiArMHgleFxuIiwNCj4g
PiA+IHZhbCk7DQo+ID4gPiA+ICsJCQlyZXR1cm4gcmV0Ow0KPiA+ID4gPiArCQl9DQo+ID4gPiA+
ICAJfQ0KPiA+ID4gPg0KPiA+ID4gPiAgCS8qDQo+ID4gPiA+IEBAIC0xMDQwLDcgKzEwNTQsNyBA
QCBpbnQgZHdfcGNpZV9zdXNwZW5kX25vaXJxKHN0cnVjdCBkd19wY2llDQo+ID4gPiA+ICpwY2kp
DQo+ID4gPiA+DQo+ID4gPiA+ICAJcGNpLT5zdXNwZW5kZWQgPSB0cnVlOw0KPiA+ID4gPg0KPiA+
ID4gPiAtCXJldHVybiByZXQ7DQo+ID4gPiA+ICsJcmV0dXJuIDA7DQo+ID4gPiA+ICB9DQo+ID4g
PiA+ICBFWFBPUlRfU1lNQk9MX0dQTChkd19wY2llX3N1c3BlbmRfbm9pcnEpOw0KPiA+ID4gPg0K
PiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNp
Z253YXJlLmgNCj4gPiA+ID4gYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2ln
bndhcmUuaA0KPiA+ID4gPiBpbmRleCAwMGY1MmQ0NzJkY2QuLjRlNWJmNmNiNmNlOCAxMDA2NDQN
Cj4gPiA+ID4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJl
LmgNCj4gPiA+ID4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253
YXJlLmgNCj4gPiA+ID4gQEAgLTI5NSw2ICsyOTUsOSBAQA0KPiA+ID4gPiAgLyogRGVmYXVsdCBl
RE1BIExMUCBtZW1vcnkgc2l6ZSAqLw0KPiA+ID4gPiAgI2RlZmluZSBETUFfTExQX01FTV9TSVpF
CQlQQUdFX1NJWkUNCj4gPiA+ID4NCj4gPiA+ID4gKyNkZWZpbmUgUVVJUktfTk9MMlBPTExfSU5f
UE0JCUJJVCgwKQ0KPiA+ID4gPiArI2RlZmluZSBkd2NfcXVpcmsocGNpLCB2YWwpCQkocGNpLT5x
dWlya19mbGFnICYgdmFsKQ0KPiA+ID4gPiArDQo+ID4gPiA+ICBzdHJ1Y3QgZHdfcGNpZTsNCj4g
PiA+ID4gIHN0cnVjdCBkd19wY2llX3JwOw0KPiA+ID4gPiAgc3RydWN0IGR3X3BjaWVfZXA7DQo+
ID4gPiA+IEBAIC01MDQsNiArNTA3LDcgQEAgc3RydWN0IGR3X3BjaWUgew0KPiA+ID4gPiAgCWNv
bnN0IHN0cnVjdCBkd19wY2llX29wcyAqb3BzOw0KPiA+ID4gPiAgCXUzMgkJCXZlcnNpb247DQo+
ID4gPiA+ICAJdTMyCQkJdHlwZTsNCj4gPiA+ID4gKwl1MzIJCQlxdWlya19mbGFnOw0KPiA+ID4g
PiAgCXVuc2lnbmVkIGxvbmcJCWNhcHM7DQo+ID4gPiA+ICAJaW50CQkJbnVtX2xhbmVzOw0KPiA+
ID4gPiAgCWludAkJCW1heF9saW5rX3NwZWVkOw0KPiA+ID4gPiAtLQ0KPiA+ID4gPiAyLjM3LjEN
Cj4gPiA+ID4NCj4gPiA+DQo+ID4gPiAtLQ0KPiA+ID4g4K6u4K6j4K6/4K614K6j4K+N4K6j4K6p
4K+NIOCumuCupOCuvuCumuCuv+CuteCuruCvjQ0KPiANCj4gLS0NCj4g4K6u4K6j4K6/4K614K6j
4K+N4K6j4K6p4K+NIOCumuCupOCuvuCumuCuv+CuteCuruCvjQ0K

