Return-Path: <linux-pci+bounces-26499-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E32A98412
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 10:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C49C179F00
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 08:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16201A0BC9;
	Wed, 23 Apr 2025 08:50:17 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11021139.outbound.protection.outlook.com [52.101.129.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3A1535D8;
	Wed, 23 Apr 2025 08:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745398217; cv=fail; b=A8ND/BNJQTwZio4YwDzmqsYWF9F2g4xWFZg3uPIHG1Yh1N3WSda5ig/bLCRgCeIkfMQy/+a42Cz/g7K8ENfLgZmigZ8GEmYe0kKl2zLgkznqk5lh74YypvFFoc/VbKqp8BjF8xRNYw6F8akxnnBRJVbvq/550CfKELvThYQii4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745398217; c=relaxed/simple;
	bh=ogsZZp/qoYJdV1aFczbB71wxwETevm473HHp9eBf3Bs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kqVtj7JZOeFwxLGG08ESLnfAOtijtAHrsNl8EO5rLg/fwZRLnZpmgBzP8Xm5Exie4kehPfhhBqDi2D1LB6QUFGHD1xIuQhrHTBdcIMpNF9+DET50M0cNWfJWQuJnevXnaEjeCISyhlvodVQC59IUsQg7dNW+tc7vAPRFQ0L0rIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.129.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pz/rid/wtMLgr4KOLnj/K7g5vxn6/qJzsj5EvEqpoe4jWq89FG3pxyVcYxDgy8z3gE961ZtvxN500saTFSsx0DZG/5y3WlkLcMrtXXA+Ss3P7A5vm9jfIt0bGuwKepl/8zo6il03kch3usaLuzEb5hqF2/6Qr7lKVbsMUpRDtDcj0rhJ3YzRe8cRqb5hO+289j4npN1caxp/EaKMnTeRk+840avEdH4Ui+GfHoZg8aSlxv1LJFJ4YmQA1S2xC+kwyIpVufbuaXvdn5yjX0NEHlFjO/Bimvoz20XDoZHZorshPeoZpL0qwMaJCQkwdk6ZdyECiOnFacl+oyyzQ6OKUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ogsZZp/qoYJdV1aFczbB71wxwETevm473HHp9eBf3Bs=;
 b=rqzTj6S+8Z6iHm09o5b6A01WHuQ4NzdS5dYY5pnXKKTDNdClQzeMqNq6rp63OmSgYuPvytIA0484Yt1wZqviTJdal1wzgr6UEOxffjM9ogbE3ngrZjzXle05AWvfA4B8nKTKqzSFmgGs/6P4zMExcgOB4tHTGLypGJ4GtKItYzz+4KvNbMxfPuL749Af2ENvsi1zVfbp1CRdcN7SAIeSKNghF9C1aHwieU5NDUblm5+KnmO+coMmOtPliaam+IiKiT3FH2KKpXeS+zprzL3BKwpScFZCbV1oBo0w2O49pXk9XMgESHSTw8iuYSgze3Y1D6sYkzR/2zWmc9vsngLVtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cixtech.com; dmarc=pass action=none header.from=cixtech.com;
 dkim=pass header.d=cixtech.com; arc=none
Received: from PUZPR06MB4715.apcprd06.prod.outlook.com (2603:1096:301:b6::9)
 by PS1PPF5540628D6.apcprd06.prod.outlook.com (2603:1096:308::24e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Wed, 23 Apr
 2025 08:50:10 +0000
Received: from PUZPR06MB4715.apcprd06.prod.outlook.com
 ([fe80::e2a0:7ecd:8694:bf1a]) by PUZPR06MB4715.apcprd06.prod.outlook.com
 ([fe80::e2a0:7ecd:8694:bf1a%6]) with mapi id 15.20.8678.021; Wed, 23 Apr 2025
 08:50:09 +0000
From: Hans Zhang <Hans.Zhang@cixtech.com>
To: Christian Bruel <christian.bruel@foss.st.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kw@linux.com" <kw@linux.com>,
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
	"robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "mcoquelin.stm32@gmail.com"
	<mcoquelin.stm32@gmail.com>, "alexandre.torgue@foss.st.com"
	<alexandre.torgue@foss.st.com>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "thippeswamy.havalige@amd.com"
	<thippeswamy.havalige@amd.com>, "shradha.t@samsung.com"
	<shradha.t@samsung.com>, "quic_schintav@quicinc.com"
	<quic_schintav@quicinc.com>, "cassel@kernel.org" <cassel@kernel.org>,
	"johan+linaro@kernel.org" <johan+linaro@kernel.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject:
 =?gb2312?B?u9i4tDogW1BBVENIIHY4IDAvOV0gQWRkIFNUTTMyTVAyNSBQQ0llIGRyaXZl?=
 =?gb2312?Q?rs?=
Thread-Topic: [PATCH v8 0/9] Add STM32MP25 PCIe drivers
Thread-Index: AQHbtChhrch5nTp+iU+X7sglcKEOxrOw8FVw
Date: Wed, 23 Apr 2025 08:50:09 +0000
Message-ID:
 <PUZPR06MB4715A6E6E2452BEA648B99D29DBA2@PUZPR06MB4715.apcprd06.prod.outlook.com>
References: <20250423081051.3907930-1-christian.bruel@foss.st.com>
In-Reply-To: <20250423081051.3907930-1-christian.bruel@foss.st.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cixtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR06MB4715:EE_|PS1PPF5540628D6:EE_
x-ms-office365-filtering-correlation-id: 0c8ca781-af0f-4731-d207-08dd8243da7b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|7416014|7053199007|921020|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?MGZqUkpaT0FjNDl5dWwwWWdHclA1Uk1YdUNjWThCbVhLR1NJN0dYNUVCZnQ0?=
 =?gb2312?B?YXJJRWFBb0dqdE4rVUNDNmNEWkU5MUFibGVMeUxrWkw0Y2E1WmdnU3JKTTFG?=
 =?gb2312?B?SGRwRW91b1Y0SHZTRFd3WU05d0hONXg3dVVraXJ6RHNFVDVXc1RvdkRiekx2?=
 =?gb2312?B?U2loSDMwTnhHYk04SUliSXUrQWJabTFFT1BiOTZsT1FYZEh2R2g3OVhGb1NB?=
 =?gb2312?B?Rm9JVm5BNFh3SjJoVzZrRElhT0c5SUt1VGN1Q2dnaHhLQTVjSm1FanBFZ2Vv?=
 =?gb2312?B?Vkh0bkRUcFY3Vm12OGREOWV0VW02cFY1QmorVjdNVTUvejFXc1BSUG5yTnNY?=
 =?gb2312?B?NWdVQ3J1K05tMGhjdGtMSkl2VlpMOVRkeUhxS3l0ZHNLaSsySHBmdm1XS29Y?=
 =?gb2312?B?dXhiOStOaWlOVzRKRzRPaTRUeTZXZEtsTEE0eCtuSTJVbFNZV3hCcFB2NXBQ?=
 =?gb2312?B?NUdPR3E4cmZzWE9JYXRucDdVUlY3RmRDdjJlY0J3NTJnTmZTMm9JSXl5TVdX?=
 =?gb2312?B?Z0ZhNEpYeTBOOHhITXRLTVFTUXBBTjFHSHkrbVF2NGFPZUxTbVg5T0UrQ2FU?=
 =?gb2312?B?bEwzL3hnZmszaURUbFJoSFd4cUo4bk5ienB4UzNSZk5qZGRpWGdaTlA4ZnhW?=
 =?gb2312?B?bURzRlJXY1c1UUViMklBcU5xRlBYUElVUXRSa0VtSWZIa3dQTHlUSEJrTXk0?=
 =?gb2312?B?ZWhHcis0TERkc3UrSUdrOGw2YlhIamdoRWxSOSs0YnBmVG8ycjJTR1dyTjVY?=
 =?gb2312?B?b250TFhlQlpoTGRzN2EvUjVMZ0x2OTRzM0RLcGhvWW1tRnFmT3N6VXZqYnN4?=
 =?gb2312?B?VFlmMXg4VTMvc001dFZNL0dQcG1vck9hSDQyL2N1RGQ2SEhZK1BsZDZqWjBj?=
 =?gb2312?B?VVJ1dkxCVlJYU3VHb1VZQVpkWkpPakJidEhRbm02eFFjM29VVVpSbWsyU1JQ?=
 =?gb2312?B?N3ppcG9YM2MwVk1QY2FJRFhCQ0pEcUhSa1ZYTDRLbEtUNDdINmdDbEhFanNj?=
 =?gb2312?B?Z3pzekEydXNGNW1sVUl2eTI4RXgwUHl1Vk5JaGRIQlZhU1NNSjU3SXlaSzNy?=
 =?gb2312?B?aytuMGk3UERvSGRWTnZPTUZNcEtkdDR0eG4vSVAwQWUwSWdTYk9BTXR6OElu?=
 =?gb2312?B?eXpaZ2M3V0V4VkdZVVNzVkhsNU9RbEg4My83R09lNmtrWUY4c1c0NTRZRE1D?=
 =?gb2312?B?bWR0dFFZbjhTNm42QVdVbU5TSHVPMFp2UUtUVFZ5K3o1ZnArdzdsUUNMVFpi?=
 =?gb2312?B?Szc0R1VRMjYrUms5NUhDSlJ2SE0yMjE1OHlMT2J1RzE1Yjd2cW9HZXlTYVcv?=
 =?gb2312?B?U1h4OUJmK1dvM3B3VlZ6bkdIdDZVRjhOQXVKL0NTZEVYZlhHemJkVDFtTXZl?=
 =?gb2312?B?bTVqTkp3QmR2MzI5K0d6bFd4eXlXUXhGdDlwQk1MSEJUNS9Fam5DamkrSUVH?=
 =?gb2312?B?NTBaOHJVbWdCdnBNNUVDSFlKWjV5OTF4MVJHZnA1WU5HcDlPYUJ4UmtIdzNs?=
 =?gb2312?B?dDR5aVVDVTFUVWNzQWc3clk1bGQwNjU3b1RUYWNyc2J1ZGFQdktDUEw0OXox?=
 =?gb2312?B?WUhReG5LSi9QTFlOT21KR3FjZ3VjOTZHNklJNldJTTVEL0pCanVBcUJYQXdm?=
 =?gb2312?B?VmpXNU91eFBYWU1kTkR2L2pSUDJvZklSQ2M3dTJ3d0JiZzRRNWVrK2d4cUhM?=
 =?gb2312?B?TGZFOUN1L1ZMdWZwZG5DZVJvYVArN2NOdzJ1SjFIaHphUUxRenZFR1JsZXl6?=
 =?gb2312?B?cjVURlVycWdvd3ZRZlVuMWRZU3MwaS85WFp0Y0VZUUJSRWw0bDQ3YmJuTjVz?=
 =?gb2312?B?TXFJU04rcG5XbG5rejJNU1hGVUJJcEZ6dFN2QjB2KzErR3hrSk52cU10MkFz?=
 =?gb2312?B?UXRYWW56RTUvTHpQOUlJQ08ycVBOYzUyOXRpQXF2TFdOcGFRTmlVcGN2ME1O?=
 =?gb2312?B?bkkzS294Zm9KNElzOHMzRGlDank4aVZ1dGt0aGJIcWZVcnJiR1VLaWtrUzBE?=
 =?gb2312?B?Z1Vmb1VUdmtYbURMZ2ZRZmxqQmw2cmxCS04xdFlicGlTcVltRFBnZzROQlVs?=
 =?gb2312?Q?J1F7m+?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB4715.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(7053199007)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?NmY2QzdMZWRUNWtWYlMxbjcrVnl0UmRTa2NZdGQrVi92YnU5bjF2TVVCTCs0?=
 =?gb2312?B?MnZFVGZKb2grTGhsNnlDTHpLSGZVVEJUajVBYklIcS9nSGh1YW1Ic0V4QnBS?=
 =?gb2312?B?QnJVWDNVNFVTMXFYcTVKVGtqbW1RUjJNQm9WaUxxczZRNWVxdXVYQlRYSkpl?=
 =?gb2312?B?aTFRZm03U08xOTJ5M0RkTEROSVM0MXloWWIwS0VhSjZvOE1sdjhOSytmc3lu?=
 =?gb2312?B?RnQ2Nm1ZbXNNekVyV0FsSGlIbk51THh5SDNpOGpZMWZFZWtmZ2NHR3Fsa2tJ?=
 =?gb2312?B?UkplSnFuUDZGc3EvS2g0Ri9lWTVrYkZUL1h3bTQxTzlneTN6QkE3M1VxSjQ2?=
 =?gb2312?B?MWtDTEFRTVk1bGNBSDVac2Z4NmxjWE5oN1puekRpQkkxbXN1OXZyQi92YUli?=
 =?gb2312?B?YlJpbzRRMWpnTDdKaHBrdEYwbGpVVEpkV2FKb1FSWjRsRFdERjFCL2RsOEpX?=
 =?gb2312?B?dU1HVGVPR3Zva0JpMVJIbjFGcTdiWEVCMVcraEEvV0I5NmdVY2pia2hweStp?=
 =?gb2312?B?b2tPWWhneG1SaGJDczVkbWZWVUEyclZIbHZabkdEcFo0VVhRR3dROThnRDNn?=
 =?gb2312?B?NGFieXdQU3B6YURFUWpDTWRHYU1mWHUzUU1rRTFjYjVSTDAydGhnQ2YvVEx4?=
 =?gb2312?B?MzlZR1JPY3JFeUEvY25NSDhCaHZ6OXZnbTNhWTczbTZQVHBtSi9MQzVodmlK?=
 =?gb2312?B?QWpoTUU3M0RWRkZNR2JzT3hleUdJM2d4dkRaQXVwczBPTHczN2NpVTFNc0ph?=
 =?gb2312?B?Y2VMVVdoOEpzYkpudUdZMEJ3UFVUd1l3VCtheFROQ1EvNmprWmRlSktSakVh?=
 =?gb2312?B?Z2NKTzRhaXdSUGgzbGtSMGtEQ3ZrRHBVQUduOWxGdFFhZlpLRVdRNXlKOHRa?=
 =?gb2312?B?b0VhS2V1SFllKy9Jcjh2VWozQzJNcXZDQmVrL243SG52TWZ3RVl1REVCWFhu?=
 =?gb2312?B?N0hUdlBNc0RQZjZ5RnpBaDluS0tyMmhEY0NIL0E4SjYxUmpDQUhtQ09rY2Vi?=
 =?gb2312?B?TGJsSHh1WFpXY1VoR1JnekVGRWhhbHFIcFFPL1VoOGlzR0luQmw0TFpGTUMx?=
 =?gb2312?B?VGVidUtlRXB2LzFIYkZCcFZiU1F3UVRtRE9UeEYreGtEenBLeHUvb05wMDR1?=
 =?gb2312?B?SVZldUJPNm1LMVFQMzM2UlI5bm5aTzZULzdWL1NQWm5VYjlMdkYvZDZQeGFO?=
 =?gb2312?B?ZDEwQjk2SGpJdmlFQUdrUHliQW9OdURJWXhRM1BzdUNBTHNqSW93QWphcGtQ?=
 =?gb2312?B?bXRZN243THVqdXg4TkwzY0toV0hxbG1ZOXB1cXdpRDhVaEhZSi85b2pjSG5E?=
 =?gb2312?B?emVSV2VkQVZKTjB2djBUSW9XTWlRclJnY2J0ekhXMzdrRHJTWGtPekVITVJG?=
 =?gb2312?B?Zit5aDVhZmNBak1BSHkvVjFmUU1NUWdzeW5DUUQvbzJNUXl1d2J4T0JOZDVI?=
 =?gb2312?B?aDM5YzFkRUhqaTFBcGJwdFUyUTFFV0gvSFRTSlRjb3IrTWdhamtmcGpNaVV1?=
 =?gb2312?B?aUpsZllZSnplTEc3L0R2aW4vK1NYbTUrK0Voai8rYVVYVFRpazFDVHdGeTZE?=
 =?gb2312?B?Ti8yZGo2dnlHZ0owSUc2RFg2TTVSRm14K2NQaXBydXo1aTBJK3IvMGF4akNm?=
 =?gb2312?B?NWJmSGZxeHowY1BUV0FHdGRaVC96cE9CSVFCSmludFgwRVA1VmduczZTNktk?=
 =?gb2312?B?aTZ4TTZtOTdWRzZBQ2FSM3VCSTJ1OUx4UlUzeVNxai9HR24wK1RiK3U5Zzgv?=
 =?gb2312?B?WUJWemFiYjJvQ3hMbjdaTkt6TjZReVNGMjQxQXZPaWRBWmxoTkJVWUxFNzRW?=
 =?gb2312?B?WHdmQVV2UEF3YlkxK1JSWG5MNGNwUTM3ZzVYK2ZwdE5KNzhXaUNPVDV2ekdW?=
 =?gb2312?B?ZDN5WkM3ZmhKSGFveXFqZ0svNUM4TG92cHk0WWVDRGg1Tnd6ZXJaYXV3SkJT?=
 =?gb2312?B?VXBJOE4wYVg3cVoyTDRvME9sU3RRQ2luOHBWaDFadmZHdXNUL0xabmFCRTI3?=
 =?gb2312?B?cUYwYXQvdkJHWURJejEwVDJQYURYci9PUTJCcFpzT29CWVNDcHpnbURxK3ZT?=
 =?gb2312?B?U2crT3Vld3BhaUp5S3dpMklDc3ZYOEtWNjA5c29ZalNlM3dOYjF0UmpjNFFE?=
 =?gb2312?Q?b0zq2rbfCw0I6eCiRv0jArVuq?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4715.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c8ca781-af0f-4731-d207-08dd8243da7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2025 08:50:09.6206
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GGiamYnNBKZyp5pLAunNdMWbofrOqS3oGzhyV+UKpfD1nFimkzrq72r2CBJkrcpYzSqf0iI7OtnGpLpEwM873Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1PPF5540628D6

DQoNCi0tLS0t08q8/tStvP4tLS0tLQ0Kt6K8/sjLOiBDaHJpc3RpYW4gQnJ1ZWwgPGNocmlzdGlh
bi5icnVlbEBmb3NzLnN0LmNvbT4gDQq3osvNyrG85DogMjAyNcTqNNTCMjPI1SAxNjoxMQ0KytW8
/sjLOiBjaHJpc3RpYW4uYnJ1ZWxAZm9zcy5zdC5jb207IGxwaWVyYWxpc2lAa2VybmVsLm9yZzsg
a3dAbGludXguY29tOyBtYW5pdmFubmFuLnNhZGhhc2l2YW1AbGluYXJvLm9yZzsgcm9iaEBrZXJu
ZWwub3JnOyBiaGVsZ2Fhc0Bnb29nbGUuY29tOyBrcnprK2R0QGtlcm5lbC5vcmc7IGNvbm9yK2R0
QGtlcm5lbC5vcmc7IG1jb3F1ZWxpbi5zdG0zMkBnbWFpbC5jb207IGFsZXhhbmRyZS50b3JndWVA
Zm9zcy5zdC5jb207IHAuemFiZWxAcGVuZ3V0cm9uaXguZGU7IHRoaXBwZXN3YW15LmhhdmFsaWdl
QGFtZC5jb207IHNocmFkaGEudEBzYW1zdW5nLmNvbTsgcXVpY19zY2hpbnRhdkBxdWljaW5jLmNv
bTsgY2Fzc2VsQGtlcm5lbC5vcmc7IGpvaGFuK2xpbmFyb0BrZXJuZWwub3JnDQqzrcvNOiBsaW51
eC1wY2lAdmdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgt
c3RtMzJAc3QtbWQtbWFpbG1hbi5zdG9ybXJlcGx5LmNvbTsgbGludXgtYXJtLWtlcm5lbEBsaXN0
cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQrW98ziOiBbUEFU
Q0ggdjggMC85XSBBZGQgU1RNMzJNUDI1IFBDSWUgZHJpdmVycw0KDQpFWFRFUk5BTCBFTUFJTA0K
DQp0aGlzIHBhdGNoIGRlcGVuZHMgb24gcGF0Y2gNCmh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5v
cmcvcHJvamVjdC9saW51eC1hcm0ta2VybmVsL2xpc3QvP3Nlcmllcz05NTM1NDUNCg0KQ2hhbmdl
cyBpbiB2ODoNCiAgIC0gV2hpdGVzcGFjZSBpbiBjb21tZW50DQoNCkhpIENocmlzdGlhbqOsDQoN
ClRoZSBzdWJqZWN0IG9mIGVhY2ggb2YgeW91ciBwYXRjaGVzIGlzIHN0aWxsIHY3Lg0KDQplLmcu
LA0KaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LXBjaS9wYXRjaC8y
MDI1MDQyMzA4MTA1MS4zOTA3OTMwLTItY2hyaXN0aWFuLmJydWVsQGZvc3Muc3QuY29tLw0KDQpC
ZXN0IHJlZ2FyZHMsDQpIYW5zDQoNCkNoYW5nZXMgaW4gdjc6DQogICAtIFVzZSBkZXZpY2VfaW5p
dF93YWtldXAgdG8gZW5hYmxlIHdha2V1cA0KICAgLSBGaXggY29tbWVudHMgKEJqb3JuKQ0KDQpD
aGFuZ2VzIGluIHY2Og0KICAgLSBDYWxsIGRldmljZV93YWtldXBfZW5hYmxlKCkgdG8gZml4IFdB
S0UjIHdha2V1cC4NCiAgIEFkZHJlc3MgY29tbWVudHMgZnJvbSBNYW5pdmFubmE6DQogICAtIEZp
eC9BZGQgQ29tbWVudHMNCiAgIC0gRml4IERUIGluZGVudHMNCiAgIC0gUmVtb3ZlIGR3X3BjaWVf
ZXBfbGlua3VwKCkgaW4gRVAgc3RhcnQgbGluaw0KICAgLSBBZGQgUENJRV9UX1BWUEVSTF9NUyBk
ZWxheSBpbiBSQyBQRVJTVCMgZGVhc3NlcnQNCg0KQ2hhbmdlcyBpbiB2NToNCiAgIEFkZHJlc3Mg
ZHJpdmVyIGNvbW1lbnRzIGZyb20gTWFuaXZhbm5hOg0KICAgLSBVc2UgZHdfcGNpZV97c3VzcGVu
ZC9yZXN1bWV9X25vaXJxIGluc3RlYWQgb2YgcHJpdmF0ZSBvbmVzLg0KICAgLSBNb3ZlIGR3X3Bj
aWVfaG9zdF9pbml0KCkgdG8gcHJvYmUNCiAgIC0gQWRkIHN0bTMyX3JlbW92ZV9wY2llX3BvcnQg
Y2xlYW51cCBmdW5jdGlvbg0KICAgLSBVc2Ugb2Zfbm9kZV9wdXQgaW4gc3RtMzJfcGNpZV9wYXJz
ZV9wb3J0DQogICAtIFJlbW92ZSB3YWtldXAtc291cmNlIHByb3BlcnR5DQogICAtIFVzZSBnZW5l
cmljIGRldl9wbV9zZXRfZGVkaWNhdGVkX3dha2VfaXJxIHRvIHN1cHBvcnQgd2FrZSMgaXJxDQoN
CkNoYW5nZXMgaW4gdjQ6DQogICBBZGRyZXNzIGJpbmRpbmdzIGNvbW1lbnRzIFJvYiBIZXJyaW5n
DQogICAtIFJlbW92ZSBwaHkgcHJvcGVydHkgZm9ybSBjb21tb24geWFtbA0KICAgLSBSZW1vdmUg
cGh5LW5hbWUgcHJvcGVydHkNCiAgIC0gTW92ZSB3YWtlX2dwaW8gYW5kIHJlc2V0X2dwaW8gdG8g
dGhlIGhvc3Qgcm9vdCBwb3J0DQoNCkNoYW5nZXMgaW4gdjM6DQogICBBZGRyZXNzIGNvbW1lbnRz
IGZyb20gTWFuaXZhbm5hLCBSb2IgYW5kIEJqb3JuOg0KICAgLSBNb3ZlIGhvc3Qgd2FrZXVwIGhl
bHBlciB0byBkd2MgY29yZSAoTWFuaSkNCiAgIC0gRHJvcCBudW0tbGFuZXM9PDE+IGZyb20gYmlu
ZGluZ3MgKFJvYikNCiAgIC0gRml4IFBDSSBhZGRyZXNzIG9mIEkvTyByZWdpb24gKE1hbmkpDQog
ICAtIE1vdmVkIFBIWSB0byBhIFJDIHJvb3Rwb3J0IHN1YnNlY3Rpb24gKEJqb3JuLCBNYW5pKQ0K
ICAgLSBSZXBsYWNlZCBkbWEtbGltaXQgcXVpcmsgYnkgZG1hLXJhbmdlcyBwcm9wZXJ0eSAoQmpv
cm4pDQogICAtIE1vdmVkIG91dCBwZXJzdCBhc3NlcnQvZGVhc3NlcnQgZnJvbSBzdGFydC9zdG9w
IGxpbmsgKE1hbmkpDQogICAtIERyb3AgbGlua191cCB0ZXN0IG9wdGltIChNYW5pKQ0KICAgLSBE
VCBhbmQgY29tbWVudHMgcmVwaHJhc2luZyAoQmpvcm4pDQogICAtIEFkZCBkdHMgZW50cmllcyBu
b3cgdGhhdCB0aGUgY29tYm9waHkgZW50cmllcyBoYXMgbGFuZGVkDQogICAtIERyb3AgZGVsYXlp
bmcgQ29uZmlndXJhdGlvbiBSZXF1ZXN0cw0KDQpDaGFuZ2VzIGluIHYyOg0KICAgLSBGaXggc3Qs
c3RtMzItcGNpZS1jb21tb24ueWFtbCBkdF9iaW5kaW5nX2NoZWNrDQoNCkNoYW5nZXMgaW4gdjE6
DQogICBBZGRyZXNzIGNvbW1lbnRzIGZyb20gUm9iIEhlcnJpbmcgYW5kIEJqb3JuIEhlbGdhYXM6
DQogICAtIERyb3Agc3QsbGltaXQtbXJycyBhbmQgc3QsbWF4LXBheWxvYWQtc2l6ZSBmcm9tIHRo
aXMgcGF0Y2hzZXQNCiAgIC0gUmVtb3ZlIHNpbmdsZSByZXNldCBhbmQgY2xvY2tzIGJpbmRpbmcg
bmFtZXMgYW5kIG1pc2MgeWFtbCBjbGVhbnVwcw0KICAgLSBTcGxpdCBSQy9FUCBjb21tb24gYmlu
ZGluZ3MgdG8gYSBzZXBhcmF0ZSBzY2hlbWEgZmlsZQ0KICAgLSBVc2UgY29ycmVjdCBQQ0lFX1Rf
UEVSU1RfQ0xLX1VTIGFuZCBQQ0lFX1RfUlJTX1JFQURZX01TIGRlZmluZXMNCiAgIC0gVXNlIC5y
ZW1vdmUgaW5zdGVhZCBvZiAucmVtb3ZlX25ldw0KICAgLSBGaXggYmFyIHJlc2V0IHNlcXVlbmNl
IGluIEVQIGRyaXZlcg0KICAgLSBVc2UgY2xlYW51cCBibG9ja3MgZm9yIGVycm9yIGhhbmRsaW5n
DQogICAtIENvc21ldGljIGZpeGVzDQoNCkNocmlzdGlhbiBCcnVlbCAoOSk6DQogIGR0LWJpbmRp
bmdzOiBQQ0k6IEFkZCBTVE0zMk1QMjUgUENJZSBSb290IENvbXBsZXggYmluZGluZ3MNCiAgUENJ
OiBzdG0zMjogQWRkIFBDSWUgaG9zdCBzdXBwb3J0IGZvciBTVE0zMk1QMjUNCiAgZHQtYmluZGlu
Z3M6IFBDSTogQWRkIFNUTTMyTVAyNSBQQ0llIEVuZHBvaW50IGJpbmRpbmdzDQogIFBDSTogc3Rt
MzI6IEFkZCBQQ0llIEVuZHBvaW50IHN1cHBvcnQgZm9yIFNUTTMyTVAyNQ0KICBNQUlOVEFJTkVS
UzogYWRkIGVudHJ5IGZvciBTVCBTVE0zMk1QMjUgUENJZSBkcml2ZXJzDQogIGFybTY0OiBkdHM6
IHN0OiBhZGQgUENJZSBwaW5jdHJsIGVudHJpZXMgaW4gc3RtMzJtcDI1LXBpbmN0cmwuZHRzaQ0K
ICBhcm02NDogZHRzOiBzdDogQWRkIFBDSWUgUm9vdGNvbXBsZXggbW9kZSBvbiBzdG0zMm1wMjUx
DQogIGFybTY0OiBkdHM6IHN0OiBBZGQgUENJZSBFbmRwb2ludCBtb2RlIG9uIHN0bTMybXAyNTEN
CiAgYXJtNjQ6IGR0czogc3Q6IEVuYWJsZSBQQ0llIG9uIHRoZSBzdG0zMm1wMjU3Zi1ldjEgYm9h
cmQNCg0KIC4uLi9iaW5kaW5ncy9wY2kvc3Qsc3RtMzItcGNpZS1jb21tb24ueWFtbCAgICB8ICAz
MyArKw0KIC4uLi9iaW5kaW5ncy9wY2kvc3Qsc3RtMzItcGNpZS1lcC55YW1sICAgICAgICB8ICA2
NyArKysNCiAuLi4vYmluZGluZ3MvcGNpL3N0LHN0bTMyLXBjaWUtaG9zdC55YW1sICAgICAgfCAx
MTIgKysrKysNCiBNQUlOVEFJTkVSUyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
fCAgIDcgKw0KIGFyY2gvYXJtNjQvYm9vdC9kdHMvc3Qvc3RtMzJtcDI1LXBpbmN0cmwuZHRzaSB8
ICAyMCArDQogYXJjaC9hcm02NC9ib290L2R0cy9zdC9zdG0zMm1wMjUxLmR0c2kgICAgICAgIHwg
IDU3ICsrKw0KIGFyY2gvYXJtNjQvYm9vdC9kdHMvc3Qvc3RtMzJtcDI1N2YtZXYxLmR0cyAgICB8
ICAyMSArDQogZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvS2NvbmZpZyAgICAgICAgICAgIHwg
IDI0ICsNCiBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9NYWtlZmlsZSAgICAgICAgICAgfCAg
IDIgKw0KIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtc3RtMzItZXAuYyAgICB8IDQx
NyArKysrKysrKysrKysrKysrKysNCiBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLXN0
bTMyLmMgICAgICAgfCAzNzAgKysrKysrKysrKysrKysrKw0KIGRyaXZlcnMvcGNpL2NvbnRyb2xs
ZXIvZHdjL3BjaWUtc3RtMzIuaCAgICAgICB8ICAxNiArDQogMTIgZmlsZXMgY2hhbmdlZCwgMTE0
NiBpbnNlcnRpb25zKCspDQogY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9wY2kvc3Qsc3RtMzItcGNpZS1jb21tb24ueWFtbA0KIGNyZWF0ZSBtb2Rl
IDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL3N0LHN0bTMyLXBj
aWUtZXAueWFtbA0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvcGNpL3N0LHN0bTMyLXBjaWUtaG9zdC55YW1sDQogY3JlYXRlIG1vZGUgMTAwNjQ0
IGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtc3RtMzItZXAuYw0KIGNyZWF0ZSBtb2Rl
IDEwMDY0NCBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLXN0bTMyLmMNCiBjcmVhdGUg
bW9kZSAxMDA2NDQgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1zdG0zMi5oDQoNCi0t
DQoyLjM0LjENCg0KDQo=

