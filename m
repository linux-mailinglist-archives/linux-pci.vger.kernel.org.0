Return-Path: <linux-pci+bounces-34172-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A223B29ADC
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 09:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C3DC17C68E
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 07:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB8F27CB04;
	Mon, 18 Aug 2025 07:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jI4TMudk"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013005.outbound.protection.outlook.com [52.101.72.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DD72798EA;
	Mon, 18 Aug 2025 07:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755502379; cv=fail; b=aBxNngEp6bI1+M9qAxgkE1m6/3gIv//MM8YdxN5hhFsXD6q0IbAx0QTNgSU3HD6slmsyVmRAXkChorMK9iOVyLo/r8/cf5k8pHdanZsVhfUo4iA+9VEPzdUmczKXZESRQIieNJMSbFvPLzKvbD9IedI5oKPMvlXhxixma1ViuGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755502379; c=relaxed/simple;
	bh=FJnYr8S3Z8rr3nJZ4PK31fYI5fMDywJW1iixA8AFG1I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=vC2FvIJCn/enUMDg2tCswfhM/43kYKg1ifQoouH79xHE2wZSwRpkP/BH7VHMeFJ4LZoM6803EuEDSBfaAH2ssEoIQQ2o1Ohv8tIfn58W7bNgv5gG2JHOqSHOXl5dBq9wM1p3Z4hYqyydTUnr5JZic21z4D2J2GswF3P5R2BOrN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jI4TMudk; arc=fail smtp.client-ip=52.101.72.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e3hwmoAv5/5fmA4U+Rx2SrdZsTvfh6x2SgMDmA6AoybLgbZUVL8jr9mZFunCcVTM0/+cTo7HZOVEbyyOB4uNaGrWOGseW9i7pnz7NMW58q+VbpKQkvzmeZczp/9/1xB1xVxMb5lOTWKIrkYBIOTknG1TlZQumzHLydi9l2oKqPrItPyad92TkTW5E8NJYDKIlVp0+MLqQuxmhgk6W8xbyp0FKKxSG/Hpdk9eoMYqOTc84/7UFbGdACALOhonb8Y2phvsKyvtO1Dbr8P1wQDbGZfKTcKdJH7tlrSbI07I/Pa/PEJJlZFLcbsKYjv+oRs7f52eZ3s2KQdQzLYkFMw8oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NSZGv0FmqbwS+LbUjwsmHIWyPW6CsRO2Uw3DePhj1zA=;
 b=n/cvYUlKivauhI5eQxd0+rJ8QJDqkmjxuysH33sFy0GKef5/KAV0DozwJmFOGtGg2gG8/DCuNbnopb2j4G5umbgvH2bs+iykN2t+MFoNZ4B46M1k7P4FX67sIjDLE96hcwavar21dDzOwxJdSpChij2v490UazH0YosD1dKVzqWBi49V/Co+R04tXZMIv3OYQ1NRbHFN6KEWsju0gN+pgf61XUMBMm6pgDmUxgLyFWuJnTvM7I6pN7aty1ntOXHlcvJUH0LFh4CuAu44Thoq14Q1AYA6ckoTFWrIATmJBel1kJnO2qXSyVTRbYHX/+ngAdeUbEsF0OZpgcUZmEZH3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NSZGv0FmqbwS+LbUjwsmHIWyPW6CsRO2Uw3DePhj1zA=;
 b=jI4TMudkjhJ7xMT//PLc0shHUPY7bYdM03qVaJsMJ6h6KyRnkCrs8s0fwwaNoPE0GQWe749vsyA0N+CAVzES3/z20jKXB87QSF6pSkeb9TCHulHARKthnAA2z77tr5Lv0yFtXmlzvhgtaaFXZn5AMTbmHAZI7CZXIrw4wKg/iRzmeonBq4nIQH8jnApt7zvDmtcj5Pgk99TYbXPIIBw90o7UVxDU1VO3JmdLMJOFflccsHTuBXlwRSZphIslQ5YmrMgPe3SkIsX8dpCBv7nuTUSf5tPsgCIBhx2fD3Nul7XOw1wqMbriswOwMGEmMQ7ko0OQxHhGvXzcZcWWto5NbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by GV1PR04MB10533.eurprd04.prod.outlook.com (2603:10a6:150:206::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Mon, 18 Aug
 2025 07:32:41 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%4]) with mapi id 15.20.9052.011; Mon, 18 Aug 2025
 07:32:41 +0000
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
Subject: [RESEND v3 2/5] PCI: imx6: Don't poll LTSSM state of i.MX6QP PCIe in PM operations
Date: Mon, 18 Aug 2025 15:32:02 +0800
Message-Id: <20250818073205.1412507-3-hongxing.zhu@nxp.com>
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
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|GV1PR04MB10533:EE_
X-MS-Office365-Filtering-Correlation-Id: 6831975c-cdd4-4166-822a-08ddde296a45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|376014|52116014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aYc6KgPUm/ePCl86Sy86206y642L3muXDVweE9LiRejS++pC8yTFXEZbImYZ?=
 =?us-ascii?Q?FjhoNrX4UyXzUA4l1D7z3BdIZbViMe/ZmtPW4GE0i0xXk8AmHtMT7yr/jY5P?=
 =?us-ascii?Q?J1lKQMTo92zSc4ambO5LqY4JoTQEIdoILUeN1hQzKKyn7kNzJoayk13SkS5B?=
 =?us-ascii?Q?fIdehPvC6OKSwLKu63WW2kWfvXFUEW+FRpdZ6wntX6cQNoCLi96bfUVK9y9z?=
 =?us-ascii?Q?kwft6oMzCVwy8ISYvkNjPWz/0VXLc7kTLmy66O85jXEzV4KEQso9MbUIfSWs?=
 =?us-ascii?Q?cA/i/3d7tYaaRdA8gpi1Q50Opob9zytpxoPFmSwyxxsu+hC9bDewe8ZQqHkJ?=
 =?us-ascii?Q?xOV5FhXhJIR0pKH76IogAFHeONwE6kS2mwF411S1NXE5oMSuuIu9MjiK0LsI?=
 =?us-ascii?Q?GdhgEUtRKtBAqus7gwoSOYPcIKgo/FdPOdbdwgdaOFWMv3JmOt34FYkaYkMs?=
 =?us-ascii?Q?EYs9Lvk/tGQGpQOi5SHGWoP9HYJoOgoAbHfuF9ftyxcL8GlkZ6pVjRZYc2rJ?=
 =?us-ascii?Q?48BsHMdZmXoG6CjJ3QAQmx84dNc1vn2ZphutnmzsVj8k+KaCWii1QbL+RXhm?=
 =?us-ascii?Q?C79WyCN82xjv/0n3yU7OTn8Fmv0YgANMMrAjRgFLWUrVp57IBK1t3YeG/aTo?=
 =?us-ascii?Q?nbBhz7etJ4BSd82tnxvSINzHidQeBqbzO0d7OKJgV+M5+aOQQJaiOauAJ6Eb?=
 =?us-ascii?Q?MbXX+Y03kN7KnMHhQZNRDKoZevV33PvUwKhaY3TN0zZz+TLa/UBGHxZj2dbL?=
 =?us-ascii?Q?ttPltC47FXN/zAC4rU12oNoSta4L1pQn3vkHMuUrEaH2+DUD1dsomTNFT/Q1?=
 =?us-ascii?Q?2s5baB5Jra2PDoo9B6OQWy1m8/VIN8Gh4Hd5DIQY5RO53asDRbv8dhgpt11u?=
 =?us-ascii?Q?9arAMmn+zPGnwoAbjv4/BqS1xPg/Ro+MGEf3m5rJX2F3muptkpDYQg9P2rNT?=
 =?us-ascii?Q?wwTedhIVblOnlxR0urdRgpQBUbK2kfbTeivX1mtH9WXw5ZTvJcT3hE1+gfxB?=
 =?us-ascii?Q?tmPIBLek64UNyFnA3qtIhjY9ld2i0p66bipJ5d62d0hDM2D6H+RaTVzfhIUo?=
 =?us-ascii?Q?OF52a1pY1daJ5HOadCgCAskbL1KBEuaSFJ2ObwPik/rl0XXDgo6a4iBK1Yb6?=
 =?us-ascii?Q?uo6SiPLALeFeVN3enWXjtKVOOZsFsohWVWh/zjTIH4bnRP5L9pZ5qc3kHHeM?=
 =?us-ascii?Q?NYsIg/7LLHq+UprhKAuHG2fgcUmC7VjscFqHIZ1VHlCHxubrpwm5B0jb2hkF?=
 =?us-ascii?Q?cSfmLXV+iplVFMr8f02cA6uC0cg7Ahu1MKe7G43HxE9ICwiert4j23wn7alV?=
 =?us-ascii?Q?F7StFGcF+/Aaott251d/KX55GzMOJXixIYv5Yw+3CUGIRVuiXx77tiM+Qkcq?=
 =?us-ascii?Q?aP2hsuIeT8pQrEHgHizjbk/NHQso5/80CrKAm+6fHHkfvif4oOCgorzQpbKK?=
 =?us-ascii?Q?c8evfyl5o1Dfi9O9BwRfOm3fVPa5CusVSvGCC4jlTGS+W8xeB9YCvmhLERzx?=
 =?us-ascii?Q?8bCfEyK8l0zz0eQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(376014)(52116014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yc0QKhQ+kkrxqsGBysHAjv24hM4J3S0t7/d8cEiv73l7tqjaSSdESVg/iwDW?=
 =?us-ascii?Q?4nk6ttyV2a30tiCsP4nhkLI5ryEsE0vzyndMNDmOeWPY73ZUsBpFMiMeDiZJ?=
 =?us-ascii?Q?0abUdkQfFzmeLx5/1rIm4Fr+HrkfMCRDQBVk0Gzn04q7PPmGdY6sv/XAE8WO?=
 =?us-ascii?Q?GAgx5KNiCqITFeHHHvqeg6WEWjJ+JSo+VWB6hJkWnz6uIl0mW6AfKn1NRbnj?=
 =?us-ascii?Q?b1ZTT7Gfm0H6I2+5DFNObWJhp2EjcNr+qLR2G1U+Cm7RI+54pR7gzry3TCeY?=
 =?us-ascii?Q?FRZnshgJgRUoEZd2/bBJ1Lp5VFtgCnw8ccDqd1tsK5Tm5RQ2AwN1dQOH9DwV?=
 =?us-ascii?Q?oW3PQ5seDEHUBNxwe89sF1PZkQ6Uqn34ko9RAvAuHcVHtrogojt6Do87VtJ+?=
 =?us-ascii?Q?6TkqqzmYi4kHxvTsxyM+IFfrDYEfqPdTxefNG+o7jJKqEUy74FoGTl329X6S?=
 =?us-ascii?Q?FAI7XLJpfT14Ps+Gbi/KobxefugphJ+TAUrXMcRtd9NhFhxfgksCu8p4hImX?=
 =?us-ascii?Q?vH4tF0gLGyxDNscPVPGa2QT8EhPnGVIZONgx9pEIhBIlGF2g59MUXcVpPKTv?=
 =?us-ascii?Q?/DmOqnraBftz1PKr6dF23YKUNx02WEV5ORac8DzehPy7jUmTcG5gPcrHe8/y?=
 =?us-ascii?Q?xHv9lifpB9ztEuBi9Krk55+E7C1piY23w1rDbsndoMVeHZdzBQ4hLKAJMyQ5?=
 =?us-ascii?Q?nVHt3nDply36w5wOGU/HNsblNJrOLKARv3J2mmMtbqkgMWshj1XINyAy4dLB?=
 =?us-ascii?Q?yz1FggSakjCFJZ7oto4sTm4R6lD8djIiyYwVAYnkmUPERN+csQeo7ZsnTlLR?=
 =?us-ascii?Q?H9xoLAikw3vz6kbbbja48ZSBLJ2+DlVHHHx3wJNkcY1DGRtECyYJpGc11Lmz?=
 =?us-ascii?Q?QYXANyGikHK5FCOhIWBJyopBEMDtbGThcdt2ueaAO3E+qfFFpV47vx0Pc/Hx?=
 =?us-ascii?Q?BQifoIR4GRfu3bKbIhJjanE6wpHAmXUZQo6fznCOvarEELqQWtEpSxlGU8Z3?=
 =?us-ascii?Q?p9yFs5CW72Bd7iUKfKeN8KrBoFP8krV+HLcomrdihLPNmP6T4UQwj2RA/65m?=
 =?us-ascii?Q?XrNUp130YQpeBb/K8VQHwzV4O5+gudKjpEi/mWT7aT+qXFU6LL+AdH9GutGZ?=
 =?us-ascii?Q?PU9XaJW30EekqBxWLPmH91x4ZktzHIokz8w24hASH2ZV6rUuLTiy+m5mONC/?=
 =?us-ascii?Q?LKngX4DKhhI1whZkfVHtnXjc9DX7JrGZhXWTFmnptrhntblV6E0QJJJhpVqH?=
 =?us-ascii?Q?f/ASIa5enqkX7nh7nU5fvrc4hycJocpvSyMZZkdOutnX4RwnIij8Rlm6tZVf?=
 =?us-ascii?Q?5qsDxBVrbHktfiXbaYlr09cl5pPnXc/+GZeL+DHvAIk887E1vtHSYcgys9Kg?=
 =?us-ascii?Q?U1ayeFHXLXtggj1313AOCicVfSBL7oDijn7Fg6aIJPtNHhc3PfbSuY2hj6m1?=
 =?us-ascii?Q?8KSOHegCoRtctB0OKc7yFa3ftuWZvLXWGUsrA9T/pI3aE3kTqhDuQFYVWNzk?=
 =?us-ascii?Q?B7sH6EoODwKiHtwaJ0VgRuQh0t06Zcu+fSms00FOSgpoOKaM95YS/oWJPwSA?=
 =?us-ascii?Q?m1KGGIAuo1dR5AvCiZ50YnLBsCv/V2+7/HFhwXjv?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6831975c-cdd4-4166-822a-08ddde296a45
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 07:32:41.7819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FkxPir2Z0wOeudyUix1B+0DJd/RFviXjqxzfF2787fzlicz5eknXKXPiSXaqxPkDcWiDj469qZzbZhML3MzIXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10533

Refer to PCIe r6.0, sec 5.2, fig 5-1 Link Power Management State Flow
Diagram. Both L0 and L2/L3 Ready can be transferred to LDn directly.

It's harmless to let dw_pcie_suspend_noirq() proceed suspend after the
PME_Turn_Off is sent out, whatever the LTSSM state is in L2 or L3 after
a recommended 10ms max wait refer to PCIe r6.0, sec 5.3.3.2.1 PME
Synchronization.

The LTSSM states of i.MX6QP PCIe are inaccessible after the PME_Turn_Off
is kicked off. To handle this case, don't poll L2 state and add one max
10ms delay if QUIRK_NOL2POLL_IN_PM flag is existing in suspend.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 80e48746bbaf6..18b97bd0462bb 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -125,6 +125,7 @@ struct imx_pcie_drvdata {
 	enum imx_pcie_variants variant;
 	enum dw_pcie_device_mode mode;
 	u32 flags;
+	u32 quirk;
 	int dbi_length;
 	const char *gpr;
 	const u32 ltssm_off;
@@ -1765,6 +1766,7 @@ static int imx_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	pci->quirk_flag = imx_pcie->drvdata->quirk;
 	pci->use_parent_dt_ranges = true;
 	if (imx_pcie->drvdata->mode == DW_PCIE_EP_TYPE) {
 		ret = imx_add_pcie_ep(imx_pcie, pdev);
@@ -1849,6 +1851,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.enable_ref_clk = imx6q_pcie_enable_ref_clk,
 		.core_reset = imx6qp_pcie_core_reset,
 		.ops = &imx_pcie_host_ops,
+		.quirk = QUIRK_NOL2POLL_IN_PM,
 	},
 	[IMX7D] = {
 		.variant = IMX7D,
-- 
2.37.1


