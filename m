Return-Path: <linux-pci+bounces-12949-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6E3971941
	for <lists+linux-pci@lfdr.de>; Mon,  9 Sep 2024 14:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A4C71F229DB
	for <lists+linux-pci@lfdr.de>; Mon,  9 Sep 2024 12:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D021B5ECA;
	Mon,  9 Sep 2024 12:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="YmxPd4f4"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2062.outbound.protection.outlook.com [40.107.22.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898CE1B3F1E;
	Mon,  9 Sep 2024 12:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725884630; cv=fail; b=WssHQFreEaRpDpYyvxdhpo4Qnrx9VSaG9SBTqZzaqtWp9oBGO8vSi2H9TUmpGxGRmlFLBoU4Nh/Uu75kCH0c5kYHMVaqcRf2udUYhOYPsi7V8s0HoYNBetKISSs3PTYUsjokd4h0BNKs0W3P0KEn9+rGWypYSzdh7Q9X1ZlODb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725884630; c=relaxed/simple;
	bh=YCPzXqq673F+68aOVrzYcm1u9Kh2nsBJ/DOB5AUzpug=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=C2b4U3kYmjItbBAg4n9NOO9eMqJ71XZGtrhKz/rh/71V6YRqwIquVp11gWv8ispQ5SQKurahODu5FAFn13h32WG6vtz8exmJSNqu3CVWAm+sLi4DOieMa8tMDIsSgVwk+FV/yWPgejhjRC+TTo61y0Y78CLypOBDy38LHd/7Hao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=YmxPd4f4; arc=fail smtp.client-ip=40.107.22.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YGLMitGfDBm8CyX+WUWu46SZEpDGgO1Xs2Z/Z8J7rejMJEZiVfSUKZ8AIwkBgmiRW8URLcWaNSXbdzvfQXjkd/OgBkc+Cz+tZBuAmXUK38YdarhiELFimnKQwdGvKJUL11HbwbW97kcCkwdAxSz2zF2zcml0ygPwAEH7UD938rmCmnI+IHiBMiVpxrM7DS2ynmQoupeRTyRgCeTcQM7ra/x2Oc1zb1uZGI0JWuHmVpQmmc97r2180kvh9tc62v9i8KQDZ9A0bCQJhjKcl4itAfCKaAW9XlJno7l45Kk/bXM22iHZe7twYhPkuoZnFCNilP+X1PTKClQV90MaeFuqOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3a6uL8VzT5RpspXiZAbAWtM6DrGsk3toQtfuu9NWkl0=;
 b=U2uUuOZFYDWi3QnJNIu7naiODb3qbRSdRmbZnYiEqk4r3GbgUzfYu0eS23hw4l+CVumtL9GBbtDwkDwNqxNkMzpRSxmW8wW5o2+YA9eBV3xnAsk3k2y0z2Cp2iLAmeDcYxnpodlc22gu0xk5b+yUpDjuByBaMaT0mVse8rdGzuRuw+qEOO4dWtUPtpoxw01hD6G88csu9Lsdnj5QOfRTh+d7YrSpJdcg+rZF4ZUOaZ5Pr1c6+WEk+v1DYs1T0SRxGTI0oNOGeMMGm+u5LqUXpenJRixN57hJuda8u5pgcfMKzZ1utgXIXe0RCL8nX6ScGrG5D75SNKBI6KXoXMxaFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3a6uL8VzT5RpspXiZAbAWtM6DrGsk3toQtfuu9NWkl0=;
 b=YmxPd4f4YtSesMo8gIs/OCZ+bJkdPrive1iBSvJ18CMZgYeC3ZtPDbVEgjKtwZeIEHRVmYts1miULx1oOB4etHgs5a3fvSdGGfanafHsNMy3CUSJsXi31CJpa5lei7Ibvj0wDEYsBjUbijkH6jpTdLsI5bYP/C55IR+EoQWsv1QU1GMkf3cbDONxTUBNfC7Lws3qUo34CwKV0x766qDtKJUt/GyIawO0qYI8OzUVFEI5x9uy9DqEy26n3tRXQfR4DHjN+Ulvz9G7q8UjGDS16TXsx9U448jijr3IZ8GDelQgGTOCgfaS5VcxTvx4If9bIAV4bEE2axjKbmpKSh130w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PR3PR10MB3866.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Mon, 9 Sep
 2024 12:23:45 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.7939.022; Mon, 9 Sep 2024
 12:23:45 +0000
Message-ID: <82047fad-6974-4461-a1a2-c90b171ff299@siemens.com>
Date: Mon, 9 Sep 2024 14:23:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/7] dt-bindings: PCI: ti,am65: Extend for use with PVU
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pci@vger.kernel.org, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Bao Cheng Su <baocheng.su@siemens.com>, Hua Qian Li
 <huaqian.li@siemens.com>, Diogo Ivo <diogo.ivo@siemens.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Bjorn Helgaas <bhelgaas@google.com>
References: <cover.1725816753.git.jan.kiszka@siemens.com>
 <33d08f61fe9bd692da0eceab91209832bf16e804.1725816753.git.jan.kiszka@siemens.com>
 <n5l36lo6at3yfbexqc5wcxgxop5wwfzldhhm43rwr6qy2epf7a@jq7l6wiyvydc>
 <0f2c79b5-2aa8-4d4c-b568-e74876fd6ecd@siemens.com>
 <91f9c0fc-c9bc-43ac-917c-b1aa86f53f97@kernel.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <91f9c0fc-c9bc-43ac-917c-b1aa86f53f97@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0192.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PR3PR10MB3866:EE_
X-MS-Office365-Filtering-Correlation-Id: 52833246-76ab-4a95-89f0-08dcd0ca3fb4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V1BkaC9EZnZXYk0yK2poc204VXZETGkrZEROQmJPYm5lM2w1UEZKRmdxbGZ2?=
 =?utf-8?B?SEpEUEdjZEs3ZzlNeDdpSmJvOTd3b1ZLM0pPMlhHeno5QnpZRlJIN0V1RHB0?=
 =?utf-8?B?RUl3MVFZR3JDMlA0WjRrdllKS3dxclpDK2xmOUM2WmhaWVlreXdOekFFdm9m?=
 =?utf-8?B?ODVYaWNYeTVmSDI2M0E1US9SR09SL0VsdFV6Z3lLVHdQQ2xYcnl4REJXYmpD?=
 =?utf-8?B?dUJTc3pDdGRUaGFIbVZpVk52NlN5QjhzM3lEcWI4T1FUVkdQUFFqL2I1T3Rh?=
 =?utf-8?B?ZE9XU3hYS2xNZjZlOVR6VVZzMzNvNjhQbSttemhOWXh3aVFIbk1MaGcvWnpr?=
 =?utf-8?B?OC9TbEs3SytRY0hEeHVHR1JCNDA3c2JDR1pPaHRaa0tkcG1RRkFFNGpGNk1v?=
 =?utf-8?B?OWFhUUVQN3FEcTFZNVhHUlJXY3F5bExsVDlMakpIZ3ZnQVBFNXVGUVBrZDIx?=
 =?utf-8?B?RW84WmgyWjFDOElPdVUxb3c5elM1STludVpCSk5QOG1LbHdaZkk2K0lEUVV3?=
 =?utf-8?B?VFBHNjBxcTVTdkY5SXdaTjljQVJrc1l0MzJiZkptWC85M3gzY1FBY1R4bjB4?=
 =?utf-8?B?cXRqNllrWXhIUE5PRWxYUmFQTHB3YUs4V281SmZFcjRZUnArYlFiYlhzWXBJ?=
 =?utf-8?B?QTc2OW1UMVlSN1RwZElxclZ0eHduZ1ZHcG1vVkRUS1J4dTdzY25xUHlxMFFw?=
 =?utf-8?B?Tnh3ZGQ2Y2tITGNrUGQ5MTM1T3hFK3BmQmh1Szc0aG15QlVJLytRc3FVZy83?=
 =?utf-8?B?ZXliV3l5N0diaHJYcEJiR1VxSWJQVldWcStwUFY1VHNrY2dCNFo3QkhMTHdr?=
 =?utf-8?B?SWF3dDFEeVRiMWlJKzQ1clhUZFJDNkdENG5nenFoK1JFemFrRnBNQnBqZk9s?=
 =?utf-8?B?Q2h5QUpsMHFkblArb3NCckFLeDdaSkxyeXRMUFJCNWErN3J1MVN1UE5zcmRO?=
 =?utf-8?B?QjdaT2szbVByMVRVenNjRHo0VytCM0FEalVMbVpzd0JQT2FPbUdxVkZ4enBa?=
 =?utf-8?B?S2tQQWZyZndVMmFQbFF0Rm4yVFVWaG9hUzI1RVJDUWdVR1RDZGJSeDV2L1BP?=
 =?utf-8?B?TUpqQ3lFT1pzVDJBSTlRWHROOHJVMzVjdGIvem9vUGhPekVGZmZqRXY3MVFw?=
 =?utf-8?B?aGJKTXI4akgxOUkvcGM3V1ZJV3ZNZExEWEFoRnByTDFRQ09UYXdKcm03bUls?=
 =?utf-8?B?OTZLaGxKejVPNVNtaE1CTU5YV2lZSnhDWlVhTnJTUjdicHd6WldFL2tkSzdv?=
 =?utf-8?B?dW82SW50UlE4dlVsRlBjUExmS1hXdnNQUXFJaitqMndVbUtYS1hxcWMyTTh2?=
 =?utf-8?B?MXY4Wko3SlBiTU1WMFRBSmw3SkllL2hHVzZDeDIzd3Y5ZW40M1pubHJFZzhS?=
 =?utf-8?B?VUlDcWpMc3VDU1F4eHNlbjcycnZyNlNqaHVPOWZyUTJBYllpanJMeSt2QUpT?=
 =?utf-8?B?RGJETGVEYmhvajVMd21Xc2E2YUw3Y3hDU1FQUXZRaFM3R1pDbkFmVUJMYWxi?=
 =?utf-8?B?TVZwMmZuVEtpaktHS1BVMDc4Y1hLVjlFbmg5U29leHJSRFdHZUJaUGZSSTNV?=
 =?utf-8?B?bzF4NEgvOUdOTklvNTN2bDdSS25qNmpTZy9XaSt6RGRaMmk5YkRwUGQ1YUE2?=
 =?utf-8?B?NUtLc2ZRdloyMTlaSFpBMzNuV0tjZERQZDJYWnZpNzJsYkd1alhWR28zd0pa?=
 =?utf-8?B?YTU5SzMvV3BBL1BNRlRENk5aWW1uTFZ0VzAxR2dIU05vcUxQRll3bWVBK0du?=
 =?utf-8?Q?zWhkGEDbhf3PCZQP24=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NThrd0xnZHJBQWhBYmI5cUtxNjYxaWQ1VGVvdHJaNHAzZ3hxNmVmSFhydzhw?=
 =?utf-8?B?SmRFSU1ML2hnSWlUbkI0K1cwREkvSll4Vm8zc1JLZmI2bi9LMUczK3lpdzVH?=
 =?utf-8?B?YlNXZHBjbjUwUlY2OFZ0NStNK3NuMXJ5b3pzU0o4cEd3aHM3TGNVOHVKNldW?=
 =?utf-8?B?eGphZjlOVldIaXJWSHQ2MDI2WXI3T1kvTzBTaVFiYmtIUXN1STlvMEUxVnd3?=
 =?utf-8?B?TENLS1k2TkYvbEhDWWxIdmdjNXZhdHBJTTBUMnMwYnRYc29Md3JCR29xS0pl?=
 =?utf-8?B?YmVYUGZ3REUreVJLeDJhR2ZjWnV6QmF6amZ2aUdNTWNvYU93WXJTbjVDQm1t?=
 =?utf-8?B?QlAxZ1Urb2pFOFFNZDhlVk54ZGl4Z0NNN3ZKdXdORFpCbTVCajJCV0trRTl5?=
 =?utf-8?B?Qm41WDNnTWFwNytRb1RuU1VXVi9pQUpVWEhGSWRINzMzT3JST0NCdXhIQklU?=
 =?utf-8?B?QzM4S2oxZXRYV1VZWGIxR01RTE8rNUxSOVMycTZnVmRkcG5pb05TdWFKY2xj?=
 =?utf-8?B?cHlDckc2Ky9ZdGxKNWN4dGYxMC8zK29NYUE4RHgxT2VvSTJqRXZONWROWDJJ?=
 =?utf-8?B?VEFVRzVSRGNvMTBqYmNndEhHbVlVWE1xQTNRakg4ejVZTE94cmlDaldtaFVn?=
 =?utf-8?B?USs1MHBGS0kxK044QkVRWFI1UG43dlpKZnl0UUtWbExKUWJUNHlpNmxZVWt0?=
 =?utf-8?B?RkNzT1ZhVjl0TXRMWkxwa0F6dzNSRFUzNHJMNGp0OUpSV016Z0IzQ2M4WWJV?=
 =?utf-8?B?MWdaRWhUeGtidnJBU1h0VlNsVVdOZFduTVhnU0VPbnA0RFYwNzNOc0VZYytS?=
 =?utf-8?B?MGdob3dEaFYzS1pxbzRTYzZ4VVRVMFRPTGlKa3JpVGxqSWVmb0diVWZjR1hP?=
 =?utf-8?B?YjZRRXl2V2t5ZEpDYUU1akVQNThyVXFsclJacXo5a0VucmlrZEZ3VzdUTU0r?=
 =?utf-8?B?QzdzUUVhRWlHdFJDck1BaVdXTDh0d3JYNHNudGdGaFBqcGkrRDJtQmZhd0Z4?=
 =?utf-8?B?bDdCdzRhN1lSdWFGd1NISzM2V2pONXFLdEFXWkhpVEVxWkg3NVZVYUlxMkEy?=
 =?utf-8?B?UEVDN0V3aGRiRzRkMHlSa21FRmxYeEFiMTkrM2NOL20zNzRVMnB1T1Z5VzZE?=
 =?utf-8?B?OE1OaTR3dmJCOXd3WlZwSURXc2YxeUljQmwyY3BLeXBpelh5N0JkYTEydUll?=
 =?utf-8?B?bjRyR0F3L1p4VHN1ci9EdVRDRnFHcGcwLys0OTVTcDdsOGNDSnVZaXcvdGJW?=
 =?utf-8?B?OWVUNW55QmRuUlovRjBIa214bS9EclpEb0dyNXRHK25zckR1YjZVc0E3dlVz?=
 =?utf-8?B?UzhmTzFlMzFxTDBhYU05bzdNV2N5d3VyZnJXei9kOGNnSmdzRnJndUFvQVdW?=
 =?utf-8?B?V3AwL2oyVjVDdVUyeEdDcVplbjZCMCtRV3JJcjVHUitjQ3pXMm9ZTTdtZldH?=
 =?utf-8?B?NVVNclhqU3A0c3FySXdyN040aE5tSFZMTjBNdUZxZmVhVmV4Sm02dlJyRDlo?=
 =?utf-8?B?WDdLQlVnbjU5WGh5VnBsa3phRGlTSUVONHFrUzMyejdrUFpWNitGa1pZODZF?=
 =?utf-8?B?M24rckpLMGhKR2g3K0JlQzJJWWREbnhJbzRVQWI5RjgvSTR2NDdwcGdGanlx?=
 =?utf-8?B?b29JN1dZUytCRjJRWFhWMHNMUFMxdGJEcTBxdTV4akpSMHVnamJnZXRNNkpm?=
 =?utf-8?B?R3QvYW16cGFmVFlDcDc3KzVpY1gzMkR6ZFdzS2xyN0p3bDVOTWQyZXovc05t?=
 =?utf-8?B?TVZMNVVjaHJ6TGViTUllM1k4cEVrQjJJMXpEYjVpTmlHU3B0Qzg0akl6V3d0?=
 =?utf-8?B?ci8rays1OTFSR2dXaFdGTnNqL05LRUhPaTcyY2Z0QllWL3E2VVVUNzZucjVv?=
 =?utf-8?B?SEc2bUo2T3hnUCtXNDRQaC94QmMrRE96eDRBSHVCRXJ4R01vQmVrWVR4RjZX?=
 =?utf-8?B?djZWWGZ4emduRlpQOGF3WXdpWXloWEhqMmFodWhNKzlPY3U3TnpwckJJQmQ5?=
 =?utf-8?B?SEJqT2NpZDhMNXNGemtHeEpnbXRqMnVBbzZFd013U1lHMDZNVVRkbXdidXBp?=
 =?utf-8?B?SmpVRlAyQTAvdFliRm9uZWtnSWRMaVNSNG5HMmI2K2xaM2JoeGVYOUcyVkV4?=
 =?utf-8?B?MElqTkFhVWFpdytmSWYxUmlEYXlRaHlhQzdadlF6RU55clcrUGRlQkZYVWh5?=
 =?utf-8?B?S3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52833246-76ab-4a95-89f0-08dcd0ca3fb4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 12:23:45.1800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Gzf5AdhWVXwfWuRlxkgt6yhKE0+/XTIK8pKcIjFkKgMLqZvYfwYUEDc3uEg84L5AcNgBuHsO8NtADydZFGXlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3866

On 09.09.24 09:49, Krzysztof Kozlowski wrote:
> On 09/09/2024 08:48, Jan Kiszka wrote:
>> On 09.09.24 08:22, Krzysztof Kozlowski wrote:
>>> On Sun, Sep 08, 2024 at 07:32:28PM +0200, Jan Kiszka wrote:
>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>
>>>> The PVU on the AM65 SoC is capable of restricting DMA from PCIe devices
>>>> to specific regions of host memory. Add the optional property
>>>> "memory-regions" to point to such regions of memory when PVU is used.
>>>>
>>>> Since the PVU deals with system physical addresses, utilizing the PVU
>>>> with PCIe devices also requires setting up the VMAP registers to map the
>>>> Requester ID of the PCIe device to the CBA Virtual ID, which in turn is
>>>> mapped to the system physical address. Hence, describe the VMAP
>>>> registers which are optional unless the PVU shall be used for PCIe.
>>>>
>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>> ---
>>>> CC: Lorenzo Pieralisi <lpieralisi@kernel.org>
>>>> CC: "Krzysztof Wilczyński" <kw@linux.com>
>>>> CC: Bjorn Helgaas <bhelgaas@google.com>
>>>> CC: linux-pci@vger.kernel.org
>>>> ---
>>>>  .../bindings/pci/ti,am65-pci-host.yaml        | 29 +++++++++++++++++--
>>>>  1 file changed, 26 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
>>>> index 0a9d10532cc8..0c297d12173c 100644
>>>> --- a/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
>>>> +++ b/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
>>>> @@ -20,14 +20,18 @@ properties:
>>>>        - ti,keystone-pcie
>>>>  
>>>>    reg:
>>>> -    maxItems: 4
>>>> +    minItems: 4
>>>> +    maxItems: 6
>>>>  
>>>>    reg-names:
>>>> +    minItems: 4
>>>>      items:
>>>>        - const: app
>>>>        - const: dbics
>>>>        - const: config
>>>>        - const: atu
>>>> +      - const: vmap_lp
>>>> +      - const: vmap_hp
>>>>  
>>>>    interrupts:
>>>>      maxItems: 1
>>>> @@ -83,13 +87,30 @@ if:
>>>>      compatible:
>>>>        enum:
>>>>          - ti,am654-pcie-rc
>>>> +
>>>>  then:
>>>> +  properties:
>>>> +    memory-region:
>>>
>>> I think I said it two times already. You must define properties in
>>> top-level. That's how we expect, that's how dtschema works (even if it
>>> works fine otherwise, it's not always that case), that's how almost all
>>> bindings are written.
>>
>> Look, if you have such rules, also enhance the checker, or people like
>> me will continue to work intuitively. Add reasoning along that as well,
> 
> That would be ideal, but I also asked to do this twice. It does not
> matter if dtschema  or me tells you this, if you do not implement it.
> 
>> would help further to reduce your review effort. The current situation
>> with rather fuzzy results from the checker and strange mechanisms inside
>> (see my maxItems finding) is not very helpful IMHO.
>>
>> I this concrete case, I would add this item top-level, just to set
>> maxItems to 0 for ti,keystone-pcie? Not a pattern I'm finding anywhere.
>> Or do we have to allow memory-regions for all compatibles now?
> 
> Is it really not suitable for all the compatibles? Maybe these are quite
> different devices in such case?
> 
> But if it is not really suitable, then you can disallow it for other
> variants with :false. This is also explicitly documented in example-schema:
> https://elixir.bootlin.com/linux/v5.19/source/Documentation/devicetree/bindings/example-schema.yaml#L212
> 

I will address this via documentation: The property is not hardware
related but permits swiotlb. It can be applied to devices as well that
have no hardware enforcement, unlike the am654.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


