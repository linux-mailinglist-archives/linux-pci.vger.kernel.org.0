Return-Path: <linux-pci+bounces-29790-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C36EAAD9766
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 23:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B909177944
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 21:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6204A28DB7A;
	Fri, 13 Jun 2025 21:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PFL6qhtM"
X-Original-To: linux-pci@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013002.outbound.protection.outlook.com [40.107.159.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5187828DB45;
	Fri, 13 Jun 2025 21:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749850475; cv=fail; b=m6EUsi6P3nW0B5vzjCpgmsvOtg2ebWqdDAg5NtoAs4tKzw0QS4UO+0ZmYGXHdspZz76M2h93rdoNgNrwL4yMzYsSQeQqPE16P78Oo8nNg9QTr94XPKSK5rlI/8Cjtgtgqvi4iBJUCtCIezfoiYiq9Iz3bzxfdqjRunDyUCMQPoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749850475; c=relaxed/simple;
	bh=qSIfKEx95k6ODhvVw461h2b8m+2eUf3ftBzR5QU1OKU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=SKSpGTnnTn6W7bnAmpsH3nTHM9CUQq9cvlYFqewanh5suPXzG0G8wFGB42vQ5RORbkQ/l5E1zBSjTbz7+n2G1SVyx2GZpdlBP26HkZ8efHlmYrStHSDKAQ8jXTasweVD909dMcpxNJKeIF9c0nMovm+XupwcOGKetUIvVuMOFZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PFL6qhtM; arc=fail smtp.client-ip=40.107.159.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uuB2FkeU5/5qMcqAuufN2d5+Fg38oTwzjP0ePN3AflFq1o7QuzRcJz1my2fr5bfLVOl/mxPBcEfly9kOMyFTIvEHREKPWKiYawC8RaQCI4h0Nb0XXvTxmDLX+4zW6P9oZuhxL1GYfOG2cdjF70351Qp5nPH60d8wn1/Yp2vu2zqV2A8ER5OChTKnZ9IJJL1C7cKgTN7DRh2tt21N4qwRuWfH9nsh25a7VQ7AOhvwRL8FbVvRn5rA7ZTZAriX2xuD6v3ZGIT1mNVL/GIcQe76wWq5Q5ShcZxUBzTPlstyWZOOhmGBUMxngm0z4tREIIFwVs5sxQS1LKrdMVZIbUtJAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nufmyfNf3R8wAshdU9NV7WnaFxZ7CGXD2RJ6786gEJ8=;
 b=AjE37It6F6Pt1T7zdMdzHvSRN4obKZqv/AUtIX/JjBPPwMJeQNdsy7GBOxWOpiGZKL0OkLxYva5TbvT214Acbq0B/0xw3C5QWbQAGnteconSh9P7IJ+t1FXj9OlVujd/EThFO4Wdz/K/m8efAMYunJwYnFdPaeLff1SFBJGZ+XS7Sph2fk4gzpwctRicLY8GSrlJJbR8bvA2FsAJIbHHlSbhf0rHDiFqYVgq0jHhLGd/GSdXDofr/saJrMVrBJxWt43NvyWC+u5PihfMMe2399xJ1Y9/zr3BWgPQ2CKfQ6YMI+CYMwTJLDMh/yky9aS/hlM4OOC7t9pflGRslG2Ddg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nufmyfNf3R8wAshdU9NV7WnaFxZ7CGXD2RJ6786gEJ8=;
 b=PFL6qhtMy9/3sWqEfjxHHtIk88VOsU222cUXGPeGjlDVsH4ZYiRiYYqzNRCBmELhzfAaDRX0EKLGsE4cMPpjsla/EJiVe1i/qTk8WpJDw5T3lKoo4CX70WEjMTUPKKgjznoo435tU+0xSMnnxGlCLOnIzsbPU83R2C0BVG+0ioZSRNZE/Lxkpj2xNQHL0zwKM+WBRADKqZIgCvHfZIWs2u8DnqMqDKHSqCnrXDoCahMRehTNqUHVcop2erigD64BID+bOhEPeVrE9NAXJZDjQn92z0d5Tqk9bhV8LqKgg5Oug52/1/vbMyi4wkcFRX91r/1FyO64jBGD8snAdTL4ug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS5PR04MB9856.eurprd04.prod.outlook.com (2603:10a6:20b:678::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.25; Fri, 13 Jun
 2025 21:34:30 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8835.018; Fri, 13 Jun 2025
 21:34:30 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 13 Jun 2025 17:33:30 -0400
Subject: [PATCH RFT 2/2] PCI: dwc: visconti: Remove cpu_addr_fix() after
 DTS fix ranges
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250613-tmpv-v1-2-4023aa386d17@nxp.com>
References: <20250613-tmpv-v1-0-4023aa386d17@nxp.com>
In-Reply-To: <20250613-tmpv-v1-0-4023aa386d17@nxp.com>
To: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749850461; l=1402;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=qSIfKEx95k6ODhvVw461h2b8m+2eUf3ftBzR5QU1OKU=;
 b=OgrwUqQim1U6LX3Qs7y6cFN9+JdDxIqXXJW2B4NQiEmWFfzMhXMH65gsIVuoxB90zwc9MTWF9
 y3GuYctdzl0CkFoF6MG3HKPPUJ7c5kt9dATDZ8hwL0X8bw996HOt6vm
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH5P220CA0013.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:34a::10) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS5PR04MB9856:EE_
X-MS-Office365-Filtering-Correlation-Id: 144eb972-0eb9-4acf-6a49-08ddaac2148d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c3hLclVFQmFSRzllb092VEdxaW8rbVJXUXBMK1pITHlTWnA4dFFIaGJHaUVG?=
 =?utf-8?B?Q0tyakF6bXNEYUpSNkkzYkwxT21TbmFvTFFsM1hVaERJS01Zb3dITU8zTDNu?=
 =?utf-8?B?bEVFR25lcFFUNC9hY3JWakUyWXd2R1d2eXlUZ3pBcHRYdzd2MjFVOVdmK2xp?=
 =?utf-8?B?dDV6cXlrK3FpNHZhWGx5dHJiVndhZm15ZDBXN1ZBTEc2Szc2MVpqUC83WVNM?=
 =?utf-8?B?clpaV1NWZm53VGRnbWhudFRTY0g1VE5pOHNUY1ZzTUkxWE9uVkZrQk5EN1NE?=
 =?utf-8?B?TGtIdElFQ2dhbjFGcncxOGNDRGw4QnpQYUh0N1c0OHZYQ3kxdG9XU243QTVw?=
 =?utf-8?B?WUZzVDNpa2x5cGVtMWVtZjNUTkMwY3d0cS92M0d0bnVKUS81VDk3a0c0ZWNy?=
 =?utf-8?B?NjhrbjNRamdtMGpZQmpYUTFLVzBrU2s5eUxZNC8vS1QxNlNMeVpod0c5MjJE?=
 =?utf-8?B?aHlJOE9OOTRzbjg3WnlaQXlBMTVTMGQxWDV0b2F4aW5oRUU1cWhwMHVTajF0?=
 =?utf-8?B?TVpiVFNTWGE3MUxpZi8rVk9oSnJIaGVFenpUeHg4TmcwaDF4SHhNQjhrQXBC?=
 =?utf-8?B?NkhQTElYYmJNM3pwaHVzVEJkMHNyUndHak1EMm05NmNMOWw5L3RmRFRaeGs4?=
 =?utf-8?B?b0VIOTJicEdxQXB4bnhlZkFZeWhaM2NvNmdVdHJrZ21yK1pCdEFZdmJZZHpO?=
 =?utf-8?B?QS9QS25EbzV1ancwRndmVWVXSzMxNXBMekZIOHZPL3pZMTdiTHdTdzdaUTJM?=
 =?utf-8?B?alFkbGRSMnFSckNTSnFERzduS1lGS1VvbjBtNEUvOEtuV1dUellHTmtEM3N6?=
 =?utf-8?B?a2dkNFdRa21rVEl1STlQYzB3bnlTK29UNlFDUloyWW1ETC9ueTdsVmJJMjNX?=
 =?utf-8?B?Y3hHcUJiWDd6WGFReVdWR2xDVGx1dUp1Q3hEOWlpVkc2K0txek9YVXkzQ2Q5?=
 =?utf-8?B?V3U0Z3l2dU8xQ2J4ZVF2QVNrZllJVmFwK0xETXhNMzVnTzh0ZURFd3hlbFdG?=
 =?utf-8?B?SGhMaVFmZVVMQnlXQjdvS09qWG9VNUJmRHJweHIyN3JrTjI0a2cwd0txajZw?=
 =?utf-8?B?VGJ5MFpNeUIxQ0Zhd3d6SnJxTVc4RTBjOXo5YzlCbHFqUzRXdXJlMHJCVUhZ?=
 =?utf-8?B?VEtoM2FVV3NBcnVpeU55ZXE5eEpuZW1rL3Y5YzhCTHpzQ2hwbHE3L05reFNo?=
 =?utf-8?B?aHpYaVBadmxLb1FiOWJvaWdUN282anhGQTVEbi91U3ZtdnZHVk0rUDZDdHdk?=
 =?utf-8?B?Y0ZFdGlTdXBlZENhNXYrN015VnlacUthK05iS3BJTkZmNUt2amp6MUNneElD?=
 =?utf-8?B?RFR1QWZneHhVN2kwcGRySlhGM0crbW1wUVR5VTZlMVhKaHZLMDJoSFk0Wldq?=
 =?utf-8?B?YzZyLzJqdEJTRDdkb05zVEFOcUVKdlZ2N0hDbDEzMFo1SzNJdU9CT0lpdnpl?=
 =?utf-8?B?dEFSOEJ5NU9qbGxpb0toZ2o0V0FFUjU2NjJMcCtyUDRRU3o5SEx1TVlCZEZL?=
 =?utf-8?B?cmZDNXZmYUtLblhueHFmSkFkUXUrUDNsMmt2MmdjYlJPOTFMU1R1RFVVOHRX?=
 =?utf-8?B?dHNDcjdDTUc0djExcGN6dUhEYUJnSmM4ZzBQVEhOWWpzYS8vQVJiRGl1SVpl?=
 =?utf-8?B?dEl3clBYQnZUOVYzbysvbU1WWC9scnlPc21BZUFPNzlpUE12OE03VUtTRWdH?=
 =?utf-8?B?WWFxL1VWOUFuMmpnbTRhVGUwLzdFaXE0cU5zQjE3L0NEQ3I0a2pPclAyUG41?=
 =?utf-8?B?TjlnR2pIN01HR2FXR2Z6NE8xOGk2NDlOelJXOE9KSFhjVU50cHJuRlBRRXRN?=
 =?utf-8?B?THhuOXlLQnhQVGNtdHRlVmVtd1Fpbm56V2s0aCtCM3VSNjVxVXZjT0xNSjRZ?=
 =?utf-8?B?UzlXQ0g5NFZiTVZWdHJEbGtnUlhWM0ZvdVlvZ1hmc2J5d3NOL3FmMExJZ1Za?=
 =?utf-8?B?V3ZRbUYrNFdjemszcnhObVRsYlZOWFRaOC9hSll4TnJwdUFTcjNIY1dPOE5G?=
 =?utf-8?B?N0kyTDJkSVF3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TmF0TU5JdXRJTXFZc1lzU2FlWTVEVVBWeE92YXptaXVXMHdpNmxPanhxTVFi?=
 =?utf-8?B?enRzdUVXUEZRWHpacm1GbHlUSWxzODhZUklFUEZxTUlqbFRMZWZJSEJMVjhz?=
 =?utf-8?B?MWpGU09JRnA1eE5qd1BWdXo4TkJLcFE4cVJtamdIUGw2R3pUN1JwZDNRbGhz?=
 =?utf-8?B?VnJNcGFhTVJYcXlBdFV1dXpzNDlTNVN3U1lTSEpoWktjandMUlMxYm9UY1Q0?=
 =?utf-8?B?d1VUTzBxaEZvL3h4RkhuVjVoT0RMeDdnekhzTUJvR05JZlo4aFhWc2xxTEd5?=
 =?utf-8?B?amoyZ3RnNUN0SytieTdFZHY3WFBFWE9RTkxPWUpwMTlXM0xQcEFNcDgwbzYw?=
 =?utf-8?B?L016cHV1U2daNFV3VlpKalNuK1FlaHJ6SlU4dzdKTEpkTENFV3NHbHdBeS9L?=
 =?utf-8?B?Q3JvVDlPNFZJS0RzQnZFMmlIMWdJclZ1MzVSUkJrMkhhOHFYWVJEN3g5bXUv?=
 =?utf-8?B?WmpPM1ZjTndOV04wL2k5aWhJNlBVaWU2bi9Qck1EQW1HRTNEL0R4OG54RFZU?=
 =?utf-8?B?eW5qb2xHbHVJaEovMnpqU2NTWFFNb2o0dGJGTkFoeDd0bmt4ZFBsSHVQbG1K?=
 =?utf-8?B?TzREQVM2eEZzMUNuaDlmOEZicU53cktqL3l0ZTFaa3loUjdFdENLRUdXeVNt?=
 =?utf-8?B?Q0p1eDFvcmNjc05acE9KVEk1RkpaSXZnSEU0WGhHNTV6bFRrZElyVFdEK1BL?=
 =?utf-8?B?S2hPTHB6UVdEUUZ0b1pKcjR1VGZ6WC9TSkcvZmd1Ym1HaGI0KzRCbXdNait5?=
 =?utf-8?B?SnJ2anNrclA1NmJhaTkzTnZEWUZyMWFuZHZnZUhBRFc3Vit2ZVFBL3NiOWo2?=
 =?utf-8?B?TmNXcllDWW5NQStqZ25FSHlEelRKcW9hUFNBOFQ4UFZYUWRwWG1VbWR2Uysx?=
 =?utf-8?B?QVFMK0RBZnZ0SHFTcG1hcFltellYRDNGS2pwTzlEWlJLa0tYUS9LbTVsT2Rv?=
 =?utf-8?B?bkVMdGVMd3ZSWjlFVVd0SjFuYW9KK2xLbzJsLzUySE1HUDByVndEMElCNk1x?=
 =?utf-8?B?N0xnSUQ2UUREV1hDWDNxdWl4UktaMHVMOGg4SmhpV2V4RitoMS9VUXRvUnZk?=
 =?utf-8?B?YnpEVGd6QWZBQis4ZVBiR2ZyRGlEQ3lKWTducWhOVWVDRkFhbE5mVHRUS0Nt?=
 =?utf-8?B?OHV0U1Mra0pnUThzV3VRUVZyekFwWjl4M003eGc1SHYvOEY1Smpua3VNQjJQ?=
 =?utf-8?B?alJ5REd5ZjNWNGJtRDhCQm94RjVrZ1AzbkYvcWtIN3phWXhYRmVNRksyaURh?=
 =?utf-8?B?cjdlbCtRNksxa3VYNTlMUzcydWNYdE83dXliM2Uzem9qQ2pFR3lCUWpmeWlw?=
 =?utf-8?B?L0tZYVZhaTVLZzNwU1dVREgrVEdjWXNjYkxSU1JzSHBPVW1RY1VGUnZSYnMr?=
 =?utf-8?B?SGhhd010QjVDZjJCZkhjcGdmK09zZmdaRDMxaHBUWlk1eDkwK2sxTDg3QThI?=
 =?utf-8?B?SGNCTmxwM2U3a2dkMnBxRnpwckVyZFdVdGhVbzBlVVFwdGRLeEpGNVM5UVlC?=
 =?utf-8?B?TmZRVG5CdnVxOGhSMWcrbGVIQXhPWFA2NjVSMXg1UEFZcmNiRERiajU0c3RY?=
 =?utf-8?B?ZUVCZlN4RVpMMjlGT243WDIzR2NjbHpRZ1I1amtvZnFrK0FnOUk4TlRRM1ox?=
 =?utf-8?B?SENTdnd4OEVmY1NCekRRK0JKWHpYTGxiL29LR0prMjQxTTR1NVpQSTl1U05J?=
 =?utf-8?B?UFI2TTR4L0tvUFp3eGRxd1poek1QT09Velp1Zi9QQkVHUll6d2dMcFZWam1a?=
 =?utf-8?B?aVpjYlU3WEFQemdQeFVNcTFseUN0MWFYUVFGOUc4K1NUVHUrWFA1WUVRYjhB?=
 =?utf-8?B?TklmQlU3UUR2dEY5ZjhyekNxSnljbkY0MVhwcmI2dS9vM3lXRjRuT2FySFlX?=
 =?utf-8?B?Y1RPNHVhWUtKQmpSK2xQcTJwQ1A4YTVrRnByWXVzMHF3dWRScUg5aG9vMTJq?=
 =?utf-8?B?a25PdW5nV2VMUFdlaXI1K3pDaXVNdWg3VXRKUDJxVnNjSlFjaFFhK25GSlND?=
 =?utf-8?B?VlFHUmpmM1ZLaE54WndtcllvbjlpS1hhTXpCSjdZTndNNmxmbDhzaFZrTnVx?=
 =?utf-8?B?cmJuVFQ0allZZWs1V1FET0w3ZHFkSDZzTVZieVUxNGZnbEdFZzBKNEpmdUNn?=
 =?utf-8?Q?kQVOXpC4ywzAsKP8ChdVjkc6q?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 144eb972-0eb9-4acf-6a49-08ddaac2148d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 21:34:30.3480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G3FMAtWpu5thGoOx+tXaai8c5M/S9pH1Gufkh09ntOViz5bUCX+Te3J9xmL48F2tlMymEW9cJhQ5RUU/VbJfpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9856

Remove cpu_addr_fix() since it is no longer needed. The PCIe ranges
property has been corrected in the DTS, and the DesignWare common code now
handles address translation properly without requiring this workaround.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pcie-visconti.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-visconti.c b/drivers/pci/controller/dwc/pcie-visconti.c
index cdeac6177143c..9c3386c965948 100644
--- a/drivers/pci/controller/dwc/pcie-visconti.c
+++ b/drivers/pci/controller/dwc/pcie-visconti.c
@@ -171,20 +171,7 @@ static void visconti_pcie_stop_link(struct dw_pcie *pci)
 	visconti_mpu_writel(pcie, val | MPU_MP_EN_DISABLE, PCIE_MPU_REG_MP_EN);
 }
 
-/*
- * In this SoC specification, the CPU bus outputs the offset value from
- * 0x40000000 to the PCIe bus, so 0x40000000 is subtracted from the CPU
- * bus address. This 0x40000000 is also based on io_base from DT.
- */
-static u64 visconti_pcie_cpu_addr_fixup(struct dw_pcie *pci, u64 cpu_addr)
-{
-	struct dw_pcie_rp *pp = &pci->pp;
-
-	return cpu_addr & ~pp->io_base;
-}
-
 static const struct dw_pcie_ops dw_pcie_ops = {
-	.cpu_addr_fixup = visconti_pcie_cpu_addr_fixup,
 	.link_up = visconti_pcie_link_up,
 	.start_link = visconti_pcie_start_link,
 	.stop_link = visconti_pcie_stop_link,

-- 
2.34.1


