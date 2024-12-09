Return-Path: <linux-pci+bounces-17909-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 666F29E8C5E
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 08:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22236281673
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 07:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF19215182;
	Mon,  9 Dec 2024 07:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="oVlZL6Mb"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2073.outbound.protection.outlook.com [40.107.247.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9831321517B;
	Mon,  9 Dec 2024 07:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733730026; cv=fail; b=kgZ8GJJzERmCJ90dzVEXriW2fgKMo1KodXuourP2QeAjFzu96sml2l65xCsYqpcCQe2t/36xP73idm4mm2vHA8UFz9X1SfdGdogD682YsE5mkfwzWKT126w/wgVX09VpOa5JyOIsSqY679M1SJGE+ohpkSXnP0rvqEBOchQCL5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733730026; c=relaxed/simple;
	bh=iYqfJb8IqgktArfm/3T3a1LNBeinrYa1RBufQOUepo8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Cr4g/UJDUeUE5ibsyx7w5eeyRvFSqgHpLMPi2nOtdYN+N7cLKQJ6PcoANm8iP43eLa2fwuwhNhyKobpNJfyUObtRpkuykNwUfBhMsgD37u8IqoxPXlCsCRpLrEmydR6tBj7JbUy/JamZ5DBGGZT5uDJSTRWRCT25n/NCLHDCXLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=oVlZL6Mb; arc=fail smtp.client-ip=40.107.247.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h282amhRcR5Ium10CXIEw5zrs1+weAITJt+ffQK5jfZ1jKWZXE0soGL/Hj7USKW/hudVRxMUwbT85+Ct8vYwvaqDQ9u2yyRqC1rJNv64w/HRwWUyOoObKPRrl+x11dlheLKvUn4o71GpuZxirlm6WNn+FPJmEYAm7L4a48iO0U/o3zUIeq+XojJt6dTwG/hKbaaTJ0x2pPH1Gsdo6MzDUPCCtqZIKghxqbgkQHU3CCTBGh54tO/ZRoImBlG/bycS4WAvg6nwZGD0dH554UKzu4LTnPU2NLjyFBoqwqhb/ivMx0rT+rgY+FIbIp73GcwkkfPOtqRYBVKmj5gwnJIxHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GsRfcRi1dhGHvI64BtY4iXvSpC03+0YIzrGgFwfHBa4=;
 b=VTPf6vfLugyD1Axjp0afoHr1BMBLUo37Wue6heUl1wn7TCb24zVScdBx9R9Jc2AzheSfVrRp7ZAeLZPfkMESwvbOwfabWvDC7OtGnld5usQkKkszdmKvQGGjOy6cHVGgaoWnJRJc9p78WNlNq83mM2rUrMoA7PBCNWB0bcAu6rsic9VRiDRTGKKXUHEyHJPMCknfEhBKPcYqgwvDaaMm26YZYD8EauCi9vMz4hA53PDBF+CrxD+rf7cEK5qNwkisUBfVp3mqn1g5WcsqH48yDVe8wfyn6iJ92DW8flALuoe2+i8KRbc+r7KUitYEXyNw/AORndOKLnHNZjj5gV4gMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GsRfcRi1dhGHvI64BtY4iXvSpC03+0YIzrGgFwfHBa4=;
 b=oVlZL6Mb/CKHyTh+nw4eah5nHJ/H7+CvZ4rOSNqSa3RMJmyA8uXX5FdXsa9S0PU7wfvLvoURXCE1AnuCrnpK6Md2qVZZcs5Nrq6hgKNSJjVGtdqly3+PaVbuFObSbKQr3QO/sTo9FacipMASlVVlEhD5GHhPelvsagq9oiQJhi7YV5gNMRIRIs1TfTyY93p61NvxAT4SzRQD5edEf8XfavIuNckipVsQNpiqBedDcJTxrbw3k1Fm8FZWPCR37GKVR8oIGXUrKkhezTX5M0dBApvrTQtOxBhAJ2j5opNgwsE4HbP0m0DtXx84P6kXebjMWdAth8y4wOthjz3Abe/iMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by GVXPR04MB9927.eurprd04.prod.outlook.com (2603:10a6:150:118::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.28; Mon, 9 Dec
 2024 07:40:22 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%5]) with mapi id 15.20.8230.016; Mon, 9 Dec 2024
 07:40:22 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: jingoohan1@gmail.com,
	bhelgaas@google.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	frank.li@nxp.com,
	quic_krichai@quicinc.com
Cc: imx@lists.linux.dev,
	kernel@pengutronix.de,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v3 3/3] PCI: dwc: Clean up some unnecessary codes in dw_pcie_suspend_noirq()
Date: Mon,  9 Dec 2024 15:39:24 +0800
Message-Id: <20241209073924.2155933-4-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20241209073924.2155933-1-hongxing.zhu@nxp.com>
References: <20241209073924.2155933-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:4:196::6) To AS8PR04MB8676.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|GVXPR04MB9927:EE_
X-MS-Office365-Filtering-Correlation-Id: bdb9d542-6fc5-423e-29c9-08dd1824bd13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Hoe/Mqwx42gXs/7OareNaVnICkxG5OjwosXt4/756sagWhX7t+OamIKXXbP9?=
 =?us-ascii?Q?8vPZKWDh2jGNQ+LrzDVCyahI55BYh9+2eCJiY7TMZa3GyAGodahHJAcpTokV?=
 =?us-ascii?Q?rX6QBCgpMLY2HAj2r0ULVcLQruMP9UkdiQP6d8X6AeGBeqcqHpJYqZR4rW6t?=
 =?us-ascii?Q?ucLM82swU+hN6mpXTsD/Kp978wS5fa1VqVniCageeEMOi2hzp8XTjf6uPHoh?=
 =?us-ascii?Q?TK4h7pdQuN9kceDw0v/niCCKSuJo5q4SYGOtWo4pRZ5iyaJtLEMHg3yxAecA?=
 =?us-ascii?Q?h660vW1N2aca8IAJM211YVGMCDsNGhecCjJdgVWJuvnbX3FD/H1UI+JjgD1X?=
 =?us-ascii?Q?oUkL+D+GUZbnLT7ZaEvxE0XxBCNqJ9aj/Y9toD0AaDkIuqOTdWDyFKRFxiEf?=
 =?us-ascii?Q?c+26Z/kGyxQngdwAG3qAPLDsOgNTCKnsGsdWuuTz+u3kDJM4jR29ywVwjZwv?=
 =?us-ascii?Q?J0oYjYPrRvTi5zNlohZKUETOOh00zj754vM8d8D2r3C8yHVHznaZIi7ij+1j?=
 =?us-ascii?Q?aLsqKekxdWoHN8E6/ZpkYDPS1fymmVU+Z9w4vAhZGOQ3cFsY6VDQAoy5TVyL?=
 =?us-ascii?Q?+tamPGy/2YVcEBoNQMIu2x39BPiJ1fD6d08VtkbW2RX2eN3CUxgiPNTRlk36?=
 =?us-ascii?Q?W3gjlLtn+pkJnpgDfrKKM75/XKg4dkGGTb+R9ikaj0uRhddR1d2gzaeThlbl?=
 =?us-ascii?Q?GUZr3OuU4BI0EIoxyiBhce50QxbE0BPk3zq0lETiOTadqJ8gEofDz8oi5+65?=
 =?us-ascii?Q?+T+KhrTaO++2ZY4KULTKHdYuDv1L9q2QtyhQ02UmWtYQbe1eiGRO2TFBFgpt?=
 =?us-ascii?Q?xLeEKHy2uzDmttgV3I7rLkTP1H1C/Mpo1rP4jaHJ+BLT7N72FXzUhazljxLf?=
 =?us-ascii?Q?RRVUTTGTsOCuWxrLFIoATOKOkgD0ryIsxvoASIhyjmLWVMOaT8OIryWEqWdz?=
 =?us-ascii?Q?dzQbvXkJuR0GCvVeOlgQCCFg93Fdz0n4418fG+s+LtXgUDdjFPh5H7Bcd8JI?=
 =?us-ascii?Q?FGnT57nnA6V8lUP5jPihp2PVxE5Zsdt61zhlmxi8JCCIrIbwGkCGAk98OghK?=
 =?us-ascii?Q?GnqccOxYqFXVDwx6df0S+nuaSnYnrokNPs457QFmxeX4RkzKBkqtfzhvcRTO?=
 =?us-ascii?Q?2bGrXXZJxSzQa1vnOljZ/kFQExcqOdaUxMSIiG8Wk3YE1BAainm/9IMPkLJf?=
 =?us-ascii?Q?L++ELYVbxo8L9MURkM6V5TdD98PG+oDfi+oYyS8P7rz8uTWxO0NJG8wUe8G8?=
 =?us-ascii?Q?BkFgVtHnf/imzpt6+kLQetOV+hbTaC8p/sS0/MhMYaG1t7RP3b17GqjfpqaV?=
 =?us-ascii?Q?nx9ZCgvA0QVX5jGs9WpB+wLilaNdRwS3WwRIInOFiAnwlKBaqadnbqeDcq9T?=
 =?us-ascii?Q?r1RRT0Dmlpr7QpQzJbOZyUjI1Rj3YHe/9+2fPHHtV9mq/Ig8Sw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4XVAnA8rsVRF3SR+99pGbfumygIexk3LRlebyuyRw9s1F7L2ak5/NBI/o2Tp?=
 =?us-ascii?Q?+DTsdL0Rr/S2FDHC+ZQdPii9D+H8x4sdAxZ5EmrwNzRZnb5eGZLJ3cx4BVLb?=
 =?us-ascii?Q?scbZbR8dRx9KHfDYeCSyxW9odTxnnLh9v0e0P0GVNiropHWeMvwrphfZ6oxe?=
 =?us-ascii?Q?gWy6wkmC1FGo8Q6gOeAiB9yTiVGlboj0EwV+UZ7wNR2VS9mvmp1FsodCWIXI?=
 =?us-ascii?Q?q11RHX/1OBesJt3b2Z+ScujPApXdLHP7umwlX5Z64A4QnjbxOI5uXDUmnkOI?=
 =?us-ascii?Q?Sy4LnGTCG3rSDSPKkhw+H1J5p+cs9OA/7YQ6eAV/ua2ZB2q4mn4sliDB2weA?=
 =?us-ascii?Q?qnp6p8TXbbWHTU2hSz4TdVvsra2LfJrjP/t+fTcU7WniwKh/KFA3685mmEBI?=
 =?us-ascii?Q?0loiwQMkZbH0ZJsuWpByFAGPa/R6ihvUH0eDP5AmSQAFCTMAc8AQS+nu0ARD?=
 =?us-ascii?Q?PHIctjDICK26+iB4hXW+ooDTKgpUQtyYob5/MIU9cigVHqdJzhFK7sDR0vji?=
 =?us-ascii?Q?vz9bgsMVXId5TVJmcyuNa7PYEQ5R2KsKZvO89b8dkNhzJwpzVHXzrhm8ST3t?=
 =?us-ascii?Q?XpF1TTxXMJRL7Nv3g3Gxdb1RpNXEOJqH0UtSuBDRubXChg3TkBX9e9CJFCvk?=
 =?us-ascii?Q?2P8Oj2RT/Ae6DITG9ETh/Kgfu8S/VELjU449VyWcuAOFE7IK0b4sSwnqWAKL?=
 =?us-ascii?Q?1Hplfrbklq9gIrZVsnGe9AmfDQyTN7I5xtpukUelVxXa2d3o0ZVpdnD5G2QK?=
 =?us-ascii?Q?N5GNTqqwFg+5k0j42SQB+1SK5iyudjj+/frTB6vI5nmJyqOn6npjE5HKGTDU?=
 =?us-ascii?Q?Lgu7NbpQFZoi+6db2muAlui+55SULO4SACKF+6l+T3OkpjniNv5hPCBc61jn?=
 =?us-ascii?Q?T26oLkJ9iUEt6y+SOQvIvInnT9jvq9YE4NcMZEVmq2OKQEwLbmrevkM7ScWL?=
 =?us-ascii?Q?ywJNgqcFDJZfttkcGkFMsI4/bSr85DwrahSFCueOl9T2wVuYzKCw/vhYUORd?=
 =?us-ascii?Q?sZo6oSjIJvu6zTkdZuFlSG+gjoe2oPw9ngpc40ispd7vwmVG1uMvngFn8+rW?=
 =?us-ascii?Q?zNsJXSzEMzyKmbozICXGtLX+xGPAiU+1VWgSv//SibRGpNHLIQCu7yrOL2O4?=
 =?us-ascii?Q?e/aVBgWqCYEbupNeB7/HwjDn8m/fh3ouBvrC7oSPGF6SdrTFxvwOgLEV+EvF?=
 =?us-ascii?Q?EqgxzTG0+XPSxzzdatKzV3QVR2/r8JyfRXzpGAb9lZKEFMOGjfJJ8suLNqLf?=
 =?us-ascii?Q?Mq4zb0gg3/V2BJqpXdIzM7x9xYJQ4GsqAdaWPk/uSz0H605W5DE/gHt3zFuF?=
 =?us-ascii?Q?/lUpg1mFIFabx11mI0obf2x+4rx+c7t63hwBg7M7gBlV+EVQkL/vZlIQEMAZ?=
 =?us-ascii?Q?bBYqj2mPXQ+YppDumt7AOYBGR5tPlq/kB0PV6fNnrm+SA3xsDEQyL+/ymOLY?=
 =?us-ascii?Q?1BbmXWdbuxF4wYD2SJMD4u1cZBIEuWlOuWxpv+Q+qcABroWugVpeU6WZbs+H?=
 =?us-ascii?Q?qOB77fzhfV1jYwaRQ2xfbXLBtMQZvyWxrQdmOh5vtxzEZA2s+QdLuEYzyt6M?=
 =?us-ascii?Q?F1qcnT4hEcNsxzLgo5jgUM2TgbOLC4h+BgQb6KGW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdb9d542-6fc5-423e-29c9-08dd1824bd13
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 07:40:22.8451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AjxO8XVKAvcuSzAnWF9rhdpHTtiD2aDbj1xFZw927JWvcrmGdXd5OOvcxG1Q+pi8G6kR2Ku+TFykOGoxKw32Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9927

Before sending PME_TURN_OFF, don't test the LTSSM state. Since it's safe
to send PME_TURN_OFF message regardless of whether the link is up or
down. So, there would be no need to test the LTSSM state before sending
PME_TURN_OFF message.

Only print the message when ltssm_stat is not in DETECT and POLL.
In the other words, there isn't an error message when no endpoint is
connected at all.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../pci/controller/dwc/pcie-designware-host.c | 38 +++++++++++--------
 drivers/pci/controller/dwc/pcie-designware.h  |  1 +
 2 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 14e95c2952bbe..02e0e8c255c70 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -982,25 +982,31 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
 	if (dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKCTL) & PCI_EXP_LNKCTL_ASPM_L1)
 		return 0;
 
-	/* Only send out PME_TURN_OFF when PCIE link is up */
-	if (dw_pcie_get_ltssm(pci) > DW_PCIE_LTSSM_DETECT_ACT) {
-		if (pci->pp.ops->pme_turn_off)
-			pci->pp.ops->pme_turn_off(&pci->pp);
-		else
-			ret = dw_pcie_pme_turn_off(pci);
-
-		if (ret)
-			return ret;
+	if (pci->pp.ops->pme_turn_off)
+		pci->pp.ops->pme_turn_off(&pci->pp);
+	else
+		ret = dw_pcie_pme_turn_off(pci);
+	if (ret)
+		return ret;
 
-		ret = read_poll_timeout(dw_pcie_get_ltssm, val, val == DW_PCIE_LTSSM_L2_IDLE,
-					PCIE_PME_TO_L2_TIMEOUT_US/10,
-					PCIE_PME_TO_L2_TIMEOUT_US, false, pci);
-		if (ret) {
-			dev_err(pci->dev, "Timeout waiting for L2 entry! LTSSM: 0x%x\n", val);
-			return ret;
-		}
+	ret = read_poll_timeout(dw_pcie_get_ltssm, val,
+				val == DW_PCIE_LTSSM_L2_IDLE ||
+				val <= DW_PCIE_LTSSM_DETECT_WAIT,
+				PCIE_PME_TO_L2_TIMEOUT_US/10,
+				PCIE_PME_TO_L2_TIMEOUT_US, false, pci);
+	if (ret) {
+		/* Only dump message when ltssm_stat isn't in DETECT and POLL */
+		dev_err(pci->dev, "Timeout waiting for L2 entry! LTSSM: 0x%x\n", val);
+		return ret;
 	}
 
+	/*
+	 * Refer to r6.0, sec 5.3.3.2.1, software should wait at least
+	 * 100ns after L2/L3 Ready before turning off refclock and
+	 * main power. It's harmless too when no endpoint connected.
+	 */
+	udelay(1);
+
 	dw_pcie_stop_link(pci);
 	if (pci->pp.ops->deinit)
 		pci->pp.ops->deinit(&pci->pp);
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 5c14ed2cb91ed..7efcb4af66da3 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -330,6 +330,7 @@ enum dw_pcie_ltssm {
 	/* Need to align with PCIE_PORT_DEBUG0 bits 0:5 */
 	DW_PCIE_LTSSM_DETECT_QUIET = 0x0,
 	DW_PCIE_LTSSM_DETECT_ACT = 0x1,
+	DW_PCIE_LTSSM_DETECT_WAIT = 0x6,
 	DW_PCIE_LTSSM_L0 = 0x11,
 	DW_PCIE_LTSSM_L2_IDLE = 0x15,
 
-- 
2.37.1


