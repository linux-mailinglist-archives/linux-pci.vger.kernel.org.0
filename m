Return-Path: <linux-pci+bounces-22994-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D879A50607
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 18:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0102A7AA78A
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 17:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EFFF1A3160;
	Wed,  5 Mar 2025 17:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WMvYUoqG"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2062.outbound.protection.outlook.com [40.107.105.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32086189919;
	Wed,  5 Mar 2025 17:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741194494; cv=fail; b=Cxzjr2yTrjiD+AacTM0gTKVvnq/nO/42uXKmr7R/A3lg+o6eyL5ZWCFbuzcBODxHnqt5mFIO5ysWyJ6J+CDiqDr0V9TXmOp3Ai/bBm/2hLWOdXqV5XoD+nMByhqFjYwapZ5/0/A7pf5JoMgkWvNezlvJuk64b6HVjAHbel/QRXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741194494; c=relaxed/simple;
	bh=sDBkGPpRyPQs+UXYhHQ9sko4aV5y72odX3bYE5ZJiOo=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=TfCEILuH8XYOfW+jAn3eITiGvB1Kgh+6XI3rACkJmNe5DPjVGpjoiZG9sgjsqr3cI6OcvRGGHOmeis4uWRO0zxYpVJY7G5449Edvo5xx+W7ggbq+PiNKc0MAuBOA9ZzkEfJNKEh7pjbmBMytS3zO2vp/c0mWNsaWbegJSn3HmCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WMvYUoqG; arc=fail smtp.client-ip=40.107.105.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=flVNtogdcJi14/X4d5q1L7TO2t1+2KEHKU/9qwBVcYHIXar0DinbmWMQKXc8IB2c1FrLVtWccjzPL1bFgQP0kefSYFU2pBgPEFVDq2MUpCWBPkSi2aIx9JrUM5qrsyB4zx0MyCLgWIlRTVI0YwokuElrJfGa5+2DBXS0/k4qql0pGqwJPFSBMnKr9glBURD44QiSpIj/3HD0Bv9OyLCKcN5r/TS//Kg/XXDgLURSXEoYNX7zno116XAoj+IxKYCWrxpX8dWfUT98MaPPlILSijBeV1EklfprTHgPEFSZ3rSnGBwILG8dADhJNquniJVu+6Km0p5nU2TqwPWCt17wPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E8C37wrj12OK+gvKKYU2QP+8oN9hw8FsV2Wawh2WMVo=;
 b=dwseIsWa34C0x7mMhDrghl/dDOMepNmq7tR0H+ztg/jXiCIMca1fTtfeYZv0A4hsdCYipZIbRsKVigNsyNF3ewa3g7x1+SYQxR1kOeTqEb+rcViR85WX8/CE7BY8HreLgT4EfcecwUxjFhND6OQd2IUYKKVu6EMJLOylKhLKLUboi3HcZ/40hcUswXzDkh6S8FQN5EHnSS6KhdtIV8SQN9jBbIxCAovZX1Y7pgE1QzCrC3ZyzN1BN7dT5Hn9wuRnUvYf1LWJNdSmtfNcqWlmSFD3YlY2utCrgSNukh83M9e8uUEx4YCTXmFVWsG4KJ54RdCY9+ua7GX9MHs3C9CpTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E8C37wrj12OK+gvKKYU2QP+8oN9hw8FsV2Wawh2WMVo=;
 b=WMvYUoqGk0PS8nZ/S4evO4/j+KrFNbjI2KSESPzafkUUNEYtgV4m6RDfQSxVpiEVySmPg49EeFs5QVgw/E6156xoV9JtjUS0L+HsmyJ4EOEOiiyqcnytFYaRGU9/lpkeL+mj5yLFHifcBCZFUG9SIAvSBb1KShkLEjQPD01AQvnXqwxUZKO5svk82lLD3EqnsEIcjm8G9CTpSSpzW1IviszISyoUiXsvV+c6bbtg+qLzR57JWxL6JifDCXRr9lULn72QUzuufH5dydI2Z5oGH3+52u1Y00zmqaId1dWd42jU8pNNlJth+cSJdcW8MFTPMJdc14Vj4tsnR/IWvJ15sQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by AS8PR04MB9010.eurprd04.prod.outlook.com (2603:10a6:20b:341::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Wed, 5 Mar
 2025 17:08:09 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%4]) with mapi id 15.20.8489.025; Wed, 5 Mar 2025
 17:08:09 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 05 Mar 2025 12:07:54 -0500
Subject: [PATCH RFC NOT TESTED] PCI: intel-gw: Use use_parent_dt_ranges and
 clean up intel_pcie_cpu_addr_fixup()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-intel-v1-1-40db3a685490@nxp.com>
X-B4-Tracking: v=1; b=H4sIAOmEyGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDYwNT3cy8ktQcXfNkI9OktCQTS4skQyWg2oKi1LTMCrA50UpBbs4Kfv4
 hCiGuwSGuLkqxtbUAD2Axf2cAAAA=
To: Chuanhua Lei <lchuanhua@maxlinear.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741194487; l=2238;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=sDBkGPpRyPQs+UXYhHQ9sko4aV5y72odX3bYE5ZJiOo=;
 b=+ZsObaFZRibp7RFIXN506MubWWnNrsG9tvE+p/LokpnBpkO0nsJsLm5UHxPNPZBRYJNwFJ2L1
 XHCTD9UxXRQCu0BUV2wPO3T7hb6hEEfR+R0vjUr5BiE2zK03qh1th/Y
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY3PR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::26) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|AS8PR04MB9010:EE_
X-MS-Office365-Filtering-Correlation-Id: c70cb330-b023-4047-cf38-08dd5c084dfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?emhkRFpBNmVCTGJWSmp1M3BMeCtuUkRDcWpZRllxaVF4TXlMbGxiVVJJYmxO?=
 =?utf-8?B?WmsvV1ZxK1JUbjBqOGdad0xzd0d2UUNPRW4vRTFmWTJyWG56dnJNYmYrenZJ?=
 =?utf-8?B?aEtlRlI5S0RYMEJDN0Z2OW00VkxpYlROMzcvcGZ6amVvU3dsRXJscmdUYW5R?=
 =?utf-8?B?bmxFdTcrYWVWTHdJRWNKeWt6cTgvK1BweFZ1NTk3QndYRmdiUDRGSTJ4d2F4?=
 =?utf-8?B?emFyRlVXUXM4NVVhV3R0elVaRTlYODZvcXNzeHlrUzA4N0QvVjYxWHp2L2FU?=
 =?utf-8?B?WXVOTi9veXQzbHlxdVRwU2FEOFU2WkVaQ1BDVm5DRitkUWVKdXc3YVZRZVR0?=
 =?utf-8?B?TXdieUpIRWwwenVXSHoyNXA2SUR0Y2tXZ0preG9nWEJYL3dRL1hTTmhHM1Rw?=
 =?utf-8?B?TVlrNks5Y0dESjUxb0dUdEczdUlXNmdxVTRDRklyOC9NY1g5UmhrLzIzK0ZH?=
 =?utf-8?B?WHhpZXpRWStwbUtFV3N5RlRHbmdiSDdLeHBLVWNvOXlQekRqMVBGR2srTi96?=
 =?utf-8?B?ODdqL1doQ0huaG9FNG1VZ0RPKzNaSU9zUTd4TXB4UVdsTzc0c2JYY00xVWp1?=
 =?utf-8?B?RGZTNkVvdDJocFJCN2QvUVkxbmZXVHVIdzAwWTlRK3prZDhlQ1JxaUpXb2Q2?=
 =?utf-8?B?NnV2aUh3TWxjVVVHMUNIT29tallpUjdyZUhnVUJRNURDZUIvVUxXSWVPeXZp?=
 =?utf-8?B?SjIzQjM1UFc5ajM0cUNiRkE0anR0Zi83STVtTW0ydDdvS21RKy9QNDMvZlM1?=
 =?utf-8?B?cWdXOWFjbE9xVUI1YzlLTXFsWVF2OWFhU0x4eVkxanZzNGNLV3FoL2ZVQ1p5?=
 =?utf-8?B?RUZBVFpPL2w4dFVPeW9yK3UxV3hvRDMyQkk1eDZhUmFBMFJWOXNnWm15bUZP?=
 =?utf-8?B?TjhPSEpyd244WDl5eFBzUE9JUHFkZ0ZYZUxraW1LelR3WXM0b2wzMUtlay95?=
 =?utf-8?B?ODhUN0pCU1ZoQjlmcXIzYVNpenNTdVZocjJBeWovZjhveVNGdWRYY1YwOUVh?=
 =?utf-8?B?OHNBNnJuZC9KWFFhU0drUkUrQXNWbUs0YlZpOENKRElkYkVLVklDR1hmcFVD?=
 =?utf-8?B?NnJiTkdWNnYrcTQrZTV1VjY0MXN4WEk3RjJFSFBqeUVsMGNWU1o0dTFic0lF?=
 =?utf-8?B?OEtYZ1F4UXZjYnhsd0lBOHV6RUJxOEtmcHBodTdDRytIMmFhT2h2bit2bVhp?=
 =?utf-8?B?VDdWa3ZPV3htQzlRTXJxamtlbytrYzZvc3RNT3hIVkRRZnMzZmZiYjFOTGgx?=
 =?utf-8?B?TkdlcytQU2FERUN0Y3p5azE1aytETnhYdDBmZTV1c1I0SlBJM1k2YWFLUjFI?=
 =?utf-8?B?S09OVkJsVVluVU5xUEVOZHYzM2FQVzNpRGtpZWVHcWJBSWlwMm44WVUvNGVW?=
 =?utf-8?B?ZnhqOEhoS2x5WkNNaGJPN0lOaWtuY2N4R3dBbG5RMUFwb0d4bEZsWS9kZFNI?=
 =?utf-8?B?R3J2eVVFaXVOdGJSM2pMNlZDN2tOcHN1OFJGYWZSMGw4KzVTdi9mNUpwMVFK?=
 =?utf-8?B?MysxR2c4NlV2UE10ZFVIR2xKK0R5LzBCWEVzQWpJY2lRVUp5UFFBbGNyUHdT?=
 =?utf-8?B?cFdoaXhzcGtlV2JOeG1rTDhOTldwTEdZekFpYUZjTFUzNFM2QkEvRS9uTHBB?=
 =?utf-8?B?aXNqaERtLytEVGR2a0xnd2JPVTNTSmlTbjZJd3JKRGJiVWx6Z0o5SDI0Nm1j?=
 =?utf-8?B?R2tLekNRTzVpNVkrTFpTNXdNRHNXNEY2VGY0TXhtS0N1TEIxQ1pZM1Z5eW1q?=
 =?utf-8?B?TkpFa3Bldkx4RlByT29pSm5iZWhRaXp1TFZSdlQ2dFJZZ3QwS2twODA0SE80?=
 =?utf-8?B?MlJUbkR0TnIxbkVZLzlBUldEZS96Ti9SeU84L29iY1ZmZXVsYWpuNVZWS0pQ?=
 =?utf-8?B?WXZTZUxNZUhubWxxZU5pNHFZV091ZVcwczh5Q1NQK2hIOGc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ajcyME91a3l6TlRqOUJEcjUxT05qMHNHSzlTMXZuYnFWTmZDM0VrSDJBZXA3?=
 =?utf-8?B?NHhmN2NYNHZVUWh2RnhwUjBXZ3hERWVYaW5rc3V4WGYvWHJ5OC93eG84d1B0?=
 =?utf-8?B?Zk9HMWhGcFNLajYxL29Hdmg4czRRTllXb1hCa2g1MTBjdFFSMXBHT29zbmgw?=
 =?utf-8?B?WnZ5R0VOS3ZyQWdKSHNoU2gvaXAvS2YvZ1pmTmZsU1RaZWRvdW9IS1FQOXlW?=
 =?utf-8?B?NDdrSks5OFI1cDhlcm1DNnZWYXJWYVBhZFZsR0V5QWMySU9WRTZpK1hFQkEw?=
 =?utf-8?B?bnN2Z2dLQ1Y5SG5LWWwva2FsRjNnWGZOckY5cWlDUmMyZ0VSbkVySFUzRnFQ?=
 =?utf-8?B?RnJRWVQyVUhJSDN2a0ZGZUxWV3Q1V1lsa1NnTmw2eTJsZlZ3QTRsQlVUUnlk?=
 =?utf-8?B?RDgwaGE4Y2FSZVMvL0MyMXIvclJDSE80cWJpaWVJNThzVFpwZE9TQ2JWT216?=
 =?utf-8?B?Nm5GSk5Rb3B6Y0ZjSzZsa3FtbUMyY2ppNkI1SWd1aDhCdkE5WUtBTmdkcTg0?=
 =?utf-8?B?VHRIelZkS2ZYNGhFcU5lVVJBV09jWVRyYXNpYUdKUi8wd01nZlpyS3RRZ0dW?=
 =?utf-8?B?UThGdmpyQmxoOWJ4cjZ2QW1PSm80QUtMbEFaSXFRdEJPY2FEVTkzSjQ4eGNy?=
 =?utf-8?B?dzJSdTJrUkJwTmdMbFpkazhIQzNJS1hSOE10ZWlWWmRQT1JLMlhPb3JENkpN?=
 =?utf-8?B?MjhheEwxU1hnY01JYnJmMlJ6d2NRQkpmZ3ZkNXgxM3hCcG5kNFNVQ2Mwak9D?=
 =?utf-8?B?ZDAvMXdUbHJNdCt3SkdmaHNXU1NJYWwwUE9GN0kzWHh6c1dEUkdUV0xEMGdq?=
 =?utf-8?B?bDhVV3FlR1krbjlSbm9DbEhkamtaZUQ4SVFJM2FiTDF3c3VGQ0kxeUlDSVJn?=
 =?utf-8?B?bmZ0TjNBWDhJVWhJNTJrWTU1VkVkRGdseUZQL2NPcS9zWi8ydzBQemhFTktp?=
 =?utf-8?B?ck8wSGhKdlRiM3ROWTBCM0VMa2VkU3ZLM3JIYWZnRS9kZkFDd2pUelVBOFhP?=
 =?utf-8?B?M1RTY0J3UDJhRy9qNTIyWWFabERnUklaSXE4N3dkSzBlYjU1SE14OE84L29W?=
 =?utf-8?B?YzRLSVloaTZ2cksyM1I0N0kyWXRUbTBHMkhOV0xScEhMNGdObW4reE5NZGJK?=
 =?utf-8?B?eXRlTWh3aGMrZ0RFT1A4WkZ6SmVOd1dBeE5RTnZrNmhHRENrQkZ0YmRwSGpa?=
 =?utf-8?B?SmRYRis5R2RmRTViVlRqbjdZYTlpVEhDRUpVNUdxTGJSY3lyaFc2c2RlVUl1?=
 =?utf-8?B?cXdOR2w0TmVOdW1CY1hVNml0ZEFPd2Z3Y0l5L2hMcWVqNTN3RXJvckowWExL?=
 =?utf-8?B?WFdBUXBPRzBBYTBDcmRkNC83eHRtOTkvalVCZXliQzRHVTBPYnVWNTUyUVFE?=
 =?utf-8?B?ZnUrWlVKQWtQc2pLNGx2NEF5NXAvWXd0MmVpU3JZejVuNkNxZ3VXYnprWnJC?=
 =?utf-8?B?N0xrWWhDNXNuaUFEUVd3V0tqamdESCs1UnFxR1hBRUtKcXdzWVNMaURkSVBj?=
 =?utf-8?B?YXEyYzcrdWgwSHFlcUl2WnFESEdObzdlWnRMbVFjNXN4eUhiMUpDMkpnbHhn?=
 =?utf-8?B?QmVNYmRiT2gwYWlnemdYc212cXU1VHU2MnRZdWZSVEJRWGdXTVVUN2NVYXI2?=
 =?utf-8?B?aWFKdmdrUVp5MmROQWhVNHVSN1VJc08yZGE4eWpXSkJOZ25hQ2VGYUgrM1Zy?=
 =?utf-8?B?NVpGYWZKWWR5M0NWeUNoS3pheGJ4Nk1uWTA4blh6dXBaZk1VaG94Z3BsWmFy?=
 =?utf-8?B?bjljRGdWSHVhMm1xbytrTlVQUk80UHlUSFZ5SmU1QnMvUy9nZjkvSkowSmd6?=
 =?utf-8?B?aUdTVFdrT0R1RmVZRGkxblo0WlB2SCtaaXRVVS91S2FYRE4zeWRUdHo3R3I5?=
 =?utf-8?B?Nm4rQkJKOEJVYnJzNENITTFzanBBWXZaRllkdzBBN2UzMkhMem1nRXpvWksw?=
 =?utf-8?B?SlljbnBvOHhmTEJRZktyd3BRVzQ2dFdmZHMyeHZZeHNsLzU3d1h2b2RNclhP?=
 =?utf-8?B?dzMrNDFGNklnU20wTkZNVEpXMCt1b1Evd212YjI3SWhEbE80NzN3WUpTMG0z?=
 =?utf-8?B?MXVmNC90Y2luaXlDYzZFcnVQMDdYVnhSMXA2ZG5XYmZOL0dSR0RUclpCU2xI?=
 =?utf-8?Q?recSMHtwg5R8FHQOEZaoC9UYM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c70cb330-b023-4047-cf38-08dd5c084dfb
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 17:08:09.5605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hoUTeP7z/xOepEkTLRhjFtSbNCi1nhL74LA1sul7ZMQcdNrHoepM4dKbiYQpEAB7Cm5joIMlzrpcM7Mcz/3OXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9010

Remove intel_pcie_cpu_addr_fixup() as the DT bus fabric should provide correct
address translation. Set use_parent_dt_ranges to allow the DWC core driver to
fetch address translation from the device tree.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
This patches basic on
https://lore.kernel.org/imx/20250128-pci_fixup_addr-v9-0-3c4bb506f665@nxp.com/

I have not hardware to test and there are not intel,lgm-pcie in kernel
tree.

Your dts should correct reflect hardware behavor, ref:
https://lore.kernel.org/linux-pci/Z8huvkENIBxyPKJv@axis.com/T/#mb7ae78c3a22324b37567d24ecc1c810c1b3f55c5

According to your intel_pcie_cpu_addr_fixup()

Basically, config space/io/mem space need minus SZ_256. parent bus range
convert it to original value.

Look for driver owner, who help test this and start move forward to remove
cpu_addr_fixup() work.
---
Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pcie-intel-gw.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-intel-gw.c b/drivers/pci/controller/dwc/pcie-intel-gw.c
index 9b53b8f6f268e..c21906eced618 100644
--- a/drivers/pci/controller/dwc/pcie-intel-gw.c
+++ b/drivers/pci/controller/dwc/pcie-intel-gw.c
@@ -57,7 +57,6 @@
 	PCIE_APP_IRN_INTA | PCIE_APP_IRN_INTB | \
 	PCIE_APP_IRN_INTC | PCIE_APP_IRN_INTD)
 
-#define BUS_IATU_OFFSET			SZ_256M
 #define RESET_INTERVAL_MS		100
 
 struct intel_pcie {
@@ -381,13 +380,7 @@ static int intel_pcie_rc_init(struct dw_pcie_rp *pp)
 	return intel_pcie_host_setup(pcie);
 }
 
-static u64 intel_pcie_cpu_addr(struct dw_pcie *pcie, u64 cpu_addr)
-{
-	return cpu_addr + BUS_IATU_OFFSET;
-}
-
 static const struct dw_pcie_ops intel_pcie_ops = {
-	.cpu_addr_fixup = intel_pcie_cpu_addr,
 };
 
 static const struct dw_pcie_host_ops intel_pcie_dw_ops = {
@@ -409,6 +402,7 @@ static int intel_pcie_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, pcie);
 	pci = &pcie->pci;
 	pci->dev = dev;
+	pci->use_parent_dt_ranges = true;
 	pp = &pci->pp;
 
 	ret = intel_pcie_get_resources(pdev);

---
base-commit: 1552be4855dacca5ea39b15b1ef0b96c91dbea0d
change-id: 20250305-intel-7c25bfb498b1

Best regards,


