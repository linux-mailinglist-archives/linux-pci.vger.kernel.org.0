Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A126A77C51C
	for <lists+linux-pci@lfdr.de>; Tue, 15 Aug 2023 03:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233716AbjHOBdY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Aug 2023 21:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233438AbjHOBdH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Aug 2023 21:33:07 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2057.outbound.protection.outlook.com [40.107.247.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B562E109;
        Mon, 14 Aug 2023 18:33:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SCSpM65DEfDIzKWEI5rOIVY1juahf+nv3AtpWsfMIFw3RxFx319P7YkDkqnEocuItzTT5cQkYyOzv98mZ8mm4QOG3Q5aR82gu2LUB4buyK0VH4UGPiHNY7Ld5T0mBsSvQgmsu7qD96gzfnzyzazHyQCiVbKYTYUh8/c9Y+jN/kOCeHDa/MGVRMbfaMYLm+UHADcHBhl1MlIDJ+aUw1pE9tQVS93I0nVSZRj3sWK/pu8BHkfHZ/CZKu6o4eyjYgKHtsxWMYspvLdBr1dvN3QsLdvWERvWp4dYkKZAxdVxIMJznGKqYrkMP6NjXRH/tOeoDcPZM2RXpyTN7MFPx86YlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CBlQH6I95/CaTvVf4DdWtJrxC3swCgMtqx5fWwikV+8=;
 b=KVF6OaRxiuRhripAZo95Mur9KBgLKn1wXD+YqikiTvXpy1NTa/oZKds6r0ABmvZ277XqpOnJwP8cbQEx9+er4SEWkDIjZPOr3Dv0MAMvvgna0f/4vTOawQsrlp/9u1RuIqRQVE5yxxNHSWw9Gb1SSmVqpU12aK8KcqwfOd254dW9ADtrk1ogMgfGXoabSFkGBCUVkMzk2TKaEBUvuYjG4WP5f7+loL8mra6+h4IxpDQy3CfBgg21tDjpql3j5qymAUhwKIfzq3+oT0RMk2Lg/bXHFsdR8rNMb2O8ymRDWayhHkWqbnCji8c8oJ/rfosNoKanS7sOSRm7sHuJv3Wr/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CBlQH6I95/CaTvVf4DdWtJrxC3swCgMtqx5fWwikV+8=;
 b=YTi+fNKZEvOyzcJfZg7v6YTK2Poxaz0Fwab6p+sCW2bIpDGCpAFMxIrpSaKPaE6Ybn4EhJoPrDi+7Eozh9TEIsEIl9RNjwlEXJLLU3h/eK2ucDP/OMBSbRWRNtKcyeXdMVJED6VXZoS068StAbaLhkKF/NXmREUs8WyTX88x4R8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8436.eurprd04.prod.outlook.com (2603:10a6:20b:347::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 01:33:03 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6678.022; Tue, 15 Aug 2023
 01:33:02 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     bhelgaas@google.com, pali@kernel.org, ilpo.jarvinen@linux.intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2] pci: introduce static_nr to indicate domain_nr from which IDA
Date:   Tue, 15 Aug 2023 09:37:44 +0800
Message-Id: <20230815013744.45652-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0053.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::7) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8436:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c943db7-6904-424c-a451-08db9d2f90ee
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8gS705ad+JEhlSmki4b3+nmHL+nwVHhkg43khl3ya6i7xXA7neL39mV25TnQszKo9yEcmgR6jNOhIb/MHJT4wQ0lBABGJzjiRGB/p8yXxvHDo2A3pxCXWXFdwxPz9yhTQmGk753nzErKaD66JMEiuCeX5CtOL4h0Au1y5lwoIxmUSIvPnaC8oQSNn2wLd8nelUMcpkSpvdwcFdt+ikGSzBWqrgT/f1zI1A0JZZWQZXLR2Ean9HvgfLtuRTuMjGYpUOnFZyoYNgk+6Z20DAG99E0kTeFgnOXiC3159hydkaTo4kgZiHLKIE6B5fz316jx3sa4UtG2cAh+0eKT5TLsrtF2C03i7KWdoeIC7AxpouqcAIalysWTGZDVP/UHcqpjhH8zIK0EAqxsh46anmBdF+Bn0FDvQMNW3VneJU0+ducgRvrlB0NJARPq0e2z2iV1G9dlZPt/dxsDCA/goAi8DeBzPmuRV+efNtptMoz17MuMraiUmHWfezbNvEVFasKgTsAG3Np6bV4liHMu5apXSBbh9BBMgA7LYwoj/FKaB5MVKx2FW6MKoUUhgV6zUpt0zJFi/yg8ME1PUeYUNA/3Ak9iFAcsKDVe1/fh8QHUu0pb8o6g7CGcCpQ8lktfpMcT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(39860400002)(346002)(376002)(396003)(1800799006)(451199021)(186006)(6486002)(52116002)(6666004)(6512007)(478600001)(2616005)(6506007)(26005)(1076003)(2906002)(4326008)(316002)(66556008)(5660300002)(8936002)(66946007)(66476007)(8676002)(41300700001)(38100700002)(38350700002)(86362001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x0x9SthVh4CI2qhfExpFpYk6XOPfjW7Ov/Xfyo60VmeCFtB6uPs9JJVtLtoJ?=
 =?us-ascii?Q?cYCHBUa9gA4Utjd5laYvJ/vgBbOnhrQX9ap+IxdXpRsH/AK/r5X5oonrtxdT?=
 =?us-ascii?Q?uYGXYPPl7xC3lCyiyf2IFEWhYXyil2FpZDFKbPR48VPE7sSYt7nWx1bBeahN?=
 =?us-ascii?Q?KhGZelciLvNMbhh7ZMyvpLBc65+PxgQlNxyCsFyBQfx72FPXpjmW1u8Z9lYg?=
 =?us-ascii?Q?VGaXPcdwoWrqKvHcaemkZ199p5jkRvHrIGb7gsrZiYEXb91KALgEneMaYAst?=
 =?us-ascii?Q?9sd7t+3DxB5sMKgieXuAbALZfkDNa3thNtymv6N69exUMdPBQQSjcXKRFFNx?=
 =?us-ascii?Q?TC4dS3Ls2gbB8luX3A8LY3iWKfhRF5KPgFvbmj28snP8+Il79E0MlppPzoz9?=
 =?us-ascii?Q?hjMHI5g1PO0KSflrnqUlrmh2YWnsqmDSsQ5zSDnaB4qIAnkXqF1B9y+xsIAf?=
 =?us-ascii?Q?abIXX5CmY4wsI5IYL2V+qoYllyLjLh6qRNhcvJpVXqVSg7pwJYEgDsfF9xXk?=
 =?us-ascii?Q?OrV1iEqTPIhY66+dBLdIr7dknEePiw33pNQARfxRuwS6mVVHefxaECe8iKnx?=
 =?us-ascii?Q?a6JVJPfA0h7+EmKAEaby0O5xW1erqwOQjtDm/x7L+JAhHHFcQJt+cC+GC+c6?=
 =?us-ascii?Q?Q2VZOHmRPHbb8yGLVlrPKJZxWhBNwHzF4t49SrTlnIhzy+Ox8+ilzipum2cS?=
 =?us-ascii?Q?aycSA3/bzXo006Lc8mnNyMtpoz1SRK2EY3p5yFCLDl3opGlJbLAk0MeQQBIs?=
 =?us-ascii?Q?dLi9KjPCv/v5Bmf9dAy/gJUf3D50ix8blXyHuB5akLivk94f9b9qhtOOkspU?=
 =?us-ascii?Q?0+06OqdntyZUp0X6+MlHdt6eM0R0++DhRarOIj7Ie9lE9sfZq7GjgeXoX1UD?=
 =?us-ascii?Q?ES1UMEhtS2eeb89Ie9UNeamFsAvXfcxU9yO2meOC6zpoHv5e3UGBLPWF3ur4?=
 =?us-ascii?Q?Salaa/5PgPgLTi6y3nk7ygIVBDyQtQLJhl2UbTteKrEL4L8NgujY4wfM7Fm9?=
 =?us-ascii?Q?/uCZU4tiZyt+dhHEZgtQB6G3tp7JDrI0jhCHih+TStPPMSgPR3NOQ+Dgnzv9?=
 =?us-ascii?Q?qqTyu02itzZMd9OVkPoNyoRFcNJAUiUPeXQLXowm8DCnwUk7qDal3+uknXUc?=
 =?us-ascii?Q?OZKaI2Irwc6a+Bs1TsOXA1A6LPaheyAERoD7mREQX0ddNgVXHXQIUpJDrvpC?=
 =?us-ascii?Q?EWGAWoGB1Rox3D9/G2G2ZLy3I51CJNvN/OgWdv9I8wCEphterV6aPoJhyMF4?=
 =?us-ascii?Q?KAroPv3vdhN6ISzQ/CBPN18nfsVAz6gEeB4kyllReop+vMOqjg6z3tYRaNxL?=
 =?us-ascii?Q?K9vIqz6rQyFphUg93dBLuViDlIjMjrwzZNW7rB1PYZP7pB0fxJHCSx9HuHZp?=
 =?us-ascii?Q?G3l0Gd9qdoBN5Vvpbxc7RLwGdJ81SUZuWSXVUzH/tGd15TXEmOkGJgFnA27W?=
 =?us-ascii?Q?2o53X8kPzIPzSpVEpSg1h5jqfeJilY4pJMDPFos4ADjnO9znzLVMSMWrU9oq?=
 =?us-ascii?Q?6ZR8282vzQJAXM1na5WtR4KbVR/8udb30D/t5LA+8b6fY+iowk4xPKtGEbN6?=
 =?us-ascii?Q?3hIy5tgi6nMcF8myTvf7w8uq+6cDCSpijp+3V02I?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c943db7-6904-424c-a451-08db9d2f90ee
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 01:33:02.8725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YxwMhp3gjy1ob6yGjzwyoTiJCqtghy9PB3B5u0tsBBSdm4/98nrv5Wdja3XW8jOD3H+PEWR1v8KV1dDJlj4YcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8436
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

When PCI node was created using an overlay and the overlay is
reverted/destroyed, the "linux,pci-domain" property no longer
exists, so of_get_pci_domain_nr will return failure. Then
of_pci_bus_release_domain_nr will actually use the dynamic IDA,
even if the IDA was allocated in static IDA.

Introduce a static_nr field in pci_bus to indicate whether the
IDA is a dynamic or static in order to free the correct one.

Fixes: c14f7ccc9f5d ("PCI: Assign PCI domain IDs by ida_alloc()")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V2:
 Update commit message
 Move static_nr:1 to stay besides others :1 fields.

 drivers/pci/pci.c   | 22 ++++++++++++++--------
 include/linux/pci.h |  1 +
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 60230da957e0..5c98502bcda6 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6881,10 +6881,10 @@ static void of_pci_reserve_static_domain_nr(void)
 	}
 }
 
-static int of_pci_bus_find_domain_nr(struct device *parent)
+static int of_pci_bus_find_domain_nr(struct pci_bus *bus, struct device *parent)
 {
 	static bool static_domains_reserved = false;
-	int domain_nr;
+	int domain_nr, ret;
 
 	/* On the first call scan device tree for static allocations. */
 	if (!static_domains_reserved) {
@@ -6892,6 +6892,8 @@ static int of_pci_bus_find_domain_nr(struct device *parent)
 		static_domains_reserved = true;
 	}
 
+	bus->static_nr = 0;
+
 	if (parent) {
 		/*
 		 * If domain is in DT, allocate it in static IDA.  This
@@ -6899,10 +6901,14 @@ static int of_pci_bus_find_domain_nr(struct device *parent)
 		 * in DT.
 		 */
 		domain_nr = of_get_pci_domain_nr(parent->of_node);
-		if (domain_nr >= 0)
-			return ida_alloc_range(&pci_domain_nr_static_ida,
-					       domain_nr, domain_nr,
-					       GFP_KERNEL);
+		if (domain_nr >= 0) {
+			ret = ida_alloc_range(&pci_domain_nr_static_ida,
+					      domain_nr, domain_nr, GFP_KERNEL);
+			if (ret >= 0)
+				bus->static_nr = 1;
+
+			return ret;
+		}
 	}
 
 	/*
@@ -6920,7 +6926,7 @@ static void of_pci_bus_release_domain_nr(struct pci_bus *bus, struct device *par
 		return;
 
 	/* Release domain from IDA where it was allocated. */
-	if (of_get_pci_domain_nr(parent->of_node) == bus->domain_nr)
+	if (bus->static_nr)
 		ida_free(&pci_domain_nr_static_ida, bus->domain_nr);
 	else
 		ida_free(&pci_domain_nr_dynamic_ida, bus->domain_nr);
@@ -6928,7 +6934,7 @@ static void of_pci_bus_release_domain_nr(struct pci_bus *bus, struct device *par
 
 int pci_bus_find_domain_nr(struct pci_bus *bus, struct device *parent)
 {
-	return acpi_disabled ? of_pci_bus_find_domain_nr(parent) :
+	return acpi_disabled ? of_pci_bus_find_domain_nr(bus, parent) :
 			       acpi_pci_bus_find_domain_nr(bus);
 }
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index eeb2e6f6130f..222a1729ea7e 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -677,6 +677,7 @@ struct pci_bus {
 	struct bin_attribute	*legacy_mem;	/* Legacy mem */
 	unsigned int		is_added:1;
 	unsigned int		unsafe_warn:1;	/* warned about RW1C config write */
+	unsigned int		static_nr:1;
 };
 
 #define to_pci_bus(n)	container_of(n, struct pci_bus, dev)
-- 
2.37.1

