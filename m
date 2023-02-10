Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D2F692529
	for <lists+linux-pci@lfdr.de>; Fri, 10 Feb 2023 19:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232586AbjBJSRt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Feb 2023 13:17:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232822AbjBJSRs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Feb 2023 13:17:48 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D4C5B77D;
        Fri, 10 Feb 2023 10:17:35 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31AHwkAQ001642;
        Fri, 10 Feb 2023 18:17:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=4xPP9APE6e5bJLR8BAjUNrSn3FMcWmQb1c2kHqtPy6A=;
 b=DwD37JOPSpT+P9MEIyY0bgVGSmGGIDHpciM8e/Uja+elK9F3iEdkezKDdqmmkqUXiehB
 ZxHyPL/x2NdWnPVUSmGHn1L1tXIc9WPWMqv1R+ZsRXegcw3r/3HIa/cv/uHRUYZZhjkI
 gm8zPT5k9LIwYAkSpNsWLKykV/gyRjXkKNYiCXIf9zXdpgfZy+TaBv3CyB69tIADC/+/
 xDyfdBaPk7oqCy7Nwlf5d1mH9olwnw347MdcSArAE11QvRLF8uFrY8ZndpoDeDvMHpUF
 0uGh8a4Hj+b7DFsZ8+Jfmd5urVOStliAI+r/5ZWTeKa9jvK6/W+3diQ2VVXOve6xAYkA QA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nhfdcp0sy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Feb 2023 18:17:26 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31AH8U30013685;
        Fri, 10 Feb 2023 18:17:25 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3nhdtak9vc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Feb 2023 18:17:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N6Xqs6OQNcW8j9N/mtH9KOiwQvj/0AmsvqRbxS5VC2NPxnJ9FQ/76hv+XRMOH1b232v/Vwm3kQgnPfwockVbBMwbOb1gYXuEG1/v5Ujy98xmbTD0/psDaiENiI925gmbOSWKGc+qlmfxCKmBKJJyU8Wd9qeTZsh5dtJ2XIL5uBVa2dlI0QHWK0XIKz1HMmOTKo1/QFynL+gSR0QWeJyFhvGHS5/x6fq+Eak4njpDh/7862Q5fLvyY1xmnG5OcIBoMTI0IOHOsat6ARDi9Cyf4M/iohHLs599U17fvsJ1t63qXpXOopXPfjUjYoFngzkCXA1BfwK/kogdSlB/zMw/Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4xPP9APE6e5bJLR8BAjUNrSn3FMcWmQb1c2kHqtPy6A=;
 b=OhRGqsrjV2Dft7ODYkMkGSSjyb4D6GRmba/jAmClVtPAbu92FbmLsW0mcYwFbq4tS0XoDIjeqRRJ5F30uyl5UhhGwfcMe0+1rL5zvznQfs+B49vDJa0Be6fnOWEisvBjCU7ODBk+VYn39TJWzlWm+Y0WFKhTwtyzUsemnwByU7BBUTYxGrwx7q94DF/3eHJS7CbMWmHaDnA54BX52ERblKS4lbXgK7Ly4V4NOwogcTJw0i6YJY53icOo+Xk3e6083+V4BpXwm9E/knhUG/n8ESGcA8i8dWT1ft9HDpkLEN5Uu4TLPziNNNBy4JoEd6fGU1O4FDPk4PoT/Z3fZI+mpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4xPP9APE6e5bJLR8BAjUNrSn3FMcWmQb1c2kHqtPy6A=;
 b=UpmQC/TCUd5JbfahWi7DDj5PsLWXx0Aad5se2sqqLE7OnbrUNIx0U8UDuXoZqjbCOvhwmZvRp+sfUox/hXkZSLLCRTCgYeqSnFVp84pgtP3vjltaTozwqw0IO2pd8WhDSIf13yvCYU88wL8NOkTyBu2pEaRgO4aaxsqD7tJltTk=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by SA2PR10MB4697.namprd10.prod.outlook.com (2603:10b6:806:112::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.16; Fri, 10 Feb
 2023 18:17:23 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::b30f:e3aa:6ba:5c8d]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::b30f:e3aa:6ba:5c8d%5]) with mapi id 15.20.6086.019; Fri, 10 Feb 2023
 18:17:23 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH 8/8] kbuild, PCI: microchip: comment out MODULE_LICENSE in non-modules
Date:   Fri, 10 Feb 2023 16:47:49 +0000
Message-Id: <20230210164749.368998-9-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230210164749.368998-1-nick.alcock@oracle.com>
References: <20230210164749.368998-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0178.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18a::21) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|SA2PR10MB4697:EE_
X-MS-Office365-Filtering-Correlation-Id: e41f12da-5625-4b0f-333a-08db0b930e25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v7EU6r3QAqTAqLoH70dOHOQbJPMbjWwpkj0ucgrKYrn20Ykx8pU+qF80f97M1MMljmyiJL7cNvFXzcOVojv7Ck00S8N65hOBwPd1bAY78j501POX8h8w5+odsgwA7F232K/oyIg0wmZYpfI95m3JS63ajkHtXQnJixjMErob4m8TWAo8KtHd/dzPzYBvdvarBchSPujVgaEiYqp5fZuqKzFOXgRl9kj4WAVHBlc+xVTPNpCBPcU89otngxcRhmWb3/QsP2KRZYfi2IGH1Cki37FgVwazhORgye+dOxPHW7OYmqqNcrRDUXl+rSXqX+dxfJ0N9PI7jEdssVKWuUEIuqFbplGKi1Mu9oYcFkWPnLpMLeLmA7nItpYUzfCz4HSfYjmf9QGcHcNl1tgHoz61WO/IwNE93L6Hj5KT1Az/q02l9pRhdtSV6xEn7aevTF9OUTvgLSZ9llvcQ8Z8VsMpfadsbyTPjDSHZ5U7oE07PpJk97JF7BSqkxkafuYXRmeZWPngAuf/Xlt2+LkGdf8FpR1JlFt7LYeaqNrRudH2ZMgQ7Sm+UadWhWkaM7wfQ8boqvBhGBtuc5PygH9InrE4l8v8RyNAQa3kGdnpYHMfDN5I5bzaUYpV4T2L1Z0bTHL+gO5uQdyf2oY8mzXRerDN7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(346002)(376002)(396003)(39860400002)(366004)(451199018)(36756003)(83380400001)(5660300002)(66946007)(66556008)(44832011)(6916009)(66476007)(4326008)(8936002)(2906002)(86362001)(316002)(41300700001)(8676002)(38100700002)(1076003)(6666004)(2616005)(26005)(186003)(6486002)(478600001)(6506007)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bK01zFtrPKAzfZjOybFdgMQ/4Q0oo7UvzVs+1SWn8clPOqp3n+WYyMAaUsBv?=
 =?us-ascii?Q?AA1yady2NtFFJjh9HhfC4C0Gtrz1LGsaSocebOEKwB43tAw2kjsnSWusvcsR?=
 =?us-ascii?Q?Qrj5nbnawNXvs4b7bEm+gvcMfkyZVAys+PmmbEHK8HMjKwToXjkYmZYTh/+I?=
 =?us-ascii?Q?b4mVd7nBMUcCrSqIsof/DxmGjqK5p6euC/vINjnfCH/yNJVf30eAPjHL4oC+?=
 =?us-ascii?Q?+h+GFUUcO6lbkQ8DBZRD9h+Vy6slwz2qQwoJAkwu9F2zkFk+tcYo2O3OCv59?=
 =?us-ascii?Q?gzvGKpJbzimV/iJqtt+UQfQj477iSk+e9xJMYRfw896peerf8eeAG4YFxa/m?=
 =?us-ascii?Q?hm3YTv1jm5XJ3DimSb+S2n5eOBw2enhKP4iAfv+l20uS7l/Oukn9G9iqVEUc?=
 =?us-ascii?Q?75K9n4muVzNyuv5YVhd9Af2+HtElsVAfAAgNzbS7+obeB+BJyszMzYtZMHhM?=
 =?us-ascii?Q?AKlB2J0KiEW1PYZB1HPPNfFYlHFHKL7VDBzvIWhT+W449eRfuA6W6KuV7FWr?=
 =?us-ascii?Q?cDdhJf/7oT+lVlu3xUZpT3dlraJu0CxREXRTi54LAi8PZMk5h5pV9Q5JodhE?=
 =?us-ascii?Q?U/w7VAiJXIA9mltLbqNkuzjOhVP03N5p+UjDV/v7wC57L/gqO+efZTijUy5x?=
 =?us-ascii?Q?yRL7dGf5OHUtIM4QEaGLgM3ER9kGgRTDm4xdJ8g8k7EVRxRCxKi9ArEBhHak?=
 =?us-ascii?Q?6RVUwyBxN6uyStsErbk6rUNuvgEV6EZc4RMOdU8bvnIjcK6TOAKwrity2vq2?=
 =?us-ascii?Q?LdtqT9Y3HL961ol0z+uEcHb4N6w0ty5daBX90yJJ3ygZyvuTuUC5Rr4X7JxJ?=
 =?us-ascii?Q?SILgg8Xlx7PDjRzYiDSgH0oc0XVOqQfWpukGMSU49rCxYYYldDBIx/aGYJQM?=
 =?us-ascii?Q?053wOAn7NKBYIBRkbPn+C5hql4u/VfXyEhtx4W8p5r7bhh//HkJB8rmkwk9h?=
 =?us-ascii?Q?NuwN3YZmOJSJ4knsuW32brUSIy8YMoCOtYHkIWvcrn4N45KOgcTMNl3+vp9p?=
 =?us-ascii?Q?FJ/Xj4Iu4tlsNlr+DAEJB9TEYGYvSMEujSjPSpBWwLKGBJkByfHW1hYA1Ld8?=
 =?us-ascii?Q?Kbi6lXSaPbMI46yINwrsCFdLSOWZkpUfP9Z1dUDS3Ud6QlVBCJ6+ZSH25zPC?=
 =?us-ascii?Q?TMqd4OCjEClBvEBEQwv8yxWPIhTW0rdktmiXbgSwpJKov+NGPkvuOCsbmbGt?=
 =?us-ascii?Q?nyTUT8BhaBYYygqx+xwPlMfgDcpyU8xU9ti95rM1Uac0cQ6Xl86Tm0TPx5Am?=
 =?us-ascii?Q?gloqFL0WGxR9dbKB3TGfWF76J1Ym5VmjFFV/O/j/++GMj4+pQpKplT3UwqB9?=
 =?us-ascii?Q?z3KGwoDxLdgcdlyZ8nKvEumUEGz+Ug8jIU+BkhxbNxN0xPpcDFYFInLxKGEL?=
 =?us-ascii?Q?5h4ZmL+lsHpjyEJlG26mHhwN8B6wEUK3EDB57qR+7/EOKmfPjEjF78yIQ4x5?=
 =?us-ascii?Q?fZ2D2DE1EUz34MeTmB1wnqx48LUGUj3WCeRsUJGtDTb5JIcFZIkiD4T4Pjc8?=
 =?us-ascii?Q?KogICXF0ujSyJjW/vq2Ftai+QztlVGPEU29j5Ip/Vou4s0JACpxgoQxAzvy/?=
 =?us-ascii?Q?9qgbQskj7B9C4AezMtIzVkGBgOJPcas30nIhNcE1roHNAnsXBveeLoRbDG4Q?=
 =?us-ascii?Q?DQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: b4gCc7Xs9DlvhDUjIZ6ts6XiQwA2+XFYprUQmGxMnxDrUiOLkxeNwxS3Xask8Cme/7whOcCcE/3ecKay++JQcJFrSGVxdDyZf7i1LPzM26TjWHAzd5KDu5scMVpx3DqnVQncTjTP66Av47+oiCixi3RMgtn9cfp2bQJ5CX1z8ZoTuqd53UuW5GUcff8RCzAqV3kAOKNPri3mwblHEaz/UqEEjA0NBg7Ynu1lEXIOkRoNPlgrGALaCGbtVRtNFZVRxfyQcOFQeHG6EQXySeaew4Gr7XN/HlVSWdS3oYz2gsLLIt4vjvJlXpMoe83+U9UIOzgHeVskarSorwiLUyBskj1oc4LhCNTUB3ltK0Lph/0/YDUUmahTcnIAdQq/9Mib8KAtiTwG8QuViijgoQY33/ZZ5nKFQyTSzY4HkMHlZhTJBDMIsZtAW8li5YFsnlyb9Mbtf3o4t8gY142NNMQx/6f7oVjjTYRa5Mb5eJGbtAoJHWyYrhQqw3sLUsxu7mkFi8SVesGU3KXk6tfhWTDnT4wD98WoWHOdhTdaow8wbKLWK/hc1q8pqBYVbu1r4eSk3pTrt6mUy0hw7BVykqo4ZzXJSgM7K6Rn59J+QsChGD313UmF0uLUpMAFAQ7wmJUBxfuicIIgeQsM/L3193XHJAVxWYuXF6t85WPeo/kp3zbaUXcq9os9SyKGkb8tjKHq4GQlM2Mvdsvr77Dk0BY8mYWpinQ2LNCpIRtrsPnuGUSEbE/llR5BbxfdS1cAME3+VqwshvT9H58/kGwRBfEsb/yIv4/7/ZHEoXEcilZz0Mx/TGQglHU53vDOoIApJLRBUv3Fc7G+qwLC3veh8UzarQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e41f12da-5625-4b0f-333a-08db0b930e25
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2023 18:17:22.9724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jkCvspMoaW7bpOt500tNUMHuWhCAB5yPnOwoFjz/a+MmOlgYPi+ZgjJjbP/WPVj9e6TCCrvRf73DStiQjHQB8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4697
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-10_13,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302100152
X-Proofpoint-GUID: 12wjfv7-ObPTnjI3vyd1tYHUYRlhLLQR
X-Proofpoint-ORIG-GUID: 12wjfv7-ObPTnjI3vyd1tYHUYRlhLLQR
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Since commit 8b41fc4454e ("kbuild: create modules.builtin without
Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
are used to identify modules. As a consequence, uses of the macro
in non-modules will cause modprobe to misidentify their containing
object file as a module when it is not (false positives), and modprobe
might succeed rather than failing with a suitable error message.

So comment out all uses of MODULE_LICENSE that are not in real modules
(the license declaration is left in as documentation).

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-modules@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: linux-riscv@lists.infradead.org
---
 drivers/pci/controller/pcie-microchip-host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-microchip-host.c b/drivers/pci/controller/pcie-microchip-host.c
index 0ebf7015e9af..08c0b778ce67 100644
--- a/drivers/pci/controller/pcie-microchip-host.c
+++ b/drivers/pci/controller/pcie-microchip-host.c
@@ -1135,6 +1135,6 @@ static struct platform_driver mc_pcie_driver = {
 };
 
 builtin_platform_driver(mc_pcie_driver);
-MODULE_LICENSE("GPL");
+/* MODULE_LICENSE("GPL"); */
 MODULE_DESCRIPTION("Microchip PCIe host controller driver");
 MODULE_AUTHOR("Daire McNamara <daire.mcnamara@microchip.com>");
-- 
2.39.1.268.g9de2f9a303

