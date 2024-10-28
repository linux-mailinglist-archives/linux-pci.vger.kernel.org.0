Return-Path: <linux-pci+bounces-15486-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDBE69B39FF
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2024 20:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DAA2282E3E
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2024 19:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BA51E0B89;
	Mon, 28 Oct 2024 19:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Behj/9mt"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2079.outbound.protection.outlook.com [40.107.104.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483D41E0B78;
	Mon, 28 Oct 2024 19:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730142386; cv=fail; b=o1yx4EQK8vOOAMxq0p4/zxoTd5crypSjeLI80SYnC2oz4qY6oCTOylTJveSCpG9QGWMJ6u8AQcEn4Ltrxkc217W1K02C64MQqpyLMLGTKpqH6c3yarg7vlyur/dZhIsjPw21x1+a96enOCYhBwBUdBi/F6/tKumDMvuWZlpB2Wo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730142386; c=relaxed/simple;
	bh=wjq39b1bSlaqsK6CqdYI9THTeDF6beeukudaMwC5+eM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=kIIe4XJ07fnWHxpJovbU0Goev3VtXJHRAUA69YokT8U4vXAIPjlgybdq2ejFOj2g/h9s+SsfW1mSyGUJkB/38xUoyoN/B4KIgF37kBWNiysgJ9KMbDH0qsOyVTrl0Tku46mV4m/3VDkwinltZK0wYcnGs1Rj8/caruap5ocm/pw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Behj/9mt; arc=fail smtp.client-ip=40.107.104.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YnFsSnT8dtkr9cPeii5vvS6munI7Pi0twrD7z4imwDDM5FPj7WeIdwPlqrFgdI9KPr+5KAVgW0s1cRkv//y02go/g4T0QeAX6xaRnCIY9nhrRNsqmFJxew1tDtzc/FymqPtDMqFrKZdPD+lfK+wlhNisEmoQoeIJI//t9G1OgQcN5ofRIj6jhT8Jte8XU+8g9CW+R8J6544YN1guYIATnBEGfSSqoaexq84GGFuyKCZkxR4Df2dYIjFId1YiCId2VXCnv+hMldNpyqWZmTsxjam2cTp1BWWwwEe7zsdqEVG0Np34bkSgqzLEGp5hclBOK7jYqjMTaQq3aJSRk3OniA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ilQ06dZ+gRqsAnBOtuudd2FBhIfbsL8re509y5kH6U=;
 b=utDSc75tLU/nUHT1jvwjwOQ0puDGO1spxw1/+HgCS0YG42CKIiqZ+P2bBVjPBYH0Ma3fxV6upw/hbW7VFwTZZEWVqzCdGxlscYA1ehHXwqMTQnO1VizK0ZnSqTqv+dn2QIByIPC6nXwrBwdrVXgJ0yly3v3A86FfOAGQw3hUHgnmN2pW1FtP3KCKfC9BdggtgHtBEwSOrNQDeRCAhFpESABO4kOAVQ+E0ANs2S10JODjCI1jEVVOy5T58K7giAatEYbf+03/vyFvsIH2Z8rQ5riGHBQ0aRsti+DNztRzz/kEq+ObBZGo7smflBd8lXA1tGIDDdBlaBARVMUPPzzNQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ilQ06dZ+gRqsAnBOtuudd2FBhIfbsL8re509y5kH6U=;
 b=Behj/9mtJ59S3b8sm4ogk3Zqk18D2EXHG1m25RLSVX7etMM64u9v1LLpIlximVYAKI+YulPMU3bsR9IvTV8JJ9NrbWwSrH4dMSKEIoKmuKfGnRXIGJUZ/9nf89xbp/o0xxEgl3/9wInW8snwYFUePiYUWRw+DTyyh1uZAfnbW1ukkjYSdYkOacy82geJd/paCKkXghxJvQ7WiV7dYtuKjv9VWlg7xSQcCVVAPdWPrfZmjcnCRaEYpZHX4KEKvxHB/bPoWbS5+nPpwdn4Cjtldni236Ow9VdBcgDznYxw4iLLHfXFKzAldGutRLZNHun5ILpil/9wnYcP/jY1GN6ZHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7946.eurprd04.prod.outlook.com (2603:10a6:10:1ec::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Mon, 28 Oct
 2024 19:06:21 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8093.021; Mon, 28 Oct 2024
 19:06:21 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 28 Oct 2024 15:05:57 -0400
Subject: [PATCH v6 3/7] PCI: dwc: ep: Add bus_addr_base for outbound window
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241028-pci_fixup_addr-v6-3-ebebcd8fd4ff@nxp.com>
References: <20241028-pci_fixup_addr-v6-0-ebebcd8fd4ff@nxp.com>
In-Reply-To: <20241028-pci_fixup_addr-v6-0-ebebcd8fd4ff@nxp.com>
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
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730142363; l=5630;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=wjq39b1bSlaqsK6CqdYI9THTeDF6beeukudaMwC5+eM=;
 b=OkTwnRGEyTpEsvbOP8JxrxmK7S1zO2r8ZqzQDDCSgQTstxt0IDtyadD3Suu3yRVF7yfa7/KT5
 lp1tb+eBOuqCLfKtJaGjwCcceNyXd0Rh0P3jBTkUfn64VE6+oYN+1el
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::18) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7946:EE_
X-MS-Office365-Filtering-Correlation-Id: b641c80d-0b8d-455e-f3d5-08dcf7839c65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|7416014|376014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RGoxV2N0ejB2djdHaW82eUUvK2YrSVhzc1pvS2thQVV3QzJDV3RkaEU0RGZP?=
 =?utf-8?B?cG8vUjJCZVRrVjh6cGVOVEVmZUdzRUVnYWZVTFNudlhiVGxlcHRWdVdNd1VL?=
 =?utf-8?B?UFljdG1YYUg5dk10bHV3d3NpRXlaVU93YW1YUFhqa3ZTc0NoVWpLUC9sc0hN?=
 =?utf-8?B?Y25zN2tVWVArd3BzYVE5UlZOZVQrOGNVTytnWFFoTmdGUDQ5dW5vNDVZS1R1?=
 =?utf-8?B?eHB3TUkxVnFDY2hCKzAzNW1CYW1UMGpRY1V4NHdnWjR4OTIxcGU4dzQxbFpt?=
 =?utf-8?B?UEV2MlVudzNjS0t2UW1nTDVlMzFpTFo3NmM2cTNjeHJ5VTYzTTZUNll6Rzcw?=
 =?utf-8?B?aDRWUmszaVZVVUQ4dUlSVjI5SE0yblg5a2ZIU29JMlJXZFZpd0w0NmFhRnkv?=
 =?utf-8?B?Y0lqdmc4NFB0clVaRitFanNmWkd4VWtSZzBuM1E2NGpyejBGRDRhWVRaTWh0?=
 =?utf-8?B?emlIclZIZ2lOT1lrYjFmZXhid1U0RDVpd2hFZlZncmRiellPY01ybmp0dE5P?=
 =?utf-8?B?S1k4aWRsa3liWWZYWFZUOEVwWm5sdG1tOS94UE0yUkdZTFRqVVVvaEsvUi9N?=
 =?utf-8?B?d0VsVllpRVR3NkpxdXZjTDNjYjVvclc4em90aE9FQnBOYmE0QTgyM1p2eEFC?=
 =?utf-8?B?UjNNdEFYOW9vNmRuRzZzcHh5Z1Faa2hIVUVzTXlIYzV1VXZhRWZJYnZFUVJs?=
 =?utf-8?B?M21rRTdRQWVQbStKaWNvOExWVHU3b05KcFlzNndSODRDZGNvUGhOY2swMURL?=
 =?utf-8?B?ZDBneEFnbW16REpIZ3pIN3hZWmlnRWRLd284Zyt3UldnNk1Ub1ZUSDArLzM3?=
 =?utf-8?B?VFdTZ1ZtelcydUUwM0ZEMlhlbDAxVlVDWVlXQWJmY0Y5bFJyRm96R05HZmN1?=
 =?utf-8?B?a0h5NFBYN1BzWnY0UHF1MEx3bjlvQnN5ckVxdkx4WG1IamN5WTdadnFMUkY5?=
 =?utf-8?B?T1FIek5RWThwazRsU1JRd3lsejAzblp4S21BUkNsRTN1Y0Uvc2RDU21PMmNR?=
 =?utf-8?B?Z0M1cURZVnpCaTByVml3My96T1BBZFVLN2hJWHhORkNPMnJ2TDNGbE13MUlE?=
 =?utf-8?B?azBvUER3cTZBTDE5ekhtakxOL0pDcEFpZE5icllSSGc3SXdYVkQ3SFVYRk1M?=
 =?utf-8?B?ejNZMHRHbTNQTkIyNHQ4eVYySFZXdXJhSE9ybGkzbkMxcnFORXZROXFNOVpT?=
 =?utf-8?B?QVJTWXg0elZzeXU1emR5MEJyNVd6blJTM0pXUHliTWtOVExuaGlJU2NybHBs?=
 =?utf-8?B?YnNjWitnM0gxUGtZYVZKbUdxVk40c0FpR1F5WDFNY3M1K3B1Z2x4YmNyWjZV?=
 =?utf-8?B?VENKUTBiVjhDTDhnYW5ia0dhOVE2eHI1ajZKWTdZTUtMeFJJbk05ZW1WRUcx?=
 =?utf-8?B?ZWxUOEtyRy9PSG84Q1R5L1lJekp5WEtWYjJGRE9NN2tDbnpWQlBVdE1QZm84?=
 =?utf-8?B?Qlo2RFBQNDh3anpmUzJ5UW9zNVBXc3RSeTVkLzVKVkQ2UldvRlpPK3l1dzZu?=
 =?utf-8?B?UWV2bnM5MG9qU1NaSm90ZXdMb2VJLzhtRW5idkRhMWUxbWY0TzVqOVVOV3FO?=
 =?utf-8?B?cTNNN2RqQWlRbE1hUGh0THhRN1FCMmtndGU4TURhUEtiOG9CSGhqcWI5cTVk?=
 =?utf-8?B?dGNrenJia2Y3L1FwL0UvOW5SNi92bHBVNnQ5S0NSakZjWEVLc1BRaWJMblZa?=
 =?utf-8?B?bFJoYnZrL0hVUmZOTnYvVnZBbVdoVkEzTk50SGJHVUY4cGx3dWhyTUtrMlBX?=
 =?utf-8?B?TFlQdlRNQ1A3RHorSVhXSTI5d2FKZzlRNHJ5ay9IY0NDNzV1Y0RSbi90VW0v?=
 =?utf-8?B?SHI3VmNzdmgwMVFweWo3T3J5V29jK2doNjc4cVRyMDNkZW12WjFFWmlaYlhU?=
 =?utf-8?B?eExhVlVYYmYwaUY0TnowTDgwODlnQjBVcUR3U1pUNUtnVFE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(7416014)(376014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a0dmaEp1cXRMUjdvRzdtdnVUNmFMUGhqZkhIRmZ2S2lGa2lqdmxIQ29xTVRw?=
 =?utf-8?B?RWMxeHdEeEtmZXhqK2U2R2NhekVGZzVFZlFaWTczNmVEbTlFMVlXMHFtNFVH?=
 =?utf-8?B?d3RCcHNNMTdRbFI5Uk0rb3JKa1ZMb1JNa3krdmxick00d3k2dVlNdFZtUWRk?=
 =?utf-8?B?YWlqcGJLMjQvVWk5V2UyZUFHL2lTWXkvQzl6cTBrTUUvTFI1ZUk2QVJCMFVR?=
 =?utf-8?B?M1hMYWttTUUxUVIxM2NITWdPUWxudU9keWIvdjZKWGFFOXllWlRMVityREhy?=
 =?utf-8?B?NmZsaWpGY2lrMW9lbE9sZDFaSEExNHRwYnJjSmpsbjNkNXpqRGplNmIyZGli?=
 =?utf-8?B?b0NjR3dzOXhLUi9jOTdXYXdIZEIwWEt3WXdBbzU3N3NSeklURm9yR1JLalF5?=
 =?utf-8?B?QTVidFBWQkdRQjBFSUZRcVFLT3FweTFSVjdIMm84bkRZUGM4ZWNFaU5oTGcv?=
 =?utf-8?B?a09tbXFSVXZKbk56VzJqYnB5ZDdydmNuT2RlcWEyT2Zha2dHcGYyNnVwL2xZ?=
 =?utf-8?B?OWtTdFNZb01ONXJSQmR2SDZOSGt0NDAzSXcwK3J1YXhxU3JhYTRpVjdUc1Z6?=
 =?utf-8?B?TjBHVFg2RzJnU3pWNzU5TWlDaU1LdXdRZ3A5dERpRVZXVTlVL0ZVb2tCUkZi?=
 =?utf-8?B?Z0xORmxyZCtOTXgrY24yaFJFd3VyZzVnUzFPQ2lMTitSck0zVURZUEJNR0c3?=
 =?utf-8?B?cWxqcFo3UUkvbld6bUZVcFM1Rk54dXBRMUJsMElHcEhiVWUySy9adGJJdCsw?=
 =?utf-8?B?bUJFcS9WOXdNU2k1SCtYUS9ieGNhcWdCdE83WUlTUVcySEhMZFlkcEk5ek5E?=
 =?utf-8?B?YTFzcDF6dmxMWC9sZmJEclNwb1JlaGpMakM0RzZBTzhETXFTZFlZaUZIUEc4?=
 =?utf-8?B?SzgxcG1Pck1ybzBxWTBtTjlxQlNpcGZ4SXZPajBNM3VOdDRrQ0VYL2pUR0ht?=
 =?utf-8?B?TzMwT2hmZWEySUJ4c0lqcmVVNlVvOW8rREMvWkZUbEk0bDhINGFpVVQ3aUh1?=
 =?utf-8?B?S2gxTDQ5Wm5oaG50TGJUQ2tJOE96MzA4STdoNDBRaEJpb1dQc2lmSjJJYmIv?=
 =?utf-8?B?dDhRakRSY1dqWk5iM3IrQnY5bWRDNDRHL0JjUGhLaFJJazFGYktsV1IwWG9m?=
 =?utf-8?B?VDFuOTNyeWxHNldKdlJaY1p1SWF0amVuZHFwb0dKbWtxYkM2bEEvTndSZFow?=
 =?utf-8?B?dGRBRnIySFpUbG5KdGVTOTREcVJnUVZOTTdaaTZYSGNqZzExVThhWTBRMDhs?=
 =?utf-8?B?RXJrSVNOZ25OejBITmsyVGxLSGFWY0V3MURvbDVxVEhTUzhkcmZ4OGVaZmdm?=
 =?utf-8?B?WlRGcmpGa1BPNGZTVkJHVysrTXpheTF1dkhqNlVzbnZjbVI0QkMwbmVJZXRS?=
 =?utf-8?B?bnJRekZMUXQxSU82c0YrN0V3ZkVoNEI5TEEvRHIzSVg4a1ExelNZRlNXL2c5?=
 =?utf-8?B?Y2tUYXVLbDdOU0ZnZEhJMTFpUmc3QXJxeWdWN0pKc2ZjUnJweW5tN0RsTitw?=
 =?utf-8?B?QXovbTRJOHdER1IvUmVKNWo4Q3B0akJxNE1FOUk1b2NoeFdFN2dhZFNQdllB?=
 =?utf-8?B?cHRyRmhUdnI0VFpKUXhHdFlMenRURklvTUQxUUtZL3g1UEczRSsxWm9pWWhv?=
 =?utf-8?B?SEFWVXQxdW5xMHlHaTV2L25ndXJZSDJ0ODF4OU5QRlhTTDJCTUpFTGlQcTJ0?=
 =?utf-8?B?amRabnJ2Q3NuQXFQUDJQOFpvdmNxaDE4QVdxK0tYY3FXdnZCb29YVkltZ3F4?=
 =?utf-8?B?SUx5KzV1UEdGUjJsMGxNenF5TFk5VkVNT3JiZEZRT3NDWFFXbnlZTkU0cFFj?=
 =?utf-8?B?TXpxQ0xZU3gwNllYNDI1MTRucjFoc0FCeTkwL3dPc1llbnd0ZUE4dk9va0cz?=
 =?utf-8?B?cDlxQ1FXMjQzNVkwWitLekJnVVBYOGlYMDlFZnBkMlI5YmExeDNYNjcwanhq?=
 =?utf-8?B?ZHJyUzRadklDbEU0RklORDdBZUdPaDdJbGpsdWllYW83SXVycGhjb1JweFlq?=
 =?utf-8?B?VU81WkhEM2Q0TGlWdHZKRDV0emJRelhVQlkrWitsSFZUR0U5TzM5eTIxS0tu?=
 =?utf-8?B?QndoZjNYUWFzbUp3MzY3cVdNYnlLVkNDVHd5Ukkxa05iTzdCMXBTaDd3aHdE?=
 =?utf-8?Q?p2j5vR8zC8FX6Lgiw2LaRCJRV?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b641c80d-0b8d-455e-f3d5-08dcf7839c65
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 19:06:21.7565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QPD8tend6DRo+XH1G3qGxRN7VGdu142qLEuVFTF2tFuo8xViqjpRlqSjW+plZyQqSAiDgvhGL3oRFWk/hFlPiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7946

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

Add 'bus_addr_base' to configure the outbound window address for CPU write.
The bus fabric generally passes the same address to the PCIe EP controller,
but some bus fabrics convert the address before sending it to the PCIe EP
controller.

Above diagram, CPU write data to outbound windows address 0x7000_0000,
Bus fabric convert it to 0x8000_0000. ATU should use bus address
0x8000_0000 as input address and convert to PCI address 0xA000_0000.

Previously, 'cpu_addr_fixup()' was used to handle address conversion. Now,
the device tree provides this information, preferring a common method.

bus@5f000000 {
	compatible = "simple-bus";
	ranges = <0x80000000 0x0 0x70000000 0x10000000>;

	pcie-ep@5f010000 {
		reg = <0x80000000 0x10000000>;
		reg-names ="addr_space";
		...
	};
	...
};

'ranges' in bus@5f000000 descript how address convert from CPU address
to bus address.

Use `of_property_read_reg()` to obtain the bus address and set it to the
ATU correctly, eliminating the need for vendor-specific cpu_addr_fixup().

Add 'using_dtbus_info' to indicate device tree reflect correctly bus
address translation in case break compatibility.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v5 to v6
- update diagram
- Add comments for of_property_read_reg()
- Remove unrelated 0x5f00_0000 in commit message

Change from v3 to v4
- change bus_addr_base to u64 to fix 32bit build error
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410230328.BTHareG1-lkp@intel.com/

Change from v2 to v3
- Add using_dtbus_info to control if use device tree bus ranges
information.
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 21 ++++++++++++++++++++-
 drivers/pci/controller/dwc/pcie-designware.h    |  1 +
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 43ba5c6738df1..a5b40c32aadf5 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -9,6 +9,7 @@
 #include <linux/align.h>
 #include <linux/bitfield.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/platform_device.h>
 
 #include "pcie-designware.h"
@@ -294,7 +295,7 @@ static int dw_pcie_ep_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 
 	atu.func_no = func_no;
 	atu.type = PCIE_ATU_TYPE_MEM;
-	atu.cpu_addr = addr;
+	atu.cpu_addr = addr - ep->phys_base + ep->bus_addr_base;
 	atu.pci_addr = pci_addr;
 	atu.size = size;
 	ret = dw_pcie_ep_outbound_atu(ep, &atu);
@@ -861,6 +862,7 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 	struct device *dev = pci->dev;
 	struct platform_device *pdev = to_platform_device(dev);
 	struct device_node *np = dev->of_node;
+	int index;
 
 	INIT_LIST_HEAD(&ep->func_list);
 
@@ -873,6 +875,23 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 		return -EINVAL;
 
 	ep->phys_base = res->start;
+	ep->bus_addr_base = ep->phys_base;
+
+	if (pci->using_dtbus_info) {
+		index = of_property_match_string(np, "reg-names", "addr_space");
+		if (index < 0)
+			return -EINVAL;
+
+		/*
+		 * Retrieve the local bus address information, which is sent to
+		 * the PCIe Endpoint (EP) controller. If the parent bus
+		 * 'ranges' in the device tree provide the correct address
+		 * conversion information, set 'using_dtbus_info' to true. This
+		 * allows 'cpu_addr_fixup()' to be eliminated.
+		 */
+		of_property_read_reg(np, index, &ep->bus_addr_base, NULL);
+	}
+
 	ep->addr_size = resource_size(res);
 
 	if (ep->ops->pre_init)
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index f8067393ad35a..f10b533b04f77 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -410,6 +410,7 @@ struct dw_pcie_ep {
 	struct list_head	func_list;
 	const struct dw_pcie_ep_ops *ops;
 	phys_addr_t		phys_base;
+	u64			bus_addr_base;
 	size_t			addr_size;
 	size_t			page_size;
 	u8			bar_to_atu[PCI_STD_NUM_BARS];

-- 
2.34.1


