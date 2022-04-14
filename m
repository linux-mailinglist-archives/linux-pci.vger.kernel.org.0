Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 272135009B0
	for <lists+linux-pci@lfdr.de>; Thu, 14 Apr 2022 11:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiDNJZZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Apr 2022 05:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbiDNJZY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Apr 2022 05:25:24 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94AB46EB0E;
        Thu, 14 Apr 2022 02:23:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XM4x9Fj6U3QnXeXP2DDMXZQzR7SZk+ex9lngbo9WHysXront9qdBQ7o7aKugNtYX3x2CgEJrCtO1xULX+QRxAYT3+C+3bDSn1QPiVBdTqXnk4pchsUUzSnt+Y5oEvesj8C73UBIgdydmXYCEz09mBw0ylw6HMrqamiIh1lkd/XYWiv6Kmz0JP/rihhDdYzZq5iNMS5y8dZ6300S2sNzDiVj0+DLUqV+GPVRe1yP+XC7FC3L4VzRoJ3a6G7+cqS5iEzqRLYTYiOcXtjgv8rttO2BiS3F3QY292HXyW4Sp7SmSYbwsQGzswDmZiHzbTk7rbKqfh1c2qr3XtG+DiBDrkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aTsGmvHB8lo92GZW3yslsoiKfvy2k7WPJU8L+9I+FSM=;
 b=B/HrJSLHAb0WrvOHJx1dArSxnLWoNYgSNBlji0r9yuRxUKXTxPZyIurMcFdJOPV6j+MNAo1GZ0tapV+Plw+JHUSGatNX2C0TPhsIvcnpOvyMZbTRX9k/H4IyFRPU2nOf1zmFEpAuiHOGeR80XprcgjmZ9apoWUUcbF3OOAAOOmD/AcKq0YcydaF7c4SO7jD61eHeVISqmIjGbI/Ia0kjjWRylVnqfoPsW/NXN3XXuWKAjcX/dCYEZE53NWCOo1rUZ6DvH2gv3GaFc/mOsu23p5VVBwyK8eBmowh3LOilQ9O4L6wEcMeeWMea+oZxqACcbgvlH56YjThliT3sdS8psw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aTsGmvHB8lo92GZW3yslsoiKfvy2k7WPJU8L+9I+FSM=;
 b=qdQiaHRPl7JqKizCmhUFy7wCR+PO4YPYJehf/oI2dpSePlRKUpzfTsnIieydD/QLsJG6CQdJOOsc0UUqsbVaY/93R0uWMp19o6jSstRQ8muA7PK/NdUo+tP4uKnO/EgnQeFlOqDjYVAdXgAHbSp+kQw8Q2yDbMbaolSnWB+u0lo=
Received: from BN9P221CA0006.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::33)
 by DM8PR02MB8295.namprd02.prod.outlook.com (2603:10b6:5:314::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Thu, 14 Apr
 2022 09:22:59 +0000
Received: from BN1NAM02FT005.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:10a:cafe::de) by BN9P221CA0006.outlook.office365.com
 (2603:10b6:408:10a::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20 via Frontend
 Transport; Thu, 14 Apr 2022 09:22:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT005.mail.protection.outlook.com (10.13.2.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5164.19 via Frontend Transport; Thu, 14 Apr 2022 09:22:58 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 14 Apr 2022 02:22:57 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 14 Apr 2022 02:22:57 -0700
Envelope-to: linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org,
 lorenzo.pieralisi@arm.com,
 bhelgaas@google.com,
 robh@kernel.org
Received: from [10.140.9.2] (port=38782 helo=xhdbharatku40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1nevgn-0008Tv-8R; Thu, 14 Apr 2022 02:22:57 -0700
From:   Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <michals@xilinx.com>, <robh@kernel.org>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: [PATCH v1 0/3] Remove unnecessary version number
Date:   Thu, 14 Apr 2022 14:52:49 +0530
Message-ID: <20220414092252.12174-1-bharat.kumar.gogada@xilinx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28022151-5c7c-4330-523b-08da1df85dbf
X-MS-TrafficTypeDiagnostic: DM8PR02MB8295:EE_
X-Microsoft-Antispam-PRVS: <DM8PR02MB829506EB0EE7FA70A9E2A3DFA5EF9@DM8PR02MB8295.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4nKRKmZsqCblBGTKkt2hTR9A1FbN4vPO0KQHJmQ4l5gb2u+av7r/E87U0v0cK2c0jhD6TKacxRZ68OnzEXo3CYGKTM4M1EAOgiEH4yXG2hoNmSOzJgf97D0A2JmRYD/mmQtrhJakl8DV3NUaqVhWrrNZB8Fa4u+4RPqAYaa7h2u1YRfId32C206qCYhIClwJwobWHHuuoCRCUvoGoK0rqQHaYJ4ptsLZKhcyKBSYz1bG09bEwQa8cAeK++P7GZOjPNvzh28tl/yybY+6UTvtdq8JWMQY5/ZHtGHXFANMfnxrIBbtr+YTksKum/KxWL2iq0Ave8jhha0GyaKm78Vo9kgGCVf2T8mhIwPK3o9GRh7eNCc+vbai7eeSDXAhdFYCGNVTQ+8hx2HlQqx69VGgVBXLNLh5GTSyDQAD1lx2kT3vHe5SKE/nbWVWNCcZcy9ecsg4lKdFUHnKGSLov6tvvEApHbUO5b88lhi6+wBceBxLbWNqtmsbsaN14Elr1udhycj818ZEX19QYXhRWfSiUwHblaM2gH7Cdw5RSHp4rIgJPHMp6JEaB9kk8x3JwhFf8raJOwM+fVxZ+M1W7+R/piYazTVwdMlqDycq9P7DjQIihWRnuYJIZqgBFfvz2wmvPKE4q/5sM/NX9axMYhgb4RnW9W61rzg9k0MfKE6CnDlzns4Lj16oYFjdwE4MVZ89u60bgZQetmbO5tQECUDP0A==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(7636003)(356005)(36860700001)(36756003)(4744005)(83380400001)(508600001)(40460700003)(2906002)(103116003)(70586007)(316002)(82310400005)(70206006)(2616005)(107886003)(5660300002)(1076003)(47076005)(426003)(336012)(26005)(186003)(6666004)(7696005)(9786002)(110136005)(8936002)(54906003)(8676002)(4326008)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 09:22:58.6854
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28022151-5c7c-4330-523b-08da1df85dbf
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT005.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR02MB8295
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

This patch series removes unnecessary version number in compatible string.
The device tree documentation reg names are rearranged to align with
node name.

Bharat Kumar Gogada (3):
  dt-bindings: PCI: xilinx-cpm: Remove version number in compatible
    string
  PCI: xilinx-cpm: Remove version number in compatible string
  dt-bindings: PCI: xilinx-cpm: Change reg property order

 .../devicetree/bindings/pci/xilinx-versal-cpm.yaml | 14 +++++++-------
 drivers/pci/controller/pcie-xilinx-cpm.c           |  2 +-
 2 files changed, 8 insertions(+), 8 deletions(-)

-- 
2.17.1

