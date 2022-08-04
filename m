Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6CA589620
	for <lists+linux-pci@lfdr.de>; Thu,  4 Aug 2022 04:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238498AbiHDCag (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Aug 2022 22:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiHDCag (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Aug 2022 22:30:36 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2096.outbound.protection.outlook.com [40.107.92.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E685FAC5;
        Wed,  3 Aug 2022 19:30:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RDNXWJiEUtZYVTDo3LxjF8cf6DcZmKch4ErdhniK26FGLlgMqTNJcB38nl10SnsMFpOkkcGmx/pcI6EVVn8F483pLk7ZkPNtnnPRYwB+nwkbp0TW9iXfUqtyZkK+skEDBHrRMXtp+XjkEXtIK8z7+hxXeg6HgXS3YFaPZc1MlB0794U41+tShNEeCsobu7coXp5GiVWxX5KYgCJSS054v13J1MMOeHCKHojmeCEoKIdvKMigE09sUh1WtMgvmRU2D7+8L3cobqjas/ij+Y4UDkqTJCk6qhGAu62sIMVMRRMfAy+qC2TCZXj8948xLL/7cQzWZKkNaf+DasM4MEmZyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XzM7sZeA8R81uAbPb+iC2rN3+udFrszcIWq4CVf3ExY=;
 b=jj3Fo73+B9XE9bdfF476ulClqDLg6J6uzw5/Dx6MPrI+/JdDLN9G+a8YxTvvxVp3lwrkIE+sc1H1obJ7S4Y0Vj5bM+El8NE70cfG3AAvhUEIu77yiLNJLxfLpGCUdjZ3lmYVV182lF1iAk9FSKS5q49RYqNi52B+7kggQWXLb4pGaqa2HdH6Mai/ql8QXNDSjS3+RDh/CaefgFQay1gwhKTAPXRZq8geJ4nnzBE4JtwMJesmD+F5SwdkxzAnOrPn23/cIPP4jPZbW1+wyuueZq4iY4eCk2d8TbCYzXQeBS3YdDH6+MZWla1ht68RwL4CswtmIUKE4p71ePDchhwjjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XzM7sZeA8R81uAbPb+iC2rN3+udFrszcIWq4CVf3ExY=;
 b=Ob+mjuvo+oiWWKn0yxe/8JA1hj8zoLm0Q8ieFpyCI875lDMiZAZGDvP31meAqTEVCN4nIsqyO5NBaNun/IDQB4holHpN04FsJIDAQvc6Ul+CNbR+rEbOn7ubs7+Np7GLWi3zJzhCydZTvubFJfI7zzCMcgC30mv2KJxT5d2ac9M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6826.prod.exchangelabs.com (2603:10b6:610:ed::18) by
 PH0PR01MB6503.prod.exchangelabs.com (2603:10b6:510:12::7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.14; Thu, 4 Aug 2022 02:30:32 +0000
Received: from CH0PR01MB6826.prod.exchangelabs.com
 ([fe80::d68:3d30:ca66:5dfa]) by CH0PR01MB6826.prod.exchangelabs.com
 ([fe80::d68:3d30:ca66:5dfa%5]) with mapi id 15.20.5504.014; Thu, 4 Aug 2022
 02:30:32 +0000
From:   Huang Shijie <shijie@os.amperecomputing.com>
To:     bhelgaas@google.com
Cc:     patches@amperecomputing.com, zwang@amperecomputing.com,
        darren@os.amperecomputing.com, corbet@lwn.net,
        yangyicong@hisilicon.com, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Huang Shijie <shijie@os.amperecomputing.com>
Subject: [PATCH v2] PCI: update the link for aer-inject git tree
Date:   Thu,  4 Aug 2022 10:30:08 +0000
Message-Id: <20220804103008.1960215-1-shijie@os.amperecomputing.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0356.namprd03.prod.outlook.com
 (2603:10b6:610:11a::34) To CH0PR01MB6826.prod.exchangelabs.com
 (2603:10b6:610:ed::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95a709ca-0492-4ac4-6c42-08da75c14d8a
X-MS-TrafficTypeDiagnostic: PH0PR01MB6503:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vCqN+5nNi6ikz2PFCu2Hk16ETYKSWcAK0ncuJMpXkYuK8mEJBBBlpV1u0wI+IvvSgRATAD8IrZIVCFCkWH8EngIKiD+adzoyxfDsX3FgKFuj/s6rmxIMqAp3Rf0S1ops+tqLVffzkx06WkTdjfZkfbWUukfuoTPux0vARUzGBYh4Op9weWmas+k9wnWzcCEtpGkxFq/gYAS7Svezmkoo8StP8N3pj587h8UppYjnVpvHmlBT586ezYtJN+a2uGjnrCAUnGDxf5VJZ2E3Kpl4699lRX4zsDgSQbP3FKs6G7YwBraI04n2npSw7ETONLK9WDh5/YknwiRTOAPwDbOaXqcWxdA5Tttznqfr6/n7sYNsZGEYvMX2CmPJm2qPJlo0oj6CCh2jNWf9j9DzlUjto3vp6+IHSFmoA9OfpQ2cI/yfirQS0/LVPWvH/semxxvdxSRZMyz8pphaebREipRbXKSWHqDv9KRdEPO5T9p5z/M3vSrQmo42G1d+q1BzKT/AYjgHHVikjlpefVMsAhqxC9tDqrDr4Injjv4uKuvuzXRsqmYa5ACEwuObMnBgTP96MB3Z3itJlMBfqDCFI2H/fj16Sh/SK9maSRzcgjCXjneJQ8XYLSsVLMX/abduardKf2JIv2ccskQH/SgXBM9KxMcDzZWKLkHSklQJA+BcxGJBDonpzTETGXromFNgKt4/m1k0hIQKq22+UD2mmRdQHVPEDdYe/9hQyBhy2E9+QOeElqcNh4jdfH1wuWL3lGwYWM5ZKqrvwohQmfYVoiS8wPY0HtuHX2GVCWrNp6HoPq8TXdHFaZEh0XdJxxO6A74hgStpnvP6hY3sMB0t9QAH5g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6826.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(39850400004)(346002)(396003)(136003)(366004)(38100700002)(15650500001)(38350700002)(5660300002)(8936002)(966005)(2906002)(6486002)(478600001)(1076003)(6666004)(186003)(107886003)(2616005)(316002)(6512007)(6506007)(26005)(52116002)(83380400001)(41300700001)(4326008)(66556008)(8676002)(66476007)(6916009)(66946007)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2CQkIo2KXW5FRM+xBCos0RjUpFmZ9VT24hTvJouwkTJw5KVCW3IK/r7Y3RJy?=
 =?us-ascii?Q?cwKIxLTiEpOmNfg08D1Fq+x11wMKNJKgfejSSUNxTjxSBemB3v8GIBTd5X0s?=
 =?us-ascii?Q?fmICn/FLsOtX2P8p588NaJo9fzHeg+sesJM+2xd8Pb50GgYcP2b+7w6CGUJm?=
 =?us-ascii?Q?+o4JxgO3X9Jpc5Wvl6wpulclYUm8Kz9YXsTDb2/rUX0HobKudMFWu8Ejq2nJ?=
 =?us-ascii?Q?i/s0K/4JZ2FRQxQ5gVnjetbSMvjNmbvQWakW7psctj9cyXuvmlGCVMst8nzN?=
 =?us-ascii?Q?7jxI0uV1T68bO44btXYAF9NN7qMAH7Z7XssEcGM4ChMrmJxzFo+uKwgYOnI/?=
 =?us-ascii?Q?AQh6TKo1YB/xQxM+kxNLcEbFO6pkwGjmR8Z29EcIpiLvmxzTa+W8991ZsU4Y?=
 =?us-ascii?Q?VhJ8d8175yx3vR09Vs+Kp7w4X9sLizkSfkDpp61Mu36psM8hiIkiBMo1rUXt?=
 =?us-ascii?Q?kov1wYEJFvLz05M4efgbn5u1SawSDKoDuGdjwIjzWdgCfihK0HSGUbzPqSDZ?=
 =?us-ascii?Q?B8ezVq+zK3P+DeAMoHAnPQkNeCyRaShcralacvBMtad4FYXA1g6fCk5HhC9k?=
 =?us-ascii?Q?Tqo4Bh/dYwC+FwGDowdqvUqiK2HthddXfS1SPlj72/kB9U223qatAYKN1MLi?=
 =?us-ascii?Q?Vig4DbdN09OF26hy1u9sSON+Y7t2h+jDM2shVEUpum+BXhrpJ+XDju+Q6zW9?=
 =?us-ascii?Q?Jg5E4e5w7qwpX9YwznSNwe2OO+9aAMmga2kSd4sUvOyCN1tzfowNGd17QuRn?=
 =?us-ascii?Q?Myx8ine5LavmelvTtIm1wLMYEjf6weg8ixdTz0JHwtoH5Il3/BjjF6muangr?=
 =?us-ascii?Q?S8IQhcHYEux7zpIoemDinefgAihFwTgre4evJhv5ndya4NabJVS+/VPR4GbL?=
 =?us-ascii?Q?5hKjxoF6KrbmHKrO6ccfI4JjHJsjQSPxyndwt8aMEb747QxrRo0O0kqDpLvj?=
 =?us-ascii?Q?Cy4eHs89DnQwRMT1ulYvAu2fjFXn1R56ky5WSu3bbBH3L5it5KqWXpvbpIWn?=
 =?us-ascii?Q?NFajGjgweFZL8gMmJ2BpM7Kol1Pv2CuJ49mZpYfFQaYszonG0vy9BGxLf/NW?=
 =?us-ascii?Q?BlFJ2Ka/bDyFykOh9jwLKBBnK4ma15V0ZxeIBEVQLl5B5dO2cyxD6Nn6zK9G?=
 =?us-ascii?Q?J+pRIi3hRpGmI3LC0t3Rt/NqT4+srxtUnM+chmoNK7D7FmN9U+4B8MZpwgJJ?=
 =?us-ascii?Q?vgjBwWAp/LqvXuRRdBKWXh10231+yhxewFBjlScx1+bZ41jHvGUkh7IvTgGp?=
 =?us-ascii?Q?PqpS54EhOZWjk+yBm6dXBA8pZoRjP/CM40V6SdlHfH0WR4/P+IOL9GOCUG1C?=
 =?us-ascii?Q?DY0iiSX+n7qdiPKSsLa8ZqOIXWR4zLV4g4/TdHogIjsGS41fjC4SPqlVxznB?=
 =?us-ascii?Q?ZyWZs7moWqESES+wqNu0OcxAUTkFXgkiM1ErroP+TEomagtTUANlxXVfwCik?=
 =?us-ascii?Q?YangjVF2bmLdGcEqOOFX1XTdjVmw6zZYKFMmyg25TF7R3DGQiS5fTykfY/ea?=
 =?us-ascii?Q?f5uNcOdnOBOcYubJNXjDdJ3bFKF8xrlSuckFx8QFd2v2bNPlWm8Dku54XIiL?=
 =?us-ascii?Q?ppr8jzlKaGk4Odkt+rKfnK+9Eq9WvagCIXSOsF3qUuSyeGRdpqzMi3nuEulE?=
 =?us-ascii?Q?auGm+gV/s21eb1TI5EdlQI0=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95a709ca-0492-4ac4-6c42-08da75c14d8a
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6826.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2022 02:30:32.0619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9uU3SMvnIroP3BDaAAK6EOaw4IHqV2u4pckoFjd0o3SgIM8SEtVdgVIuAUTHvIvLFd1xZLNrwS+BUwWYhJKUksOJu2TlfBQVFpgHxNHzf9ddPiiP0T+Vx9aeMTelgjfi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6503
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

This patch updates the links.

Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
---
v1 --> v2:
	Modified the commit message and the title.
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

