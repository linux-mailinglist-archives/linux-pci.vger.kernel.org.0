Return-Path: <linux-pci+bounces-35309-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB62AB3F77D
	for <lists+linux-pci@lfdr.de>; Tue,  2 Sep 2025 10:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2A0917E9B1
	for <lists+linux-pci@lfdr.de>; Tue,  2 Sep 2025 08:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC202E8E12;
	Tue,  2 Sep 2025 08:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OxoGM2Lj"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010060.outbound.protection.outlook.com [52.101.69.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E38D2E8E0C;
	Tue,  2 Sep 2025 08:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756800193; cv=fail; b=XKgxFqHN5vNbW8Nhd2qyhm3OeBPrIcpfxJe3LKr8XnPI7MceTfiWHJ+mW5ZYSwQ2pZQAFg7rKOifrFYClO8EZcpU5YVqqUgx5m3mDOnPgC5ddcofKYT9kAL8SevjuPzed6N8YDZ0McluYmvw4paqck08ezCZo2JgGmOXTLIve1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756800193; c=relaxed/simple;
	bh=acCelFb2tf3AUTxLDqa//aA0kgZctIn57T/AClq20sw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a22vVhvOt4xgko+7FBT4WfiO/fhNk5qbJYzK7qNZhNTgQsb1DM1m3+FeKh+kEk7Jdv+3dI3g/pHqaNJJQTvAuGx4/wfgw49Ha/I0FohpjvZMN8tuEOZ+AjbrB0LqMFtNZi9CQLDgNHKxIQSb3mpIJ7A4W8n5MrJy7CXTlErg6i4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OxoGM2Lj; arc=fail smtp.client-ip=52.101.69.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AF10RJCXhJno5AQaLZtk/7Q3BO2uDsbk6gUZUYkSw9jzKNelnkuqTvO4OgXB/FBW5rQuW8siCt7/YQ6sAdCKzVmuvoyDbU+keknOAMWsDDbvzhGvS+4tio8Qge+ZspyMPA4X4fJY6YEv2mVynJZAEtZGh2TOUCSiRyVCnCdio6C2MpkAFGOBxyqKqniB9mZkSYNYcTS049dTmSiUpOZwrKDsha1fEDBNuSycJgNgv3loTN+qZXIFtljmFn+tSDvBWNvHwOtZhyMWEbNmpTU5r9a9G/oEobDxbUV1zk622NVQRQViUzAuuQCoDZasidXZdcKQGtlgMfWU8DruzjA+DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5TEveY2keKMel3uEDO41NRqO21YKgEQFKeKNu+ATs2w=;
 b=V8i+9Xo8fxtcg/cTK7pvQqs0sZZACvknz6oSBBjJWIm6SdYavxV7DcieUeRuNljq3TrbixDtKKE1Jkl9RkP87E9EzLWTymbTsYiayBmTgLsO6/i+ytMfx6SaOPkJYy56pMZqoPmGMwAfnGKvMBf+iOszhNLgopIpDJ5V4zB0xWOgO8EIz4VRMOP5UwkeUyYgGeEGLi8D0FaWgpkvbwJmfENliw/8XzrcTqlC/7/rGQtKiJXAlAqvN4LJytDF6jH2fUl7WDT603MtVgq8Txu+X9b5Ld13+ziB/uWPVGKgKX3www+uPcopiY7IEMXMhZ8P1u2dX2iBL86xkGt7//DzEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5TEveY2keKMel3uEDO41NRqO21YKgEQFKeKNu+ATs2w=;
 b=OxoGM2LjkB0tCJZ+gClAPEKv2aTuWYXBBekKgZDP0k4yOs1XJ6TS1UQSrCUECw1AQPK6M+v/IDE+zY1GSfvOgPZgNLfn0b0rLYLTDb/Fh1WivwS8fcHbt9tzu2ogwQMR8iFm+LUU3lSNnC6Rep6zAszEQuwdRQutH6XseRhJI5h/mRJugaFmSg/jwIZEGOebgJYG9udJ4C4bC2JjUAJ6Z1FrTXAMFM1+dlgYTI4Lp9od3vrxquJY49TZWtVQKAHeOWTJxCJYvRz2p9q7AA6wtveCDpr+trVviqgKhiuvm1jvLoRSDjyY0ODOe4xUnPAXaHR2n1GSDc5dESunSGYGHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by DB9PR04MB8265.eurprd04.prod.outlook.com (2603:10a6:10:24f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.14; Tue, 2 Sep
 2025 08:03:05 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%4]) with mapi id 15.20.9094.015; Tue, 2 Sep 2025
 08:03:05 +0000
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
Subject: [PATCH v5 6/6] PCI: dwc: Don't return error when wait for link up in dw_pcie_resume_noirq()
Date: Tue,  2 Sep 2025 16:01:51 +0800
Message-Id: <20250902080151.3748965-7-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250902080151.3748965-1-hongxing.zhu@nxp.com>
References: <20250902080151.3748965-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0087.apcprd03.prod.outlook.com
 (2603:1096:4:7c::15) To AS8PR04MB8833.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|DB9PR04MB8265:EE_
X-MS-Office365-Filtering-Correlation-Id: 3694f74b-f3fe-4a98-445e-08dde9f725a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?e3EXTBHAkn0WNvy2dKZ3GOwtCiGAJ10sq1/dOWxS2L54TGk9eWRzO2xOh7WW?=
 =?us-ascii?Q?a8/Bn0oWdzdJe1IqDoaB+w28CteWzCIMZHYN8S/YxpszEZj/tP8F7A+aVGsz?=
 =?us-ascii?Q?I4InofDaXHtHaiGyw9wBseKSweaQfPFAyKfZ/LaCOE1J18j0+L9KS0c5vYAw?=
 =?us-ascii?Q?fOPSpj/4VrBEEByIqU2GSq4xGDPK4V5T5k56aIsvAEFeMaO1URN3rhFA+Ck6?=
 =?us-ascii?Q?XHT5FtISF4WwUD5tP3nAvGeP67NIJM2Yctw8q+DO4PBM9F7ATYaB4RxeC/lP?=
 =?us-ascii?Q?Jr1jcOB0hBc65bNVGai9vsGRu4dZmua5FgO+SVfMwyqK/U3C20Zaz08tuquE?=
 =?us-ascii?Q?DYovvNVtwoY0IIP+66AqJBZrJagZRV3yjsCUc4knw3Wc8JS3QKWiw/7gLtqk?=
 =?us-ascii?Q?HQofOmRACv1Lu02AEFE0HGl+SeOcVHLtHfLh+jMlBkXNuPekRCEysP88alJV?=
 =?us-ascii?Q?0w+pNUB93dJU6kNmm/YQj/oineCIunDS5tuWhtbCfGVdts8UAHk/MikCf27f?=
 =?us-ascii?Q?VGkhPNcjjAJaZo1AEwOhBro8xFESfJ2h04RKnRBKEKHRjeoRmKgUB+UsAlbF?=
 =?us-ascii?Q?3bAGFgxx29vju/BPsygCiwZGVqsTIQ16i9hy9qrkiFF+lTSOG6zE6Utyx5cl?=
 =?us-ascii?Q?BSQ3c0MfrPha3yjzLcVeClAiuxlOFD889jmOMowR2HW2PhoiYPoVXAzvWnb/?=
 =?us-ascii?Q?gmqGobUMMYHmBFzQn3JuzZWsmWrVteKTbYoGiR6t1SLIGvPUKFxEcf71QvPX?=
 =?us-ascii?Q?GtNq8+frVFPMfy6XDn0MII3qTsRVITL+1t8MFia3rVK1Ezlx2SQ4tSDkYUy1?=
 =?us-ascii?Q?kd2po5q9yJr4Bs7wBVY0Saa0EIBA9A181EtypPnKi5MBO9xHzMh4mVUZKvdr?=
 =?us-ascii?Q?Vw0+6eoYgcO9V8caftmJBo8v9+o2TiEVFpuKpQ0qEwZPKPzgePQKZfSfpEjN?=
 =?us-ascii?Q?AOQprhN7PGV5iZZiAnPakPuq0ZL52AmGE277ZAtsJlaGn1trTjVVfGp0RLmd?=
 =?us-ascii?Q?YYZ5eQvz+o9SGyjhbB4ARok45yQBVkH1j+kWnUS9qSibXu0bpCk10J6hSXvW?=
 =?us-ascii?Q?rW4oBxSWINSHLx9TaXnRS0Nk+y3sSz3n/JHlUZfFr3NeTu2jM3bH/zH+JX2Y?=
 =?us-ascii?Q?riXCFoNZMfnHNZWbLG7FADp3CtZVJzA/cjKxlojAFOrkZ1BSrE3wj1phMOuM?=
 =?us-ascii?Q?2tAVc+mTh6jP/G2L8XPfvPFjbZbJqAdeyqqun+IixfJdr9ZtEaZWUXGlXBbw?=
 =?us-ascii?Q?z08l07Wr32bUTKxHTzg4j7F4+xaNW5mvKQuN9eCfvc78Af7Ft1PkwsnYpg6s?=
 =?us-ascii?Q?W5bWsejYozdKdilPbWOcxgMkI9rnWAltN6nQ82ksKpbJC2Xr3Dp5nCPql1lz?=
 =?us-ascii?Q?Mf0/uXVjAB2WhsyT+WNDG7dyWfQblLbpHmhT1q2K8m2tP4kPN+Zrxx9UiLVJ?=
 =?us-ascii?Q?xWDHJT+KRlpRnWDMDVjTacCZkvPtig7cM9uDgBjXZGkRIgR2xUm4n9wRIJMQ?=
 =?us-ascii?Q?S6EvTmdcBMQYCt4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FOfiznsvuxo7oYwzGJ/cgzWgcrz1YwVp2FSkZZdczQst2+zg1RIzz8gKhvsx?=
 =?us-ascii?Q?ELgwyFugXuPuy3CitELQTKoCfcJY/EU/U9Tvgi1lWCoO2Tia2jMMONbFXKNd?=
 =?us-ascii?Q?YP25W8jBIxyRomzfL0Mgxzkr6M9NgRq/jYmYNR0eTB3sF+kE2gqtykZCOgEi?=
 =?us-ascii?Q?o9AsuNMSsOjmvmT0jDmGoFE7MlakNAxsmtVOYC72RbcNVjtfcqSA/d/tjjOc?=
 =?us-ascii?Q?ZMQjz/q7fwoMV4uxilDwrvYQC7yGVZ49stKBw+7SUppz64SWusWGb7d5GOKF?=
 =?us-ascii?Q?ukzBn1UyEW95cDdI39hQkkZhZjFi3MTF3PlQungXL7RRyXcG00+KrJRXouhC?=
 =?us-ascii?Q?SE2j1nLBuWaFCLNLZyXoPF+IsrxVBsWdV0S6JT5umP4Cr5t5hjqDlbi7yOHy?=
 =?us-ascii?Q?TJxbCHyxO4lHW6io106BXb0he49tZzvIEJojkZzi2Ac1Is9UQWeFctMmZlPD?=
 =?us-ascii?Q?nyMWDFWOoNIMdmGHS+tB+IBsB8kjY2v2P/Y9eUAkmMXuX17J5YY8elu6DFCt?=
 =?us-ascii?Q?vOrwXptAoXdI5Ofd8kjxDTftiuZyuWCRSWS5yi9NSJ9L/lq18uWmZJUIyH99?=
 =?us-ascii?Q?evFwGlUsikODjzI/3DOsgVZiBnIWm8WUDI8MLB6vZx585Fj+J51Ut5l43c7n?=
 =?us-ascii?Q?C29QHKnjC/Z/b+YcsclFHgQo5oXpfFwnCxkqIAJ8Oi1mftCodvOHJ5VrBRBG?=
 =?us-ascii?Q?AxemJ2If4YyeWUyzkt3o9pzKOew7SyJWCJdWDoJ/duMsC31gELJcwjUciae5?=
 =?us-ascii?Q?9PDm91vL7qC16tho3vCH42MuQZ5OqLBVQnwPkbhjktz7ZwBaJ6vVyMGW+2sV?=
 =?us-ascii?Q?ecF1sdL6uizOVDGFNJ5iOsXKIFQWEmLgs6KpJj4QJY5wNu2thZykvPjocT1g?=
 =?us-ascii?Q?Hi7jS54B7/vXwbuZzQPFUXuv/tHs+d2sunT6yBSrSGzesNuEvvNcC1D55JiY?=
 =?us-ascii?Q?mp7KkHuSdZnrCcYH8Pelg526uACmsmrqQBrtGtqy9J+wZ46yGZA6Xn8tKd/8?=
 =?us-ascii?Q?pwo06KEhBArTo7iB5Txd4GVe/H7l7P8UzIoKjcSn8A8SLVwSsqv/duqeColI?=
 =?us-ascii?Q?EmArwgxqv5Xmy3fHnhhNi3Uflg3URqLzAuekKUKdGoSRpKDMB8b+R9e8Ooe0?=
 =?us-ascii?Q?7kKsceG6hEsF3bo3YTdtg5D1kOyrArqDq9GWdQgDE+1yH9ZTNEthyXWs/S9b?=
 =?us-ascii?Q?vPg3H6hZCU1CHBaPqV6tknt1qKykWn3SGk52KhEp6vbpdjlC0DfPBhBehCyy?=
 =?us-ascii?Q?jA/G2M8/NrN7pmdepfozrezlqRgf7Pe+6EpPFBbZq8tJoVBscGlDe+GPsKKe?=
 =?us-ascii?Q?jOVeSC/9nedOgF5wpn/aqNdASrZt/OpuU3W7YEPwZu8R9Ruzwu6BHHvouwy9?=
 =?us-ascii?Q?zAXtOmuOoY/LTcstk5GpjboKZGQWqjhs95eVJwyYfrVmbDvv85AEipzAo3OQ?=
 =?us-ascii?Q?BZxdc4KQWndcAVSxbY/lemjVrErZ+Qgqm5bEuiC4tY4iIub7I+Q4zbpuCOcS?=
 =?us-ascii?Q?ufujfVylAlZu0eIhn3YrkfJgqmv33QFzwui9f0mDDK+lFhSOKMuEsxqBAQU3?=
 =?us-ascii?Q?SUgxsrBrYXfPXNGeCvQRWB3N9t2jdkyj/bnmvtNc?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3694f74b-f3fe-4a98-445e-08dde9f725a4
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 08:03:05.8116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: brx3MCapRPYGHogr6w98vA+tZ9cTp+iOAXhGXj07iMkMfMoxT/b3jL3cM8P0yyqPq/fZ3WQjL+mz82aNqVRKuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8265

When waiting for the PCIe link to come up, both link up and link down
are valid results depending on the device state.

Since the link may come up later and to get rid of the following
mis-reported PM errors. Do not return an -ETIMEDOUT error, as the
outcome has already been reported in dw_pcie_wait_for_link().

PM error logs introduced by the -ETIMEDOUT error return.
imx6q-pcie 33800000.pcie: Phy link never came up
imx6q-pcie 33800000.pcie: PM: dpm_run_callback(): genpd_resume_noirq returns -110
imx6q-pcie 33800000.pcie: PM: failed to resume noirq: error -110

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index b303a74b0fd7..c4386be38a07 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -1084,10 +1084,9 @@ int dw_pcie_resume_noirq(struct dw_pcie *pci)
 	if (ret)
 		return ret;
 
-	ret = dw_pcie_wait_for_link(pci);
-	if (ret)
-		return ret;
+	/* Ignore errors, the link may come up later */
+	dw_pcie_wait_for_link(pci);
 
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(dw_pcie_resume_noirq);
-- 
2.37.1


