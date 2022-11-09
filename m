Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D75C6228B8
	for <lists+linux-pci@lfdr.de>; Wed,  9 Nov 2022 11:42:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbiKIKmA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Nov 2022 05:42:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbiKIKl4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Nov 2022 05:41:56 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF13B1BEB6;
        Wed,  9 Nov 2022 02:41:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kZTHL5XDY3wRKmLDAGeyf3wJ8QWKYFapm93v8vWFJmILs+E99sL1DgXDXDp7FL9PjFZbCbZ4qZRdHMZT7tLzSA/EmGRAxQQ6CTRU4hwk/lKX1ARdV65VOlS4s7plC3nkgsj7IWBzQrZ+rDswqYrLyhoWaeS4Rnr7ZaN12A09zEKmEfEuhKvKPvGEarcNbmTSvoWPZcsea6u5d6Nkcy9LS9rREmlT6aXbLtzPTcUgGuTZY66POwuhxZaFQUwbKalB9+8o5g3hbUnrJgiQt1cKvakgxQ0td4lW7snm1BARXvJhqEV6SZvA/t+u6rFks10vBy43sfwLiBbDJCxRC/NhCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JSIyl6waVDcHfCsJjAro/YA6c3cWSEtPh8eZJxbZJEQ=;
 b=dgg340pH6rygpPKbX5HJMzvBcMSNjLiFxP9FVfHOTBDKwhkPMQKB9Ta8bK7Llgwpct+lhoazgoPXhRQpw7BCPr4SdmE9OTtM8mkxl57jEvtA/erz5VR0vss4GFEcO1vaURmDxinr4EeiNZW71NzoGppj/cvWYQDmzqWIgWjxbTwZF7+V2LQgF1urdRl9dVx1mCUGiQ6/KfI/IcAfINzgIoSaR3iP0ZlEmrvC1WwRtNbyqEp5CWfQXLwQQt8Vxu865pa6sTHaezSFviE1T061WfWnlUebQ/DPaypPOigGr+/91J1CDJiG0JAOv+tfUF3nHrLzoeL6Zpby9V3gKiX1AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JSIyl6waVDcHfCsJjAro/YA6c3cWSEtPh8eZJxbZJEQ=;
 b=TunuBCBCEwFBrYJzzBZqPHiIblSFEFnA20gsHGY0ZX8FIDnh/nYjAp1oA43RoGsI7hKQVqAscztbYbFLPQaTWHyXEXrqwIbMSCHGfufrgwSzaNjGwl/lDC16ELMFBAh2ePg0F3rapd14wZwB4AKYQU5VhOEhKijS+noBT4FY7Fo=
Received: from BN8PR04CA0035.namprd04.prod.outlook.com (2603:10b6:408:70::48)
 by PH7PR12MB5687.namprd12.prod.outlook.com (2603:10b6:510:13e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Wed, 9 Nov
 2022 10:41:49 +0000
Received: from BN8NAM11FT105.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::ab) by BN8PR04CA0035.outlook.office365.com
 (2603:10b6:408:70::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27 via Frontend
 Transport; Wed, 9 Nov 2022 10:41:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT105.mail.protection.outlook.com (10.13.176.183) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Wed, 9 Nov 2022 10:41:48 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 9 Nov
 2022 04:41:44 -0600
From:   Robert Richter <rrichter@amd.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Len Brown <lenb@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Davidlohr Bueso" <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Robert Richter <rrichter@amd.com>,
        Terry Bowman <terry.bowman@amd.com>,
        <linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>
Subject: [PATCH v3 9/9] cxl/acpi: Set ACPI's CXL _OSC to indicate CXL1.1 support
Date:   Wed, 9 Nov 2022 11:40:59 +0100
Message-ID: <20221109104059.766720-10-rrichter@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221109104059.766720-1-rrichter@amd.com>
References: <20221109104059.766720-1-rrichter@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT105:EE_|PH7PR12MB5687:EE_
X-MS-Office365-Filtering-Correlation-Id: 323ab923-8b23-4f2a-e6da-08dac23f0151
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fax13Wjkm/oqgVNzJHzV5ilUftsAMVBjzQzFccCVDSIBzUK8KXCGEXouyz0bhZTiO6k1UIAr34pRS81P3/8Z+Gwqw8FKI2umx6DDI/ALw7r8xSvPa6zK8+mbtk6X0KKDRCwHuAjggwwnVcNsvsVoOsIcZYUN7Djd7/SBg3RTi7TIsJo2Q+EThhj/cVwwrZX9U5g41nJc1H28JLCQxnmoIeSEIhhn32mHEu0Hi2KYaQdFaF2SWEkMalgeiLx6UFf694/RlQJm8VwMTdZoWaiMheYJ+0vH0AHDnXMT/r8l0dGfjOeJdlfB1+YNOi7W3g3w7uphQcfMWXz0Fg12QHlyRJ5mtIlxuEiQx+68asL9vOgTjLeq1UV9j7dCtbGzgNnWVnhfUGTvcFJavfg2SDito226JWc7etMKkR4etxMtw85NHAazfnvLm8BzTDleEQsbuPYj9lgc1CgkKS20ujBzxX64nip7TO6qFo5gkmoF8TRa/QDd/7QWmx7JtT2wtSTUwSIw1GeOPRS2+CPTQX3SpMZCDumDIgXd99JOGBb/gxD+4chFtK+38aVdXys6udutUc8WW4bRwV8eb4e7mibKmddgi4p2WshACw4oT7eaz+m1M+My9Z2o3dKxR1kcdgZfS0yI9l5RFM7llnsO0Cfp1J4pqoAkGnxmPTv4LiYWSnWBAwJ9TQ0sqw2McV35cK0olLcdfha/1c37iVDUWcYhJtO6mmhF8jd4tAL8BtE6FqUrQUg+Zn6k7Nhzc8ZpcFOhOjD+IeoeYHEy4n9lX3AlKg/2AGrI1IJmwgaWNo9hfwyOZcoy9fJrUEcROalNfbNf
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(136003)(396003)(346002)(451199015)(36840700001)(46966006)(40470700004)(82310400005)(478600001)(54906003)(81166007)(110136005)(6666004)(356005)(316002)(47076005)(2906002)(40480700001)(26005)(4326008)(8676002)(70586007)(70206006)(82740400003)(7416002)(2616005)(36756003)(8936002)(41300700001)(5660300002)(16526019)(186003)(1076003)(83380400001)(40460700003)(426003)(336012)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 10:41:48.6750
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 323ab923-8b23-4f2a-e6da-08dac23f0151
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT105.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5687
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Terry Bowman <terry.bowman@amd.com>

ACPI includes a CXL _OSC support procedure to communicate the available
CXL support to FW. The CXL support _OSC includes a field to indicate
CXL1.1 RCH RCD support. The OS sets this bit to 1 if it supports access
to RCD and RCH Port registers.[1] FW can potentially change it's operation
depending on the _OSC support setting reported by the OS.

The ACPI driver does not currently set the ACPI _OSC support to indicate
CXL1.1 RCD RCH support. Change the capability reported to include CXL1.1.

[1] CXL3.0 Table 9-26 'Interpretation of CXL _OSC Support Field'

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/acpi/pci_root.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index c8385ef54c37..094a59b216ae 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -492,6 +492,7 @@ static u32 calculate_cxl_support(void)
 	u32 support;
 
 	support = OSC_CXL_2_0_PORT_DEV_REG_ACCESS_SUPPORT;
+	support |= OSC_CXL_1_1_PORT_REG_ACCESS_SUPPORT;
 	if (pci_aer_available())
 		support |= OSC_CXL_PROTOCOL_ERR_REPORTING_SUPPORT;
 	if (IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE))
-- 
2.30.2

