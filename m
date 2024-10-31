Return-Path: <linux-pci+bounces-15733-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A861A9B8013
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 17:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CDD81F22489
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 16:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB75A1C7B63;
	Thu, 31 Oct 2024 16:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ht7dQOvC"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2045.outbound.protection.outlook.com [40.107.21.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D061C57A0;
	Thu, 31 Oct 2024 16:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730392051; cv=fail; b=PJcXyIXLSeuPahNQrAKRtJpIi0oMCyRCgreYwfFwEwwjumpVrFAjx1RqdlgpEikKL8VnV3/um67X9UZLmHTRjD1nI0oFtEqjRBTrTbvrGhzdo6+AUJV5gpobIs2kH2FZwzFbW2YUs+7D5johtoSLIZ+xWoqGoGRvA1iR98iM9rI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730392051; c=relaxed/simple;
	bh=86w1a1XMlWfuSdwPQdmN0jUXDLe71oOcpkgioiRNwn8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=iIR4jlVTToQtbJBpYe2iDu9vBj2eE7HrpvdxwqO4vetddsYMBf54otP/7g9Mub+7ilqIhDJf+5u4FjyBQ8goDftSftk5qKfJUB8IJ6Nw6hMuu4k/dZlVeoh9hTdD0XyeWakNVsLetWeHfeFpzy3WweHXU8XDBtFZd/RdAYQCONQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ht7dQOvC; arc=fail smtp.client-ip=40.107.21.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cF6HEfjo4H0D9XuIfEDOesG5ZjDKkkxwUZflaUYzT5CzFxd9yrL2KPCQX/6CkDliwXMfkakOI9qN+70bkHRa05A8T+9C/oVRabJbn8xoYTJeevvROSqWS/dljvjFXk75D54gQxdIcstE8BSeTBdX699GKdsoQkVWfOoqVaAVTLeDaIX1D/G9i4k36xI5LQXSAt7GteQIO/EKihl15pkI/wWbHxKmFGtIgy+OFfRcEWfJOn+HOrCOwbIGbQoMKAdKZ3dKj+bQznvxCS0BsGGB+Os0s0l1NWk8L0icWvSWxgIdS02ldkpBEZOZCVmtTkZ2eeqpdhPpRHL5+uHUfnMuog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3cvWynPFHPf07oWxi8rpPdNTX2d96vmSUu2BSeQ+qNo=;
 b=cpmAF6tv3VRU2PWPl0zcZ3tqp49idxdiV7zlmXUQ92td/4Tn0lvkgg1MO3Js+7UbmrXX5bS8JNBR6AerF1nPpq90hXg/k4McNY0sfNqdNMCHQf16RYuatNzmSHegl+lOKT8vjpeAjQCnQMLElbjLdlE39gtMvpfhqSMIBRFjlYk/t+slS+LOUfQBlpz68y4nIRMZWdll7q2pEhEDRgvGA6Cvu4gtSQFC5ms+P9uan/cF8B0TiLGjI0TJzmG4dmSSn1yffUQL1FzbHHjBz94gCTFZPCDzZdxtlahH2mu5HN0k+WB3QBQQ3QCKMNfJN39EsQmIOHmI6DVI62dF3zFRgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3cvWynPFHPf07oWxi8rpPdNTX2d96vmSUu2BSeQ+qNo=;
 b=ht7dQOvCWErj22QXpnKF2/zKboJSQnuGF+KSrAZqRIdPqlMTYSEwztgy69Jax/xFe7TNkDy39VBZ79i7Y60nUL763I08Fsn6x9WoToNL+DNSMg4Oz1xmBHEsT0Bkr+b4egnJBG96a9z6dxwd0N+zav9K39BRrJCXGgvxAn9IggfuNUAHq6Bf8RWx/n39jHQXF3Jln9u35GRaaTHwRxinoQKcfoAViqeIRzivJzus7h+tvYJhb8nboZI3c5Qfa5Ecksd5tQwtFL+5kZwy4Ymv3yjneI4VfJZTTQSWVStguQkq9eMevcZz06t99MKLzjrSeiNX/a93AtEbqV6U4zuh4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA1PR04MB11081.eurprd04.prod.outlook.com (2603:10a6:102:485::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Thu, 31 Oct
 2024 16:27:20 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8093.027; Thu, 31 Oct 2024
 16:27:20 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 31 Oct 2024 12:27:01 -0400
Subject: [PATCH v4 2/5] PCI: endpoint: Add RC-to-EP doorbell support using
 platform MSI controller
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241031-ep-msi-v4-2-717da2d99b28@nxp.com>
References: <20241031-ep-msi-v4-0-717da2d99b28@nxp.com>
In-Reply-To: <20241031-ep-msi-v4-0-717da2d99b28@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730392028; l=7322;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=86w1a1XMlWfuSdwPQdmN0jUXDLe71oOcpkgioiRNwn8=;
 b=Erbraa3lsZzknZGivE+84oK60M+flb/gF0e77hX/NWhTBmb/4Fv2V9SDcue/dnaM6Yr3otQWY
 Nj8ux8LJNtUCL+TTzRHEDBJSc/BTiSKVg3NyDMucbA62MPprlfnikLM
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR08CA0056.namprd08.prod.outlook.com
 (2603:10b6:a03:117::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA1PR04MB11081:EE_
X-MS-Office365-Filtering-Correlation-Id: fd943788-ace9-494a-cc8a-08dcf9c8e44c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UERmMTJES0ZYcjU0RzVQdno5cTIrZWJhTnlDQktyalhqUXp0bHhJNDJrUUhl?=
 =?utf-8?B?WXZ2RkRwbG5UQkRhQVRWdkk2VEt5RTM1blBza280WVAwN2sxRjJCbzlJcmhR?=
 =?utf-8?B?MG1IYWwwTXM2S1YyU2owOTUzZ09HK09nK2s1N1MwR3pBYlhHK0lTbWpTWjFN?=
 =?utf-8?B?Q0Y5eG0zL2p0R1VLZi9nSnNzWXNFWHpYZWs1Wkx3N2N6VlhyNnl5QXJZNHRC?=
 =?utf-8?B?NTVSaWg3MGpKSGFydm5wYmZEaGRUbDFHWTI1VE02UEJuVmliTm1TWTQ4a2g1?=
 =?utf-8?B?eUNSMnRtKzVFSndLUDFUa1RBcEpOSVFRQWhqeG9yQmdhUFN4WHRjdHdvYXU5?=
 =?utf-8?B?VnpZSTdBVWpZWDU1VzZDaG02UjVmaUFGbndQVU53aTFKcFRzaEJIOHB4TlFj?=
 =?utf-8?B?dHp0LzJleENjalpjRkIzODIwTXhnRi8wSXBUYkdqTVA5UjBNR3U2amFSSFFU?=
 =?utf-8?B?OEhmdGxDVVJueUxKV2dFekVKZEMvTXZLTExRelJWVyt1OXhXMnhxcDFmeFRX?=
 =?utf-8?B?VEFVSGxoaXEzcjBZcTduNWQzZ3U1QXBkYUphRU5HTmU4UzRnM2ZqaDcvRitX?=
 =?utf-8?B?RjlIOWgvU3EydnVucStqVGN6MkhVekU3VERsUThIS21raEZJTE5OSG1QaUVa?=
 =?utf-8?B?VGZBTnpPMUJPeGY4OXY0SFZRdGozR28zOXMzTUNhQitmSXBVY2NBT2VRWkNp?=
 =?utf-8?B?ZjJiUXRHb1A2YnY2QlpUZW5Ka3l2aVdESGtlWk5mcDNSb2UyMWphQk95eVBX?=
 =?utf-8?B?VFRUeVFHUDNjY2VJZUt4MkRDK0IyRzFMYnkvMWI4TE0xQnh3V1c5ODErYmUz?=
 =?utf-8?B?Z1E2bGZNUjRtYzBITEdpNEJCeTVrWmtpWm96R0NRUHpCWFBGMmxVazBTMWRX?=
 =?utf-8?B?ZzhEMlU5Q2dhQ250ZzJ6UGpIc2Y1UkJTTHljbXlySzJ0akphT0tmeVF2L1c3?=
 =?utf-8?B?ZjJyek9reWl5bTQrYWtLNkZISzJleTJ5cnh3b0JGS0w0YVFlV1NNYkJIcjNK?=
 =?utf-8?B?T2xtMnJ3L1lIOGZIa25JYkNuQnFSL2tZZk5kVXg1VkhGMG83dXBFc0hGOUk3?=
 =?utf-8?B?b1BkNHVnQWhGUnNCZm1qMGdNU2R1LzZCYjNGOWJaWFE0Vnc5clNwQkdIeVhN?=
 =?utf-8?B?bkE4T2QyMHJjNmVockVLK2tYS2VVczdkSGNKdVZtdGRvQXJOSVYvbk1QTE90?=
 =?utf-8?B?cEhtM251S2lpTEV3SmhUTVRISUtobnhabzRKd1paUjFYVERxZm1QZkM4OURR?=
 =?utf-8?B?R21Fb3poUVczS21sTHBaKzdjbHA3b3pidkJGNEtJNEtnbENHbHpYS1p3bUNN?=
 =?utf-8?B?bkVTSmhFaGpBc3VUSTZCZkZXTVkybXpuL0ZIdUdBWFJTdUtCQjEzbmZZaGcv?=
 =?utf-8?B?U1hrZEZLaGNGT09aMDV2WitGODI2akJyZHhoYlgzRGltM1Y4S1hERHpjZTc4?=
 =?utf-8?B?U0lIN1JJWk9vYllFemYzUFpRbDZwdmVDK01pUnZOTGNWSzBRUnh1WUxtcHV1?=
 =?utf-8?B?a2wwYnVabVR5c24rTGZRQlZYT1hBTW1CT2tRUEg0K2ZsNFBSNWJuaG9PT2to?=
 =?utf-8?B?YklFK1dvSnhBNHFlUEZ4ckR1R2s4WjcvNjhzUHNMM3FWd2FDdXllVE9xZ0Jj?=
 =?utf-8?B?TlVQdjAyV2Vram0xeUpRMGx6MkdnYkVqZUpBaStCYmdxNHJxMWFRUWU1d1lO?=
 =?utf-8?B?WXNVajZqV0RERC9SQ0FHcjFaZXlSbnY2c0xWcmZIRDJmaTZGWXFDWG84Y1d2?=
 =?utf-8?B?Ni95K0Y1WXF3QmVRcXdyMzIxRVp3NzhjOXl4VWx3ZXNLMjVvdGxxelhwV1A4?=
 =?utf-8?Q?FOVbjg0Z6cvvafG3NFMdRGhAVUvM5rHe7ClnM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U1ByTGFKVG44Qnlxc2JBVm9HS1FqamxPdFNhQjdwZnRZa0ozMUtiYTEvVmJV?=
 =?utf-8?B?Rnp1d1JjM2VsaUpLdUMxMStmSHFOQzdIeU05a0Zqc0FERjJZc3k4MGZxazc4?=
 =?utf-8?B?MXNYbkRTQkVhYlgvYTliNXRvY2xHY1hLVTd6cEpLNERqcUorbHAvWnplY0Va?=
 =?utf-8?B?OG02MnZLOXpWcnZZRWZqcWhTb0dubDBRekY4bHFLdE5SRmcweFRFb2ZZVlpC?=
 =?utf-8?B?QmVjeXI2VHFUMEhFbFFwWnFrd2NJRG9Pc3RhWUtxSGNEdW9EenVIc3VsWjI4?=
 =?utf-8?B?OThjZElsaHAyY3krZGhjUm9oazNMcXRDUlllS3NoL0tjVG9tLzVCL0pCY3l4?=
 =?utf-8?B?b2ZJa2ltdnBrMDB5NFcydU1ZQjBvcTVFTjhTM21RY3gwVWl6OFFtWnI4OGFi?=
 =?utf-8?B?MWhPNFpHbEZqUTlSeUhzSVQ2TFFmekNLWTAzN1l0bHU5Q0lmaDdiOEFOdmZz?=
 =?utf-8?B?cWV1MThYWm9vOVRQc0NZOHFMNXQ3S1FJRllmelF1WWtvVVZlUEE5dG1SYTVs?=
 =?utf-8?B?aXY2bG9BZ0hsdHZCTElGSnFKOU5obS9zZ3QzYlpKM25QM21qdVp3YXh6QVV5?=
 =?utf-8?B?WCszT0tXSjUzN0ExQW1BOFF4R1BKZGpHbWN2OHJnRExwVDNVYlY1eVRaOUNn?=
 =?utf-8?B?UE1HNXF0T2VyRVJteUlhcGdVOXMxa2loNnBKalFsOTRPZ2xubGkrQmNkSjdT?=
 =?utf-8?B?UVRJM09nVjZEQVBHNGFYYlp3K2dCQ2NYSXlpU1UxYmxsNVdPbzl1SzczZ3Fp?=
 =?utf-8?B?YXk0REpORisrWU4yd2QzV1d1Z3BGU3E4NWVZTTBwanFneXZGdDV5WUJ4SlBj?=
 =?utf-8?B?dFlncU1yL0swQkx3ZXF5WEwvQy9uTkRZWGUyK1pBcUk4RDBWQis2TVhCeWZN?=
 =?utf-8?B?bWFxZit3eGxkbEsxRFcrS0hiOXZWbHBvNUlqYXFLV3VqaGVJUEc5cVNhMFM1?=
 =?utf-8?B?cXArb3BhV3pKTVNwQlB4aHZFL1JnMEZ1MWswVENTMXVKUmVtaWNwdVlVNE1v?=
 =?utf-8?B?ODZXelNQdy9QTDU1Wm9ENHhDdjBCNllzOUdlc2ZjcXlZR2Nha3BIb09oZS9z?=
 =?utf-8?B?NE9UMXcrUHZjdEJEOWM0MkRjSGFsWE9CMDRmMUpoUlhpTzZjUGVoUVFtV2Rm?=
 =?utf-8?B?eDVoNkxwaGRZa3pCVkdzUng3UVdzTHFOUHhHU3hMQ0tjKzEvVVZISTBVNEpq?=
 =?utf-8?B?eVh1blNPaGZIMElPZU1pb2R4dUd5QTNwc0ZCdVBPM0FwcG4xbWdpaDNFNUEw?=
 =?utf-8?B?Y016eWxsRmE0OEV3c1pBNnpxei82L2xzejkvWWJJZVM4R2FlMTUrZlBVZW1P?=
 =?utf-8?B?NGpVaXdPU1VsR1VGaUdzRVU4TkJ5dFliVjA3ekpxbndZUUZxUkI3YWxWUDdv?=
 =?utf-8?B?QXJZc0I0aGR6eTBKTjNHZVFqYjd6VGkzUnUzV21uKzJ1ZkNxVVZ1U3NVK2VD?=
 =?utf-8?B?RVJrS0tEaXNMdlBjcXRIZ1BzdjNGdWFKd1A4Z0dwY0ZwS1ZXY05SaTFIbThZ?=
 =?utf-8?B?Q2xrSEJ2MkJIWitKMUJod01lYUVPWVQrc012WE5nUk94cmJtMnA3L0RtVUJx?=
 =?utf-8?B?YmFDS0JUN3BMOC9HS1RCdU05cXUreVkwVWVFbHhCbEx4bVJJUGJFM0RyTDB2?=
 =?utf-8?B?OTJBdVFKNDZGM1NremRHTUFacTZEeEJzdG04cDVJaVVES0c4V2hwRlhxMlZD?=
 =?utf-8?B?YXZzQk56NUlxenpickdvdnUrdUpuaXlFaGxpYmZpcUpUa0FYRTRNT1RiOU1z?=
 =?utf-8?B?VEU4RjN0d1pGMGdaSmRoeDQ4d2VBWWpGQWx4NnNyQ1o5aWc2ODY0RG15WGNt?=
 =?utf-8?B?ckxZMUQ1bGlGM2tyZnRBOUpXb2NJd1pJS0M4ZkJDZUpXbi9zUlBoZDVrSHhC?=
 =?utf-8?B?Y1BjcTFqbE9KN0lSQmE2L1RMbnkwZzJiWnBEZy9US2NCaGZsU2xOQzZ0QlBp?=
 =?utf-8?B?a0FpdkZERVJ1alBSeXd6bExLaTZ4aWx2R0VVNUswb1FHR3VtSks5NjhZRC9O?=
 =?utf-8?B?d29UcEhIaFpTeGt1K2NCVytpeFlNU25EbDR2WWtiU3Rkdmg3SW80S1RWU2xU?=
 =?utf-8?B?MldlZG1SaVgyaXdpbVhiVEUyYm9aMkRJUEVyRjVLZDFwRHJKeUptYXZuazJL?=
 =?utf-8?Q?ALtY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd943788-ace9-494a-cc8a-08dcf9c8e44c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 16:27:20.0550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YLxwMhjvEXGTZP4T6hLcaYhnFKI8fZqNPBGpEoMGDbBSZNFaXWNsPyBAm9/1K4eJ5A9IWOwM8mon/Lyi9UMfzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11081

Doorbell feature is implemented by mapping the EP's MSI interrupt
controller message address to a dedicated BAR in the EPC core. It is the
responsibility of the EPF driver to pass the actual message data to be
written by the host to the doorbell BAR region through its own logic.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v3 to v4
- msi change to use msi_get_virq() avoid use msi_for_each_desc().
- add new struct for pci_epf_doorbell_msg to msi msg,virq and irq name.
- move mutex lock to epc function
- initialize variable at declear place.
- passdown epf to epc*() function to simplify code.
---
 drivers/pci/endpoint/Makefile     |   2 +-
 drivers/pci/endpoint/pci-ep-msi.c | 128 ++++++++++++++++++++++++++++++++++++++
 include/linux/pci-ep-msi.h        |  15 +++++
 include/linux/pci-epf.h           |  19 ++++++
 4 files changed, 163 insertions(+), 1 deletion(-)

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
index 0000000000000..91207fb66db32
--- /dev/null
+++ b/drivers/pci/endpoint/pci-ep-msi.c
@@ -0,0 +1,128 @@
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
+static irqreturn_t pci_epf_doorbell_handler(int irq, void *data)
+{
+	struct pci_epf *epf = data;
+	struct msi_desc *desc = irq_get_msi_desc(irq);
+
+	if (desc && epf->event_ops && epf->event_ops->doorbell)
+		epf->event_ops->doorbell(epf, desc->msi_index);
+
+	return IRQ_HANDLED;
+}
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
+	int i;
+
+	guard(mutex)(&epc->lock);
+
+	for (i = 0; i < epf->num_db && epf->db_msg[i].virq; i++) {
+		free_irq(epf->db_msg[i].virq, epf);
+		epf->db_msg[i].virq = 0;
+		kfree(epf->db_msg[i].name);
+		epf->db_msg[i].name = NULL;
+	}
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
+		dev_err(dev, "Failed to allocate MSI\n");
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < num_db; i++) {
+		epf->db_msg[i].virq = msi_get_virq(dev, i);
+		epf->db_msg[i].name = kasprintf(GFP_KERNEL, "pci-epc-doorbell%d", i);
+		ret = request_irq(epf->db_msg[i].virq, pci_epf_doorbell_handler, 0,
+				  epf->db_msg[i].name, epf);
+		if (ret) {
+			dev_err(dev, "Failed to request doorbell\n");
+			pci_epc_free_doorbell(epc, epf);
+			return ret;
+		}
+	}
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
index 18a3aeb62ae4e..50c0f877f2efb 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -12,6 +12,7 @@
 #include <linux/configfs.h>
 #include <linux/device.h>
 #include <linux/mod_devicetable.h>
+#include <linux/msi.h>
 #include <linux/pci.h>
 
 struct pci_epf;
@@ -75,6 +76,7 @@ struct pci_epf_ops {
  * @link_up: Callback for the EPC link up event
  * @link_down: Callback for the EPC link down event
  * @bus_master_enable: Callback for the EPC Bus Master Enable event
+ * @doorbell: Callback for EPC receive MSI from RC side
  */
 struct pci_epc_event_ops {
 	int (*epc_init)(struct pci_epf *epf);
@@ -82,6 +84,7 @@ struct pci_epc_event_ops {
 	int (*link_up)(struct pci_epf *epf);
 	int (*link_down)(struct pci_epf *epf);
 	int (*bus_master_enable)(struct pci_epf *epf);
+	int (*doorbell)(struct pci_epf *epf, int index);
 };
 
 /**
@@ -125,6 +128,18 @@ struct pci_epf_bar {
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
+	char *name;
+};
+
 /**
  * struct pci_epf - represents the PCI EPF device
  * @dev: the PCI EPF device
@@ -152,6 +167,8 @@ struct pci_epf_bar {
  * @vfunction_num_map: bitmap to manage virtual function number
  * @pci_vepf: list of virtual endpoint functions associated with this function
  * @event_ops: Callbacks for capturing the EPC events
+ * @db_msg: data for MSI from RC side
+ * @num_db: number of doorbells
  */
 struct pci_epf {
 	struct device		dev;
@@ -182,6 +199,8 @@ struct pci_epf {
 	unsigned long		vfunction_num_map;
 	struct list_head	pci_vepf;
 	const struct pci_epc_event_ops *event_ops;
+	struct pci_epf_doorbell_msg *db_msg;
+	u16 num_db;
 };
 
 /**

-- 
2.34.1


