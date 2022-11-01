Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B32FB614FD6
	for <lists+linux-pci@lfdr.de>; Tue,  1 Nov 2022 17:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbiKAQ5v (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Nov 2022 12:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbiKAQ5s (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Nov 2022 12:57:48 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70047.outbound.protection.outlook.com [40.107.7.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC3E1D0FC;
        Tue,  1 Nov 2022 09:57:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c1aH0xa7Fmz9JuqGPI3uEmPDYtTT2fmvLKOdyXQgOn4Sj6xCh+gQ0o3H9SZ/aMdAs/i5YOJC5fyMbUZSWGYGGB8E4LjiPFSr1ruSjEl4au7Z2fWIK9QyH0DyIocKk/l72qPVz433J35wZsle4Y9AMD6wqqaoXbAuX7MRWDL7MXDgzmWQ3CuqfCQyyjKxhTghGigYi8fkSVGlXuuieYB8HsvEwsQnoLvstipfomjxi4yqZZ7aT3JwmhBLl/sg5qzxILoDmgH2OMRqDxAk4mHiQuxCmlTFSk4maqT+xU9gAGqFkRDuttzZ3bXWPsIAtKcXovHLvl2Ksqvrr/gzxx6cHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cg9Cz+TfGC5o2RUupkOOm59g23D635oht16Vk34QK4Y=;
 b=QCAgJN2OtWoB8bU+o94ug8SObJqBxrghjCidoajvvCfiATUEHTpRErBL2HBdwiruykxWwYhHK7BAgzdjKiB7ZzerCP0kso0UsZuBYBrtRzzNyW3ONguyCYsPuhAh9Ckxn0YeV0HS6gCOgStoGJsGnVQdJzHdD2z2kPRUhfCEWbS7j7vXVWu7mZA4PyOOj+DelE7oHTvpmmEzuzcnrRkQvZyP+6oWZ6irN/sv99P4/tbMOvEPzyBV39rfIUAmHH3ABvzbuMgSJv4rIH1SdyN66goRdXrNKrCwtky21IRq3RvdpSqLKJ3V0MEVazFrd/tJMgFuAVeUlkr8lWRHZVrPIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cg9Cz+TfGC5o2RUupkOOm59g23D635oht16Vk34QK4Y=;
 b=V8kJkq87shf8IAL0EVpMIkY8ujsSNjb6r9CjYa1vzAdKV/++TWZqk25s2LlA2DHF6p9+QjsbDxGC+jbVcM/S+tIDweBjDJGw8ww2c5REayypZQqnMPQ/ELtQ9WSQjhof01D7/niWr8ZjHsongHQf6owhYZhPS0NxP2sBJVjoaSY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by DU2PR04MB8631.eurprd04.prod.outlook.com (2603:10a6:10:2de::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Tue, 1 Nov
 2022 16:57:45 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::44bb:8387:8f4b:6a28]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::44bb:8387:8f4b:6a28%11]) with mapi id 15.20.5769.021; Tue, 1 Nov 2022
 16:57:45 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     mani@kernel.org
Cc:     Frank.Li@nxp.com, allenbh@gmail.com, bhelgaas@google.com,
        dave.jiang@intel.com, helgaas@kernel.org, imx@lists.linux.dev,
        jdmason@kudzu.us, kw@linux.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lpieralisi@kernel.org,
        ntb@lists.linux.dev
Subject: [PATCH v15 4/7] PCI: endpoint: pci-epf-vntb: remove unused field epf_db_phy
Date:   Tue,  1 Nov 2022 12:57:06 -0400
Message-Id: <20221101165709.983416-5-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221101165709.983416-1-Frank.Li@nxp.com>
References: <20221101165709.983416-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0007.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::20) To HE1PR0401MB2331.eurprd04.prod.outlook.com
 (2603:10a6:3:24::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2331:EE_|DU2PR04MB8631:EE_
X-MS-Office365-Filtering-Correlation-Id: 4871a37b-9a5e-4f56-7105-08dabc2a3295
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QUqTAWuxjMJ2yT8f3n55CiLT+wQV8v0ZUs1Togn5bs4fDyXCFCywozglK1fmf1i+/QCSSMH3KpS0X1jqZ/HBYIyCE2z3GJkUQwEr3nOHbOZFpVjdKNEwyd/8O5pr5s/hM1EV1pnCNSdECVql2Vado+dLBvxhWQGvOg3+kKEPhEl3xXGECL58nAXXgVhq3mtHeUJXvSw42VLjdne1Oi9xCU7/eztJnPWfZlAzc2ybQeqKCQKU8B16Y06BojzAfdGLv/LQoF1YSGvJekgffKPO8WwYIdNC7bPKlsaDg8kC3GUX2moC+V4w8tHYlKKf906WYNwc+R7ONien8jmCQSMVMjVaMmeOfGfOlVUeSBx/DXop9LIDTnbmiGwFxD5zsdYmDGrbLwjoye6RGqA98iPXpqfKo9M4v1LQHXAPYRlhMF4oHRjghAt1Ps3V31vuyQqCuODg4oZXm267cqhUeZJbL827LillK9V2SjJ9ty8kVRlG0k3IIWDnJrM99pN7hdI1mKCuD8v0ab2EzAvjlg+ELOzmVCdTNEnUDPpKkEhCHixTwsipgFQBTJ14Zp2MFx4bRZrLU8jdmf3AgkboiNoTyrMOOwTidrc7LLPue7szAz5o9qv7BoNQ8t3u86Q8+MSINX975rWU1XJ7bwjpCPajK888DLApRbZ4p2GuPqJd+CJQZhRskG8PNtAcZpP2LLiwKF58m3DdZM+6kUZP1dKaGURRrJY7I35My1TEpm/ULI3UzVJrp8eJXZERl/zxykInr3689OYZaagqybX+Sl6GhA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(39860400002)(366004)(136003)(376002)(451199015)(83380400001)(36756003)(86362001)(38350700002)(38100700002)(6916009)(316002)(6666004)(2616005)(1076003)(7416002)(4744005)(5660300002)(186003)(6486002)(2906002)(6512007)(26005)(41300700001)(6506007)(8676002)(4326008)(66476007)(66556008)(66946007)(52116002)(8936002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ICT/kEomWu3od2dSIMiGaHx6wKc3G/ClTbFqRzrEQ727Fq5lObCoYkeVf9DV?=
 =?us-ascii?Q?naWri7fkB7qCpTqUqLZU2maXS871/6IB24neONtGZgwyMqdmilxda9gmth3A?=
 =?us-ascii?Q?4eP0uCzfj5R6LSlhbh4pcHL0rrkYxhoSsEkpvbyzbxzFziBmk7E5fWGHfV9S?=
 =?us-ascii?Q?9eq7vqr2DUKYdxuE9OjtM/f5+O2brJ8Fkf2NWNtRiVDXR/WIhxIa+NekEEI0?=
 =?us-ascii?Q?nlS1Z0cM131lhGtEiryvDKWlUXewwcT7Hakbfd28Br9qjXyKSaCPVyg6QX0u?=
 =?us-ascii?Q?1cnWxvIKZzHNg4ppt6QW1QxhICtvBytViNIBZBuL9oOXmGbI1ZMXDm6LqhHa?=
 =?us-ascii?Q?vNAkoET5nup3PeZ6QaZkn3k/iSPznxIc4jVbzuPnol82NDATzWf2XkNpZCNr?=
 =?us-ascii?Q?kyq7TQ8sktoHZ6lq0nY9jVe67aRWv8Tke5c8sS6axnGIb4l+N9w9M9oerkXW?=
 =?us-ascii?Q?tYdQuDsA6JwV7Y/Rmot6ptILSeeB9j8QNKFB/CzbFnfC5VxWr6Nzo10eYRW8?=
 =?us-ascii?Q?CwHAwvPDPaqMxAM9Vll/VwW/Z9J7+XT0aqrJraRSdeGa0q7f439ujepaLBQR?=
 =?us-ascii?Q?6Ro62rS8UzXMS1waBa0JMfylaih9jRkPOtzfMjn3IhrppceNXoDtN5xWBuUI?=
 =?us-ascii?Q?xJ8P+BkWHKz6i0yYn2iA1q89mrDqrtGOpM5aXTr0ZJ2/TsnZKnugI0WVeoSk?=
 =?us-ascii?Q?gUwbieZ4KyRp+fA5p8R/NPPXMF5FHT7tc15a43DH8zw63TrAPcK6GwBk0LQW?=
 =?us-ascii?Q?KLd3gksM4Gy/hu5M3enZPtxVzdKQzB7iDtzzpLo7Xik1C2NsbjkOPDwX4/hx?=
 =?us-ascii?Q?yYWlmPwCYFbjIwjDI7vQr394/UUsXUJK0kJ7+076JHmibPGVb04zzLtlWvkJ?=
 =?us-ascii?Q?tx4I5tPsfJJ8vj69Q8/KEHrb0aS3arKW1y1Z9hYHAuklo141lWjt4jAa1dtT?=
 =?us-ascii?Q?cDEFe2CfHf3rFjZmhOF3jPc+FwXoXzP7tzlbHs7szzbgm2TzSAKRiHnwE3RH?=
 =?us-ascii?Q?gpQt34pe5/Xf3GHQoODM1xP5p3e2iqaQR8pqvdUsUYxubLfkdcrl4ZAH7IY4?=
 =?us-ascii?Q?5u1hiHuKjnqjIJNgibMFtTVMvit3hrB/5V+dMlzT6HlQG9CPKf0bD9RwPQ7I?=
 =?us-ascii?Q?TGvdX+QH7vQGhJhl/8R+T9DUzhT26nZkoK8UyZlFciqZWAVJCHuF8PbZR9/G?=
 =?us-ascii?Q?3SjXD3r3SCE5EyzqOLGOUSsS3aT4tVCuUQWrNLVzATGKI5sBZYWsmjiOYEDS?=
 =?us-ascii?Q?/gtb4ytNLBkqGAVoo8trT91UTl3EILLNxzx7Kcf9CimG0c4HEQgne1rZ9tNp?=
 =?us-ascii?Q?U9MqpQG24XmwuDHLE/vU1zw5LmX1uh8cvha8m1893PrM2KOnOTswSMqt/2I+?=
 =?us-ascii?Q?isfzLYtN1yneztWngcNHP2Td+3il0wUzFcZ5jTKUd7r9P+b9rZAHdhnaFEZj?=
 =?us-ascii?Q?kkK45SAc4tlixjFIJyvyQS9JMWTnScbyHYwMMxr+zJ1RZ3t+up9AF+/XmJqH?=
 =?us-ascii?Q?Vso/O4sJ2W8qbV40c5FboKDGwrD2VG8QUN61hPC+80zgJcJOaXf4zhNnETbc?=
 =?us-ascii?Q?KVF0ycb69AoLIsMNjvF7IUNltpJPqqWLX9o/gpfF?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4871a37b-9a5e-4f56-7105-08dabc2a3295
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 16:57:45.2774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h6h2UO9gUYK2+0IlUXVKmQ+mfWEvo+eLDEY3KMHRqYD56wRRoq9YnPidyawN10HC/63sLfet0BwLVs3k1x7uaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8631
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

epf_db_phy is not used, so remove it

Signed-off-by: Frank Li <frank.li@nxp.com>
Acked-by: Manivannan Sadhasivam <mani@kernel.org>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 191924a83454..ee66101cb5c4 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -136,7 +136,6 @@ struct epf_ntb {
 
 	struct epf_ntb_ctrl *reg;
 
-	phys_addr_t epf_db_phy;
 	void __iomem *epf_db;
 
 	phys_addr_t vpci_mw_phy[MAX_MW];
-- 
2.34.1

