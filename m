Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAA314BFE77
	for <lists+linux-pci@lfdr.de>; Tue, 22 Feb 2022 17:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233989AbiBVQY7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Feb 2022 11:24:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233818AbiBVQY6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Feb 2022 11:24:58 -0500
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30078.outbound.protection.outlook.com [40.107.3.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37618166A7F
        for <linux-pci@vger.kernel.org>; Tue, 22 Feb 2022 08:24:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K/WeWjou6hGhrTGTmGl0S15NTs7/AEnz8HuSn6aMiGTHxaMaNKPHz226NUJ6dY3CoTE/pvzp34C1AyOa5cExul/reRuDfEoM56PF5zVUXcT6zOmmhFqUEOJgnqmvrrtoDQ1Kvrv6kfyFQXOsn3nsnIJK0dZmRIVUXGjyszNXJUzWOkhwS0FzyWN4mRoXrLAnYWpzdJXC3hlk873+cIvqFGMyJ+2mjk8oYT+m8yz4DaeySRMhzixHDmDQoAYfDwYJ+pj6tj2tSDEggbncJV1sq+H1q5HRY1Guez880CQ9CIdzGJ4vZqN5nUC82e8ODIufd/3Fds0Tmt4AP/+C6O1KOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=syqeyh9sDq3XB/OxlHsD1WyO7hRhOqnap2TksE0n8ag=;
 b=PvIzn/mdDY4dYKs+JPTXQW2c6G6aIkVQCn8Ml8ySHj0iQi4Dnlk09exTM92sInxY8SGgk8aQgkHOdMsGosHB2pi1sUPSnxYOzBSeZltoI+UY/BiO/daZSEg614W4dHXWzlrze3o7l+BCzrYdDsDGGUaQfkAM/CG+mF3+NcGdcZ4PVwitQNtl7oNw3gJaG98pjTgcwODBiJLQgS+4i2Dxcb3lZSkkzw8uB9b2YCLl98IG+6idyWPjSG1cLeNvB1BIlGZD6LdhusI7AszrH/WQcq5Yz0uLMDg+D/3ePN/5Fvx923wGmLNKoAApvTnTflPso3HkunoPVG7pHnxEXMbFRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=syqeyh9sDq3XB/OxlHsD1WyO7hRhOqnap2TksE0n8ag=;
 b=oWKkKe2lc14mMDsbZGCGX0CD52IHg5ScHVKDv3XtdwehU2o02qxJZ2w9H8a2bGHBqj44FvduTTRUXQP1SBCO+hl/GsyVcJVH/T2fRu2oZJKlASMnLi7frB7Wd1g7Cvo1/hrf6jfItX9Wiw7bXTIktBSUcE6Grl16NFravLKGl18=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by DBBPR04MB7899.eurprd04.prod.outlook.com (2603:10a6:10:1e1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.27; Tue, 22 Feb
 2022 16:24:29 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::9ce4:9be4:64f8:9c6]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::9ce4:9be4:64f8:9c6%6]) with mapi id 15.20.4995.027; Tue, 22 Feb 2022
 16:24:29 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     helgaas@kernel.org, kishon@ti.com, lorenzo.pieralisi@arm.com,
        kw@linux.com, jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lznuaa@gmail.com, hongxing.zhu@nxp.com, jdmason@kudzu.us,
        dave.jiang@intel.com, allenbh@gmail.com
Cc:     linux-ntb@googlegroups.com, linux-pci@vger.kernel.org
Subject: [PATCH v2 4/4] Documentation: PCI: Add specification for the PCI vNTB function device
Date:   Tue, 22 Feb 2022 10:23:55 -0600
Message-Id: <20220222162355.32369-5-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.24.0.rc1
In-Reply-To: <20220222162355.32369-1-Frank.Li@nxp.com>
References: <20220222162355.32369-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0190.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::15) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cef7c806-af87-4fae-97de-08d9f61fccef
X-MS-TrafficTypeDiagnostic: DBBPR04MB7899:EE_
X-Microsoft-Antispam-PRVS: <DBBPR04MB7899A147DE0042F1316D26A1883B9@DBBPR04MB7899.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /m8gsAZjofKRsMgm4g3WTFqWRqeuRjNJfm2UrlQnAra+ui2BzexGZg+iuFhX4/AlgeVzB8pZ0L6Ym9mz0ddPcXreCGutvrOJZbdiQZqqqcjiiyHJ0FN6kE61tRm6DvC3Rp0cDmbDM5UDqrsya2LFSn7oPr8HCeEBo3c7/uDD6csIVmxkq/brlTf7sDTwHJzHIXRKuTsmtgTWtvMcr8AMlQIsPuJ8hNKkmv8OzzEq8YRGz0G1rZQUj04eCDqAWPbM2MTTPycrED7vZ1kf41sjL7or0eqsCBhdF97+yPh1knaYQLrLzkkyJsY4+G2hPwgNdz6Empa+PcnQRNBUPKBmckLQVWQPUCnhM2ULl3N71hOT/89mXy8zkKD68bCZDz1Htwq92ghlyy6sGkm01l89GOlfPQ1Cp0be1P9tafDtF4uUnT6bMUJPfAJ6Fhn0Z/L10qW2WxtLm73C4hkCuWPThiQreUO/Qh5TJoYe4ow2RO3Rn40b4eKDdX6ZJgCVr/v1lw3vt9e/yvlKu0jS+ymnytFnwkhp/f+Qb9qQBKu9nnu4IvMk+fkrZo9p8NwAK5HfLbq5IC3cJgigJpFBgnR/OLiXbK2Y6plq5yMGHjwIhHzl+zIHG48HkjzstIabrVXf338FPQHAPfEjms9sSx5JbsUFqwJPSFgqy2crQEyrWhE74EaltzsX4GVYox49vipVCNZ17Z9F7i4c2JfVviD123kOrIs96yHvNR92NKtI9go=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(66556008)(83380400001)(508600001)(4326008)(36756003)(8676002)(66476007)(6486002)(52116002)(6666004)(6506007)(5660300002)(26005)(1076003)(186003)(86362001)(8936002)(316002)(7416002)(2616005)(38350700002)(6512007)(38100700002)(921005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qcUucny0OCzmfoL4zhc2br1xjpsFYIErklcKJhXmAU/UP61ECb5+BpcW97w5?=
 =?us-ascii?Q?ksskSjLqZruEhkzU6BiaUT/63KqEVVmajfuPjBXG8/ZUVGcmJ5gjS3Rc1Nzu?=
 =?us-ascii?Q?qLd3QI34a16GQFQrnR0XpejH0E+HvQV9mh/qcfqMm6oh5I9pJYbwuHTF5RMV?=
 =?us-ascii?Q?AX+2jcMAH25JQ//g/zkfra/HS7AZE8oorHXblVdYduaLC8zIKFT5Qcr7fUfy?=
 =?us-ascii?Q?s27VbQaaniijO1kSomEx4MQHWXPA7XI4raHrbhdo7sJRrtyFwk2MJ0jVkCTT?=
 =?us-ascii?Q?r6A7WaKPMlAQWUdak7U+hY7CI5YI0LKUmASWFXoaLlK9GAQeXqkCnqYRPDEv?=
 =?us-ascii?Q?Qx8gvx6Q59fnZTwDTyen5EK5vH2fYk2u5anAiCRns2eHAh4GNuKpkZTUFTvx?=
 =?us-ascii?Q?+JQL6Bb4WU+C1a77PKyGA3DGvbKfhnR0wn9/CMN1ll2U84lYQuyHe9lH/fYc?=
 =?us-ascii?Q?O0gE3oize42w2WTgH0Xew2zqktfmsyqTbU5kZmzwzG0EnyIwIYYgbAZniOQT?=
 =?us-ascii?Q?lmwgqmx533rFOZh7Z+GxKEqL4iGW6Vkl63HFx3yZuAvvGf60yDAwXXtxYm1e?=
 =?us-ascii?Q?1WnnY3CenDwIQcloUXBvR1WHOJ6/oGSPfb+Iy7BKoaoT+4NiKe5v1+xV3ZXl?=
 =?us-ascii?Q?xyVryJZ9+Z0eExWJKPCo3P0kI3Ph/PTu6Sy0i4dhFHn80rZYMDTmcKMDzORv?=
 =?us-ascii?Q?s+Y0anznb8gcQKkh2nefi6ePkBTjJbT4U7I6CIMNbZum+KWj1Qn/xww9dXGi?=
 =?us-ascii?Q?bFQ6txg1Zu2h9UWgJGFQsNGv7IaQ6UkcS+b4bhPm9QSjwuMj3c09BiWmplwz?=
 =?us-ascii?Q?eQhFAddhamad/HC4WXnCCC0Ie+OMQBzwaJYC9dLVanGUNJbIjPndwe9fUEPn?=
 =?us-ascii?Q?D7b4srn243CphUcxIFplxaLXHMlukcObSc3Gwh/AqhVyT7Ll8KETDjQkKDvk?=
 =?us-ascii?Q?nMg4KNWrLfHzgVfuJ3T480BFlbtYSktSv2czkcmc01el6MJ2fnXpuK5wufpg?=
 =?us-ascii?Q?YkKFRl9CdLGnBEeLH0GFNH8k6c7HbkvfeY00JTcbmBM/zIegoEVe30kyITp0?=
 =?us-ascii?Q?LbHySFcuyArSKycd2NAPp97hvridhEYnQPCaMJ1eGZQC8SS2s80yNOyFc2F1?=
 =?us-ascii?Q?HFavLKVKmryTIw/evPVU3OHRVe7IXF36oF/aLawx85+dkWa2dJ8aC5iBvPXo?=
 =?us-ascii?Q?vSXETWFJJa2ykqqpBPx6bhMv11zyEY0jeJALTZxOrP1h8f6n8FQbTeD1alhi?=
 =?us-ascii?Q?3NpiQUSxuJNugNqeNjDU9SaMBeDDxxxqifnrwKfn5YroMB2qfgadWCNPGESu?=
 =?us-ascii?Q?BUv1ZAfjU1GshqAwyC5IvT/E0gRy0Iq0uZf8MkFOrmG7ZZuKHadglpi99A7g?=
 =?us-ascii?Q?V/0I/L9ciX5yTqxiAA3KNUlp59wTQvqgOe6mlSIjISowa7i3/eEvcMWd2Z3M?=
 =?us-ascii?Q?RnTZcOdT1cFaAXi2n21jaYJljkI8zt+kGtFD8pMgXmAengrkm88FvptT4z/3?=
 =?us-ascii?Q?wseYAh0nuO53SD6NCzKVWfWEK1W7VrZXYb6B/E0/BVKM0wOadp7ucb7q9uML?=
 =?us-ascii?Q?5WsXFx+tXuqMxINK5JFehL3qBMaL2/2rh6EsY6+LkwsK4Si27HMP9urG1zFG?=
 =?us-ascii?Q?Ow/ERp60eaRGK0/YYRLeoIY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cef7c806-af87-4fae-97de-08d9f61fccef
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 16:24:29.5745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c97L1VvuXhB3oedStq/eVez+p2djGVHioPASjBVwkfhqUtJkEkicBOgDudTBsuT4P2nyA3mt6CKLVAjh6ZXYBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7899
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add specification for the PCI vNTB function device. The endpoint function
driver and the host PCI driver should be created based on this
specification.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v1:
 - Add virtual pci ntb driver config

 Documentation/PCI/endpoint/index.rst          |   2 +
 .../PCI/endpoint/pci-vntb-function.rst        | 126 +++++++++++++
 Documentation/PCI/endpoint/pci-vntb-howto.rst | 167 ++++++++++++++++++
 3 files changed, 295 insertions(+)
 create mode 100644 Documentation/PCI/endpoint/pci-vntb-function.rst
 create mode 100644 Documentation/PCI/endpoint/pci-vntb-howto.rst

diff --git a/Documentation/PCI/endpoint/index.rst b/Documentation/PCI/endpoint/index.rst
index 38ea1f604b6d3..4d2333e7ae067 100644
--- a/Documentation/PCI/endpoint/index.rst
+++ b/Documentation/PCI/endpoint/index.rst
@@ -13,6 +13,8 @@ PCI Endpoint Framework
    pci-test-howto
    pci-ntb-function
    pci-ntb-howto
+   pci-vntb-function
+   pci-vntb-howto
 
    function/binding/pci-test
    function/binding/pci-ntb
diff --git a/Documentation/PCI/endpoint/pci-vntb-function.rst b/Documentation/PCI/endpoint/pci-vntb-function.rst
new file mode 100644
index 0000000000000..cad8013e88390
--- /dev/null
+++ b/Documentation/PCI/endpoint/pci-vntb-function.rst
@@ -0,0 +1,126 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=================
+PCI vNTB Function
+=================
+
+:Author: Frank Li <Frank.Li@nxp.com>
+
+The difference between PCI NTB function and PCI vNTB function is
+
+PCI NTB function need at two endpoint instances and connect HOST1
+and HOST2.
+
+PCI vNTB function only use one host and one endpoint(EP), use NTB
+connect EP and PCI host
+
+.. code-block:: text
+
+
+  +------------+         +---------------------------------------+
+  |            |         |                                       |
+  +------------+         |                        +--------------+
+  | NTB        |         |                        | NTB          |
+  | NetDev     |         |                        | NetDev       |
+  +------------+         |                        +--------------+
+  | NTB        |         |                        | NTB          |
+  | Transfer   |         |                        | Transfer     |
+  +------------+         |                        +--------------+
+  |            |         |                        |              |
+  |  PCI NTB   |         |                        |              |
+  |    EPF     |         |                        |              |
+  |   Driver   |         |                        | PCI Virtual  |
+  |            |         +---------------+        | NTB Driver   |
+  |            |         | PCI EP NTB    |<------>|              |
+  |            |         |  FN Driver    |        |              |
+  +------------+         +---------------+        +--------------+
+  |            |         |               |        |              |
+  |  PCI BUS   | <-----> |  PCI EP BUS   |        |  Virtual PCI |
+  |            |  PCI    |               |        |     BUS      |
+  +------------+         +---------------+--------+--------------+
+      PCI RC                        PCI EP
+
+Constructs used for Implementing vNTB
+=====================================
+
+	1) Config Region
+	2) Self Scratchpad Registers
+	3) Peer Scratchpad Registers
+	4) Doorbell (DB) Registers
+	5) Memory Window (MW)
+
+
+Config Region:
+--------------
+
+It is same as PCI NTB Function driver
+
+Scratchpad Registers:
+---------------------
+
+  It is appended after Config region.
+
+  +--------------------------------------------------+ Base
+  |                                                  |
+  |                                                  |
+  |                                                  |
+  |          Common Config Register                  |
+  |                                                  |
+  |                                                  |
+  |                                                  |
+  +-----------------------+--------------------------+ Base + span_offset
+  |                       |                          |
+  |    Peer Span Space    |    Span Space            |
+  |                       |                          |
+  |                       |                          |
+  +-----------------------+--------------------------+ Base + span_offset
+  |                       |                          |      + span_count * 4
+  |                       |                          |
+  |     Span Space        |   Peer Span Space        |
+  |                       |                          |
+  +-----------------------+--------------------------+
+        Virtual PCI             Pcie Endpoint
+        NTB Driver               NTB Driver
+
+
+Doorbell Registers:
+-------------------
+
+  Doorbell Registers are used by the hosts to interrupt each other.
+
+Memory Window:
+--------------
+
+  Actual transfer of data between the two hosts will happen using the
+  memory window.
+
+Modeling Constructs:
+====================
+
+32-bit BARs.
+
+======  ===============
+BAR NO  CONSTRUCTS USED
+======  ===============
+BAR0    Config Region
+BAR1    Doorbell
+BAR2    Memory Window 1
+BAR3    Memory Window 2
+BAR4    Memory Window 3
+BAR5    Memory Window 4
+======  ===============
+
+64-bit BARs.
+
+======  ===============================
+BAR NO  CONSTRUCTS USED
+======  ===============================
+BAR0    Config Region + Scratchpad
+BAR1
+BAR2    Doorbell
+BAR3
+BAR4    Memory Window 1
+BAR5
+======  ===============================
+
+
diff --git a/Documentation/PCI/endpoint/pci-vntb-howto.rst b/Documentation/PCI/endpoint/pci-vntb-howto.rst
new file mode 100644
index 0000000000000..524cd487e1840
--- /dev/null
+++ b/Documentation/PCI/endpoint/pci-vntb-howto.rst
@@ -0,0 +1,167 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===================================================================
+PCI Non-Transparent Bridge (NTB) Endpoint Function (EPF) User Guide
+===================================================================
+
+:Author: Frank Li <Frank.Li@nxp.com>
+
+This document is a guide to help users use pci-epf-vntb function driver
+and ntb_hw_epf host driver for NTB functionality. The list of steps to
+be followed in the host side and EP side is given below. For the hardware
+configuration and internals of NTB using configurable endpoints see
+Documentation/PCI/endpoint/pci-vntb-function.rst
+
+Endpoint Device
+===============
+
+Endpoint Controller Devices
+---------------------------
+
+To find the list of endpoint controller devices in the system::
+
+        # ls /sys/class/pci_epc/
+          5f010000.pcie_ep
+
+If PCI_ENDPOINT_CONFIGFS is enabled::
+
+        # ls /sys/kernel/config/pci_ep/controllers
+          5f010000.pcie_ep
+
+Endpoint Function Drivers
+-------------------------
+
+To find the list of endpoint function drivers in the system::
+
+	# ls /sys/bus/pci-epf/drivers
+	pci_epf_ntb  pci_epf_test  pci_epf_vntb
+
+If PCI_ENDPOINT_CONFIGFS is enabled::
+
+	# ls /sys/kernel/config/pci_ep/functions
+	pci_epf_ntb  pci_epf_test  pci_epf_vntb
+
+
+Creating pci-epf-vntb Device
+----------------------------
+
+PCI endpoint function device can be created using the configfs. To create
+pci-epf-vntb device, the following commands can be used::
+
+	# mount -t configfs none /sys/kernel/config
+	# cd /sys/kernel/config/pci_ep/
+	# mkdir functions/pci_epf_vntb/func1
+
+The "mkdir func1" above creates the pci-epf-ntb function device that will
+be probed by pci_epf_vntb driver.
+
+The PCI endpoint framework populates the directory with the following
+configurable fields::
+
+	# ls functions/pci_epf_ntb/func1
+	baseclass_code    deviceid          msi_interrupts    pci-epf-ntb.0
+	progif_code       secondary         subsys_id         vendorid
+	cache_line_size   interrupt_pin     msix_interrupts   primary
+	revid             subclass_code     subsys_vendor_id
+
+The PCI endpoint function driver populates these entries with default values
+when the device is bound to the driver. The pci-epf-vntb driver populates
+vendorid with 0xffff and interrupt_pin with 0x0001::
+
+	# cat functions/pci_epf_vntb/func1/vendorid
+	0xffff
+	# cat functions/pci_epf_vntb/func1/interrupt_pin
+	0x0001
+
+
+Configuring pci-epf-vntb Device
+-------------------------------
+
+The user can configure the pci-epf-vntb device using its configfs entry. In order
+to change the vendorid and the deviceid, the following
+commands can be used::
+
+	# echo 0x1957 > functions/pci_epf_vntb/func1/vendorid
+	# echo 0x0809 > functions/pci_epf_vntb/func1/deviceid
+
+In order to configure NTB specific attributes, a new sub-directory to func1
+should be created::
+
+	# mkdir functions/pci_epf_vntb/func1/pci_epf_vntb.0/
+
+The NTB function driver will populate this directory with various attributes
+that can be configured by the user::
+
+	# ls functions/pci_epf_vntb/func1/pci_epf_vntb.0/
+	db_count    mw1         mw2         mw3         mw4         num_mws
+	spad_count
+
+A sample configuration for NTB function is given below::
+
+	# echo 4 > functions/pci_epf_vntb/func1/pci_epf_vntb.0/db_count
+	# echo 128 > functions/pci_epf_vntb/func1/pci_epf_vntb.0/spad_count
+	# echo 1 > functions/pci_epf_vntb/func1/pci_epf_vntb.0/num_mws
+	# echo 0x100000 > functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw1
+
+A sample configuration for virtual NTB driver for virutal PCI bus::
+
+	# echo 0x1957 > functions/pci_epf_vntb/func1/pci_epf_vntb.0/vntb_vid
+	# echo 0x080A > functions/pci_epf_vntb/func1/pci_epf_vntb.0/vntb_pid
+	# echo 0x10 > functions/pci_epf_vntb/func1/pci_epf_vntb.0/vbus_number
+
+Binding pci-epf-ntb Device to EP Controller
+--------------------------------------------
+
+NTB function device should be attached to PCI endpoint controllers
+connected to the host.
+
+	# ln -s controllers/5f010000.pcie_ep functions/pci-epf-ntb/func1/primary
+
+Once the above step is completed, the PCI endpoint controllers are ready to
+establish a link with the host.
+
+
+Start the Link
+--------------
+
+In order for the endpoint device to establish a link with the host, the _start_
+field should be populated with '1'. For NTB, both the PCI endpoint controllers
+should establish link with the host (imx8 don't need this steps)::
+
+	# echo 1 > controllers/5f010000.pcie_ep/start
+
+RootComplex Device
+==================
+
+lspci Output at Host side
+------------------------
+
+Note that the devices listed here correspond to the values populated in
+"Creating pci-epf-ntb Device" section above::
+
+	# lspci
+        00:00.0 PCI bridge: Freescale Semiconductor Inc Device 0000 (rev 01)
+        01:00.0 RAM memory: Freescale Semiconductor Inc Device 0809
+
+Endpoint Device / Virtual PCI bus
+=================================
+
+lspci Output at EP Side / Virtual PCI bus
+-----------------------------------------
+
+Note that the devices listed here correspond to the values populated in
+"Creating pci-epf-ntb Device" section above::
+
+        # lspci
+        10:00.0 Unassigned class [ffff]: Dawicontrol Computersysteme GmbH Device 1234 (rev ff)
+
+Using ntb_hw_epf Device
+-----------------------
+
+The host side software follows the standard NTB software architecture in Linux.
+All the existing client side NTB utilities like NTB Transport Client and NTB
+Netdev, NTB Ping Pong Test Client and NTB Tool Test Client can be used with NTB
+function device.
+
+For more information on NTB see
+:doc:`Non-Transparent Bridge <../../driver-api/ntb>`
-- 
2.24.0.rc1

