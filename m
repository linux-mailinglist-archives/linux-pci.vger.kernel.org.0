Return-Path: <linux-pci+bounces-37776-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE55BCAD80
	for <lists+linux-pci@lfdr.de>; Thu, 09 Oct 2025 22:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B720235476B
	for <lists+linux-pci@lfdr.de>; Thu,  9 Oct 2025 20:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B137E274B4A;
	Thu,  9 Oct 2025 20:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hVOWyMZW"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010058.outbound.protection.outlook.com [52.101.69.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C5A274B22;
	Thu,  9 Oct 2025 20:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760043304; cv=fail; b=f//x+vraSAEBt3NWB7jZUtMPh/tEFGNVy/4V/1k7+dCPvb0YqhmNOxYIzMKGaEGkmx+jR7mC9v8e50UTnMJMDDM/qYGzBp4kbx8NTMCIKQzH+51bD2HE0dzaxh7Pbt0/g9D9dsliID1nWqSCJiPr/1281Q2vhop18cgHpmjEJ9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760043304; c=relaxed/simple;
	bh=YJ0UBVfDSrJ/g5efRs9S2lD0X1Dr6V8TYsPoQFvWbw8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Y4O6TszG+ZXuw4RXmYMBYbXxQpmWhvXem3HiBFWJPACPi6wLvP0JuDowLW3IWVdOhqs/azSODoawpZt3YiwlGad6LRaqQoPZyMD5urZLBdQnGrYIVdyLjGX8+JR3cqwv9MuZHijGTCIbVpem2fghkmGwkWdxM6doEveuwram0Tw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hVOWyMZW; arc=fail smtp.client-ip=52.101.69.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pFMiOdW+0uFgLpmxzH+F59K0fSAOeAa/7n2qDjwd4HobqHiMpGZp4TvJFE/LTmAV7vPH5APnfGv3jywxYoeLCif8Rq1aj9hedoJr/Pkj6W8uIZsII4F5mwdI7S0WcPA/yBl1apzXkHqPoKsILh7BmdzyVvaPtaL2li0d4vIj9H/B+p0KAltpXELu/ddcOM3dDRNKWFkwu7p0hGYcP8tXpCUOrB/ukGVQzzIwHd+71sV3XP1s3n8dyfvZxlYVyXJYfzRRBbQEhLTsGXiDoGxnoVl97f6eTDYW3QHkT/jv0AF1CaVoP+k4SFGgOVNFZ7VpTxWkEIiPQi/fsS22becepA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=McvAIrF6Nla4nUxGDP4EFkswJiFKbcala8l5tO65Pak=;
 b=mJ8Vb9Lf90gaHJQQIpWS+tmb3t9sFY+nqm7RzQqSNT2WdxRtra/r1uVAomaSspuVAQ6lyq1P7vMXQKZGOdGjCQwYzWoJ/YerTLN36FuxLaVdHf5q4ci/drnDFnKAjw09zjgVLNPTZlNlUc+c5Hcu7R8RWdd/h1A4fRpVt9mGqi/s6SooQQwfqFLtC45Fzxd2NBaLtLvsMr1HMAECubnbQ/isj3Q7VFd9+ptokCUEKPYzbDTwzmmgdPzZxz5sppci1O11slTqmZUBKrxGd7XYfs+rSwqGpwKvQgOq5yFx+IlpLeYyc/uoRmsZOVtr8M9qdYWNj3BGlm1dUqmz74kVCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=McvAIrF6Nla4nUxGDP4EFkswJiFKbcala8l5tO65Pak=;
 b=hVOWyMZWNTW7ag4yXGlJF7oXzUXTzM83ZMOOecI8UYFdCBs6+9kQqW6A8XCvHELsxa0/+owd4XmV+QeBw4hirw815mL2eldvnhi91YI0/d/MTU1btkR6GaLpvPVPhEsaIhXHUWg/f+S7MDfvWJVHND2PEZIljj+IpPBd/N438Vg6jmC6oCIJLFfUgSogyJsFq8d2IzmzpVt4uPivlGnSFobT8QFJBxGuqyMA9ZZFwyNufyk/PJnK9Zp+b+h79nyF4Ag37YDJVKxY9Lk8Utk6YTvkHwncNz+ooro71ExQB9rGkf1xcPuPPGAwainPlmIPWit3M0am686aamc5ApPfig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by VI1PR04MB9906.eurprd04.prod.outlook.com (2603:10a6:800:1e1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Thu, 9 Oct
 2025 20:55:00 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9203.007; Thu, 9 Oct 2025
 20:55:00 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 09 Oct 2025 16:54:36 -0400
Subject: [PATCH v5 2/4] PCI: endpoint: Add helper function
 pci_epf_get_bar_required_size()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251009-vntb_msi_doorbell-v5-2-4cfb7b6c4be1@nxp.com>
References: <20251009-vntb_msi_doorbell-v5-0-4cfb7b6c4be1@nxp.com>
In-Reply-To: <20251009-vntb_msi_doorbell-v5-0-4cfb7b6c4be1@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Jon Mason <jdmason@kudzu.us>, 
 Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 ntb@lists.linux.dev, imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760043291; l=4288;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=YJ0UBVfDSrJ/g5efRs9S2lD0X1Dr6V8TYsPoQFvWbw8=;
 b=qbjLSa8U1ftTX/wxBsWCcztxs5g8GbU7XkIs0VLA+LAhxD85uPGfrgXZnc/jHNCNcI+mWh3EI
 4LHdiFJl+CtCsloaCP6s0bxYHnYSFst2w0i9/ExOmNxxjT/deqIOc9n
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH5P220CA0004.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:34a::16) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|VI1PR04MB9906:EE_
X-MS-Office365-Filtering-Correlation-Id: 68b7c94b-063b-4bf6-e4ff-08de07761c91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|366016|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UTVVdHNZQUUwMDlUak80b0krL0hiYWpHZWpNQXdUOG5jNDBlTUVPYnIzMzJK?=
 =?utf-8?B?OGg3NVdXdEdManZodCt6L1U3YkdPR25vd3BqTzE2TVpZUXBXQk9XNjI1YlVX?=
 =?utf-8?B?TDJKMjJmTXZBTXZrM0EzVUo1QjVyek9Md3VmVkNZSzhveGxkb2NGYzhZRG1K?=
 =?utf-8?B?N1EwaE13WVFXT1J4WmdNNDZCUVVoSmIrQjIvZFNLZ1J6SWEzRDhZa0wzdklH?=
 =?utf-8?B?YXJQTXduMjdVb2Q3YkVlSThicXF3YnpRVXIrclR4WUFrNUpSMFRIVmlQZUFX?=
 =?utf-8?B?bExpZWF5WEJLUUovNzhwRmpRaURVa2E2VlNGaDAwSVB6MGhTZ0I5V2Q0UHFE?=
 =?utf-8?B?UVpEQkRkRnJmcTYrUU5aSzJqRXhtRTI5aEpNWnZnZHROTzNEZkVzdStPdnU5?=
 =?utf-8?B?azZKWlRNcFJQc09hNFdLd3pjVElweHpMQ00ydHJ3eWZUVWZDVmtpNGw3STdZ?=
 =?utf-8?B?cUppZnlCcDRtZ0ZUeFBQSUxHcDVVRVUybkR6YkpnYUhnbDk0OWI4cm8wamZ6?=
 =?utf-8?B?NFAzSzR1NHdjMjZrQ2lnT25TUFh3amZSYnpCNUV6RUs4cmx1WnBkOGczSktO?=
 =?utf-8?B?RDhHUVFueTFIVEU0MDk5cTNKTStlbVFvYmFOZzFwYXFzb05iM2pZUWVmNzZF?=
 =?utf-8?B?dFUzTTlJN0Z0bmhGQnIwR2tHMVZvT21TdW5qNEtUZy9yMUsxd1ZGdnVLRlVZ?=
 =?utf-8?B?NzRodDdWUXRLSUlDM2xDWHA2ZnZiNElFaVJKc01jMUp2KzBDa09IV3BaZ1dB?=
 =?utf-8?B?SFFEYnk4cEJWa1FSZDFqT1J4WDlKZDBSTXhUMFhDY3pwTHdVTzhoQ0RHbC9t?=
 =?utf-8?B?TEw4UTZtVlVyRHlBelhXSVozdndNa0lMWERLQmQrVGI1YkZ4UURHZ0krLzBH?=
 =?utf-8?B?TGhZem9TL3BwaTYraDBBY2QzQW16aEc4LzZMN20xZ2hxU0J5b3Y1UUFUOFhW?=
 =?utf-8?B?VElDRHZoT0RJQVFESWF1bHhVNHltUDFMN3o2dXZhbnZFWlhTT2dyaWpYSGxK?=
 =?utf-8?B?SXF6YkpjR0Q0ZWRVS1Y4VnlNTVVQTDlCRzc4NEUvYnpIUHlpbHVZdUYyQlBm?=
 =?utf-8?B?U3VnRnMwMjVUWHRZZEZsR2lyNldvNGJzdG85WngveEpKNjVGd1BIQ0FTSzQ0?=
 =?utf-8?B?R0ZLSW85amt6TUZoWCtRbkFscHMwVWcvSVdySU00YmtWc1NDSkd2cFR0NXFE?=
 =?utf-8?B?OVQ3WksrWCtDM3FHSU1Qc21xeHF5NzMwRG1DTW8yRXh2WVorOFE4SEVlcFJh?=
 =?utf-8?B?c3ZxaFhpRjh2b2pkMmtTdmZlU0Q5UWMwcGpjRXl2R203dHo5VXBZVSs5ZWFH?=
 =?utf-8?B?eG1NQmtQRS9SbmpLajJsQXZzUlpFZ1o4KzNuU3ZmYzFRTTBXQkJxZmZNTFM3?=
 =?utf-8?B?TkFWUDA4SjU2dTVOeExYN3dPRldUbExESGV4dlV2MEczZ1dUR21WVFk5cURB?=
 =?utf-8?B?cjZ4NlB6RWJGc3FFSThPUUE0NU5aTjRJMUNtc0J4T1RXck1xLzM4dlpCNCtu?=
 =?utf-8?B?U3orWDFneHZ4dmtTZUtUcFlMRWhKekVyQS81VGRDaGxIamNTQkVPWHhzVUF2?=
 =?utf-8?B?NVJIRHFNUUZNU3lPSkN4d2lFMzdCTUFpMy9FSEF4azgrZkhaWEc0UEl4bkdu?=
 =?utf-8?B?cGkwWERhaWlsTXR3MS9rK1llVzVJZndKMFN5NWxjYVZvWUpuVng2ZHQ4OWJk?=
 =?utf-8?B?NmkyVkVOZDZQQ2lRNG45aVI5eWd4NG8wcVRWcUVDTjVsejIvRmxTQW9nWEJt?=
 =?utf-8?B?dWIyZWp4QlJFYU13NFdpbmNzUFloTmdVbWVWKzJKZ1ZZYkIvLzIzcnFnSVUz?=
 =?utf-8?B?Qzdzbks0bjJpSlJYUlFVL2xSZkRpREhzY1llWnVkM2xNNVpDNWJHV1hJZ1lw?=
 =?utf-8?B?VFZLenJ2MGVuWmVNejdXVnJLK3Q3V1FQRTFjVmJzajY1TUVDb0ZJczlLdm5x?=
 =?utf-8?B?Q1ZBMDVjb0tXZWpXTGwxTFEzdFhFU1JNTENSQlhDZlFGN08zODc1eithU3lu?=
 =?utf-8?B?NGxHcXJkY29SRDlaU085VDMycUc1TVlQRGVocGRNZFd1bGRhc29ZRHhEMEx2?=
 =?utf-8?Q?XBq/jf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(366016)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NFlLakl4WWVUYTYrY0pJaEVKY2l0NjlGbCtvQW1oS2RlYWZ5N1I2bm1ZRGh5?=
 =?utf-8?B?MEdYQ1IrZEEwdHl3UERxbGN6a01xTW82SCtLWWwxNTI3eVZNSTFhVDFReVFE?=
 =?utf-8?B?bnc4K2RjRWY1djR3bnhXVWF6WCtWQ0svZC9UalVjREYrMmlhOUlKSms5MEFi?=
 =?utf-8?B?dmtaWXdwbFU1N0RIa2h2aU1Rekc4aTA0eW96QWE1clhxb2REbFI4L25lUXYr?=
 =?utf-8?B?SWZIcDRCNzdYa3ZUMWRvREk2YmJIY2wvOUIrWVg0Z1RBZjl1RUd4ZlZSOG9D?=
 =?utf-8?B?ZnpDa3VkdWpZaDJrWG50YlVSVE1UcGNVT1BlajZTMnFrajU5OFNUb3B0a3hv?=
 =?utf-8?B?Tml6T2VMRk55ZkdvR25ONk1rRVBROU5SQk5kRXBoajZ4MkJUc2REalBEakRo?=
 =?utf-8?B?NGNZQjdUcWxnWFNGNTdxYlljNVV0RExxak1DZ0NJelFScllCbWkwYWthYkxL?=
 =?utf-8?B?M1dGbUZjbW1lSU1lejdLMVNuTDE0Vyt1UlRhdmpaZGhOTmlVRzlZQ0diSHI3?=
 =?utf-8?B?NlNldXRraW5RcnY2ZEVCdDRZeUhyU0MyMnRsQkVRMXlRQlhQcnNTMEtUYnp6?=
 =?utf-8?B?YldQZHp3NEN6cncvOVdzdFh6ZGd3UjQ1emEveXpDMmE3bWVCbTRoUE5ucHFm?=
 =?utf-8?B?aGxIRkFvdTlNTzBiaDR0b3EzbUFrMUI1WkNOQWNncDdRZ2h2anlaUnpqRXlT?=
 =?utf-8?B?QityaW41QS8wZGNsVWtPZHl6U1VYOWZpQ1RXbktEblFzMFkvKzE4YW5ZRERo?=
 =?utf-8?B?TS9JMmtjRTBVVStIdmJtTFB0WDFpT3cxSGR6aVBmL2g2a0MxQVA4TkRYazVy?=
 =?utf-8?B?cjIxZlhuTkgxUE5EMjA5VmpNQWRUNEZQQ2JCd1RwQWljTkRVUk1FY0dyaU42?=
 =?utf-8?B?ZVcza29URXpIdWVyV2RpS3BQakhsTzVVMHRhMGZpcnpvSmxEN2x2aFNOejBs?=
 =?utf-8?B?OUZrTWpvQTRGaCs3ZkR2dzFqQ0Z2QkF1ay8wVXVtWkRLRk1zWEpDRWxWdTB0?=
 =?utf-8?B?SmtvVW1HRUNVRHBrZXV6aHZsVTc2S1JPanFMVTNnZkUzcXhIcExiYitiVzVN?=
 =?utf-8?B?WkcvTHo1U3ZVOC9qbCtHYllqMzV4aVg4TVNmYXZ5TUtZQi9HemNlQXlwMHAy?=
 =?utf-8?B?L0J3aWNjeVFGY2JzK0hKcFcrNUhRaEJCbGZKWVdnam1PVlBsM05WS2pZQkhM?=
 =?utf-8?B?aWR2cm1UbnV4NzFPaWtaM3c5V1oxVmdMSWE5dU1yNjFmZmZzbWdvN3NVYno1?=
 =?utf-8?B?VnV3Z1VhZVpla1FNc2tqVVlCMXA1Z0tGVVVNRTcrM2VnYjdkeG1XU1ZKaW1w?=
 =?utf-8?B?ZzBab2hoS240S291enMxcUYweCtyZ1NQUGlqVFBZeGJ2TDIrSmsrcVJnK1Fz?=
 =?utf-8?B?UkppNUxNRWx1WmJnUHBRdDQrWXQySnp6ZmRldzN4VSsxK21OeHRYdmd6bVNj?=
 =?utf-8?B?RDVsU2NBeWNPOU81MW5OY2U0Njg3UmVLU2J1d29vemJaQ2pkMWhMbkR2ek04?=
 =?utf-8?B?T21XeWxGM2lzQjRzL05hd2lwN1VtWXU1dFp3U2tpSHBkRlA5WGFxalZXRHFy?=
 =?utf-8?B?VG01czlRRmZBRzBmQkx1ZDdKNkF2VTEzZ3ltM0tzcDFpSnQ2MU5zbHZycWFQ?=
 =?utf-8?B?WGZnZ1llcHA1aGlEdXJ5QTdkcUFwNi9kQjlCNVUvbGpTUEFuSURyZVB3L3Zh?=
 =?utf-8?B?b1R0WGgyQzhuai93MlVidjg5N2EveVJYZnJteDJJcDNnY3ZqZytoZFNrcGo5?=
 =?utf-8?B?OHljNElkOWp3WmFnSUw3ZHBBSFFycnpzSFhhaWJiS2VqeEdlMkN6SUNndFk4?=
 =?utf-8?B?RURORzVNelYzaG1PNW5LNVZta2tDTEhMS3ZWQXB0TjBLc3Q1cWtaS3RmSHl2?=
 =?utf-8?B?dUZwRENlanlTWnZkdys1K2tXU2pHQ1Zsc1V3cVFxZTdLNVhlM0IrL1dNMzVl?=
 =?utf-8?B?SEUxOXd6RVNkR1RZLzY2dVhoQ2cyRjRlNWlMc3lnS3FjVXlRc3NmSWZoclJs?=
 =?utf-8?B?alNTK1g0VnZiajJiSDI3QVBIdGI1YThUdlp2OFFEVkx4Q3l5VTNrRGdwMWlO?=
 =?utf-8?B?WVpEOGtiMkRMdno5dmdxSGMyQkpoVm4xKytHNDk3WTFORHozVFJnNjY2VUZ2?=
 =?utf-8?Q?665VB4Sfqss2jjdTlCHbcdpjy?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68b7c94b-063b-4bf6-e4ff-08de07761c91
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 20:55:00.1812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rJJ7MoEBphDBhcZFWOXoG6txhUzwVwc6dneGrNmRRQnMazMIImEI9njnEYoygNxFMfdUt58K29aShIxwpfTMAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9906

Introduce pci_epf_get_bar_required_size() to retrieve the required BAR
size and memory size. Prepare for adding support to set an MMIO address to
a specific BAR.

Use two variables 'size' and 'aligned_mem_size' to avoid confuse.

No functional changes.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v5
- update commit message.

change in v4
- use size_t *bar_size as in/out arugment.

change in v3
- change return value to int.
- use two pointers return bar size aligned and memory start address aligned
- update comments about why need memory align size. Actually iATU require
start address match aligned requirement. Since kernel return align to
size's address.
- use two varible aligned_bar_size and aligned_mem_size to avoid confuse
use 'size'.

change in v2
- new patch
---
 drivers/pci/endpoint/pci-epf-core.c | 75 +++++++++++++++++++++++--------------
 1 file changed, 47 insertions(+), 28 deletions(-)

diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index 214e3f6e6d0d5a216c3469b8ff47908414cd1286..38c4fd06e9693ceaa0c86f67090faa6e390425e1 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -208,6 +208,49 @@ void pci_epf_remove_vepf(struct pci_epf *epf_pf, struct pci_epf *epf_vf)
 }
 EXPORT_SYMBOL_GPL(pci_epf_remove_vepf);
 
+static int
+pci_epf_get_bar_required_size(struct pci_epf *epf, size_t *bar_size,
+			      size_t *aligned_mem_size,
+			      enum pci_barno bar,
+			      const struct pci_epc_features *epc_features,
+			      enum pci_epc_interface_type type)
+{
+	u64 bar_fixed_size = epc_features->bar[bar].fixed_size;
+	size_t align = epc_features->align;
+	size_t size = *bar_size;
+
+	if (size < 128)
+		size = 128;
+
+	/* According to PCIe base spec, min size for a resizable BAR is 1 MB. */
+	if (epc_features->bar[bar].type == BAR_RESIZABLE && size < SZ_1M)
+		size = SZ_1M;
+
+	if (epc_features->bar[bar].type == BAR_FIXED && bar_fixed_size) {
+		if (size > bar_fixed_size) {
+			dev_err(&epf->dev,
+				"requested BAR size is larger than fixed size\n");
+			return -ENOMEM;
+		}
+		size = bar_fixed_size;
+	} else {
+		/* BAR size must be power of two */
+		size = roundup_pow_of_two(size);
+	}
+
+	*bar_size = size;
+
+	/*
+	 * The EPC's BAR start address must meet alignment requirements. In most
+	 * cases, the alignment will match the BAR size. However, differences
+	 * can occur—for example, when the fixed BAR size (e.g., 128 bytes) is
+	 * smaller than the required alignment (e.g., 4 KB).
+	 */
+	*aligned_mem_size = align ? ALIGN(size, align) : size;
+
+	return 0;
+}
+
 /**
  * pci_epf_free_space() - free the allocated PCI EPF register space
  * @epf: the EPF device from whom to free the memory
@@ -264,40 +307,16 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
 			  const struct pci_epc_features *epc_features,
 			  enum pci_epc_interface_type type)
 {
-	u64 bar_fixed_size = epc_features->bar[bar].fixed_size;
-	size_t mem_size, align = epc_features->align;
 	struct pci_epf_bar *epf_bar;
 	dma_addr_t phys_addr;
 	struct pci_epc *epc;
 	struct device *dev;
+	size_t mem_size;
 	void *space;
 
-	if (size < 128)
-		size = 128;
-
-	/* According to PCIe base spec, min size for a resizable BAR is 1 MB. */
-	if (epc_features->bar[bar].type == BAR_RESIZABLE && size < SZ_1M)
-		size = SZ_1M;
-
-	if (epc_features->bar[bar].type == BAR_FIXED && bar_fixed_size) {
-		if (size > bar_fixed_size) {
-			dev_err(&epf->dev,
-				"requested BAR size is larger than fixed size\n");
-			return NULL;
-		}
-		size = bar_fixed_size;
-	} else {
-		/* BAR size must be power of two */
-		size = roundup_pow_of_two(size);
-	}
-
-	/*
-	 * Allocate enough memory to accommodate the iATU alignment
-	 * requirement.  In most cases, this will be the same as .size but
-	 * it might be different if, for example, the fixed size of a BAR
-	 * is smaller than align.
-	 */
-	mem_size = align ? ALIGN(size, align) : size;
+	if (pci_epf_get_bar_required_size(epf, &size, &mem_size, bar,
+					  epc_features, type))
+		return NULL;
 
 	if (type == PRIMARY_INTERFACE) {
 		epc = epf->epc;

-- 
2.34.1


