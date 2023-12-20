Return-Path: <linux-pci+bounces-1229-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1ED81A742
	for <lists+linux-pci@lfdr.de>; Wed, 20 Dec 2023 20:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FE9C1C234D4
	for <lists+linux-pci@lfdr.de>; Wed, 20 Dec 2023 19:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8A5482F4;
	Wed, 20 Dec 2023 19:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RO6v6mRy"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2062.outbound.protection.outlook.com [40.107.105.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6E648784;
	Wed, 20 Dec 2023 19:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A4azvvNSYPkvqAU0DnO4pQXOAlCCTYq1GzS7w1r65AjACWO6AGfmQMFNEOQMaduHT6eaRVgOusuXXlj9BQrHhb4NW3uvldo+9A1HlMdfWU4SrfG4v3k0wzw4fCM45DJXuyPGgoT4kHDpjs5rksKpzcBmcgU5CIQx0IvBqRaaJM88ertc73CsEaC7W+jQIyt4q7JN2g0JQuCfK3tdDHqVKzLEnWuIBgJlyfL143yZisaYkHg+EEQ5A50Uf55LQVYbBir1C2XwPskS985PBr2V+SpkYYKZbdfnd/B3qgRmvQ/6NdQUmlQyuWFpcnBi1gORXL7PqDYV8VGR7wOHmsd8lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NW8j7GQyne+PkeRuV22J8yGlE2PlpSrquGMqnGLBI7Q=;
 b=JoUrMnqHOEICXm9wcF1/Tr3nGLxn1v9x/xUGtIppXfx0BrTchhJIyoOrZj5XKXrEvHY79Fjxo8GeLNqwuHrqUezSQWr2QA0V2ez82fjkQOxV32kt2uInhYogRocrgwj9bWC34UQdjET+htxEY6ZUHDLOekyorzeroMl21HA/qnrFQX5TyOJpUUc4qfunbY+7AR8S5Yqo/iLJD0iewpDk6fPK/HGzwa+Kd/83B8+QFXuYNY1V+6VD8maEBzPfCrFRGE7ETzk0TG4dxkywDbKM1LFJtQGa1rYVqGBltcRH8HmHBoJiS2g2lH0Ge60WvZQEz6MHUQE+uMw+pEGK09mECw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NW8j7GQyne+PkeRuV22J8yGlE2PlpSrquGMqnGLBI7Q=;
 b=RO6v6mRysLB/p6WUsyQc1ojDuQcyxd2hD0DfaHKGeMfH8jVWcpaFY2ue76BGu9b0erA1dsoy9uttHsj6hHZ0v9Ri+/HoZSJRRsxEGAr5At3zQiILAqO/kn1hNRgm8L6HsT8qL+uioTYB20lj+Yl7smwKdsZU4NWtddSWKhkGhIo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4845.eurprd04.prod.outlook.com (2603:10a6:803:51::30)
 by GVXPR04MB9759.eurprd04.prod.outlook.com (2603:10a6:150:111::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Wed, 20 Dec
 2023 19:25:01 +0000
Received: from VI1PR04MB4845.eurprd04.prod.outlook.com
 ([fe80::dfaa:e869:45eb:76e5]) by VI1PR04MB4845.eurprd04.prod.outlook.com
 ([fe80::dfaa:e869:45eb:76e5%7]) with mapi id 15.20.7091.034; Wed, 20 Dec 2023
 19:25:01 +0000
From: Frank Li <Frank.Li@nxp.com>
To: mani@kernel.org
Cc: Frank.li@nxp.com,
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
Subject: [PATCH v3 1/1] PCI: endpoint: pci-epf-vntb: Fix transfer failure for fixed size BARs
Date: Wed, 20 Dec 2023 14:24:27 -0500
Message-Id: <20231220192427.1530460-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0354.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::29) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB4845:EE_|GVXPR04MB9759:EE_
X-MS-Office365-Filtering-Correlation-Id: 835c913a-674c-4459-6f77-08dc01915388
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	H8Rk1OeZGYRf5NCJ9BlyTkSW85UbU6ITzJm7U1xjkK9oQpRZ2y14EmoHacGICtIwjiISUpGErGbfK9BP9HRotkAhlwBouMC2uOdJssPulg4Ckysh1JRoPGDCDMAr3BebASJcmxGtLLxFZJ6OpPvHAgkOBzS0Wqte1I/nSpTS/hPVuZfHYw3pm0PPMtN2d/QodEdJ0AG5PWr2tgNGBqCVtKhhdhKzPeZvS5gBTif7nb1dLgYdBGLo2rcJw3uCz2/YAi1kBUIO5/IRCysvz/zgzigBcNJ9mNzg0996NwBC87Z+5ICshm54rpLVxhDZ1f8gAXJKZ5bfn1mE0CqConcbxM5skH2u4Qn9Hg09W+ihb2LyfO2ApD0FGb/b/fl5WZvgiQNFu1P+B8Idla2grecFxOHH1B219ouX+KcqoEBdSguUWWKugfjiuoNaLLvoK54ravLyAP5WDAzvVINbPToyaZrQqZSgtoy7JhcSzV8cSji5osPCiqJjwPpSXrkVKephYNTfVAl+G2Vojmc2nUNhhz4E4Fn00V2VHoyhMewLuSF68w/XCTr4W7RyWttsqZUGnvCThah95Q30Qbxf1swm0EDvXHeDjYmKaK4pYj3iVPifAY4C+54SwLp5vfC/3Pff
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4845.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(396003)(39860400002)(136003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(8936002)(8676002)(4326008)(6666004)(6506007)(6512007)(316002)(6916009)(83380400001)(66476007)(7416002)(52116002)(66556008)(2906002)(5660300002)(66946007)(36756003)(38100700002)(41300700001)(6486002)(1076003)(478600001)(2616005)(26005)(86362001)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2OjFeElPyO0t0Y1weRqqJzzPHVtgmC/joE9Dioel/MxK6racuocExP1XoT5V?=
 =?us-ascii?Q?+PGeWTEG74nPr4oNhtcu7ZPJLTYQ/slu3s7IeuVsk15t6n1bCNEv0zf134tX?=
 =?us-ascii?Q?mrPPAl3dYlAHVYwrXfXh3IUZQTLesVWOpZ6bAcmy1A9RyDXHMlWu2d1IFjpT?=
 =?us-ascii?Q?bTOW+9rbPxxErDs0PUWgIW1dvQcySzocwv4vePwudoYZtfAKyEwevCZndlq0?=
 =?us-ascii?Q?0jKuzkP8VoToBY7confTyUG0JdwN01w5ubTup7ttgx2Rn85TIAxu08f3V0T+?=
 =?us-ascii?Q?otM3d9adOi/qWwCY0e+1z0NduamnhOBQG7+tIPMnQ0Um43Cil3gB0HAYzvjG?=
 =?us-ascii?Q?4JqoTwfYsGiIDgz+A4cTtuU0nVHiGLgQwglW4sR3XNCRlzWFYLpkRliPXMvD?=
 =?us-ascii?Q?wuoBDD+xYKqO+yoqqwkD23uF9VLgPdBWvWxXVaYUB+wjKdyfgniGcDNCFrMg?=
 =?us-ascii?Q?utdrHdwTeYNnrLTmylYksQg1xusDAorH/Rv48UQbCiYQmG8eGtSZuJ+qEBdO?=
 =?us-ascii?Q?Y4IvXvilSf0Fxs6iQdvlGUG68s3HjrA+owL1szEGc+QnlIzatlcuZN23Zs3b?=
 =?us-ascii?Q?04AYG9k3GarDJ4cPlh4KbvEFDf0tRXzY93O/p/1IVZElGJqN3/xlbOMqAKRl?=
 =?us-ascii?Q?vCBXA2tfiejKyGs+tR4OcBB2+FOLIUUFjPBkC6zvzp/8G+N3/KC05nUjYl/d?=
 =?us-ascii?Q?eOTUUQtqpMGE6SrdJnJncPiS+rz3cG2OKQknJ7XZRhHuXYYi6RhaAJUD6qwQ?=
 =?us-ascii?Q?4iIh4I2dHfhQSBb5sbr4XRVOcw+wD1pSq206SEPWThOdkQHwlV17VBnQGAw6?=
 =?us-ascii?Q?Mza8ynE77RRjugEM8oz2BDIwK+1NGHGmZZdYwCiPUTphjNMMcYwSFt/DErdJ?=
 =?us-ascii?Q?7AQGPZ3T7hb7ff81UMU3chcQLgUU5Y9C7lYR59VUiH9CdngHFOD3cbjlpHz+?=
 =?us-ascii?Q?us4Wm6qwBsQmK/px8W/rj+zrcALKQbmJEGFRKslrvx1JHOeRYwKwKoi3dC38?=
 =?us-ascii?Q?xfK5/KcJgKgFRwvA/nHHyr9NxjfJrfhNXg5Ba+72hIQ3UoYW3TrRaKTLPsFq?=
 =?us-ascii?Q?LREJWcnH1N0hGx4PIQodMxHk30+KcT73tuHkHsaYBUEOejzKZ6nEE1DwzQ4N?=
 =?us-ascii?Q?6S/i4sXjbFocDKSdIJmogWKNBj1KCitY0FFtsNl3poHqxeOLMtM5+bOlOy5f?=
 =?us-ascii?Q?3tdqU5ZyR6JY1Ha4J7Y/4qKB0/ByOLoySVFifvHP8hSiGErElETvwy5BDqV2?=
 =?us-ascii?Q?0oF76o8XEIdVEOzhlI3jRgqygtJXUs1HE6dKb9Tegck4p8rMFoDUHwi2UYuA?=
 =?us-ascii?Q?rB5moH54GiE5Z+dBZeFs9zvXkMfKorX19R3mMSsdsdkiG8p4e1tnm+4m2bCr?=
 =?us-ascii?Q?wMVYb/iY67mAVet5dXvxxBH/eMcjPNAy2nbTFCMygvGP9VXza+LaORpta+X/?=
 =?us-ascii?Q?WuyQsvzaoMPG+gH3HUuhGS9Wpu4tHiFrjMPX/ISAoHVLmyl1KoevPKn2MLCq?=
 =?us-ascii?Q?lDMHD4J1szy6W13Zn3akWZu+oPtGeRb2XM0WKeVOp7tur6jM3Gc+Y7wz5a/h?=
 =?us-ascii?Q?Acsph6QyviC+kLeFOxU=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 835c913a-674c-4459-6f77-08dc01915388
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 19:25:01.0973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XRZEXJpHIgZCeWaAhU2QjdtAFWjjjjnVKDjoOWDzNU2o4RDOiin+xWxBvxn6EOnuMcO1Ra2XroLCexZtX0ZEoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9759

For the inbound MEM/IO TLPs, iATU on the endpoint expects the target
address to be aligned to the size of the BAR. For configurable BARs, there
is no issue because both host and endpoint will know the exact size of the
BAR region. But for fixed size BARs available in some controllers, if the
BAR size advertised by the endpoint is not same as of the actual BAR size
used in the controller, then the MEM/IO TLPs generated by the host will not
be translated properly by the endpoint iATU.

So if the fixed size BARs are available in endpoint controllers, always use
the actual BAR size.

Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
Cc: stable@vger.kernel.org
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
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


