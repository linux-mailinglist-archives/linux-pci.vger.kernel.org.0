Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE35B6DE372
	for <lists+linux-pci@lfdr.de>; Tue, 11 Apr 2023 20:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjDKSFI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Apr 2023 14:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjDKSE6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Apr 2023 14:04:58 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on20600.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5a::600])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7155C5240;
        Tue, 11 Apr 2023 11:04:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j5hpMkQCt3O+uUmXA/0ti3l+vGqP6/RrVr0faU9ATBrsXNcIVb8s/OeOvgKgNl7MJCoeqvYLNQjWX8HNpyASirgq+rOZpfkk4dOULxd3occqdPPryxQ8CE2hcmqJlMmIro0xZgflVPm1V+4qjDeMVd27UScrl+OiV4sMB0+Yg0yWcws/a+v+iXJ2WixFa49FNkeFeC1FL+mxEDW4Sk89/SDozbtgcKTj6YUZSwuSFAhgiQwusMzknI7fJB/in64W7ZsGRXAIsSoRNkThCujZNEOAYnsCbtgeLTESZorsuVtVZXNbJfV9uTuMb/DW7t+EJtUCjkUEJFCz+Pw/R6a6OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9jWizZyOkncM0zUzSAlj45CvBH14g/iZi511HWH1pLE=;
 b=jpD6YtWPsdIrTRAyTcQQmc2XJ6uCaGFOrWcyyWjKDG3xmmiMhmeUPoUwT9b7nwiKH2Z2UQ7IsCvWtK7rcqLH5sNF5JkU4hO8bJfjGKhrgta8uBCwusfUsRgUBldCvFtrHuFcWwQUXROy8CGo17kyOFCHySFWOEyTajr0ndZ72uGqFmqiKi3RDlWP7v/KjE5gkwRhjaXghY1cmhngbwBUuyFv/oaXTdi5s1WYWioeOGFhCZvY4B+ExjuoHXGyUNGstLzfwMOGsdFM0qxp5G/JwoHOmn6Gqhd62oinAjlj6FGISYJeZOyAOLgcQ03dET6kFUpBTlVheNiITDFLTV9EkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9jWizZyOkncM0zUzSAlj45CvBH14g/iZi511HWH1pLE=;
 b=JYXIXHFQvkgc0kNDxxOiyk9wQ4ASCRQFASIns+OfJ4X1WBsePAVXIGz6rjbkb59AvH0IKyPb7/QYwLVtSG6XeZYcMSmlMWIVzywFSyvvpTAT3vfdcdG6a8XDG3rOu1geawEkDvwdf9STavtusV/Ga0i4CTV7M9/qxx74tLmVPXs=
Received: from BN8PR03CA0022.namprd03.prod.outlook.com (2603:10b6:408:94::35)
 by PH8PR12MB6988.namprd12.prod.outlook.com (2603:10b6:510:1bf::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Tue, 11 Apr
 2023 18:03:55 +0000
Received: from BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:94:cafe::70) by BN8PR03CA0022.outlook.office365.com
 (2603:10b6:408:94::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38 via Frontend
 Transport; Tue, 11 Apr 2023 18:03:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT053.mail.protection.outlook.com (10.13.177.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.29 via Frontend Transport; Tue, 11 Apr 2023 18:03:54 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 11 Apr
 2023 13:03:54 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        <linux-pci@vger.kernel.org>
Subject: [PATCH v3 3/6] PCI/AER: Export cper_print_aer() for use by modules
Date:   Tue, 11 Apr 2023 13:02:59 -0500
Message-ID: <20230411180302.2678736-4-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230411180302.2678736-1-terry.bowman@amd.com>
References: <20230411180302.2678736-1-terry.bowman@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT053:EE_|PH8PR12MB6988:EE_
X-MS-Office365-Filtering-Correlation-Id: 2910ac8b-68a9-4e8f-cbd2-08db3ab71d62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CGxjmd2xup7L9WjX75UTvjxyStC6eQj/aOm4kZYgwr1OTOmWcE18MjVl5AHTA12Rta87jq1BfySovZl6SOsxBx957uvEGaiUvqkw6W8gZZIdzD2NBKx+TBog7v2Yl/W5DVw37cYCYkRrdZf4q3icFbVUsJXIb2fXHwwwycUFW/AvQMiD+2oWt8wUidfZisuOzuSbyPFt1FUyDu17Wy2x40X7Dz+goBhgsQz8poHlI64RBAPeLk9W+9gbh5sYxOUQzWSs90eOmoJDoJ8Cci9uJdxEXCopyjkeZ1yZ8RIla8t/HChgPEGKjNqjfwo7GNSFHv2P3XYi/e67RPVMZXnYcTJkMffXcTawcUeqyRiqzfWfHPLnHZFinNzonNWXN9R5jGxnHxU+kEWL+0t4j43ZtH1VF7aT8VXj2HzUHInF5UUPJ7jxIp0jo8LQ8YVrgWNtET6E0QN1iOVfAnbpQNys4Eruq77K6ojktoOedn/XlxdNkqVOD7MnxaufA2h3GIqcLxyrhh9wXylahlwvzjbG9sgLgkMGWKCIQbvZV8LEPVOZVp4K7tpw4DNjPjyxo47Vwy1hy4uDwNT96qynbSU4FDmzSO7Rid8IrtfLUD14aoYm7ufEKFkDjHrBv9ROBViafM9Wij5NH8fXdYtF10P08GGs+vZ5K9IK7Q04GcqpDUIJwPu/n1t4MD06BY9+dBPMArSAzUpUisx84//8/BijSlPGOYBNKD/JWCIHpt8MmW4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(396003)(136003)(451199021)(40470700004)(46966006)(36840700001)(2906002)(40460700003)(36756003)(54906003)(478600001)(26005)(8936002)(2616005)(4744005)(81166007)(47076005)(356005)(82740400003)(44832011)(16526019)(1076003)(7416002)(86362001)(5660300002)(186003)(40480700001)(336012)(426003)(36860700001)(70586007)(8676002)(70206006)(4326008)(82310400005)(110136005)(7696005)(316002)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 18:03:54.9028
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2910ac8b-68a9-4e8f-cbd2-08db3ab71d62
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6988
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The CXL driver plans to use cper_print_aer() for restricted CXL host
(RCH) logging. cper_print_aer() is not exported and as a result is not
available to the CXL driver or other loadable modules. Export
cper_print_aer() making it available to CXL and other loadable modules.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
Cc: "Oliver O'Halloran" <oohall@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
---
 drivers/pci/pcie/aer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index f6c24ded134c..7a25b62d9e01 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -812,6 +812,7 @@ void cper_print_aer(struct pci_dev *dev, int aer_severity,
 	trace_aer_event(dev_name(&dev->dev), (status & ~mask),
 			aer_severity, tlp_header_valid, &aer->header_log);
 }
+EXPORT_SYMBOL_GPL(cper_print_aer);
 #endif
 
 /**
-- 
2.34.1

