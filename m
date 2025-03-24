Return-Path: <linux-pci+bounces-24482-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FBA0A6D453
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 07:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95E773A2795
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 06:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0181990AF;
	Mon, 24 Mar 2025 06:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YbTbptGR"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2071.outbound.protection.outlook.com [40.107.22.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E520319C54C;
	Mon, 24 Mar 2025 06:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742797918; cv=fail; b=hd/vMaTUU83ccq5QaLaaFR2VYes4F4MqAuU84Xv3sQBPbSqcy2wjBXN1SHjGSuTdoTGePX12C1eNMkOjo69b0AbV83BWpPjWgkvzDS6RzY+C2kiE8Sv7Cf1QQ/qjfayIyAPtCVuQ/FjUd7Yao/4eacIioLBezW3zJUNMbCZ7wnc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742797918; c=relaxed/simple;
	bh=wfIkJtcm1UxOjeEq4b5fBIHid+eY7iobCM/MTBe3dsU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CPdBwZ8KsPQOOD/dCFxoaSFY3AfXd7mVD9IfbWoHJm9JsmSM1JjnQ5HaKx37haXdOIgLRoTj14bfr4Vz3ss10ElIG6aTpd0z28ZL66UKYiG842+p1Fm5jgL8FDZ3zIP63OWfnh42uKfVE8eyfAUrUjtWxdqso72y53/fOrKYgS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YbTbptGR; arc=fail smtp.client-ip=40.107.22.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yU9E/ONiSKJSwb0fkeJr91AfFhQ2saIS+HBqzDT47zrIfr2xSZdnNy3ngLnAYUnvaIz4XVc+1BEzSh59TH3KN51P4Cr7GOLioxVV1YvvuQKl21zx9jD2uWjkiYqgpbWQId982BedrVC4KZz7wqXqqwPEvZVeoK1Ncq9ZKK7+BC5BYFOB+3+iwhkW44uJmbnuUe4mqr850W19vuzfvp2Nyu+jzMV752J1Ay11A+OVSumws20xbnYsUHyuaLKaNC3cXE4xxmR0yhtsTy3+Kb+sKD/Zke7RGx5dyNc+noPu9EuoXcL5Wlp8nm5X85jOxyfhw2iGNYlXFenG2K6d14PrkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ImVpy4Bf5XJdFMQwiC2OD56wfDTnA58cSEat86hpqao=;
 b=CKPKhhsZJ3NhN8nRNa8LmZwJaU9+3ZrWGNYtRUZITQO2HrSCpjnvECe6vHchTDnZBgGTHBIxvVCUA9VLfw4+X4riFXbJH0q2wXYTsRbKbiBeMFUUIBeKEfOLuTSi1z5TAwYjjhv63h+m/2PY9+QejvquYdPm1YG9vLcCX5hON1CKvdQALezi6bJs5XC7bd/CJzKDw33CHIAqxPgAmBpvWKzp0gse+f/fWhXNuaNav7iv1kCnk/1L1yJQ/kUs5J3Vi5YF1y6xwFvdvkkhvT2i98x+uDmPy73lyxd2Z5OXWQvKLmtQUJdkblOKqwXuUDHVkVDtz4LJUb0rU+y51rqR6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ImVpy4Bf5XJdFMQwiC2OD56wfDTnA58cSEat86hpqao=;
 b=YbTbptGRsLH7GkBU7lbgfN+VomoGwxbMcq99I/lxZ0uX8AxHNePEjlcnAwRBn6pZhD3WpHelqOAAGpq6M/i3Ont6IBG9a0K2f+M6jl+WUfSRnj3+mnzC5PoelCQpi1NnGb3OSoP+oh6WuEjCI+lh9Gqm0uougDigyvWSRI0kKKX6qMOyb8Hrtp/oTBIF5tAFOk+7t5zzInQ3Mlnc7V85+QfM8PcqaN7Bd12fC/cEd8X3bbSdk6hgqa58G4RhaDGTXDoYyMoYrSCPBiHLTrVUPvDlewqrWMIQxdfW1N43YS4J0nai54grQvLPYCeYkmqIqZCievXt9pdXR8zxTHsb3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by DBAPR04MB7366.eurprd04.prod.outlook.com (2603:10a6:10:1a0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 06:31:54 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%5]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 06:31:54 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: frank.li@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
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
Subject: [PATCH v1 4/5] PCI: imx6: Let i.MX95 PCIe compliance with 8GT/s Receiver Impedance ECN
Date: Mon, 24 Mar 2025 14:26:46 +0800
Message-Id: <20250324062647.1891896-5-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250324062647.1891896-1-hongxing.zhu@nxp.com>
References: <20250324062647.1891896-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::7) To AS8PR04MB8676.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|DBAPR04MB7366:EE_
X-MS-Office365-Filtering-Correlation-Id: f10e1f1a-4b70-4963-43a9-08dd6a9d91c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|366016|1800799024|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rIrXNHZXDHvxTMBrSSDldUnb6nKG5UTl8kgvnwbRPa1cdi772Hch64KBMTQB?=
 =?us-ascii?Q?ZG5O7JFq+JsF8MFU1yE4oE5Pc1OtM3qnoS0l7IAjCbIFFSoOfXPmtWZ6Ld8d?=
 =?us-ascii?Q?oKFWxxwkg6Svnpi0V9knTWIJfzXDy+tmFKRutjF2QrkRW6hv4tX4uiQZlUp8?=
 =?us-ascii?Q?u+Uq8g0WjCE0zUMOiWzEyyP/ZfMRkt0NwIO90QM8JsKq5dqrjEu47L9LcN7o?=
 =?us-ascii?Q?HdAyCKO/PlnBLVUaqIDXOW7Fh1BHzLp0z4zwA27L7txEP5jST6sOgLALvJD2?=
 =?us-ascii?Q?CoYrhQO1GONIBhOpVmUjokzsFbqvXc8NDvhJuXaSv5t5I3uH34smF+WXwl5k?=
 =?us-ascii?Q?NfOUhXefCUFGTmi22THb7ST7fiR5BceqhvyN6cDNZZoGG/kMY9ZYyE7WvgMu?=
 =?us-ascii?Q?ZS187E9agV9unwOpvu2dwHx3HyRrm/dGEDT9B2mJkgFr0NTrIqo4rbY+oHY4?=
 =?us-ascii?Q?BWFUj9Q2uZHXtY1bhsBak1X22mtKIksIbQ7rB6TGntCRMbbAbz9LOdlrR7gV?=
 =?us-ascii?Q?B2a1Vy8l8Nk0a5Csf1NBkkkinhlvwGFYLoVUSgxNIrWYNQKLhGC3ofyS+JA4?=
 =?us-ascii?Q?xRfI9t9A9PYadLZYoXO7/2hWouZIyL85g6kjZIdo7sL9jcPKqp0ZFYXm/wjy?=
 =?us-ascii?Q?by7YvHkL5jBt6U+iiLTnN2OKuX3xfMNHzsepILoTg3JG/rh9DFGhodjQRSFV?=
 =?us-ascii?Q?MG1wzqH2aBT82DXzDi8Jgilw96kaIztK4z6I00cY4B51ohCT4cE0uG3bNw7k?=
 =?us-ascii?Q?DrtiQS9BbJbnJcwNg2wBbgO1jWQ1oFYLa487ZaCZEXqb+m5G6YNNqy0ruKTb?=
 =?us-ascii?Q?3bLsWQDj3tZFFSMJUnYHhn0QQtk1J4QJBgHXN2lxHrNENla2UNUU6V9BSI4P?=
 =?us-ascii?Q?Shbf0YSJBKNjlUYbWeuWR1Os2appe7Mxw94BwMnuVcmce4oxfsZsNzZCMhT1?=
 =?us-ascii?Q?cvEVYKlwr3/j+HSc56+9Ui8w7wTMZL1O4PI4HKN1edC+jlC18QyRWBQMoODt?=
 =?us-ascii?Q?VVq+eSXmcdLH+LnVzwk+nXAY6fl+GseBjX6EGvmtLlhIK21BBKRfwYEacv2I?=
 =?us-ascii?Q?R2Kfk0ckO7cPwPzbGfJ+d2fszon7twB5bphqjSXZWiq5hYskDlADq5nEDkis?=
 =?us-ascii?Q?7PeiLeKlsDX1AGdw+5+cPRK4pASaBk/RsBj3MLpwUio4Pf0XtxfsTBF7A80V?=
 =?us-ascii?Q?7hoMeTEva+yY1WP+N3hr9ntXvNpoEZ0YHGloTrusWUYpNA6g4LgyZe2tu1O+?=
 =?us-ascii?Q?dTJqYiUbldhQb5i/5lvd4PFNpfEloPjqv+jF+XR/y+Lsfp/mtqHJZ1p8pQKZ?=
 =?us-ascii?Q?f0Fatr3tlHEzEAODovyaY/6NvpPXoWSGurdzocPUXpkx4dMGEGMN06PmiAW+?=
 =?us-ascii?Q?Co2sro5wT4c1i95udzkaYNNbgCMbeWhmRTB4eyz/9dmu7dqOcRul/5G93wOF?=
 =?us-ascii?Q?oVkHSPt04qrWOYSb598PtCM6+z8cT8iBppYgWRhkT5Tlc5IDpufdlg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(366016)(1800799024)(376014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GAqtPxxtfqr9Rve7HDgnPqUbIQ70037G4gpO00vAAkRgag2qWoi/wzLJVzTK?=
 =?us-ascii?Q?rb3+kapaFelF4MUbv3Wm7ssurVNcR+LqWs60mtzlcGnBZkbAWURSun0y8ufV?=
 =?us-ascii?Q?0A75fHq+Jt4MLHu3g/1NuyANAX+vw1KWlPeebM1+X6YLfTq9Pu8uF46sm20o?=
 =?us-ascii?Q?f6nNHAXkx3kIhuQQSrIhjpFGi4wzIUGaQlKVU54vlI+gXpUpja2Ug44XiuZz?=
 =?us-ascii?Q?deC1J5w2RMBstRQld+uts2eSKx/kyk4gAPk/Za/+X7r2mbDG95neWbDszBRy?=
 =?us-ascii?Q?Y88E8y0YtD3pSGliI4vY/1ScwWZZ/GVYosFAx0+4jJdonxJBZB2t9MDX4/z8?=
 =?us-ascii?Q?vKo3LMWw+FaZRRUhR3UwIRalLTNgWLOi/ldozB3VOcokVbH4SZFzuCCZwPad?=
 =?us-ascii?Q?5/DMuaJknYtZidbs4hVVTZNmfHeFYG299ozLyK63ZDOBrK1HcqnAFsVHKWBZ?=
 =?us-ascii?Q?m9TOAmZFeBlehPWWeBCekJgxq05b/5C526Djw2y151ImPzu7CDwXr1YHaKXB?=
 =?us-ascii?Q?wTv6NtrQCSqBTihdYeM1BcrtY5NsJF9QH6gcxxVIXObfVp8MZuTSWHKJR7T0?=
 =?us-ascii?Q?6V00K/zSi/V1zfZhn2KL/QR9besMR2q/LV+JdWC26qZNaSVCYsuVNV6/d0Hk?=
 =?us-ascii?Q?7shhV+Mzk7sJ7/47N9FCow+t0VIEIsIiGQyPYVxhOpnPzHsjor4Ahp1NKfSM?=
 =?us-ascii?Q?B4Pk3ZwWlH0fpIhBPvdUqmeYL2nYcXRDfJAhRcs09HZRjEtr/Wu1hkfPUwK/?=
 =?us-ascii?Q?P2GNxRAmLtuISpSThDTyQU23QEf1U9KczwOlyG9qszWHTcSiore6ny0ah5+q?=
 =?us-ascii?Q?p5TDK/V6zd6gVSwXeBG5VS7tyIuIX2VWk2Ul+9DkqXRaeSf+Bol1mm4cdGao?=
 =?us-ascii?Q?Lf79FsZHmHdEHCutHuvQ23nqjGIYWY4vAH3o+aUasu4mNpAQo6vLrsELfDyL?=
 =?us-ascii?Q?SHwWbdt+rB4OFpHVemaTnUfd714Jj+z2OnGq8j+hXGgWeD+8wreNWEcy6GD1?=
 =?us-ascii?Q?0kdjo4OeGqTRKdkyzYtNkBoyJI9TXKZIhtJ3+0YyRmNh8q4I4hhPML+D1gRI?=
 =?us-ascii?Q?5UUstzXyIxHeg6tQALccA05NPcMWn2ek068QHKh+O76RWlwTFcgAUyuaFHt3?=
 =?us-ascii?Q?zR0sGEkVjamW7AXHMzZp1UCauvWlgCFVHNNlqhZuoGjZZHWvn49292GCBqPq?=
 =?us-ascii?Q?J4rw92/ms+SJ9vS5W6r/8RG25gXxhUj/2jnmpnertS38/G9SdSmzIJn4RHcE?=
 =?us-ascii?Q?V7mJrEm+nm4szNmkDJcP0oeax8lAV/WjwTLmO4mHSeBeADw3v97pAObEFgWv?=
 =?us-ascii?Q?ksUQq14ffaTPEy8v8Rpo1stZD07bpeZBomkIFFV0auapavHUtzlvkXA4EpLP?=
 =?us-ascii?Q?vCZE9//GmK/HA2Aci+SNePOLoBYYkfx7oPc1x+ewQv+E3UG/9lCWTwmIaMrx?=
 =?us-ascii?Q?TyzWQIz3kJjBGeIj6WngS9eaumjvZA81fH3HZpGVaxOJD+EOAYQy4XOZssz1?=
 =?us-ascii?Q?OEjAi56rk9rYcBzkoN/cDFWIupWP89dPVvKC7xfk3p+op/IZRqeX8d1AGwtG?=
 =?us-ascii?Q?OfDO29+Izn/q5aYy4u2j4Xq1NbxYx4r6F+1pc/Wr?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f10e1f1a-4b70-4963-43a9-08dd6a9d91c3
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 06:31:54.6372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wQnzhOJXWDfKHhIfedutQtdRvAEwBfS4voGjQO5MDHcdObjI+SjTFtRDsmSkAbd0djaebiqOzTqM4NtmWgVnUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7366

Workaround for ERR051586: Compliance with 8GT/s Receiver Impedance ECN.

The default value of GEN3_RELATED_OFF[GEN3_ZRXDC_NONCOMPL] is 1 which
makes receiver non-compliant with the ZRX-DC parameter for 2.5 GT/s when
operating at 8 GT/s or higher. It causes unnecessary timeout in L1.

Workaround: Program GEN3_RELATED_OFF[GEN3_ZRXDC_NONCOMPL] to 0.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 29 +++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 52aa8bd66cde..dda3eed99bb8 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -131,6 +131,7 @@ struct imx_pcie_drvdata {
 	int (*init_phy)(struct imx_pcie *pcie);
 	int (*enable_ref_clk)(struct imx_pcie *pcie, bool enable);
 	int (*core_reset)(struct imx_pcie *pcie, bool assert);
+	void (*post_config)(struct imx_pcie *pcie);
 	const struct dw_pcie_host_ops *ops;
 };
 
@@ -1158,6 +1159,29 @@ static void imx_pcie_disable_device(struct pci_host_bridge *bridge,
 	imx_pcie_remove_lut(imx_pcie, pci_dev_id(pdev));
 }
 
+static void imx95_pcie_post_config(struct imx_pcie *imx_pcie)
+{
+	u32 val;
+	struct dw_pcie *pci = imx_pcie->pci;
+
+	/*
+	 * Workaround for ERR051586: Compliance with 8GT/s Receiver
+	 * Impedance ECN
+	 *
+	 * The default value of GEN3_RELATED_OFF[GEN3_ZRXDC_NONCOMPL] is
+	 * 1 which makes receiver non-compliant with the ZRX-DC
+	 * parameter for 2.5 GT/s when operating at 8 GT/s or higher. It
+	 * causes unnecessary timeout in L1.
+	 *
+	 * Workaround: Program GEN3_RELATED_OFF[GEN3_ZRXDC_NONCOMPL] to 0.
+	 */
+	dw_pcie_dbi_ro_wr_en(pci);
+	val = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
+	val &= ~GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL;
+	dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, val);
+	dw_pcie_dbi_ro_wr_dis(pci);
+}
+
 static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -1222,6 +1246,9 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 
 	imx_setup_phy_mpll(imx_pcie);
 
+	if (imx_pcie->drvdata->post_config)
+		imx_pcie->drvdata->post_config(imx_pcie);
+
 	return 0;
 
 err_phy_off:
@@ -1808,6 +1835,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_mask[0] = IMX95_PCIE_DEVICE_TYPE,
 		.core_reset = imx95_pcie_core_reset,
 		.init_phy = imx95_pcie_init_phy,
+		.post_config = imx95_pcie_post_config,
 	},
 	[IMX8MQ_EP] = {
 		.variant = IMX8MQ_EP,
@@ -1863,6 +1891,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.core_reset = imx95_pcie_core_reset,
 		.epc_features = &imx95_pcie_epc_features,
 		.mode = DW_PCIE_EP_TYPE,
+		.post_config = imx95_pcie_post_config,
 	},
 };
 
-- 
2.37.1


