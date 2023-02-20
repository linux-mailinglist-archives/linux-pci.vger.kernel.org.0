Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0646369CED4
	for <lists+linux-pci@lfdr.de>; Mon, 20 Feb 2023 15:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbjBTOG2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Feb 2023 09:06:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232828AbjBTOG1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Feb 2023 09:06:27 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on20628.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eab::628])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0263A1F4B3;
        Mon, 20 Feb 2023 06:06:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fpCDvdi3EWKiQlYBU7e6eVWoYSqo5z6X/ikICn9xllk2uF/JgHtLH1DAlbhexVQtDAUasJJdBR8WQQOmu0fjVntGljLkYBccDPPQbydQ2c+dKB8gLPyqG+KeQqh3KC/a2LzGn4oSy50dcxoiKStvngX+VNPO+dexxobzmIEpJKAdSSbiSlkCydHeYY2wRSMZXnEmZNFocVO1//EDcY0SKVIEBhj1DOD4senXWlfU7RGGZLwo/sYNdI53AteGJjRAUw0JPFy2/S4iXMd7Iql8ukOKZ3gvJkOxwot6dJ8pxX//nCL76tiTZZ+2elGxe3I+fvuv9q/BcJnklPb/cGTMxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ga1UMMLcweiyeFkeXIonoB65uIQJQHJR8iozOl0Gquk=;
 b=nQB99Z74UyqQuvrTkyEsArvepSScQDo3Xh5uvXORQHgAEMrINc7nKiucdJI0mNCsZBpEfXrUhREpZaJfSClhKD7mUZhL45eZn7IZLA4zbNKuILbYm14zHFxumh7+Y/3HYp85NB4w7dCwt/xUwkere/c1AMNWvI4LTV11zThz3OVghIGo6IpGEAf7lyjtZWMts1TrsLmAVe9eNL8zYqjg+Vy+32b9NLMv18ThraVCqrYrMiABodsf7SkVLJrLhx8OTrgwzukWNlFdlMcEQm6gELjF0A+dXyRR5EvdQikvKy6LtzL3Vcx7Gw1vt3QvVv7aVG9j7FXvwNNtA2vTxtPgKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ga1UMMLcweiyeFkeXIonoB65uIQJQHJR8iozOl0Gquk=;
 b=mJ2mJRT0uxoMcYN/r3vHQ8T4PdUdlt6a8V7DkM9WQRLcuSbHwKuzWQ6SavQVg/S7V6pfAMntDA+Mf17JmblPGeTg7FKQR0cTKfS6utRSwyjAy8Ca/yFKuG+tB9V/3WCh8Gi33HgKNgRdXSglr2Lg9ay+z1nNFkg9vKccZM4DTFm633o6fJ0Fo9ugOdqj5DpFqAzbo72PULBiz6sQlzxjW2tjbXjVpukSdOcX3q7ZoLJ+dohDoTqQjanjB3E9XmbfvA7vEQAHeyd1UfCrRVOVDJNp5Yh+vKNqh9qvmR/yJnyMuNZKJLwuPgXSR94v/IwOBEvXMDYnoZD/X5cvT+IoCw==
Received: from DM6PR06CA0055.namprd06.prod.outlook.com (2603:10b6:5:54::32) by
 CH3PR12MB7618.namprd12.prod.outlook.com (2603:10b6:610:14c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.13; Mon, 20 Feb
 2023 14:06:14 +0000
Received: from DM6NAM11FT069.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::c0) by DM6PR06CA0055.outlook.office365.com
 (2603:10b6:5:54::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.20 via Frontend
 Transport; Mon, 20 Feb 2023 14:06:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT069.mail.protection.outlook.com (10.13.173.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6111.19 via Frontend Transport; Mon, 20 Feb 2023 14:06:13 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 20 Feb
 2023 06:06:07 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 20 Feb
 2023 06:06:07 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Mon, 20 Feb 2023 06:06:01 -0800
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
Subject: [Patch v2 0/9] Tegra234 Memory interconnect support 
Date:   Mon, 20 Feb 2023 19:35:50 +0530
Message-ID: <20230220140559.28289-1-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT069:EE_|CH3PR12MB7618:EE_
X-MS-Office365-Filtering-Correlation-Id: 5eaa3d32-4745-4e61-53c3-08db134ba087
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: quXByqUYUWswcpCFIIVSno8E9VHK00KfBE6XwWMaplX7iJ1+ThBaJbCKg81JVyUdie5GRCZgZx8BmAahmHPTq0p8f8quGwLSEYz+tiIG8NzYTZ2F4oNh7JDOYAJCrIb77KMigN46mAN8hwyHBty+V6dFFk5mbZ0IyF8PKP/MDgeqNjAHCO+OaRqFuN0M1j5swL+h0CvCCZwtLr+9OsatXCOysrEknVW4/t+yBxKry5/Mhlflwji84WnNURH8DF1soGWmy438tKT+aF7BY9DYjOkhEkE7MNGop15xhihyMqcXMYPTO6SyEGbjoimboj8NuSQqH2ufuI7uueNe2sTTs8vZfh+Dd5+2L0Nj+Ao1slaBWHGTc54/7VIxU8AR3/3phQzzNeTvy3xAMPirWXKukNwgHicqXbEjXik1DyggVLE0qo7yLvlwfpJev7kwE7n6Y4GBWbFdqvQy1JmMb74HnxUBJFVD5sgIIJoAkn6/AI4yHKG9MhYplfBkG/ZmvzgYCNnA/1KxQE2zTWp1xS5dsSK0bmr99IhCHyE3jwZJFhBHthlmO4G+bFyCSxEMhCr7NIW7388JkzaxxAC+FUCrUT7eiAuz4L9ojUXqe8Cx/habIyIZM0tYubPCDZxv/Q0a+9LHPj20/+IYIxK2pni5vBwd57PbWICAdS9J7W/5gUe9BBmAvnIH/mYFwSRdouhqPJ7LZgKU+wqn1+Z5q4PsalioVIlnWFNVm9YXZuxGWeL1W5CwHjNxIOQZygJ3DQnl
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(39860400002)(376002)(346002)(451199018)(46966006)(36840700001)(40470700004)(4743002)(70586007)(82310400005)(4326008)(40480700001)(36756003)(82740400003)(2906002)(7416002)(110136005)(5660300002)(8936002)(316002)(7696005)(70206006)(478600001)(8676002)(41300700001)(54906003)(1076003)(186003)(26005)(107886003)(966005)(6666004)(356005)(426003)(336012)(2616005)(7636003)(40460700003)(83380400001)(47076005)(86362001)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2023 14:06:13.8193
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eaa3d32-4745-4e61-53c3-08db134ba087
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT069.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7618
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

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

The patch series also adds interconnect support in below client drivers:
1) CPUFREQ driver for scaling bandwidth with CPU frequency. For that,
   added per cluster OPP table which will be used in the CPUFREQ driver
   by requesting the minimum BW respective to the given CPU frequency in
   the OPP table of given cluster.
2) PCIE driver to request BW required for different modes.

---
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

Sumit Gupta (9):
  firmware: tegra: add function to get BPMP data
  memory: tegra: add interconnect support for DRAM scaling in Tegra234
  memory: tegra: add mc clients for Tegra234
  memory: tegra: add software mc clients in Tegra234
  dt-bindings: tegra: add icc ids for dummy MC clients
  arm64: tegra: Add cpu OPP tables and interconnects property
  cpufreq: tegra194: add OPP support and set bandwidth
  memory: tegra: make cpu cluster bw request a multiple of mc channels
  PCI: tegra194: add interconnect support in Tegra234

 arch/arm64/boot/dts/nvidia/tegra234.dtsi   | 276 ++++++++++
 drivers/cpufreq/tegra194-cpufreq.c         | 152 +++++-
 drivers/firmware/tegra/bpmp.c              |  38 ++
 drivers/memory/tegra/mc.c                  |  24 +
 drivers/memory/tegra/mc.h                  |   1 +
 drivers/memory/tegra/tegra186-emc.c        | 117 ++++
 drivers/memory/tegra/tegra234.c            | 593 ++++++++++++++++++++-
 drivers/pci/controller/dwc/pcie-tegra194.c |  40 +-
 include/dt-bindings/memory/tegra234-mc.h   |   5 +
 include/linux/tegra-icc.h                  |  65 +++
 include/soc/tegra/bpmp.h                   |   5 +
 include/soc/tegra/mc.h                     |   6 +
 12 files changed, 1300 insertions(+), 22 deletions(-)
 create mode 100644 include/linux/tegra-icc.h

[1] https://lore.kernel.org/lkml/20221220160240.27494-1-sumitg@nvidia.com/T/

-- 
2.17.1

