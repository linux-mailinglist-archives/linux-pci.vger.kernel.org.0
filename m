Return-Path: <linux-pci+bounces-25829-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE69A8804B
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 14:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49DC6189546E
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 12:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACE3286A1;
	Mon, 14 Apr 2025 12:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WKsSK+Km"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B941E505;
	Mon, 14 Apr 2025 12:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744633411; cv=fail; b=R2n/oDn5/AsQA7ou8vhl+G10cAoyxPQSoYS8+7TwR+08DSGeUR9ioqs22/dcLG+Ov6BllN3gpGCgb0BYlcFmMssQAtRJ/z1ZhE1mqOnIzq950EbGTSLpVYJ/+mzc0rufiu2cLv0sfc4dXbIvJdBZysbxznkKF6wkQF0WbFeJeLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744633411; c=relaxed/simple;
	bh=8+NpMNCNWvzcCwl9jGSZ3tWskbIsKZtXhNlCznjssDY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OPtcSDsbkrtLwa6rklEtJdeCxFvZVDnIdYm7/8mzxClXanONJqZk1sBIW5L2KPAi2BJ46YkBo8twy8Ybn5a4JTJ+LEbOjIfVo5AbuvX/WNmL3MC6CG0dHzQU87WIxBzu1XWspaqe+47CtaHmuDqtGnJizun0+LXh4kCyqmq7rpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WKsSK+Km; arc=fail smtp.client-ip=40.107.236.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jwElEDR4G75QJDpYygOe+InysMaid8Oge6nJ0agAiimR2h3Uj7RM3OiZJ+tVqEuFfS5f/K99ebL2uT5HGoC7YNPeGhPgO/Xm5vGFI3P0+xd4gyi6hcVYENoXrlFtYLNyOCnjiyFD+JMetjvCsEifvnhrMl/gqCvgicwUODIrfq0MX2ShLohG9GFrhDWJbXBOEqvQAFecDslVA4iZuOcIqjMgaQnI/qKHSnpjc8UnEgLu+8tIRywrrjcUyHg5wOJ38ccA8Oa9/tpD94OL9u5Dr2UAYxPr7iA/31NCA2qf4OlqzU6BiUTEwpWmIXsUJ8Am/PrGkbaFveeFAlhyRUD9zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8+NpMNCNWvzcCwl9jGSZ3tWskbIsKZtXhNlCznjssDY=;
 b=qPC1s6/e81r5QvPyummMSnX+pA5o6055hUiucwNjwknKBn4olFqQECLUPhfzFC5u/l0Kw8BQrcXY9BVMo1dRjFNMyapP/92peSqKoqHnPT+LZG7NfleBiJUcT8WanDGDs58uVoa+G4ah+5sbBXPwzFcX4yonJ7kugUnEZ2uQcAP7pO+WjglPFN7jTeZkbqyfdc6iG0CfpGr1QeuGZ3Zjd65xmZOHAWZLjaRe/HUire1jPKgSRuXf+mwuuPviUsdX/kc+0iO+W1cggmhq6xOuV3Xwk+vX4yDzqka5dmz3CK1wElnMAqMrRFfKk5wHHfOYtV7dJYmm4y6kTiMQWGtt1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+NpMNCNWvzcCwl9jGSZ3tWskbIsKZtXhNlCznjssDY=;
 b=WKsSK+KmZ9k6IJDCEOCrV7nJ749nqNxY/9N7S5W1f9i0ZCuIkz9xV+n6lslISHrCCyP0keWYicsf2TtXWVgPzP6qcQ++LPJGqn/GA19xl22656E5/N/TQUFaN6WpU26N58COWvcL5mrqiuhB9nr+3DpLZgLTnxZs0TZ7dPyWI5o=
Received: from IA1PR12MB6140.namprd12.prod.outlook.com (2603:10b6:208:3e8::16)
 by IA1PR12MB6210.namprd12.prod.outlook.com (2603:10b6:208:3e6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.28; Mon, 14 Apr
 2025 12:23:26 +0000
Received: from IA1PR12MB6140.namprd12.prod.outlook.com
 ([fe80::92c9:cc21:f1dd:abec]) by IA1PR12MB6140.namprd12.prod.outlook.com
 ([fe80::92c9:cc21:f1dd:abec%7]) with mapi id 15.20.8632.036; Mon, 14 Apr 2025
 12:23:26 +0000
From: "Musham, Sai Krishna" <sai.krishna.musham@amd.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kw@linux.com" <kw@linux.com>,
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"cassel@kernel.org" <cassel@kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Simek, Michal" <michal.simek@amd.com>,
	"Gogada, Bharat Kumar" <bharat.kumar.gogada@amd.com>, "Havalige, Thippeswamy"
	<thippeswamy.havalige@amd.com>
Subject: RE: [RESEND PATCH v7 1/2] dt-bindings: PCI: xilinx-cpm: Add `cpm_crx`
 and `cpm5nc_fw_attr` properties
Thread-Topic: [RESEND PATCH v7 1/2] dt-bindings: PCI: xilinx-cpm: Add
 `cpm_crx` and `cpm5nc_fw_attr` properties
Thread-Index: AQHbrOyiG1HeLApj8U6pHK3ZPQFrqrOivGoAgABRrwA=
Date: Mon, 14 Apr 2025 12:23:26 +0000
Message-ID:
 <IA1PR12MB6140D67181ED0003799228DACDB32@IA1PR12MB6140.namprd12.prod.outlook.com>
References: <20250414032304.862779-1-sai.krishna.musham@amd.com>
 <20250414032304.862779-2-sai.krishna.musham@amd.com>
 <20250414-naughty-simple-rattlesnake-bb75bb@shite>
In-Reply-To: <20250414-naughty-simple-rattlesnake-bb75bb@shite>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=16f878da-984d-4775-8ccb-8112f5bc9302;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-14T11:54:27Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB6140:EE_|IA1PR12MB6210:EE_
x-ms-office365-filtering-correlation-id: 00305e43-7789-4e78-8591-08dd7b4f2832
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?L213UWdHRXlxQzZCNXRLbjgrTWloUEthOE1aOW0vVWVleDBTWTJqM2Uyc2o2?=
 =?utf-8?B?UWE5dC9ydW5GUFY5UDF3UW0vMENEdWR4UFlLLzZES3ppRUJHVmNWVUxqbzBN?=
 =?utf-8?B?aG1xL3QzNkh2ay9VZ29DR05qbnVNcEFodklKQWIxQ1lvTEFtUnFTSUplRUNx?=
 =?utf-8?B?dlJYQmlJK28wVTh5OStsZEVPd1QxMkJkTHJPREszRmk0clFlMkpmc0YzSnNF?=
 =?utf-8?B?cjFZWTJyRjY5eitvcE9ITFRkRTZiNWxqQjhEYXZkcHVuTHhxYzd1SU9Ja3pJ?=
 =?utf-8?B?eHJnVzBjWXIvcmczL3BYSG0xU25OUHNlWUZJQUVETFI1dkQ4aXMwTmRRN0F0?=
 =?utf-8?B?bVJLM0M0QXI0UEc3UTI3S0YxVjAyRkJybFdEdHpPa0JhUktiSm5YNE1mOTJW?=
 =?utf-8?B?MDN2Y3FYSCsyZ0lUUGFRNmlEbVlndXkxSDBlMWpFdk84M2tESHV6eGI2VFZO?=
 =?utf-8?B?bElsUW4rRG13RW1tb1RwVTIydXlEWFFITmFFRk8yRVdxWTByNXREdE5hR0JD?=
 =?utf-8?B?bnAzb2hmYjIyaE0vL3ZuaFdkZm1TTGJ6ZVlINWRMN29BbXBMUXpzUjJNZk02?=
 =?utf-8?B?T2RaVEtCa2hxYnBVSm1kcUNFNkcwUnZocTkyazJrSHBOK1M1dFNsbU8zcS9R?=
 =?utf-8?B?dUdVTVpIYjJzTExRT2cvUS9XZmtONElYcm5IM1MvZmRaTFBWais3YmhSZm80?=
 =?utf-8?B?YUFaRlFDZXVJNkIvTWJyRVBER1JOWGJTWkhteHZjWklsVjA1UkFyeHFKNmxo?=
 =?utf-8?B?aVdrZ25sdWRRN0VmaldWTWVhOXdGcDNxaFNCL2xRdXNGajkzc25jdWlUSGVi?=
 =?utf-8?B?ZHZmbUtsSzY4TjhlUTN2OUtCYjRzR3hwaUdubVBMVVVIaW14WXZwcDNTMWJB?=
 =?utf-8?B?aXlTWSsrTE1xYlVrZUFTZVRJajFQcTcyYnVnaWxycEhhZDd6ZWVTMGkzVFpG?=
 =?utf-8?B?YXdlWGl6WVNmS0gybW5xVFo1UnF2ZzNsVVRXZjZJOEdHZTVncm1FRWhFbXJC?=
 =?utf-8?B?YjFNM29aUEcrUTlmTXN3UW54eDRXV1p0aUVHbzAzYWJ6aGp3RXBuVEEwOGJl?=
 =?utf-8?B?MWxRd1ZWdGo4Lzh6OVJUalozby9VY3Y0RkgyNGpFS0xCTEozUmliYzRZZE5l?=
 =?utf-8?B?WTdQMUxBRVdtN3dMZit5R211Y2kzdGtBT3ErZWJha0JMT1RUWk1aY0FyRXFF?=
 =?utf-8?B?elI5dWg4UG9lWGNjOWttNEJlTEVvaEVEUVJCbVhFZVc3RitUdXFlNkU0cmVv?=
 =?utf-8?B?ZDdibWFGWXNoK1ErWlowczNFVjJtczU5WlE0VDZLS2F4SzRCR0p6UzRNZFlN?=
 =?utf-8?B?RmVJQzc4T3RDM1U5SjJlNVRZUE5JYlhBNTlwTktMVG91U3dWUjcwYkNoc0Rt?=
 =?utf-8?B?MmxOeE1kT01pU1Y5bDRhTW1GMUFkNitNN09tb25XQkJIZ0toNWdWWmRGR0Q3?=
 =?utf-8?B?U3VtS2VpK1dXQmNCdEZFeStRQUtnb0dabnRYZUYxUjFwcmlWVVZTcDdhZzI1?=
 =?utf-8?B?RDRjQlVDSk9ZZjRGNzFFYWx5WUZETk9KQVJZTWZnZWc5QXErdmRzNDlRc01w?=
 =?utf-8?B?ZmFtNVBWTTBvTDBJOXJtNDYvcnVQSlNCbGZvK0ZUenp6aTdNYmxzb1VJdHRu?=
 =?utf-8?B?OXJaZ25KbnJvbHozbS9MVk5zTitwNUNYT2NIUWEwYUtHQTJDbjhweXQyc0M4?=
 =?utf-8?B?dFZwTklKdnk1KzcxTFZnYjVJd3RZYS9ReEhhUGM3ak5FMk5XcTdHZ2psYk50?=
 =?utf-8?B?cmVjUlVtMXN0NEs0M3N0V0V5eTU5c0tvdGZWMEcxcndEY0lYVW9mRk55Tnp4?=
 =?utf-8?B?Q1YvREpyZzVlZ2JWUjhLUm1LTzdtUmxWYm1GTFl1Z0VaU3FlVm9qN3pkY1l6?=
 =?utf-8?B?dWJscjZDWXd2MkN2ZWlmVmZUT3Z2ZXVyNkNPeG9rNitaZkN4dExnUmxLUWp0?=
 =?utf-8?B?NUNGTlUyN3drdklXTFVJNlJHNE02TjdUdFozUEtxdU1HQkQyakQvZmFlZi9h?=
 =?utf-8?B?aXJ1ZnFaMzJ3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6140.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cDVYblFvOUJpcFlTTk5vWjVYNEJEbFk0MVVDaXhPRXB3R0REWTZGb25TS3VX?=
 =?utf-8?B?bitOa3FCYVEybzducjdJY244c21zUW5JYlJqaVRieEJSeHNtaVhkUXpsRk9J?=
 =?utf-8?B?bW5rMG9IeTVGRjBDM0NOVVBVM1F0WkYvR0xoS3JDSXV5Rm8zMGRhSmdpajFp?=
 =?utf-8?B?a3FiVy9YVVQ5QnZUK2pHUVNvRTV1UVk5YzdzUFJBWjAyay9JQm0rRUhBNXFO?=
 =?utf-8?B?TCtNSnNtSmhrK1VwNTYrMEo2ZXFGSEFvQkdOTVJ0NFFsNTVZSlNMTGswUGxy?=
 =?utf-8?B?M0dHWkt5bCtISnBIZVlDVXVoaTJrc3NWQ2VRZ0VEaVU5empUVTJoQU1FSCtW?=
 =?utf-8?B?dVJrY3ppcEh6RzJJd2xkL1hLaktQRFJYRHpWT0c4VWZmUklQMGd5WWVacThJ?=
 =?utf-8?B?dWRLdXExZU9FVWVkb2RwcDBpYW1kUy9YRGg1U211d2FQM3RPL0lwNjExM3k4?=
 =?utf-8?B?U1hTNTBXcWFVdUppSEpOWWJISDdkbXp1T1J0bkxFMUhPd3FxZ1RyeU9GUy9x?=
 =?utf-8?B?Mk9JVWZaN3Z0U0YyTVBFUGVKamlIejhDS25qSENqYmtCelcxekpPRmRyVWFN?=
 =?utf-8?B?WTRobncrdStoVG02SzhtSThZYUFEbjA2YVpWa0FhT0Z0U241QjV1bWtGNmtK?=
 =?utf-8?B?UFNYVlJnczdldEIrcENncDBpNldOY3Qva2xab3VrVWIxVjNvUXZuL01MMzVr?=
 =?utf-8?B?bml5Ri9mTTQwOFRVMmY4bm52UVFqVndqaDc2a3l2K0lJb210K05oaUFEUzRx?=
 =?utf-8?B?LzEvUVBSQjUrNlkxZ0J3Y0tCZWQ3Tmt1TWJ2R0VobE5kR0ZCQUdBL0pVQzJ6?=
 =?utf-8?B?UlNPcGpweFF0ZDFjY0N3alNpN1Nlc0lCWTVkVmFFTE9uVGhWZXc3dThlaGpv?=
 =?utf-8?B?UUtOV0dXZXJFUGpWcElLVWYyMklPdW5rNFhHMUdUK0tETk9BemIwY1lYWVY3?=
 =?utf-8?B?MENOL1ovNWc0Q2FFVFRoeUtMVTJDSHE2V0NhcExId3JCZ2lXUFM1NFlYSmtJ?=
 =?utf-8?B?eERSMExRUGxya1REakVSWFdYbWo5aExzRDVzRC8vdmlWSHN1N2JVQ3pkUUJq?=
 =?utf-8?B?Q2tUbFJIY2U5OUl0SmVnaE52bEtRWlpiTE5BN1ZoVGVNVHdxOW52T2t2TmVS?=
 =?utf-8?B?U1hjR3VoWUdYWU5uM0w0c2RZaWlVSTRSWU45dUNVbWYvNEdlbnRuUGNNVVpG?=
 =?utf-8?B?TTRrZlFtNHdEalYzUThrTE44cGRTeUZZRmZrRWpuSHA1V3AxY1lybTlFdDN4?=
 =?utf-8?B?ck55R3dielhwc1RWSWhpNlA2S0k1MXh6M0lxcG1HMXNrQXlPZlowUzNZTVRB?=
 =?utf-8?B?emdON0VGZ3JOTVdRQ0R0V3B5WU5rNmlrVmk5ZTBEU3dyNkJqbnM1bTljUktR?=
 =?utf-8?B?MUE1elVIK3hRU2h6bHJPZmNIbC84eUJWc01qTEZPbFFpd0lhMDBDRkpOWENT?=
 =?utf-8?B?aXQvT2luVlpqamk4eHJYYlpaNnMwUm9WeUZRb1BzMUd6dy8vOGRDbS9ZQS8z?=
 =?utf-8?B?U21uNDU3M3ZTVUlOc2Q1ekJPM09wVjVjRnUyM2lVeGxXMExUVlROai9TRHNC?=
 =?utf-8?B?L0hrSVJseFE0MGdJbVQrVjVQNkpKcklmclJ0VFd1b0pQQTJqb0tYL1dDNGw0?=
 =?utf-8?B?Um1FL1JVK1BWVVZlcVR6Zy9DVlRwSklTaDlCS21jWTRES0hvYmwyeVdaQmw4?=
 =?utf-8?B?T0VKekh0eEM4MUNGeTNPUm1scGF6Slc4SmUyOUdYNjVNbnRwbVRsSi81WUdr?=
 =?utf-8?B?RHd3N3E1bHBwaHd4Zks3MVhXcG04YzJlR1JVVHFIYnhVVWFLa0pDYU5WeGFZ?=
 =?utf-8?B?Nmg1V0JGSkEzY0xVd1o3bTVRSmVBaitEQnd4dlEvK1VlaXA5aFkrWWVHdHlU?=
 =?utf-8?B?SFpwcG1PK2J4YXhYeEVrRlB4NnVoWGpKK2pSRlRHYkJBbGhzYW1GWkdWVHlI?=
 =?utf-8?B?NWJkbVJLdXoyMzJyV2pmOHJPckN5emlSckZoY08rcEtlWmNvK08yd3ZPZUFC?=
 =?utf-8?B?U0hOaWJmSkI0Zy9pQkNGMlI5aEQrK0NRaE9LMXFHSlovNlExeTVvS2hNZ2gz?=
 =?utf-8?B?QXlxV0hXMXE5Wm5Mb1UxRlJzSTN5VDd4OWsxb0cwZkFjS1V2aDluUTdsbTI0?=
 =?utf-8?Q?43BY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6140.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00305e43-7789-4e78-8591-08dd7b4f2832
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2025 12:23:26.3279
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KLDkBjzaTkelduuPXc4Fy7HLPCKhurzvCgydQjGMlPjweLiN8KRijWqDF+lbiRxK5FkaRmdz2zM0iCuZzf1oEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6210

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KSGkgS3J6eXN6dG9mLA0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXcuDQoNCj4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6a0BrZXJu
ZWwub3JnPg0KPiBTZW50OiBNb25kYXksIEFwcmlsIDE0LCAyMDI1IDEyOjMyIFBNDQo+IFRvOiBN
dXNoYW0sIFNhaSBLcmlzaG5hIDxzYWkua3Jpc2huYS5tdXNoYW1AYW1kLmNvbT4NCj4gQ2M6IGJo
ZWxnYWFzQGdvb2dsZS5jb207IGxwaWVyYWxpc2lAa2VybmVsLm9yZzsga3dAbGludXguY29tOw0K
PiBtYW5pdmFubmFuLnNhZGhhc2l2YW1AbGluYXJvLm9yZzsgcm9iaEBrZXJuZWwub3JnOyBrcnpr
K2R0QGtlcm5lbC5vcmc7DQo+IGNvbm9yK2R0QGtlcm5lbC5vcmc7IGNhc3NlbEBrZXJuZWwub3Jn
OyBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9y
ZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgU2ltZWssIE1pY2hhbA0KPiA8bWljaGFs
LnNpbWVrQGFtZC5jb20+OyBHb2dhZGEsIEJoYXJhdCBLdW1hcg0KPiA8YmhhcmF0Lmt1bWFyLmdv
Z2FkYUBhbWQuY29tPjsgSGF2YWxpZ2UsIFRoaXBwZXN3YW15DQo+IDx0aGlwcGVzd2FteS5oYXZh
bGlnZUBhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1JFU0VORCBQQVRDSCB2NyAxLzJdIGR0LWJp
bmRpbmdzOiBQQ0k6IHhpbGlueC1jcG06IEFkZCBgY3BtX2NyeGANCj4gYW5kIGBjcG01bmNfZndf
YXR0cmAgcHJvcGVydGllcw0KPg0KPiBDYXV0aW9uOiBUaGlzIG1lc3NhZ2Ugb3JpZ2luYXRlZCBm
cm9tIGFuIEV4dGVybmFsIFNvdXJjZS4gVXNlIHByb3BlciBjYXV0aW9uDQo+IHdoZW4gb3Blbmlu
ZyBhdHRhY2htZW50cywgY2xpY2tpbmcgbGlua3MsIG9yIHJlc3BvbmRpbmcuDQo+DQo+DQo+IE9u
IE1vbiwgQXByIDE0LCAyMDI1IGF0IDA4OjUzOjAzQU0gR01ULCBTYWkgS3Jpc2huYSBNdXNoYW0g
d3JvdGU6DQo+ID4gQWRkIHRoZSBgY3BtX2NyeGAgcHJvcGVydHkgdG8gbWFuYWdlIHRoZSBQQ0ll
IElQIHJlc2V0LCBhbmQNCj4gPiBgY3BtNW5jX2Z3X2F0dHJgIHByb3BlcnR5IHRvIGNsZWFyIGZp
cmV3YWxsIGFmdGVyIGxpbmsgcmVzZXQsIHdoaWxlDQo+ID4gbWFpbnRhaW5pbmcgYmFja3dhcmQg
Y29tcGF0aWJpbGl0eSB3aXRoIGV4aXN0aW5nIGRldmljZSB0cmVlcy4NCj4gPg0KPiA+IEFsc28s
IGluY29ycG9yYXRlIGByZXNldC1ncGlvc2AgaW4gZXhhbXBsZSBmb3IgR1BJTy1iYXNlZCBoYW5k
bGluZyBvZg0KPiA+IHRoZSBQQ0llIFJvb3QgUG9ydCAoUlApIFBFUlNUIyBzaWduYWwgZm9yIGVu
YWJsaW5nIGFzc2VydCBhbmQgZGVhc3NlcnQNCj4gPiBjb250cm9sLg0KPiA+DQo+ID4gVGhlIGBy
ZXNldC1ncGlvc2AgYW5kIGBjcG1fY3J4YCBwcm9wZXJ0aWVzIG11c3QgYmUgcHJvdmlkZWQgZm9y
IENQTSwNCj4gPiBDUE01IGFuZCBDUE01X0hPU1QxLiBGb3IgQ1BNNU5DLCBhbGwgdGhyZWUgcHJv
cGVydGllcyAtIGByZXNldC1ncGlvc2AsDQo+ID4gYGNwbV9jcnhgIGFuZCBgY3BtNW5jX2Z3X2F0
dHJgIG11c3QgYmUgZXhwbGljaXRseSBkZWZpbmVkIHRvIGVuc3VyZQ0KPg0KPiBUaGlzIHdlIHNl
ZSBmcm9tIHRoZSBkaWZmLCBidXQgd2h5IHRoZXkgbXVzdCBiZSBkZWZpbmVkPw0KPg0KPiA+IHBy
b3BlciBmdW5jdGlvbmFsaXR5Lg0KPg0KPiBXaGF0IGZ1bmN0aW9uYWxpdHk/DQo+DQoNCkZvciBv
dXIgY29udHJvbGxlciwgaWYgY3BtX2NyeCBpcyBub3QgcHJvdmlkZWQgbGFuZSBlcnJvcnMgd2ls
bCBiZSBvYnNlcnZlZC4NClNwZWNpZmljYWxseSBmb3IgQ1BNNU5DLCBpZiBjcG01bmNfZndfYXR0
ciBwcm9wZXJ0eSBpcyBub3QgcHJvdmlkZWQsIHRoZSBmaXJld2FsbA0KaXMgbm90IGNsZWFyZWQg
YWZ0ZXIgcmVzZXQgYW5kIGZ1cnRoZXIgUENJZSB0cmFuc2FjdGlvbnMgd2lsbCBub3QgYmUgYWxs
b3dlZC4NClRoZXJlZm9yZSwgdGhlc2UgcHJvcGVydGllcyBtdXN0IGJlIGRlZmluZWQuDQoNCj4g
Pg0KPiA+IEluY2x1ZGUgYW4gZXhhbXBsZSBEVFMgbm9kZSBhbmQgY29tcGxldGUgdGhlIGJpbmRp
bmcgZG9jdW1lbnRhdGlvbiBmb3INCj4gPiBDUE01TkMuIEFsc28sIGZpeCB0aGUgYnJpZGdlIHJl
Z2lzdGVyIGFkZHJlc3Mgc2l6ZSBpbiB0aGUgZXhhbXBsZSBmb3INCj4gPiBDUE01Lg0KPiA+DQo+
ID4gU2lnbmVkLW9mZi1ieTogU2FpIEtyaXNobmEgTXVzaGFtIDxzYWkua3Jpc2huYS5tdXNoYW1A
YW1kLmNvbT4NCj4gPiAtLS0NCj4gPiBDaGFuZ2VzIGZvciB2NzoNCj4gPiAtIFVwZGF0ZSBDUE01
TkMgZGV2aWNlIHRyZWUgYmluZGluZy4NCj4gPiAtIEFkZCBDUE01TkMgZGV2aWNlIHRyZWUgZXhh
bXBsZSBub2RlLg0KPiA+IC0gVXBkYXRlIGNvbW1pdCBtZXNzYWdlLg0KPiA+DQo+ID4gQ2hhbmdl
cyBmb3IgdjY6DQo+ID4gLSBSZXNvbHZlIEFCSSBicmVhay4NCj4gPiAtIFVwZGF0ZSBjb21taXQg
bWVzc2FnZS4NCj4gPg0KPg0KPiAuLi4NCj4NCj4gPiArICAtIGlmOg0KPiA+ICsgICAgICBwcm9w
ZXJ0aWVzOg0KPiA+ICsgICAgICAgIGNvbXBhdGlibGU6DQo+ID4gKyAgICAgICAgICBjb250YWlu
czoNCj4gPiArICAgICAgICAgICAgZW51bToNCj4gPiArICAgICAgICAgICAgICAtIHhsbngsdmVy
c2FsLWNwbTVuYy1ob3N0DQo+ID4gKyAgICB0aGVuOg0KPiA+ICsgICAgICBwcm9wZXJ0aWVzOg0K
PiA+ICsgICAgICAgIHJlZzoNCj4gPiArICAgICAgICAgIGl0ZW1zOg0KPiA+ICsgICAgICAgICAg
ICAtIGRlc2NyaXB0aW9uOiBDUE0gc3lzdGVtIGxldmVsIGNvbnRyb2wgYW5kIHN0YXR1cyByZWdp
c3RlcnMuDQo+ID4gKyAgICAgICAgICAgIC0gZGVzY3JpcHRpb246IENvbmZpZ3VyYXRpb24gc3Bh
Y2UgcmVnaW9uIGFuZCBicmlkZ2UgcmVnaXN0ZXJzLg0KPiA+ICsgICAgICAgICAgICAtIGRlc2Ny
aXB0aW9uOiBDUE0gY2xvY2sgYW5kIHJlc2V0IGNvbnRyb2wgcmVnaXN0ZXJzLg0KPiA+ICsgICAg
ICAgICAgICAtIGRlc2NyaXB0aW9uOiBDUE01TkMgRmlyZXdhbGwgYXR0cmlidXRlIHJlZ2lzdGVy
Lg0KPiA+ICsgICAgICAgICAgbWluSXRlbXM6IDINCj4gPiArICAgICAgICByZWctbmFtZXM6DQo+
ID4gKyAgICAgICAgICBpdGVtczoNCj4gPiArICAgICAgICAgICAgLSBjb25zdDogY3BtX3NsY3IN
Cj4gPiArICAgICAgICAgICAgLSBjb25zdDogY2ZnDQo+ID4gKyAgICAgICAgICAgIC0gY29uc3Q6
IGNwbV9jcngNCj4gPiArICAgICAgICAgICAgLSBjb25zdDogY3BtNW5jX2Z3X2F0dHINCj4gPiAr
ICAgICAgICAgIG1pbkl0ZW1zOiAyDQo+DQo+IFdoeSBpbnRlcnJ1cHRzIGFyZSBub3QgcmVxdWly
ZWQgZm9yIHRoaXMgdmFyaWFudD8gV2h5IGlzbid0IHRoaXMgYW4NCj4gaW50ZXJydXB0IGNvbnRy
b2xsZXI/DQo+DQoNCk1TSSBhbmQgTVNJLVggaW50ZXJydXB0cyBhcmUgaGFuZGxlZCB2aWEgR0lD
LCBzbyBtc2ktbWFwIHByb3BlcnR5IGlzDQpyZXF1aXJlZCBmb3IgaW50ZXJydXB0IGhhbmRsaW5n
Lg0KTGVnYWN5IGludGVycnVwdCBzdXBwb3J0IGlzIG5vdCBhdmFpbGFibGUsIGFuZCBFcnJvciBp
bnRlcnJ1cHQgc3VwcG9ydCB3aWxsIGJlDQphZGRlZCBpbiBmdXR1cmUsIG9uY2UgaXQgaXMgYWRk
ZWQgY29ycmVzcG9uZGluZyBEVCBjaGFuZ2VzIHdpbGwgYmUgYWRkZWQuDQoNCj4gPg0KPiA+ICB1
bmV2YWx1YXRlZFByb3BlcnRpZXM6IGZhbHNlDQo+ID4NCj4gPiAgZXhhbXBsZXM6DQo+ID4gICAg
LSB8DQo+ID4gKyAgICAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvZ3Bpby9ncGlvLmg+DQo+ID4NCj4g
PiAgICAgIHZlcnNhbCB7DQo+ID4gICAgICAgICAgICAgICAgICNhZGRyZXNzLWNlbGxzID0gPDI+
Ow0KPiA+IEBAIC05OCw4ICsxNjUsMTAgQEAgZXhhbXBsZXM6DQo+ID4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgPDB4NDMwMDAwMDAgMHg4MCAweDAwMDAwMDAwIDB4ODAgMHgwMDAw
MDAwMCAweDANCj4gMHg4MDAwMDAwMD47DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgbXNp
LW1hcCA9IDwweDAgJml0c19naWMgMHgwIDB4MTAwMDA+Ow0KPiA+ICAgICAgICAgICAgICAgICAg
ICAgICAgIHJlZyA9IDwweDAgMHhmY2ExMDAwMCAweDAgMHgxMDAwPiwNCj4gPiAtICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICA8MHg2IDB4MDAwMDAwMDAgMHgwIDB4MTAwMDAwMDA+Ow0KPiA+
IC0gICAgICAgICAgICAgICAgICAgICAgIHJlZy1uYW1lcyA9ICJjcG1fc2xjciIsICJjZmciOw0K
PiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwweDYgMHgwMDAwMDAwMCAweDAgMHgx
MDAwMDAwMD4sDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPDB4MCAweGZjYTAw
MDAwIDB4MCAxMDAwMD47DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgcmVnLW5hbWVzID0g
ImNwbV9zbGNyIiwgImNmZyIsICJjcG1fY3J4IjsNCj4gPiArICAgICAgICAgICAgICAgICAgICAg
ICByZXNldC1ncGlvcyA9IDwmZ3BpbzEgMzggR1BJT19BQ1RJVkVfTE9XPjsNCj4gPiAgICAgICAg
ICAgICAgICAgICAgICAgICBwY2llX2ludGNfMDogaW50ZXJydXB0LWNvbnRyb2xsZXIgew0KPiA+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgI2FkZHJlc3MtY2VsbHMgPSA8MD47DQo+
ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAjaW50ZXJydXB0LWNlbGxzID0gPDE+
Ow0KPiA+IEBAIC0xMjYsOCArMTk1LDEwIEBAIGV4YW1wbGVzOg0KPiA+ICAgICAgICAgICAgICAg
ICAgICAgICAgIG1zaS1tYXAgPSA8MHgwICZpdHNfZ2ljIDB4MCAweDEwMDAwPjsNCj4gPiAgICAg
ICAgICAgICAgICAgICAgICAgICByZWcgPSA8MHgwMCAweGZjZGQwMDAwIDB4MDAgMHgxMDAwPiwN
Cj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8MHgwNiAweDAwMDAwMDAwIDB4MDAg
MHgxMDAwMDAwPiwNCj4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8MHgwMCAweGZj
ZTIwMDAwIDB4MDAgMHgxMDAwMDAwPjsNCj4gPiAtICAgICAgICAgICAgICAgICAgICAgICByZWct
bmFtZXMgPSAiY3BtX3NsY3IiLCAiY2ZnIiwgImNwbV9jc3IiOw0KPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIDwweDAwIDB4ZmNlMjAwMDAgMHgwMCAweDEwMDAwPiwNCj4gPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICA8MHgwMCAweGZjZGMwMDAwIDB4MDAgMHgxMDAwMD47
DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgcmVnLW5hbWVzID0gImNwbV9zbGNyIiwgImNm
ZyIsICJjcG1fY3NyIiwgImNwbV9jcngiOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIHJl
c2V0LWdwaW9zID0gPCZncGlvMSAzOCBHUElPX0FDVElWRV9MT1c+Ow0KPiA+DQo+ID4gICAgICAg
ICAgICAgICAgICAgICAgICAgcGNpZV9pbnRjXzE6IGludGVycnVwdC1jb250cm9sbGVyIHsNCj4g
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICNhZGRyZXNzLWNlbGxzID0gPDA+Ow0K
PiA+IEBAIC0xMzYsNCArMjA3LDIyIEBAIGV4YW1wbGVzOg0KPiA+ICAgICAgICAgICAgICAgICAg
ICAgICAgIH07DQo+ID4gICAgICAgICAgICAgICAgIH07DQo+ID4NCj4gPiArICAgICAgICAgICAg
ICAgY3BtNW5jX3BjaWU6IHBjaWVAZTRhMTAwMDAgew0KPiA+ICsgICAgICAgICAgICAgICAgICAg
ICAgIGNvbXBhdGlibGUgPSAieGxueCx2ZXJzYWwtY3BtNW5jLWhvc3QiOw0KPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgIGRldmljZV90eXBlID0gInBjaSI7DQo+ID4gKyAgICAgICAgICAgICAg
ICAgICAgICAgI2FkZHJlc3MtY2VsbHMgPSA8Mz47DQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgI3NpemUtY2VsbHMgPSA8Mj47DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgaW50ZXJy
dXB0LXBhcmVudCA9IDwmZ2ljPjsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBidXMtcmFu
Z2UgPSA8MHgwMCAweGZmPjsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICByYW5nZXMgPSA8
MHgyMDAwMDAwIDB4MDAgMHhhODAwMDAwMCAweDAwIDB4YTgwMDAwMDAgMHgwMA0KPiAweDgwMDAw
MDA+LA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwweDQzMDAwMDAwIDB4
MTAxMCAweDAwIDB4MTAxMCAweDAwIDB4MDggMHgwMD47DQo+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgbXNpLW1hcCA9IDwweDAgJml0c19naWMgMHg0MDAwMCAweDEwMDAwPjsNCj4gPiArICAg
ICAgICAgICAgICAgICAgICAgICByZWcgPSA8MHgwMCAweGU0YTEwMDAwIDB4MDAgMHgxMDAwMD4s
DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPDB4MDAgMHhhMDAwMDAwMCAweDAw
IDB4ODAwMDAwMD4sDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPDB4MDAgMHhl
NGEwMDAwMCAweDAwIDB4MTAwMDA+LA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IDwweDAwIDB4ZTQzMDEwMDAgMHgwMCAweDEwMDAwPjsNCj4NCj4gRm9sbG93IERUUyBjb2Rpbmcg
c3R5bGUuIE9yIGp1c3QgZHJvcCB0aGlzIGV4YW1wbGUuLi4gaXQgYWxzbyBoYXMNCj4gaW5jb3Jy
ZWN0IGluZGVudGF0aW9uLiA6Lw0KDQpPaywgSSB3aWxsIGRyb3AgdGhpcyBleGFtcGxlLg0KDQo+
DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgcmVnLW5hbWVzID0gImNwbV9zbGNyIiwgImNm
ZyIsICJjcG1fY3J4IiwgImNwbTVuY19md19hdHRyIjsNCj4gPiArICAgICAgICAgICAgICAgICAg
ICAgICByZXNldC1ncGlvcyA9IDwmZ3BpbzAgMjIgR1BJT19BQ1RJVkVfTE9XPjsNCj4gPiArICAg
ICAgICAgICAgICAgfTsNCj4gPiArDQo+ID4gICAgICB9Ow0KPiA+IC0tDQo+ID4gMi40NC4xDQo+
ID4NCg0KVGhhbmtzLA0KU2FpIEtyaXNobmENCg==

