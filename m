Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15B36786401
	for <lists+linux-pci@lfdr.de>; Thu, 24 Aug 2023 01:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238553AbjHWXnm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Aug 2023 19:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbjHWXnX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Aug 2023 19:43:23 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2050.outbound.protection.outlook.com [40.107.100.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2067710CA;
        Wed, 23 Aug 2023 16:43:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EiCS525cqKxDxO//7zf1orOBqCI1LXxOYvPP9QUlfdaBM7clRQdytFc/aWc0foIW4XyUG+H23kipaQilysqtcEVgNAd1mTNXa7uwgMTAQS2yzuH+mGopxl++OO05lNBTo5J4mTlcWVXzIWqzoOwOE8XCufmOCQ9PQxSuPTtugLrrG9y7I0jA3haEWoov5XXMwc2JiVCNwMiogfs1b2AQzyqVLo9dmKvWpvI0TQgcQofbb4/DS96MfFvYP75SgmT+2DL84HoZiPmkPQn1myZkSszCyoXo6BxpJ+t4RluihDZZdGTPDrtcHrNWsVjfCQbLZ2lqAprKO9axp+pYlH/VBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=641DbmTm3KLt3NEeDq/Xm42pfHAFTS5YSw4UG45sHmk=;
 b=krjJDHChg4sNbky1nMFxK4nMxxrap3RoBAkVGrNS/qzvqHDYl7k4m5mbzzDhDIBgU7kNzIUFMT3hUG7vmvv9S8gDGyl/TUyHW1q7Z91mY8r/kd8l4mW4wUphlWi8jMVbuak3rPR5Ad/yNf9J5W13mzuogONbGTact3xihSleii1tsg2xj9vq6y6yZ7295vEZaymIWzkx0vir9vW6ECepAWRBGBMl8ytT2lR+jFOnQ9s/8iSYlW6IBJpE4iCOeOn9L96ZpbCy23qbE17+Q+K0fjpQ7AgdUyDexc7aZGWFlRR4HT+/SeKwQm4a0iAecqMMlA9yh0dznfCls6ew9yLaBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=641DbmTm3KLt3NEeDq/Xm42pfHAFTS5YSw4UG45sHmk=;
 b=C/yGwkRkxcgOB7818WzC1bVpo8cnKWVNNH5BGl2A3/cwEbirXAZU8F7blJprSFGdw1golF3p4re4PMnR9Uis99MqkYqOz4oPbNYXx1k8A6rBlD0hf8LgvMnW67e/64IQ2EU6X05VdjHjWoksVOqiYs9U6M88b2BzRz3en3XtU4w=
Received: from CYXPR02CA0086.namprd02.prod.outlook.com (2603:10b6:930:ce::23)
 by LV3PR12MB9143.namprd12.prod.outlook.com (2603:10b6:408:19e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Wed, 23 Aug
 2023 23:43:18 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:930:ce:cafe::25) by CYXPR02CA0086.outlook.office365.com
 (2603:10b6:930:ce::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27 via Frontend
 Transport; Wed, 23 Aug 2023 23:43:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.78) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Wed, 23 Aug 2023 23:43:18 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 18:43:17 -0500
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-cxl@vger.kernel.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>, <oohall@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Alison Schofield <alison.schofield@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Terry Bowman <terry.bowman@amd.com>,
        Robert Richter <rrichter@amd.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH v4 0/3] PCI/AER, CXL: Fix appropriate _OSC check for CXL RAS Cap
Date:   Wed, 23 Aug 2023 23:43:02 +0000
Message-ID: <20230823234305.27333-1-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|LV3PR12MB9143:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a166060-e4be-4517-2824-08dba432ba6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ewZL7ItUfZVdmxMfPgBzAltwfSQBfBgRpy+L3lcgqyMZoqF/+krwyFUTDIF3s31J0twWjGh3kZTs0v71mJuAJDqrYJgsCZwplbB6aqktCxqWxKiNcWHR0e5PPOWHoP+T+rEMWd8tVjCdhTIloWNwa4JwnPSonkxDkm4xaOcDGRTS/L+GPl4n4XRG/d/baysnoXKJpU74P7mGQA5eph3mD91fVMLO82+bViEjYs39M+l2WIFK3WQ5mdPWpKzfuX1CknOnNOtGnDYnFDafnZQlJjR1dUcbMiItf/fwkKU8Eq6vKWVnsyBtPgYjtRTb1Ch0MP+3uzBDISu5NfP3vD3HggbHV3xsQ4FqLrIioUgtBYOmV/WSdP7q9m7VBim6nN7UhVlD0nxNqV1Fp+Cj/uk5urepoEQawIYGCjAYUkvsjQ4lpbbok63t/WHPJSnTOKJlH4F20Ft56D1SotK3wblhr2jOWGzUWQd7mtNwAkGPGHMR8uWZ/f6Znl5sF+h8Hf5+lo/xmJM62OkSl3X42cHH0HrXisjQXn45JuFrjdHZ1HE9gS9YvxAmbiztuNhUTIQpPLxzjm5/crO+uIxT8YT5dhHRKp9+C92sDvPGqOJobxdrQw+d0G2AYyV7lSJmTzwn7LQ4YMF4nsFD0XD4e4ZtV4V2V5ONSTCyTO/tara597A3IYJ+DPSZkwtCQzYkp7I+FJGdEgKe/67Ft7o6BOBUC9e4S82e+VuM/i8ijQmmJAvyU6MJ+mu43JdRkIsXvnUg
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(39860400002)(376002)(346002)(186009)(1800799009)(451199024)(82310400011)(46966006)(36840700001)(40470700004)(54906003)(70586007)(316002)(70206006)(110136005)(8676002)(8936002)(2616005)(966005)(4326008)(36756003)(40460700003)(41300700001)(1076003)(356005)(82740400003)(81166007)(478600001)(6666004)(40480700001)(83380400001)(7416002)(4744005)(2906002)(47076005)(7696005)(36860700001)(86362001)(426003)(336012)(5660300002)(16526019)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 23:43:18.5064
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a166060-e4be-4517-2824-08dba432ba6e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9143
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series of patches fixes the appropriate _OSC check for CXL RAS
registers.

First patch addresses the _OSC check.

Second patch moves around pcie_aer_is_native() function declaration to a
common location to be used by cxl/pci module and third patch reuses
pcie_aer_is_native() in cxl/pci module.

Link to v3:
https://lore.kernel.org/all/20230803230129.127590-1-Smita.KoralahalliChannabasappa@amd.com

Smita Koralahalli (3):
  cxl/pci: Fix appropriate checking for _OSC while handling CXL RAS
    registers
  PCI/AER: Export pcie_aer_is_native()
  cxl/pci: Replace host_bridge->native_aer with pcie_aer_is_native()

 drivers/cxl/pci.c          | 7 +++----
 drivers/pci/pcie/aer.c     | 1 +
 drivers/pci/pcie/portdrv.h | 2 --
 include/linux/aer.h        | 2 ++
 4 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.17.1

