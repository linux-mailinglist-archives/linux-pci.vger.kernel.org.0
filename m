Return-Path: <linux-pci+bounces-16974-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B85D19CFF53
	for <lists+linux-pci@lfdr.de>; Sat, 16 Nov 2024 15:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CEEAB26B6E
	for <lists+linux-pci@lfdr.de>; Sat, 16 Nov 2024 14:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E95188A3B;
	Sat, 16 Nov 2024 14:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Em70wJrX"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013010.outbound.protection.outlook.com [52.101.67.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEDA38F9C;
	Sat, 16 Nov 2024 14:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731768084; cv=fail; b=LMxZ32HTKczWglYf6SXVJspR2aUW6JPvsbPZc17r02U46Fyk6xQmyZO5ne150b+ERHhJwi2Lb269dS4/kd8OXEF+4C6HtxqCMcT7IeGruVHhlpT3xSmJSw90I6l8K4RaOLtV7/td1ytYDsw1NoPRJ8TbTaBt8LyorBtuTWF1kjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731768084; c=relaxed/simple;
	bh=bfBlohtvx2bmitM09sd2P0/1msiF1RQlPsCuEI4gWds=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=AxXDWYtaPhDU91L5uREdnVOzZbiA5ViiyjGOZ1d6mI17PssoD7ehhzxB9VDAR16N4HNwf31Z5o8Tg4LQKJseqlQ6LJyjgRSqEy0Q2roMSzNKUegYQz2GPfgx+y6RgqVNtcvX8EuEuj5BJuv2qbGuj8+KqP+cK8TFsFm0khzPmSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Em70wJrX; arc=fail smtp.client-ip=52.101.67.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yUPAes3xkdt3aj0dclhi2rtwtKmr43o/MdQwFFgdJAMDIsm8HNYZjPRzP9PpyEgxR9BA5YNennzwSrxkngrW8bJFiMszdLUh/jvyPILoSYe1bYfKlDHKEKRX3XN5b+OOghV6t41xaI6Ni9XC6WQGsC/6E5qjHMF5rt2rE3/cyFX5VfgCmD3K02sa00Ri+unrMapRXXSDjCAszjZlm+QGWBWMFUu6fnFhHNk/8ICjoZAbRcKVGoUf4SArXdkUHVApneDntYQxA1y9y0NtZRazBJuJsrThaVpTQN/HFZn5YSCqpLBZg8WiFhJnuNG1NxZH+sl0HcNMewAeszwBk0Aj8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sPLSAjBxVhmW/iYWYZ4v4ELai9IvZTkeFFwJE94I+Ww=;
 b=Dk0GX3ypQa9NdnxPOkwHb0bqBnoXJwkeEn8zvOfmzOrafBrxK+hG4WDI+Cb9VIDlBmsnCotxiPGHtXEJxtPJqdDcglHiGfudiWcLcJw90dybRJ18KH1/k3PzQkBR+dkt8oqbJ4WjnI/7HqsogKYBsGBPI1pPjuy7SMxclmtTUguEEw0mEjcQCD60uUkoUpAaGpeTxG5Umj71/zeAS8AqVwD7SZt5L2sMh+UXszLgkrR14krWO0Y2eRhAQKJDgCT474ET2870hCsUIuFJTu5qxCzW4ZCTW/4kszBvG/qA9kn/KOx9IUvSSEjEE7RQ9sfW6fmgYdk+JDQQR6YWmD7qrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sPLSAjBxVhmW/iYWYZ4v4ELai9IvZTkeFFwJE94I+Ww=;
 b=Em70wJrXGL49ancuIJAdvqVAMXtEX1nyZgS5QiRTXGvakNekPe3n39GCVpLvRnCyIO5tfS1/Bqy8imNQCRvUIIEuR8YVBzNhyQTqv13lXiiNDSPkAh4cySjpDLmqKbe25mY5aqIA76xkjIm6AWCI2Gt/vb+nKq7zic/lbrMiUH5uSHvVFeZFBhWorgtHPqPZJTI0bB2RKZpP5gVmLTQoOLx62dMSy2DtwszJC7D1e3zvc3kpTR2oPwCWSbFW+FadZSwkl2l/2fBAeWj1tCSotUqG8WZbVdbG8s/4v5ybjrjN207AbswJbma+y2kmvr7KsulEDBbOBm8MhISUuWxPZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM8PR04MB7265.eurprd04.prod.outlook.com (2603:10a6:20b:1d8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.21; Sat, 16 Nov
 2024 14:41:20 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8158.017; Sat, 16 Nov 2024
 14:41:20 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Sat, 16 Nov 2024 09:40:45 -0500
Subject: [PATCH v8 5/6] misc: pci_endpoint_test: Add doorbell test case
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241116-ep-msi-v8-5-6f1f68ffd1bb@nxp.com>
References: <20241116-ep-msi-v8-0-6f1f68ffd1bb@nxp.com>
In-Reply-To: <20241116-ep-msi-v8-0-6f1f68ffd1bb@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 imx@lists.linux.dev, Niklas Cassel <cassel@kernel.org>, dlemoal@kernel.org, 
 maz@kernel.org, tglx@linutronix.de, jdmason@kudzu.us, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731768057; l=5527;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=bfBlohtvx2bmitM09sd2P0/1msiF1RQlPsCuEI4gWds=;
 b=R7yeWlooL09qMBHQ6B5jA/netTygU+2xCXeQeYPhP+4oTtMk6hlya2JAMPdOt0Vf3T3S8Yn25
 btDmwrEgvaHC4gfzw8jCL01LTijIf38ZbKNdoh06soCMTO8Oh6eK/0I
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0210.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::35) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM8PR04MB7265:EE_
X-MS-Office365-Filtering-Correlation-Id: fa82eb39-b14d-47bf-2fd5-08dd064cbc42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OFVBV0R3R01hM1FpYVhEQktUZTlTU0QweHBkaHhBcUZ2S3VaODdJa1BVQ3pl?=
 =?utf-8?B?V0x1UTl6WlM2RVNUdURrcnYxV1lUV2FXUDBGTWFTbndBb3VnV0VjWVR6WXQv?=
 =?utf-8?B?NS9lSnFPdy9uSU5SNTRqb0NCRHBNUlZUbGx1bldza1FkemlLcEZTeVQvNHRG?=
 =?utf-8?B?ZmtMSVdraGJRUERhQXZFdXJUUFFhYVJPRWRGcnI3UVJVZ3ZOVDJHU1htN0tT?=
 =?utf-8?B?dmpRMHhjV1FhbkMxNE1sc1dMaXNUbXhCTWdHRlMxT1lGOCtvRjdqZWhSL2ls?=
 =?utf-8?B?QU96QjBFMUdFcGxDa1o2Nk1oUTJJUDVJN3NDbjRhSFlQUGsxMlJDMFBWdm1Q?=
 =?utf-8?B?UUgwdzI4UGM3WmpYVjVBSkRaZ0Q1bVovcXhSR2w3TURtWDVHNnNza1o1alhm?=
 =?utf-8?B?S1RsRDVuTENzdzBCTDNHVGlsQzFCSHpoT1AyMWM3dlFXT1d4RUpnazEra1B5?=
 =?utf-8?B?RjdjUVhQakhSaUpXTkdxd2MweWQ4VmhxY1N3d0NhekJBb3NGbHRSWWExRTFm?=
 =?utf-8?B?dTA1TGVFU3drUEE0czk3R1hVTTVNb3VQak8rSlk5OTFhS2N4VDF4Q0h3NXBU?=
 =?utf-8?B?L0J0MzlvWjFnSE4xdGNKNUtxYldpTGRVZE4wbWxTSlpPOGRBa3dPTnhESjJq?=
 =?utf-8?B?TWZVUjBTZTFCdFFtSVl5U2JHVTJ1ZmdpbFU4MEw0M2Q2SG9QTnd2Zlk1RlJJ?=
 =?utf-8?B?SFBhcjJWZGxQenBPQVIzYUh6Y0JVSVVQOExlL2JLVDBBZnFIRUJGR3hVQU5H?=
 =?utf-8?B?M0dGNU9pLzVJQWcwbnlLbHBmRVNFRm9FN0JyTlNZMDJJU3ZjMzJnaUxiaTlO?=
 =?utf-8?B?UkVlTHZLNnZpNFJ0SjNEc2NYbFlyQU9mWlE4bDJiTVdaYTNnekcyMnJndDdB?=
 =?utf-8?B?MHFpQVEyREZwRGFpVmFEMXZIMTJVbjZMVGF1R25CYVFvcDlVaTIvbk1OVkVX?=
 =?utf-8?B?ZDNlU09JMUZXZEczNXJJeUtCTkgrbEhEbU1JOFgxRTZ6cWxkSUdqRVFCQW55?=
 =?utf-8?B?ekk5RVJOQkdmd0o3SEFSeGREdG9LbFZ6ZWkzU00xOWJuV1VXcmx2UFRXNlNp?=
 =?utf-8?B?QzhDZytDNzZNdVBKb3MwZHZlVmptZWlWL0oyVGJ0N3J6RGdLZFdSN0xIaFBy?=
 =?utf-8?B?c0hQMGZJMW5icmdXK2M5SWRjZWpIcEplRXFmMW8ydG9rTlFUOWxYRnZuaWhX?=
 =?utf-8?B?UEJLenBxRitnL2lPUndQU1BZTmVSL1QwU3R4ZnphMzhGUzJEbStScWxnNHVR?=
 =?utf-8?B?QXM0UTlHVS9CZnBDVk9qbVRJUTZlelpXS2pqUHVrdThxV1h5SDB2WTBpeXpK?=
 =?utf-8?B?ejRNWUR6UGVxeEx2MFY3ZjRmWWd1YWdVMklDdXplcmdwNzlHYnZsSHUrOGFN?=
 =?utf-8?B?NGkrQ2dUNEQ4YmJsZTJmeWJpcEd1dnMzdW0veWFNU3k3L3UzKzFpZXh5TzVZ?=
 =?utf-8?B?ZnJJcyt2RWsrNUdNc3RwTEdmaUNsblFrc3JVaG9WMytZSklZZlgzUGd6bHdI?=
 =?utf-8?B?YkROYTR3L0d1b0s3dmZ4aUJHcGgrMkV6UCthMnR3b2JnZWRPR0h0QmlFZHJ1?=
 =?utf-8?B?UEh0YWpTNE4xaDZMamlBR1RrYlF6dzk2eGlRZzJvUEVVcDk3Zkt4eEJhMFB6?=
 =?utf-8?B?WHJXN3VqcEFPakNBV1I0UUdZV3F5WC83TmRQN2lPUnRiVWQ4YWNLSXBBd3NN?=
 =?utf-8?B?aGlLaDlPWDFBVXB6Sk1BQUlXZlVYRUxCc01SQklqd0NtNThGa1h3YUhzYTBB?=
 =?utf-8?B?WDluNnZWbjd4U3pydXlGR1lXTGhDQWYrellYcittUWoxL0tWbzNrYVU3d2k0?=
 =?utf-8?Q?K76gxy3g0tqpNqOET5YnKgw30U/nHtYmZIKEw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OXlLazA5cHdKSzJuVGtCU3Z0Skc2YlBRanNKK1NQaytGdzAxS2kxSzdBelBW?=
 =?utf-8?B?UVRsSkR5SDRWS0tjVWlnOXF1eGF1bUpmT04wWXJGNzR0aytXSWx4WEcwZmZV?=
 =?utf-8?B?N2ZpNG52dXl1Z3JiWEc1c0hnTHpPS1NoRmM2Tktlc0hCRDYxUW5abWdxbXp6?=
 =?utf-8?B?YWdyQTVyelI5czhlZFdwYkJnWC9CV2pYMFpLcXdMUVNIcDNHMU9sQUVDTU9j?=
 =?utf-8?B?VnQxdFBrWWRiMVFkMUNBSGIwVnJpQlN1aTc0NDlzem1wUnpzcFpQRnRvTXlp?=
 =?utf-8?B?WFU4NFlUUE51MDlBZURnU3Z3Z0FURWQyaHlMTXRtRWk3OXBRbEl2UmZ0bnZZ?=
 =?utf-8?B?MkVuUktSU3pFMjlPaGVWeTJpUzBDdCsyNmJ5Yk80SnVUdVA0SFVDTFlTQUFM?=
 =?utf-8?B?WjNoZmRNQzd3M1lka2pBaHZZcWF5VDR2c1NKelhtWTd0MjR6VzdGcVdOOFl5?=
 =?utf-8?B?a2lYNVFHbFQwOEQzUEY4U1JKU2wyTWdld1k1YVh6VENVL21BRTBmZHMvZzg1?=
 =?utf-8?B?a1NrOE9OV09QWlBiRDVpcHBrMFMzdEwxcVVBcnpMWTZBcTJoTGkyVmVoRjRy?=
 =?utf-8?B?Yk1BbVdJNlJZbHRiR2JIS1hDVjBYbXVBSjZDNnJ3cWloVmdZSGh4clgvYVJh?=
 =?utf-8?B?TXNYVmVzR2VuTGJVWXhiMlFzWE9ZbkRwQ1JLdlM4UVlzWnZLZXRrRzg0SG9C?=
 =?utf-8?B?UndmQ0NJYnl3YzUremtqTFpzQ1BQSWVqYU0rbXJqcHBVKzFscmNDVTlaS1dJ?=
 =?utf-8?B?ZzBoVFZGZXkxSWxJdEVURWhHeitGdWhZeVJKVSsvMEtZVFRUaURXTjZLMmJn?=
 =?utf-8?B?cUprLzQ4WWgzbnk3VjJxWHlYYzlTUnRQaG82aEFMcC8wSWRCWnhhdmFIVlIx?=
 =?utf-8?B?YnRVcmU5TkxrbWRtTWVSTXNjVEV4WmZzYUd6SXBUNjdIQ2oyNGNHZklGUUsz?=
 =?utf-8?B?cWs2dkZBT0h4UE5zVmpjN0JUTU9wc3E0bDlZb0RZWDR0RUhYajVURUMyZGZ5?=
 =?utf-8?B?a3ZqT2s4LzB3U2dYdklpTU1TdW9DNSs5KzBBUWFITTFYeE1vRUZaUmlpd04r?=
 =?utf-8?B?d255M3ArbWRqVkw5ZDVJdXRQKzc2Y2pFVmJPV05uemhEd1V0c1NJRHdnMGZV?=
 =?utf-8?B?NWFNWDZRWFZpVG12c1d0bGlyT2ZFbDRVR2RreTQ0SUthN011b091RklvNGgy?=
 =?utf-8?B?VzJ0RE5DSXRmOW4vZGswaTRqdGF0b2NubXRKTHEvVVhqTDdudDNEaXRTM1RB?=
 =?utf-8?B?TFlBcHJrOHAwb1BWOFJ4SWtWQWFiZUtEdUt6angxdFRtczk4aXNzb2x0Zndh?=
 =?utf-8?B?RzRST2Z1cmJtdkFxUWExVG9zQkdOUkphb3VHQU9DaUdPYklxL3dSdmM2bVgw?=
 =?utf-8?B?bjZqK3paTkxtUmZ6cjYzQllhZ2Y5Rjl2eHYxMVV1ZElyYUlLaDA5TXF1aGQ5?=
 =?utf-8?B?ZHlWcmJjTnVBWkdYc2I0TTYzbERWMU1nQ2kyaEl1QVFWb0dsVExiMG5PTzFQ?=
 =?utf-8?B?Vkt2YmFJUnRmdnNiZFNmT1NVdTl3NG81WlJpNkhaWTg2VXd2Z3ZvSm9yNmZ5?=
 =?utf-8?B?MVNRaDhRa3cySzlGZWVmb3QvY3Q3bk9PS1RIczVleWF5ejhISUY5WDFRbmlN?=
 =?utf-8?B?a3h5cWxKWTZJSGZ2VUhVQTJONUdId2REQ0FhUFNCR1RJSjFLOW4zZHJaZXVY?=
 =?utf-8?B?NFVnRkl6T0h5YXJ3aUtVZ0VIK2Q1Z0lHSVFHc28ybWVWK1VjbE5jT3NuNVNh?=
 =?utf-8?B?aDhIYWt2TTBTdi9KWm1LODc5ZlJVUmJFS0RiUDJPZ3lqWmRyek80bmlraUU0?=
 =?utf-8?B?eVhhdFVFeUs0N250RFJjSy84MU0rajBXTVFtMWhIdmFJbGFjUHdtaUpBbjBS?=
 =?utf-8?B?am5vWXVtNTYwbHVVYWZCTTg4eit4TnNydkhPNGw2SmUwT1hFemNvb1p6Rldw?=
 =?utf-8?B?RDZybjNOQXFBQW4xTWtHQytVSXFTQzIxZEpWM3pDWlc2YlNueFExVzZvdkUy?=
 =?utf-8?B?RC9OSXlSbkN2RU1lb1EzRGI4bnNiN3ByTGhvRFBmTzMxamNpdmdFR1NRYm1w?=
 =?utf-8?B?TzNjcGZYZHhKb1FWUGxCQXgzVERFNjQ2YmhocTR3UXFYUk9vbHVZM0xQNmI5?=
 =?utf-8?Q?p7KQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa82eb39-b14d-47bf-2fd5-08dd064cbc42
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2024 14:41:20.2970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ty/GE/nqDJ8h0fSl6AgUCQ7yhYY2iGRdWNSTO0FHJWo25HH0FlDwnJ3deqDM93ckkhreJeVGq8XhV1FEDcVZRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7265

Add three registers: PCIE_ENDPOINT_TEST_DB_BAR, PCIE_ENDPOINT_TEST_DB_ADDR,
and PCIE_ENDPOINT_TEST_DB_DATA.

Trigger the doorbell by writing data from PCI_ENDPOINT_TEST_DB_DATA to the
address provided by PCI_ENDPOINT_TEST_DB_OFFSET and wait for endpoint
feedback.

Add two command to COMMAND_ENABLE_DOORBELL and COMMAND_DISABLE_DOORBELL
to enable EP side's doorbell support and avoid compatible problem.

		Host side new driver	Host side old driver
EP: new driver		S			F
EP: old driver		F			F

S: If EP side support MSI, 'pcitest -B' return success.
   If EP side doesn't support MSI, the same to 'F'.

F: 'pcitest -B' return failure, other case as usual.

Tested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change form v6 to v8
- none

Change from v5 to v6
- %s/PCI_ENDPOINT_TEST_DB_ADDR/PCI_ENDPOINT_TEST_DB_OFFSET/g

Change from v4 to v5
- remove unused varible
- add irq_type at pci_endpoint_test_doorbell();

change from v3 to v4
- Add COMMAND_ENABLE_DOORBELL and COMMAND_DISABLE_DOORBELL.
- Remove new DID requirement.
---
 drivers/misc/pci_endpoint_test.c | 71 ++++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/pcitest.h     |  1 +
 2 files changed, 72 insertions(+)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 3aaaf47fa4ee2..dc766055aa594 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -42,6 +42,8 @@
 #define COMMAND_READ				BIT(3)
 #define COMMAND_WRITE				BIT(4)
 #define COMMAND_COPY				BIT(5)
+#define COMMAND_ENABLE_DOORBELL			BIT(6)
+#define COMMAND_DISABLE_DOORBELL		BIT(7)
 
 #define PCI_ENDPOINT_TEST_STATUS		0x8
 #define STATUS_READ_SUCCESS			BIT(0)
@@ -53,6 +55,11 @@
 #define STATUS_IRQ_RAISED			BIT(6)
 #define STATUS_SRC_ADDR_INVALID			BIT(7)
 #define STATUS_DST_ADDR_INVALID			BIT(8)
+#define STATUS_DOORBELL_SUCCESS			BIT(9)
+#define STATUS_DOORBELL_ENABLE_SUCCESS		BIT(10)
+#define STATUS_DOORBELL_ENABLE_FAIL		BIT(11)
+#define STATUS_DOORBELL_DISABLE_SUCCESS		BIT(12)
+#define STATUS_DOORBELL_DISABLE_FAIL		BIT(13)
 
 #define PCI_ENDPOINT_TEST_LOWER_SRC_ADDR	0x0c
 #define PCI_ENDPOINT_TEST_UPPER_SRC_ADDR	0x10
@@ -67,6 +74,10 @@
 #define PCI_ENDPOINT_TEST_IRQ_NUMBER		0x28
 
 #define PCI_ENDPOINT_TEST_FLAGS			0x2c
+#define PCI_ENDPOINT_TEST_DB_BAR		0x30
+#define PCI_ENDPOINT_TEST_DB_OFFSET		0x34
+#define PCI_ENDPOINT_TEST_DB_DATA		0x38
+
 #define FLAG_USE_DMA				BIT(0)
 
 #define PCI_DEVICE_ID_TI_AM654			0xb00c
@@ -108,6 +119,7 @@ enum pci_barno {
 	BAR_3,
 	BAR_4,
 	BAR_5,
+	NO_BAR = -1,
 };
 
 struct pci_endpoint_test {
@@ -746,6 +758,62 @@ static bool pci_endpoint_test_set_irq(struct pci_endpoint_test *test,
 	return false;
 }
 
+static bool pci_endpoint_test_doorbell(struct pci_endpoint_test *test)
+{
+	struct pci_dev *pdev = test->pdev;
+	struct device *dev = &pdev->dev;
+	int irq_type = test->irq_type;
+	enum pci_barno bar;
+	u32 data, status;
+	u32 addr;
+
+	if (irq_type < IRQ_TYPE_INTX || irq_type > IRQ_TYPE_MSIX) {
+		dev_err(dev, "Invalid IRQ type option\n");
+		return false;
+	}
+
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE, irq_type);
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, 1);
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
+				 COMMAND_ENABLE_DOORBELL);
+
+	wait_for_completion_timeout(&test->irq_raised, msecs_to_jiffies(1000));
+
+	status = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS);
+	if (status & STATUS_DOORBELL_ENABLE_FAIL)
+		return false;
+
+	data = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_DATA);
+	addr = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_OFFSET);
+	bar = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_BAR);
+
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE, irq_type);
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, 1);
+
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_STATUS, 0);
+
+	bar = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_BAR);
+
+	writel(data, test->bar[bar] + addr);
+
+	wait_for_completion_timeout(&test->irq_raised, msecs_to_jiffies(1000));
+
+	status = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS);
+
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
+				 COMMAND_DISABLE_DOORBELL);
+
+	wait_for_completion_timeout(&test->irq_raised, msecs_to_jiffies(1000));
+
+	status |= pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS);
+
+	if ((status & STATUS_DOORBELL_SUCCESS) &&
+	    (status & STATUS_DOORBELL_DISABLE_SUCCESS))
+		return true;
+
+	return false;
+}
+
 static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
 				    unsigned long arg)
 {
@@ -793,6 +861,9 @@ static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
 	case PCITEST_CLEAR_IRQ:
 		ret = pci_endpoint_test_clear_irq(test);
 		break;
+	case PCITEST_DOORBELL:
+		ret = pci_endpoint_test_doorbell(test);
+		break;
 	}
 
 ret:
diff --git a/include/uapi/linux/pcitest.h b/include/uapi/linux/pcitest.h
index 94b46b043b536..06d9f548b510e 100644
--- a/include/uapi/linux/pcitest.h
+++ b/include/uapi/linux/pcitest.h
@@ -21,6 +21,7 @@
 #define PCITEST_SET_IRQTYPE	_IOW('P', 0x8, int)
 #define PCITEST_GET_IRQTYPE	_IO('P', 0x9)
 #define PCITEST_CLEAR_IRQ	_IO('P', 0x10)
+#define PCITEST_DOORBELL	_IO('P', 0x11)
 
 #define PCITEST_FLAGS_USE_DMA	0x00000001
 

-- 
2.34.1


