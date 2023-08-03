Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 009A976EB5E
	for <lists+linux-pci@lfdr.de>; Thu,  3 Aug 2023 15:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbjHCN7Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Aug 2023 09:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235850AbjHCN7V (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Aug 2023 09:59:21 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2066.outbound.protection.outlook.com [40.107.20.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19A31BE4;
        Thu,  3 Aug 2023 06:59:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i0PnTO6jXScR+RSt7aqNJlxUNNgfZqWuc3SO9nEl3223xRl/kAC9gJU6PbacxyTveXtdiUo3BG3+Bnyt17119QLq/Bm2vXPMYWEafwxubeIKC1Ti87GoQ9EIfH7yDrT9xV+4jRX7akAL2PUUPDxqW1TpHt5cHzjlIH6yrx9WQH5JC9kzhKDOdch4GjXGIlYdPqR9ojFEII8Y1yLYhOtcG+SXCdx21OocSY9lUBJ/87UcL74gNJb1V0aLKvGNw4bf0ZIyl1qvSnRafPJ/ziQuWJkpIpv3nk4coZmV29sTBJE+A+CHhCpo+wC6QWBAEhuNxAMv37axJm+U3YlEuY0qlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L6G01L6TrLjRhzAatZncIBGwWrlgeNojLy26pEtIu2M=;
 b=nalNoOixfPzNFfGpp5VI/P/RaURuAHjPghSkDUVjzgeQmiQwm6fIH0pmMZh+llFIOsh4iHSTZLQnHjU4N2ONxsaFvBZNx10pnvIRZAxSfx0/n2f6zqwCeomBsh7ZwVI5e4cIoyo1U/ousPj+eR0+aTivFga3qX+bnORGWk9kZ/WI6/lU50tkBcQu0m+ARq+hyEjF/GmIgNpR0D6pSYgh+rgwcMzKp9J/YG1o9bh1OjNyBDbXGUthQc+/V7e8rAOPfzXOpMCS3fLunXc7GhGU/xBmNJ3aksEjDCizTLjKHEIdA61mpjZtdVzAbV2j3xAVDSKaSg1VEwkSvaM578Ok9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L6G01L6TrLjRhzAatZncIBGwWrlgeNojLy26pEtIu2M=;
 b=a6qv0Z/O/nb0/dV76OguWXi6xE1XFDjgDR418Rsxigm52MAOd0ASFSuua6E1S99DRmlB+93z5o2oIeRK/vUIyWwa4pMOBNfEVUNr3JoALroZsjGQ9P2B61XcW3s1yYtA7HGPgrodVmqGA8bL9dhFV2VQY0NmRluEkG0n9/pNUs0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by PAXPR04MB8799.eurprd04.prod.outlook.com (2603:10a6:102:20e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 13:59:12 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::6074:afac:3fae:6194]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::6074:afac:3fae:6194%4]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 13:59:12 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     linux-pci@vger.kernel.org, netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Michael Walle <michael@walle.cc>, linux-kernel@vger.kernel.org,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Liu Peibao <liupeibao@loongson.cn>,
        Binbin Zhou <zhoubinbin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH v2 pci/net 2/3] net: enetc: reimplement RFS/RSS memory clearing as PCI quirk
Date:   Thu,  3 Aug 2023 16:58:57 +0300
Message-Id: <20230803135858.2724342-3-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230803135858.2724342-1-vladimir.oltean@nxp.com>
References: <20230803135858.2724342-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR06CA0108.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::49) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|PAXPR04MB8799:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ecb545f-f92b-4b4d-91e3-08db9429d0b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ACZPbvmxehGRgFT76g0Gq0tMrUsbySLBXub1Yc8RcbOzWcQb3qGWp/RGBRR8qt8jofd+WeV9bbHCMKHih74AOUtf+hCDORJccQVn6/rIQKK8F9NlN/0UNoW2798KbEiFYBOsJmXROu2MV0jYMCqwgGGu34A9x2q1SklxQiJ+llkF+Yctcg6v/6jXzLhPp/gMkCxhjGvkR1R6K4PIHHvcsS6IAlRC629Zk41CRRnb6GJd0SUMBvNdpsPFA4eq02uC8Rol0ag9Tg18wvrZIT7amDbVzhlwdcCIJE6yrWEipQRryrGr1ZMkmDi2lfjIlx3UJMegAH6RMohLXi5wpdFa1H7qrcWf6dmOcNwG8AYMS5dvZ6+ef2kKMnIsE2RVUMn0fJlQ3VaIZ3ClmLjhQUlJMu2jzihCxip2fuCBfaywtSuAsnhjfdERqPcP4Suy4h0mw9P1k93xYxIams6ZqSDBCXI1P/QDaj2xjNLV5gHSqL4WPOmUI4WzTCnPF9WtktMLbr2ga3/53kawkuIIOTOSshHTRLVOy0aSiDB+WCW9Oh4JM6a8d9HMTqWNuYFDhq04otB0eQMkRMsW0dPFAkTCg6gwDGDEAJDSt6I5kbLOP8g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(136003)(346002)(376002)(396003)(451199021)(7416002)(44832011)(5660300002)(8936002)(8676002)(41300700001)(66946007)(66476007)(66556008)(316002)(2906002)(4326008)(966005)(54906003)(52116002)(6486002)(6666004)(6512007)(478600001)(38350700002)(38100700002)(83380400001)(2616005)(1076003)(26005)(6506007)(86362001)(36756003)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M3mGTBokN3JsimuoqlXTOJTEzW0eQqPOTbJ/YfcVvY1k376FugT8cqlB7RUn?=
 =?us-ascii?Q?L+Eg7o/3Cb92XB1VkUtaPukJjuY63OwqqAgjE7WeEnwZeD+00h4Zle4W/psX?=
 =?us-ascii?Q?YsKJeE8p2RxJI+b3zim35Fg2D3Yt4XVGODKb0kh2Xs5hA9FTWMW5mvdM3Qv5?=
 =?us-ascii?Q?oAd65FO/6kwTLDakeaMOrixIk2Xcpp8KY6sMdP3CpUCmHkiA0R4m33z+/Y+P?=
 =?us-ascii?Q?qVAMbXi42pmiNCA83SpXUVtnLU9jzyWGFB7d20fdeQtBfgVsh+8pzQ+HF+4O?=
 =?us-ascii?Q?ax0dZCQHE0ZyjOrSqEBArBEulsPMa2iGshC7Kb9kmk335l1BN/E9BWFVyAQz?=
 =?us-ascii?Q?MlG5wcaeLGxoQG7t9lkAfHmxeQqbTPCkS7kAnbclHs1HluqEVWYsYxMiNS36?=
 =?us-ascii?Q?ELp+nB76ysqmqXdoQfPmtd5GomnNVZnRx8uEIiMW46V0lZSGnKzDc41zWEog?=
 =?us-ascii?Q?0qWu7leZ8oEE+N6khKXN+1fp+AEk2xeJDM7zbVuLFebCHyNvjXAaXdrnhoQz?=
 =?us-ascii?Q?srPIH2BBt4M4+agr6grn7PGnD4ZKkh4CZKImQ9S/4IDEIZaPiEq+igplV8iL?=
 =?us-ascii?Q?HY0tGTsZwg2tiYP93zX/M+GUGi694+2dAtZbCk2cvdPjxfEa/mmcyFJc/Vqw?=
 =?us-ascii?Q?r6y/LJRf9OAjCuOBKaTHd/61uQbDtE2XbxgMEiTvPmb9IQyTtyJd41wNR1lA?=
 =?us-ascii?Q?To44sO4/vGTnPNHW+oKQc90Ou4DpAjACVr/EQ/9qZ2iayWfPW7fwL3SMq7CP?=
 =?us-ascii?Q?d5PNs6a4fubScdPMmrqpQmpuqy9RF/aBs2/chg+tuobbhCnOMrvhOi9BcAcb?=
 =?us-ascii?Q?pbM4CsIwnT6P6nEci5/k7eBT8YmfNTXXsmKcbIfdh/+3E0ECZh2caGLP6ohq?=
 =?us-ascii?Q?dyAXP0NyutrkOwxXW9lODcsufPbrSyQkliK8UArCpGyS0n6wGSgUxlYqbF12?=
 =?us-ascii?Q?G+kG3aVkeZfVZ/OTnjeunidfFiULW0oI+hkhmNa0s2WNgN+GeqGuvXa1zeUq?=
 =?us-ascii?Q?E1I90yXnZtm41We3b9SxkQcmQY7t/FHQZWpzxztPMkXsa+ZwMraPQF2awuiU?=
 =?us-ascii?Q?g0Ui8bmVZKYazjt9EfVGfXS4QcRjgQdjLkSWnBQsXXJFhnvwQ6kCOyQKjPNk?=
 =?us-ascii?Q?dv7fKWMpwy9oA1EU9vAAq8adVX1VaQ5qMHLEP80paCMtmSK04bsOz/HeimQL?=
 =?us-ascii?Q?Mh6lzYOiZ1CThllVMYu7Y0y1m9qAOfx2SbqucumrSwGmT9V8gxsgm4uKfyvH?=
 =?us-ascii?Q?pe7N2zqxbdv87ULisJvVAnjhlB7sA8m1asB+j8KEGbZY57+6Yh+WafeLupMo?=
 =?us-ascii?Q?NZigj+f9BVKVxGgiVCAzQdlFTQQB1+Xljoyz0TXpGMJQOM/H89e3ISMaAInB?=
 =?us-ascii?Q?NDVUdZ2exjghKgLd+2nX8gOvenopWMPQJtHe1jH3t0wyTp8ULbEJKTRJZwzg?=
 =?us-ascii?Q?DAIq8Gx3oGie4zR9lDvRrdxBgx34wsdCfcmr28s8u6okEGWqLwYQ4qR4J7kW?=
 =?us-ascii?Q?uruI4atOlM+Rj71EDs4h70M9sjpi9YOooSmKZs+a7gGMFQ/F4Bc3EALKnpRj?=
 =?us-ascii?Q?52BxXoL4tzSjof7Ew7rszXTJzYeco3jPnVugsM5VCtjW46hOJNuYDpe5yET5?=
 =?us-ascii?Q?vw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ecb545f-f92b-4b4d-91e3-08db9429d0b6
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 13:59:12.1121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PVLLMqnaM1+oZE6tCEAR8/H5k+gH+j1TkHOtuKgTAAPhJwWttzLU8+usS/JuaMBvlK16Hq49E3wL7hHqhhF0TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8799
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The workaround implemented in commit 3222b5b613db ("net: enetc:
initialize RFS/RSS memories for unused ports too") is no longer
effective after commit 6fffbc7ae137 ("PCI: Honor firmware's device
disabled status"). Thus, it has introduced a regression and we see AER
errors being reported again:

$ ip link set sw2p0 up && dhclient -i sw2p0 && ip addr show sw2p0
fsl_enetc 0000:00:00.2 eno2: configuring for fixed/internal link mode
fsl_enetc 0000:00:00.2 eno2: Link is Up - 2.5Gbps/Full - flow control rx/tx
mscc_felix 0000:00:00.5 swp2: configuring for fixed/sgmii link mode
mscc_felix 0000:00:00.5 swp2: Link is Up - 1Gbps/Full - flow control off
sja1105 spi2.2 sw2p0: configuring for phy/rgmii-id link mode
sja1105 spi2.2 sw2p0: Link is Up - 1Gbps/Full - flow control off
pcieport 0000:00:1f.0: AER: Multiple Corrected error received: 0000:00:00.0
pcieport 0000:00:1f.0: AER: can't find device of ID0000

Rob's suggestion is to reimplement the enetc driver workaround as a
PCI fixup, and to modify the PCI core to run the fixups for all PCI
functions. This change handles the first part.

We refactor the common code in enetc_psi_create() and enetc_psi_destroy(),
and use the PCI fixup only for those functions for which enetc_pf_probe()
won't get called. This avoids some work being done twice for the PFs
which are enabled.

Fixes: 6fffbc7ae137 ("PCI: Honor firmware's device disabled status")
Link: https://lore.kernel.org/netdev/CAL_JsqLsVYiPLx2kcHkDQ4t=hQVCR7NHziDwi9cCFUFhx48Qow@mail.gmail.com/
Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 .../net/ethernet/freescale/enetc/enetc_pf.c   | 103 +++++++++++++-----
 1 file changed, 73 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index 1416262d4296..d52ac0b6add6 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -1208,50 +1208,81 @@ static int enetc_pf_register_with_ierb(struct pci_dev *pdev)
 	return enetc_ierb_register_pf(ierb_pdev, pdev);
 }
 
-static int enetc_pf_probe(struct pci_dev *pdev,
-			  const struct pci_device_id *ent)
+static struct enetc_si *enetc_psi_create(struct pci_dev *pdev)
 {
-	struct device_node *node = pdev->dev.of_node;
-	struct enetc_ndev_priv *priv;
-	struct net_device *ndev;
 	struct enetc_si *si;
-	struct enetc_pf *pf;
 	int err;
 
-	err = enetc_pf_register_with_ierb(pdev);
-	if (err == -EPROBE_DEFER)
-		return err;
-	if (err)
-		dev_warn(&pdev->dev,
-			 "Could not register with IERB driver: %pe, please update the device tree\n",
-			 ERR_PTR(err));
-
-	err = enetc_pci_probe(pdev, KBUILD_MODNAME, sizeof(*pf));
-	if (err)
-		return dev_err_probe(&pdev->dev, err, "PCI probing failed\n");
+	err = enetc_pci_probe(pdev, KBUILD_MODNAME, sizeof(struct enetc_pf));
+	if (err) {
+		dev_err_probe(&pdev->dev, err, "PCI probing failed\n");
+		goto out;
+	}
 
 	si = pci_get_drvdata(pdev);
 	if (!si->hw.port || !si->hw.global) {
 		err = -ENODEV;
 		dev_err(&pdev->dev, "could not map PF space, probing a VF?\n");
-		goto err_map_pf_space;
+		goto out_pci_remove;
 	}
 
 	err = enetc_setup_cbdr(&pdev->dev, &si->hw, ENETC_CBDR_DEFAULT_SIZE,
 			       &si->cbd_ring);
 	if (err)
-		goto err_setup_cbdr;
+		goto out_pci_remove;
 
 	err = enetc_init_port_rfs_memory(si);
 	if (err) {
 		dev_err(&pdev->dev, "Failed to initialize RFS memory\n");
-		goto err_init_port_rfs;
+		goto out_teardown_cbdr;
 	}
 
 	err = enetc_init_port_rss_memory(si);
 	if (err) {
 		dev_err(&pdev->dev, "Failed to initialize RSS memory\n");
-		goto err_init_port_rss;
+		goto out_teardown_cbdr;
+	}
+
+	return si;
+
+out_teardown_cbdr:
+	enetc_teardown_cbdr(&si->cbd_ring);
+out_pci_remove:
+	enetc_pci_remove(pdev);
+out:
+	return ERR_PTR(err);
+}
+
+static void enetc_psi_destroy(struct pci_dev *pdev)
+{
+	struct enetc_si *si = pci_get_drvdata(pdev);
+
+	enetc_teardown_cbdr(&si->cbd_ring);
+	enetc_pci_remove(pdev);
+}
+
+static int enetc_pf_probe(struct pci_dev *pdev,
+			  const struct pci_device_id *ent)
+{
+	struct device_node *node = pdev->dev.of_node;
+	struct enetc_ndev_priv *priv;
+	struct net_device *ndev;
+	struct enetc_si *si;
+	struct enetc_pf *pf;
+	int err;
+
+	err = enetc_pf_register_with_ierb(pdev);
+	if (err == -EPROBE_DEFER)
+		return err;
+	if (err)
+		dev_warn(&pdev->dev,
+			 "Could not register with IERB driver: %pe, please update the device tree\n",
+			 ERR_PTR(err));
+
+	si = enetc_psi_create(pdev);
+	if (IS_ERR(si)) {
+		err = PTR_ERR(si);
+		goto err_psi_create;
 	}
 
 	if (node && !of_device_is_available(node)) {
@@ -1339,15 +1370,10 @@ static int enetc_pf_probe(struct pci_dev *pdev,
 	si->ndev = NULL;
 	free_netdev(ndev);
 err_alloc_netdev:
-err_init_port_rss:
-err_init_port_rfs:
 err_device_disabled:
 err_setup_mac_addresses:
-	enetc_teardown_cbdr(&si->cbd_ring);
-err_setup_cbdr:
-err_map_pf_space:
-	enetc_pci_remove(pdev);
-
+	enetc_psi_destroy(pdev);
+err_psi_create:
 	return err;
 }
 
@@ -1370,12 +1396,29 @@ static void enetc_pf_remove(struct pci_dev *pdev)
 	enetc_free_msix(priv);
 
 	enetc_free_si_resources(priv);
-	enetc_teardown_cbdr(&si->cbd_ring);
 
 	free_netdev(si->ndev);
 
-	enetc_pci_remove(pdev);
+	enetc_psi_destroy(pdev);
+}
+
+static void enetc_fixup_clear_rss_rfs(struct pci_dev *pdev)
+{
+	struct device_node *node = pdev->dev.of_node;
+	struct enetc_si *si;
+
+	/* Only apply quirk for disabled functions. For the ones
+	 * that are enabled, enetc_pf_probe() will apply it.
+	 */
+	if (node && of_device_is_available(node))
+		return;
+
+	si = enetc_psi_create(pdev);
+	if (si)
+		enetc_psi_destroy(pdev);
 }
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_FREESCALE, ENETC_DEV_ID_PF,
+			enetc_fixup_clear_rss_rfs);
 
 static const struct pci_device_id enetc_pf_id_table[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_FREESCALE, ENETC_DEV_ID_PF) },
-- 
2.34.1

