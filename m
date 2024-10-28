Return-Path: <linux-pci+bounces-15485-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA2F9B39FC
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2024 20:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98AF0282DA8
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2024 19:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47551E04A9;
	Mon, 28 Oct 2024 19:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YQgvxOlr"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2044.outbound.protection.outlook.com [40.107.20.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4101E009E;
	Mon, 28 Oct 2024 19:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730142381; cv=fail; b=GCsTZZGTw+dIPwz2MrGSTbS18NP0gAWVGOotUsV2Ogmit3o0uSe51uwAZGqTks/H9ompI4QAMhMnUgtyQfQtSDm/BaGYLc/m4GiX01FbDQDq37ZjKCNL0yVH29XNcBLT5Ep343xGl0blucgKOIXQhUrh4CpNMQTU3Jv2LcLbBDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730142381; c=relaxed/simple;
	bh=xiXouNpVhhagOvQdXFLvlfaRhzcVDADSufDDS7ir13g=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=KwW1PUJjcTlWb8kyFN9X1MvqP27//CZW4IqNv2vhV38cTowPwGFvFMyPFAWjZi7xte+g8XXY4gXn1fAKj9e379JZ9I+ViXKv5UqsUMxenJngvvRdFbedUzQw6Ydg+CwQ2lX6SQdUNuqJY3OhWeWfqLwChWev7nVMlnP0DRQi47k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YQgvxOlr; arc=fail smtp.client-ip=40.107.20.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k00L9f9BI4YCq9756XeJ287hUTvHIJVk5PNGhHPIeReAf1qxwDXzzyBz+iH8dhyaGWJTNz7p2kwXxNskAFJCoiP6j4KM4zFGmUhun8lNHjM8jLtVmxRqa7YUnjO/15p/Zlx3guCkKoJV33D6mXhRkhQNf4orlZ1rLaMiclh0LWSoVv6gshpGoIhdZ0n1+UywsejgbyXhfGytxKtdS8YMsCpC3YJFzFWBO0ct56/ZqbwOzOuGz/GnBZJM+XjFl/jNcnaOfKMLGfWqyj6QsKJuD5H80EX7AkniUt3lyHlNJAp3nQKewXUjt9Ca0opLJULjVbmCeQcEdRA9iPL4tGEiSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=72nw29hHFDlpi9crET+L23if2rJ656JTjj/1lPj7nXM=;
 b=jqyNrWEbXumyQ8Jtu1oS6TfvB3nPYiPKXDvoQQyWu1TYdRdsb1WkV4z1poXr8vyEuMVLqvp7r+vM2vDTuTuOoYa3DRBycG95gvO3+0abuxjspkk0LWuZbyp8tt37lmkR5/t6duDy0w3MTdX++ts368YGHrAWAEgo9loaI/1DcWOv35n6rciSD2J4lwp2Dg7GX129UWJ7M6x3ZTWELfLxDB0eIYe/fQy8yzOLC+SAr0vMeQP4TPCUwlUErNhxDumH4nP0XrfC0yTBBWIapJs8/GTnacqrk64XtmDnxxY1vnjZrXlzuLAkdQVH6sZMDs5bVWlsF7huSpfIJrrR+lYAcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=72nw29hHFDlpi9crET+L23if2rJ656JTjj/1lPj7nXM=;
 b=YQgvxOlrCjV0BhbDAPSweEuhr5pwW/M/Alb56QDsrCzbtVLA6H5GHxkB9UUJExh4J13VcgkJ1shQ6aG+GRLCi8f11AQey+EjwBNgspFmvcWv414RUed63n0ynTlkKI8QNo4IlqtFlhhec4j9RtUhlmC9uN7vRMvnRrEygEguG1+vWBEOzNTBIMTOtnI2PTbs/EmkQqKS2QUqTFgUARpk+tKzlzj/DglUni4LctNBXKNjUhav2B+LOr/eMUjUlqFeOyooZWdoI9EcaPa5/qZ4POhZhXSRwyFXQUwAD2xEotkVTOoOAOfaFwU82UZo9H4rZ6CsYW9NMcSLEXn87cq5tQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7946.eurprd04.prod.outlook.com (2603:10a6:10:1ec::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Mon, 28 Oct
 2024 19:06:17 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8093.021; Mon, 28 Oct 2024
 19:06:17 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 28 Oct 2024 15:05:56 -0400
Subject: [PATCH v6 2/7] PCI: dwc: Using parent_bus_addr in of_range to
 eliminate cpu_addr_fixup()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241028-pci_fixup_addr-v6-2-ebebcd8fd4ff@nxp.com>
References: <20241028-pci_fixup_addr-v6-0-ebebcd8fd4ff@nxp.com>
In-Reply-To: <20241028-pci_fixup_addr-v6-0-ebebcd8fd4ff@nxp.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 Jingoo Han <jingoohan1@gmail.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, Richard Zhu <hongxing.zhu@nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730142363; l=6907;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=xiXouNpVhhagOvQdXFLvlfaRhzcVDADSufDDS7ir13g=;
 b=1XAtPwmnz6utgJb/RgXFDtavRFJLTmEvREIQo8R68WR2nw0mr9p7AuMh2ILH2KG9QuZC0XOqd
 GVmw+rYESP/AvIAsufScZqwYRpxvl/2uw0EzbJk+uSP9fWALk43Bj0/
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::18) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7946:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ef1ffbe-4d91-4a31-5adc-08dcf78399b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|7416014|376014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dG5jcC9IdVY3TnNUZjJUWWhqYUwvbnlsSmJTblNINTRsM0tCNER0QkZNVEdt?=
 =?utf-8?B?NE0ycmVpamczTnBFWEphN3J3WWtRa1YzYUFQVFpQeGo0UHRFY1pOenMvNWRC?=
 =?utf-8?B?VnVJSzFqMUIyVUpGemJldmFsUVlPUW44UFkxVGpSRXBsZlRwYXB2YklmMmRO?=
 =?utf-8?B?VS9mYzBoZ3RYMlZ1VFJHM0wzSzhObVNMYzZLZlplZkJ1VGpvSmM2SGpvY0FL?=
 =?utf-8?B?bnVHSE9kTkY3VjFoVnVTMmdqTEhDRzM5bXlRZG5yTDR2YXNYcnJBNEJKempp?=
 =?utf-8?B?azBaNlJVR3lFanZsQkNIanBkVkhJZmE2Ui9oOU1IK1c1Q3prV0dwbGdsUTVp?=
 =?utf-8?B?dEFieXF3UUtwZTFLWDJTZFo5M21Jd21FSkU3SytjUld6MHVLbXAzaUZ5N2dm?=
 =?utf-8?B?ZHkzajBhK1gwM3ZiZkxHaEE5UVkrMHRIWmkwTHBxNGt1a1BXaUVpU0hXTlJi?=
 =?utf-8?B?QWx3SzFnbVd1OENNZCtJREk0Y3dYcTREeUlKK1R6Y3RXUUs0ZDhFcmJFaGJ6?=
 =?utf-8?B?TEp4OC84blptN2p6V0srR2NpNTFTMjFMRTlRWVpQWFF0MWZsWjIzZnNuYTYy?=
 =?utf-8?B?T3lYd21oeVlUU2V6VDB0QU1zeVl2MDAxT1lsb2xSVnE0aVRlSWt0TzJYNXBo?=
 =?utf-8?B?WVFJQ1d6TWNzZGlZYi96YjBXdWZkdmNuTFA2SFdKVXF6T05SZGpIdStYV1Iy?=
 =?utf-8?B?bGdmWDZ3M29xOWhLY3M3V2ZMcGpOVktKSnlUUWdtWVVGNkJIUXR0bnF0bWR1?=
 =?utf-8?B?aXNUOFA3T1F2VWhCYm1pQjM3RVRVSlNNeXZCbGxkenhtR3RQTnhxQjROamdK?=
 =?utf-8?B?TDJvcyt5QnMrYzd6Q2dUSnlvS2wyNlV5aWFKc1YrT1VsUHI5WUptMS9Jemor?=
 =?utf-8?B?SG9mUzNRRk9YcUxQaTJuUVNPbGVPNzdXeHhCaFJPalNlQk91SGNLUFVWTWx3?=
 =?utf-8?B?UW1YcDdZWHFCSWt5Tkpzd1l2Yy83YTdUUlQ5L1VzZjFrRXVmRWs3UGl3ZUsx?=
 =?utf-8?B?RlQ5T3ZWckVYM2QzQTZ2MGM0YjdNZjZDRHBPelcwUkNOWUVvTlZHM0VlcUpt?=
 =?utf-8?B?dFVzbExnMEhtZ0RNN2syelFQOHl6ZGhpays3ZzMwQVNqR1ZHeUZ4OW1ONWhv?=
 =?utf-8?B?UGRTeXczOGt0REkvOU56b3RPSHNNaEFRMnhWRk9Ma2xQNnJ3SEo1bHNMUjYr?=
 =?utf-8?B?QllzZTJnMCt1dmNSenNTZW9ZdC9HQW5RMjZOK3ErS2FLdXFKM1hLWlBDaTFs?=
 =?utf-8?B?eFF4Mks1dURsUnJTL1p4NEdUeUF5bDJOZXRGUzg4a3Zzc3RiNlptVFRuWVhj?=
 =?utf-8?B?ZjZyamtmRThnTnE2aXJ3YnR5MVZMM0JydWRpSVNLdGdhZ2FxZFNaRWh5WFAr?=
 =?utf-8?B?bGF5eE5LelRLUFRkYjdqZlRGQjAvN0luYzlpZTBSSWlvL3NDR1M1anpvUUp1?=
 =?utf-8?B?TlYzOSttSjFScm84NHh3MG4zK0lBbEk4a3dCcW9GeDRPSjd4NU96dWcrVjd3?=
 =?utf-8?B?NEVHeFdpRjM1UXlOWjlLL01KdGVtR1hYRUF2akxBek9wQWo4UHVaTW5Hd2c4?=
 =?utf-8?B?TnYrTnNIelFrUk9wZ0FqN1FrM2wyNU44YStJdkNHc1JSY2VCYkRsTGF1N1RS?=
 =?utf-8?B?WkwyWkJpYy9LODcrdkNkQ3IvT0owMis2L2piWXRlenNwd3l5SkdDNDVpVm15?=
 =?utf-8?B?NUI3d3JHZHVMSzkxaXFFb3JVNVhRWFhDbnhLMzUvNk5nMFhmNjY1T2h6bGt6?=
 =?utf-8?B?NVdGRS9mNVI2NkxBZkZnbDIvd1dTM0pYblhxckNGTytuSmJDcUR6b1dqU2dm?=
 =?utf-8?B?VEQrY3VnR0tIK1E4ZWhTaWl4OEJEbXJ2dmVrOXg0OXBEMjVUVXg5ejRFakpp?=
 =?utf-8?Q?aczuh5sg+5ait?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(7416014)(376014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cURaeHZ2bFJZalJNYko0Zzd4T291bExIL3EyVGZheG51c0pDM2RZYk4xUlho?=
 =?utf-8?B?d05SbnM0ajlIMWpWOGVNV1RuMjZwNEJrRFBOVDhGdmU4ZFhJd2szL3ZnL3Ra?=
 =?utf-8?B?cVBRZXV3dUk4TDc5ek4yRHM1dDUwM1NGbmR6RGxDRHJVS053SmM2RDBieC9Y?=
 =?utf-8?B?dWtpZHlaeHh3NjJMQlRJVGFjUzZURDYyTGQ0MHBXZ0xUOVU5dy8xaythd0Vy?=
 =?utf-8?B?d0lGN2VJVU1Rd0Z2aDEwOFdnMEsvV1g2YmV6aUpvRmUrK3RDcVBxaHY2dysv?=
 =?utf-8?B?Q1N5YlArNFZTZUZWL3pwVURsaXhyajVSWWluVlFYejIxUjZVdkxDeFVDdW11?=
 =?utf-8?B?RWRKWS96VUZFRDQ0ZCt0SzF6Y0YySStJaFc5YnUwbWIwUEpFVlJSMFFsbE8x?=
 =?utf-8?B?bkI2NDNEYWwrMS9HbzFQbm9NRFJIbStnTDV3MXZuQnBRRFYxOCt3emVWSkZm?=
 =?utf-8?B?TjBWZWRLZmFlNkM1cCtaSHZXK1Z6ZUVmVlYyV3RwSlEreGJXTy93VkVBaDdV?=
 =?utf-8?B?LzZ5NHozWTh0eVBCMkR6eGR1YXVaVlUyejhtMitKaytIWS9BbnZQeVQwQlFz?=
 =?utf-8?B?UEREZnFyWllxOWV1RkZwa2dJREFUdXh2cjRZZ21pTWpiTlJGZkdyZ2JlZFVC?=
 =?utf-8?B?eStiL0g4amsyb3NLVVBZR2ZRbk9kcXFleFBKbUJ6S01zN0RhQUFVYUFnUkZh?=
 =?utf-8?B?akNEN2VRK3owRlVIb25HaEJKSFlRb1FjaG1aKzMzcVRma21MNDlOT2dja3hU?=
 =?utf-8?B?ODdHR1pDazY4NjQzUDhQbENwZVhSOURwUDU5L3NHNE83WjE5MUlxYk81NWVh?=
 =?utf-8?B?NlNsUXFmdXI0eUhXWDVOaDMwRzlOMWw4dksrSXVSTjZvbXhCbDhaODlUZjRV?=
 =?utf-8?B?VGZiY25UZ2M2dittemcvZkRhWlJOaEp2ZWhVbGRtVGlDQlcrbVQzdUN4NXpW?=
 =?utf-8?B?M2NIUDcvcHcvaVRKR1Q0S0xQc3c3bFRJRE1Ua0tQTU1PNk84M1JaQWpvS1pC?=
 =?utf-8?B?VVBnQVZCSUlSK2taWWovaHVFeVk0clpHZGd4MlFtWndQZWUwMlVVQUtvd2p0?=
 =?utf-8?B?T2hvT25pNnRleW5OaEpMUi9GQnhxUXBEQmdEanYwLyt5SGY1d21UWW0waFJR?=
 =?utf-8?B?eVlZcThXdERaU0VtUFBBVVNsZnpLRHo3eTdUOWlvczRENUFpRmFrZkpNK2dP?=
 =?utf-8?B?SkJsem9GczVLbjF3VklZVEFkQitpUnVhdnpIOWxJUlhWak5sN2dCSyt3MTU1?=
 =?utf-8?B?K2JsUmpYeU1nWXUvQzRWU3loczJSUTdTYWsxUy9yblpEa0M0cmJPenM5TjZ6?=
 =?utf-8?B?MFNaSnZ6K0N1Rm0vcUYyK1FPUTVOL2tNZFlHcUQ3V1FvZHYyN3l1ekQ3MTlS?=
 =?utf-8?B?RDdJeC9ScXJveW5sQk5FVXlZN0ZyRmxMTkRIUktIOWtSQUo3MDVmWi8wK0Rx?=
 =?utf-8?B?OGtxME5nMnZheWROb2Q1M3AzTWhCekdaWWZlYTZRK3VIWjM4Z1o1U0RJRkZY?=
 =?utf-8?B?UU5rWGZxMTIvYjRjYWxESndrRlNrTGFrT3VkK3hKVnM3K0c3QTVrMFJaYi8w?=
 =?utf-8?B?SVZSUSsxcXBidFJCOEh3c3FlK0JFV2tRYVp4UjhDMWREOXQrOURaWkJwK21M?=
 =?utf-8?B?ZlpSOHFCUHJNMkQ3SmNqWWpJRHdVRjVJY0djOERWQmd2SlZMbTJoSms1cG5u?=
 =?utf-8?B?clRKS1Z3ZksvNVlnamhkVlFTeW84K2pEbUd3eDJwMjd4TEM4MFM2VFdEOTZV?=
 =?utf-8?B?TStWdHkwWEVQbTJoeGRHK2QzYkluTFBObklEdUJ3dTM4Mk42WURxREFyV0ZJ?=
 =?utf-8?B?TjhWeFZicUljem92Qmx4bDhnNzUzWlIwM2ZEUS9pU1dhVnE0TUx0MVJ3K2Ux?=
 =?utf-8?B?Ykp2c3orUGJlSGkxSGlvQ0VHY2FHdWFWdGxrUFJPcm55OUtvSGpZSFlySXI0?=
 =?utf-8?B?ZlhzRStyakxXVzlXeVFoZ0QySy95V2ExS1ppcjludTVvU09MSVgxd3FJNkRJ?=
 =?utf-8?B?bWRPRHFoSDd4RldJTm9qa0hBNGFFckM1K2l0OXV6aXJYQys5NHdVYzJmQ3Nj?=
 =?utf-8?B?UXNSSDRUdHNDVkpQdXY3SkhDOTA3V2QzYW9rMTRUS1pEOWY2VWtwckpRc0pB?=
 =?utf-8?Q?F3+hjtGjs+CMbYzShTYzZHuCd?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ef1ffbe-4d91-4a31-5adc-08dcf78399b4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 19:06:17.2531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +H2/7q3a05XVFq77nLUer3jVCQhN6+brmNfuZ1W9SBtiE2eRVbjuA+OH/D7TgPfOyR5R5TGfscue3S7eF5A+rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7946

parent_bus_addr in struct of_range can indicate address information just
ahead of PCIe controller. Most system's bus fabric use 1:1 map between
input and output address. but some hardware like i.MX8QXP doesn't use 1:1
map. See below diagram:

            ┌─────────┐                    ┌────────────┐
 ┌─────┐    │         │ IA: 0x8ff8_0000    │            │
 │ CPU ├───►│   ┌────►├─────────────────┐  │ PCI        │
 └─────┘    │   │     │ IA: 0x8ff0_0000 │  │            │
  CPU Addr  │   │  ┌─►├─────────────┐   │  │ Controller │
0x7ff8_0000─┼───┘  │  │             │   │  │            │
            │      │  │             │   │  │            │   PCI Addr
0x7ff0_0000─┼──────┘  │             │   └──► IOSpace   ─┼────────────►
            │         │             │      │            │    0
0x7000_0000─┼────────►├─────────┐   │      │            │
            └─────────┘         │   └──────► CfgSpace  ─┼────────────►
             BUS Fabric         │          │            │    0
                                │          │            │
                                └──────────► MemSpace  ─┼────────────►
                        IA: 0x8000_0000    │            │  0x8000_0000
                                           └────────────┘

bus@5f000000 {
	compatible = "simple-bus";
	#address-cells = <1>;
	#size-cells = <1>;
	ranges = <0x80000000 0x0 0x70000000 0x10000000>;

	pcie@5f010000 {
		compatible = "fsl,imx8q-pcie";
		reg = <0x5f010000 0x10000>, <0x8ff00000 0x80000>;
		reg-names = "dbi", "config";
		#address-cells = <3>;
		#size-cells = <2>;
		device_type = "pci";
		bus-range = <0x00 0xff>;
		ranges = <0x81000000 0 0x00000000 0x8ff80000 0 0x00010000>,
			 <0x82000000 0 0x80000000 0x80000000 0 0x0ff00000>;
	...
	};
};

Term internal address (IA) here means the address just before PCIe
controller. After ATU use this IA instead CPU address, cpu_addr_fixup() can
be removed.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Chagne from v5 to v6
-add comments for of_property_read_reg().

Change from v4 to v5
- remove confused 0x5f00_0000 range in sample dts.
- reorder address at above diagram.

Change from v3 to v4
- none

Change from v2 to v3
- %s/cpu_untranslate_addr/parent_bus_addr/g
- update diagram.
- improve commit message.

Change from v1 to v2
- update because patch1 change get untranslate address method.
- add using_dtbus_info in case break back compatibility for exited platform.
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 49 +++++++++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.h      |  8 ++++
 2 files changed, 57 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 3e41865c72904..a4f2578700eb3 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -418,6 +418,34 @@ static void dw_pcie_host_request_msg_tlp_res(struct dw_pcie_rp *pp)
 	}
 }
 
+static int dw_pcie_get_untranslate_addr(struct dw_pcie *pci, resource_size_t pci_addr,
+					resource_size_t *i_addr)
+{
+	struct device *dev = pci->dev;
+	struct device_node *np = dev->of_node;
+	struct of_range_parser parser;
+	struct of_range range;
+	int ret;
+
+	if (!pci->using_dtbus_info) {
+		*i_addr = pci_addr;
+		return 0;
+	}
+
+	ret = of_range_parser_init(&parser, np);
+	if (ret)
+		return ret;
+
+	for_each_of_pci_range(&parser, &range) {
+		if (pci_addr == range.bus_addr) {
+			*i_addr = range.parent_bus_addr;
+			break;
+		}
+	}
+
+	return 0;
+}
+
 int dw_pcie_host_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -427,6 +455,7 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 	struct resource_entry *win;
 	struct pci_host_bridge *bridge;
 	struct resource *res;
+	int index;
 	int ret;
 
 	raw_spin_lock_init(&pp->lock);
@@ -440,6 +469,20 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 		pp->cfg0_size = resource_size(res);
 		pp->cfg0_base = res->start;
 
+		if (pci->using_dtbus_info) {
+			index = of_property_match_string(np, "reg-names", "config");
+			if (index < 0)
+				return -EINVAL;
+			/*
+			 * Retrieve the parent bus address of PCI config space.
+			 * If the parent bus ranges in the device tree provide
+			 * the correct address conversion information, set
+			 * 'using_dtbus_info' to true, The 'cpu_addr_fixup()'
+			 * can be eliminated.
+			 */
+			of_property_read_reg(np, index, &pp->cfg0_base, NULL);
+		}
+
 		pp->va_cfg0_base = devm_pci_remap_cfg_resource(dev, res);
 		if (IS_ERR(pp->va_cfg0_base))
 			return PTR_ERR(pp->va_cfg0_base);
@@ -462,6 +505,9 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 		pp->io_base = pci_pio_to_address(win->res->start);
 	}
 
+	if (dw_pcie_get_untranslate_addr(pci, pp->io_bus_addr, &pp->io_base))
+		return -ENODEV;
+
 	/* Set default bus ops */
 	bridge->ops = &dw_pcie_ops;
 	bridge->child_ops = &dw_child_pcie_ops;
@@ -733,6 +779,9 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 		atu.cpu_addr = entry->res->start;
 		atu.pci_addr = entry->res->start - entry->offset;
 
+		if (dw_pcie_get_untranslate_addr(pci, atu.pci_addr, &atu.cpu_addr))
+			return -EINVAL;
+
 		/* Adjust iATU size if MSG TLP region was allocated before */
 		if (pp->msg_res && pp->msg_res->parent == entry->res)
 			atu.size = resource_size(entry->res) -
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 347ab74ac35aa..f8067393ad35a 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -463,6 +463,14 @@ struct dw_pcie {
 	struct reset_control_bulk_data	core_rsts[DW_PCIE_NUM_CORE_RSTS];
 	struct gpio_desc		*pe_rst;
 	bool			suspended;
+	/*
+	 * Use device tree 'ranges' property of bus node instead using
+	 * cpu_addr_fixup(). Some old platform dts 'ranges' in bus node may not
+	 * reflect real hardware's behavior. In case break these platform back
+	 * compatibility, add below flags. Set it true if dts already correct
+	 * indicate bus fabric address convert.
+	 */
+	bool			using_dtbus_info;
 };
 
 #define to_dw_pcie_from_pp(port) container_of((port), struct dw_pcie, pp)

-- 
2.34.1


