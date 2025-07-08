Return-Path: <linux-pci+bounces-31668-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 116D4AFC6CC
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 11:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23311482C78
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 09:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745C62C08C8;
	Tue,  8 Jul 2025 09:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jSRafsAc"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010016.outbound.protection.outlook.com [52.101.69.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA582C15B3;
	Tue,  8 Jul 2025 09:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751965969; cv=fail; b=O35FV5+bqcDNvHPiTbNPpaLpg9lri9JJtsSxbejMVv9BNvKY+nonsuo3mRHJV6zhW4WxtLkC19ocjV9rvH/ohxv63MKWtkwCu1faPOPKdNPIi7MCRDwn0tCRNrPvEy/AFZSB+pvIJjObTIGmeq1GYMFW1XZmCN7Ej2yvpKcyBB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751965969; c=relaxed/simple;
	bh=SKL+vwNsJg1pokdHCmVjDyl7Y4ruTKU/CHEevHW2vYo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Lbs8C8p4SEj5cSxf1eUqqtJ0ZeWTm7uHD+R7GXH0w+U6Djp4wUyxUIXJj9sGzt5vnVrbYAM90CGVaMMIfro/qaiBcqSGFqzPqhhiR4RnUefgowbFWDZCXRPvPSKrAlMqyWMUlRC1rHUJ2ypiJiu7L7l5KHM1LphghNB8uDBwuPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jSRafsAc; arc=fail smtp.client-ip=52.101.69.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W/Vy/G41VCyIr8qPfZf56oOgXjHp66jmuntZwCWn/yK7h0qLqvrWR8VyqrTYMeMyG/5u358d70jgIqB/TWmpViZpJXASCD9kagITjB65Mr1EtCPbA4G4EheEHwnOBLD0VYT2D2prn6EhrETb84Zfn4cjiV0ROC85Au+WOYJBBjkKkxxXhp6kFNpCxNbOQAW9p0xOlVdyqh+vPrDbJzA0slZchFLFBC+A3b3jcxnB9wsgYpiwNSsqKzX9Ubu4Og9JSsfwx5pWL8EODYBKlchxR3rvuCCF1x3nfsqC++2BVBfvQ3n2AcZ7Vv0qdnRxrEEgR41kKamaEOCM/GsZyf64nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x7ViVnYm7qDRNCwxzKRunHV91pnJPg1KJ8Q8P/09Yyw=;
 b=vxrIEUKDtu5AebTA+17efR6RojDL4hMkdNk8KVJ6/sQ/7/QZvNdpYj47GbTzMuyvzrN16trkyOua4wiP7QdYZrcrqko4cmm27KhN/Zp9AgPWBWjxbskwUlWOgzsrxKWeJrhP55qAEkcsuDl8JKdcMPyhmveHRo4hQFAAZR4KAWnjFvxQOgFcErofd1PtMNc48J3kbwyCW9X667VqDxlzK54faUIxXe70IzQmu+Rav2fCz8WlNwrgyN8rMa/XG9jnP4ySPhd1esQED6ED+FTT8qCZxJHCkaEOKC3urBQVRInIvLdCKARm5SssSVVJMYSWBGgeQttrCFRLnHWFw5CodA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x7ViVnYm7qDRNCwxzKRunHV91pnJPg1KJ8Q8P/09Yyw=;
 b=jSRafsAcsDaK9WrPgEMvf6PkLdqBGmA4HODV2Cs9jrS0ysgs6YDQ8C2RELVFI2mUQ4/bJYuAYGmSvfva2n2zqpsTwxl0N7vlYXQfL3Zv4HwidECw7kUdkx+c9JxnO1DIa7bUDmtjP0cmEXrNLoY14OCtAS2WZENdV47MbOdwVKVwrcMr1RcTo7bLXkeGjaX1erH9M1crJgtiBB5/cst1vHNeCX/J5OiCNGCyIqzcKzN11Ur9BnhSp0pQUxF2YKsHjpMbTF9XftvjDbQnSJ9NUsTeG71WvRCjWNtRJv/Qns3RCFumY5SO0K/kEAshs16oLcNOsg69vyR5CGYkpeyJUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by DUZPR04MB9984.eurprd04.prod.outlook.com (2603:10a6:10:4dd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.23; Tue, 8 Jul
 2025 09:12:45 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 09:12:45 +0000
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
	Richard Zhu <hongxing.zhu@nxp.com>,
	stable@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v3 2/2] PCI: imx6: Correct the epc_features of IMX8MM_EP and IMX8MP_EP
Date: Tue,  8 Jul 2025 17:10:03 +0800
Message-Id: <20250708091003.2582846-3-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250708091003.2582846-1-hongxing.zhu@nxp.com>
References: <20250708091003.2582846-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXP287CA0005.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::16) To AS8PR04MB8676.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|DUZPR04MB9984:EE_
X-MS-Office365-Filtering-Correlation-Id: e5011eb6-d924-4983-5a90-08ddbdff99a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|7416014|19092799006|1800799024|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?m+xKMkWUpNfpAAArIzSJ5HDdqCPBq6ZrzCrQmFX31GyH3xXAqfM4OvU66/jQ?=
 =?us-ascii?Q?/xr6twQSuRhY99XSoYLffd7BVwDNdpIOAKxkDQkDFYQbhgHFUYi8/eq4haUn?=
 =?us-ascii?Q?J9G6//gWU+ySTW4wvaK7B0yAgMaRe2fPuAaJFPrIELrvRB3DyTzl3Hh8gDY8?=
 =?us-ascii?Q?YoplzDL6OOBxveVxAGPAPK5gzD+/+ocMi6YwGHPlx/stJmq4J1SK7UevXBgy?=
 =?us-ascii?Q?UuOzB4E3x36We4hx1zmGGg3f4l8R/ChV3GIb5Ryvq/iKYnE4gj2D5V/KYu26?=
 =?us-ascii?Q?SXsLWxRReav+HmUtiIWrii/XNtbhMQ/HI4VBLGEJltHkmEwgusZvkOSZbkFy?=
 =?us-ascii?Q?6ooCZJ2GGsAK9xn2ie3iO/vR/aIzqbf67QreWdxSIkZNIOdQpSQj3rUyr/Z+?=
 =?us-ascii?Q?fhiLwQ+AInpcV1n2PGTscEZCvt9UYPToI4hmo631QQOk3dh+n112swPSpv9T?=
 =?us-ascii?Q?Ae+1hfLV6gIe3FIy3fbI9behi84lEd/uPH4KsuTcAIaKRiiDLQZZJ8mc98bm?=
 =?us-ascii?Q?32pQGIsoBJYj+1fHyvi/7Lesdvbt061cdYfGQ052Qf2REJybx5qw6v/4XvK+?=
 =?us-ascii?Q?kmTyQboSQcjhR7k6RlFH5ef5uBt3eo/1oYYIJWn88PDU2RVCbUz54giyVNKs?=
 =?us-ascii?Q?V3q1uJ9aQXNhANdCzOO5IA4mNVik9Jld2G0/UkZvDwSsxLEYmaaAtQjDdzIr?=
 =?us-ascii?Q?L6JRtaznKq2Lqq8u6ejcAXJzOQ6OSr8uITz9jMkVzTCV95rhThr37KbSzNIs?=
 =?us-ascii?Q?iz6gk6QtGWSZKI5gA+p8LeLtyUyGMIxbrNDkcxhhko7qsbp/zdNK00WdRs3N?=
 =?us-ascii?Q?kNDlez5WHGBLPtIxp+MfPD3BTdDp1BBqGNSa3HyhQvj3i0Ew9HpSfrnECaB3?=
 =?us-ascii?Q?QuaZEDhGswOQTzNxqACRX/itsodoitWU/EYn0tZ+SWIg8aGGGdSUAi97P534?=
 =?us-ascii?Q?Qxz0F2OnezTWQNA6t3pq8vbvhDLKkOmlVML+EMNZOY+PCppaNYBrNMcXovwo?=
 =?us-ascii?Q?/18H9Bn0itz0x3gJHJUiRCHpPXk42ZkkxRDPVtdO0qoSy1biFinfc6QutVMq?=
 =?us-ascii?Q?/dJ5Zwx5a663pyTpwixfEXYMi6IyN8LnGVfAo3w/iF6X+KGjFeiDFoJG2Sfh?=
 =?us-ascii?Q?t1cBCRqiWwqKbO19/3ftN+I3s2/q19WB8vOmmYPxalI9v7v1/Wu9yUCFcIdQ?=
 =?us-ascii?Q?xGxUMtXR1IMYEz9ASk3YNvu5I2abFNPlP1OuiRFE+cwbonr8CLtXQGYSiVM9?=
 =?us-ascii?Q?L/wXhrHGF2hNviabSd1OjkB5fWwoMcDmnkGKVqrE6ErPpHVaYcv419zWjYiW?=
 =?us-ascii?Q?UQx3O3aPNhUi5jtzw5zAxTCMN67EZvxYKX3tNRg4R+okBI8eJJO87uSQp342?=
 =?us-ascii?Q?FxRwBO2xFAR7oVUUCUs4bzbDl3XWWDoiNfSVegv3wQYe9Xn7/DTAFxJYFWZY?=
 =?us-ascii?Q?BbiEKHKA3xGQYXqMQeQpz5tbbYUnj1uv7Qc7YUqNUTlEdu2xpid03t0pmtcy?=
 =?us-ascii?Q?19gpK47HAjPAWWg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(19092799006)(1800799024)(376014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9rodNuBwvBTXKCaiugUgNO6v2R8lu0q1ewBb2hPi5DXmDS1x/YmnwC19FF/k?=
 =?us-ascii?Q?P/sQ1+EV5TFVsi/Lo3/VWLB4sRtgreS/vhmkhyGgRKHAXEbewZq14YVivZop?=
 =?us-ascii?Q?jaZAklPgHQmliJ1W/I0EaClLzpdzNJW2ScbuKRypQ5f/+E53CGXluy1mrdLp?=
 =?us-ascii?Q?/yHdrsCLOYpFuybzVHcLDd0DdQInGmumBeyuIoEpMY2vX4ru3SnAUhtH8CTb?=
 =?us-ascii?Q?QEHCBLcBNXB8bABu6xxqG8/4nZ8PuwFmRIJ8yOnGiJ5HVjiWuKKXPe++RpSK?=
 =?us-ascii?Q?jq2+u64Ij2sFRZR+Or4+FsSlCiuY8pir7FBCRTYs+9f8VP0Ik/Xy+FcfUByT?=
 =?us-ascii?Q?ZozpriYnelKI8NNfl3UA4uRFy3CreuGn8krozLOxXqnXyjTL57pzXaKirezv?=
 =?us-ascii?Q?djDcUMuKVcdJz403tBfV8rd2IUlzw+GqWwuNPiELv+P1j7TFhJzCH2z5Es5u?=
 =?us-ascii?Q?whX0rzKhvqxlsKO6JraUyBg8O1WftDuIh/ZOu+xCmQKeO0WwM/OdtGZmVkxx?=
 =?us-ascii?Q?qVAs/1C1T3asic1shVa7ae6oWqYEHfQBv2/H/9W9pls3TjukMsPrmNeWiVNh?=
 =?us-ascii?Q?ybkfvnL/RsD8cip7ByJ1SeDhoW1x7Qcp0S8DAAzLw6ZhbuhOkeBowmzXIgM/?=
 =?us-ascii?Q?Ay9VQiE0cGFp5/LEsiOvmFSdt8xk64Il4QrgDS+/sfegwzKPTWbRKm6yE8lI?=
 =?us-ascii?Q?DrVuMk4QM/yvEjx1et3PnjoIGVklgHp6hX8TqTNQzE3Sd/OTw2Fn3KgWPVLj?=
 =?us-ascii?Q?aiIIipKZFm0m8z1nzHT9ezuH7hv/2xLK06iH7Nv9wFZNgDVYP6fbJAgtsc9I?=
 =?us-ascii?Q?qCKtn7+BGUuzSI/MYI0POHfqQH5ygAA5G2UMAaGbZ7reJLUNz4y0AsJ6y4SV?=
 =?us-ascii?Q?73P92gUozizyr+Ew+ZoZ7pN3ms5v3ThkHT3yVScfNnhyf1ZuXPKtFA0kQLjw?=
 =?us-ascii?Q?7XaekZ1pRyonpg2L91nG2jtOEtvJ3WDR4H9t4zmu6KMw1U1WSCQZ0qar/sDa?=
 =?us-ascii?Q?W24sH1If4NrfMmO80Puhhx24WovrCxa4VsDNq61W/Rn+XuIyp3pOq7wnMyPw?=
 =?us-ascii?Q?51o1qtonEYBblPEj2dGNDIPd6VOfz371iCsrWMg/gzo1xrfq/nOZTedmBuLi?=
 =?us-ascii?Q?t1gCbFnP90VTzWehr8jJGH8g/2Q17gzdjBlJJXJUwk4NmJ6uM4MGMUbQMNXN?=
 =?us-ascii?Q?MJyPZgPBjlWaZTdL/kWMuJbJbrAlC6KV7xiR3gecCkQWjcONjR8/ug0GEQ2s?=
 =?us-ascii?Q?FzkU50k5kO1gHn4ZHy5ByKRiUTyWxYHv4djNDWYlBVACpaJh+BMzJ1TTJ42D?=
 =?us-ascii?Q?4sPjSt1ungZnYbTDocm8aJl/+bazMTPOgcgv/pOsxdLNdwMklLT3LBt29ZZr?=
 =?us-ascii?Q?Ux7gVi0WRNRy9liDM8gArCr7i0nL0DcVmoWBY/WKr5o6eeSLXPiBUyyl0vmx?=
 =?us-ascii?Q?PjgdkaiyC9IzJTzu9gU1k9jOrnChzfEweDYyLz7Jp8n4R6ofIK92TJM32+f6?=
 =?us-ascii?Q?qW+JQdswONNnykCFxQrhWLPCET+wZbHbtglRTNOxgVS8dobpB2KmAMS5OIaN?=
 =?us-ascii?Q?+LTPd7src7E18cHogGgKkQHPR02zR1BomThPOqZu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5011eb6-d924-4983-5a90-08ddbdff99a2
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 09:12:45.1447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y56IIL5a8GR41snlzgw6Tu3ADrM0+sIq1b/cswX0wnWW0fG/TdRUmlzzgfObklm9OkMtGaRfL6j32pKts1A73A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9984

For IMX8MM_EP and IMX8MP_EP, add fixed 256-byte BAR 4 and reserved BAR 5
in imx8m_pcie_epc_features.

Fixes: 75c2f26da03f ("PCI: imx6: Add i.MX PCIe EP mode support")
Cc: stable@vger.kernel.org
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 7d15bcb7c107..9754cc6e09b9 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1385,6 +1385,8 @@ static const struct pci_epc_features imx8m_pcie_epc_features = {
 	.msix_capable = false,
 	.bar[BAR_1] = { .type = BAR_RESERVED, },
 	.bar[BAR_3] = { .type = BAR_RESERVED, },
+	.bar[BAR_4] = { .type = BAR_FIXED, .fixed_size = SZ_256, },
+	.bar[BAR_5] = { .type = BAR_RESERVED, },
 	.align = SZ_64K,
 };
 
-- 
2.37.1


