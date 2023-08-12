Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65856779FEB
	for <lists+linux-pci@lfdr.de>; Sat, 12 Aug 2023 14:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbjHLMQw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 12 Aug 2023 08:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjHLMQv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 12 Aug 2023 08:16:51 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2047.outbound.protection.outlook.com [40.107.8.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FAEB12E;
        Sat, 12 Aug 2023 05:16:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UQRIyRphhk9nd5Dr9cf5lLhToyu5wyTbaqeRNNeLf04FFsSNjBz0vrfyIBkXnR7ABZU1IwpltEAhcP/eZ65I4SVzq3cfI0kVIKLX4gSJfkBi+c4bodv0wp6nBDzoD8akon42LZSLhUFUW27xmb4AJgmtlhwPdKkIQeDswEE7FY/h+aAaabs+w9eK41xk6mrNdkzRmUtVotlc0HiCiN5NFgXz2uBlKILsm2rlbxndsTHECwLyjR6S3DicVy/eDe/NHkIXxp9wjQpfGyt79Mwz7oCXsjl1deKBNXh2LlVAloLZBJAXY7uySZUVuMPJzFqD6liKQ4RMODfHdWZp5fipvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NVQxb89hkdh1Vp8fY0E3LrlJJe9AqaPTVj+3hrM07Y4=;
 b=AagxY6BpOlbV5v6X2sVrGrqfFM9ejIufNgeJa+FKT9xRSdFu+9vTF0WKgQv0WIm9RTxbzfJSFdPtV7hiBRgYGBRLTwWzBLBSwrG2doPXVqMNU7B054wLGJV9X993T7VT3Y8FKkAaA5qPY6oWYUr/HAr1LKCnXjNd2ewztiiz1GOfbkfQphp7Mm1UjHi881nyCMD32bzmVEQNiHfHcLJRmn/aM6YxnV9GiAHARsxuxK/Tg6Q+RY3OMKjB5NKUTX1sVqmo12Com0Uz16BzutHpMGvVBjKgD8ehlbXgj8znIdsCE17VdLturnXVV7lnoFQja6XSXUuoW1g+Bn72mk6ASg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NVQxb89hkdh1Vp8fY0E3LrlJJe9AqaPTVj+3hrM07Y4=;
 b=dmI46JFxOe010wzpPcxsZ68Zdnd807UYF/B5lMv5XZc2qp17/lMGlPTSmpss+1o/06O7E9lrNUdUNn7ZBKAQQwG+UaUrE9CNogXeVybtd4WoI92MP0AsfqqX5m68k+fYMfwr16mjErSSd+hKdp0qFxzothqRDn6sR2tsFuM8cBs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DUZPR04MB9846.eurprd04.prod.outlook.com (2603:10a6:10:4db::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Sat, 12 Aug
 2023 12:16:49 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97%6]) with mapi id 15.20.6652.025; Sat, 12 Aug 2023
 12:16:49 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     bhelgaas@google.com, pali@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] pci: introduce static_nr to indicate domain_nr from which IDA
Date:   Sat, 12 Aug 2023 20:21:28 +0800
Message-Id: <20230812122128.3409733-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0198.apcprd04.prod.outlook.com
 (2603:1096:4:14::36) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DUZPR04MB9846:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d4caa33-60df-4c1c-91bf-08db9b2e00dc
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 58ShpB/csp5y2kp4T5/B4A2J1omuJRbTBpf/uvldFl73sFjiBMaPxpO46HxKMArUTLyeDYIb7AP0JZdcP527xYGUn3+AkvpluWrhAwWNujG6/WqOZyWXZYE8QLVEiOSaxzk4zaqUxtgDiQH922mLEfm7fedbQn8jcz3n/5qFw06jlhPBb7ut6xLwqK9VSvPTIkNMuZWbbrQMoBsTmIpLYAcLJ4Wr6YN07c46QUqhaFRtK43ikq9PeEX+RkLLoJpZ/4akQh9l48FrdBgSRXP+VmLQFWh6tdeO0b0BwYEJ1JU+NRVglhNfkZJhzrE3yXXw81+GEOIorPu2y4gy4p9IbSntFlVfe8XxCFqduzCiwyNWskBvKRfIAFA4JF2yAgA39Of+cs1A3krNPupbT1KbCUH8phL8fQNoaOg9kTiadQ9HkctS/D46C7b3FtFMQUSXp8aszi534gxiKQ+QVbvb8Dx9HNuKtASEQSZYwFkorWQgv9TLY/WtqZq7xvNOjpr23TMfD/PsrQu3Pn81c2G8vi9nPD2oja2IhhoSp4Ypd04uLiVnfMcI5GpQd46rQy7I9YJffyuXRsxiXA/F93mg5VbM/gIZi/Kfm3QQt/79PKk0jKeQp2vO3Ua+qeIzDZHD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(136003)(396003)(376002)(346002)(451199021)(1800799006)(186006)(4326008)(41300700001)(8936002)(8676002)(316002)(5660300002)(83380400001)(86362001)(2906002)(6486002)(2616005)(1076003)(6506007)(26005)(52116002)(6666004)(6512007)(66476007)(66556008)(66946007)(38100700002)(478600001)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mc4THQcfUGa6RLIJ7tt33i0Q+BqdWcb02EzE1pk+DrX6PrwpQd3dQkRsXOnV?=
 =?us-ascii?Q?UF5q+OCrEb6IUMLosjc+z9h/lxAti/QH+HFoUKQGIFhu0I1hwKH4WXPZvPvW?=
 =?us-ascii?Q?knmo7CMYJctzaPzW8cqAnYKXcw9bjQkGQrtCLT37uJHypthiuGv/cTfefDl5?=
 =?us-ascii?Q?F28dVJC4uAEHl752y/NWP5egjGvFybG2WwDRgxpJmBeFNhNoifRt63ev6Niz?=
 =?us-ascii?Q?Zm4rXoa8VHdi31GAjCmvZrHL9S9oV3KihlgakQmFtSCHl+jPhf7rH+uXdwal?=
 =?us-ascii?Q?zM3cYtbrxNykN4sKUvYmbEIwKp8BjEbG743udskTaDjSnMe0YyuOK0rIc3Ai?=
 =?us-ascii?Q?9sgznnLQmg67K7nG5j8if/wCm2nIB/FjOIFh5D2ERCD+zybpnCtXvFO6vGCP?=
 =?us-ascii?Q?oWujV/Oc2L/0QXVD6c2OKMj6l4ekgoHuSdZYsfT4Xua1SMr9zqZpvxrqVbdI?=
 =?us-ascii?Q?GIdtaCGy0tKbgjRf1WxZOaxZ8ZiZNb/am47FjSWVgD4yL+ZHSh9xTjghu20G?=
 =?us-ascii?Q?1l6snkRYMrmTRLKJISJGZ2xtCwkW41+7nhFH9yL5fB6iVMj3JYP15Ck9R/y9?=
 =?us-ascii?Q?1GjFzq5qj1O48UPAib6LdYSrkE/X+b/aNBKXE5r9N7wOLSruzJG10E0yQMyn?=
 =?us-ascii?Q?a5KOZMoVlRZQxfn0fYzyte8Sl7yUuDwJXpvoRCbJeoZbDrPov+p+kyqHuW4S?=
 =?us-ascii?Q?K/TaatVSc6ZL0TzdxaTIlDr+J4O8LIduvt3cLt6ca1pwgImE3BlAgGYat/66?=
 =?us-ascii?Q?ZLOxcBecHHaeyAtRDIgou0ECJIntrHHC/Hsq0XUivQA0WUYJVhwVQTwi9hRS?=
 =?us-ascii?Q?FliRWIPG9ejQeK+5B6gJoEN76veCT43xMdpi1vpoeZGsRUKLknmPVsmukx/b?=
 =?us-ascii?Q?QRxNPmrCAM7DQKS/vtqnsYiN3ri7s536uL9msb9WTcNKKEg5WRTwzUrmxJvw?=
 =?us-ascii?Q?u+p4jW9Z07tfkQQ7W7AIs6nJbyMe5eO4kgHnc7ZZSzd/Z7I2e9gJiQlECCUF?=
 =?us-ascii?Q?Z+TNIs+96dK+Qt66CHBFjGThcAGO5caMwC7C/WjTK8atHaGQ16hUbUv9pNmp?=
 =?us-ascii?Q?xpeYXu1icvmg1WdXoe9nJIRR+hJ1m6JGZAY8mKxWJ8jSHKAokU4u1klY3hgo?=
 =?us-ascii?Q?3s1XSWktQFDNINJ2cjvSRvWNWnoKphHg4da6FUJCleZvafRWGXG+F6Eh9PFx?=
 =?us-ascii?Q?+ucbg4Nne8IQw9NtZWPEWTOzcUJGnDarWDLalG0HEeXnQ+/0VAZ2VHPFQs4O?=
 =?us-ascii?Q?LktiLsaCTHu+CTDPsku8oz+tot+zTSDl92jhxMm48D0c/L0oAWjE04iBXaVS?=
 =?us-ascii?Q?RZh1PD9HALLmnn2NYnps/qsGDCgtim55GpeBhO0I/jCdq72pGqqtf62OPsU7?=
 =?us-ascii?Q?L6ZXZLDtIN0JX6w/lxyJKKD8nrV58YPsxLzVrEIvwvX1lCqzxD1ZoQ00u4kU?=
 =?us-ascii?Q?BTlhASE/AhWQD1pYHZbrn1sn7SLRWkvY7Ki2Xl3Fe6QW0ZNhhWkUnxP9MgTQ?=
 =?us-ascii?Q?iIMtyteaubblHNTNHvytp2Er4jl1dkqqS0kLJSOBSo4yec+KJIf/2D48ZU7v?=
 =?us-ascii?Q?a70FRfXSZleprDl2eIdEdpTWKSveVUZIDZvMs0xi?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d4caa33-60df-4c1c-91bf-08db9b2e00dc
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2023 12:16:49.0777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KSuqYFnB/L4XOLW2F+DdVRHjHr0a9u+R5xgDJc/XEEf5vVSSXmHmS8JgUJXfCu2zEGQTNWoxgU+jZGgEKIcYEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9846
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

When pci node is created used an overlay, when the overlay is
reverted/destroyed, the "linux,pci-domain" property is no longer
existed, so of_get_pci_domain_nr will return failure. Then
of_pci_bus_release_domain_nr will actually use the dynamic IDA,
even if the IDA was allocated in static IDA.

Introduce a static_nr field in pci_bus to indicate the IDA
is in dynamic or static IDA to address the upper issue.

Fixes: c14f7ccc9f5d ("PCI: Assign PCI domain IDs by ida_alloc()")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
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
index eeb2e6f6130f..6dd16e069ab8 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -665,6 +665,7 @@ struct pci_bus {
 	unsigned char	cur_bus_speed;	/* enum pci_bus_speed */
 #ifdef CONFIG_PCI_DOMAINS_GENERIC
 	int		domain_nr;
+	unsigned int	static_nr:1;
 #endif
 
 	char		name[48];
-- 
2.37.1

