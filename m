Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D503616493
	for <lists+linux-pci@lfdr.de>; Wed,  2 Nov 2022 15:11:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbiKBOLC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Nov 2022 10:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbiKBOKv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Nov 2022 10:10:51 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2085.outbound.protection.outlook.com [40.107.21.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F4A24BC4;
        Wed,  2 Nov 2022 07:10:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bt3W+Yd3jr9jehiqSKHexwxkSWauA3l07Pe2+2Bz1c2drAE0i0mCrRszHCIbfvLkcRHWUkzAxlzmo1e9aYgJTki5ztJCVWLR2bkQaXsOKhPq4W/p4pmljacYQDqj/qMGF3Zmgj0GF+o6WPlgkVU8+8fa7NlhCtDUcHJMRAPkj0tFmETPApKCZt0i1itYQ06TIk9NzB+sRQeitCNh6dDuaYqpZUXD2VkeO5nn1uBUGlAqfO4BtPpNIVgS1FbTlkjlzOnuJrC3gxJp5AO0ZaTabdd99E800Bkf19A1cyTUZ+Nv81x9iC63tJFImGTA33rSyFEg6RLEsSXIyk/LQzHS4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YRK103siZ5945LFLHIFILLE1HOlBh4/xZcoINeMqjBQ=;
 b=nlBZvj4CyOFE4t5I5flip42mX7ppfyQHhmvixRhBQlQEzavTUGABIMJZV/2tP3aKL8V1wYNOZG6x3pe0MeWNvArj/L8wYnbex6tW+SOcoGlOZSTm10xVbNyRspGiAa/LtTpoF1VpxFkZlOkLDlNpk3LXUV7Ae9PFAppz0yfnfTwAhdkyyJKONMEiDAuqRhWgi/qx44dQ+SEgzExWbxCnzmA5C4wg4+mvs5OS0rbbREYjfYG/yudKMxZo9kLGxb2Cg8gRm9Pk8/k8LVLlhY0z0mtBSXrfk7oJWrkJA0eXoJSpciwVz3BILa4KkQZCALCiNNHFFWVBpfKkObr/V+4wcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YRK103siZ5945LFLHIFILLE1HOlBh4/xZcoINeMqjBQ=;
 b=c0Gw57SO4xlemBnH7dvBDQiL6MHEU+G7/rdpT1H8mAPJVjKQBP3wr8AGbUCWo3RIKg0+glUa6/MrFQl8SZ663szW4bVTAON8YvsP31THbKOHxFTyxPmwW2ZkvAsp04j/1lIFCzNYoUzjSX/Y5p0rVPxdIpBAnfKQhrmNS3pcluo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by DB9PR04MB8234.eurprd04.prod.outlook.com (2603:10a6:10:25d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20; Wed, 2 Nov
 2022 14:10:45 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::44bb:8387:8f4b:6a28]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::44bb:8387:8f4b:6a28%11]) with mapi id 15.20.5769.021; Wed, 2 Nov 2022
 14:10:45 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     mani@kernel.org
Cc:     Frank.Li@nxp.com, allenbh@gmail.com, bhelgaas@google.com,
        dave.jiang@intel.com, helgaas@kernel.org, imx@lists.linux.dev,
        jdmason@kudzu.us, kw@linux.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lpieralisi@kernel.org,
        ntb@lists.linux.dev
Subject: [PATCH v16 3/7] PCI: endpoint: pci-epf-vntb: fix call pci_epc_mem_free_addr() at err path
Date:   Wed,  2 Nov 2022 10:10:10 -0400
Message-Id: <20221102141014.1025893-4-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221102141014.1025893-1-Frank.Li@nxp.com>
References: <20221102141014.1025893-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0210.namprd05.prod.outlook.com
 (2603:10b6:a03:330::35) To HE1PR0401MB2331.eurprd04.prod.outlook.com
 (2603:10a6:3:24::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2331:EE_|DB9PR04MB8234:EE_
X-MS-Office365-Filtering-Correlation-Id: ddff5be1-4526-4700-48ef-08dabcdc085b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MAR2C+s+VLMMSOkUeJ1MNeYphCuK0owRkB5dO+gN82hQgW12a91zGWFA8nHCG9NbP2w6Cd45/R5vUuNrMSvqLNpR9P5AAEw1z87Vvm2bzLEdWOuYjSQ5I6Fldj/1Y2q7pYeOhgHT6XAeklSbFT51TGl1ijaGFp9OPKATrxZDdhdoHUBgwNy1UpK20Su1KROgsGmOro1vHMaIwXfGyWVSrho080SNLy1wG/x6rR1etl/98+d06QKRU70Ah4l/7xml7fc7XDLeXx6lkNtUIMMEN/CbYQKLJ1JhwqzsQvDDGpI5MEj+YbWh8jtsvdvEYkcCbxQW7qtUS7D99j9lNcbLm6b+c51R2ZSyEDkq0+C0iaJ2ZjiUQu9yMx8kYF2G3Mg1GP2vc1DIMhnBo1oKluMnCmaT5RM3VIGsoSzygJDb1b7JSmDUWz5ek0UEjcV9TpBIaspL0+qdUvWJqa21caKg3NckaQNTkYDWdx/y5/0ZjREJ33iOa+umOfK4OOc7ppw32tYxanvDeqlMXLysom++Bllv4XEqAFBFqxxx6dOzx8g6hgYDttkN7/aYdEaoe4P+2NTp1T5Z5vmqIFdjHYnUTW8Knv6M51NritPbVD8q75kysPKNh9sRgNnGQ/bFdfV3hJkC9pG5/6PhnFP8RI6yP3GNGZkjwfxrs4WwAuqGHczxnpjWv8MHJHsPnbJS5KXVPCynVOxU9sThq8MNa8T2b4L2dlivKtpcIXNDdD8HsWh3UivpulnBTrcYVbhMhq9QmMP7Cg1lWGCyoq0/WyqbDA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(39860400002)(396003)(376002)(366004)(451199015)(36756003)(6916009)(6486002)(5660300002)(7416002)(83380400001)(478600001)(2906002)(41300700001)(66556008)(316002)(8676002)(66476007)(4326008)(66946007)(8936002)(26005)(6512007)(186003)(4744005)(38100700002)(2616005)(1076003)(38350700002)(86362001)(6666004)(52116002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4s/n3O+7cblwHqmrGFMtWWkhzEZrzAKpQLOYlX6GQW3WE+2ssG+WiSgDhsK5?=
 =?us-ascii?Q?4UPRxN48zs6mA2tT8UmL6nKjsw4npClvgnaDdw3JewYwyaC6sPotavd6UJiQ?=
 =?us-ascii?Q?EqeRm+JhBz3LevgLuf8IbQgwJXZlK75aEOOUrcfYPQFaOQgp1x6Oiu3WZ50g?=
 =?us-ascii?Q?KihMSNrqnP7vgfLHlSd4RY9NUQjCOs6W7qWsjdlgVK0gbcxv4n4+L9dW6Mmg?=
 =?us-ascii?Q?fF2w7SrDGblmdKnP21dqYwp6F/pMeKlwM6RPRbSVVxrfvZV534zzBMcXFOrR?=
 =?us-ascii?Q?6MM0EGJ3g3KMuHrtg/p2569G5flMaUXwQkr5/RU98R94D7KfASqKkyz77Ti1?=
 =?us-ascii?Q?F4xx8lVV3iHaW3Onk3/K7yR0Xees7kQ8XsvP8podN/7ndL7AMHN0Tv9/cM3O?=
 =?us-ascii?Q?peM8r2xTFLyce93rfQeCPqyEtaZgzaYg8SYP6FKJAnK5tqliTuhaM8qUUv+Y?=
 =?us-ascii?Q?Nz+/yD3N13Vqa4qiu1RCVnD2NlTv68TGIcjouYl/i5yPsQA3TPQ371aXttwf?=
 =?us-ascii?Q?1O+jppJE/A2V4n5DmyB2mHbgWw9YxNQrLHcpIB/nrOmWNDutlAaOAWbmnWyU?=
 =?us-ascii?Q?fnxjgBfe31LRG/tNOZDV4z38ofLDjEnui/4wc8azPYzCzEZv4KW1pct0X/AA?=
 =?us-ascii?Q?Y/pV8otqqSbTkxMI8hJ8pg9Yhv8mZb66XX66V+f/zVwGVI5LU/es9ccVFKGn?=
 =?us-ascii?Q?t54FKXmBN3Bp99A5rypMQD4zCPbbb1lJ7D37iaugagSeTgFqoijObLYOTgUG?=
 =?us-ascii?Q?okGtGrRWuIXjhrU+03lRKqIPRFXtKMzoeIM8i+9yJTlVeYpvpI7u7WaE7nu+?=
 =?us-ascii?Q?Z/ajCbMT0XlJw5176G8gX/gDXsSlO+fJuE6Xd//fUcVB6zdn3ku3gzC61hwC?=
 =?us-ascii?Q?7uZHobLg1cS7K4xdCXuntu77mVZRrOjrGVK62gyG8+ffRJjr7zJn+rXcNxLF?=
 =?us-ascii?Q?RNZiThDOPmSFNP8SNgnMCecR/VXs1U76mtzbBZ6wo4PImnV0FAHlgyGEXciN?=
 =?us-ascii?Q?BocE+m2JeCreHhQSKrmrSKzH0TpWUDJe9aPK5ILlEGL7cIEFm67PHDJnA32W?=
 =?us-ascii?Q?Y+fkFrdSGnQOP7ak9CupHd0PbXeRTxPP2c9cf6FfrEOfEWBGzdoac0kLqgpa?=
 =?us-ascii?Q?0TcxP4YVRkeLdttZGJzgrR45/4DsoXVvVB1Cdu3gPPSozjrejrQjD250aa/h?=
 =?us-ascii?Q?lG5nllCCcKgG644oZ3wgAh32m2aD8ljykHEYf+2UKkGoyg5uQYR8RpmbyRrt?=
 =?us-ascii?Q?WrRmd8f09Y7NZAF99cDZggePqFLs3SYw/V/NtJSIrve+rY/x5dnvYZUoEq7U?=
 =?us-ascii?Q?VyYJ0hy0G8vyq1T8XNfU8ff5Zu5p+u7pvolRyESLprQkGTP59cmwF/X8TVoK?=
 =?us-ascii?Q?qF55cs0ROSM8L2Sr/pmwgcmacN9Vc4DBq9+FW+UKs8mMGiuefgU8hlKiHPHO?=
 =?us-ascii?Q?eI9SHQMaQ3EChKhpkYDCbRzb6kbuwh3+vmAjq3+pAlDAVkLv/bYX61dz/mew?=
 =?us-ascii?Q?r08q6JTOOUeYM19n3jEiSHLZY20lfN+2gvoqdDYl0GykJQzU/bT6H432XhyH?=
 =?us-ascii?Q?9efgy7aVX7U5PoLBjncMsM9QWf1+1noIxPBfUO+h?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddff5be1-4526-4700-48ef-08dabcdc085b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 14:10:44.8654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZhCXwUja6kcKqUwIxFuOmbd3NrnjQAg6j0vfIO80iRsJJwqGdxOmRnyn/BUQ80vqFB4goFisW3hsf5wic/Ph3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8234
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

Replace pci_epc_mem_free_addr() with pci_epf_free_space() at error handle
path to match pci_epf_alloc_space().

Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")

Signed-off-by: Frank Li <frank.li@nxp.com>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 1863006cc36c..191924a83454 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -571,7 +571,7 @@ static int epf_ntb_db_bar_init(struct epf_ntb *ntb)
 	return ret;
 
 err_alloc_peer_mem:
-	pci_epc_mem_free_addr(ntb->epf->epc, epf_bar->phys_addr, mw_addr, epf_bar->size);
+	pci_epf_free_space(ntb->epf, mw_addr, barno, 0);
 	return -1;
 }
 
-- 
2.34.1

