Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2452257BF9F
	for <lists+linux-pci@lfdr.de>; Wed, 20 Jul 2022 23:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbiGTVbY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Jul 2022 17:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbiGTVbW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Jul 2022 17:31:22 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130059.outbound.protection.outlook.com [40.107.13.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1893C61B1F;
        Wed, 20 Jul 2022 14:31:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cabb3J4IT6Vr6cg0mPtQjUFurOPXWKWAxuL6KOqkW3k9FMeE8TOo6wAujMMaPCBgDX//7HofKdFSuwDzBF6a0y4AR+Xljw6lBokH/wx0MWLH2zHw1e2tEmMOWR3R7xXbMV+9uL6oW4t/klP6A9UJNcRxOzJ9FDUvDP69OsCPrbHEvA/UY9S1eo5Uh63JOK8R8xT5m5JIpKx5jvKkSzdvvatI8xE+i1ozH7RihkHBbbxhl8R9WvNHoMQQuGePpUhp8k1+5nFHofYONHQAVznj9rf51rOS83JZB91bBeNDA1R8LbuMtouC62YnIntCRxepCNnCXCP8xUKj5AOsY5cYUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1hJeUUxqEQAHaeavRRaTbNVbuGmClsA5qDf+Wpd5vng=;
 b=Rm82Pbbm4zb6WRLe7dszfOVrcePrlGLCc+dN3wpABItvleHWElQB6x2dbJaQYTzVcd/4sFvGM66PBavDaUSpYeYf7Pjw8QuNhtf9E16uhVxJHE0ZebEzgQTW5Ltm0DqBEqY/osF/oyvwIBIGhwjrOldpWFVWHA/6kimZ7RahQtphR5o1cMExLoPGqQkk+rMSp+noiLlQAKd24NHUh8L+AebQvN7htAIo0e8ohe6yXDBHD170iErGvfpYyJa+JifOPwg/VVjrBzQf8Zq4eev8ob2S4IT9dEefXzUe2pmaMBE7yDSTJz/qMjlfpoxMyXJcQT7cw2IAa2/avFHZG5ri6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1hJeUUxqEQAHaeavRRaTbNVbuGmClsA5qDf+Wpd5vng=;
 b=c0rtKHqm/nKxtfzTqWyWMrgQmvNscz2XOOxwWchyzA76Zq1gL5/fVIyI1bXRDYcFltSX08ESreDfkddaTZuKTxO/d5XO6MZZB/1C3i0DwQYf/VyuqdkNwYaOAr7hEa/d0kv6JJwau17dpc8v0pNZTLYErkRb0oX2gMFsVKoc2MQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by AS1PR04MB9479.eurprd04.prod.outlook.com (2603:10a6:20b:4d7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.24; Wed, 20 Jul
 2022 21:31:18 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::54aa:b7cb:a13c:66ab]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::54aa:b7cb:a13c:66ab%9]) with mapi id 15.20.5438.023; Wed, 20 Jul 2022
 21:31:18 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     jdmason@kudzu.us, maz@kernel.org, tglx@linutronix.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kw@linux.com,
        bhelgaas@google.com
Cc:     kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        peng.fan@nxp.com, aisheng.dong@nxp.com, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, kishon@ti.com,
        lorenzo.pieralisi@arm.com, ntb@lists.linux.dev
Subject: [PATCH v3 4/4] pcie: endpoint: pci-epf-vntb: add endpoint MSI support
Date:   Wed, 20 Jul 2022 16:30:36 -0500
Message-Id: <20220720213036.1738628-5-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220720213036.1738628-1-Frank.Li@nxp.com>
References: <20220720213036.1738628-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR10CA0005.namprd10.prod.outlook.com
 (2603:10b6:a03:255::10) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6846439a-0165-4f2c-1e2a-08da6a972eb8
X-MS-TrafficTypeDiagnostic: AS1PR04MB9479:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZPMvpDGemGjD3TuBkShhE8xDZi9qUXNyhNU/kGSmYSMM7UMHOekpaCheb4gS7j6EfF2Vb91t6TDQgOnwVRYphfGDGR+0dwldY1mcHaa05ObC1cWrONPtrnLkQhsI0zk1+yypqMKHZxAOA6+pj6qMSllj69aDVDUfW7rsUPyGT+zD+Y3xrEH4CtHiIPhgETfb/nOaVvjYugxMTfHESceRDSrL700ywZy7c/GTh0M3DiZk+iujXO/DKXiUdBk2JazfQfYDzXbGd7RRMMF5utJpS8FqIoh8BJnKQwJs52qAYDOaPL7TosdVKrFlHzvTatnMmLRax/CR5dfwg+0rclwBbaiq3hm77vBw1PdvSXDVaggOZxZSk07fpUAmIqggh1m81NGcSgROUt06vL+jweeeHJVlBQEiQWmzY4sO5wMsm/UskDKVtkwLk29P3XGkPz4i+p247di69boForifbN6t9Jg33qNmlqOSJvTYX9ZhSovFdM4YHPQeG0XOQ8uHbcfGXyxy2NXW6pnoLFiQLDud7cA/SQzPC61+rbjZEQPgS0nJyn7mhNa16db/6L52cSeVrDZcpYgFFnhIKpseeZGMnE7jRdlyzUq4T633Ou40aOQWaifbUbGz93tcS4nFa12/Px6UAs72g8fyELTU4Adlgpb7cJXlgvK65E5/fexGgstmcVbifw+zbSWGSlLeSPwY9ggXSnL/CMq4LgjKYJumgEaavVc8aEWK8WiJ4c/xfCO8Uq715arHnpO5zc40hBDXOkVYc4oaHWSoGSK4uby10sw1qa6au7AfMKoAu/3eKYE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(136003)(396003)(366004)(39860400002)(4326008)(66556008)(66476007)(36756003)(83380400001)(6486002)(86362001)(8936002)(478600001)(5660300002)(316002)(7416002)(66946007)(1076003)(6666004)(6506007)(8676002)(186003)(38350700002)(41300700001)(38100700002)(52116002)(2616005)(2906002)(26005)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmJhcDBoa2NKcmphSHFMRmROSzRhRSt0SmluZ0JtZXA4ekFaZ3RwemN5RndE?=
 =?utf-8?B?dTZ1V2o2ODZuOEFRT3FLcjNNbjcrVFVTZUM3TnM4WnRTNU9Mc3dQZHNBVlF4?=
 =?utf-8?B?Q1UvTUN2Wm5icEp1ajhiSkdhWHVFYS9FUjkwME5JS2Y4cGt2ejA5cDF3bi9F?=
 =?utf-8?B?Nks4dVRtdkJ3SHBiWUZ2M1NydEt0TEladHRuQXA2T25YSkxlc1lFSEh4VmdD?=
 =?utf-8?B?SDdIb3hITEM2Z1Njd3BDakladXdzcXNxYnhGd1NUZG9GTXNjMmpwWGtiWjMx?=
 =?utf-8?B?bnZ4VGtEcjBJRGl5bThaZ0V0dWxJd0lMMnRRZUtCakZxaDZsdXV3Vzhrdllr?=
 =?utf-8?B?NldxWDkrelpJdk9Lb3NrMzUxb3IwOWlqQ21hUWRWbE96OXpRTVFCT25LSXB3?=
 =?utf-8?B?VkhhVmJIbFZvZ2VET0hYcGxoaFBGS1dnOTJSZXNLb0dGUlpWN0hCT25yYnJD?=
 =?utf-8?B?NEpJbVJBUWJtZ0M2QlpTNkFTVjc2Sm9VWmxyQTIvbS9VRzhES0FmcTRCNE5U?=
 =?utf-8?B?bkZGWWlrZWZSZTl4akp2c2VuVlFreUNqMjZiS01xWWF4OUE5aW9ublh2dHpH?=
 =?utf-8?B?NXNTblVqWkJKWHVYdHpROEVUTGlESzRaTmdxTEtCamY3a0ErNkViejBtODVI?=
 =?utf-8?B?blZGTHhBLy80UzFudng3Y25pUUZwWW9UOHd1U1BPZ1ovVnNkb0FlWnRPeU5N?=
 =?utf-8?B?dStIS0d5R0NpQ0NmWEU3UFhhQ3VYMjNCajlRTEcwVWcwcVYxTEZ6YllJem5T?=
 =?utf-8?B?Qm93SXc1VjlTSThOTlBiYzFRYmNTcytiYU5hVmtEV0Q2VzNwQW5ybFlXN3Vr?=
 =?utf-8?B?OWNwN05nR1FJQ0hPVCtielI0Zkt0cStSN2xmb1Z6VGZVRVd5NVB5UWNWckp6?=
 =?utf-8?B?c0dlZmppdEhIYlJlY2gxbE51NlV2eFYzQjdvSXVrYWpETTVmL2phd1I2a2E0?=
 =?utf-8?B?bnR5OForUWdvam9NNldUZVlkMktyVlpqZ0xBM0Yrd2pEMW5uOWYwRWZvUEFR?=
 =?utf-8?B?QzQ4VzRMU3B4MDVtYTR0QnVSc0RCVGdsMHhxMDdIYkRTR0Q3N2VFU2Q2SmY0?=
 =?utf-8?B?OWt3VzBma2Z3K2NiME5DVDg2UXEyeW9RaDVEYWlNVVB5R0ZvT0dpRDB3Tzcw?=
 =?utf-8?B?T0FZUGYrVVpsbnY1d2w5Tlh1QWFvMnR0NVdFWlNCRFF5QW9EMTZVaDRrS1pV?=
 =?utf-8?B?Y3R0U25ZTUdMN2RRenQxbTlsZVJ4Qm83dVMrcnlnaDlUUTQ3eW1JMXQxRzQ0?=
 =?utf-8?B?am5tZytNUUg2dDgxd2RpK3did0Vjb1U5OG9vNjh4WUZSSlFyL1dOeE9ncTNJ?=
 =?utf-8?B?L2VGcEN3VG9YUHBOUGVXdFVWbktveTRJcjRuYlhyTFpuRXF2SlZMMTFlVkxB?=
 =?utf-8?B?L3E5a2JWbWp0NENrQ01EWTcyRG5XT21LaUkwYTBtVVhnd3dOTEFXNjhlc2cz?=
 =?utf-8?B?WnY5MGJrTlFHQzdhbmR5THRDZ2dzVm12T3owckhmV0RxY2hYTHJxNkZNSHJB?=
 =?utf-8?B?NXNJSkJqanZ0T1lWbEJUaGZ1Q3diU3B2YTlDTEp4eDF3ZzFVd1d3K2xNNTM1?=
 =?utf-8?B?b2xFdWw5blVQQ29iaWJySXorYVQ0aVBOZmpySU9Ha2I1UlpSNDBsZXoxV0lj?=
 =?utf-8?B?Q3ovQyt0UTB6V0xXclo5bVpDUUhwaldoWDIzdXRRNHUrQzRrNUFlUENCYklF?=
 =?utf-8?B?cllWdnNvdENlSGszN3RlSzVzbnVKRFhrbElyZ2cvVWdoR1IrTWhzTGp1VmpB?=
 =?utf-8?B?U2xXb0IyNnFYL1FZVWVqODkvZWNNYkpDUGRJL1laeHhXVkluL0EvUVJyUUxn?=
 =?utf-8?B?OFQ4K3BxT1lOSGtQN2U3R1ZDbzlQSkFRR0F2TnVRbzVpT0xwL0kxWVBSYTJm?=
 =?utf-8?B?TDR3YVJjeG9xSDdNZHNyTEoya3RQcjIzT2o1eGdSWkVlVFBadlAvUldySGtR?=
 =?utf-8?B?RFdQOW8rVXZzVnpNVVdtTnQxUmczTmhnaVpVRThFQmZwOTNRN1ZJZGdTemho?=
 =?utf-8?B?NlpYdVRzeC8ra3Rxd09YRXZOc0JhSWZYc1d6VmwwblVKeVltVkk5SytIWThn?=
 =?utf-8?B?WFZXR0JVeU9DQlZ3dmlLSEE3T1dzWE5JMURMSDZ1eWNxd3J4TVo0blYyQ2k2?=
 =?utf-8?Q?Stu0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6846439a-0165-4f2c-1e2a-08da6a972eb8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2022 21:31:18.5739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MuLbAOhBAtXR0mKy44dsCrZTRd4dDm/mHdCWsApNACoDwwNghhJOVjhcQVgrlkCeg+lGR+98H/dhhsorRcCpEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9479
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

                        ┌───────┐          ┌──────────┐
                        │       │          │          │
      ┌─────────────┐   │       │          │ PCI Host │
      │ MSI         │◄┐ │       │          │          │
      │ Controller  │ │ │       │          │          │
      └─────────────┘ └─┼───────┼──────────┼─BAR0     │
                        │ PCI   │          │ BAR1     │
                        │ Func  │          │ BAR2     │
                        │       │          │ BAR3     │
                        │       │          │ BAR4     │
                        │       ├─────────►│          │
                        └───────┘          └──────────┘

Linux supports endpoint functions. PCI Host write BAR<n> space like write
to memory. The EP side can't know memory changed by the host driver.

PCI Spec has not defined a standard method to do that. Only define MSI(x)
to let EP notified RC status change.

The basic idea is to trigger an IRQ when PCI RC writes to a memory
address. That's what MSI controller provided. EP drivers just need to
request a platform MSI interrupt, struct msi_msg *msg will pass down a
memory address and data. EP driver will map such memory address to one of
PCI BAR<n>.  Host just writes such an address to trigger EP side irq.

Add MSI support for pci-epf-vntb. pci-epf-vntb driver query if system
have MSI controller. Setup doorbell address according to struct msi_msg.

So PCIe host can write this doorbell address to triger EP side's irq.

If no MSI controller exist, fall back to software polling.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 134 +++++++++++++++---
 1 file changed, 112 insertions(+), 22 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 1466dd1904175..cf55fa402049a 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -44,6 +44,7 @@
 #include <linux/pci-epc.h>
 #include <linux/pci-epf.h>
 #include <linux/ntb.h>
+#include <linux/msi.h>
 
 static struct workqueue_struct *kpcintb_workqueue;
 
@@ -143,6 +144,8 @@ struct epf_ntb {
 	void __iomem *vpci_mw_addr[MAX_MW];
 
 	struct delayed_work cmd_handler;
+
+	int msi_virqbase;
 };
 
 #define to_epf_ntb(epf_group) container_of((epf_group), struct epf_ntb, group)
@@ -253,7 +256,7 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
 
 	ntb = container_of(work, struct epf_ntb, cmd_handler.work);
 
-	for (i = 1; i < ntb->db_count; i++) {
+	for (i = 1; i < ntb->db_count && !ntb->epf_db_phy; i++) {
 		if (readl(ntb->epf_db + i * 4)) {
 			if (readl(ntb->epf_db + i * 4))
 				ntb->db |= 1 << (i - 1);
@@ -454,11 +457,9 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
 	ctrl->num_mws = ntb->num_mws;
 	ntb->spad_size = spad_size;
 
-	ctrl->db_entry_size = 4;
-
 	for (i = 0; i < ntb->db_count; i++) {
 		ntb->reg->db_data[i] = 1 + i;
-		ntb->reg->db_offset[i] = 0;
+		ntb->reg->db_offset[i] = 4 * i;
 	}
 
 	return 0;
@@ -509,6 +510,28 @@ static int epf_ntb_configure_interrupt(struct epf_ntb *ntb)
 	return 0;
 }
 
+static int epf_ntb_db_size(struct epf_ntb *ntb)
+{
+	const struct pci_epc_features *epc_features;
+	size_t size = 4 * ntb->db_count;
+	u32 align;
+
+	epc_features = pci_epc_get_features(ntb->epf->epc,
+					    ntb->epf->func_no,
+					    ntb->epf->vfunc_no);
+	align = epc_features->align;
+
+	if (size < 128)
+		size = 128;
+
+	if (align)
+		size = ALIGN(size, align);
+	else
+		size = roundup_pow_of_two(size);
+
+	return size;
+}
+
 /**
  * epf_ntb_db_bar_init() - Configure Doorbell window BARs
  * @ntb: NTB device that facilitates communication between HOST and vHOST
@@ -520,35 +543,33 @@ static int epf_ntb_db_bar_init(struct epf_ntb *ntb)
 	struct device *dev = &ntb->epf->dev;
 	int ret;
 	struct pci_epf_bar *epf_bar;
-	void __iomem *mw_addr;
+	void __iomem *mw_addr = NULL;
 	enum pci_barno barno;
-	size_t size = 4 * ntb->db_count;
+	size_t size;
 
 	epc_features = pci_epc_get_features(ntb->epf->epc,
 					    ntb->epf->func_no,
 					    ntb->epf->vfunc_no);
-	align = epc_features->align;
 
-	if (size < 128)
-		size = 128;
-
-	if (align)
-		size = ALIGN(size, align);
-	else
-		size = roundup_pow_of_two(size);
+	size = epf_ntb_db_size(ntb);
 
 	barno = ntb->epf_ntb_bar[BAR_DB];
+	epf_bar = &ntb->epf->bar[barno];
 
-	mw_addr = pci_epf_alloc_space(ntb->epf, size, barno, align, 0);
-	if (!mw_addr) {
-		dev_err(dev, "Failed to allocate OB address\n");
-		return -ENOMEM;
+	if (!ntb->epf_db_phy) {
+		mw_addr = pci_epf_alloc_space(ntb->epf, size, barno, align, 0);
+		if (!mw_addr) {
+			dev_err(dev, "Failed to allocate OB address\n");
+			return -ENOMEM;
+		}
+	} else {
+		epf_bar->phys_addr = ntb->epf_db_phy;
+		epf_bar->barno = barno;
+		epf_bar->size = size;
 	}
 
 	ntb->epf_db = mw_addr;
 
-	epf_bar = &ntb->epf->bar[barno];
-
 	ret = pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no, ntb->epf->vfunc_no, epf_bar);
 	if (ret) {
 		dev_err(dev, "Doorbell BAR set failed\n");
@@ -704,6 +725,74 @@ static int epf_ntb_init_epc_bar(struct epf_ntb *ntb)
 	return 0;
 }
 
+static void epf_ntb_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
+{
+	struct epf_ntb *ntb = dev_get_drvdata(desc->dev);
+	struct epf_ntb_ctrl *reg = ntb->reg;
+	int size = epf_ntb_db_size(ntb);
+	u64 addr;
+
+	addr = msg->address_hi;
+	addr <<= 32;
+	addr |= msg->address_lo;
+
+	reg->db_data[desc->msi_index] = msg->data;
+
+	if (desc->msi_index == 0)
+		ntb->epf_db_phy = round_down(addr, size);
+
+	reg->db_offset[desc->msi_index] = addr - ntb->epf_db_phy;
+}
+
+static irqreturn_t epf_ntb_interrupt_handler(int irq, void *data)
+{
+	struct epf_ntb *ntb = data;
+	int index;
+
+	index = irq - ntb->msi_virqbase;
+	ntb->db |= 1 << (index - 1);
+	ntb_db_event(&ntb->ntb, index);
+
+	return IRQ_HANDLED;
+}
+
+static void epf_ntb_epc_msi_init(struct epf_ntb *ntb)
+{
+	struct device *dev = &ntb->epf->dev;
+	struct irq_domain *domain;
+	int virq;
+	int ret;
+	int i;
+
+	domain = dev_get_msi_domain(ntb->epf->epc->dev.parent);
+	if (!domain)
+		return;
+
+	dev_set_msi_domain(dev, domain);
+
+	if (platform_msi_domain_alloc_irqs(&ntb->epf->dev,
+		ntb->db_count,
+		epf_ntb_write_msi_msg)) {
+		dev_info(dev, "Can't allocate MSI, fall back to poll mode\n");
+		return;
+	}
+
+	dev_info(dev, "vntb use MSI as doorbell\n");
+
+	for (i = 0; i < ntb->db_count; i++) {
+		virq = msi_get_virq(dev, i);
+		ret = devm_request_irq(dev, virq,
+			       epf_ntb_interrupt_handler, 0,
+			       "ntb", ntb);
+
+		if (ret)
+			dev_err(dev, "devm_request_irq() failure\n");
+
+		if (!i)
+			ntb->msi_virqbase = virq;
+	}
+}
+
 /**
  * epf_ntb_epc_init() - Initialize NTB interface
  * @ntb: NTB device that facilitates communication between HOST and vHOST2
@@ -1299,14 +1388,15 @@ static int epf_ntb_bind(struct pci_epf *epf)
 		goto err_bar_alloc;
 	}
 
+	epf_set_drvdata(epf, ntb);
+	epf_ntb_epc_msi_init(ntb);
+
 	ret = epf_ntb_epc_init(ntb);
 	if (ret) {
 		dev_err(dev, "Failed to initialize EPC\n");
 		goto err_bar_alloc;
 	}
 
-	epf_set_drvdata(epf, ntb);
-
 	pci_space[0] = (ntb->vntb_pid << 16) | ntb->vntb_vid;
 	pci_vntb_table[0].vendor = ntb->vntb_vid;
 	pci_vntb_table[0].device = ntb->vntb_pid;
-- 
2.35.1

