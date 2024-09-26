Return-Path: <linux-pci+bounces-13577-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB519877C7
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2024 18:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 420211C24E4B
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2024 16:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B8615B55D;
	Thu, 26 Sep 2024 16:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ps7NyoBJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012030.outbound.protection.outlook.com [52.101.66.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABA715B0FA;
	Thu, 26 Sep 2024 16:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727369271; cv=fail; b=gMe9uAH16ZGZRtfWVGajN0K20qNCPF8qZ+4aBh45GdnqxkFBVVeQek6PVIEpelqqYTtG49JAut9NRbPGC39nta9pyZzH8fHtSoyzr+/yajbfEjAmJVgL9UFCQ3JvjTu+wtBQrw7fRJvMjVVXbc7x34RL1dV/+VqWHc0khVjUXfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727369271; c=relaxed/simple;
	bh=9ldyp6HrhRbm9ZHIGYVTyAdfKVy/p8x2cPRL2TPnOiE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=d1IBs9jkCXIS5HN4E2k7ezEuIytnUmp11fLbpbACHnMZrx/1CLEdUhDeW/kKA3D+FG+kcY6TrB3TpPVkPZ0f420Vn5biC/ibXZGVQhaAmQZ/S5m4bi5FYPmuPvEDUtJv75bA989bb8z9KhGmGQ4qrPb6sEZNY+zwiA4lUzM2New=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ps7NyoBJ; arc=fail smtp.client-ip=52.101.66.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iAw9EVs0h750zTOtLGN0jplwkXod6/DiCVqGjlzrn0QdYFVfmq9+YWYPEoqpPb4RVPE17v13DdnwHmCZlDVIzMBl/WtshVzbuMvcZ48pmQZfdDoIQuDqAW4t8Tr2xdCwxA0ckqRs8bPiyOe6FrWHQQga51eyp0EBPGhRjDiCKZRwbChHhQqCFRO+k1ix9D4tMhOlZXkk84wFYzdaa2HPQq38P7WfDkv42F4Mz/v2+fmrCut0HozR6781blp+lae4/rnGLTNdrEc0x5lNw7oX61DbYLmMbgeECDk9EH8K0jFU8c1XlNW652ehq44SIbYih1nKzZSrW/UGx3pcJaeB+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x0T16mVkKkqfYTm9px2P9XDgOfTuQA4CE/TaNDgxwlA=;
 b=VAS/1N2OPI1bMh83ckn1kdOJEws4yJ62tf6IuJYX7DfcQsYLQrnN6U8+SZoLlrvHke50HdfbF9/AFGXBK44eD/5OP3POQvUv7043mRqIcxqaBr+gS0OhQJWu3M408f+amRa7jeY2CPqz8vjcwHkMlLuGb8wcDzbofDNlQBi4lTV1Cj+Zr7TDinitduhiGD+25UzhrhyrffSwpLUV3UJXhikKfNORkbGC8h5yT0bSMixDGPjEzoPtrV7TEIiwzhdcKu0Un34yJ8j+2HIpOZ9HmdtFnHDugp+S2tI91e4ZHc9asGzwMDSUOOSYbaqrHnmdatJsJ1cP3/qYiVI2IvHS/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x0T16mVkKkqfYTm9px2P9XDgOfTuQA4CE/TaNDgxwlA=;
 b=Ps7NyoBJsGtEA+7nmvN3VoBUdhmOoJ3bG/VKTDucJnmFxxr4qQ6J70DpRqHdR9DR8/RYRURVrW+h/WFZTO3qEZreEd6wTN35XRCy8PaOjVqFJerw4eEL0oT79SBqqgI4URX0D3V+hXiU3D6tAxlA3iByAHXUDV5pHkWUrH/59sJQqgnAS2tuJoCVm51fLVeVBinKTm9lZykFrWo+sw2IbWe9J5nRp+vfOoL9Z5/zQs+nnt3dO1me/FCe+w57ZTR8XFQmlvKvuwam5j1Hf3SrQmbDZqqFmoGCkJ58b1kw4ogEL5yk9IX42haw8CMO8gsF9ErXaB8/+cIoqRiWCsBw0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB7768.eurprd04.prod.outlook.com (2603:10a6:20b:2a4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Thu, 26 Sep
 2024 16:47:42 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 16:47:42 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 26 Sep 2024 12:47:13 -0400
Subject: [PATCH v2 1/3] of: address: Add cpu_untranslate_addr to struct
 of_pci_range
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240926-pci_fixup_addr-v2-1-e4524541edf4@nxp.com>
References: <20240926-pci_fixup_addr-v2-0-e4524541edf4@nxp.com>
In-Reply-To: <20240926-pci_fixup_addr-v2-0-e4524541edf4@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727369253; l=3905;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=9ldyp6HrhRbm9ZHIGYVTyAdfKVy/p8x2cPRL2TPnOiE=;
 b=Ri+NQMKn6WwChg/IavsYeJu9oEgesV3Jj3CUa+qyQHI/2Wj6TSB3CsoEzRgpvRd7Gb7CNxYXE
 LYhdcWmxpB5BS3SKKdSb40ic36t0Cdd5hiyex6UuuPUpx03DjaiHI3M
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0091.namprd05.prod.outlook.com
 (2603:10b6:a03:334::6) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB7768:EE_
X-MS-Office365-Filtering-Correlation-Id: 46199f4b-7b8a-46bd-2bc1-08dcde4af09e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MW9oQ0I0UmNtTmh2VjBqMEt3SXg3WWNXVlpxMEVoNjlrMTk2TmNhVHNDbjRn?=
 =?utf-8?B?UEpXbWpaMU5FTXJxQ3VLUUlBUVNtbGs3emxqY2M2VUp0bS9oS09MT1REelp0?=
 =?utf-8?B?NlVpSFZqb29UQkQ0V1BjSXhFUlM0Q1BaTXVoNHcweHFqYUxnMU1zOCswKzVy?=
 =?utf-8?B?UlVhVitTRHZHeVBLOUU0eFhlR3NOYXFWek01YzM3aUxva2lvcHJQdWFUZ3FK?=
 =?utf-8?B?RXVkMlowSWs0L3F6bWs1VGNrYjNWZGtBb3JZUlc1N1hPeFUwVEpERjhUT2w5?=
 =?utf-8?B?ZW1Gc3NmdmltL1JQWGQ3Tnc5bnJKTENzYkxLbEIvQzhvTTFnQ2s4Z05BTXAz?=
 =?utf-8?B?SS9ORzBYQVgveVAzRjlmc3F1M2lvRTRDcWpxRlZsR05IN1BxQTQ0cVVzM2Uw?=
 =?utf-8?B?Y3V2RFhUcHF6eWtVbndXVnhlTGQxczBNRlplaW5zMGxqV3h6a09BK1JRcVRq?=
 =?utf-8?B?c2xjT0lsSDR3aEgxekFUTVk3cnZvNVBuUnZDUVA4T1NPcUcvSG5rQWREcnhV?=
 =?utf-8?B?WVRJTzZZeXFQQy9EZVBuS3V1dXpNQ012YWh3bHlhRkNrY3AzUXpia1l0WG5D?=
 =?utf-8?B?bFNPOWhlUEhnNlRGOEh1c3lCNUlXck9RYTZVeHVVS2lCNzhaSkUwckhtQTQr?=
 =?utf-8?B?RE04MWgrdysvU1d2THNrUjRFOUYvZ3QvZUYyMXh5MDlKNW8yemxOM3UyVlE5?=
 =?utf-8?B?UldwemZuZ0twS2VnaTNwZndLMU5pUXo5VDlqbUxKa1pkOEtzYk93SCtxWkNG?=
 =?utf-8?B?b0dJMHNJVDFCZUo2T1c2SHZEczJQdjhYWVhDTG5Qa3I3UEFPVGVCNXlqbTgx?=
 =?utf-8?B?MFRBVTVtanRVQytzZFk5OWhka21lT3VVNXk1OGhOYjBiYU5abUg1S2lxNlFY?=
 =?utf-8?B?RVdtMStXUUFVcjhKMUllTmt1V3pDREF2QnJ4QWNEOVNRQjdabU16YUF0UUdU?=
 =?utf-8?B?ZUJieHlnQ3o4MkFodE5VMklCbXU2RWhDMUZ4Tk5UMkljL1g1YzR0TW1odENT?=
 =?utf-8?B?TzhYRjdpY3pwdmtjQXZ6cWhPY1pxejFvZjhydElVQmFJVnFKWkNmLzFFcWlu?=
 =?utf-8?B?WHp4elk0UDE3K0hrM1M1TTV5blBGZjloSzBNcW9JTHZSdGZNWGE1RklJRHJY?=
 =?utf-8?B?eGNZWHNPenJnMkh2Y0R4aSsvOTgzTDBqYTIra0lFT3drdmtXMGVRRGc4dTRh?=
 =?utf-8?B?Y0tRamJ0T1NUS1JMOE5pZmxPQWM5SE55U0xSQkRqNS9XMVR0WFV2U3E4a2Vt?=
 =?utf-8?B?SWRQRlNLaERXRVA1L0ZBREJUYm9DT3JzcFNuWWRBMVdCbGEwU1R3dVk5RWtQ?=
 =?utf-8?B?MjdEcnJHZnpkMUFwaWRpbm1jdGNRTVJoL01FUEw4N3d1bjE0Qk5nTUZtckhT?=
 =?utf-8?B?MEFzOUNWOE9Fbi85cnlNYWhPWjBwdHRvMzFWamI0Zkx4b3kxQXFLUmcvWVdp?=
 =?utf-8?B?Z3JaUE10VkRTNGxQQ3cwQTQzZEVkMHBQT00velpCSUFZd3FBMUkwTHp0M0pK?=
 =?utf-8?B?SkFLSktqVUZPNEZicjFtbW5kci9vZVFOU3V2U2JETGhLQktEc253Mk5DelNa?=
 =?utf-8?B?UDB5T1E3ZXl5bzNZYnlpK1VqU0pDV3VxY2FoTHZ6b3dQOFMwbUNCaDFBRXUz?=
 =?utf-8?B?OFp6Qy80Mm9TamdDWUJYcmJ2NkJ0Y3FCOU1pMHJCdG8wVkhXdUowREhRWjN4?=
 =?utf-8?B?eXVGUlFiZEtZbi94Z3pRSjJHT2owTk5jRjNRRUliOURld00yOHY1dnNWZ2hh?=
 =?utf-8?B?c2t3U2lsTkRZdUZqVHN2cGVoOHJBektiek51citpRDBwanR3dzVRdjJDeXN5?=
 =?utf-8?B?djlGeU5CdUVoQUNqNzVHY1BjMC9UU1ZXeG55a3VEcHJxeUtZcHY0NzRHZEhR?=
 =?utf-8?B?a3J2aU4vaUNiczMrRkhsR2JoT2VLRzd6Y044ZW5Sa3RMY2Y0MndrcWlSbWM0?=
 =?utf-8?Q?QVad9TE1JjI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dUU3VENRbkJ3NUU3a2pDRkh6cE84RVFhZzdTcUFzOFhmUHlFRW53K0diWTFu?=
 =?utf-8?B?dFNWVDMzOEowUU5PUzkrbmlaOE1KNzJITnhUaU5ZTjhITExRN2ZMYkp6WWUw?=
 =?utf-8?B?bDUvS0JYSVlyS0lKYWx3RjZBdDNObGJDaTNzVXMwUndlaFR0RnlUYTVJL2c4?=
 =?utf-8?B?Vm5IK1NPNHhzb0Z1ZVE2Rm9ZTFY0S2FOWFhHMkNJVzFqTUpGWGsvWENZS2FF?=
 =?utf-8?B?L2xZTDZIbEpRa3JzNjJreVo5NTdxcnJlSmVJTkVXeXVURHQ3cHByU05HU2xa?=
 =?utf-8?B?bzdoRlhJZWhJN3plVGRIWXdrVjY3YlR4OTA4RU1aeWJiRlZONmdPKzhXNjNz?=
 =?utf-8?B?QWw1ZUg5SU5NYXVFbjdPZmNzQWNJWHg5OGhYa01XUmxnVjltTWRNRUFTSUZH?=
 =?utf-8?B?ZnhOdHpFQTF4d2NIVE9KOFIzK3grRXROdUVkNjV6SzgydHc5TTF1NHpQaUZH?=
 =?utf-8?B?NEpZN0ZoTXlkWkt6NHp0SkZSdFF2SVlTSUpoSCtLNVdicmJIZGVPU283QURs?=
 =?utf-8?B?bDhTTU1FQng1YzdPUktjZ1ZrUVErb2tnMWpJWUd3WnN2cWJ5dTA2bGd3NkJ1?=
 =?utf-8?B?aEZyYWkrdDVReFZZanBVRUp6aCtIK0swWEhvY2gwVjdkWTJ3Z2FFMFcwaGIv?=
 =?utf-8?B?SVhHTjkzdXl2VEowNzMwdkFyVk9vMmVDWEdoM3AvRk0zZVR6eVlLTE11VXNR?=
 =?utf-8?B?ZHg2VlpWbkROd0RKSVZQaHp4aWMyZDJlTUhvMTVMNWk5bDdWSm5jaXlQcVY5?=
 =?utf-8?B?TlZnUFlKWnFuNldxV0FPbGdmeVhZRERyNERqbjFzRGtTc1duS3NLaHpMWXB3?=
 =?utf-8?B?dFZFMUw0WWltUmo0TmlHRHAwK3JzNmVTUXRWQ2JLMFVjZ0JuUDR4TWgxWi85?=
 =?utf-8?B?aTFvZGEvVEMvRUMyM0c2ZHF3UHlTZDJ2RmNBdFdCMEV4RjRxdXhzcTQ1YUZ4?=
 =?utf-8?B?LzJXM1ZZNy9Gb0pZRVRNNlBkQjh1VWlPUTBsMEZtV1NicytjZ3FYRGNkNW0y?=
 =?utf-8?B?MXZOSkorL0U1dlJMek0xRFd5ek1kZnA5ay9YcE5nTG5wb3Nsc0lrS05rZDBW?=
 =?utf-8?B?ZTNQbUZOUTZ1Ym1SNGRWekdMcytaS29MajEwNnBwTU84YklhL1ZKU3NyMnRy?=
 =?utf-8?B?SlQ0VEVsekoydFV1d2I3d0xhMHpsRnIzVHBoTVRVSHdUdUxvaTg2T0g0SG43?=
 =?utf-8?B?Y004TXlmUXppamZMa25UQlZkd0JIeXd2d3F1bGhZVTdBeDJPcHVBM1Faa1hK?=
 =?utf-8?B?b1hPZ1p1RDBrOEhWMXovSkNQdXdCbGNQVGJGbnRZYmJicHlFQVFmUlZoN1U3?=
 =?utf-8?B?b09hTDFvM1NPaG5GUVhZaytlSkQ2bFNjWlpSN1BWT3FKNkZ3TkVFdi9sV2VH?=
 =?utf-8?B?RWJ5UlhZaWtyeUlYTVhYcE9xM1ZSMUJaWHhPREcwU2w5L1V4L2dQVmIyTWg5?=
 =?utf-8?B?VGwvOE55ekViSW8xN2U4aTJSL0lQQ0JlL1dndXBQNEJYZUJLY3J3aEpqV1Va?=
 =?utf-8?B?M3pRd0JsYlE0SjUrQzlhMkM3bk9kdVpCQXprNlNETXlOQklIOEtBT3ZhS25h?=
 =?utf-8?B?Mm1TWjNYSVg0OSttTXQ4ZTV5UlR1cmJBbFc0dDUwbWhLTUp1bWhlbXhjYlVz?=
 =?utf-8?B?SGdCQzgrU3VHelhWR2Jad2lhR1lNdU1iVEZRTTVLY0lHMDNiSU9PSXZSQmRp?=
 =?utf-8?B?R2lWWTZ2R2Fkazd0cWVVUDVPb3FCUGJCZG1UajA1ZHBJbHBEdktyWFNjMHFG?=
 =?utf-8?B?UHEyVTVWRjJhcTNGdlFXelFOU202N3c2MGJFWXNuOE5HYjBLRjUwZHV5UVRR?=
 =?utf-8?B?TDFFZWVnTng4bEt0T1R5NlJNN1hRNytmOU9yQlErWkVTOVRxYVR0SjJJVXJl?=
 =?utf-8?B?a0FXZDlQL1lIeHBzb1BsZWprdmUzQlllMGVzdzIraXN4eDdFOFZ1bndYa21J?=
 =?utf-8?B?QUNPanlQRVJMSTNBbDhRaGQ5QkUzWFZFYUJJQjEyZDY0cVBpL09jeCtjam9R?=
 =?utf-8?B?WHUwQk1oeVNJYTY1dnh3dEdqN2NJeEFubWNSQjVzbXVkbVB3dmp1YkR5UkJ5?=
 =?utf-8?B?R0R2RHRmREEycmdmN0krY0FVUnBzQllQdEd6c0JUN2NXbTRwRzlaU1lqdnZV?=
 =?utf-8?Q?HPoLLuN/xvRiLJIzuKf6gyWFN?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46199f4b-7b8a-46bd-2bc1-08dcde4af09e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 16:47:42.6725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qEVlziymjTYTVruhCUzsAOnVrgMBtz3f+9LHqeDe1Gm79T6yTEImSWIjGg3IKW6Jtluig1zKxrTXfKmrU1Ducg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7768

Introduce field 'cpu_untranslate_addr' in of_pci_range to retrieve
untranslated CPU address information. This is required for hardware like
i.MX8QXP to configure the PCIe controller ATU and eliminate the need for
workaround address fixups in drivers. Currently, many drivers use
hardcoded CPU addresses for fixups, but this information is already
described in the Device Tree. With correct hardware descriptions, such
fixups can be removed.

            ┌─────────┐                    ┌────────────┐
 ┌─────┐    │         │ IA: 0x8ff0_0000    │            │
 │ CPU ├───►│ BUS     ├─────────────────┐  │ PCI        │
 └─────┘    │         │ IA: 0x8ff8_0000 │  │            │
  CPU Addr  │ Fabric  ├─────────────┐   │  │ Controller │
0x7000_0000 │         │             │   │  │            │
            │         │             │   │  │            │   PCI Addr
            │         │             │   └──► CfgSpace  ─┼────────────►
            │         ├─────────┐   │      │            │    0
            │         │         │   │      │            │
            └─────────┘         │   └──────► IOSpace   ─┼────────────►
                                │          │            │    0
                                │          │            │
                                └──────────► MemSpace  ─┼────────────►
                        IA: 0x8000_0000    │            │  0x8000_0000
                                           └────────────┘

bus@5f000000 {
        compatible = "simple-bus";
        #address-cells = <1>;
        #size-cells = <1>;
        ranges = <0x5f000000 0x0 0x5f000000 0x21000000>,
                 <0x80000000 0x0 0x70000000 0x10000000>;

        pcieb: pcie@5f010000 {
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

'cpu_untranslate_addr' in of_pci_range can indicate above diagram IA
address information.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v1 to v2
- add cpu_untranslate_addr in of_pci_range, instead adding new API.
---
 drivers/of/address.c       | 2 ++
 include/linux/of_address.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 286f0c161e332..f4cb82f5313cf 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -811,6 +811,8 @@ struct of_pci_range *of_pci_range_parser_one(struct of_pci_range_parser *parser,
 	else
 		range->cpu_addr = of_translate_address(parser->node,
 				parser->range + na);
+
+	range->cpu_untranslate_addr = of_read_number(parser->range + na, parser->pna);
 	range->size = of_read_number(parser->range + parser->pna + na, ns);
 
 	parser->range += np;
diff --git a/include/linux/of_address.h b/include/linux/of_address.h
index 26a19daf0d092..0683ce0c07f68 100644
--- a/include/linux/of_address.h
+++ b/include/linux/of_address.h
@@ -26,6 +26,7 @@ struct of_pci_range {
 		u64 bus_addr;
 	};
 	u64 cpu_addr;
+	u64 cpu_untranslate_addr;
 	u64 size;
 	u32 flags;
 };

-- 
2.34.1


