Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF62B54E0F7
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jun 2022 14:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbiFPMon (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Jun 2022 08:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiFPMom (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Jun 2022 08:44:42 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4A6DFC4;
        Thu, 16 Jun 2022 05:44:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K8GwtpKPpCUpBno9Cj1arWMVZCv143LC5VdKG18DKlMWL0Q3jLEsRpk/KBjKnymgosHRXib2O02PMAPYgIDfAwWuz3H6oXnqEeXNjdGXUT54G8aw0CMpYOiQZTFQRAmEDV5I3IKq0F/EnlGBRnnrEVGyi07zdjoqk4qluiin9XZcPQOtir9nx+O0T1Qra9oKuz4DQvUjKO6Kv9T5OLn1MJWirqHKOvZ6YXuf4dJXDxvD79a85NY5tSiFLDE+ni3GOopDxAHW8mrT+T0Ud8ftQb34z31SfVh7/Hy6JwNhmEoWkUAwfnFc96oI0viVruhSiwHwK2QaPZHKNSn7HnTC+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZNenaDrZYEkFAQHcjYIh7L2D9Wouh6uO2jzRMK+XK/A=;
 b=dgSDGMfj3i0tbu5SLtWsI3iBVxaRazE87bsNtS+CJPZFtBTrftVKUqCHCqieQf9b3EGr5wtP83DDGpRxcjoit1Zxul0AMVUcdoDjJNxM0jgIuKQNesuDCaspggrbn0U+x/52Vho7OqvZ8v17nicY3r7wcbZynzTBD8uUnU7UT40PbwdQOfnwYv2pyGi55akNkjuQp8TCZxh/dINhN+vlcv03YQuhkFYtlCtM+qoLrgTjjLwoJ+PKDGbpJQEtnBwk/byLRsXY5OaiB0KJuY/n5nIjFvgAIZN9H6XdBbg/QICBD52+A6aNgEyo8USBBoUJhgMqjZzcKs0VLcDCvLEBhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZNenaDrZYEkFAQHcjYIh7L2D9Wouh6uO2jzRMK+XK/A=;
 b=h6VHhzbfaigqNUiPGqaYbtulBIf+dEcpcoNKQrLXY5AisV21HuIzXcy8NpTkACtOesrCHT+BFNxERLAq1UfiSrNWtBJOhb7P5yB16hwZOEGFFAy74zC0BsUyl9XaveM3xNVfnWSr29HW8bMOy2uf5l73/r2FDnW8hXii3c3/r4w=
Received: from DS7PR05CA0102.namprd05.prod.outlook.com (2603:10b6:8:56::22) by
 SN1PR02MB3904.namprd02.prod.outlook.com (2603:10b6:802:27::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.13; Thu, 16 Jun 2022 12:44:35 +0000
Received: from DM3NAM02FT013.eop-nam02.prod.protection.outlook.com
 (2603:10b6:8:56:cafe::65) by DS7PR05CA0102.outlook.office365.com
 (2603:10b6:8:56::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.9 via Frontend
 Transport; Thu, 16 Jun 2022 12:44:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT013.mail.protection.outlook.com (10.13.5.126) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5353.14 via Frontend Transport; Thu, 16 Jun 2022 12:44:35 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 16 Jun 2022 05:44:34 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 16 Jun 2022 05:44:34 -0700
Envelope-to: linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org,
 lorenzo.pieralisi@arm.com,
 bhelgaas@google.com,
 robh@kernel.org
Received: from [10.140.9.2] (port=44392 helo=xhdbharatku40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1o1orS-000Aiu-1j; Thu, 16 Jun 2022 05:44:34 -0700
From:   Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <michals@xilinx.com>, <robh@kernel.org>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: [PATCH v5 0/2] Add support for Xilinx Versal CPM5 Root Port
Date:   Thu, 16 Jun 2022 18:14:27 +0530
Message-ID: <20220616124429.12917-1-bharat.kumar.gogada@xilinx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a2f98e52-57e9-4aad-2618-08da4f95f7ba
X-MS-TrafficTypeDiagnostic: SN1PR02MB3904:EE_
X-Microsoft-Antispam-PRVS: <SN1PR02MB390402E3D96751A41788E884A5AC9@SN1PR02MB3904.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vQ2MI3qjSL7LBKZyUO5Cw2IloMq6WBOT6jvHRcDYoLMXPI+COx0Mttjpx7p/N9wqL3mIZ5rj98Zj4j2xwzO+NZ5BWOOIlt/DttBsRhMojuRdB8sUCoeUEYmFeP4mtFHmcuWeE14xtedOi3Cd4AwxaMnxDxb4WOoO+Jwi2/ow8xOhiQWWjL2LrAfXduJC4iE6O8VjZl36IXHpJ4JGZODjAyTDf5p74j04gStNcdeLPRca6nhCbVus1oer2o0MG0lXNDvtm6rRzlg+TQpIuzoc04Dk+rJV647P8ScusqexDe6PK1y+4kBOR8x1ddIvSZX/XN+ete7RjxjnOC8JMMvUGah3dnEiBTYPxJoMJg7vZYLdQZ3MvJ6KO+21LiEbsY1HA61yJ5vTiVHZ/EsbvNvfOB4hJubo7boQlHHUWSDwXAR/Njjt0VP5MPpZrLrLOGtXjPP3Cv799nDH4PMOnXaSQICeqDTwrnXu/Uu0fkm26BiKzExJ3Ts76PZeHIe70yhPrx+WD1ZWCf6CLHzk0GX3LGLtB1EIjOqep51VTi0b4CG6kvcDVtnBWdp8f9wFXUql91zlQ0HB7ynqMbiqCbwT0KoS1d7NvaC/GpAkwESF/+x6OB0VLAcEPgsSWoVKteqrHTHQx/wFsXU2ss14ScXZ12A2FBnIsOg9L+uqKM4JO6wRlpJGBqmPpPoNzXzWwOh7EDil6lOppbDLQZlQ6QclMw==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230016)(4636009)(36840700001)(46966006)(40470700004)(110136005)(2616005)(70206006)(83380400001)(7696005)(356005)(8676002)(4326008)(316002)(70586007)(82310400005)(107886003)(426003)(9786002)(1076003)(5660300002)(336012)(8936002)(26005)(186003)(47076005)(7636003)(508600001)(2906002)(6666004)(36756003)(36860700001)(103116003)(54906003)(4744005)(40460700003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 12:44:35.0302
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2f98e52-57e9-4aad-2618-08da4f95f7ba
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT013.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR02MB3904
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

Xilinx Versal Premium series has CPM5 block which supports Root Port
functioning at Gen5 speed.

Xilinx Versal CPM5 has few changes with existing CPM block.
- CPM5 has dedicated register space for control and status registers.
- CPM5 legacy interrupt handling needs additonal register bit
  to enable and handle legacy interrupts.

Changes in v5:
- Added of_device_get_match_data to identify CPM version.


Bharat Kumar Gogada (2):
  dt-bindings: PCI: xilinx-cpm: Add Versal CPM5 Root Port
  PCI: xilinx-cpm: Add support for Versal CPM5 Root Port

 .../bindings/pci/xilinx-versal-cpm.yaml       | 48 ++++++++++++--
 drivers/pci/controller/pcie-xilinx-cpm.c      | 62 ++++++++++++++++++-
 2 files changed, 103 insertions(+), 7 deletions(-)

-- 
2.17.1

