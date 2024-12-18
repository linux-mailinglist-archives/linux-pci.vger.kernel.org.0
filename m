Return-Path: <linux-pci+bounces-18735-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1DF9F708C
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 00:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1D6B16BCF4
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 23:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64CD21FDE26;
	Wed, 18 Dec 2024 23:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TQvHSC6K"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2085.outbound.protection.outlook.com [40.107.21.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011931FECB3;
	Wed, 18 Dec 2024 23:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734563379; cv=fail; b=SMV8DJvj1++xveEsNvVJU614F3O3pHtzymYyMpalCeqmqWBPSNJuAvMYQDyRDJqd8CQRz8mnEeTUvpcHmZ3oM9++vAY/+WfeIaO7oTgdFsQndZ/uDiLbhBgSllSFLuQUv2o+JGwyu9QO02kcctT7EiCaBhjsc3B5OIkhka/z0LA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734563379; c=relaxed/simple;
	bh=+tf6wudUoIbEsl/FZUMDaGOl5nvUQhr4hR8U75xWVfI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=uG1fX3CsPHRKIQyxieJNFinmsNHgRo5nOday3EFYMOrlUJZ9YVPVXT2d6ra9VHdtX/6cQm1oHzz7dSFR+Kumr9K4WeZZwNa64Wpoj2aJ2SlMImGFBc5RQvNttP9IKx95PNmDK7GcCUxrsuhArrjUZVhGEI3KI1WIReRVAD42nLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TQvHSC6K; arc=fail smtp.client-ip=40.107.21.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=psVHzcxMOXFsFoOaPAodoe/yzvVk0DWwy1PvrsUZpPISztU6hO22OezdKap/6gmH9WacZODU2t0nOYYmtH1xMR6g+jrPsLjsqQnQQX2wTrJztI9zjf7vOp0uvRyL9ektJ6GXn4t5BzgdY0jzpl0gnRrSPyf+qd3kwJbQyq6L0Gu0AAp3Qd9dqOROZeAAupKyiqqdrBI9sM6HsDjPv4qpuLq+KkegY76S6EWjTGoVC15Z6u01vLUy++43SNRDxOw78/l2MvVT9RDDnHxM/+I3B9TfjqbfVfSiGrRS3hYTiUYO/S4sgMueOIuqfQWdwvhjHUex6Zhn0Oe4y39FqEkTqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2EsQMPhR1nPrXLiGi6B1VPzpAgUnb47cDPExYl7k0lA=;
 b=iAagzOryysy0Me4sL+UvglvfyxjmFZ5bZJ9VrGLHIB/iunG98MJJ4NlVTKxqqWjXb0JMoRg3BEAxe9VG9RHYF2Txyd4C6OlAPToX6PAB9SJzKeo3maO3VCF5rtO9M8jbbEGpwqJwqxmxuvapcrWzOwLTQOlVm2Lc6kFs3JgVYGuV3J7fQPta095KwjHSj/gO+bWkVYkU9NgiOS+IwHwSfpsaGwp8zkI/qEjktTkbzFQZAY1vB1K21kopDX3C43QtmPcTWYFKmLlafMT2UT1OLAAZt7jevIbq2tzIaQSFUz+b0k2EW+PZimpXQYwwhJv0kRwH912nnCeYH9mBYqVYqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2EsQMPhR1nPrXLiGi6B1VPzpAgUnb47cDPExYl7k0lA=;
 b=TQvHSC6KNLGS12PopZgoWkkNMY1/l4cegWywpUgUXTAEKpZUMl2/zyjMk5YPGe0zzF56i8xaqsvE5Nz5FpMw3yjHUNIn2q7XPGzbBmPw+D5b4/KMSyL9kG7rFPd8leFSHXn2L7q3eCsytWvQwd2ow+8ny5QV1klsAC0T2WFFVf1IOt+C8veLEuXmD4yt09Cu2sYLNK/7S2v3rHcDOqRYtOzfMGkgdAnWis3fyl91m3V/eKgI1GjGQ9T/HvARuycdZ2tkHnyykNNfYdOQBtmw4EhAqQIKryat2NPXmV3bXcswfOyhgEpEXpI0QpSXM7ng9TtdqAzGaOo6wGvSAqrMJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB9939.eurprd04.prod.outlook.com (2603:10a6:10:4c4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Wed, 18 Dec
 2024 23:09:34 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8272.005; Wed, 18 Dec 2024
 23:09:34 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 18 Dec 2024 18:08:42 -0500
Subject: [PATCH v13 7/9] PCI: endpoint: pci-epf-test: Add doorbell test
 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241218-ep-msi-v13-7-646e2192dc24@nxp.com>
References: <20241218-ep-msi-v13-0-646e2192dc24@nxp.com>
In-Reply-To: <20241218-ep-msi-v13-0-646e2192dc24@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734563338; l=7892;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=+tf6wudUoIbEsl/FZUMDaGOl5nvUQhr4hR8U75xWVfI=;
 b=npYniliL17rb38kwx/P4jIuV8n0K8bEGquKoLUhFzPbCPZ29imQcvss7wSPWZNXcEAOJ2U+EA
 ja0KUdLbalnCGf/F2xFERIfVhzWAWL8Arb6S1T1ABVXbXLUWTX1Twkl
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0075.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::20) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB9939:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e51f7d8-6d3a-47e9-4c8d-08dd1fb9095b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N3BjZ3EzeDlSR3FTbnJ5dllWaGMrenhreWRZZldwc1ByZWZKUTlIRVhIOEt3?=
 =?utf-8?B?ZVFVYlFrbTA4QXhuRTJsaWE1UEZ4RzRKN1dKalVrcEJKZDk2ZVJNanlIb1lE?=
 =?utf-8?B?OGdURVhobXRjQzcvV2JjWWF2NFppdkJvVnRZaWliMGVJZTFmZlRZV0tsWThP?=
 =?utf-8?B?S3hyaURaQ2c3RGQwem1ObHNyVGdiQVQ0UG5lKysrTE5DUlY0Rlk2a2I2TVhi?=
 =?utf-8?B?OE1JTkR5RGozRUdCYVQxSDR3c212QWZTNW55cHE4eUVNcWd1V1FmOU9SaEVF?=
 =?utf-8?B?a3AzeDNmejIwNVdSWDZMaUpSSUx6R3FRV2dadlJMRjNCVTJJdWxOWGpMaFVF?=
 =?utf-8?B?Y1BJcFBTL3ovdGFoQ3EyRllIczFrUGhOMXN4bnZBWDRJVkZaRnZodnNMZXk5?=
 =?utf-8?B?ZW10UUt4ZlBZbmxCdmZBeTJ0S0NBNkpqaFRsQ1BDUUt0QWFKeFE1MFMyZE9M?=
 =?utf-8?B?M045c1dQUXNTUnM3WVNuZjZqT2dTbDRTNlN1U2xwMmc5V0JMNmJjbzludmxu?=
 =?utf-8?B?TE5NTGZuNC9qTnRTbXlaVm42TU41RmFKV2gwK21hemQ0Qm8xTy9TaHcyZ3lu?=
 =?utf-8?B?REhCRlV6NURIbnJIZ2ZEMkduYW9nTFg0enlaQll4SHJzM25NN25FNlJPdDdV?=
 =?utf-8?B?TzE0NzdQSXZIV0ZJSVMxTk44WFpnVkpiMWQzZEora1p2ZzJNQ29PM0xSWE9H?=
 =?utf-8?B?cStNYUQ1bktIUnQ0MDlIN0d5ZFE5RHFkc0FsOG1MWnAwYzVROEJsd2IxaEVC?=
 =?utf-8?B?elVUWTMyYnNuUEJQWVFIbTJpT1dIMW43dFhmZm9IOFd2V0YzSXR4Y1J5SEhR?=
 =?utf-8?B?NUxqajlrckZsTUF5ckpmcWhIb2ZiVDVKQ284cEFKdWR4U2VQYXp4eWVXNFlG?=
 =?utf-8?B?ZjdsdndZQ0xyQXVEOFZzdDFjdHp5bnpwbVJFRytHckRya0xZeWlXVVAwU1dE?=
 =?utf-8?B?MGtheENsN2UzUWtXalBUUmxhTE01SlhLYWdRa2FrNzlOZG9JS2g3M29aMmUw?=
 =?utf-8?B?V0lTenQ0QUQyQ0ltT2NieTFENXR5RkZOeHNXN1hZN1BmbFM4TmJYekYrR05W?=
 =?utf-8?B?TlF3VmZjL0doRmZIb01tOEFPaEloYmxGRVQyZXBrd2RPSDk1ZGVQWjlwWTNO?=
 =?utf-8?B?VTh3ZWozMWFqdUZiQXh0TkxzWXBZNFYyZDF2WEZGak1hK3VVQTNnMG5wekVI?=
 =?utf-8?B?VTFwNHduajk5aG8wQVdyTlpvckkxSmJ5bXp1T2RQOFNiRG9tSDdrMWhtWEc1?=
 =?utf-8?B?Tno4VGV3aEdPWXhHNStsRXZhc1pIMmtlamJHT1pHR05wK1RrQm9IWFJjVEN2?=
 =?utf-8?B?OHMzRUFxSEgwVFpTcW10bXhIME9iS3Z2WVNDUktqWFM2NE5QeVV0T1RSUUEw?=
 =?utf-8?B?RjNCbkd2RDVMcy9kYTRzcWNpalQyQmpxcjRsZGZwdUpJV2N5NUd4bnZva1Nr?=
 =?utf-8?B?ZEVWNHF3azFybFl3U0xjQ3cwczNteE5DMlNEYTNKb3poYlM4cDF1NmV1UlBK?=
 =?utf-8?B?bGUyM1RsbWY0Z05CdkNkT2lvSW4ybU5rZUVKdWh4Y0JNaDE1aEppTGNNeUlw?=
 =?utf-8?B?R1lYMTdCckNMbWlONGtMNHY2NFRBakRTZkdOaGNXaWFIR0hhdGxNa1BMSVBi?=
 =?utf-8?B?TVZsdDY0eHkrLzJvVnBXb0tUMjJoN1YwcGl2Qi9vSnNKajRPcG9abjRjaWRp?=
 =?utf-8?B?M1NrVkRmWE1RT1E5TU9zdzJ2bHpVMUMrTVJDK2pxay84WWRmd0YxRVBHQ001?=
 =?utf-8?B?RWZyVDZ1SG1SMlhEcTVTZ0JJcGVGRlZ0WU5CL3NLRWpmbElYbkdEWHZPb3Rr?=
 =?utf-8?B?anMrWG1ZTmNCaEtiRWNkUDk4OEhBaE5YeXB3NGQraXpKalB4eWw0Wk8xaUFz?=
 =?utf-8?B?Z3N0L0I2TzRKYkZUR1FnRDFRREpzT1FTQmJ1d0JoTTl5V2VoVHN3WXA3dUds?=
 =?utf-8?B?bmxvUFZIcWQxL0RQcVhWWEpmTjF0cmtpOXRLYnRobXlHZFdYMEczTG1Wdi9z?=
 =?utf-8?B?NG9VQ3Q0cjhnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K1Y0bUl3L1V3d05xS1p2Wm9VelJ3VDBvVkFOem05L29XTDZEeUkyUXczNVNR?=
 =?utf-8?B?UWJINllJdVlOQTRBcm5QWFF0K2V3NmFHck1EZ0ZESnQvZHV5REF2WGxJMk00?=
 =?utf-8?B?SnMwY2J3Rjg1cUdIS1VkM1YxbnFLaHhmY3AzTHFpMUlHaWdlaFpzTDZKYmFT?=
 =?utf-8?B?S3g0ZWg1dGN6WnVHK0JhMTRRT3BCRHhKcWJHSE0zSFpmZ3EzMHkyMjA0OHNo?=
 =?utf-8?B?bWxaREdTWk52emdhZnJXOFdhdnQrbXdTZDRJeE5VanVTQUhJUWY2ZVRDK3d3?=
 =?utf-8?B?bWZFUlFabktXc2dEanByOFJCVWI2TVFUSUFFMi9ITWxiNjdaVmpMWU8raDFj?=
 =?utf-8?B?K3I5NVU4QlhuZFVEdjlNSU8ybHFmTm1IclA3MVVTYTZ0MDhFWkk4cGtMeG03?=
 =?utf-8?B?ZGVGUjZuRUI0a1lJZ1ZobFFyQWs2TXpJak1Ia0JpWW9GRDltNW91V1RYT1ha?=
 =?utf-8?B?UFdQQXB2eWRtYzFwWkVIQW9RR1Z5dkYwczNJM2RQcnhKdWJlYlhGMDRXMXVN?=
 =?utf-8?B?cnI0ditrNDljVk8rTVFqOUh0ZXF1SWtSRTR5aGVBaWVuN1o1bU53dWwxTmNP?=
 =?utf-8?B?aEExZ1JnaWFDNmpoVVAxMVpISjMxV0lyK0FnNzJaNXNNMzN1bTVsZ0ZoL3Jl?=
 =?utf-8?B?ZTkxK2FGa3RqWXVSUlpEbmVTMjZIV0dQQWQwMTlvaUZXSi9aSUVFUzJScS9D?=
 =?utf-8?B?RjJCL3ptQjUrenl3SVFWdVRYNWtxcjVrbXhMYVBBeFIrMk9GdmNKV0luWmpZ?=
 =?utf-8?B?UXpLb1V4YncxK29UcVJNQUJPSmtKOXZGRU8wMXlhVWw1Ty9LY29vckhsNzNT?=
 =?utf-8?B?MFhrUk9PQ3JjUDF5NHc5TWtOZk50cTZZV3Z6a0FHaGc3RWdiUTNPc0NYM3JK?=
 =?utf-8?B?Um9uVjNzbmwwL2s5eWVnRU5QQXYwbTJFdWtSYWhUbmlHbU1KNGF1RS9EU2M2?=
 =?utf-8?B?UUIvMFFaQ1A4UStEV3p1d3pHZzBEdW5jdlpveXF2MVdydlFEZE55ZXlDY3hw?=
 =?utf-8?B?Mnc2U2ltYkRwQzRrR05ldGRZZTc4Ni9aelIvL1Bpay9KZ2s2anU1dW1Zckta?=
 =?utf-8?B?em05azRvdm9WNlhDcVhha2dXQzZMc25kWmdxWmJ6b0Fuc1IwbHc5bFMyQk9T?=
 =?utf-8?B?UlF0bkNWNklsZXo5UzVZZVpSVEFZdTVoUnJyZ2g4SzFURDZtOTRKMm5MaXlF?=
 =?utf-8?B?N2t1Szg2b3ZGWi9kTXpHTmFYcGJFM0pwalNSWjhQcnBUYWlHNGtIT2o2V1Fk?=
 =?utf-8?B?d3d6VTdCWkFuaTltREV1MS9odm9XcElHbHJSWGdIbGUyZkt0VHlwOXpaVWlt?=
 =?utf-8?B?dkxZY2tBbmNuYWZQVEExVDBYVFVFL1REUXJacW1CQ2NWejkwK2pRdTBrZERZ?=
 =?utf-8?B?TnZhM1hHNWVJcUFBb2JxLzlvRHZaSDZzVUFRd1lDelVGcnFrdHgzdHl1dGJ2?=
 =?utf-8?B?akJMTEc0ZXpDOEY1QVgyUHlQRVd1QmI0S1lTOXk5WW92NExDT1d4aWRGRnJY?=
 =?utf-8?B?ZnZMdlFnZi9VbDdZV2lteTlWemtIeCs0VXRGUEh5RGFtcHNCWW1BbUlmbXQ4?=
 =?utf-8?B?aXhyaUVaZURjcGxKdURkYnhhM2U0UUFTeUtNcDBJZTltN3NwNkFmUVQ1ckU0?=
 =?utf-8?B?SzFEY1FGK3ZvRU8zNm00VWdndFFkRnFBcTQ3TnRMVVlVL3pIY0VIRmgvOW5V?=
 =?utf-8?B?M2duNXdVdWtTdlJWTVdGdWVMbG1xSjRWRU5PMzBRME9vWHhIYjZpYzQwWUhL?=
 =?utf-8?B?TjAvcjFXbUI3d0xhdHlpRER0eTA0YitQckRPYWFEOUZsR1VxcEg2aWFYU1Y1?=
 =?utf-8?B?a1gvRHFtcElmakJGWUpyclJTQmZhR0dGbEx1d1kzb3R4VEhWZlFzMU9ibEQ0?=
 =?utf-8?B?VkI4RGEwdzFtcWtsVXZjbUhTMGZTTThGTnkvNzlhWDNJc3FzWU5aTExpdFJU?=
 =?utf-8?B?VC80eDBMQndIUHNtWUp6S0hqNTVXWGV3UWdod1F6WnFBM3FDODhBaktaelJN?=
 =?utf-8?B?dU5BK2V5clhud2NaUWJNbEljeWZSM2o2a0ZPWGVsWFpqV1VET3N6elhaZ3cy?=
 =?utf-8?B?ZFVMYXNxUHJFT3ZFVjcvT01pbHhyckhhTitVMmh4UHJMWDYyVGIrcWJJZkgz?=
 =?utf-8?Q?zZ9dIuUOzD8W8ra/6e/TQkay8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e51f7d8-6d3a-47e9-4c8d-08dd1fb9095b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 23:09:34.3649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g3D0I/rG6j6tZfedXqxto7EeETXsGKE+mfn53kxbH+PiT75NYhOTV4UcR1UXwm78wYbuGf+TP67lI69XWST28g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9939

Add three registers: doorbell_bar, doorbell_addr, and doorbell_data. Use
pci_epf_alloc_doorbell() to allocate a doorbell address space.

Enable the Root Complex (RC) side driver to trigger pci-epc-test's doorbell
callback handler by writing doorbell_data to the mapped doorbell_bar's
address space.

Set STATUS_DOORBELL_SUCCESS in the doorbell callback to indicate
completion.

Avoid breaking compatibility between host and endpoint, add new command
COMMAND_ENABLE_DOORBELL and COMMAND_DISABLE_DOORBELL. Host side need send
COMMAND_ENABLE_DOORBELL to map one bar's inbound address to MSI space.
the command COMMAND_DISABLE_DOORBELL to recovery original inbound address
mapping.

	 	Host side new driver	Host side old driver

EP: new driver      S				F
EP: old driver      F				F

S: If EP side support MSI, 'pcitest -B' return success.
   If EP side doesn't support MSI, the same to 'F'.

F: 'pcitest -B' return failure, other case as usual.

Tested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v9 to v13
- none

Change from v8 to v9
- move pci_epf_alloc_doorbell() into pci_epf_{enable/disable}_doorbell().
- remove doorbell_done in commit message.
- rename pci_epf_{enable/disable}_doorbell() to
pci_epf_test_{enable/disable}_doorbell() to align corrent code style.

Change from v7 to v8
- rename to pci_epf_align_inbound_addr_lo_hi()

Change from v6 to v7
- use help function pci_epf_align_addr_lo_hi()

Change from v5 to v6
- rename doorbell_addr to doorbell_offset

Chagne from v4 to v5
- Add doorbell free at unbind function.
- Move msi irq handler to here to more complex user case, such as differece
doorbell can use difference handler function.
- Add Niklas's code to handle fixed bar's case. If need add your signed-off
tag or co-developer tag, please let me know.

change from v3 to v4
- remove revid requirement
- Add command COMMAND_ENABLE_DOORBELL and COMMAND_DISABLE_DOORBELL.
- call pci_epc_set_bar() to map inbound address to MSI space only at
COMMAND_ENABLE_DOORBELL.
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 132 ++++++++++++++++++++++++++
 1 file changed, 132 insertions(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index ef6677f34116e..a0a0e86a081cb 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -11,12 +11,14 @@
 #include <linux/dmaengine.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/msi.h>
 #include <linux/slab.h>
 #include <linux/pci_ids.h>
 #include <linux/random.h>
 
 #include <linux/pci-epc.h>
 #include <linux/pci-epf.h>
+#include <linux/pci-ep-msi.h>
 #include <linux/pci_regs.h>
 
 #define IRQ_TYPE_INTX			0
@@ -29,6 +31,8 @@
 #define COMMAND_READ			BIT(3)
 #define COMMAND_WRITE			BIT(4)
 #define COMMAND_COPY			BIT(5)
+#define COMMAND_ENABLE_DOORBELL		BIT(6)
+#define COMMAND_DISABLE_DOORBELL	BIT(7)
 
 #define STATUS_READ_SUCCESS		BIT(0)
 #define STATUS_READ_FAIL		BIT(1)
@@ -39,6 +43,11 @@
 #define STATUS_IRQ_RAISED		BIT(6)
 #define STATUS_SRC_ADDR_INVALID		BIT(7)
 #define STATUS_DST_ADDR_INVALID		BIT(8)
+#define STATUS_DOORBELL_SUCCESS		BIT(9)
+#define STATUS_DOORBELL_ENABLE_SUCCESS	BIT(10)
+#define STATUS_DOORBELL_ENABLE_FAIL	BIT(11)
+#define STATUS_DOORBELL_DISABLE_SUCCESS BIT(12)
+#define STATUS_DOORBELL_DISABLE_FAIL	BIT(13)
 
 #define FLAG_USE_DMA			BIT(0)
 
@@ -74,6 +83,9 @@ struct pci_epf_test_reg {
 	u32	irq_type;
 	u32	irq_number;
 	u32	flags;
+	u32	doorbell_bar;
+	u32	doorbell_offset;
+	u32	doorbell_data;
 } __packed;
 
 static struct pci_epf_header test_header = {
@@ -642,6 +654,117 @@ static void pci_epf_test_raise_irq(struct pci_epf_test *epf_test,
 	}
 }
 
+static irqreturn_t pci_epf_test_doorbell_handler(int irq, void *data)
+{
+	struct pci_epf_test *epf_test = data;
+	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
+	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
+
+	reg->status |= STATUS_DOORBELL_SUCCESS;
+	pci_epf_test_raise_irq(epf_test, reg);
+
+	return IRQ_HANDLED;
+}
+
+static void pci_epf_test_doorbell_cleanup(struct pci_epf_test *epf_test)
+{
+	struct pci_epf_test_reg *reg = epf_test->reg[epf_test->test_reg_bar];
+	struct pci_epf *epf = epf_test->epf;
+
+	if (reg->doorbell_bar > 0) {
+		free_irq(epf->db_msg[0].virq, epf_test);
+		reg->doorbell_bar = NO_BAR;
+	}
+
+	if (epf->db_msg)
+		pci_epf_free_doorbell(epf);
+}
+
+static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
+					 struct pci_epf_test_reg *reg)
+{
+	struct pci_epf *epf = epf_test->epf;
+	struct pci_epf_bar db_bar = {};
+	struct pci_epc *epc = epf->epc;
+	struct msi_msg *msg;
+	enum pci_barno bar;
+	size_t offset;
+	int ret;
+
+	ret = pci_epf_alloc_doorbell(epf, 1);
+	if (ret) {
+		reg->status |= STATUS_DOORBELL_ENABLE_FAIL;
+		return;
+	}
+
+	msg = &epf->db_msg[0].msg;
+	bar = pci_epc_get_next_free_bar(epf_test->epc_features, epf_test->test_reg_bar + 1);
+	if (bar < BAR_0 || bar == epf_test->test_reg_bar || !epf->db_msg) {
+		reg->status |= STATUS_DOORBELL_ENABLE_FAIL;
+		return;
+	}
+
+	ret = request_irq(epf->db_msg[0].virq, pci_epf_test_doorbell_handler, 0,
+			  "pci-test-doorbell", epf_test);
+	if (ret) {
+		dev_err(&epf->dev,
+			"Failed to request irq %d, doorbell feature is not supported\n",
+			epf->db_msg[0].virq);
+		reg->status |= STATUS_DOORBELL_ENABLE_FAIL;
+		pci_epf_test_doorbell_cleanup(epf_test);
+		return;
+	}
+
+	reg->doorbell_data = msg->data;
+	reg->doorbell_bar = bar;
+
+	msg = &epf->db_msg[0].msg;
+	ret = pci_epf_align_inbound_addr(epf, bar, ((u64)msg->address_hi << 32) | msg->address_lo,
+					 &db_bar.phys_addr, &offset);
+
+	if (ret) {
+		reg->status |= STATUS_DOORBELL_ENABLE_FAIL;
+		pci_epf_test_doorbell_cleanup(epf_test);
+		return;
+	}
+
+	reg->doorbell_offset = offset;
+
+	db_bar.barno = bar;
+	db_bar.size = epf->bar[bar].size;
+	db_bar.flags = epf->bar[bar].flags;
+
+	ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, &db_bar);
+	if (ret) {
+		reg->status |= STATUS_DOORBELL_ENABLE_FAIL;
+		pci_epf_test_doorbell_cleanup(epf_test);
+	} else {
+		reg->status |= STATUS_DOORBELL_ENABLE_SUCCESS;
+	}
+}
+
+static void pci_epf_test_disable_doorbell(struct pci_epf_test *epf_test,
+					  struct pci_epf_test_reg *reg)
+{
+	enum pci_barno bar = reg->doorbell_bar;
+	struct pci_epf *epf = epf_test->epf;
+	struct pci_epc *epc = epf->epc;
+	int ret;
+
+	if (bar < BAR_0 || bar == epf_test->test_reg_bar || !epf->db_msg) {
+		reg->status |= STATUS_DOORBELL_DISABLE_FAIL;
+		return;
+	}
+
+	ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, &epf->bar[bar]);
+	if (ret)
+		reg->status |= STATUS_DOORBELL_DISABLE_FAIL;
+	else
+		reg->status |= STATUS_DOORBELL_DISABLE_SUCCESS;
+
+	pci_epf_test_doorbell_cleanup(epf_test);
+}
+
 static void pci_epf_test_cmd_handler(struct work_struct *work)
 {
 	u32 command;
@@ -688,6 +811,14 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
 		pci_epf_test_copy(epf_test, reg);
 		pci_epf_test_raise_irq(epf_test, reg);
 		break;
+	case COMMAND_ENABLE_DOORBELL:
+		pci_epf_test_enable_doorbell(epf_test, reg);
+		pci_epf_test_raise_irq(epf_test, reg);
+		break;
+	case COMMAND_DISABLE_DOORBELL:
+		pci_epf_test_disable_doorbell(epf_test, reg);
+		pci_epf_test_raise_irq(epf_test, reg);
+		break;
 	default:
 		dev_err(dev, "Invalid command 0x%x\n", command);
 		break;
@@ -934,6 +1065,7 @@ static void pci_epf_test_unbind(struct pci_epf *epf)
 		pci_epf_test_clean_dma_chan(epf_test);
 		pci_epf_test_clear_bar(epf);
 	}
+	pci_epf_test_doorbell_cleanup(epf_test);
 	pci_epf_test_free_space(epf);
 }
 

-- 
2.34.1


