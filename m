Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD60A6ECCC8
	for <lists+linux-pci@lfdr.de>; Mon, 24 Apr 2023 15:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbjDXNOY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Apr 2023 09:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbjDXNOW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Apr 2023 09:14:22 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BAFB4204;
        Mon, 24 Apr 2023 06:14:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fQY0CGe10+UX4yszekYXAX6O1fPZkJV8CpQ8ZsZrFKzlUJJpTMRwlJ5v6mioGAprPXtIEdsxGoH2vqqn1Y8x/4L3X4oyV4yrkhrV1O2RUqUEnTdPj3TxwwAF8l1Rl7sBGbZFFqSi2PtUN+Qf68OHNx2e5FuZ4UNuJ1aERgsmpHP9SQR1raY7hawz2eotMGtx+ciWeVoNayl10yxxGaVh47wHKyOryxspVVC3EL8mdSGYMP0PjMEKGL9VC8jSu82XAsYyaMSzMkrvKmtjQtDlUKhnF05ax8rTk/MHEnCi1jdO0L6YHweYgJ1ZUEfZ9ZaDUaQQRxFK19CG5oRM0h2uag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NjPe5HBhe46J4M423EveHUIWZqfwjojmiiQjImKPQ6k=;
 b=fU/MwBurJNga4mTy2yjLT2xa+h9bI5BRjv/b6fTUObAgyj45On+nFA6qpxNo5yXWxDRC6bshVKqKVEpmoKmXOJ0+4p2q9AdUQ1+RupjY8pvAyyCVHXWn31nFloi1+Lr3Rq/XQlPCATYC57yIbWZh1AFjSqYAuo0/6vBc6+X53sNu/nYk4xqghUiwCpu9NvO8o+VWJg6KiZzwEkcwWV43YXUWZ/QRv85POubZ+Bgi68SfZIYokhoWWk3iQJuFIbfrUzRvIdnpbI2BJD5nqdGHEGy/cTGAqRdCD8iIKApX1G0Lgm/DpqDjP9BIL2ICSFxWOu7C/FbYlvjBjdT86JBDGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NjPe5HBhe46J4M423EveHUIWZqfwjojmiiQjImKPQ6k=;
 b=umicY+LqH0I1d4UdMoVmvkeVIn0IsEoxH8u5h+yfFzlQmiQ0mbSTpjNEud2e0oBff+ZAtnOIwtABDzWep8SivOruW052OHYvmZcU5LQjmn+VVfoI1z5dDrn2/HKZZMPvSuRRaDM6Ai72gPeiJn7+iYMlDz9jsXpcGIOegK8UYHBj1z8IsogZ2tOBUvC7FbubEG853vmumelg86IVKmEbJWHAG4EUZegR3zvQrkTaj4wYBTE5CoM1tSYN6B8DRGXUgzYy743Se8Byfmf4YtznRJysetqasYL+F2VngfJ66eJpkWgt4CAtF77YKFUujZwL0SBrvvXpGhMwDUhxipmFMA==
Received: from DM6PR13CA0029.namprd13.prod.outlook.com (2603:10b6:5:bc::42) by
 SA1PR12MB8918.namprd12.prod.outlook.com (2603:10b6:806:386::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Mon, 24 Apr
 2023 13:14:17 +0000
Received: from DM6NAM11FT086.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::45) by DM6PR13CA0029.outlook.office365.com
 (2603:10b6:5:bc::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.19 via Frontend
 Transport; Mon, 24 Apr 2023 13:14:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT086.mail.protection.outlook.com (10.13.173.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.19 via Frontend Transport; Mon, 24 Apr 2023 13:14:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 24 Apr 2023
 06:14:08 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 24 Apr
 2023 06:14:07 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Mon, 24 Apr 2023 06:14:01 -0700
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
Subject: [Patch v7 0/8] Tegra234 Memory interconnect support
Date:   Mon, 24 Apr 2023 18:43:29 +0530
Message-ID: <20230424131337.20151-1-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT086:EE_|SA1PR12MB8918:EE_
X-MS-Office365-Filtering-Correlation-Id: 59d245d4-1575-4869-b927-08db44c5cf17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1lPsPL4Jtme2nMkyfudz/89Etix9d/+mx3pPjT7nX3E6751kvkR2Ee4hfAtsD4xxshfxE+kYCqfp5Z5Yb5VtvT00eL3voYgd6Cjh8BKyeivx9/cU00YK2HhqpWJ42O44Xa963UO6eKvDYQimsIpEqXJHgy93fDMVTE+QC8/Yb1A5eXFxu12Agi7UUnJmbFt+0A98VDMtUs98zQtHIicbwKHRhfz/hvCZlyooDN9ILUKgEYKuPwpO69qpTv35NsGYNEBYIewOPptsx8HVDTjqGiRzgcfwzuqk63waOMu53gEExlAM2/5Joy6KkGNRYdxd5BftWHAJSN5hxAfe4tExL8JQFqTW8GAcga6tWtKKD5JM8VM+f1xajdxLf3tmtoSsxLPOOQ6PuCglWcm7kK9JT+zxBxRDzidy2uZg/E/v3j96/ZG5g8auqpN/hLfgEeTX8gPZ3T5v1btFYNKZrBFCTJm08yy3Z4NvzKRCIFKnKtohPhE9muGDUywsnUQO/SUEgS+oY1DhuVy4uSupBHBIzXlHq3vlff3neflYqVyZ4zC9U6bAQFrnwVIV1jML/ockiePIjX7VpkoIC3eQ31rsJvsnEepGIu9PG/k6gCF104jUndNOPpXAjnpaYSSoWY/j3SSrktRwKtsxpza++aeeg7Se8K2QUl5vASPqolAQLOCl5M3CXvTTrn6Ae0TCIvO++iaUY6HBSBTRP3X2livOPj0VKic65Ct39dmL1bneTKm5G8RTYG6R6w+e8swAar3sCo1ikGW2126FGkzv72NZtB0rH40k5L/mfFWbrwSmZiPg6Er+VnBFl8pvMLiTN/2G
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(136003)(396003)(451199021)(36840700001)(46966006)(40470700004)(478600001)(40460700003)(110136005)(54906003)(86362001)(966005)(36756003)(107886003)(34020700004)(186003)(7696005)(26005)(82310400005)(1076003)(40480700001)(6666004)(4326008)(316002)(82740400003)(83380400001)(70206006)(70586007)(36860700001)(2906002)(7636003)(336012)(356005)(426003)(41300700001)(8676002)(8936002)(5660300002)(47076005)(7416002)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 13:14:17.5335
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59d245d4-1575-4869-b927-08db44c5cf17
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT086.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8918
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi All,

Thank you for the review.
Requesting for ACK on the remaining patches and please consider
for merging.

The patches are divided into below groups:

- Patch [6-7]: Memory Interconnect support in PCI (MC client)
  -- Added ACK from Lorenzo.

- Patch [3-5, 8]: Memory Interconnect support in CPUFREQ (MC client)
  -- 'Patch 3, 4 & 5': have ACK from Krzysztof.
  -- 'Patch 8: Need ACK.

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
 drivers/memory/tegra/tegra186-emc.c        | 130 +++++
 drivers/memory/tegra/tegra234.c            | 595 ++++++++++++++++++++-
 drivers/pci/controller/dwc/pcie-tegra194.c |  44 +-
 include/dt-bindings/memory/tegra234-mc.h   |   5 +
 include/linux/tegra-icc.h                  |  65 +++
 include/soc/tegra/mc.h                     |   8 +
 9 files changed, 1139 insertions(+), 9 deletions(-)
 create mode 100644 include/linux/tegra-icc.h

[1] https://lore.kernel.org/lkml/20221220160240.27494-1-sumitg@nvidia.com/
[2] https://lore.kernel.org/lkml/20230220140559.28289-1-sumitg@nvidia.com/
[3] https://lore.kernel.org/lkml/20230320182441.11904-1-sumitg@nvidia.com/
[4] https://lore.kernel.org/lkml/20230327161426.32639-1-sumitg@nvidia.com/
[5] https://lore.kernel.org/lkml/20230330133354.714-1-sumitg@nvidia.com/
[6] https://lore.kernel.org/lkml/20230411110002.19824-1-sumitg@nvidia.com/

-- 
2.17.1

