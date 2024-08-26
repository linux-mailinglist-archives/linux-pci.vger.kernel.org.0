Return-Path: <linux-pci+bounces-12225-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9674F95FBD7
	for <lists+linux-pci@lfdr.de>; Mon, 26 Aug 2024 23:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBD7A1C21961
	for <lists+linux-pci@lfdr.de>; Mon, 26 Aug 2024 21:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6CA19D08C;
	Mon, 26 Aug 2024 21:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZtYmeEDy"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011043.outbound.protection.outlook.com [52.101.65.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052D219D07A;
	Mon, 26 Aug 2024 21:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724708377; cv=fail; b=PBODODBBXJ5yRZAsTq37MbX8MxX9Kw+g5PXKnfC4+eRt83j9UG9eEJkVtWTR/UaESCZquc+vunme90s0KqH3kZl0d1JgONey4u3zke8vEYclEu+IxXPFrMkQFz+QoKh3Azo+qZEs+zzP+oahQC8dYLCQv7UGKxprRfUViiKqG1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724708377; c=relaxed/simple;
	bh=PIVUh4mo86LjWwqpLBE5dlM+D4iaxoH2rYfkuU3+e6Y=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=BxyX09evVTzim8pP08h/STjBCUBjWHRIcZDKx48w234Ugwl2pTpDpKlcqDd8yCudM595r/CC8ZZEuX+QNaMRr5rq/3UMS5PZo7/Toh/mf8Xk9jTkX2r55aDU7cVDJa+6FU+XDWcZM70NaDuI1yE6lH9nIQ+IbQ6BKGr9gn+Erf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZtYmeEDy; arc=fail smtp.client-ip=52.101.65.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a/NllxeVLtwQXxrGlZp+3ZYy0bMU6c6wdyFKEeGMMmyMlxkjZcHAgMsy/tgUBAV1YyqQX1khMxdcpjKRfCxMgMfRDGNROlNe+kDZyhfQmDMITuv4D8ihDgcVqLxgIJG1njEhYJl2GYG74KKJZztuVZYSX3jGyWa9Wn6q2VsybBKzCV9D719fkPPXj3pQfyIVWU1tSriD8a0OkfPDEET6YYf3JmdTGF7wxykjwBFl2J3Ynfmm1O0HJyH0598x4MVydl+JvdOtlEaIMzzUlxBvq2QfSsuAAjJKldSfCKdDY/ylwmpRltnH61cSfGRgsLfmTO1RmpjSq8wEfBZ5tcPyCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8E/LX3Bby8r0XxqOJWZ05/ynY6HsOtJnt5emu6j9PJo=;
 b=uSKlyFTgMfcjZBGT7pmPj7lgh99vrzxKcKteUe8fRjJIcTy6LMyoZ2HGluTFN/fRxzjhzfaLE3mBDI9fsybyrcpZwzzlSHLZ0uWgqcl7+O5ZxOCuctZGk5xAajMOBS/O1ElvIwU8WzlWogG+cKfVvXSNZratWlidKT9RU1SOaYJstM6UzxJCX+lXQo8W988zRzf0CsA+kadqXIOGX8gxirNNghNWm6nORpPtDLtscA6gkEI7braazUnqk1Eku3n+iVsi5mtKBb+CZ1OpCKh47NLOpAlNHMKMO8RKkegtVzD/z5IL3XsgRXnMzjsEPMl4uUt5ZywhfDt8Icsq2/jBfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8E/LX3Bby8r0XxqOJWZ05/ynY6HsOtJnt5emu6j9PJo=;
 b=ZtYmeEDy1shd/1+0ok0LeT2SOlu8sH+Cmq0BkFGD44ReGHcKAwsigj/p6qZY6wz1CHh5dwtzJ6Dq/p+6jFlUgiM/IycHSwME5aBAgMxuuRd7+VmzGUAx007Bwu2oLyEBaW+ZTTv2682OJN3WqPh0pQnCNRIXhBFD6CuX7FxQ3xkkne3bh5QhdKLaqjLtGxTO1vVA3a0BLT/Ylop67r29Y9pXC+lIlkU7EwAZLsTNLiziLC+GGNKihAT7HWUTE5db6OKOgPWaj/WJHkFxbO+5UGncia2dW5eGel4RxRi6KPmaMbQ61NCG0KOJMtmcjLOGkoHRmG3p5Kfc0LXb9N03Hw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS1PR04MB9360.eurprd04.prod.outlook.com (2603:10a6:20b:4da::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Mon, 26 Aug
 2024 21:39:32 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7875.019; Mon, 26 Aug 2024
 21:39:32 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 26 Aug 2024 17:38:34 -0400
Subject: [PATCH 3/3] arm64: dts: fsl-lx2160a: include rev2 chip's dts
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240826-2160r2-v1-3-106340d538d6@nxp.com>
References: <20240826-2160r2-v1-0-106340d538d6@nxp.com>
In-Reply-To: <20240826-2160r2-v1-0-106340d538d6@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724708357; l=1919;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=PIVUh4mo86LjWwqpLBE5dlM+D4iaxoH2rYfkuU3+e6Y=;
 b=Cv6IN6+jodgEi5H33xdVSawQU51EF5TD0tePewc14ahE8v7ExZiaGkJGOG0iVmZe89wQMbpsF
 jyIZxaj/IU3BymkVAXgMQvQJZPB3Hc0Rnqt8YHLF7ZdPklyQ1rV0EC6
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
X-MS-Office365-Filtering-Correlation-Id: 1884c5e3-57dd-476c-070e-08dcc6179259
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cGhGRjk4a01RWFRrRGc4N1NZYnZONHpwK3pyc3B0WnRXQ3Z1Zjg5MzRVeG9z?=
 =?utf-8?B?cFVOMHJEM3hUVFp1WU5XVGtwMkc2SzZhaXFFM0VoVVRpc2tOWGdqeDcrbzRZ?=
 =?utf-8?B?bEVZRnd5ek5OY3JPMFVkUnhOSkhxWlQwMVBzdi9LaDlPRTdob0ZLazNnZE54?=
 =?utf-8?B?L1gyU2ZzNllTM0pPTzN4QlhLQTlLYnJ3T3VsM3FONGdOMlVVMHJvcTNQM253?=
 =?utf-8?B?ckJMN1RydVZqRG93Sy9YTXpEMkFxT091eEJpR2VyaVVEa2YxYjJjYW5uR09K?=
 =?utf-8?B?SXd4V3JBcERDZ0ZSc0REMldJU0w3bGI5UGJhZS9aMjExUFdPVVFjK2MwMjFS?=
 =?utf-8?B?OXZ5QWdPRDR5TzFzT3VEL1VEM1ZRVFExNC9JU3hqZ1RFK3VqeERnUEpkNDV3?=
 =?utf-8?B?Vk1JKzMvbGlzbDczTndJOHlwSUJPc0tiQWRsOW80Y0VBUUw0c0wyWnY2WnRT?=
 =?utf-8?B?a3F3ZXlIdmJTY0w2YVByeHJnTThnS3lzbFhUYnNLZEZMRjRyNVNhaHdrQkhj?=
 =?utf-8?B?S3dXWTM5Nm5nZldLbGZPaW9xUlBKOFRDYnB1NGRIVnV6ek5UNmk1dUtmZk90?=
 =?utf-8?B?UXNlTGFlU05zc2plVmNuTlVMeHpiOVNxQU5PYnd6SFl1cW9Ld2ZPRXFDcHNZ?=
 =?utf-8?B?cG9jenVpMUlmSWRUaEl5REYwTk1kWDNPTTVxeEdSV2NlVGdxbU93dlVnZ0VT?=
 =?utf-8?B?NXlSRGlSZnF1TjhRd2FLMzNJT0RSblRwWDJzOHV5ZXpvU0hUcVhOZ3AyN08y?=
 =?utf-8?B?S3FjNk14N01ieWppS3VJN3RpeGgrcTFRUGZiSFhNd2ZEdTNIY1p5NEI5VlRB?=
 =?utf-8?B?UFpFN1dXZjFXblBFMlJVNHZSS0xFTVBOUGd4SUVWdkxJMkoyR2pTV29MaWV2?=
 =?utf-8?B?dTVxWjVvWk53NXNHaUhadVVzZ3lNaWtVWDhnTjJsMXJHMUVWUWQwbTFCSE16?=
 =?utf-8?B?ZUl6U3hqM0lKL2pGc01QalBBVnNwR21VNkVXaCtWY29NVWViTm9mc2lyUkdP?=
 =?utf-8?B?ZUtCMldjd01Zei83bDRRZXZWZVo3YjMvb045MDVPZldZRXQ0elZ4eXJhTTZS?=
 =?utf-8?B?TGJPb3FXLzhFN0Uxd0pud0dLc0lFZHd1ZmEvUWxxbTU1MWdjK1NvUmFtWWQ3?=
 =?utf-8?B?T2c0ZXRuM1UxNGtPai93b0hpU3QwbGNmMG9PSjc5b0dkbWptUm5nYTJPUVJi?=
 =?utf-8?B?anVrQlB0V3ZXYm5tbUJCblBlU2VSbDljeCtYTWUzMEwrQXY3WmEydEZTM1Zn?=
 =?utf-8?B?aURXSmd2ay9DNEQyblBhcDFIaEdoc1ZjeFFqVExkNlVUTTlvd0IzNnhuUHli?=
 =?utf-8?B?bnNTVm5kak1kZFBCd0I1cWQyOHdRb0lON3hmMHBtSkU2WUtkWmFNeWtBNzBu?=
 =?utf-8?B?NWNLdlZsM3J0UEZzQllpcTd2T1BFaDhVSXZsVzNxNzFoTTduZFlFQVUrVG93?=
 =?utf-8?B?ZVlSWUVGQ2tNUEh2ZnByNUREVEdHa1dVNmFFNVpoNERWL0JyMnFjMzJjbFJa?=
 =?utf-8?B?bjZoelo5VHluMkdUWFhoMHcwanRJaXA3dEJjTExkMDREQWZXUEIrc25tUVVD?=
 =?utf-8?B?Nk1xUXJBTElNa0VyL2xUS25HSkhrUXRCSFk2YTVmb0FqbWJwT0dieUhSWDF4?=
 =?utf-8?B?SDdXRkthQXZIelh5eUtaZHN6V2s4bXVnb1gzQkZtN3RDd0MvTnpBQUlHMm9P?=
 =?utf-8?B?eWZ5d0VVTW9CZ3BWMlNHTnZaV0psZVZjOFZRTGNjZkhiWFladTQ1SlB2dEI3?=
 =?utf-8?B?T2xxaUprUnhDeG1oeWduck90QTlvQjNMdno0SjBySGJKVVRpYUlKSG5idjIw?=
 =?utf-8?B?dXpxcTBLcFBENkVuSWkxOEpVa083VDRSeTEvZ3Q4Smd4QW9IRExYUktpcFEz?=
 =?utf-8?B?MUxSNm16YlF4TzhURjIvajBNcWZ3cmkvckgxcThtcjZNa3c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aFBpRlVFKzZvRkhmdThwZ2NMZmZPZDRUUUxQbUcwdHoxQW8wNEphVzFHOEhk?=
 =?utf-8?B?Y29LM1RJK2tRNytpcHNBRWg2NkllWU80Rks4T21kYTM3bld6aXZINDhKMmcx?=
 =?utf-8?B?UHZLZks1clNBRTdqbXo0N1FwV3VWWUd1c0tobXorTFdLTGplTUxKbVIyU2po?=
 =?utf-8?B?bnpNdEk4MngxcGQ1ZTZNT2s5R0o3MzZpUVpKaGtidUlEeHc0cElmSmVkSXdE?=
 =?utf-8?B?ejB4VHM2aDRSTnEyeFVCd0RPU1RqTS9SV0R1bUQ2WDNFcyt0aUhLc2padlRu?=
 =?utf-8?B?OXQ3ZXB3TWpMM1k0RzQ1aG5sSmdKYWRRakQzWENGRTdHMWJVeUV3MndCR1V3?=
 =?utf-8?B?b1RCckZ5WkdxdzIraXFjYkxubTZYVnh0RDN3b1IyVHVBUWtQK3pQbnM4YlMr?=
 =?utf-8?B?d3ZUU2Ixa01YUkd0T1NMZHY0dGs4a0RnSExLNVNkUEc5UUpBc1NtdWRKNjE5?=
 =?utf-8?B?MG1CeUFNWXoxQy9mVWtlL0JUaFZjWDdhMm1lNDVMSEM5bnl6YjVRd1RDVTZ3?=
 =?utf-8?B?THNwVDlJUnE0N040UXJZN2xGRk5zWlNnazZyc2swMzlvVDlWYkRCNE0zYVhN?=
 =?utf-8?B?N1Nuc2pCZW1zNkYxV2JrQWpwb0lUbzRiMmxxeHdLKzk3OFhvVmhLVW1TRkpU?=
 =?utf-8?B?RFFrUElkZVJUeFUyenFyU0hLM3Q4NGdBNTFpYWFkVHF4SWNkMUhldTA1a2l5?=
 =?utf-8?B?SzZJSDRiQmlweWNiVEpITitlVWl2ekh5d3JoTTh2VmwzVDdUR1NmaGRZenph?=
 =?utf-8?B?SzJPM2w4U2FlN2xZMzQ5SXJMbUR1NE1ZVHk0T1lrdjJnQ2c5S2JJZWU0K2Zw?=
 =?utf-8?B?aGxwcG4rK3YvUmpyS3VnY2ZQWVI4SGl5Z0VUdFc1b2JsZDZBdnI3RmE2UzIw?=
 =?utf-8?B?WEhtajJTMUlOc3RKeW1qSUF3UnFackRFNVBxbE4yWmtwZDdoNE9CKzdQaVN5?=
 =?utf-8?B?OElmTno5WWRPRUJUOG1YRFo0cTVCeUpWdm5GV0RwVXovK2JqNHBuVHJLazE4?=
 =?utf-8?B?WExmNEJxZEpjL3hpa3A5RlEyUDN1WmJveGpOWTRMZStxSm8yaGtNaVJvaG9m?=
 =?utf-8?B?N0lsMFdHdTZlUXRiVE1jK2VhYjA4U0Q0UkxTczNVaTBFbmVzcnRnN0EyblpW?=
 =?utf-8?B?Yzc3SU9iUm85QUVjTW1vd2lkQUZaYlBmK095bFNTUWR3V1hNVzR2cUYxK0Vy?=
 =?utf-8?B?VUFWSmpXeVJaODNaQkdMM25xMSt0aDlzd2pxUU8wWkZtQytJSzM3M2x3MjV0?=
 =?utf-8?B?MjZ1QmFLeXNaYVpMQkRrS0tMeHdISmdMNFZPYUxWR2xyVktzaHp3UUNDdFcw?=
 =?utf-8?B?UG05N2RtcCt0T0s1eXRDQ0c5VmF1UnRHRnZMd0NxRGNoK3NXK3ViNGtRMnRO?=
 =?utf-8?B?MFRmYTlVbkx0Z0V3clQ2dEtaNFNrMFljZFV0cGJuTHJXS1NIbU5HSjY1b0JW?=
 =?utf-8?B?SnNSRS9ualF4VjVmNzE0Y2daeWt2UmgvSGhXVTJXQm53WENsdGxLTjZkcXl4?=
 =?utf-8?B?SlFZOUxENWJ2ZlgvOU05SVBUdHlhSm5hWU1LbVhPbDZzNm9ibGxMaGFqNXFl?=
 =?utf-8?B?d0dKRW8wVEcyenFkYVh6ZGc4enBwWTc4T2pDRTJaTkpoRDhxa2p5M3V3ekhq?=
 =?utf-8?B?YWJPN0VyeFhJQ2s5QkNzMEhvb2laemdlL1o4Vmh6RGlDWDFabzhRNXRGUmlU?=
 =?utf-8?B?b1MydkZtMTZZbkhKUTU4K0luaW1IRVJwMHp3Y0FHOEx4aG0rNXlucndtWUhW?=
 =?utf-8?B?STk4NFMwcG53R004eWFZdDhXM0F2Nk5DbTB4QVo5bnVSNzBFSjU5YlRYcUk5?=
 =?utf-8?B?MXVOTk04MmN4Qk92b3hhM2dJN0E2dllGc1p2MTJEN1dmYk1vb0VmQU9qK2lL?=
 =?utf-8?B?OG5NSXJaZk5na29xWTZMYk9ocllaS0xBRGtublNsNlBwUFVpc1ZBMkRmM25h?=
 =?utf-8?B?UG01d2tjYmtGUnc2d2NLWEdGN2Z2MnhQcHV4ZzdoNUFqdkt3UmZWdlNvVnZ5?=
 =?utf-8?B?Y3p3Z2VSV000bGhOalRnWWtsVXQreXlZNDN3cm91WFUwdWVJK0IxN2JvVWFC?=
 =?utf-8?B?K2YrV0NUU1lsT2FYRVJ1Z1pwelJHVGxQb0hVUFEzcVFJZlFsWTVhNE5IVnFp?=
 =?utf-8?Q?AgMY5ZhdQIFOqtOfyRNxO9T/h?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1884c5e3-57dd-476c-070e-08dcc6179259
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 21:39:32.2432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dkcj7HGB+D/j4WMTunNoXVluDyZPhfuBHYLSJT25df+wCEp3vjTlUPgKjCw87n342eBR9SEYre3eXMv7XWgAcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9360

The mass production lx2160 rev2 use designware PCIe Controller. Old Rev1
which use mobivel PCIe controller was not supported. Although uboot
fixup can change compatible string fsl,lx2160a-pcie to fsl,ls2088a-pcie
since 2019, it is quite confused and should correctly reflect hardware
status in dtb. Change freescale's board to use rev2's dtsi firstly.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts | 2 +-
 arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts | 2 +-
 arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dts | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
index 4d721197d837e..71d0d6745e44a 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
@@ -6,7 +6,7 @@
 
 /dts-v1/;
 
-#include "fsl-lx2160a.dtsi"
+#include "fsl-lx2160a-rev2.dtsi"
 
 / {
 	model = "NXP Layerscape LX2160AQDS";
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
index 0c44b3cbef773..2373e1c371e8c 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
@@ -6,7 +6,7 @@
 
 /dts-v1/;
 
-#include "fsl-lx2160a.dtsi"
+#include "fsl-lx2160a-rev2.dtsi"
 
 / {
 	model = "NXP Layerscape LX2160ARDB";
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dts
index 9f5ff1ffe7d5e..7a595fddc0273 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dts
@@ -6,7 +6,7 @@
 
 /dts-v1/;
 
-#include "fsl-lx2160a.dtsi"
+#include "fsl-lx2160a-rev2.dtsi"
 
 / {
 	model = "NXP Layerscape LX2162AQDS";

-- 
2.34.1


