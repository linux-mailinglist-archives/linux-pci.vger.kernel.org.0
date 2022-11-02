Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1513616490
	for <lists+linux-pci@lfdr.de>; Wed,  2 Nov 2022 15:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbiKBOKw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Nov 2022 10:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbiKBOKr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Nov 2022 10:10:47 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2085.outbound.protection.outlook.com [40.107.21.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06F423391;
        Wed,  2 Nov 2022 07:10:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H2HnNbeVdyRHn3NhwQnj6riTC3K07F11S2Z1IJy+g9pbeV7mSnkgWTKi50aTwOSw0jDD/MDvGi4hDnF/Z/NAESmIwZiXYisDWxm2Vh/J62hwnlapkDwFUgH6o5cI0RaQ+6UNgEPt4l9kGjebgplxuP0hjJzK5eccdDbSqlX1Q2gNiSDVgLm4LgJGXCqBVh09CRZBc5c80tHAUTDKcjMR+4NoNaGM/ugDm2ezD2/5m2wesj4/fBQ6E6KZ+Jh9K1P3uxx0IHTdsXRbSCJv8RH6BSh3WvEjAZ3HB3I3LJRUtZA+ziRvwfboB1xF5g2esx/RV5qCPPYESqk2Ioq3lk2/Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qSqxyTF416uWTAfTmzpTKKp4abZoPZOkUSlBUHn3j/M=;
 b=RdSu0vjCCf3QL9CDYvKSMzYkUeJQqx3I5fIy3eZCLBzW/tRd5mhz8QjeTTbR17vnoG9caNKF1wBV/URz0ASqfofp/hSHnnBP0urVaPW2+KhNKgbXhV3v9mjuu3FBPmo/ugZwvGse3URAX7GFIigTWGiiUdfFcfXO6J/d3mGXuuEsiScO7dw7v2Wz3AzHWdB5tLoKCOBr6WYlp5ctRE5bkZFmo1z2EboNPVf6PQ/UKdR0FmNjrZUUWkvkPoNO2MZP3k8c0392armO6x3RgWnx2RNi9QHazstjgOiiKHiBLrvk6d/vZJuR+58xvipKunqPsxPsgAfN7/UySO9+qY9WKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qSqxyTF416uWTAfTmzpTKKp4abZoPZOkUSlBUHn3j/M=;
 b=N0lGG2WqciH387e1UglLZ8AkMSdiRNEkze5BzXKm2nVbM1sQHUK4MbTJJxP31oxc3wKwFXBDd7fp7YTeiK4WGDvtU4FtSygfR41C5Yn54ikaCntW5rvPExOTKWA06EjH/cwf6nws8yyqYH9xLfVxzl8SQPmQ7gcju9OKbYYFmAY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by DB9PR04MB8234.eurprd04.prod.outlook.com (2603:10a6:10:25d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20; Wed, 2 Nov
 2022 14:10:40 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::44bb:8387:8f4b:6a28]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::44bb:8387:8f4b:6a28%11]) with mapi id 15.20.5769.021; Wed, 2 Nov 2022
 14:10:40 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     mani@kernel.org
Cc:     Frank.Li@nxp.com, allenbh@gmail.com, bhelgaas@google.com,
        dave.jiang@intel.com, helgaas@kernel.org, imx@lists.linux.dev,
        jdmason@kudzu.us, kw@linux.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lpieralisi@kernel.org,
        ntb@lists.linux.dev
Subject: [PATCH v16 2/7] PCI: endpoint: pci-epf-vntb: fix indentation of the struct epf_ntb_ctrl
Date:   Wed,  2 Nov 2022 10:10:09 -0400
Message-Id: <20221102141014.1025893-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221102141014.1025893-1-Frank.Li@nxp.com>
References: <20221102141014.1025893-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0210.namprd05.prod.outlook.com
 (2603:10b6:a03:330::35) To HE1PR0401MB2331.eurprd04.prod.outlook.com
 (2603:10a6:3:24::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2331:EE_|DB9PR04MB8234:EE_
X-MS-Office365-Filtering-Correlation-Id: 83d9e597-dd10-41c1-85c8-08dabcdc05e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XOuOtrU6NWAkBPQfvLvvN+giCWNqEkZl04koBjsKj7rICigsNyppAIROqLgkyYUCSSQ8ryKXBKXgRcHYbVmxU8Dq0oYLrHzqe7Dn3MXVlG9artJdFuAT8xbp89DI61wLZDy+YaNdfKKxE6zGnWUWyER1Lqq8Str8OH2NJ8xivCyFkRlJwEJ+KRnPRIVYe5CurKvr+IvFK5CgGfwGmPD7ZQjWO/5/I8lJLyLhKa5k5zcBR660/9D0LCje7/mNdzuTQLzXJUkqaiV4fpnsLn4ud2+1r8HFTFO1TL63ifW7nQSgFGgm4rQXWDKX0Zwq90Y41LR0sp2n0lg/kFLTWlHz+IF1QS6Jc5nq9We9X9FHT8+16oByiSGFBYAeXXCIjNA8TllAX+VK97YXWWGkSzDyiZ6HjjB0zsX899O9+VkFQrjcBAePkj18pbli7IOdmRvJcKWWThL0gsPOoObBAk4xr4SjTNOvNAtwHYuqNurSMZSpyMtzcSAsOzfz93WodeiUOhXLKpw1eDOWtzdVlfHzKgphZWzaCmhLkT3W+lD7Jb0ewzefbWDtw1i4oq984B93KKLbvSO7P57GAiH8w99Dcb23LwdNXHNRnx6Qz3nqc9m84EghH+jvx7Hmom7xiJtZK5N3f7hWj/81N1M3F6wU6NGl1Ln4jkTjsp6ADc/tfyC//67bpTKOBw/4qYGFjMfIFZCsnjkNs5LLJqSBgkbNVbZARNqosYsmQdkAHwVhW3ygOAaJ85bdMiGtRkfQbiSOGqh7LBKUYABPCvK0pe/0SA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(39860400002)(396003)(376002)(366004)(451199015)(36756003)(6916009)(6486002)(5660300002)(7416002)(83380400001)(478600001)(2906002)(41300700001)(66556008)(316002)(8676002)(66476007)(4326008)(66946007)(8936002)(26005)(6512007)(186003)(38100700002)(2616005)(1076003)(38350700002)(86362001)(6666004)(52116002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F0/bgEi9ARnjqQsLuPQPKoDwwU24XqScMcJsK7VQyxN07If6uegderEZGVUa?=
 =?us-ascii?Q?9iRKAVFKnCUs4fCRGtUXn1mxCX1LumSKNsXWxyPg2X1xEoZi36hApxZjLTb9?=
 =?us-ascii?Q?9AzL8QMj69AWkvWPlz9gLF4Rts8ylNKMcyHRvzmNNxSTB4wwPWHF6RbjvdJW?=
 =?us-ascii?Q?eZ/pnUmoi/EhhhAfszBmKRhw3o1c85w+ogmm2F/MgbwlU4JrHwRKuDHcBViK?=
 =?us-ascii?Q?GVleED/Qd8LkHjSM9iWKWqXi7ZtleokNEST8WNvQYtgDvnuMYTWdTSJMQNtk?=
 =?us-ascii?Q?5k6ITq9Qc9QCmgQ+8SwR5+WtCSn2mq82bCpQa8jrHPAOR/hz4YcCt3+A50HI?=
 =?us-ascii?Q?O9/Sk4muTD17RvdUdVdauV1Dc7DMNmgJRy9RtuqvKzRQuEAcG0eRlI0V1bsQ?=
 =?us-ascii?Q?vxaf1xEyQaKI2iLaEIEs4xtcv3AZzhaoD82lB8P97p5ounbLaN9BPUXzftcK?=
 =?us-ascii?Q?XXLd3FdZBxNslAYFbckEoVHjKF6Ydyle21YkXkKF8lBCKWH6uDRG95rHRohm?=
 =?us-ascii?Q?MQUjaIKVba4yxV2OXhSYHRsux/J7n4kW1q4koBssj1fCP/TCMuDQ2BxHl2hy?=
 =?us-ascii?Q?nmR9J9vuFagkHsb4/tljWYehdPkOHMT8lbV8w8epUl5SF/FeLDf51HgV6lw0?=
 =?us-ascii?Q?jDBRj57GqvUH7zaIsUG56wPDxOtTaA3sbI2KOVuHroExQWrFGKwO2M5ZA8N7?=
 =?us-ascii?Q?45siCBNP9EWtHOUpmHB7EdnJYS06gTYrNPRtrfxYsLjMnkx9bUtm0cKtSwol?=
 =?us-ascii?Q?sUKNNkRopsz0Xx+Vy7w4SUylwoPG4kNYRauZ0cc+SsgvHkgGTTgHgcEoFSl9?=
 =?us-ascii?Q?ViPaJQhlKExQJ4lkjherFqQcNRvLybUuHvY4CkZ96voAhX4GYxbpRkOIc1AT?=
 =?us-ascii?Q?G1/q27JV1yrnSzEw36Vnb48ykEZeIF5ENsUPH/DuUQguFzQy5mkHllJ3rpJ0?=
 =?us-ascii?Q?a2jAtA4W9NWiBBymSeOKNFmE1D1EGMqkhosWF2SCyx1ZeDvIgh7x7rzUZCxR?=
 =?us-ascii?Q?l+hCoa8XsQWU13uy9IRlbiT/ghWWuvmrVy0whkETUdakCJqjorHnJDnhtQJX?=
 =?us-ascii?Q?YPezkRwpAWpKuVB5hV+NMWxENg/WzUob+VoUB+XwhqxCyHWlZZn6/EvaYtIi?=
 =?us-ascii?Q?hmqtV8qhDMpIvdt0iCPmQcQ150LpvR6oG7DiJTqSGicy056MqE/aPWH9hPRS?=
 =?us-ascii?Q?jzzE3qI7+yhXW9saxNApbfrdqvkh/TNUfvCKMl9WaE4V38ow4lJokTflnZ/P?=
 =?us-ascii?Q?p/BMzuIfWX4qKmKeHedid5iVtIlwlv1eHTgaCzbyHShws5jKZu58GzMclIGN?=
 =?us-ascii?Q?ulrri5t3MkH90Sr+428KmKqzzsrOmipXpZsPcSPvxlrhE1GBtIZZ/2YGL6TO?=
 =?us-ascii?Q?WlXAbRylhh7+RJGsJjwyKGctGVo7pixINl2PICCF4ROhpjHpWNNVi6EqzTpt?=
 =?us-ascii?Q?CQFxv0aLwlJaPkgwnnqJuy8Fv9W1aAPWfKj6UD7DolZUEBeN72WZCIr8W5wH?=
 =?us-ascii?Q?3ia/OrLksIondxHhrWvJvEcjFvrbVlW4blOPXQsddBnHWPSSPs2kbOf1hldf?=
 =?us-ascii?Q?BZlq+HGHAy1vt7abpUqf+3qEcHlRS78d4dq3vrOD?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83d9e597-dd10-41c1-85c8-08dabcdc05e3
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 14:10:40.7407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l9UILFix67Q6okutsVrMzc0dDvVmAt9soAaKrGLzgQBk85+B3/+tJ0f2CVKmYgjeK05wKnPxzCUkNGDcD5M1yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8234
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

Align the indentation of struct epf_ntb_ctrl with other structs in the driver

Signed-off-by: Frank Li <frank.li@nxp.com>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 28 +++++++++----------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index c0115bcb3b5e..1863006cc36c 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
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
-- 
2.34.1

