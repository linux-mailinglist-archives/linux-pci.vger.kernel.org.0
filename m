Return-Path: <linux-pci+bounces-25464-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 450DEA7F2F2
	for <lists+linux-pci@lfdr.de>; Tue,  8 Apr 2025 05:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6189E3B180E
	for <lists+linux-pci@lfdr.de>; Tue,  8 Apr 2025 03:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426506AD3;
	Tue,  8 Apr 2025 03:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CqY1Pdpg"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013064.outbound.protection.outlook.com [52.101.67.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4340825334F;
	Tue,  8 Apr 2025 03:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744081256; cv=fail; b=Xw8zl9cLjf+aduIrzJ8iLMpte5WnezYp9sF0ezjamAsoG77TVVYhC4jyTNP8ghG0CQO7BI5+refb2oXG1RdQypFJf1lRueqXu4PvbSr2VSXYsVZKECX2ot0LYHPXzdgDfuTOvqjZdIxd5afR2UI3rdkiobkL94jCOoQbXMMhZAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744081256; c=relaxed/simple;
	bh=oJWA+i4fF+6AYxkePJspziApJJBAkxWdrGjtHhVExAY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=caFgS/4duflvD4UPo//dskXd3VxXA9wwg8P3YBB0oiuRqJcwp301wJ8vyfcpZ1A6+2iHP8IVRQUQ2Qpr80VsXfHeLZoSZ9t3WFPW0CQosfMDKqRjuamaV7YACKgTqdW5QDFae/bxHq+2Qh1pTZ6dvFY/CT/7Bfm5hhnnDDTjTr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CqY1Pdpg; arc=fail smtp.client-ip=52.101.67.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xXO3hLzTcUFGWyZrNCXRGHxJ+rXmYG9bFoDeQpUFcuxJzQz2NIk9UpvHqEaKsj1A+AbbehyyiBM6JFRRqUUrXPiAdEAucPaAAGaKtltyF+mbeCnurWRnjVpD+O2xivbMiixMsSbzom5NPJdNttNRzsnbMBKZv+dOiMYYhJSCaI1Bx3+lWs9gJq9H/gNWEFfAXfw6UhfdrgOf75b+6djzX3MgHiHge/IGOz1B14enTkcEGSYFm4XpwSNvF/sjyGjsGJeDXSbkXcMPoHVq10wNdmIrGmYD+rTbH5rCHbyWv701IO2+sW5UKV1whzezyfEMC07jWbHUup5ljcs0qrevSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yoXNAFWqFI1gRUevXYIY4OpxF/6Ydw+prLcu1kd5jJk=;
 b=NwCHcij5BM4Y4lkyRnTUp3HUugEItm3qkJobK5Y7rU+cl3Xo2dP5vHhJum0BqbIoL0jt/EDvSq0zztGy3ZL25caNYmOiSj2uYyC1JqXf9taHqCzT0VJqSDu+R7isszCKPsJd49IQhmOrYz2RniavAEV9L23cdqv0MYLyY8hGf+UT9VhgyrONgPlJnJP8j663FyPTKw7kd7SA0zAgkm2sB6QW3Ey/mzbPyxHTQhLQho2hR72rcSQr0x51JDGHCwnEHEj45Fb6mWQB1+Y7Z30c1yoOlLL7A5iNyukzEmqc2YdrIhfw/UA7r0ZX816QLZrv2ab+mGmq4si9/qZIzL8VMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yoXNAFWqFI1gRUevXYIY4OpxF/6Ydw+prLcu1kd5jJk=;
 b=CqY1Pdpgfl2k4X4NlaThVpPbqOkB1LZis9H6F6tRKeQyB4dElWOLP+oG2h3Vo9G+20eJcNddCTpDqXJ6H/1U/Jci5ofBDjg/um81wipjbMe3l93HVuLUdW5wohTxFTf0/M45bLn8ZXi1YPJJLCzC0EZ/mGrmR3CzHwX/BC1xc7n86CqPUOz+fpgouJoPcbcRvzh0mtq5XJDsLe19t/4HZxSIG9w/pA592HHm/YcjytYp+u69beoDcsam/LAnjvAUi0fGTYfrC6udwGKxBcr1Gqgr/zvyAaTthOBNN0U9A909SwY5L0UBiHha2rdj/vyy8AGHV8LyksNb/dFIvHghIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by PA4PR04MB7536.eurprd04.prod.outlook.com (2603:10a6:102:e1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Tue, 8 Apr
 2025 03:00:51 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8606.033; Tue, 8 Apr 2025
 03:00:51 +0000
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/7] Add some enhancements for i.MX95 PCIe
Date: Tue,  8 Apr 2025 10:59:23 +0800
Message-Id: <20250408025930.1863551-1-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0051.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::20)
 To AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|PA4PR04MB7536:EE_
X-MS-Office365-Filtering-Correlation-Id: 69eb1b92-acdd-4dd7-d552-08dd764991a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VVKVUYDgSv2bWRfEXXd31dyvZReaQf51AyrtpSA3tJVCJK+KDLtk0M+Kn92L?=
 =?us-ascii?Q?PlRBNguUloM56JSdWC917aTFlZbh7kRT/v64Hy6Qqvjm7vOseEQ4Nj9dNneQ?=
 =?us-ascii?Q?cJgz1FoWkmFPmrozoQr4Sjwh/npFDaGefJ5xbj7FR/I+5bmbAWIdP2RJk5Ih?=
 =?us-ascii?Q?0peNf6ERbB1Qe+UyclzTQ4VpGI9XpzAn6GEinaaAvbYQg/Yl05YfjOFjOeji?=
 =?us-ascii?Q?3igkAZWWoAqy938C4STcXF4yt7hEPb1jqVQbDY8SKGqjWf0MCFw/px3/K6c3?=
 =?us-ascii?Q?bp5W59ympvz3OUZ+jwj7EZRvfj0byD6g3CUXo4db4apq9rRZ1GEfs5t0ZSdk?=
 =?us-ascii?Q?XdvXgsH5K1ibbLL5J2PrSuKfwcWt7j6qurYTFEcpjC8/o5VI1S+MGTSrGQF4?=
 =?us-ascii?Q?Z+2OEUgsFauqmtn5Ocq6fffYFlTrSYuiqIHC0g1qwBY8Zp0hxEA5x2h1hLo7?=
 =?us-ascii?Q?mCMpsmQ3luhPZUmcY+p5JoMujYILOKopxXm/s8rA+qAAKIj9dUndbtkEqUDv?=
 =?us-ascii?Q?j4pJ8xa38WKHrNmsD/g4GprDywDsBgKrb26JQk8nIg7FwJVnIC8hYJw7aGEb?=
 =?us-ascii?Q?tIimj04dcwDAoXUGXiY0UFAg/oyszSa//0dlEpvTpwSaTeEzsub+SQrYYCG4?=
 =?us-ascii?Q?A9qwUkQ2LtIOwW1GQKOAAroXL9Xx25iKGIDMzBiwLm31vP5OEQ8YOl2/h/ed?=
 =?us-ascii?Q?H54/svJ6JdeEk7vGArNVzMp/1rqis/9g6qzF2fFNYQe1FQ78xBP1v2MrMC/e?=
 =?us-ascii?Q?tCxHKPusX0yI9+Cxo7F1SLy83JlaAtnbnXizjU1kpDsFSjx4tC7Ln2BQMlfm?=
 =?us-ascii?Q?HCOYv3FArJnj4R3172NfkIzhI/C47eKOHssNd9t9YsGRZL7WZ+LHsLIws3xg?=
 =?us-ascii?Q?iy3sxhk3PHiCwIRAAQSP7ARwKzhDcS38HYMETlW5XmQEN8uOnC0ekRX5F6ia?=
 =?us-ascii?Q?g7Moh2uX3Dz3CXHdCPnmguwhoWE+n7lLZYKog7/URmkSztXLgZytbb9LEVB3?=
 =?us-ascii?Q?nGDN6o+nuUj0oTzroQFfVl0a20Z2vTLxNQl/4eelj87heCRyrmShYWaczaaT?=
 =?us-ascii?Q?Jan4B4zt5Tb0wHhKDPAKXafVxadsOu7W4LKUGWMkRcU7gjKzvmR9QRoREuca?=
 =?us-ascii?Q?BT+/61fI90jm+2c4LvFFOv2c6yXXCZiumekIYUbkc02RZT3zIUeXGm4JOu4T?=
 =?us-ascii?Q?ZoPhT0KJc9nVvVozfRs1eD3j6rZzWlS+bM6e+QpEMTiMFEuJqkJycZLAh0jV?=
 =?us-ascii?Q?9iTWmR2xbe8ZjT4Oo+PU2ocqt4VEtwu5qdSLftNVUcWJHZbxH2YfY0aQcJTS?=
 =?us-ascii?Q?5SPh1ya4QuyQe5hJyZ2Disdvtx5F4+MWRit0HGwMqcmAtcOkvEI/mqNYtmD1?=
 =?us-ascii?Q?kG8lC4UNSSoglM1QM5qY/X+AP6Dcjn8epZPkDeBEPLgmW9FICL6um31VFfWw?=
 =?us-ascii?Q?wWl0hjxlztoNthzme1thk2T1hZoMvH/DawyKRl2i4xgznWHdMeiE9g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yUnaA1U7+e2SJl3xqYLuWY7H+VRltFv9ODNRk8phAv/dYmzhtULCOGNYgvx5?=
 =?us-ascii?Q?1QDcMechhcAb05iOPQJUepHAshJfCQEBSGBwNFk5XEQPogXT5rDA3MkkCJtk?=
 =?us-ascii?Q?fUkhsTi91Wuavy3NYy5EYWAXu+IAFWEDJoAKHufMkx0HJ9yjP36sF/wPsoem?=
 =?us-ascii?Q?7P+FcTgKbDl8LARQ2UICm9ClwH7bl1N03KL+LvfnRvbIoZdFsqhuhqz7Cq9K?=
 =?us-ascii?Q?gSUdOCGkwwzxcFMrudU3cbUDkvIXZ4VWJMbhy2lIG4G9MXtqFEaaiJLWlGNF?=
 =?us-ascii?Q?Pzj5Aa5uhgc+eyEQYH9Qy+dLSfujDJxjEnkvzY3uECstttT8hDql9w/ATZVO?=
 =?us-ascii?Q?nJsG7MmBqN+KBvvdlFhszNryqfdOGPYKugtZHZ8gaEpKX+LOBJHtpGcH2gA6?=
 =?us-ascii?Q?/gjX2io/Ht8zpGnCbsaxnof75HtXi8o1xW2n0Yav/5ZneBF0mtSdL3S1OxWk?=
 =?us-ascii?Q?9t9ICwGj+/fkbIxWrDdnnR0ohH1pexzWF/V9fOmlmEj9Q8RSqkFkJjzdLQ/2?=
 =?us-ascii?Q?WoHG/aKGVPFMhj6fEdrhMrFHx7FZxCtDl+LuKDcO+ika6FROmvxNmqdXWL85?=
 =?us-ascii?Q?Q3oxn3fcsSZ2IhunNJ2LlGi5EXH7hqarCgrLFUgtgR2TZhUBtsuYQ88vrcrf?=
 =?us-ascii?Q?TGHlcPFL8DClAAv06QLjNa1Q6Of63HJ6dATDgV7E8yN0CB4+FPf7HpsRcuoi?=
 =?us-ascii?Q?zMhl7jV1uUQ8WmTa6+VWhEbUkbTm5sTBPwcQSAUwA1T6uifv8YZ2CcW9q/hc?=
 =?us-ascii?Q?VoYwEskxCr9qCFsYZ6Z6lVvPMC8wV44e0nyGO9ZjW9xZJ7pl1FtHkHUry7In?=
 =?us-ascii?Q?/hC8fwAuMRimYio4hz4HDVn6cKVCzSmIzE1nvEfR8MJ1NFJPXHZ2oublZXxP?=
 =?us-ascii?Q?arRifPAEIPhzkM9J+bD/Vyq5zOJGhcnf75qSpi2x+ddaMBPWkcL5TxKPauwB?=
 =?us-ascii?Q?RaKOR+roJBa9SIhJMalxmUSs5tDr/2SLAfiqsv/QjKmTVb2/FhcRlQYVwJ+q?=
 =?us-ascii?Q?kYh24b3N83OSUFb67MFQgmZzGNBuF9EWewZUbqatZqkxYli5JnnPdBeWSYQ8?=
 =?us-ascii?Q?tH4EKfsG8tqbq8/YJgGgPXprPGCNR8QI01Srb7t01XjZEUbQrTD/NU5yoLvL?=
 =?us-ascii?Q?k3rkfQuCIatxmuEYuzthmvmF6oJKxJhaUFUdFiRTOAH2jg64GrVkXvPFD9GZ?=
 =?us-ascii?Q?8wWkmBDr8S4aJ0o/6I7GjqiRb+5qCPv9vvKYvIu6GKgecowDAQeoZAtHfZDl?=
 =?us-ascii?Q?0eXHzS9gyl366a7sViKQU/IWJCCxOdR8e5YuTXMsyv+Ysr3+R+7k5tKCvd5J?=
 =?us-ascii?Q?ch7fUsQmqtUYpkbEP0E7SP3sPs+dV0dcM+KdiRjzvuQhBfuK3poqflK4a9MX?=
 =?us-ascii?Q?Ecu8B3cwFmfzVqkZ9tsu87Hzi/E+SZB5kEWQILAkHdLaBRK+5L+Uyq3V/G5L?=
 =?us-ascii?Q?lCI02gaNbKmevLLMdfda+AzuWoCwxugWyeET7JQ177X5L/usRpZ8X8+lNf6f?=
 =?us-ascii?Q?XMkM1Ivkjr0E4aVXG5/RWmDfbAxZPOKkXoxyrI1BnlAn0UmUhUHjMTj+3sXL?=
 =?us-ascii?Q?UkGwC1/gKYDkTnudOZY1wpAWsGSSCIIRyFJT52Oc?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69eb1b92-acdd-4dd7-d552-08dd764991a2
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 03:00:51.1538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HTSr0QdBQunRd/Ss/KmD9k38bneOJmSF3vd9Tvii3DUG02iMj1wsTbQZ+Ctmput7McNoF1Dpj+ZNIWW7FVFvKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7536

v5 changes:
- Rebase to v6.15-rc1
- Update the commit message of "PCI: imx6: Skip one dw_pcie_wait_for_link() in"

v4 changes:
- Add another patch to skip one dw_pcie_wait_for_link() in the workaround link
  training refer to Mani' suggestion.
- Rephrase the comments in "PCI: imx6: Toggle the cold reset for i.MX95 PCIe".
- Correct the error return in "PCI: imx6: Add PLL clock lock check for i.MX95 PCIe".
- Collect and add the Reviewd-by tags.

v3 changes:
- Correct the typo error in first patch, and update the commit message of
  #1 and #6 pathes.
- Use a quirk flag to specify the errata workaround contained in post_init.

v2 changes:
- Correct typo error, and update commit message.
- Replace regmap_update_bits() by regmap_set_bits/regmap_clear_bits.
- Use post_init callback of dw_pcie_host_ops.
- Add one more PLL lock check patch.
- Reformat LUT save and restore functions.

[PATCH v5 1/7] PCI: imx6: Start link directly when workaround is not
[PATCH v5 2/7] PCI: imx6: Skip one dw_pcie_wait_for_link() in
[PATCH v5 3/7] PCI: imx6: Toggle the cold reset for i.MX95 PCIe
[PATCH v5 4/7] PCI: imx6: Workaround i.MX95 PCIe may not exit L23
[PATCH v5 5/7] PCI: imx6: Let i.MX95 PCIe compliance with 8GT/s
[PATCH v5 6/7] PCI: imx6: Add PLL clock lock check for i.MX95 PCIe
[PATCH v5 7/7] PCI: imx6: Save and restore the LUT setting for i.MX95

drivers/pci/controller/dwc/pci-imx6.c | 212 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------------
1 file changed, 179 insertions(+), 33 deletions(-)


