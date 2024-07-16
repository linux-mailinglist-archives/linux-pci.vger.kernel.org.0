Return-Path: <linux-pci+bounces-10353-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3DB9320DF
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 09:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B24381C20DF7
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 07:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF05196;
	Tue, 16 Jul 2024 07:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="MO3WUidm"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa13.fujitsucc.c3s2.iphmx.com (esa13.fujitsucc.c3s2.iphmx.com [68.232.156.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C254208A7
	for <linux-pci@vger.kernel.org>; Tue, 16 Jul 2024 07:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.156.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721113515; cv=fail; b=c4huWg9jz+9ZyORj1C4iA8qrHVsOWQpFNwx8ejqoKBz4VPIrGg70tPAT58Jy09WO3D7L7zfnWR5CiaD9/ax3SFJ5s7/XnK1ku9MVgI4woR5as5/v90sLDkz48mmgThZBCgmMW8I0kzVgXAuwDeSDBUygshyo20+dY11W14gTtJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721113515; c=relaxed/simple;
	bh=f/VEOjGqqEM1KLk2Ko6uyYR5j/U0kYDyxdZD14awac8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a2mUrqiDQIh9K2vHoolQhL0bxlXbEcw7gJwsYTXMbJz4xq8UklxxOhuDMGwxu29te/dIWigGKrrd+z13qMC5NQNhfPvQWv1C5R9w/Daw08EZxvdQTevjG9g+Qh2Y1GidaBh5cKY7MS7z/reUV4CgE0BObFERPhoMP0wRbKKWSMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=MO3WUidm; arc=fail smtp.client-ip=68.232.156.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1721113512; x=1752649512;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=f/VEOjGqqEM1KLk2Ko6uyYR5j/U0kYDyxdZD14awac8=;
  b=MO3WUidmTVkI9ImRJ6rHye4DASEZJPK2AA+pPvjFDXrkGfPYyp6OyKmA
   BuhMGaotTahdr82FHdlOVY6DpQnwYiOebNvBU+N/56oF0tCH/mYE/FJWH
   8PKeJwyHvfHe+W+v7w8spaaYbd4s4WGBmBsor4oLAd9il18bgJepkB9l0
   9NG979EiCBEvDP0AxrlRk0bV+RhkOgKqwnRGJjSRkJ50zJrgISgOLi9Q4
   J6b6Xzoh69jGzypFEATIktfNN5gYuz2WHfkG7mXH0GyyroRRennVRiUOm
   SuJvJmIb25V0mf2B01lewOPDCnQ/U8wsa5pU2Ndse33T9fh/JhlYxOzHk
   Q==;
X-IronPort-AV: E=McAfee;i="6700,10204,11134"; a="124781507"
X-IronPort-AV: E=Sophos;i="6.09,211,1716217200"; 
   d="scan'208";a="124781507"
Received: from mail-japaneastazlp17010004.outbound.protection.outlook.com (HELO TY3P286CU002.outbound.protection.outlook.com) ([40.93.73.4])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2024 16:05:03 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JutrM1JRAl/yc2H89wbZ6pyj1vdO/SriNDsmGpk3wGsXDq0x6zPVgzQexisIX6rBv77/us/jzSJSuoDbj9eQsgZOSCUXLPLOpn+kMR87q/NNbLL/MqS+Itu1s3J1410hObWyeXiOJRA67pmX2Ya5bfkg5bQoBfTvrNdNJeqgnkw/n1pnAoIdJuL37NfErroJrzAr2hZXyuSGgkTG8n2pyghWfwtvsTurWREqQR6oJf+VD+nj+n/ol98YjMEd/655J8/zwOQ7EOOONUsNGNTeMd9qggfTYkBrTtzxGrtmqr2D8wpA79dh5QjvgmoKN5LRPQdGs6jB6cXPFSe8OPpDnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f/VEOjGqqEM1KLk2Ko6uyYR5j/U0kYDyxdZD14awac8=;
 b=HMAwC1JgocPrEIQiTBXlhe2OZtqi/PnpC+4fiWyzgp2GNMJO1ym7ujD7FNSanfHp7vEApBq3hO6dEW0+yxjilS4LVn7Aw6tu9FgFBbGnHN9qYROyJXQIGwXmNUjFslVYhFUlbBShf794gXyLRH1jICnYjCLSK/k/XCungcZhly+/h9OTszafHlVqMtzx233oO+m+fkT12xdApm7ApKpbhHGuF5hNOW8VINtWeEb77teaLiuhxAJe9nUok9HR4ecm5PpZLydjT+0p+bl6LXINR/FG085rlkUEwOAolqD7N9eZQwBQAm2fFmgQMquBSa4ARqRpC4bIjCniKw54kXRQ4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSAPR01MB7182.jpnprd01.prod.outlook.com (2603:1096:604:141::5)
 by TYCPR01MB6208.jpnprd01.prod.outlook.com (2603:1096:400:7b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Tue, 16 Jul
 2024 07:04:59 +0000
Received: from OSAPR01MB7182.jpnprd01.prod.outlook.com
 ([fe80::357a:7bf5:8d95:3cba]) by OSAPR01MB7182.jpnprd01.prod.outlook.com
 ([fe80::357a:7bf5:8d95:3cba%5]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 07:04:59 +0000
From: "Daisuke Kobayashi (Fujitsu)" <kobayashi.da-06@fujitsu.com>
To: =?utf-8?B?J0tyenlzenRvZiBXaWxjennFhHNraSc=?= <kw@linux.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [RFC PATCH v1] Export PBEC Data register into sysfs
Thread-Topic: [RFC PATCH v1] Export PBEC Data register into sysfs
Thread-Index: AQHax4L+i4Kp4u4qEEmK0TgyfRRzXbHv4xSAgAkfqVA=
Date: Tue, 16 Jul 2024 07:04:58 +0000
Message-ID:
 <OSAPR01MB718231921A414BE66FDFA555BAA22@OSAPR01MB7182.jpnprd01.prod.outlook.com>
References: <20240626044330.106658-1-kobayashi.da-06@fujitsu.com>
 <20240710110519.GA3949574@rocinante>
In-Reply-To: <20240710110519.GA3949574@rocinante>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 =?utf-8?B?TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5Njgw?=
 =?utf-8?B?MmZfQWN0aW9uSWQ9OWQzYzExNTEtMjk5MS00YjA5LWI2MjYtYzlhN2UxMjFl?=
 =?utf-8?B?MmY0O01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMz?=
 =?utf-8?B?OTY4MDJmX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQx?=
 =?utf-8?B?LTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX01ldGhv?=
 =?utf-8?B?ZD1Qcml2aWxlZ2VkO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFk?=
 =?utf-8?B?NTUtNDZkZTMzOTY4MDJmX05hbWU9RlVKSVRTVS1QVUJMSUPigIs7TVNJUF9M?=
 =?utf-8?B?YWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfU2V0?=
 =?utf-8?B?RGF0ZT0yMDI0LTA3LTE2VDA2OjI1OjA2WjtNU0lQX0xhYmVsXzFlOTJlZjcz?=
 =?utf-8?B?LTBhZDEtNDBjNS1hZDU1LTQ2ZGUzMzk2ODAyZl9TaXRlSWQ9YTE5ZjEyMWQt?=
 =?utf-8?Q?81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSAPR01MB7182:EE_|TYCPR01MB6208:EE_
x-ms-office365-filtering-correlation-id: 1d0b09a0-f4ca-4665-ef24-08dca5659aed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?utf-8?B?SlBmdzAxTzcyVURPWVJJT0hZWkcvYnhDcmluTlF0M1p5b1Rkc1hoLzZuYk1P?=
 =?utf-8?B?UE85NEZ3Y04zZWNkOHArekdLSG9WQmVIZ0JxcE5NRGtBMkFWbHB2aUxHVHl2?=
 =?utf-8?B?Q21uZFdvZ3hPY3BEWEN0cHN5S0NraTJBUGtXRFVWZThLRDRCVkk1Sk5sNmYy?=
 =?utf-8?B?QUhuQllhazBBSUNUdUNFQXVTWTlvK3BIY01NK2VPZjVaWW5oTStzM3FBeW5V?=
 =?utf-8?B?ZkNHWlZ5ZHNtMC9rU3Z5aXgvVVVQZG9WQVNJaThtVm9vVWlsNmNxckI5T3Zm?=
 =?utf-8?B?V2drUzZ2bGtuL2kzVkRyMmdnUjNIVzREbGpFWWE2ODNSczUvelBYQmZIQ3Vl?=
 =?utf-8?B?RG51UEdsZTRReUdvZ1FsMno1ekFiWVVKZTVsb1hlYmo2d0p5eEtzQ2V1V3Nm?=
 =?utf-8?B?UzMraU52Ky9NWVFxY3RKQmpDb2Y2aURCSDB3NzZ4TnA1VUJQUGphMEV3anJP?=
 =?utf-8?B?N2hmbVhUd2JvdzNxVENKa2I0WW56VjZsVVBpUnllSGNaWFpWZW1vZ1B3SmFh?=
 =?utf-8?B?QlFNc2N0d3pNQ3BENVFseEpoMXdEWDJtN2tEd1dRK2w3V3Z2VkwwUDROUzlG?=
 =?utf-8?B?NHFYMUZMZk5FMnVVVWRuaXNPU2VMUURJdnQ0bFdEekV1MDN2SjhySDkrNndV?=
 =?utf-8?B?eXlSTXA2MTVScXJRSU56ZEdtQ2d1aERPVGFxMzI2ZjQwVjQ3V2tYcDNoM1Rx?=
 =?utf-8?B?OEV4RUNXTkZDMzB2VitzbDUzNXk4aC9LbWRvaEVOVDFMNUVFUmtlUGQxcEly?=
 =?utf-8?B?VU45Q29ybmpZcXp5WFR1Z2Rndys1WlhnSG9CN21JM1N2Z0ViSmxsaStrNUpj?=
 =?utf-8?B?WXJ2SHBkem5SZXl0WjNQS0FUOVdVZGFYRFRydmpZV0tlZWlmUHVCSkJWcFBL?=
 =?utf-8?B?eG9JMXdCQVJxdGs4SEVVd0R0dWY0c01wRjFLSmN4R1ZMQ3Bham0wSVdUN21H?=
 =?utf-8?B?SURhQjNTdUNHV2J1NXUyM0ZXUzJVREMxRklXalJwbExqZjI1Nk5vanNHMkV2?=
 =?utf-8?B?STVKYzd1d0Y2cWVYU2ZtY2hRYzNydGZzUlY1d25BNUE3cW9adG93ZUJzWFB5?=
 =?utf-8?B?TVFuNGdid0t6K1ozc2VVbjNZSmk3ZHNJS3dPbzRZdkUrYmp6ckVlMUVuUFlt?=
 =?utf-8?B?T24zVFhETmJoa3dQSVRCRVcxVG1oTjFON2NHTE54bk9UelM5NThTTmNPQktk?=
 =?utf-8?B?dC9zSVh5aUFFZlloRmFxdENSdUxBdEF6NThmMVZrQ0FsMUsyWXNFQlRROG95?=
 =?utf-8?B?V1VBdWlheGFoWEFkYW9BOCtBaXdKbGl3NlZDd2prOFpndnpaMUFpNDA4a3dI?=
 =?utf-8?B?VnpBNFBRaWxsaWkyWklOWEJPbSsxNGRBWVlveVNtQURGc1hRazBYdE9LOFA0?=
 =?utf-8?B?cElpWnZFOWR1TzhTeUIyWHp4SDJhQzRoQVJlRHA4bHR0NERDR0xiS0dLR3Bn?=
 =?utf-8?B?blp5b1ZicEdhZGJiY0JBSDdQeHE4cDcrYVdFVm1VUndBcWZ2SDdnS3BnVGtW?=
 =?utf-8?B?RnpOMkdyUHJ5eit6cSthS25JV000OXB6N1hTWU43a0pTMkVKY0QxNkZUbDAy?=
 =?utf-8?B?OWFOU0grUWFVdUZhNERnRG5td0tOMU80ODE3WWRFbHdkV3hFUlpkeUxnU29Z?=
 =?utf-8?B?V200cEgrRlBZb2grNEFyUS9BdUZ4ZUdHdnJhQ2V4cmZxUmU4NVNITUo1NUF2?=
 =?utf-8?B?NytWNEs0SFpSanF5bnhPdWhzc2I4NnFEOGVCUVVNSWx6dktaWHc0WC9mRUo0?=
 =?utf-8?B?Vy9SMGJKS2kvcjltekhBMEtWM3lMcnVtRlR1SFErTGRaZzJJc1oxdzhkS3Rw?=
 =?utf-8?B?OWpSS3BickdIczFFdWFCWUtGVlhlQlNhN3YvOUQycXVMbzNNU3VuUkJLd1Zh?=
 =?utf-8?B?RFdpS1lPUmRHS2JmdVYrbnV1b1VYQzNqTk9ManNnNkQ3MDRudllLNWVDemlp?=
 =?utf-8?Q?lzW8KY9ZDaw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB7182.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Zkd6Y3lYbHF5ejJOQndmRVVORCtzOGJaRXlUNncyR1BpMUhhMlNOd2VySlV1?=
 =?utf-8?B?U29QY29CZUN0VE9kRVl6d1NjWmcva014QmF1dFYwOTdGZ2pYeUNzZ3gvYlp5?=
 =?utf-8?B?OVIzN0hCMTFzNlZBUjJFUUc5TUZvK0x5RkFzaHNoTmRnaW4wdEMwM3RCbE5k?=
 =?utf-8?B?MDJDd2Flc1Qrd2V1KzlXcmJ0UmtNQ2dEMTNOdi8ycy9KSDBML0Frb2hUdWlP?=
 =?utf-8?B?UzlqWWdHM0hBekdxZ0FVWE1Rb0p6U2R0SnJXeWt2THYzSDA1c2JXZjlkWitV?=
 =?utf-8?B?NUNOLy9TbXBCei9QMzZWU0N5VGpMaWIwUHhTOWtzVTkrdGlndGMrTGtPUEZP?=
 =?utf-8?B?eFRmRFhSTFV6U1FEN2ExWHhrOFJNS0M4NU5ZcDEzYnp0WktOdHIxYkEyZ1p4?=
 =?utf-8?B?WUxXT1JHZG1DaktHZnpsRkwraHVyUDVwRUVyNjVQb1pseStLdkFZM2V3aVY1?=
 =?utf-8?B?QU9SU0Y4c2UyZis5K3NRSnNBTWRLYWNQdDd2REtid2NvcEFkcGIrVVdZcm54?=
 =?utf-8?B?N2MreGo2ZENIaE9peTRUUjJPRXliZVVoNS83NmdIUitmVG91Y3B2NTJMaVgy?=
 =?utf-8?B?ZGZLSVFrclRKOEw5OE9wRWpqclJkYkl0dXQwODVxa1VFbDlGVCtLYjU3dzRo?=
 =?utf-8?B?TVF0OHIvbUVyMXdoYXNtUEdMUlBkTFVVOHJMa0Y0OEZrUmxIN1ZMRHVPVE1Y?=
 =?utf-8?B?OWwrcHFVV3ptRzFGQWQvLzhZZmtQK1FwaGlDK29Ick16bmVQMFcxbnJEM1ZQ?=
 =?utf-8?B?emFPUW5PdytCTVNFZCsvSThwSFQzOXRmcWE3cFNrRXRMeWhuOVQ2K0U4cHJt?=
 =?utf-8?B?T3JEQlptWkUrQ01mM3FPRGwydStYWkYzWXh3MElJc0tlUGJCamQyQXM5Z0or?=
 =?utf-8?B?ekhGNGFuR2FUT2ZNbmEvNE5jdkRvT2tnUkJtWHRnUXZrTmJoM09wem9ZS1Rk?=
 =?utf-8?B?YjdhTG84NXpXSEkxV1Rici82NXpIbkc2Z0dHeGc4b0JMeUx6Zno0cUZMT2dw?=
 =?utf-8?B?WWJEZ3Y2WEI0WXlmelo2LytPM1RXUzNFazc2V3BkMThaOHFTME5NTE4xdDU2?=
 =?utf-8?B?NE5xTkdaRjh2eFJEbWlESEcrazViLzdxdFdXVytaa1NIRzY5ZFlwZk5OeGtO?=
 =?utf-8?B?SWs1YXJTSit5eWZPTmtzSjk4MEkrUFJqUmN0Qy9mRzIvcXVzL2Z5L3Mvb1l4?=
 =?utf-8?B?a0k1YWx3VDJvRGdnVHpKcmpES2RRQlg5Ui9KNDFTcTdQWW9maTBWaWQ2RnRS?=
 =?utf-8?B?RWViMDRnZHJpNmxHSjkwUVlPbUVFNTFuZ0xvL2dsRUdwVW1Gb29yZ2QxVitD?=
 =?utf-8?B?ZDJqenNzVWhNWlJFNjZzNmQ1Q3NvY0VEY053UUY5bWUvUHZBaFpCUVdpcUhR?=
 =?utf-8?B?RUVvcUE1TFltalNYb1dlWkk2VEZqenRIa0o1bSttUDdMMnlOTzBIRHFJOGFi?=
 =?utf-8?B?cU5DSFIvRHphL1cwaGFPWFRlVm52bitQQjBuelhnQkY0bEZpaGdFMTJsbTFO?=
 =?utf-8?B?N3JOSUpOQlNEVFU2RGVmaCsxL1E3ODFSOGhTdlZQSnFtc2liTXM4QkhVK0Fy?=
 =?utf-8?B?VkZldmpReWVNVnVrLzZqejl4L0tDL1JmN0kxRDIrWkF2SlJPS2xZUU9PLy8z?=
 =?utf-8?B?dnU4TExqNTBPbE9GbWJxbjdaUjJ1U0svYjJoamJPTys0eXNielh4VjNnNldq?=
 =?utf-8?B?TXZqdXI3N0t2bHp6bjhIMWx6RG5Db3dkY0FnS0I5YU9hbE9nNG1BTEwzNXZO?=
 =?utf-8?B?V0F3c1E3UGlNSlZPZHRmdHBCSkR4ejNOQjlNbU5ZUk5aT3FzUGR3WHlDM1Fv?=
 =?utf-8?B?WkRUc2REYUVTU0xrQnB1bmpXeG5rWlZnNmJlVndrclVNdDIwOFRnNHBVaVVx?=
 =?utf-8?B?WUw1Zm4zQVhUcUlpYmhrc0Irc3BjWWI0Qldna2JOZ0svY3lDQW9adXNCWnRM?=
 =?utf-8?B?ZmxLVTV2VDRpTXJ2UExwQm5RZ2x4MVZtcXRUaERBSlZNR09QRkRka0tKTmRx?=
 =?utf-8?B?aFgvbWUrb0FkWDR6WUlTaWUxUW5Ec2hrbFZ4MUx4Y2I3Y3Btd0JMcHZYSHRI?=
 =?utf-8?B?b1BTMnNyZDBSNlJ1MjFabnNRWXNSTFl1a09kelYxT2c3NXVla3RWeGRLNk1U?=
 =?utf-8?B?aytsVTRXeWFZWVdjRWh0bVpVMGFrUmNHMzJOQ1NWOVdUZUhJSG4xNEJWTUt6?=
 =?utf-8?B?Y1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ledk6XTOXBAzZTRVdz28C6jL6ImI0Eb/ozzT9Vgr4lA6UDuRUvB/0cngrTqDDVnF/TiD76B0Nmg2ZLqsM0UHn67MHnTGknSMW82iJ3LlyCO2dbobwusNWnqviMbGJKWnpwm20J7jdg7y4RkroJl/wg0/J5apkkCynoiTFWjhNMZm39uUDEmCwmItr2siB3cPIjsnIh1U3lPaxEuK2aiHAP2zd8+QrmEdVv30M43S79rPdpJOvbNCIwEBgzaHKvYMQ/tynbxYqd5yx2Syi5fQ6fuPfsPOBTe5dlCgfwW8VKmmppClgNi9KURPIOQ8xBc273wH+wBWe8ANZ92tr18c1TYNQQUAoNSwT3eddHL+r5eG+ZJFqXvl50LA4map+ZIV3XY1/pNKhf1iJVrk72fq5D+edIPYnvWB5EFPkQcZg5LyqG6tMV132sUk16et3WE7TBI5p5YAJoX6zbHtG5U+1lVhBwfZb24sfLduw7C8RD5m3qwW2/Y8g6N1fUx+7CVg1aebxbz0RN7+bShDpfXehbouiGlRzullxwQFq/cD0fE50peq9086WpyJ/nOXCAx3psVlB4ufmnRpFC3A9DG6KszgCHway2kJIO1SVjW3wo+bUAbEz8Wz9DQJPtey9Bm0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB7182.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d0b09a0-f4ca-4665-ef24-08dca5659aed
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2024 07:04:58.9288
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WRXmzM3GzIlWMizd12wsPLxfrkmACaW8lpdI7IGr89+f5sMEmTx0AEJveqZhwMrYvD1YJo9pn+EA/XRN+HmW5q1cesO976qdVKalh1pxPew=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6208

S3J6eXN6dG9mIFdpbGN6ecWEc2tpIDxrd0BsaW51eC5jb20+IHdyb3RlOg0KPiBIZWxsbywNCj4g
DQo+IFsuLi5dDQo+ID4gUENJZSBkZXZpY2VzIGNhbiBzaWduaWZpY2FudGx5IGltcGFjdCB0aGUg
b3ZlcmFsbCBwb3dlciBjb25zdW1wdGlvbiBvZg0KPiA+IGEgc3lzdGVtLiBIb3dldmVyLCBvYnRh
aW5pbmcgUENJZSBkZXZpY2UgcG93ZXIgY29uc3VtcHRpb24gaW5mb3JtYXRpb24NCj4gPiBoYXMg
dHJhZGl0aW9uYWxseSBiZWVuIGRpZmZpY3VsdC4gVGhpcyBpcyBiZWNhdXNlIHRoZSAnbHNwY2kn
IGNvbW1hbmQsDQo+ID4gd2hpY2ggaXMgYSBzdGFuZGFyZCB0b29sIGZvciBkaXNwbGF5aW5nIGlu
Zm9ybWF0aW9uIGFib3V0IFBDSSBkZXZpY2VzLA0KPiA+IGNhbm5vdCBhY2Nlc3MgUEJFQyBpbmZv
cm1hdGlvbi4gYGxzcGNpYCBpcyBhIHN0YW5kYXJkIHRvb2wgZm9yIGRpc3BsYXlpbmcNCj4gPiBp
bmZvcm1hdGlvbiBhYm91dCBQQ0kgZGV2aWNlcy4NCj4gDQo+IFdpbGwgeW91IGFsc28gYmUgbWFr
aW5nIGNoYW5nZXMgdG8gdGhlIHBjaXV0aWxzIHByb2plY3QgdG8gZXhwb3NlIHRoaXMNCj4gdXNp
bmcgdGhlIGxzcGNpIHV0aWxpdHk/DQo+IA0KWWVzLCBJJ20gY29uc2lkZXJpbmcgbWFraW5nIGNo
YW5nZXMgdG8gdGhlIHBjaXV0aWxzIHByb2plY3QgdG8gZXhwb3NlIHRoaXMgDQppbmZvcm1hdGlv
biB1c2luZyB0aGUgbHNwY2kgdXRpbGl0eS4NCg0KPiBUaGF0IHNhaWQsIHdlIGFscmVhZHkgZXhw
b3NlICJjb25maWciIHN5c2ZzIG9iamVjdCwgd291bGQgdXNpbmcgaXQgd29yayB0bw0KPiBvYnRh
aW4gdGhlIGRhdGEgeW91IG5lZWQ/DQo+IA0KSSBjb25zaWRlcmVkIHJlYWRpbmcgZnJvbSBhIGNv
bmZpZyBmaWxlLCBidXQgc2luY2UgdGhpcyByZXF1aXJlcyB3cml0aW5nIHRvDQpjb25maWd1cmF0
aW9uIHNwYWNlLCBJIGZlZWwgaXQgd291bGQgYmUgYmV0dGVyIHRvIGltcGxlbWVudCBpdCBpbiBh
IGtlcm5lbCBkcml2ZXIuDQoNCj4gPiArc3RhdGljIHNzaXplX3QgcGJlY19zaG93KHN0cnVjdCBk
ZXZpY2UgKmRldiwgc3RydWN0IGRldmljZV9hdHRyaWJ1dGUgKmF0dHIsDQo+ID4gKwkJCSBjaGFy
ICpidWYpDQo+ID4gK3sNCj4gPiArCXN0cnVjdCBwY2lfZGV2ICpwY2lfZGV2ID0gdG9fcGNpX2Rl
dihkZXYpOw0KPiA+ICsJc2l6ZV90IGxlbiA9IDA7DQo+ID4gKwlpbnQgaSwgcG9zOw0KPiA+ICsJ
dTMyIGRhdGE7DQo+ID4gKw0KPiA+ICsJaWYgKCFwY2lfaXNfcGNpZShwY2lfZGV2KSkNCj4gPiAr
CQlyZXR1cm4gMDsNCj4gDQo+IFRoaXMgaXMgbm90IG5lZWRlZCwgSSBiZWxpZXZlIHRoZSAiaXNf
dmlzaWJsZSIgY2FsbGJhY2sgZm9yIHRoaXMgc3BlY2lmaWMNCj4gYXR0cmlidXRlcyBncm91cCBj
aGVja3MgZm9yIHRoaXMgYWxyZWFkeS4NCj4gDQo+ID4gKwlwb3MgPSBwY2lfZmluZF9leHRfY2Fw
YWJpbGl0eShwY2lfZGV2LCBQQ0lfRVhUX0NBUF9JRF9QV1IpOw0KPiA+ICsJaWYgKCFwb3MpDQo+
ID4gKwkJcmV0dXJuIDA7DQo+IA0KPiBJdCB3b3VsZCBiZSAtRUlOVkFMLCBjdXN0b21hcmlseS4g
IEkgc3VwcG9zZSwgdGhlIC1FTk9UU1VQUCBvciAtRU5PU1lTDQo+IGNvdWxkDQo+IGRvIHRvbywg
YnV0IG1vc3Qgb2YgdGhlIG90aGVyIFBDSSBzeXNmcyBvYmplY3RzIHJldHVybnMgLUVJTlZBTCBi
YWNrIHRvIHRoZQ0KPiB1c2Vyc3BhY2UgdG8gaW5kaWNhdGUgdGhhdCBzb21ldGhpbmcgaXMgd3Jv
bmcuDQo+IA0KPiA+ICsJZm9yIChpID0gMDsgaSA8IDB4ZmY7IGkrKykgew0KPiANCj4gRG9lcyB0
aGlzIDB4ZmYgbmVlZCB0byBiZSBkb2N1bWVudGVkPyAgU29tZXRoaW5nIHNwZWNpZmljIHRvIHRo
ZSBQQkVDDQo+IGZlYXR1cmU/DQo+IA0KVGhpcyBhc3N1bWVzIHRoZSBtYXhpbXVtIHZhbHVlIG9m
IHRoZSBpbmRleCwgYnV0IHRoZSBtYXhpbXVtIHZhbHVlIGlzIG5vdA0Kc3RhdGVkIGluIHRoZSBz
cGVjaWZpY2F0aW9ucy4gU2luY2UgRFNSIGlzIGFuIDgtYml0IHJlZ2lzdGVyLCB0aGUgbWF4aW11
bSB2YWx1ZQ0KaXMgYXNzdW1lZCB0byBiZSAweGZmIGFuZCBzZXQgYXMgdGhlIGxvb3AgY291bnQu
DQpXb3VsZCBpdCBiZSBiZXR0ZXIgdG8gZGVmaW5lIGl0IGFzIGEgY29uc3RhbnQ/DQoNCj4gPiAr
CQlwY2lfd3JpdGVfY29uZmlnX2J5dGUocGNpX2RldiwgcG9zICsgUENJX1BXUl9EU1IsICh1OClp
KTsNCj4gPiArCQlwY2lfcmVhZF9jb25maWdfZHdvcmQocGNpX2RldiwgcG9zICsgUENJX1BXUl9E
QVRBLA0KPiAmZGF0YSk7DQo+ID4gKwkJaWYgKCFkYXRhKQ0KPiA+ICsJCQlicmVhazsNCj4gDQo+
IFdlIHNob3VsZCByZXR1cm4gYW4gZXJyb3IgaGVyZSwgc29tZXRoaW5nIGxpa2UgLUVJTlZBTCBw
ZXJoYXBzLg0KPiANCj4gPiArCQlsZW4gKz0gc3lzZnNfZW1pdF9hdChidWYsIGxlbiwgIiUwNHhc
biIsIGRhdGEpOw0KPiA+ICsJfQ0KPiA+ICsNCj4gPiArCXJldHVybiBsZW47DQo+IA0KVGhhbmsg
eW91IGZvciB5b3VyIHJldmlldy4NCkkgd2lsbCBmaXggYW55IGVycm9ycyBvciB1bm5lY2Vzc2Fy
eSBwcm9jZXNzaW5nIGluIHRoZSBuZXh0IHBhdGNoLg0KDQo+IEhvdyBmcmVxdWVudGx5IGRvIHlv
dSB0aGluayB0aGlzIG5ldyBzeXNmcyBvYmplY3Qgd291bGQgYmUgYWNjZXNzZWQ/ICBJdCdzDQo+
IG5vdCB1bmNvbW1vbiBmb3IgdGhlIFBDSSBjb25maWd1cmF0aW9uIHNwYWNlIGFjY2VzcyB0byBi
ZSBzbG93IGZvciBzb21lDQo+IGRldmljZXMuDQo+IA0KTXkgY3VycmVudCBhc3N1bXB0aW9uIGlz
IHRoYXQgaXQgaXMgYWNjZXNzZWQgd2hlbiBsc3BjaSBpcyBydW4sIHNvIEkgZG9uJ3QgdGhpbmsN
Cml0IGlzIGFjY2Vzc2VkIHZlcnkgb2Z0ZW4uDQoNCj4gVGhhbmsgeW91IQ0KPiANCj4gCUtyenlz
enRvZg0KDQpUaGFuayB5b3UhDQo=

