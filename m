Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 758265F7DAB
	for <lists+linux-pci@lfdr.de>; Fri,  7 Oct 2022 21:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbiJGTOH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Oct 2022 15:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJGTOG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Oct 2022 15:14:06 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2068.outbound.protection.outlook.com [40.107.20.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A75E1E;
        Fri,  7 Oct 2022 12:14:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AGXwVJOFGqnvy9fq+4fCRYS2eDnDOpd6sm8iqAJCwjn6RtlUV+ORcZKJ/Hjp3C0ipCf4zPszN8poPr9BTiOIDdkgc35zEWsn1X2cR6SEzuzIOqi/oNiHLkZzHA0lxEy4SNdpRsi5gi8PjNua6yDxA1ookEsOyxSUplUt/XkrxOicVNZ90ELmaT7L88o/qJCp+Vj02daQUcn4xW0mMoFD1xrhq0rV9imTeyBPa/32gnJIC9wsekEwhtW8SQB6x+XLvXbIYUYw6kxPSh3u3xv2V5XvoObI0GxfvGMPC8TfZCAbM9uV4f/eQQeIUY1HC3cWckwveEF0xM+i51xtOTNfog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sv21a6BMPaapi/PwjWIE7c4OBzC9tkTbhunXpI4m54w=;
 b=ONlIqSt6xIWGPJu50cfJ7Ln652Pl8kIhXeBex7jQ0JFCZGxudMNLlfQdfv5HmdyhZXnl0cLTu6A9EihEqZ/mGs/s1W+ocsBXIKEIxFyNPJqXYnGeBJvPs5amC/NOQS4q3EVmneFiAcWfq9RQABNoGMmt9JFNrEF2uYXnpq3cTredxweRW2Vq5OYTiZ8nwfjwZZ+CRCFZUVcvtsGBUpo+kOwFcFnU5vHiPfgfFH0zCltZ7DpUoume51s1bRB7c/ljnAdu7EKySciR00n+Vy8a0gT0Z3V5s9ZWXSqlxkrfbxWSGJ0mDxMKWfxh+QyOnENG2tGG9GC1tUQdOGeRdn5m+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sv21a6BMPaapi/PwjWIE7c4OBzC9tkTbhunXpI4m54w=;
 b=AcBSK1Bg3KyiaI9hRWKB4uxZf7JYLgP1LzDzRfo7ZAUd7uy4vvDbE6dKHjj9s5QiNgkEhI9eqaY3GG5fsuuRyLwj0HoehVP5qbcno3kjAxLd5GbbSaU8MPSR4FdY7OxMGzwCY1vOdM3MJszODQNa7eBfsk5nY+gT1hVO2b8uRHE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8793.eurprd04.prod.outlook.com (2603:10a6:20b:408::22)
 by PAXPR04MB8192.eurprd04.prod.outlook.com (2603:10a6:102:1cd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Fri, 7 Oct
 2022 19:14:01 +0000
Received: from AM9PR04MB8793.eurprd04.prod.outlook.com
 ([fe80::54da:4ebc:2916:de90]) by AM9PR04MB8793.eurprd04.prod.outlook.com
 ([fe80::54da:4ebc:2916:de90%5]) with mapi id 15.20.5676.038; Fri, 7 Oct 2022
 19:14:01 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     imx@lists.linux.dev, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        ntb@lists.linux.dev (open list:NTB DRIVER CORE),
        linux-pci@vger.kernel.org (open list:PCI ENDPOINT SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v12 5/6] PCI: endpoint: pci-epf-vntb: Clean up
Date:   Fri,  7 Oct 2022 15:13:19 -0400
Message-Id: <20221007191326.193079-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::20) To AM9PR04MB8793.eurprd04.prod.outlook.com
 (2603:10a6:20b:408::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8793:EE_|PAXPR04MB8192:EE_
X-MS-Office365-Filtering-Correlation-Id: a9079cd3-ba98-44b8-84ca-08daa8981777
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1/YZRTPTEhU2vP7Tdl37MR7N0JHDR2OLGHPtcE14C63qUA2X0l3wq3tfJezKm1InodQINMWNPIHvfGx7tANPTdGhWBbalhURIPpQmQh8bAXcBZOxUtW2Gw94+Cp0Ep6RaLeave3T3SmfHbCFJiR0EEX2UmiYOpNwK/rSpumj2lI5/ngeYvGKVlgn0SAsl+vUKvXopC7Qdm9iMHdIA7QkwubeBgoy2rLVPPcUec2gA3y28ESjY/XBxeU6aku2eAm6h00YCwD95dyoBCp2eR8HuTe21WsWipBWWBRuTxeNJ7ptzYkVU1W8KPVLs6x8JUDwTdGoDqiHlt3dbk8BMIXTL73KsEvUbSMXSceCsDzzBARO8rXpAiv4ECbomUddZy2f/mAMSog65KdR4OEJb0f0Awo7UuB8gd9cFJMVcfVWkH4oYQfFeMFCUkAbVXAdiEAnWa09VDWdAlOFNp7DEEk4H0NRFlerxeyaW3StyAkdz0o4fztXkoIRZEwZJl/A63Zxfb9riSkNmw4i6xWvURTML6BJ6mLsJTaynaEJWtuN4WsyON3bUxBetK/qXvwzVKm95ZN6ZrmijPGg+hWjCOKGsLPjK19DReAazVMxWOuHjp6YFNhT/oqcyWkktN+UCWNJsgHJB2Nax1jECsUcyEpXq3d0HFWHt1JNvGduMKcuo5Z4uH/MVtSKJ9HyaSZtpeCD9NWn4v43zTnOMl4UVGQu6wuStfdQ8/3ri5rF1jwA0D9HtujudKSpUDFmavl1pM7VmkxRLutyolAJZ+B8IubfdhpPm21pUYvFIpIRoMB8c18=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8793.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(39860400002)(346002)(376002)(366004)(451199015)(66946007)(36756003)(6666004)(7416002)(30864003)(38350700002)(8676002)(38100700002)(2906002)(1076003)(41300700001)(66476007)(186003)(66556008)(83380400001)(6512007)(8936002)(2616005)(52116002)(26005)(86362001)(5660300002)(921005)(6506007)(6486002)(110136005)(478600001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P1OhdH+1A+uY06v43RGApMKlj0bZp2/UdlVxzg3uSW3eRjcgPXRb1BaaKLYL?=
 =?us-ascii?Q?D+23upZTsiBqzcVFyfoOUBIWr0ZxUAVX1hq/zfAxZS95Z/+gIusXtb8zFMKe?=
 =?us-ascii?Q?Vlpu9bK/7Pt6HzLKwBT11nOG1OLgS4FUku0BJ9hTD/J/nvozCUAf1ZgStpvR?=
 =?us-ascii?Q?b81twAT+/kwDI18K39+qDL7DeCnj4GC7XS9AC8sMWumlr1+dtoQJjpg99ip0?=
 =?us-ascii?Q?1a8FOHJykFnVXRq42JvAINI7k/fvDFahrAZQpETUWjitpMJEsBKulAKxG/9r?=
 =?us-ascii?Q?veKhHAr4ZYMXyiZ/W41UN4GdtZGGhA7KUVs5gv2fm0CXDyZnd69czoZqlh4h?=
 =?us-ascii?Q?qJAhuPa18IOR+BiFHmw6LQk2LbQRnBA5EVHj23cK8egWlpkqgEIUQvoTxueq?=
 =?us-ascii?Q?HsULvAKw6qCzWumACwdrTgoCboNeWQg5eguqYypariHBcLQf4S7Sc21K1PIo?=
 =?us-ascii?Q?+3tBIUbmPy82ZzYkf42NLeaZm4AZFGwfFapHGHRM9nS5Cf1+FlMWWxoYte8u?=
 =?us-ascii?Q?rK/hrHmcWJkOWe6WEzKd6zvC6pf04nwLPtRu/21Ufo8FVOCqDFSxStVykoTX?=
 =?us-ascii?Q?oczydSUzJiAuckOq1fObh00F+hxYDtT1pzGnlFLyS64N5pBj5c/HVJZvyqfA?=
 =?us-ascii?Q?kihFzuBzz0G/Gg5T88u6oKiqPWiiXCT3EIDdjksvTYnuqb6H5PAUjJbtnCTd?=
 =?us-ascii?Q?U9Q4iAtT21Q0f9AHexFRfvGB/HFyYhMksQ7DfBILHWeKvnb1do7rYggYkM2C?=
 =?us-ascii?Q?83Eh0rjVTrHldMkGKrU/nsH63mNmSZyeyVtR23lw9+Blu4xGExTRQAoEJh4O?=
 =?us-ascii?Q?jUNKN5vNejhg4M8kBqhH+kdaHxo9Vek/ytiHaxlNd5WtPPygzgIZnKCPL25h?=
 =?us-ascii?Q?H0HfO1T4XHTDTTDtUcl8fKXxyM9oWGwDzhCH5Ipwxw4wN6oSWG9LpvSv9m0C?=
 =?us-ascii?Q?wxszkLcUr5IaKq3sOE0CVqDzR8w55XFoZi4RYpnrOlmsntWL2okac5Mawzgy?=
 =?us-ascii?Q?plg9s73CWti2zfl426OeSrf47sYpbJLZX+gkyWnSbE8vLIOp214baXJ4otvv?=
 =?us-ascii?Q?WHG2KZgJzc3IDRbCaZkYf+9vt9a/Uf4nQI87BwywQnhvEcEOsYBiwgCLRBW6?=
 =?us-ascii?Q?W5Lkc3VhmXXcKTuwXdiqAOxH7/Dzat1w5PdLiu1KPlzrNz+HbfRKgXG6Ypbs?=
 =?us-ascii?Q?LbIDT9qX1YYTashFLGDeRX2PpIZTDJmWM15PiQHFnlhaavXomOsnsUSMjCo6?=
 =?us-ascii?Q?XJhsWzZhoXI/17Jf0noHeCqKG02f5m1R5LHbHi5W/4NORezlKeGFZHIXA0Zi?=
 =?us-ascii?Q?J+Lowt/bBOSsYYy2uPmXlgRxYc0YlY+3nc/yXyy6Z4otoEigOzTNjXx8gWHi?=
 =?us-ascii?Q?g0zXII/s+Riv7OhzX1fHMhlY6e2kWnLP3Lxp4zBfJJSSLc3STlQ5W2Dr7qLu?=
 =?us-ascii?Q?vCMCm8QQdHSDySarxbb5lA1TTNlFwPk8/jwKDfQjJbyzfgRDPsNF2vnKdouP?=
 =?us-ascii?Q?85zvSiSCvTfjjfy69l9pS3yt9oxbk96HPanGqSz7dBHcR3TDVayj1b0ruhg+?=
 =?us-ascii?Q?IPyDQro16YRhVrBqZbw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9079cd3-ba98-44b8-84ca-08daa8981777
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8793.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 19:14:01.1665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aHte+MROXysI19E+qXK0Qeqb21TZtrX1WkfJMmiqo+3ACKTYfcYTtoxOibOJSMKd8Or3qS0m5GMO4ZLZqkJ67g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8192
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
Remove duplicate check if (readl(ntb->epf_db + i * 4)).
Using sizeof(u32) instead of number 4 at all place.

Clean up sparse build warning:
  Using  epf_db[i] instead of readl() because epf_db is located in local
  memory and allocated by dma_alloc_coherent(). Sparse build warning when
  there are not __iomem at readl().
  Added __iomem force type convert in vntb_epf_peer_spad_read\write() and
  vntb_epf_spad_read\write(). This require strong order at read and write.

Replace pci_epc_mem_free_addr() with pci_epf_free_space() at error handle
path to match pci_epf_alloc_space().

Cleanup warning found by scripts/kernel-doc
Fix indentation of the struct epf_ntb_ctrl
Consolidate term
  host, host1 to HOST
  vhost, vHost, Vhost, VHOST2 to VHOST

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 157 ++++++++++--------
 1 file changed, 90 insertions(+), 67 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 1466dd1904175..acea753af29ed 100644
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
+	void __iomem *base = (void __iomem *)ntb->reg;
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
+	void __iomem *base = (void __iomem *)ntb->reg;
 
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

