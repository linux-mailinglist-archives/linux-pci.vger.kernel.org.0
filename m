Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD86B4B6C92
	for <lists+linux-pci@lfdr.de>; Tue, 15 Feb 2022 13:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235754AbiBOMqY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Feb 2022 07:46:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiBOMqY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Feb 2022 07:46:24 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D19140C3;
        Tue, 15 Feb 2022 04:46:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YJADdNmamYrpJrrFoh5gxneWJTNTMXpcSHVKu4l/uFdszQFvA3C/KNlrUszdgtB7Y2SpJV4DSl2jU3DgKY+aJKZ2tLt3bExRmiyj73iODnpr1zb1++vkvHoOk20wVm/UkF9eEE3ENd0MVKpT/v8I13y1CiB6m50XgL4BsBo+6SWIL/wazJuXiuCIYd+o8KQZFrsuMHm9tJ06nkvtOPlTjOTlS9usmbfKvHFbtLjLB5+W3Y7Ev4MAdQ/N3GSb/r6mSLCfOc6D+ck/fwJONDCHDp1YwFNRsxlSXAlwii8U50XXS469CbtwrZuKuFCX3Wre6UXgJCfRXQwqYdBiFXyxAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CUXlCp8PTld7zLGup2QKKlRt7EIQMnQFfnBIKAgzQSQ=;
 b=O9wIfN4Dx15d8nqJyvacSOZevFBG4vriml2qhNZ+61STCJPfTkBZgEke40Yntckis3xkOXpvFI7BrqSUHV6qV4fXHWfKIfXwhqM1bIr8O0vDbpBOvR1+9RI5GzPvnwOnwMDL8l3hSjU3phuMDwkCLkU5+g+rPGz3Uxo3cEiP+ozUkzUR9WuBb9B/QgWKGV8Jh5e/mqKVP2ZZE3K78pRhhU6BQDf9aA9b3rK21exdrByOQPswGVb9c+gYMSeuyQKbQAwMzCCXmhmvobT3Kh53w2tNK0adDyQkqjDnXt4F4XOqBDF1d448SSDSU4I8jbp0PjqSILYUc8MJreZYBVHeYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CUXlCp8PTld7zLGup2QKKlRt7EIQMnQFfnBIKAgzQSQ=;
 b=U1ruQC+ht2jhCKzLKXmvokMlm24X3RsUZy+4XMTCMadavx2pdIM6uw5qt0NewrBggGjIBiUmchyyNuJhfftkyNnr1L1Jgs5t7sBUz2IbV0jZ/pMKXmnb07Hatj9wDR1QPVD5bG+QNFMwNJt0uu3aKMqqqHIWu5IiCaUF1Scmg/M=
Received: from BN9P223CA0017.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::22)
 by BN7PR02MB5122.namprd02.prod.outlook.com (2603:10b6:408:2f::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Tue, 15 Feb
 2022 12:46:12 +0000
Received: from BN1NAM02FT053.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::23) by BN9P223CA0017.outlook.office365.com
 (2603:10b6:408:10b::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.16 via Frontend
 Transport; Tue, 15 Feb 2022 12:46:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT053.mail.protection.outlook.com (10.13.2.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Tue, 15 Feb 2022 12:46:12 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 15 Feb 2022 04:46:11 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 15 Feb 2022 04:46:11 -0800
Envelope-to: linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 lorenzo.pieralisi@arm.com,
 bhelgaas@google.com
Received: from [10.140.9.2] (port=50434 helo=xhdbharatku40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1nJxDf-000EtN-2l; Tue, 15 Feb 2022 04:46:11 -0800
From:   Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <michals@xilinx.com>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: [PATCH v2 0/2] Add support for Xilinx Versal CPM5 Root Port
Date:   Tue, 15 Feb 2022 18:16:04 +0530
Message-ID: <20220215124606.28627-1-bharat.kumar.gogada@xilinx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b80e0272-8d10-4da8-9908-08d9f08125ac
X-MS-TrafficTypeDiagnostic: BN7PR02MB5122:EE_
X-Microsoft-Antispam-PRVS: <BN7PR02MB5122A7B3F7D770863202098AA5349@BN7PR02MB5122.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:324;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n2jiQiOnj659QWu2ckoeWFpVBviPOSRfwZNYTK9TOqu4BTu2YB8hXWopqsvGbB5dNz2kud8HOqFRiLYNdR6tb6sXTWaOYNmiN9RqgCOfV3FnucYIEVPg3TLtKtrOpGzxrE6VyUaQlnLXZjd9NbWGoeTHUqJpsvnQZm9/fh5VJ2nszyjwTr+Ap87xxxyZgX8b7Stb290okleikLP2bm+82cGUgwo6ptkGsX5DX+pxGWKmrN3SrjVu352EGJ/1Dg5Sc83avGeVe3uGGX5An3Y15mCukzm77g0Y9zuzzATUF7YBxtVrnZ6O8yjFCx4LPk//A5NiMicX62N1AF1+krRT0SIzw1YA7TQ1x5EEgJUQsacflG9zTBd9/oTOt3Fw1VagCZu+F1fx0XgpkvI87TYPlXISnC6DFcPi/CGin8ZouwyEZYG3DNtf+kG3qMQ9tQDPrSrkUQ1P0aWIiwQwhCWgzfEFaodKxA9gbPJui3s6QubUUbiLrr8zmSigwmXUR4TyQifKf+ebdxIdPCR8hUgDL8lkuyaqyc+WqQ8w8iD1XLZ+Eo5de2OI2rmUmDJUbmloKhEywNbX4qWOgdyMP9l643dAQZED8iQXj3u+z0GhACyM/805UnKJL5bvCoAUZWTBfmg89lr/hkfE5Do4EHXrEs/zXT9LSIxQJ2dvk+B5UQ7Sap6c7Nt7l20US1CJQu5wIm9zbz28pOZj0gvJH3ti2w==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(2616005)(83380400001)(4744005)(36860700001)(103116003)(6666004)(7696005)(107886003)(1076003)(26005)(186003)(336012)(426003)(9786002)(2906002)(54906003)(47076005)(8676002)(5660300002)(316002)(508600001)(82310400004)(110136005)(36756003)(7636003)(70206006)(70586007)(8936002)(4326008)(40460700003)(356005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 12:46:12.1745
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b80e0272-8d10-4da8-9908-08d9f08125ac
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT053.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB5122
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

Changes in v2:
- changed commit message.

Bharat Kumar Gogada (2):
  dt-bindings: PCI: xilinx-cpm: Add Versal CPM5 Root Port
  PCI: xilinx-cpm: Add support for Versal CPM5 Root Port

 .../bindings/pci/xilinx-versal-cpm.yaml       | 47 ++++++++++++++++---
 drivers/pci/controller/pcie-xilinx-cpm.c      | 33 ++++++++++++-
 2 files changed, 72 insertions(+), 8 deletions(-)

-- 
2.17.1

