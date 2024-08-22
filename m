Return-Path: <linux-pci+bounces-11996-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CCD95B2B1
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 12:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8800A1C21978
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 10:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6989117F4EC;
	Thu, 22 Aug 2024 10:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="aKbiAiev"
X-Original-To: linux-pci@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2054.outbound.protection.outlook.com [40.107.255.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF8A18309C;
	Thu, 22 Aug 2024 10:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724321716; cv=fail; b=KrykU18mDg4zZA4I7fr/l/OjWx2+u4B94k7h5AvKTOqSKDtz9azfXQkLdFHbI+CrUtyfoGFGT7uX9Y/Mil2S928hRrhLAdJtTnb0aeMc8Zf3CRz8Ed5bipQ2iFcicuJ0Wb0rUOZJfvCPDR6QhMDkXfffh5uqEqfemcqPNWGz8nw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724321716; c=relaxed/simple;
	bh=0l1kjpl1M2wJpCMDOCtWpkXwGQtdjtbUK14Kim8TSQE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=qoqk8W+kVTtA0PJTEWKJSp2S7xiJWf197nTi9FbepesaivXYunvYvYa49n3igYKs6JRAjAbZxol45zlu+8S8ZhXbeb2vn9B1gcMv/pDEUAq+qCDTI4PMnPh1mgd4L0K01G0BSY71qcef9DiGZwQhbg5aoHQkkBq+jyANi7iJ0Cg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=aKbiAiev; arc=fail smtp.client-ip=40.107.255.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H9x6U46ckfjWO2wd55vcLY8z/P64Sjo+yE1YUxXK0LtZCFzqTQodblrKVM/arroQSHlWtsE6z1QVp01kv3kJulW9jTVPFECFhYIJUtySKqxULEpWPwzsGHv6Pbmsah1PFahdGRzzAMVqZm+WBVXRt1bJphueBAe8LDLfUavCWl4O3In4qxjLx1OwoNwK2vbbb0oTVV3jUNcgAjnbAv+6TYoPZnvJR1FYCFCaR4MnPtVeCWJb60x3gCUSwU3XcLEYXLon60PpQQBDTbOHIX7X0KadZL81nuXgIXZu7n7jXRQJyLmyG5sCtdaU8gAGRSrLmV18yuFklMDgqlEj5GI2yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ru6pjjNs2mdiEJd/HSztW+qRuRGhQRs1IoJxnKMXu6Q=;
 b=A/KaOgKn47mFuE9VJ/PG3FSvNuSV5GMOJz4eqou/OOBUy9oFk4MobWs4kV0sWjUXXsUnRhbXGksEUf8sdPZgkD8REEsXDx+ClYBiGLGBJvV0w8jkzn0Mp6oLusan4xKn+3NIUT7b0jYhUNOCfvc4z6tShUWgpG+GEYhDs4vtNhi0zivY+i0CtAW/maGA924W1ABll4X8lW3HO5aAuBoB2nLi5RnW2Hf9719PU1lZhJmLmPW0Sao6MYj8xTNGJqvx+nkiLUVSDT6LhrPHmrMn2ZhER2n5o3SJWhvoHCjZSc8qhP0QFM7MC7YR+VfvI/GiXP5q4/EYSefadZPMqpQ6cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ru6pjjNs2mdiEJd/HSztW+qRuRGhQRs1IoJxnKMXu6Q=;
 b=aKbiAievOdbLRzrFg5li966kI84exL0hxPKkHChJSQNnWUeDg1CBw2qGcxPRMQJAw+W7Ka4koEMlthqCPv/stTNYo0Z0xEfYxiqvLC1uFa1QqutakvjvUc/MvljRnTTKR39xgZtixKhGx3nNH5O84Tt0Vlc9ZJ2/9a+R/+mYIWtuX6gJFPVRpjCk4KInI8y/TbUPVB5PgROAo1AfsL3n+k1hP/owqjqjvOQ1sIkbSdJYi0WNUQtbeSosD557lho7AUWbPNNfJQoTk/mJafTBOJznbL096s2v6dQOsLLwkqaY8gcp50gnmgiFPkaOJUvUqJsNf98FJQBco5WIGhkQpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PSAPR06MB4486.apcprd06.prod.outlook.com (2603:1096:301:89::11)
 by SI6PR06MB7217.apcprd06.prod.outlook.com (2603:1096:4:24f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Thu, 22 Aug
 2024 10:15:11 +0000
Received: from PSAPR06MB4486.apcprd06.prod.outlook.com
 ([fe80::43cb:1332:afef:81e5]) by PSAPR06MB4486.apcprd06.prod.outlook.com
 ([fe80::43cb:1332:afef:81e5%6]) with mapi id 15.20.7875.019; Thu, 22 Aug 2024
 10:15:11 +0000
From: Wu Bo <bo.wu@vivo.com>
To: linux-kernel@vger.kernel.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Wu Bo <wubo.oduw@gmail.com>,
	Wu Bo <bo.wu@vivo.com>
Subject: [PATCH] PCI: armada8k: change to use devm_clk_get_enabled() helpers
Date: Thu, 22 Aug 2024 04:29:52 -0600
Message-Id: <20240822102952.1656027-1-bo.wu@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0211.apcprd04.prod.outlook.com
 (2603:1096:4:187::19) To PSAPR06MB4486.apcprd06.prod.outlook.com
 (2603:1096:301:89::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAPR06MB4486:EE_|SI6PR06MB7217:EE_
X-MS-Office365-Filtering-Correlation-Id: a1058aca-f011-420b-1944-08dcc2934e4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WfksQO1iyMQOzYfkGuqmVMccFTN46uXPFj4KysmRBZbwxaP15sBQWbUItmYQ?=
 =?us-ascii?Q?DcURJn6wsPzKvGyx/zfEZEKkPLCCbKIxxh2FbvoO9Su05gt7wruJVeFLhXU7?=
 =?us-ascii?Q?DkSryZnw+aB1CQyEtWVLQxyLNfkuiLPBAuVgcuveKT/SStpj+ueTPmNSAq83?=
 =?us-ascii?Q?2hMmyFuiuX6cWcCqz9GwC3aUQfgUg2RcBVv2c8KFSpn93vyM34my1E+vAcRf?=
 =?us-ascii?Q?lslQc0BhoIV3H38jxBBexqVyWtOIFQnQjD5RzsRqaiTUwtlSiPafYMSQ2E9X?=
 =?us-ascii?Q?xWJqh0Lj6XLdc0Co9y4l9Jbv3Zy5oY4P4/2VvI13PQTRnre2x+x6I2fLwwnj?=
 =?us-ascii?Q?SDaTZkUIIwv+ozAddOAWq6rL6qgg2oAtrlVs1aqOOpQwy3Q/E321tEFAVtgO?=
 =?us-ascii?Q?waDG5OkzYaz9dODveekTvwVyL5U07HchpUf23U9sDlwVgiKvqTj6tqHmTQL1?=
 =?us-ascii?Q?35z+87inJ7jSAxa/Hx3amKH80HEq/eW1C5p57DvHHknsBjCDigbCEk1GYY8W?=
 =?us-ascii?Q?N8u/Y/s4bnI7DKiRVNs7LwOzQwXqzbPx9gtrcXWkf0dHl1h3jDCkvShD1qsa?=
 =?us-ascii?Q?RWGECFoY/CXnNQDO5TkUDcp0nmJBaNvqcEnhzNQZBkV+qlBLAiE3lXStHoSW?=
 =?us-ascii?Q?MO2400gsywkI4tSYYFCOds+pj2qODxpUtnHTaSJAKe4zDDneM6SijPVIa1yc?=
 =?us-ascii?Q?ho0ziYrdGLpR9hIZjHzpjj5Zdy52oEi7by56hUpAtG4JVHcMorLaVl/+rSP2?=
 =?us-ascii?Q?V/vLXiPane+cQSoXj9DI4PQCvnxADhPG9Vi0nFp/Cdo3ZyhWS/hnfUy6iMdB?=
 =?us-ascii?Q?S31ALQIs1bm58EbECJ4zov9bCGhFXs0rXjXSwOS9iFSWs/U7FHbkgHm+TAml?=
 =?us-ascii?Q?KJSPNahQgCFePDoW8LSEYWj2OyIun0c7kE8kbWhwMREfTEKrxqKo+y7cuKjj?=
 =?us-ascii?Q?V0nCSNkmGOYfa7LKSAOd7ERRftUOyHm9xNJcH1joqZHlA5galJ+eFtixys9C?=
 =?us-ascii?Q?nst7y6ydDOeBEPqWejM1N3e4U1sjKQSaBddYPAo7tBI+v4h5nviMmGCiGwT7?=
 =?us-ascii?Q?KQLBK3rTHMf9EKyVOcnGGSfgSAJkDWOttmpn7xgXdvCwhMUPIxiB1h8y8jdV?=
 =?us-ascii?Q?q6UahA3NpAZH/NozzjI6B+vn400O++uwGZ5jP7HS9lMawpj69SjCZQ8rEfuc?=
 =?us-ascii?Q?fNE8WN9uY+5mnEF/o1cAUprdelD/dRJx0DQXTzqk5HDB1VagFY1HgpOl7/xG?=
 =?us-ascii?Q?4FhLW09KH039ReAvx+cSGZTHXvHmNZHO9tFD1NwyiP539PSV613NsglJpazl?=
 =?us-ascii?Q?iU+GYVOWi+DI+tx4qepK/f7Y9Hv3p12pb5NODx0fbebzzaASznUPPhonc8aS?=
 =?us-ascii?Q?2UB27wmwwOPekY6MHcnt3GZCUBYbUfucs4tezBIFYi7dIDWqGQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB4486.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5pxT23QGvf4ysT5gEVQ0C0GI2qt4XuDiDqPTVJ4xllJdydTmEQHTJHfqDBps?=
 =?us-ascii?Q?mhWfDg9926dgHTx1ZPNPHs137c/+viKt79pzOfZTknpNZISmrcVRZi7Ixx2v?=
 =?us-ascii?Q?9+M5NVnkCp5ofAW78Du1IhVHhaOFxfdZCVXLel9lm9UjwdQIVxv6ewYy3Dl6?=
 =?us-ascii?Q?kYaDXHDsxtvpjtY3jQjrmQNno7au2GnNPdPPDSWOJ7cL/YlJV9aGDFl6fMPW?=
 =?us-ascii?Q?by/tm5y5Cqhez114gcLrmiKDhmx22td6bPsWU0We89n6/OQPqnXt7ANz7myy?=
 =?us-ascii?Q?mA9z0xXDGXT/EZyYGA+i7AZ1y+nEODIJWo5MaaY4HsP5lOAjHxHaKMa9b7kx?=
 =?us-ascii?Q?omjXTfi9RVoc98XDdp//xSypnEdbBhDrBi+u+RCPI86K86rxhWMvzthaIVEb?=
 =?us-ascii?Q?BoeQ+Y+CpuKYnxVHXNovND8gRzb96ya1dbxrtUSwPh5jKavPqz1C2+6GvvD8?=
 =?us-ascii?Q?Hna2/BKk1YxrtsFppyQx0o8u9EPF6KFySP6+XDT6oKO3vz2SV+9XapLIkL6O?=
 =?us-ascii?Q?G+EvtN8cLZMrovR4OoHd13qvtNbL/dmuwePXpBt4qfdeMn+QpjVz1s0fhaxI?=
 =?us-ascii?Q?dZGpGam1rT/3zsgDQmHwqwLHbU8nLPQQL3UQtEbqhCqYaywCB6km8W6HVtp1?=
 =?us-ascii?Q?8m8H08dbPpvveYx+Lhz8dksG35nRI/orZWOvhOoPoNyydSnUh2rzSHKViJIP?=
 =?us-ascii?Q?N6gm3/c4814lmxT6NcfO0fSfiWHx+fN/+Eh5wllynjn466vR64rL57uMh12G?=
 =?us-ascii?Q?MhUfb5GLdl2BXVTNZOgXJ5CN3yJGYh7fXbYq6EnNiQQynnQDQKSne5NWIh8k?=
 =?us-ascii?Q?xm5pput0ymRXeAOs81OpPj70EfTycdDmftMDtE74Sk4uXrQ8HC9SafM5qoDS?=
 =?us-ascii?Q?W+T8PucOkr3LU6l3NJHCFtlDoRPnhs66VHviqDO+5xmYkJRptYAwJScYmvaq?=
 =?us-ascii?Q?e0e8HUEfTILYi1uLyqvolcbHFDmolXC61OB7+HejIQRxIzreAhIRyZr1C9HX?=
 =?us-ascii?Q?P4Ib0vj7YRnmY54zkzznKoAtswayMGWXXh454ghKFfI5CfNTBQqok7MVSKZq?=
 =?us-ascii?Q?5LWVFF8GfEcAAE7yfi1Cl7R0iknoK3YsH9Q73Rn91laUOmzvdN19ZjWCnxZk?=
 =?us-ascii?Q?1SSjOW+xs9X+a7d/4EiGER3Ef2qTTisg85c8igTJhP3LLsEpRpod/aXKyRMq?=
 =?us-ascii?Q?6wDyvhHQxGjlK+9Cv+qiKlcI9oZyBhKPwd80Lkaz17O0QzKNkzNrgjs+l7B1?=
 =?us-ascii?Q?sVL7CPOst0eAZoxvFDT6zf6JFoHKmvNu3cMpJd/QbrRbjea0/pWtyfroI9+S?=
 =?us-ascii?Q?dtspVozriL6/FNAN4SrAaOZ8cQW+GoB9PqXXTMQqWbVuhSF060eBySMsJrUp?=
 =?us-ascii?Q?d8RkTnvWXVIcyYsLBn60dlbiFi7PdAHLuQUwMAAArgCuvzEElqHQ0m4aJ+v8?=
 =?us-ascii?Q?pur2OGNt/asBRYmcoBAlOLzn5CWfj3jrN0Y3PA0ekwSCwmHyelunKN95wtM+?=
 =?us-ascii?Q?DJQdGbcxiL+onHTcclXhh7rdo3FEjXzOaQXxcRURYG4Rce0xLO2KwsNKVHbl?=
 =?us-ascii?Q?vXJqw2U3ZajKQ9IvlYKe+U4HFlUYpDKZyie9BEom?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1058aca-f011-420b-1944-08dcc2934e4b
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB4486.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 10:15:11.1035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x5AwaxTdZFOkjeBKOkgwdfIvu+xwrtlE3q9GFUkkSunRWRyC8AOcQ5uyihcHs1/HB9TtNFiQIUn/OdKSij1YEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR06MB7217

Make the code cleaner and avoid call clk_disable_unprepare()

Signed-off-by: Wu Bo <bo.wu@vivo.com>
---
 drivers/pci/controller/dwc/pcie-armada8k.c | 29 ++++++----------------
 1 file changed, 7 insertions(+), 22 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-armada8k.c b/drivers/pci/controller/dwc/pcie-armada8k.c
index b5c599ccaacf..48009098fa6b 100644
--- a/drivers/pci/controller/dwc/pcie-armada8k.c
+++ b/drivers/pci/controller/dwc/pcie-armada8k.c
@@ -284,36 +284,25 @@ static int armada8k_pcie_probe(struct platform_device *pdev)
 
 	pcie->pci = pci;
 
-	pcie->clk = devm_clk_get(dev, NULL);
+	pcie->clk = devm_clk_get_enabled(dev, NULL);
 	if (IS_ERR(pcie->clk))
 		return PTR_ERR(pcie->clk);
 
-	ret = clk_prepare_enable(pcie->clk);
-	if (ret)
-		return ret;
-
-	pcie->clk_reg = devm_clk_get(dev, "reg");
-	if (pcie->clk_reg == ERR_PTR(-EPROBE_DEFER)) {
-		ret = -EPROBE_DEFER;
-		goto fail;
-	}
-	if (!IS_ERR(pcie->clk_reg)) {
-		ret = clk_prepare_enable(pcie->clk_reg);
-		if (ret)
-			goto fail_clkreg;
-	}
+	pcie->clk_reg = devm_clk_get_enabled(dev, "reg");
+	if (pcie->clk_reg == ERR_PTR(-EPROBE_DEFER))
+		return -EPROBE_DEFER;
 
 	/* Get the dw-pcie unit configuration/control registers base. */
 	base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ctrl");
 	pci->dbi_base = devm_pci_remap_cfg_resource(dev, base);
 	if (IS_ERR(pci->dbi_base)) {
 		ret = PTR_ERR(pci->dbi_base);
-		goto fail_clkreg;
+		goto out;
 	}
 
 	ret = armada8k_pcie_setup_phys(pcie);
 	if (ret)
-		goto fail_clkreg;
+		goto out;
 
 	platform_set_drvdata(pdev, pcie);
 
@@ -325,11 +314,7 @@ static int armada8k_pcie_probe(struct platform_device *pdev)
 
 disable_phy:
 	armada8k_pcie_disable_phys(pcie);
-fail_clkreg:
-	clk_disable_unprepare(pcie->clk_reg);
-fail:
-	clk_disable_unprepare(pcie->clk);
-
+out:
 	return ret;
 }
 
-- 
2.25.1


