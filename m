Return-Path: <linux-pci+bounces-16584-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 497A59C63E9
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 23:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3223FB42C63
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 17:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CBF2144DD;
	Tue, 12 Nov 2024 17:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Pyrwu7vH"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2058.outbound.protection.outlook.com [40.107.249.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73E9215035;
	Tue, 12 Nov 2024 17:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731433728; cv=fail; b=jbYchHgwi3eTjR2UjaWuWDtvAZBJpS6RX2MWON8YRpqPeGUYe4eodZQ72KVFtgDAgExENbbNSmpPJ4rF2fuHwpGHX3wA2QChQh8p9Zo6MV15FoOSFGFsW5X8etOhhmu+OW59klk2H+++1XhXA56L8zEMwFwRh3pd0dsnyVKTYd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731433728; c=relaxed/simple;
	bh=YT99E9eq13FEX+qUFaoGejBUqS7EaIaDgacmztfhmnw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ODQ0IzlL/jbaFwT3sZZgk3EBpUIvulEmcWIMYurZkI8oyW00FCkaKJl/J8iKvT5EnljZ4cCdXqnyQZ70mmOV/FUtulOFFnvFPPC0lUGhDDjca3KfM7T7mW0brLpd6QfP1DdlFfsD2926ydzzYY7M0/ZVkKp6sowyzrH/+qO1fPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Pyrwu7vH; arc=fail smtp.client-ip=40.107.249.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KZAjuLdPctdELsZH4lR0hr+bbPx2MAtRFru8O73t1Yap4rMc9LLLeebEBGJ9dWpUtJ52e9G3aqcFai3Xx12PA1SwbIhMpPa6e2HfbIwU2kJwfM0jutS3a1kl+AVJ/cobhU/ZLUovBpNtL0gWV7ffkP6/yuqqjOWSVAUaYRsMG9HN+NzI/51O081+DhaVG8y11NxVXQRm+hGB1F5VJCWzl2NlZHIaJT4IO7prmqKjEbr97sJTIMxJL9sJ/UkdkoAXxGKMDSvfUn1ALn1uT1lTivRtimEFVa9xClDruzOgIpX9m5jFLz1nUtjzu0i/p05PFu8FBBErAkhEy3folbgaaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0C1f/pv6sXoxTlSc1BeTk4SRqkS6VfLm5JtkIQZDNKI=;
 b=HGijjyuYX3EjDmNExNBvLGDqvEHijQdZYIuIsdyBYM+JlwyNyFVvIZf8ekVIFsriFXQVSQ2owOF9ONgNgDV8lTnZwoAoHCnZpAT/TKxRzV2aMJ78NUjR0B4YhIxegU5Ns1j4qPGTiL8ZIe1w+rpn+RpKrudaZ2j2EasYLg27wlmtCbrLf2sTApyPcg4y4l+0WQ7UwiZZNiz3iFgqnQFv1OO9DpAE00m/QhvD/NbkSmvVBIXAPBruFn0esnsq53Snw3der3YDPXIvdLbOmm0KBa3TDYlaPlIbR+MFs8vBGOFoe0frR0YZfNm2c+fBzxXcrbCzEbesc3WCPLfHoK5H3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0C1f/pv6sXoxTlSc1BeTk4SRqkS6VfLm5JtkIQZDNKI=;
 b=Pyrwu7vHT6SQbsoWn27SSPf+A3Qy9NkOAxMnL0YHWdhmTopBciuLnWZqsIgeXZyX5zoX6zGy+GjrNVy2AeZDEdfHzsoIXmQsc4A1wfvanL0VXb7RbI/3FxWVqnQRjBqETzkFUItpI5Casn+KwKX2pKxzPafnwxeqAYZE8EPMZPNCJrjHLyBYoAPHzK3NNiXbPuoMjygcU2Eh8v22VXPBqYTNje31OJoDsjdT+H0smg2D02CH7M092WhX7c5rclML4cYoabg2vYXDzSzmeEAE1Iu+Sy3wB0etJCL7ak4iQWwY993jWJWrub2IaWi2avjlMlkDB2sRkSkelO0eRuwZyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Tue, 12 Nov
 2024 17:48:43 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 17:48:43 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 12 Nov 2024 12:48:15 -0500
Subject: [PATCH v6 2/5] PCI: endpoint: Add RC-to-EP doorbell support using
 platform MSI controller
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241112-ep-msi-v6-2-45f9722e3c2a@nxp.com>
References: <20241112-ep-msi-v6-0-45f9722e3c2a@nxp.com>
In-Reply-To: <20241112-ep-msi-v6-0-45f9722e3c2a@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731433711; l=6297;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=YT99E9eq13FEX+qUFaoGejBUqS7EaIaDgacmztfhmnw=;
 b=3G7wSUQ8lVrRXb76K5hYxWOK7cOGMX6K7i9qKqWPomG9g6fOex46BZ9Dk8QR0E7s+K0JR3lpL
 +lTN1oCDqjmCB11vht+gh8gERaJydPQKuyuwjLxlpjt/DWiNYxfSNRh
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR03CA0076.namprd03.prod.outlook.com
 (2603:10b6:a03:331::21) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB9510:EE_
X-MS-Office365-Filtering-Correlation-Id: 41a15fc5-a550-43b7-07ae-08dd03423fc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NDV0YlJRTnlDckk0TW0zZWxwU1NGajd6eDVjRTltUDdqby9WWVRVcy9Fc3Fv?=
 =?utf-8?B?VGFWdFhMcjhReUZFcDZXb1cvd2VKOUF4clp5dGdsWFJwNDcrVHFkd3pCVkty?=
 =?utf-8?B?Z1NYaU9xVDFXaUIxYTduYzBJL0gzSUQ1MUI4aWljUjNCTkd6WkpLQ3l2NWdD?=
 =?utf-8?B?NjExb1JFRHpoNHNWbFdNTk9Iek5jbnk3eXdFR3VvRXluUlFnRVpaOTR2a0or?=
 =?utf-8?B?U1gwbGtZYUJIYjM5YWVNeGpMaWhvR3IvZWJ4eTJid0NITE9KdVdTakhHQVVm?=
 =?utf-8?B?TFpqTkU4a2wxK3ViSkZCTHRoL2UrWnlhN21rYzRRaWs1cXl2VmEwSnZvM3J3?=
 =?utf-8?B?NUx1UCthR0EvWlp0Q09qbTlzZ3cwUWlHM3pZYVpaaUhBeHBIazVZVXVWRW1s?=
 =?utf-8?B?WWtGZldXbEExbmFySXMyNTArUWxKckpMalhsZXU5VEo5ZUtXS0h4TjlqdGNB?=
 =?utf-8?B?Yld3dmdwZGYzWTNtazNReTd4aDRia1BZUllMbFpPbWc1MTRyaWs3ZkNYc1RD?=
 =?utf-8?B?eGNFMFJFOU9jZUtDSS96WTFVeFJmOGQrdzVTVWJXTXF2WCtzdFhOWldxRStI?=
 =?utf-8?B?NTc2Vk4vbDVoMUZRNXRoZ2MwS1Q1VDNqZnNzVThFSzNMTFBZaVdYZWI5K05h?=
 =?utf-8?B?TWJvWUR3YUdWcS96ZGVjc2xHbUh2TXBydDBpRk9YVlo2TmpudTg4OC9SSDZk?=
 =?utf-8?B?U0c4Mm93a0xBSjhQUm1IdXdXY0dzRjNtUkNJdWNVY3p6WVRXeHBCNmxDYWlF?=
 =?utf-8?B?clRRbjlhNGEzd25QdUZSVWF6aDIrTllqV0hnQ0VYU1lOVE10Q2lVY3hJTlQ5?=
 =?utf-8?B?cUlrVjlZbXI0b09HVXVrajFybFBOVndEYzg3Vk5hZ2VXV0tydzMxQ2U0bFgw?=
 =?utf-8?B?T2Rsa21NNFh1MmVsYnhxQ052SjdKdGprdVZhcWp3NE90VzVYUTY1VUdNZEta?=
 =?utf-8?B?djRjRzIvZ1dvUldPVnJ5VkVVaUlDazVkUWl0NVJwOGdxaFB5aWliVnhIV29p?=
 =?utf-8?B?dWNYdm96SlpzaHJaOCtGU0pqWE1ENHdwaWZFTEg4VmNXTC9OVmJoT1pWQW0v?=
 =?utf-8?B?dHJMb0tWT1lkODVaaG90dDBpcndLMDRoSURrNVd2NEQyOEVsTnZTa0pjNEUy?=
 =?utf-8?B?TEh3TlB5ZTBkN2xZL0l3VU9DTzZpYzVjbTVDWmFrUGVtL2cvcDBaQVBzMms5?=
 =?utf-8?B?VmlMTHlSU1A1MWNJQVhORTJqQkRGQzRjK2xUdHhDUlIyNXE5TTRjVUlWSFBm?=
 =?utf-8?B?VDJWOHc4SHVLZXcxdnVpUFZkN2t3blZBRTkyL2pJL293K1kzek4wVzhCTnhx?=
 =?utf-8?B?T05pR1BoTm95ZUpEa1FWV3FjcGFkN3d5ejVkYjhTcFROWld5aGZuemJ0aS9S?=
 =?utf-8?B?OU0zNEU4T0dkWkZTdW1rYStGWHcyRmhkdTJxNytnV0FiZjFsUWdGcmVhV3hm?=
 =?utf-8?B?UGhNbCtzNlMzN0pZdnV1NW5Zci9Wc3N3Z08wbnllRkJXdkhLOGthaDBORHJO?=
 =?utf-8?B?SkIzeC9xL0FzdnhHV3FpTk9NNk9nRjJHemhCYmxEbm10ODRCL0cwSmFFN1hW?=
 =?utf-8?B?ZWhPWWdIWVZYc2VPS0pkWnFLMzhUUW1TR2ZCUURXa0JDazRUZUVvVmhuK0Vl?=
 =?utf-8?B?ckc5dTU1d0tjamU4L2dhK1BQWXlwalVubUduOTM1anROWUNkVm9TQ2pHeXk1?=
 =?utf-8?B?UWN3U3FvWlZZak9wNTJuK215Q05lWFo1dWU1bjNtUi9hQzh4TEhpajJUencw?=
 =?utf-8?B?L09TTWN2N2NCdUdIcjRjZDBZZE51YXdpa3RibDlWc29sa3U2d3V5VE9Wb1NU?=
 =?utf-8?Q?jGFxAP0d9mIu/DNRcpeSH25ROG6/8hZZwadVw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M3Q1MEVCOUsyeHlZQTdyTjBPWkpJWHBSbzRCZ0ZEaURnNFcwQ0xXOXI1aWg5?=
 =?utf-8?B?eXNYNDRoUTV4bGtsclVGVVAzcmNIWFRSaEJNK09UWG4rRlRBcG11amxEMmNL?=
 =?utf-8?B?ZS9KSVdXVGE4MElCenkxQkE5WTJyY1pnZ3UyOXJsemcxODd5OE5jcHJOL2Iw?=
 =?utf-8?B?eGhCNk4vL3NQUXVZNXlWeDl0UXI0bmFoRnpiZ1BNK1JWOEtDU0o1VVBEVnZh?=
 =?utf-8?B?UVdzaUprclBGcGJaM0d2UUY3dFN4TWJibG13TXBoeWk3UzczOXp1bnIvQ2tN?=
 =?utf-8?B?YVRTZEt2TG4wTk9Hc21UTVFSeXFheE1NUW9CVmxnOUxhRm03c0d2L2FnTHM0?=
 =?utf-8?B?Mm9kQzV2cWFjSGF0NnRkekdQdEczMC9vTXp2ZDYxTExxaithc1VVS1ZhY1g1?=
 =?utf-8?B?b2xoVXpDNXhHZkNJMTBjRW0yUmxyVm5OTWZzSHVQajk1TnF1VXd6eTBrZE1a?=
 =?utf-8?B?WjBvcWtQS21PT3Z0VkdNdUpCNHdZaUxBK21ZQlRXa1c2Rm11UnFoMERUellQ?=
 =?utf-8?B?OGpyT2J0RXdwcW11RnZvYVRzLzFmZHVXVzlNdXJuWjQvVHVGUXNBSWJkN3ky?=
 =?utf-8?B?a20wcG9heThYRjgrdVBBS3VRZmVkbERVU3QxWDJuL2l4OXlFSGxQZXlzUlQ2?=
 =?utf-8?B?dEJaVmZVc2JVYkFuZEpyUTZkcU8weGxJZnk1KzlOL3RKMDFlQSt4WTNRY2h6?=
 =?utf-8?B?UkI3dWVSV3dLdUNhU3ZUTnc2QzZmZXZEOENoYkNsNFArRHIxZ1VTc0NmWktn?=
 =?utf-8?B?dkRBSkNWbGlvODBvQ0ZYQkdRZzVuZW1oUnQvSUxudGdtZUVUUTgySk8zVGty?=
 =?utf-8?B?SDY0VE53OE9CeDFHamVWV3dYSVNTTmxqVDh6aXNzcDgwVFBYZlBYR1JlMk1x?=
 =?utf-8?B?KytvTEw4NzNXekdCMFQwL1huZ0Z5dW9SR1hPdWZTZ3MwOW96dmdpUlhTbGFI?=
 =?utf-8?B?Wkg0d2d0eWdwdXg0S1VkUlh2TXd2RWlBa3R3MlZqczVRMkdMQ0RtWWwvNnNl?=
 =?utf-8?B?MlIxUmJuWDAyd0lPaGZQaXl2TTI3TWhhSkZjbXhWalZBMUtuNk5kbFNvbDZM?=
 =?utf-8?B?SHN5enBqbTl1VTJKY00rTE5GQ0xLMVpIOTNSS01ybmE2aTNnaVkxZFExUGwz?=
 =?utf-8?B?Q0JjRm5sWXlYVGY5NThnYnNVeS9hekJpN2d5U0pXc3dqL1U1amJUTitiTzJD?=
 =?utf-8?B?dEpyWXJLRDh5bnFmNk9aU1lSbk1IVHhaTEJwZWVzcnZzWlV1NWZiUlM5VnpU?=
 =?utf-8?B?SWpFZUdqSm5zK1pvSXFoNHY1REx3ZEZGSjR6amF0RVFqV0VLTDRWSlZYTVo1?=
 =?utf-8?B?ZVFQYjVJclJFbDBENWI2Y1JRZ1N1dm0wQVFBVFdRMG1YaDNiL1BOeE5aeVdy?=
 =?utf-8?B?MW9HQ3hpME1QQnpkS3F1K3pWbHViTllYdnNiUWZTdjZxTklkUDFjcTJQT0hO?=
 =?utf-8?B?VS9zcUhXZnZqSHRMR3VmRndBS1NyK2tHNkMzSldDUkRERHFaREhLVEdDVkRV?=
 =?utf-8?B?aW9UdmFHUXdMajE4SGtRdGpIaU9KNXN2UkNCTmY5dHNUWXBzS09tYU9OUUdy?=
 =?utf-8?B?b3J1Z29aR1FjcWRXSWNIUS9lVTJMSE9iQWYyb0VmWHp4TXVRbU5LVUlqZnk3?=
 =?utf-8?B?b3AxVWhMTE5vRDNxekZsNFVaVGFMK0hiZFBKYU5wQ1BwNWpHNzR0ME1zOTJX?=
 =?utf-8?B?cm9rTkl2OEJweWpGKy92ekZ3VzYxSittQzA2cTNqYUZ4QWZrb2F6d2xQU2Rq?=
 =?utf-8?B?ZUsyUHhtUHFablZhNjJXTWpHVyt0T1RvU2t4VTg1NWpwNDlEWTNrdU1id2lF?=
 =?utf-8?B?ZTRJemFyV2l4cjB6bDh6Tk9KeTluQlFhSlJ4enl2ekU1eURCWTdwWkJwTkdv?=
 =?utf-8?B?UUpaZk5jaTY4aHEwSmVpdzVIZDVTeTNORE1UNGZ3RWNIdW5jdUhkcXZsVEVQ?=
 =?utf-8?B?ZjV1dlI2SU9tZFBDWEc1V0o1S25mZDQ2bTVubjhpb0FHSm1zM1Q5VDAwYzJm?=
 =?utf-8?B?THBobTl2V2gzUjRvejFxb0NMNzhnTDZ4MEtFd2NGZFZ3cEJEZ0tmTllZSzl1?=
 =?utf-8?B?c2FLeXZpbXRweExCSDRScm9GK29VTVcrRjlIODBxZmZqTTJ0ZzVGS25sWlZy?=
 =?utf-8?Q?VN9Y=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41a15fc5-a550-43b7-07ae-08dd03423fc7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 17:48:43.0516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1QZiWkSYEZ/Qq1DiMO0HLyfBes9+5ifUZtFYwHkhXqUHJER6OwZk27hOgUj9c+5LBd8JSvSrwvxaL0IBLwjdzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9510

Doorbell feature is implemented by mapping the EP's MSI interrupt
controller message address to a dedicated BAR in the EPC core. It is the
responsibility of the EPF driver to pass the actual message data to be
written by the host to the doorbell BAR region through its own logic.

Tested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v5 to v6
-none

Change from v4 to v5
- Remove request_irq() in pci_epc_alloc_doorbell() and leave to EP function
driver, so ep function driver can register differece call back function for
difference doorbell events and set irq affinity to differece CPU core.
- Improve error message when MSI allocate failure.

Change from v3 to v4
- msi change to use msi_get_virq() avoid use msi_for_each_desc().
- add new struct for pci_epf_doorbell_msg to msi msg,virq and irq name.
- move mutex lock to epc function
- initialize variable at declear place.
- passdown epf to epc*() function to simplify code.
---
 drivers/pci/endpoint/Makefile     |  2 +-
 drivers/pci/endpoint/pci-ep-msi.c | 99 +++++++++++++++++++++++++++++++++++++++
 include/linux/pci-ep-msi.h        | 15 ++++++
 include/linux/pci-epf.h           | 16 +++++++
 4 files changed, 131 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/Makefile b/drivers/pci/endpoint/Makefile
index 95b2fe47e3b06..a1ccce440c2c5 100644
--- a/drivers/pci/endpoint/Makefile
+++ b/drivers/pci/endpoint/Makefile
@@ -5,4 +5,4 @@
 
 obj-$(CONFIG_PCI_ENDPOINT_CONFIGFS)	+= pci-ep-cfs.o
 obj-$(CONFIG_PCI_ENDPOINT)		+= pci-epc-core.o pci-epf-core.o\
-					   pci-epc-mem.o functions/
+					   pci-epc-mem.o pci-ep-msi.o functions/
diff --git a/drivers/pci/endpoint/pci-ep-msi.c b/drivers/pci/endpoint/pci-ep-msi.c
new file mode 100644
index 0000000000000..7868a529dce37
--- /dev/null
+++ b/drivers/pci/endpoint/pci-ep-msi.c
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCI Endpoint *Controller* (EPC) MSI library
+ *
+ * Copyright (C) 2024 NXP
+ * Author: Frank Li <Frank.Li@nxp.com>
+ */
+
+#include <linux/cleanup.h>
+#include <linux/device.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/msi.h>
+#include <linux/pci-epc.h>
+#include <linux/pci-epf.h>
+#include <linux/pci-ep-cfs.h>
+#include <linux/pci-ep-msi.h>
+
+static bool pci_epc_match_parent(struct device *dev, void *param)
+{
+	return dev->parent == param;
+}
+
+static void pci_epc_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
+{
+	struct pci_epc *epc __free(pci_epc_put) = NULL;
+	struct pci_epf *epf;
+
+	epc = pci_epc_get_fn(pci_epc_match_parent, desc->dev);
+	if (!epc)
+		return;
+
+	/* Only support one EPF for doorbell */
+	epf = list_first_entry_or_null(&epc->pci_epf, struct pci_epf, list);
+
+	if (epf && epf->db_msg && desc->msi_index < epf->num_db)
+		memcpy(&epf->db_msg[desc->msi_index].msg, msg, sizeof(*msg));
+}
+
+static void pci_epc_free_doorbell(struct pci_epc *epc, struct pci_epf *epf)
+{
+	guard(mutex)(&epc->lock);
+
+	platform_device_msi_free_irqs_all(epc->dev.parent);
+}
+
+static int pci_epc_alloc_doorbell(struct pci_epc *epc, struct pci_epf *epf)
+{
+	struct device *dev = epc->dev.parent;
+	u16 num_db = epf->num_db;
+	int i = 0;
+	int ret;
+
+	guard(mutex)(&epc->lock);
+
+	ret = platform_device_msi_init_and_alloc_irqs(dev, num_db, pci_epc_write_msi_msg);
+	if (ret) {
+		dev_err(dev, "Failed to allocate MSI, may miss 'msi-parent' at your DTS\n");
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < num_db; i++)
+		epf->db_msg[i].virq = msi_get_virq(dev, i);
+
+	return 0;
+};
+
+int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
+{
+	struct pci_epc *epc = epf->epc;
+	void *msg;
+	int ret;
+
+	msg = kcalloc(num_db, sizeof(struct pci_epf_doorbell_msg), GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	epf->num_db = num_db;
+	epf->db_msg = msg;
+
+	ret = pci_epc_alloc_doorbell(epc, epf);
+	if (ret)
+		kfree(msg);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pci_epf_alloc_doorbell);
+
+void pci_epf_free_doorbell(struct pci_epf *epf)
+{
+	struct pci_epc *epc = epf->epc;
+
+	pci_epc_free_doorbell(epc, epf);
+
+	kfree(epf->db_msg);
+	epf->db_msg = NULL;
+	epf->num_db = 0;
+}
+EXPORT_SYMBOL_GPL(pci_epf_free_doorbell);
diff --git a/include/linux/pci-ep-msi.h b/include/linux/pci-ep-msi.h
new file mode 100644
index 0000000000000..f0cfecf491199
--- /dev/null
+++ b/include/linux/pci-ep-msi.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * PCI Endpoint *Function* side MSI header file
+ *
+ * Copyright (C) 2024 NXP
+ * Author: Frank Li <Frank.Li@nxp.com>
+ */
+
+#ifndef __PCI_EP_MSI__
+#define __PCI_EP_MSI__
+
+int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 nums);
+void pci_epf_free_doorbell(struct pci_epf *epf);
+
+#endif /* __PCI_EP_MSI__ */
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index 18a3aeb62ae4e..5374e6515ffa0 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -12,6 +12,7 @@
 #include <linux/configfs.h>
 #include <linux/device.h>
 #include <linux/mod_devicetable.h>
+#include <linux/msi.h>
 #include <linux/pci.h>
 
 struct pci_epf;
@@ -125,6 +126,17 @@ struct pci_epf_bar {
 	int		flags;
 };
 
+/**
+ * struct pci_epf_doorbell_msg - represents doorbell message
+ * @msi_msg: MSI message
+ * @virq: irq number of this doorbell MSI message
+ * @name: irq name for doorbell interrupt
+ */
+struct pci_epf_doorbell_msg {
+	struct msi_msg msg;
+	int virq;
+};
+
 /**
  * struct pci_epf - represents the PCI EPF device
  * @dev: the PCI EPF device
@@ -152,6 +164,8 @@ struct pci_epf_bar {
  * @vfunction_num_map: bitmap to manage virtual function number
  * @pci_vepf: list of virtual endpoint functions associated with this function
  * @event_ops: Callbacks for capturing the EPC events
+ * @db_msg: data for MSI from RC side
+ * @num_db: number of doorbells
  */
 struct pci_epf {
 	struct device		dev;
@@ -182,6 +196,8 @@ struct pci_epf {
 	unsigned long		vfunction_num_map;
 	struct list_head	pci_vepf;
 	const struct pci_epc_event_ops *event_ops;
+	struct pci_epf_doorbell_msg *db_msg;
+	u16 num_db;
 };
 
 /**

-- 
2.34.1


