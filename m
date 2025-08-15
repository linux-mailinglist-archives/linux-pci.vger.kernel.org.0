Return-Path: <linux-pci+bounces-34124-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E90F7B28856
	for <lists+linux-pci@lfdr.de>; Sat, 16 Aug 2025 00:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C95D2AC696A
	for <lists+linux-pci@lfdr.de>; Fri, 15 Aug 2025 22:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B702270575;
	Fri, 15 Aug 2025 22:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AVmxe2Kn"
X-Original-To: linux-pci@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011027.outbound.protection.outlook.com [40.107.130.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37C326E718;
	Fri, 15 Aug 2025 22:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755296509; cv=fail; b=YpHr93ZTWJ9FJwtm39L96s9eKB9BDwRiSpOZY7OHtsZByzo5hz7BCoLHuqbms45+8zdxlP9dYqUoA77AjNEwlOWirxNaPuftRuR+FLEHL6izChjtGIIIi7d9aWN9YMNncSpa2j60enARL74Uw5/d6AMEFb+2v42RIKd0TxT1EdU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755296509; c=relaxed/simple;
	bh=SNNG/R0sxGoyz5fGoAH02mj6T+ZgFUegAhr6avULASk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=po2hHIGbXysoZUZHoMnugnAZ1wAmUuCMFwIZtQYLemmc0D134iTAN1XFZTeqVvvHesifjuwjAq5wqQ7EfD709xqKOy8PZp9cRgRD/Z5N4it+stsTBdunQwKj2uqHDahhOqWTSC/oU5EVHEB2diahG9q7mEjU4s7XN1u9xqrN7Zw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AVmxe2Kn; arc=fail smtp.client-ip=40.107.130.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gABvlmVm7hffozVHKoF5F8E0zmxzW9/nNAvBf3kJfCBM01hvLPU4xa7u08uspCzzNMRoslWJbBrIRImoCkFcJp5yNYggs/xN/z23KkIRiYoZ8MTN4dqq7hyWuZlVbRUXnl52WPAFZIqCn9PE0dvVjKe4KSHax838qohqNpk23SVOyKnIY9qbTg79omcTC8HbsanZH5YO9ib9Y4UmFSpJ8OwtVf693lFSo1X5u4r3ra1fGVqR/BgfxUV/VUDoVcxXJ7PsjVEPh682k9OwWzhbDNCHvsZqAtN+zJSrSKDgYEDs35zRanCtIA6DzR1cQm3DpEwG+DJZyzNjEsTF0yAomg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uoPV5lgwxkDwBOvUIsiV/UHJulWAyL+4/Ll26LhnMSU=;
 b=ywfcI9lbtKpwcekf85yAr9weIT6oNjHTeLCCKluBmOKWQcvnEw3Rwp/lioTuuS7q+GBWLvB0J1wnsxwzj4yVZPmYJtOsktIxGe1oVhlBObYn3NRUsz1JJFXmw0Xain8HQeWqn4s/ZbQtfJvO4Wvia5gUQgslbNeWtOkvmeDzKr9BpqQOOTBj8I/4wu8YGEj1SldTTBM/zkDJuWTn2B6yuOAVJweb0KRdq1dROny3CI5OGYVPykTiKG4pArYmRWUIvjohg6Mn9hTAEKF6mCrStU9XbXORTdNHlslp85jEXnE/oGjWwmwD1DUMeLwFD+WF5ffdBUTVe0zeBV6vA3+ihw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uoPV5lgwxkDwBOvUIsiV/UHJulWAyL+4/Ll26LhnMSU=;
 b=AVmxe2Kn2xfnhLbnLfmbo19TUK0alGy1WkPnEBXjeTz8zOWaMxCDqYytquT+9ae4g/yiQjEQwfQJ9v9nowN9l2nGfaJILO0y+JLjzpA9fZFoPyxHEqdspA+YXNb/Ka2H4GCXuPcf4A2me4FmmmWvnMmUHmZOfampg0cDruO5G/coAQ+E2PzPlcYDtb4MdFWwh6GYGY4GaQLdEsAHcDG4v1YuHDA1L6olAZnZaoY2ZWthmEHTTZz6BaOBEcDk0RsZKqYNtWCci3SSl6Pdfy9seXdB1YqugKpkouD7NJvUVQ5riczMlWMWIR4TaoICWWk7ZUBgW9FY9CXXlGsjlL4fQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM7PR04MB6949.eurprd04.prod.outlook.com (2603:10a6:20b:102::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.12; Fri, 15 Aug
 2025 22:21:44 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9052.006; Fri, 15 Aug 2025
 22:21:44 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 15 Aug 2025 18:20:54 -0400
Subject: [PATCH 2/2] PCI: endpoint: pci-epf-vntb: Add MSI doorbell support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-vntb_msi_doorbell-v1-2-32df6c4bf96c@nxp.com>
References: <20250815-vntb_msi_doorbell-v1-0-32df6c4bf96c@nxp.com>
In-Reply-To: <20250815-vntb_msi_doorbell-v1-0-32df6c4bf96c@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Jon Mason <jdmason@kudzu.us>, 
 Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 ntb@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755296496; l=7258;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=SNNG/R0sxGoyz5fGoAH02mj6T+ZgFUegAhr6avULASk=;
 b=fnW53V75lLRn7MsfE+n8rGbpCXk0SJCl0cYvg2Zv0qvkuhxfOL5DnLHKkFCZhidLSPz69Rflx
 XThczx7wiVbAHLlgzfJSAqljL+qE4uYjxznhGGlwN+8yn/3pAQ3qIjt
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH8P220CA0029.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:348::13) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM7PR04MB6949:EE_
X-MS-Office365-Filtering-Correlation-Id: e883b3ae-b530-45d0-75cb-08dddc4a1daf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|366016|52116014|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M3M2QVY2aWRidFVYMGtCQUhFREd5WEVreXNFMlVxd0pGd0o3amFXVjFSd0xJ?=
 =?utf-8?B?akZxbFhUMTdNTEJQUW84L3lkNStraHNxL3RMQzdLTzVOak1qTEFQbitiRmtX?=
 =?utf-8?B?bllRYzEyUjhxWTYzRU1rRExEeVpLdTlubUpiNDlXWkVOU0poYVVRaXMraXNp?=
 =?utf-8?B?c291cndZRm5NY3BQQ1B6MWpvVFBxMUExSWxiLzloNkZURXJyZ01zVmxkM3NR?=
 =?utf-8?B?N1ByNUJ5WjI4d0VyUlExL1dVWWwvWDRlWVcyc0JrQ1dmSFJCdFFUV1RZVC9K?=
 =?utf-8?B?OG1haCtFLzNBYlFaMlp0NUZZMkEzWXdkSjZHWUV5MFhiSlZCM0t2RzVPVXlh?=
 =?utf-8?B?bEFFZmJLbkpDa2Jud2pNd09vSGM2S08zNC82V0NmRlJUL0dPc2MyWHRjd1cz?=
 =?utf-8?B?RVBUWVMvZ1lXVkxtSEV5bklHdHZBek5kNVlnWmRVVDlnY1hMR3p6N0QwcFFv?=
 =?utf-8?B?dVJpQlZBU0ZST3k1WHVvbHpTQ3N2VlJNRlRsN3dzNElzZi9hSjBpY3dFQjg4?=
 =?utf-8?B?VU5CdjNDbkRXbG1vaUt6TkdOaXd0YkZhaXQ0THVReHdZVGV5ZTh1d3pOQk5Z?=
 =?utf-8?B?MURwT3FpQ0hZWGxDYjZhdFpONzRBLzdONmY5eUNQWFAxMGdNengrK2p0QlVU?=
 =?utf-8?B?ZDNQUHhGV0VWVy9KaFJhL2NENE0zd3ozeExsRko5ejNhMGV5cGk5STQ4Q24y?=
 =?utf-8?B?UlZWRGRzZSszNmphNTNJam1RSFUreUVEWGtiNEZaeTdHOEhpUFBiTFRnRlFN?=
 =?utf-8?B?WmJHT05nMlV6NGRDM294aW9XWnVIbVpTL1BHV1hmajFNQ0dCU3NTVUdxeitn?=
 =?utf-8?B?SmQ2NkFUblJkOGVhV1RkUW9ZTi8xMk9Wb0NwNGNQMHJ4V2k4eE9lNlJxbEdN?=
 =?utf-8?B?S0pZeHpwb1NCV0trZk1SWFcyb0RUd0EyOXRCNGF4MHkwVk5QUnJGSytDTUtr?=
 =?utf-8?B?dkhGSGxLcVZLTE5CK2tjSnRVcVVSR1JHZzdNdXJsNlgrTlpqNEtWSUYxTEZo?=
 =?utf-8?B?UFRaZkk5dHQ0M3dSYUJEYWlIblQzSFFmZkgySEZsdzRIQXRIWFo0enkzM216?=
 =?utf-8?B?MHF4WlJIWFQxSWxzVHlLVDc0WktoR09qSjVmV3JTOGF1RHg3UFZHUWVoaFF5?=
 =?utf-8?B?WGRsRVZLNHNxWDZEMzdQUTRYZ2QwU1R5ZVNHZHhQQk9wb1c4cE41aEZPNXVv?=
 =?utf-8?B?Z0lvWmMxUmlWTURjTE9tQ3NIL011bERIanpucnZ6d24zYnNhb0NuUlQzWGYw?=
 =?utf-8?B?K21nY3paREs2enh6RC9MUkhnOGpPMGZvSy9LS0RNTVdTem8vYTVXK3ZCQmpa?=
 =?utf-8?B?ZllsZDZBYXB2cEVHdlJweUZwM0ZGcGhjc0RBaFRpYWZuUnZDSVhEUXpiZTAr?=
 =?utf-8?B?Z2hPZ0wyTThZMkNoc2hMOHZEdzhFaXBKbHdWdW5pVENMOE85M2xmd2FrdVJP?=
 =?utf-8?B?VE11eHRwZ0wwL0YyZWhDc3RhWU5oZXdCTUk2ZWRrQWNYZ0FZMTdHc25OQ2pw?=
 =?utf-8?B?VURaNTcyWnNqOG9oOExtb3JRMXZVSk5TYlFNZktHK0hiaEh6clRnSHpUbEZ6?=
 =?utf-8?B?ZTdkUjl5ZU1yVTNVc3F5bXgwenptTHJUa2FKOU9kZDJ3cnJRV3dHMDRBRmd3?=
 =?utf-8?B?Q3RmQWZTSHVwVk02ekZOb0xFRS9RUVhkWVB1d2NEcUU2SmJqbW82eGVsVXBs?=
 =?utf-8?B?c3BPK2dlRFE0Z0VnWjJZUVdNejZxNzg1cVBlQnAvSDZIcUVPQXYrMlNKRkc3?=
 =?utf-8?B?Um1TUmFxc25OVW0wL1NJZ1VxS3pOUEF6ay9WeTNsT0tPaWJTMHdTUUVPeEh5?=
 =?utf-8?B?Mmhlb29ld1NUZXUvMHB6NlBtaUsrQ2dWZ0VUcGpVTng0bGRwWjdHYmNreC9h?=
 =?utf-8?B?VkgzOEZncVVoSmtnWnQvMTduODBRQjZQbS94S2Y5dmgvbGp0b0pHNXdKM2VL?=
 =?utf-8?B?bXYzdzRNQk1TUmZxWFJvK2h2c2x6eUxhWjQ2U3V4d1BRQW5waGRMSkRaaUhh?=
 =?utf-8?B?RG1nMTN5YzBBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(52116014)(376014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b00zY0I4UXBkeHJHTUtoUGpFMThQbGhLOFdCS3RGMGZiNlQwTHNxZTkwbkVy?=
 =?utf-8?B?ZE91cHo1alZpbXNHVWJnY3Q3YmpHSnBsL1FzK3k2QWEraTVjZUhnL1pUdUlY?=
 =?utf-8?B?Ym4wa0ticlBybk9EcmFrOHJSNXpBTEVTQytRV2oyVnJ3SU1LRUpxdkI1aDhj?=
 =?utf-8?B?cE1rZ3Z5dnloTFI3SkVtZHV4UXpuK2k5bzhTdE0ydVdTV0V4Qm8xN1FSUnd6?=
 =?utf-8?B?TXVFR0t4ZDJVbzNvRVdadTJ4dGo4UmRGa1BNa2ZvZVBHcThxUmpaQVFBT25m?=
 =?utf-8?B?M2M0R2xDRXpYNFh0TlBjR1pSVWRmTjlSa0lVRU5tNkpybE5EREJFdlgva2Ur?=
 =?utf-8?B?Q0RHVCs1SUZrc2xOUUJiWllTWTFPbDJaQ2ttSUZSQjBoWlZSYllaQlpaNklT?=
 =?utf-8?B?b044c1pBeTZ3T0tmMW8xTEhPNU5OdktIMWZsU3RRbmRXdzhPYUVlSGNiL1M5?=
 =?utf-8?B?cDRWKzBVRCtRajJwUkRuY0o5dUlDdUNOeE5WbXVKNVgwZTJpaU9ieG1tMENp?=
 =?utf-8?B?cFFnc3l1dHVic0VtRE1kYUxDOU41ZndzTFBHQUpxd3NTanJjK1pLa1lsSjdE?=
 =?utf-8?B?VlJISTA2c2JPeHNPTnBFN1cwV1JXcHJCUkxPRXdLakhFTGlpdWp0YUpES1pQ?=
 =?utf-8?B?SG5xS1dSUVBIVFYrVXQxbUgxcnZLbWdnUTQ3M2FzcjRaWklkZlNINlFEQUVS?=
 =?utf-8?B?T3dOd2VCLzlnTGRmY045YmVIOWVvMlRKOWgwcEU2UW8zQ2JQN0pGWE5TMVBt?=
 =?utf-8?B?M2V5ei9iMXZXVGFmQ1kxMHFxMFFTWm9FczNTN2tSV0JadnplMzRCcXp0c0Ja?=
 =?utf-8?B?cE5yK1JxcEdsd216WVBjWUJ6TXhudytQZzhwelVGUjdTQWMybmZVQnV4ekdE?=
 =?utf-8?B?bE45ejcrMlMvbFJNdW4vZUpDQVMvbUdpenV5b0xsclJPTXgvU1kzUXk4c0JN?=
 =?utf-8?B?R1JWMUt4aDZ6U2k1QVgvK3BGTmZ2WURud3FUbHJWcWcwOXpNV2hOeEl4UERY?=
 =?utf-8?B?WnMzYkw2enlPQUFDSElvZndiRzV0dHNPamlqaUVJMmphcUJQZG5uNHYvVDNF?=
 =?utf-8?B?RndXaXNEL2xWc3FyWnQyQU9wMmxlbzRyVDdCS01CSExGVWlkaUpGVGUwRjRT?=
 =?utf-8?B?eTgxWW1XMFFvOGp3cGhKSEVNaXAxR0dVY0R6Wnp1K21oUk9LblkvSUQ4Q0FS?=
 =?utf-8?B?Q2pjcmRreHFOZjNvaWZld2gxTGQzb09SVWttNkFDRDNDendPVU0yL3BxaGpk?=
 =?utf-8?B?TVdnY3FuMkJmOHdpYnRwNWljS0hVUE5VYUJnbmhUenFlazE0WHRpNCsvNHJT?=
 =?utf-8?B?YVJsQnZuWDJqUWl6WVRTUWE5bVNjNVQzcHhJdTlwZzFTZm5PT3VEZlNZYnhH?=
 =?utf-8?B?UUN5NFNHdnYremxyQmxvY0J6NUVvNnpmK0FLMUZ5cWpFcVlpaGY3bDlJanRv?=
 =?utf-8?B?TUJKSkc4YmxnQTluUTR2SUs1MWR2WVA1SmJRUytzSHozUGdJNk0xOWJQc3A0?=
 =?utf-8?B?aHppcm8rL2k5UFpUVVZ6MU03T0lXZzBsTllINnU1VUhXK3JaaU5abklFaEU5?=
 =?utf-8?B?dWdIdUxjSUR1L2xuSWxHWmZuaU1jR1RNdFBWckl6U1ErYUN4MjFaYm4wREFm?=
 =?utf-8?B?ZVpYVHV2OWNPMjNHMXozR0t3MjZZMmhmNklFd2xPcU9VNi9KWHdkcnVhUmJZ?=
 =?utf-8?B?cFVFTjI0VnpwemRqZFAvenp1L1J5TWR5aVV3RE5aaFBvRWJoZ3J4Vis1bS9p?=
 =?utf-8?B?VXlkTWpENGdYVlY5eEQ1WTZIcE9LN05hN25ybm01RmY2ZjRMZkE3QmNmNWli?=
 =?utf-8?B?Wk5zWkVsTS9iaEJIY1JHbnBXUnI4TWpTUkx2SEJiNndKekEySjlnbzRHVnN2?=
 =?utf-8?B?MnA1TStrUHpYMkdXbG5jVFNPZ1ljci93QUhXeThPcTNlSmFaQWtBSkpMMThr?=
 =?utf-8?B?cWxhVFArODlWQjBwTGE2NVIyVnZHVWRlMkFWdnU1VWx5Vy9weTlGQm9rTnF3?=
 =?utf-8?B?MWFUbmhlRW8vWGE5YmlFV2JiWnF4R3FjMC81VXhCOWVYZlR6U2NkU2hKaGJi?=
 =?utf-8?B?U2xRYVRGZ0E5V1l1N3o5WkltcTEvZDJKNFFYeWNGa1pUeTRoWHhYd2VJckRB?=
 =?utf-8?Q?6sQdlRSJvrUdmasxwqo5M6UdT?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e883b3ae-b530-45d0-75cb-08dddc4a1daf
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 22:21:44.1695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 84w6lBysGUQ9TZwVLb8azwh7OdwkCAPo+rWAQaIHegWOED9S/uB9qf6VpObVmxuo/ijkzYMsVCyqmWXxzS6QeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6949

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
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 153 +++++++++++++++++++++++---
 1 file changed, 136 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 83e9ab10f9c4fc2b485d5463faa2172500f12999..1c586205835fe9c7c5352e74819bccb4ece84438 100644
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
@@ -319,7 +322,24 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
 
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
+	if (irq == ntb->epf->db_msg[0].virq)
+		queue_delayed_work(kpcintb_workqueue, &ntb->cmd_handler, 0);
+
+	return IRQ_HANDLED;
 }
 
 /**
@@ -500,6 +520,90 @@ static int epf_ntb_configure_interrupt(struct epf_ntb *ntb)
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
+	ret = pci_epf_set_inbound_space(epf, sz, barno,
+					epc_features, 0, false, low);
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
@@ -520,22 +624,27 @@ static int epf_ntb_db_bar_init(struct epf_ntb *ntb)
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
+
 	return ret;
 
 err_alloc_peer_mem:
@@ -554,6 +663,16 @@ static void epf_ntb_db_bar_clear(struct epf_ntb *ntb)
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
@@ -1268,7 +1387,7 @@ static u64 vntb_epf_db_read(struct ntb_dev *ndev)
 {
 	struct epf_ntb *ntb = ntb_ndev(ndev);
 
-	return ntb->db;
+	return atomic64_read(&ntb->db);
 }
 
 static int vntb_epf_mw_get_align(struct ntb_dev *ndev, int pidx, int idx,
@@ -1308,7 +1427,7 @@ static int vntb_epf_db_clear(struct ntb_dev *ndev, u64 db_bits)
 {
 	struct epf_ntb *ntb = ntb_ndev(ndev);
 
-	ntb->db &= ~db_bits;
+	atomic64_and(~db_bits, &ntb->db);
 	return 0;
 }
 

-- 
2.34.1


