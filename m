Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 304EB6FF86E
	for <lists+linux-pci@lfdr.de>; Thu, 11 May 2023 19:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238759AbjEKRcm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 May 2023 13:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238516AbjEKRcl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 May 2023 13:32:41 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2074.outbound.protection.outlook.com [40.107.95.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261C03A90;
        Thu, 11 May 2023 10:32:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MwRYyQv3X6JySs0j5WbvSos/iQBa1ia+QVt4fgy9Nt8CC4jDGx+GMcvX+6L9e3LXQfGshceHg5gBF7uldNc1v32SMs1Ke+VEjBdC63YCWywxp1u3tDDeM7hkHI+mLdBVwLV6Hdz3N399ovdD9lI4PMn/D3owezyxWk41mcHuHte2HEUditl+ZlDLDADt7JUy8p5Q/NnzQDHmPJ7OScs83OG+B/qhOUl4aH7XkCObG+4hF4xnqR+LtwmfZzyfQN++COTW6x8SDPoGi9bOGbK/42PNrb4ukaCxbEhOXdk8yKBMHjk12KrTylq3WtdjRrh/Cm1V9iQa3edtf7okX0/bUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a7qIiuuzyhgbheJ34U4LYNL2JtwX+92lrpDqq3PBOvE=;
 b=D5JE/idJbPFHDAYPGY25XjMOWz1ExpjsozcnX968PHSOc4PCYIodYAToR73eyphwa1QOzVGpWYaxN+VEd7eIXHxUcoXLfQsCTR7cdkiiWKHKtKqZq/kHNnvbhFXMIQuTUpfr0Xk/DJ+Ul/Ta9DMNwm0HMWgYwRdd7qxEb0tZji96BmiCWe94MYilhAMI4OU1aWTLk67fEchTH3LjdfKS7Yj34B+PKcyLpkoqowC/hs8FYWXLN54U561s1u8q7G15hkvDlVFoUWTxTfSwEIsy6WjBmepXBQGo5zBcCr8UEm9SeieiuCjGh6dXDtu/ltt47pAAkIegFrlWIL4S7m0+rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a7qIiuuzyhgbheJ34U4LYNL2JtwX+92lrpDqq3PBOvE=;
 b=IbZKJ/ZA9rIa2yvB4Xssn7oNazfWp6HgP0aBw9EOrq76EeVctXGSNAW/2NeMF50TQD1ExDAdZqkutDv5WDvWLare7CU/Mo1Z6w518jmw7E30oZUxYgcAgaV9dwccMHCA2UPMqszdHbQhgejxorq6WCUZ8yPQ3p+aGTMHkD6GaK+Abv2/GwNNv/4+o9P6CfftlnZJrUrDTK+lY+6gDPUVU04AOgwsfWKORth/+Wb1tn8u2YS21/ZNQTKtMvwBh13M1Zom2ZYvw1VK/YxYSREY9kGX/kwvVI/Gxcnr2rg5JAZhApgtNsxFCJrDaJqH55pgX8ObRRcH86S0zsPe8MEXXw==
Received: from BN9PR03CA0781.namprd03.prod.outlook.com (2603:10b6:408:13f::6)
 by MW4PR12MB6998.namprd12.prod.outlook.com (2603:10b6:303:20a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Thu, 11 May
 2023 17:32:38 +0000
Received: from BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13f:cafe::57) by BN9PR03CA0781.outlook.office365.com
 (2603:10b6:408:13f::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.22 via Frontend
 Transport; Thu, 11 May 2023 17:32:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN8NAM11FT011.mail.protection.outlook.com (10.13.176.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.22 via Frontend Transport; Thu, 11 May 2023 17:32:37 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 11 May 2023
 10:32:23 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 11 May 2023 10:32:23 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 11 May 2023 10:32:17 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <treding@nvidia.com>, <krzysztof.kozlowski@linaro.org>,
        <dmitry.osipenko@collabora.com>, <viresh.kumar@linaro.org>,
        <rafael@kernel.org>, <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
        <lpieralisi@kernel.org>, <helgaas@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <mmaddireddy@nvidia.com>,
        <kw@linux.com>, <bhelgaas@google.com>, <vidyas@nvidia.com>,
        <sanjayc@nvidia.com>, <ksitaraman@nvidia.com>, <ishah@nvidia.com>,
        <bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [Patch v8 0/8] Tegra234 Memory interconnect support
Date:   Thu, 11 May 2023 23:02:03 +0530
Message-ID: <20230511173211.9127-1-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT011:EE_|MW4PR12MB6998:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ff4cb52-7633-4a43-df64-08db5245b6dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SNuMFL0k5I4iUMsuwJ3nCfx+F/HzhziMhKF1AobdJqLUxQ5H84c0+wIeyxXtJBSn5cIM0L4CDZxiHQDcH3lz+7CzKzUedJ4Ae0FuDGs9DsQ/OfE76vO/bhxz16bKvWAkHh019WMWI4le37mPRwdNVBdPYHVCZvUSiynBQUm9VjpkGqAUOtPkOEiEOKNtxS1zz72A29GXHZ/Ow7sYpIZILpBf1TD24gUUOF5fcT+JJ0RARtNBiBK3uTH7tP1cVMVI5AN9DH4siWjKnVc2Ck9mLSTPna64esIlLNw9/tAJ1BXHJ0TUXObZFo3SbmnzaxCHz2uhShCTOV8n2FgtGSqv3v+hM2f6ssZJ2wAq+2QmV+xTgaKpx6GAIeZBnJzYYIYHTeIgKr7ZRlZl1ByLHaflMIR6pCoyHJ7rnQzvHLLiz3kvPa+ocYkescchByUgVwORFocgDFOpbNV/UDu3jF5bUU0K0xXOnfrBsCJ3l70o+eYJm3mAbjhT91EvBH4l3yq+gz/NamSXfCb1/Agl3fzk79/rwoJ171W65PcgV0FIp9RtArcw3bhMXEmDLoqd7IWI1B4rDCciA0fN2mUVeSB8YZVKF0JH0aCHyWj98eSjEqLDVfIig4xCgq9r27ew0ckq/Mg9XV3e8cDHyBGdreQdZQzjr8vJqyve0bzBsQ54dYN7PE8PU+PnR7dfZmriT8EAGWORW8oRU0DDfTGt5TNwENEDBbCdtHdK+BX3OyI37vyzQeG6U86NsvO9Ibc9VnAPqRLPSWLIzpl5EineVOcsflmE6+BURIScdQPZQSkUnCc=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(346002)(136003)(451199021)(40470700004)(46966006)(36840700001)(107886003)(1076003)(26005)(40480700001)(47076005)(966005)(36756003)(336012)(2616005)(36860700001)(426003)(86362001)(82310400005)(83380400001)(186003)(356005)(7696005)(82740400003)(40460700003)(7636003)(7416002)(110136005)(54906003)(8676002)(41300700001)(316002)(8936002)(478600001)(4326008)(70206006)(5660300002)(2906002)(6666004)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 17:32:37.5241
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ff4cb52-7633-4a43-df64-08db5245b6dd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6998
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi All,

Have incorporated the suggestions in v7. Only changed 'patch 1' in v7
to fix possible race when setting 'mc->bpmp' as pointed by Krzysztof.
Requesting to merge the patch series.

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
v7[7] -> v8:
- fixed possible race and compiler re-ordering when setting 'mc->bpmp'.

v6[6] -> v7:
- removed 'Patch 6' from v6 as it has been applied in next by 'Viresh'.
- changed commit message of PCI patches as suggested by 'Lorenzo'.
- added ACK from 'Lorenzo' in both PCI patches.

v5[5] -> v6:
- split PCI patch into two 'patch 7 & 8' as suggested by 'Lorenzo'.
- added more info into the commit description of PCI patches.

v4[4] -> v5:
- dropped 'patch 1 & 2' from v4 which added "nvidia,bpmp" in MC node.
- save BPMP ref from EMC node into 'mc->bpmp' and use it in MC driver.
- added check for array bounds violation in pci suggested by Bjorn.
- moved DT patch having OPP table to the last 'Patch 8'.
- did multiple small changes and cleanup suggested by Krzysztof in v4.

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

Sumit Gupta (8):
  memory: tegra: add interconnect support for DRAM scaling in Tegra234
  memory: tegra: add mc clients for Tegra234
  memory: tegra: add software mc clients in Tegra234
  dt-bindings: tegra: add icc ids for dummy MC clients
  memory: tegra: make cpu cluster bw request a multiple of mc channels
  PCI: tegra194: Fix possible array out of bounds access
  PCI: tegra194: Add interconnect support in Tegra234
  arm64: tegra: Add cpu OPP tables and interconnects property

 arch/arm64/boot/dts/nvidia/tegra234.dtsi   | 276 ++++++++++
 drivers/memory/tegra/mc.c                  |  24 +
 drivers/memory/tegra/mc.h                  |   1 +
 drivers/memory/tegra/tegra186-emc.c        | 133 +++++
 drivers/memory/tegra/tegra234.c            | 595 ++++++++++++++++++++-
 drivers/pci/controller/dwc/pcie-tegra194.c |  44 +-
 include/dt-bindings/memory/tegra234-mc.h   |   5 +
 include/linux/tegra-icc.h                  |  65 +++
 include/soc/tegra/mc.h                     |   8 +
 9 files changed, 1142 insertions(+), 9 deletions(-)
 create mode 100644 include/linux/tegra-icc.h

[1] https://lore.kernel.org/lkml/20221220160240.27494-1-sumitg@nvidia.com/
[2] https://lore.kernel.org/lkml/20230220140559.28289-1-sumitg@nvidia.com/
[3] https://lore.kernel.org/lkml/20230320182441.11904-1-sumitg@nvidia.com/
[4] https://lore.kernel.org/lkml/20230327161426.32639-1-sumitg@nvidia.com/
[5] https://lore.kernel.org/lkml/20230330133354.714-1-sumitg@nvidia.com/
[6] https://lore.kernel.org/lkml/20230411110002.19824-1-sumitg@nvidia.com/
[7] https://lore.kernel.org/lkml/20230424131337.20151-1-sumitg@nvidia.com/ 

-- 
2.17.1

