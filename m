Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 884D632123E
	for <lists+linux-pci@lfdr.de>; Mon, 22 Feb 2021 09:48:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbhBVIsf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Feb 2021 03:48:35 -0500
Received: from mail-dm6nam10on2066.outbound.protection.outlook.com ([40.107.93.66]:28897
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230088AbhBVIse (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 Feb 2021 03:48:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e33hXmZkKUXg8OlA3bBfhOzEOwYzoBLziAw+vWNlCN1wGrV+ApdG7N6FElZyNcrA4U6cO/KV5GsOGrpXDQ0GSBT8NebKwhc2vRpkvEa90hB08tee0aoqF0TyWsUEqoIxiiboxAKj9bTzstwBEm5cOtcEVKxp/Yr8uIWibSaTlbCdhuvIiLjqELA8pzXZqcH753unPf3vRwOx10nAVgNPzfHCY7LdTXnCj2ovou8Nq+7CxmippZaRtSBIIaX5lYnUL4H3FokOi1POXUeqGUC/oszP3LN6IvfHwWqn/BrFflsFAXf1Y5agaSQ0ykOihP3hm3Of1ILj/ocze+vnURPAjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j8+mSReKVu5/l/FJ8ALBYjnmeqXn2KGoeugFYsbdO3o=;
 b=fsvYdZS/CgsDUS0K9dwuxY/gJIrpbuSVpga0mH26P1imGMFBMnPYWjNfdKya/B1zBN9R3s7eYedCxa6kqi4bJr2R12x4S50L94ANQyXBBz9rjlLjrcA5rgIVM/DKxZjnkZ8l4BH92VPDTlEYNh5cskUrG7mDwSY8XrOEh8wFw98g71u4Yhva9O28dy9/uKETc0ZGWw0bslt8lfHzESvWRQVyiiD/VhwIojSceZ3GyTwDaGk+SmVAZDvyiKlAFv/GUJYi67eYcNRj3XEFiQ4gkFd/aZwfldTh7Z/Soq24DzfzAujCGnjfnZgpxma3rh4cjZ5EwK8+fw6Z12x9TgaDFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j8+mSReKVu5/l/FJ8ALBYjnmeqXn2KGoeugFYsbdO3o=;
 b=UDL3P98rz9IBmTCJBXNOvsuke3Pa3kjRozsR5R6m9eHPbE28Vql3SmH3WDbsv4kWFXT6xcZeH8WAjrp1RWRleikc06n7CUWhEhf7+YzmiWMLNX0Os11uQCri0NiNimN1/LoBjLM8yoTzsJ7eFMBcKBfaiWTKczm+E//97/ZWGmo=
Received: from BL0PR02CA0054.namprd02.prod.outlook.com (2603:10b6:207:3d::31)
 by BYAPR02MB5941.namprd02.prod.outlook.com (2603:10b6:a03:11c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.29; Mon, 22 Feb
 2021 08:47:40 +0000
Received: from BL2NAM02FT062.eop-nam02.prod.protection.outlook.com
 (2603:10b6:207:3d:cafe::9f) by BL0PR02CA0054.outlook.office365.com
 (2603:10b6:207:3d::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend
 Transport; Mon, 22 Feb 2021 08:47:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT062.mail.protection.outlook.com (10.152.77.57) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3868.27 via Frontend Transport; Mon, 22 Feb 2021 08:47:40 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Mon, 22 Feb 2021 00:47:39 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Mon, 22 Feb 2021 00:47:39 -0800
Envelope-to: bharat.kumar.gogada@xilinx.com,
 linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 bhelgaas@google.com
Received: from [10.140.9.2] (port=33774 helo=xhdbharatku40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1lE6sU-0007zZ-Na; Mon, 22 Feb 2021 00:47:39 -0800
From:   Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <bhelgaas@google.com>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: [PATCH v3 2/2] PCI: xilinx-nwl: Add optional "dma-coherent" property
Date:   Mon, 22 Feb 2021 14:17:32 +0530
Message-ID: <20210222084732.21521-2-bharat.kumar.gogada@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210222084732.21521-1-bharat.kumar.gogada@xilinx.com>
References: <20210222084732.21521-1-bharat.kumar.gogada@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad043258-54d4-4e0a-6b3b-08d8d70e8330
X-MS-TrafficTypeDiagnostic: BYAPR02MB5941:
X-Microsoft-Antispam-PRVS: <BYAPR02MB5941AF5CF795F30E8652771CA5819@BYAPR02MB5941.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7arGrvwFyRUk1fnA6Kn1XnEJoHHoeoJn9hB1xTzwg1yJaMazhQfEbg9bbrJ7/AMTEUBGy8khdoOOSR7FBjSmguNI+DOc9P0J3Ilyon21Ca6QuNrPLgKWsLfP4IxhM/1dL/zv8X8/bddciuxweI/y+BBsZrk2nOgTiMuLxGk1ytAZPgp6sCteb8UjKezHy/BmgehMI/wFKq8dOO85oxrWfOTKk43Ru0NZgwt5hV9FtTpmJ054D1LQgBzynnGWiT9oJ22TkZ8Z4iPVWUjLYIb7eFZy2hvCBsBF4qf+IGFnKUYPb4umDDtkvhfhnWxyedO9z/y7CwcyrN5N/86fUs5zS39+EZYt80v+Cb8BlOPeqYGXh6fA6gizlNPIntYnAlXzLTsRuKUXa23Um11Y0PABqKPL+23uCsioN3cMxKPWHjAopxqD2hlsReWCtcA08kWy/1TEbxvBG3lzwadnyjrgRMTyo4v30FzmaBxHIJtvy+Yfk7UiPLhUvdUf7Mi3r6CjqGHJl8yaOm0pAr1eZFqSbcYAmPkH8M+In3NpFjjdGOr/fKnaiuVMh2jzVZuxyDGH68A8/KfUz/ABVUAcSWqXWCxcImS5gNdO6XthQfF33sYJ3pSMBlugLKAv2gLQSr08iVK2tsGGrFYvi63FhaU6ll5LLX9myj7NoUvKQbvcJI9UjiHTN1TVXR71NqPrmG+f
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(396003)(136003)(39850400004)(376002)(346002)(46966006)(36840700001)(2906002)(6666004)(336012)(2616005)(186003)(7696005)(36756003)(54906003)(356005)(426003)(82310400003)(107886003)(36906005)(9786002)(4326008)(8936002)(5660300002)(103116003)(26005)(36860700001)(82740400003)(478600001)(7636003)(47076005)(110136005)(70586007)(1076003)(8676002)(70206006)(316002)(4744005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2021 08:47:40.1998
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad043258-54d4-4e0a-6b3b-08d8d70e8330
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT062.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5941
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add optional dma-coherent property to support coherent PCIe DMA traffic.

Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
---
 Documentation/devicetree/bindings/pci/xilinx-nwl-pcie.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/xilinx-nwl-pcie.txt b/Documentation/devicetree/bindings/pci/xilinx-nwl-pcie.txt
index 01bf7fdf4c19..2d677e90a7e2 100644
--- a/Documentation/devicetree/bindings/pci/xilinx-nwl-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/xilinx-nwl-pcie.txt
@@ -33,6 +33,8 @@ Required properties:
 	- #address-cells: specifies the number of cells needed to encode an
 		address. The value must be 0.
 
+Optional properties:
+- dma-coherent: present if DMA operations are coherent
 
 Example:
 ++++++++
-- 
2.17.1

