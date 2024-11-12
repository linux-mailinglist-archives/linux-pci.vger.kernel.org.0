Return-Path: <linux-pci+bounces-16516-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 597669C51EB
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 10:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1796F2849FB
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 09:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A2420D4F4;
	Tue, 12 Nov 2024 09:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KAZkNiuL"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2040.outbound.protection.outlook.com [40.107.105.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44BB20B204;
	Tue, 12 Nov 2024 09:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731403563; cv=fail; b=k2wr8XT4sELpZRdDJkkOroWDcLhfWc5Qq2MWqGJWgmUlw7GKUmnqfMXTy3FgEpFeXJo21mcN1LFLUGPZRng0OCIle9ARPc4dwA1pwml5Puyom9Z/F87vX5U1+0hOTUh26WzyY4u/ZG1/54fsmpoqFuzSN+ek0fh+MmKnBULo6yE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731403563; c=relaxed/simple;
	bh=mOtMogHMQayjcNgvB5UzP4BJmo49PamzR45urQ9T0fA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pV8PXGTcAlu54vFrEf6MoCvyeQ9BKa4XRO7AotfHiaBflDA8Fkf7iEuGn13rp1WzJs00Hd18jIz4mcebOLJzYxxQoFYZwXJXRq72bUQnp3+X84VTP/S0rS83FabSiskWE1TYsATBx0zKuQjHhtO7ja1/xowVELAh87d1OvG/CTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KAZkNiuL; arc=fail smtp.client-ip=40.107.105.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ei7aNhm0sFt/plDJj6MgiGtlkHfXxb2hf0QJxMb7f32MU051p2Q4JfhGW+QH1FueaChRjwpondLVmowqK3YW412d8NeHRfak6bkdZU6Sr2qxLgAQvQ9vuG1Et05MY3VINkzBczVAGnYuAhWD76Wz3rtOlgvM+/cvklrQRXOTPJGsXa2OWxEd9B7ILmqLqfeNyTM5FOFUYkbCeUO+xYeyK7jt2OTeNdjYvp1lb5PEr5uFB5sZHSGH+wt0OQWkr/lj1RdqzI0ATBpcSWkHgE6+Cw7cX8PMDlqf8z9yVsblVL8I85YjVC0PX3bYLFv9Bz82qK/KuYFZDkye+4KxUTvAWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mOtMogHMQayjcNgvB5UzP4BJmo49PamzR45urQ9T0fA=;
 b=PJKmpDD4Li8KUk1IBqr0ziqH9jgMV6BCPE9V2TqjejBAQXotuo9jiln2aiD9YkncK4bQpEdb2sJH0cXU040tnQ+YmwoJ+LlMzqS4cHD/m64WxO6ESA+SSpD48P28aAeoEXBms2mFu/9Nz1I2XRWjbr61X6KMqb+DFzf14CG4YpLsAAoMci9WUKupGmpSkmfmdJ/nTttCz+9rxbVgbIDTquR6d8I0DPIuZHP7+WfSm0LLutsYQ8tNIDnj/cMMknzj+w+hO+jF76LDDFTTctJW9LCKvz6FHKYMlG6swBkz10+lhY4nZ4IVhJOTcreesqtr8FbMKJnjMCvIvh6VUpxH1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mOtMogHMQayjcNgvB5UzP4BJmo49PamzR45urQ9T0fA=;
 b=KAZkNiuLPHFE7Xj7dXtWSuEIKw6dtAtWUhhUhnWvpyXrpt/6VdKhvQdqsxacIRuLAevLUL3svvlR3NUcg3fYDhy9FriLmdOT4IjdFNst/V6yl5oqFza0GizWnBnQJiBflaNKo1rZbeOD3MyR7bbh33RXvuQlJhVhfSFd0aiXExj0fPSPIkwQF/7jMNDvfq9EcPIjuGI53ZVvtvIp0Hhsz6eM3UuzsujYAAjyNfOUo29WPEFRarjSCeiZTyGgq/1bkmuBc5HR0d4UqFwX35JaUSU0qIEysTXjM6nSnEUWa2shSIsuL8KRLfP8/9M3Gu+WuJG6Uxd1GY60PLoMpnnBgg==
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by VI2PR04MB10548.eurprd04.prod.outlook.com (2603:10a6:800:27d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.26; Tue, 12 Nov
 2024 09:25:58 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%7]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 09:25:57 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Bjorn Helgaas
	<helgaas@kernel.org>
CC: "jingoohan1@gmail.com" <jingoohan1@gmail.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>, Frank Li
	<frank.li@nxp.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1] PCI: dwc: Clean up some unnecessary codes in
 dw_pcie_suspend_noirq()
Thread-Topic: [PATCH v1] PCI: dwc: Clean up some unnecessary codes in
 dw_pcie_suspend_noirq()
Thread-Index: AQHbMO/ydVggfwMlw0SMjZ6nwDplE7KrqksAgADc9oCABRdHAIABxzZA
Date: Tue, 12 Nov 2024 09:25:57 +0000
Message-ID:
 <AS8PR04MB8676B2B98473900A6310246C8C592@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <20241107111334.n23ebkbs3uhxivvm@thinkpad>
 <20241108002425.GA1631063@bhelgaas>
 <20241111060902.mdbksegqj5rblqsn@thinkpad>
In-Reply-To: <20241111060902.mdbksegqj5rblqsn@thinkpad>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|VI2PR04MB10548:EE_
x-ms-office365-filtering-correlation-id: 9670778e-ba10-45ce-26fd-08dd02fc0403
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dlZyaUtraGRjeTlNVXdkeC8xT1o4ZHVXdk94UGxIeHZ5eS9DRmRZZEwzV0JM?=
 =?utf-8?B?UXBSSkpMR2RPYU03V2hUKzQvNi9zVWR1MTFRbmtzVWtRTGpMam9GWkx5WGJt?=
 =?utf-8?B?VXZ4YWlscFVQRjBnRHhnMEMwNWVidTJMZkx1SkdMcnhFS0pwRC95YUp2QUQ2?=
 =?utf-8?B?Q2NuV3Vsdk5XcWUzaVVESzZiajBiWEpIenIrbjV2U09MWGVpUW1qZ25oUVBZ?=
 =?utf-8?B?YVZPV2hYc3FDVFAvbDl3UG9HS3RoWU96WUwwYTFndUZCL0dGK0xrUmVWRlBS?=
 =?utf-8?B?TlFIRUZrai9VeHZvZThIOHN0U2g4TzlWWnNvS1dvbEtWUldYMDFtb3dQalB2?=
 =?utf-8?B?a3pzYnFuWlhZUEw3Vm12b2Y5K1JsWThHaVBIZHJVN1NNMjJNalpCUzJYL1Mw?=
 =?utf-8?B?c0FkYzBGZG1VV1N0RVhBWWc2MVpqdkxGaGFncDhBSlVlNkpaT2haRzlDWnVu?=
 =?utf-8?B?RGdHVHNyaVhoQUZzaGxxZTBEbG5rQ1BrUHZOQ3NzNHZHb2ZXNFk0ekQwUEhK?=
 =?utf-8?B?NCthR0F1aUYzRjhQTG5tQVFSRXI4ZWR2YVhZT1Fienhrck5DWTY2ejBlcTd5?=
 =?utf-8?B?d0xHSUM0cWpJMjdOM1IybDRvcU85eUxrdVlKRkpmZFNtTStldC80Q0JPQUd0?=
 =?utf-8?B?WE9iNy9DZVo1ejN6T2gwZWdHQnhxK0ZPTDYwQ3Q5TEpDbnN3K3hHUDljOWVW?=
 =?utf-8?B?L0NXdHQrTVNJREJXNTF5RDNxeUwrNVlrdVQyV3hYSytyUm9uNWNjd3JWTG9v?=
 =?utf-8?B?YitxbDhXOVBOcDJEWnBzSTVKNkwwM2tBbFJFdkYwK3c1MHY2L25tZlFlT1Rx?=
 =?utf-8?B?aUN6dWVMSFF5elYrNFh0dDl6S2ZYWXVHbWZPcHlqWFc2bXBKWDlXYzdZazlB?=
 =?utf-8?B?VmJ2dnVvOGtXKzQ1aURTSC9MVk8zV3dmb3F3V0kzdnltOXRwczViUHhRSk1l?=
 =?utf-8?B?VDRhN0pDUGs2NUJSdjVaSFpsZmcyQzUrNExBM3E2YmtTSmluZ0JSUmNhaXlK?=
 =?utf-8?B?NWVLdmNZNVhRSzhlVFhHVEU3djJ4SVZHK3NVcnE4dndsQ0FSOSthblB6NDY2?=
 =?utf-8?B?UVdXL1FoMkJUYmsrQVV0blNBSUV1NWNta09iSnNnQTZqK0FtRkVnV0ZESFFC?=
 =?utf-8?B?cTZYUU9PdmY0Z1RIblVLUEduVjFmc21wNjN6WlU2MDFMUXB0ZVZETzV1Yzg2?=
 =?utf-8?B?TnlrN1RBcUhWS0huckt4YkdUNlRWc1RuMDEybnJtWEpocGN6RGZyakdZOWl0?=
 =?utf-8?B?b3kzOVUwZjdnejY2anlxOUxJeUx1MmpPSW5wVWdjYVl2TDhNWUhmQjJnZTN4?=
 =?utf-8?B?eFlJSTNjZEVLSndybTh5WFpWbXV2RHpZTEtkMlhiQ21pc0JWNWlseFh2aWpm?=
 =?utf-8?B?Y2RYL1dlY1VEV21meUxrOE14YktaNkxpbEFXVjRvV1dZT2NtY3hybThtOUdv?=
 =?utf-8?B?K2Q2WFFXck9yV1lBcnF4RU1kaGV4STErOXJMcjdNMW5QOWRkNHNLcS94QS9X?=
 =?utf-8?B?U3V0WkY2QlRUTlhBK2haeTFjNlFLQWF6MjVtZlUyOFpWR1UzUUtBY0VqKzRO?=
 =?utf-8?B?TmUxWVJLdGphVW8zYXhzVGFRZFFCcHVqZSsxOEFZMXg4MVhjSGsweDhTK3NN?=
 =?utf-8?B?YlBsM1ptOUp6ZlRudmIrcEgvcjZyQXhlR01PRTNRUFVEVEk3b1hLMVRpd1d1?=
 =?utf-8?B?ZUJ2UEZ0czNJdHVTTVdXV09WTUVUUEpoRThxdCsxayt2NnM1dVlQUE96WVJ3?=
 =?utf-8?B?ZmN2dmUrTW82RlVRV1RKYTU3dWFabFcxM3NyN1h4dDZMNC85RlVSdSt5S1RM?=
 =?utf-8?Q?ieobsOW7RclG2ywKAGBQdtc65Yg0az+K53f44=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WTdtNzJjbHozUVZyN0k4STRZTjZvT285cXo5b3d2RzduUlNEWVV6alF6REtN?=
 =?utf-8?B?Y2ZSY25RbUlZQWRJUWRJeW5JMjJtQmJnL1dTTFQvRVlPZHUva1ZLWTNDYlNq?=
 =?utf-8?B?MFMydnc1QkFHMHRTcXFnQ0t0Vm9TOFp2RmFDV1JJVEgzcXZjNUR4MFc0ck5m?=
 =?utf-8?B?YVFkVEhLclhvbGZYNDZrcFhtREl0YUNpZ2F2WnBVdlBOWGYzY0FvZDhCL1gr?=
 =?utf-8?B?S3pFUllQaHk3WWRZc1BBRFJPVnk5UjhEcUd2REZlV0xrOTVvWHRIdkMrRTRx?=
 =?utf-8?B?WDdtRXJzVjMzSUhDMjgyZVl0SkxsdWFKeWdkZUxweVJMVEQ4TVpuTTZSelB6?=
 =?utf-8?B?RmxaMTNrQlR5ZlQ2UWJLUytaVDNGOW1lNnhFdUM1N0ZSaW9idlpoUk5sYlF0?=
 =?utf-8?B?cmVNQUJ4dk1hUkwxcjVacVplMS9vcmNua3BVSDNkcjk0Kzk1MHNYcXkyYUdo?=
 =?utf-8?B?NnRzenM3OTduazBUQVNIWGUyZ1pzVEx6RHhlZ1BYVkxaeTZsY1dIelJLZ2RV?=
 =?utf-8?B?T042Wkl0ZWlPRnpUUkp1ZGdQdUFjc3JYSytUYTcvVTlvN2FpNEZyMVQzK0Fh?=
 =?utf-8?B?ZEZqb2xUdC94aCsyc1hrbzBXQ2o5OU0wa2JBYTVPNyt1MUMyT29xSmlibURO?=
 =?utf-8?B?VElxck95RnhiaFRyNjJLWmJGNmNsaEptaGhCQmRrcVh5eTNOYXc2R0Y1RHgx?=
 =?utf-8?B?bWg3Y2FRVGd3MTBWcWtHL0JWTkNNaklqUVZ2UjZEeno4bm5zWDh2Nzl1MUla?=
 =?utf-8?B?Q0U4Q3dFeUd3L1cra0xWblVzL0Q2RU1UeVA3elMzVFI4SnNZWkZXZHkwb29Y?=
 =?utf-8?B?RzQyQS9lVzc2czV6ZUZqMWJvNVd0L1VaMG9RUjZGN0xLUEl1U3piTVFJNVF5?=
 =?utf-8?B?amZpbUFuOUxjWE5tdTd4cWhIZXhmaG1lU3dGdWFZRDFTS1gvYVRMSkJhMTJX?=
 =?utf-8?B?OUl5U0J6YnltL0lKM1VGMzF3MjZzV1hXdm9oSVFYKzl0aUxMclIxR2xRV3lG?=
 =?utf-8?B?c0ZnNDdGa0thNFhjVjVFRGMrVXlBQzlwMjl4U0s4bGo5bmpSRXZCeGkwWnFY?=
 =?utf-8?B?Vm00anhYaGlGVFE4WWZXUHBadjdMdlRuSTVTa2RzZWMyWjVNekQzSDhPYU5W?=
 =?utf-8?B?KzdtUjc0SXZWclVxV0ZGQTBjWFZrS3ZmN0x4YS8wUGVCc3RRWk1Tc09xYllm?=
 =?utf-8?B?cXEwWnp0TDhwQU5ZQjBYMnhBWjJpMm91UEk1THg0VisrdEZFRE9ocFdVbUdv?=
 =?utf-8?B?MFFTTlhwa2l1TkJ5ajhPRmRESzhGMXRvS3FDR1hNYzVYMlIrM0IyRXZVc1pl?=
 =?utf-8?B?WTlyaklGcldmQ1lmdnBPVDk2eVI4V1pkdDhWbDV0RkNhcnVCbzBXZnMyWDVl?=
 =?utf-8?B?SjZSMUMzdmVCbWhLTVJZd2pjWVlnZlVLaTNDU0VCNGRHQ3Vlc0NjajBPbUVi?=
 =?utf-8?B?clplOHJJUksyV3RhRE5KSWF1T0o4SXprRDdqc0dTQmRHbDB4Sk9RaWlIV1Vs?=
 =?utf-8?B?eG43MzRWS1NtSlVYd0I4VnV4Qlp6UTJkSE1tNzZ3MHZXU3lFOXl3amQzVUJu?=
 =?utf-8?B?b0RUcTVSR2ZHVGdOVXM4RktOUExQMDF3d3l6dlBRN0lLQ1JxTllpMDNlWkkv?=
 =?utf-8?B?SHJZQThVd3RNc0VpWjZuREZzeHhJM0R1bkpWRXIzdGpiL3pzc09McWU4Qnhl?=
 =?utf-8?B?cXI4K3ZUWGpZcHoxQ1BYRFFWYkMySFdXaXRhbkgwTnZoQ3ptODdRNHltSDZK?=
 =?utf-8?B?VVBveGhtUWlyZEZwTkNjdGZXNUl4QTJ1MGwxNnRxOXFDd29WNGFuN3ZWZ2Q1?=
 =?utf-8?B?OXB1K0lVcmlPb2dhaklqQzBCckk4WW9DdHh4aGVxWitWVlYxZjNUMy90S0NL?=
 =?utf-8?B?SGpMbi9KdHR6cjlMWktPTXZpNG0wRlpZR3RCdy9WTk9zYTNjRlRMSkYrM01p?=
 =?utf-8?B?bUFmOVhydGRjcXlJTm02REhSRjZyYjVEV1lhSGFXbTBFVVNtdUJlK0Q1SVF3?=
 =?utf-8?B?dWhEK3lDRnpmTFF5Ulc0VVM0a0lWKzZ2QWlFQWFwZ0NjVFRrRzF5TDQxY1dW?=
 =?utf-8?B?dXZzclRTNDBLUlJQa29ZZmFPMGxvZUtsblJLNlJrUTJtN1MyTmRmRG95UmlC?=
 =?utf-8?Q?LIxNeIF5c0e7bIElk3DOoe4Yy?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9670778e-ba10-45ce-26fd-08dd02fc0403
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2024 09:25:57.8305
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KzxB87gbFP9G/zT8MbPW+L7rZBoY6wVfO9XhqeJjSOPydTzrr7bwtH+Y8+lwM18b8rDPKvj7o6VPcz4LNZxCPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10548

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYW5pdmFubmFuIFNhZGhhc2l2
YW0gPG1hbml2YW5uYW4uc2FkaGFzaXZhbUBsaW5hcm8ub3JnPg0KPiBTZW50OiAyMDI05bm0MTHm
nIgxMeaXpSAxNDowOQ0KPiBUbzogQmpvcm4gSGVsZ2FhcyA8aGVsZ2Fhc0BrZXJuZWwub3JnPg0K
PiBDYzogSG9uZ3hpbmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT47IGppbmdvb2hhbjFAZ21h
aWwuY29tOw0KPiBiaGVsZ2Fhc0Bnb29nbGUuY29tOyBscGllcmFsaXNpQGtlcm5lbC5vcmc7IGt3
QGxpbnV4LmNvbTsNCj4gcm9iaEBrZXJuZWwub3JnOyBGcmFuayBMaSA8ZnJhbmsubGlAbnhwLmNv
bT47IGlteEBsaXN0cy5saW51eC5kZXY7DQo+IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgbGludXgt
cGNpQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBT
dWJqZWN0OiBSZTogW1BBVENIIHYxXSBQQ0k6IGR3YzogQ2xlYW4gdXAgc29tZSB1bm5lY2Vzc2Fy
eSBjb2RlcyBpbg0KPiBkd19wY2llX3N1c3BlbmRfbm9pcnEoKQ0KPiANCj4gT24gVGh1LCBOb3Yg
MDcsIDIwMjQgYXQgMDY6MjQ6MjVQTSAtMDYwMCwgQmpvcm4gSGVsZ2FhcyB3cm90ZToNCj4gPiBP
biBUaHUsIE5vdiAwNywgMjAyNCBhdCAxMToxMzozNEFNICswMDAwLCBNYW5pdmFubmFuIFNhZGhh
c2l2YW0NCj4gd3JvdGU6DQo+ID4gPiBPbiBUaHUsIE5vdiAwNywgMjAyNCBhdCAwNDo0NDo1NVBN
ICswODAwLCBSaWNoYXJkIFpodSB3cm90ZToNCj4gPiA+ID4gQmVmb3JlIHNlbmRpbmcgUE1FX1RV
Uk5fT0ZGLCBkb24ndCB0ZXN0IHRoZSBMVFNTTSBzdGF0LiBTaW5jZSBpdCdzDQo+ID4gPiA+IHNh
ZmUgdG8gc2VuZCBQTUVfVFVSTl9PRkYgbWVzc2FnZSByZWdhcmRsZXNzIG9mIHdoZXRoZXIgdGhl
IGxpbmsNCj4gPiA+ID4gaXMgdXAgb3IgZG93bi4gU28sIHRoZXJlIHdvdWxkIGJlIG5vIG5lZWQg
dG8gdGVzdCB0aGUgTFRTU00gc3RhdA0KPiA+ID4gPiBiZWZvcmUgc2VuZGluZyBQTUVfVFVSTl9P
RkYgbWVzc2FnZS4NCj4gPiA+DQo+ID4gPiBXaGF0IGlzIHRoZSBpbmNlbnRpdmUgdG8gc2VuZCBQ
TUVfVHVybl9PZmYgd2hlbiBsaW5rIGlzIG5vdCB1cD8NCj4gPg0KPiA+IFRoZXJlJ3Mgbm8gbmVl
ZCB0byBzZW5kIFBNRV9UdXJuX09mZiB3aGVuIGxpbmsgaXMgbm90IHVwLg0KPiA+DQo+ID4gQnV0
IGEgbGluay11cCBjaGVjayBpcyBpbmhlcmVudGx5IHJhY3kgYmVjYXVzZSB0aGUgbGluayBtYXkg
Z28gZG93bg0KPiA+IGJldHdlZW4gdGhlIGNoZWNrIGFuZCB0aGUgUE1FX1R1cm5fT2ZmLiAgU2lu
Y2UgaXQncyBpbXBvc3NpYmxlIGZvcg0KPiA+IHNvZnR3YXJlIHRvIGd1YXJhbnRlZSB0aGUgbGlu
ayBpcyB1cCwgdGhlIFJvb3QgUG9ydCBzaG91bGQgYmUgYWJsZSB0bw0KPiA+IHRvbGVyYXRlIGF0
dGVtcHRzIHRvIHNlbmQgUE1FX1R1cm5fT2ZmIHdoZW4gdGhlIGxpbmsgaXMgZG93bi4NCj4gPg0K
PiA+IFNvIElNTyB0aGVyZSdzIG5vIG5lZWQgdG8gY2hlY2sgd2hldGhlciB0aGUgbGluayBpcyB1
cCwgYW5kIGNoZWNraW5nDQo+ID4gZ2l2ZXMgdGhlIG1pc2xlYWRpbmcgaW1wcmVzc2lvbiB0aGF0
ICJ3ZSBrbm93IHRoZSBsaW5rIGlzIHVwIGFuZA0KPiA+IHRoZXJlZm9yZSBzZW5kaW5nIFBNRV9U
dXJuX09mZiBpcyBzYWZlLiINCj4gPg0KPiANCj4gSSBhZ3JlZSB0aGF0IHRoZSBjaGVjayBpcyBy
YWN5IChub3Qgc3VyZSBpZiB0aGVyZSBpcyBhIGJldHRlciB3YXkgdG8gYXZvaWQgdGhhdCksDQo+
IGJ1dCBpZiB5b3Ugc2VuZCB0aGUgUE1FX1R1cm5fT2ZmIHVuY29uZGl0aW9uYWxseSwgdGhlbiBp
dCB3aWxsIHJlc3VsdCBpbg0KPiBMMjMgUmVhZHkgdGltZW91dCBhbmQgdXNlcnMgd2lsbCBzZWUg
dGhlIGVycm9yIG1lc3NhZ2UuDQo+IA0KSSB1bmRlcnN0YW5kIE1hbml2YW5uYW4nIHMgY29uY2Vy
bnMuDQpXaGVuIGNoZWNrIHRoZSBsaW5rIGlzIHVwIG9yIG5vdCBiZWZvcmUgZHVtcGluZyBlcnJv
ciBtZXNzYWdlLCANCnRoZXJlIGlzIGFub3RoZXIgY2hlY2sgcmFjeS4NCkhvdyBhYm91dCB0byBy
ZXBsYWNlIHRoZSBkZXZfZXJyKCkgYnkgZGV2X2luZm8oKSwgYW5kIG5vIGVycm9yIHJldHVybj8N
CldoYXRldmVyIHRoZSB0aW1lb3V0IGlzIGNhdXNlZCBieSBubyBFUCBjb25uZWN0ZWQgb3Igc29t
ZXRoaW5nIGVsc2UuIEp1c3QNCmluZm9ybSB1c2VyIHRoZSByZWFsIHN0YXQgaXQgaXMuDQoNCkJl
c3QgUmVnYXJkcw0KUmljaGFyZCBaaHUNCg0KPiA+ID4gPiBSZW1vdmUgdGhlIEwyIHBvbGwgdG9v
LCBhZnRlciB0aGUgUE1FX1RVUk5fT0ZGIG1lc3NhZ2UgaXMgc2VudA0KPiA+ID4gPiBvdXQuICBC
ZWNhdXNlIHRoZSByZS1pbml0aWFsaXphdGlvbiB3b3VsZCBiZSBkb25lIGluDQo+ID4gPiA+IGR3
X3BjaWVfcmVzdW1lX25vaXJxKCkuDQo+ID4gPg0KPiA+ID4gQXMgS3Jpc2huYSBleHBsYWluZWQs
IGhvc3QgbmVlZHMgdG8gd2FpdCB1bnRpbCB0aGUgZW5kcG9pbnQgYWNrcyB0aGUNCj4gPiA+IG1l
c3NhZ2UgKGp1c3QgdG8gZ2l2ZSBpdCBzb21lIHRpbWUgdG8gZG8gY2xlYW51cHMpLiBUaGVuIG9u
bHkgdGhlDQo+ID4gPiBob3N0IGNhbiBpbml0aWF0ZSBEM0NvbGQuIEl0IG1hdHRlcnMgd2hlbiB0
aGUgZGV2aWNlIHN1cHBvcnRzIEwyLg0KPiA+DQo+ID4gVGhlIGltcG9ydGFudCB0aGluZyBoZXJl
IGlzIHRvIGJlIGNsZWFyIGFib3V0IHRoZSAqcmVhc29uKiB0byBwb2xsIGZvcg0KPiA+IEwyIGFu
ZCB0aGUgKmV2ZW50KiB0aGF0IG11c3Qgd2FpdCBmb3IgTDIuDQo+ID4NCj4gPiBJIGRvbid0IGhh
dmUgYW55IERlc2lnbldhcmUgc3BlY3MsIGJ1dCB3aGVuIGR3X3BjaWVfc3VzcGVuZF9ub2lycSgp
DQo+ID4gd2FpdHMgZm9yIERXX1BDSUVfTFRTU01fTDJfSURMRSwgSSB0aGluayB3aGF0IHdlJ3Jl
IGRvaW5nIGlzIHdhaXRpbmcNCj4gPiBmb3IgdGhlIGxpbmsgdG8gYmUgaW4gdGhlIEwyL0wzIFJl
YWR5IHBzZXVkby1zdGF0ZSAoUENJZSByNi4wLCBzZWMNCj4gPiA1LjIsIGZpZyA1LTEpLg0KPiA+
DQo+ID4gTDIgYW5kIEwzIGFyZSBzdGF0ZXMgd2hlcmUgbWFpbiBwb3dlciB0byB0aGUgZG93bnN0
cmVhbSBjb21wb25lbnQgaXMNCj4gPiBvZmYsIGkuZS4sIHRoZSBjb21wb25lbnQgaXMgaW4gRDNj
b2xkIChyNi4wLCBzZWMgNS4zLjIpLCBzbyB0aGVyZSBpcw0KPiA+IG5vIGxpbmsgaW4gdGhvc2Ug
c3RhdGVzLg0KPiA+DQo+ID4gVGhlIFBNRV9UdXJuX09mZiBoYW5kc2hha2UgaXMgcGFydCBvZiB0
aGUgcHJvY2VzcyB0byBwdXQgdGhlDQo+ID4gZG93bnN0cmVhbSBjb21wb25lbnQgaW4gRDNjb2xk
LiAgSSB0aGluayB0aGUgcmVhc29uIGZvciB0aGlzIGhhbmRzaGFrZQ0KPiA+IGlzIHRvIGFsbG93
IGFuIG9yZGVybHkgc2h1dGRvd24gb2YgdGhhdCBjb21wb25lbnQgYmVmb3JlIG1haW4gcG93ZXIg
aXMNCj4gPiByZW1vdmVkLg0KPiA+DQo+ID4gV2hlbiB0aGUgZG93bnN0cmVhbSBjb21wb25lbnQg
cmVjZWl2ZXMgUE1FX1R1cm5fT2ZmLCBpdCB3aWxsIHN0b3ANCj4gPiBzY2hlZHVsaW5nIG5ldyBU
TFBzLCBidXQgaXQgbWF5IGFscmVhZHkgaGF2ZSBUTFBzIHNjaGVkdWxlZCBidXQgbm90DQo+ID4g
eWV0IHNlbnQuICBJZiBwb3dlciB3ZXJlIHJlbW92ZWQgaW1tZWRpYXRlbHksIHRoZXkgd291bGQg
YmUgbG9zdC4gIE15DQo+ID4gdW5kZXJzdGFuZGluZyBpcyB0aGF0IHRoZSBsaW5rIHdpbGwgbm90
IGVudGVyIEwyL0wzIFJlYWR5IHVudGlsIHRoZQ0KPiA+IGNvbXBvbmVudHMgb24gYm90aCBlbmRz
IGhhdmUgY29tcGxldGVkIHdoYXRldmVyIG5lZWRzIHRvIGJlIGRvbmUgd2l0aA0KPiA+IHRob3Nl
IFRMUHMuICAoVGhpcyBpcyBiYXNlZCBvbiB0aGUgTDIvTDMgZGlzY3Vzc2lvbiBpbiB0aGUgTWlu
ZHNoYXJlDQo+ID4gUENJZSBib29rOyBJIGhhdmVuJ3QgZm91bmQgY2xlYXIgc3BlYyBjaXRhdGlv
bnMgZm9yIGFsbCBvZiBpdC4pDQo+ID4NCj4gPiBJIHRoaW5rIHdhaXRpbmcgZm9yIEwyL0wzIFJl
YWR5IGlzIHRvIGtlZXAgdXMgZnJvbSB0dXJuaW5nIG9mZiBtYWluDQo+ID4gcG93ZXIgd2hlbiB0
aGUgY29tcG9uZW50cyBhcmUgc3RpbGwgdHJ5aW5nIHRvIGRpc3Bvc2Ugb2YgdGhvc2UgVExQcy4N
Cj4gPg0KPiANCj4gTm90IGp1c3QgZGlzcG9zaW5nIFRMUHMgYXMgcGVyIHRoZSBzcGVjLCBtb3N0
IGVuZHBvaW50cyBhbHNvIG5lZWQgdG8gcmVzZXQNCj4gdGhlaXIgc3RhdGUgbWFjaGluZSBhcyB3
ZWxsIChpZiB0aGVyZSBpcyBhIHdheSBmb3IgdGhlIGVuZHBvaW50IHN3IHRvIGRlbGF5DQo+IHNl
bmRpbmcNCj4gTDIzIFJlYWR5KS4NCj4gDQo+ID4gU28gSSB0aGluayBldmVyeSBjb250cm9sbGVy
IHRoYXQgdHVybnMgb2ZmIG1haW4gcG93ZXIgbmVlZHMgdG8gd2FpdA0KPiA+IGZvciBMMi9MMyBS
ZWFkeS4NCj4gPg0KPiA+IFRoZXJlJ3MgYWxzbyBhIHJlcXVpcmVtZW50IHRoYXQgc29mdHdhcmUg
d2FpdCBhdCBsZWFzdCAxMDAgbnMgYWZ0ZXINCj4gPiBMMi9MMyBSZWFkeSBiZWZvcmUgdHVybmlu
ZyBvZmYgcmVmY2xvY2sgYW5kIG1haW4gcG93ZXIgKHNlYw0KPiA+IDUuMy4zLjIuMSkuDQo+ID4N
Cj4gDQo+IFJpZ2h0LiBVc3VhbGx5LCB0aGUgZGVsYXkgYWZ0ZXIgUEVSU1QjIGFzc2VydCB3b3Vs
ZCBtYWtlIHN1cmUgdGhpcywgYnV0IGluDQo+IGxheWVyc2NhcGUgZHJpdmVyICh1c2VyIG9mIGR3
X3BjaWVfc3VzcGVuZF9ub2lycSkgSSBkb24ndCBzZWUgcG93ZXIvcmVmY2xrDQo+IHJlbW92YWwu
DQo+IA0KPiBSaWNoYXJkIFpodS9GcmFuaywgdGhvdWdodHM/DQo+IA0KPiAtIE1hbmkNCj4gDQo+
IC0tDQo+IOCuruCuo+Cuv+CuteCuo+CvjeCuo+CuqeCvjSDgrprgrqTgrr7grprgrr/grrXgrq7g
r40NCg==

