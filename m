Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDA2A3DD635
	for <lists+linux-pci@lfdr.de>; Mon,  2 Aug 2021 14:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233752AbhHBM7D (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Aug 2021 08:59:03 -0400
Received: from mail-bn8nam12on2041.outbound.protection.outlook.com ([40.107.237.41]:20897
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233665AbhHBM7C (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 2 Aug 2021 08:59:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QHsFkplyFyMMlzz0LAnNuJYaQ83kdAFGWPoz4YjCpRCmEyr+RgysEfCHK2eWFp7tTBWZ2U5d1vtpr+yYZec4fThv3pfP4rIHkIPM7VMDneHzWVtBE19l4o/bdOLn3PDamdqIVdBp31k48hlsywYSgxJguxm8zMgB6I1WZ2e8eCE1K9nWDuolLn3513aB9cvJZISOEVtRhVmbEi25ZYRaa0QahKq+7Aw4xEz4OYkHkwmpBYaYWXyaq8oZrL3IWHFiIH/hwaolDPd32mKs4lADZMv4hhThOr6aIn3yoSFZGEQUpxfqd5CMuR+4oU4K+yVAwqda3xWmwrQDZ1LA6XTmNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j4TQM/JSgcsWKb8ikUP6GKgFsbliHiRzN40UngX2oFU=;
 b=HF1T+UmwKN69J1bDcVUDFuCRcKHQoOucnaDb1CYhqb0XyRMiVHg2dqc/am5OH/MTiLr55GlxJdDoLiqVDlBQnS+gDVO8lZ54qwdqly+4MSDQxRlGYCD5bH8cV5ufoHCUyNDw0srErRAJpATdNvVKNtMplctKBEOs2LGcVasjG+aODLTViVcEpb83UYDmcjYScpIn+srYY+5VFdDqLLvBt3DdfwijUi4ZumWR6ugmvleq6GenVP9PderpgHB9bRh/8jNxB2TQxltP89kZIas6AN4fjx5ezNe0SbXnP9sYmyG2N1uFCKL6lVi4Z2+BzXBbxP/FyAWTuICgxiwSzR3Y+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j4TQM/JSgcsWKb8ikUP6GKgFsbliHiRzN40UngX2oFU=;
 b=itsDIMNfIXlgqWHdsHJZCbEAbJv2QK5r1M9bMDEnIkUbqA5Rq8T4UB74Z+wWfl77yuXwpCeRWr0IgTAbNj44qqI+P8iKT4iQDQlz0R3fDES8H4zekU93SxYXEOw6scKJrT+bKqwMypdtV9oRP+95QQ4nnWnq7tN4AstmbcoZcc8=
Received: from MWHPR2001CA0024.namprd20.prod.outlook.com
 (2603:10b6:301:15::34) by CY4PR12MB1384.namprd12.prod.outlook.com
 (2603:10b6:903:3d::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.26; Mon, 2 Aug
 2021 12:58:51 +0000
Received: from CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:15:cafe::12) by MWHPR2001CA0024.outlook.office365.com
 (2603:10b6:301:15::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend
 Transport; Mon, 2 Aug 2021 12:58:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT052.mail.protection.outlook.com (10.13.174.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4373.18 via Frontend Transport; Mon, 2 Aug 2021 12:58:50 +0000
Received: from sanjuamdntb2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Mon, 2 Aug
 2021 07:58:47 -0500
From:   Sanjay R Mehta <Sanju.Mehta@amd.com>
To:     <mika.westerberg@linux.intel.com>, <andreas.noever@gmail.com>,
        <michael.jamet@intel.com>, <bhelgaas@google.com>,
        <YehezkelShB@gmail.com>
CC:     <Basavaraj.Natikar@amd.com>, <linux-usb@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, Sanjay R Mehta <sanju.mehta@amd.com>
Subject: [PATCH 3/4] thunderbolt: Fix adapter init handling during switch add
Date:   Mon, 2 Aug 2021 07:58:19 -0500
Message-ID: <1627909100-83338-4-git-send-email-Sanju.Mehta@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1627909100-83338-1-git-send-email-Sanju.Mehta@amd.com>
References: <1627909100-83338-1-git-send-email-Sanju.Mehta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c6174010-dde4-452d-b799-08d955b54691
X-MS-TrafficTypeDiagnostic: CY4PR12MB1384:
X-Microsoft-Antispam-PRVS: <CY4PR12MB138404739E144525EFD3B8A8E5EF9@CY4PR12MB1384.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AATgcFIxFh+V4sQD6hXPAUxeYstwrYm5/GuJFeyDXqgJ5L+ssBxNSk1s8Pt2dr2vPfQNSaSjruNmQNkuB5hxaWQQrTVqGDlrZliAPdsyBQaPo2C5AgJoAgU6IvkiaV6dHz6F87Xv8T/1fcaYw41QSXTAw3O9OElTd9Bd4zC4xmKNJtkTB7FEcB6c917ydfzS6IP+Sl4IMecSynz5yRpAA7uH7IX3Xr9UT8I1zFeCcdEk2H84ebHF1qgZOrfORaXH8tTWMyzcxq0heGffH9LxhNmO2D//JliS8TdorlXiMDg9f2hiX6aOn4ZwagwznrFAD5wZchJHadnwCHLdjyty8jvpgOj5qqK9ZyxjOFIdiCWn7gU2aUxQkP3RWpvh3gX5FAK+X4kBrJnWgLQrkkoXnKEgJQOhmd69hMI9E5iEVF3IV7jVRzd1F/uqHzFD3WFcYdRv2FTDPMpge4eIy/Hi6PQNDhGD8ywxRQSl9heZ4OQ5Y/byKaC+O3pGtI6bOBsrxyRjgIlnJpV4seNXNMPjtBoHYJSX3blBkTJqw2ks7Mqy6rQz7gDSUG2il/HlGbht9juYvDqJn89Fk80dhwGdkdOXBTI1qK/N6Foiy+IpILPKO5iHmuUOlWS3LDPdedVa5uOhZa4fVoLhrNpg8TzN0FFHXSLnTXFPZ8QfB5vuckzHr2p/h//CmouqBCnhfKFaMOR1FK2xsbKfzZr7MRJMzcZ82PcKZxheHZ2vouDQQjk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(8676002)(86362001)(83380400001)(2906002)(66574015)(356005)(186003)(16526019)(8936002)(5660300002)(36756003)(336012)(6666004)(26005)(47076005)(82310400003)(4326008)(2616005)(316002)(110136005)(508600001)(70586007)(70206006)(54906003)(81166007)(426003)(7696005)(4744005)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2021 12:58:50.9463
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6174010-dde4-452d-b799-08d955b54691
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1384
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Sanjay R Mehta <sanju.mehta@amd.com>

Adapter0 (Port0) is the control adapter on the AMD USB4 host router.
As per USB4 spec in "Section 1.8", Control Adapters do not
have an Adapter Configuration Space".

The read requests on Adapter0 time's out and driver initialization fails.

Hence Disabling the Adapter in case of read-request timeout and continuing
the driver init.

Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
---
 drivers/thunderbolt/switch.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index 83b1ef3..effbfe4 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -2747,8 +2747,9 @@ int tb_switch_add(struct tb_switch *sw)
 			}
 			ret = tb_init_port(&sw->ports[i]);
 			if (ret) {
+				sw->ports[i].disabled = true;
 				dev_err(&sw->dev, "failed to initialize port %d\n", i);
-				return ret;
+				continue;
 			}
 		}
 
-- 
2.7.4

