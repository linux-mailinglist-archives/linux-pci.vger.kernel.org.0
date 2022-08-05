Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C55158A4DD
	for <lists+linux-pci@lfdr.de>; Fri,  5 Aug 2022 04:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236091AbiHECxV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Aug 2022 22:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiHECxU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Aug 2022 22:53:20 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2132.outbound.protection.outlook.com [40.107.92.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01CE571702;
        Thu,  4 Aug 2022 19:53:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LuR7InGSyJh6o+E/fySB+j6GdtAF9vjblL6rUJ9YejozSE/Bn2MZmz+XNFk0nsrj/Us1aD6i+8qUebGv81jmreC1P3CEtB0EuvBFIWDfgcSBt4K8WBmscLBRyidVL9voVUI7MBfSzZ/Cg0m+UUh5JmqEnoOsqwWxICt4nc1SjPymW38gjU6h6ovD5VIlGLLSOsWzyFC1fKOBcUpWqP4BR1t0ypRzn4HSUA8tQJlpC0Q7dN9/VSj9ivsjgY0yH5HAoJSueui52LPYm4pPq7QnGfLd6EW6HQOLnFRF0s0I3ZEa/ZyW+rmR1h/yjKKcDU2RiCKoqfHPjSQspxiSPVuc4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Ds8Y6oXKCOBJnd+UXGPXdVfj0/bQcZYKH5l14kD6dA=;
 b=iS7HQbyArrA906sXh6EeuEyxnvG6YaUQ/PBxyQmAJRiA9lMR9AWZjhec62g1/QsuTDgnTzWFUeyfoYhqUGEDOP/zzGAH8MD4wydIaEmeBHL+njWIf/H1wabOUwuZUzyyKGb+Ov9GXgdBmzWghAvTARFGl57eX3AQ8ZQpApWxJbkXqVRGDGRc9MdDJum6MfC5HpFGEG0urrAEHX3q6UDfcR0OQjw6PGak/XSztLQRV/aLPA10t7J0VIQWopTiX0NUEhmQ77NmsU9cDzWRU4Xd89UafSHnQJs9kuJrn86rLagAsbLC3BVmt6MhkVSemVUMGqjonRzya9bf6xLB7FMZfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Ds8Y6oXKCOBJnd+UXGPXdVfj0/bQcZYKH5l14kD6dA=;
 b=diIvot5cTxAAfNq5ZE/qIvvBM0HCYVsrUd7JbCUo5podW316Hk0eXMtzrM9rRMbTwHBjtocR5aL0NB4T/feIJ+AEK3mAwGo+In6y/n+lUh9Lonw3xuPKtp5hVjZwYrNX/SBFR+4RFPyAnt19qxwJio2YI75+w//36kdFSh1ZzEA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM8PR01MB6824.prod.exchangelabs.com (2603:10b6:8:23::24) by
 CY1PR01MB1980.prod.exchangelabs.com (2a01:111:e400:c637::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.14; Fri, 5 Aug 2022 02:53:17 +0000
Received: from DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::7058:9dd4:aa01:614a]) by DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::7058:9dd4:aa01:614a%5]) with mapi id 15.20.5504.015; Fri, 5 Aug 2022
 02:53:17 +0000
From:   Huang Shijie <shijie@os.amperecomputing.com>
To:     bhelgaas@google.com
Cc:     patches@amperecomputing.com, zwang@amperecomputing.com,
        darren@os.amperecomputing.com, corbet@lwn.net,
        yangyicong@hisilicon.com, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Huang Shijie <shijie@os.amperecomputing.com>
Subject: [PATCH v3] PCI: update the links for aer-inject git tree
Date:   Fri,  5 Aug 2022 10:52:38 +0000
Message-Id: <20220805105238.345599-1-shijie@os.amperecomputing.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR10CA0009.namprd10.prod.outlook.com
 (2603:10b6:610:4c::19) To DM8PR01MB6824.prod.exchangelabs.com
 (2603:10b6:8:23::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba953302-84ea-4921-e82f-08da768da57c
X-MS-TrafficTypeDiagnostic: CY1PR01MB1980:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dqHMD/ExlL8/JwtultV4i3UhNTnow75ARwXIkPWP6R/WxVst7MC/2/6gRBfWYm3EstU9MOruKgqcPG+JIhjRd/YC/sz5TqsYClip4s3btYYnxCYb2ROeZb1fJO3qx3gOD4PtB+V1L1buoGsVpSB4yAqTBWtxLgxANXqLTct7K2GWB6bMVh9X16pzFWVsgQ4LU1oozcDoQEDQljaafWzh3DZXjSrdMz/9eHzFWH1x9e/j8rW0s01GIS1bUvcDk0Cj2DjCCliPYNQy54G8QlCXBqD/oa829exKfDn+VkGfpMig46A6Ri0AijFYrvgP+rcviMx/gPpIGaEI0TxQHVX5pkYjRqzT6tKTzCKtWn6KkVf72FrAGzZ4n3SMmwA2hXlanWbO+iG27KrnWpCCEvGpbJPcJOqWU57CBdHPII1/v65wTGlvkRwSiPxLXZLWKqBOrGP0O7gRXDol5lzkeHmqs9Wla/rTxW2Um8W3duRJOdgPRrrlC1EW8KDQizLQ0HBHXMs1az3dirOzlXR8t1zXJek2TAx0qx7+mMGEJl3ObsBi8/Oou3VgjRL30OUiHLHiZRu8Vmc055FLv2Yw9wIGLrMmEz7QdXBf2zSDjG8qCDxZxLZbGFPGVAcDYTgZ/HsiyI15rqpowxtLjIUQdhBO5hKrT+/pI4hKhB8VNwspCgQzQLOlxgdCl1io1wjwY5jIt/Qw77+GBkWVw/9TE5uhFo9P3v+hlYWLXboAvzZ6dyU55w5liD1tt3Y6V07kC+V2BZ+JQT/0k+MJbq1qU+I0I/TqoK8/HRk8+dd1MbMi034ZYK892T/+D/5zSxueTl6jPyWKGo9u40T8rlhvCRP8VA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR01MB6824.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(366004)(39850400004)(376002)(346002)(1076003)(966005)(5660300002)(8936002)(6486002)(15650500001)(316002)(6916009)(478600001)(66476007)(4326008)(8676002)(66556008)(66946007)(2616005)(52116002)(107886003)(26005)(6506007)(41300700001)(186003)(2906002)(6666004)(83380400001)(38100700002)(38350700002)(6512007)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2ynOYjs3F/NaKongEMxMlY4PkvayauyPWSf3bF0moiMDJSKAXcRZEQ0Ug2Iq?=
 =?us-ascii?Q?Qs5W99oD+UdTP+6RESLQUYb1DqiW/5xhTQAPKUDNVRm9sMj79tWdbeMVASt1?=
 =?us-ascii?Q?+FFQ3D5KJj48JrWEXQz8qAgZ5zjciI1u6oylN+MU/2d5JmA8JbqLCGGKJ3tH?=
 =?us-ascii?Q?uxHx4ZKnNC8L1UNwzfrwVI57RfjIKC+ydIl6JGxbQdrtqzEdtZOhg6UNA6E/?=
 =?us-ascii?Q?705fMs7nhaxaCGX6NvX6LA6q0OBeOLi0qzfxjfKt75TUHGMLHdkljmy60LSx?=
 =?us-ascii?Q?H7rBW9q8X/06UV99ILuMp9/P/+eDLHFkq1jhz/w2sQJvPbGy6XHIkpJf3Fz5?=
 =?us-ascii?Q?hZYFes7BBWIfQ87NAOTGdqW8ZIT+CuFnZxU1Gr3VpBztFPeLWC4XMJl1dIhv?=
 =?us-ascii?Q?aAS8WQ6RxRso4qJQor9+xVKFpu9sVw5BY6mgOGtF6zvnmiIBPJCNXH99AxJf?=
 =?us-ascii?Q?sIDAQv+1UhtyD1AsTW0P6u9g94DfQC7yHsQWn3YOewCVh4NsC+61s4G9p5Ek?=
 =?us-ascii?Q?oduy491V3BH9S4MOZlwlDMFb1E7KPQitcHqOGsN8RPNgMUKuwELtfdO7o1Lc?=
 =?us-ascii?Q?dHBd/Jv2ku+hRfso8NUZv2fjHPQM2vgo7DmmRFbadCmX3sOc3AzcnT4oQPwB?=
 =?us-ascii?Q?qE4bi0WhJ8fzesnFmNa/u772YcIQjMJWBHspSc1CRfX39EQGTMKPe+zw0CzH?=
 =?us-ascii?Q?l5m7NgEkR6dMYPHsnlX+mr3T/0TOJlUBoBzLRDFW0g4PAh2yW20GJLj1uTHj?=
 =?us-ascii?Q?mklaQ06MThng+5qf/cT5XDIfpynUt2W6SnPn8+LNF8XNqqPumbb/BYPO53Kd?=
 =?us-ascii?Q?wZdk5UleIykqbVjBZJDGfHc2FapcFvP5AUsvECLAQeFwguozSb2vu2jX9/y1?=
 =?us-ascii?Q?xd8YTznlJW+MC2E9Xdb8MbXD06LGglFH7rKZ2qYV8GhW22b/GxqMdyB6lOJf?=
 =?us-ascii?Q?p9xxZv0xkbT0xtd/AIew53aZwcTzC1/rCs77qlOL4uQXZ5wIi5rQVxqUfCA0?=
 =?us-ascii?Q?T+JdbAh9y6r3UGMC+EHlzqF3cmKorPb7nk3Qxhk5mNh9g4WVD6OlvsZgyMQb?=
 =?us-ascii?Q?+cNxL5nFZBPWDs1boDRxUZ5zyvrWCfpsgTPduGTYQJicIBMABpnv8xXv7aA4?=
 =?us-ascii?Q?btPjU2NEc0gLLCkeX0XpD6VWNRenY1Ixo+H0YxT/9dvf/nsUg9V8RB6c2Bs7?=
 =?us-ascii?Q?YHAXlhPGvFSKm9l02P5I6IgM7ZHCJ1EHndKJtozU0b51XJKxZxSTUcgWOS4+?=
 =?us-ascii?Q?gvBjpHqVUOt2/khb8vFdqQ6XTTI/RNl9G5H8M91BzVQx1kCoMWKBeZXfA7mQ?=
 =?us-ascii?Q?9uXypE4SIFvE7rprV2b5QVuEG3N2Rgl0OE6VCSHIrrLaEkAJn3uo6939II52?=
 =?us-ascii?Q?26ncIZgqhn/hcJqoYum5lclUPOSU7Hd3JJr664Iuu1ns9SJMhx9886DU3Uv7?=
 =?us-ascii?Q?hMjnjwtLYG7tyFeUlf17QHJid+gwkr7rLGdABZd/geDjbp15hX9RuWHGbcJv?=
 =?us-ascii?Q?/wiXe2WBCBHhd2bm1GXvK/JUalCxJv5XhJ8hASXkJ2cGGb9iJ3E4vyAY0MJx?=
 =?us-ascii?Q?rBYuDNJbXHbelSI1Rz4nE7D9k1xm+4iEUczTMPGOmCv4NWYua7k8CoaMsOtZ?=
 =?us-ascii?Q?dkHQbLnmYLTg7Zv2RdG8z84=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba953302-84ea-4921-e82f-08da768da57c
X-MS-Exchange-CrossTenant-AuthSource: DM8PR01MB6824.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2022 02:53:16.9457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u9t49RXL1iEHBG/EJzTbx5Z+9FYp8OTomJV8pwNSNfxaqe7VC+CxGgds2M0Ds98Z2CnHRem31FQqPqUPGuct9wMbaQnV1KsuEAUqyqbGkFAtHBbMyhqBVoOfxuIfRHs7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR01MB1980
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The aer-inject tree has been moved to:
    https://git.kernel.org/pub/scm/linux/kernel/git/gong.chen/aer-inject.git
Update the links.

Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
---
v1 --> v2: Modified the commit message and the title.
v2 --> v3: Change the commit message again.
---
 Documentation/PCI/pcieaer-howto.rst | 2 +-
 drivers/pci/pcie/Kconfig            | 2 +-
 drivers/pci/pcie/aer_inject.c       | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/PCI/pcieaer-howto.rst b/Documentation/PCI/pcieaer-howto.rst
index 0b36b9ebfa4b..b31fc9a0edbc 100644
--- a/Documentation/PCI/pcieaer-howto.rst
+++ b/Documentation/PCI/pcieaer-howto.rst
@@ -294,7 +294,7 @@ After reboot with new kernel or insert the module, a device file named
 Then, you need a user space tool named aer-inject, which can be gotten
 from:
 
-    https://git.kernel.org/cgit/linux/kernel/git/gong.chen/aer-inject.git/
+    https://git.kernel.org/pub/scm/linux/kernel/git/gong.chen/aer-inject.git/
 
 More information about aer-inject can be found in the document comes
 with its source code.
diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
index 788ac8df3f9d..d6ea0fd9892d 100644
--- a/drivers/pci/pcie/Kconfig
+++ b/drivers/pci/pcie/Kconfig
@@ -43,7 +43,7 @@ config PCIEAER_INJECT
 	  error injection can fake almost all kinds of errors with the
 	  help of a user space helper tool aer-inject, which can be
 	  gotten from:
-	     https://git.kernel.org/cgit/linux/kernel/git/gong.chen/aer-inject.git/
+            https://git.kernel.org/pub/scm/linux/kernel/git/gong.chen/aer-inject.git/
 
 #
 # PCI Express ECRC
diff --git a/drivers/pci/pcie/aer_inject.c b/drivers/pci/pcie/aer_inject.c
index 2dab275d252f..262b06b0dc1d 100644
--- a/drivers/pci/pcie/aer_inject.c
+++ b/drivers/pci/pcie/aer_inject.c
@@ -6,7 +6,7 @@
  * trigger various real hardware errors. Software based error
  * injection can fake almost all kinds of errors with the help of a
  * user space helper tool aer-inject, which can be gotten from:
- *   https://git.kernel.org/cgit/linux/kernel/git/gong.chen/aer-inject.git/
+ *   https://git.kernel.org/pub/scm/linux/kernel/git/gong.chen/aer-inject.git/
  *
  * Copyright 2009 Intel Corporation.
  *     Huang Ying <ying.huang@intel.com>
-- 
2.30.2

