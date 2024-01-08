Return-Path: <linux-pci+bounces-1826-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CCE782723B
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 16:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F04481F231F4
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 15:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FAA4C3DC;
	Mon,  8 Jan 2024 15:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ILHNkF9e"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2066.outbound.protection.outlook.com [40.107.105.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B844C3A0;
	Mon,  8 Jan 2024 15:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iJUPk/1Aa6dhsDWs7a+dsgNQBfrilEm+nY/T25PBo+NNM4N8m6Ig2+jSQT4Xfpd5haUr8AkKDMcMRp6azHDBN4T4bcKjVPxkv47hAmNxrZKRoZ9z5E0AD19SSve6celivawyiwdyMMQKpCDYbTYdDcmQevehRfbraob6aGynDddGmspwlJ7vi1hN4wl5i+pBuFiOZopgR5+fmUSZAWyhUl6NWpw3oLJxBF+wYV19s8PFqBtWkH3v7qmjUoHzIkoBTJ10EfPlOXjZnDWHOgeVI0M0X7FFTGr0mkWCOl2dXJ2giAWHOsoJB8UOuA/hCLSo9+nokpb79ULWqYjxY29bDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bUMtzAziPx8enJm9oMRjcW5Rx3lxQvoSqY1piafrRvw=;
 b=SmoLxQu/gtyjtU+xtEXRbO68LyaSGm3CVGBertFu6w0PnysYoQ2HVwrjhd1mS2RqJz1ObPj/CEJhJnqSUNL8FTrncIwO+ZHZFR3CXy45t5p0nkrIHsESn7V70lu2EsAl8LBE3QUsDgeYllOw3MQvmzG7o4gKYWxBwEyVgDUeWwBi6c6Qob/ymhuIzbMizVpxJ8kbmvjlg+hLjRyDpBdxT3KZo/OH5aYyJUt7uT0kADYDtCbODST+1PI0IlgaaLnhCamtqRmJp/yVb9HzWnkIPn/u0HyQDJAPEjFiPGwravaYRwpN6fhfbujOks0Jc70i/2edhydCXVAUDFe7vsWiWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bUMtzAziPx8enJm9oMRjcW5Rx3lxQvoSqY1piafrRvw=;
 b=ILHNkF9ePnbq0a1MocSa/BAHDslqZzFBsd/tF2zlXGfXgmaTmVJF2o0gUXVwnh9qc6T8sCb9CwiuUbgXubruppNlUCUkhIE4yUdxteyQPdpEJ8zLqzaC5b87YQCVBaVPg/reUcclnzUKt6C3xNFjdy9HjM1kNuLprB3GkRnFqfA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB7511.eurprd04.prod.outlook.com (2603:10a6:20b:23f::5)
 by PAXPR04MB8670.eurprd04.prod.outlook.com (2603:10a6:102:21d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 15:10:35 +0000
Received: from AS8PR04MB7511.eurprd04.prod.outlook.com
 ([fe80::8ee3:bac5:a2da:d469]) by AS8PR04MB7511.eurprd04.prod.outlook.com
 ([fe80::8ee3:bac5:a2da:d469%4]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 15:10:35 +0000
From: Frank Li <Frank.Li@nxp.com>
To: mani@kernel.org
Cc: Frank.Li@nxp.com,
	allenbh@gmail.com,
	bhelgaas@google.com,
	dave.jiang@intel.com,
	imx@lists.linux.dev,
	jdmason@kudzu.us,
	kishon@kernel.org,
	kw@linux.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	lpieralisi@kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH v4 1/1] PCI: endpoint: pci-epf-vntb: Fix transfer failure for fixed size BARs
Date: Mon,  8 Jan 2024 10:10:15 -0500
Message-Id: <20240108151015.2030469-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0030.prod.exchangelabs.com (2603:10b6:a02:80::43)
 To AS8PR04MB7511.eurprd04.prod.outlook.com (2603:10a6:20b:23f::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB7511:EE_|PAXPR04MB8670:EE_
X-MS-Office365-Filtering-Correlation-Id: 3809a201-9dee-43c2-5462-08dc105bf71b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ni85qfTGfq23L+OL+jllSdgy5p1WuYVHgdTOfKPxlVY2n+/YbRK7Hd4sbmZC5ozTN26gO/MHjz6vp/GREvbLSQPW+3LVJWZ8Dpw9Hm77qZsXX1URQDF0/xWZrM5uLeWmYzysHxipsOM4d/FJlZzOto4kReIVAHvT4rhRLwxu/DelmSw+GPsTLWOHarDQekyxikflKS4xASrGAgxiZXwRZBe1IqFQSvPapoMJityh+VhE8u6s4wGklazd7v50EDouHC1Di4qRnCkwHcjgnyxreFVQm2D+4dxmY86tCjsAH3q636WrE8P7IsMCsUNF0bz+PO33ZD2nWkjTFTA3Gk8zwjJThVW03qlj7LvR0fIICop/Zqvy4jtfWrTADGQcrDElaG3FCeftDzaAVEdSjSVrR75T68P9h0KmGKk3bkqMNC6qysR6cXVr4F3VwB46GEyODaaOM1lKvEB6q7eZ2HYcQlPkm2a5jMrdSVkgG19tEAova6Zil0O0eRXhFk1rmYtXGZ8z9106bwqZGCPVYiF2fQu0UPvg2nLa4DOfTKTsTP/4MxrXiks4ax+NSuzyG3TurCwZsqZ2ZiqNH+sx0EX2gV8hQvbMtwRy3o+DdKi1TYxdBSsxq2qKR9KE27c2TaHA
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB7511.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(346002)(136003)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(6506007)(1076003)(52116002)(2616005)(6666004)(6512007)(478600001)(26005)(6486002)(38100700002)(86362001)(38350700005)(36756003)(2906002)(7416002)(41300700001)(5660300002)(83380400001)(66476007)(66946007)(6916009)(316002)(4326008)(8676002)(8936002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6uCIz6vtVOEfdEno3xMOPbO6gLZ/iQsdDt2X/+0yEExWZAKvlUoFOcfliyL0?=
 =?us-ascii?Q?V+bO3W5O4BTHSvcBGykVruUJz6cgAiB3pmIHwRcNDQneEuKdLzmVCT3p4xf1?=
 =?us-ascii?Q?EPvVOB6oUv4lvV3D6SIcaSsRpVm3ud4nrft51G0HHGVih/QApMkSEx/DY0Pb?=
 =?us-ascii?Q?q/n+zXnO19lHXGZD8QGi2keNp9T3lYoOwWgWpl2J0qz7OZkO2g8CSERSd4Sf?=
 =?us-ascii?Q?dFUrqvwNhYRcjOPUriEWvOHKK77JzSyt8cRLWLWa9CPsqTZv344Ka+VOYkxI?=
 =?us-ascii?Q?JKwu5PAMbxRe09kCZVSEGlQKabf+SlHnw7MrfGgDxwTZSvHUOqdkeRJMHcVg?=
 =?us-ascii?Q?GCrReDOk/n0mdMzJy4oUNrTyatJYsYmkTwwY4ont3nfHwHjzEW41ezm3A0iR?=
 =?us-ascii?Q?HwYITKO2yIWyLXVZVO0Q59o3lnuIz5Hiw+MqoEGeH05hG/z8MtjZPuxCnp65?=
 =?us-ascii?Q?ca7Hh8dEya4IKbDKv8UoR0amR69FRxTufNO5/BdMTq2JYTVGrLpHY1hOTn+4?=
 =?us-ascii?Q?n4B6jnhoq2WKCQMY/2afn4AWN/hwnDLOmA2bQoJbEl1LDAWxP/7Ry2rBJcMM?=
 =?us-ascii?Q?LEffsSGiVDhpUBd+qoVSidSlEXBEvf7vS0btKTX/gqHa73zJeNPn37IRal9r?=
 =?us-ascii?Q?tCslt8yGJNpT/1uMMO2ox4chiNxmikyLFOZjGWxYnNV1hoYd9KMFuKTWrVir?=
 =?us-ascii?Q?SKHCW4UyYRnBmT8XEzUWl3nQKYOKQuGmrcHF2ckYaNLJmPQmPLgHNyp1evrn?=
 =?us-ascii?Q?8Lrg0a1uwRzN5uLN3h/eSuC7U6twm3NiHXbJXykFyD8R9meUBJ6acgn06jwr?=
 =?us-ascii?Q?AdUy30igie2RE2gfz7knJ4L7Y7r7e+eoP7eVB8SGGsHA4+Oo/Xc8uEoZbtEJ?=
 =?us-ascii?Q?VG8PNTLc05NHZ5tp/RC+lipqOG+x6JrsIswhqESoq8DZVp6Y9jGNhQ/hiOTG?=
 =?us-ascii?Q?qSLxRtddKUm0KQmVIkBzZE6kvs123V1ZxytSJXdnadJOz/kuwyE8UqVgANd8?=
 =?us-ascii?Q?x/TuUCWcA+ryYSPrh9kjUUBYvj+WANT3c2eKCEb+/oDdLprMRoUFb2OsCVgU?=
 =?us-ascii?Q?Oc2HH1IN/Nl5fD8+WnO6RaqCyUK5v8I/9bTJn936Mf8cRh6KRW9gyCCoAij9?=
 =?us-ascii?Q?CtGb5iqWNVFd5srwpJDyUUUNgofscTWrfy/Yl/2vLMd2TOYwwXVIszO2venC?=
 =?us-ascii?Q?n511AcMnHhSRIv+aiEUwaJtmXWA1/S1EXUWVfoMGVZaxdqKxq+Ftq5+1gsoK?=
 =?us-ascii?Q?X4uM58RlElCQ5SpiPK9cuwgGIWx/glxP0zzNATVJAzcCvCF6vhB7eoB/NLzF?=
 =?us-ascii?Q?ppkEFs36Y0pBrFnnJTq5EeW1mC2RqZVOUf5dhx+Yg8EGy+XxeDAAYtE3XH0g?=
 =?us-ascii?Q?T5Ycmh4vx8lwvPze1kMB5zl1mtnzf+crxq4XAdWoQBgg+iLPq/qWGlbR/ofw?=
 =?us-ascii?Q?iry96r9x4jn21aty/OhY9LKxOUk125Qy/Qu3Y1JL3VR1jgwfj+12qbv1sfZp?=
 =?us-ascii?Q?e06O/Pjy3gdpbBMXLPsxRiMhkTkGc5QoeBCH4YFPTz3sPi3f09iItzc313pj?=
 =?us-ascii?Q?2haTu5m7h+EjYIVVLIg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3809a201-9dee-43c2-5462-08dc105bf71b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB7511.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 15:10:35.5436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gP4ANU1DfqUFrh7zlpmufk9L+IqYL4hvV2z0/TxomKfmFLX2TlrHwCtUTnASZi+TEv5I4WwiJMxsyxd+lPZkLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8670

For the inbound MEM/IO TLPs, iATU on the endpoint expects the target
address to be aligned to the size of the BAR. For configurable BARs, there
is no issue because both host and endpoint will know the exact size of the
BAR region. But for fixed size BARs available in some controllers, if the
BAR size advertised by the endpoint is not same as of the actual BAR size
used in the controller, then the MEM/IO TLPs generated by the host will not
be translated properly by the endpoint iATU.

So if the fixed size BARs are available in endpoint controllers, always use
the actual BAR size.

This only fixes doorbell (DB) BAR. A similar fix is needed for memory map
windows(MW) BARs.

Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
Cc: stable@vger.kernel.org
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v3 to v4
    - add notes: fixing the issue only for DB BAR and a similar fix is needed
    for other MW BARs
    - Add Manivannan Sadhasivam's review tag
    
    Change from v2 to v3
    - rework commti message
    - add fixes and cc stable
    - return -ENOMEN when request size > fix bar size
    Change from v1 to v2
    - Remove unnessary set align when fix_bar_size.

 drivers/pci/endpoint/functions/pci-epf-vntb.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 3f60128560ed0..85120978fb8c9 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -550,6 +550,14 @@ static int epf_ntb_db_bar_init(struct epf_ntb *ntb)
 
 	barno = ntb->epf_ntb_bar[BAR_DB];
 
+	if (epc_features->bar_fixed_size[barno]) {
+		if (size > epc_features->bar_fixed_size[barno]) {
+			dev_err(dev, "Fixed BAR%d is too small for doorbell\n", barno);
+			return -ENOMEM;
+		}
+		size = epc_features->bar_fixed_size[barno];
+	}
+
 	mw_addr = pci_epf_alloc_space(ntb->epf, size, barno, align, 0);
 	if (!mw_addr) {
 		dev_err(dev, "Failed to allocate OB address\n");
-- 
2.34.1


