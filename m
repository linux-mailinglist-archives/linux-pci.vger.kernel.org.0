Return-Path: <linux-pci+bounces-37296-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D25BAE8F2
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 22:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 041B17A5AE5
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 20:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE8729A322;
	Tue, 30 Sep 2025 20:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YXA3xAJ5"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010014.outbound.protection.outlook.com [52.101.84.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110A1296BD3;
	Tue, 30 Sep 2025 20:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759264808; cv=fail; b=KP1kiVMiXQqL8Z2TK3tTgeKEd1eEGjqQO82Qzi+cirj1Spmf9aQWzOLiF8E2RFpi3+17RkGJvrri76jrtMbS/jeYb6dj56K2AHCJjnUqMQF3GpU1oN+BRCCNtxlUzRnOiCpCUye9ajoVIRl7qaK89UW6wDhwK7joY5eC/tsAZjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759264808; c=relaxed/simple;
	bh=OmjgalyMEz/bjO/mA0S3/047Me4ZtIMWQT+5JXdTrSo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=UG5nmug08iopKMb1WVmK8NEi2IUNk3RQPUmhAu3zV66DzSHyu5g3gq4n/CH03BcEoa0fIz7haWczqmnqCiiXSz71Ofun3Vi/YpiZWozVnHwZWB7oDfn/00VF7S4Y1AtbQJEjJ9EB7ztTii+o3s5UQweLlKM75BtWg3pG/PtDkow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YXA3xAJ5; arc=fail smtp.client-ip=52.101.84.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RsZ65J2sgEenfj04q/U8OthUjKTQzaOt3gETU+TlIQxs4cJzPje699CD6SDhv5EH2dZ7snMK8btJZj1fZEh8tcrn5Ir8fT0W6sTEfZ6XpXqts089reEs757wY709uio55COqJ2SsiT81PFLpBmo8+ULdmN98Gs7S65uLzdRdVVLSbA/X3A/s/RXpaqe5LcjBeRkNWYraEFSCp9jMMOosK3sXExM75TsHAJHqoyxv9TYak6uL2Qd5TPHg4glMJkB0W2yGiFT/zJo2g5JH9VZ+QpO9/pDmu9zCtiGFiRoX5j8SKz9SCW/5zzP8b6xkxjsyWB3A2U/Y8NhzeUcEAiOmHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=poDyOzGHkRUTlXAq3G+fe8PxDKzcy6duwGMjdYdKS1E=;
 b=oRPJz9GCUZ2CE4O1X4RlLRp5UpvrV+bpHSjqsMiBs8IyIL1m4e7Ks3bKmpAWcF6Z4F07ptmRr1JXXUGPqgRQY+TVnJBf1NBP074jKutclfyKk49mYqlPv7ysPqgcQ41oy3WJLVpKJMmXcawHDETaQOq/8PzcXAbEjxN4XuOEDCcsKLS25oZEzIDLRwqWgkLTnBKWIMXB4lDDFS/+50eixOPYHEa9bQgmLjsIPVDpn2p+7SN/cPwzuaCzYj+o2trVjSArAoCNFNIIhN+e+cMQQHCmbtXxqtKzwrvO9zdjorurbMX3lkFQEde7/5+pxIYGeDYwh7YpWOy14Si3ajn5uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=poDyOzGHkRUTlXAq3G+fe8PxDKzcy6duwGMjdYdKS1E=;
 b=YXA3xAJ5KwTisDi7STO50+6M3gk6kiBoNd+1875kkSnASQ2o5oejemEkb8yi3/fYPLyPIL5KN5hveCg/laR31Y64YrAf+i9hM8ZcNggb9kxZYDsP9NccHhv36IYM3ttVoIEHR2zcvkl8hWwjLTvCWKqccxPg8YG1PK9cQEDu0TvfeEoSjD+KUOLGj/r3moWILs1bGg4NKloxqGXfaTU4gW8uBZeWEgJdI6xzlKLHcKwukiEHQJ+7528u9FkOwcrYMfVac+QjfOYllyFvchRjcR0OXzqXNhE5ltwk4n92+MSBryFmZUvuAinOloUu7GAeBdtDoSTvZvevdCeVxcwVUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by DBAPR04MB7366.eurprd04.prod.outlook.com (2603:10a6:10:1a0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 20:40:03 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 20:40:03 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 30 Sep 2025 16:39:39 -0400
Subject: [PATCH v4 3/3] PCI: endpoint: pci-epf-vntb: Add MSI doorbell
 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250930-vntb_msi_doorbell-v4-3-ea2c94c6ff2e@nxp.com>
References: <20250930-vntb_msi_doorbell-v4-0-ea2c94c6ff2e@nxp.com>
In-Reply-To: <20250930-vntb_msi_doorbell-v4-0-ea2c94c6ff2e@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Jon Mason <jdmason@kudzu.us>, 
 Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 ntb@lists.linux.dev, imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759264791; l=7547;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=OmjgalyMEz/bjO/mA0S3/047Me4ZtIMWQT+5JXdTrSo=;
 b=seP9sSsCEx2JmKr0J12wEcioBdHTuAV6K9pTjW9U7ylHUZ1nb4Ik/K3giaGbFF0G8B+Xqn4LO
 +XgxbaHEVwgBaMkE2DSDd6wkWddhTtNHIiM67tNkPmWKll0w7Z+fZXT
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH8PR07CA0046.namprd07.prod.outlook.com
 (2603:10b6:510:2cf::24) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|DBAPR04MB7366:EE_
X-MS-Office365-Filtering-Correlation-Id: dbe52d50-a735-42b3-7b57-08de006187fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V1pTR2NuMDB1Q2U3MUgrTk10bEFUQkJJa09Od3UwcTJjSGJTUkdQUlJjVHlo?=
 =?utf-8?B?MDN5R3AxS2NDVWRNK3pzV0V2ZkZHNVRabGpKS0Q3MmJIR21xYndJU3I1Z041?=
 =?utf-8?B?VHo2YkQrVEdUdGJqaU1hZERlNGtqUzAyOVFWSytObUMrbVVZQTFsNTNrTWpp?=
 =?utf-8?B?RnpRVmo1Q1JHdWc1YVNIbmVPMUp3RE5Wb1VWUHUyTE9MU3FrS1N6U01jSXVy?=
 =?utf-8?B?VmhhWVl4VFVoQW1KSEc3SVV0bDdDZW5TTkI3V3lJNUlJcnk3U0gvTDZMV3FR?=
 =?utf-8?B?ME8wSFFTQzhqS0JxM2VQblVQSStoMDNWQzlJRWNpOWFKMnI3NXVkZEJSQVY2?=
 =?utf-8?B?MjQ2T0ZIK0psbWJCUGI2b0hqc05aWHJqSWhGZk9oNGlja3hJOFhOSmFmeUEz?=
 =?utf-8?B?YXplK3dGYmg3d3Q5Qm1ITC9hd3pET3pWTXZhOGc2TENnR2F1dnpuaUZGY1B1?=
 =?utf-8?B?TjEzYWd2R0kydDdaajcxV2dKN0lkTWszUWdzSC9JTkJySkNsYWdUa2JOVGZ2?=
 =?utf-8?B?bnVHQjdFaC9XM1NJOVhRclo1aWdNb21jRXVsb1BNZk5PR2FGU3F2MUFVYVV1?=
 =?utf-8?B?QUVScEJmZ3RYSkxNVkVFbTNUVU9RVXZ0VkVHa0V0WWNjVnp1QVNZQ0VWZC9M?=
 =?utf-8?B?WWJBZnZDUEhJRnA1VjZMQmttM1BITUoyZWhXTElrU0crUTBLdkRFVVJDY2ta?=
 =?utf-8?B?bEZDUEpOWVh1a0lJTjN6Sk03M3FCUVgwNmJURHRRcWVSS0xDTlZMa01CYWlm?=
 =?utf-8?B?WnRWb2xHQXgyZFJQejdVcklZSFlSUGpSWGtTK09zbmtsMWd0WjJtOUIvN05O?=
 =?utf-8?B?YWUrSHozejJRUFB2RFFSL0k1UEVRYTBrbllZaTVRL1ZnUGNkYmIrOFl2UEN0?=
 =?utf-8?B?VUdZeUVrUkdoYnpZaDg1TFlUZmQ2bXIwcnZOTHpUOFlYVDQyZzNoc0ttekdX?=
 =?utf-8?B?U3ZxSGM0R2pBb3o5eGdlaDRTay9kYk9rT2xDZVRGS2tpd3V3eitDdWNRV2RM?=
 =?utf-8?B?b3dJdmpHTXRudENJSUsrWmsxaG5GZk15OWNpSUNCcC9WSmhaR05uOFlpZDRE?=
 =?utf-8?B?cFYyQkJWZnk2cUxDSjZzeEZucmdqeG5PUnVjbnp1TDdNYWtXOHdtRzFDY1BU?=
 =?utf-8?B?OXVyUzFRR2tjVWV1OU1mbDlDOThodXBUaU1tTStxam9WN01wNFdsTi9zODk0?=
 =?utf-8?B?T29lS3Mwc3YxTm9NNXY5N0JZMjhTMnIyYzVWVXQvRUdrMXNaZ2RldFRmTWl6?=
 =?utf-8?B?RkRzWVhUbXNSRWJ6WUpHVUg1QjBPbHZldWtsQ0FvbXVIbUMwUzNXYXRGMWVW?=
 =?utf-8?B?d0V6b0lnS3N2V1htQVFIVFVyd2RrWmpEMHo2K1pjQStqdUNaSG5ZVnQ2ZWZD?=
 =?utf-8?B?QTYyQ3pRSDBySnlRSGtjZmhxL3FZUUNIaS9yRlBtdXNGMGV1Sisvanl4cEFF?=
 =?utf-8?B?NEsrcVlFL0VPdHF5ZURMemxmQ1hFTEFzU2NjbE9QS3huT1ZRbkZ0ZHRhbzZS?=
 =?utf-8?B?RW51Uzl6RDFOYXltQjA3SEpOYjdjdlNkam1SbGxiR0JqUEcwclcwK29aZUM1?=
 =?utf-8?B?dTlqOWNrWkVwbktQbk84dldpeUNPeHFHT2IwUDlyUnhPdWp6S1gxMFpwMjlC?=
 =?utf-8?B?ODQrZWhaVmx6NEltd2VCMDV4TnI5eUpCaTlzalZYRXhnWTdQMjB0UHF0TnNn?=
 =?utf-8?B?RkMvUGdUYUlCbGNDcWF2Rnk5RWtYZ29RTHFnaUdQcVdCbHEvNGtaNitiRmd4?=
 =?utf-8?B?aytBbFJ2U3hEOFVOYXNHRmRucXJtYnpKWXNSVWphbDNpUS9HZm1wMmFUdW1F?=
 =?utf-8?B?RWJ4SkgxTDcwbG1iWVRsTmh2V0dyL3p6ZGdIVVFsM0VTV0QrZTl3S3o3c1BV?=
 =?utf-8?B?Z01mbkNwL0E4dEZESnh0eXZIWk1SdkpUb0h3cEgwSWlWMjlGQmJNc0ZXMStV?=
 =?utf-8?B?UUhxREpXNWxGMHBXcGhLcDlYcG9ocFVlZTFEcmg1TklOampwanUwZDJZNStv?=
 =?utf-8?B?OFh1dTEvRUIvcGRKU09pYzRtMXhrU1Q5bXlscG1MZlNKeUdHZngyMW05NEhu?=
 =?utf-8?Q?p3r/ZU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dFhWT0Jud05RTlN6c3d2d3ptZWU4akN2cmk2S3BNeTBHalJxSnJaL0E0bmxC?=
 =?utf-8?B?c1NjUmtiVmovbk9UTmNnMnQwRy9oK093TEdZbjBXUFdCU1FSNzdMajVGY0pP?=
 =?utf-8?B?Z3lhNWZZekkwSlpkM0FYbmovREpWS0lMZDZRZVAzWEE1MlNaMk9Ea3lFK1R4?=
 =?utf-8?B?aW1pSzNVUkNMbWNFVnBOeHIxVEFSOVVNWGZBVnNmOXViWTZSaDJTeHVIZm43?=
 =?utf-8?B?NEozbVllamdvTzVRRVZkVGwwMGd5aWxiSElsNWhmM0hMa2N2aEJvQ05jQWZl?=
 =?utf-8?B?c0F5WEJkSTBVSmIzeVUxSGgxYlFQWVBBem9uL1diU25VdEVuOVNrVDR6RzNv?=
 =?utf-8?B?dDRVWG1BRXlWdGcxQ0sxWGxvVlN3cGNlYjhIdWtFaW9yVkRsTlFxOXh6VU9t?=
 =?utf-8?B?M2d4QWh1NVlLQzg4ZUJGc3gzUkxyYWJxczQ5UkJSNThMWW5VME52UjQrVHI3?=
 =?utf-8?B?UnRTMWFGRXNyOVV3WHNxOW44STZoYUR0NnV2YVplYzZuQTNWTDZKdFd3YnVw?=
 =?utf-8?B?c2h5d2VGSEJXZjUvYlJzUVJVOXR6bDRUWWxEY0g4cm5sMi80am1kcC9JU1Ey?=
 =?utf-8?B?ZTdCR3NXSFBFTTRNeHhHbnhVdnFtWDMzdkVUTW9vZktJdkVnSDVvaEZMU0dM?=
 =?utf-8?B?MmNMVzNyODNUeHpGemRHa2crMzhLWVg2NkdheXFlSEllbXJ2VnZJN3BxK0x1?=
 =?utf-8?B?ZHBJSlVHR3NWYW9JT0ZNZzdvZ1pTVC9WaXdzTGNpWmR3dUJKYmtxcklST1Zy?=
 =?utf-8?B?b1ViYjl2N0F5VjdFMW1DaWJTU29XVCtvYnJ6bm85SGthNDZmS1NwV2lFOFdC?=
 =?utf-8?B?aHRoODRJamszenVYTUpIdUpUMW42QzA0YW40VVVmSHl1d21HcEFsTFY5RlE5?=
 =?utf-8?B?blJUcWdaVFRwalozTUhhakkrV2VJRlpiYkpJbXM1RnBxVEFGbDRnbFBQQVpH?=
 =?utf-8?B?RUdrbjRzcHQyamsybHFrLzlJcDBXS2hRSWZFM2VFYkVIRm1lbHN5R29yRno0?=
 =?utf-8?B?bDNuNXZFSHBUQ1M3czA0VzhPUWlGVWhxK2xqRFJnQVp6THM0aDY4T0xibXZV?=
 =?utf-8?B?S2JBenVBNnZsb1dDNTNzSFJjdHBBQjdoVE5iU0dUdThaUmQ4ZzhGclg1MHRY?=
 =?utf-8?B?c1dqUUdZZDllaGdWOEl3Wkx1ZlNCTjZQc1YyQ1FpYnVmS1paUGZWbkRVN3VF?=
 =?utf-8?B?RldXODVEREd6ZFpXK3NqOFhEQ0hnOE85emdOYUx2RGUvL3kwSGs2ZEFiVzJ2?=
 =?utf-8?B?YU14M29SL212eUxGUDYram1ZWkw2RFo2MnkxMmdMN2UwbHFudXgwYXNCelQx?=
 =?utf-8?B?RzdOYWo0cXV0MzNSV3phMkhOYnVXVHBQOUJUUGtZV01veXNwcHdoUnV6cHRs?=
 =?utf-8?B?Myt2SDl5eGYvZzI5VUo1WlVTNzRiZ0hQeTQ0TmhWRURMODBudWNCK05hcVda?=
 =?utf-8?B?SDg2d1d0VFliQzF5eHQvVmRDdHZxMVpaL3BRWFRCTzFMRVNCTmxyRTlnZC9q?=
 =?utf-8?B?c1hnL0NNQkk5SWxSRTVSQ0F5Y0xZNGthT3lRUnNNdEw0cktub3BwQm5ZWDZL?=
 =?utf-8?B?OE1COGYxQkVtbmtPeG13YXg4NStPc1huZjJxRjlwUmVDUmFTbnJJOTY1VnBm?=
 =?utf-8?B?UUJuOFNtM2Z3VjVldHJxaDg3aEhyZGdIcExFMmVucHRYb0tkRzdjTlhBV2tC?=
 =?utf-8?B?WGNCV3VJN043K2E1ZTdWN080ZnVMZUFwSHU5di9FejNjTEY2c0hDdStUZm1H?=
 =?utf-8?B?MVlWaGRBZDB0dmpEd3BLMWpMOXMrMmZlQUE4QTZZZVBGVXRQeFhSS1BQMzBm?=
 =?utf-8?B?RUlDdk5jZW5NY1M0VlBLZW84TkpUM2xoSGtoOGpWdDk3YnJNRk9xckw3d2NI?=
 =?utf-8?B?cU9zVjJNZjJ1a01tc3hsQmVwcUJkRFdDbXJURmdsNkdsVkF0UXJuZGNlV1NW?=
 =?utf-8?B?TjQvWWR2QThlMHp2ZzhvVjJCYW9kblYvcC9UeDRjcHp0SWZvYXlpSGxpQ3VZ?=
 =?utf-8?B?ODY1dG1MQ2o3T21FM1NTeW5HQ2cwUzVUdHJQc2lEenVCdmo2aXk2LzlKcGNt?=
 =?utf-8?B?bzMyUENRUzM4b1lrMTB3L21OWUlRV3hpTVJlU0pMeTlwUnVXdEg3VWthVHhy?=
 =?utf-8?Q?qpJmpMEWZOBh1IW0V4bSvp/TW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbe52d50-a735-42b3-7b57-08de006187fe
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 20:40:03.1080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TxMqVg+QXqRNqCCBHCvy9LI2+/YttngcrmQhNzaGbcTs4EbLWuJwnwg2yq6V5yaUYVJfJN7oql6a35nrEjMncg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7366

Add MSI doorbell support to reduce latency between PCI host and EP.

Before this change:
  ping 169.254.172.137
  64 bytes from 169.254.172.137: icmp_seq=1 ttl=64 time=0.575 ms
  64 bytes from 169.254.172.137: icmp_seq=2 ttl=64 time=1.80 ms
  64 bytes from 169.254.172.137: icmp_seq=3 ttl=64 time=8.19 ms
  64 bytes from 169.254.172.137: icmp_seq=4 ttl=64 time=2.00 ms

After this change:
  ping 169.254.144.71
  64 bytes from 169.254.144.71: icmp_seq=1 ttl=64 time=0.215 ms
  64 bytes from 169.254.144.71: icmp_seq=2 ttl=64 time=0.456 ms
  64 bytes from 169.254.144.71: icmp_seq=3 ttl=64 time=0.448 ms

Change u64 db to atomic_64 because difference doorbell may happen at the
same time.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v4
- add check of return value pci_epf_assign_bar_space()

change in v3
- update api pci_epf_assign_bar_space
- remove dead code for db 0.

change in v2
- update api pci_epf_set_inbound_space
- atomic_64 should be enough, which just record doorbell events, which is
similar with W1C irq status register.
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 152 +++++++++++++++++++++++---
 1 file changed, 135 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 83e9ab10f9c4fc2b485d5463faa2172500f12999..6e48a1efe1eb267c4c80c7c09fe1c6f73c7ccf44 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -36,11 +36,13 @@
  * PCIe Root Port                        PCI EP
  */
 
+#include <linux/atomic.h>
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 
+#include <linux/pci-ep-msi.h>
 #include <linux/pci-epc.h>
 #include <linux/pci-epf.h>
 #include <linux/ntb.h>
@@ -126,12 +128,13 @@ struct epf_ntb {
 	u32 db_count;
 	u32 spad_count;
 	u64 mws_size[MAX_MW];
-	u64 db;
+	atomic64_t db;
 	u32 vbus_number;
 	u16 vntb_pid;
 	u16 vntb_vid;
 
 	bool linkup;
+	bool msi_doorbell;
 	u32 spad_size;
 
 	enum pci_barno epf_ntb_bar[VNTB_BAR_NUM];
@@ -258,9 +261,9 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
 
 	ntb = container_of(work, struct epf_ntb, cmd_handler.work);
 
-	for (i = 1; i < ntb->db_count; i++) {
+	for (i = 1; i < ntb->db_count && !ntb->msi_doorbell; i++) {
 		if (ntb->epf_db[i]) {
-			ntb->db |= 1 << (i - 1);
+			atomic64_or(1 << (i - 1), &ntb->db);
 			ntb_db_event(&ntb->ntb, i);
 			ntb->epf_db[i] = 0;
 		}
@@ -319,7 +322,21 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
 
 reset_handler:
 	queue_delayed_work(kpcintb_workqueue, &ntb->cmd_handler,
-			   msecs_to_jiffies(5));
+			   ntb->msi_doorbell ? msecs_to_jiffies(500) : msecs_to_jiffies(5));
+}
+
+static irqreturn_t epf_ntb_doorbell_handler(int irq, void *data)
+{
+	struct epf_ntb *ntb = data;
+	int i = 0;
+
+	for (i = 1; i < ntb->db_count; i++)
+		if (irq == ntb->epf->db_msg[i].virq) {
+			atomic64_or(1 << (i - 1), &ntb->db);
+			ntb_db_event(&ntb->ntb, i);
+		}
+
+	return IRQ_HANDLED;
 }
 
 /**
@@ -500,6 +517,93 @@ static int epf_ntb_configure_interrupt(struct epf_ntb *ntb)
 	return 0;
 }
 
+static int epf_ntb_db_bar_init_msi_doorbell(struct epf_ntb *ntb,
+					    struct pci_epf_bar *db_bar,
+					    const struct pci_epc_features *epc_features,
+					    enum pci_barno barno)
+{
+	struct pci_epf *epf = ntb->epf;
+	dma_addr_t low, high;
+	struct msi_msg *msg;
+	size_t sz;
+	int ret;
+	int i;
+
+	ret = pci_epf_alloc_doorbell(epf,  ntb->db_count);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < ntb->db_count; i++) {
+		ret = request_irq(epf->db_msg[i].virq, epf_ntb_doorbell_handler,
+				  0, "vntb_db", ntb);
+
+		if (ret) {
+			dev_err(&epf->dev,
+				"Failed to request doorbell IRQ: %d\n",
+				epf->db_msg[i].virq);
+			goto err_request_irq;
+		}
+	}
+
+	msg = &epf->db_msg[0].msg;
+
+	high = 0;
+	low = (u64)msg->address_hi << 32 | msg->address_lo;
+
+	for (i = 0; i < ntb->db_count; i++) {
+		struct msi_msg *msg = &epf->db_msg[i].msg;
+		dma_addr_t addr = (u64)msg->address_hi << 32 | msg->address_lo;
+
+		low = min(low, addr);
+		high = max(high, addr);
+	}
+
+	sz = high - low + sizeof(u32);
+
+	ret = pci_epf_assign_bar_space(epf, sz, barno, epc_features, 0, low);
+	if (ret) {
+		dev_err(&epf->dev, "Doorbell BAR assign space failed\n");
+		goto err_request_irq;
+	}
+
+	ret = pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no, ntb->epf->vfunc_no, db_bar);
+	if (ret) {
+		dev_err(&epf->dev, "Doorbell BAR set failed\n");
+		goto err_request_irq;
+	}
+
+	for (i = 0; i < ntb->db_count; i++) {
+		struct msi_msg *msg = &epf->db_msg[i].msg;
+		dma_addr_t addr;
+		size_t offset;
+
+		ret = pci_epf_align_inbound_addr(epf, db_bar->barno,
+				((u64)msg->address_hi << 32) | msg->address_lo,
+				&addr, &offset);
+
+		if (ret) {
+			ntb->msi_doorbell = false;
+			goto err_request_irq;
+		}
+
+		ntb->reg->db_data[i] = msg->data;
+		ntb->reg->db_offset[i] = offset;
+	}
+
+	ntb->reg->db_entry_size = 0;
+
+	ntb->msi_doorbell = true;
+
+	return 0;
+
+err_request_irq:
+	for (i--; i >= 0; i--)
+		free_irq(epf->db_msg[i].virq, ntb);
+
+	pci_epf_free_doorbell(ntb->epf);
+	return ret;
+}
+
 /**
  * epf_ntb_db_bar_init() - Configure Doorbell window BARs
  * @ntb: NTB device that facilitates communication between HOST and VHOST
@@ -520,21 +624,25 @@ static int epf_ntb_db_bar_init(struct epf_ntb *ntb)
 					    ntb->epf->func_no,
 					    ntb->epf->vfunc_no);
 	barno = ntb->epf_ntb_bar[BAR_DB];
-
-	mw_addr = pci_epf_alloc_space(ntb->epf, size, barno, epc_features, 0);
-	if (!mw_addr) {
-		dev_err(dev, "Failed to allocate OB address\n");
-		return -ENOMEM;
-	}
-
-	ntb->epf_db = mw_addr;
-
 	epf_bar = &ntb->epf->bar[barno];
 
-	ret = pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no, ntb->epf->vfunc_no, epf_bar);
+	ret = epf_ntb_db_bar_init_msi_doorbell(ntb, epf_bar, epc_features, barno);
 	if (ret) {
-		dev_err(dev, "Doorbell BAR set failed\n");
+		/* fall back to polling mode */
+		mw_addr = pci_epf_alloc_space(ntb->epf, size, barno, epc_features, 0);
+		if (!mw_addr) {
+			dev_err(dev, "Failed to allocate OB address\n");
+			return -ENOMEM;
+		}
+
+		ntb->epf_db = mw_addr;
+
+		ret = pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no,
+				      ntb->epf->vfunc_no, epf_bar);
+		if (ret) {
+			dev_err(dev, "Doorbell BAR set failed\n");
 			goto err_alloc_peer_mem;
+		}
 	}
 	return ret;
 
@@ -554,6 +662,16 @@ static void epf_ntb_db_bar_clear(struct epf_ntb *ntb)
 {
 	enum pci_barno barno;
 
+	if (ntb->msi_doorbell) {
+		int i;
+
+		for (i = 0; i < ntb->db_count; i++)
+			free_irq(ntb->epf->db_msg[i].virq, ntb);
+	}
+
+	if (ntb->epf->db_msg)
+		pci_epf_free_doorbell(ntb->epf);
+
 	barno = ntb->epf_ntb_bar[BAR_DB];
 	pci_epf_free_space(ntb->epf, ntb->epf_db, barno, 0);
 	pci_epc_clear_bar(ntb->epf->epc,
@@ -1268,7 +1386,7 @@ static u64 vntb_epf_db_read(struct ntb_dev *ndev)
 {
 	struct epf_ntb *ntb = ntb_ndev(ndev);
 
-	return ntb->db;
+	return atomic64_read(&ntb->db);
 }
 
 static int vntb_epf_mw_get_align(struct ntb_dev *ndev, int pidx, int idx,
@@ -1308,7 +1426,7 @@ static int vntb_epf_db_clear(struct ntb_dev *ndev, u64 db_bits)
 {
 	struct epf_ntb *ntb = ntb_ndev(ndev);
 
-	ntb->db &= ~db_bits;
+	atomic64_and(~db_bits, &ntb->db);
 	return 0;
 }
 

-- 
2.34.1


