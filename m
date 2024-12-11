Return-Path: <linux-pci+bounces-18186-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A485A9ED7FB
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 22:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B50B281EEB
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 21:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44950229682;
	Wed, 11 Dec 2024 20:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KrEXKY/O"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2048.outbound.protection.outlook.com [40.107.104.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EA723A185;
	Wed, 11 Dec 2024 20:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733950699; cv=fail; b=Mg4qlKxJP8r9Z0lhFMaTyei8v/7UJbav8ziONy1cKqApwsyiqktxQzAm96JpPLYIKJw+j2/Iwee1f6bGAMHeM7gCJ84uMWBIvQwtXEZaBzN08eDlJWq68RH04CKEgdQ9B5czhMvZdFOuSmVukTEzt97jV4bOYL1UAUd2IFhRjZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733950699; c=relaxed/simple;
	bh=ATnxL3MtlZvwsNg/rnjJY7VKdXtCjc5uSP/3WxbH5ls=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Ud/P7g7pZXl2+YV9OPMxigRsxL37RkCbEJ5lnCVUxuQCJ0rCfMxih3+L4LixPmpJsOPj5N7pI7Zb/5/xwXzuEe6DZAE52es12jcC06Q2CkgGGpq4C4n/gRaewOlcgnLuLOGOD58FRPHN2Lt+bOv2SoXcfwz5GiFKgORDDIRy5f0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KrEXKY/O; arc=fail smtp.client-ip=40.107.104.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sBwhkYFtls6et2fxQGCKgJ6tE6dBACoousVa9353oneihsatBNMggzN4Yu55IJE4+r+7C44sQwZHmwcmivN1ntRB5S+3xBcEZmA930yQRMejyICMHJfSzxGqrShTeS19/rYW4DvlwRhodvxsK9Z+A8Zu5ivu0RHt8y8JS9ETPCaUgPht4NKUd2biIQZW8ENFpDtQb/wRQ8e9RIG5BOEQjGJYir4EQ0cEhFBTlFKyDgYd5e0nzNbgiH1wltoxIhlPu/tOxQuIwSZNwdLlJ2mOCPA3o23MclHPrBTw9IiOzZ1SgYvKH0m7qjr3CXQMlMGGHMLVZtZkYdFrvhyLQEf3uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e8pqhqg1rJbKFFLKPcwz4vZVPUqET3tTJLjryUl1peg=;
 b=fhifroqeAuRpCU8mL8ls0AQHSVMxuHtbVYDBFra4nIoEzowh6VOkslVGKuZDrIt6AUhJyMZW6wsMKGcFpTsD6RjhSp2cFezupepf4GRCu3lg4RfxT5H0N1zw+6Odzo2rq0o7cDfcsyr09F1JH7b7Wf5dzQGSvftqHsGn2hWf/MZ+9x7Bwdc/cG0GLXDpcw9sQwfdC417L/3tF3RFLaEF4SkY8QsyQMsA4VJZxmSwywDOqq4qHOKvIFgEx9JSLRumRydjhPzgJscH4cgNYTctlhoIliSNkCDDgNsSrhMCvIf/V0GxJ5beE7yQ5MG+SlKn927TZItmzRx60T/a4sKXHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e8pqhqg1rJbKFFLKPcwz4vZVPUqET3tTJLjryUl1peg=;
 b=KrEXKY/OpaeShP/6JcshukbMIzyF0H3Hra6ZbvNNj9hEyNDBMCxCMsjj1RFsSYWMtikdKAG6xsKgKZ4HEac7NJLIfPFMtIrcmMcv7ypPcq/bJCZ4liL7TyXic4LiB9xQJsC5qHbS0pT2ZlWgkDrdfjGeEuq4KyIPlfDB6mZG3FiDa3WGdd1fqgROB5XGMUmh9h3cysT4l7+OtBITrnrlvnnpCiPBsoN7eW04iExWx8lbOTY6t9SpKIgsxMwnlmjig5MvQVPqeKua+1JZOZKLos1LBMBNcp/AQC0Uk0z3QER2Y2JHmcptMvL9VlNSBW656MPrapnj2mWeLqvU+0DPAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM0PR04MB7139.eurprd04.prod.outlook.com (2603:10a6:208:19d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Wed, 11 Dec
 2024 20:58:13 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8230.010; Wed, 11 Dec 2024
 20:58:13 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 11 Dec 2024 15:57:34 -0500
Subject: [PATCH v12 6/9] PCI: endpoint: Add pci_epf_align_inbound_addr()
 helper for address alignment
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-ep-msi-v12-6-33d4532fa520@nxp.com>
References: <20241211-ep-msi-v12-0-33d4532fa520@nxp.com>
In-Reply-To: <20241211-ep-msi-v12-0-33d4532fa520@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Anup Patel <apatel@ventanamicro.com>, 
 Marc Zyngier <maz@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 imx@lists.linux.dev, Niklas Cassel <cassel@kernel.org>, dlemoal@kernel.org, 
 jdmason@kudzu.us, linux-arm-kernel@lists.infradead.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733950663; l=3395;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=ATnxL3MtlZvwsNg/rnjJY7VKdXtCjc5uSP/3WxbH5ls=;
 b=HXiGHHTwwx7E5UQgOBkgSKnHF98cvOYYzQEFoScg0AbvTUrMm41/UCTDdaHC0QMJITRoJTUlU
 Jcjjz7xPgelCGAH0nzFH2nlAC1JVQzGmrf2G5Kivg5JSE5W+gkqaGCH
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR01CA0037.prod.exchangelabs.com (2603:10b6:a03:94::14)
 To PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM0PR04MB7139:EE_
X-MS-Office365-Filtering-Correlation-Id: dc2c9820-8dee-4915-0731-08dd1a268735
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|7416014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QjhkMWdOSkZSMkViczdWVHQxRFpWTlZQOENQMzc5SDBYVEFsSlVJdTFMRUha?=
 =?utf-8?B?SGJTb1FFZVNuNlZXb0s0VFNNYmpxWHdCVXlIRnBIUjd6SW9JVVloZzFNNXF1?=
 =?utf-8?B?Yk9uZXg4b3VpMHcxT1kwa2FyMzJ1Mm15WXZuUUd6WThwWHNGbXBPU1R1blBM?=
 =?utf-8?B?TlVHRjlPWWlFVXpwVHFUYUlRS0oxVXUrYjhtUHE3TDN3TlhWSkZwcFFRZXph?=
 =?utf-8?B?QUp0UWFoTFpMczdzWVJDeFQzU1ZpOUw1dHRHbzZvVitOWTMzQ0FEdVIzaUMy?=
 =?utf-8?B?SE1zaGNrSk1LRWlMcm5TeTZacDF0aHg3MVJrbExyZUJCR1BBcVpHSm84MW1o?=
 =?utf-8?B?NVJ0WXlNd21rZUFOVlI3VzBucDVPOTBaNkN2b1cwRUo2MG0zVkNNM2ZNQmdE?=
 =?utf-8?B?N1Y0RDlOT2xNUFYreVFtODQ0NDFkMjd3bEpOSFZZK1hTQ3NoYzR3UThuNEF5?=
 =?utf-8?B?MTJCOUJjOXJEWHg3VFJZQVRDZTRWeERicFEycEhsT0FONVFYSUZwdFhmbHdN?=
 =?utf-8?B?N2JvU20rWUFBSVljSHorOVlVRnZ2dlZCWnMzWDBQK0hJNGpQWktGUXVnQXM2?=
 =?utf-8?B?SWRIbjFxOWQwbU5rTWhvZyt3MWw4bERrSndQdmVjQm84UTlub0N6T0QrcVNl?=
 =?utf-8?B?d2NvNW82NnQyM290TVVyM0UyMnlNZHAwRmtPb1ZVYmJUK2VWZmZWVGpFcU5X?=
 =?utf-8?B?SlA4NFBHTHlvMk4xaEoxcmdVaFJ0ZENYQVBZMWZhK056S1lHdkNDK1lqZmY5?=
 =?utf-8?B?MWp4aC8vTllQc3V1UVJIajNTdE5KMlQvQmNIY2IwMkc0VzZqMVRERkZBR3hi?=
 =?utf-8?B?YVB4M3k4VDlVR2owSEZoK1JnNERadnladUZUVlp6dm80Y0NpZ281VTlIaEhJ?=
 =?utf-8?B?YTBEWGM1VktpRWpxUTdEVGNhNjY2cDU0SzFQQysxK0MyT3A2ZnpDeHcva1dx?=
 =?utf-8?B?S2hxME9KZEkzeGpJa1lWWlZOWUhZWFlIOUg4N3dheU9SL2RFT3hLbUhDWlZ2?=
 =?utf-8?B?SjBia0RVVWF1eXgzK2VHdlBkUkdYWjFWU0o1NFBSRmNSaVNWYXZ3ZTJOQTQy?=
 =?utf-8?B?SjliN24yN0lBODg4M09Bb3ZVNFAxOUx2ZWs2NkcwdlJDcXRyWlFPT0FVakFq?=
 =?utf-8?B?UDl2K2xwc0RmTFhLbEU3eWdHcy9kTTBoNUJNRXJvTUNpcUhmSlVBVEdSTG81?=
 =?utf-8?B?ajRBbW05TDVUWWY3aVROT08yaTFIZGpBMGI5emd6VVViNHE5VVhYeTJFUnNE?=
 =?utf-8?B?Mnd3UFRBTmg2QmlKSXA4bXhpM2ZPS29XcmR6VW1rZDNJTXFqU3F1RWxDbE5V?=
 =?utf-8?B?amVnejFCcUE3TGhFcmdRa0szNHNwR0o2N0x3ZDFubmx3eHlGenVDa090UXRx?=
 =?utf-8?B?NmZCWmxYUXJqdG5pK1pGNkRvRTY0RGYwUU5ISUhCYWNrckxocGwrem9DaWFO?=
 =?utf-8?B?R2ZpaHhsMWMrWWtNaGVwMXd1RVVsLzFRVzBWOGx2a3dndU9nSU1BSmY1RG1t?=
 =?utf-8?B?QWVJbDdYYnRUTmxFdGYwTGM1VDdzZmU0RkFrYWZZVS9uVTQ0ZjhEcmtzdnM5?=
 =?utf-8?B?WklSclhmejZ5ZmJ1YVhUS2hvS1JQTFEzRXMrOCtyK0tBWFNtMUx0VGtFTmF6?=
 =?utf-8?B?REp0TWhlaTZCaTRDTXVJYkhiK1c5aDRxdE42dTdVbjFabXlyNkU0eVBnTmZZ?=
 =?utf-8?B?UFBsOFZQbVhqUXNUcDNXTGlTa1JZZ2hINFNOM3FFOGJuNHlYcHV6eFpYekF3?=
 =?utf-8?B?c0JGUi9MWGs5aUN1ZG5HK0UyWmhkd0F4ZXZ4MVFkeWNHYUdhQ05VekdvQkhO?=
 =?utf-8?B?VFovcnV1VVBLa2JkSCszcXcrNG5CK01DNjhBQXRuY1BaYm1EZWU0bW92VW5N?=
 =?utf-8?B?dFIzMzZyS1lkMlpUOXZmbjFqM1lqMXFtVkRTMm5zZHNvaGJaYnM1R21UTVUy?=
 =?utf-8?Q?g/VJmt8rbTM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(7416014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZzdLRTBVaXp0bTlLU0wzeHowa3d5bWtEK0Zwa2FrVk9mNmpoV2UrbXFxU1J6?=
 =?utf-8?B?SzQ1U1R6SFJOOXRzRVNvelp6UUoxbDJtY1pDWVJHWUpGUUcrYm1sdXRWQ1Ny?=
 =?utf-8?B?aDdjMDZoU2RFM3NSMC9QNkpKa3pPaFN2RkY3L2F6WlZRaXIrc211YXhxemhF?=
 =?utf-8?B?V2t5Nm1ucWVzcVdGM3BicGJaVjRMOHdqaEExTmVndUVNWVpSZFJMekwyOVcx?=
 =?utf-8?B?ejAwckowait2RTZCbWplVkorYjdCbWZCTUtwU2VHcXAzME1WZFp1M1o2Vnpu?=
 =?utf-8?B?K0xsN0k5aWdBK3ZjUlBubE5UUUMzeGdPbXkrWGdFdzlGYjQwQ2oySkZBcnV0?=
 =?utf-8?B?cVBHa0ZXLy9NUnU3UEppVUorNmJWdlBsYnRoNjUvQW5mOHlienlzVWpsV0hp?=
 =?utf-8?B?SXRycGhGMnJheitpSXhzWmc2eXNGNUZrazEySXUycCtoZ3MzMHEwNlZsYmtM?=
 =?utf-8?B?d0c3RzhpN0lmSHlLNkluYUFEcWpqTmoxNEpCRkVMWEJLWElPSUxvL2FMRjFG?=
 =?utf-8?B?TDdlUG1QaHNBWmxuUzRsQVBnQUJsamYzQ2s2azkwNFhUaGN0S0NaYVRjT2N5?=
 =?utf-8?B?T3VwLzlxbVhUMnVYQjNoRjY5bDE2MmFaaDlyQ2Z4dGZxK3pVcTJQTW9sbzVI?=
 =?utf-8?B?emZ1WUJMcFNSenM4WFpQblN6VVRGejhBTnAxT3hpMFpFZGp5TXEwQmdLcjd3?=
 =?utf-8?B?QmRIaUgxMVVBd2o5TVYraVgwaHJicm8reExaUEdzTnc3azVnYjNoK3JDeWpa?=
 =?utf-8?B?Rkc4MndFZWhRMUlsZ1RoQk1PWThaZVZPUVd2OWVxdVV5SENEQWQ0cjUybnQ5?=
 =?utf-8?B?VWF0TXZ4UlNQNkgzUTRjZC92QmpiUHBJUXVobnBiUmhCUW13MlFNdW84TmJI?=
 =?utf-8?B?aEk2ZjdVTlVvdGQ4bHBqSzdyV2dmOVc5T0k3K0VTbnlYRFdFSmYrUlRvL2hW?=
 =?utf-8?B?ZUpMOFBHZUtyOVVtY21wNXRBNVNqeVgvLy95SUhrZWhQT2hzQWxmekVuMis4?=
 =?utf-8?B?dGhmU0xzMnRUWVRVb2xVZFdzNGJHNFZsRElmRVZjdXVpV3gyUHVrcFI4bEJk?=
 =?utf-8?B?ZFgxM244MTczNnFMcU5rVngxQmJrbW5NWkZnVUpYNUtuTVRYNXNqSnVYRlll?=
 =?utf-8?B?ZSs2MmN5bm8vUzRiL05qMXAycmxzOEFxNkRqc2pObmdsZzlEM1NZZk5rclJx?=
 =?utf-8?B?MjdRUGdUdXdFSVBTQXIwaGlkOWF0aXZFR3VIMEpiRWVCek1VWUdnWG9JUWNC?=
 =?utf-8?B?V0c2UEkzVDBkL3NwaldWVWdxUmRZdlFRU080Yk5GUkZQOUh5TW1idDZMMU5m?=
 =?utf-8?B?UnFYTllFU3RQQmdBZmpmZDdtMmxRY2RaWFVPM3dsNTJCdFNGditzWFpRaTdQ?=
 =?utf-8?B?eDRBaTRqbWhERXY2aG56Rm91aUpNQmw1NGpVUzJVcUtYTlArSEJHTHV0NE9V?=
 =?utf-8?B?T1JUTVBOMXIzc1M1VGJBWU5od0NGdWo1a2o2TkhYNFNqM05ZbkdLN3R5WENl?=
 =?utf-8?B?WUR3TkpNd0c3NnZvNU1nMzRkVzVvWGVkT3M5M0hDa01GY2FXaXErUVBudHFm?=
 =?utf-8?B?aERCTWdmQUk5cEM2VEFQZElva2owNkNaV3NpZFYzRDNQOGZDQmFOaTBpOVlJ?=
 =?utf-8?B?Q05wSWF6NVlBY1RFZVNTaGo1d3BQazBzOXF5TVpEN29FaTJVb0ZGL0JmT1ZG?=
 =?utf-8?B?UXlQTlFxV3JkRFBuazllUVFMZHA3QTM4dmkyVkNBQk45b05zL0txRHJWU1FI?=
 =?utf-8?B?c25lb0IzZzF5NmxnUVY5aXN0RXFTcnIwTDdhakRGYW1SSEJNb3NvalZUOWVN?=
 =?utf-8?B?emkwOVByTzd3alE4dE9FK0habW1vclVZdnc2Zm5HaUxEeCtJRjBmSHdSQjFu?=
 =?utf-8?B?MnlvN1lrMmlCTXZKMW9pWkJ3QzBRWFhBU1o5SmZMOU43UnNwWlUrZy9hMEJh?=
 =?utf-8?B?Z0VXRUZKaERvcTFlaElpd3M5MjlTODFqd2hmcnJhSXUxN1pXclpoSGVXM29z?=
 =?utf-8?B?TlBJSy9neFVYK0VHQTdSWVhaaWlFU250U3NTWmd3T01TVFdGeUI5ZkRhWlVx?=
 =?utf-8?B?VmFxeGRxNzNJaVFLNTA1REowRDhoNlpNMjlVaGVnaldubVRMdVN3OWhtYmtl?=
 =?utf-8?Q?6nPPFoQLPj8wsnGa1ncprWdgE?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc2c9820-8dee-4915-0731-08dd1a268735
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 20:58:13.7067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AZeV8ebavj4SakSMGU0C416Fyl03txeHhFu8lB3d58d48Ex6qtRTBWmwEz5DbI574GNdaW8lD9QlzW2Q5qstxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7139

Introduce the helper function pci_epf_align_inbound_addr() to adjust
addresses according to PCI BAR alignment requirements, converting addresses
into base and offset values.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change form v9 to v12
- none

change from v8 to v9
- pci_epf_align_inbound_addr(), base and off must be not NULL
- rm pci_epf_align_inbound_addr_lo_hi()

change from v7 to v8
- change name to pci_epf_align_inbound_addr()
- update comment said only need for memory, which not allocated by
pci_epf_alloc_space().

change from v6 to v7
- new patch
---
 drivers/pci/endpoint/pci-epf-core.c | 44 +++++++++++++++++++++++++++++++++++++
 include/linux/pci-epf.h             |  3 +++
 2 files changed, 47 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index 8fa2797d4169a..d7a80f9c1e661 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -464,6 +464,50 @@ struct pci_epf *pci_epf_create(const char *name)
 }
 EXPORT_SYMBOL_GPL(pci_epf_create);
 
+/**
+ * pci_epf_align_inbound_addr() - Get base address and offset that match BAR's
+ *			  alignment requirement
+ * @epf: the EPF device
+ * @addr: the address of the memory
+ * @bar: the BAR number corresponding to map addr
+ * @base: return base address, which match BAR's alignment requirement.
+ * @off: return offset.
+ *
+ * Helper function to convert input 'addr' to base and offset, which match
+ * BAR's alignment requirement.
+ *
+ * The pci_epf_alloc_space() function already accounts for alignment. This is
+ * primarily intended for use with other memory regions not allocated by
+ * pci_epf_alloc_space(), such as peripheral register spaces or the trigger
+ * address for a platform MSI controller.
+ */
+int pci_epf_align_inbound_addr(struct pci_epf *epf, enum pci_barno bar,
+			       u64 addr, u64 *base, size_t *off)
+{
+	const struct pci_epc_features *epc_features;
+	u64 align;
+
+	if (!base || !off)
+		return -EINVAL;
+
+	epc_features = pci_epc_get_features(epf->epc, epf->func_no, epf->vfunc_no);
+	if (!epc_features) {
+		dev_err(&epf->dev, "epc_features not implemented\n");
+		return -EOPNOTSUPP;
+	}
+
+	align = epc_features->align;
+	align = align ? align : 128;
+	if (epc_features->bar[bar].type == BAR_FIXED)
+		align = max(epc_features->bar[bar].fixed_size, align);
+
+	*base = round_down(addr, align);
+	*off = addr & (align - 1);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_epf_align_inbound_addr);
+
 static void pci_epf_dev_release(struct device *dev)
 {
 	struct pci_epf *epf = to_pci_epf(dev);
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index 5374e6515ffa0..2847d195433bf 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -238,6 +238,9 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
 			  enum pci_epc_interface_type type);
 void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar,
 			enum pci_epc_interface_type type);
+
+int pci_epf_align_inbound_addr(struct pci_epf *epf, enum pci_barno bar,
+			       u64 addr, u64 *base, size_t *off);
 int pci_epf_bind(struct pci_epf *epf);
 void pci_epf_unbind(struct pci_epf *epf);
 int pci_epf_add_vepf(struct pci_epf *epf_pf, struct pci_epf *epf_vf);

-- 
2.34.1


