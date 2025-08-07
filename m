Return-Path: <linux-pci+bounces-33523-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5AE6B1D309
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 09:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 205171892F07
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 07:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D2021CA1C;
	Thu,  7 Aug 2025 07:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fkpGU6gq"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010067.outbound.protection.outlook.com [52.101.69.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2451723314B;
	Thu,  7 Aug 2025 07:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754550605; cv=fail; b=dxQAJ/TDsLbWpvsf9+eMVD+6wdNzAdLW6t0Rx48Fj5YbQDVbx4re5Wy96H6STo4g8J+YD35bAPQup8QqXra+3wc4m6X5PjNvmvMjsZTEbeqQ5ZuB/hQZyjYOdiD/Jj/XI+kFuu53y+Ct5PntJbYJizQ3+/pvTngXpTrMYZioVxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754550605; c=relaxed/simple;
	bh=wWAj1Hkde0KaWvpQlC6Jt7k3DfW/OXh0GW7I8FQKHmc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DSqQTGOv9nDxNf7d3MYmvqGOWPAkAF9wpi/gG6qFESSbGjHFlP06m5CXhslVKX39zHhUb+JqqgEJiUP/fzt7TkG4U4YHTUl7/TPwNCBoYFYHSNFW4IbKgiuv5x1GB99sTCdFc25oRrM6YaWeMEOyLvBLi9qhy1AIZBOFHNJF118=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fkpGU6gq; arc=fail smtp.client-ip=52.101.69.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x2dze6Ko32WtDXk8cnrGDGuCfsSdrTKYyvnWduCzZlFcCZES5d57Do+S9Lyo+q3fZga73PO+8784yjMBTyfyYHU74qj+3K8k1LeipRYYyOYjyi+wB/eDFz4IEFxvHP7wDZnCsh+fTqrS8bxI/Tr3WoY3vJVHOr0rCPYsdLx/pAZWKis44iamnZ0XaNryEqwgWBwZuOmsA0lXD5w3l9DgiOpTYR4GN4LVmedfGX4xJlfZLoEu7zUaBi/F92u7WrKycAtPq0ezCATsVN7M6A7pe7tKMQRMd/Y3zknS0tVGn6JCvifpAmupffTlgmgauOPZcec458q21KVArshdlYK5oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l8As4sEw3EX+RablbqbcK6WuX5UDe0w21F+HICKwf/Y=;
 b=hhl/753Eubx6ZC8c0KCu2S+dxxTFAlzQ5Ege381VQ2dK3LqkNJ+cdKKKjh40dNFpVnuybKXfLJ77Rdd/rExxR+cobupBZsg/adU+03sEvDUtMwZF8yw92krwZtUijdiICXrLvJCtYxvGZsjGGA1enfALgygB9keyZ6mSTjKXiDF2brBwefTipbQ8vxQhFc8BR089TOVq6vXruKSCV0JXJljnb/9bPb1EOt/g6E2svCydBZYBV0q/NuT2yhB0HNe7DeHObJ45XjNKAzlRxublmHmQVOxT6u/4ccpt6tOjVNQlijRegkMIFfzcGkx9C1nXhDLJVd94TKnAUzu7keSkwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l8As4sEw3EX+RablbqbcK6WuX5UDe0w21F+HICKwf/Y=;
 b=fkpGU6gqBw0fMLMf1gf7Qg3YJ/q06Z5EijsVXyfubLuj/NsCG9yOVz1D59peVXE4gVrNmtrlAPavZKl4nPXhdAsY45ZxfHm02CBBeyqJy/pdkFKw+V4eRFNQYKkY61f8bjVE3gBIhcO3T8Wu5qgpMY+E2gOKOJCgL5b1Xo1zm6simZHXXqW07jo4z43j43PUWGROuw2DV+OnZu8zKX1rsr1cX28no5T8BsLRY+TWM+jk4x+dVeViDFeoZXVfP06SdSicshe3/k5jXHfV3vmwG/79Tyj2Ly6ibOqOe+b6mNpFBg2+rjvM7tVj+7Wu+86VIml6ii21u4M/7GJDAa9ISg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by DU4PR04MB10814.eurprd04.prod.outlook.com (2603:10a6:10:58d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.16; Thu, 7 Aug
 2025 07:10:00 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%4]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 07:10:00 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: frank.li@nxp.com,
	Zhiqiang.Hou@nxp.com,
	bhelgaas@google.com,
	ilpo.jarvinen@linux.intel.com,
	Jonthan.Cameron@huawei.com,
	lukas@wunner.de,
	feng.tang@linux.alibaba.com,
	jingoohan1@gmail.com,
	mani@kernel.org,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	robh@kernel.org
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v1 2/2] PCI: dwc: Fetch dedicated AER/PME interrupters
Date: Thu,  7 Aug 2025 15:09:17 +0800
Message-Id: <20250807070917.2245463-3-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250807070917.2245463-1-hongxing.zhu@nxp.com>
References: <20250807070917.2245463-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0037.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::6)
 To AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|DU4PR04MB10814:EE_
X-MS-Office365-Filtering-Correlation-Id: 920e9cb3-16a5-4777-621e-08ddd5816c73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|19092799006|376014|52116014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8dUE/tZTr3oA7FL9KwiBIguhLHSg0eqmYupq0YnrzM0WSpelOy6JtpdSp43S?=
 =?us-ascii?Q?GqW7R8hsb2r7nmT1o7TKNanwWJ1wZtgwlQ8mZNbjzwTA38AonsLfY3dNaFiN?=
 =?us-ascii?Q?o0GjGvTIoQLdjKBjP3F9+QrciqOIeDBTb/2MHPxIt2vO1VpzWbdZ9vb/gcsX?=
 =?us-ascii?Q?tniI2SXsRjaKN6CKNU49nWt5oXyhLgOEbX50+f+BsLDK/FEBLqmtcrl/byh9?=
 =?us-ascii?Q?hAbilo0tWKQzvqVcmWrXTo4dTF2Z6lDlpgbGpLRe8hlDG260JyCP5aDlv2Jk?=
 =?us-ascii?Q?jDqzflM1bISqIPw/DrRLFjfD0cXt3VSDkSzs8N9oCSFn34DXArJg5iJ9H8if?=
 =?us-ascii?Q?rR/jLa7pNLoDHKXuCVwnaWZMEf2DDDBq+JHgc9uwZ9iOKBiO9jOy6T2KSuyX?=
 =?us-ascii?Q?NK0y72iAWHSJlv66CjkWQHOce3waEo7VfqCQPYQNv2lGSY2PKxR4Faf2v5MF?=
 =?us-ascii?Q?VAe15gUmi+MuuuMhBfnfbrG2BFCsk3VnaFh2xBghow0yCuaM7SLO3TKecSuH?=
 =?us-ascii?Q?sOBohhxE4b6EVgNyeToQcbUJT9WsG6UFY7ifOqEzYX7zm0MeXGGY1q4RcT/M?=
 =?us-ascii?Q?8gf2qfQnCYibThMmyWMkQhX/YbJe78bh60M73WRTztNV7aYCwiuGqiTgHJzE?=
 =?us-ascii?Q?rVcd9RamotDYOeuQdROffZ2AerRM04U1TRDgi9REUo8/3J+XfhMxolLXWY5M?=
 =?us-ascii?Q?mxLO7L+pInWUJ8Y+U/e9brE1cLsoOny+MGPbS3eEOK2qJYtTVpyLvUx0cs5n?=
 =?us-ascii?Q?5RpOoTMp+1RYSPxfMkPz6DgX3trDYYMAxbSvTsrGE3/H3uY9GnF4JovVCni9?=
 =?us-ascii?Q?wUtCctPPa9HRXCH/vpAKodO42BplgmvAvW5/SSKv3N6+k0WShYE19O7ftRHw?=
 =?us-ascii?Q?fR1JHRoyhiixZuXzVpYZqrFuwiPqUUvWBkyvk5mhF8JKorKHY+qYBBl2OY9I?=
 =?us-ascii?Q?S+eIAI4J60psEVhHYCBmZjBMkt0wjU5qRKhZL1NJtG0cTuelQh0aRR97gUTQ?=
 =?us-ascii?Q?d3qSsP3lNgph31npqgmxQgmJwwL85VD2L5K9Wxo/RwEOTIqoMyYzB3wX4RE9?=
 =?us-ascii?Q?ygdDNJlo8eMmQ5C+hRfMVzfXHBSd78Fhg5Kp7M+MOOlKsfDqyoj30cMlZmel?=
 =?us-ascii?Q?mEBay9aNZE8qOa4PGN6teIfiXHfg0M26eUeGhSqpfUxhg8g7Q6SY0E3DDZ3i?=
 =?us-ascii?Q?UZ7Yr7WleTa4DUNOnBJXkXIEvbmqVBVH0f+lHJOrne52xSyhDQLlcdubZkAo?=
 =?us-ascii?Q?7R+Xtk5g4y2bceT1JCxmpjHw/dLil2VqJfYMVZ7ascXjnadEOkmWQKFXYXR0?=
 =?us-ascii?Q?UnUXWeDsorRinIfl49kPq+cTsW7ZNhcEKcQeldlP2zc0WN1NffWj0VYKxSoz?=
 =?us-ascii?Q?eRo1oYzu7EnwXxuTa6NPFro799NpJwq+eW7cHoxU+kMCKxM42WGWMnZAshs6?=
 =?us-ascii?Q?LlAxw09VF4fsaKQ9HjGJukAptovFZkUHWlPkJwYaC2WMUJmd5eMFacbTen20?=
 =?us-ascii?Q?PvMSpQ1kBeSAZ+Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(19092799006)(376014)(52116014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2KfJf8Rz4BmUvFkfbwCBuzWM5LO+qZvQ8YW589I/7Vn+7Y7Xor0Hv8OPJA/p?=
 =?us-ascii?Q?qP9Vi8oi3AhOhzw8LOl1WSZcRk9QBn8XV/84nFuVQCkF8x1Gxmpnw6ta9nfb?=
 =?us-ascii?Q?6nrJlIBB16pPeGEeph+GbDHpJRpQhMPb5aO0n33/GXalUwF8Yw3gYy43brxB?=
 =?us-ascii?Q?+ypUzJQjVEqoOIQu7st57poHnUq/Sw5xiYJr1+RvQxj1xtD3UDYY+TImPSZt?=
 =?us-ascii?Q?jxkPdjMIKXS+gQS4CE/iWfUh6fX6/grhxNBOe27jcFLnAZC2sM3tgDlWKmcl?=
 =?us-ascii?Q?inLraKiM1Jkwtq9QGzvP5V1ENIu7SJaJ8c0b0ugmJnQc0il7TdhQQBt1lX5M?=
 =?us-ascii?Q?FU68L/NS1SoUmd9ZE334ayxooR4Jujio2UdwXPrJBxtEua6e0PN7jjwNkrIK?=
 =?us-ascii?Q?FN/BRUi3m08tir4atjr2HyRzG2lBzKo3FdKgpVtn/Atwc4IYtg5tBAuU2z2/?=
 =?us-ascii?Q?Lp+VpL3sN2Io06/ywVm5qjVuQQNiM8a9MaC2lz6p0vEWKu3v+5RFA1ATgPHr?=
 =?us-ascii?Q?eEBSw4f2xg0u1fJ+5X8V3MSA83dqr+owULK2nrKM/+O+P1du16pKnG6AQ2KF?=
 =?us-ascii?Q?QYpADjJbcmU6DyG0j0Dmkrc/8tCWO26c6/SGR9gnvsnUKeK/woSkzlgf739O?=
 =?us-ascii?Q?/tFx3T1s2nV/8Ix89B24VUemRHobEpym2YhdylIxNdMJA75Ut+z3ZkbVk5cO?=
 =?us-ascii?Q?8mNBIhcx3gEdVAnOBgJPpMTC22Z9LCYhlgFQQ4PeuPdhBe4jvT3IR/DCAueG?=
 =?us-ascii?Q?0jhLTwOkHIPzpMNlc0lTYWYahD0XkUEJX3kFNDr2NaDyn+ZmuTxlceZwlGvC?=
 =?us-ascii?Q?gRPbdotatiPxoq3QpZ11P2htsOROfx+/G6uE+jrvyc/meDfPxorHU4VlBD2Q?=
 =?us-ascii?Q?j3KPuaYWa719I27CxqQ01j/MO9NEXy8i/cgb02PZg096K7/5ISTCq3uK7uGQ?=
 =?us-ascii?Q?xSdS9pai3RHKtJVMmMDAkEIiXtVjxWaqVrq+cN9eRioxZYNsOPQ3e5Tkljcz?=
 =?us-ascii?Q?Ee234K0uuEhHRud+DMtf3Vormk/Kavoc3c1k9m11U8gEv6ta5y3k48xh+w8Z?=
 =?us-ascii?Q?PHlGnNptANvXhwS/a/iYIogxeJFKYAdofqxTs3C/uGeFYGYAVeN85pSuEq5J?=
 =?us-ascii?Q?HZdlbMbjPB9wyDgBCEoU1GyZGBLirdWkK6khya8K3g4eesI1YHPJgQjRvY61?=
 =?us-ascii?Q?9ngHKSs2BFymhDMTPvME0XMZO0ZkwW692qACTLjYsjshnEOPSdIUAi3XVuu7?=
 =?us-ascii?Q?S6KfpcWF9Y38tB1qlxwxRdfIZt4ZG07Cp42gWuRo/NUP2jLspClWzhUBRji4?=
 =?us-ascii?Q?+UZAXF/BMy7wr+l2Wp7SomQG56lUq3cgWSYq64cAbkjEzISvlsBBjR5Sfel7?=
 =?us-ascii?Q?sLjlUxUGocTAz5lWppsOON3R8VKdfVRGY6clSVAhToPMu1CO2rmZko3sYIjc?=
 =?us-ascii?Q?/5OWU84UCExw4jUFxpxQYNudWM27zujSFVfEiq6NfnPop+T7JrM4fLOh3cA+?=
 =?us-ascii?Q?3dy0370bo5GWFxNEEXrJkW6Thr9itJqXlGReOvxpJqCABiet4j9/FxawRSTl?=
 =?us-ascii?Q?1b4DcSXHW4IAhsalNWPfBCFDtctoxnEIvBso3bxB?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 920e9cb3-16a5-4777-621e-08ddd5816c73
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 07:10:00.5615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VNi3jMs+iw7ZB2iWYN485t0xlKLW5jIq3rWozVaq+LdNYYyB2uVAEuyNfJDhFvWAgP5nxu02hxk4SIWdZIp6sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10814

Some PCI host bridges have limitation that AER/PME can't work over MSI.
Vendors route the AER/PME via the dedicated SPI interrupter which is
only handled by the controller driver.

Because that aer and pme had been defined in the snps,dw-pcie.yaml
document. Fetch the vendor specific AER/PME interrupters if they are
defined in the fdt file by generic bridge->get_service_irqs hook.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 .../pci/controller/dwc/pcie-designware-host.c | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 906277f9ffaf7..9393dc99df81f 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -13,11 +13,13 @@
 #include <linux/irqdomain.h>
 #include <linux/msi.h>
 #include <linux/of_address.h>
+#include <linux/of_irq.h>
 #include <linux/of_pci.h>
 #include <linux/pci_regs.h>
 #include <linux/platform_device.h>
 
 #include "../../pci.h"
+#include "../../pcie/portdrv.h"
 #include "pcie-designware.h"
 
 static struct pci_ops dw_pcie_ops;
@@ -461,6 +463,35 @@ static int dw_pcie_host_get_resources(struct dw_pcie_rp *pp)
 	return 0;
 }
 
+static int dw_pcie_get_service_irqs(struct pci_host_bridge *bridge,
+				    int *irqs, int mask)
+{
+	struct device *dev = bridge->dev.parent;
+	struct device_node *np = dev->of_node;
+	int ret, count = 0;
+
+	if (!np)
+		return 0;
+
+	if (mask & PCIE_PORT_SERVICE_AER) {
+		ret = of_irq_get_byname(np, "aer");
+		if (ret > 0) {
+			irqs[PCIE_PORT_SERVICE_AER_SHIFT] = ret;
+			count++;
+		}
+	}
+
+	if (mask & PCIE_PORT_SERVICE_PME) {
+		ret = of_irq_get_byname(np, "pme");
+		if (ret > 0) {
+			irqs[PCIE_PORT_SERVICE_PME_SHIFT] = ret;
+			count++;
+		}
+	}
+
+	return count;
+}
+
 int dw_pcie_host_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -476,6 +507,7 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 		return -ENOMEM;
 
 	pp->bridge = bridge;
+	pp->bridge->get_service_irqs = dw_pcie_get_service_irqs;
 
 	ret = dw_pcie_host_get_resources(pp);
 	if (ret)
-- 
2.37.1


