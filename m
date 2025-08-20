Return-Path: <linux-pci+bounces-34419-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44877B2E827
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 00:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF0D7A23C78
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 22:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0B025BEF2;
	Wed, 20 Aug 2025 22:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KSwNIx58"
X-Original-To: linux-pci@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013011.outbound.protection.outlook.com [52.101.83.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFF6296BB6;
	Wed, 20 Aug 2025 22:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755728728; cv=fail; b=CZDRmEdeLYnJAS79ehjB4mDg6X3TjnFRufTASzCpqrs+Cq+4kWnI4/sJZNZYmmtjAsE+kl9SJvXKhCdpmYavZ8PoZ+mP07G9/MLNX7Ig4bYxCC58KIwi4JLoq9c4erBNYGiA4SdY6wKldkWKaAvu5aSj+j9hVojosg5fQdOjRUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755728728; c=relaxed/simple;
	bh=/MyvHqPvWaD35Dh0/9WsyyFDenx5X3Z+31Jjyt+fgjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=E9simpCiVnDase5RQ6b1Nj1dA3kP+7l89R+zjLmCeMageCcX1SDfsJpTgq8TqNj3ww4fDvUrRyI/YFYp+Wtg/3C/9NXNfnfjlRn2j6my8gbuL5DPe69fVmkODtzlaGXd3s/GVDMzlT8XjuNO1YHqgMG4N3ql96UVr4iGngtgP+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KSwNIx58; arc=fail smtp.client-ip=52.101.83.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oqeNhDcdXRjCHrEo1ryuxLGv1D2uXY+wgdLsIv/RYEccZkjupthnR6UQQuHvQzjJfkikcvH/p/f0mFOpIpaNNuuu5f53U34FwLopZamZkR/C+eOrwZteVDJ8nu+yQZ+iQJbf0dOrocIqncNufXnf54/XFSn5zoTCc3fUoI2sj060fChMTFTRkCxbpHecb2dea9n8NtB0mHuB/UU8vfa3R4CH7+m84S1EruIQ6ckK5BajrbipbYsXsWCkOq3Hk/j5CFGQ/MI1L1ZkUHyS7WxcWwbRUC229hcIF9T6yUqayCt/ZxNUjQXqStdCVvDPGfNOZBYjO/l9ONS+ENsIp57PaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h8ZE9ixDV5+s2Y11Mhe6P5k4WTx9FJFqSZ+plsd2A1Y=;
 b=iHLduoMTk54InazD4ptmQTA2qkUcRrZ3UOraoq/BPjOofomgZiUK+WYmAo44TQFHeyewAwk0eAmwFDeB1WYnmDXWB1ygkY1uMzTN3kBbVyEwjVDn//LEFqY6rtgJ/orYVBZ8sVGeoe1EbZu3jbGybIwicNZoMeBK/aZTwEVkBN0M8Zn7+To/icaDsNGV9TI5ZdM1J5sQazqgHXpIp6WA1Cs8VoxhYrYMm6S4yUKph/NLJfTocXPcNto3XrxEO0j5b5V09tKkZmLY/mrmf3bAyj1ksz4c5zhGHgE03iBarnBOpLKBpVwHpLWmaiqgD5I5vAUGLf/aJqoM5qdcg1tZ9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h8ZE9ixDV5+s2Y11Mhe6P5k4WTx9FJFqSZ+plsd2A1Y=;
 b=KSwNIx583rP4cR7UsX7cH+LVb9kCjGucpBW1aRWUFNsTkFlvFYuQQZ0ri9xsdOYUvo3o3YQ8xG8CQkiY7g/xi0TRtk4DgZwfUtj2vSkgp1Tllz7iUDm5UKDf33jlByDAzfKg+VxOyrCyFmWLColsB2FgCoudfbo6ocdA+QHtiHEN2BdcSdx5MXuFuXdfNnJu5ynNIw21GEYiyyIa1Z9kVX01RnnMlUgu05Vs4yyWBrN5bthhWHGPep65LTIUdGs3p5+d55k0Co6IKVLosg5Jl7Sbne9OXixz4f9JmRzRQjLxTIhZ5WDtg8DktCs186OYk7BN1wAx5ipOQ7OvmdAG9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by AM9PR04MB7524.eurprd04.prod.outlook.com (2603:10a6:20b:286::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.17; Wed, 20 Aug
 2025 22:25:22 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%5]) with mapi id 15.20.9052.012; Wed, 20 Aug 2025
 22:25:22 +0000
Date: Wed, 20 Aug 2025 18:25:13 -0400
From: Frank Li <Frank.li@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Richard Zhu <hongxing.zhu@nxp.com>, l.stach@pengutronix.de,
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	robh@kernel.org, bhelgaas@google.com, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] PCI: imx6: Add a method to handle CLKREQ#
 override active low
Message-ID: <aKZLSSsEacH01suz@lizhi-Precision-Tower-5810>
References: <20250820081048.2279057-3-hongxing.zhu@nxp.com>
 <20250820214010.GA641668@bhelgaas>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250820214010.GA641668@bhelgaas>
X-ClientProxiedBy: BY5PR04CA0009.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::19) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|AM9PR04MB7524:EE_
X-MS-Office365-Filtering-Correlation-Id: dc6e5f9f-f8a1-49e6-1b65-08dde03873bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YkxQcEI5ZDd2SHpxS1grN3ByeE5ZbFhLWWdCNy9wY01rMFFoV2dHSWpBeGQ0?=
 =?utf-8?B?d3g1TUNKZkNxVUdDQlBKNTVaOUJtUndxSVkzc1N0WEFPM1Q3cHVDcXQ5S3ZC?=
 =?utf-8?B?Sy9oVEhTVjdMUjhMbjRxczIrb2tiUnJyTmhFa1VHdFpjYitoMFNJcjhBbW51?=
 =?utf-8?B?N2hXU2g4ekt1d3ZIM1JjNmNSa3JDeElkK2xQN3pKVGM5T3JnNWMwai9YNzRU?=
 =?utf-8?B?T2Rvays5dEZFRkdzMFhDMWNnRmRpV01tdmlWMGg0Y1NHcWhISm1pb1QxbVJV?=
 =?utf-8?B?ZU5YVVlxS2wyTkhVMWJVeUpWYXQ2S3pURGd2b21HbkNnMHF5RW9IZGF0cWUw?=
 =?utf-8?B?K2pYZ2xMK0I3SlljbE5ya2V0UGRKVzNycTd4NmdZUUxaTUkwZ0htM0hzcG1l?=
 =?utf-8?B?bnl2RnhvSkZYR1JaRjJiWE9Ja2lUbnhRZTcxSlE2c1VYRy9ydFJ2T3RUMkdD?=
 =?utf-8?B?Z2VoeHoxdTlBOWUrYi9qQVJoZGZnS3BNR2dqeXVNL2RaMXZ0d3dMbURaZmRU?=
 =?utf-8?B?dVRNRFZjZTFrb1ZzbWQxN2EzdVpxUEFoeXlGdjk3TUFxK3NHTlYvZkJxWjdq?=
 =?utf-8?B?TlJibnhKbkJMK3pWczhsZktMK2ptZFlTeWZ5RjVvT2hYU0Q2dGh2c2N0YnYv?=
 =?utf-8?B?UmE3WHQxOHVxU1RwRXQ3bHVGRzVGTkQ3T2lsdVZxTXlZQWhwRm81ZGRlVnJV?=
 =?utf-8?B?WU52ZjhkZFNhZ3lpYTVLb1dvd1luTVUxOXVLZTgrNW10UitpN0wrWElGV3pj?=
 =?utf-8?B?STRVWWRTOGsvSWdBLzM0ZWtTUW1hZGhOUGpOQVAremJwQWVYUk4xM0U4QWJD?=
 =?utf-8?B?MXRGRUEva09rb0o1VGpBWURtWjBLNGVCOHNNQ0cyNy9ERFlGR0ZDai9Hczdw?=
 =?utf-8?B?aGFmUklxZG5BQ1hCZmx2WlV0SzZlZElDNVdlVUdBTDRGbElRd0JPbEorc1pz?=
 =?utf-8?B?RFRDN3pHTmR3bFVRTnR1MytRWDUrUm5PbkhwYUliMkdTZldMR05FeXA3T0xj?=
 =?utf-8?B?TnNKREcveENkU2hnZnFxaXRGMjZNUGpNaVJJL1hGMlVpMGRqNzNGbW16NzFm?=
 =?utf-8?B?UUxIZ3N0cjNNVGRvN2ZJU2VqWFZlb2VNaFcwbEtTMjgrWkwxK2F5NDVFMWVD?=
 =?utf-8?B?VWc3a0paOVF6QTdSYTZCL0VCdGJDWmtkTWJFSU5tL3RKdEcyd1Z0UDZFVUFZ?=
 =?utf-8?B?OFV0aEh3NmIxbnE2dytKSkZuVkhwbFJDSFhvOGlaY1hBZUlCZm5HTzdhNERi?=
 =?utf-8?B?aGxSZ3oxV1QwRDZTTEVYMXFhR2hjNHc2YlQ4WEMrcVNUTlU5dlNlbGw0bUR4?=
 =?utf-8?B?NHJqN0J1S05oMHZpTzkxU3N3bGo1Mk9wR1dmQ0M5dGlGRm1EYkZ5bGhQT01Y?=
 =?utf-8?B?QkFaN2t2SGRsUnpMcFhPRExkMHNDb1hxdFFzbVpnOXRUTllEQ0NJVnVlNEZ3?=
 =?utf-8?B?M2lqZHZRbUxFQjk3WE1tVWVPWVQyZ1dONWNrTnQrRWxWejJKeWJMcWFQVmY3?=
 =?utf-8?B?c3EvcFVqREJLdWd4VFgyYlRZaElaYmkrRTNjSGhRQllZSUdJVHJWOXM0cXhH?=
 =?utf-8?B?UFZJNkdoZjEyZVlCNkRVTmYzSmdxZ1RvWkRpR3MrbmhQUGE2WEQyT0NLVEpS?=
 =?utf-8?B?ajhnd2tqZWNFa1dEUDAvbSt3NFJBZDVvVFVVYmF3Um83SmR0R25pYkhCUFpi?=
 =?utf-8?B?NSt3T2FKZEdtVURtUkVjRnRuQkFQSjJSRHp2blpJMVdSNW5kMnE1aTJqT21F?=
 =?utf-8?B?OU9rSzNNRTV1dC9ZY2tyQnZ6bXM4YWdoMkU2d3lta2tmZnhGUTh3aEJEVExH?=
 =?utf-8?B?a09oSjk5NzkvQnVwcUo2N2E5b3RLdHFIQ2lKNHVhMmpXQWZraU1kc3Q5elBv?=
 =?utf-8?B?Sm5YRWZ1QzZ4UCs1SjVTa2IrdTdOeXNtQ1JnZ0h5azhJZndGSDdGQzNiMHV0?=
 =?utf-8?Q?HX6f075dpk4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?STlDclNXak9UMFpUcTJEUmVyRzR3OU91aHowYm10dlA5cTlMR0l1aUR6ZGQz?=
 =?utf-8?B?SDQxekpNL2NHY2FXWWlzS1NReGZIbzlucGdCWUZ3alhhUVR4TzZuVjF3aGlO?=
 =?utf-8?B?dDFQV1NaN1ZoMDAvNVdkOHNoazJySy9hb1Fabk5SdVc0SlZ0M2tOY2JLeE5t?=
 =?utf-8?B?bjFJMG1CdmZ6NUJtWUJMVGVkam1wT20rbCtCNGF4Yjl0bzNPUndDd1hmWmJj?=
 =?utf-8?B?MXNTS011SllzMER5L1RJYzQwY2FWOERheERXMFUrV1lzbFJYWEJCcGRlbEJh?=
 =?utf-8?B?eHNBVjduMVFienU0b3dvaStoUkpna20yNGpUMXlHSm9BVE1MRllWa0YyL1NU?=
 =?utf-8?B?SDVmaFkrZmlOTlhpSHhvMDhRN0I1Y0tHdnZUVkplNjRGY1I2SExJTVpKTE1V?=
 =?utf-8?B?YVpGL1prYThOUHBpRmVBeFNSeFRCQmoyMFhDMGhaaURqUkZ4aUQ4NlpZTDZH?=
 =?utf-8?B?bDZEUGdLbDZiR0U3anJmdm5VaUVKb0IrRkdLZUF4U3h1UHZENVRlN3pFY1dm?=
 =?utf-8?B?Zm9TWmN4MVZZaDk4VnU4VmxIbDEybUsrYitFTVUzZ2hWSGk0ekk2TGJOVmZh?=
 =?utf-8?B?WU93bVUvU3RLREVMVXpoZ0o1UkNtRDJHV3dDMTZQVy8vMnBzSlJqb1dlRTdw?=
 =?utf-8?B?WmFXTkZwWDRxTGNacTU3eWhQbjlCRWl0d003UmZrd2ZwNkJXWXBYakFBRXpZ?=
 =?utf-8?B?NnBEOVlub2c2ckN5R25BMHlDWHduZ2FxdkZSOW5wNVorK1c0UmpjS29yblRX?=
 =?utf-8?B?WmZVNTBmOXpoaEJxVEhmQ1d1Qmx3NlI0bHBIRHNHclo4TzJJNnBQbjRFRXhs?=
 =?utf-8?B?RmljcXNjbHhwY21CVlpPWlpha1A1M0NNVFJ6aDkrSzNCVGEzK29TV2R2c2Rq?=
 =?utf-8?B?Y3oyb0d6L284UjBHeU9BdzlmMGFlNWhuS1o3Lzd4SVJFWlBUdTBUeWFmSnhu?=
 =?utf-8?B?SEtVSVIweDhFSm5MSGZRT3ltaVo5SWVZa3gwYWhRNUVMdzdQWk5VNTN1TGJJ?=
 =?utf-8?B?a1FTR1NXL1hiYUxDT3BpQUtQRGgzOG5leFFZdEYvZTNjYUgxb3l5L1I0aUpn?=
 =?utf-8?B?dk94dGRuaGJ4VFUzTlovZ2xBRXVJNjlmMGdxMndmKy9YdTFiRFAwaU10Mlp1?=
 =?utf-8?B?dTgwbEFTM2M4aHRpOFBZMnUwUmJNMW9UTlNLSzJnODIrNU1qUGNXdDJNdEdO?=
 =?utf-8?B?UTJ2d0JrTC9wOFpKT2xnTnVheW9sV2pieE1MUkNKajYrM2d2SlR3T0U5Mk1i?=
 =?utf-8?B?azcvdVV4LzVoYTVqR204WWdab2tHZHppNXN4dm9NMGpUbGZEM0k5SGExYzVI?=
 =?utf-8?B?OUt3YlgwOHJZQ0QvWTB6Mnh6Vk9uV0QyNldOTEV1bkE1ZWNnVTdvYmpqK0cr?=
 =?utf-8?B?TlZ1UTFQS1dkT1ZwaTZxcW13ZDhtZURRaFFuOERFZlZ3R000eXl6VEVOSTRY?=
 =?utf-8?B?RHhKWkFaanNWZ0ZQTTdCNFg4NHNoSTBUTDdHK2tGVkd6RXRNNEtieFBQbFpQ?=
 =?utf-8?B?UTVnd1ZHWk9EUVJNMkEzYS9McGhKUDE1ZFZGbFRXbDhscDBkYWZ2QzNNVDV1?=
 =?utf-8?B?OUhvVW85TDBVYWdaNTFTcEhLa3A5Tnh4Q2ZNdkR1QnNKMjB5Szc3ZzdoQ3hz?=
 =?utf-8?B?S25Sc0VBektBQ21mTVNBdk9lWDdiRjE4aVNHSlloM0s0VzZiZDhYdDNuakhn?=
 =?utf-8?B?WnJUUXZZLzN2R1pCb2dPS3Z1eS8wMGtEa1RjTVVMUGRmSnhOZzlaZ2l0cGRs?=
 =?utf-8?B?UEFXMVl4WnJxVGJMTUNFdDFmNUMyMHpCOFpwczRIaWVGSzF6Qk8vM1pGK0wy?=
 =?utf-8?B?Z0YxSzRRRTAwdHQySHhLcExKdHJNUGJEMVlMZFYvYi9ZeGxRa01VSWVHbFgx?=
 =?utf-8?B?ckFFVjhHWTF1TTcyZHF4ODRJU2htSkJHck1zYnZ4TGc5OEhhc0QwNk42RDlI?=
 =?utf-8?B?eTR1SmhiV0dtcm81bWpHcXNHaGN4b2FWOGdKNmtuUFBMTjBTVVYvQ0MrVkRM?=
 =?utf-8?B?ZHBteXYwR29aQVBZVVVkV1VCL0ZBTnNaM0Qvd3dOWVFIRFpYUFM0aXRIVmc3?=
 =?utf-8?B?dE8wZjZxcmUza3hEUVZ6ZE9ZbElDRWpveEp0a1kxZjZYN0FiMUlOWnQybkVF?=
 =?utf-8?Q?k63Vx3PaU27zOIy3W1Ey6U9sZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc6e5f9f-f8a1-49e6-1b65-08dde03873bf
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 22:25:22.5247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7JzkPPmnJdwZag0hoVr029xv+ig6VGt61kSEalXsteXl3O+XywhAnn8gWX4NWe4ey8Cf7MhD5CYLcbBmJTNQSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7524

On Wed, Aug 20, 2025 at 04:40:10PM -0500, Bjorn Helgaas wrote:
> On Wed, Aug 20, 2025 at 04:10:48PM +0800, Richard Zhu wrote:
> > The CLKREQ# is an open drain, active low signal that is driven low by
> > the card to request reference clock.
> >
> > Since the reference clock may be required by i.MX PCIe host too. To make
> > sure this clock is available even when the CLKREQ# isn't driven low by
> > the card(e.x no card connected), force CLKREQ# override active low for
> > i.MX PCIe host during initialization.
> >
> > The CLKREQ# override can be cleared safely when supports-clkreq is
> > present and PCIe link is up later. Because the CLKREQ# would be driven
> > low by the card in this case.
> >
> > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > ---
> >  drivers/pci/controller/dwc/pci-imx6.c | 35 +++++++++++++++++++++++++++
> >  1 file changed, 35 insertions(+)
> >
> > diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> > index 80e48746bbaf6..a73632b47e2d3 100644
> > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > @@ -52,6 +52,8 @@
> >  #define IMX95_PCIE_REF_CLKEN			BIT(23)
> >  #define IMX95_PCIE_PHY_CR_PARA_SEL		BIT(9)
> >  #define IMX95_PCIE_SS_RW_REG_1			0xf4
> > +#define IMX95_PCIE_CLKREQ_OVERRIDE_EN		BIT(8)
> > +#define IMX95_PCIE_CLKREQ_OVERRIDE_VAL		BIT(9)
> >  #define IMX95_PCIE_SYS_AUX_PWR_DET		BIT(31)
> >
> >  #define IMX95_PE0_GEN_CTRL_1			0x1050
> > @@ -136,6 +138,7 @@ struct imx_pcie_drvdata {
> >  	int (*enable_ref_clk)(struct imx_pcie *pcie, bool enable);
> >  	int (*core_reset)(struct imx_pcie *pcie, bool assert);
> >  	int (*wait_pll_lock)(struct imx_pcie *pcie);
> > +	void (*clr_clkreq_override)(struct imx_pcie *pcie);
> >  	const struct dw_pcie_host_ops *ops;
> >  };
> >
> > @@ -149,6 +152,7 @@ struct imx_pcie {
> >  	struct gpio_desc	*reset_gpiod;
> >  	struct clk_bulk_data	*clks;
> >  	int			num_clks;
> > +	bool			supports_clkreq;
> >  	struct regmap		*iomuxc_gpr;
> >  	u16			msi_ctrl;
> >  	u32			controller_id;
> > @@ -267,6 +271,13 @@ static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)
> >  			   IMX95_PCIE_REF_CLKEN,
> >  			   IMX95_PCIE_REF_CLKEN);
> >
> > +	/* Force CLKREQ# low by override */
> > +	regmap_update_bits(imx_pcie->iomuxc_gpr,
> > +			   IMX95_PCIE_SS_RW_REG_1,
> > +			   IMX95_PCIE_CLKREQ_OVERRIDE_EN |
> > +			   IMX95_PCIE_CLKREQ_OVERRIDE_VAL,
> > +			   IMX95_PCIE_CLKREQ_OVERRIDE_EN |
> > +			   IMX95_PCIE_CLKREQ_OVERRIDE_VAL);
> >  	return 0;
> >  }
> >
> > @@ -1298,6 +1309,18 @@ static void imx_pcie_host_exit(struct dw_pcie_rp *pp)
> >  		regulator_disable(imx_pcie->vpcie);
> >  }
> >
> > +static void imx8mm_pcie_clr_clkreq_override(struct imx_pcie *imx_pcie)
> > +{
> > +	imx8mm_pcie_enable_ref_clk(imx_pcie, false);
> > +}
> > +
> > +static void imx95_pcie_clr_clkreq_override(struct imx_pcie *imx_pcie)
> > +{
> > +	regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_SS_RW_REG_1,
> > +			   IMX95_PCIE_CLKREQ_OVERRIDE_EN |
> > +			   IMX95_PCIE_CLKREQ_OVERRIDE_VAL, 0);
> > +}
> > +
> >  static void imx_pcie_host_post_init(struct dw_pcie_rp *pp)
> >  {
> >  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > @@ -1322,6 +1345,12 @@ static void imx_pcie_host_post_init(struct dw_pcie_rp *pp)
> >  		dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, val);
> >  		dw_pcie_dbi_ro_wr_dis(pci);
> >  	}
> > +
> > +	/* Clear CLKREQ# override if supports_clkreq is true and link is up */
> > +	if (dw_pcie_link_up(pci) && imx_pcie->supports_clkreq) {
> > +		if (imx_pcie->drvdata->clr_clkreq_override)
> > +			imx_pcie->drvdata->clr_clkreq_override(imx_pcie);
> > +	}
> >  }
> >
> >  /*
> > @@ -1745,6 +1774,8 @@ static int imx_pcie_probe(struct platform_device *pdev)
> >  	pci->max_link_speed = 1;
> >  	of_property_read_u32(node, "fsl,max-link-speed", &pci->max_link_speed);
> >
> > +	imx_pcie->supports_clkreq =
> > +		of_property_read_bool(node, "supports-clkreq");
>
> Is there a DT binding update that goes along with this?  I see
> "supports-clkreq" mentioned in
> Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml, but
> nowhere else.

It is already defined dtschema/schemas/pci/pci-bus-common.yaml although I
like it should "clkreq-broken" because most system support it now.

>
> Should this be some kind of generic thing?  CLKREQ# itself is part of
> the PCIe base spec, so it's definitely not device-specific.
>
> But I'm not sure what this property is telling us.  Based on the
> patch:

It is quite long story about clkreq signal. The old version before L1SS

PCIe controller #CLKREQ (#CLKREQ_RC)
EP #CLKREQ (#CLKREQ_EP)

There are OR gate in board design OR(#CLKREQ_RC, #CLKREQ_EP) to controller
ref clk gate.

In this type board design, supports-clkreq should be set false.

After L1SS support, there are ECN at PCIe. Require connect RC and EP's #clkreq
(open drain) together and use one pull up register, see below diagram.

           VCC
            ─┬──
             │
             │
            ┌┴┐
            │ │
            │ │ 10K
            │ │
            └┬┘
┌────────┐   │ #clkreq┌───────────┐
│ RC     ┼───┼────────┼  EP       │
│        │   │        │           │
└────────┘   │        └───────────┘
             │
         ┌────────────┐
         │ CLK Gate   │
         │   │        │
         └───┴────────┘

So RC's phy part can power on/off by #clkreq signal beside ref clock gate.

Rollback more years, there are #clkreq signal at stardard pcie slots.
https://en.wikipedia.org/wiki/PCI_Express, PIN12 CLKREQ# is added by ECN
(maybe after miniPCIe). Before ECN, PIN12 is reversed.

>
>   - We assert CLKREQ# on IMX95 (and on IMX95_EP, which seems sort of
>     weird) regardless of "supports-clkreq".
>
>   - We call .clr_clkreq_override() to stop asserting CLKREQ# on
>     IMX8MQ, IMX8MM, IMX8MP, and IMX95 (but not IMX95_EP), but only if
>     they have "supports-clkreq" in devicetree.
>
> So I don't know whether or how CLKREQ# is asserted on IMX8MQ, IMX8MM,
> and IMX8MP.
>
> And I don't know why we assert CLKREQ# on IMX95_EP but apparently
> never stop asserting it.

It is default for EP by spec define. We have not support L1SS for EP side
yet. But it should not neccessary to overwrite it because IP default pull
clkreq to low when work at EP mode. but not do that at RC mode.

>
> And I don't know why we assert CLKREQ# regardless of "supports-clkreq"
> but only stop asserting it if "supports-clkreq" is present.

See above diagram, ref clk should be alway running after power up. clkreq
is power saving feature. Only board design match #clkreq ECN requirement,
we can enough such power saving feature.

Before enable L1SS, EP card always pull #clkreq to low. But there are
"broken" design, other from board or EP card, which product before ECN
public.

Frank

>
> >  	imx_pcie->vpcie = devm_regulator_get_optional(&pdev->dev, "vpcie");
> >  	if (IS_ERR(imx_pcie->vpcie)) {
> >  		if (PTR_ERR(imx_pcie->vpcie) != -ENODEV)
> > @@ -1873,6 +1904,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
> >  		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
> >  		.init_phy = imx8mq_pcie_init_phy,
> >  		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
> > +		.clr_clkreq_override = imx8mm_pcie_clr_clkreq_override,
> >  	},
> >  	[IMX8MM] = {
> >  		.variant = IMX8MM,
> > @@ -1883,6 +1915,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
> >  		.mode_off[0] = IOMUXC_GPR12,
> >  		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
> >  		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
> > +		.clr_clkreq_override = imx8mm_pcie_clr_clkreq_override,
> >  	},
> >  	[IMX8MP] = {
> >  		.variant = IMX8MP,
> > @@ -1893,6 +1926,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
> >  		.mode_off[0] = IOMUXC_GPR12,
> >  		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
> >  		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
> > +		.clr_clkreq_override = imx8mm_pcie_clr_clkreq_override,
> >  	},
> >  	[IMX8Q] = {
> >  		.variant = IMX8Q,
> > @@ -1913,6 +1947,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
> >  		.core_reset = imx95_pcie_core_reset,
> >  		.init_phy = imx95_pcie_init_phy,
> >  		.wait_pll_lock = imx95_pcie_wait_for_phy_pll_lock,
> > +		.clr_clkreq_override = imx95_pcie_clr_clkreq_override,
> >  	},
> >  	[IMX8MQ_EP] = {
> >  		.variant = IMX8MQ_EP,
> > --
> > 2.37.1
> >

