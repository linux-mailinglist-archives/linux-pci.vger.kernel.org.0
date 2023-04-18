Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5321D6E6DD4
	for <lists+linux-pci@lfdr.de>; Tue, 18 Apr 2023 23:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbjDRVFp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Apr 2023 17:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjDRVFo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Apr 2023 17:05:44 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B2619748;
        Tue, 18 Apr 2023 14:05:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hfCwmQLNt+sbxZ0TXp5t8tDr6DUllg3LPKbyzZmgIrAED/DRgXgrqVKWI0IgodyBoaXmTxUYufd4ZXSZwzJZli6pKmfA61S6fadoZr0yFPXVEnRl3TDFgyWYm2Qr49LqIqi8sHvFfn999jN6rd8NhIQp7uJkhH7uVKU+mKnFU0MgaJcRWqJsNqHN4eUs0uriZz3md2/uKfawdIXM0V4uSdhfhtxaYi0cSKyCdoP7HOFNyiDFpgbxmNZI1mxTiVFR7kabJf3IODi4eVF/gJLMpxDoN16oUgGQwASOBF6rTB++QAzDBDSgbmIsD3DHecQ7VVc0x5PgAYx0I0D6tYsMbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lxf/pQhQdoRpTOXAYTc5kkcCEPy8yMD+lyPmzHOXnr0=;
 b=k0US6AdxstMUV2FlDmiNa/F8r4yBmzh6+knKwIhr+fXjDHkZKTuJMTSvQg2LYndwK9Jih+cks8jVi5edh5akh5M3QYMCyoOji8EQRAotJnw/I1V9+2GUw4zKcj1uqRrcQmfl9sT4Iplu6LCUuijif3NKqXcll2kWvAj2A2MzhkzgfLlW43cI/BiwVuDjKEeec4HaapNIYV+fgDqGFvocaHjVxYApmXC83CCo8x3KuhB+q7YPvRjy8yKFl00Rx8NZsEWfwp6W8roNtTEZ33aMTslX2GXZA9Vj1RXPwxR+jVQJhBUvYZHz46Z0/cTc3lQ5Gfy/2zEg3KPyL1UXmo+SOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lxf/pQhQdoRpTOXAYTc5kkcCEPy8yMD+lyPmzHOXnr0=;
 b=tzjreaBJ4jctuRv8ZAeMzTfESRJ9ca6yUUV0oFg++TFD9KiptzuxlsUnqRSYtr6kdSXKWALezcPCMmrYGqr6yYYwBKhv39g5wPxdGZJ1407gvWlGNVb9bVzrzAm+mpewZurY1ZZIANJxZjmlsSexOhnHlD6krxVe9QTtP+ULmc8=
Received: from MW4PR04CA0037.namprd04.prod.outlook.com (2603:10b6:303:6a::12)
 by PH7PR12MB6835.namprd12.prod.outlook.com (2603:10b6:510:1b5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Tue, 18 Apr
 2023 21:05:40 +0000
Received: from CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::fd) by MW4PR04CA0037.outlook.office365.com
 (2603:10b6:303:6a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.46 via Frontend
 Transport; Tue, 18 Apr 2023 21:05:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT051.mail.protection.outlook.com (10.13.174.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.20 via Frontend Transport; Tue, 18 Apr 2023 21:05:40 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 18 Apr
 2023 16:05:39 -0500
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>, <oohall@gmail.com>,
        "Mahesh J Salgaonkar" <mahesh@linux.ibm.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Kuppuswamy Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Fontenot Nathan <Nathan.Fontenot@amd.com>,
        "Smita Koralahalli" <Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH v2 0/2] PCI: pciehp: Add support for native AER and DPC handling on async remove
Date:   Tue, 18 Apr 2023 21:05:24 +0000
Message-ID: <20230418210526.36514-1-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT051:EE_|PH7PR12MB6835:EE_
X-MS-Office365-Filtering-Correlation-Id: cbdf47c3-bc58-48a7-3bb7-08db4050aa78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FUFI07b0X4dg1M+CaC+CfB6thJsh5Z3DHAzp56o1dkSLvarxt3J+KX90RoH4UE+m7JLaj5W6KNA/Dt+EdyzZGnlyqMQpooWdLBu+F9sbQew+lXiLrCoWiKgMBZnm8efxNOtE/lwC0sqXt9MqM0OafOavDChFUiWN00YuIDQ6ihDLI8bY/J019QvYL8ME11PRkYdHNmZ71vOXkYJGZ2SZuBQhekVQakWNIxE2zYYOYX7bNgQ+vouO69oEAEbHZ4UzrSf1Um3nwCn7TFQNwJjUs9/ZzyzrKG4bajspAPglX+SO3KNufE/yqISGmpsFhApAXQpvHQPZrLFarra9d9lSRNaAeRNNDjEnkiqNMxoM8m7jCahBfFrkntrCl1j9p1DStVFH0w920+dyUjergHC8aVtmxfT/Z6HCHBkIyt6V7Lf7z15oM0C6DsoajzZdcAGupar2VJcwY8pYSU5AQVTMD2p6UBV5oekg9Fmj/AH3n8qmPXMpJ8nQ3XMUJjkVaHh5Idv5NPgYMIJqoDbc+dyv7sON0P18I0mPT92yCsZxRTzlKV9YvJCGloYnXV+84NNWWnADhL8t4DR1xiXo7BwtZkM3yQQCA0hiLvWD+4+ZGjGUZAngReQAyPUf1t2VdhMyn7lafFOjmYtip+Xv2cRl7TP3M9wvLfzYs4abfklJkUojzN2JhCubKhHdLumH0FStA6Ff5ldQj5aclKAwzj+H2iKxhYowFoFxZ6eVn+9um84=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(136003)(396003)(376002)(451199021)(40470700004)(36840700001)(46966006)(5660300002)(966005)(4744005)(7696005)(40460700003)(2906002)(4326008)(70206006)(70586007)(36756003)(86362001)(81166007)(8936002)(41300700001)(6666004)(478600001)(82740400003)(356005)(316002)(8676002)(82310400005)(40480700001)(54906003)(110136005)(1076003)(26005)(336012)(426003)(36860700001)(2616005)(16526019)(47076005)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2023 21:05:40.2906
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbdf47c3-bc58-48a7-3bb7-08db4050aa78
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6835
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series of patches adds native support to handle AER and DPC/EDR events
occurred as a side-effect on an async remove.

Link to v1:
https://lore.kernel.org/all/20221101000719.36828-1-Smita.KoralahalliChannabasappa@amd.com/

Smita Koralahalli (2):
  PCI: pciehp: Add support for async hotplug with native AER and DPC/EDR
  PCI: pciehp: Clear the optional capabilities in DEVCTL2 on a hot-plug

 drivers/pci/hotplug/pciehp_pci.c |  1 +
 drivers/pci/pcie/dpc.c           | 50 ++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

-- 
2.17.1

