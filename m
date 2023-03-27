Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 262CE6CAA1C
	for <lists+linux-pci@lfdr.de>; Mon, 27 Mar 2023 18:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232866AbjC0QOu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Mar 2023 12:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231904AbjC0QOt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Mar 2023 12:14:49 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on20606.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e83::606])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5A0CF;
        Mon, 27 Mar 2023 09:14:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ifj0JHh0RMEtucjUAVBEWUOqHPAk7uCLtPJWdVyx0V4E0yEEATmEeCo7A78wAdoUGdzFLUI57AUFcnk07PpHdjKGAEdX/erdgKvDMucg7FCzRc4hYpTdrzT9TEWf1nVOpOhTee7rXOT/TGat0WPY+0mw1pZa4ufPC5NP/BHZRgnTiJrW3yanlRwF+0wias0W8KfjtDKji6CPcfpPdrO+i5n4Q4mWrHYKUaVcwui9Ci/1QV/NHYM+/XuHQEiMM6jV/K+fEecHSPSJolfZJn0Wi75ao2MOYhI2mbRww1gRMWrlBEzYPaaT7PkLVKPkwy+H0RxkxqQNI/qSqF6SyNnk/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kemZZQbKUyuUCwM56tmDFxeGoyDJ0qMtdp49LBK20HU=;
 b=E/Ax+CJQW46VS9JO21pWgSyrT1qQ40DYywI7U0II/jXUdyEI+RZ5XdesbFFEfLus+eLB9J2jEvfP71Un4xzxnCIVXICqLo44eLd7DAy/awjmkG/tPiimquc6iOXIvlG3AlTKQo/SklmwBQ0AmG+Nh90yfuETKD3DneF5nGMjqEFzoyp5vn9wM7VUHWOCD2RMJvFY2BKhBNuv2URDxB1VuyPilWVxWShcnmvHPwoK+8pKIx801sFO6S62QxwXujYPL1LpK7xqrfsKVBnbY0jk3JxeHLW+HPx4tRGqk+92TfXmIwvUnBQ749YvxD8pRBwSiv246QBho7SIvJ4Jl6JiWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kemZZQbKUyuUCwM56tmDFxeGoyDJ0qMtdp49LBK20HU=;
 b=Ba4GWW/Cnq9OYYTMqWAbG4TnVaIwz/qDM9yfseAJN9Q+7905iSguDOeGzG4xo6rinElO51kCARajko9EUYtc89lPC4kkybimVxv62Vci6Cvp5II0eJUrDw54YI0b4z7sDVwBPoQmlORIXBvqjo7tnHRlcpHG453D8h+N7CTkoITn8RnuPOzJdYCV+1z4lC2C1JGqazfl6I4w7YqYHAtZDV5YyrWI12KUNA8DssxOiVKkMNAGczITNRjLM7s/uZIaT28s8Rhf4q20fofTX7n8xEjzge3aN0tJvBwzLc7wugMikCMmuY9n4/9/Og01d0kAA8tJMAO9crsXcYIZWd6NRg==
Received: from CY5PR19CA0071.namprd19.prod.outlook.com (2603:10b6:930:69::17)
 by MN0PR12MB5932.namprd12.prod.outlook.com (2603:10b6:208:37f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Mon, 27 Mar
 2023 16:14:44 +0000
Received: from CY4PEPF0000C97A.namprd02.prod.outlook.com
 (2603:10b6:930:69:cafe::6d) by CY5PR19CA0071.outlook.office365.com
 (2603:10b6:930:69::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.42 via Frontend
 Transport; Mon, 27 Mar 2023 16:14:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000C97A.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.30 via Frontend Transport; Mon, 27 Mar 2023 16:14:44 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 27 Mar 2023
 09:14:34 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 27 Mar 2023 09:14:33 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.5 via Frontend
 Transport; Mon, 27 Mar 2023 09:14:28 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <treding@nvidia.com>, <krzysztof.kozlowski@linaro.org>,
        <dmitry.osipenko@collabora.com>, <viresh.kumar@linaro.org>,
        <rafael@kernel.org>, <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
        <lpieralisi@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <mmaddireddy@nvidia.com>,
        <kw@linux.com>, <bhelgaas@google.com>, <vidyas@nvidia.com>,
        <sanjayc@nvidia.com>, <ksitaraman@nvidia.com>, <ishah@nvidia.com>,
        <bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [Patch v4 00/10] Tegra234 Memory interconnect support
Date:   Mon, 27 Mar 2023 21:44:16 +0530
Message-ID: <20230327161426.32639-1-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C97A:EE_|MN0PR12MB5932:EE_
X-MS-Office365-Filtering-Correlation-Id: 64e303db-1793-4ecb-9215-08db2ede60aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pdk/k1F0MtAGYUm07R+S8qwLfTyGR+Wsgny6uPSbG3wj2bTrmg03KXLCD4sumsJ3kWMCo9nRy6xhCvWzxoIqSc9gk8ioSfhou7qYsWBBqzAFlLqK0uhp5bZfaZ9bK0EZe/4U9H7yGafCTvhIBDyguz6t9ymB8wRJ2A/+P2u2AnMY13vdAtetJAnHjlPHqrPp0lICTsGWViXNZuEEg/ivEXPONRRhoGUFuwh1CJHBzG2IUxikRVzCBllILCqE7oUluw/6nwyy5SwjxTtOhXcP1Ppg48Gn+mRFxDj8phNGTX0+u4xR5F29XyQfhZT/Oy/wbn3zcf24L3Hgrxd5EW5kfGkifq9oPibN1EUQvhkXfNJq1/R13u57M5r/7jECPweD0BCksLplBthBErH+t9kJvEQiavKeyggEe9r4M5+uXVfQSHZGgqLoqszD4g6chrq0cRlBT6U8cvO5ZSdz6qTN/wDKgxPRw6ib5EIhVaalrR7aM3RoRD81fKI/9yxHjU6/0asIDjCbc91j/gm7nWlYGkXI2gOfnHBagVFC7g5uX0VxjfZV3DkXjvXJl2srQXHJJH6CZnxMT4AnFkSLFCrDH8TjePiHca+rYpvoah8pSQrk1rHQrHm3tToUrtTrfN8+f7Ew3cpYqEHZ4CnL3cBdHM9SAHFwZzpZ7Y9x20qEXJt0sjwMZgcU5jsEnzA/ZIlKTEURRtct8jxklzj9n8A+WUvFMtxzvEC/MimLXFj6Q/qSJK9EW0ns/hrHxIe67moEa1gk/ANcv+og6Fbzio04MsXSSp0CElQMDZIBIybRY5LXXkbR/KXxeR98K+8iOMsRBm9TUAGpsnKc3k8Su571tw==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(396003)(376002)(451199021)(46966006)(36840700001)(40470700004)(336012)(8936002)(426003)(7636003)(82740400003)(36860700001)(316002)(41300700001)(54906003)(110136005)(2906002)(356005)(5660300002)(7416002)(4326008)(478600001)(70206006)(2616005)(8676002)(70586007)(7696005)(47076005)(40460700003)(86362001)(966005)(40480700001)(107886003)(82310400005)(83380400001)(6666004)(186003)(26005)(36756003)(1076003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 16:14:44.1372
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64e303db-1793-4ecb-9215-08db2ede60aa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C97A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5932
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi All,

Thank you for the review. Have incorporated the changes suggested in v3.
Requesting for ACK on the remaining patches if all fine.

The patches are divided into below groups:

- Patch [10]  : Memory Interconnect support in PCI (MC client)
  -- Need ACK.

- Patch [4-9]: Memory Interconnect support in CPUFREQ (MC client)
  -- 'Patch 5, 6 & 9' have ACK provided in v3 from Krzysztof.
  -- 'Patch 7 & 8' need ACK. 

- Patch [3-4]: Memory Interconnect base support
  -- 'Patch 4' has ACK provided in v3 from Krzysztof.
  -- 'Patch 3' removed ACK from Krzysztof as did suggested changes.

- Patch [1-2]: DT binding patch
  -- So, need ACK on 'Patch 1,2 & 3'.

Both the Memory Controller (MC) client patches are dependent on the 
'Patch [1-4]'.

Thank you,
Sumit Gupta
============

This patch series adds memory interconnect support for Tegra234 SoC.
It is used to dynamically scale DRAM Frequency as per the bandwidth
requests from different Memory Controller (MC) clients.
MC Clients use ICC Framework's icc_set_bw() api to dynamically request
for the DRAM bandwidth (BW). As per path, the request will be routed
from MC to the EMC driver. MC driver passes the request info like the
Client ID, type, and frequency request info to the BPMP-FW which will
set the final DRAM freq considering all exisiting requests.

MC and EMC are the ICC providers. Nodes in path for a request will be:
     Client[1-n] -> MC -> EMC -> EMEM/DRAM

The patch series also adds interconnect support in below clients:
1) CPUFREQ driver for scaling bandwidth with CPU frequency. For that,
   add per cluster OPP table which will be used in the CPUFREQ driver
   by requesting the minimum BW respective to the given CPU frequency
   in the OPP table of it's cluster.
2) PCIE driver to request BW required for different modes.

---
v3[3] -> v4:
- dropped 'patch 1' from v3 which returns 'struct tegra_bpmp *'.
- added 'patch 1 & 2' to get bpmp ref using 'nvidia,bpmp' property.
- dropped 'patch 10 & 11' from v3 and added those changes in 'patch 3'.
- added static to prototype of 'tegra_cpufreq_init_cpufreq_table()' to
  fix the warning reported by 'kernel test robot'.

v2[2] -> v3:
- in 'patch 7', set 'icc_dram_bw_scaling' to false if set_opp call failed
  to avoid flooding of uart with 'Failed to set bw' messages.
- added 'patch 10' to handle if the bpmp-fw is old and not support bwmgr mrq.
- added 'patch 11' to fix interconnect registration in tegra186-emc.
  ref patch link in linux next:
  [https://lore.kernel.org/all/20230306075651.2449-21-johan+linaro@kernel.org/]

v1[1] -> v2:
- moved BW setting to tegra234_mc_icc_set() from EMC driver.
- moved sw clients to the 'tegra_mc_clients' table.
- point 'node->data' to the entry within 'tegra_mc_clients'.
- removed 'struct tegra_icc_node' and get client info using 'node->data'.
- changed error handling in and around tegra_emc_interconnect_init().
- moved 'tegra-icc.h' from 'include/soc/tegra' to 'include/linux'.
- added interconnect support to PCIE driver in 'Patch 9'.
- merged 'Patch 9 & 10' from [1] to get num_channels and use.
- merged 'Patch 2 & 3' from [1] to add ISO and NISO clients.
- added 'Acked-by' of Krzysztof from 'Patch 05/10' of [1].
- Removed 'Patch 7' from [1] as that is merged now.

Sumit Gupta (10):
  dt-bindings: memory: tegra: add bpmp ref in tegra234-mc node
  arm64: tegra: add bpmp ref in tegra234-mc node
  memory: tegra: add interconnect support for DRAM scaling in Tegra234
  memory: tegra: add mc clients for Tegra234
  memory: tegra: add software mc clients in Tegra234
  dt-bindings: tegra: add icc ids for dummy MC clients
  arm64: tegra: Add cpu OPP tables and interconnects property
  cpufreq: tegra194: add OPP support and set bandwidth
  memory: tegra: make cpu cluster bw request a multiple of mc channels
  PCI: tegra194: add interconnect support in Tegra234

 .../nvidia,tegra186-mc.yaml                   |   7 +
 arch/arm64/boot/dts/nvidia/tegra234.dtsi      | 278 ++++++++
 drivers/cpufreq/tegra194-cpufreq.c            | 156 ++++-
 drivers/memory/tegra/mc.c                     |  24 +
 drivers/memory/tegra/mc.h                     |   1 +
 drivers/memory/tegra/tegra186-emc.c           | 125 ++++
 drivers/memory/tegra/tegra186.c               |   3 +
 drivers/memory/tegra/tegra234.c               | 600 +++++++++++++++++-
 drivers/pci/controller/dwc/pcie-tegra194.c    |  40 +-
 include/dt-bindings/memory/tegra234-mc.h      |   5 +
 include/linux/tegra-icc.h                     |  65 ++
 include/soc/tegra/mc.h                        |   8 +
 12 files changed, 1290 insertions(+), 22 deletions(-)
 create mode 100644 include/linux/tegra-icc.h

[1] https://lore.kernel.org/lkml/20221220160240.27494-1-sumitg@nvidia.com/T/
[2] https://lore.kernel.org/linux-tegra/20230220140559.28289-1-sumitg@nvidia.com/
[3] https://lore.kernel.org/lkml/20230320182441.11904-3-sumitg@nvidia.com/T/

-- 
2.17.1

