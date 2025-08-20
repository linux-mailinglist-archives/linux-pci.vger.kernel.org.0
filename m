Return-Path: <linux-pci+bounces-34368-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00DCBB2D72C
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 10:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31E711BA6E93
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 08:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8422D979F;
	Wed, 20 Aug 2025 08:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Yj94ecUZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013021.outbound.protection.outlook.com [40.107.44.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767482BE65C;
	Wed, 20 Aug 2025 08:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755679938; cv=fail; b=a9o6gW6oeiLG/ejhQb85WkDf6hyk+7yGWVPLZzJzNY3kSIxpixXskXAbkPMPKMnrFUV+x/Y13JnV67r21F37wI1jIVbXD/SLgjvK6XlWZLRXFlViuqkYph779ca8DwPxhoxy+HA2uW7cTeECB/aDM2yex1KV6Lp/5rdc+dfxw6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755679938; c=relaxed/simple;
	bh=8Nj3BbZUTSUMG6KYzuKkCmb32FbHpyJbc92tZJ3R4uQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=nL0/SGtdITaaUkuxm54ZR+16zGQeFOOiOKGx8usu57ID1xH+hyNZb7HnKalYTGfoi6LOARFZhVdc79kOF2zFlJiRg3nm0uLQbaJOygCPA8tMwjpycHFWM6YtOTiXdw4cHoOSMDsGEb/Tp2/GBr0r0YeuNPodZX8PVtnkSLPc0UM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Yj94ecUZ; arc=fail smtp.client-ip=40.107.44.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=biEeuYmHDcavHCN9Tbbh2Mei3YZgTovLzZ8GTcGCnuSfyzWa/pdldKV6gUeKHC4VtliN9sdLFg4VHMQ05BrhyB6/qthuhSQ8OGoYTNwCJGCtfI08Em79u1UFJohcdkGRPyd5eDMtEHHt/zlB/F405JGJO8om4YnOUhBGbFa5NqU5mPkwqy8Dml4NwLw1RaMWFAe3w1av/5ZatAkEAFn/KU4zxEa3+Nc4++M+IqdbW98b545MOqwuU1cE+Ps7SG8WVJDULnUNSl3sriqWRO7Z23zF1VzKk4KG5NpPxfU2To9DsDP213pIP7qBrU0Xa2N55eoyhYYb1SByDUUT7tDoLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yuFrm6qF0jBjW2aYp/OIEeFfiy7Rv9L83T042sGkExI=;
 b=I0vFfuNzaVcQUMxyFJsI4kVD2m0i4hJIrA9ciy1Du92+urn6+74lpHHSX4awejxy8ppTUDbZTGMpp2ZucwGbQXqGgDCCapZHEamT1LMNlzcQMKrvqaVsFLFLNUkVKXKK4Bx3YMPOWIu8AZDBo7jbOUUfJQj0zvFWeWlFzbLKIz8IM2OWi71ROjf5hMoJbAok2Wm6chqauaTI1NB8V6i1/fwb1HiEZVjUcW+n1BLdYmVuSXghmXeFP4MXYyr4oa18/c0nCu2zG9dqDOC7o12FjtLfETbc2MhuFTKCk/bmQVn+EzOPrqlAD9QlAmPP4Lj31HhZxgFpKneIAZ6VzBVIQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yuFrm6qF0jBjW2aYp/OIEeFfiy7Rv9L83T042sGkExI=;
 b=Yj94ecUZpf8mL1P4KrUA+2930e6ps0dcFI668bjeH16+EEtZeeIf+4eu9j3qI2snjICo9yldS+0+xbXzOPLbFARjtuE6Kebh+6HLStY8B2e0FcUQamBpeJ32Mthx0AERaiEk2tXpdA0pLbs6dOVtatKVpVfnCpqv0oncsuXhLy3jjDeTYzA8qX6LWXGte6tKIezM3onjJZTPENCxiNE6A3odzMew7zz8wpDaru0kn3SZ/5wwIy4X3MXyZFapVNL1w0HWpOaBQYQ9xNgypGG952vrPKR4h/nT2yXAmTb0oelsVk5e0GB89Oza8L2fHrD87oKUtsaGrCv3LySxujpKkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by KL1PR06MB6887.apcprd06.prod.outlook.com (2603:1096:820:114::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 08:52:10 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb%5]) with mapi id 15.20.9052.012; Wed, 20 Aug 2025
 08:52:10 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: daire.mcnamara@microchip.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	bhelgaas@google.com
Cc: robh@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH] PCI: plda: Remove the use of dev_err_probe()
Date: Wed, 20 Aug 2025 16:52:00 +0800
Message-Id: <20250820085200.395578-1-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0156.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:383::20) To KL1PR06MB6020.apcprd06.prod.outlook.com
 (2603:1096:820:d8::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6020:EE_|KL1PR06MB6887:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ee593df-f623-4d8f-69a9-08dddfc6d96f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oGbDoQYoTso8t/RHeIReLK27w8tw/Yg2WL37vUbHY2LtPrCvtl460rh5pFkY?=
 =?us-ascii?Q?75KlgZt2AnHy6RryU7sjWWuqHZmhAhCROU8FEt7ejEmH2GeimOWICFnQObPE?=
 =?us-ascii?Q?CXyIrrpwx3AECoO6Bt8NijHGUzDZ1HyawytuYiLCnUj/h7+dsi+nsjGkqzf5?=
 =?us-ascii?Q?keFyIYc4MR9eQiUjeuSChkQtsVrSpAFUqXw4qnSS0gTllaPJRqXBjyxFDfCx?=
 =?us-ascii?Q?EIRgM6rQ88EKXx/YB+WRkHp5gnj206R1cAMx5Lqk4bROpuiPoV9KKHs8QG6N?=
 =?us-ascii?Q?99V57TuO1DfS2+MY81IFveScL4iwtkYa6wfdMQMdIcovdiKudQxyRcDGS8Nb?=
 =?us-ascii?Q?3tnf8hkrjc+LEfXKZmy4FUPQiM5GuYAK3MVfj0qobtTJwDoWGS3Rl+7UziN6?=
 =?us-ascii?Q?EwoPFUixUoLEHekvC+vIl5G2AP1XSp6QP238BICZ0GgP0Prj6rqIch9vcU+u?=
 =?us-ascii?Q?rGr9VzsvDAXPtOeXoD/fuS+QbA6iyf28ikfwF1+C22zYi0MQsE6Ir0UKghjw?=
 =?us-ascii?Q?6Jd96EdjZD5GXEECOHDk+7yoy8rv66CdtvmQzHTyGGoOwTK47ecdgpp/fsYl?=
 =?us-ascii?Q?PoTnDnggCnPOc5qOXD6aHYGOZPd2cPUkpYeeTw/tzNvk/dGZhY2wJSofdd4/?=
 =?us-ascii?Q?88uykp6kFuJRxfKmzEIyGpW4agULH1bVoBS2WvYpD7ww+wXIVYbL3sZgWNAt?=
 =?us-ascii?Q?5MvMzil957Rxt+GsAsxwTjukwBNZvSqhQzYQz5RPtwsPjGwP9CJyFjS/HoIL?=
 =?us-ascii?Q?GfIeLFGK2gL4y/YjrIAhH2WK24y0Q5KmhAY7JoFRlRVn479beBJ5FKyF2j2b?=
 =?us-ascii?Q?0fVcjCSgJQcNi/wOXHLg0hoR0TcZ52DRJoXVSwIx6haBhsFbbtztfwFGrdag?=
 =?us-ascii?Q?d/4PcsBUV2ccF1tACShzmMPFoILuw4Elf3ZoLtGGWq1po8iM4jAv/2lBqKvK?=
 =?us-ascii?Q?75kB6tmVn5EZbwYmkKYFBxsDK6fan3g0/m2MMeBcSIZcLPCOl8vMpQ4JKDWB?=
 =?us-ascii?Q?0bWzeK37XEvnmnuFk7OMjo2C/YCT9g5DL/bBs2vdRS8TcOnD6QVJFgE8KsSk?=
 =?us-ascii?Q?PF+SDV31725svU7ywoCtUWsS83rkTvvpHUj9oivNOibQKUA2JllpUJaXgnaX?=
 =?us-ascii?Q?sqx18YDPLRBhCvwAo0trSs2Zms6VbKHksnCp2atlrI86jz54zU/ZnLo060uM?=
 =?us-ascii?Q?xl/MyQLsoNjJiooOcz3STwRACpYSNW06UOJQvWdC8sUxggZ+kawDa4tvzVZK?=
 =?us-ascii?Q?FuEriH2ENo1hfyyXg26Z6gsT/yLGFDUUQiSH2Ns/0paK6aMpYm0uxeLHrH0P?=
 =?us-ascii?Q?rkkwqzkCVBkS8aiv/cXxiYHIMq3w4Kub1VcmXuuAS+UMPWi6Qatq2gJzrFmX?=
 =?us-ascii?Q?mrax30xxIgqYH98eDUkz/NWS76bZYaSs0FYODgDNG2Qe92Lubpcge/mhjC0g?=
 =?us-ascii?Q?cqfLjjzx1R9RDPqEvCy7AV7cGT2EOg61EWO6KjceSImraCo9O0odNg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1x/d83iNDoeltr1WM5NBuxK5+zSfOy7GSneTLp2NI3T8tO5XZ/qFMz0rK4AP?=
 =?us-ascii?Q?AN5pbkkK3lb6qDhL49+Tk2LOcTvS3L+B6pDU5A4XXISXAobfTCEind4Mo2zU?=
 =?us-ascii?Q?kiC6S0FePQm5GYgC/70wRJo1yBy0XoooIsVJiLhpu3rwRtIuq2IsEtlL+Uuq?=
 =?us-ascii?Q?chZaNSXIB3H+31Bs3IzfJAm7DZohoxBhYpTnNP4iR97XSKlRcQdmhgCfavul?=
 =?us-ascii?Q?P0+rsocM0qudr1XRAaBqV3bS/012tV9pDDIE/nouIrtclwHHvAy2CI5eKhQi?=
 =?us-ascii?Q?tz7OmWYfhMswS6h4A/ZtwPO1SU3nglRIM1KNNS4FAnbh7qERtx1hr7FJsSb+?=
 =?us-ascii?Q?p4Boj0uMLXiDHIY77pdutWXDYzf0sJek0Pij2VIfwBbTv028AxBfyRcI1K3+?=
 =?us-ascii?Q?YD9UdXa9R5y7by4vKCI+WOkoIbr56YRlPEraUG93/18lEez/TWjrikb2uem4?=
 =?us-ascii?Q?//eeYsbI8cbsBuCby/ggHWG7H2QikJwyW/JuBJ+ZVxd94B5TWwzYSnpv34So?=
 =?us-ascii?Q?X/0JQS2UgXi2CwJqwsghF/1n4A6RCu6qEIQmgytDVBqVzC0utm7jIEcgHYJ5?=
 =?us-ascii?Q?QnyRnPRGcp9qAfL5kRJmi3Mr/W1rNL8yPz+fvRuJ7NBslnpyZKYufVoeeV/U?=
 =?us-ascii?Q?RaNlVeaoWyiIlk/DtSXJFgBKwxNdF1wUF6rUtr1oYp3j2uXWnxPcElTJo+3y?=
 =?us-ascii?Q?wA1EG7YGr9s9HKDlVzkCfKkCmeuIW/QN6bA6843Xck0w5nce3eg8OfdTdUDD?=
 =?us-ascii?Q?Ex6oUYrXeU2lp007xQJ79q+IV2s9TGITcxlRTHYxvhGYOoGIBqGwk++E6n35?=
 =?us-ascii?Q?dmPQ95hY6Z1ZDJvUMl5u7KHoEl6iqEofn9BZmx8qTW5SDgAGYsP0OxfvybMy?=
 =?us-ascii?Q?tfRPy1jCJ185PQAirWMNR0E69HK06ytXmuUnQTN4KdlO+G7RiTNLy2a0YGR2?=
 =?us-ascii?Q?OL5zyNQEnzAohofk7/KYBPLw9BSsNm2f0EdkGr+TKE8fw4l+DFUbfpWunnre?=
 =?us-ascii?Q?76LMG43acza6rCc5veqaCD5mxxOdP5ASVnJ3vjEoJ01uU8pqcySCIhtyRw2L?=
 =?us-ascii?Q?Yy3OoGmF5/P9Bzumd3jQgHm57DTnS+v6Tuks4EXHVk1snzwgAULo2InwPfCL?=
 =?us-ascii?Q?QBBQBurn3uuAWBJaQawFB9kQPyvK6AqEcMjFb0cYRadmOKdrT7Vx5xGfiQl6?=
 =?us-ascii?Q?Z3UQQHa5KRNmKPhgv4ONcFYGrxG4FQiZZMfIgiAbA8lgB4ekM0svQwLlfc8k?=
 =?us-ascii?Q?HZZDkarF9R/XTzuPP3KDfXcJ1y2gkh92bmK99iis97EtICNY/TFMegzCHVyZ?=
 =?us-ascii?Q?Q1pA/KEAnxeVrsEVPaOxCV84/S2+85SULtLUBg7Ym2+DCpWj4jFupOmqk9QH?=
 =?us-ascii?Q?5XmhCq55w1pidjd50nPF6JfLKo0r4Ij/TXFvy7R3xP5Ddt+PZWcCdB0t5vtT?=
 =?us-ascii?Q?fssySRHYeMHGXabJYdjzY9FwuWav7MaJHpVje8eFVCu9oAceWM2fixnrUEa3?=
 =?us-ascii?Q?duMq6suFO7qAUQUiokLq/+Zmy2OmBxCtnTfYdhGh7OmbeLNstzU15BTJzgNd?=
 =?us-ascii?Q?xLSiHsGjRPJTXOSz1kdJ7/0oYVhodciADoH5OwpI?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ee593df-f623-4d8f-69a9-08dddfc6d96f
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 08:52:10.3293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LBWWK/6quYDgfsdoX5IdLZ78+Xw9dWtCVjxTA3XyjYOR976xKj2tcY6RXYywcR1VQIaWppGpvwWlcJgJvNtJHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6887

The dev_err_probe() doesn't do anything when error is '-ENOMEM'.
Therefore, remove the useless call to dev_err_probe(), and just
return the value instead.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 drivers/pci/controller/plda/pcie-plda-host.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/controller/plda/pcie-plda-host.c b/drivers/pci/controller/plda/pcie-plda-host.c
index 8e2db2e5b64b..3c2f68383010 100644
--- a/drivers/pci/controller/plda/pcie-plda-host.c
+++ b/drivers/pci/controller/plda/pcie-plda-host.c
@@ -599,8 +599,7 @@ int plda_pcie_host_init(struct plda_pcie_rp *port, struct pci_ops *ops,
 
 	bridge = devm_pci_alloc_host_bridge(dev, 0);
 	if (!bridge)
-		return dev_err_probe(dev, -ENOMEM,
-				     "failed to alloc bridge\n");
+		return -ENOMEM;
 
 	if (port->host_ops && port->host_ops->host_init) {
 		ret = port->host_ops->host_init(port);
-- 
2.34.1


