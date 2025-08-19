Return-Path: <linux-pci+bounces-34258-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4BCB2BA92
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 09:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7B4B7B9204
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 07:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616EA31159D;
	Tue, 19 Aug 2025 07:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FdAWthhg"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012052.outbound.protection.outlook.com [52.101.66.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0C330F7F9;
	Tue, 19 Aug 2025 07:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755587834; cv=fail; b=M6yZjrh3FL4B5fCss60H6qGyFxKG8WnROla3/EsjmVgITQhUnDkdt3C7x16zhakCMkmwIBY1/MM7wFSGJaDtJpucvWcpee04sKeQ5e3sTAUREiiL4A94zbsHIyq0Lokn+JVrvk2vSaI+3GUgqn2X3tbP3zxtrmq4s1S+6QsR8EA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755587834; c=relaxed/simple;
	bh=17BrSO2Ni/K6b7LVzcxqRvVkFINjeU2bP3hNufoByMg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h8KjkneXcjoaFE/c8fEoUrz8aXcd/F7eBxh/+k3OxLTphevt64zYgm5CLMm/pKLOGC/ccH3pahvmU4T3ZVsCdem2MJ+7CX75fA/grbN9kstLTckYm9RUedeSSpGBeyEPkxj1YYWua55ELfmehzh8BGjOYed2WQ8oPeE9RAR8wGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FdAWthhg; arc=fail smtp.client-ip=52.101.66.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dJz5yVWP7dJ/OVEEEerG+f1sYAzwcz91MOGBQ7du0Wc7+RwelD9lcRdW5+j3vdi52A9ya3RYnD1ulXpr17arXTjzFng+2wvC6UgVp/R9tm6PZl0ygzGmNH8m9x5IlkOKS8Do1ktcmYbMpaoYeU2AnWns0nFaQy72PyTY6eYvEBjoemqPlwZJxjNwZljdwdbnj2InZmo53Kbmc9gI+jHuSXA3Id9WDY63uRIr3oNM5ycI6/8ejAf5lMKbNJNz+MjDlfNrP9XmCUwy1wuxDPrX6bo2D5t3MXrs4IGrwzJljM2eRMJcH1u6oi3FqfnCJehHIMGDE7+k1OiKf7dg1BtB9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F3gUckhSo7azmsIj81r3pEmipcjZQzKoOhPYN/XQRlI=;
 b=PyDQd6a6A4clzdZviQ1tygglTa9aJNHWY6Lx07LKAkXwQNOoS9ufaorcIOVNEdmQOf6vEKrtg5enc13OQj1VK7Mi1Uv3RKCa1AWBDHemr1gTY+bHmgHWNuz+mBEN16sRewmA5BjnvbJUnYFWiafgvuSggwU22Q9iz+9MJ/OBfUsZWbwBxrPUogSDew729+TaU1shLAZd+HV/ulXlCE3wA5ni2JHwsJRPj260bAbb79Ae6dwaRFW3/AOCw6aHEry/VUB2xUAfvojq8/LStS5qdKzrzSjJ/tCv8DNuamjSJntmk6/j2/8HZzvPd2sW5HPTiDZKlCDaRRgICM4eKwUWvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F3gUckhSo7azmsIj81r3pEmipcjZQzKoOhPYN/XQRlI=;
 b=FdAWthhgqnfTD2iIKf6ON+zJSaYyvAFKi04E3U5J1crKBnafairLD8k+xiBf3URfCMcycheqLxICC/rFHtRjmgjiOaeMvkqpKPlch41zQhPP2v5MCqONRrawYzi9kfEIvUpdt6imYx6NFoxhWvCQJSAVp4Vo6PiFQJyT8Eau9+cmfsHa31EH1dPFhsrj7cSRVKtPjIbzQzhdT1Z97IZa268YgcCcT3L4aefFGv5hIC1ARXN35zngzhyYFd++HhwbAjAE2OlS88q3cCfEP6Vzxfwde98i+hNHjICm9p/2kdxlqr0VHqD7/sfsioprglmOosevspcVuhtvIqMceWjS+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by GV1PR04MB11527.eurprd04.prod.outlook.com (2603:10a6:150:280::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Tue, 19 Aug
 2025 07:17:09 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%4]) with mapi id 15.20.9052.011; Tue, 19 Aug 2025
 07:17:09 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: frank.li@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	bhelgaas@google.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v4 1/2] dt-bindings: PCI: dwc: Add vaux regulator
Date: Tue, 19 Aug 2025 15:16:29 +0800
Message-Id: <20250819071630.1813134-2-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250819071630.1813134-1-hongxing.zhu@nxp.com>
References: <20250819071630.1813134-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0163.apcprd04.prod.outlook.com (2603:1096:4::25)
 To AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|GV1PR04MB11527:EE_
X-MS-Office365-Filtering-Correlation-Id: 98a02ae6-241f-4903-22c0-08dddef068f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|7416014|376014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?97Eu81ewaXh+gKfU2teFl9z5sN5mQxKnI6hBQ0j01bWaeeIyk3g3ojWHdPAT?=
 =?us-ascii?Q?T5yNYkF2HhqUifFfpprShn/vRejP867sNYJ/VUu/4oCFmCpxGx2VoZIgufXE?=
 =?us-ascii?Q?7/jlwzor3NYMt4bOAXkh56tUGeuPUX7cDJdMVOsgnTIVydYzuopSlFFYXl12?=
 =?us-ascii?Q?o1yKpQLuHg7ZJrGXEkOqmO5yRau94Fk0r6YR3F1bVBmHmct1V/P3hTKuXN4S?=
 =?us-ascii?Q?pLbFbJoaXR4OPqm920KPwB3t2DPsym2RXn31gkAzOLd/fvzVPztSFEmt34fK?=
 =?us-ascii?Q?JC4eI5RJjhRqgaDHVX49UoOuDGmbho/DEU3L0Wj8tD9YHMR6nC/LmZ7BFgwb?=
 =?us-ascii?Q?2Tdt/jDjq3UWfG4CSO+F4y+Ocmkzy9HUSn8fwQEOE/MPPwJXWpiFKXNkL3sP?=
 =?us-ascii?Q?9ZMp8IDpBGRgCrufzpffrM5/5ruqc0TeKypB0yYFr4lJHtexqfJs8uC3NqM2?=
 =?us-ascii?Q?Vxg7OANNsHlnGl9ieM3BX3pvKwNwHfNID6VPY3mMVT5bnB6A8dxQ+rRsKTG4?=
 =?us-ascii?Q?AcRKnOWG8IBm+vOi2YNNE4JsNo12piASmGBubVcP2tOqLN6TkGJsG/HC0wBX?=
 =?us-ascii?Q?TCgkcS7O3Qq2bEA7MZ273kbqaxclbH0ykKSB9EkoCmqSDcQiJ5eaXO8SBJgU?=
 =?us-ascii?Q?ZywlX5C7uR69JcfntHendpZ25wQuuh/ngR1kwkj+t1oLR3kcF2tPsUqU2RDj?=
 =?us-ascii?Q?3wBFgoVU7s/Rudemqjb9jlQDRt+UlyMsw5ArY/RMWqCj8bcMm08fxER/s9+V?=
 =?us-ascii?Q?1h1iGHNDvlZa8V0tjYmLoMhEGxPplhDbm/B0CtgMov/7VIA2k4itv7xEUcv9?=
 =?us-ascii?Q?pcRjMvUGrDuSa4Njze6iA+QGVU+9icVb48X43+lzj867tVYImjv7cLI0lJND?=
 =?us-ascii?Q?I7YjxAqFKt7+dnh2WXRhyH0HYobn/CFlzRSu5/vFeQsKKhmkUnKmBAjU0RKI?=
 =?us-ascii?Q?T8Fh+kq5qfKuVspjfys7BtMEv8mdja41ATYgwxRNKGOcT+gzrCxgo8yayVIF?=
 =?us-ascii?Q?DOJZePAbHNjebAamoNOVpSUKFyGTO9IhopyYvqsbAAwkrJtekukLEgLA9jIj?=
 =?us-ascii?Q?uyvupKfqVoUKgCuRPyAh3GdMaARZ2LIxDld8gU4z4amkG23wqch41/CUSkgW?=
 =?us-ascii?Q?8Zqd+mbidZGJwz9eorxA7VzlK/de2B1OQiKR4oG+Pa5wI9+HmGox9jsVZFJf?=
 =?us-ascii?Q?TUEdiaJv5J++TRQg03s35aeTG0LgZeOqFeDTcmDyqWYXS9lhapa4b7rmxEgt?=
 =?us-ascii?Q?9Oh1EuQprO6vkHEufnDOuft8brVobqRBkl0RM87KvDEiwnmiaCAPI5s9ZZq7?=
 =?us-ascii?Q?X6CY3nmPsa4wXJ/IYta2InquSBt+9ZP2RSUq3BaWiaqN5L9oOMmu542Sbm4L?=
 =?us-ascii?Q?nbFHvkSBndnDZr1uZQrxowkZ6m4fq7PVTerTMpvdIr0SqXty9P+enh8sIC95?=
 =?us-ascii?Q?/q2kXKXpkC7gXMDXDy4j5/TOMJgBRVRN1WwwTaaMSeDYV5eoTBfGGDO3Fztq?=
 =?us-ascii?Q?xyccuui5/vYrAAw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(7416014)(376014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZlV8tMhvUccFIdZpt1w1acdZDQAB2+h7OyLADFzh7rJDaeKQG2GJLiKoE9nB?=
 =?us-ascii?Q?20HxsJCfuSPO0a6PvSbCT5nKVIFFH2CB0rOmWSggxSdHfrDRNk6Mil9eq49n?=
 =?us-ascii?Q?Pto3ZjHTJRHRPfIxVddEnQb82M2r6rqZ2tLtDIaZJ6qjU7p9dsxQl0sFJKIN?=
 =?us-ascii?Q?C9+phJ2DadYM8Kn0zPfUPjlSt+3x5Jd6YdiJP9cs4OrpMZDCp5QujmIgw9LC?=
 =?us-ascii?Q?jl1sHl4z1Sos2pMTqhHOThIS0bkcLh6ZBuYdoJL+50SeOSuFpwH8Fjc4MNFV?=
 =?us-ascii?Q?8N9cCyZ5xyh6BW6krVm1R3KuEQnYVtNa7Na5yV1/0dqm4Z1ykLt8ypVfmAcr?=
 =?us-ascii?Q?8WcjSv1+1LY+LoXYsVpajDxvk8ZxNTERLJPVbsbI+aCb7xaSISwQlHIKyabS?=
 =?us-ascii?Q?z59uK25AHlKFVa4lwWWXo3kg0kdgVd9rsWKFmVN5cXEMEUptAh4qDZ4AkqDc?=
 =?us-ascii?Q?bei0yuDk1AUlcvdHkPbDslaTi9vTy1CC8W1xpShuy2xS1E8sHowyikRDrYSS?=
 =?us-ascii?Q?lHiSjkyv/QM5wFW8PukYYCNz46Zq6I7sLqN9sgr/14LxRYe85nLl07UrfKlp?=
 =?us-ascii?Q?s+l4GKIXFLDftxQiEji95wULdxPn8BP6oFUl/w2SIVMfzSU9xv2vkxMO18Bm?=
 =?us-ascii?Q?0QGyxteTrKXwia/Kk7pPoVI4X3vm25F7PnNTkg1W5/ph4uuYJ90iWXd3NZ5P?=
 =?us-ascii?Q?y92O5233ZHplhorbGMiY2ovq4OiemhiMci7U81UHWqq8QhRptP8tTv7oiaF5?=
 =?us-ascii?Q?sK5ZLuG9kxNaZI7blRmPPyCg71Ef2LXKN/scn8nRJF9wFMfbrMhqsP5pLv/U?=
 =?us-ascii?Q?M8TiRWtOlCGo2xU56w982PLHgLwZFWZn72rIwjt82lBQ6yU3HtlLKLG/y7c0?=
 =?us-ascii?Q?uREt/rhek1nIQTzrz3eo5MHLFWeMOS2eg6U38vr5eaA68hRQef48qq/a4GyG?=
 =?us-ascii?Q?UR1bSATXT0nGF58FO56tjTIXsk1jmg/ERo93T+7gaARAHQGgEazTbof4dKLs?=
 =?us-ascii?Q?0Q7rXnaRlpVoyEQwP9aO5rmPHhLYYPTgxjdbslGAnU3x6oAsnjC5p9SnyRas?=
 =?us-ascii?Q?ocRMDgvnLjz2Q758EG4I/+14oxTOgDYJ/ajW6RwdKCtmZpbBXffj3OCCduZn?=
 =?us-ascii?Q?d6mPGkCt6H6cOPznHRSaAm/y13N8gltmubPjuyf+A3xQ5Nu8ZvTXU4ui0D/z?=
 =?us-ascii?Q?o/IWUO0xmQKjBPnhcdVIcvHngcImAYoeYPXdclbzST7zGVMGKoCRXdAKlu+2?=
 =?us-ascii?Q?CgLt+Amu70CkqwEUdwBiXNsDb+TSYA05/DJrroATzwto8lLtmLA/hSXUP4cx?=
 =?us-ascii?Q?V0Ln6+sliZq4ZQiCsmAT9PWtbeMgo8W3/f5bo+bz2iAzXyItf3xDYlI+bxQE?=
 =?us-ascii?Q?vOsG4oyIv+1pO/1vgKLQRDkDRijWCad9b/pI1CpkCjpjA0c1CMOcO0i1kNZ6?=
 =?us-ascii?Q?y7VjhMjfy1Iye/7vYMpPjrKUH9dUcMRB/KXnNybL/R3XjN7o3VSs/YCYv2nT?=
 =?us-ascii?Q?A8Yx2KOA2dnfYVTmqsg5DKMm4lTRKhZcLMf1gmncYi9vZSocAs5ST0IURzRV?=
 =?us-ascii?Q?LwZG9hkJZth13ompO5VBvu2Q973Gm4E4+G+BsHJX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98a02ae6-241f-4903-22c0-08dddef068f3
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 07:17:09.4930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9bL9vQQlTM60+QbY5Gkfa/z678rtLHmHSbgP+3l1SUzzvDM3xEhAZqy0Qu53MSZKT5zEUXi1qEonz4LuGuvGwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB11527

Refer to PCIe CEM r6.0, sec 2.3 WAKE# Signal, WAKE# signal is only
asserted by the Add-in Card when all its functions are in D3Cold state
and at least one of its functions is enabled for wakeup generation.

The 3.3V auxiliary power (+3.3Vaux) must be present and used for wakeup
process. Since the main power supply would be gated off to let Add-in
Card to be in D3Cold, add the vaux and keep it enabled to power up WAKE#
circuit for the entire PCIe controller lifecycle when WAKE# is supported.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 .../devicetree/bindings/pci/snps,dw-pcie-common.yaml        | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
index 34594972d8dbe..5283f51388584 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
@@ -262,6 +262,12 @@ properties:
 
   dma-coherent: true
 
+  vaux-supply:
+    description: Should specify the regulator in charge of power source
+      of the WAKE# generation on the PCIe connector. When the WAKE# is
+      enabled, this regualor would be always on and used to power up
+      WAKE# circuit.
+
 additionalProperties: true
 
 ...
-- 
2.37.1


