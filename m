Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D11A61168B
	for <lists+linux-pci@lfdr.de>; Fri, 28 Oct 2022 17:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbiJ1P6U (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Oct 2022 11:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbiJ1P5b (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Oct 2022 11:57:31 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2061.outbound.protection.outlook.com [40.107.104.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F381F214668;
        Fri, 28 Oct 2022 08:57:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g8B8+TeOxYuNkwv2vpMjZYlQSUS+k8ZU77GkWZJMjNVTWBpkWleC6Q5rY+QH+hDC7gMTVdMrEewNSr6KtnazAt+hJgliIW9zogJQ4Y+bFsj8WhDSOAoXRWNRBbEWQNF4RB2tptpqL+HEOY38Le9IlyIfJ5PiOQBAX9oMB+mQhdvdnsNFFl0hKam4FSNOT12T8+FOCOxWNpdjrS8s5m9QVHTga5ZSZWgi5ae2Oa8siQB+0nkku0WtgwdIuUOarZjKD4iQUfNX+ABIR9oxAS/WMiJ9Xt6sVDQubf5NnZID8WSGf/q4D2r7dypcXnyRJ6pRjQSvrtUccW4w2haSb1hHiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jXSrZX8phVrAfFRRBhKjVDWw2uITbVjHtV885yiR6I4=;
 b=QX30y1J2GapDKXOwt+uzZS3yjdnZoXNw/usYK2xyuz/YXTmYbo68BpIIMQ2j9Oske7cbPaGS8PN9hpRPyXBHRY2uxvB6C7rU5zg9u40XLH5w8+w6KEZ8cZFwbfXed4OX216qW83MbHidNmfxk/cUh9VVoCvk+GHMQxLirPkE+hINoVuwbG5wjw+iHOiS59bq2dtU874X0r7yCTu1WBzs0l2KkB6Ezts+jqTVvh0bMaoq9gsd+qyX37abm3XqrY6PykA63Tlatybj4TnZDcF7lVE0rXBBoPzAU+NqTmJeoOzj2Q09iOYCiQ9hVzL9O2zAZEMd5PucS+6tuetmYEkn0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jXSrZX8phVrAfFRRBhKjVDWw2uITbVjHtV885yiR6I4=;
 b=XOgEgVBv7N8888cPAkpuKg797XClyJaSOTyrgmyyvkHKJGwH1SZ8JL5GbwBTgJyuujIYEsw/dAyz+rbzNLrEyk8JCBLKrWb16JvDohCUTRQqDMLPQemwmTkELBIKPwkvINNkwFWP3bHC2fbvMVf6mC2u22EfE2V+Le5VFsr0fq0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by AM9PR04MB8323.eurprd04.prod.outlook.com (2603:10a6:20b:3e5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Fri, 28 Oct
 2022 15:57:26 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::44bb:8387:8f4b:6a28]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::44bb:8387:8f4b:6a28%10]) with mapi id 15.20.5746.028; Fri, 28 Oct
 2022 15:57:26 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com
Cc:     allenbh@gmail.com, bhelgaas@google.com, dave.jiang@intel.com,
        helgaas@kernel.org, imx@lists.linux.dev, jdmason@kudzu.us,
        kw@linux.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lpieralisi@kernel.org, mani@kernel.org,
        ntb@lists.linux.dev
Subject: [PATCH v14 0/7]  pci-epf-vntb clean up
Date:   Fri, 28 Oct 2022 11:56:56 -0400
Message-Id: <20221028155703.318928-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0010.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::23) To HE1PR0401MB2331.eurprd04.prod.outlook.com
 (2603:10a6:3:24::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2331:EE_|AM9PR04MB8323:EE_
X-MS-Office365-Filtering-Correlation-Id: 60d5fa76-09c2-4cec-fbb4-08dab8fd1b9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K/DcTCRLeencKMn3r9JbSTnwNKC67LiZBVTPb/zB/tTF8XIz43y/YMFOcG2btuYyriwvMGYeoOEuaRO6xuMh8qW27/uvu0USYuRQnKKj33uyyyq5xJ4wS7dHdysSqDhOrfI4YQy5k3itKiQV/LKpM3xIgvEnHLlYXbc26tuF6m2ygFIT/BtfUqRZwF4604mBRiuwHwY50DzXtihj4YLVpmpRQRcILWcp5mX3cKg/2FKUbm0C/0HIT1xZjjCAZ9Abxuk6FJJh4ZoVpN8uD6Wdo+91sj3BG+ZGtHhGxebny5apPzu/mVD4lOtnVL7U91fV6jKfOgwUVOthkglQ366Rfbadk4MUai62GzEsQGhh2I8I+g6o16n7sQGKmVZxqlepBtU0BWb9NK3Z3UF5slUKtmtbz/2ueYyOzjjnX/0aG2hMUaLHnx+GJLa/ZDUZ6axQKJUnJnGzk956TeAn6htXrlm4/StCs7631FmVfqsFLOH9rFgPh3I6qEluTLxME86VG+uXCODEkjg7MozRNKV91EwPaG11lWdzBP44DEw3UuHKZ+6xmOKnC2kT1vYQB59G2pbfpOVyPFpeK46TdsmY7SvQAQ0ivnk6Hsc8dLfoHypimIc96eqSbkgDGFLtfR0p/YLPZt1SVz88rj6m5p9zVRqjK3metrQJTVLF0yROZ3DRW94ep1UfQS6ut07YY/J8+s+FlMkq+7sPjJCPTlT/vFkpf5nEPSFHYo/rpZGE/HxMkESCYFYoIadMmgABni7LIfO+m9aEZTT9aHvGKP1aHHZcQbg+iH642XwHj5xtFvLeprm5wDlMFRX3WYefxUISdfGWw0Vd/+iDsmYZWYBLKQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(366004)(396003)(39860400002)(376002)(451199015)(6666004)(316002)(37006003)(34206002)(8936002)(5660300002)(4326008)(2616005)(186003)(1076003)(7416002)(8676002)(4744005)(52116002)(36756003)(6506007)(66476007)(66946007)(66556008)(6512007)(26005)(41300700001)(83380400001)(86362001)(38100700002)(2906002)(38350700002)(6486002)(966005)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YbnbH47epcpjA/lay/XvcI05MiI8kyiyd3KyVotiDhm4zmZZQz+u0ZBC4+MV?=
 =?us-ascii?Q?kFCjLpQMm83rfUENOUL7KTBVC9KxSJAWre31bLulTKwJyn+ymxwYvsoETzsX?=
 =?us-ascii?Q?F9q3uq0gd0f/xHA0d81qyX9M4to2vyJP73qLOCkUyNI++pvwJBYmCo/QLA9J?=
 =?us-ascii?Q?iw1LTlWequfGvcauU/hcZ9mb13T1GC5UOnc9Sw4zDO0zEe6ckeIJxYNvOZep?=
 =?us-ascii?Q?8qJJJDvDmUFvD1KyLGAnLNKshZxjh6EgRO1OJMiGgthnViOOzMpTCVTDkNvI?=
 =?us-ascii?Q?QzQ/ARryNYVZf7aGMB8oUhmWbB17Hf+bcIubrM5/YI19mhMNE7Ce87koaDqy?=
 =?us-ascii?Q?FKrQCz2WBO1ApqCp6GlziRJvpqh4sZA23ubmy/qrsBRDO7iL1S1UDTUIdSFL?=
 =?us-ascii?Q?goqOiGuQoyUrOeTrzWbxtV3uifm8T16dYSfGDb7pm/c84CQONgRVpWCZSkYG?=
 =?us-ascii?Q?vES1K1zaFGrqdexc47ckrcuj2OdiSBk+7NlRpPgJS9M1YJcjBs8v58X9Zwa4?=
 =?us-ascii?Q?ORlkbZBECa5GAJQHUkoJV+M3xr99MXTmMvAflBgKW1t/sObJZYI2KbNMtukf?=
 =?us-ascii?Q?6GKVmb4OEBawG8lRxbuE2djf6rqT258rFDtU0plGuND84mhZPam0SfChuIj8?=
 =?us-ascii?Q?nqDoUKHYkiDoyOzlYsv/ASgZtfJhnwzB3zfaXF6ju6oYe7VfJ61+Hmf/kqMa?=
 =?us-ascii?Q?VujUZowmNAdyDtX39ATvY9wdpR+mn9OYHwja+FqRXsXXZ8LiYEKY4rjhb3Mm?=
 =?us-ascii?Q?kljsk6/iaY0oZn2mdnKHSB2T5xyaOE60AyqwEwJDzZmA4QnOG/t/lceNeR2A?=
 =?us-ascii?Q?YmX8n0vIv0ubKr/X5vB7Q2DRAgotOAPbl3trXuGnBCrpU1Y3yJsUfP8ywg0R?=
 =?us-ascii?Q?4JNb8s9sqjygLeTfjP6+uCQuR5M1bAUT0tJST72ZMSRKoBILMgYvBzJYQBgn?=
 =?us-ascii?Q?KuzlAzxhJGfCAeIvJ/XlSkhrOg8aMc3fZRfSbk3ytBVrjRZ8DTfETLjBWgSc?=
 =?us-ascii?Q?yq66ooQCPnOpYaNHr1D3mfannp9wgZWKiZLop+Di3qd1L8XeSvBDDJy1buAa?=
 =?us-ascii?Q?cJaX4YUSVR6zr77dW8yXhPEQIa52i69F6j4Id4R+zHMTjcaS8Pks60XVFVEo?=
 =?us-ascii?Q?dgSBQ0zo70yGC3yjW93Xg7UAEspKmaWy061rnfVwwzK///rMzvEVfg288LCC?=
 =?us-ascii?Q?ALMTNd4N9LYKbFDuV387kf7/Tiak0E2jxyvcVMHKLKbDDcxhMIekEcLFeaYL?=
 =?us-ascii?Q?h4A3gN5rlAW7jk7qPNUiDaNXkXmcBF+21FX/K9AU96eQoBYSUDc6wUFOzymx?=
 =?us-ascii?Q?v+7lW5IkVGwiBq+5CSRvvxD8vv7lnh849NDtRuTjL8l5AZL4Y/sQjh7E4B3G?=
 =?us-ascii?Q?byQvyr8FM49CZ91ENU3tdhdaa0zpVgD+mutLDTRnlmjZyZ38J87YJBwMqb1v?=
 =?us-ascii?Q?pX5wwDpCGYJ7Z1y6pylwt71DnbOz//O3EWUaqO/lR9pphkX9Gc+AjimHuN0P?=
 =?us-ascii?Q?CZ7xcqqCaSnhPaandpTioJisPHVUdKPTrgY+GLjcaGtcwB855UBrwiaxWAGk?=
 =?us-ascii?Q?pZvPpWX/+dcYjoYyy0Jo94R1YOeJOBHt6KM7gBqB?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60d5fa76-09c2-4cec-fbb4-08dab8fd1b9d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 15:57:25.9671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DyEUPFxNvbKbvfIatUEQtmirW2JQ6ZsMxSoL9+tMERN2/qdWy1zSKz9xu+q8FEV6E/Z4nq8mm3oG+foHe6Ahww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8323
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

continue patch series https://www.spinics.net/lists/linux-pci/msg130372.html
https://www.spinics.net/lists/linux-pci/msg130924.html

Lorenzo suggest create new series. Version number continue from old one


Change from v13-v14
  split spare warning fix to two patch
  remove local variable reorder

Frank Li (7):
  PCI: endpoint: pci-epf-vntb: Clean up kernel_doc warning
  PCI: endpoint: pci-epf-vntb: Fix indentation of the struct
    epf_ntb_ctrl
  PCI: endpoint: pci-epf-vntb: fix call pci_epc_mem_free_addr at err
    path
  PCI: endpoint: pci-epf-vntb: remove unused field epf_db_phy
  PCI: endpoint: pci-epf-vntb: replace hardcode 4 with sizeof(u32)
  PCI: endpoint: pci-epf-vntb: fix sparse build warning at epf_db
  PCI: endpoint: pci-epf-vntb: fix sparse build warning at ntb->reg

 drivers/pci/endpoint/functions/pci-epf-vntb.c | 149 ++++++++++--------
 1 file changed, 85 insertions(+), 64 deletions(-)

-- 
2.34.1

