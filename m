Return-Path: <linux-pci+bounces-37775-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56AF7BCAD77
	for <lists+linux-pci@lfdr.de>; Thu, 09 Oct 2025 22:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46A271A6368E
	for <lists+linux-pci@lfdr.de>; Thu,  9 Oct 2025 20:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E57F274FEB;
	Thu,  9 Oct 2025 20:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mOTekuW7"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010058.outbound.protection.outlook.com [52.101.69.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4532741CB;
	Thu,  9 Oct 2025 20:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760043302; cv=fail; b=c04oPsGHTdUxZFhtCb2Azx6BlO5Uu6udWhgL3P49WEqlV9ooZSVtFiHwbTD0C9irLZowVPgUwL3/8vViON5bJQXiVodXdRqQBHJAzjmGliHLpdrT6Ha3ApRcbrlD93vMFdCEf25q9EFH0aqYPlBIC7O7BQIsUBi2IgAHwKy9EWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760043302; c=relaxed/simple;
	bh=LOMfi+sIP0ExKFoZ+4SuzecTW90e8Olxw78NTpYmXeE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Vfo+f5uTkCVCEQkHdkWuGfDaXgmKHu0683X7PFXkCtY/59AUMpIwfNS+SMe5oXjA6DFQKJPYnqgG5EjEGnVhC8aA88UFSZku3M0291zOWfb4GpnaMzdO5QC4Q/0Y17L+PiWtb+I/NWtLidjEH7rb4/19ZovU+RT/xMgD4m2oWtg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mOTekuW7; arc=fail smtp.client-ip=52.101.69.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CTdkm1o6wuPum4BPTG9om7S+3PvctEgGLIzoplUmxrgwcWUOHRM/r/2+V5xIw80gCnzNb6aqYiys/ZHGhTywiwkjct1HEwLcsMzb8QmtqIyOOI4ERBk9emoOiwnDBfGGG5cpBGHCkGiWgXf3gRlqnvDemLiTIsPQ948ehO86DNWBE5O7zP1tovZl7oQVDwcDwjTmds14ciLAFPlAem49c4/ml8KPIrahS/R0SPlhtpPe30gcAUKfGLaoeKgsjHxS+XxcLlucqM8iv9kD2P1QYQe+d8naOI46Jim/t9RuLcYaY/5yOSjCviI/W8OmupezaUXLiBTulYsRoFal707+uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mJMukrZPwXdqBRQQg9U/et+AgIHnCosZFldeNeqiHFg=;
 b=H7SZFPtjQSq4+q/AjyNmCttpd/a11/TayVXvacvRskGzGzdi0dDx6i1LQw4WK9F99shxHT1HlSb4c7EyKjk7ofuk3PZfhswNwEOmirGB3z6exGOMYbxH/Qnt/agNrCc6B7M9mfRWlV//aVT6DVvILmxNx+9/qUSntJCaVlPY+xgKV8kIh1B96vu/bs5O2hEKdmEhjOoUFtK4KaWt1WIMoONBgd/esVAz2Xaa3uRm9VacWzQ1nDoGSa1xDyHXC6RoGEgFfthHzbeU4J86fkM8NNxe6+roJZZwwF3QzmXPzKGNCmvkFaYJvyh5DaCR6/LBhcOqEZ+ZYPvLFpBJu6UM6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mJMukrZPwXdqBRQQg9U/et+AgIHnCosZFldeNeqiHFg=;
 b=mOTekuW7AbaIWmbzpPdqAAVjKFbxuokfKRksRpODrxWzy+l/fZ4ONH/zK9oCckYFoKlMMj9iKSWikuJ9Cvxi2wLgBNR29NLQ2RtSUoYjTpTTtB0hpdahQHOKbgNTeO/lN/ycg/2JlON2rKKjOXAFeYnP/CC/4adXy7Yj5DpOUXG9h3JPSnx2q5jbV5mpnlZWaZHGOfFRi5AU5AtFJcbio3t35zCUE1WzzKpsgmvhZCAWsHjcu2s57/pZ60aH35L/6LI5RyePNKj+QXCBAbcANd29u2F//yJEW397r/Mr4vOAXkc9x/CduHNxWUG56Ptcvq33mvR+5TqUfsqFHFOb6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by VI1PR04MB9906.eurprd04.prod.outlook.com (2603:10a6:800:1e1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Thu, 9 Oct
 2025 20:54:57 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9203.007; Thu, 9 Oct 2025
 20:54:57 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 09 Oct 2025 16:54:35 -0400
Subject: [PATCH v5 1/4] PCI: endpoint: Rename aligned_size to mem_size
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251009-vntb_msi_doorbell-v5-1-4cfb7b6c4be1@nxp.com>
References: <20251009-vntb_msi_doorbell-v5-0-4cfb7b6c4be1@nxp.com>
In-Reply-To: <20251009-vntb_msi_doorbell-v5-0-4cfb7b6c4be1@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Jon Mason <jdmason@kudzu.us>, 
 Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 ntb@lists.linux.dev, imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760043291; l=3721;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=LOMfi+sIP0ExKFoZ+4SuzecTW90e8Olxw78NTpYmXeE=;
 b=3NMLv0leNY5puHhaIX0xvKmSCHRFdtQfnKHTsMNFWQEiRjHpNWRG5IUSzwKph4KBKzuqbhYhM
 md8mhDosxGDDSK8UNVZO+jivRZkoJwmV5UcJJNIiEfzvK5oGL30Ri1C
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH5P220CA0004.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:34a::16) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|VI1PR04MB9906:EE_
X-MS-Office365-Filtering-Correlation-Id: c8d21b17-1416-42c7-e2e1-08de07761ac9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|366016|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R05KQWRsRnkzbUJBSHlmeU0wQUJJcVJDdEx4QnBoV21NVVBKaVd2YzI5ZURI?=
 =?utf-8?B?SFBRMDdXVEVMWGZ4WTk3Y09EMGN6dkJjaG5uZTFXV3lXd09DNG85YXNmZGxF?=
 =?utf-8?B?ZlFLTGlVSmF1bFFkT2VhZGpOS05wSVFIT2FPUzNueFI2c0pSektkaE4xaW9r?=
 =?utf-8?B?cTk0N0NodVdVMVYzampRRUpBNDNJclFTWFIzYlF1NFNjSmd3V1pBOERhZzNl?=
 =?utf-8?B?WmhpM1IxL3FJTjZxZWdRRlpkQ3lLeVcrR0xJcUpJU2FITDF4cG56bnpsNVpM?=
 =?utf-8?B?clphT3hmdGNwOUZ6MWtWQmRuYWZQdXg2LzN6c3BYbis3OGVEMmpRTHFwT1c3?=
 =?utf-8?B?VzJZT0wzY3VWanZ1MHNwUTJOWVUyRHVWN01Dc0VLS0tPMVVTTkc1UlVQQVNt?=
 =?utf-8?B?b29YcDJZN05tdVM1VWxiMkpZZlVHSGd5TzZESXpnK0V6djNQOE9ySmNKUU10?=
 =?utf-8?B?QjQ2cjFhNnFyWWdoNjd2dFBub0dtd1JIU0RkRTlpR2JDUWFqbDlMUG1yMk5w?=
 =?utf-8?B?SCtXbTVwWVd4UTZCazN2Mlc4MVRlOXNVZndSVFIzejNkWm9DYlhZakxKOVM1?=
 =?utf-8?B?NGpLTjdLREl4V0M3VUV6UXhhZjRRRzJ3c01RNVJheGl3U1NscjN1ZWxXTDAz?=
 =?utf-8?B?aGRFRUlBUXU1ang1cGFJOEZEQkMwcWFmQXArWHRhd0dES1lUUkgxTVdTTTRF?=
 =?utf-8?B?Z2l5UU14MGhzdjM5dnJYRnlTbkNKWHpTa0pWQk5oSXk3Mm5CVzRxVlNRb09P?=
 =?utf-8?B?dGwyRUVhVGtGbElaYS9OODZRL2NvMExRNWh1cTlodkN6b2xNaVFReThFVmQr?=
 =?utf-8?B?VHFmWnppcEU4R1lLZVFsSlVUTER5TjRRQkh1dURTWG8zMEdJNzYrL1A2OWFK?=
 =?utf-8?B?TDdrdk1jeVJPUEZ2TUswZmQ5YnZ6blhDd2pxcnJqZ0s4OTRuZ2RGT3liUlMv?=
 =?utf-8?B?OUlVYUh2elJzRnJKT21rWDBCak1EUW8rOWxRZFREZ3U2U2xUalV2N01vR096?=
 =?utf-8?B?djdjR1dHQUh6RXFiVTNRZ3Z3K3ZxVEpvRHN1OHR1QWhRT3ZYajRhd1RUeXhw?=
 =?utf-8?B?Qk1FK3pnRm1Mb0pLczQwa215REpJWlViR2wxemZtVVJudnljdkJyTXNsUEgy?=
 =?utf-8?B?TlpDdTZyYVhwbU81RmJRUzhZMWFaK3I2LzRUTTlUd0lGZDk2WC9pcU5RRUxk?=
 =?utf-8?B?QkVOQzBLZXMwZW8xMnpTRjg5VTVSamdabHk5SFRGZllzMUkyUll3ZTBpVVh1?=
 =?utf-8?B?c2ZzbzZMQXg5aGliQXB2RHFMTzVJQmJHZ2QwWDg0RG9icHJhK2hacWV1SVFi?=
 =?utf-8?B?Ym4wTlQ2TnIvK1drcjFsTk1NOXVPbmZJL29SUjkyQWI4UmFKVWhMeTdBaVJS?=
 =?utf-8?B?K1BQNzFPYUtqMGNvTmxDdkUxWVJTT1pFVFMwenBjcm4wRkd6MS9YS2g1bThy?=
 =?utf-8?B?bEptbThjTFoxMHlEZzA5Rm9MOFNvUGVMSzRDMmp2WmJTUGhWZ1ZoaTQxL3RC?=
 =?utf-8?B?K3EveU5KL1pHTGRMYUpWNzczbGVPOFdnSGhTVlJ1ZWE2VVh2VlRLczBqYTNM?=
 =?utf-8?B?cFpGemp4U2plQXNxVXBKV2hTRFFtYVNUNG9IbjJVV244MStFem5zTHpSd2E4?=
 =?utf-8?B?MDY3KzVkMVJsTHo5dXFLY3JhbVVPM0xyL21LcTJ2SjJUYWQwVk9xeGNYSGxk?=
 =?utf-8?B?ZkRDbUdKeUg4TEJIUEpmOGk3b2FoUCtDMC9qOFBMeHVNdWdpNUt3KzVpbUd4?=
 =?utf-8?B?S0J1Ylc3VUJmN0ZBSEk0aFFPQ2VXRjBWNkNSZThzN2xocnVsU2Vua1lzNmto?=
 =?utf-8?B?Y05PTmYzZDNnb3lXaDY1eFFTMmltNFE3VUQ2ME5MaTNyZ3d0b1FUK1lkcEU2?=
 =?utf-8?B?emZzS0dJS00rV20zQlEvcE9ESzdDUHJva0lsZ0Q5dDRqdjhGaDlKajVjR3dL?=
 =?utf-8?B?NFVjR0FXUm9sZFdhdHlLOGZidkxvWk9xait3NmVqZWM3czRaWHMzdTFnZGtN?=
 =?utf-8?B?aHE1QXlsRmhYbklOSTl5OWVzSHFvSmg3Z3FZWVJjcTZndXRVNTZVVHRRTUx2?=
 =?utf-8?Q?azGR7L?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(366016)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dDEwbVBWTDlsZy85WWRkd2FZRGl3bkZkOEJwS1o4ZjRxZWFqWTYxZFFpbDlX?=
 =?utf-8?B?ZXo5dnE5VnQzSThTaVREVGR0KzVpMkNOOEZ3NTBrczNvSEdIN2F5RFFXUVJw?=
 =?utf-8?B?b3JBVDBOaVp5QXJoV0V3VnMwMTNvL0t2d05jWTUybC9uTC9PRUVYNmtmSzFE?=
 =?utf-8?B?RnRMV0plZldCbUJ6cWhjYUJ3dE8va0VpQTkyc3gvOWpRY2d1Zkp3UThMSkRw?=
 =?utf-8?B?L20zY1k1OWpjNVFFanl1UWVadWpyMFJKaWp2R0l0WldiWVI2KytjR3lacGdH?=
 =?utf-8?B?cEljRVZkeTJOKzJjYzlmUHpINkJadXM1VFlmMWRDYTNFVnlXVVVIVlBhRDNx?=
 =?utf-8?B?eENQQlk0UUNxbkxrSnFQRkN4NHlwZFpLUFNPcGM5dHNPOGt5Q2dBUTFNQ3Nr?=
 =?utf-8?B?czgzRlIvaE16UEdPRXZ3T0JhRThrYm0wQmhjcXd5cWNOZE01YnROa0xzSmJu?=
 =?utf-8?B?T2k0ZWZuNHJsNEg4MU4wcWUrY0VxQ2lSQm5ySDR5ZXd4NkxibUlPYm52bHJa?=
 =?utf-8?B?c2VJMTZWTXVFL2M5R2JFZjA3SS81N2RWVlJFRUNYZXBEYWJ1ZGRaNXBOMUpO?=
 =?utf-8?B?WjR4RXJmUlFOZDhKaG5UNDZjNTRuV2E4cE5zcVRDQnI5QWhEbFdqaVYrQU1Y?=
 =?utf-8?B?VThoU3JrL3pCOG51ZDBYalpCWlpQeGt3L0VrMlc3MVJxUzNDTVg4VnNHUWVh?=
 =?utf-8?B?dUxEcmlVWWNTYXBiODROWDNMYzNiektXN0gzL2xtdUtKU2NhSS82a3BWdnND?=
 =?utf-8?B?MThYcE1KTjAybmQvZnRBNmpIemNMb1Q5RkV2YlFxMFFBK3FUYjNZN3hSUU01?=
 =?utf-8?B?a2hZN0RReXNFbk91ZEFsQmRRbVJCQnpaWlozbC83di9yUEdzZ09nQUd1RWZp?=
 =?utf-8?B?V2NuR25tQkdTM1ErSEJuSnpMcmwwdWlxeFN3N1poY0hna2dCQWtkeVZPdkRw?=
 =?utf-8?B?YjVwaEc3UzBFK1lnWDlpT0t5eExsVEpTelVEVlBuNlc1K25JYlVvWG00ZHEr?=
 =?utf-8?B?MWJzeXJ5RnBQMmJmRFJUaWdWcm1KYXQwVTUwTk9XelFKM0RQZGlDU3R3S3or?=
 =?utf-8?B?U082RU5FV3JZL2I3blg3S2RacDVkQVBlM3dmQWRiSFNxSUlIRnh5eUlLdHcz?=
 =?utf-8?B?SnFOTW45K29XOUoxaUN5d0JQYWZDenFKZ2E4cmZBaFZTNFREdkxqVFNTUG9x?=
 =?utf-8?B?ZDRuK05xMlRUYTZ0WmRTRjdKc3phejFNL3BCdVZOanJBelR6L0V2UTZUWUFU?=
 =?utf-8?B?dFF6Z2NCcG9YS1JMNW1QMlU2U3RySDN1L3dnc2F4K2FXQ1Nyd1EreTJ5WktB?=
 =?utf-8?B?d2xoK3JQMTcwaFJSdWxJdm9Kd2RORTIyaVU5RktNczNGYUgrMkFNWGhxVURU?=
 =?utf-8?B?M2lWTjZWd0RnNDhMNEtoVGRNZ0JoYXhEZ0pVL25QM0FBTmhaNjlhV3pYMEd4?=
 =?utf-8?B?QTJiMlpkZ0d6QjNGZ0dKWkNlOU1KbTlNRVZRTUhWMnVEbDNoS0JJOWNIK3FY?=
 =?utf-8?B?bHJSQ1lramRVZW5kUFk1Rk9SbG9SdEtzb1NucEQvUVhWVGE4QzA5Wm9HblJ5?=
 =?utf-8?B?cnNWMzIzaFBGakxtV2ZQOHY2bkx4UGpwK1B3K2lKQi92cDBZSVVWMDNGQUk4?=
 =?utf-8?B?R0tEeFVBYXppZFdFME9uMU1sWTdVUkpoOE1qMVRwVEkrTGJuTis4YlBnV21m?=
 =?utf-8?B?UmdET0tpSjhwZXB0SU9pVVVZZEl5a3FTd2xudmF3UHJmOGY4VHNjdDhHeUxY?=
 =?utf-8?B?SC9XKzdKV0hYajVNOHVNczdYcVNHUzkvQ09QaWpwZk44cU11Q1kyaFVSRzdy?=
 =?utf-8?B?K0hhbXJ6cmxEdjJzYk94UkJiOXNQenE5YXB3SWJXNUpDRzNPb0R4OEtVRDNo?=
 =?utf-8?B?ODZMWkt3dXJVUDJheWhZeWdybE5qdHBxVDc1NVJ3cUNCZHdnbWNJNEp4ZDYw?=
 =?utf-8?B?dEhBTXNMTy9xMXFWZ0JLNWNRMDBSdGRFNVV3M2JHcDQxRW9LSVlzczQxdmpP?=
 =?utf-8?B?cHN5b3V1MW1MZ2I3bUZqN2NkWW9JMWhPVTd3L2I4WEM5K2I0R0QvNDRxRUNI?=
 =?utf-8?B?ZmtHd1VsVVpsam1raUdDaEJCYzNpMlcwSTU2TUxCR0VVYmtOaStEV2RvemRM?=
 =?utf-8?Q?9OhDASQuJXRq1/zF4cJqW/7xx?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8d21b17-1416-42c7-e2e1-08de07761ac9
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 20:54:57.2057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wx7duqAF3wkEp28xA6mYJpJa/J3wOK71ALd+ckTB/OG6oaGJWd2DHe0BfXo6HQ3DbAvvCNcDe/6LiGmtgrjegA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9906

Rename the variable aligned_size to mem_size to better reflect its purpose.
'aligned_size' was misleading, as it actually represents the backing memory
size allocated for the BAR rather than an alignment value.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v5
- new patch
---
 drivers/pci/endpoint/pci-epf-core.c | 12 ++++++------
 include/linux/pci-epf.h             |  6 +++---
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index d54e18872aefc07c655c94c104a347328ff7a432..214e3f6e6d0d5a216c3469b8ff47908414cd1286 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -236,13 +236,13 @@ void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar,
 	}
 
 	dev = epc->dev.parent;
-	dma_free_coherent(dev, epf_bar[bar].aligned_size, addr,
+	dma_free_coherent(dev, epf_bar[bar].mem_size, addr,
 			  epf_bar[bar].phys_addr);
 
 	epf_bar[bar].phys_addr = 0;
 	epf_bar[bar].addr = NULL;
 	epf_bar[bar].size = 0;
-	epf_bar[bar].aligned_size = 0;
+	epf_bar[bar].mem_size = 0;
 	epf_bar[bar].barno = 0;
 	epf_bar[bar].flags = 0;
 }
@@ -265,7 +265,7 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
 			  enum pci_epc_interface_type type)
 {
 	u64 bar_fixed_size = epc_features->bar[bar].fixed_size;
-	size_t aligned_size, align = epc_features->align;
+	size_t mem_size, align = epc_features->align;
 	struct pci_epf_bar *epf_bar;
 	dma_addr_t phys_addr;
 	struct pci_epc *epc;
@@ -297,7 +297,7 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
 	 * it might be different if, for example, the fixed size of a BAR
 	 * is smaller than align.
 	 */
-	aligned_size = align ? ALIGN(size, align) : size;
+	mem_size = align ? ALIGN(size, align) : size;
 
 	if (type == PRIMARY_INTERFACE) {
 		epc = epf->epc;
@@ -308,7 +308,7 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
 	}
 
 	dev = epc->dev.parent;
-	space = dma_alloc_coherent(dev, aligned_size, &phys_addr, GFP_KERNEL);
+	space = dma_alloc_coherent(dev, mem_size, &phys_addr, GFP_KERNEL);
 	if (!space) {
 		dev_err(dev, "failed to allocate mem space\n");
 		return NULL;
@@ -317,7 +317,7 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
 	epf_bar[bar].phys_addr = phys_addr;
 	epf_bar[bar].addr = space;
 	epf_bar[bar].size = size;
-	epf_bar[bar].aligned_size = aligned_size;
+	epf_bar[bar].mem_size = mem_size;
 	epf_bar[bar].barno = bar;
 	if (upper_32_bits(size) || epc_features->bar[bar].only_64bit)
 		epf_bar[bar].flags |= PCI_BASE_ADDRESS_MEM_TYPE_64;
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index 2e85504ba2baf93827224884ca19ae2bd0e6906b..4022dd080e20f2959f3a5faf4cfe054ddb5856a7 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -115,8 +115,8 @@ struct pci_epf_driver {
  * @phys_addr: physical address that should be mapped to the BAR
  * @addr: virtual address corresponding to the @phys_addr
  * @size: the size of the address space present in BAR
- * @aligned_size: the size actually allocated to accommodate the iATU alignment
- *                requirement
+ * @mem_size: the size actually allocated to accommodate the iATU alignment
+ *            requirement
  * @barno: BAR number
  * @flags: flags that are set for the BAR
  */
@@ -124,7 +124,7 @@ struct pci_epf_bar {
 	dma_addr_t	phys_addr;
 	void		*addr;
 	size_t		size;
-	size_t		aligned_size;
+	size_t		mem_size;
 	enum pci_barno	barno;
 	int		flags;
 };

-- 
2.34.1


