Return-Path: <linux-pci+bounces-17285-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 266969D8BE0
	for <lists+linux-pci@lfdr.de>; Mon, 25 Nov 2024 19:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE0C51617EF
	for <lists+linux-pci@lfdr.de>; Mon, 25 Nov 2024 18:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E591B394E;
	Mon, 25 Nov 2024 18:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bl3yB5Eb"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2059.outbound.protection.outlook.com [40.107.20.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230C617548;
	Mon, 25 Nov 2024 18:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732557836; cv=fail; b=X9krF8NS72+qmykq1xgnu5rNw9oHczqKSX8gWgrJIyH8WQOhVbXEc81VSWe/MrzyIZM6ccocZCuILKDnxKFNccBgcPRFRWEVCa5iDNUxk/YlJ/NdbAD1wp9tuESdnmwRVOeSlGcZ4t2lPKiKRFrw26PaS0c0PqYbLJ5gGzuheCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732557836; c=relaxed/simple;
	bh=+wm4c3hV/SvH2TaFKeJguWajsQ74n6vtVr8JS0I/DbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gY46iziAQdP+M9+ptHMtfDajMB3+qqfgiejf8hHRblJh7cWXV3ZvVUOc/8CU7KeuTm4JZXhHNwF/JBQ5aytJZbu5wJrLxK3OcTrsduTTup5k5KxwdReozE+OeRFT68nN2X68N3PpMwYeBzcDcm6I1nhbiS1jamQdBL9690kBOLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bl3yB5Eb; arc=fail smtp.client-ip=40.107.20.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qiraVifA7fug/HUbLm71fugLYTWu3lSPMSlgQkZ2OalB54pxWLVmBIdQp8D00TZ1x9x0GvQkPQEyCVCjmoZVZwNrMkojUnu0QdEGN+HSWSKL0mWxbHP9WlnuDGow3xRYnEr0whWk+e1wA1et6mxuT2LQtMdvLCkICvsp12ugMc7PZgNWaI8fY30njOGFY8DTkkI1Gx4zP0T4Z+2sL/SHhyesTzLB+PM168vm5/K1N4O6pcCrhGa0hYzSSACa4GbDqfRjGFTljw7niOaslQNofe18672k6MqqjjOslVOlSC/nkhHY3nao4EJjttZ2xIuJCFwhPO3/bNYhNoaPTgZmvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y7fl9Uae1Z9Fg3YjdhqAdx6KjoKc+0zavZU0ar+jKIs=;
 b=osX85tQTh0l1LjENanxHVUBP7W7vgUPJggemUljV5RA7Sjm/ZYkYdXxjbjoyO3dNKG4KgZzhJXa48NTwt3Cm7UEwmFXAjs26MlnuoK7xILNNwXHIxNx7FcuKZ1RFzBMJvyO8GflP12M3VmmV+kz1+fZtmXsp1HPPX0+wYxWCi2KqnCen1p9CvylJNpS0hZaDWK1Akiaco7ZXXToQXQXso0PoVgYlx2d9f8xIi7W87gXDPOM2QVD6W1pmOV+/2IzHjCBEmiODY3LfPaGarrh9M5xyQRTUNjr0FNARAGtAiX1quW8ON5Hg9GcWPLi4TC8tz3D/NDdMJ4UX/Q48czdyTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y7fl9Uae1Z9Fg3YjdhqAdx6KjoKc+0zavZU0ar+jKIs=;
 b=bl3yB5EbD4rfWtNHUIGwsjUf/75aVBvRXPh56tVhT3AY5dWa5VLW7IFB0B8K00g60qH7hmQwEPuVQIhRzqLAkSWvdaTrLXMBk28UTRV/8d6afUKFV1yLUUt8CFl7ygVbokq1dGUKHUkyGmCdhEPg5qRP6Hxzex3GkNkOw9uuCS1mkdLZsGoLD8QL9zL9W14kDeE44hdxEqD4pTNVy94hlPDd/fCtyUjcltI3Tddunto5RpzgZ5BOwDbiMU8w+8/IoPYsNHpR/DMb11UFD58qpnPMvlSfZ05eGg3UGdXUdouTLVexnstuYaosahwkz8qpEc9fFZ4oz3KPmhvbLWZ+bQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB10154.eurprd04.prod.outlook.com (2603:10a6:150:1ac::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.19; Mon, 25 Nov
 2024 18:03:51 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8182.019; Mon, 25 Nov 2024
 18:03:50 +0000
Date: Mon, 25 Nov 2024 13:03:37 -0500
From: Frank Li <Frank.li@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	imx@lists.linux.dev, Niklas Cassel <cassel@kernel.org>,
	dlemoal@kernel.org, maz@kernel.org, tglx@linutronix.de,
	jdmason@kudzu.us
Subject: Re: [PATCH v8 2/6] PCI: endpoint: Add RC-to-EP doorbell support
 using platform MSI controller
Message-ID: <Z0S7+U5W2DOmzdJL@lizhi-Precision-Tower-5810>
References: <20241116-ep-msi-v8-0-6f1f68ffd1bb@nxp.com>
 <20241116-ep-msi-v8-2-6f1f68ffd1bb@nxp.com>
 <20241124071100.ts34jbnosiipnx2x@thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241124071100.ts34jbnosiipnx2x@thinkpad>
X-ClientProxiedBy: CY5PR13CA0029.namprd13.prod.outlook.com (2603:10b6:930::6)
 To AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB10154:EE_
X-MS-Office365-Filtering-Correlation-Id: 30ffa3ac-dccc-4512-4fb7-08dd0d7b8425
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eEUvM1dkR082Rk50YjNBNGpEKytqc3lrcFI5SFk5VEpiUW9DS2JUT2xLZUlX?=
 =?utf-8?B?bkExaDF3Ry9PNEZUNllNNHVnVGIrSm5JOUMrMHNYVEthRnVxalE1RDQwQWJy?=
 =?utf-8?B?TzZFQ0xJYzhvaDRpVWZmSGJ0ajJ5QUpHQjgzR1Z6cWxYMDJxTUxPdUVFaUVO?=
 =?utf-8?B?dGZxdlRBNmFJZTJ3NXFrM09oeTUwMEM5WmZub1NrTERCKzhTcFZvZEFJSkZW?=
 =?utf-8?B?QWk1SDR6ZytNMU5zN1NPN0xrV05UQ1J2b1JuUHZVOGdzOTFHd1BRMyt3V0Rr?=
 =?utf-8?B?dnlZNVZ4bjdKMjFrblUySjc1YVhWcnBLRDg2ckN5cjlqVXFlM0xOeG1jTnhY?=
 =?utf-8?B?L0hEN0dJMUJmTDZMR0MzM283K04xcHlFM1ZoRnVYS1hiZHRaS1M2MWZZVHVX?=
 =?utf-8?B?SjNJaSt4SmdOOUtadmNnd3hNK09EcE1mb3VvM2FFYTVlcFZyZWZJbkxrQ0px?=
 =?utf-8?B?UkhyYU4wTTEybWpGbGtXYllrcGtTQzMxVXNLSTlmWHFmU3dVVUxlQlBNNVh5?=
 =?utf-8?B?ZWZBODdaQjcrQmNCVVR5cnRnS0pad1lFV2hqYktKSmhFamkwVThycndBVWNZ?=
 =?utf-8?B?c2JGQ1haYUI3aHJmWGMySlBONnFmZG1RdnE0UFFOL1AveGVZdEwyTWNQeUdP?=
 =?utf-8?B?RG1GQ0M3NWlpR3pSUTBtZTE3YWdUKytaTnBsa3dKVUJYZDh1aWZHeDA4Wk1C?=
 =?utf-8?B?YzcrTjVmendKWjN1K1hUMTdPS0NOUmd5MTdVSjRrVmo4RVRHQi84dHI5ZWlD?=
 =?utf-8?B?TkFQRy9tMlpDTWxiVzdWTU9scmZyOEVSREtyVlVGejZGNVNKb0Q4cGNzYW83?=
 =?utf-8?B?RVFNYkhIVjJodWl6VnVMcFc3VStTcWJDTmdtVEpiRXEyNE91NklJZnV6M0Vh?=
 =?utf-8?B?emMwekRMOWVQRm1PTnpBaWowYWlsN04ybUZLcWkyQVdYV1JWbEZBZUZNUmJh?=
 =?utf-8?B?V2k3aEpMeXpUNFNmbUh1NFIzNEhHSXM2bUcvYk1DdlQ1ZEw0eUJnaXBXSml6?=
 =?utf-8?B?Q0NXdk9SS1hrdGlwaGhLazZUdzZQYlEwY0wzYU9IbjFaTHFZSjM3NW5IMWlV?=
 =?utf-8?B?Ykc4SEgrZGJOdk1lU0V2Qktzak02NmZyTmdzLy9xbkNneUVVVmlLRldLcytU?=
 =?utf-8?B?cXl3WWFUVFJOK3VwVHQ0ODBQMTZDSy84UDNkNXMxWUNzb1ljU05wVEFBeXB3?=
 =?utf-8?B?dlh1eFVRQk5LdG11WnN5NzRYZzhFOFBXc3dGWUhWTUNDLzg4Uno4bmszTDNl?=
 =?utf-8?B?QnlrUkRmRUZOVENMR2RsK2dJNGV0SVI1eUVFR2pkczNtK3dpS0J1Vk9UYmhK?=
 =?utf-8?B?Si9TZkFEdCtnZzFzNHVnZFVTM2t1Rkx2dVdYRnNRSkozaTZ0ZHJDZTlVRE0r?=
 =?utf-8?B?cmhGaTVpRk5EVTBhZGliNS81NjFzbDQxMWlMdHh4WktaT0VqS3JyODlTV3JR?=
 =?utf-8?B?WHBCZjd5YUx3aTBQVi9pa1VYSEN4Z3BMaWhXWWRScUNGSC9CRzlLalZMbjk3?=
 =?utf-8?B?L3VsY244b0VYdlVGU0ozSGE5b1o3UGNYckJzbGdXVnZ3YkFFK3hObjdNczNo?=
 =?utf-8?B?ZHo0eG9ReWZkcmJ5RVRkRGFxQVJGdnQ0TmpRVW1TcGM3K0phbTZLWm9BbC9F?=
 =?utf-8?B?Vmh6VWpPRS9HUFVGVlJmVWZkVklpQVBjT25kaXE1QVV0S3hzZDJ4M0l5cmh6?=
 =?utf-8?B?aVE2dXNtWWdCcDBSdU1XM0crRjBhYVhITi8rSCtqdG1YT0pPeWZlaUw4WUFp?=
 =?utf-8?B?b3BpY0ltVmZ6SzZidjk0R2ZQWVFsY1R4VGpzWDlidXh2Nm43SXlaN2tUZXY3?=
 =?utf-8?B?VlU4UVZrK2lqZmtzZ3ZmRms2SHdxTEhIc1FaYkIzMnNiUi9WRk45WFpvN2Zr?=
 =?utf-8?B?OFpITmZCdS84RlB1M2FidGRVbG9SSWJaTHRpcFIxUS9ZK3c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZCttL1BPT1hpdHVyNi9PcUtRZXN0K01sZGExS3FTSExERG5UNithOVIxeFhH?=
 =?utf-8?B?Z05zS2gwL3MraXNTa1oxWDhOa1A1cUFNMUZBMXhaMm4yVDBWbEpEOENZK3FV?=
 =?utf-8?B?Tnd6N3F2dmtIVFF4QWhXNWNXRU9GOHNBdk01emoyWTRneVRTaFd1ZHAwclZ2?=
 =?utf-8?B?Q0xNOGJOWW44M1JwVmIwdU1OMWY4ZG9vRTZmbElDUnorZFlOMjF2RUJPWnBS?=
 =?utf-8?B?OUlkcXltRUtLSXlrZXJEaWljcXJZTmdLMnNyTlV0QVJFdjBVQ3RUandSajBU?=
 =?utf-8?B?OEk0NDEyOG1IU044U0RLdmx2WkR6SnVSQ2swWXFjMVByUVNWL0ZqemxMeDZ5?=
 =?utf-8?B?THBXeDgyNVZqLzVVWUlTZkRVNkx6Nk9YNkxzWmlENEpkMjNUWnFzNElINzFX?=
 =?utf-8?B?UFNBUzZRMC9PMi9zRUFWcUJVUUhFbEFNNmdzb1RXMEhZQ2F4YVUzSDhVNzFF?=
 =?utf-8?B?TFdoeG1mbzY4cEY3ZHlySmVnMG44NmVENWtaZDVyYmpCdTVDVnM5NE1BbWF5?=
 =?utf-8?B?Rmp0aDlQTlppQXdBVjBCVm1jbjM4V1o1eU5rMXNkVmpGaVJOTEh5SWJmbGtU?=
 =?utf-8?B?b0RFQ01pLzdaQjVXQ3NGQ1dXYVJIVGEwWUQ4ZVhkeHNWdXpacUN2SmtyT3h1?=
 =?utf-8?B?Qm4zT2JvM1RTVk85NjFHajM2UGs2VkQxZnVzc3ZVcURSRnVPME12b0d3Vkht?=
 =?utf-8?B?dEFwTmR2dVY3RnZFdHFTMzdhemh2R0I2RXpBVFpJbThJSWZ4ZG4zUnZITStq?=
 =?utf-8?B?MjFNajI4ZUdSbnBtR25Ya1oyUk5SOXppYTMrOWtkeXo4akFIR2hEY0Jab09O?=
 =?utf-8?B?SkpRc0Y2aHRmS2Z4NFM0TGdjZlMwUGladzhteDdhQUJLbW43SllBWWRBaXpJ?=
 =?utf-8?B?cnREMkV2T0s4eWxZM2grMFJlbDZjeFdIcko3R01rS0lvSXBRdEZZYjNGS3Q0?=
 =?utf-8?B?MTlpT2lDNk9ZSWFmcGRPbXJYOXgxL0tCVjN3UWo5cFdyQjVua1BYMXloTVZO?=
 =?utf-8?B?UjZncUZWOVRCUWEvcW9mS2dXUmV3cVZPMHNOWGQveityeThlNDdtVzJvYjdU?=
 =?utf-8?B?d3FYS2w1WmIvcVM3UVBSK01tZUhSakNtQkN5LzR3aHJnL1NQaEJQa2JPK2s5?=
 =?utf-8?B?VmNsamVqNndXaUpDM0tBU0NrNld5S2NiYnBuWmNhYjczQWdhWjhQTVltcUJH?=
 =?utf-8?B?dVZzTnFIdDRIdG9FdlFKVXRNV29QaGh4TnhwcHA2WE9sdS9iNlYySXo0R05T?=
 =?utf-8?B?dFc1aERSemZ5bTNrSVFZNGQxR244bFgxOTZJNnJPWWFmdnZiTHlZam1ncEk4?=
 =?utf-8?B?SkFRUFc0dGNwME9wUGQwbU9WbElsbzFtNmhzak51S1h6QmZoRW5LODM1cUlx?=
 =?utf-8?B?c1B0ekwwdWN5dUUwZjZBMm45cXN1QU1KYTZKc3Npd01CTVlvSURodWtqa0hK?=
 =?utf-8?B?NnAyb2d0OHlHMGpYMTZIMit1Z0ZxY1JSUUhFYmRNcHNlZ1VTM1ZFeFBIYnd3?=
 =?utf-8?B?NEozaVRSbkJKQ3gyMVpxa0RjN3IrOWl1eEpVbGlBQlhzK1d2Y0ZxcHBHZ3A3?=
 =?utf-8?B?NWVuV3k0WFJNSzQya2lPNDA4YWd1bjFpRFdTYzYrU3ZrelBWaTIyQlg0OTVu?=
 =?utf-8?B?NTAwM2tVNzhWUGxlRkRSL1dBSFc1NUdmQjMwa0t2QlBLZktDRXROV0ovSGlT?=
 =?utf-8?B?L056MjR0Z1JqeUFqYTVoQzlqZjhYODNBSzhoeEVKQU1RMmFvekRwVHJLZ3o5?=
 =?utf-8?B?OWRhOXlsS2FxUHJKeDNVZzZjSjB3YkpYQU5XaXB4ZkNQaVBGa2cxYmh1dGMr?=
 =?utf-8?B?Q2NIbnZKRm9vZk1MOGp2ZTdRTmVCMmFRMi9DUmJwZGE0WmhhaWt6ZGlwYVVV?=
 =?utf-8?B?WW54ZnEwcHdWOWRUdXBkdllBSmtQbG05Qitmb0hDUElDMVRaTjhqVUkzWVVP?=
 =?utf-8?B?K2Zac0ZYaGR1bE9mV2pOMTAwbWIxUC8vM2FvTUZVek85UWxUc1Nrc09KWFVt?=
 =?utf-8?B?QVpxdW94NmlZYXBZMjhpVzZ0YiszcFFTVHFjZlMxNTFadkhZT1ZjVTJzNWhJ?=
 =?utf-8?B?dEdPUUprRU5wWFlDVVNyMkxCNHJydDg4TjZYV2g1eUZUQVFMWGJHUmFtNUNw?=
 =?utf-8?Q?o1HTORhZXdbvq0jna64zNmHDc?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30ffa3ac-dccc-4512-4fb7-08dd0d7b8425
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 18:03:50.8907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VtgbCjvGEodO5tboe69+4XnZZ8vePoXrqzAL5i1yITrbdemJBhfji9jD/8XsfiYOt/rTdP00h8hwQRzpr9TS4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10154

On Sun, Nov 24, 2024 at 12:41:00PM +0530, Manivannan Sadhasivam wrote:
> On Sat, Nov 16, 2024 at 09:40:42AM -0500, Frank Li wrote:
> > Doorbell feature is implemented by mapping the EP's MSI interrupt
> > controller message address to a dedicated BAR in the EPC core. It is the
> > responsibility of the EPF driver to pass the actual message data to be
> > written by the host to the doorbell BAR region through its own logic.
> >
> > Tested-by: Niklas Cassel <cassel@kernel.org>
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > change from v5 to v8
> > -none
> >
> > Change from v4 to v5
> > - Remove request_irq() in pci_epc_alloc_doorbell() and leave to EP function
> > driver, so ep function driver can register differece call back function for
> > difference doorbell events and set irq affinity to differece CPU core.
> > - Improve error message when MSI allocate failure.
> >
> > Change from v3 to v4
> > - msi change to use msi_get_virq() avoid use msi_for_each_desc().
> > - add new struct for pci_epf_doorbell_msg to msi msg,virq and irq name.
> > - move mutex lock to epc function
> > - initialize variable at declear place.
> > - passdown epf to epc*() function to simplify code.
> > ---
> >  drivers/pci/endpoint/Makefile     |  2 +-
> >  drivers/pci/endpoint/pci-ep-msi.c | 99 +++++++++++++++++++++++++++++++++++++++
> >  include/linux/pci-ep-msi.h        | 15 ++++++
> >  include/linux/pci-epf.h           | 16 +++++++
> >  4 files changed, 131 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/endpoint/Makefile b/drivers/pci/endpoint/Makefile
> > index 95b2fe47e3b06..a1ccce440c2c5 100644
> > --- a/drivers/pci/endpoint/Makefile
> > +++ b/drivers/pci/endpoint/Makefile
> > @@ -5,4 +5,4 @@
> >
> >  obj-$(CONFIG_PCI_ENDPOINT_CONFIGFS)	+= pci-ep-cfs.o
> >  obj-$(CONFIG_PCI_ENDPOINT)		+= pci-epc-core.o pci-epf-core.o\
> > -					   pci-epc-mem.o functions/
> > +					   pci-epc-mem.o pci-ep-msi.o functions/
> > diff --git a/drivers/pci/endpoint/pci-ep-msi.c b/drivers/pci/endpoint/pci-ep-msi.c
> > new file mode 100644
> > index 0000000000000..7868a529dce37
> > --- /dev/null
> > +++ b/drivers/pci/endpoint/pci-ep-msi.c
> > @@ -0,0 +1,99 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * PCI Endpoint *Controller* (EPC) MSI library
> > + *
> > + * Copyright (C) 2024 NXP
> > + * Author: Frank Li <Frank.Li@nxp.com>
> > + */
> > +
> > +#include <linux/cleanup.h>
> > +#include <linux/device.h>
> > +#include <linux/slab.h>
>
> Please sort alphabetically.
>
> > +#include <linux/module.h>
> > +#include <linux/msi.h>
> > +#include <linux/pci-epc.h>
> > +#include <linux/pci-epf.h>
> > +#include <linux/pci-ep-cfs.h>
> > +#include <linux/pci-ep-msi.h>
> > +
> > +static bool pci_epc_match_parent(struct device *dev, void *param)
> > +{
> > +	return dev->parent == param;
> > +}
> > +
> > +static void pci_epc_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
> > +{
> > +	struct pci_epc *epc __free(pci_epc_put) = NULL;
> > +	struct pci_epf *epf;
> > +
> > +	epc = pci_epc_get_fn(pci_epc_match_parent, desc->dev);
>
> You were passing 'epc->dev.parent' to platform_device_msi_init_and_alloc_irqs().
> So 'desc->dev' should be the EPC parent, right? If so, you can do:
>
> 	epc = pci_epc_get(dev_name(msi_desc_to_dev(desc)));
>
> since we are reusing the parent dev name for EPC.

I think it is not good to depend on hidden situation, "name is the same."
May it change in future because no one will realize here depend on the same
name and just think it is trivial update for device name.

>
> > +	if (!epc)
> > +		return;
> > +
> > +	/* Only support one EPF for doorbell */
> > +	epf = list_first_entry_or_null(&epc->pci_epf, struct pci_epf, list);
>
> Why don't you impose this restriction in pci_epf_alloc_doorbell() itself?

This is callback from platform_device_msi_init_and_alloc_irqs(). So it is
actually restriction at pci_epf_alloc_doorbell().

>
> > +
> > +	if (epf && epf->db_msg && desc->msi_index < epf->num_db)
> > +		memcpy(&epf->db_msg[desc->msi_index].msg, msg, sizeof(*msg));
> > +}
> > +
> > +static void pci_epc_free_doorbell(struct pci_epc *epc, struct pci_epf *epf)
> > +{
> > +	guard(mutex)(&epc->lock);
> > +
> > +	platform_device_msi_free_irqs_all(epc->dev.parent);
> > +}
> > +
> > +static int pci_epc_alloc_doorbell(struct pci_epc *epc, struct pci_epf *epf)
> > +{
> > +	struct device *dev = epc->dev.parent;
> > +	u16 num_db = epf->num_db;
> > +	int i = 0;
> > +	int ret;
> > +
> > +	guard(mutex)(&epc->lock);
> > +
> > +	ret = platform_device_msi_init_and_alloc_irqs(dev, num_db, pci_epc_write_msi_msg);
> > +	if (ret) {
> > +		dev_err(dev, "Failed to allocate MSI, may miss 'msi-parent' at your DTS\n");
>
> No need to mention 'msi-parent'. Just 'Failed to allocate MSI' is enough.
>
> > +		return -ENOMEM;
>
> -ENODEV?
>
> - Mani
>
> --
> மணிவண்ணன் சதாசிவம்

