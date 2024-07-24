Return-Path: <linux-pci+bounces-10705-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB54E93AC93
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 08:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2793284487
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 06:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4EAA3E49D;
	Wed, 24 Jul 2024 06:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gzbCR2x7"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011042.outbound.protection.outlook.com [52.101.70.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84B0482EF;
	Wed, 24 Jul 2024 06:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721802408; cv=fail; b=BaOiOUGfLQbv1uJSFXQCdQcFAO3sHjXdJtwS74zyRstqYyFPVHLcHtjt799mzCQ7joPVQaLKH7bE3AJT5XhvI01tnhFqnobAG2tR7gb6wgxh7P6GKRrzDOKDQOu2CSNgCuYi1M2BIdiOevR6D2nrG09xRA66u9c5dKuFVtfzt3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721802408; c=relaxed/simple;
	bh=IqGhUyCMPAfBxpYJTqblEZpv2wkODDnG9WUpZxSeGes=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rO6TUJxBK6IJ0f6qQmCz7a+e2cWOxfYcTNtYoZTBNI8mKQlkcC/l5CtEkXRkxvp5e9giOIquSeK6wypzKzx+AAiudmiOwIzYRaOpOq33xRqlO667J+U7wzkpKs1YNFNwrWmXyBPcg3za9VozHJ5if7uoKj9DVoRK7UQpWd0kmzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gzbCR2x7; arc=fail smtp.client-ip=52.101.70.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JoopCw7WcXgYAGtZ+wfRn87HCejL5o9YJXKFgOyyFpBml0PQ2mFbgd02rqJ3TEZjzawCUWFjfNEkunla0HwHa5LcZO0amP5Zhg4ZVfaqEzn3UgBEmuJ2M4NPJCs1Q18apAGGLJENffg2RpqjYsN0oQbk52XeUVZOlaa38ZmC6QqgNE9kIzyXFfH+BbUXuUG/6f0GVtj5h5EWDy6y/GMejHfh4TIQZSBdKL4YHqoyX/SrYwAPcXnIyk+BZBjOcuoWMitD2C3K6dQkiqqb5cGZ4bLln2mvN4lSjUph9JP/HTEAVQaUwgf0fhltTKhjsAwsj98O8mDN1OlmDuVaORWeMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IqGhUyCMPAfBxpYJTqblEZpv2wkODDnG9WUpZxSeGes=;
 b=Ctptse1Qxsb4H9lONoB1d115yuAKZ8fC36u4Al1VWPGpAISYGGjx1cKgwlG5nv8FQ0fAxiUlpbNzrIwoAvywKB3+Gj8GouIJdcJmAyVLzVb6j56fZNnyu+cPDWTqTwhVkVqdlBdh7Oe3RSqyFiM8Yg6Mlb2SJfZ4eE2R9hBsznIctu2Qj6ICreEGaS+S4FE+dr7Td4cntoEOONZ8pNOZm5GIZhDcHsmT6F76R5hXtw0Jtfk3K3DDIufPcAHxQYYYNzO+7ToiOsTzOeSa/ZK2bJc48orAUUB3PtDPctv2soRC3U9HL983r3rEg5/+/6K0ObISS6aK5zL4hdHzJnTTaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IqGhUyCMPAfBxpYJTqblEZpv2wkODDnG9WUpZxSeGes=;
 b=gzbCR2x7Ql46i/L5co8vBtBakDj/TWwKue4rcEJy5jfLHMCqi2miIXB+2TG1rdXaNgQguPdlK4kL+iBTMaL9iSOal1eORBzbAVisUGDD/HkrwXf1+c4hfY7ZBvbrJLv/ESB7PoehHv0rqcu9QGQFfwJiEn6/j/W2hzkiT0Z04yxzpirhcozT1SGBAApNxYe2nEP5WX5hy80zyj4PcZ5qA/M8UvwzYrMxgYtpQjdI8xka3gP01GJSvcOgiiBMb8yM3KWaHAmLVqm3qTEranrAjit1bB6anEQIJVyMKl02OMSkumKtI73zvozDA4BPJqQOouz3uyqTL6Zn/QqJ8/Yi0Q==
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AM9PR04MB8259.eurprd04.prod.outlook.com (2603:10a6:20b:3e4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Wed, 24 Jul
 2024 06:26:42 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%5]) with mapi id 15.20.7784.017; Wed, 24 Jul 2024
 06:26:42 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "l.stach@pengutronix.de" <l.stach@pengutronix.de>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH v2 1/4] dt-bindings: imx6q-pcie: Add reg-name "dbi2" and
 "atu" for i.MX8M PCIe Endpoint
Thread-Topic: [PATCH v2 1/4] dt-bindings: imx6q-pcie: Add reg-name "dbi2" and
 "atu" for i.MX8M PCIe Endpoint
Thread-Index: AQHa3XjKPyuG93K/lkCq2rFQl2xS+rIFZFSAgAADLtA=
Date: Wed, 24 Jul 2024 06:26:42 +0000
Message-ID:
 <AS8PR04MB8676B0F1385BE39D209DFB698CAA2@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1721790236-3966-1-git-send-email-hongxing.zhu@nxp.com>
 <1721790236-3966-2-git-send-email-hongxing.zhu@nxp.com>
 <dbcd776b-172a-4c53-b33a-3215f7dcfe77@kernel.org>
In-Reply-To: <dbcd776b-172a-4c53-b33a-3215f7dcfe77@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|AM9PR04MB8259:EE_
x-ms-office365-filtering-correlation-id: b634db60-0d00-4f26-a12e-08dcaba995a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?M1NCUnNGazQwUllJNElVcDVzcGNHOHpCUHhKVFI2S1I1SnJLeWltdGd6aWhR?=
 =?utf-8?B?YXA4S01MUWtaMExyOGpUWXhHZGJwYVErVDlLZStEQlFOL0VkZGJtSzdoK044?=
 =?utf-8?B?TVRvUzQwYlgzZnlZTkFPZlp5N2IwTEJqLzgvWG53cXlmaFJCN0d4RDhVTjBC?=
 =?utf-8?B?U3FpSkNIVUpkemF3VlVCK1V6YVVlV2hDWVZFblVwZHNHUXVMVm1BenNPWGw1?=
 =?utf-8?B?dDFxdzZScXo5dG1BcWdFVXlqVzJmNkYvY1U1d1I2bUYyZ0Z2MnBhcllpQVN3?=
 =?utf-8?B?TmE3ZW1vMEVVdGZyVkQwd0dZanpXcC9ndzRhZ2ZhUGFNc3ZLRU5zLzVYY2Zh?=
 =?utf-8?B?SFBlc1VLWkg0dnpUR0MzMHpoakVpNU45YXZXemMySW5TcjFhYmNIaUZhZ05z?=
 =?utf-8?B?THl0aG80TnhBWS93YmRkeFNMYTg2elRoVjZtQ1htSzBSNE4rUWZaUnJCZ0Nu?=
 =?utf-8?B?Sk5JdGt3VGxFNHBqV0JMTktrVTFNSFQ4M3pHa05KQXplV0VtNjFyOElLN1lU?=
 =?utf-8?B?YlVRcU1Ua2QzQkgxSENVd2R6SlR3d0htN3FkQ0NRMmNSWGE2MXV0SlZFWWZQ?=
 =?utf-8?B?eFdXcXUyNGlYQlMyN1Nad2x3dmhGVnM4VEJGWGlaNTNCd3ZibS9ibVcwSHVY?=
 =?utf-8?B?b3dJeXU1K2lHalRZeFJLUWJ6YmpqVnZnM0F0WWRvSmQvbXZCWlRQaEg1SzJ2?=
 =?utf-8?B?T0JQektSZVV0Rmp2QXhhcUZFcHVwQlNLcFpOOFcwSnNmemNkVERaRkJqZGd1?=
 =?utf-8?B?OWxPQk1ML1l6dFlUbzA5dERUQm5mSlhiR2ZQWXdEUzhaR0tKVm9rY0xFaEZI?=
 =?utf-8?B?dDdmbjNLSnZML0hrcC9mN3o3S2toN3VPYUxsbC9xdmptNnVHSjVQNnk1Q3dU?=
 =?utf-8?B?RDhZcmNDbE14V09ZNFBveVZIbTBjeWhadTJmQXlvdHowNnNFeWxnV2FJaGd2?=
 =?utf-8?B?R2IyOVNCSTRTUTNWN0UzOUQ5UTdYMDZCNlgxMjVsREMzWTVraWdUMms2dUdK?=
 =?utf-8?B?eDRlSXVVVDRnV0pmYjNWVlZFLy9DWmlXTEk1ZlRIRTdVdXREZ2RRTjZSTWds?=
 =?utf-8?B?bkhFN213MVZwL1J4REExSjYrMTY5TmdGUWZHNGJMYVpNQ2lldVI2WHA3bVBt?=
 =?utf-8?B?aGV5VnZ1Wk1DT3RRVjRGWGoxYXVOcXc3dWVYVHl3aHV6VjAzNHFTcVdyNHk1?=
 =?utf-8?B?ak8zZzVNNzdBNWliNjlOdjR6ZUVGa2k0K1JHSURYMnVVc0N2R29wVFpVaFpB?=
 =?utf-8?B?a3RWVTVIRkphL1REelgyek5SdEhFUkVFWXJOZWxBNE1zcCtJdW5JMjJWS3Mr?=
 =?utf-8?B?a0lwODlFU05vTDFiT2lpMjB3YkFYQ0NndUZpTXcyekREbEVSaEJqRkhWL0dx?=
 =?utf-8?B?dmNsb3JYRDd4aldIa3JhU1hta0s2dUNuOW5EMURpRjN4NzNBTFJhQkpaUWJ3?=
 =?utf-8?B?S0NQMGV6TUtlQzVlME9iRy8vOW9qcFpUeFBwNi80NkEyajJpMUpxT255eHFy?=
 =?utf-8?B?R2VGbzBRREZrc2Q3MEw1K1RKSjRzZ0hzT2IxTzJUTzNJVUZINE9QTjNyZXlR?=
 =?utf-8?B?TCtoSmtzbVNtVStyemhZUldqdVA0bTRzcDdaQk9xbFFtcks4a1Nkd0lIak8x?=
 =?utf-8?B?QjVpc3h2cm9DZjd1UUhUTy9vTERwQm5OTDdxVGJuSTN4aVdMblJScnJqMmIw?=
 =?utf-8?B?VUlNMTNUOG56blg3MTFLaWljVG1saVZ2a0g1WTMyREFONnM5emxQenRmSzdo?=
 =?utf-8?B?R1cxS1A4aklsUk1hS3pSN25ydW1BSXdRRUZPMG8xVVl6dGZHK0p2eG1Kb2NT?=
 =?utf-8?B?czBDa1hlalVpeTNaUUdZcmtDYW5JcGl2a09BT04yT1Z6M1RzNGFZYXVPWTFw?=
 =?utf-8?B?UWVYc1ZPeGNtdWNXcDNDTjhrdzVJRFhaa1RyQkFBaWxCUkE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bjVrNjJSa3NEb3IvNGI1Wk9wbERWaWl5aDJXOWxWNWlVNmZYcFhXekkxTWNl?=
 =?utf-8?B?NjlhNVg2aDhMeHI5b3c4YWlsNGg1NXA1eDljRWd3N3pxVlVVZjZ3VC8rWnBB?=
 =?utf-8?B?VENzRGVnV2RIMGM4dVplSE9PbDhGcEptcDl6T0E4cWRkaEV5RmU2ajVybm9H?=
 =?utf-8?B?OXNlWkVXTFUvSnlwRit3UER6UFJnejVKcGpPNllWTEZldDUzUkNJeWpxS0dM?=
 =?utf-8?B?Q2VlQzdNYUMySkk5d0N6YTgwSFVaV0xHNXlhNUpqM2FDU01PcWUzU2NQNFVw?=
 =?utf-8?B?aHkrMi80bXZTNnV6MVBWOVU4bVgxTE1DY1lFTS9HcTVoVHVTZGtxeUZveXJ2?=
 =?utf-8?B?ajdSSjd6WWVrU0o0K2lWaGlTN0JDNHNsOUdTd21IOFdhdSt6a3FHMzRiZ1lx?=
 =?utf-8?B?eFYrNWh4cU10Ly85Q3R3MDEzRmlvYkhPTkM3K1BzeVViNzFyT1ZWME81Z2c3?=
 =?utf-8?B?NFBPajhoZFM3VGhQL1NRbC8vdW5UTC9qajdPQUFMRnpFM3JZdXRnU0QrNC8r?=
 =?utf-8?B?dlFFaXArK3dPM2YwcFZpZzJPOUNwN3pBL0N3WmN5VnR3MHNhSlVBT25SZmZu?=
 =?utf-8?B?KzFlcnoyMkNQL1NZTlhGNTdONXNtL1ErUmRsVUlURmZvRVExK1prOFU0VjVN?=
 =?utf-8?B?cGFjeXVLdmpiSms5Z2UwY1Q2RXFxTW9vbEdvYUU0S2U2TzlmQlBSZDUxNWRk?=
 =?utf-8?B?Ti9mMTc2Skt0NklmSi9FYkVyQlZKZzFIUjlYRkVjQWNwbFVHbm8zbDF3YTRu?=
 =?utf-8?B?bStuYVhhMFBFZmp2YWtpQTlNNUhFQ0d5MmhhRnNSYVZ0cis1cGsvaGZad1NT?=
 =?utf-8?B?ZE9kUmJCdGYvemI0OElHcml6cDdGbmVESldTWXdpMDNvTjNScjNnVDVKMzBZ?=
 =?utf-8?B?V1pzSGZUQ3A0cWJacENsUStvSTRROUxXaWFDNHJxaFZGMlNnMkVRcHF0ak9E?=
 =?utf-8?B?TXp6cUZXUmJ0YzJEMkFULzRzM3d3STRkSG40RDBsUFR1TnlzV2xJdFdPSE9j?=
 =?utf-8?B?R3RYVnpQdy9JRDR3WEdiZGxSSC8veE1PaXJxTGRGOEg4NmZadWwyT3pIbnFk?=
 =?utf-8?B?NTV4ZW5tSkNDZkhUK2paYmJLaG9IazVUeXhVc1YxWXJBVjNhRlpUbzdiQ0RV?=
 =?utf-8?B?bURPU250VVRIR1JlSzY3cXlFaGtWTTZpOXNTcExyellSanpkQzk5akgvZ1Rj?=
 =?utf-8?B?allIbloxVHgzclFweW1ta3FLemxxdzhwcWNERko4VjFIQlB6dHAvbHFzdVFD?=
 =?utf-8?B?bjUrYzJsQldVeXNnaFFFRFhpYkVrUlQxNlpqMUM5WlZhM3h4bDRUV1M0a2xH?=
 =?utf-8?B?NjV3YytGZ3IwZzBzNmhuMXNYYWVvWVBpRDVMY2doL2pXekRSU1ZmYmoxazBT?=
 =?utf-8?B?STk1VEVlTzFsVS9RZzVGZDQvQUNDQ1hzWTNYM3dwQ2FGNGlNL2tZenRDOSt1?=
 =?utf-8?B?VUttWERYbHAyNmJqbkMzRWtJaTY2YkgwY3hOVVI1cVg2RHBjYlpVTmd5Y2Nt?=
 =?utf-8?B?RTVFc2RiNUtDcXRzWStqNzlPWCt0N2lTMGVlYXlCcEpRSk15WXZsYXRjV0ky?=
 =?utf-8?B?enc4MXF0MzFNWkovRUZublBKNjVZYjVkUldRbjVhTmV4b28wVFhCbk1maXht?=
 =?utf-8?B?dTRXYjVnU3lZOFpRTUtYb1ZtdkRWQ3BSaXhrMUJDckZUQ2dRWDlBUlZDQ3ND?=
 =?utf-8?B?Uk5wMnVhTkZTRXVHaDRVdEpZNCtxZGxad2JnRldWY1NnMFl1dE1TakVtY3Jo?=
 =?utf-8?B?VXZqdVhxV2ZqY3crdWxPSlBBYytBeFhET3NocnFVNjBmSHc1dndZL0I2VDgr?=
 =?utf-8?B?cXpHUUpDalY2R2ZJSGYzUEVlRTl2a2xqeCtnMExJam9iTFhvTnk3WktlODBu?=
 =?utf-8?B?Z1MyVnYzSWNHdnlvNGxScXJEdjZLL0s2YVRsbGh3N2RCYkpiQ0piU3VZOXpw?=
 =?utf-8?B?WHM3VFJjaDNzNWxoMTByYXV0WlRLbXphS3VSbGN6M2tjc0gxUkg4bElBK05W?=
 =?utf-8?B?cVVVUTE2UnNCZkxEWE5jQ3ZJWUtLME9xdkFmUjRBWGc0d0dKeEw1VlF0Q2Vv?=
 =?utf-8?B?NS9KdG96MGI1bGZMMmxMYkkwbUpHdzhYV2pCdnc3U2xnd0Z3SERRdWRWbnRP?=
 =?utf-8?Q?Tc2q0+L3K7QE8ELBlWeykcSaB?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b634db60-0d00-4f26-a12e-08dcaba995a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2024 06:26:42.7599
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p6lenGmxDj5HpZQVpv89SGQXYvsTqGIg09c2HhB/3Ccfs3eTUIDTV1g1iQRK4Y/8zU83hJUqhJPjVQj4F8NzHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8259

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tp
IDxrcnprQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjTlubQ35pyIMjTml6UgMTQ6MDcNCj4gVG86
IEhvbmd4aW5nIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+OyByb2JoQGtlcm5lbC5vcmc7DQo+
IGtyemsrZHRAa2VybmVsLm9yZzsgY29ub3IrZHRAa2VybmVsLm9yZzsgc2hhd25ndW9Aa2VybmVs
Lm9yZzsNCj4gbC5zdGFjaEBwZW5ndXRyb25peC5kZQ0KPiBDYzogZGV2aWNldHJlZUB2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWFybS1rZXJuZWxA
bGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4ga2Vy
bmVsQHBlbmd1dHJvbml4LmRlOyBpbXhAbGlzdHMubGludXguZGV2DQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggdjIgMS80XSBkdC1iaW5kaW5nczogaW14NnEtcGNpZTogQWRkIHJlZy1uYW1lICJkYmky
IiBhbmQNCj4gImF0dSIgZm9yIGkuTVg4TSBQQ0llIEVuZHBvaW50DQo+IA0KPiBPbiAyNC8wNy8y
MDI0IDA1OjAzLCBSaWNoYXJkIFpodSB3cm90ZToNCj4gPiBBZGQgcmVnLW5hbWU6ICJkYmkyIiwg
ImF0dSIgZm9yIGkuTVg4TSBQQ0llIEVuZHBvaW50Lg0KPiANCj4gVGhpcyB3ZSBzZWUgaW4gdGhl
IGRpZmYuIFdoYXQgSSBkbyBub3Qgc2VlIGlzIHdoeT8gSGFyZHdhcmUgY2hhbmdlZD8gSG93IGNv
bWU/DQo+IA0KRm9yIGkuTVg4TSBQQ0llIEVQLCB0aGUgZGJpMiBhbmQgYXR1IGFkZHJlc3MgYXJl
IHByZS1kZWZpbmVkIGluIHRoZSBkcml2ZXIuDQpUaGlzIG1ldGhvZCBpcyBub3QgZ29vZC4NCklu
IGNvbW1pdCBiN2Q2N2M2MTMwZWUgKCJQQ0k6IGlteDY6IEFkZCBpTVg5NSBFbmRwb2ludCAoRVAp
IHN1cHBvcnQiKSwNCkZyYW5rIHN1Z2dlc3RzIHRvIGZldGNoIHRoZSBkYmkyIGFuZCBhdHUgZnJv
bSBEVCBkaXJlY3RseS4NClRoaXMgc2VyaWVzIGlzIHByZXBhcmF0aW9uIHRvIGRvIHRoYXQgZm9y
IGkuTVg4TSBQQ0llIEVQLg0KDQpCZXN0IFJlZ2FyZHMNClJpY2hhcmQgWmh1DQo+IA0KPiBCZXN0
IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KDQo=

