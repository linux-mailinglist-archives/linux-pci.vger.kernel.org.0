Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1355F7DBA
	for <lists+linux-pci@lfdr.de>; Fri,  7 Oct 2022 21:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbiJGTOh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Oct 2022 15:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiJGTOU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Oct 2022 15:14:20 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2075.outbound.protection.outlook.com [40.107.20.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CAD3ABD6B;
        Fri,  7 Oct 2022 12:14:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aDb8SvHrPLGoB/mltKQR6Dz1UZEMNIewqahyXb4M4I8E5tIC+RfjDUAAMHSBoW8oiQwpq/ZU5ceg3yxleG9JZF82YACklUY6+RcsmN5eqn6z1u9B43H/CCIAJvlshseVk6OzJRIwF+sKhw7bCfP6bNQWCGZGOXSz9WskeLJkPWfkjhhiI8lEmLZ2T82RhzfKl4kQExRSIr2BF/lGSzu+5t1AUHxppBKRUN4nal86XINlqwlIyxYyOSN6d2/8iEIqZWMsXkF6vWTN9gTD0fexMImQoiTubr49XmM3w95JTme4oSx25sJEwa/pDU7gY7Ybp32H9LdIY7FSY98TAU/24g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QfqKjmRXfkbqfS71fsocR7ajWkM3hp3bLrQF/zSSm4k=;
 b=nrH0idkBkQgN0ACjkxCTlpdYcsOXWXPDSrV0qH9dzuukrmPnOVFXDAFyCNmiZ0uokE/aR9CswZAgC6tPganw9QlYIuwhO1Eyc57HVzLSNuU+4GKBGkIi8c1pJnmrRsri6tkGUudYuipX1lAQwJdDMixDnpzMqduWSZhVD4LM4EjNx+BPdtTrHH5O/zSxzcUdL50/ZyCk+l05TOgqU8WD0c5zcMVeh9eeRHTdbYClZDDVp+JmPNPgaX7fw9p4NzVUGZwj//o+FpNTC13g11CjXQ6XWMQSZS3eanchudM/xcnFjEnxcSQnTvJHxJYEUxUv2oAOwus5CCgxHiFiuNUSLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QfqKjmRXfkbqfS71fsocR7ajWkM3hp3bLrQF/zSSm4k=;
 b=et40l+XKXs3vABPhC/kSsGvbUm4ancc2LnD/xjRCFsQ/dj2/+mJzFM7qsIyypznMcpGS3YKHNlvHVUPM2IBu1VueKh4M9bbcyT6VctypZ38a4jPzOUXSiSW9LmiZkVIYYsguOYXTro2Jeutt40yDYSCXm408CTi99cMSvHPpeu0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8793.eurprd04.prod.outlook.com (2603:10a6:20b:408::22)
 by PAXPR04MB8192.eurprd04.prod.outlook.com (2603:10a6:102:1cd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Fri, 7 Oct
 2022 19:14:16 +0000
Received: from AM9PR04MB8793.eurprd04.prod.outlook.com
 ([fe80::54da:4ebc:2916:de90]) by AM9PR04MB8793.eurprd04.prod.outlook.com
 ([fe80::54da:4ebc:2916:de90%5]) with mapi id 15.20.5676.038; Fri, 7 Oct 2022
 19:14:16 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     imx@lists.linux.dev, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        ntb@lists.linux.dev (open list:NTB DRIVER CORE),
        linux-pci@vger.kernel.org (open list:PCI ENDPOINT SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v13 4/6] PCI: endpoint: pci-epf-vntb: remove unused field epf_db_phy
Date:   Fri,  7 Oct 2022 15:13:24 -0400
Message-Id: <20221007191326.193079-6-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221007191326.193079-1-Frank.Li@nxp.com>
References: <20221007191326.193079-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::20) To AM9PR04MB8793.eurprd04.prod.outlook.com
 (2603:10a6:20b:408::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8793:EE_|PAXPR04MB8192:EE_
X-MS-Office365-Filtering-Correlation-Id: c5c739ce-1ad9-473a-49e3-08daa898208a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 30A0quYrcT9Zg38Z70FWWjzA+e0kay2lxToErsL36a3JRsv4E5NC/8y2vY/xBEf97WrJ3zbQ4Xa8VZJeAGff7eXgrs+h/4ElFSasfPHL/NioD0P/G4fMi/JJx8GtyloXkxwtKoY6yWo313uc1v0a2Nbplalp6/yHs5uEO0pQwpCtfxEpZDmXoI4en1Lky0YC3s838GCMcIv9C29UztNpO/BnD4TDcJbyeaImA18qOmWmmRrHu9oEZoQprLCeKVanjJ537ClbL68Gy+DFMlH3boiQxGy462zk8Ao+o8mtVTXCevpwrXMP+0pdTz5qRTOqctT54HinhEYPB6Q6Dzuagaa0HGut0TK5y/fwrwN6NMjFrIZYvtqz9WcorK+nqABTwo804yFz5k53W6EzIATcv8NqoblnezTq0iNwL2bqPG0bmVX0We7M/+FRy5yRPCSiXbvVQcdQSAEWJ2CK9ci6cZENNBOMxW6N42alIwl6ybMNi4ZMoejR9tKYaniSKTGV0ifZq7bY8oRb4SnDUJqFzDSuVGX7KGv8eX2UN+lKlHMArtcfKucMX2jLK8KidKenqLpJQBwACRewklOpska5dP3O8vuyg3iJUMK/KESomLV7KSIcTULNhVUHDYnNjNG5MBjmXhdIKomgIzxJWZckKoqxKxiMRhvQ//Cy/mENoc+eYp5cUbw0LstIDuf2RPNTxy3SSMVidonBFnn7q97pRvgKshix000un3C4KTskNgAnySysHXaBftpIYjJf9X7WTFeq+dvyHUiWGlR0tSAbdZjmwmgkMGWTaDdUrKg4JHU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8793.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(39860400002)(346002)(376002)(366004)(451199015)(66946007)(36756003)(6666004)(7416002)(38350700002)(8676002)(38100700002)(2906002)(1076003)(41300700001)(66476007)(186003)(66556008)(83380400001)(6512007)(8936002)(2616005)(52116002)(26005)(4744005)(86362001)(5660300002)(921005)(6506007)(6486002)(110136005)(478600001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BpWZcwLRwODwZaLncFonVysNLuplp3ci9Du4lx1UaEzjIEIDdtROjQDlKhR5?=
 =?us-ascii?Q?f4t45o5AdcI35ks1q79DWcfSUv9fBKjjK7jc+4M6JhniIFPYtYwt9WX5ML24?=
 =?us-ascii?Q?0KUOZu3NH+iADP2h4+gPAPMtYqvmiTSft3gpGt8mLzEyKZjvZam9xlt/Nnvc?=
 =?us-ascii?Q?xSzUwFJele6+LJvGfyHGVofg2pQmMu/tAML8YHnYQLF2WLhsgSxx0gNIZEsM?=
 =?us-ascii?Q?snFY7amf4o193182SFraiyJyDCvoQNZaIUKyR2jDeACliP3XX/Z6ANhz69I3?=
 =?us-ascii?Q?bil7CZi/rFSxu2Rv3x+N37GymNCgPrjNFIH8HtMYd/KuSEPMSxK03aeKyNIe?=
 =?us-ascii?Q?KKNiPECYJMztXNKOhM8eecxnjDw7ky19uDjT77eUW9P6MOPVSdOkCBg2Oa0v?=
 =?us-ascii?Q?EJi9O/UC3+xdes8HdxpvNIitwAJrnEu/nnKx3m3FoLxzFJAsGDgJRb7PHMZb?=
 =?us-ascii?Q?GBKJvjuG5S7dxK8hek3jiML8l1V7mMDzCU6bgONEv4x6kAfCKvYfVhlcy+lz?=
 =?us-ascii?Q?r2DA2iWayQI4axKamIVHburWoiJBH1sBCyVIzegzFIWOpj5LGfFKIem/F2SA?=
 =?us-ascii?Q?Ld+QQw3G6fOGcOkJPf9yyt3clZ4WRCMv6B7u7uhMDAKkSy9qru306382Qd+t?=
 =?us-ascii?Q?CH1gopQYzeAEFWxXXerQBaKL/FZxoaolqdP1EyAyMziWK6TRkT/ke6mLOLhn?=
 =?us-ascii?Q?WICsixqEPAapuVXirsi7RxEC1AXZktch6mhu0otNytbbwwH8PbYNnzfL3TDT?=
 =?us-ascii?Q?5MZb7RT/sIuGj2vHYFi7z6iLcyRdajJoTU+lcEVett/H6R7fEnM11wyJWCJK?=
 =?us-ascii?Q?+s+0fdRAjH3LEX60cYAsX+LL2reGd+ULWwvV8t0Cx6ZDruxYK/tmapMqnDiA?=
 =?us-ascii?Q?rCiA9hCja8FcuTV3KTuzzghymaMq7GLA193plCpEbeLcHTi1VRRk3o2br/oe?=
 =?us-ascii?Q?WD+hP+juhpTC2CGqronbD7oNOuCrLurwJgYtBpdC9k47ebjkTP8SBCN4Pu4N?=
 =?us-ascii?Q?RBcL5t/oLEKFya+ExLG0+J7DNSlzzOHKoOnArokh0R9FANQ6xpfUK8BBteiO?=
 =?us-ascii?Q?irPLKTmMp/X+tdgWONDyDLFzr3IRYxdg1QukNwPWJsiWS0kgI1RpvQY0xbyT?=
 =?us-ascii?Q?cmCz/i6IP1jj3pxoRmwWegD1lYT9gvVZDdQLA8AOxBsn9CrTeLc7NqLk4E/b?=
 =?us-ascii?Q?FJxgbM1+bjVdse+mtXGREvrcpkEUqeuFCcLw3iVIWpCdxXbCslQ39+vfufGD?=
 =?us-ascii?Q?c1XypVcA2pTSDmGWzbHPxdJizuwrAnZIqfDYs5UnoshOVs9HvZe/URus3Qa9?=
 =?us-ascii?Q?iyND+boaWUJrde/fpvdPz9QFMlXdfaMj5Qdl4XoWoHtDTvrGNAwVLxTj+p34?=
 =?us-ascii?Q?Ojx2MghrSTQE6aBhPJImfwVwTGvhFKmfQJ3JULQDritZo3aZhz0agj/32ZoR?=
 =?us-ascii?Q?c5S2tjndiaumjeibnjorIDN0H7m155lOXpAWkGK7vtUlhrDR0EftTiHrqDXz?=
 =?us-ascii?Q?3dEJEvQphEA2/qLH5fKTF51sV7H2y/Hrs7AtmRbH7h9MS/ILQQC6Xm1d6OL2?=
 =?us-ascii?Q?4T46FlrOJvB/lEK80sE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5c739ce-1ad9-473a-49e3-08daa898208a
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8793.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 19:14:16.4055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NnosGQP+iP7+q5FDE3tRCKl6r8VLn8yrAG5KyF0iXPNTX+mvFoW71SLf0g9xXhaCTezWaLdMP0pQ8YrqaOyeRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8192
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Frank Li <frank.li@nxp.com>

None use epf_db_phy and remove it.

Signed-off-by: Frank Li <frank.li@nxp.com>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 191924a83454..ee66101cb5c4 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -136,7 +136,6 @@ struct epf_ntb {
 
 	struct epf_ntb_ctrl *reg;
 
-	phys_addr_t epf_db_phy;
 	void __iomem *epf_db;
 
 	phys_addr_t vpci_mw_phy[MAX_MW];
-- 
2.34.1

