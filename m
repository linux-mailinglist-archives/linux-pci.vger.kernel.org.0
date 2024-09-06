Return-Path: <linux-pci+bounces-12886-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC41996EE1F
	for <lists+linux-pci@lfdr.de>; Fri,  6 Sep 2024 10:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94D67283103
	for <lists+linux-pci@lfdr.de>; Fri,  6 Sep 2024 08:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960B745BE3;
	Fri,  6 Sep 2024 08:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="h3Gi49e6"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa17.fujitsucc.c3s2.iphmx.com (esa17.fujitsucc.c3s2.iphmx.com [216.71.158.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC5F14A604
	for <linux-pci@vger.kernel.org>; Fri,  6 Sep 2024 08:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.158.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725611488; cv=fail; b=mETei/p0VUwjKWGxS698TR4ibAIFNM1/bDZEd+WSoaSwPHXKOROQrx+8DHLxlV2QNArghJtn/B1Ih7ddFopyiwCzV68UCOh8TkVx910cqUmqxpr2ZKdYo3g+TZeuREUfEcdXnEFw6TQSDx9alQl4X842khNOZFhTChnBlQlcm6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725611488; c=relaxed/simple;
	bh=Dw94nNJSyrZWxl4mfrjM/Blq1CiukRvZgCoDXz3P6FM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gn6r9/MnZfeUwqwvMqMVxf7o+XMqB9t2q4dAT960q/Grs7ZuLlAJLtdhX1LXtDanjiPu2jO8XZ+dzhGwBcDEHdZphT1D2aoLEMW/WeEgJXKlbSUsuzDpoBaJy0aewwoRGAujgnTDzHi1JpMGgSnIcCmOLlKNJfuar5mFWr8lV84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=h3Gi49e6; arc=fail smtp.client-ip=216.71.158.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1725611485; x=1757147485;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Dw94nNJSyrZWxl4mfrjM/Blq1CiukRvZgCoDXz3P6FM=;
  b=h3Gi49e6njIultkqhrxDR1f+YfJXkmLs9nM90A2gPqJyM34I3DBOTWfx
   dBjpeVsdmyq+7a4Bmwlhk5EQCy1/oGDzIX5Rx4wDI/+tG6nZWMoQyzDhI
   LLNY5DTdGK+82isaipe2ibJb8Jvwsqj9e1VdxJlAqGkk7kg5X039+r3AB
   a04g6FvmQCtjrpmGTCo58ra89hRKjXd+sNbtPbMqGJ5Fmwx7I48qF2i9V
   6W+pMSAsQV/5eNexd6Ze8n3njshHkBdHlM6R7j/Xbj+cOV9O6Sp2KrHwu
   nvSaQ+oUgK9j/cLIR6huxCipohSVNV06zqoJYC/jRrG5Lh2PNJdHrOmc5
   Q==;
X-CSE-ConnectionGUID: t44WR5iDTYSi/J+WuxY3Kg==
X-CSE-MsgGUID: VhVVLI1eSv2BYejl1FpQaA==
X-IronPort-AV: E=McAfee;i="6700,10204,11186"; a="129990391"
X-IronPort-AV: E=Sophos;i="6.10,207,1719846000"; 
   d="scan'208";a="129990391"
Received: from mail-japaneastazlp17010001.outbound.protection.outlook.com (HELO TY3P286CU002.outbound.protection.outlook.com) ([40.93.73.1])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 17:30:14 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kUrEKJT5a+HO7SH6byexGZ3nAaadQUr5rGLH0MEnqwt22xNxJkAPKDIwAkZSo61B3OGCYbhzNwhDISn2AA8SG8Zz50agNHXH24LF+dL7Om5ubuwa0JpVeQNYxdYWfJEvYtBUhuorFlD9tB6+iFd8adVv7SEOW+WILMFvpfqZddzJpFfUVEncKIxnF4HUh+j5DCl2Ef8poA/faCd7J8h9gVW8NKdVcuF2JSZrnQhsp15BvZov59G6Tjh/aOuAtlAtR7PI1J9N/CCLRHd5Z1axNvXevrRUL0/bJgWuEXBH7yfyYZUbRNdq3KgbiIbP3mkj6tw6oRZVvFI3WeqY/M1Ilw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dw94nNJSyrZWxl4mfrjM/Blq1CiukRvZgCoDXz3P6FM=;
 b=xMeTQBBhgkbLzLPl92STuiBWQp6r8UazqrXs9hZc+Rf/hDHKmhgtWgiSLRuwM+r28aUhBIilGQTdZVoU494vrC1K/L3skTzn/ffsox88JYjdz87Mnrq61wc2MDJc5v0V0DGNBlpm17VqNkEXxXl68deJMTFBZ0rAwqq2GLtTupc18arN+jssBz/2JoX/aCMyMe0Ub2NaxIMuCeXdyjR3VKItm0CWakpIxw/Wyi3iy8XmXidudqsAtnFHXECK3w9zJ6k5om3/eLk9hw/xNUf4wgCsmIvOWIJ203rBE5z/qLbf0LNI8aD5sQTT1x7mzMYpurZtREFUOCyGpUy+I0n9jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSAPR01MB7182.jpnprd01.prod.outlook.com (2603:1096:604:141::5)
 by OS3PR01MB5734.jpnprd01.prod.outlook.com (2603:1096:604:c1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Fri, 6 Sep
 2024 08:30:10 +0000
Received: from OSAPR01MB7182.jpnprd01.prod.outlook.com
 ([fe80::357a:7bf5:8d95:3cba]) by OSAPR01MB7182.jpnprd01.prod.outlook.com
 ([fe80::357a:7bf5:8d95:3cba%3]) with mapi id 15.20.7939.017; Fri, 6 Sep 2024
 08:30:09 +0000
From: "Daisuke Kobayashi (Fujitsu)" <kobayashi.da-06@fujitsu.com>
To: =?utf-8?B?J0tyenlzenRvZiBXaWxjennFhHNraSc=?= <kw@linux.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH v2] Export PBEC Data register into sysfs
Thread-Topic: [PATCH v2] Export PBEC Data register into sysfs
Thread-Index: AQHa/nZAI/90nMHAe0SCn3NQwUajDbJKV8cAgAAQUxA=
Date: Fri, 6 Sep 2024 08:30:09 +0000
Message-ID:
 <OSAPR01MB71827A7D15108D6AAB476416BA9E2@OSAPR01MB7182.jpnprd01.prod.outlook.com>
References: <20240904030035.284423-1-kobayashi.da-06@fujitsu.com>
 <20240906065944.GF679795@rocinante>
In-Reply-To: <20240906065944.GF679795@rocinante>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 =?utf-8?B?TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5Njgw?=
 =?utf-8?B?MmZfQWN0aW9uSWQ9MDE5OTUyMDctMWMwOC00ZTAwLTgyZTYtNmJiNDIwMzI3?=
 =?utf-8?B?ODc5O01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMz?=
 =?utf-8?B?OTY4MDJmX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQx?=
 =?utf-8?B?LTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX01ldGhv?=
 =?utf-8?B?ZD1Qcml2aWxlZ2VkO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFk?=
 =?utf-8?B?NTUtNDZkZTMzOTY4MDJmX05hbWU9RlVKSVRTVS1QVUJMSUPigIs7TVNJUF9M?=
 =?utf-8?B?YWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfU2V0?=
 =?utf-8?B?RGF0ZT0yMDI0LTA5LTA2VDA3OjU4OjE0WjtNU0lQX0xhYmVsXzFlOTJlZjcz?=
 =?utf-8?B?LTBhZDEtNDBjNS1hZDU1LTQ2ZGUzMzk2ODAyZl9TaXRlSWQ9YTE5ZjEyMWQt?=
 =?utf-8?Q?81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSAPR01MB7182:EE_|OS3PR01MB5734:EE_
x-ms-office365-filtering-correlation-id: ead47371-4078-49fe-ac45-08dcce4e1ecf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bktCZ0tselJHdUVhWThjcC9SR2p3aS9ZeGI4dlU0SFNrWHZta094Z1NMOHp1?=
 =?utf-8?B?U0pQam84cG8wUEwwbFVLL3BuS1YxTEpnTnlYTlVRSWs5Yk1aM2RQWmJhSEty?=
 =?utf-8?B?OUhndE9sbW00UWRoZGN3UkR3OGtTQUYzTzVpV1MrZVk5Q2FjYUNpbVJVcWlU?=
 =?utf-8?B?TUI2NGF1UnlsdDBuTWpSd1k2dHlIVm5yT2tYamZnZU42NEc0L3JEdnhJaUgy?=
 =?utf-8?B?a1pRS1BGTC9FUmlyOUJ0OVhWRmlqaHZhSWxLUlI3bmVDc3dDaE9NV0RzTWV6?=
 =?utf-8?B?NFNPNkc0eWFUODZMeGtuK3VOdElqMFhHNWVRVk1paDdIdFBrZ1N0aytCc0lx?=
 =?utf-8?B?OWFnREgzYzZLb2UrdjNxQncwa1RhdDIwN1hPdEx1bkE5TElKbjEvd3hManNh?=
 =?utf-8?B?N1dtWWtBV3JGVXdkZG5TTjN1cTAvL0dJazZ6bi9YTUVZVlVzWHJwUEtUUkRt?=
 =?utf-8?B?YlpIU0V5dVg5UEZkTWF1TUtHdzVEaHZqZ2hLSWxKR0tDYzk1c2RTMnFPWEZZ?=
 =?utf-8?B?NmlJcE1IQ2M5ZGg0UU55cW9PTE1EZGx6Y1A2YkYzVzg0S0c2M0k3NmFsczBr?=
 =?utf-8?B?dU9pY2hESWs1VGQxVUdsY1IyTHhtN24xdnZidnJ2akY1Z3dsQjFzY3JUc3E4?=
 =?utf-8?B?L3dVL2hOTGI3OXo0T3BVYmFTVXBVd1lqMTFBVlhMRGtkTWNYRnQ3TjFxVlZ4?=
 =?utf-8?B?QlpqQzhObWtLM2g2R2Z1cXh6SU5jallEc2RuOXFUWm9UQTJxYlVVVElwSjNF?=
 =?utf-8?B?SitObkg1b2tCd2oyM2Z0Z1lMbkFzZ3kwaDJuczRLRjdRTWxpZy9EZk9BK1ov?=
 =?utf-8?B?eEpxTTYwZWZPRjU5WmQxeThMR0VZTVJYUGFlM0FMZjh5YkdmK1dSWDFUaGpV?=
 =?utf-8?B?ZXN2VGhKbU1FYm1xMWJWYXJXQlRtMXZNWTA0UGh6TW1VSHpDampnSVc3a2NS?=
 =?utf-8?B?Rkx5WVZMM1EwdktoQklScitnZkEvU0RTTFdKUk1OaFJ3Y0lyb0JZQk1VOGhk?=
 =?utf-8?B?RTAyM2xHQlBuQ0JCbEFXTTVNSDhYSW1sSzBYYmdyNStUUkRudXV0MEJjZjd4?=
 =?utf-8?B?NFIwRGhwRzV6cEZuaXVqZTBzUVlDZUNhcEdTRVFjQ2J6aGxaT3FJdVdXcHZn?=
 =?utf-8?B?Wlp6YW93MnpVMWtwY0RnOEtQSWRjRjVlSVpXVHlURTljOURLV0Z4Znd5ckZn?=
 =?utf-8?B?VTFNb0gxTEVRVHhXSnY2OUhqbElVbWowaG10Y3lDOXpOOVNxQkN6ZWM1ODkz?=
 =?utf-8?B?bGd5eUlRbU9YZlNEcGljbURuSS85K2tvVlVaVS9xZXRwVmRsd2ZQMGJZL0JI?=
 =?utf-8?B?T0RvZ2N5VVRGa2hCTEs4bUJ0eEFiUFlIY2QzVEVNdnVBdURqT3BLckdRT3pJ?=
 =?utf-8?B?Vm9ob3pyd0FzaEJmekgxcVVjTzZka0tyeFpiOHJYZEFLbXMrZDlKK1ZYVVJT?=
 =?utf-8?B?TGdWRUZGdm9MdzVNbXhOOWdXcm91ZE1zczhGbTRLNkY5Z0RPaUk0b3NXakMz?=
 =?utf-8?B?L0l5Zkw1SEZ1amthcGhnNUEyZ0N3M2RPTkxGenVhWVZMVXFzOUFKM0xWQ0N4?=
 =?utf-8?B?YWFObndWa0FlZ1NvYVg0R1ZqUmVIc0E2VFdYMTltR3liRDU5djhzYXhUSE5N?=
 =?utf-8?B?b1RZU1h2TGNQYkYvanhRN0FqYXBZZkNIWkdXNEZqcHJLZFNBbytiOEFpZ0FJ?=
 =?utf-8?B?MzJqWm9ORVNPbUV1WHRtNlppVGM3UmlxZG1PT28rRk9qQUVsZ2I4c0w5ZnZ5?=
 =?utf-8?B?bVlRR3ZlU0IvbVBUQXMwY2lQT2Z6R1JtVVh0RjcyeU1ZRkNBcGUxOTFEWDlP?=
 =?utf-8?B?QjBEOElzNHVxYUIxTE1xYmt4UHNPbVhhUldKcjJ6MTJJcWV6ZXlrWTBneW5C?=
 =?utf-8?B?SEVjVGpHbGY0ZzA0VHMvNUtYQTk0a0svM3J3eVlIeVkvWkdjZU8rak8xOWpT?=
 =?utf-8?Q?jxHiKmZsxgTbjoQVbDCIzEXSXnTXuuFe?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB7182.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cm9wSVNnckNNYkJVTWFiclBPV2xBelFVYXBucVRWQmFVNW9CUE10UzhTZHJB?=
 =?utf-8?B?bnhVdXdPSzJsRUs0R2s4L04xRmVlZHpnNno0bkh5MllvMGo3ZWdqM254MFNF?=
 =?utf-8?B?ZjFrbzZGTEhwUDN4Qi80Tkw4U0JwZjBqVnluMVBXRWhXRy9XNTh2N04yU2hj?=
 =?utf-8?B?NmhieS9NenJWeFRXVXAwUmJhS1hraktENGJHVjI5cG1oY0JTalgySWtzYWll?=
 =?utf-8?B?OS8zNVZicnkyREc3RlFJS1pKMHBrb2VOckNmZGZwZCtIcVVJUUc2ZE52V1Vw?=
 =?utf-8?B?aklaNWZiMzhPMGlSZVNoSE1oOGU0TmF1SmNESENKelgxcVh6R0VIdE43TEIy?=
 =?utf-8?B?QkY4dUlNWDg2U2toUlJLT205NkVlS1RiOGxxSmFQc2d6SEU3ZDZEazUzUGJ0?=
 =?utf-8?B?clZhNU96SG5WRVEweFc1aENzYk1uc1RVVWNTQ0NvcklpVnhydjhraGtVVXkr?=
 =?utf-8?B?VEZVWklWc0YycmFkaElzdmxvVTA4S2RrL1VpazZ4SXRpcHZKR0pRQ000Z0w3?=
 =?utf-8?B?VWNOaUoyeFUrelJldzk5d3J4cXI5eEJWa2Z4aFRISTh1OG1yWGhVWGI3aXIy?=
 =?utf-8?B?eC9oMFBnZWxMWUZhNUlCbDRPTG5WNVNPVVF1SXhRUWpqWkFRQUpXcDdyNTZk?=
 =?utf-8?B?YzN2eDRDRHd2S2I5dXRxS2lGNlVPUDN4YXJQSnp1bTFiTDZPUm5sRmRmWXZ6?=
 =?utf-8?B?aXk1MU9XOUxPRjZSWW1oYk1nbTRFR0kya0dDRC83cUg5c3F2RkF5Q1pFUlho?=
 =?utf-8?B?a0FrMTl1QVU4L21nbDFXVXY1RWUySElIMmRMWkgwYWp1U3lLNEYzUGJXN3du?=
 =?utf-8?B?MWx2ZTlGZU0vc2ZhbnJNVEkwVkpSOVZjdDJLL2pQWjh6a2dVLzJmRnkwZXhn?=
 =?utf-8?B?Z2dUVXVrWmprdk14MFBHWHVjZm5tUVQ0K2xQZXdGeVQwbGk3UjdhUTlXTkh2?=
 =?utf-8?B?b2pIcGNLdVRLaXljV1Zac0VrVHYwb3hwN2tLYmtBMVBxbDZlOGVldnYyZ1VC?=
 =?utf-8?B?ZllBc3lsbk5vWVlTZFFYZTI2VDdvOGI0UEh1cTBIR05QWm8xRHlHcUxncU83?=
 =?utf-8?B?bEtmYS93OVpxVEFqTGVOdndML2gzb2M5aTR3Y09YcUlvcUVybmNickFTVnRr?=
 =?utf-8?B?VEN6Qzdrd2pJaFFZOG0wYU9zRmxXaWZHRTIwQUh1bitLS3R3TXJwdnBOT2pm?=
 =?utf-8?B?aHEwYzJvS0tYVG9BWGRZVTRGYlEyMHpsdkp3TUFVdTJEaG5PWTdMcFA5Nlp3?=
 =?utf-8?B?MkwzUElSUTFydGVIWWlJQjAzZ05Xb3ovcy9GUmIxRjl4WnphanVUQTVUTXZS?=
 =?utf-8?B?elRqWHExckYxM2xtbnNFVWZXdUxRemV3NFErcEpCUStKMnNDV0kyMGZ6WlN1?=
 =?utf-8?B?a2NtWng3U0JwaFRCVlcvRlZoZS9MeEVyYXhFRkFlVE1QZnErYk9YQkNWa1Mz?=
 =?utf-8?B?TEZ5VTFLNEdSd0ZUVHFQL1Ird1d5MGNaUWtHcWFuRGJST3pyWUR2VU9td2RJ?=
 =?utf-8?B?ZGtOdDJuTkk2TFkzYzZQRDdjSG16QmttNlhwRVorRWtmeGFKT0JXQjVBWGds?=
 =?utf-8?B?T2lqZ1czNGNVYjBTa3RzV0x6NlRKYXh5YTFiYnBJMzllRW1jZUNXWTc5RGhr?=
 =?utf-8?B?NWxva1J6dkhwSFdPSkRPczIxbHZiQWpYL3NrK0dHQlBNNGh2U0h6YWlJdmpr?=
 =?utf-8?B?Yy9Ca3hFT2g1ME5zVm4xcUJpYzFNZVc0WjloR1JYTGpHSTR3NjhyVjBtL1VG?=
 =?utf-8?B?QmZPb2NGclc5SjdQS3RwMFRRbTFmRGpsbG5DYW83RG9NVjhTTi9QVlY2NElJ?=
 =?utf-8?B?UjZEL2YxczBzQjRXYTZnYTdjM1VtK3lvZWF4ZmZ2Y1hUUk5WVlNKVDRyejdT?=
 =?utf-8?B?YUVoUzlFcHJpaGRaU0NWVVM4QmE4YStIeW5BVVJvUHhtMnMxY2xraTk5Tm1u?=
 =?utf-8?B?Mk5VUnQ3bUhqNytneXpqdmRtMSszcWhMeSs0WEJlTk9aK1htK0Fad1hydVNh?=
 =?utf-8?B?aW5ZZzBKYTQ0M1gxcGFyQk00N1ZMdUpiR21GOFZZWC9QMk5BWEZLWHY5czJQ?=
 =?utf-8?B?VTMyUFB0TDQ5STQwSmI5UlV2WFpldTVMNGJUY0hTWG8yOFh1bHNueHpOQ1dh?=
 =?utf-8?B?UTRmSlIrMWV4ZkxXbjA0NTRENmhzTWpBbVpXU0pnN29OVldEYU9KVHdtTjRt?=
 =?utf-8?B?U3c9PQ==?=
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
	VXRuBROV+aUZrgA+EME/ZO4Q+yzIkggeRzmm6nIc2R3nn4CtUoBPJ04sIUYtqtIc+cBQd+SjVzijlcdsIUH3/TE3LQVIHPKZbSUOTBtJZ46Ci7T4Ouu5Utz3bT05N4cnUzj4D8xhzM9Silx/exfsNIVLQpsB/Ylo+ISYRqS667JMmF3Y8GoOg0lqcA/NzkwJul4HqkjcdtXlz++n9ZJAxZeyiWguLJ9Ehwa+wFz5/E54bKhwIOo6qogtCLZim2WkmYq1JvyCbBqTIHceshUB2/gtTBuhW1RXci3uRoG3M9+cGdzJN8Er1LcZru+phaNshuKNbbis73kwZhyshwKMZk09FtADtfMqz7SaL8nqRxsTOV93hDbqyZ5FV4OnFpQR4+a5ME1JbyT5t6i92uHibV7w+a1erPEAuHUGt+7tIInuZrhk/M37X2guGrhORZjZ8ZbEpAHugGcN+qEquQqq1Jo08AZKraDOYGpcKckger243CgFS7iCaBF/ezMXolsfe96eDSqlVj2GSSLCkhnm3ra5oqfK2xI7O3O/ViMuNCOVRXTWNZoJ49g79MN8nnVTVOmwLmvVrfJyguvfX/7GEHxSSD1eN2aJ+6H2LzHFbAK+XMNY3iYM7XjB4yDPcED+
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB7182.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ead47371-4078-49fe-ac45-08dcce4e1ecf
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2024 08:30:09.9302
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pfAe0UyGNvKA8Frv7VyrUX5yQCzY9kH+cLIqkQsxciOqGBBSMQdu4j/bdGKxfvKezmlG+oNF4PpCiUboEu6ANlkHjNbF7dOV+o7XTH9g7Mc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5734

PiBIZWxsbywNCj4gDQo+ID4gVGhpcyBwcm9wb3NhbCBhaW1zIHRvIGFkZCBhIGZlYXR1cmUgdGhh
dCBvdXRwdXRzIFBDSWUgZGV2aWNlIHBvd2VyDQo+ID4gY29uc3VtcHRpb24gaW5mb3JtYXRpb24g
dG8gc3lzZnMuDQo+ID4NCj4gPiBBZGQgc3VwcG9ydCBmb3IgUEJFQyAoUG93ZXIgQnVkZ2V0aW5n
IEV4dGVuZGVkIENhcGFiaWxpdHkpIG91dHB1dCB0bw0KPiA+IHRoZSBQQ0llIGRyaXZlci4gUEJF
QyBpcyBkZWZpbmVkIGluIHRoZSBQQ0llIHNwZWNpZmljYXRpb24oUENJZSByNi4wLA0KPiA+IHNl
YyA3LjguMSkgYW5kIGlzIGEgc3RhbmRhcmQgbWV0aG9kIGZvciBvYnRhaW5pbmcgZGV2aWNlIHBv
d2VyDQo+ID4gY29uc3VtcHRpb24gaW5mb3JtYXRpb24uDQo+ID4NCj4gPiBQQ0llIGRldmljZXMg
Y2FuIHNpZ25pZmljYW50bHkgaW1wYWN0IHRoZSBvdmVyYWxsIHBvd2VyIGNvbnN1bXB0aW9uIG9m
DQo+ID4gYSBzeXN0ZW0uIEhvd2V2ZXIsIG9idGFpbmluZyBQQ0llIGRldmljZSBwb3dlciBjb25z
dW1wdGlvbiBpbmZvcm1hdGlvbg0KPiA+IGhhcyB0cmFkaXRpb25hbGx5IGJlZW4gZGlmZmljdWx0
Lg0KPiA+DQo+ID4gVGhlIFBCRUMgRGF0YSByZWdpc3RlciBjaGFuZ2VzIGRlcGVuZGluZyBvbiB0
aGUgdmFsdWUgb2YgdGhlIFBCRUMgRGF0YQ0KPiA+IFNlbGVjdCByZWdpc3Rlci4gVG8gb2J0YWlu
IGFsbCBQQkVDIERhdGEgcmVnaXN0ZXIgdmFsdWVzIGRlZmluZWQgaW4NCj4gPiB0aGUgZGV2aWNl
LCBvYnRhaW4gdGhlIHZhbHVlIG9mIHRoZSBQQkVDIERhdGEgcmVnaXN0ZXIgd2hpbGUgY2hhbmdp
bmcNCj4gPiB0aGUgdmFsdWUgb2YgdGhlIFBCRUMgRGF0YSBTZWxlY3QgcmVnaXN0ZXIuDQo+IA0K
PiBLb2JheWFzaGktc2FuLCB3ZSBhcmUgbWlzc2luZyB0aGUgQUJJIGRvY3VtZW50YXRpb24sIHdo
aWNoIGlzIGFsbCB0aGF0J3MgbGVmdA0KPiB0byBnZXQgdGhpcyBzZXJpZXMgbWVyZ2VkLiAgUGVy
aGFwcyBldmVuIHRoaXMgY3ljbGUgaWYgeW91IHBvc3QgYSB2MyBzb21ld2hhdA0KPiBzb29uIGlz
aC4g44GK6aGY44GE44GX44G+44GZ44CCDQo+IA0KPiBBbiBleGFtcGxlIG9mIGEgc2VyaWVzIHdo
aWNoIHNob3dzIGhvdyB0byBkbyBpdDoNCj4gDQo+ICAgLQ0KPiBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9saW51eC1wY2kvMTY2MzM2MDg4Nzk2LjM1OTc5NDAuMTQ5NzM0OTk5MzY2OTI1NTg1DQo+
IDU2LnN0Z2l0QG9tZW4NCj4gDQo+IFRoZSBzeXNmcyBkb2N1bWVudGF0aW9uIChzZWUgc2VjdGlv
biBhdCB0aGUgYm90dG9tKToNCj4gDQo+ICAgLSBodHRwczovL3d3dy5rZXJuZWwub3JnL2RvYy9o
dG1sL2xhdGVzdC9maWxlc3lzdGVtcy9zeXNmcy5odG1sDQo+IA0KPiAJS3J6eXN6dG9mDQoNCkkg
dW5kZXJzdGFuZCB5b3VyIHBvaW50IGFuZCB0aGFuayB5b3UgZm9yIHByb3ZpZGluZyB0aGUgZXhh
bXBsZS4NCkknbGwgYmUgYWJsZSB0byBwb3N0IHYzIGVhcmx5IG5leHQgd2Vlay4NCkkgYXBwcmVj
aWF0ZSBpdC4gVGhhbmsgeW91Lg0K

