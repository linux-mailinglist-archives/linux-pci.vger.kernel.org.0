Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A4F604D8D
	for <lists+linux-pci@lfdr.de>; Wed, 19 Oct 2022 18:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbiJSQjW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Oct 2022 12:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbiJSQjU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Oct 2022 12:39:20 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2072.outbound.protection.outlook.com [40.107.22.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 621551CA5BC;
        Wed, 19 Oct 2022 09:39:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PC2fWwoUtjXGgngClGYJrwp+t436WnNMfxQhLa6Z1jBse0wg527oiuLf7/O8Cx8Ww87JaLfeyFu36hvLfawb/3SXJ+3hFTBFNcMCUnEekyabR+2v08enBgXvzmfnbdLDPiOAKjsVnndwYnVtwkTNe2ZBRCS43r7vute6w1N5GI0uCeKUQLo4rcWwH1Xsi7xsePeNH5kP5tvvLeQdjBbwZiNGHjYmYjFh19kX10yjUi6XbOS3FDdrtgxgRPXvCDy8nHY+oqC/Vj32uFWKAE0VhZCviVm4uYzi9126pq70Q+QHDgHSFPl1hTEQZ81LO40Icbq2RkSUjdlIVULjdKQp2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UcEdoYn0/F3mZipHwnA08VCM0AbGpPuQQLusjnnBnPM=;
 b=E1w4Qs4YwWeUISGX8DhbUv9cOqzUW7W/9mh6rV0Xg/Egi1CFR5u2x35yOtnu+MK8O5l0olBDf/skCP9rMjxadqSsJD/N/Y5lovpC6lxOvttz2Y6EPOVjnfO/XgBNteEplc9p6bkNODpsXIbsPnTtGgqafaCaHd20oO5Vr0AZfwzhiJ71BJAOwhlHav2jz4FSY79EG0beW3hP86GmLdFreVn0/Dl+hfJTIlyRrD+9RPTVgJfMAOqqMFJj3heyvmF/sdqjwjCJWTThVo6pJ7RlnWb9jqCOvHxHKg5gxfZ/LBvH4bTRiE+CDqb12824wk+9yGF3dAp4eNka7aTU3CWchw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UcEdoYn0/F3mZipHwnA08VCM0AbGpPuQQLusjnnBnPM=;
 b=YO6wMrr0EvI4HjY9mQ9988PbJQzPI4nazpeUj7Eh2e1RPoH5yhFHP3TfmeZ2g2Fh7uJAgFUSI4sx2gTG+e+YHfh4SJ8DuseQ8XULtvJ6k1fUJhl8mEah8mbAK3OVYKEz4w0xYrRm0JUMQlarEWyARO2PSCsQDyUpnJMWevmHqIQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by DBAPR04MB7318.eurprd04.prod.outlook.com (2603:10a6:10:1ab::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Wed, 19 Oct
 2022 16:39:15 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::6110:8304:5648:88f5]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::6110:8304:5648:88f5%10]) with mapi id 15.20.5723.034; Wed, 19 Oct
 2022 16:39:15 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     helgaas@kernel.org
Cc:     Frank.Li@nxp.com, allenbh@gmail.com, bhelgaas@google.com,
        dave.jiang@intel.com, imx@lists.linux.dev, jdmason@kudzu.us,
        kw@linux.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lpieralisi@kernel.org, mani@kernel.org,
        ntb@lists.linux.dev
Subject: [RESENT PATCH v13 0/6] pci-epf-vntb clean up
Date:   Wed, 19 Oct 2022 12:38:49 -0400
Message-Id: <20221019163855.1267295-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0352.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::27) To HE1PR0401MB2331.eurprd04.prod.outlook.com
 (2603:10a6:3:24::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2331:EE_|DBAPR04MB7318:EE_
X-MS-Office365-Filtering-Correlation-Id: b41331f7-d0bc-475e-8180-08dab1f075b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xpd9LNbQOH3bxo08MxvrrsLJsjPRUFsm9LcEB2keIun8ZwqRiFF5ykoOyBZCOK58D2wqZJJtC5ta39N/MGUhZEBJfZeoXL7xnqP9V9XAibFryDlbEse2QFepCCXtv9cDEn1a1ntXxX+g9WxD71m2CNMa1R2jb36k5cLO7f7sCQO/DLEN+uUUFjxOXGGD5UL9vK86pkVxEIm4OElCsn3X+U9SqjWXmunzkZDf7Yw3KYktwQJZvAzEiooP8tAxqTxBqGJDN5NJMDBJELus90xYae28X++dHxSM2p9oSBsZOxBSpzXW1ycQiyuakUtmc5lSmGCHROm7TSgex0Zh9SoajI45C9Igf3MMYSbjN/fa73rv5UhOolRW2P9y2AQeWucjQvKI/g3Udw7KafOyKyk+wj+JX7whETD2F7XcgwbQp10rUHeQ7xDD9IjaVtz8XuRLzclVrZYQA3aJCuAo22NuPymcS32oCD4046RKNod43qtXc+Mnx5EOXMrxASn6sycFMQPCuc/iieU3k4BtqUJ84RMtii6lPPiA/n9UAQbgGwuM2lLMFG3hfcsLpXM7y2VqsYBGl7U1r2AcIWB4TVTpJ4pEiqKU9wh+GSLx7H8sAraJ1HPRN4G+dYRd821vMB9robvjg73dMxdvKF/vG+E0CRugzeccH8rHhlODiXzAHZKb30RZs0tLEAx5hY3BNaq16asCohPhrMt25xGZfjoEhpC2DK3HoId7hbDYLSIFhVKd3bv5fJp+rIh2X+/wBK69waBV/gmxqS4h5CU303M61Aj78Ha78bmnkHEUmN2oE0Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(376002)(366004)(346002)(396003)(451199015)(41300700001)(5660300002)(8936002)(4744005)(2906002)(26005)(316002)(66946007)(7416002)(6916009)(4326008)(8676002)(38100700002)(66556008)(66476007)(83380400001)(38350700002)(6666004)(52116002)(86362001)(966005)(6486002)(6506007)(478600001)(6512007)(186003)(1076003)(2616005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wZgCFqR886W1ov50V6CwwcZ4Yo8GT/2TADmeaD2NBQ5yHs3J6qFopXq8L7j8?=
 =?us-ascii?Q?Pw3KjI9pMYfl7UEwMgOvN8W9UvoNeyRvbsLlTucSqMGQ9r0DXaxvzfptFJwq?=
 =?us-ascii?Q?QeewatQzhWctUzcev0JxGaklemmo/31jTVOVCwZsTy+xqVFIgaGZCIBaaSXc?=
 =?us-ascii?Q?YRAtWL7nR+UE8Hwj8jQ13mrP9gqdbSH6vkpZ7pnk1ab6LVwhZ2OvMozevmOX?=
 =?us-ascii?Q?WK90rtqpH+Fl+BQpxTy06bjANRO1Y5RUJhEx25ooRQhgnsi583cXnLcwNMBh?=
 =?us-ascii?Q?BCXpMuysoGH4m3xU6tTCmzTeF8C2nVdr5uJVWn6EdNCLmZHKz5xZ8YBnZ0vV?=
 =?us-ascii?Q?vDxcaxa/nfiblZzzloY8iCrOYoku+2jSzIRhNQ511iCm/auyqij2Pt+k1ZSI?=
 =?us-ascii?Q?b7fIhqtTZiBCJKJFo9OMe4Uox/IklmD68Ci3EBfyCzACEmUhZTteUs5k6K69?=
 =?us-ascii?Q?YWTvPbezr90apMG5MehtysC6Q9aohLiMPv6E1BlYq5EfQFu5rIvvW9yp8na6?=
 =?us-ascii?Q?7DP6Tdz+hl/TOKTXl5wO9kO7XZ2yCXeErajY3PUIAeG0C2HF9k1w/07sPkiP?=
 =?us-ascii?Q?3/HJ5epR0K4JNV+Y4nyajpL9SnqV/rc+5AKw+c1nlgrN8WTmPFmhPrGRgVem?=
 =?us-ascii?Q?mR7Gg5X/XMqh4+VGYEYKkIGRjynE3hPzxznOPIDDqRQ9yJXM2BtgZexijUA/?=
 =?us-ascii?Q?+f7arbNKe7mAcIWAkotq/dIfnEK1vFg3AVhkLoXZdgOFzu+ALV3MlOphi4lx?=
 =?us-ascii?Q?GJhJSOSGRa5KjVU+agmK/Iqgt6/Erjsh5UT/WP8lLLQYTB7pesTxIqaaIJ+N?=
 =?us-ascii?Q?gGU/B7d3ly7u4g58Uz2n/nO2Ee74cDwiVkoOnVi8jHj5mtyLKjFSTaGceajg?=
 =?us-ascii?Q?npjTto4K16ceLf6q5XJvDuOT2eVhBkTcWm3QAIXzPeDOR2A/nnTCTaiVDiS7?=
 =?us-ascii?Q?Flk8/2bYcSNdYKhREXYyr+lnj+1HySDoIdpArm68LaiCrOiKsrw5LdC1/6cF?=
 =?us-ascii?Q?Z0aoUv+ymTX3ywUcuL6oa6b/m0nwSKlgV6ab7XaSDFQfxZqDyUdVwCy6OGtb?=
 =?us-ascii?Q?TVKSXbclygqWuqUg7D/XUtz+YdlQ25Zyy7x9vYGLIVIxZlpkd8Exp0izH5fs?=
 =?us-ascii?Q?PlIt+Khy4KyULSEG4mjuIXngLySxWcSyw6npB+eSnGyk+9OyG1SvesnMDnrz?=
 =?us-ascii?Q?Xs8pyEylB3tkBCUsZQMu9MfUge0lQoUxzwuz+cwc2MhcNlOuXuIFqb/h9k0u?=
 =?us-ascii?Q?0GHdoP4hpN1/8hpBm4G4fzcJLnBq1XPfbTdk7rgtB8RGlwDBk5WxOKeLkgZW?=
 =?us-ascii?Q?e/5pTigtRXAuBAEN9wN9Tj6Or4U0gN53ln1JSB1r3fEp6HlT1CEL3phvqyKt?=
 =?us-ascii?Q?S41yNonkYT9gPyiUHKtEeK16Hf9vu0TQfNy0svA+m2SDg7HNerf8Cu4JSRfY?=
 =?us-ascii?Q?6Q7C+dxU79ntesrpEd0SLQ50h3gmwg5Pwf0UMlIUh4NByqvGYchPirHKIRY6?=
 =?us-ascii?Q?EDXoOBtpm9kI2avFHrPY2TK6LmM8jhtqpLrg3a/DkhYsxh7Gl2tsRpgO+tlh?=
 =?us-ascii?Q?PFvQ0tEGsQjMJusz48DBoMWzBAjmklkh725IR5YC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b41331f7-d0bc-475e-8180-08dab1f075b3
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 16:39:15.5218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P/cTlAtqGoGE1Gzti40hOH8iPjWO27C75LdqWuu7HMpErXwP3LPcFq0YVRrT47iPmq911beWrqm7DPaNyOAnhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7318
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

continue patch series https://www.spinics.net/lists/linux-pci/msg130372.html
https://www.spinics.net/lists/linux-pci/msg130924.html

Lorenzo suggest create new series. Version number continue from old one


Frank Li (6):
  PCI: endpoint: pci-epf-vntb: Clean up kernel_doc warning
  PCI: endpoint: pci-epf-vntb: Fix indentation of the struct
    epf_ntb_ctrl
  PCI: endpoint: pci-epf-vntb: fix call pci_epc_mem_free_addr at err
    path
  PCI: endpoint: pci-epf-vntb: remove unused field epf_db_phy
  PCI: endpoint: pci-epf-vntb: replace hardcode 4 with sizeof(u32)
  PCI: endpoint: pci-epf-vntb: fix sparse build warning

 drivers/pci/endpoint/functions/pci-epf-vntb.c | 157 ++++++++++--------
 1 file changed, 90 insertions(+), 67 deletions(-)

-- 
2.34.1

