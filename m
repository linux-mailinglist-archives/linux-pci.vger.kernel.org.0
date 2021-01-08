Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 185732EEFAC
	for <lists+linux-pci@lfdr.de>; Fri,  8 Jan 2021 10:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbhAHJ3O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Jan 2021 04:29:14 -0500
Received: from mail-eopbgr20077.outbound.protection.outlook.com ([40.107.2.77]:21317
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728605AbhAHJ3N (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 Jan 2021 04:29:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X3nHLm3zMTfE1khg8FcwK5UKo+9yibyrb3w8t0JpzDYJorFMuQPoTifBi8M07FPo42838axmj/PRGNaxhGOHWsan6FkLVSt6pc1kv7mWGFh036fQTifaMJWdZbvxRGLUDSpzRuw7UztPQ+vJGFx5wNBtRvkD1zoku5dKBrLJoPZTh0ChlY3g36ho+IA+vwOGuhGhas/de0Vebmta0R5W6Ilvw5tgmlH5gD7PjYj0uMvO+X5IAKbaw7Y0Tdk2aFrSl7d/rZWi36MCQBQ80UpMtxbkhN/qzvCsreh088+Yh7epladyBlLoiW0D4NkaQMBvnr5zimZCKZ/BNLzTH2P/3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hcSaQE8rKOC4UyAeKmUnds8YwcYR6AZV+dzBuGB1fGA=;
 b=d1eFEXL+vK177hdo54i59sw4Yn46JCyE/C9bN0vV4wM2Gn4NsR1qVh69cNgTHcxHILUGQSW0EIg4Wayd9dEMFBc3UEGq3LMvaegvGkA8wujF3VqrgZmmanB20PNsi8o0bC+8MMEJIEnGiwuGWSg1cRpFT6bFNStN5E8EbwlKe5+hmhc9ActAapqe3YpOps58mY0fpeg8T7nDPTkonGo0Zy/XdT8QI2IK5yiv2mIz+qLpJbGXkKcCB/O00lCicTdLJ6ZRUX3lPs4tbXqUIJroU4zKaMukh/BOWi+Y32wJJLq9ZYdeO7W966pUO3q0KI0Z0r+XMv0/cNEHg3n/P5CA+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hcSaQE8rKOC4UyAeKmUnds8YwcYR6AZV+dzBuGB1fGA=;
 b=eJFyiT8xJu1OfuA1U0UKXh9L3t8Htrnm3YA01B2cf5u8MHmbh5zMERHTsoLIh4yBiQKzh1fW4jA2zCS+ThVEgEhyVaPWYhhqKtvPC9K1NRJXVWsNhULcc/VTcG1z7D0x/D+Mo2VSHAnZlI2PbyWdfGbSMpIcSPP7nnbEfq/X8eE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com (2603:10a6:7:85::27)
 by HE1PR0402MB3371.eurprd04.prod.outlook.com (2603:10a6:7:85::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.22; Fri, 8 Jan
 2021 09:27:52 +0000
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::3194:64d6:5a70:a91d]) by HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::3194:64d6:5a70:a91d%4]) with mapi id 15.20.3721.024; Fri, 8 Jan 2021
 09:27:52 +0000
From:   Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        lorenzo.pieralisi@arm.com, robh+dt@kernel.org, bhelgaas@google.com,
        shawnguo@kernel.org, leoyang.li@nxp.com,
        gustavo.pimentel@synopsys.com
Cc:     minghuan.Lian@nxp.com, mingkai.hu@nxp.com, roy.zang@nxp.com,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv3 5/7] dt-bindings: pci: layerscape-pci: Update the description of SCFG property
Date:   Fri,  8 Jan 2021 17:36:08 +0800
Message-Id: <20210108093610.28595-6-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210108093610.28595-1-Zhiqiang.Hou@nxp.com>
References: <20210108093610.28595-1-Zhiqiang.Hou@nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.73]
X-ClientProxiedBy: MAXPR0101CA0019.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:c::29) To HE1PR0402MB3371.eurprd04.prod.outlook.com
 (2603:10a6:7:85::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.73) by MAXPR0101CA0019.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:c::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend Transport; Fri, 8 Jan 2021 09:27:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b1bfb21f-6773-400e-9994-08d8b3b7ac20
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3371:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0402MB33717831B15F24AB810A84A884AE0@HE1PR0402MB3371.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hM4oYvnjNPxm9y58zEL9K8qnlqln/BRAiwqd3V57bHrPIxnwh7wE6yFHCJwem7jcLPB3Jci5JgjCGGXaV/onukznVhBcDbZ9O9RIhn7ZFIPfHqDX6+2UXVtbNxHeI4s6XWS/MnZFutOiwk69l95J77s5T+boRGNKkr1vNntvleVqV9hkttDgi0iF4NdLYcJe04a/TNkR16sO32FhM7Dt1zzaX0uPQ17Dm18tPGtSuHj1cfhAiL/kShGkmUhC4ApURgSNm5RuE0yXvtTSjlvfb6fCPQBV30JTKs7Rlzqgm64yQo7pJS5TpqH0aSPpuhPVXPkZOvsTGTe8nDyl5F/va66VblZ2PLwI4yEMFE3AKIJMiy6ozeqxD67u+wu0NYE73kFuMgaVOzMouYIcm0drF9GWRQLCXw2xpuEJ5auFwYbQTwO2eWbLzFPRI/oSTyTfPy4AgWIfJNxKr358yBTspQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3371.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(366004)(346002)(39860400002)(376002)(186003)(6512007)(16526019)(26005)(6506007)(36756003)(6666004)(66556008)(69590400011)(8676002)(6486002)(478600001)(66946007)(52116002)(2616005)(956004)(66476007)(86362001)(4326008)(2906002)(1076003)(921005)(5660300002)(83380400001)(15650500001)(8936002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?XQtJ4Aeo920iAGGZ/XKIWDkjSeXb8AgLxLdnBJ3hqsunKrf8a1bJcPQUyQC+?=
 =?us-ascii?Q?yrjMvjUJq8WO3Jkr6NzakMY4I9ZfNorpbg1Y6QTYRpB8ZzZF5ZDDA6hcFDM4?=
 =?us-ascii?Q?Is0yVDkvfkNjMVjMzrJXL7EKg4hb3lX/cW0XfohLJrW5VfXK+MQK5rq18l62?=
 =?us-ascii?Q?ucA528GODxAyiHnI2vsN8FJcuCHiAXFwUWVkYgkA9nB+UYa9go22ysJ0/0m0?=
 =?us-ascii?Q?srv2gR6l//gqzGmnHPkVjaTIcK/e12f4PxcPJhBqd7Z07Mine0oz0uof/G/7?=
 =?us-ascii?Q?7fPuSbppK69mulwiM3+YYNQI+r/SKLFyyqaXLuEeZ0ajc8ZtJBxeVilKGgXt?=
 =?us-ascii?Q?0yBs2l7ZgALFa5ASMRAumlyUFL7hVt+5ID/FvpIAVH++K5LtwZtGOuQTAgvG?=
 =?us-ascii?Q?a/2YIiQJ36yEfGY/VMLUKlVlxgDEVXGqv6UWul7UUU+2ntApPKdukj59dpJI?=
 =?us-ascii?Q?I7P+RoIPJkx6xoXPZr6BGWwieANRchVzn37ySdWUBU+TIlA90qvHnMlmEzKO?=
 =?us-ascii?Q?FUh7EWZ4407VcdR+O2R4mA+3cw5hHlZv1O+WA8n1co8dcirl2arLm8m8JLYY?=
 =?us-ascii?Q?PitkYVnU7rsgHAXD+lVawU+b4pa1Eg9EQlU847OIWzzOBlehvpKunwuLEAS7?=
 =?us-ascii?Q?HU2QziUWU1EyKoiTnWp770835LLPNPw+qBvlJ/S5jYwW52nVSDAlmj2OVq+P?=
 =?us-ascii?Q?/BS6fA5d80Kg2lQDkelZVoQlJ2FZq5jvjun0/S7HReTfkzMdgJBouLYwwyJp?=
 =?us-ascii?Q?VLcTYSw9QXlKW4OMq0L9bfLq1uo07M1m/kiLLnEOXB/Kxyvap4x4eozFrpH9?=
 =?us-ascii?Q?BZZkTnyhW+nBs/JWm8qFydt0b5Bv8wTEj8abv/RGEUT+oYd+8vLpnJOBsfEA?=
 =?us-ascii?Q?0e2HBe3FxS0QvJ+6S7MNo0U60dbUa7Lfxmxotr0X5ofHtt0DmXipkV3TARIt?=
 =?us-ascii?Q?ZdWxmizYCF+FNQm7nlm0NQndBOY4ohhRCAdQyPMh2bWxuNumDyZxNi8yfrhg?=
 =?us-ascii?Q?Gpbi?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3371.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2021 09:27:51.9960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-Network-Message-Id: b1bfb21f-6773-400e-9994-08d8b3b7ac20
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5dSSqTMa9t4vGZ33emcKkdL3jpspyJB/izbqG9UDmMQwPfJwaIaF2sPoQASYj/L2JVWLe9WCLJQZXm/A12dE2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3371
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Update the description of the second entry of 'fsl,pcie-scfg' property,
as the LS1043A PCIe controller also has some control registers in SCFG
block, while it has 3 controllers.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Acked-by: Rob Herring <robh@kernel.org>
---
V3:
 - Rebased against the latest code base

 Documentation/devicetree/bindings/pci/layerscape-pci.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/layerscape-pci.txt b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
index 0033c898976e..4228562be505 100644
--- a/Documentation/devicetree/bindings/pci/layerscape-pci.txt
+++ b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
@@ -33,7 +33,7 @@ Required properties:
   "intr": The interrupt that is asserted for controller interrupts
 - fsl,pcie-scfg: Must include two entries.
   The first entry must be a link to the SCFG device node
-  The second entry must be '0' or '1' based on physical PCIe controller index.
+  The second entry is the physical PCIe controller index starting from '0'.
   This is used to get SCFG PEXN registers
 - dma-coherent: Indicates that the hardware IP block can ensure the coherency
   of the data transferred from/to the IP block. This can avoid the software
-- 
2.17.1

