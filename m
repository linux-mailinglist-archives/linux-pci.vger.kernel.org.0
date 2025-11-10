Return-Path: <linux-pci+bounces-40722-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CEBC483CB
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 18:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3901C3ABC15
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 17:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC6C1FC0ED;
	Mon, 10 Nov 2025 17:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="YKAL20Uu"
X-Original-To: linux-pci@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010069.outbound.protection.outlook.com [52.101.201.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D3F2874F6
	for <linux-pci@vger.kernel.org>; Mon, 10 Nov 2025 17:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762794056; cv=fail; b=SJIRnxxnl9jwOk2eoGWlP7sEiOdC1gZPHRx00Bwz5afPLpndJ3Bg3ErY/BcvXi6tUOpm/gkO/TTC1Gkjt8jyFLNbH+tSGcEL4WQhaX7F8c2Kd+9veymdNCvn47GzX9OSGnKj6M0DjaUkEzBZchU5XKAwI4ix7K6t66YZ1drp3zc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762794056; c=relaxed/simple;
	bh=mY9ECJd3p1xKAEST3ZeVrpfcRxtKzSJxkGMwyM0LoRc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ahDg+SGBbJPrfDjhlkkzrRLnK0kC4wte2QdK6o9kJR8Umnl86eN/0sTwmgvxmxZzbh8T4ho0kr4ZpmvlDTi2o5YwZFXDIsOa5Yd1xUitXn4sZZe7tkLHSE12v2a0hHr3GKY48QQ0dvOTTaE+lR3wFl6/q5EMxVqgypsZ7wGaGJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=YKAL20Uu; arc=fail smtp.client-ip=52.101.201.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jMriqxOYlvCzr//RoN6kSvj8PMZbVc66sQ7cIVkmQvrB/m7cQuN+EGbQ27w3kErgg+nUqAOHTzPr/zz5Jlhh5MSG2rOi/BRVMkkJDMG6ogS1AYga29dkPe/E6fLTzbzj8UjeoLGSoQTFS02B1C+b4CEAJh+n19PDvbeKdh+AHyqBJ1eGkokxCbVray0abqLOi2IBym9u7nAa0RqRBELgShWlBFkHPl0rpKu68ihDlk+G7dsliD05LDXeQkxP+FJE6UUebPwmrd5J3HzylKAXqtfvznaJToH207HGBn09zo30E5giq3eSBvjWXh6Pj/cB/rZAAWuNe7zOZ800OQ77fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4YOdOjMCX4RydGev6WQ85LphgKq/B/lrTNfrxDrkyH0=;
 b=o49A9nC7qe8DFT59FCJ/CYQn88I60CzAaeVZFRs/J3XX8Azp+OjjT9NCAteMhGY5S1kzTf0+Xep9Iv6i506Bd35vQ80lSF+dp1E9DbCtqgfJPDAZ+jwcMso1K0SuMCJ0hf0tEemDkBTTJdFdcgqVmn48pC3xiW0eyuy5HanaR5Gd+9K9roNN7/fsjcJFRxIAzzON9NsUWwP5TXRv54r6+wXJc7Y02QY19uZWeJr4Dh/x45dbXI1YpJNVNRCugW55okC1gjfY2upo/yq4WsSYzScpBlvkOO43w8M/w5x8zQypqjNO1ebj9CHu6o6Q1EksrYtL9UKjDE2dq74oTwCKhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4YOdOjMCX4RydGev6WQ85LphgKq/B/lrTNfrxDrkyH0=;
 b=YKAL20Uukfr+bcAglrWjy5TIZzGBy8veWekfDB5BO/sxEsSDmwK/chg8u4vZ8koaoR87Ubtm9C8M0t1yQA/2Sdo5zlwzXb0lT9w0JUMTKoZ3kuAQ3oNGZUVl9roUXgEcrktjaoNRiwNDMCkxAUCMV/3fSZteFBk6SkTNXSgFr4odt5hF7OoZHykSKE7kbL+F2WCEUrGM5YyogjDLsvUccUjEU+mId8wSNxH2oM/iBCf0fMFr7lvColIDT/6Yfvn/M/SHyKdS3j4lJg2qHohtZTnLlBPopkQGGXCjOnqrdmn2/WUHEreSsXFyBDn2zspd9R9D4zgHh973kC44yFKZ+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA1PR03MB6498.namprd03.prod.outlook.com (2603:10b6:806:1c5::7)
 by SA0PR03MB5627.namprd03.prod.outlook.com (2603:10b6:806:b2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 17:00:52 +0000
Received: from SA1PR03MB6498.namprd03.prod.outlook.com
 ([fe80::feea:da58:faeb:9ebc]) by SA1PR03MB6498.namprd03.prod.outlook.com
 ([fe80::feea:da58:faeb:9ebc%4]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 17:00:49 +0000
From: Mahesh Vaidya <mahesh.vaidya@altera.com>
To: joyce.ooi@intel.com,
	linux-pci@vger.kernel.org
Cc: subhransu.sekhar.prusty@altera.com,
	krishna.kumar.simmadhari.ramadass@altera.com,
	nanditha.jayarajan@altera.com,
	Mahesh Vaidya <mahesh.vaidya@altera.com>
Subject: [PATCH] PCI: pcie-altera: Set MPS to MPSS on Agilex 7 Root Ports
Date: Mon, 10 Nov 2025 09:00:45 -0800
Message-ID: <20251110170045.16106-1-mahesh.vaidya@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0060.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::35) To SA1PR03MB6498.namprd03.prod.outlook.com
 (2603:10b6:806:1c5::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR03MB6498:EE_|SA0PR03MB5627:EE_
X-MS-Office365-Filtering-Correlation-Id: 50709f1a-b342-4de2-d0bf-08de207ab2b6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XWMdDJNLviHzYAGHu+KgygVlAuVYgjT3SCPTNv/aqU4P3GsCQjcvbDXwICfx?=
 =?us-ascii?Q?Y+bZ75fpvkk4PUE+sMTX0mtQdvN6Ek4R9fbosku43VpIIU1DsWkRBNxhRA85?=
 =?us-ascii?Q?+vOV22Bwak+XP4JdLP6QpQLIXLjmHnq19ECcroQMbsFaa9j8jKelnrSjzYmB?=
 =?us-ascii?Q?Xj9kLKByhq0XRji8fkYFN8Cd/TTOrphp/jQ2AdU9jB1/QYPIsG+gH3Kz+0VQ?=
 =?us-ascii?Q?U8xa/JOkxp2hNkqRo9Nd20Euq3H82/i21warb28Yqh8CzpfQTyS4BCVMdieJ?=
 =?us-ascii?Q?XXGiEEh+/GrBfDFd6H0GcwF3mB9vg0g6oZbdBAvtpmue1Faz3HWwqSBoWQWY?=
 =?us-ascii?Q?N3YteZ7wI8jJySXKeB7scpzo5fXjhYm0kgMJO5GWdNHmQd4FizZ+ahnVZUK6?=
 =?us-ascii?Q?89VYOcaP3C6irqBYzPcX+JU/irDQhhpnKWmBHfJuOENSwL0urekV0BJxpfNU?=
 =?us-ascii?Q?AvQkoZKhpmWzq7jlUJi2RHSb/TuiN1AiIXj5ZYo+CHiFAH9+X7J65KD6np4J?=
 =?us-ascii?Q?NHetZ/tXSxj5nPMDSDsIets2DRcGC/VpZZNkhejqG5hLJFlqcDGAgGWGn6fB?=
 =?us-ascii?Q?dUd19aiD8xTrVvF8qfRiV87ur8oWVJ1ztiO7381tJlhk0EtOPQI84juoOWJt?=
 =?us-ascii?Q?CDGEnAu133h6xVzBcB7yt3mFa9V4N+bHfKegLgL/zv3EPiqzj3bKEyqlCW3H?=
 =?us-ascii?Q?aW3p1j7gZ5uKVUrLbLBtAUT/IsnohS2+zQajWnYUZiV2swzuv9rXkzRsen30?=
 =?us-ascii?Q?oK5KojniQ3nddKX2+cSNWI/XXpRV7IFXJVhmhJXwnMopRi6m/qO9cefjSefv?=
 =?us-ascii?Q?r5AniF3lO/fvNZifgKsy5qe66n3oeiFR4W9Zf0kSm8szkr4tZ9asg+3XD09Y?=
 =?us-ascii?Q?1owR/Htc39DBuY5RvfBP4rq0v1FcHOL7CpT6okxqVF4v+xQihtyMiDZGAvxv?=
 =?us-ascii?Q?Nw+UW0BSEOzn+xtnn/hG34rYDqNx/9ULa1YpkbkEdIX8NumKS77PAEI10ndP?=
 =?us-ascii?Q?khWsaweDQ16liM3je2QCDFKsOdszFDNtLfiw6at0zslxxsakPcv9z9+m5P1Y?=
 =?us-ascii?Q?X/jrvTkwLFtJ0RLUnOWIqmBckFsxEdRxNoT16c74QSc5sIb1mmah9P5WfEta?=
 =?us-ascii?Q?8paos5mf6sV+sQ47Aj5IKgZJNU+zotoSdFxiUT+G04OFLYmw49vyek8LIMC0?=
 =?us-ascii?Q?cDF3vcEgLTANTZsBmDuvjHxB8/OYvE3d3JceF4uWjWIEs6q4vKncD3LX5yqO?=
 =?us-ascii?Q?0ChyRvWB4sO4SugMnpp+w1ZVpZYYS4cmtOY8tJShgb6JOIrpdS1fRS8dNFU8?=
 =?us-ascii?Q?0KARxGIvkNy9Rv9ImSS0v9FUYsLqex3QEpwlIjYcCI36R4DDftvP72YDidqK?=
 =?us-ascii?Q?foEXlK7DgOwbTh0h8PraT5NvyxcZqAHU3E9b+8UowshFiUXhhKxbygZnPq6S?=
 =?us-ascii?Q?oamnOmoWExLd6XMPJYGvIYcHKNouL6F5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR03MB6498.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QxxYUh7SPD8rF0bbAc9Ojsva7IbfSPSYFesQowBSFtZuYxM3sJRv3HmtHrNQ?=
 =?us-ascii?Q?+DlZPRJ6W2Atf8MnzKJi0DtS70lja1hSlscO3yraObeyCaSVOHimrCMnK8WW?=
 =?us-ascii?Q?7MESvviDDwQK3vyLTxDt0sqznzRKwjOPcvAH/XtL8PF7j2yD1HnVwzdtKSRm?=
 =?us-ascii?Q?AMz8PHgal7NnKJnsRQjEhzVtdd6jNW1Dae0Nina2OsjbS2CTS7631eEzsWoL?=
 =?us-ascii?Q?8IX8lzexPdASTsxH4UnF2FhW9mxSnxChcnxT/ajdAYytiZmNZLT0dztAn0JZ?=
 =?us-ascii?Q?BM8612P6Ou+/cbrgJgsVvaDkwEOah6NbjMcgibdbLWQxrYnEk5TWCJGHsw8l?=
 =?us-ascii?Q?fEdURvLeAUHGgKTNtvaUDRRO1LzRbHe0P4gPO6k8mbRWFQQV2ads1fj++B5s?=
 =?us-ascii?Q?owdqlH6NXcCSnECfjUbC4UO1G9BKJzYnvwIIuaqehNh9Tf7tDYPnaRUxS+Mw?=
 =?us-ascii?Q?87bwPqs6wLa3u7vRuFvse4w/Hn29PWo/rh44kaDyyXY7rmjkUs38Q4E/Y81P?=
 =?us-ascii?Q?lHjZ9a6XxOBpsj0gT+gztsJJuV9fQtBADYFMT3kBh80bcISLqgb2s/X8mdmD?=
 =?us-ascii?Q?UYpZvxqYrEyMK3gi2bFskmidhHE4DuFtl0en6JT9fdyuo9Cgi1AR3r9HsAHx?=
 =?us-ascii?Q?4f7+bwaipaOEni7lQaU9FB34dr0oWzDCXjcn9jKDExVYSsquwv0B1z2hHGYh?=
 =?us-ascii?Q?QVhZgGVt4G2OIAAaLl9P4t3AIfPwvauJZPBmiCkkdl3ReN6U+4sZoPAmOTfR?=
 =?us-ascii?Q?rpGgccXPGKROkCoGvTQAtPNw85Xp5kMgqUbHS39i+hu/P3KhZWhX4cOWM7ST?=
 =?us-ascii?Q?jyDjxKS72VBXYPCLHtkOFImBfV+iDV1wsR8ykLMpgfnvbRY4C6Jptbemj00q?=
 =?us-ascii?Q?ETecsjwtI2aLChm+hg/WXx3wzieFRni1zKkXWD2moswmrRk/839ZYO7gUENG?=
 =?us-ascii?Q?3k8GT7jBJEOYpc1/Litcq+gXpj5QiRoFhqsP31rrSDSVmIkMuMjmF85wbQZq?=
 =?us-ascii?Q?FJFqp6njoinUnPXRPxEE3WIvcSgGShF4+FMp4SugEjCKe/H0WDGoWBdCPyIF?=
 =?us-ascii?Q?QQ20uZK6l0zekZCUtyWAU3TI4syeSejJXovcB5f49NSdBNoP6S1mztW2/jJx?=
 =?us-ascii?Q?wwKLwQE4ZEiLyRtl/NxzMxxzWZO6WLEwHiU9gEy7EIFUjisHen1bvkkZ6S3y?=
 =?us-ascii?Q?+lncp3bgsSy8mJ1xu4fJyb+nbqrRBs+hnP3+DgTUEUcDFYpzjrVB96v1Orgy?=
 =?us-ascii?Q?B3xqRvr/o4CQO6Mmd1jZJJGZX4gjtkguBS6LzrBWU/BtGg+F1dUroj79l6JQ?=
 =?us-ascii?Q?L6zcgyuhKDNDErzfTe07Ja8GuYvPVZOwTgDFWDQyx4nbfWPEE4fdTnd+CiWD?=
 =?us-ascii?Q?f1ZnoButRgfC64HNCWVz6rGtEMERv/fhbaR/g7VpXDY8FEeHC+Ufrl/c2BtA?=
 =?us-ascii?Q?CL9Oa8UI8X7Dw7bIDGHZ1uvSPep+va/DP5f39X4+tZh5U/o084LnsxSq4GWG?=
 =?us-ascii?Q?9s6AnZQMjPAMM0qNCVMlow3vBbUFXpJGlGoKIr0QqZ5LbsQ85XZK5r9RF5l4?=
 =?us-ascii?Q?Pa6lWmNTl+OCCRnT6FU3F8NgqsFpS7qKdh2TajIfU2SZfmwn3Bu0Wf7oy3VH?=
 =?us-ascii?Q?wA=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50709f1a-b342-4de2-d0bf-08de207ab2b6
X-MS-Exchange-CrossTenant-AuthSource: SA1PR03MB6498.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 17:00:49.2862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uvsjVRhKoZHm0fk2DSIQ9n0qAhSKwyy07pHNvXhU/CxSKpizC+AMDDlaU0Eq6opWI1R2Fh8nWWmJZ0gZB8dmZ0Ug9ea9H+7g2phcWwYih6Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5627

The Altera Agilex 7 Root Port (RP) defaults its Device Control
(DEVCTL) register's MPS setting to 128 bytes upon power-on.
When the kernel's PCIe core enumerates the bus (using the default
PCIE_BUS_DEFAULT policy), it observes this 128-byte current setting
and limits all downstream Endpoints to 128 bytes.
This occurs even if both the RP and the Endpoint support a higher MPSS
(e.g., 256 or 512 bytes), resulting in sub-optimal DMA performance.

This patch fixes the issue by reading the RP's actual MPSS from its
Device Capability (DEVCAP) register and writing this value into the
DEVCTL register, overriding the 128-byte default value.
As this fix is called in driver's probe function before the PCI bus
is scanned, it ensures that when the kernel's PCI core enumerates the
downstream port, it reads the correct, maximum-supported MPS from the
RP's DEVCTL and can negotiate the optimal MPS for the Endpoint.

Signed-off-by: Mahesh Vaidya <mahesh.vaidya@altera.com>
Signed-off-by: Subhransu S. Prusty <subhransu.sekhar.prusty@altera.com>
---
 drivers/pci/controller/pcie-altera.c | 38 ++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/pci/controller/pcie-altera.c b/drivers/pci/controller/pcie-altera.c
index 3dbb7adc421c..4e23df9f5d7c 100644
--- a/drivers/pci/controller/pcie-altera.c
+++ b/drivers/pci/controller/pcie-altera.c
@@ -783,6 +783,38 @@ static void altera_pcie_retrain(struct altera_pcie *pcie)
 	}
 }
 
+/**
+ * altera_pcie_set_mps_to_mpss - Set RP MPS to its maximum supported value
+ * @pcie: Altera PCIe controller instance
+ *
+ * The Max Payload Size (MPS) in the Device Control (DEVCTL) register of
+ * the PCIe root port defaults to 128 bytes. This must be updated to the
+ * Max Payload Size Supported (MPSS) value of the Device Capabilities
+ * (DEVCAP) register, before the bus is scanned otherwise the kernel will
+ * limit all downstream devices to negotiate to 128 bytes.
+ *
+ * We cannot use pcie_set_mps() here, as this logic must run
+ * before the RP's pci_dev is created and the bus is enumerated.
+ */
+static void altera_pcie_set_mps_to_mpss(struct altera_pcie *pcie)
+{
+	u16 devcap, devctl;
+
+	altera_read_cap_word(pcie, pcie->root_bus_nr, RP_DEVFN, PCI_EXP_DEVCAP,
+			     &devcap);
+	altera_read_cap_word(pcie, pcie->root_bus_nr, RP_DEVFN, PCI_EXP_DEVCTL,
+			     &devctl);
+
+	/* Clear MPS bits in Device Control register */
+	devctl &= ~PCI_EXP_DEVCTL_PAYLOAD;
+
+	/* Set MPS in Device Control to MPSS from Device Capabilities */
+	devctl |= (devcap & PCI_EXP_DEVCAP_PAYLOAD) << 5;
+
+	altera_write_cap_word(pcie, pcie->root_bus_nr, RP_DEVFN, PCI_EXP_DEVCTL,
+			      devctl);
+}
+
 static int altera_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
 				irq_hw_number_t hwirq)
 {
@@ -1031,6 +1063,12 @@ static int altera_pcie_probe(struct platform_device *pdev)
 		writel(CFG_AER,
 		       pcie->hip_base + pcie->pcie_data->port_conf_offset +
 		       pcie->pcie_data->port_irq_enable_offset);
+
+		/*
+		 * Set RP's MPS value to its MPSS value before bus scan to avoid
+		 * kernel defaulting to 128 bytes.
+		 */
+		altera_pcie_set_mps_to_mpss(pcie);
 	}
 
 	bridge->sysdata = pcie;
-- 
2.34.1


