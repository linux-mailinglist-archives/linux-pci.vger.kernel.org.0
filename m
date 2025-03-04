Return-Path: <linux-pci+bounces-22892-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83FC9A4EAE9
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 19:14:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79964422AF8
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 18:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5254827F4EC;
	Tue,  4 Mar 2025 17:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VkoPOMhU"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2050.outbound.protection.outlook.com [40.107.22.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D97D27C868;
	Tue,  4 Mar 2025 17:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741110604; cv=fail; b=BfcMwGHbojJMMW9iAruwpsFcPOP5+xOimTgk2QNpXHri6H0TuyFv/Zn7WL1qy0KwthB71W2eu6JouHSX3h85c+9f7jd0uK5y4V8mrLWRVV5RNy4TsKjYfjqTBs3Q/Ea3yri+7s9wkzGYAO8pISXsGBj7qRbJ46dgyBEjEIZuYpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741110604; c=relaxed/simple;
	bh=r2utdgobkfrXSOYize/edAOscCvHcWtAL66Re5Iy+0I=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=QlytADYqdn1eMPPBBgZ/k6qSJIIxpuSvIfsAxPLiKoilGrt8vs92oThbCj0Gptn5RpaZSlCX/CqAI9njjAqCTYAA5zNy9p0vhGxI2yKHWMYr1CnfwrDuLCH+2sRbC97eW+00DLWJ/O81t+uSV7giV8t0KyTxasN1OdZktzoFi5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VkoPOMhU; arc=fail smtp.client-ip=40.107.22.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TeBV8QGhOSxoAoyeqY3oOs51EyexWlJ6UkVV9wxlkHoYohSN6C5L8hxt3A5Q5wXA/A5SQWKtPAMl5f1hDGvsGW7boR+CdN5XRtujHLiqRw1E8pm6pvJrCVvEykdKvLwNwYeZ3xE+5ZpjxTI2iUfiSCbnsdrbMwixeWuYWRldgKp1UJhrCYvJS5U47JddO2o8l1UR8qCroFhkHLBVncKkW5PgqKlEOgeGoyOqfyAj5qA4QiuUZl/fTfifW/u9akSoEUa4sm+V4Dd0HFoQQkK22CDAXDeHpr0pybQGjZ89kuIvnBSH4NSukO4yD6VQ2BvSA5UdhUH6+Q2eFBxHzcPV4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1KyzKNnAFLWDWd8UvRbH1xzgxfn+F5HKjlO2FJnDdoo=;
 b=gwn1ab2NMc9YBDORuqr6Ig3vMAV0Nyl+FGMynT0YW4VZr9AKC9b3kyWIAYTR8t7a4U2+dHeVG4KCGz2sIFHhMOGyej7nyc/+fOgjwVldQR1+U91IfjqcXNsDl5JD+LO+nwxFAoXCn9UGShit45oNqozX0wRvTpx4uZyBOHojrL2XqWbQSi+n2Ed3wOg3no2pzrf6JFzwNhP7yaU4wymMamgzO9uR5UHo2FSx3MXBXqRQmpEDxG1v8ZuuGwysXtGKU+GHR2b6qDIqS4UDSas3S7mgvgS5dKx+4m+bGusTQ0SCYD3H0PN9V8Lk/Ymk92fgR/wz+yov/3excX7QdyIyYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1KyzKNnAFLWDWd8UvRbH1xzgxfn+F5HKjlO2FJnDdoo=;
 b=VkoPOMhUWvPmIFNUjv6Au4j248xXPJ4HZ6e9cP96MJmPOA/V+qewByj2x7CXByzkhnAvSF4iumzKXB/i2VRfe0P9+bvkybxEVxJnVT72YtMIvZRqxTUdF8KY2oeR7tii+pSNghISyNHLm56Lj3kLwpB+4xBCWSj6eNY5Qw+co9pHhzOJ+CUM4BGDBgUCDudebDDra5XfiZB3p3dyeEJwdnQRSEkgukiENXAvNXTO9pF7NHqKmT3X8Gj9cRHjMBZgG+rgYylRanwFQ6Oy8cSfiUCxaisD+b1/w4TrZ3um7jcR8di9goxOVgZv/wj1lq53nFaOR/iqD+492t3LrvaPDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by PA1PR04MB10504.eurprd04.prod.outlook.com (2603:10a6:102:444::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Tue, 4 Mar
 2025 17:49:59 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%4]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 17:49:59 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 04 Mar 2025 12:49:35 -0500
Subject: [PATCH RFC NOT TESTED 1/2] ARM: dts: artpec6: Move PCIe nodes
 under bus@c0000000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250304-axis-v1-1-ed475ab3a3ed@nxp.com>
References: <20250304-axis-v1-0-ed475ab3a3ed@nxp.com>
In-Reply-To: <20250304-axis-v1-0-ed475ab3a3ed@nxp.com>
To: Jesper Nilsson <jesper.nilsson@axis.com>, 
 Lars Persson <lars.persson@axis.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arm-kernel@axis.com, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741110592; l=4187;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=r2utdgobkfrXSOYize/edAOscCvHcWtAL66Re5Iy+0I=;
 b=OdOjNItza5RThmzWbu5VNXTrXH8ULV/GW8bceJfhpiigotm90ssRlg3xt9CKLDDL9nD1u983l
 YjQvZ/M2v7MCK/Z4dtWKBnLYjzadz+FcvLAFBThRTE+JveLoXs0BFrV
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR08CA0007.namprd08.prod.outlook.com
 (2603:10b6:a03:100::20) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|PA1PR04MB10504:EE_
X-MS-Office365-Filtering-Correlation-Id: 07a28259-9b17-401a-30a5-08dd5b44fbb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UXdpcHpwQnhqb05tOWRnWUhUYWsvbEVOcTV6R1h6VjljNGFwc1hQSXc1SUJV?=
 =?utf-8?B?SDkrVCtER0VxMEhkdlpEN3QrZVF4ZzFwazV4UEJKbWVaNXBGN0UvL0JNaHZp?=
 =?utf-8?B?S3B6V0ZSUkhFeklXZGJ4a1FFZkQvM2Y2Q25VbFRndkpvVE96R1ZBOU9pc0d4?=
 =?utf-8?B?VUlEbXBlWk9LTVlFR3VpdzVtaHQxWHZuREdqSVZlYzdqWTU3SzdUMWQxaFdG?=
 =?utf-8?B?bHdvTlVpWDluTzA4MXNQZGx2bmhBWlhROGJhYTk5WXVXaWxkRFlmd0M5alpT?=
 =?utf-8?B?VHZtTnBURzBxd2pyVUNSM3pnbzl5dTMvT0VsWnpjSmp3QXZweDluL2RBZWc0?=
 =?utf-8?B?N0FMSk9PVDlPVTNNNEhSVlFpTngxSGVzeTh5NW9FNlVMb0RrYjJuYVZsR3d1?=
 =?utf-8?B?UFFmY1gyQ0YrL0tIU0l2czJwZ2swSkhGeGtNdW5JdkFGVHY0eW5jWGl2anhJ?=
 =?utf-8?B?MFBPSkNvRHNtNXVBQkZaU2FoMnRnL2RtVG5TVkgvdW8yNXpFd2ZvSnNHVDJB?=
 =?utf-8?B?NFVyeWIzZElKcWZpNG5wdDRSdEt0Zlg1dmsvdVNtT2RZM1NTMWVYQlhwWnll?=
 =?utf-8?B?Umk5WlMrTzhxVklBL0FseWY4TE1pRDUwNnRwNFJEczZvb3lzeHRabk9SZ0k3?=
 =?utf-8?B?NzJEMWFteFhVRUZPamdDTzNmZmNlbW1oSWU2T2R6WnAzdVF4cmdJTFNTNlJI?=
 =?utf-8?B?R2xuMmJ6K2xKNXpzdWQwZUhFbCtiUDVoZDMxeDdFdXZuR3JCalBkQytHd09F?=
 =?utf-8?B?aGRVYnRycGtLR1BTZm1XMVJ2Si9hWUF4emRnWGF4S3cyV3FhUFFuSUJlZ0xq?=
 =?utf-8?B?SjE4TUlPQ1JxZW9uVzRoNDBORkF6VlBYM1FFUG5sUUY2djFJdVBBWTlua1cx?=
 =?utf-8?B?NTR6MUhya2RNV1B4c00vaE5RbEoyYjhHZGlWWUMyaENVcy9PUWp0Tm0wRUt2?=
 =?utf-8?B?ZUgzTUZ0Rm9LZ3Yva1VTa0NYZC9JSm0xdnhQRDdWZkUzRURoTldmMWlyWk1Y?=
 =?utf-8?B?UTUxZ3RKalZkNDhlMzlZN256MGc0NnN0WGZTL1NFUTBYd3hwOVdDdWpSTmsv?=
 =?utf-8?B?VU9kWVZvNTZuK2FqcjFJc0pLcVUySGxCeTduQ24wWWg1Q01jWTh4S3o4MlBF?=
 =?utf-8?B?UzVNWlhWR3N5MDhpYk9lRzhzQ2p5WkVlV2ZxYjljb0FqN09wZWZSTzF1RlIx?=
 =?utf-8?B?OTNWeWVYcGlnQXVNdDMrb2JWMHdiaFl5OERhK0ZXdmFmQ0o5clAzWFcxSC9u?=
 =?utf-8?B?M2hRVUpkZ29RUFdMdy81c0JCcEZwNGYrWFQrTmhld3AzTXFtR3FOYlZmeEJy?=
 =?utf-8?B?RW9Fa2Z4ZkJ3azR2MHJCN3J5Q25oMnVCc2NRSEwrREd3aFVWZGlTSkxVVkZ5?=
 =?utf-8?B?Z0YrOVhNR3FPTjJQU1BMc1pJK2d4YStLNEdWbVcwQWkrY1RCaEE0NzVoRHpm?=
 =?utf-8?B?VU9DdkJ6dlBnbjBHWnlCT3p0SnkxS25yYWd1a2ZrYjZJQnF2ZDllRnFoTEdB?=
 =?utf-8?B?V3NkbGYyNi9tVnRpZXBkNjJ5bHYxaDNZUkw3M25VRFd6dFhueVNZMzNJaHF1?=
 =?utf-8?B?aXdaRXl1dlhpUmNEOTZLZm16RWxUbnFYWUlwSDBLRG93NS9oaU9YVUxMeHVI?=
 =?utf-8?B?MmU4bC8rTDhlbzJBaFdwUHZWU2UxSVZ0enNNUXdhS0t6RW80dHVteUVSc1Yy?=
 =?utf-8?B?VVZ1ckdiM1BVVENoRHU0UVhIS1M0anp1bnNyTGxGQWQ3MkxZMUhXOE02SlZr?=
 =?utf-8?B?aGppd3JudUhrRGRBbGt0QXlCZm5ZaDF6QWRTVzdndm9IUzdKcjVMUjEzZWxl?=
 =?utf-8?B?ZnBjVHV5ZHRTNDhSZ1FHd0EvMm02UHdrSExaUUQvL2Mwc29PemNZVFlWNXJO?=
 =?utf-8?B?ZzVqUUxmVDdSWmRRTUFlTVFVbEVZMVZMUGM5Rnh5Tk9UdzhmYXJILy9GVG9m?=
 =?utf-8?Q?/o6fH1iaiIahOvhhHwERyjGLfgA+cc4C?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q2JFby9USWRqTS9KbzkrUC9tMDNqT0luMnZqdFp0QytQeGNqWkhLR1E4Y3RD?=
 =?utf-8?B?dURzS0hYS2lNeEZiemc4V3pNbjhBNTFsbkVjOUlnRVI5OHR6VEloSXd5OVRo?=
 =?utf-8?B?YnVFTnd4SXA1R3hSM0kycjc3bUF4R2ZNMGluaEtBQmQ0NXBTaVR1d2ZIS0Fm?=
 =?utf-8?B?eE92N3gvL0M0ZlowR3YwU3JybmZQdmM4L0hsRFNiZFN5alhCMzQ2RlRySmFR?=
 =?utf-8?B?WGU5c29RYXJ3TEZ6VldEaU9GRkxHWmVjUGt1MUdEMVFGS2pBN2MrM0pJaG1T?=
 =?utf-8?B?UU4xVE0xaFh4cSt1bUJqZGJ5RDJ2ZFZtK0FhVmdRRlpvT2xEcGJFSE1PUEFY?=
 =?utf-8?B?WVZmL0JMNUZYanY5L2Znd213Q045djM5bVBEU0Foc2ZsVkRwTEJGRWxpaSty?=
 =?utf-8?B?NWhpbXNhUCtTdWZxWjhTUm9IYkV2SVpEbmFoMkpqREdKTlZkc1NDa2l5NURK?=
 =?utf-8?B?UlhEK0l4bm4zNm9UYm5vYVBnMjFkRlBDQzRpL3RhakpkNDF0OU52eCs0b2I0?=
 =?utf-8?B?VCtmSWxiVFVidHBqL2JjZFBveGFKaW4wRDh4YlVnVFNWUnZWZVNoaTY5ZE5B?=
 =?utf-8?B?emEzSmpaTUFNY0ZoekVsbEk1THVNam5wa1dHSk8wRkNFQ3BaYWo0R3pVUmR2?=
 =?utf-8?B?dEVEMjNiVXUwdktjb1JuUGRxbmlVNS9vN1FpSUJ5ZWlzTDFVTks0aXE1cTh6?=
 =?utf-8?B?MEtTeW5QRmx0Y3VKaE83RGI5RWkxejlBaThBK1ZkWE1GMkdUSWxHQXdYMVFZ?=
 =?utf-8?B?Q2dPcGJVZ01TSTFwZzV0d1ZkU2dxVUdLaHpmZUhVRWtucHA3eTFDNzI3elNU?=
 =?utf-8?B?NEwzRWZaT05xZ2cvM25UbE1pZW5zaiszWUJpT01YNyszaUxOWndNVTZTVDR4?=
 =?utf-8?B?VmZ1NlE3M3RmMS9IbGU5Wmc0QlJzT0hRZHMrcE9GWk1ZOXQvRGswZnVBb00w?=
 =?utf-8?B?ZFh5SFl4cnNHUGJiMkkxcTVOWGViMXdIZXA5MEdHZ1lUUFcxT3hhb1FEUFdl?=
 =?utf-8?B?UUJSZGNwVmV6L2pPbkxxRDNZM3NGRUg5ODdUaVlGbkVxOU1xUWZRNlBJUzc1?=
 =?utf-8?B?ZG5VTG1FY0ZTQ0FiOHZvakM2TzFkMUhpMUJRMXBqSzJuSGRLNWMrN1AzdlRy?=
 =?utf-8?B?dXBkRGYyN2dEMzZ3UzRoTU9TRm5ieGJocExEVDZCT0FGaEFWL3lna2ZhWjg4?=
 =?utf-8?B?VzNmQUhCekhkKzZtMVRBc054bkJPK3lhaVdlZEJPUnhqaHBnZE9oVzJOOHJX?=
 =?utf-8?B?OVFLcEZoUlJtNHN2eGs5TzlFMEZLemxzWGF1eXRmZEtZS3Bkc2g5bTZNeWtP?=
 =?utf-8?B?amhDSVA4dWx5S2ZuZUQxcmkrWC9WL0FkY1dkcldGS1JMdDdNenVhK3hMVVRL?=
 =?utf-8?B?Mi8xS2lnVWJ5d0lBam94QUV2bld1b3ZSanhJZ2J4Tk81VnRjT1drVGRiRU9W?=
 =?utf-8?B?UElHQ2kycnRnOURtVGJGUkxSaW9mTkkwQUdGUC9sYitZb2FsOXFvTTlHenp1?=
 =?utf-8?B?cUhJeFpsVUF6R3dSUnJ6RFR4S2VxZFdBMndDTzkxN3I5ZW1ITm5rVDZWUFpV?=
 =?utf-8?B?VlBwaW5mVVBwSk95VDFFdmFZSmorUWxKVmFZUXJtUGUrc3EzZ25XZWJJTEdu?=
 =?utf-8?B?Uk5OM2FBSWRNMkt2clhGOUZ3UHFnNC9aNjFCaXA0L1V2aHNvRktVVXA2YWgv?=
 =?utf-8?B?cGpPajZnMzc0NkZ0Y2RZM3MzVGd1SXNLenBwQ1RuUy8wbmFZMEUzUHoxdVNX?=
 =?utf-8?B?QUFqWmNMT3pLbHE2WlMvbEszZXlWakJ5L0VSN3laY05wR3ZkQWFxVW1OZnZ3?=
 =?utf-8?B?akpoMHZucGFYRlBzMFpEektoK0p1Uk03U24xc1FEM3FYK3BScWh0a1RveCth?=
 =?utf-8?B?cWZIRlJjOS9HRTFKRERFZlp6OTVPc1dlSjU2cGV4RkM3YW1Md2ZMWFVtdzhL?=
 =?utf-8?B?UmlpSWNIYlE5TGtPaFZxMWk0alh4M0YwUGdYekJWSnduNTYyZ082eHpLRHBD?=
 =?utf-8?B?QWhoMUQyd0FaaEZab2x1RXhQdHE3Sk5vRXloZXRjbGRvU3JVajFhbFZHUE40?=
 =?utf-8?B?T3NKbnMrZEZwaWJKMjVVNGNPR0pKZDRsZ0xHRWt6VzNFYTFIcllVMEhkeit2?=
 =?utf-8?Q?zgi0UYPAO8CSvdBlK2y+RPDVQ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07a28259-9b17-401a-30a5-08dd5b44fbb1
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 17:49:59.6380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gQRO1LlNYBOVpNu38pTCXFqhc6FIk/j25kOVL/COH/FCS572es6kCm1rDWlbX/w3k7rScvhYa6yMqtsuKkYNqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10504

Move PCIe nodes under bus@c0000000 to correctly reflect hardware behavior.
Use ranges in bus@c0000000 to indicate address translation, as the bus
fabric trims CPU address 0xc000_0000..0xdfff_ffff to
0x0000_0000..0x1fff_ffff.

Set 'config' and 'addr_space' reg values to 0.
Change parent bus address of downstream I/O and non-prefetchable memory to
0.

Ensure no functional impact on the final address translation result.

Prepare for the removal of the driver’s cpu_addr_fixup().

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/axis/artpec6.dtsi | 92 ++++++++++++++++++++-----------------
 1 file changed, 50 insertions(+), 42 deletions(-)

diff --git a/arch/arm/boot/dts/axis/artpec6.dtsi b/arch/arm/boot/dts/axis/artpec6.dtsi
index 037157e6c5ee3..399e87f72865f 100644
--- a/arch/arm/boot/dts/axis/artpec6.dtsi
+++ b/arch/arm/boot/dts/axis/artpec6.dtsi
@@ -155,49 +155,57 @@ pmu {
 		interrupt-affinity = <&cpu0>, <&cpu1>;
 	};
 
-	/*
-	 * Both pci nodes cannot be enabled at the same time,
-	 * leave the unwanted node as disabled.
-	 */
-	pcie: pcie@f8050000 {
-		compatible = "axis,artpec6-pcie", "snps,dw-pcie";
-		reg = <0xf8050000 0x2000
-		       0xf8040000 0x1000
-		       0xc0000000 0x2000>;
-		reg-names = "dbi", "phy", "config";
-		#address-cells = <3>;
-		#size-cells = <2>;
-		device_type = "pci";
-			  /* downstream I/O */
-		ranges = <0x81000000 0 0 0xc0002000 0 0x00010000
-			  /* non-prefetchable memory */
-			  0x82000000 0 0xc0012000 0xc0012000 0 0x1ffee000>;
-		num-lanes = <2>;
-		bus-range = <0x00 0xff>;
-		interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "msi";
-		#interrupt-cells = <1>;
-		interrupt-map-mask = <0 0 0 0x7>;
-		interrupt-map = <0 0 0 1 &intc GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
-				<0 0 0 2 &intc GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
-				<0 0 0 3 &intc GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
-				<0 0 0 4 &intc GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>;
-		axis,syscon-pcie = <&syscon>;
-		status = "disabled";
-	};
+	bus@c0000000 {
+		compatible = "simple-bus";
+		ranges = <0x0 0xc0000000 0x20000000>,
+			 <0xf8000000 0xf8000000 0x80000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
 
-	pcie_ep: pcie_ep@f8050000 {
-		compatible = "axis,artpec6-pcie-ep", "snps,dw-pcie";
-		reg = <0xf8050000 0x2000
-		       0xf8051000 0x2000
-		       0xf8040000 0x1000
-		       0xc0000000 0x20000000>;
-		reg-names = "dbi", "dbi2", "phy", "addr_space";
-		num-ib-windows = <6>;
-		num-ob-windows = <2>;
-		num-lanes = <2>;
-		axis,syscon-pcie = <&syscon>;
-		status = "disabled";
+		/*
+		 * Both pci nodes cannot be enabled at the same time,
+		 * leave the unwanted node as disabled.
+		 */
+		pcie: pcie@f8050000 {
+			compatible = "axis,artpec6-pcie", "snps,dw-pcie";
+			reg = <0xf8050000 0x2000
+			       0xf8040000 0x1000
+			       0x00000000 0x2000>;
+			reg-names = "dbi", "phy", "config";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+				  /* downstream I/O */
+			ranges = <0x81000000 0 0 0x00002000 0 0x00010000
+				  /* non-prefetchable memory */
+				  0x82000000 0 0xc0012000 0x00012000 0 0x1ffee000>;
+			num-lanes = <2>;
+			bus-range = <0x00 0xff>;
+			interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi";
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &intc GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 2 &intc GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 3 &intc GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 4 &intc GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>;
+			axis,syscon-pcie = <&syscon>;
+			status = "disabled";
+		};
+
+		pcie_ep: pcie_ep@f8050000 {
+			compatible = "axis,artpec6-pcie-ep", "snps,dw-pcie";
+			reg = <0xf8050000 0x2000
+			       0xf8051000 0x2000
+			       0xf8040000 0x1000
+			       0x00000000 0x20000000>;
+			reg-names = "dbi", "dbi2", "phy", "addr_space";
+			num-ib-windows = <6>;
+			num-ob-windows = <2>;
+			num-lanes = <2>;
+			axis,syscon-pcie = <&syscon>;
+			status = "disabled";
+		};
 	};
 
 	pinctrl: pinctrl@f801d000 {

-- 
2.34.1


