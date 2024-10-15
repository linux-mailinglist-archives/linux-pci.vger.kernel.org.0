Return-Path: <linux-pci+bounces-14593-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A28B099FAF0
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 00:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA87A1C2344F
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 22:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82221D63D5;
	Tue, 15 Oct 2024 22:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nxN7KuKY"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013029.outbound.protection.outlook.com [52.101.67.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC14A1B6D08;
	Tue, 15 Oct 2024 22:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729030088; cv=fail; b=C4w+av2ZTlSK6LnQKdozrqLwSFtlCDcqef0IvULb2cc7wg0d/M5g1fdgXZ5IFnOCLG62a4gOGMCbnDTaKjfm7tSZerN1BI0rsPsNON7R9OK/vyKxrK1TO+kTbF7MKufR3+dG05gkdHzbcT5Xf7myOMexiQP2r/FvIR/Ry5LBDyE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729030088; c=relaxed/simple;
	bh=UAeOGcPYB4r9eUK8PFb6MZTw8YYA0IZ33NSNOk8EfxU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=hYAOkenwoa7MC9vww+8eqk47nkAud8jQG84xyjsTIoblIy90vbQTjtVZZLFPktTCIL29ScN7ipxy8c3VHcNuVSm8KzLqP99SDeRrHHBJmzAPSBK2EnUBbMUvYilcNWCdpp7NoJ0G61p5tzK2VrM1mZ4b6VMEPJUilqxDWxtKfYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nxN7KuKY; arc=fail smtp.client-ip=52.101.67.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mM9s9bJMAz1R3sMLJGDRUSFZXyrydEj8M4ztuy3RlNDabdc90u2zhxKJxbh8ZO/zVgeV7QLanRWGM+LG+ltFoDtCACbjxvPCbI1h+8bHUntMXSvR1tbE3Wvkxpdoccpgy5eNTs2vbtD08j+/vjc9fqb4EfHD9xgD8yCVNjPp8eaeVl2TkeCsLUAERuL69dlLTaUXx9Dh7C1TvVWULX0rB6SbjC6nSB6KqWgcUbXnKtQDNTQTh8Y7EU1DMLXlBNkJ0vOKw5ZJaj2tQvp+MxNNJwHZLfCGVM1MooYDS9QvbhbZPZR4zQ3GfkuSdaRuwmzBIQth2/cz2ze6t+D9CwQO5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zr2KqpZqpb5XrDUTkmOe8bdajmgYdiot4oZ3RjQBM0w=;
 b=gh6SMFVlFy4yMma36jmQ+0XwDqMaKTQa824Nrn0sl5ZOjqEA9Q3h+YuguK0Ai9rZ5PW0SCy7SNn90ApmcI4QmWA4YiWJtXbWNizuzHeHS7WNuf/CTlH7uCbSh3d0IgORkKuM5Rss5lvtg3ourOhA83kqdPgndqkqWkjvttCkT0yba2hAcMSgShrocA2DiaUuOvZ7ptZosdvPWyfd/2ZMd+Gchg2BpIpYgCd4Py+vC3vjjhEKJT2vsDkAxMlG1J+6jbE8/ow7+QvzfLzyZRAbCcfuM1fPOxBn8Jl8vrcdMTWiMPCJRZV+pBBolCkOP+/Eo/leEvVxnc2QfNtHsa+llg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zr2KqpZqpb5XrDUTkmOe8bdajmgYdiot4oZ3RjQBM0w=;
 b=nxN7KuKYSnChn2PTYvJR+zduQlNR9YZyZNobm8Vu0f+bJ3jU72mzJPKYZocs65Lrlvdby2UtgqIbw/V6XTil5+1X6J/rTESvOpMJ/Jc/5SfW+O4WAJtrcfBucl+MCEAQ4/605JhNxLFEe2MDe2phhT9QJ0b3eQCjG5h8E/38PcCAB5OWyGLBxjCW2HyuYyI2ccsEgiqiW9kXQ6n6tCtVNUsQK2+P7rNOF9dy+MUygAsKmi7HF6NtY7kaWnHRrAJLarlQPCn8ky2kmqg8dF+pvGJjO3mo/43L8IJDDGHScBsdlff9eWQupxMcHiYHTaDRLPval1ya62kkALtaUdjoNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7788.eurprd04.prod.outlook.com (2603:10a6:10:1e4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 15 Oct
 2024 22:08:05 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.016; Tue, 15 Oct 2024
 22:08:05 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 15 Oct 2024 18:07:15 -0400
Subject: [PATCH v3 2/6] PCI: endpoint: Add pci_epc_get_fn() API for
 customizable filtering
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241015-ep-msi-v3-2-cedc89a16c1a@nxp.com>
References: <20241015-ep-msi-v3-0-cedc89a16c1a@nxp.com>
In-Reply-To: <20241015-ep-msi-v3-0-cedc89a16c1a@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729030073; l=3066;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=UAeOGcPYB4r9eUK8PFb6MZTw8YYA0IZ33NSNOk8EfxU=;
 b=3F6duJQ0TcqVVtPOFL5oV8U1QskUO8PM3H1Gy7/b/4jHvG4fr5KMxRuWupP9aMcxm4cPVOV/F
 Mfwf/Nv//SkAkZtpcfn/hGK1qMFhqUXDzBzPdGCQDHE6V9TbZY1t5Di
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0059.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::34) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7788:EE_
X-MS-Office365-Filtering-Correlation-Id: f5434e67-3416-4b9c-d4ec-08dced65d811
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WnRwMFhjY2pydTdMWnAzQW1mOVVzcmNHbmswanV2bWN0bDhaWVNGUnYrYXZO?=
 =?utf-8?B?eUVUdnF0MG5TWk9Jd1Brb0lkWUlLbzVhLzlrUHo2U1BBbXJPajNMTUFnVHVy?=
 =?utf-8?B?RU5uNkNMeG9CeHhoMFl0N2J4NE0wTW5yQ0dZa3VQeXlHTXBxdXZ1MmF6aDgw?=
 =?utf-8?B?aFc1TUkvdEZEMjJtTUg1K1Rzd3BYR1hZaTgyN1EzSHFEa1ZWVW1TRkRKV1F1?=
 =?utf-8?B?cEQ1WEd4ZU5rV1BuNTlKREllNldPbmU0UHdBek5kbDJzQW5wWW1PaWlhT2RU?=
 =?utf-8?B?eUVpQjJSUnhwczRxRFJJNWpwTEc5cjFVZ0xqNW53V3kvaEI3TktVWUs1bnR2?=
 =?utf-8?B?Z3dHTFlYWkptc1pvdnVHdklmQUdrQk1mT2lzb3BPb01lS2xQTk51cFRlZVpU?=
 =?utf-8?B?d25HMWRTNWJPUW9pYVNkWEM4NGowR1JBK1RCN2dtNkptajJraW5GbFFrYzJz?=
 =?utf-8?B?TDRscWJuY1IyTWtBWmhpbSsyYUN5SCttRXV5MkY0YWo4bG50a21uVWZMWlVM?=
 =?utf-8?B?MWxsdHFxVitJSGE2c1dpSXlKRlZzS21sNWVYeHJWS0Y0Q0N0Vlh1NTQ2Yk9H?=
 =?utf-8?B?M29KakZTWWNWdnM1eTlrYk9HQlNDYitsNEV2UFlvenRScEp4OHVOUWxYUjB1?=
 =?utf-8?B?enZTLzZ2MEhJaWY0MllRYkcrOEhBRDVGdFVTUEdrd0dvdHlDV01MbUw0eHUr?=
 =?utf-8?B?dkZYR1psRXlNUHpjMEV3NXppcm9KV1AvMnRuTHhCSlYrUXo4VE1CakxQZTQr?=
 =?utf-8?B?eW5ZUWVmRDl1Y281T1BWZUNaalE1bUdzTFpMcUVrb1BIeTVoWkh5dmlDL2p3?=
 =?utf-8?B?Z1pwRkJUaThJMTBMWGRRTFBoVE5Jbk44UFUxRVczMi9yalBEakFHcHRIei9t?=
 =?utf-8?B?bExYYkVNYXhWUGxUdUVLcDR6T3Y0OWRpM1hPbnBqMC9CbGhrbXhENVBCckwz?=
 =?utf-8?B?Wmc2NEpPa1JXVTFqQ005eGcrYkFpNHpHb1lJdms3dHcwU2FHQUhnMWF4MzRU?=
 =?utf-8?B?aHNHQ2I0WEI2YWpSVFpTY293TnB4MmhZOXhlVDNFV25VNlEwb2tUR2NsNHZy?=
 =?utf-8?B?MUZ5UjZDQm0wb2pxS3BWZW1iazdLOUgrdUJEb3dMK0JXVXdZNmxnWVNCQnJH?=
 =?utf-8?B?WnpXK2l4akxGdDFwRTAwZWQvK3RtUXVOcmtUWnJUTW4rNGMrc2xxYmJ6dHJx?=
 =?utf-8?B?b0ZITllTNklFZi9ISVQ0M3B1V3pxYllBakNTT0s4VVF3V2Y4bnlQTC9ic1NV?=
 =?utf-8?B?cHd5U0N6cEhUWW1kejRNRUJCem1Zb09jak1iUU5SUk44R1VnZFBxYk1NVVBX?=
 =?utf-8?B?ZXF2OWl6QmIzUXFrM1BhK1pKMURqc25TT1JOd0E5MHhOWmE4QnVPTFU1Vmw4?=
 =?utf-8?B?VkVHNTBtQWZ5UVA3ZUhHWG56Unc4MHcxNmY4VHlpbXJudnc4V1NnRkd1UEpv?=
 =?utf-8?B?ZVRGM1kwdnloTmtpQlg0a1BYZWV1a0luUFRLWktFdEpjUFF3WDh1RzY1L25q?=
 =?utf-8?B?WTFHSlRnSGRaNVBuSXhGekl3K0NQejM4bWR6MHh3M1B4dGNZU3ZHZ1hwbHVD?=
 =?utf-8?B?b3UvbFB1eFJqeTdVdVVuTllySXRTaThSNVVjelUrYTlvS3ZVZFMzNmU5eTg4?=
 =?utf-8?B?cmpScVBNZDEyVVcxZllob0I1Q2tHaXlOTUx2bDZoR2h2SzU4dmZYTjhCZ1Rx?=
 =?utf-8?B?SjNPYmxoUnhjNTJLeFY5ZiswUkNwTFhsWnArb1N6RVFpKzJkTzNrMlVQWU5P?=
 =?utf-8?B?Z0szMkJ5WEZtUldkcll2NW5rd0hLN0ZuMFpxcWxJb0c2T3pvbjFSV0RSRDY3?=
 =?utf-8?B?T3hiZXFFbGU0a2pXYkZDQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TUkzMVpmSFI1MXJJRDhsZ1RKQ2NkMFM2RnhpUzRveVJFS2dRZFRzNWRSanFM?=
 =?utf-8?B?VitneHg4aFJOSDVzRW9QTEdvMFAvaU9GSGdBZk9JVEphQXovOGQxWHZOOGNn?=
 =?utf-8?B?dnVRaW1qMjlFVmVXbnJKZ1JwQTJReHp0Y3R2OGtxd2JINGVQRWdtYVZ3Tkwr?=
 =?utf-8?B?RmJxM0lKZGh6bHFsNnpIaEw5ck5teU1RSmxCdTRXb1BiRGs5S0w4V3VKRmZo?=
 =?utf-8?B?U2R6dkgrRnhjYUNPNFV4eXFOdzh5Rms3ZjdqeGFJSXNIbWwrUEZrem0wYWdM?=
 =?utf-8?B?NC9YZXE1YU5scDdIRHdFcW1yaTB6Vi9TYytseWhEREJKU3JFUVBOSHZJMlZh?=
 =?utf-8?B?ZEJUSXVKMElCbjgwdGIrQ1lSSnJaRmVZWGZGOTRaNkY2N3dLNytpZkFJVkkx?=
 =?utf-8?B?N3dYeS9KVm5SMGJBS09uTWtVVmQ2V0M3VldMbG9qb2xMbWlyMjNiOG9mVEVi?=
 =?utf-8?B?akVYbyt5Z043enRVc3VtN3lGSk1GVEJVbWNkaVEyZWtVZndzaTVTMXh2OVE0?=
 =?utf-8?B?THY5ZWdYK3VBWjVxbFo1NVltTmFsSUg2ZGxTeU5KVE9NNG9zQjkwLzU0TzNu?=
 =?utf-8?B?Vy9yamU5SlFjQ01BK21wNCtrS0RiOU1Uck1JWGZiaUFJdlhQNml3eXowUUJi?=
 =?utf-8?B?TnZ6My9rU0xhZHAySVdQSUc5Snh6WjFzUlNKN1dVUWNuMjdWakdYZXBIOEc1?=
 =?utf-8?B?dXVUcTQzcWozWnYxU2RUc3RrL3BtVXV2M2Z0R2ZFZmVFYnJVVGNBeUI4b2gr?=
 =?utf-8?B?dFFCVCs3TnUvZTRiTjYwUFVFbnhkR0dtaCs1WklwWXNpUUxWTTJrTWNjVkdX?=
 =?utf-8?B?dmRVbktsTS8xaHpFUlJZMHZCaWFnN3Rkb2huTFg2Wmc4Um01NnQ4QjY5YVc1?=
 =?utf-8?B?RSt5eXFzUURxa0VxU0R4M0V5YWJtaGtpQ3dtc1BtZGpYUlpZRU5nNzBPRmpI?=
 =?utf-8?B?OXVwUW4vVVdxdnhjYTVXOUZMWHVsa1djMXNTQ3h0R093eXd4OFgzM3c0MUk3?=
 =?utf-8?B?RHBtUkYreXNWNitnVE9ON0YxRFRwNkk0c3EyakNTSmZpWFpLT09Jb3FNYUhB?=
 =?utf-8?B?SzJ2M0Rzdys1dnNmOURDTDBUcmpGVW1OZFVMUExpZzYxZjhhMzVwNWkvR0Iv?=
 =?utf-8?B?OE1GN0VPaGpXRUNhQ2paTzJveHNCTmJhT21jcE45VndVNzdsWTZKWHRmQ0ZZ?=
 =?utf-8?B?ZkxrWmlTVE0vaUNaekN5Yk1ldytLQzhFMjg2alRzWmZBemtCVHRuSDRvaC84?=
 =?utf-8?B?ZFRJSFlrbXNxeHZ0Um5MRndPaWxMbWJRYjVIVWRHckpzdGhnWDJ3a1M1SVhL?=
 =?utf-8?B?Zjk0U3RIeitSeGttZVFzYy9KSGR3Tm0vT09rRnA0TXFra0xZNEtYOUlWbzFj?=
 =?utf-8?B?Sm9GY2tsSXJKM2JXUE1hSFp3enBZcTVnbUxqbDV3Y2FzcGpXcnFWL0Z6WTd6?=
 =?utf-8?B?cXRJakRSd0xzaXAvOHlONGdQNDQwOWtjaUxUT3dHTkRndVEvdjM5ZzhSeEt5?=
 =?utf-8?B?UXUrcjJPMU9JNithaHg1bzRORHJTZDhiRGw1MllTU0gzd01QQ1J2ZGdpOElN?=
 =?utf-8?B?d1RUWWlnR1RsOGZkNU5pLzFXMGY2MW5BOUlJb3dDTmU2OFYxUGFLdjR6VEQ2?=
 =?utf-8?B?ZXdWTGRQTU9TR0dkV0QrNlNOTzQwR2lCNEJlMkRPY1lCL2VQSitkUnRFWDVw?=
 =?utf-8?B?dGFMVVAyTXJ6T0pVMWptSmU3L01RUkx1U1BsbjJ1TStKNDJlNXZRM21Rc0Z4?=
 =?utf-8?B?YzhZMmhCamEyNnhiZXcwQkNaK0ZXZy9EN3JuSC9wejkwMTVsVHk4NjRGU05B?=
 =?utf-8?B?NWM2V2ZzZUZDN1p3dURDTXBrTmdTZElGYThxQVAzdCtNd2tJak9uM1l5SWFS?=
 =?utf-8?B?WXdxd0NheFdVRmgvaytLVDNnbXp1cG41OEVmSXY2K3lyZGNiZ3hMNFR6Ri9H?=
 =?utf-8?B?L2FnbUhRbzFRTDNHcVFGZ0JNWlpLSWxPODV4WFJNZ1lDbFhycVl1V0dYdVZ4?=
 =?utf-8?B?YVhRV2RpSjJ1VDIyN3dwbGd5OEE1Y0pWdGFHTCs3NlJ2dDJPaEI2RmZtRkJq?=
 =?utf-8?B?bERHUWRpUmRnQ0NNa0hmODhsWEl5UDFyOE1rTk5mZlAreVFCQW9BWlY5SGdI?=
 =?utf-8?Q?YgPQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5434e67-3416-4b9c-d4ec-08dced65d811
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 22:08:05.3419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1zUJIOBKA94J9XelJrZMX5hCCdpoQXAJjgBxZ/mfBvkeehhEc8mqkJPbj4EHxQxeVHC9EgqoKOkPm94SiBZgYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7788

Introduce the pci_epc_get_fn() API, allowing a custom filter callback
function to be passed. Reimplement pci_epc_get() using pci_epc_get_fn()
with a match name callback. Prepare the codebase for adding RC-to-EP
doorbell support.

Add DEFINE_FREE(pci_epc_put) to implement scope based auto cleanup.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/endpoint/pci-epc-core.c | 23 +++++++++++++++++++++--
 include/linux/pci-epc.h             |  2 ++
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 17f0071092550..14e6011df4b2c 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -48,6 +48,11 @@ void pci_epc_put(struct pci_epc *epc)
 }
 EXPORT_SYMBOL_GPL(pci_epc_put);
 
+static bool pci_epc_match_name(struct device *dev, void *name)
+{
+	return strcmp(dev_name(dev), name) == 0;
+}
+
 /**
  * pci_epc_get() - get the PCI endpoint controller
  * @epc_name: device name of the endpoint controller
@@ -56,6 +61,20 @@ EXPORT_SYMBOL_GPL(pci_epc_put);
  * endpoint controller
  */
 struct pci_epc *pci_epc_get(const char *epc_name)
+{
+	return pci_epc_get_fn(pci_epc_match_name, (void *)epc_name);
+}
+EXPORT_SYMBOL_GPL(pci_epc_get);
+
+/**
+ * pci_epc_get_fn() - get the PCI endpoint controller
+ * @fn: callback match filter function, return true when matched
+ * @param: parameter for callback function fn
+ *
+ * Invoke to get struct pci_epc * corresponding to the device name of the
+ * endpoint controller
+ */
+struct pci_epc *pci_epc_get_fn(bool (*fn)(struct device *dev, void *param), void *param)
 {
 	int ret = -EINVAL;
 	struct pci_epc *epc;
@@ -64,7 +83,7 @@ struct pci_epc *pci_epc_get(const char *epc_name)
 
 	class_dev_iter_init(&iter, &pci_epc_class, NULL, NULL);
 	while ((dev = class_dev_iter_next(&iter))) {
-		if (strcmp(epc_name, dev_name(dev)))
+		if (!fn(dev, param))
 			continue;
 
 		epc = to_pci_epc(dev);
@@ -82,7 +101,7 @@ struct pci_epc *pci_epc_get(const char *epc_name)
 	class_dev_iter_exit(&iter);
 	return ERR_PTR(ret);
 }
-EXPORT_SYMBOL_GPL(pci_epc_get);
+EXPORT_SYMBOL_GPL(pci_epc_get_fn);
 
 /**
  * pci_epc_get_first_free_bar() - helper to get first unreserved BAR
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index 42ef06136bd1a..682808f4510be 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -266,7 +266,9 @@ pci_epc_get_first_free_bar(const struct pci_epc_features *epc_features);
 enum pci_barno pci_epc_get_next_free_bar(const struct pci_epc_features
 					 *epc_features, enum pci_barno bar);
 struct pci_epc *pci_epc_get(const char *epc_name);
+struct pci_epc *pci_epc_get_fn(bool (*fn)(struct device *dev, void *param), void *param);
 void pci_epc_put(struct pci_epc *epc);
+DEFINE_FREE(pci_epc_put, void *, if (!(_T)) pci_epc_put(_T))
 
 int pci_epc_mem_init(struct pci_epc *epc, phys_addr_t base,
 		     size_t size, size_t page_size);

-- 
2.34.1


