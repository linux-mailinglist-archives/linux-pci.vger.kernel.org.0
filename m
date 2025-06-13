Return-Path: <linux-pci+bounces-29788-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C31D3AD9760
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 23:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64502177037
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 21:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD39271472;
	Fri, 13 Jun 2025 21:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="H9htila4"
X-Original-To: linux-pci@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013002.outbound.protection.outlook.com [40.107.159.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9BA1FF1C4;
	Fri, 13 Jun 2025 21:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749850470; cv=fail; b=XL5gzWGMdJHftqFRrPXmYvVR/To6zPDk2WiStzHtL0kq5z/ID+dKMq9ZU3NjzhHsB+iWx8NIvu0tYcSSSYoBGgjvAbWiufp6DSEiFI223V2UvILzclJQW2X9FCZumrB1LU7pGsPRN86lv5JFWsbA1FoUfxrZ3SCpQem42c+LVbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749850470; c=relaxed/simple;
	bh=l8wxDtunRt77fiPAZcH3UjVdlN8gZ38x3V2L9pdbh1A=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=PLxiP5vOgoy53jNIfR/nKFL/s7dbEZOGRPlWUPRxJMj/o8m70Fckp1e5ocO5N8a7DvqikzOtkCIUo4CR2bliTqkSBk+sCcvEiq+d/JKRH6gaK8HM/nD36RRbLniAE44ihovpEeqLQr9r14g7Jv/Dya9ViIokBga5drF8muozzlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=H9htila4; arc=fail smtp.client-ip=40.107.159.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MQyPFb+Lax9Eg8QWCuSWGJY7nDWOQoYhlGU4Hn083ZFcH+jH+dUDlXvxAATw4l7BjfIrex1Ox4Bs2jGXWGioadXFb9zcKutsd2OQSCssyAYQmB3/qW1f9gnKPrENvQKNHZaMfhCtebxnXRRWWlLe2EgS4hqZrEJW2++0j8npTHt3NiwEL7Fba6oXaBGPlr24TrlqOaZ9Tqr7apti1VP7Xe+Bw/jcrx9l+C8XCcWnrjXFZzG9IUpJnXsCF7CuV3zlsqnocYgeCEU4OhLBd4nOrzM0ExbE4E90peSiLTO7BtrmGoT9QRhTWWYkUtnlofu2eP9BaIE6BzKR40vki4DpPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3nGp1gru8cF0nd5MPUCwliMZLqDFgCS5d96XveRiLs0=;
 b=A6D7zCQwoB8O4kKsSZoHfIew9fM8E6WocVNB8Ls2l8W74E9sQA2smLNRjtMyv+iB4AC13xCGliXBCPl+RZUMY7oM+CCMnaM/jYOt0pVIcYIoeIS05ysjXSh2XNas/3934AStIGDGaM/34vhUhIDxtqzuqZRwmX2H+VeCZALtscUv1VYTkxa0n8C0Uj49bGXV85iNRNz/SpHIfEr3bZXSF8HypIZRgqf2vERixrYZH5Q0rVUMTgCI6sbOjg97oPeaAHdPy5E1utKUOzfStLy/XArQKo9AeHxkx61+oS7a/SwACTHyJqhAVew4Lglg6VvKCNpKbnRQHhZ/+y+tI3rqHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3nGp1gru8cF0nd5MPUCwliMZLqDFgCS5d96XveRiLs0=;
 b=H9htila4gjghz8R3u+58mVW1zVe37XV/H6jnPeittnJ4RjCJpGe/H1lfY4trvlswrigvlAyYraDb0ZnhZmT+zQkjgnnTfkwEb6r8E8a8hicdgtLg8X76VmdpZxuPn+g2MBiQTybAKHniP2+bcF3q33A60e18l/x8w5EQBeLedrSqdt4eKHJzhUM4K6mvMSe9XIwMuX1KCL22jGSGpB0C7IxWLHKx4BWkJufUS5enb8FqrnWNolbZ2/fb0nhkm8fBFLCNyGEDElZ6bBX2pJOCbHVkFgpYi+ltm4xGOOWhfQLUHaTkVWEjx5ftrOEJ2E66ZXDXwMkMU4AiE7ZH+Xw9fA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS5PR04MB9856.eurprd04.prod.outlook.com (2603:10a6:20b:678::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.25; Fri, 13 Jun
 2025 21:34:24 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8835.018; Fri, 13 Jun 2025
 21:34:24 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH RFT 0/2] pci: clean up cpu_addr_fixup() for visconti
Date: Fri, 13 Jun 2025 17:33:28 -0400
Message-Id: <20250613-tmpv-v1-0-4023aa386d17@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACiZTGgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDM0Nj3ZLcgjLdNMPkZLNUEzNjYxNjJaDSgqLUtMwKsDHRSkFuIUqxtbU
 AvomvYVsAAAA=
To: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749850461; l=798;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=l8wxDtunRt77fiPAZcH3UjVdlN8gZ38x3V2L9pdbh1A=;
 b=FU2Mp08osc4jy30XXEjYMtrD8/u0VULFjqiiEjAbe4QFUuGmUlyuE+uMY7c0UGjUPfU3BMgvM
 AQJ8IatvJSGBOqmacZKN0H3Tk3lh5spis7dlurRCour4cvVIzgEmXX8
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH5P220CA0013.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:34a::10) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS5PR04MB9856:EE_
X-MS-Office365-Filtering-Correlation-Id: 76531474-b679-40c6-4c07-08ddaac210da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TktvOFdTYy9ia0dyRmlkY0ZOZjdObXZPb2t1Sm00bWF1NkdVUjFROHEvb3k4?=
 =?utf-8?B?NkpickYxK29XQmU3dWJqanBETXlObDJiVEdUM2NjcUEwWDFKRXQrRHVyR08w?=
 =?utf-8?B?ZGNVTUFueTJseU1zTklsWTk0a3Ziczg0b2lGRTNVQ2x5Y0pRNHlxdjV3bFRv?=
 =?utf-8?B?L0JzRFhWTlcxNlZ2STFIVndjZ2xKUjBNRndCT0V2TU53RG0wZnpqTjh6VlBN?=
 =?utf-8?B?cXpub1RBUVFNNmF1cDZTUDdHdnFobDdwYXRFUGpxUmlwL0VFZVlsU0F3ZUlG?=
 =?utf-8?B?dHFHN0RETFYzRHMwWm9RQWFHeW1LRnBGYTRKdy9ud2ZWWG5ScGhqU3JvTXFz?=
 =?utf-8?B?S25maUpWZ2hidkN1eEZiL1dOUFhxcGpleWNaTXp0S3k4bDNsWWNWQzVDM0Jq?=
 =?utf-8?B?Vlowc2R6Y1lpeEI1bXZPdlM4YkpWcWNUby9ZbXZxRUVkeUFIcThPazJJTWlE?=
 =?utf-8?B?V3ptN0RTZWp0elRydE4rNVVVQm1WTGtmbW93ZEorT1JZQW5IbmtOUk5Xbno2?=
 =?utf-8?B?N0JpLzV3UXY5ZXBhTS9oSmFlSk1USkQ0d3RXbVhRSCtVb2tIWVB1dnZlQ3pE?=
 =?utf-8?B?azBocHp1SXZydEhPVThuSlJScm1PRU5HVUpZUzVlTHM1YmNndzRFdFA3cENG?=
 =?utf-8?B?T2tJbUZmSjJlQXhjbmpyRzRDZmpvS3dwMnFRT2hJSmFiVXFUdTVORXhjU1Q2?=
 =?utf-8?B?c2R0Z0tqRi9scTIrL2lQVEtyYjRRRGlSeTRvOGhUQzBVR1kwdzA4L21jQW9C?=
 =?utf-8?B?RkRCRy85aWk1eVJMSHJnL0JzeWN0cVU2RU56Q2VYcTNKWTZKcGh1THVYWWlj?=
 =?utf-8?B?ZEdobFJyVjY0YWlLQ0tlUStMbkpEM3ZhK1luVzFLb0dtRkQyZk9TdFJWa3lS?=
 =?utf-8?B?bmVzaHAyMEd4cmNnbjR2N2pDMDJrcXdnREYvRU5aejZrZGxHbDVmOEl4dGdn?=
 =?utf-8?B?ZXU0dHM4bXNKRU1aenpTS1lROEZiT0Q5eW1TK05uOFhTVzcvRVhzeDZiL3kz?=
 =?utf-8?B?TjZ5am1aYlVOaDFXeXh6VFFzN0c3cHF1cVF6VDdLbjVhTzZORy85VTM4M0I5?=
 =?utf-8?B?d3ZwdGhTVEQ5bW53RlpGWGhwV3dPSzlVWU9pSXoyQWdhL1pSbTBmVGhoRUFY?=
 =?utf-8?B?V0Fnb2g4eFNlWGRnWUFVSm81VUM2aEJLc21BcU8waXllS1lWRXpBMmZiOCtK?=
 =?utf-8?B?MVB4S3pBdEZFU2xKelZFY0NkZUsvZUJGcERSWTY2aENWZWdQdittTE9YQTJa?=
 =?utf-8?B?ZEgxQ2tXb0RhN2hGWTBrRms3Q3BrUTJrZU90cWFoTlg5Q2NMWDU1eEZoYXBp?=
 =?utf-8?B?cjhtcU9yRGl2S3c2UlZtQUlEV3FNOTI4S2lxZ0ZxRXJQTk5nT2NlaGc1c1lL?=
 =?utf-8?B?NEVGYzRLYWF2VnhFbWdJOFdmY09OQlFxU1V3VmF6RWhzY0tZNmp6QXFzUjJa?=
 =?utf-8?B?djZQcEhVMStpNmMyaExlTW5OdS96dUdvRjZ1cWtnaFFmODV5NFViVHdDSHM2?=
 =?utf-8?B?d0F2Nko5T2FjNitJc0srZmNCdENpb21sY0lNbUJqTGpIMDJqOENncGhHb2Fz?=
 =?utf-8?B?NkhiQzhiVTlGdThGWjRCK1ZUb3d2Mkh0WERvVFNQWUZMcU54SXdwdnFXTS95?=
 =?utf-8?B?ZWR0Q29TY3l1MEpTaU51dFE0NjhrVGtlaE5qanIrQUkvVSt3ZW1aWTBCekRB?=
 =?utf-8?B?QVdKM3R5ZTF4ZXNRSFZlZVdFS3BjMlNRUTVydmxZZ3VFWXFEdlBsTVpsWUs1?=
 =?utf-8?B?OEZUKzZNaTI5MTJNd0t3WUxRRFV2VlNKUTZNN3ZJam5lTnpPeFVaQkZSd3Rr?=
 =?utf-8?B?OTF6YmNtQWo1Q3J0N0ZoL3NlOUNkNmNIaVFTVlhaZkIxcFlsVzl5VnA5WGFz?=
 =?utf-8?B?SFNJbVJXLy9QRWprQzNtOFRpTVIyVExxdjNTZE1uOU0xczN2UmY1clhhK1Qv?=
 =?utf-8?B?SDF6UWNhOU9jRXAwUldsaVgxR2c5YnJNd2NvdHFYbkM0TFFzUmdJQ0E4c2ZO?=
 =?utf-8?B?cWRCU0x5RG1RPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WDBZVDlOTmxKTTZMRTZHOUgxR0o3MkRvY0pLdWhOT2E4MnVpMmJiaEx1SXpM?=
 =?utf-8?B?YzdrWFYxUWgxNnNsM3ZTVi9QdEdXODZjQ0FuekplcXQvZU5vcHgycklYQm9F?=
 =?utf-8?B?a2ZnVmlwOUhlL2xWUnVKSFZsS0o5TzViTzJuZ20vWnI1WllXSjc3SmlhRlJY?=
 =?utf-8?B?WGdSc0tDK0Y1bHptZHNuS3lzSmk3bGJxdmJpd05ZeXpWZHU0RjJkK2ZtbWp4?=
 =?utf-8?B?WENHZDdsSW81MGpEZ0NUYjVBY0ZtWGxNMUJCajZ0cTJPNFYwY0pORUYwV2R1?=
 =?utf-8?B?RWlWQVF4aDhjY2dIc1JJOU5ydCtQSDNGSlpPNWhTTXpnOWwwMDRrUVY1TUNC?=
 =?utf-8?B?bm1xYThpUTdYRGJrMm5MSlhNSmNRQWNWMTh3N1NnbnZlSzAxRENxQWRQZThT?=
 =?utf-8?B?WE9jNlgwbnI2eUR3M2xxSDJsamNEbjJVN3Q4b3hxYW4zL0RGa1lLSTdEWUMz?=
 =?utf-8?B?cW9oclRiT0xRRWxNa3FkNC9TVGxuVlFpS3NXVGNrRnRCNk1ycHkxektZTzF6?=
 =?utf-8?B?ckhBZ2cvM05uQjZsVi9Zb2NqK3NDbERGNWFMaTRKazlYcWVhQWJWSml1a2gv?=
 =?utf-8?B?Q3p3K2ZXS3BkeUFLd3ZCZXYvamNEYWJJVVhudEpCajVMUDhockFLKzg1WlMv?=
 =?utf-8?B?NUNqaVB5NEd4SU5yTldpTlBmSHRhbGxTR2lSaGVreXNZUzRsWXBreEsxdkd1?=
 =?utf-8?B?elE5VDYvb3BlaDgzcURXZ1VsNUYvNHNlVDdxL09EeEhtZ0l2YWlaK2p5a0l5?=
 =?utf-8?B?OHAwZ0huR1dGV043YWhQN1dJd1pvUytKdFJuOHBZdlNBVytxVzVwTXhvamQr?=
 =?utf-8?B?MVhTMDdtMmFESS9rd3cvbllySVBidUIyTy9lWGw5NWtJamhBWjcwT2hUNnRL?=
 =?utf-8?B?dHA5SFlVbWgvdi94aGxZTEQvU2wwaVNmQy9lV0lQVXpKQUZ5SHpjMHJzR3Y1?=
 =?utf-8?B?WnphUnpEM2V6WFhHV2dTc24yS1hYRkpUenExWlVYNXVwTFVSQ2FUZmNNOGdu?=
 =?utf-8?B?dU9XbTRDYTdtTEkxQjcyeEhLa3dBbDNOSzIydnZadExVa1RqR2lTblJoMk1O?=
 =?utf-8?B?aFpDUXNCektzVVAweXV2dk9qK0g3bWROclRhQmpWa3Y0UzBYRUZReCtZVThv?=
 =?utf-8?B?bTI4VTRtTUt1WlBsTmNvZzMvblVJZkFHNzdtOHJwME8raktxaTQvd0x0TVNP?=
 =?utf-8?B?WFBOL2tuWHdrc1FZSk5tWWhSdERqQlBsZFgybjZvUkZJbE1jZEpWbTBKaFRH?=
 =?utf-8?B?SWFtSHNPT3BDYnl2MXZrcTRvVENtR3BkY0xSOGtqdEp1MS8xQ1MrbTI2S21J?=
 =?utf-8?B?SWtybGU2TDI3bVpsRGJBYWZ3WmVVdFlteUxKamdrVzRrMytjL09kWWNkZXpm?=
 =?utf-8?B?T1lRZW9idVk2UDJRWUJUdjBzZE9LL2VaVzh3bjBReDNkZXNtcWRYbVVjNjh2?=
 =?utf-8?B?c2o1YmlTa3o2QTJrTUNQZCtYMTBUNnJWaFJhSkxzVUVYeWdyN0R2enNiYjcz?=
 =?utf-8?B?OUlMQTByOEpCeGI2OUl2RWVSYzF5cGUzZUV6SUNPenJ5NlFST01BRVZSVGY3?=
 =?utf-8?B?WE9nZVZrM1dINnpyWEhxZlVCYXhWYWFibDB1dUF6V0l6blBXUHZtV2VDS3Ry?=
 =?utf-8?B?TjRmMEdKNzZZKzE0T2lKOWlxNnRVdVF2RThVaTV1MlpvdkE2dHQ1OWVia0NI?=
 =?utf-8?B?cGVvell2bEVYUXEzTFQwV0FhQmY2OHZtajV0OEEvOC8vNkdaT1U4VVI2djNZ?=
 =?utf-8?B?OXJLSlcvMTdVSjZOVW96UjZyZnhoWW9YYUhSNnBidFRYMVgrU1NiVjJXWDFo?=
 =?utf-8?B?MnY4SGoxZ2RrOUs4WUhpVG1uQUZmejZKV0F4OVNMRkYyeDUvaWhTVE9uNWll?=
 =?utf-8?B?Z1JDQWtTYTRXdkpERkFRaHhjaDNqYlFoSGluWTJCaWRWME1JQmd4bmZ5RCtV?=
 =?utf-8?B?cnZ3b2NXWVBvZ3FQSkZldUpMUEthWTVCRWZkS0pneUNqRW1rR3FZeDhvNlM3?=
 =?utf-8?B?bHhmcll0a09xZzFqaDVXWHhvVXp3N0JPZ2k2bnUvR3Bkcnp1bndIT0dUVHdO?=
 =?utf-8?B?QW1rOE1tMkhJN1hDR3c5ZXlrZDg3U2JMWElEYjI1SUpoVHh4RlZBOCtDZzBs?=
 =?utf-8?Q?/SEQQ+JXSvhnz8jbdtL2ftiJp?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76531474-b679-40c6-4c07-08ddaac210da
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 21:34:24.2056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4MKTwoh2WvDG2SRG17Et0JpuHmBSt3SrXH/iddbnsvOvRIOYvk9N7XC2ZT7jgR4xv7GEyUZVICOn3DanN90ycw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9856

Since
7db02f725df44 PCI: dwc: Use devicetree 'reg[config]' to derive CPU -> ATU addr offset

dwc common code have handled address translate by bus fabric.

1. Correct dts
2. remove cpu_addr_fixup()

dts change need be merge firstly.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Frank Li (2):
      arm64: dts: toshiba: Update SoC and PCIe ranges to reflect hardware behavior
      PCI: dwc: visconti: Remove cpu_addr_fix() after DTS fix ranges

 arch/arm64/boot/dts/toshiba/tmpv7708.dtsi  | 16 ++++++++++++----
 drivers/pci/controller/dwc/pcie-visconti.c | 13 -------------
 2 files changed, 12 insertions(+), 17 deletions(-)
---
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
change-id: 20250613-tmpv-f1cc6e463343

Best regards,
---
Frank Li <Frank.Li@nxp.com>


