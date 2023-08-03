Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADCD976EB60
	for <lists+linux-pci@lfdr.de>; Thu,  3 Aug 2023 15:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236414AbjHCN71 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Aug 2023 09:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236388AbjHCN7X (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Aug 2023 09:59:23 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2077.outbound.protection.outlook.com [40.107.105.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B5410D4;
        Thu,  3 Aug 2023 06:59:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VtKxs6z3d1M3zel/UYS2l9cZjF2MF9LWZpmz3Z2HrmYx13HPjBXD4NDl+yojFZBoroH+hiCKYMiwrfX0HIFvvmdWA5gTrK2RThit2Pk1ohYjW2BkEVkoges6gJrwgcxcAF4155jlw8ivcbAF+4+V7h1LkKcVoJLIAXZyEaNzDgQ/4QWRa3nHXGfsmxzeBSXtQ0nx13fnxsw6D+UsrZMlHS2Ti3aEeIN/4VLamM6TvNR1CumWzFhDDDaGJyt0NCIW9Qm8RUXo6kqwPTaPHh/V7pZe1lCK+tMh5o1+2gcx6ckk1c1fK4C3zVh+fYzBXRZQYBZVKR8yxhbHNkmlTqtNuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tIH3D4R/X3JWuiW157ch1VpvqT34SPIdGu6sH4HO03g=;
 b=HMMn4eGh9NY5iY4neZtQwJsPvNz7rfUbrTIlPBr+GxSRcoHF+ZBL9gPWdp79bLowYQTzpqgqgeMSjCveKW7UbHeDymc5+EaCtYt9b4UrXkN4iDvH0ZOT+y+FXuBc5zyU0pGG6DFO+eyxSvdKbNTS2jJBlXrZTqbm9dN98Qqhi6qQ2LIY2I5kqe5O10S/FFIOYvPgUT1PnwHvXuS/+2ePyhHBCjUz7e9zV3rImhvJrn+fN/Q7wYmZvhyaNNTnWElYgmiOyGLZFDBzFzoV5p2sIqwgBd4Etthl2/NkYvrW6hjBjRXzvs796xKW6gXCdz3cD9a8fXksgdyOf3YBWhVQwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tIH3D4R/X3JWuiW157ch1VpvqT34SPIdGu6sH4HO03g=;
 b=dqQxf1nMysulUQRG6dZiK+HgJ3zRCgEtEkjFoW+aEqcQH0vRU84NgboyQgilGvEO53dDoG4lnmiiIqZ73MAIs9p+p3COXTvdUj7N/GO43DNv+OoCWyOVfpdqroDIheasEEoAxTmvahwdS/kBpd5ozhsffHGged7K0hwfzgQoQn4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DB9PR04MB8362.eurprd04.prod.outlook.com (2603:10a6:10:241::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Thu, 3 Aug
 2023 13:59:11 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::6074:afac:3fae:6194]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::6074:afac:3fae:6194%4]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 13:59:11 +0000
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
Subject: [PATCH v2 pci/net 1/3] PCI: move OF status = "disabled" detection to dev->match_driver
Date:   Thu,  3 Aug 2023 16:58:56 +0300
Message-Id: <20230803135858.2724342-2-vladimir.oltean@nxp.com>
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
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|DB9PR04MB8362:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bdceadb-b188-4e60-7404-08db9429d014
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t5bmnrLzNXpHDv0M5PaHBBoVt9uWeRqrT/bTY5uZcK1aRzbrvMyXrGX0iL37G5vz6fLxR8fR73FPXEduuvBLWFyy1mtM979rqgRb2p2V11y3oSrFyKwqgcUoAOa9lD7ebLqNMDtZR8LhZbj461uq5ihZtAJBnUH7HbNvuejDZr9p+ixEHiHg6rj0HBq8PzotvmCO4XxqlX6jPOkuBhoL1VewOt4CqTtTK0R/Uq/aKEdp5xXYZ/xjlelyKucXzGLRCclwvcGyImkWyNFZeH3KUAL2Vi6cQJJFiaNsDsXqTcRMPz5DqftvLaUdo9fWMDg5lHRYEp2rdtxqmIpVmvJfbbrObOneUSqlECBmv+7l4r8oVDTur5FoiOSgh1hpyyyzqoD7yjRt+5dei5Ih+OKHQlIc42ZzUhtUn8EU2J/5vEP4PjNzzh07aOyzINUiOJiiZZJwQxwpVrcg8b+F0QuoxOqs4SpSpoccoB2z3VG3v61CfRu2MoEeCFtl6xj+j+AbOYPqbtymSaGeBZZi2I5roCX7vx6XoFRKKicoOnNcYMU9QQOATpzcgXF1cMKw8LGGIcs8S4jNaMF+DPZCraCiDnW9ICWg6rf9yUb8dU3O9J0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(346002)(376002)(366004)(451199021)(83380400001)(2906002)(44832011)(2616005)(86362001)(36756003)(38100700002)(38350700002)(41300700001)(6666004)(6486002)(54906003)(966005)(6512007)(66476007)(316002)(4326008)(66946007)(66556008)(26005)(1076003)(6506007)(5660300002)(52116002)(478600001)(7416002)(186003)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mlmcJ/2FV6d1Nm8Gyb1RQc5aydGBK9ysg9gkhjOh3ttL5FWdVOMmVeVsInS7?=
 =?us-ascii?Q?Ae2p+2rfvPoitfdZM8z57yM2c2zL1C9upnOzIViZNC3Li+wYVgtbioN9TIHH?=
 =?us-ascii?Q?U+P852NFzTjiQqtktXezsVbs9PCAJ6X4M0poS1+X/wUO2du4KBmMyIhzJESm?=
 =?us-ascii?Q?zLvEUsqP/GVY6Ux35BS65N24M318IGLuxlwfGc0U10hNa7o5wsA3qGVgB1IK?=
 =?us-ascii?Q?hOnbKjUNnAloaQlMgSxj6tPjlATSQg2P51Dopaw5+mFFKaKoF+qPElYauld5?=
 =?us-ascii?Q?a4Y5gR41BhLYmn2Casc7E7ztR+C9Knd+RPsmPdtqWNozgWu71aEqeP0rB3qx?=
 =?us-ascii?Q?ffo1ZgNkX2uhf71OLl6+QmOLFi2tvipGl/d7T/q3xQ8j8u9QjBr4GgFK0Fr2?=
 =?us-ascii?Q?wYkO9Y3vvwWXCpTzWbhEJXImRV6VwWXQdr/iKdn2ZrFV2Wtd7o0NmaZFny8k?=
 =?us-ascii?Q?M9Q7tt6eoPgLmzUsLXpIdvPxmCt2Vm3y2mN9rR/YPwe5j1Jx/x6r/1GNd8OD?=
 =?us-ascii?Q?ID2qLcKlrclGGoEPK+aYYjZ4ITzRcF2P13Bur6M2AfH1e3fO7qDWp9DpjEhg?=
 =?us-ascii?Q?un+e5DNl+g7KEjVDk/b2s1WgcvpBUVQjAazgQ0hjmbx5NvhyaxwV2KSEn8Yy?=
 =?us-ascii?Q?SCQKbemxvtnpg3y2REtJezCnaanPTrj8QEveoy5GGZxrq6OPaK22s8v4Ekgc?=
 =?us-ascii?Q?fQKGPETeoiC9sAIXbMq+t13ZwdyZrx0zKLVdgn4wm2pZrLknVNG09ElKdBWe?=
 =?us-ascii?Q?P8I7Tl1GOeGCpzo92hj7k18K0pGJEBdqBaRVJLnX2U+4YLibGr64GMKXd3V8?=
 =?us-ascii?Q?uY6FGBa8Sw9Oa6RD/X2zZkmO+XIXfXArTW+KHF1ByUrsE2kWPVNgFLlT4FaZ?=
 =?us-ascii?Q?Ynbx5+FwCB3t9v5dt5tiRh4/jgg13F9Wsci2oT1W5eY+LEVEKpEbnUougAht?=
 =?us-ascii?Q?/sZ+FFmjWBww9WBFfF2Z24ZrRWAbLIR9uFeU8QTRkKYPe4PNH+Jn81W9wabs?=
 =?us-ascii?Q?2inoy7eQz6YASC3nhDnnQrkdST6voh2F6cxgehHMq7tQCnnS9FwfkvfYvf2x?=
 =?us-ascii?Q?Ft2kGL65K/+Pme3yR+twLqX99kXNipkhAKDNNDvjYlfa1ySqlCXa35Bl6nrt?=
 =?us-ascii?Q?P6TyK6ZlRZ/3hz1MI1JeRZUw/zsBet9v8QXXl/4WbwT+8oGdOVTjNC1ZuH+t?=
 =?us-ascii?Q?eNpAUFVIOjLl6zbScf5p3z2M3ageiNrpUHG+pQ715iDAVDZfGATDwkWDI72h?=
 =?us-ascii?Q?jKS3LokL/usaKRmtqajEoAiCqRFyB/wTuqCaB+eKenEPWMW1Zn8o8LVd3Wq6?=
 =?us-ascii?Q?LJPdGanK6Ovciawcu2hVys3UoclVgOdvllndBLlfWw1taGTXIi7KHR1mw9Uz?=
 =?us-ascii?Q?CXVDj3p5+jkI8WyYg6mwngnSyN2ls5dJ4Ac9/tAj9ysyA8KAOYSf00F+un4+?=
 =?us-ascii?Q?AcvqkjbF3ms+orGsB/BI7V9TIMJv/cBKwIUNpOSVtR9ya1TTT9HmxbolohCh?=
 =?us-ascii?Q?u4ALos15TpUdzeUJB5OyRSpwbaIzglC0110LTvLeRIR719poEMNO/pPyPFFl?=
 =?us-ascii?Q?9egb8K6SLabPORPvc1TX3Bz1ccuN4UvHBc9QvoPohtthVVhk7FlGCJIkb6s1?=
 =?us-ascii?Q?5Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bdceadb-b188-4e60-7404-08db9429d014
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 13:59:11.0368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zFWjDsA+5SAl55PSx27l2gsr6MhQ49+yaoplYV7qMe7OXYvyNR5q+zc6qK9Px8JuUrvt2IISRbmy77kCex7jiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8362
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The blamed commit has broken probing on
arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi when &enetc_port0
(PCI function 0) has status = "disabled".

Background: pci_scan_slot() has logic to say that if the function 0 of a
device is absent, the entire device is absent and we can skip the other
functions entirely. Traditionally, this has meant that
pci_bus_read_dev_vendor_id() returns an error code for that function.

However, since the blamed commit, there is an extra confounding
condition: function 0 of the device exists and has a valid vendor id,
but it is disabled in the device tree. In that case, pci_scan_slot()
would incorrectly skip the entire device instead of just that function.

In the case of NXP LS1028A, status = "disabled" does not mean that the
PCI function's config space is not available for reading. It is, but the
Ethernet port is just not functionally useful with a particular SerDes
protocol configuration (0x9999) due to pinmuxing constraints of the Soc.
So, pci_scan_slot() skips all other functions on the ENETC ECAM
(enetc_port1, enetc_port2, enetc_mdio_pf3 etc) when just enetc_port0 had
to not be probed.

There is an additional regression introduced by the change, caused by
its fundamental premise. The enetc driver needs to run code for all PCI
functions, regardless of whether they're enabled or not in the device
tree. That is no longer possible if the driver's probe function is no
longer called. But Rob recommends that we move the of_device_is_available()
detection to dev->match_driver, and this makes the PCI fixups still run
on all functions, while just probing drivers for those functions that
are enabled. So, a separate change in the enetc driver will have to move
the workarounds to a PCI fixup.

Fixes: 6fffbc7ae137 ("PCI: Honor firmware's device disabled status")
Link: https://lore.kernel.org/netdev/CAL_JsqLsVYiPLx2kcHkDQ4t=hQVCR7NHziDwi9cCFUFhx48Qow@mail.gmail.com/
Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/pci/bus.c | 4 +++-
 drivers/pci/of.c  | 5 -----
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 5bc81cc0a2de..46b252bbe500 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -11,6 +11,7 @@
 #include <linux/pci.h>
 #include <linux/errno.h>
 #include <linux/ioport.h>
+#include <linux/of.h>
 #include <linux/proc_fs.h>
 #include <linux/slab.h>
 
@@ -332,6 +333,7 @@ void __weak pcibios_bus_add_device(struct pci_dev *pdev) { }
  */
 void pci_bus_add_device(struct pci_dev *dev)
 {
+	struct device_node *dn = dev->dev.of_node;
 	int retval;
 
 	/*
@@ -344,7 +346,7 @@ void pci_bus_add_device(struct pci_dev *dev)
 	pci_proc_attach_device(dev);
 	pci_bridge_d3_update(dev);
 
-	dev->match_driver = true;
+	dev->match_driver = !dn || of_device_is_available(dn);
 	retval = device_attach(&dev->dev);
 	if (retval < 0 && retval != -EPROBE_DEFER)
 		pci_warn(dev, "device attach failed (%d)\n", retval);
diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index e51219f9f523..3c158b17dcb5 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -34,11 +34,6 @@ int pci_set_of_node(struct pci_dev *dev)
 	if (!node)
 		return 0;
 
-	if (!of_device_is_available(node)) {
-		of_node_put(node);
-		return -ENODEV;
-	}
-
 	device_set_node(&dev->dev, of_fwnode_handle(node));
 	return 0;
 }
-- 
2.34.1

