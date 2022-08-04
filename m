Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C449C5895BB
	for <lists+linux-pci@lfdr.de>; Thu,  4 Aug 2022 03:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237313AbiHDBsl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Aug 2022 21:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiHDBsk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Aug 2022 21:48:40 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2107.outbound.protection.outlook.com [40.107.94.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16DF15F10D;
        Wed,  3 Aug 2022 18:48:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bwFpyDOkrcmhGLTvWI2gbNvEyyLNHQoQH5OLD4k23aiA8Kz37YIlzS71Fc5u9xeuoB9YthzbUN5/SJDGHEbnTz/BBnBHOHDDjUZyMnu8S3EREWmdkC6LJzHtk4YPWE86mGOt5N9gYjd3xyfgbrpFaFAtPHrtdL6Yw78htIbdIc3AiRCyZl88eUCk0MQxhQ+5BOQ5IgOAlCSOzXiEjNDFdHXr3ZUQ/vPUY66PrkVOMFnOwF9fScufsfLLl9vTfuceOdNr1q82INeexBLBBfaDkah1zxkYkFRFE+ivUGV9ckDfcMBQW0u++AN9ozh2GMqIwSeRBXxEzlLyagQoKz5SoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=urbUIPd9Cik0C5kD5S69kP3XzxRa2GiocManyWSuA9A=;
 b=ZKG8IHRKWqy+3mviLDuZxUmjhv+DNkKFCzD02vsgE/AZN8Ei68Zgcpv4eK3gUzrraaFP5PeD9xz/KMdYnDrZSfjmOyPAclDa6Rrbb423764wovP4pJ46SrtQ1nuCo/CiodRhwJxoEcDcQSOdRJ5IGzmXZTw59+HYVJb2IgfgfNGeehyxQhYQrBuHkjuek95OCofde2QL1wvNvJjwlGXZb/0AsKAPfOtnFx4Gtna6WB4EIFyI8pI7cmGUqd9CjsalLL9NRsM0ydrpDcdt9NPIviOpsZzlW8OIQxBDiI1NZ+b2gEdhurE6Knsrjs6iD8znvIffeEDqCPvQBgjd8LIyUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=urbUIPd9Cik0C5kD5S69kP3XzxRa2GiocManyWSuA9A=;
 b=Aq95Uqo3jsrMD9t+xQI2bOMqmDDPzzFW2BMHjssiYIEJBbrmHkKAmepPGfTCbb70X6lBzm+v55Y6EG1c1hEsBK9Ea8uddqVp6x7zil8Qs/SOT2sZCZhBmTWrIFqBPJ7DvQed+DrtnhLHJgYPANgg0GuwUnJRVMorSkqCxzKyS5o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM8PR01MB6824.prod.exchangelabs.com (2603:10b6:8:23::24) by
 CH2PR01MB6086.prod.exchangelabs.com (2603:10b6:610:45::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5482.14; Thu, 4 Aug 2022 01:48:33 +0000
Received: from DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::7058:9dd4:aa01:614a]) by DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::7058:9dd4:aa01:614a%5]) with mapi id 15.20.5504.014; Thu, 4 Aug 2022
 01:48:33 +0000
From:   Huang Shijie <shijie@os.amperecomputing.com>
To:     bhelgaas@google.com
Cc:     patches@amperecomputing.com, zwang@amperecomputing.com,
        darren@os.amperecomputing.com, corbet@lwn.net,
        yangyicong@hisilicon.com, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Huang Shijie <shijie@os.amperecomputing.com>
Subject: [PATCH] PCI: fix the invalid aer-inject git tree
Date:   Thu,  4 Aug 2022 09:47:55 +0000
Message-Id: <20220804094755.1885603-1-shijie@os.amperecomputing.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR02CA0003.namprd02.prod.outlook.com
 (2603:10b6:610:4e::13) To DM8PR01MB6824.prod.exchangelabs.com
 (2603:10b6:8:23::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d47650c2-fcb6-46c2-3b11-08da75bb704f
X-MS-TrafficTypeDiagnostic: CH2PR01MB6086:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WWm5kTzIjrrelyoW55LMEHoUjvVwdK2PpwYyz7JInpVF8ufCdDIK18tij7X23T5kMqHXKjXff+IVn1Vcmi+67bwrRZLDvi40sISfLTsVWuLDKM0D1LTifs5AUhyPuoqc7eAQiPlrkQFcumVhuiOjFD8aTrBr6bzMgL42Vkm1lZTd3SOWM+DXPhMZQT9awDhvPVuBo06GZHTze35+07IA/AIJYIIF0SJCHQqm0sGKhHSx4kn2tMk5TK6nSXeMcN5OdS+5Sk3C2To0NZTJrMAPlhlbnNySrg2NADcb2VoBWGOGkN3KoudYx6zNZHY8pW3IfCA7pB9p9nHI6ZekrBqmQLDBFD/spYtAxFt29sFEW1EekKdJB4A2TQDr04PXUVovfwgV9oZ3pcfiKLlct/Ghw6San5oMcGjf9HKXFVQQL7WjOqBRaQfZ6gzjAKIo6hWC48FlakS0Po7YlaYd1x81gMlM7tU4koLgEn/EUz4YI4zM/pOQD2oLfonlPLWhte4bPEB+XyEvnlAVBLc5Qw77LkIbj2C5ntQYxRYgqDHg5UMJNNFF9/D8lHtGH67k0REZ2gyRvQQ9pB6PVZP5zxAv58R+lnyPJwLvJY/jWOS1F8xojY+1LhVZkJMAWGA8kURMVzT/RdOYo5sJNz0OCfxA6AYpIHgaWyNG4z1By/HyDLgDvLpo1qwyNN0X1mQtfpJqI1ePqvxFP3yaHQl3gBNqSSbHaOVwutOeeHqTc4mHA5PTRp69Ra44qpU2keMo5c3H4yRvw2PNihwxbyvrpzZHAS6Md4ow8YoSfFURG9VZCq4v8+GBGq4M2Z7iVrlykrQp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR01MB6824.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(136003)(396003)(376002)(346002)(39850400004)(83380400001)(5660300002)(2616005)(107886003)(186003)(8936002)(66946007)(4326008)(2906002)(66556008)(1076003)(66476007)(8676002)(316002)(966005)(478600001)(6486002)(52116002)(6916009)(6512007)(6506007)(41300700001)(86362001)(26005)(6666004)(38350700002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D2Hb16XGGg0ewkLcGHyZLXtmtpVkpuyulx1wt1gkSSaXd6ubZP6HPZYOk1SU?=
 =?us-ascii?Q?60bnwU2VFw7s3tlX3y91FB6MWnPiru7J3Li49JSe/+BHe4ZbAJolYke8HApV?=
 =?us-ascii?Q?tjY+8FxOzRNKezd8AIa1wxwoXtWGcQpqTj4FkR8fBVB0UwctL3YbMvvUzIkT?=
 =?us-ascii?Q?tCvPcCiaYnQO87MuH3Xag4Cdy1WdWpC7xgsTILGec1ExnrL5z250iMMP3Yc6?=
 =?us-ascii?Q?M6c2DFA6+y9vxGcvv0PU23GNQos6skoMiX5pPDX71HkTaokHpzt6VviccCAE?=
 =?us-ascii?Q?s+VOmfuILkYArvll3/dlNWv3S10tWlTpg32cxYQLbCk979l2uz0uWep39D+u?=
 =?us-ascii?Q?O1H8/XRnyBppOZT3c4O94Zqzi4dyBGZsFwt6ZnPnfUv8iOxKlXzqZ0y/h8bW?=
 =?us-ascii?Q?uDx6JhjUs4uNrm4owX3geb1+kxOPIcTIysgI1RIqVs+FqxD17xmFfaEbQwse?=
 =?us-ascii?Q?qILOqR7h/kWQ9dPufvfaB28ldSMVxKhyxIEjqQWBvePJSoUAENNWiPExGYl7?=
 =?us-ascii?Q?j4MqSXEyTQLPmqYE/PNwcUg/rmbF8PLAHgp/tmTk/uBC81oJvk0s9hkuiMfy?=
 =?us-ascii?Q?D7a770ftdWTBbXwKofNvYCO4lqjlN6+XSILdkCtd26qBOQ43gsZympwyjETu?=
 =?us-ascii?Q?VgAL26lm7hhocbD4X5ob3Sz8tKUyp+AyVyRyOOauGHCgS8LaAaOCnVtp5Oq3?=
 =?us-ascii?Q?wt2zGrDGHDSLLpyz5P4OEHGYfFOvcPcdIUzKSsIFWdJ9Kg6Gne8cNQQV/2Wz?=
 =?us-ascii?Q?Qh2MIsrYAzL6g9d4Mdi7cS3vQiM9oum0WqT1YUkVA4V7zf0eCytog//qVoXG?=
 =?us-ascii?Q?yT3AYYhCz7dxvAUbcWX8H5F7H/8lVMClPdtFzFEMVqL7MSqoio9MtFthwviW?=
 =?us-ascii?Q?s/dmpyjvAQNs3ncMbDtoTGmdCGqAF57u23OIb3xQkAtTRpvTrM44k1wrkNaf?=
 =?us-ascii?Q?zqBY5KmEWQ1XY28iHWw7hCBpCfgSdV2IaQtzUvPVeEB4hTJO2AxlVwJqmqSt?=
 =?us-ascii?Q?FyV57Vgoks6c1z//75b9FxB+v5ORFbVuaYsbPTj/2M7IC1Ih8NAsHlw/RwV/?=
 =?us-ascii?Q?1OoS44vYOnCkTM8QKaBKofDMcVAs2BxLaWYFcLoqsnnhq6ffCi4aDFAhzHJs?=
 =?us-ascii?Q?fHGEWENK9QTH3TTerpTWzuvDTnMe+uYyliqj82/lcL13143HalhYUPZj5t/u?=
 =?us-ascii?Q?chLdMXIJNTcqmnJh0yZfyCzNrghXWTmNUcdbjet+44b2qaJmijsrC7J3BS8D?=
 =?us-ascii?Q?UZ9Vmfk4UdEvEt/MjPpuqbwEl/A2XKb14e4v02XO6ZOUN6o6DW5HHeLwAjTJ?=
 =?us-ascii?Q?cs6JSClYCLTkOczAmkGONnhLPPXpy7ax9NqEk0LSY54p4QWHbh7Ac5fmvZQt?=
 =?us-ascii?Q?IGvqmJqpMYjbd0k5TBgnfRRo2c8FwdcsmnqcSMZk9Fer9ESEi4lR9EyPsb/H?=
 =?us-ascii?Q?3fkcooE/RpursL3NLMyVfc24U9MFH6lpGgyScH9kzGKpgLqcw/m6MJD1cSCj?=
 =?us-ascii?Q?H2CZEehQgcU5DLb7mXVX0P1v3XzSCW4DadB9T7mRcbYFHwAncw+WrByCAH59?=
 =?us-ascii?Q?4Da67THr0T4OndeBUkX0c9FUM7Lzyx2tHDZwz3AXMbXULFaZj64me8LxNYHA?=
 =?us-ascii?Q?vShEdFInm515S5tXWzknPPU=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d47650c2-fcb6-46c2-3b11-08da75bb704f
X-MS-Exchange-CrossTenant-AuthSource: DM8PR01MB6824.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2022 01:48:33.4776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NtzAMhxGYDlNm+p18B5a1fQ9an78iAZyQlP6XFpFBnCiesVUUZIujASXZCkThK52RSTATEWfPXDvrrRZ/dJZBEmBhbpxOW9wlSsRdbqXwKXWemu4udAcpOpNqod7euCq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR01MB6086
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The old tree is invalid now, fix it with the right git tree:
    https://git.kernel.org/pub/scm/linux/kernel/git/gong.chen/aer-inject.git

Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
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

