Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959A95502E3
	for <lists+linux-pci@lfdr.de>; Sat, 18 Jun 2022 07:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbiFRFUh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 18 Jun 2022 01:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiFRFUg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 18 Jun 2022 01:20:36 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2052.outbound.protection.outlook.com [40.107.101.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7865EDF3;
        Fri, 17 Jun 2022 22:20:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bimHtQjX4BuuCOk4Sa9aMT0nhDkVppOrF/uNPk4BuanWzXrEzHxYDk+rj/EybLY8WyVx6UfavqvdqctryXhlPBScuKdMz/EBEWcy5jqoQPp6zKHCDBggVZNved4LKAKemx2MsZrNv/5FFAS49A7NylVuaISyyN3wq9LnIByDAxkKA2Ry9KD56Mwi52LGi7UAOLad+NgQEkHx67NnAy1lqAJjgw6gcwPrd68HJ01Hh4n36+3f4HxGkeAl3xm2IJXMK+7a7dETyx7/Xc+U8NEatMqAVa/PSIUWt1qRwldVVIRN7ET7nlh8YF3GjwkFKFBwPC+P8tchn4fDygCww7LFXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kDG8eO1AxvCuQrB4kvRkEDlYyR1EUY7bFksPQ0fG2YY=;
 b=PlaDqRjGf9i08rGJctzYA15lmVaLbZtf7E/zoMQn3EnOSpXw57E5VRxgv4YPZi08vWNjrB6cCbdwZ/YvJaGz8NzMgqq7zvZSjVXffimRowvdTLUIlDGUlXMYn+jxM1w7WMa9bKAejiYDBMQdiaK493E14PD5lkT350MWWeSfq176vKkr6Jj5uaxN+Skgr2e4EdKUaXRITnbN/Hg16lGxv33goMPsJzF/kKlna2EeBL+DlXx66Lae573cWttDs9K5Hqq/K5e2poueviDmphORKR53X1m3CgHixEiOMM7hZG/qVNpuO8A+LjnX5iQkVPCQZY4Us0wKv2dqiy7DpUot0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kDG8eO1AxvCuQrB4kvRkEDlYyR1EUY7bFksPQ0fG2YY=;
 b=YfII6m5qWe8gRhAR0SvvtPgqJdAcXg8IfifoFB15CE7I102feSJULxvI5gUXDMsOFtOTvc1zLZOU/kGRpECSgA3uV3zMkjzBs0hzC7nrxgzdkBJlLTHjeoG1yK0kG7rRpmNPipfyLXNUqc9M5hniz7fRSZ2mCYMSzYXGvgfFtTg=
Received: from DM3PR12CA0047.namprd12.prod.outlook.com (2603:10b6:0:56::15) by
 SJ0PR02MB7421.namprd02.prod.outlook.com (2603:10b6:a03:2a3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Sat, 18 Jun
 2022 05:20:28 +0000
Received: from DM3NAM02FT050.eop-nam02.prod.protection.outlook.com
 (2603:10b6:0:56:cafe::e5) by DM3PR12CA0047.outlook.office365.com
 (2603:10b6:0:56::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.16 via Frontend
 Transport; Sat, 18 Jun 2022 05:20:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT050.mail.protection.outlook.com (10.13.5.53) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5353.14 via Frontend Transport; Sat, 18 Jun 2022 05:20:28 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 17 Jun 2022 22:20:27 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 17 Jun 2022 22:20:27 -0700
Envelope-to: linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org,
 bhelgaas@google.com
Received: from [10.140.9.2] (port=44932 helo=xhdbharatku40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1o2Qsl-00014q-2w; Fri, 17 Jun 2022 22:20:27 -0700
From:   Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <bhelgaas@google.com>, <michals@xilinx.com>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: [PATCH] MAINTAINERS: Add Xilinx Versal CPM Root Port maintainers
Date:   Sat, 18 Jun 2022 10:50:22 +0530
Message-ID: <20220618052022.10388-1-bharat.kumar.gogada@xilinx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 09035c78-5dfd-43ef-4ecd-08da50ea41d5
X-MS-TrafficTypeDiagnostic: SJ0PR02MB7421:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR02MB74211CBD5D0623060236597DA5AE9@SJ0PR02MB7421.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xXfSoJKhxdVo7kgyGnRbLtDRGF8fOmFEGsyBPSFCojhl4dLCzfVznCNySFQs3peaZYgIWzDREqVdkKtmokKgMF8Qhy6RedIJ6XevESzLCI/Ryq8+HRcGQtVlrk5qupRTnqA+1qqw/59VkLj4eMnYqz3J8fj1LVOb1zow4yWH81GlY/F7/KlXTbjITxnuGUE0u8xmra1wbHRScCylipi8ZKTWniWJEKH4CcFv2f/hf0bfXRh7H2SPoOlaCcHrpRRLIZIdrB2vgoH5QCYSaALfCc7qxEaJHiR9aBrJZPswI3H28eOwH/gE/ZOrllqVsJlv7VAKdusCeJ8Qzr5VVbr0NszSIHDBwhUWH/iGEfNv+bICJK4smw2e6L8Gh/cfF77CmcbX+BVc/2GCYeBtethcEdem967GV9LVAI7gLpfc6lg9crYgkCdNXZJnv/g0AioawSn8LqEemcBD9ygqYKHpIIUQh5Je2RBRM/60LErDBeGSyNLtSdmbQwrvttuV4Hol+9kEvLk9oviWZ4AC00cV3ANZLGcMxbGhyljheRFSjM3WEHxGL4p38nxt3VCQU6yk2OoNZ48IQvC+uxk+XqvArDgqk96aVHZT11MNEGRjEvgiw8rGpodh1/u4ii/wQhFMCZNwOZ5T4L0wP4q4DNpYVvCiLRkzVM848IvXUJo4IeY+ca+w3TVGRDqNssZb9ujy3qynovJLqIYm+1mJlbW2fg==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230016)(4636009)(46966006)(36840700001)(40470700004)(107886003)(2616005)(36756003)(70586007)(70206006)(356005)(4744005)(26005)(5660300002)(186003)(82310400005)(103116003)(36860700001)(6666004)(54906003)(9786002)(110136005)(8936002)(498600001)(7696005)(47076005)(2906002)(7636003)(336012)(426003)(40460700003)(8676002)(1076003)(4326008)(316002)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2022 05:20:28.2476
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09035c78-5dfd-43ef-4ecd-08da50ea41d5
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT050.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7421
X-Spam-Status: No, score=1.1 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add maintainer for driver and documentation of Xilinx Versal
CPM Root Port device.

Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ea3e6c914384..a07f926d7e93 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15063,6 +15063,14 @@ L:	linux-pci@vger.kernel.org
 S:	Maintained
 F:	drivers/pci/controller/dwc/*spear*
 
+PCI DRIVER FOR XILINX VERSAL CPM
+M:	Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>
+M:	Michal Simek <michal.simek@amd.com>
+L:	linux-pci@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
+F:	drivers/pci/controller/pcie-xilinx-cpm.c
+
 PCMCIA SUBSYSTEM
 M:	Dominik Brodowski <linux@dominikbrodowski.net>
 S:	Odd Fixes
-- 
2.17.1

