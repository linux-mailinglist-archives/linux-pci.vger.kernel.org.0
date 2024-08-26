Return-Path: <linux-pci+bounces-12222-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C976195FBCE
	for <lists+linux-pci@lfdr.de>; Mon, 26 Aug 2024 23:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8C461C20CBC
	for <lists+linux-pci@lfdr.de>; Mon, 26 Aug 2024 21:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2615319ADA3;
	Mon, 26 Aug 2024 21:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="i/Wk3ERS"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011011.outbound.protection.outlook.com [52.101.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DEF7F7FC;
	Mon, 26 Aug 2024 21:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724708366; cv=fail; b=DxdXOOhrxgCJz1V2lJ9NSzZ7yFcicZ6iyJvLfibtkONReWFUKmKhs6PDIZY8CI9kKxfOl5usaV5x+9NjcDlIH98qPngJdANck5iGmDTbr4fSDY6jfFQ9w0qMNLu3kZEA3i4sZBjF5bwFlS/h5ixs+1cEeRuWb9wT/r3Kyq7Xyes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724708366; c=relaxed/simple;
	bh=CPlG7Yv03ejB4h6hBLFM2+NS5sNwPU1XLWJhDrpSy9k=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=rWsPA2G6HSGWOLTGOPD7sPrDWpV1SW7stV/ur8IUpAI2B9Hoi0BPY3tVM0DyhLI54KxDJxa9Z/BZCIczL8ojhbqZ9eQWTrvSYEM/ej/0MzSOSglboqCpsUoWwmWLYuj/CdmpNohvfKVOzQK/HCDjQaW0B90YPkFWOYDsWzLioDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=i/Wk3ERS; arc=fail smtp.client-ip=52.101.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TSUwSGF4+UUlYv+Elbx9li7hmTx7HMaRYRgFBjk2tLy3QQHlGn0uaps+ubsFz8zGOcz5PoMwRrcRs9HNb5bb2ElnhdIj0k+s0ZF+n5VnRx7xfzE7/4XJ9tQBb1qJCiBNE3xUDVCACtCpNSVEo0nubsWbeWNbAwMqjaKidPhhxoUB9Ia23g1ChP9hFMvdRf0tNUDiPjNZFgaCpQixIaLODKKX0pWaX3KKu2aXT4jtlYcsYkoEDZI9oCsHFoVxwawJSl0UM6KL4Vc25PcAa3Ho3/BLlJYCZioqti7oyct+Pb2+0ZO5akcri+vbstlVro4+vu8d0V1oQM6JpLrB2Pzf4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hV97gB2SZvi726UEf7Ku7TP9jEe05rYKO+JRVRcfpUc=;
 b=iXYVKStnofIvjxzY9Q9iVgBELBBF3xPPDF1C4cuKUfbmqjTGtN4KGQwdgaikmSrTxSclOa2kQR17MxTKrSkeN5izB0EKZjpWuZOzphoYw6yFW4KCYcOFR8wfs9QuNCUwX67S4oGquvceTwGdMR4wc4l51lkjRdldCmAy9/Q9Ovk5tsRVN7N2kAJ9ezaJ/SP6NTjRnziircJS7l+ub7O0rLbl8iOOu0KI7bebD6EyQxTSLKdJ3qWQOgDPywH9N+92BJ0+uz3IjSe5rN3Y3hTrAVcdzPXB8YjMoOk6YpgD7kQnVWL+HET5Yo34ounLapLqrNubk2ll+VXuu6Q7/paxxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hV97gB2SZvi726UEf7Ku7TP9jEe05rYKO+JRVRcfpUc=;
 b=i/Wk3ERSvYu+0j+Ki014YjLmG1nAmr6szK4tMJnEnsXEk+/hnO6cjNXZp3+5gLrLKI+6vhwXHW4OK6T7V95TgQB8GXsNtfP6o6ks7H6k19g+5kfUf3Co+VgyoNjCX2PD7bFl6/VQH9y4N3iJYiucqodYlRA71dQ1RFa4rRRX269zsWSFGEWQQASrLflzf2sZwYBYjEQ5wEbFY6XHWxx7ijJplgc3qdILUP92HEC5R40fz/kIqZlMS26waFgX6zSp4UZNnxWhGtDXLT0qcJoUkWnEZhaD59FUNbicd+BucLnqjCAzIKQUGE2SjYnIAC+WcRDlb+iKcRhA5dN+SVPmgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS1PR04MB9360.eurprd04.prod.outlook.com (2603:10a6:20b:4da::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Mon, 26 Aug
 2024 21:39:20 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7875.019; Mon, 26 Aug 2024
 21:39:20 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH 0/3] arm64: dts: PCI: lx2160 use fsl,lx2160ar2-pcie
Date: Mon, 26 Aug 2024 17:38:31 -0400
Message-Id: <20240826-2160r2-v1-0-106340d538d6@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIANf1zGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDC0MzXSNDM4MiI10TcwvjNKM0AzPzVAsloOKCotS0zAqwQdGxtbUArH4
 hFFgAAAA=
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Olof Johansson <olof@lixom.net>
Cc: =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724708357; l=2479;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=CPlG7Yv03ejB4h6hBLFM2+NS5sNwPU1XLWJhDrpSy9k=;
 b=bKynfoxMjQCPtpvzZqOfxy+BeCNQ2Yt0yJIGqGLqczWvoVs9SP4AFZy9WjCYMlL5+sS6630E8
 vSfdqFdhFC1Df88ZIGmAJTsUU/6s7o8FTK3MQo9T3u2restndpPb8oO
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY3PR04CA0014.namprd04.prod.outlook.com
 (2603:10b6:a03:217::19) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS1PR04MB9360:EE_
X-MS-Office365-Filtering-Correlation-Id: ee973577-b102-4b4d-6b22-08dcc6178b6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?elB2cTVkUU9RdDBNVTc0dGZiREc0QTJCcXZuYnV1Z0NDU3UyREFWVW4yWFdi?=
 =?utf-8?B?Yit3QjhJMzRJT3pDT1BTRVdMREkxa3Z5U1FyNjlIcFBFbGdqTm93RnVIamhJ?=
 =?utf-8?B?VmpHRTJQVGc3N1hBb0E3bHJaV1d1TloxdU1ScC92Y0JCS0VHKzF6T2VEeEdp?=
 =?utf-8?B?YXBRMVY3L29DNmx5Y244RENpTko0TElCa0phMzBraHdockJXcXJJS2kyUkR1?=
 =?utf-8?B?Z0ZHU05yN0hNNUFMa1gvbk91UklPWGJVaGZhZTQ3UGdzV1owVHpBQktEYU5L?=
 =?utf-8?B?SEFmalBmSGJpT1FkZmpMQis1Mjc0WXJ5cld0SEdJbFJ3bUtBZ0ZrMHpPTWNM?=
 =?utf-8?B?aWxIbndMMFArdVB2TFRaMWZoaVJrYjg5eUNRa1VjWUZ6SnZwUkorOTcvNSth?=
 =?utf-8?B?T3JOYkZHRXFhRklWQUF5VE5MSnVGbXFLb2JjeFZGRUtvZG9yUEMxMUhtMlFY?=
 =?utf-8?B?anl0WHVWbWhaN05PK0NoY3FUQzdzR216Snl2Vm92RUNSTktDZ3hRMjB5UE03?=
 =?utf-8?B?TndLeDYySWczaUkrejhHTElxbkk0RXR4Z3B2ZEE0UmtuTmN4ZUI5NUo0SWhw?=
 =?utf-8?B?VUcwbzgvR0xlSGh2ejVOWHFIeW9IeVY2dVh6R0FJTXJLWEtWRGlPUjE4MnlM?=
 =?utf-8?B?QmErK05wajVwODZjbDJhQWo1OW5vYWdSNm1LbE02dGxZdDdaV3dZL1Era2VR?=
 =?utf-8?B?QTRJd2NQZjVyRnFlRlZXU29vQU1IRzZRSnVOb3ZQazM5eVZyVjdGbWFaZWdX?=
 =?utf-8?B?S2xPOUR6aFpkRlJwZGJ5QjhKd3N2NnVqQTZMTDFCYWIwVW1tTmNmaWJDc1NC?=
 =?utf-8?B?YXR2SlVmcnlvMFkvZDRUV3RYQ1lmc1VwRjBoSDAvT0FUOWtZZGREb1FvdkNK?=
 =?utf-8?B?ZzN2YWxNRGVCNFJBVTJPT0EzZDdWbHN3VUxDd2F4VGNyU0lUd2Z2a240TkhS?=
 =?utf-8?B?OFFsZVE4WEJmTnF4VTM3aUlqOTFUNm1ieVJqa1NvNUFPd29iNHByRStmckd3?=
 =?utf-8?B?MzdTUEROb0pkOHl0dlJBeXM4Mng3UkkrZGNQVFovdXltdFExNUFlYXY2b3Jl?=
 =?utf-8?B?a3NPTW5BTnlNeWhaOThaZU80c2JzcGd1TURwRkIvOVYwN0JqUkZzRWJyUUc5?=
 =?utf-8?B?dDBmSUZKcUpkeWJnM3dIOVd1SVBJVFcxd21Sc3BHaStJZGh5ZDkvQkZpYndu?=
 =?utf-8?B?QkxZVGVLZjB2LzVZVXhGSHI2R0tlSEpjVGEweDRDR3NPMzNXUEhORnZvQ2Yx?=
 =?utf-8?B?TUpzZlJiU0s0SkNwOUE4alVZeWh3SEtEazQ1ODlhcWZPbmxzaHRzUWdlZ09h?=
 =?utf-8?B?UlpjR2RPT1ArMDFwYkdXSzZJVU5tcDB2VFQ3aVpZWFc0UkRsMnQ4MktpMTVz?=
 =?utf-8?B?K0FaV0lkRWk1L093WU0rRWZ0RWdMMWxBQVpQai9RMnVObHBpeXZuM0FQZ0Rm?=
 =?utf-8?B?TXNiS21PYlN5ZUF0WkJyS1lueVREWGRHTkd4WE0vZy96SFByQ0d5dFdmTzZ4?=
 =?utf-8?B?M0N1NDVBVFlWMVc3RWFSOHpRSzlTaU9lRUdhSmsyR2IwUVpmYWxRQ3Q1cGN4?=
 =?utf-8?B?dmMwU1hKTlVhS3N3RE04QzVaYkVIQ3BvUnE5Zk9hZ3JXSGo2MFIyUDMxcDQ0?=
 =?utf-8?B?RmJXam9SWnhsWkJBVjQrV3hMejkvakFybHhqWjJhSUM2enF3VUxUN1dCTlFs?=
 =?utf-8?B?MEtpUHgyQk04L0tCcUQ0WUcvbWRJZExCLy91RWNCQ0ZmTEc3Z1RhckRNRGEz?=
 =?utf-8?B?M2xrakpGdU5QYXE5a0RmeVhXZHJ2T3dwNVhxVVMvQmNqK3hmMVY3V2FKWjZW?=
 =?utf-8?Q?uYQrdbYU5WHMYqjXm/XviO1tnirpI3GUJ60SI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MllnUEltVnJSUGU5cURpTXNyNmFvd1F3czdDU3loaEowYmNwSjM2cWN4ZHA2?=
 =?utf-8?B?TWsyNWZIWDNzZExtaXJzZDJ5TmdHSG5kUEV5SkUvMFFsbit5NU9RZUZjVklr?=
 =?utf-8?B?Wm9ESEcyb2x5K1Vtd1U5YVV5NXBETFp4aHlLdi91T21SNHVMcnJkWkRGY2M0?=
 =?utf-8?B?N0ZFVDBycm15TDJKc1JOWDViNnptZmFybEphNGRycFNjRTJabkRDejJnZlRv?=
 =?utf-8?B?bi9KK1IrUFhGazJXNklhei9TWUdCb2k0NjRhN3RLYWZpUXlGc2tSOU83eUtU?=
 =?utf-8?B?VGp3VWY5TEFiaFVrNmVlUGRaV2w3azJwU0JBMWRQTUdSWXo1VXFRZllSTGVM?=
 =?utf-8?B?c0VaSzRhbmpXekRsNUtrV1hCakdCblBOWFhOYVF3VkF3amx5bFZTbVJHc095?=
 =?utf-8?B?dmNyd0Q2R1lzNFM4TTl5eUdpNnZhbzRPb25HV0N6WGl1eDZ3dk11TVdtWWhM?=
 =?utf-8?B?TU1tRjkvdFVjQ2x4SGl0YXY0SzliTDFZS2ZoWVJYVE11Rnl0cDIyNysycVdD?=
 =?utf-8?B?bkpxSk9pLzNreTBZTmZraXNPU004QVNUMTJlcFhsUzVieHZlMEp6eEVoZXBH?=
 =?utf-8?B?WDAyQXpFVEVxV3hITXY3Wm5rakxpUDYwWmlRYXVzL01DOWo1dVJJUmpTN0Zk?=
 =?utf-8?B?K0t6SE54K1Z6cFRKZVgxL2U2MXpHd21ldzl1bUhvRnUxVVJneXVQSjJVQTIv?=
 =?utf-8?B?R1d0YWh0SW15Q1dKazQwcE1nWVJpbGxBNVhhdmRTdHZuSCtXbjJ0d1pBM0FG?=
 =?utf-8?B?MzluUGxqME1idzFnbEFkTjZLVXFDVHBUQVVFQys2RHBsM3M3VGdwdldGaWJw?=
 =?utf-8?B?cFZFdjNBOU1EcklhM1NrVkNVQkh0R3MxVXQzTEpNWG5zSVBCc1dzQVRacmY0?=
 =?utf-8?B?WktaTUpRdmRVRXluNEt0dEZJanNXcFNOMHg2aHpIOGk1Y2hYZ25sVVd2a09H?=
 =?utf-8?B?Tm1JMzhLVFZVcXIwY3owQ0RwV1U3dHlMU1BhTWRQd3NRQUFjbEg0VXZCeURX?=
 =?utf-8?B?UGM5L21QMEVNT1FhSjdFRUZGWkprQVRjNUQwVXZBRDg2Y0xwcEFqdnpZd0t4?=
 =?utf-8?B?RDBLSUdrd3hRZjlzaGcyd3A0MGd1MlhFVW5PZXg4bkVvalRTNTYzeTJkSUx0?=
 =?utf-8?B?djl1ejIwUW1qSW9wUWh2SE8zR1JSdUhaUHdUbGNreStiUTMrSGF3VlcwbHVM?=
 =?utf-8?B?bGhpby83TWFyQnJCOXFNUHppb1VFUEVBeVFBbGNlM2ROM3NTS1J5Rnc4Tks0?=
 =?utf-8?B?WC9xUC9ZeG1GZWZkTnVYZTl0aGcrR0N1YndGUExlY1d3cVdGOEtPaW9Ecjl2?=
 =?utf-8?B?T3kvUlkxYmo2ekhSeXNhbm9PYUxXQlQybEFMUFNJTmNuY3M0MTBKYmV0dzNi?=
 =?utf-8?B?aDZlTlJyQ2FiVlpqRHhwdW1QclNJRXRTN1hUTTJjRS9TcElQRE9rdWVjUTM2?=
 =?utf-8?B?WTFlbzByTzJ4TEhsT0twVVBDY1VkWnZkU0x1UEdZVmpvVkk0V3VEQWg1YXds?=
 =?utf-8?B?N0RYdFVyZzZueUFjS3E0Y2FCZ1lpRUNMZk5pRFVSdkJwT1o4S2liMW1EVFd5?=
 =?utf-8?B?K00rNFpVSjh1UStRdmNHQjR6TWNDRFJYMUdFTlA5ZWl5VHRXeS9BS1YyeFlk?=
 =?utf-8?B?S0xvdi9NNXdlaXMyVzBOM21BeWE0dlhOczByaEFQdS9ia0lRa0x4MFNnNTJJ?=
 =?utf-8?B?WHJla3lDVjd4aU1TNDF5Vk9kaXpmZ0xucWF0bmo1clFlQStZMzh2V0pxSU5p?=
 =?utf-8?B?aEU0QStNMDRZb3JQNXFSYSs2MUVRY1hTZGJteDM3S1lMWGdZOEp5OENUNDZF?=
 =?utf-8?B?QTFjemR2OE9Od0FBWWRiMk45TVZvbjhTMEZxemdEbm13VFFhdm1nWVpGdDJl?=
 =?utf-8?B?OVVGd0FxL1NUWE9GWmtGNWwzaDJPWWg1cnAxc09CZ1hxWFRLRjRQS2RqSGdH?=
 =?utf-8?B?SUFUUXNob05TWVBoSHlqSzNHTEZPZ3BMTVozdlczaVl2RERwU2hLajFnK3BV?=
 =?utf-8?B?Rml2RjBSdFNhQkVBOEhUckhZb1ZJa3Q3UjBKdHlPZnRDUEhxRlRKQWxIeEVj?=
 =?utf-8?B?TDcySW9jY094d2ZBTnVrVkROaERUdmpvQkZadWN4YU1oSE1GeCtNUjRlQnhP?=
 =?utf-8?Q?Be6Y3hz0KbhnwJgf9BOb4aTE1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee973577-b102-4b4d-6b22-08dcc6178b6b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 21:39:20.6678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uF4T9O4cAP12BXQd6gUOhKM62x7H833e3zdlBc30/laYtQ0x6uMoSoWX5QDYCfqUXvq/ZeVNPtgrNP8nuYD9tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9360

Only lx2160 rev1 use mobivel PCIe controller. Rev2 switch to use designware
PCIe controller. Rev2 is mass production version. Rev1 will not be
maintained and used in future. And no road map to use mobivel PCIe
controller.

Driver part:
https://lore.kernel.org/imx/20240808-mobivel_cleanup-v1-0-f4f6ea5b16de@nxp.com/
Bjorn and mani have some concern about delete it directly.

V2 try not to build defaultly to make change visuable to do prepare for
futher clean up.
https://lore.kernel.org/imx/20240815182420.58821-1-Frank.Li@nxp.com/

Dts part.
previous version:
https://lore.kernel.org/imx/ac41ac85-fdf5-4aa8-953d-6b3ab3c23f37@kernel.org/

2020 yang li try to do the same thing.
https://lore.kernel.org/all/20220817202538.21493-2-leoyang.li@nxp.com/

Olof Johansson report (HoneyComb LX2K) use ver1 chip. NXP can't prevent
3rd parting to build their production with evaluation chip. Rev1's
informaiton have been removed from nxp.com.

Any way, to reduce impact, just apply rev2 to nxp's boards, qds and rdb.
It can apply to more boards gradually.

To: Bjorn Helgaas <bhelgaas@google.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Krzysztof Wilczyński <kw@linux.com>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Shawn Guo <shawnguo@kernel.org>
To: Olof Johansson <olof@lixom.net>
Cc: Krzysztof Wilczyński <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: imx@lists.linux.dev

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Frank Li (3):
      dt-bindings: PCI: layerscape-pci: Replace fsl,lx2160a-pcie with fsl,lx2160ar2-pcie
      arm64: dts: fsl-lx2160a: add rev2 support
      arm64: dts: fsl-lx2160a: include rev2 chip's dts

 .../bindings/pci/fsl,layerscape-pcie.yaml          |  26 ++--
 arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts  |   2 +-
 arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts  |   2 +-
 .../arm64/boot/dts/freescale/fsl-lx2160a-rev2.dtsi | 170 +++++++++++++++++++++
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi     |   2 +-
 arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dts  |   2 +-
 6 files changed, 188 insertions(+), 16 deletions(-)
---
base-commit: 182a1659076d1ae4115534f43e40e94001fd68a6
change-id: 20240816-2160r2-4783f2f067e8

Best regards,
---
Frank Li <Frank.Li@nxp.com>


