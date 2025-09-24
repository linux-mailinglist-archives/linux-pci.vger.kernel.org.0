Return-Path: <linux-pci+bounces-36834-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83335B98825
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 09:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 454FA2E3F42
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 07:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C462741DF;
	Wed, 24 Sep 2025 07:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="l9ttxSpR"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013063.outbound.protection.outlook.com [52.101.72.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6F7275AE6;
	Wed, 24 Sep 2025 07:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758698641; cv=fail; b=Ydx/ciF2EPq+GHi2nucj5koFnguUzZX4tNrSsZnHa5ln0pbhwoF+J7ab0syQu+4H54BGrepcSzbquqwWkk9xnpUv8PCGn1wLv+6bXfTWOrUkiktVTzqnagEU5MrThVmvdhfPxTQW7gpRw0liI5cW3gL1UNbVDfh9URpjwYiEh9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758698641; c=relaxed/simple;
	bh=aTbMZ6BOGwoC23CvOTdbOYg0iQyRiTykvU0YdeYlbnc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=THw4FBWUKPMF+sqmHWlpCYbm7OqKZPNaptRV2TA/guEDdbUpUhorhdQGcT1h/KTm+O1iUnXZVL26QQiPnH+t1Xt6F9/RDkQ6JQUVsjzfuw8R4CIUf6zPdf72T4Tr8SRdXVmeFSvqZnew6WTBA8fXhvFvNwlm7VmBmSiIco7jxyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=l9ttxSpR; arc=fail smtp.client-ip=52.101.72.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yI+/LxBs52jjYilFa5XAHfxKXuJwZWeot4yoGJkRNcAP9fFfNJZaLOwa7nIAa+yDKtUKIi2g4XOVxTeJCLRBy1aSuSlYUKWnxil7jritoI9mJXOTzT3KxJlxrYT4AFoqDLaDGFPveRxAszeu8pgEgeVxFku5i1V5RzTh4pssyMDqle1eAEN2G44OpCqtIzNCi2mhzu9nkVUeJ3jiJ6djygtvov19kbM6V4oFxYgXcHI2grfhxe4m/lHtRDwiA7xv0mr2SCFM7ZVPMjlaqYerugjZ6UCCi9b4Y/0puWYRNKf4eEDXWCpk6gTU6IIsUOhsWDNCugJdbgsd8P8R/ac1/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9JtoF6g9Hd9MdQlalTHgjrAKTd14dRApYJm6mbwHmMM=;
 b=SP4dabrOk0we0+E7yKoK7QnIKdz++6IPvtxeL3j2BEgCumGtzeTi5/T/WjTBM6sUs29/lBim0g215B9nrGTN5X/zg7Q3S2XBkCkfQzD7sUv8J3+/eTXNb5jRczNH6rY/5nc+jR45VOvF1yWrTYvkwO0eq1vWvnrAhPsua6hozikuQJEJDLPkpHxb9BSB4KUX1r54J6YrANwXsJh2n+9iKGEaRWDvCNq4zmHrRQDJje3siDZooULajb1zuZjS5KgtJF9A4S/BBxZx2qwuUtikvCtQ25Zz18teDl4jjq1dn7wvPDxD5mU6hrXvxJkIo1o3Av27LLThQtwU5GHtSkMAEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9JtoF6g9Hd9MdQlalTHgjrAKTd14dRApYJm6mbwHmMM=;
 b=l9ttxSpRFQsfpVGOe2dokIsyZB4lb662Ywt9dJnX+4mIkWR0fkdg+qQSQp4flZV39bxKCbRcR+04+dTiNLJVU1XaLfTabX857gzp+hTKoyJc2sPF1Willv/9+L4uoffxJsksskrToU0zK+VajybgyTGl3OBt7nrkw6qG+i2WgqcG4s9o+NnD0oO02f+do3B3s/Z1F86j25qosbbYEYgFi+qB+lrhFC+sisAXlQofDG458GUs6KLEH39WyLFHMSpXgXgSkcc9HgAYSY65e2jcDUz1kMvFkYJ5hV11+Ir5ubJBYLpwiZoTWT+oPRqzBKnzTjwmTuGhMuLrWuB2B9jr1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by PAXPR04MB8271.eurprd04.prod.outlook.com (2603:10a6:102:1ca::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 07:23:55 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%3]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 07:23:55 +0000
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
	stable@vger.kernel.org,
	Bjorn Helgaas <helgaas@kernel.org>
Subject: [PATCH v6 1/4] PCI: dwc: Remove the L1SS check before putting the link into L2
Date: Wed, 24 Sep 2025 15:23:21 +0800
Message-Id: <20250924072324.3046687-2-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250924072324.3046687-1-hongxing.zhu@nxp.com>
References: <20250924072324.3046687-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0019.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::12) To AS8PR04MB8833.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|PAXPR04MB8271:EE_
X-MS-Office365-Filtering-Correlation-Id: a8ebb9bf-1faa-4bda-6f74-08ddfb3b51c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|52116014|7416014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cvegUCYzrflSSQhkiyBF6UwOqUqbx4FYhmhAUoBCQETazQtK+u7Tu6dfvItk?=
 =?us-ascii?Q?pcGm14lIB7gJ7110njaSSGP7xoqtOIAr6wPl5c2YwhQJefQGMyaQxCVYuFeX?=
 =?us-ascii?Q?uZB2U9ngquSKBaNFZPWjHMbwyrZAaVyZacMgZ3EDY+USU7MFSNgVScp2rkNS?=
 =?us-ascii?Q?qvnqVu1RZ0ga1kIcK3vwVti2H9TZ8AkYOK6edLJxPTRYllOw00YOZ/Eb9nyh?=
 =?us-ascii?Q?30C7mt1T77AZvTWSnGKMny94tX1XJV5BlNJxtmyArU67Ta37a+ahB1tpKLhA?=
 =?us-ascii?Q?M2ACHi+ic7mdnYHDbOR2epCLlUYK24o1b5ONGwDtJK77ZWur8UhxEqSicNWG?=
 =?us-ascii?Q?pAUpwEUGVzcYBfVfdrRBcw+nmLIz3juDsUOpAusafCDmxpiPumdQIAH4Gy7D?=
 =?us-ascii?Q?IpcjmEdhvtttrTE5ih99tswrOz3dNY6usGYq/m0VDAQq8Ju9wjJ67kDKT3V5?=
 =?us-ascii?Q?s3gHqUE/s2QelG/rSdHLUR89X/TQxXs6lPJRQXikNKLEw90EanWj6eJEpBge?=
 =?us-ascii?Q?sYBkVdpifGxWgaIzsQG3YRW89rRzSgj85nWbimLQsJAKm1A/EkVArl/JWPf0?=
 =?us-ascii?Q?TG2Vqj6klsqEYp5cwfbKJ7ALCmMEeKKe6mdsRwjO49VY3UOO3sMh34d0n7eZ?=
 =?us-ascii?Q?PZiv9tlRPz89U+dwolAr4SPdoWgGTy3k2lCWZgoi9o+qlWxISkw2Drx+tUXx?=
 =?us-ascii?Q?ezVAcf/Ds4vNVB9X+2ETFe7WGd6rVGzx9AVVYMZG6fn7dhy2I2f+dMZ1ESfy?=
 =?us-ascii?Q?NbXtnB/01OFqLi+/vOdpVLAbce1qOyV0WX9VTCW5OcpfsVnHuFOuJcXJNB2k?=
 =?us-ascii?Q?/dq/tvu/3094OTS9BwNuX17q6fjxAYIpPoyLKQdAjOoSoR0ujJwD09XzeU53?=
 =?us-ascii?Q?eHhpuR5bYHpEyOBBr6oEmQ+1krkqvJFtN36JA+fOZ3pIQRVdGEoDfzbO+zBe?=
 =?us-ascii?Q?x+cZTjpjTs6jcjimg+2eUoT9knjZgYDLJUbTlCafnb/QZP6Ik2LgK/o1VTes?=
 =?us-ascii?Q?L8xcJMbkhzzHi647ga3TgGLXMLx1+Lj9+bdLTyswa+/Ob09hTFxHmkiG1aKi?=
 =?us-ascii?Q?P1KzfgXIXYnOUI+ijAEW7a56KRMq78jq9q7Q2uD8Yz0gbxFosSob+Q0KpBm8?=
 =?us-ascii?Q?NEKj3M0j5+hxlGG6oMxeLw8Cay7WFECSuUO9bdjqWzsvaSV3amtPN+nEd2eh?=
 =?us-ascii?Q?lLXu/4pY79hqQ/BfsxO9KaSGNhwA2Yqv5ZTAh0AeLRxxZvgQ476TXunn0Gx+?=
 =?us-ascii?Q?zUMGYyHTIZuW/RKseO6VmAfQ5jrVkizvqfp6pGA7x5rZsmsLzwpNrJ0u7zQw?=
 =?us-ascii?Q?ihIpKmM79+hEmq0l2fmx9c+DQnU3FpsvPlomHVxxDcFn+C5OFK/op6T/gSR6?=
 =?us-ascii?Q?tn8uuG0iObmFxsdK4bLUkm54yNZcdM8k3dw1crr11n1XDkWA+GDpppVAAHoy?=
 =?us-ascii?Q?VlUdz2mIoQCC7v2uxaCrin7Q027/HgqQbfey+dtZryQlnO73130/NERr7UCF?=
 =?us-ascii?Q?A9vTbdqUPNuyX7Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(52116014)(7416014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tu+IuKnvX6SZQYwR2tX0proxHkVuguBScL0WE+1cJRcrM6b3CmvfPYPT8l1j?=
 =?us-ascii?Q?5zM1elAHxycS/hW8lkF52j57eSH5vRQ9hmo4a/zj8uMNK4vajikVXk8o7tgm?=
 =?us-ascii?Q?v5Cn/SPm91ujvRg56+iDitirGPurP+dCuX8Tcx27P4lnBQeqVUG5gjkOqSLa?=
 =?us-ascii?Q?YmsQ89bdXmu4V3cP25UDZSPDl0fkFGGLx3ySPoh40GXRmBwdaWOsnMWN/coU?=
 =?us-ascii?Q?Vc4QPCYGFm7D3xl1k0smTKJCVe4JonqDxv5i9/RsBfBgATnbDAuKk8XClUGq?=
 =?us-ascii?Q?UKDw+sr+zE4yzBQt+H/7D2SGNcvIx+KNlA+9MK6e2JuKhCCjvrWZ4KberA4V?=
 =?us-ascii?Q?UzWHGj03n4rKR7BkClUDTzCVsAHsQ5c6YX7NTSzRAiRZF7/VG/cOSLDEws2Y?=
 =?us-ascii?Q?phHAbt+gsv5MLUFNKUeJy9YHdsahdUGNJ45AjGSOaQyWQpbRou9bJGprh2uW?=
 =?us-ascii?Q?F2jWBdnjuqqGb7EkU+CprIhlcaY4fibv+QioA0wtcReTLgFujEa2GvdZp8F1?=
 =?us-ascii?Q?XKlXD8ZqULMJ/tH6xAXlaJiNp37xuKpAhP4EmlcCKKH5IQ1ou7NSlST8krwZ?=
 =?us-ascii?Q?ru/NJZl0snZugbYb5w4yekEfDDiATa/NShF+IuSUajM0MCk86PpxGBA8/gmX?=
 =?us-ascii?Q?zaPnRcnwYTwkgat0xNxd4xstGKVOi4TOynyUYggR+A9hIKCpcGT1DFuWhdzm?=
 =?us-ascii?Q?+R2lWIEy/B59je85GLr0sbXsY+3uLSHdIr33hhd+Fqhm61PcWRlx8HsxEyqJ?=
 =?us-ascii?Q?dagzRWVcVVYjV+zMd5PSAG5Wnvou42wHfK78dWduXhEwOeFSai7AzhmCCang?=
 =?us-ascii?Q?M2AG2VvpY0FsU83Cr3lMX3WzAlTkGT/Kz4eRVBhhE21Iebk+txZNkKGu82x8?=
 =?us-ascii?Q?ewkTSX1bE+kTIpccvSNf18PcI7HwKIm0PJtBt1pI5Bt2KaTwJ4JsST+XiUmp?=
 =?us-ascii?Q?4yZcwF0Klob1FJ8PBrwzK4ml9hMaNN9c1u9HKluGeFlxkxgSQTcjnWGHWQVW?=
 =?us-ascii?Q?LO56VT2lYK0cPIuGY9A7gHorg720ya/KEbLSY4FjpMcNFxhGtVW7Hm3Zn70d?=
 =?us-ascii?Q?1Ck8n5LSU7jJh6HS9w0RCbyAvfH+0RVrmtvcT7oF3MUuoKj44Iz4ROQwmhMl?=
 =?us-ascii?Q?qUIi4bOvUGzixeIIep4pa42yGCL/8xzQxfi6GkvJ+46pIZtmwO72epeEMJOd?=
 =?us-ascii?Q?4XdkbMOZHVGAfQlZztTXLItXuvrwQa6jQAelUwcY02Fe8/DdwSZYWaU7zrkO?=
 =?us-ascii?Q?lxRNdK5i5ci9DXHmlI4Y6Dr3uaa4JFDYVF2DJYBOu7/AEfmFkTMJB96n6LOF?=
 =?us-ascii?Q?iQb6NALUWJMvztMQUodEg9JIdm+Z6QOLa1iqxU3Al7V0sIB2By+YkpqREWen?=
 =?us-ascii?Q?KSXQiiGYdjqmqYpciQCXF4vuDPH8YtCGL9u3xHcbvgzitWp+nbaF1gnzhw4t?=
 =?us-ascii?Q?sQuNX2um3VzsBGOVc4KGviAqhaOIfU8rW1ey8Z2HuBC3sOSrMkMx5ixuCCx8?=
 =?us-ascii?Q?3XNEiQDpv+VnjVCDeCQLNhbMelflgcPo9on2VxHRwAuQ9Q/NBRCy4OxR9bA2?=
 =?us-ascii?Q?Gumg7wpmM4wU5TY2yDdSxHT8cUcwJtCVDPWwU3Rc?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8ebb9bf-1faa-4bda-6f74-08ddfb3b51c0
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 07:23:55.3304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f0yIl0jpUpNjbqLY4CdQIKB9+/j7B3Di/pWe6DLcsTe6UI8YCCBUFeoBbdczxinm3XfacdS07AMd2TdXkp/NgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8271

The ASPM configuration shouldn't leak out here. Remove the L1SS check
during L2 entry.

Cc: stable@vger.kernel.org
Fixes: 4774faf854f5 ("PCI: dwc: Implement generic suspend/resume functionality")
Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 952f8594b501..9d46d1f0334b 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -1005,17 +1005,9 @@ static int dw_pcie_pme_turn_off(struct dw_pcie *pci)
 
 int dw_pcie_suspend_noirq(struct dw_pcie *pci)
 {
-	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
 	u32 val;
 	int ret;
 
-	/*
-	 * If L1SS is supported, then do not put the link into L2 as some
-	 * devices such as NVMe expect low resume latency.
-	 */
-	if (dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKCTL) & PCI_EXP_LNKCTL_ASPM_L1)
-		return 0;
-
 	if (pci->pp.ops->pme_turn_off) {
 		pci->pp.ops->pme_turn_off(&pci->pp);
 	} else {
-- 
2.37.1


