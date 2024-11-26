Return-Path: <linux-pci+bounces-17365-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 244829D9BF5
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 17:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B2C5B23618
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 16:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99DA1D9320;
	Tue, 26 Nov 2024 16:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QSIoGy0C"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2085.outbound.protection.outlook.com [40.107.21.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7F313C80E;
	Tue, 26 Nov 2024 16:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732640129; cv=fail; b=kK9+DqeRoaEPAmfsq8GzQO1C3LetUjy688NAlgNVudBOAzJS2cZaiAgQe93ACWHP+e6HEJFHCLyd0StkK8UE8n10OPrK+vkpPVnobencfiEkrQ3RvuKbWReuiBQ5blKPx+pJXU2kIuxWpvMjLfqyLEUBSTghUFhFcoufQ/OOjI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732640129; c=relaxed/simple;
	bh=qUDsV6Kx/Vo/KL5sSIzzTjsf1ESj/dc8HF5q0K8magQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TnsWCyzT6PN/Kmf7o36g8JcYILyH6B3oLPNDXpeskMK4BS/f4i/I3c2QgqjEYOysdwlOG+e2SgT+jg3Iku4Kosn3cuj2qQ777d+Qr/TSHTAawE6Of/EUDjAaHVjJpAFbHG5rGe4C4nTrVRjH7UYltrBu4qBgn78vdVGo6b0Aglc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QSIoGy0C; arc=fail smtp.client-ip=40.107.21.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bakdkzvkkkyBkBXW4fLXPbnRSMOGX7khcM0uoNSCpOBrCRF4IKJ8Lf86Ml8iGmCKc4d44s1StPSXJ/zYdtl15aBoq7KdjsY6sEteAMpCGg/Y5nRzBT2QvbcBui0kx7O4JpqSq9uxZKM7RTj0EU8GEvKzoEN1jpg9UNXDJc+PMiQtCdsT0gGkaYdkEA2bDgMONU2a/q83GOYmgm7Zls93jfT26fMk4jdhLJhDk93oRlSESy+N6eZftx9DQAVTZUbUOAuKI5h/OoJGbknTCYNd2OcWqSuo6jvwa9tFlcN3pDZ/Fy2pJ8VbMeWKWy+Ve5JqyHLcrSUt0iSGc2Lhm9bHRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vJx9ZqAGO8TCa10CQ0OQiKkNL7lJ1rxmUToK1ddk3Ck=;
 b=JRTdtjtfD7rjwboSNwJ5wPimqV30MYhvII/FEMG/mWHRcjMhMDVZ9N6Sq+2Hns6yEI9Q6iOtADp+inxJshHeBOufaAhhGcfA6J4jz7DmlGC0bU4vGu+1xzEkw8w4xqEnTNc4HKpeVPDUIP5JZP7CwVzEYAHRcIj+s8xvHD47bpxJyNB7HNpg9wWNWM1s4ugS60SFY/lFL2IU/MczK+1Ulgo8CJ3Wmk47Dbz508ZBOh1OD5/14cKNr4lrTL1a91CpP0yMsfvJjpJkxlOJtN1hJVvWVuP7bmFjenqQpYh66lIgFoHjQQTRC73SlZQGnKUjlMTbphUBYFF0wt9C/tIF5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vJx9ZqAGO8TCa10CQ0OQiKkNL7lJ1rxmUToK1ddk3Ck=;
 b=QSIoGy0CrZ4uddVH3AmoWfP/KXKZw+FiOcGlPu+Klho3uwVPbnCaqn3q1AdofzvllKMn+kzqCXx7zoSx2A4998MwQf7HOgkeHUlUi0b47fl0zIA/UfYZak4iS2i4sOPL5FOsoZTFH3vPef1+2g2sO5cfZhORhAFghwKRCQdptnAqCNXj8ZbUf6FFdhHAMNu2m4YIn+XEmDnF0wPmPq9x940W0CoE8ieIbqBwwCV/p8NgPUhuYA23NIf6ISqonG5ZnbdFrYhmAoHDv//lvhtVwsb7MAL01GaJryEFILkeoqHf5k30rGnBEeHXQ0dMSHZkrTNpau3cJ0BX4BeZsD/qlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBAPR04MB7271.eurprd04.prod.outlook.com (2603:10a6:10:1a6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Tue, 26 Nov
 2024 16:55:22 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8182.019; Tue, 26 Nov 2024
 16:55:22 +0000
Date: Tue, 26 Nov 2024 11:55:13 -0500
From: Frank Li <Frank.li@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Niklas Cassel <cassel@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	imx@lists.linux.dev, dlemoal@kernel.org, maz@kernel.org,
	tglx@linutronix.de, jdmason@kudzu.us
Subject: Re: [PATCH v8 4/6] PCI: endpoint: pci-epf-test: Add doorbell test
 support
Message-ID: <Z0X9ccbTO1I2zefm@lizhi-Precision-Tower-5810>
References: <20241116-ep-msi-v8-0-6f1f68ffd1bb@nxp.com>
 <20241116-ep-msi-v8-4-6f1f68ffd1bb@nxp.com>
 <20241124075645.szue5nzm4gcjspxf@thinkpad>
 <Z0TNMIX4ehaB+mSn@lizhi-Precision-Tower-5810>
 <20241126042523.6qlmhkjfl5kwouth@thinkpad>
 <Z0WcKeM2630u_xSK@ryzen>
 <20241126124112.5o4c3lzem72lkvdw@thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241126124112.5o4c3lzem72lkvdw@thinkpad>
X-ClientProxiedBy: SJ0PR03CA0361.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::6) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBAPR04MB7271:EE_
X-MS-Office365-Filtering-Correlation-Id: f8d795fc-aa1a-47b6-5674-08dd0e3b1db3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c3Y1U0FKem9pcUhHR1FWNlFlVkZaeE0wZUd4VVBKS1JKQlNEbjM2NS9CM3Y4?=
 =?utf-8?B?L1JnMlZjeGVVRE95elFpRmovYzlHNlRqTVZ2YzBwbnJIVmZCU0svTVlFVE1z?=
 =?utf-8?B?S3JOcmgrUGVQTWlMVDZLcFAwYmZnUzgzRDBrK1NHOVJaVXNmNGRwaEdyQmw0?=
 =?utf-8?B?RTJiSUFLVHZqZThPcnN4Y0kwYjNMV01yTnQwM1ROMW5HVXYzdTdqOCtiZmZ2?=
 =?utf-8?B?ZnQzRnA1OFRDRm44ZWVxNkUvL0tIUXZKbGlWTWVVb25jV2JEUmFSaGZsMXZ3?=
 =?utf-8?B?N3Rralp4dmJzWWhzSlhiME1ISWFYQ0pHcTEremJHdUxHZzFmYnk4d2NZK3dD?=
 =?utf-8?B?QzhPaVJKalRPaWlQWmd3ZitmL1NPVyszNWxrQzhURFVwM2kyRDFwUklnb2xr?=
 =?utf-8?B?L1ozZEVIM0djWnJsUlc5RTFxVzVGZVJJQksrZDFiN1VPL3k1SktFb0pBRDV2?=
 =?utf-8?B?LzROUklrNFZUY2xWd3Y5ZmNzb2F2TnJqM3BhNWFGN01NTGE1U3BmcDJFT0dZ?=
 =?utf-8?B?OWJJOTVZNWdncUdjWFZsY3p3ajdkb1dkNlhIdGU2aVcrZldoV3BqSmVvQ0tm?=
 =?utf-8?B?M0pIaklwelBMN3FIODRNWk15N1Z4aTlURGRFSG1Qb3p6WEJWUUxtbHYxbG5q?=
 =?utf-8?B?YnhybHlGQVUwWFQxTHdicUpub213aXFkTlgzRXZLanlTdWZCbDV1RTF5TFRT?=
 =?utf-8?B?Vkk2VTlBRWtRUkVKTnB5c08wSU5UUUpSTG1PM2VGK1FlUUxRajhvMFRoUDFr?=
 =?utf-8?B?V0hHdWtiWjFKUlhYakdVYXZSMkZ4WWxuVlVVZXh6QUNJbFZuVndBWXhSVWxj?=
 =?utf-8?B?azFONWRwSms3S05xU2NieXUxNFNET0szeGNaMzdzbWhBZjNFWGFWSEpRT21O?=
 =?utf-8?B?cHluN3A2SFBlZkw3WDNaV09TMVZlQlNTNEszcXdJNHE2TXVkUzZhR1pNQ25Z?=
 =?utf-8?B?ZW1YaTg0MkFmaEkrMjRyMWxHUkpsVGljd20vQjEzOC9iWDY2TURUeCt0MnZY?=
 =?utf-8?B?OVhIRWVKRE1LTVBnaU8rTFgxbFp5MmsxY0dZYUFodCtuOUR4eWs4MDhGd1Bx?=
 =?utf-8?B?bkFad1ZMNTZ6d2gxM1pFakQvU3g4Q3NxME92Zkc5N2ZUNE5KVkN5YjBrbG5k?=
 =?utf-8?B?eHZJQXpNMm0xWExJY1RoaGwyWVEyWTREVFVEWTdlakZoZFMrcEh2QUIreEFk?=
 =?utf-8?B?bUhiQXVIdktYVTRyQ3E5UDBNK2FlTjBCbit6TXRVU2kzeVRvMVZOTVNrZGQz?=
 =?utf-8?B?ZVFTRVZCWVhjc1hBMWNhNXZHSk0vdzdZZWEySXZURmMzMU1iOHdvZHVqRC91?=
 =?utf-8?B?MHBJcE5sd3MzcEwvNzlwK0g0RmUrejFrQlIyRjhwWS9jNGVSUzlERUNsTUxu?=
 =?utf-8?B?SENGM0Rrb2ZkN3BGVVVrYTRySk1LWmg4WHhuaWVMTjAyR1JLVUZ2cktPWDRT?=
 =?utf-8?B?bW9NWVpJaVhnMVd3YVpaUjJmcGh4VXNOYXg2WjA3NGNTcllYS3dFZEZRZG0z?=
 =?utf-8?B?Y3FXQXVrRzBuelRUd2pEdURPcy9idThTcXJlUVM1ZTYzalZRZm44YlREV3Ar?=
 =?utf-8?B?Rjh3N0hNZjNUdDRxWEJrT2tOaVM4dUdDbG14V0JUbFFESml5aXFTVkcxcys0?=
 =?utf-8?B?bnhlVldWQ1p4bWVSRUVjYzlKcmdwU1RxUlFCQjlKL2JITkNqQ1gvU0xLY0ln?=
 =?utf-8?B?QkQvM3pDS1E3T2YxYzJQZmVacURYczZpcVJQVE5haXVEcTc5eFpCdVpMaVVQ?=
 =?utf-8?B?T0IvaGhaSTBFWE1KUE5VZTlnTDM1dW9OM0VaQS9Ec3RvUEl5K1NJOHBZY1BY?=
 =?utf-8?B?akRQd09HQUZzZFJ4U2E0TGlUYmlaSkc3RmZEdHRCQzU4OFVUV01wemt6M3JQ?=
 =?utf-8?B?TDV4NVZ6N2kyUldPTVBQa0txcTUvaXEvT3RWcEduZ2taMFE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NTAwajZha3RISWNYREdpUjJJd0JNSjVNREh0ajIvanFJdi9ob0hUdFV0TjB4?=
 =?utf-8?B?cnhNRFZiRkkxbDZxNmthSXRuVzNFc3R4NWxIdzlGd09Bb21ySUJmVTBSdFI2?=
 =?utf-8?B?Zi9xeDFOUTFsb0FIVHhJQUkwRXViangyRElJY3gyWlE1NVhZTDd6djVCakZq?=
 =?utf-8?B?dmtBODBwandMcGNOTWVIVytVdkRZT3VsTVVlL2QyU2c3V0FQZkswNnE2MUIr?=
 =?utf-8?B?VW9zZDRjdGRTWlNydjZYeWFNNDR4MXhUcHdnWGtOODZlWnptNCtkNEgvVVJ0?=
 =?utf-8?B?Z2FpSFJoQkpQcmswMVp0RjFHb0JRNlVLWHYxeFVnb05mbmJKR0xSQVN3SVls?=
 =?utf-8?B?WXZuTjFlNVdZcUZGSHhoTC92bC9OWmlXdFBMd2JIclNXM3VmSVhZTUxOZy9R?=
 =?utf-8?B?dXF6SUxTaC94OEt2UGxlZlVKWXAyc0t3b2JHeWN3dVkxek1lRDlEOW92dDk2?=
 =?utf-8?B?Z0ZDVnhVZ213THhGNDF6TjBRTnZ4dWpTOWRkUCtNZWsyNkFtbXZSYUliVStn?=
 =?utf-8?B?QSt5OTgxdUsyWXlSQXhxY3hWbktUckxCSzJlckI3VWZBZTZDdWVGV2lLYkVC?=
 =?utf-8?B?Y1RqWmlSQno1UDlaYTByeVdFWnhVTS9pQ0pQS1VNQTBTMkg1a3IyeXY2dkph?=
 =?utf-8?B?eWJpN0N2bVFTWWg1MTBMcjFBSHBFbSszdWxyOVpZaUc0bjRCK0NDNFBVNGpN?=
 =?utf-8?B?VnBTVVAzS0FhZ3VzVnRjSXdueWpBN2pQb09rclM4cjNpRllGb3RKNW8vRUpG?=
 =?utf-8?B?SU1rY0xQY2VuckxXS2ZlMnRkYVVsODRUQ2NxbXBPOTYvZHBGUVJPcmtaNXIr?=
 =?utf-8?B?TUdHZ3dqdXRvd0VYazg2ZzFHUnlwSjBNMVBxMHdVSUJyWWF2cEc5Z3pMNVhR?=
 =?utf-8?B?TGVTbWNONDhmYnRPdGRnYXVJK2QyU3I4ejJRU0VQc25XNHFjSy95VDFtRkM1?=
 =?utf-8?B?Tjd0UjVhR1ZLOHNMa3BYcUgwMWUyMzBCOWh2dE42TGRQWGZod0I0M09ycTdP?=
 =?utf-8?B?WEw4RDRZQTdwVFYyQ0psdjNOZG4wWVdDZVdNcndZRUNKcXZYLzZNcHcyQ0s1?=
 =?utf-8?B?SnFvYXJ4VG1zS05YVFdBamJqRjdDWlRUdVMwU3FXZTliYUR6cy9HYkRNcEIx?=
 =?utf-8?B?NnozYVFxVUhPNGhCbStuMDV5OXJFYThOWWFnWmRMZmtuNHpJY2l2M2NINnJp?=
 =?utf-8?B?ZnZYcGdEejBtQmxMVWdxcVFINFVGU2tuTjFDaXJOMnp0a2pNZ1lPbm1NZHBG?=
 =?utf-8?B?U1BtWStLcG9BNEljOVdzUlNLRFVNbE1uamtibFI2Ti9EZXZ5RHJWMzFMcWdp?=
 =?utf-8?B?bC9rL2FlR3FaQWdrTDRPTDlKZlVRSTFub0puTUhvcEMvSnBLTjlkZzFLbEhi?=
 =?utf-8?B?VXJGN0NnSG0xa0NqTmNGRmRGdkVBZGFXZFIzSDlicWJzNDFxM0VWWkRxOUxt?=
 =?utf-8?B?QldiU0lwVld0alNrREFDM25xZmRJdFM2U0htcEgvS1VDRXo2NGhGNlozeWFX?=
 =?utf-8?B?Y2ZRclVHQXVrQzRVUDkvNmU3bCtCQk5GOHF0OHdPd3VlN0h2SVpQaGpZbFdD?=
 =?utf-8?B?bXJoZy9zMEpuN2xSTXFqUWZ3L3ZHYjFzazFIR25nWG9QWWhBQUFXWktsU2xa?=
 =?utf-8?B?bmtmT09iL3d2V1F3M3loc0hyQnVtMCtmaklORTdrRlFJQ1pXZ0ZSU1prZ3hK?=
 =?utf-8?B?NDBMNS9qNEJrdDhZRmhzKzdlVjhyMk5yVS8ycmRhTmU1TmJyMFp1REpCQzIx?=
 =?utf-8?B?a2tLNWo4T0gyNmpVRlRkYTRKN1lhMngzMlJMaDk3T21XN3BHUHI4eGtPOHgr?=
 =?utf-8?B?TzY0SnNCZHdhdEFLVG9XNkdXeW9oQTZnN2MxSzYrOGE5QnhhN2JkdHJlRGRC?=
 =?utf-8?B?UnE2cW9YcEIxMG4zS1RtZW83YUFzUXZUZEZhZ0p1Q3FwWW5BTXlsNmhEMldj?=
 =?utf-8?B?SklzOWU2ZS9lWEtEOHMzRFFYbHZsb0ZReVpySUdqbGdNbm03S0FQNFY3OUdi?=
 =?utf-8?B?M2xSMTZrcmp4RjQrVmFIVy9rY3dVVHhqZXFoSGRxUEVCQk4yVThPbFc0YjVi?=
 =?utf-8?B?MURDVlpvNHNPdC9IdG1Hc3BtL1dwK3N1U3VQaUdGWEo3UUZMQVRieWR2T2Uv?=
 =?utf-8?Q?01n0kGKYgGgBwr9hSmMAg8RvQ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8d795fc-aa1a-47b6-5674-08dd0e3b1db3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 16:55:22.5385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JwZQUlN2oy3m5g9spZka6WQlSouCg/T0pAEzaqDYGvZMEKuskk4hX1SRyZwF9RW+u+lqrvE0XPd9IPPy3IuPxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7271

On Tue, Nov 26, 2024 at 06:11:12PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Nov 26, 2024 at 11:00:09AM +0100, Niklas Cassel wrote:
> > On Tue, Nov 26, 2024 at 09:55:23AM +0530, Manivannan Sadhasivam wrote:
> > > On Mon, Nov 25, 2024 at 02:17:04PM -0500, Frank Li wrote:
> > > > On Sun, Nov 24, 2024 at 01:26:45PM +0530, Manivannan Sadhasivam wrote:
> > > > > On Sat, Nov 16, 2024 at 09:40:44AM -0500, Frank Li wrote:
> > > > > > Add three registers: doorbell_bar, doorbell_addr, and doorbell_data,
> > > > > > along with doorbell_done. Use pci_epf_alloc_doorbell() to allocate a
> > > > >
> > > > > I don't see 'doorbell_done' defined anywhere.
> > > > >
> > > > > > doorbell address space.
> > > > > >
> > > > > > Enable the Root Complex (RC) side driver to trigger pci-epc-test's doorbell
> > > > > > callback handler by writing doorbell_data to the mapped doorbell_bar's
> > > > > > address space.
> > > > > >
> > > > > > Set doorbell_done in the doorbell callback to indicate completion.
> > > > > >
> > > > >
> > > > > Same here.
> > > > >
> > > > > > To avoid broken compatibility, add new command COMMAND_ENABLE_DOORBELL
> > > > >
> > > > > 'avoid breaking compatibility between host and endpoint,...'
> > > > >
> > > > > > and COMMAND_DISABLE_DOORBELL. Host side need send COMMAND_ENABLE_DOORBELL
> > > > > > to map one bar's inbound address to MSI space. the command
> > > > > > COMMAND_DISABLE_DOORBELL to recovery original inbound address mapping.
> > > > > >
> > > > > > 	 	Host side new driver	Host side old driver
> > > > > >
> > > > > > EP: new driver      S				F
> > > > > > EP: old driver      F				F
> > > > >
> > > > > So the last case of old EP and host drivers will fail?
> > > >
> > > > doorbell test will fail if old EP.
> > > >
> > >
> > > How come there would be doorbell test if it is an old host driver?
> >
> > I also don't understand this.
> >
> > The new commands: DOORBELL_ENABLE / DOORBELL_DISABLE
> > can only be sent if there is a new host driver.
> >
> > Sending DOORBELL_ENABLE / DOORBELL_DISABLE will obviously
> > return "Invalid command" if the EP driver is old.
> >
> > If EP driver is new, DOORBELL_ENABLE will only return success if the SoC
> > has support for GIC ITS and has configured DTS with msi-parent
> > (i.e. if the pci_epf_alloc_doorbell() call was successful).
> >
> >
> > >
> > > > >
> > > > > >
> > > > > > S: If EP side support MSI, 'pcitest -B' return success.
> > > > > >    If EP side doesn't support MSI, the same to 'F'.
> > > > > >
> > > > > > F: 'pcitest -B' return failure, other case as usual.
> > > > > >
> > > > > > Tested-by: Niklas Cassel <cassel@kernel.org>
> > > > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > > > ---
> > > > > > Change from v7 to v8
> > > > > > - rename to pci_epf_align_inbound_addr_lo_hi()
> > > > > >
> > > > > > Change from v6 to v7
> > > > > > - use help function pci_epf_align_addr_lo_hi()
> > > > > >
> > > > > > Change from v5 to v6
> > > > > > - rename doorbell_addr to doorbell_offset
> > > > > >
> > > > > > Chagne from v4 to v5
> > > > > > - Add doorbell free at unbind function.
> > > > > > - Move msi irq handler to here to more complex user case, such as differece
> > > > > > doorbell can use difference handler function.
> > > > > > - Add Niklas's code to handle fixed bar's case. If need add your signed-off
> > > > > > tag or co-developer tag, please let me know.
> > > > > >
> > > > > > change from v3 to v4
> > > > > > - remove revid requirement
> > > > > > - Add command COMMAND_ENABLE_DOORBELL and COMMAND_DISABLE_DOORBELL.
> > > > > > - call pci_epc_set_bar() to map inbound address to MSI space only at
> > > > > > COMMAND_ENABLE_DOORBELL.
> > > > > > ---
> > > > > >  drivers/pci/endpoint/functions/pci-epf-test.c | 117 ++++++++++++++++++++++++++
> > > > > >  1 file changed, 117 insertions(+)
> > > > > >
> > > > > > diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> > > > > > index ef6677f34116e..410b2f4bb7ce7 100644
> > > > > > --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> > > > > > +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> > > > > > @@ -11,12 +11,14 @@
> > > > > >  #include <linux/dmaengine.h>
> > > > > >  #include <linux/io.h>
> > > > > >  #include <linux/module.h>
> > > > > > +#include <linux/msi.h>
> > > > > >  #include <linux/slab.h>
> > > > > >  #include <linux/pci_ids.h>
> > > > > >  #include <linux/random.h>
> > > > > >
> > > > > >  #include <linux/pci-epc.h>
> > > > > >  #include <linux/pci-epf.h>
> > > > > > +#include <linux/pci-ep-msi.h>
> > > > > >  #include <linux/pci_regs.h>
> > > > > >
> > > > > >  #define IRQ_TYPE_INTX			0
> > > > > > @@ -29,6 +31,8 @@
> > > > > >  #define COMMAND_READ			BIT(3)
> > > > > >  #define COMMAND_WRITE			BIT(4)
> > > > > >  #define COMMAND_COPY			BIT(5)
> > > > > > +#define COMMAND_ENABLE_DOORBELL		BIT(6)
> > > > > > +#define COMMAND_DISABLE_DOORBELL	BIT(7)
> > > > > >
> > > > > >  #define STATUS_READ_SUCCESS		BIT(0)
> > > > > >  #define STATUS_READ_FAIL		BIT(1)
> > > > > > @@ -39,6 +43,11 @@
> > > > > >  #define STATUS_IRQ_RAISED		BIT(6)
> > > > > >  #define STATUS_SRC_ADDR_INVALID		BIT(7)
> > > > > >  #define STATUS_DST_ADDR_INVALID		BIT(8)
> > > > > > +#define STATUS_DOORBELL_SUCCESS		BIT(9)
> > > > > > +#define STATUS_DOORBELL_ENABLE_SUCCESS	BIT(10)
> > > > > > +#define STATUS_DOORBELL_ENABLE_FAIL	BIT(11)
> > > > > > +#define STATUS_DOORBELL_DISABLE_SUCCESS BIT(12)
> > > > > > +#define STATUS_DOORBELL_DISABLE_FAIL	BIT(13)
> > > > > >
> > > > > >  #define FLAG_USE_DMA			BIT(0)
> > > > > >
> > > > > > @@ -74,6 +83,9 @@ struct pci_epf_test_reg {
> > > > > >  	u32	irq_type;
> > > > > >  	u32	irq_number;
> > > > > >  	u32	flags;
> > > > > > +	u32	doorbell_bar;
> > > > > > +	u32	doorbell_offset;
> > > > > > +	u32	doorbell_data;
> > > > > >  } __packed;
> > > > > >
> > > > > >  static struct pci_epf_header test_header = {
> > > > > > @@ -642,6 +654,63 @@ static void pci_epf_test_raise_irq(struct pci_epf_test *epf_test,
> > > > > >  	}
> > > > > >  }
> > > > > >
> > > > > > +static void pci_epf_enable_doorbell(struct pci_epf_test *epf_test, struct pci_epf_test_reg *reg)
> > > > > > +{
> > > > > > +	enum pci_barno bar = reg->doorbell_bar;
> > > > > > +	struct pci_epf *epf = epf_test->epf;
> > > > > > +	struct pci_epc *epc = epf->epc;
> > > > > > +	struct pci_epf_bar db_bar;
> > > > >
> > > > > db_bar = {};
> > > > >
> > > > > > +	struct msi_msg *msg;
> > > > > > +	size_t offset;
> > > > > > +	int ret;
> > > > > > +
> > > > > > +	if (bar < BAR_0 || bar == epf_test->test_reg_bar || !epf->db_msg) {
> > > > >
> > > > > What is the need of BAR check here and below? pci_epf_alloc_doorbell() should've
> > > > > allocated proper BAR already.
> > > >
> > > > Not check it at call pci_epf_alloc_doorbell() because it optional feature.
> > >
> > > What is 'optional feature' here? allocating doorbell?
> > >
> > > > It return failure when it actually use it.
> > > >
> > >
> > > So host can call pci_epf_enable_doorbell() without pci_epf_alloc_doorbell()?
> >
> > This patch calls pci_epf_alloc_doorbell() in pci_epf_test_bind(), so at
> > .bind() time.
> >
> > DOORBELL_ENABLE and DOORBELL_DISABLE are two new commands, so the host driver
> > could theoretically send these even if pci_epf_alloc_doorbell() failed.
> >
> >
> > pci_epf_test_cmd_handler() additions looks like this:
> >
> > +	case COMMAND_ENABLE_DOORBELL:
> > +		pci_epf_enable_doorbell(epf_test, reg);
> > +		pci_epf_test_raise_irq(epf_test, reg);
> > +		break;
> > +	case COMMAND_DISABLE_DOORBELL:
> > +		pci_epf_disable_doorbell(epf_test, reg);
> > +		pci_epf_test_raise_irq(epf_test, reg);
> > +		break;
> >
> > so they will call pci_epf_enable_doorbell()/pci_epf_disable_doorbell()
> > unconditionally, without any check to see if the doorbell was allocated.
> >
> > We could move the was doorbell allocated check (if (!epf->db_msg)) to
> > pci_epf_test_cmd_handler(), but that would make pci_epf_test_cmd_handler()
> > more messy, so personally I think it is fine to keep the doorbell allocated
> > check in pci_epf_enable_doorbell()/pci_epf_disable_doorbell().
> >
> >
> > I did earlier suggest to Frank to move the pci_epf_alloc_doorbell() call
> > to pci_epf_enable_doorbell():
> > https://lore.kernel.org/linux-pci/Zy02mPTvaPAFFxGi@ryzen/
> >
> > His reply is here::
> > https://lore.kernel.org/linux-pci/Zy1CxtKSgRuEPX5A@lizhi-Precision-Tower-5810/
> >
> > "it may be too frequent to allocate and free msi resources when call
> > pci_epf_enable_doorbell()/pci_epf_disable_doorbell()."
> >
> > I don't think that is a good argument, as presumably (in the normal case) an
> > EPF driver will enable doorbell in the beginning, and then keep it enabled.
> >
> > However, one point could be that pci-epf-test currently does all allocations
> > (the allocations for the backing memory) in .bind(), so in one way it makes
> > sense to also allocate the doorbell in .bind().
> >
> > To play devil's advocate, I guess you could argue that doorbell feature is
> > optional, while allocating backing memory for BARs is not, so it makes sense
> > that they are not allocated at the same time.
> >
>
> I like the idea of calling pci_epf_alloc_doorbell() in
> pci_epf_{enable/disable}_doorbell() APIs. And as you said, it doesn't make sense
> to call these APIs too frequently.

I not sure what's you means and direction for next version.

Ideally, host driver should use doorbell for every command because it will
avoid EP's side polling reg change.

It still is problem to waste a bar to do doorbell. Ideally, we can append
doorbell ITS register after test bar, which require map two segmemt memory
region to bar0.

This patch just go first step. If we can append to ITS to bar0 in future,
pci_epf_alloc_doorbell() will become more reasonable at bind() function.

Frank

>
> - Mani
>
> --
> மணிவண்ணன் சதாசிவம்

