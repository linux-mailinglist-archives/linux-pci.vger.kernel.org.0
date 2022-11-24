Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B93E637AF5
	for <lists+linux-pci@lfdr.de>; Thu, 24 Nov 2022 15:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbiKXOCL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Nov 2022 09:02:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbiKXOBv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Nov 2022 09:01:51 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2107.outbound.protection.outlook.com [40.107.20.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75970168B07;
        Thu, 24 Nov 2022 05:59:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=anXj82PDgZayXz6GJg/3adoGxE0RCUvgfL9agNTc5OErAXYsBRMxEdw82fJfHCDAV/qVcJdlaoh/db4Sr+HNhVO5uOg9MIFM6Pa8kT5dXmp/vaAdWT21vy6103q2CFJG7LQsXHe9lvPjik82Zqtcy60xL0UXO9yT9JcQsrYk/ogH2JZrUENYImSHoUR2ZoDXi53gLfqfOziNFMJqHCAfwSJPizPqe+0fVk2F4w32YtU5c+oQvY04QSjkYkmSxNAhhQw2Pg4F18wkGZvb+j7fs7PzLEU0+0UFtrN9TolL6F+w337QVY3RYoIDiYMQznbhyS+X0wqqK7fCdVgnhku9jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yOFx6ykw4Yty05usC03e13PABLmMILjwHo0n3YtWomA=;
 b=JZAiMNr3XEXHE/FLvueFxLFf/1KhjkUz6FmGJtLWhU1mDtDXw1+F+qIaP7H/Ua0SYaRGSOdZzu7A+4i2AvGrEuJREj9zH8EJh8Z8/ytUzZvx4UfBWbgc0RUNvT2e+8oS90lsRAY/NBFw84VhWEeFJOi4njTUDlvhHCw0cVx29+dIG/Mrj008ykfBVwkEAqRt+MMLpHJ2nGe+FAkWNp7UGSAEwc3IKDj2C4W13WurL9UlOLQWObrL+xsazGb+XaaLr2rd2Jl+0uz1YK4G8WkE2Xe/utiwb24OxBDozABuwo2MDux3nGcoPwTVYsHGj3BCarMQWagObw90YJjwKK4siw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yOFx6ykw4Yty05usC03e13PABLmMILjwHo0n3YtWomA=;
 b=vgqGJJ3YBjMEMT7sZo0Ixllj9U7togNlAlUoE8ZLxj4ItOb7vNeMVgCAsZPuemrWXnjhFjSQwESr3YQL8gysMJOq6z2ZP8nXsTBSPi2QN+ca4WJ5HuD85sQBFBKXgEI1VRZpE8b7MJs8YLljDojvWaLKZq8YU4nItY0xvdXj7Bg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=plvision.eu;
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:38::26)
 by AM7P190MB0758.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:117::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20; Thu, 24 Nov
 2022 13:58:53 +0000
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::5912:e2b4:985e:265a]) by VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::5912:e2b4:985e:265a%3]) with mapi id 15.20.5834.016; Thu, 24 Nov 2022
 13:58:53 +0000
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Elad Nachman <enachman@marvell.com>,
        Vadym Kochan <vadym.kochan@plvision.eu>
Subject: [PATCH v2 1/3] dt-bindings: PCI: armada8k: Add compatible string for AC5 SoC
Date:   Thu, 24 Nov 2022 15:58:26 +0200
Message-Id: <20221124135829.2551873-2-vadym.kochan@plvision.eu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221124135829.2551873-1-vadym.kochan@plvision.eu>
References: <20221124135829.2551873-1-vadym.kochan@plvision.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0120.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::18) To VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:38::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P190MB0317:EE_|AM7P190MB0758:EE_
X-MS-Office365-Filtering-Correlation-Id: fc024538-8a7f-434d-655c-08dace240584
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4hqvBV8gKRt+8VayVMYW/cmCUnqkRk0SI5gqEZd1vUPt7nIgtEoeyRq6MBF9pa2AnGACaATD4qTo83yVXhqHBp03dV1poK3roFPD3kbHd/SM0Ywk9tGed4QGFOICgKCcAvFWIOGtRKMnLg8hYW8pm//mnvzmHpV5XxGZop12VimiyQ4SspPi1Be7hBjU5223OOpwqv+a6VxFGb+piorch0AxMbQuuP7+YBlBKlAZZQtkw+7TG8AqeVJvHM1TvjvR8gAs0Fis8YnDNaICOrtJkBsODMekYmBMhmtHgWbJllqXMDMu2YaQ0zqo1axAz7LplHqIa8QWRK4nTDQDIE5slIRrkdtVbHR+vQd3wmvum0mWlA3+qyS8Rjvs8OnA6bvUZQgn0U0zMi5yXORvOyR05eq7Hj2v4Z68jGHibLganCo/ul2zZe8hhz12bUlhhBoXJBbCh9KoF2PVZ0nKBBMy55aKNUoZU5VUCb1N7vvN1AsW8GP3Irdgu9ZnIjIr4U+6cg/P+IO2GPWrWcZQ8tuJuFvmXqxox86juBcquZeQWhwmY8nogzCSbUVL14Kfoaw3Ep+VwVMqBulT2vo2D/vpteMyI/FkLqC5ZsJYv3ZsDA9pUEI0usL1wnNAkISIvHschDp0Np6/OJC68sMAb39g5mJhDJelvSMfeiXVdKcCgNU/49x6mWCLG94KDu6NUU1/sqBe6GEZqrCGbdUKdai6ASc5nHT7ty9VG/caxAiiiAE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P190MB0317.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(39830400003)(34036004)(366004)(346002)(396003)(451199015)(1076003)(8936002)(36756003)(83380400001)(2906002)(2616005)(41300700001)(44832011)(5660300002)(41320700001)(86362001)(921005)(38350700002)(38100700002)(6506007)(110136005)(107886003)(54906003)(186003)(316002)(6666004)(52116002)(26005)(6512007)(7416002)(508600001)(6486002)(66946007)(8676002)(4326008)(66476007)(66556008)(32563001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h6f6WzZ3blzSNCW3BcaJZFkGwG3XBJ4WiXi8V13fjBPG87RLhy/eRVnb/XJ4?=
 =?us-ascii?Q?QOzgor0p55EcTnIhr705zi2Sdooww7cYQ1kbKV9bCjZwh4FVRGIMuRgME7BK?=
 =?us-ascii?Q?DVWBTYv/E3SQdhoDU8JapeZnZijlwY9dL1iRibrc60qGrY3TmCin3FZ3dxIa?=
 =?us-ascii?Q?gAd98IB8vTZD7vaUj/NZXAMbvcmVprWBvKcxC2Kwe3kR2+HBn4CHCuI6+Pd/?=
 =?us-ascii?Q?fzngK9odRNZSBMSrpRg7oTb7wD5Vrv4ZtkE+yq85qhO0g79u/L25zeJR4GJU?=
 =?us-ascii?Q?/DfxIetsaUt22hFhLElXTjTWOkUerKLLTHCVOJER+5I/eKBPB0r+cUtDLh8i?=
 =?us-ascii?Q?tz7f98w/R7QT3IJ5f66ECoSeqwUm2MnDgqzSv9v8ZJBB0tqD9qIuJD0hKuq1?=
 =?us-ascii?Q?mGgyxcpscU90GFfXntt9qszmtoB8u4jtAz1BWMp2BtE2RM9znUPiviVDg97W?=
 =?us-ascii?Q?TpiQDy5vl56Rv4VJorUHgtCKw/G4CRQTvQhIWRf1/rJDBxqH3Wskyp02ExyN?=
 =?us-ascii?Q?yugTblf5wqey/vaOARiEP2pG+15t7ebWhLYEdDYnDoL9Ly2JCbTz+wUcELSa?=
 =?us-ascii?Q?fhRpLeDAuEoRnnhzux9dQcbtj03sWikYAzlUicifCBNh4FGox5DVIWQfiC/U?=
 =?us-ascii?Q?zAUUiqv7S/fgJZa4rz455mKc4HwdYjP/ZsXtrl/CLFXHffD1IVd6MPGqb4at?=
 =?us-ascii?Q?sJJPDw7IGvKys336nDmqpOM5XEUUcqOmfC+qP+yG14dROzzmaXcvjQ3mwlvO?=
 =?us-ascii?Q?UWUnV91TTePeglf23ZaL/FKbOdrG6yLdnDa2+JPBIttW3LNhovcKDrH3UWuL?=
 =?us-ascii?Q?80cN5gb1Z55PP1qb4UYRZGs6FWCY3cCa2UZ/0/7UipVaDJaxMLSNbQPts5BH?=
 =?us-ascii?Q?QV8R2AWUX+s3R/k4ReDLx3PBWNc6ViZqSgcaYXzZ1AaxcSHIoycLl1z/eBVP?=
 =?us-ascii?Q?OLm1+py/N1mQu4DTNu4LUY+HKfBsGgIPHOzPvsoQcbfSA+RyDUthoyQq6lam?=
 =?us-ascii?Q?v6cTCKDBL7H0eN/Fl3b58dmTn6i3VE2eDHYSEz8eC1+CwDFI8O5I4xAKCOhm?=
 =?us-ascii?Q?3GNN20lqK4X5HRUv2QqTv8AZTSvmNDUXvHKPCP5eoh1htmR+si1A6awN3uEV?=
 =?us-ascii?Q?fCdoHD3mTKRVeROz5EYXUyOsObZ0ph3lTr1b9Hod+Or/iEfl/jtSlF/Su5D+?=
 =?us-ascii?Q?irijVLDH1LBJSlgAuVPpDyp/lPdMz5DOkq4YtARLGyhIcGPD/56LqJy19Mia?=
 =?us-ascii?Q?gO6FSPg+eI988XpxAUOKeiXNvGAEZUcMJTntAZjoP2HoesOviWL0N+w2qJeD?=
 =?us-ascii?Q?bPvPQAQLxQNvQz37ivUDWo8De/U6cnMLqin4Jy4Ja73mGsSfYKocDW322rJV?=
 =?us-ascii?Q?VGhmOMNcawbzoeqC1hJbXS4IreFUuItdwci2o4ZFj1aAolpiQO60U6+nsoan?=
 =?us-ascii?Q?6VizUzcKN0TbRPN8t5zYkUDRQhSHVmrLTUUXeXRJ/Eth8wLordDZ4P53X0eF?=
 =?us-ascii?Q?876TE1cctyqLLByVntYuYaVGEHYoV7bb1v0GeppPCsRNGV6CVBBUIuXWh/XM?=
 =?us-ascii?Q?R11JaGJWIfa72sYWC7axUmG7DUQM3j3pG7CFXBt2ebBTbYR0czzZDcdJkEJh?=
 =?us-ascii?Q?0A=3D=3D?=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: fc024538-8a7f-434d-655c-08dace240584
X-MS-Exchange-CrossTenant-AuthSource: VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2022 13:58:53.4459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tRSd+6S7H93q8Ah0a+VfB8skijbjNAr/fniqEfv+ocxZRjiRX5R6/tcm26CtUHFyGBDZPNFcn1Z0s8EsP96HU52V9dsTv/f3DiV12JUtyGs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7P190MB0758
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

AC5 SoC has armada8k PCIe IP so add compatible string for it.

Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
---
v2: no changes

 Documentation/devicetree/bindings/pci/pci-armada8k.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/pci-armada8k.txt b/Documentation/devicetree/bindings/pci/pci-armada8k.txt
index ff25a134befa..b272fa4f08b5 100644
--- a/Documentation/devicetree/bindings/pci/pci-armada8k.txt
+++ b/Documentation/devicetree/bindings/pci/pci-armada8k.txt
@@ -4,7 +4,9 @@ This PCIe host controller is based on the Synopsys DesignWare PCIe IP
 and thus inherits all the common properties defined in snps,dw-pcie.yaml.
 
 Required properties:
-- compatible: "marvell,armada8k-pcie"
+- compatible: Should be set to one of the following:
+   - "marvell,armada8k-pcie" : For A7K/8K family of SoCs
+   - "marvell,ac5-pcie"      : For AC5 family of SoCs
 - reg: must contain two register regions
    - the control register region
    - the config space region
-- 
2.25.1

