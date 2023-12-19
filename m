Return-Path: <linux-pci+bounces-1156-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2CCB818167
	for <lists+linux-pci@lfdr.de>; Tue, 19 Dec 2023 07:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26A381F23124
	for <lists+linux-pci@lfdr.de>; Tue, 19 Dec 2023 06:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7156FDA;
	Tue, 19 Dec 2023 06:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UUAGxPYh"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2055.outbound.protection.outlook.com [40.107.22.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F30E11700;
	Tue, 19 Dec 2023 06:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KOFN74RJKBMonqAyUL6kLVW/X5+izSU47ybFuDcmKZfQ5Nvpr+PmwDUb70AO9tX8msb/05042LQmFuPv8Pu+iXOfdmGdJMmgi3leLcmgTcFZMcE28LF8GEHphfD4/juqLwJLUFOCldzWRBOg6hvdfLbUM17/q44qpRPbFwSPMVI13kCjCqotLoWFAJZVYojzsXv5pHsZLd0RZMKWj34vZPM1e0pPc8JlxqV/jTHfa//Uvi5B4wXc+MKyOZY+KjrDHoHT3m1qhpB9TiRLitqIe5ZpL2Q/pRubIdDeHvGw2u5egnEo/3o6hAzty77JrP//IA1xz1wiyFxwtBU6YO0png==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eA9sXR4RO8lDMUpw+1958OOZ2Cn91PXvFk1itXstDv0=;
 b=EQohvHJHhYovE1V1vM7BpWIGu9oQRkbl6BASvtph+dM0yhEAtwmoU3Q2vE+JsQdTmk1HavsVSC6vHiRxDgjPi0qzWWvvNgEAYqkq6ERjLPMF9S9rwYJcx9vDFwPRCsnGrIvcInhLjTuGMrRECdT/JwBalRn2DW9Sn4q0aQoKRStxhxUscxh1PSh+dliDP5Kmf4XPcIfvbFIAMCI8hajY2wPHTp353oP8gUnTL5DbTxEE94N6HEMjTPD8mLJhSXMrdKXgvD4i1DyvwCslWVhHGpuikuDNpHwCGXzfn7iCOJ+5ob3+7XmGcHpaW0vQ0EA4feVsouteX+qbwV1D36xstA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eA9sXR4RO8lDMUpw+1958OOZ2Cn91PXvFk1itXstDv0=;
 b=UUAGxPYh3nBOU6oX83AoCMKjd5RXh6QlOGDx5BgBZr2zrsCsxVv7kB2MqV/YB+8JQv4k+AF/7QRYmJAlJh6oIHNbtOwgVoT0K9UR4MXnTdoh3laZf2i0ALPj6pcbAqfMhZO5V2FRgQWSdu6Ip3a2LIohDNkaCsR2kcyfe302SMQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by VE1PR04MB7485.eurprd04.prod.outlook.com (2603:10a6:800:1a6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Tue, 19 Dec
 2023 06:17:40 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 06:17:39 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	ntb@lists.linux.dev (open list:NTB DRIVER CORE),
	linux-pci@vger.kernel.org (open list:PCI ENDPOINT SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] PCI: endpoint: pci-epf-vntb: Fix transfer fail when BAR1 is fixed size
Date: Tue, 19 Dec 2023 01:17:22 -0500
Message-Id: <20231219061722.1214670-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0366.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::11) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|VE1PR04MB7485:EE_
X-MS-Office365-Filtering-Correlation-Id: 47f96f42-69c4-4f99-3441-08dc005a33c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8WBfz+FMdINbwJ+VF8Ge7m83izGkU54K8eweZ/8U6YAtqTIED3gRD/bKtCKVatjK4WxwOydTBIkjtXX+cLT6n6WxKSJ/OFT7hH8Bpim55OnjRcHl3KZlm5KMKRkvf+rSx8GdQPi3EehvTE3T5ki7BHiPfMjOtMQ+9+883pRwHxUnQ70KQ6ibiqnPX5WuGfBM6ejwasUG+sq7NriQpf7o/fL6VRom2cIXFkJlEkQka/21fziErmeIEUAxNJXXlKG7xu7CSzWLGolFB4zO5gosYYUX4M3gj9bLDCioHQHKkdbojv8hgCusCvkgdsKJhKkl8LmL43201xKeuSpXGR8q853oYRP98ucBbY0GQ9qC/PfwOFMWI/nPWnvEJDUes6RXBwBpFCBbgZBGnC06+zB96YOQZY7B3w1wtYcvlaEnpi/hLJOqDKhLkbn2Nkfw1wf2QFXvkY3NMvlA84NhTvwFBMcQCGh92rsLCURzPJ4wvRQU3sZbBKMfc6fhp2HvlusTkecAiN5FyDLy/AZQopJT9zumVoqzj5us2P2KKGlXya/XAQUzYhEm17sBvQXAF4IZe75bZAIcmnFRbh6EAu4FpA0fWhf9du/rmIvfEk1kvjcxHxzak6V5sXCRy6BB7Q+0o5ft2HQKrh2EcBeQfyhX2A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(39860400002)(346002)(396003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(38350700005)(921008)(110136005)(86362001)(52116002)(36756003)(38100700002)(26005)(316002)(1076003)(2616005)(478600001)(41300700001)(6486002)(66556008)(66476007)(6512007)(6666004)(2906002)(6506007)(8936002)(66946007)(5660300002)(7416002)(8676002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MrIr88SIrKzNYQCh0xQUB4AHBMijCtechg4/K+hZ/awEDJK5PX+ccpLSeLri?=
 =?us-ascii?Q?CTCFbofQppRtXdGsrLC1yPtgboc6Skemuo5qlEgMBARINmFHDNYFPo1JVNVQ?=
 =?us-ascii?Q?MuYqsDXuklzzvh7jkcQFd3CyYcjYR1PGLJKEuzBG/CxA3Hmh66zqsN5f82Jv?=
 =?us-ascii?Q?6C4G8OG82zhobRP0BqHmUInej+/Yw6TqmSL0GZ+E+lIuMQA3/xbp8fboWmSA?=
 =?us-ascii?Q?Xqx9E1zllhTgbPEKCQZV9/Q+L/yru3ghTp6vR8xizhO97Yocgl3DWLumN93Z?=
 =?us-ascii?Q?d+gb77acD63/c/yVN0EUNXyqWPy+8BqzJqMr+xaO+v5Vjzb6KoCGMFvm/lok?=
 =?us-ascii?Q?ds2OIPyXc2oxDqAjauWx/yqAAhkPZrpl6UJDADMPAeqCvNf7l7rjqeTiBJEW?=
 =?us-ascii?Q?ZrZoQKYIHKii6sj/ZrMWO086CmUvl/BNqf2fRD5iK4GFLME9Q6O+FeudL9VA?=
 =?us-ascii?Q?mg1fXlbPrzKDKT2OsrB462dELiN9x2Nqck1fabQCV9iFghH545n0HnMOiDr2?=
 =?us-ascii?Q?snJ0lrR5loEtja9ml/PXbireiYWpsNWtwClWHYlEXFbKm3bRYA6I+m6zYPjp?=
 =?us-ascii?Q?8bageqjQW01uYLT8GRFvjEDVxdkmimNPNZS98kz1sLvCA0/jFZD6B+PcxChk?=
 =?us-ascii?Q?2tqtdByLODQ1ofWF0pyXMot3d8nkZArC1WdgfX8MAap8rzVjLBxYMCRf2rZt?=
 =?us-ascii?Q?LbKwQQVfrR0JRoHDJemfN1trhll3OtCtXHMb+WH8/YMn0uQXPD12LnldpxRz?=
 =?us-ascii?Q?3posQdWOzULBahyjVbRsp9HOD+0p0OM4StMkElMt8H6GOf3rSpgzurbXdxg0?=
 =?us-ascii?Q?BtZdXPVWh1mCBzQjYDrGGrKNmtLcpqNmC1QMBoboh52OuRJWv4n0jmUMw0A4?=
 =?us-ascii?Q?dLPBgj5aSlXTy6S4JK4hVB+LgFCMMC/r9bI+dDz6XCKAOIs5sN7ksx8O1YdO?=
 =?us-ascii?Q?pgFdVs3+1KwYjmX8Fbd1NepPLPtaEksA6gp1KPq/ZG8NKzZBODynHVLohocg?=
 =?us-ascii?Q?qzWrXRaNr2ETHdpGsyPfAwc57743xfrgHTdxIqbMv7pbsUCkAE4w8NT+auL+?=
 =?us-ascii?Q?/jboxsRBniFSo54Ql7E2mi2nzd1H46QLwkaB5F/y7JGK6TMmK3byduGZCBYW?=
 =?us-ascii?Q?iPNKkkk5WXNWNmh/pvTEBxYnxfQUf5SEVpVsF2ozgbsewDzGO3yleILLnDcO?=
 =?us-ascii?Q?N4lMrLZ2SxdmfNvxpqzmxrj8Ri1+dfQaSyRUB1o4EP9zvZtGXZrMYOnRtO9x?=
 =?us-ascii?Q?tQd3CbZ8eMsmKPDA5IKu10/al2tvBBhQxXva3bSPBK4qakei7+5FbTexdoZn?=
 =?us-ascii?Q?B3I0rQZ86nsKyNKQkYlvL9hVWC68B58s4cHsQP+6gLSk32oCMbHAYIhbMC/Z?=
 =?us-ascii?Q?2HY96hE6DiXZxS1wdwk+TLGlW7mHe3uOj+9ayY7y4URgneb8/XE6k91j/6na?=
 =?us-ascii?Q?YUjzIqSjpDsWjkv/6s/4/EBOIszHmx4YnVOzjDuqM+F0NT8B4tNQDz0+nFv6?=
 =?us-ascii?Q?uC9VimzhFVCWpbjKPfELNuIHpogFZkeqtTUcwAnUDTGjW5kG4fvEQgY2AyN4?=
 =?us-ascii?Q?hq+axwXWDdD8LuRA6wFL56zdMhNf19A4cLVl+qiL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47f96f42-69c4-4f99-3441-08dc005a33c8
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 06:17:39.7483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vNaN7s9zqHner1cn7elh7UWfGTUQqlnxCqu+ctmBW0QT2XCJLZJZSG6Q7iJ64K9cIdmilS1bns9UWikj6GKJ3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7485

ntb_netdev transfer is failing when epc controller's BAR1 is fix size, such
as 64K. Certain controller(like dwc) require memory address must be align
with the fixed bar size.

For example:
	If BAR1's fix size is 64K, and other size programmable BAR's
alignment is 4K.
	vntb call pci_epf_alloc_space() get 4K aligned address, like
0x104E31000. But root complex actually write to address 0x104E30000 when
write BAR1.

Adds bar_fixed_size check and sets correct alignment for fixed-size BAR.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 3f60128560ed0..c24327a06d8ff 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -550,6 +550,15 @@ static int epf_ntb_db_bar_init(struct epf_ntb *ntb)
 
 	barno = ntb->epf_ntb_bar[BAR_DB];
 
+	if (epc_features->bar_fixed_size[barno]) {
+		if (size > epc_features->bar_fixed_size[barno]) {
+			dev_err(dev, "Fixed BAR%d is too small for doorbell\n", barno);
+			return -EINVAL;
+		}
+		size = epc_features->bar_fixed_size[barno];
+		align = min_t(u32, align, epc_features->bar_fixed_size[barno]);
+	}
+
 	mw_addr = pci_epf_alloc_space(ntb->epf, size, barno, align, 0);
 	if (!mw_addr) {
 		dev_err(dev, "Failed to allocate OB address\n");
-- 
2.34.1


