Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B98625BD154
	for <lists+linux-pci@lfdr.de>; Mon, 19 Sep 2022 17:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbiISPmL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Sep 2022 11:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbiISPl5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Sep 2022 11:41:57 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2044.outbound.protection.outlook.com [40.107.21.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDCBA3A159;
        Mon, 19 Sep 2022 08:41:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AQV8xU7mPAKg165oPpAUJmJQda+r+0P4FCc8X/jHmaqD9pr4Kvl8MqAMJ3ID2bqaCZ28aKn9TD71Wff0n3Pdgu83kkBpUAaviv9CR0atKzRJZs+un2TnZb780TqWF1QWIi76NgI7W8mNDNQ/uxlAVvJBqts5bYadRPhnZLeHK4zK03vPRTqE7lPJQHhew6dRJ6BRovFbHRC0P2m032RNCMIpS1BdmyQxM3ry5ZYwDp7ap9glTLGz/TYbKAFCy/l0YnV2urGBSESo6d8GKAJ8HUY2W3yhAqa4UtrX8RLNV/hcv8Pi+dvAaeAyB1DYPqX5RTMqAT55ix0SM7PVSjVEbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S+y6KFDFpJGY3mCQokZytDF6vDhQSn1oubXHZ9oJp70=;
 b=lKE/oZ0ddbeqyoFeJ//mynRp8CR78Ra2rmooAPv/pQ5ydb05f6bordqP3R66LUVUo3XvhLWJPn7n1K9aIpiSkfRRvhSarb/t/fwQOYg6WOKiNG9eZdGIPpigixgkGz9LSw9JqEJhWLjaCJVTNgnuJalUDpZRTh1BsFvo4XhyGUgXZrVROqMsRNCmw9aoXrlR6yi3QeP3fpZnNp4OunnEXzexnPG3cXqht2IxGFU80mf0CH31YsBshPeckiZeboMEu05H+L3jOoRH7iJe3jLJzxg33qpY2CfVWOGOoYEpN1vtFT2Ds982QgSY1HEAAdo5tURnI65Iosdz6aSjJkxCWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S+y6KFDFpJGY3mCQokZytDF6vDhQSn1oubXHZ9oJp70=;
 b=GSWRiPB0gQ7prdwU4bNaO069n8Z96FzB6TntBqZu9PkQnw+58rHt8Pr92E29MXZRsI3bevVD5qHx+IVtI8/fIMQ3zVQMzt15ozC+aM74/CdcLzHbQ3d60S8aJvo3v2TgK3lDezAAowg34N/uL9fHu8wHB7g8ADu8mn9rXI3eo3A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8793.eurprd04.prod.outlook.com (2603:10a6:20b:408::22)
 by VI1PR04MB7165.eurprd04.prod.outlook.com (2603:10a6:800:125::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.19; Mon, 19 Sep
 2022 15:41:34 +0000
Received: from AM9PR04MB8793.eurprd04.prod.outlook.com
 ([fe80::5a3:ff70:317d:a99e]) by AM9PR04MB8793.eurprd04.prod.outlook.com
 ([fe80::5a3:ff70:317d:a99e%7]) with mapi id 15.20.5632.021; Mon, 19 Sep 2022
 15:41:34 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     maz@kernel.org, tglx@linutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kw@linux.com, bhelgaas@google.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        peng.fan@nxp.com, aisheng.dong@nxp.com, jdmason@kudzu.us,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        kishon@ti.com, lorenzo.pieralisi@arm.com, ntb@lists.linux.dev,
        lznuaa@gmail.com, imx@lists.linux.dev,
        manivannan.sadhasivam@linaro.org
Subject: [PATCH v11 6/6] PCI: endpoint: Add vNTB MSI support
Date:   Mon, 19 Sep 2022 10:40:38 -0500
Message-Id: <20220919154038.187168-7-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220919154038.187168-1-Frank.Li@nxp.com>
References: <20220919154038.187168-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR05CA0059.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::34) To AM9PR04MB8793.eurprd04.prod.outlook.com
 (2603:10a6:20b:408::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8793:EE_|VI1PR04MB7165:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bf9d996-843c-4df6-f113-08da9a556e7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rg7vXEHW7QxHfx9n87hsV/AQffiC5lntVSRgzKN2Ahfy/6giB3wfjF++fXjRxtNYJa2hXPsecxTMfmzT7HOrE67fVRC3NtuBWWT96qk78oAkiACZySlI2q5SSxQikR5P5DQYvVO5Mk5Lcql6FgAop+Jy5XG7qhWUKL0ljh0PPBCbcwqQcVe7Ubh+X61KWO5ghJS6GiIPwQAhY4DBxSKQwNToy1q4jUVtisR24dGLpR9lm7aR4Al8XwSWmjzZ/aVqv6VLy6iD+q4fOIBfQ6i1HHma6AwTgGWi4I5mm4xHHdEf09OtV0jA0PUoln43DE/tarFAAAYzual5kju7D/JcJnsK6tAVoFw+ZROOMXskOIHxzvRe49MIFgRf+CS9YsCx1hMhF+KntFylLJT5VOTXIPHYzYEMUP/Xq3iqWvl07i67YGpogVjkBGnq/XGi/xJbRpgF0UkTbVMK8FV1SbV0B3ekZS+uq79ejjWOgz58yCHe1B34q1c0oAf7itgsL7s8rXHuzR+JK+o+RX09LpjkxHkp92TbV8uekL8baX5OSgX/i8pRXVv5AID+Mqmx0GA1efgcbKXxtDqmS97TnO5KzH+h+OuM/sGmmJkf9D39RLBh7skVQLFn3U/KWXhHqKtMm+QclU3CijgNKvwpkm0HTddirOwO4qRJwW0PBnJWivin77sVL4HfO0rqmfnWJ492E/OIdOO0TB6QCsJe7BJw0jt5qWjK7UTEvYFhEN04slGty8VTya9jogR6hTq7pSJLWuT/Fd4gvYG9H5Aw1bYmRg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8793.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(396003)(346002)(376002)(136003)(451199015)(4326008)(36756003)(1076003)(2906002)(2616005)(66946007)(38100700002)(38350700002)(83380400001)(8936002)(6486002)(186003)(66556008)(66476007)(478600001)(86362001)(8676002)(6512007)(26005)(316002)(41300700001)(5660300002)(52116002)(6506007)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFZoeWoyZzMrbDRRMUIxN1dLek5NN0JlNFNqMm1ER0VRc3FFMEVhWW1RK2lC?=
 =?utf-8?B?QjdXQlY5TThaNGgxdlBxV1VkVFBadlhubWRzV3VoZTFlL2hVOXhRWkxHRHA1?=
 =?utf-8?B?U3ZqTW1YNS95VmVqY0NvdFBuWE5KbUlybmlqRTJUSXA5YzZ1OWg5ZCtUS2o1?=
 =?utf-8?B?ZWFlWSthTzdlUEw0aTN0dkpjSDgxUlkxbXc5dHA5YnZxaStDZmxDczF3WHZU?=
 =?utf-8?B?aVNZR0FaZm5vaVhYQUdzZkdEa1oyVitpclVwZFNVVy9ZWVl3cDhuZ2E4Sy9z?=
 =?utf-8?B?UEZ1YVpFY05waGl1L3hKdUw5aTM0MnZhc0pvM1p3RkNWY3Urd3VSRnM1MFJm?=
 =?utf-8?B?VndRK0duUHlyekF3d2xaait5a1g4R25pUFAvbW1ZU3o2QUdWanB5M09raUx2?=
 =?utf-8?B?NU1zdVhNQTkvYkhzUFVoWEpXZmNWa3JoT3l6dkFOMHAzVmc1N3RlYU1sak5O?=
 =?utf-8?B?bWtZdk82V240TzR0ajRpUC9hSnVMb0lDWDFKQmNzWnpaV05LNmZ5VUs2R0JC?=
 =?utf-8?B?U043RllnajN4S09CZmFEWWRHT2o4c3FNMUtrbXA4VTcvT2FBMFRBekFBeElO?=
 =?utf-8?B?WXMyRCtaa2JxVG9uS3NxaGJXZ3c3ZklmZ2xDbWMvR0MrVmxOM0lsMkZZei8y?=
 =?utf-8?B?cnk4TUVMajY3SEJLWEtqLzIyUUlHVUYvZ3NjaGFRcjdVelJPS3R6eWgzenhL?=
 =?utf-8?B?T1ZUR0tPbEIyOGJ6VDFmRzJLcEk5UWVhRHdpUmE0aktqYnRRL21TWkxGeWRj?=
 =?utf-8?B?empNZ0xqTURScmZMaEMzaSt5akErSDJpRkgrbG5NbnFVZDZwVEgxUnRHZXJI?=
 =?utf-8?B?UGxOaG41MTdGZVRRZ3B3Zlp5SFNKTUVmaCtaWlhZK3ZNNGJDYldyUmlGeGJy?=
 =?utf-8?B?YmJXYzNZQmVJMmpQQ0NQanN3bC9VWWYzZEdCeGpZOHAzb1BsU3pYcU9kTktG?=
 =?utf-8?B?TFdMcWRLeHhoZC8yd00rcVVBSVJXNVRvR1JWM09MaE5HZ1NERzJzeTIrWVhD?=
 =?utf-8?B?NkV1UW1hQmNtMXYyejV5VEdSNXFzNzJQUktvditNZHdiWkFRc0kwT1lFbW9j?=
 =?utf-8?B?K2lFV3ZLNXZaTzZjSkZNRzU5VmdtU3FWYW8wVXk4NmprR2owNHdzc2xYU255?=
 =?utf-8?B?UDR1S1Exc21ObkRmaWZHb0dSb2xzRDJST1NMWEJkN3ZMZXY2a2I4MXVYbzJm?=
 =?utf-8?B?ZGNtSW95U0JKWE00VTB5VGRVUG1reS9qU3N5VkFTQjRPMzlGZ3FjTmFoY1l2?=
 =?utf-8?B?R0puMFY5bjhDZWVQYUIxbnZhclk1QUxwNUVBV0tvNWVLS2REdUZYbVBSN3Uw?=
 =?utf-8?B?ZnkwVml2dU9XNlNlRFdoYitOQVo5QW1RRGIzNGxReDhsVlFiQjhySEU5TWdU?=
 =?utf-8?B?djBlQVorUzdNMmdseFZQdVNwRFAza1RRSlNiL0x6TjMzRFBRSmduZWZqeGMv?=
 =?utf-8?B?aldlekdiWTBFZFhvekxLbUZvYlpscXE5bWtoYXpOUmljOXZqeTkxUmFuSS9Q?=
 =?utf-8?B?dmY2TC9wY0o5ZUJHYlluM0RqWUc1bitFOWlBYWhSVTJwSXVWL0ZROTEzNmE5?=
 =?utf-8?B?L2lveDFTeUlEMmNRWHA4dVlxNHk1Y1BMTi9UUXdMaHdsVUNmdU9wSTVGNCsy?=
 =?utf-8?B?L0VWUjBhK1JzVEhpa2k3ZG5zcmRQbE5rby81V0tGeDFlVUJhd1VjbG05THYw?=
 =?utf-8?B?bnc3cE0zUkovSkRKWEtIenEyWFVLanNlNlBic2tncVNpSHRhVTNmWUIrczJz?=
 =?utf-8?B?MWt4aFNFZlNwRUM1L3IwWE5vaU55TFptTUtCV0xuYjhyUWkvcC9UNW0vb0VF?=
 =?utf-8?B?WHdqaEVBZlFEUFh1UmxBMDJHb0tpTWk1bjJqOGdlVFFheFdRNWJxUHhvVG1x?=
 =?utf-8?B?cCs0YWVuV3R2am9sek1WaUlrVTcrNzdEZTNlZFlha0lEYnYwcVRXQWpLcHNK?=
 =?utf-8?B?ZTRVbjRvSzF4TG9hbFRTdE9tV2F3Nmwxa0sxamljZG1uZTNxZFBMc1JpTm15?=
 =?utf-8?B?Y0FoZjVIdktaMTNpQ1RQaFlHZ2h6SjhmQ0xEYytadHBCNEdNdEdRYWVIRDEr?=
 =?utf-8?B?cTFrTjYybGpvWllVbHlob2J3VjJyODFneS9YdFk0b0ZVYTJyeXZ3eFlzTnph?=
 =?utf-8?Q?Hwc62LwkTLpcDygsnTd8bc084?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bf9d996-843c-4df6-f113-08da9a556e7c
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8793.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 15:41:34.7299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qoUQVLjzwSH/cAwj5amgKUGYDSlDc3lSzAHa9xh9hi4H7bmq1k09Kaea+C9LIoTraUx5f9ikZDhHuxeA9eJghg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7165
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

                      ┌───────┐                   ┌──────────┐
                      │       │                   │          │
    ┌─────────────┐   │ PCI   │                   │ PCI Host │
    │ MSI         │◄┐ │ EP    │                   │          │
    │ Controller  │ │ │       │ 3.MSI Write       │          │
    └────────┬────┘ └─┼───────┼───────────────────┤          │
      ▲      │        │       │                   ├─BAR_n    │
      │      └────────┼───────┼──────────────────►│          │
      │               │       │ 2.Call Back       │          │
      │               │       │   write_msi_msg() │          │
      │               │       │                   │          │
      │               └───┬───┘                   └──────────┘
      │                   │
      └───────────────────┘
      1.platform_msi_domain_alloc_irqs()

There is no defined way of raising IRQs by PCI host to the PCI endpoint.
Only define MSI/MSI-X to let EP notified RC status change.

The memory assigned for BAR region by the PCI host is mapped to the
message address of platform msi interrupt controller in PCI Endpoint.
Such that, whenever the PCI host writes to the BAR region, it will
trigger an IRQ in the Endpoint.

Basic working follow as
1. EP function driver call platform_msi_domain_alloc_irqs() alloc a
MSI irq from MSI controller with call back function write_msi_msg();
2. write_msg_msg will config BAR and map to address defined in msi_msg;
3. Host side trigger an IRQ in Endpoint by write to BAR region.

Add MSI support for pci-epf-vntb. Query if system has an MSI controller.
Set up doorbell address according to struct msi_msg.

So PCI RC can write this doorbell address to trigger EP side's IRQ.

If no MSI controller exists, fall back to software polling.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 149 +++++++++++++++---
 1 file changed, 128 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 90522de00c6a9..34e01c30aea41 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -44,6 +44,7 @@
 #include <linux/pci-epc.h>
 #include <linux/pci-epf.h>
 #include <linux/ntb.h>
+#include <linux/msi.h>
 
 static struct workqueue_struct *kpcintb_workqueue;
 
@@ -137,11 +138,14 @@ struct epf_ntb {
 	struct epf_ntb_ctrl *reg;
 
 	u32 *epf_db;
+	phys_addr_t epf_db_phys;
 
 	phys_addr_t vpci_mw_phy[MAX_MW];
 	void __iomem *vpci_mw_addr[MAX_MW];
 
 	struct delayed_work cmd_handler;
+
+	int msi_virqbase;
 };
 
 #define to_epf_ntb(epf_group) container_of((epf_group), struct epf_ntb, group)
@@ -256,10 +260,13 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
 
 	ntb = container_of(work, struct epf_ntb, cmd_handler.work);
 
-	for (i = 1; i < ntb->db_count; i++) {
-		if (ntb->epf_db[i]) {
-			ntb_db_event(&ntb->ntb, i);
-			ntb->epf_db[i] = 0;
+	if (!ntb->epf_db_phys) {
+		for (i = 1; i < ntb->db_count; i++) {
+			if (ntb->epf_db[i]) {
+				ntb->db |= 1 << (i - 1);
+				ntb_db_event(&ntb->ntb, i);
+				ntb->epf_db[i] = 0;
+			}
 		}
 	}
 
@@ -464,7 +471,7 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
 
 	for (i = 0; i < ntb->db_count; i++) {
 		ntb->reg->db_data[i] = 1 + i;
-		ntb->reg->db_offset[i] = 0;
+		ntb->reg->db_offset[i] = sizeof(u32) * i;
 	}
 
 	return 0;
@@ -517,6 +524,28 @@ static int epf_ntb_configure_interrupt(struct epf_ntb *ntb)
 	return 0;
 }
 
+static int epf_ntb_db_size(struct epf_ntb *ntb)
+{
+	const struct pci_epc_features *epc_features;
+	size_t size = sizeof(u32) * ntb->db_count;
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
  * @ntb: NTB device that facilitates communication between HOST and VHOST
@@ -540,27 +569,26 @@ static int epf_ntb_db_bar_init(struct epf_ntb *ntb)
 					    ntb->epf->func_no,
 					    ntb->epf->vfunc_no);
 	align = epc_features->align;
-
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
+	if (ntb->epf_db_phys) {
+		mw_addr = NULL;
+		epf_bar->phys_addr = ntb->epf_db_phys;
+		epf_bar->barno = barno;
+		epf_bar->size = size;
+	} else {
+		mw_addr = pci_epf_alloc_space(ntb->epf, size, barno, align, 0);
+		if (!mw_addr) {
+			dev_err(dev, "Failed to allocate doorbell address\n");
+			return -ENOMEM;
+		}
 	}
 
 	ntb->epf_db = mw_addr;
 
-	epf_bar = &ntb->epf->bar[barno];
-
 	ret = pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no, ntb->epf->vfunc_no, epf_bar);
 	if (ret) {
 		dev_err(dev, "Doorbell BAR set failed\n");
@@ -719,6 +747,84 @@ static int epf_ntb_init_epc_bar(struct epf_ntb *ntb)
 	return 0;
 }
 
+#ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
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
+	if (!desc->msi_index)
+		ntb->epf_db_phys = round_down(addr, size);
+
+	reg->db_offset[desc->msi_index] = addr - ntb->epf_db_phys;
+}
+#endif
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
+#ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
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
+		dev_err(dev, "Can't allocate MSI, falling back to polling mode\n");
+		return;
+	}
+	dev_info(dev, "Using MSI as doorbell\n");
+
+	for (i = 0; i < ntb->db_count; i++) {
+		virq = msi_get_virq(dev, i);
+		ret = devm_request_irq(dev, virq,
+			       epf_ntb_interrupt_handler, 0,
+			       "pci_epf_vntb", ntb);
+
+		if (ret) {
+			dev_err(dev, "Failed to request doorbell IRQ! Falling back to polling mode");
+			ntb->epf_db_phys = 0;
+			break;
+		}
+
+		if (!i)
+			ntb->msi_virqbase = virq; /* msi start virq number */
+	}
+}
+#else
+static void epf_ntb_epc_msi_init(struct epf_ntb *ntb)
+{
+	return;
+}
+#endif /* CONFIG_GENERIC_MSI_IRQ_DOMAIN */
 /**
  * epf_ntb_epc_init() - Initialize NTB interface
  * @ntb: NTB device that facilitates communication between HOST and VHOST
@@ -1320,14 +1426,15 @@ static int epf_ntb_bind(struct pci_epf *epf)
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

