Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60A196DD881
	for <lists+linux-pci@lfdr.de>; Tue, 11 Apr 2023 13:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjDKLAa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Apr 2023 07:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjDKLA3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Apr 2023 07:00:29 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472F5E5F;
        Tue, 11 Apr 2023 04:00:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=THTDYluI39YHf0kmT/nVHakPJws1HdGKeHjgriLmIC/9tkDTc6wpUHuN8vhCL07xSI7HAhl4T7GXKRdn88SxHCFgLxo2/iRU8B1VTiUqWAVWTuWz488WnJzQ3zYmkUFPB6NfpcfpTPPtSVmXATxomQwElsEaeF4hxq9oa6PH/zeFbx9o9o/5f2prV3tx5A2dHIDtrb+Y8gE93zo03m9a3HlHhpIHc/RMsCWi44CUCDMHT0Tv9QntVV35EOsz3unZnl//zrxoLX3TvJvswkOuqsnUUPot9/6ict/a/8oqFnQ9J/uXMwLH4hlgScHoSnm4Ack52uvo5ZfKMivcan70lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hby8+zsrT47mRrzo1v1pxKNpAKQT+cRxNB3zMFEpyVM=;
 b=AmpEBBIW+vUil4QMCMYtVbW41eYWqKUG5iNoSJw7YPoE6748Z4eOitzGXJNE9yh1Z5BtvDbGohAj4qeQsqI2qvGZX9rK2HuK4ZXQNPmtOV4glUPuAgjan3fJFku0DL4dIhQlE3OOzNqL7l3KhVMpKVfNYTfqSnZLm3k/A6x87eFNlBvA9J7Hwn9jUWnyp/zAfnangsRmJkFHi/UtOfGNyHsKPkHjATzoVR2KH8JQhJm3RTGIdA/z0siOqTDXxvThcbd8RJYWONbJdhGOyAi3kAK28TzhMsEYoGmA8t6zSDt4UU+6D4VVSvYcB3cXuTssm4VstdCz9aDuMUzKAKZ6ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hby8+zsrT47mRrzo1v1pxKNpAKQT+cRxNB3zMFEpyVM=;
 b=rIzfCs29i0kODVCx3HxTixrxUoKUlPw2OyGvwr6HZGC+vdJtGQ67qnz8Edvq2I2ElHlxONgrRrUnLNyHiQS4nLW5jvF4t7i/aTfiRpQihqMpIohsJgsfv1dw8Pudb8aTTkVDHTF6lDKYKp3IdRmTaNJg+dgwZ2CBtvPyjjOoZCnzaitR7ki+Ttdzt0bImEPjsfVl6DaRKA8FMHoL9n3Ejrcok2OPSmyeV/R+BaU7wc8D8eBowzxJQlZpHImKRzE5ADyvCjbffqh6gj0A8p4XoyxzAB6NAaEexBTQ6HWG7lGN0OnU+FNHqEPu1ANAHJW8dgTm0+25Ygn6CzA1DSuaSA==
Received: from BN9PR03CA0691.namprd03.prod.outlook.com (2603:10b6:408:ef::6)
 by DM8PR12MB5430.namprd12.prod.outlook.com (2603:10b6:8:28::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6277.34; Tue, 11 Apr 2023 11:00:25 +0000
Received: from BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ef:cafe::c1) by BN9PR03CA0691.outlook.office365.com
 (2603:10b6:408:ef::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38 via Frontend
 Transport; Tue, 11 Apr 2023 11:00:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT038.mail.protection.outlook.com (10.13.176.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.28 via Frontend Transport; Tue, 11 Apr 2023 11:00:25 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 11 Apr 2023
 04:00:12 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 11 Apr
 2023 04:00:11 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Tue, 11 Apr 2023 04:00:05 -0700
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
Subject: [Patch v6 0/9] Tegra234 Memory interconnect support
Date:   Tue, 11 Apr 2023 16:29:53 +0530
Message-ID: <20230411110002.19824-1-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT038:EE_|DM8PR12MB5430:EE_
X-MS-Office365-Filtering-Correlation-Id: e61fad76-16ca-4541-e58d-08db3a7bf42d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F0VFQLJ3sotOG0U7+gKbGsh9uBh2HZeAb4WWAuPccs9liapc+t5UIIljeDztZ2LtTSE9ORSQM7ziMB33Op344+N9wjtnkE0+UaZQIYer9bKZ5TlZHTwOy3fio7y4sfdvmBR1ajD2CkN5UNU75oucUeS2/+s501uNX28egc/4j10hLJR374Ez6dX90N4ITbuie4X63Ve/eBRficJuKQnbFcTH+Hp/WzR7U2ChLVHIkbnD+XJOT4K7lFyQVtK/5Ogu9NEkJVOCV4JrUp7u5iWZ7H0VZ39ZSVKssfAfg7c1KolHZo/UTFqjPlO+Rd0PPMUjlRnh9RQb3oL3fQl+Rp4xqP3vBG21RMQdjHt9sqZTyLtHKuEaLLdP4D+Fn43yn/fA5cW8VuGUoGc7AtmrKZE/lDGTPNNIH4LMReswSR6jrUaZ8LsimOtcfkG9juTDnfG/TTvMNlox+PJXb1o58l4xT8JbrvD3bxYH8wXMsRF+P9a3+HAiNyCK94fY0iwOI197vmZHY2IENQvIwB71XhmRCZA0bJFu8g/BJOZ9lrdnfbVfWM46G+rgekTVvKr/J8A8lnRzPwLIJ+Hp9QKjzY7PJZfnoutS/5kXbZgLuMeIsYOqTYhpehIin7YGC52JXV8tUA61CqABZv9yfXszAthD3ZL+adn841WY499OKBvEyajE72pEHzPeiyUeAXdX+mQONSsVkfUqLvUStufWbG1XSPMvqqwEKA5+nfa2SFg6HGaJ7NbviA2BrdYyu8JBRKa5NnN2H9E4TSpY2HbJ+iQwDdhsEEpkV60YQnqex1r+reaL0rBKXe6S7NgqHLOfCxnWJpBtfreDyqD+3PdXHk1KBg==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(376002)(396003)(346002)(451199021)(40470700004)(36840700001)(46966006)(2906002)(8676002)(4326008)(70206006)(70586007)(8936002)(41300700001)(5660300002)(7416002)(478600001)(83380400001)(54906003)(110136005)(316002)(966005)(7696005)(40460700003)(26005)(47076005)(186003)(1076003)(426003)(36756003)(6666004)(2616005)(336012)(40480700001)(107886003)(36860700001)(82740400003)(82310400005)(7636003)(356005)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 11:00:25.2750
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e61fad76-16ca-4541-e58d-08db3a7bf42d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5430
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi All,

Thank you for the review. Have incorporated the changes suggested in
v5. Requesting for ACK on the remaining patches and please consider
for merging.

The patches are divided into below groups:

- Patch [7-8]: Memory Interconnect support in PCI (MC client)
  -- Need ACK.

- Patch [3-6, 9]: Memory Interconnect support in CPUFREQ (MC client)
  -- 'Patch 3, 4 & 5': have ACK from Krzysztof.
  -- 'Patch 6 & 9': Need ACK.

- Patch [1-2]: Memory Interconnect base support
  -- 'Patch 2': has ACK from Krzysztof.
  -- 'Patch 1': Need ACK.

Both the MC client patches are dependent on the 'Patch [1-2]'.

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

Sumit Gupta (9):
  memory: tegra: add interconnect support for DRAM scaling in Tegra234
  memory: tegra: add mc clients for Tegra234
  memory: tegra: add software mc clients in Tegra234
  dt-bindings: tegra: add icc ids for dummy MC clients
  memory: tegra: make cpu cluster bw request a multiple of mc channels
  cpufreq: tegra194: add OPP support and set bandwidth
  PCI: tegra194: Fix possible array out of bounds access
  PCI: tegra194: Add interconnect support in Tegra234
  arm64: tegra: Add cpu OPP tables and interconnects property

 arch/arm64/boot/dts/nvidia/tegra234.dtsi   | 276 ++++++++++
 drivers/cpufreq/tegra194-cpufreq.c         | 156 +++++-
 drivers/memory/tegra/mc.c                  |  24 +
 drivers/memory/tegra/mc.h                  |   1 +
 drivers/memory/tegra/tegra186-emc.c        | 130 +++++
 drivers/memory/tegra/tegra234.c            | 595 ++++++++++++++++++++-
 drivers/pci/controller/dwc/pcie-tegra194.c |  44 +-
 include/dt-bindings/memory/tegra234-mc.h   |   5 +
 include/linux/tegra-icc.h                  |  65 +++
 include/soc/tegra/mc.h                     |   8 +
 10 files changed, 1282 insertions(+), 22 deletions(-)
 create mode 100644 include/linux/tegra-icc.h

[1] https://lore.kernel.org/lkml/20221220160240.27494-1-sumitg@nvidia.com/
[2] https://lore.kernel.org/lkml/20230220140559.28289-1-sumitg@nvidia.com/
[3] https://lore.kernel.org/lkml/20230320182441.11904-1-sumitg@nvidia.com/
[4] https://lore.kernel.org/lkml/20230327161426.32639-1-sumitg@nvidia.com/
[5] https://lore.kernel.org/lkml/20230330133354.714-1-sumitg@nvidia.com/

-- 
2.17.1

