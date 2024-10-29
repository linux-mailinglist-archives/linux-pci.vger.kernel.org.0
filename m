Return-Path: <linux-pci+bounces-15543-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD259B4F74
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2024 17:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E6941F23D4C
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2024 16:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB439192D68;
	Tue, 29 Oct 2024 16:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="laTtBPUt"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2070.outbound.protection.outlook.com [40.107.22.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB5A19A298;
	Tue, 29 Oct 2024 16:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730219815; cv=fail; b=iuWijjAzTGaXJb2xEsjRoT/11DgY1+v/xVtyROOs+AkNmA4mxPcSpPPmSRjlkG0O10azQI8XaSQPlyAtW9Z+b3nr2spJt+e57p6GrrlMH4begfPOwS8A781cdoPbLbptwzmxOKyaIA1CGMWD8oza6oGh3IgAl+5slLscX8hcOG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730219815; c=relaxed/simple;
	bh=yZdqmrqbTLbF4+nrhojHvjEl9Y6WyPHs/n0NCAnME+M=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=J22ew4JH4BtSzAZO/Sm++bBwdpw+avNEKnPU+UEvCZSk/Kj68jbLmS9BKAhSJDlUmpceI7v6GwzcUKuqCbH0jfyJjFXmpqqZD2c19lYv+YPiIBIfWuPLJgjXelaSVzdp0Jo+spx6D12FiMAXCZkX0hbt/K0oOkai8Lx0IFt3W4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=laTtBPUt; arc=fail smtp.client-ip=40.107.22.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wAAR1b3k8qzKeouo7APZSFLZ6bGK5EJ0GRkaATAn0dEGORmkp7Rvma0tgK+FN8fD1fVioCB8M+eyKIf3rKST3e4AiHlmjw9P2+QaH+v8m4bcD1L4ip/JV29QQJaJonIoRqiUW8zHAi/jr/gn+OP1wm00BFwyO8Zf8MjCBCHIoTi7IgDAma3XYrtiAuL5pcaUly7G5N72i9lZ+wFz00ZDyrFMYZZmQ9vs8uTGX4jYvUpMJR76/L1Ea3qNLICrIbUM13bPZox9e65VklLZsJN4XPnFjYjyfOQiuIpbLzM82VJ5L94ml/9PFU/bozRbK2sbemiZvW2y9gxI/2Jt346o0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I7E6ctQ873OCWFw0wgYbKh8cLoRdOiMAZxFvYh0tbBQ=;
 b=GJApU2HqAWjTiOrmd2lycFRdPF88tJDf9yiPxd1+CPsVcfgJreyd0vGy+keFKd9f/GJ/pIcfj0qtoVc9GkRZgWLhZbmlzGm5u3Yllyg8Zyn/c/4yEgb58xGCAPbuqseP84hEm4Sjc8l0IAjd9KR4t9sQQiwNugrKxvH5hlE1D0zQSiLJDKsOpLqfaT4uyBWGcD5dsiuNDmpuuLpjbWrda30E7J/tSnr/k+STSpfxrejdSf77yAtKc/9LI2pz7D9liMze2tenY14j0rKmXFtD+UQjqv6K9MoKtM+V1vS96DguNRT94nGzOTiASrHwr0k/kBZOAnbrPArqCDyB/HmwyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I7E6ctQ873OCWFw0wgYbKh8cLoRdOiMAZxFvYh0tbBQ=;
 b=laTtBPUt1R8oX/MISDjRus4Xvt69l3Xlo31yADvaeD7NyUD37A2DgUxgjUyO0LEoObdEAj6e3pRRARNxWhrB8hCUKXleFGdKhSeuhWT5RohRiqjx+ChDOkqC0NKuJ/0tAjJLX+a2RXAfw9YEgTx+Oz8EAIjQaioEubPd1RHYqFjaRDmGzbZCJkFTelKKrHgwGUwgZ03s4JTicu18re457WZCLVFrFHzm3gU8i57SWBuEdhEVGcGpJBbpS3KXAgO3CWMBqN9UBgnuI1JzlkSWjA/RTBhMFVx4QDithYpKn/QBg2ZZyWjnfP8Uo5p/Nwt78uDNDoYMflqL4Cdd9ZiEBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB8431.eurprd04.prod.outlook.com (2603:10a6:10:24e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Tue, 29 Oct
 2024 16:36:48 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8093.027; Tue, 29 Oct 2024
 16:36:48 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v7 0/7] PCI: dwc: opitimaze RC Host/EP pci_fixup_addr()
Date: Tue, 29 Oct 2024 12:36:33 -0400
Message-Id: <20241029-pci_fixup_addr-v7-0-8310dc24fb7c@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABEPIWcC/3XQwW6DMAwG4Fepch6TY+wk7LT3qKqKJM6awwDBh
 jpVvPtCDxMI7fg7+n4rfqhJxiyTejs91ChznnLflWBfTirc2u5DqhxLVghI0CBVQ8jXlO/fw7W
 Ncaxax8alxntfkypoGKW8PgvPl5Jvefrqx59n/6zX6b9Vs66gYhs1tY2WQOm9uw+vof9Ua9GMW
 2wOGAsWYiQmLTHRHtcbXMMB1wU7ELFQM6Zg95j+sAZwB0wFIwsjgGHrwx7zBms+YC44SGQ2wTF
 a2GOzwXjcbNY/e/EhuhQpbQ62LMsvcY1NitsBAAA=
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
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730219803; l=7902;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=yZdqmrqbTLbF4+nrhojHvjEl9Y6WyPHs/n0NCAnME+M=;
 b=+OFkwkhACdx/He9EyjzZV7VNbZBuIot0Z0g0eR+JK3vF5RYPx9NADu9E21DVaPNdoELdh7lip
 AmLaeYDuiTHCreVwo1mYaELWbXyq84p5beGNJTTmyHmeazgO78GGKQ8
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY5PR13CA0035.namprd13.prod.outlook.com
 (2603:10b6:a03:180::48) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB8431:EE_
X-MS-Office365-Filtering-Correlation-Id: bb15ec40-6b1b-4a3e-0abd-08dcf837e224
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZjZrRk92dmZaN253dGRkRVJaM3BCZ3FEMEpCRUJaNklSbFllNGQvUnNCbnhl?=
 =?utf-8?B?VFltVi8zU3h0a1JwYUdGK3NuVGw4clVLMDYrVDVJYk1QcDBydmc5VmNrNDkx?=
 =?utf-8?B?cmowS0xxQWJtdlk5UUY0RitBNzdKMU55TEtTaitCUXlSVzlWK0tSbXNURnUw?=
 =?utf-8?B?NHM0cVVRSW5FOVpZa3NzNUJIaHowK1RTQk1QbGlmN0llUEI5cks1RVZwVjNy?=
 =?utf-8?B?L3pBNURaL3cxaGMxbWFZRjZmVmtCTDZleHhpenh2WnRFWTY2bXJUa09VdFhq?=
 =?utf-8?B?SW1GeEVqWDZLdnNMaTN4MVBMaU5RekdrMkJJWC9hOFVONnpwRDdLMTNaM0l0?=
 =?utf-8?B?Qll0SE9xSUdPbko1MGNES20zK0Z3aWdLTkNTQ3ZwZnVkcjVzZ1VtT3lpemoz?=
 =?utf-8?B?b0hLVWxLdkVjT08wZnRjbGQ2U0RpMVpZeThXWjlKbThaWlRocEc1djJ4bTRx?=
 =?utf-8?B?SU1iZmxDTmM4M1pTa3pGdXBqVjRRMytrOW5KKzJkaitLdXJzSzAxWXRMRkgx?=
 =?utf-8?B?VWc1TG80c0I0R1JIamZ2OUswUFpIeUYvV0w3MWd3Y3NubWMrSVl4U1ZFVU9O?=
 =?utf-8?B?Rkx3TEJuSk9tTHpITXVkVTU1MFh4NzQ5RW1NN0NIVjUvK2JJME5UOVZtc0NW?=
 =?utf-8?B?bHRqM1RTdGozN2VldmZsS2Y2RGd5R24ydXZTOHByeFh0bURNa3lHRlRoTyta?=
 =?utf-8?B?L29BNXpPMTczZ0NZQjhMakFkWTU2WG5mRTR5dzNOQ1VQVW1MM0lUL0JTZktY?=
 =?utf-8?B?T1lZM0NnMVB3aFdEUTgwQkc3c21TN3RpMEJuWmVGMzdibFFreDdkRXFpaWd0?=
 =?utf-8?B?bHV3emtzSVhTeUFJUUJKYUpRTnVMUElNMFBpR0pEUkRVMWkzbTB0djNCR3ZP?=
 =?utf-8?B?bWdVRnlTWEkybDc0WU1oSW45WjJDZkJnTm9uT3NxVGpHaWYyUUx5VnBIRmRY?=
 =?utf-8?B?Y3Z0ZENTMnc3L2o1azVsR2tWTk5OYVRwMWZmMCtSRHZNMnhVRDZSbk1oSHlG?=
 =?utf-8?B?NUU5aUdkN1lYTjlkNXhyM3QwZHppbGh0OXlBTTBKazg5NmFSL0M0aVJEL1NQ?=
 =?utf-8?B?ZXNmVnorR2ZqUG9sS29aTGRKZmxubC9nL2V2WVRIYWp6VFZGTWNoancvTGdk?=
 =?utf-8?B?YmNCSUM5ZXNwRERkbEZ1U3JiOEZTY2lXWVM3YTBvaUd2MEFnN1d5VzVqcTV1?=
 =?utf-8?B?SXZ0ODBVT2tJMFlzd0tRN1BoQ2EyZzJpVG9YUmZucmhBcEdIRGlYZy9QVVA2?=
 =?utf-8?B?d2VOZ0JrRndzQTc1UjczVTdUVm9zOWovTlhKODJ0ODhUSjJDVEJLa0RGbnE5?=
 =?utf-8?B?M1V3ZTM1MjFxYWUyMCtmeEZ4R05pYUMvVzYrZ2UwYkdkMmJrQTFDZTR3Nnk0?=
 =?utf-8?B?aE4zL0JPQ3lyZXhWeXRreUwrUXJBRE00YlRYSUNyM2VDZDN2SFY2UHh2REZy?=
 =?utf-8?B?TW83YzhxTkxuTnVSS3ZwU0RoSkI1SDErdFE0ZkI5TnJYaHBlVFVBTnlqclBT?=
 =?utf-8?B?YWRWU0NJTDcrWGhYODljUkFld25LK3hsMjIzenMramE5bUp2ZGhYOFFpQlBl?=
 =?utf-8?B?VWZZbHVqc0picSt3MTVsYldHVDBMSzVycnVGT012TEpQOFU3MTZkaEJoelFK?=
 =?utf-8?B?Z3hkaE5iOTY2Mi8wZndVOTUzc3hwOUZqTzUxaTF5dkpJRi9CMDZaeVNhbXNM?=
 =?utf-8?B?V2xCUFlkT3JUdEdYNXduazNNeHM0RkFSdVFmRmJSYU9YNUE0Y00ya0R6QVEx?=
 =?utf-8?B?bHdJTmxTTmYySEx5UkJVVmxBVTFocGhtZHRnK2thUmJ4L0ptRmFVSisyYWlG?=
 =?utf-8?B?V1ZSYzBab1A1a2JTM3Rhb3Zzb0MrbXZwdWMyY0VqYVZyWDR2aDROUVZUL0ov?=
 =?utf-8?Q?1Sh3ZayrDEcj/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MGNXL1NVdENycm5uTTVkMmtvUVVrVjR4ZDlCVlBnNm9xRVpRbHk2TjdwSUVE?=
 =?utf-8?B?U2l6NkY4WHlRdjlkdXZMRUM0Ti9uQlJZTHJCVFMzVE1JRmk3THVwWTVsQSty?=
 =?utf-8?B?SDU2b1hrQ3lPSlFwVFJMbmFnUmZ5L1lscFFxUmlGY1p0ak1uNXUzUzkzNUpx?=
 =?utf-8?B?K3NER0R2VDRDL0VjQktrakxROWZJb3JqbWtNUWxzQXhNdExIbzI2WlpFTjRF?=
 =?utf-8?B?NjI5cXA4R1RxRGFjeGtBL00rT0VSNDdyaklRWDBDSTgrTWdkbk8xVUIwQ3Nu?=
 =?utf-8?B?WUFubUJCSmVHWlBWR3NuM2NCUFcyMlp3YTEwZ0lPcjh6WHFDZ01CdnNPU3Rw?=
 =?utf-8?B?UmFpKytUWjdYSGJ2aXA0WUl4U3Voa1FpeUZqbFY1cXV5Wk03MjRDY3h3a0Nr?=
 =?utf-8?B?SVVUOFZrcVRmem51a3pmYmwrVEt6MjVVSytyc0lKN2F6YTkwaFZrZHlLc3Rp?=
 =?utf-8?B?U1k1ZWJSQXNUbzRINU83NDJwaEVvUHhVYUVVWjVhWG10SkFMSG9ORmc2eExX?=
 =?utf-8?B?THN3NGtqV0c0TUEyOWRsYkxNTy9UUytRNG1KbEduak1jYUdCeWlweHJ2bXpx?=
 =?utf-8?B?emVyOEw5Y3VoVDhQUG9IdzNMY2orTnQ0UmlXWm0zaGJTYmtudHVqRkttbjVI?=
 =?utf-8?B?N2tTcG1sZTg5ekJlNFRLNmVrY1gwcFpMRldnRFh1YVN5Ky9ET0hzYkdUcTJj?=
 =?utf-8?B?cE1FYlNvTGNEemo4L1dDWktLTFUrRVZaWU5rUE1TK3kzODVUb0J2R3BXbU1N?=
 =?utf-8?B?eCtFL0ZaaEpZUU1GL2E1NXlIV1A4MS9iRXJrdU9jTldCQ3BiOE1qWHRhdWtX?=
 =?utf-8?B?a1dBbjZkN3cwMFZPMHpIK0ZxdkgwVzA5azRBd0VjTmdxL1c0Nk5scEtBbWht?=
 =?utf-8?B?LzNPOVVhTGtobTNlcnlOUGJ5Rk52QzhneGg4cnBFSlFTSkd4eFBQaFZNd2pI?=
 =?utf-8?B?R2VKdXV5aFFkZ2s4ZE0zNjQxOThXbGZxallWaGdFU3BiL3pQM1h0T1ZLeUdL?=
 =?utf-8?B?RjJ5emE4Y3hub3FZWHIxN0JvN3FZWFpTUmtweFFuMk9JaEovbSttM0tIL3Fj?=
 =?utf-8?B?R1hrV29HbmladFQ0N3p3cm1ocnZWTzB0dFpEUlRBNkdOSm1GZ25aelprdG83?=
 =?utf-8?B?TEluUFlkbk9ubjlVeCt5TUQ4TDk5SUd4WSttVzJYVXYrZ3dXaVk5U3l5YXpx?=
 =?utf-8?B?dFZyaTVpQWpiSDNHazNoUFNKVUEwOTVxRXB6ODJyTUkwWEEyak5yVEFnWGtF?=
 =?utf-8?B?RjAvcEhQQS9YeTFWeTR5MnlyTm1NR0VQdk5wNTRQOFFuWjZ1UERkYzYrSm5Y?=
 =?utf-8?B?NExob3VOMW5xekplalVDK3BlMHJpUmh5UVJSVlN4dlFDUFl1bHgvVks1Q0RO?=
 =?utf-8?B?QVFtVHR1bERJUnVKa3J3RDhBakpBT1drRnlKYldSQ3RvTHFOM3l2MWEwRmw2?=
 =?utf-8?B?cUNqbUk3T214elVrdUl0bnJhYk5zYWExV0Qya1dWeUlPR204N1pXRFZhVW9H?=
 =?utf-8?B?WHN0MlpwSmhvWGRXQ243TFlyUCtrMWNUbDhNSllOdlpuSHF0VzNXamxsZDFl?=
 =?utf-8?B?WnVHeG5ndG9lSzkyRUhCSUxGcDc3YVJhMG9HZnYvN213RkdnUHJ0ZWF1ZzV3?=
 =?utf-8?B?My9PZCtLZ1RFbVNQTjRRMk0wV2pJRGZrNmg2TnFpSnhLTG9qSHVmdzdGdUVM?=
 =?utf-8?B?VmQ2RDNxVzg4S0NpRzJ2RTgzc1VWRGdERnZqb2NoeWdlTFY2ZkF4SUFBZDRk?=
 =?utf-8?B?TmxKajJXMk1GYU9jUFdhSnROdXJ1UU9lQXpaTi9FRC9Xa1dIQmQ0eVREYTV1?=
 =?utf-8?B?VyswWGlZanRyRWdScDU0aDE3UlFScTVVZ29VendxQ0c1N0JERzljOHVJRVhI?=
 =?utf-8?B?TjBlV1Z6VVFxTzVQYUFVOXZhcDkwaXU5clloM0RjbVRTb3FpUFFNalhiSllo?=
 =?utf-8?B?V3JnNC9vN1FlNms4SjlFY2hRZHBVN1MvcG5ZNWUwODV0VkF2Um5vOVV3MlJC?=
 =?utf-8?B?cmFxVVRTWkErQUlzTnROcFJ6TytXMXIwNW5xV0VyV0pyTlVacjNuMTVsTWNy?=
 =?utf-8?B?QTJrSTZzMnpFdjVxRG8wYUtZM2phTDg4R3c2b252Sm1nSUkxUzI5clc2TGpq?=
 =?utf-8?Q?x3bcxSmY+CLkTexEvSSeYMhck?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb15ec40-6b1b-4a3e-0abd-08dcf837e224
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 16:36:48.4812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0P9zYhWTBqg6Q40WMSn1INCRir4vsL0SDDBCUqp7rYGlB1/Yd+GlNRL7qHhIERbAiYtCtbe09wT/O4RzLJ0Eug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8431

== RC side:

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

Current dwc implimemnt, pci_fixup_addr() call back is needed when bus
fabric convert cpu address before send to PCIe controller.

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

Device tree already can descript all address translate. Some hardware
driver implement fixup function by mask some bits of cpu address. Last
pci-imx6.c are little bit better by fetch memory resource's offset to do
fixup.

static u64 imx_pcie_cpu_addr_fixup(struct dw_pcie *pcie, u64 cpu_addr)
{
	...
	entry = resource_list_first_type(&pp->bridge->windows, IORESOURCE_MEM);
	return cpu_addr - entry->offset;
}

But it is not good by using IORESOURCE_MEM to fix up io/cfg address map
although address translate is the same as IORESOURCE_MEM.

This patches to fetch untranslate range information for PCIe controller
(pcie@5f010000: ranges). So current config ATU without cpu_fixup_addr().

== EP side:

                   Endpoint
  ┌───────────────────────────────────────────────┐
  │                             pcie-ep@5f010000  │
  │                             ┌────────────────┐│
  │                             │   Endpoint     ││
  │                             │   PCIe         ││
  │                             │   Controller   ││
  │           bus@5f000000      │                ││
  │           ┌──────────┐      │                ││
  │           │          │ Outbound Transfer     ││
  │┌─────┐    │  Bus     ┼─────►│ ATU  ──────────┬┬─────►
  ││     │    │  Fabric  │Bus   │                ││PCI Addr
  ││ CPU ├───►│          │Addr  │                ││0xA000_0000
  ││     │CPU │          │0x8000_0000            ││
  │└─────┘Addr└──────────┘      │                ││
  │       0x7000_0000           └────────────────┘│
  └───────────────────────────────────────────────┘

bus@5f000000 {
        compatible = "simple-bus";
        ranges = <0x80000000 0x0 0x70000000 0x10000000>;

        pcie-ep@5f010000 {
                reg = <0x5f010000 0x00010000>,
                      <0x80000000 0x10000000>;
                reg-names = "dbi", "addr_space";
                ...                ^^^^
        };
        ...
};

Add `bus_addr_base` to configure the outbound window address for CPU write.
The BUS fabric generally passes the same address to the PCIe EP controller,
but some BUS fabrics convert the address before sending it to the PCIe EP
controller.

Above diagram, CPU write data to outbound windows address 0x7000_0000,
Bus fabric convert it to 0x8000_0000. ATU should use BUS address
0x8000_0000 as input address and convert to PCI address 0xA000_0000.

Previously, `cpu_addr_fixup()` was used to handle address conversion. Now,
the device tree provides this information.

The both pave the road to eliminate ugle cpu_fixup_addr() callback function.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v7:
- fix
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410291546.kvgEWJv7-lkp@intel.com/
- Link to v6: https://lore.kernel.org/r/20241028-pci_fixup_addr-v6-0-ebebcd8fd4ff@nxp.com

Changes in v6:
- merge RC and EP to one thread!
- Link to v5: https://lore.kernel.org/r/20241015-pci_fixup_addr-v5-0-ced556c85270@nxp.com

Changes in v5:
- update address order in diagram patches.
- remove confused 0x5f00_0000 range
- update patch1's commit message.
- Link to v4: https://lore.kernel.org/r/20241008-pci_fixup_addr-v4-0-25e5200657bc@nxp.com

Changes in v4:
- Improve commit message by add driver source code path.
- Link to v3: https://lore.kernel.org/r/20240930-pci_fixup_addr-v3-0-80ee70352fc7@nxp.com

Changes in v3:
- see each patch
- Link to v2: https://lore.kernel.org/r/20240926-pci_fixup_addr-v2-0-e4524541edf4@nxp.com

Changes in v2:
- see each patch
- Link to v1: https://lore.kernel.org/r/20240924-pci_fixup_addr-v1-0-57d14a91ec4f@nxp.com

---
Frank Li (7):
      of: address: Add parent_bus_addr to struct of_pci_range
      PCI: dwc: Using parent_bus_addr in of_range to eliminate cpu_addr_fixup()
      PCI: dwc: ep: Add bus_addr_base for outbound window
      PCI: imx6: Remove cpu_addr_fixup()
      dt-bindings: PCI: fsl,imx6q-pcie-ep: Add compatible string fsl,imx8q-pcie-ep
      PCI: imx6: Pass correct sub mode when calling phy_set_mode_ext()
      PCI: imx6: Add i.MX8Q PCIe Endpoint (EP) support

 .../devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml | 38 ++++++++++++++-
 drivers/of/address.c                               |  2 +
 drivers/pci/controller/dwc/pci-imx6.c              | 46 +++++++++---------
 drivers/pci/controller/dwc/pcie-designware-ep.c    | 21 ++++++++-
 drivers/pci/controller/dwc/pcie-designware-host.c  | 55 +++++++++++++++++++++-
 drivers/pci/controller/dwc/pcie-designware.h       |  9 ++++
 include/linux/of_address.h                         |  1 +
 7 files changed, 148 insertions(+), 24 deletions(-)
---
base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
change-id: 20240924-pci_fixup_addr-a8568f9bbb34

Best regards,
---
Frank Li <Frank.Li@nxp.com>


