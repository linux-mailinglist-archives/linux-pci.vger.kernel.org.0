Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACF75BD151
	for <lists+linux-pci@lfdr.de>; Mon, 19 Sep 2022 17:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbiISPmA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Sep 2022 11:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbiISPlq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Sep 2022 11:41:46 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2044.outbound.protection.outlook.com [40.107.21.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A89399F8;
        Mon, 19 Sep 2022 08:41:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g8GF9W/A+ADNtUH9c3WBdfBdHLZxp06Tx+iYniz5wrhJQJQsShM6Eg0orA3dt060/iH+PnFxa1f+msiSYLgUVXD01Q1Rr8ChBgnKPYJFFUXDYI/Uw2oCUz208iRRRQoW6WV+ifETH7FXzlixUgxJBe014tp0T1z8bKg8Y4btLubZeQuoc6kY22nDuOMIghsHhhIRgvU8lpB3+Pvuiy/0dw1ha6Dn9Ip/BbPnqtyrGbrK0UeAwDyEcDqJtJGYzPG/I+kI25J2fAKuXBNV/oLaJVeSCL1W55Yraudu/nqY14YfkN2+K3evpBPlqPlNZWgGZyIJHYCGrAuJXQdfXDnkSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q4AcB2RqDPI/KvJ8x43udsBlzc9VfZ0PGuEvXiaJtys=;
 b=D/05vQV3louTKEsGA5hqauvKpn2PjeLVVTtQxXGEUtpIEtUDv0dDuKlyfWNXhPflI5IKkgTpOAistCmhk/pZ1szglo/GSPu5SX4nwKXc8FpcYPtnf4JmevafS2hfii1BKzl3BX5SDGfeHDQfEZDbtoxSM8ap5Bb5Cmc+iwDsNO+wA1e4hnzF2yzk07rRpbTKCy2gQikF/CBxAbyfybhNQ+fR7vVAj/kh/tzt54zzPG0LLqueHsDp6BnePJdBDlnW5uXZIu7sRoV2zuiuL0cDKY+XF0iS16BBfNXXuGmVrNPEVAN55Rpv1zOLmpd9AVIaoIcNzf8aakZOoxwLpCtmmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q4AcB2RqDPI/KvJ8x43udsBlzc9VfZ0PGuEvXiaJtys=;
 b=o05cF1HcHq4oSZhN4+N2QzsAFoQpCkRLQQJ4Cjf0XEL3gUVl2XeQ228betp+ajY1+nObxH6xMnOIOypmh4IbyYXOWIzGkxD5WTVq35pU1zknBFejrA5NNwQUA5mG9dDXN4RSl/srum4pWwFZIxTfm7TbxyuRe8lGENvNh/HYY68=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8793.eurprd04.prod.outlook.com (2603:10a6:20b:408::22)
 by VI1PR04MB7165.eurprd04.prod.outlook.com (2603:10a6:800:125::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.19; Mon, 19 Sep
 2022 15:41:29 +0000
Received: from AM9PR04MB8793.eurprd04.prod.outlook.com
 ([fe80::5a3:ff70:317d:a99e]) by AM9PR04MB8793.eurprd04.prod.outlook.com
 ([fe80::5a3:ff70:317d:a99e%7]) with mapi id 15.20.5632.021; Mon, 19 Sep 2022
 15:41:29 +0000
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
Subject: [PATCH v11 5/6] PCI: endpoint: cleanup pci-epf-vntb.c
Date:   Mon, 19 Sep 2022 10:40:37 -0500
Message-Id: <20220919154038.187168-6-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220919154038.187168-1-Frank.Li@nxp.com>
References: <20220919154038.187168-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0059.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::34) To AM9PR04MB8793.eurprd04.prod.outlook.com
 (2603:10a6:20b:408::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8793:EE_|VI1PR04MB7165:EE_
X-MS-Office365-Filtering-Correlation-Id: abe7d279-6fa2-4f41-9156-08da9a556b30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RsIB34wZCjE7UruW2H0eOsCicBNiZqbLutJE2yTUF6SMFYm3ZxZaaqk/ERaTeEBBdkzrSuur6Js6BWL7g2mkfHH7Y3Lv3vJbWh9r9gJQ/mpUOnZDoN91C//obrrMBDaO/b2NJuGNadqV8E035OOXHT8lAQ7WevUZXbR9V4/RUjb+9im/P44GYMTU/CWieFkSyTNfq99y6SlfMfytYLqz+eKzoEQSqiRFPojesQS1Vtv0ZBwcodBb1ca1WWPPsyl3pTu8IIFPPaNSlu7Rc6i2S3Rsd/al1HLHtH/J5fdAVwUxRQtKgfv1qWKzJaxGzrpRmMroWgxSMPd95jHRf2t5+e+93N5SzeDcfTkkPLWzcxCFLutKNfLh321qsoKt+TrpD/5udC8zNJHgoBTW9PH/6722CPmeWdDLt07u+CnhGno8lLw3iwYDGZZX/xk/zLDCHasf9D1Skm/HrJhuzKyMid3M+HfAWN6FKhUvjUkAzpQFyESo1dnr0kyxG2aduBVb4BoQ3r39Mqr51c2XbaV7sOTmWKA84C0MvJmJDcHG5UQAl/gWJyuysxLwsichY0+G0sBAqBcIzvgG4QU+8irPhhQLd108Rrnu18MIMfHrnCvseaYowUSbL9KIzPZ6XxfoXEYzHJ+tCANJ8jJFAwAcrIVyaBOyEYWXdewveNd4QrzVozJJ189ECr3s1s2ZA5PqrG6sSOyDusBrtGjnB0FS7MgcYBl/JVo9wdOgHvp/cnof9WycpAnuOt4T8E9pTujSpPUL1uQj+xkkH/T5UbCCFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8793.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(396003)(346002)(376002)(136003)(451199015)(4326008)(36756003)(1076003)(2906002)(2616005)(66946007)(38100700002)(38350700002)(83380400001)(8936002)(6486002)(186003)(66556008)(66476007)(6666004)(478600001)(86362001)(8676002)(6512007)(26005)(316002)(41300700001)(5660300002)(52116002)(6506007)(7416002)(30864003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kNucwszJKmh6Fx/AlmM2hgDZ0TKoXCi72fnaAnnioYlszm2QYlpPTyH0dbLV?=
 =?us-ascii?Q?1rrxJXMIjG3xy9Kkyj9pw/Wu07Qp7q3WY4wHT1MhMFC1V0KDU0/vdevcPSS9?=
 =?us-ascii?Q?7Pdx6hAJbkU/MQxUql9KGuXquhGTprD1WKXmZH1MD5QocIWtn0VuDl+zPNMS?=
 =?us-ascii?Q?w0HlzgZ7AqAXuQ4fnloutcCN6R/oegcoEmizUAiOloX95SVVC2ulfrJfgyvW?=
 =?us-ascii?Q?EbPKx/gX6+cztRnraluUeOA0/iPkOQxBQTJ74v1KtEAY/2pqY/3UylTBHsQl?=
 =?us-ascii?Q?mUHnkvZqmXZ3jUeC5KXIM2zacLRw/c49fW2gHuUkLRpTJM6aB48hIOAqtGGo?=
 =?us-ascii?Q?uRUBzN6+zT4gS7T0OeNu3XMcC0yueahO3THx7RJiN4zWgVQzbUeByj/YlGc+?=
 =?us-ascii?Q?u4uSI3exU3g5WOvO+LDNHpWOWN6QXpSpjlDGDWeOds/TjpO+OzZjYWFED+ls?=
 =?us-ascii?Q?jt+rJphCNdOYww6MIdheXQfYAO5qidAgN6zDTRsB3tLAX8z18RG6m7NRvG3k?=
 =?us-ascii?Q?EFy6YKCsDeiN57WRuhZ94tIGTF33etxs7k4BPlfDwUZLItsXR0y92DguhJBj?=
 =?us-ascii?Q?X1IQZi1J0MLBEVJvTdH2QWYHn3Guo2b/t6GqNxl9EqcIjoZv/Zhv1Kpy3cE7?=
 =?us-ascii?Q?dOkZVqLhtcYazxLuqOKQL2aSrModdjenfu2JDCnHD/Bo6kHzcFukxgNr5h8S?=
 =?us-ascii?Q?EPHBpDfq6T6FnXBPSShCtezUQQZq3t5G23bNltctmfN5VDU7dcjnAEmtMECk?=
 =?us-ascii?Q?Ee0YUM8U8HtBPh3nQmSwryv6sCBMcqvX9rKd9fRNz6YcYG3AlY+ZKxNbd4RR?=
 =?us-ascii?Q?OFEiRSev7va7McTtb92CaMECiLxwkmCgpUFRBtXHUhXYBi+5luWyFphe+bhJ?=
 =?us-ascii?Q?i3xS5+NjVrI+NJ5rLBJfKxqsZWAKEa3N2baU08aXh878yQCemOCqstP+8Dzc?=
 =?us-ascii?Q?EcLoaxdbyDyBE/G/9aO4RQGrDfJQAyfwKVUrYXySQXEqp6STfwvD9VIu/zlj?=
 =?us-ascii?Q?YNSo7WUJfhxUNvFRTTbywaDidc0wLAXkvshhe6jkH/hWBGNQg8vKIRBv0Edp?=
 =?us-ascii?Q?MDaCfUMckklf3ImA2vrFPgN1NhkozqqKFo0jm4xubmiyuAez8bbCzOE7doIK?=
 =?us-ascii?Q?7keSsR6IaPNcGxwFzGS/jdfyTXH1pyJaTFg2yNOOKZDEKn7wgtY6U/w6kchq?=
 =?us-ascii?Q?WosWuxU/9AHomxbE46WP9bxEEfZOwUQVQNi8flYmlEOT2KP3bDFWMPdapj2+?=
 =?us-ascii?Q?hlAH+y9E4jnFzM/ZpIdQJUKngbtNFZV2dhrYJCIUWSGlz/ZjYuNPLue5HYn3?=
 =?us-ascii?Q?qa9WmVjaGEJBGYbFL4Or+tjfLcrMoDl0z/fbYKKC3ckxEE8vR9khdY2xLQuC?=
 =?us-ascii?Q?V20rk912US3pvXrJ2AOLP8IxhnH/0vzkIiYwWHSGXG5jo0VP2Ng4P6JdjguG?=
 =?us-ascii?Q?Z6NmVrT9/8A9ta1FKGpkTkZb0uOhulAteBfzScL16beJAY1di6wUyxEj+8b8?=
 =?us-ascii?Q?fuOn/QvGECBMIP76ajk10hFfyBUmkgqAWRwPuzzEafT8qZnVuEAZrs9D/JiZ?=
 =?us-ascii?Q?dIj1jXCqdAyShDXSU0+cIWp1tWYHyEcBHXEILnV8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abe7d279-6fa2-4f41-9156-08da9a556b30
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8793.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 15:41:28.9619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EG34kZ+5AJ5XDgDqEKJlxcLygsEnr3ihxW2QD/giQU+/goDAIhBZdrFLkFUCtYXTmaBY3KS/QxBbr80+MPXtuA==
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

Remove unused field: epf_db_phy.
Remove __iomem before epf_db.
Change epf_db to u32* from void *
Remove dupicate check if (readl(ntb->epf_db + i * 4)).
Using sizeof(u32) instead of number 4 at all place.

Clean up sparse build warning
  Using  epf_db[i] instead of readl() because epf_db is located in local memory
  and allocated by dma_alloc_coherent()

Replace pci_epc_mem_free_addr() with pci_epf_free_space() at error handle path
to match pci_epf_alloc_space().

Cleanup warning found by scripts/kernel-doc
Fix indentation of the struct epf_ntb_ctrl
Consildate term
  host, host1 to HOST
  vhost, vHost, Vhost, VHOST2 to VHOST

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 157 ++++++++++--------
 1 file changed, 90 insertions(+), 67 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 1466dd1904175..90522de00c6a9 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -11,7 +11,7 @@
  * Author: Kishon Vijay Abraham I <kishon@ti.com>
  */
 
-/**
+/*
  * +------------+         +---------------------------------------+
  * |            |         |                                       |
  * +------------+         |                        +--------------+
@@ -99,20 +99,20 @@ enum epf_ntb_bar {
  *       NTB Driver               NTB Driver
  */
 struct epf_ntb_ctrl {
-	u32     command;
-	u32     argument;
-	u16     command_status;
-	u16     link_status;
-	u32     topology;
-	u64     addr;
-	u64     size;
-	u32     num_mws;
-	u32	reserved;
-	u32     spad_offset;
-	u32     spad_count;
-	u32	db_entry_size;
-	u32     db_data[MAX_DB_COUNT];
-	u32     db_offset[MAX_DB_COUNT];
+	u32 command;
+	u32 argument;
+	u16 command_status;
+	u16 link_status;
+	u32 topology;
+	u64 addr;
+	u64 size;
+	u32 num_mws;
+	u32 reserved;
+	u32 spad_offset;
+	u32 spad_count;
+	u32 db_entry_size;
+	u32 db_data[MAX_DB_COUNT];
+	u32 db_offset[MAX_DB_COUNT];
 } __packed;
 
 struct epf_ntb {
@@ -136,8 +136,7 @@ struct epf_ntb {
 
 	struct epf_ntb_ctrl *reg;
 
-	phys_addr_t epf_db_phy;
-	void __iomem *epf_db;
+	u32 *epf_db;
 
 	phys_addr_t vpci_mw_phy[MAX_MW];
 	void __iomem *vpci_mw_addr[MAX_MW];
@@ -156,12 +155,14 @@ static struct pci_epf_header epf_ntb_header = {
 };
 
 /**
- * epf_ntb_link_up() - Raise link_up interrupt to Virtual Host
+ * epf_ntb_link_up() - Raise link_up interrupt to Virtual Host (VHOST)
  * @ntb: NTB device that facilitates communication between HOST and VHOST
  * @link_up: true or false indicating Link is UP or Down
  *
  * Once NTB function in HOST invoke ntb_link_enable(),
- * this NTB function driver will trigger a link event to vhost.
+ * this NTB function driver will trigger a link event to VHOST.
+ *
+ * Returns: Zero for success, or an error code in case of failure
  */
 static int epf_ntb_link_up(struct epf_ntb *ntb, bool link_up)
 {
@@ -175,9 +176,9 @@ static int epf_ntb_link_up(struct epf_ntb *ntb, bool link_up)
 }
 
 /**
- * epf_ntb_configure_mw() - Configure the Outbound Address Space for vhost
- *   to access the memory window of host
- * @ntb: NTB device that facilitates communication between host and vhost
+ * epf_ntb_configure_mw() - Configure the Outbound Address Space for VHOST
+ *   to access the memory window of HOST
+ * @ntb: NTB device that facilitates communication between HOST and VHOST
  * @mw: Index of the memory window (either 0, 1, 2 or 3)
  *
  *                          EP Outbound Window
@@ -194,7 +195,9 @@ static int epf_ntb_link_up(struct epf_ntb *ntb, bool link_up)
  * |        |              |           |
  * |        |              |           |
  * +--------+              +-----------+
- *  VHost                   PCI EP
+ *  VHOST                   PCI EP
+ *
+ * Returns: Zero for success, or an error code in case of failure
  */
 static int epf_ntb_configure_mw(struct epf_ntb *ntb, u32 mw)
 {
@@ -219,7 +222,7 @@ static int epf_ntb_configure_mw(struct epf_ntb *ntb, u32 mw)
 
 /**
  * epf_ntb_teardown_mw() - Teardown the configured OB ATU
- * @ntb: NTB device that facilitates communication between HOST and vHOST
+ * @ntb: NTB device that facilitates communication between HOST and VHOST
  * @mw: Index of the memory window (either 0, 1, 2 or 3)
  *
  * Teardown the configured OB ATU configured in epf_ntb_configure_mw() using
@@ -234,12 +237,12 @@ static void epf_ntb_teardown_mw(struct epf_ntb *ntb, u32 mw)
 }
 
 /**
- * epf_ntb_cmd_handler() - Handle commands provided by the NTB Host
+ * epf_ntb_cmd_handler() - Handle commands provided by the NTB HOST
  * @work: work_struct for the epf_ntb_epc
  *
  * Workqueue function that gets invoked for the two epf_ntb_epc
  * periodically (once every 5ms) to see if it has received any commands
- * from NTB host. The host can send commands to configure doorbell or
+ * from NTB HOST. The HOST can send commands to configure doorbell or
  * configure memory window or to update link status.
  */
 static void epf_ntb_cmd_handler(struct work_struct *work)
@@ -254,12 +257,9 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
 	ntb = container_of(work, struct epf_ntb, cmd_handler.work);
 
 	for (i = 1; i < ntb->db_count; i++) {
-		if (readl(ntb->epf_db + i * 4)) {
-			if (readl(ntb->epf_db + i * 4))
-				ntb->db |= 1 << (i - 1);
-
+		if (ntb->epf_db[i]) {
 			ntb_db_event(&ntb->ntb, i);
-			writel(0, ntb->epf_db + i * 4);
+			ntb->epf_db[i] = 0;
 		}
 	}
 
@@ -321,8 +321,8 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
 
 /**
  * epf_ntb_config_sspad_bar_clear() - Clear Config + Self scratchpad BAR
- * @ntb_epc: EPC associated with one of the HOST which holds peer's outbound
- *	     address.
+ * @ntb: EPC associated with one of the HOST which holds peer's outbound
+ *	 address.
  *
  * Clear BAR0 of EP CONTROLLER 1 which contains the HOST1's config and
  * self scratchpad region (removes inbound ATU configuration). While BAR0 is
@@ -331,8 +331,10 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
  * used for self scratchpad from epf_ntb_bar[BAR_CONFIG].
  *
  * Please note the self scratchpad region and config region is combined to
- * a single region and mapped using the same BAR. Also note HOST2's peer
- * scratchpad is HOST1's self scratchpad.
+ * a single region and mapped using the same BAR. Also note VHOST's peer
+ * scratchpad is HOST's self scratchpad.
+ *
+ * Returns: void
  */
 static void epf_ntb_config_sspad_bar_clear(struct epf_ntb *ntb)
 {
@@ -347,13 +349,15 @@ static void epf_ntb_config_sspad_bar_clear(struct epf_ntb *ntb)
 
 /**
  * epf_ntb_config_sspad_bar_set() - Set Config + Self scratchpad BAR
- * @ntb: NTB device that facilitates communication between HOST and vHOST
+ * @ntb: NTB device that facilitates communication between HOST and VHOST
  *
- * Map BAR0 of EP CONTROLLER 1 which contains the HOST1's config and
+ * Map BAR0 of EP CONTROLLER which contains the VHOST's config and
  * self scratchpad region.
  *
  * Please note the self scratchpad region and config region is combined to
  * a single region and mapped using the same BAR.
+ *
+ * Returns: Zero for success, or an error code in case of failure
  */
 static int epf_ntb_config_sspad_bar_set(struct epf_ntb *ntb)
 {
@@ -380,7 +384,7 @@ static int epf_ntb_config_sspad_bar_set(struct epf_ntb *ntb)
 /**
  * epf_ntb_config_spad_bar_free() - Free the physical memory associated with
  *   config + scratchpad region
- * @ntb: NTB device that facilitates communication between HOST and vHOST
+ * @ntb: NTB device that facilitates communication between HOST and VHOST
  */
 static void epf_ntb_config_spad_bar_free(struct epf_ntb *ntb)
 {
@@ -393,11 +397,13 @@ static void epf_ntb_config_spad_bar_free(struct epf_ntb *ntb)
 /**
  * epf_ntb_config_spad_bar_alloc() - Allocate memory for config + scratchpad
  *   region
- * @ntb: NTB device that facilitates communication between HOST1 and HOST2
+ * @ntb: NTB device that facilitates communication between HOST and VHOST
  *
  * Allocate the Local Memory mentioned in the above diagram. The size of
  * CONFIG REGION is sizeof(struct epf_ntb_ctrl) and size of SCRATCHPAD REGION
  * is obtained from "spad-count" configfs entry.
+ *
+ * Returns: Zero for success, or an error code in case of failure
  */
 static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
 {
@@ -424,7 +430,7 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
 	spad_count = ntb->spad_count;
 
 	ctrl_size = sizeof(struct epf_ntb_ctrl);
-	spad_size = 2 * spad_count * 4;
+	spad_size = 2 * spad_count * sizeof(u32);
 
 	if (!align) {
 		ctrl_size = roundup_pow_of_two(ctrl_size);
@@ -454,7 +460,7 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
 	ctrl->num_mws = ntb->num_mws;
 	ntb->spad_size = spad_size;
 
-	ctrl->db_entry_size = 4;
+	ctrl->db_entry_size = sizeof(u32);
 
 	for (i = 0; i < ntb->db_count; i++) {
 		ntb->reg->db_data[i] = 1 + i;
@@ -465,11 +471,13 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
 }
 
 /**
- * epf_ntb_configure_interrupt() - Configure MSI/MSI-X capaiblity
- * @ntb: NTB device that facilitates communication between HOST and vHOST
+ * epf_ntb_configure_interrupt() - Configure MSI/MSI-X capability
+ * @ntb: NTB device that facilitates communication between HOST and VHOST
  *
  * Configure MSI/MSI-X capability for each interface with number of
  * interrupts equal to "db_count" configfs entry.
+ *
+ * Returns: Zero for success, or an error code in case of failure
  */
 static int epf_ntb_configure_interrupt(struct epf_ntb *ntb)
 {
@@ -511,18 +519,22 @@ static int epf_ntb_configure_interrupt(struct epf_ntb *ntb)
 
 /**
  * epf_ntb_db_bar_init() - Configure Doorbell window BARs
- * @ntb: NTB device that facilitates communication between HOST and vHOST
+ * @ntb: NTB device that facilitates communication between HOST and VHOST
+ *
+ * Returns: Zero for success, or an error code in case of failure
  */
 static int epf_ntb_db_bar_init(struct epf_ntb *ntb)
 {
 	const struct pci_epc_features *epc_features;
-	u32 align;
 	struct device *dev = &ntb->epf->dev;
-	int ret;
 	struct pci_epf_bar *epf_bar;
-	void __iomem *mw_addr;
 	enum pci_barno barno;
-	size_t size = 4 * ntb->db_count;
+	void *mw_addr;
+	size_t size;
+	u32 align;
+	int ret;
+
+	size = sizeof(u32) * ntb->db_count;
 
 	epc_features = pci_epc_get_features(ntb->epf->epc,
 					    ntb->epf->func_no,
@@ -557,14 +569,14 @@ static int epf_ntb_db_bar_init(struct epf_ntb *ntb)
 	return ret;
 
 err_alloc_peer_mem:
-	pci_epc_mem_free_addr(ntb->epf->epc, epf_bar->phys_addr, mw_addr, epf_bar->size);
+	pci_epf_free_space(ntb->epf, mw_addr, barno, 0);
 	return -1;
 }
 
 /**
  * epf_ntb_db_bar_clear() - Clear doorbell BAR and free memory
  *   allocated in peer's outbound address space
- * @ntb: NTB device that facilitates communication between HOST and vHOST
+ * @ntb: NTB device that facilitates communication between HOST and VHOST
  */
 static void epf_ntb_db_bar_clear(struct epf_ntb *ntb)
 {
@@ -580,8 +592,9 @@ static void epf_ntb_db_bar_clear(struct epf_ntb *ntb)
 
 /**
  * epf_ntb_mw_bar_init() - Configure Memory window BARs
- * @ntb: NTB device that facilitates communication between HOST and vHOST
+ * @ntb: NTB device that facilitates communication between HOST and VHOST
  *
+ * Returns: Zero for success, or an error code in case of failure
  */
 static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
 {
@@ -629,7 +642,7 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
 
 /**
  * epf_ntb_mw_bar_clear() - Clear Memory window BARs
- * @ntb: NTB device that facilitates communication between HOST and vHOST
+ * @ntb: NTB device that facilitates communication between HOST and VHOST
  */
 static void epf_ntb_mw_bar_clear(struct epf_ntb *ntb)
 {
@@ -652,7 +665,7 @@ static void epf_ntb_mw_bar_clear(struct epf_ntb *ntb)
 
 /**
  * epf_ntb_epc_destroy() - Cleanup NTB EPC interface
- * @ntb: NTB device that facilitates communication between HOST and vHOST
+ * @ntb: NTB device that facilitates communication between HOST and VHOST
  *
  * Wrapper for epf_ntb_epc_destroy_interface() to cleanup all the NTB interfaces
  */
@@ -665,7 +678,9 @@ static void epf_ntb_epc_destroy(struct epf_ntb *ntb)
 /**
  * epf_ntb_init_epc_bar() - Identify BARs to be used for each of the NTB
  * constructs (scratchpad region, doorbell, memorywindow)
- * @ntb: NTB device that facilitates communication between HOST and vHOST
+ * @ntb: NTB device that facilitates communication between HOST and VHOST
+ *
+ * Returns: Zero for success, or an error code in case of failure
  */
 static int epf_ntb_init_epc_bar(struct epf_ntb *ntb)
 {
@@ -706,11 +721,13 @@ static int epf_ntb_init_epc_bar(struct epf_ntb *ntb)
 
 /**
  * epf_ntb_epc_init() - Initialize NTB interface
- * @ntb: NTB device that facilitates communication between HOST and vHOST2
+ * @ntb: NTB device that facilitates communication between HOST and VHOST
  *
  * Wrapper to initialize a particular EPC interface and start the workqueue
- * to check for commands from host. This function will write to the
+ * to check for commands from HOST. This function will write to the
  * EP controller HW for configuring it.
+ *
+ * Returns: Zero for success, or an error code in case of failure
  */
 static int epf_ntb_epc_init(struct epf_ntb *ntb)
 {
@@ -777,7 +794,7 @@ static int epf_ntb_epc_init(struct epf_ntb *ntb)
 
 /**
  * epf_ntb_epc_cleanup() - Cleanup all NTB interfaces
- * @ntb: NTB device that facilitates communication between HOST1 and HOST2
+ * @ntb: NTB device that facilitates communication between HOST and VHOST
  *
  * Wrapper to cleanup all NTB interfaces.
  */
@@ -934,6 +951,8 @@ static const struct config_item_type ntb_group_type = {
  *
  * Add configfs directory specific to NTB. This directory will hold
  * NTB specific properties like db_count, spad_count, num_mws etc.,
+ *
+ * Returns: Pointer to config_group
  */
 static struct config_group *epf_ntb_add_cfs(struct pci_epf *epf,
 					    struct config_group *group)
@@ -1084,11 +1103,11 @@ static int vntb_epf_link_enable(struct ntb_dev *ntb,
 static u32 vntb_epf_spad_read(struct ntb_dev *ndev, int idx)
 {
 	struct epf_ntb *ntb = ntb_ndev(ndev);
-	int off = ntb->reg->spad_offset, ct = ntb->reg->spad_count * 4;
+	int off = ntb->reg->spad_offset, ct = ntb->reg->spad_count * sizeof(u32);
 	u32 val;
-	void __iomem *base = ntb->reg;
+	void __iomem *base = (void __iomem *)ntb->reg;
 
-	val = readl(base + off + ct + idx * 4);
+	val = readl(base + off + ct + idx * sizeof(u32));
 	return val;
 }
 
@@ -1096,10 +1115,10 @@ static int vntb_epf_spad_write(struct ntb_dev *ndev, int idx, u32 val)
 {
 	struct epf_ntb *ntb = ntb_ndev(ndev);
 	struct epf_ntb_ctrl *ctrl = ntb->reg;
-	int off = ctrl->spad_offset, ct = ctrl->spad_count * 4;
-	void __iomem *base = ntb->reg;
+	int off = ctrl->spad_offset, ct = ctrl->spad_count * sizeof(u32);
+	void __iomem *base = (void __iomem *)ntb->reg;
 
-	writel(val, base + off + ct + idx * 4);
+	writel(val, base + off + ct + idx * sizeof(u32));
 	return 0;
 }
 
@@ -1108,10 +1127,10 @@ static u32 vntb_epf_peer_spad_read(struct ntb_dev *ndev, int pidx, int idx)
 	struct epf_ntb *ntb = ntb_ndev(ndev);
 	struct epf_ntb_ctrl *ctrl = ntb->reg;
 	int off = ctrl->spad_offset;
-	void __iomem *base = ntb->reg;
+	void __iomem *base = (void __iomem*)ntb->reg;
 	u32 val;
 
-	val = readl(base + off + idx * 4);
+	val = readl(base + off + idx * sizeof(u32));
 	return val;
 }
 
@@ -1120,9 +1139,9 @@ static int vntb_epf_peer_spad_write(struct ntb_dev *ndev, int pidx, int idx, u32
 	struct epf_ntb *ntb = ntb_ndev(ndev);
 	struct epf_ntb_ctrl *ctrl = ntb->reg;
 	int off = ctrl->spad_offset;
-	void __iomem *base = ntb->reg;
+	void __iomem *base = (void __iomem*)ntb->reg;
 
-	writel(val, base + off + idx * 4);
+	writel(val, base + off + idx * sizeof(u32));
 	return 0;
 }
 
@@ -1275,6 +1294,8 @@ static struct pci_driver vntb_pci_driver = {
  * Invoked when a primary interface or secondary interface is bound to EPC
  * device. This function will succeed only when EPC is bound to both the
  * interfaces.
+ *
+ * Returns: Zero for success, or an error code in case of failure
  */
 static int epf_ntb_bind(struct pci_epf *epf)
 {
@@ -1359,6 +1380,8 @@ static struct pci_epf_ops epf_ntb_ops = {
  *
  * Probe NTB function driver when endpoint function bus detects a NTB
  * endpoint function.
+ *
+ * Returns: Zero for success, or an error code in case of failure
  */
 static int epf_ntb_probe(struct pci_epf *epf)
 {
-- 
2.35.1

