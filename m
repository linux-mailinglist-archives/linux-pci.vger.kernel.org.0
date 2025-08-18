Return-Path: <linux-pci+bounces-34171-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E20B29ADA
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 09:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E129217B913
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 07:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B741A27B500;
	Mon, 18 Aug 2025 07:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="b8w9D6VI"
X-Original-To: linux-pci@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013019.outbound.protection.outlook.com [40.107.162.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EFE2749D1;
	Mon, 18 Aug 2025 07:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755502377; cv=fail; b=cd3TGXsVowc3zDuTCfE9vldM64GcThxJ6vETWia8vGltNfXkm8y1+Ughr2DL4Ad9L3RivLSrV2lfmuU4uMXG04m1ASI1Z0zFDdwJML+kwY50eh8mX5UD65IGG3vRzRHTrlcKCO51DsUl3usQTNtiDswWK5ZqJiSAE3aisnepk4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755502377; c=relaxed/simple;
	bh=dOefhoii4Un6tgTZTjDVtyVXgOWm9Dj7Cj+Sdh129KU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GTnKxvoWYooD3Anv74ny/5S++J670tCPXOqN6nIFSbWs0te6F81OlLO+JNAQuvpjCLak68xzkyI0ckUasth33xO+s0ifvlvHg6L6BInInX9uxOfDy/VXRxa70wOEQu3IsK7G5biMN44uqlTsyBubW+t9JYvzr/LSt+dWNBjjHtQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=b8w9D6VI; arc=fail smtp.client-ip=40.107.162.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z2Lihi0i0JapslJCtMKmuxtyrxzO7IBbGK8nlIQGrjjNKeKIti/od9KPftbEdlRHalrE1IAPDWJSvcIsEBkSgeWC8jObApnoZ+QRMYunaRuYUyS5KlETzYffguuxYM5UisRAdHCh38GV9QpBj5oKj2m9Ip781EapseYUqzFLNyAwMkWxjL0CP+PiVayKjnAzaIQehE9BpmKgU/DtncpLco1yzGqnwALx9ASwZNfZMvL/i0EE/b9MPeiwLjEn1HAMyxuVKE7SVGefbdCbTjkmS59d02cIJGeODt8Ub0Xsqm12dJJXLyJ0e21mS/gDlov6KfgZbZr4HRWvncYwycn6Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XclEIJlq6aFtGfUSMfdGCxYbItv+cQcBQN8fJqXzVU8=;
 b=bTUHTY36A8u8VhJBs1ltJID+4+0RLQbLFWAJ1xzJKUb3aMnmFqXN9JlIhTG6zA2bCzbbJ+pydDPAnw+aeGD+tFnO+yyG+iQMTZTAZPqFYi8xbeInUkGsJyhpsOmuUjwhtiw7V9XNCPlgnZMFdhmIWGHAj64ehTxvyf3x3xXkjFINDNg2TVydc1rij8SBnl1KtM1IPfDEyXlmErCINv2vyDVVLLjFwtCPI4yIhDvllhgQ2h3uYnqQVCIJOoi+p1ZJ7fGDWzahNrx+3k5CTxcFFUcoHuNZh2GOsB+gwMFCsYwyYhoAeldmzk7sS93589qgytebE4CHk2+Yw5Pj/M00Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XclEIJlq6aFtGfUSMfdGCxYbItv+cQcBQN8fJqXzVU8=;
 b=b8w9D6VIP0a8xuyYN+H1SQdfe6T/V0fIn2XJ7khQUrLn5xlnFUkvfpcCGUlO0kCroUkKp+ieUuPSGcpabJ0WaW8nAaOr929RV1NOOVJNDA4dMUsQN3IGfL8+QlEtgFnPelNU9VHAN+YCJOx+7bVYu+Qt4ky1H+as4JOv+Eqi63bbaasFqWTaMgodJ/yzzlm2huHw2ESd5+zU+zPWZkdeTsbX1gi8DVDK6iWm86QUlC+S2A+uGK+LtscV+prsnZV8dUrrTvAZYeKUdEuPmQ2G3woourloXJdz93ZEtxxe2HvDJrroJD5Aa/6bkoMnMJ7QfDB6BjPoIXtuFlAjs3kUOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by GVXPR04MB9878.eurprd04.prod.outlook.com (2603:10a6:150:116::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Mon, 18 Aug
 2025 07:32:53 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%4]) with mapi id 15.20.9052.011; Mon, 18 Aug 2025
 07:32:53 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: frank.li@nxp.com,
	jingoohan1@gmail.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Frank Li <Frank.Li@nxp.com>
Subject: [RESEND v3 4/5] PCI: dwc: Skip PME_Turn_Off message if there is no endpoint connected
Date: Mon, 18 Aug 2025 15:32:04 +0800
Message-Id: <20250818073205.1412507-5-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250818073205.1412507-1-hongxing.zhu@nxp.com>
References: <20250818073205.1412507-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::22)
 To AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|GVXPR04MB9878:EE_
X-MS-Office365-Filtering-Correlation-Id: a45e72e0-25f6-4196-e8f0-08ddde2970ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|19092799006|7416014|376014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IR7QkZXBiHQoFNu9/hTzjIoencvTXm1F9pfgc5aFCtSH9A+WqiXZvoiqiX3g?=
 =?us-ascii?Q?y8stbWQEyNlArJgqz/eoT+HGMsb3QXpq5wCtaWP2NU9tsruS+x7XxrGvK97T?=
 =?us-ascii?Q?QIwFfiaPBeapu1kMKkNQJRzCxZdsKehy7KmJIr+Dg3tuWl+gQt/VzBvaa0aW?=
 =?us-ascii?Q?MWEGGcfswHW0RtbEmMtIueNPvJF++LyqMc1fyXqTyAH9JRZls1vCVPlooJdK?=
 =?us-ascii?Q?YQhjSAxfmBuyqA0ThfnW1p+bbI2v6oI8ufxPxKod/8CnHD9CvbFYdYMEFcw/?=
 =?us-ascii?Q?ij27dDf7tKALD7ti3yVb9NdOmdmDZ089ZKWv2zcXrDsdH0o8c/IM9rwH3QYy?=
 =?us-ascii?Q?SRw6lMMDpJg/fciCMCX7G1HBf3F+Gjuc5iqp52UBEqhH1usB27Sobk4Wboq9?=
 =?us-ascii?Q?z+hxXJE+x+qjc5cIqT9riWEbIfHCwuq8IklYOHrkc7n8TOMMp40ro/sAElJJ?=
 =?us-ascii?Q?0rnjpxdRAlcCgWyLnKlukp8QlttKNqwKzWlOxhXNE/t9snK0W62nRCdNpZoZ?=
 =?us-ascii?Q?1Notla2bjIJM4N2QoH+89+d59oYf+Bz9GClC+AhbdTJim4/8AWhHqazy4F7n?=
 =?us-ascii?Q?ukQRwABaZzWk+eGDW8Ro+q8y+uFfo7LaTsYI5FD9WUpddAfp5WrghR3A8mtp?=
 =?us-ascii?Q?tQ5CTyyM3x/XA9NXeUVWEiLD6P27OBEWXAaFVZGMxyjPuoLQT5DiLv7h292q?=
 =?us-ascii?Q?lKLZTz96Xqxw/+LoVXNl96NWCtuJ39zjb1vkStWIMBvS1wfYlFhscVdDUyb9?=
 =?us-ascii?Q?6wnFgaFZOpJ7DdVZExirfv9hybkFP36hlnjbjwMFhLXG0Zd1JI4FJ9hWeqOT?=
 =?us-ascii?Q?A1+aB32bQOBf/kKXe1EUy11AQv8Sqp1T+YJTZjwFCbc7qWHpaXY40ggh78dy?=
 =?us-ascii?Q?YcSbP6J06GqP0ALd3PpuZZOasYICgzWx/0iI8UoBiwa0FvhFxu+j6LW4ZDRy?=
 =?us-ascii?Q?PXe4/v1hncDpoxOVbBl9OJnZmqZcyBbj+47eErCnBr8uYQId+g3l54Vvw3la?=
 =?us-ascii?Q?80HEWOvORNYrtNTeZ67ZPTm2myaoFqJg3dowj670Kp04AlF2OJfVIXInXp2M?=
 =?us-ascii?Q?MSnPT3JVIEt/KEZ5t24kaRE7/aUzleiWF/2fS/CdcLgEP35eNXU09ihXJdbj?=
 =?us-ascii?Q?Ej1VWobAxTlVhz+ybep7gsAfxe3BU6KuvLBKnTXfM/pwlAHF6bbVJ7pITeO/?=
 =?us-ascii?Q?F+8GSLB2zRq/sC4AgjD3JOyXEUW4FD6WlHeYmzM/xqBilDMbFvO0C2CcKdAN?=
 =?us-ascii?Q?iWE3Tg/cMjcULyxpPGu9jrAED0DnLJmFlrk/8I6yYVWO0wJkuxFZm95UKI+c?=
 =?us-ascii?Q?7Mvo+maoOdZyEACTChSEexyadv1y0LOqjt3xeBYByrOzFguyADK/zT6GUMLn?=
 =?us-ascii?Q?D1+4qofiS76qm5uqWW9gHWTdrK017uxGE24HeZ6GQtAjtjdrIfv8YIEUkwYn?=
 =?us-ascii?Q?YsKjvFJ0pusIvR48jKogF+XDtWPKu9OMyGY7bMDHpvxCJbnqXyXJsJSt6KyS?=
 =?us-ascii?Q?4rMed8wirtYjbGw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(19092799006)(7416014)(376014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Prgu5HY+Agn7Vzat2RjdRRTAyScFqT2e7Bahm754DoLNHkNcnRkeXzAFCECo?=
 =?us-ascii?Q?ZGr27hG0dC28J+KwXu+uvvyW5xmQlZ6dbwwq5pA9H4K1kSumJqpjNcc2N54J?=
 =?us-ascii?Q?3UsyFXCbJgkEPXW1Q8d7rza6QfL3NnhgAJufUyItRZKu0fVJ9CdrfQRrn80G?=
 =?us-ascii?Q?QPYE+j1/xCiI4TfJ4F8XZ81dHKq1P2fTQQouSKzvT3tr6HhT16FZGVsV2cgI?=
 =?us-ascii?Q?H+/itq2EAGfWOFD1pp/3KiwYkZ7QhDLyd3gmNX9NHPyL7BGDq7rUpwUbUrPS?=
 =?us-ascii?Q?h78zGUHQW8W6vIAPVuYBj+AyFfSXV1pPgGlo/Kz8ML64tnbmRYkJSwIx/alx?=
 =?us-ascii?Q?dWlPC5Gcz4Y0vMKOpJ/h8mCUDMWya+Z00gMfRwOsAzMcp9VTBmC9Y1MS46pY?=
 =?us-ascii?Q?xkOHrfK8p9SvCbBucQW1x5BckfcjgfmSyRarHvnKGyXmft8lxT9zmrryJBnr?=
 =?us-ascii?Q?sOPJEoGQkG7vakXWb1RTDNQ9iMrd7UszKNSLp/tiz6FWTBnGYh0M+p+rVMs/?=
 =?us-ascii?Q?emu+hOQXXvaDKNyuMb2WfXgDyR2ibO+plifXOYPqNgBZ4FR65LtbymLfGK7F?=
 =?us-ascii?Q?h6sYqy2GcnDoiTFeNN43lkePVKQcg+SZX2aX53WihOf5jLVjVjrtYIQbbMFN?=
 =?us-ascii?Q?rR8uThZt9tGDwPQgik4vq/FbwHpjFPWcbnbV1E3A2NIJuCro/NpLQ5VwX6sS?=
 =?us-ascii?Q?UT8hxiSRVM0EYUu3Z4LmEQiamXQrquAXcVzVPsyLtirUJ97DNgdjgvIBfB4z?=
 =?us-ascii?Q?boMSnEPcsD7OqvqvSmw8OWE6v/AGV5+ST3ciWnYXNH7Dl6y3qvui69FPPDKq?=
 =?us-ascii?Q?9LC8IDcnDGtNt8ftVNHGPy+z2MMx8mqdjciJVP6dGMM4EoUbuB6Kfx5eoNQ/?=
 =?us-ascii?Q?HaozXvt9jiCO7H71mlQsDn3uSNylEtS1zBqNns4xtAZwRmTY9waS4Ur9YqZt?=
 =?us-ascii?Q?C6joymg/RLEbCZXFhYXIhPvq13q0SJzE48iShdUa+9EmdgpM9m43vguFUEsF?=
 =?us-ascii?Q?IDhsSfJk8hbXZXPVQNcLRJWPPs9betQiXaECFDg0U3L70KPpfsbm0vILRfbh?=
 =?us-ascii?Q?qQIRz4a8cszjdRcSBDQRQmr4HAWGoBxGgzq+dmYNaX0a/xEdKFIy8kwBAjWR?=
 =?us-ascii?Q?U9fGwvJxs3Pe8Z/nd3nhaMX/7zVXR5v9akk2SnKZsQ+ee4X9rFaYebhCvCM/?=
 =?us-ascii?Q?CuyW7G+l0yTcZffPqS13fQ/vRO7QXtaA1RWmImz70/Mr1cwO2qovjk4gS2JK?=
 =?us-ascii?Q?Qynf985ob1gEuIZldM+8d2Sh8os4XzOrqqXdC8WiEVgkR9ae3esSwLRj9ZDR?=
 =?us-ascii?Q?KyRw9rXN2vkebVfcIHFtNIBvbVxk8Orx7k6e1+SdOTaZw9+4J0j3U8p0g+pD?=
 =?us-ascii?Q?t3bKMV9m07fZK+1+wZSysNbON0dcjFcmiZluqHmDfRN+Na0dRDxaLQl/3hBA?=
 =?us-ascii?Q?lazybB41LXwAyHMcIEhII5qN/po5SEPVd06zgjIj3fhOENzhkKhGDvdnSE71?=
 =?us-ascii?Q?6Lje1u6CFNaUlk+48RMY2b0sZCSTegMlQpZnVZvqi3l4AhknENvrTHKUVEF4?=
 =?us-ascii?Q?QAxxzo561aZiQiaMQGl/MX/Es5QKoUxe23sOD7qH?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a45e72e0-25f6-4196-e8f0-08ddde2970ec
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 07:32:52.9978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A2GUfxLHPaGTLYyndwJP8m8kUa0om8YXIzQHx5IRuPm6Tw98oZ57Rnt168fQSmzE4ez/7nZrpIwEIcygG6iFmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9878

Skip PME_Turn_Off message if there is no endpoint connected.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 20a7f827babbf..868e7db4e3381 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -1016,12 +1016,15 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
 	if (dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKCTL) & PCI_EXP_LNKCTL_ASPM_L1)
 		return 0;
 
-	if (pci->pp.ops->pme_turn_off) {
-		pci->pp.ops->pme_turn_off(&pci->pp);
-	} else {
-		ret = dw_pcie_pme_turn_off(pci);
-		if (ret)
-			return ret;
+	/* Skip PME_Turn_Off message if there is no endpoint connected */
+	if (dw_pcie_get_ltssm(pci) > DW_PCIE_LTSSM_DETECT_WAIT) {
+		if (pci->pp.ops->pme_turn_off) {
+			pci->pp.ops->pme_turn_off(&pci->pp);
+		} else {
+			ret = dw_pcie_pme_turn_off(pci);
+			if (ret)
+				return ret;
+		}
 	}
 
 	if (dwc_quirk(pci, QUIRK_NOL2POLL_IN_PM)) {
-- 
2.37.1


