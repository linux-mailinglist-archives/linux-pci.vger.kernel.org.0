Return-Path: <linux-pci+bounces-13662-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DCE798AC52
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2024 20:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61E731C22050
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2024 18:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932BF199FA8;
	Mon, 30 Sep 2024 18:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VQuAH77V"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011047.outbound.protection.outlook.com [52.101.65.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64089199FAB;
	Mon, 30 Sep 2024 18:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727721934; cv=fail; b=Fx2hpSzT9pyhDUbM01RI4SYAO5hxuwidHwexg921GTl0pJERzdddCiDiuHj4QkN520QAx5+0v1WadAAStpWJHZ9EezgvPpwB681J3RozI0dpO/XD843+ybK2VCURz0w4rNqxlSOfATbC6M8WsAprymp4llNCwH+kkdgAmZfP1yU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727721934; c=relaxed/simple;
	bh=+dGq6PoUYPMOCSby2xfGUtVL0PAj0jtC7NzcyMHa4wQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=NkE2N3MesfJfa+ZVXWkgM4+k0k58D9cORvCbG6NdoLZMyVP+S5XuHI9My/D3yy5FjEs/2pwg2epmv420Gkj+90qLCuBI6H5SBzQrMvsCBj2ko3UaaoRJaXgS1lRmVByCvlb5bJIE2Xc0/9EcBzvRxhmSXOhZstchfHVVsq7eDLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VQuAH77V; arc=fail smtp.client-ip=52.101.65.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AXbvaF+4Uh63JSCNYi3KmComFDi7E6KvkX3LTc6Y5O5tWvtddnCbirGFXDKKIqj7VLXd9tpmh5LlK0UUKInjcl9tlL1b6RqNFoAu0miM0t0fiG+L3b3mZOV6PBO1jZIixNKKEnA4L77NGwvRVu7tEKFwOhEhotgKeI8BZNH/TYSWVwAoft8MUcE6/2IBN6nhgn1ME9FLrlgc27NAiAtXFXx1d55ipNrC0HKeShb0NpibamyXUpivssxxpbeEsqvKqSCTtdbEf0ngl5/Art02Q+S5log+3rAzBwTwnTmblJLz8TmhEMyqdrMCk+UDALkMDeakESZcmscKqQN+RB039A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jMQxrTJTrKyb9jA1AVXWB4dHgbjb8wTaLWpeKSZmB9M=;
 b=pLR6etYQxczZ5C0FOR78gTlCknLjTL7LrJXhWXz2HCUO3PadACLtX08t9dLn4IItW7UzBqXo5QqobfE8k41dUjorRjtg6/giSE6f/5tSL7SV1I44OozUCcc8rwCuGrDGtBTIzPv2vV2UNTwA9Iizto74xdY45eumI25upUmvCPkTZENfIecGRN1OkOk5mimlDPQ1CiGXA6IcyhXwGemejzJP6l90DO2oD6sLdCcctxCEhjGU/DZmA9LkJqEi08sy7y7qGpznFrt5fRzb0oxPNe26YQVn9TWx0xdxK9sxT78xcejJPS6yOrjfOeDgATAGwpVJbKI8kHcJWNJn06HXeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jMQxrTJTrKyb9jA1AVXWB4dHgbjb8wTaLWpeKSZmB9M=;
 b=VQuAH77Vo8P8JNQesLmz9qAOf0MQR3r7ODICFcODfCEu9SfrIohb9z3OD5QSRKq0AzXdoaTW2/IgpeskEqjMSJST5xSBYhWGXFZBRAQ2gQISquIAa+kHywAEFvhvgFUhRglnOFtukYkuf4C9E3L4E0W1z6hwlSlxJ7Jpb+/ZBWY6rj37xgGtrtayweVF8kGuIU+fHG+PSeIbs0qz9WU7fTYx2Q0e8NhURCedtIh+Dr4jluNcoHSxkekrzUyKCDCYq89KASx8kVK1TjfqT9RW/G8iOk19bmxTy28ZzGjCDPVAihhiV2fH60lLIRd0dej4oukXwI1ltM4yawrJHpvqcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB9884.eurprd04.prod.outlook.com (2603:10a6:800:1d0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 18:45:28 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 18:45:28 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 30 Sep 2024 14:44:55 -0400
Subject: [PATCH v3 3/3] PCI: imx6: Remove cpu_addr_fixup()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240930-pci_fixup_addr-v3-3-80ee70352fc7@nxp.com>
References: <20240930-pci_fixup_addr-v3-0-80ee70352fc7@nxp.com>
In-Reply-To: <20240930-pci_fixup_addr-v3-0-80ee70352fc7@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727721910; l=2455;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=+dGq6PoUYPMOCSby2xfGUtVL0PAj0jtC7NzcyMHa4wQ=;
 b=pUws7vapk2FukVNjbBvFBoUpU21J6bsa+N8lQC1LnWs4Ds9ggp/MqO9ouRJKR7h27+1Xr8eg3
 6Uhk0S7Q8znCS/w1ZYfnc53aVjsgoOcFEtGBr5ozJrIvafMeNpT9UCz
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0P220CA0020.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::26) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB9884:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dca980b-2c80-4fb9-6761-08dce1800ded
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QWZlc2t2RGY1SGhidmVucXRabUU4OGNheGc2WTl3UUd0V0ZmVSt6dDBHWW40?=
 =?utf-8?B?UUp6VGozbzhmQ3p3dDhaK2tITFlwT0FvWDExNVlwZXlqOHhXZmxDR214Q0VW?=
 =?utf-8?B?MEg5QXZIblEyYm85STROTmo2T0RlU1YzdjBJVXY3a2hNVks0SkxVTlVwSm1M?=
 =?utf-8?B?YjFUdFh5VVIzQVo0ZXZNcHJtSnpsUllPUUFuS2JGZVFKUnRaSEViOG5hL1Ri?=
 =?utf-8?B?SVpETFhmTkpaVVNhOHo3YklWK2xtZkFUYi9tem9nZmFhVkNLZjRFeUtFcGJ1?=
 =?utf-8?B?NXJUOExXNTM3Wk1NYjB5WHgrUllGZnJwc1J5dE5zaWU3VlhFTTJkRHc0MzBU?=
 =?utf-8?B?bVZlTHZIZ0dFVXc5cm5PUzBteWMvanRuTW9YWTZwLzJtZGE5TnBsMlZJRWRX?=
 =?utf-8?B?bWxVNHNNQ2t4cENhanFJN3hsMjdtdC9jS2hNdnByYTZJN043ZnR2clNta3g2?=
 =?utf-8?B?QjZRS2ROMFprS0s3MG4reDZqYm80ZHMrcnJKYUx3RmdhZk5RY0ZoY2tzSDhG?=
 =?utf-8?B?Rmtpa29kcXFJMWNuZUExWDJIU1hQQ3NUK2E0dk0yM1lFSk0rV2Fob1RpQWg2?=
 =?utf-8?B?a0pSS3ZlQTY4Wm5MSmhYY3o1OXFZWlU0THVXc1dESjB0UktybkVqM3orZ1M4?=
 =?utf-8?B?WWVPc2liN002c0F2ZXlQWURJMTlBWGZYNmhzeDdKY011NjNhWE9QTFAxdHps?=
 =?utf-8?B?TXdUa3dUc2NJeTE1bnc4b25lOStuTE9vZDV6cGZFTzJrMjZlZUtWb3pEUnNR?=
 =?utf-8?B?MmZlWXJZR3dvd0c3R2x5dHBlbktJTjhyb0w5djRCVGdEbFdpa3JkTGNKbXRQ?=
 =?utf-8?B?alJpRGRLbUZLa2Z1VHM2MUJ1NE9abjRRVjRZS3hOOEphL0wrNExBMGxCQVRm?=
 =?utf-8?B?SVordWhrcWVNUjZPTWQvWFEwNVRWQkNXbGhUVkVxV0szL2liV1VRYzdkNXlD?=
 =?utf-8?B?T2RKU2RJRDl5RkxiYlV1Zlh1MnhWWElTcXdySytJZU4rOCtraExRK01LL0dW?=
 =?utf-8?B?aUtUd0p0YnBmZ1JsRmkwZDFvc2d5UnRIb1BkZjlrRm9XNGEweWgxMzNtb1g0?=
 =?utf-8?B?RGFLdXJ0TTk1azNQTWJmZmprZDNqT2RqZWlvL2JWSCtjbDQzTWNRUnBPdlFF?=
 =?utf-8?B?enJYMGVRVEI5MWxIMmU5UU9pL3BEa2FNaDBaZEI2T2JnQUdCWll4MjBIb1cy?=
 =?utf-8?B?Vmx3M2Q2NzY2NEFYY1lBcTN3U2MreCtTYmlpZ3ZiUnBVMVl2bitjSFZGVUoz?=
 =?utf-8?B?VmkraFc5RlNldVdjVjBXYXZpQ3A5ZUVkcDhRdW9WbWdKTHhIUkVPWm11dlpB?=
 =?utf-8?B?NDl2NDk0TGxhZW9wVFRmNWhuUmNsWVhqd1NzYThqd0N6MnhXaUpkbnhwOWpZ?=
 =?utf-8?B?Y004SmlNbVplcHo0U0V2YUlEQ0RDYlpVM2NHMHlGcDVOMk1sejB5VTBjR0hN?=
 =?utf-8?B?M09CQ0FzWXRqb1ZNaVRuVDNRVXgyaDI2YjJPODRKTzlZTFJDWk1tdm4xaWF2?=
 =?utf-8?B?eVRKSFBTRFYrYXV6NnR6ME5HWkE3OFo2ZU9ZZnkxNUZ5R3hON3FDSDFHd2pr?=
 =?utf-8?B?WVJ2VFZrSkRZM05lRjMwWWJlaEpOUzRjd09jdVhhdml6cyt0TFgrZnd5YXpQ?=
 =?utf-8?B?VjNabG9UMTFUamp5b1BScWFLZjR0NlkwaEo4azB0VGlTU3FQUjZnUzdVSmsy?=
 =?utf-8?B?NVQ3S29MbU9SWDE0TzVUenY1eEZYVXQ2aGRRakJoN2N2WDd4bzFtVThGSlNH?=
 =?utf-8?B?MTgyV1pJNHV5TlpTWk1YMStPNXpOV010cFdCdkFHYUVMdVZ4Yi9JUDBtbHQv?=
 =?utf-8?B?dk5jdmtBWkJIemNjbGgwdnlnaHNmK2tXZ1VMeHRNTE5Ld2ZWWmdJTGxNREZ5?=
 =?utf-8?B?WEtTNGRHTDNJTHAzQzRqZUJYZ2NZNnREbC9JeDBXVHY1YXArM3pqL0ZmSnVP?=
 =?utf-8?Q?GDwxbjrtAwU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NDh4RGhsb3dmRk9aNWJuUEpEVUp4NHNESkF1RlNpRWYxZlczQWgwVkJ2WGYr?=
 =?utf-8?B?eFJoNUQwOXdFMWpzUlp0dlRwQU5tNHhZaXZsRkpwM2Z3M054cVZ6OHozVDFh?=
 =?utf-8?B?dDVOQ3l0a3NiOVBpbEFTSGNLbDNqVzlya3ZNQVBHNHZ0TnBQbXVWdlpBMHRQ?=
 =?utf-8?B?OWdxek5IcW5udzlNZ0RWTXIxb0MxQUE2R1FXQ1dpV0QzZjNxOHdKb0JEbHg5?=
 =?utf-8?B?aFB4YU1FNWt6ZzBvRWdqQ2dNUUNzSjcyOWtVelZxc1pTS2E1ekNCVG9LY1hn?=
 =?utf-8?B?czFlekNoK3FuN1BYK1ZGU0JiSjRtMUlWbkVUSTVKS3dsYjJoT1hOWW93ckxD?=
 =?utf-8?B?SllaYldwbVp1azVySTkrWFpsRlNxRDNHdFUzVldMNFdFa3NnU2xGQUpjenBl?=
 =?utf-8?B?Y0hJZ29xY3ZOOHZHVkRrTExDU2dDZ2xmYjB5NEx3YkRKeWRxQmpVSjU5Ym9t?=
 =?utf-8?B?TEEvUlZibkprZE14MFhwb0U5dVRjK3hheTExblMzTGdhdVNVNzBYQlhWTW9x?=
 =?utf-8?B?WU5iUTY3N05kNmRwZmo4Mlg5cWlTYVBNSEhvckhDTXRVeTBnUVhoSWhlVGQx?=
 =?utf-8?B?bTIrVXYzZnhrRzJBSFZ3K3U3Z0dacTVMbXViNlRqSzZUK1FzOHNUKzVGQ3JH?=
 =?utf-8?B?VVRrWW9TdVpzWVdYTjYrUXRDY3hFcVlzaG44MllwclRnYTQ2L0hGTU9vNXZE?=
 =?utf-8?B?THVncjQ0a0xQSkRQck82K3R5dVo0RktTUnE5UkR4YWd1bHl5UmlNQVdxNmh3?=
 =?utf-8?B?d0huUno0aXhDNzBydzNRMTAzck94VGFqTUhHM256aW9RQVJMeGNDcmxzekNn?=
 =?utf-8?B?TnFmUXRUNjJPcVM1K09MRmQ1WmlzbHJhNG9Mb3pMSWhxOE42cTF5M3cxVEF2?=
 =?utf-8?B?OEtPTXQ5UXZLamFHcFRob28rSHhha2xPRzZ6NkQ2QUtVSXhwK1JEQ1dSWFJU?=
 =?utf-8?B?K0trRWRORERpV0Z3Z2tWcFlYUXJPd2dUQzNheUZ5MGxzc3VxQ21xMDY3Wnpn?=
 =?utf-8?B?TmZpYXY4TTYvRThlOFlrcXYxYmhGaGY3Smt1WVF4YlBPQWZCRyswU3oyLzdw?=
 =?utf-8?B?UHRzaXQyd1JyWk0zMzU2K2FtRW9rRUFzQjRVK2w2YnNiU3NDaDZRaVY1ZVkv?=
 =?utf-8?B?YngxMlYva3UvMThHR2EveCs0NXExL1FBeU90NXRvKzhvaTBZL1JWMTZGVXJk?=
 =?utf-8?B?dWVQckp5UEFEcnRFeW1wRlcranpEeUY5RytSSXlZVmgzRnUyQWlibXc2bDJ2?=
 =?utf-8?B?SU9xRXdRODI1dHBiZVVQRUhIZFJRU1F2UU5Sc2FtNkNRQUV4UzZwTjBUR1d1?=
 =?utf-8?B?VWZYZk5pazdGK1lTZUFRcW9XbTltYng0eWlYOGRrd2RoWllBaVV4YmdTMm1O?=
 =?utf-8?B?Y2JoNGQ5WHN2MHl1YkhaU2d0ZW1IdXhGb2NXaENPQzhuUnZhdm9nRzVVKzRs?=
 =?utf-8?B?ZTl0YTBvNGtUODlnc2JPUHR0VS9ZTDVVcVl5aWhsMWJURXVXdXhoS0d2cW04?=
 =?utf-8?B?aE1tSDZSWkdObFJNMXdhblFnZExueVFxUURiWUkrUnRVZFBybmlzZ1ZJU0Vp?=
 =?utf-8?B?dDg2aW1OanNFeEhpei9nd0w3TkRVM29BbExYTXdLY2JiTklVMzA2bjNqZWZK?=
 =?utf-8?B?djVWM0ROOWpFeE5uNkVlUVJwejloakFnbGcwQUh6NU5JT1duSXBSQW51MVdJ?=
 =?utf-8?B?dyt2TTJxQjhoSEt6UCt0N0FGNkU5Uy9lT1MyN1BPaUFhNUtzWkNkMHVoSVVx?=
 =?utf-8?B?NTdsSVFXUjZlcXhIMVIrNlVKVHVBTnRuendCTnY4OTBONXI1SnlLSFRacmZN?=
 =?utf-8?B?SFRxOTB1ZXE4WFZ0QU1EdVBpWmMzODN5a3BoclRYeTdueVZuaHZ6YkZJSUpH?=
 =?utf-8?B?QzcraFRlRE4wZ2cweVE5M3orVkRDeStUN0I2MEVvS0V2R1hMMXkyVnFEY1dP?=
 =?utf-8?B?YzMzYWw1S2VXUUlYdjA0U1g4WUtTdzQ2T2lpZG91SU00RUlLcEpaaXF0aW0r?=
 =?utf-8?B?YTdvQ05NTnBQaS9OV3RMMnYzMWZTOEt5YW5aejlTTnBrOGNkWTFZeDFKNHJO?=
 =?utf-8?B?UHJmeWkxSVZ6RGZhMlYyZm82K0NEMnpGQktJWSswaUNjdmZLd0s0UitJK0V1?=
 =?utf-8?Q?xfFc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dca980b-2c80-4fb9-6761-08dce1800ded
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 18:45:28.6513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l7mbLDPhPTHcjMWaS0Mosh37Uj0kCbVR3Wy9o4htAuUgwKz2rifkgXLELDmYlZGDIbF80FbuUOELuvZWaZwPqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9884

Remove cpu_addr_fixup() because dwc common driver already handle address
translate.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v2 to v3
- none
Change from v1 to v2
- set using_dtbus_info true
---
 drivers/pci/controller/dwc/pci-imx6.c | 22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 1e58c24137e7f..94f3411352bf0 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -82,7 +82,6 @@ enum imx_pcie_variants {
 #define IMX_PCIE_FLAG_HAS_PHY_RESET		BIT(5)
 #define IMX_PCIE_FLAG_HAS_SERDES		BIT(6)
 #define IMX_PCIE_FLAG_SUPPORT_64BIT		BIT(7)
-#define IMX_PCIE_FLAG_CPU_ADDR_FIXUP		BIT(8)
 
 #define imx_check_flag(pci, val)	(pci->drvdata->flags & val)
 
@@ -1015,22 +1014,6 @@ static void imx_pcie_host_exit(struct dw_pcie_rp *pp)
 		regulator_disable(imx_pcie->vpcie);
 }
 
-static u64 imx_pcie_cpu_addr_fixup(struct dw_pcie *pcie, u64 cpu_addr)
-{
-	struct imx_pcie *imx_pcie = to_imx_pcie(pcie);
-	struct dw_pcie_rp *pp = &pcie->pp;
-	struct resource_entry *entry;
-
-	if (!(imx_pcie->drvdata->flags & IMX_PCIE_FLAG_CPU_ADDR_FIXUP))
-		return cpu_addr;
-
-	entry = resource_list_first_type(&pp->bridge->windows, IORESOURCE_MEM);
-	if (!entry)
-		return cpu_addr;
-
-	return cpu_addr - entry->offset;
-}
-
 static const struct dw_pcie_host_ops imx_pcie_host_ops = {
 	.init = imx_pcie_host_init,
 	.deinit = imx_pcie_host_exit,
@@ -1039,7 +1022,6 @@ static const struct dw_pcie_host_ops imx_pcie_host_ops = {
 static const struct dw_pcie_ops dw_pcie_ops = {
 	.start_link = imx_pcie_start_link,
 	.stop_link = imx_pcie_stop_link,
-	.cpu_addr_fixup = imx_pcie_cpu_addr_fixup,
 };
 
 static void imx_pcie_ep_init(struct dw_pcie_ep *ep)
@@ -1459,6 +1441,7 @@ static int imx_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	pci->using_dtbus_info = true;
 	if (imx_pcie->drvdata->mode == DW_PCIE_EP_TYPE) {
 		ret = imx_add_pcie_ep(imx_pcie, pdev);
 		if (ret < 0)
@@ -1598,8 +1581,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 	},
 	[IMX8Q] = {
 		.variant = IMX8Q,
-		.flags = IMX_PCIE_FLAG_HAS_PHYDRV |
-			 IMX_PCIE_FLAG_CPU_ADDR_FIXUP,
+		.flags = IMX_PCIE_FLAG_HAS_PHYDRV,
 		.clk_names = imx8q_clks,
 		.clks_cnt = ARRAY_SIZE(imx8q_clks),
 	},

-- 
2.34.1


