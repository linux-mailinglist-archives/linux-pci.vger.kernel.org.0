Return-Path: <linux-pci+bounces-29995-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 904A1ADE13E
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 04:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43559189D192
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 02:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6801DE2D7;
	Wed, 18 Jun 2025 02:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hRR3YN3n"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012020.outbound.protection.outlook.com [52.101.66.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B524B1DB356;
	Wed, 18 Jun 2025 02:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750214617; cv=fail; b=n5tnq9MDPVfxx0BJr0XGzb9NkIcULF5sNaH9Z59RAFOwSCd5RdEg//okgG47LENmuNh98+okNq9GphoSSOmBftnGRaOh0doi4u0+oY4p421mkbo8c7FCtdrFz8DqgmCIeMFlLUxsAF7yF7IEq1lHkItM9040/bMxaF2jv/I3S2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750214617; c=relaxed/simple;
	bh=NBlmvRVaGh1Ovh6AxafApDtGc6vsdd+YsXqkIF/oPTU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XJUJoqS15fZqvd/kJZBJcEqHRbKoVGxwmN66b738/BzCuV3j8KUQH6lKzky6fo2WPtNYcoABjA1/AoNb+aZDB2y84nk7o2qIt2CBminOU/vkAqmkX+Wq0i9txjzwwHzRqk+05Qp1YevpFYeu/uLPLwku2UJgQMEsfdeF0GtLxQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hRR3YN3n; arc=fail smtp.client-ip=52.101.66.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l6tMZOMrZce/rUHBYjiDXVoub8iurCa9FsdGuWQ0IcvFu6ZjgY+fDwpwLIXyx3gdDOkhFM1XB0/EzhgpY14JD+kvQs/NCRsbkjrSimQ+LpdsrV8bBZEBex8B7vSKDJyJnhh0qaOGYlf+9+Xh4oDasKrCZcC1ADO5GZ18+jQsWbYC1QEF7ePNQFqOmFOHET28a6FZJPKgR44rAoJF8tXn4dy3zzqcfkeu7p/EWVRMQeUAahmJk807FyhDaYZN5xME2Un6CUXR8tCUzF/VWE7VP+2+oICzmA4XnptUSf/0Ig0o0H5Lb5JIDLF0pin4gG4En4Py2k88OCrf6+X5OtjEyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2sBB+AhElzYQ1ECpCd3gVWkwc5268NfU9VTLdC4rzMo=;
 b=o/Df9Lgc8T5LOoMQ7uuZIe68Y1sSVIaP/n7o7vOOQJVUkKScafOZsJc/4JSHb//hoM1AgLX+xB8jrJ1W0+umO0UUyecY9L3k8ENIVxTa231CV5CmOBltk12/Iro0F9SIj1lUGVqwpq85mHa03tr1b37B0Q3wVLpHRVYRMKCIfw2ksomzJrjItmm9FnDuvAfuaoHG9JaXZI0WHIuCvgTqMLK/WMuJZg+Y3k+azZDByeL9Y09xcApeVfzKIZpYMmK9dHj5kwi8QUmBUl4TA4WN4eOzA2sNopUYAVJ/iJFS8d0gexbOfxvtKxc6ho+Cj6z1E9UlAKpB+atmx8rgnxi9LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2sBB+AhElzYQ1ECpCd3gVWkwc5268NfU9VTLdC4rzMo=;
 b=hRR3YN3nr1ml1WbfGcTnfQsda+p/B3+olqmJpJXHVAFkkZr5eGVDZThGU/UXiDtuUt8CglLgQ9HicM/Sqd1UIrnSBFsQrTDxbLPPgsKkfF9WLwd+gF3cNA7Ue7ZLvBJ60ST3vbH92Jwqge1ifGwUJCYBhosuA99505RUNopk3FHQKfB+ywEkYDxjbDbempBfp0Brs/4jIuismTPDlSMIQ+XbzSRtSH/iTzeu8EigdA7RB1mvzy6C9Tlq9aQ7mKF16fa8E1bEgOoFtJdAbtiyLwlG/0xkvp0Wc/Uj9DsWbfuAUoOXokLMwEWIFaNpq9NOpLRRmqJZhIQ4SEYb1hNhag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by DU4PR04MB10960.eurprd04.prod.outlook.com (2603:10a6:10:585::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Wed, 18 Jun
 2025 02:43:34 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 02:43:34 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: frank.li@nxp.com,
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
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v2 4/5] PCI: dwc: Skip PME_Turn_Off message if there is no endpoint connected
Date: Wed, 18 Jun 2025 10:41:15 +0800
Message-Id: <20250618024116.3704579-5-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250618024116.3704579-1-hongxing.zhu@nxp.com>
References: <20250618024116.3704579-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0011.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::23)
 To AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|DU4PR04MB10960:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e411f8e-aa9d-4fbe-025e-08ddae11eb86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?moCOQWzdAfiu79qZWhs0DcTGJTpEq79UgHwjD7Hp6bdZNA09olIc9vsBSgWE?=
 =?us-ascii?Q?VmLMwadbmPmMVe856DHfhMEdgJPgRk2cCfjGluLvi+sqMLHLsef2ZTm+87Ev?=
 =?us-ascii?Q?pCF8+lX2pb5Wdei43eKbcVSIQ5VSwWYLkz2KeRGbK8MN9QQAYceeAtZIE1JM?=
 =?us-ascii?Q?J18TNR8HLqLE13Yf1ZDQcvw/z4GE+Ro+3j6x+IcsWsJtLSmDbTv1b1DUaf9k?=
 =?us-ascii?Q?0DrQF2Jc0huqJn5EffxHHEz6ZFzITed5vPPuI52OMsLgLJfIVAzyX35R+woN?=
 =?us-ascii?Q?z2mP4Q3gpyQ1zHBqcyAH7aWVcR/T7CT+OF84UMVgMHUfQNMJYL/AplCO3uMN?=
 =?us-ascii?Q?+UhtUctrc+tJo06DJ0eig4kQN2PVA4rQnAGyU8UV2p9CDgbIh6SuHEMu+gVs?=
 =?us-ascii?Q?WXHY+5/QoZQ0dEFgXHgWm8ybmoOBH3z/KLqIcji9yY9RcjaEChpzdRrmGiM+?=
 =?us-ascii?Q?UUNPyk1NDE/SOKdKVWkH6FmqoTXXbQkgRwXpROUthZgK+8XU2nKM3AGWb5Sv?=
 =?us-ascii?Q?5agWsAFJf0hSEnW1f/Qj//78+jge7QAEZYxGONtLssAPc4eCHheGmOB/Lqmh?=
 =?us-ascii?Q?ntqi71Cxe5/i7BfOwJ+3FXxfQMYMH3orVD33ZAYWAEV3LlENL/ohK7kvQX7u?=
 =?us-ascii?Q?NjkabOlPHFi+xHDKP3PXlwodpHo/AU6fFNC2hWs/2wqawcNIrFmvDhCAjm81?=
 =?us-ascii?Q?ni1ERu4A3vlPLOQDFmA9ehAKY37IRFZYz/fLGFUt8J6aaVOyYidTySzJPI7u?=
 =?us-ascii?Q?XsTRxh7PpugZh0+MqXRpjEZGB/piiBX/Y+c27V8P18sa0owM3fdlIocfKURI?=
 =?us-ascii?Q?3DbEIKtkJp1wi+E4KYsRQwzjpme+T0CrL+qlXJDShO+PBqsDDKZuSBoCN7T1?=
 =?us-ascii?Q?hMlCRpHJKyIQdxxokxk1yDGNDBfVO7jPbaY3XfYjS/UWeU5JpKZS/zVPYz3a?=
 =?us-ascii?Q?p4EamIPM8BG4EqCXHlnBuDEIPxCkQx1TcPFnn+z6vH1/ex2egj+gnrSMLtiV?=
 =?us-ascii?Q?y0Eq1snTDsrTv9di5QZjWGE90ocqMoG5JnTTp358Q85A6DChyqLmwenRBvq0?=
 =?us-ascii?Q?w7LmDRJET96rAhPikwdkBwiezcGaeICgOBGJ32WsYgdcGTh8vn55yQPNj3ls?=
 =?us-ascii?Q?/SMFT1y4fwASimokgdYUOaB93qGIXdk1VQnDdctUIBoyKjOofVG0HdGK+W8v?=
 =?us-ascii?Q?RWK7NvkqDjyvnSGVoTH9zf8lnwmM2Hc2lyEQY/cTudE4KlQDNP9Pj3mkFxE3?=
 =?us-ascii?Q?VXo2U6ZMmSFqK07brPyA9Z7a+fs0pUjefb22x66Uems2kkMUgktukOPdHg27?=
 =?us-ascii?Q?3P6IAw+bGdsN8jNYEGvI9RrWacOPtZ2MyCNhWr9h62zvNXwmra6bA98cInUR?=
 =?us-ascii?Q?tqzu5+LDVypYBM17iFbpgbT8jFAs0fy7pXmS3zbWZlvBuCiHfM3PhTj8pHWW?=
 =?us-ascii?Q?J2ySzizHwf/Y+7VTy3zfRoKft4VQ54z7v+mS6uLmNKIgOAkTfywGwKiu/izP?=
 =?us-ascii?Q?rmTg48FSZOnhNwg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LsPqmxxg3TMXwt+uHhe3N1rvyufDHDq46f6G8R8n2EqytlosoITwXQc6c7/H?=
 =?us-ascii?Q?s93u36B8ovo0iRaK9WEudQt1HO8JJ3WhZaPAywIW3/JADNbKHaqvc6sqa5O+?=
 =?us-ascii?Q?1wyZwFVR2Zh2z5t6+Y7PimaYUbj+gWzOWDxphjLXuUtYmDEf1eih6VJ96AbV?=
 =?us-ascii?Q?kHTHSCQbYw0AHNqDu3S6qIr+07dAiPoHWRFJ3W4BMqksrIQyEm2iPqCPn6Pj?=
 =?us-ascii?Q?jli5B4RiAG/8jCK8SmwDBGDmPMn2+SPRIB5Dr3Y1o2nSyaSonF3anwPhlxJN?=
 =?us-ascii?Q?o9VBNHXZG+2x6lPzsQRRildcvT89nVr6tLajk06cWFSyMeSZoz/pVvxNzn17?=
 =?us-ascii?Q?q2j7aNMwq9VtJyrxIM1C4h1lmFJ3Wo80ifMEaHN8tvjSqOre0r0KoqbjedRi?=
 =?us-ascii?Q?zLuxrbgbaBBbdGkNmY3QqI3ywtrfFHV5pyJdecYh23fQAsLaz3FtVhNCge0t?=
 =?us-ascii?Q?YK/xKXbWztmw21rzbmKxOhm8KxmAh7wkBRr9mm1359lIYS4NZRj1Kzqgy3PF?=
 =?us-ascii?Q?6kJQwxZ4GRSnmvNY3/jnQw8KsD5UWG78wFmbCc1xYgKPBY8n0opSWyTTdLST?=
 =?us-ascii?Q?v5PyXiy2zEpM1iqzaZQ0IT2P/MhXR+s8/b6hXreAaDqnlsL8U1mc1TDRyjA1?=
 =?us-ascii?Q?Tu1MLSQ1BcEfiFDfDo2ZOxVyQDjX9laIwWUYAKdX+goylj/TQC39m10NHmLI?=
 =?us-ascii?Q?chQuhkZeko/1FSenpR3GJHU7eTViHV42ffmSJx8QuXnHE4nC1t34bgIbZvfn?=
 =?us-ascii?Q?sA31cnWVEZUY12/GadQR3IXLVKINUO91s6wFsrx4V4T1E2jAghu0jvoo+gZD?=
 =?us-ascii?Q?7+pBHud/yggR7q1sULe9cLNhTs24j6J0XUKntLd1efDGCrg2oj/iNMa5+h71?=
 =?us-ascii?Q?sqU2KheioN0e/6IULGRbn9R9YhaKR6QJgTOqVE7AKsWoO3817+BeUUbG0xag?=
 =?us-ascii?Q?ZaxAiIWQ6T3FX/O8R+CSLNQcvHWC6F/Ll6k6r0A9iJkdpT06svUcaZ8RuavH?=
 =?us-ascii?Q?pVMQ9rUIHfDv35ctH4RQTWAMb2lPDoaUO6QRguOc016LIXtbL7nuo0l52ODk?=
 =?us-ascii?Q?H7n2/0r5NRxY46VgJRx4FUPb8yKogMEkWNL+uJ32J34IXFB/+blStSIPqKT8?=
 =?us-ascii?Q?M/9APbtTVMcT0Cq/3o0o21TJDxQu5wxfd6OdbGc1MwWwfci2UTSilibx4npy?=
 =?us-ascii?Q?5m/O1UY5TloL+N11MktXmOTxKrEpjKsiCdo7u9tSdgNdF+CepLSpezp9mdJo?=
 =?us-ascii?Q?TrjaAFS5G6RZ2mPkqd8CLyJspz192DlaHRcyoOC8pIZfJ3eX4yPx85sR7edX?=
 =?us-ascii?Q?UKoYVnLzQ5UkCD6CSTgdkUkN+OVA5bryYWfihJuxlQrXzXXS2jUq/bQF1oG5?=
 =?us-ascii?Q?gaHSMMonfKWnbHoPNZlUmn/M7FkUrup7xzbDmBWWDZHl110Vv2IecW8NKwZ3?=
 =?us-ascii?Q?MwVmeaETSRkCMzFSMW8zvWg1XrxFsQYt201JZp/qRdwt2civAOfZmDyFJDuS?=
 =?us-ascii?Q?ukBPZ7anvU0AQsa8CI7a0B0966NLLCOF+9B9ner8dxLeKEuorvoRDV8PfgZH?=
 =?us-ascii?Q?lkXuqRnOUlZ7IVhMWlT40OOcosn1xLeVlW45HCJY?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e411f8e-aa9d-4fbe-025e-08ddae11eb86
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 02:43:34.8652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eIC50+B5xZ59Nkpom+9nT/Ug388ZFYaqNHajYK49HJNlfmKmw0vitM0qvvBhe+FMWSPe3RB4Alf2xCWpklwPhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10960

Skip PME_Turn_Off message if there is no endpoint connected.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 2d58a3eb94a1..228484e3ea4a 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -1035,12 +1035,15 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
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


