Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 498506C1FC2
	for <lists+linux-pci@lfdr.de>; Mon, 20 Mar 2023 19:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbjCTSdg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Mar 2023 14:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbjCTSdE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Mar 2023 14:33:04 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61693C7BB;
        Mon, 20 Mar 2023 11:25:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dAo1F1UgXFMCtnxSjjAN1gLFAGPQQts1I118ODVA3BtznNcvBJYelQpye1TfNpdaQ5YOdJMFnM6SzPfR/2eVpW131CXPIdT6chCSbjctJub8yETBVEqeCV1BZwZpcG2XjQUlv5y34cOGfYaFBZvO2wG4MnUi3y8gYq5a99aCXPcS7Fj2DfAzcP95WDHIolNnrNyltyGUaWifZSN6EJQ5oVahCYUNXsqm516K1n6ZGiaSotxgMqoc8sMR86Z/dwK/6x5STtj0XZ9eRPcLzNvV0+J1iNvWUtY9Kafi8c/s1aErnf3maBw6JlxuEFG9TgY3672ZNrAmPDWcAchtz9itWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xuc6h5Vk55fJI4jzYR6dfGm9NGSziQPSeWgE0TyKqDc=;
 b=crtlA8p9RJheA6RDGYF3bnlorH8skgw/zpY/1kgidOK87hjZB47kkcGaLB+MfQnDiOtdRSjmlhz9h7tzJFsZPunXkouNm6DY2D/OqubPf/0HhyOmu9kwE9IBX+mNQt/AFaC+SijYltv7iG4MAy4gyppJEXeDtrCdhv7hD7EP0nVPKtTbCcSc/LzTLsa+8KfQ4Y7TBT83PZwDTWHLvh1n0j47x/StoTO0u178R4tDnSHHi6Q8CPDwh5obKZTyG6EhAfFOR1Kaejl+FXsRQzRzwg9rPMDbnj+Xzs8nCWMOX9neBsDABmIqAtmcv2J9asz8HaK7JrJP0txHu7lLocdEWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xuc6h5Vk55fJI4jzYR6dfGm9NGSziQPSeWgE0TyKqDc=;
 b=uX1SA12xS1nE6NgQXCPnGr4qyze5No/j7Pv/DvT0XGLAkvgo6R2Bj/+NXZRXwCqdAINYtFurLuT2ZoCQvQjA1XSl8K0MdJmkFIFN+3J4l+EGrBd2Npog041T5cTfP9Bz9fDTiGTkdkQHva1h4FsgcUYTWOGQK3+UryZvv+TFTOhhK95Vhz0Tn2ye9b9zAGz+W7DmFfk63xKJ0lWR3HG4P4EkPNq6sT/7GCWGCibOjfSNhRMcYHTg44HbRiktSWneoBSSpK6ZT9399fcMdvK2FAYFZLgl4hEo3F4Kf0p/tjFityvpR2c2YDvJYkQotW/sKS6TFyCmR9ehJSldslbwVA==
Received: from BN0PR07CA0017.namprd07.prod.outlook.com (2603:10b6:408:141::31)
 by CY5PR12MB6129.namprd12.prod.outlook.com (2603:10b6:930:27::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 18:25:04 +0000
Received: from BN8NAM11FT085.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:141:cafe::e5) by BN0PR07CA0017.outlook.office365.com
 (2603:10b6:408:141::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Mon, 20 Mar 2023 18:25:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN8NAM11FT085.mail.protection.outlook.com (10.13.176.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.16 via Frontend Transport; Mon, 20 Mar 2023 18:25:03 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 20 Mar 2023
 11:24:55 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 20 Mar 2023 11:24:54 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.5 via Frontend
 Transport; Mon, 20 Mar 2023 11:24:49 -0700
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
Subject: [Patch v3 00/11] Tegra234 Memory interconnect support
Date:   Mon, 20 Mar 2023 23:54:30 +0530
Message-ID: <20230320182441.11904-1-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT085:EE_|CY5PR12MB6129:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a56240f-a230-4069-7e5b-08db29706c94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: skUj1bFGFi2GsAZYgKEdrY/DxZdwLrYzI9PGl0acffPRxyd0nPKw9ThWa1WsfXIQwSDF8rogKNPu428sCIudyhp2OHrhmvOJE7/ssYhXc1LbNTeW69KBWopp229tJ4SWCNlmmonWzd1wCMoNafkxXhq/XNAgMfvTgOUz/P/VEJABCbwwVNq7lIyZhLTwr37rhf2rL1BO6KtGVDG79NZii8ocMbDXyD+dMYswxwQEmKqk/QG5gNreu5mNFePFWJBPDDGk856OhpKqS7sJFOS9cjKO91DvxyNIFBrt6X7NcDLLp3tLhAK2JIrmdHUX5cD7fH3ilgAfDPgE4eMy+QucVEpfg7+AlGr15Yr+ZcxPcZXwiOue5SkAuZhei2N7BJPHrv/bkzoGxiDj+AXM5J378D4AEo7/iEv+3tLSdT1IP60M6fbLcesjST9GX/3Q3zSFt4FrRKZNicPgXKdEasms6c4tsm3kYhCQYN0cK52CJKQbV72HzKHeNGzlkOdZ8o1zgK+EYokaE4Zy8fctaptkjJSm4yBEQavRAxOtPXwjoPq/hbdW9L7ssYZSYSkAnq+qHCcnVVbovYkKckfSyiJPrwtA71OFrPgjcKEHsStRGfTXsRdd5DNS03TQS07do8iPmVqpbjS+gWGyVQQ1dKXvxzvYnVUmKY20mVZrZHSbNnLRGWoikswV64ngeIz7M5/xnd3HCdkMmq4I3pZEOuy8czeraNKTgHbqRz3n49b+qNCw+1JqOPqMNoc9Eo0mv5AwzFLT+KI0nfTlp2fvixABsGBFUKykdJLm9McVATpGjvACVQkzqjnmpl6FIGtNY9GmjmDhm7rkpslKMhQY+DcvYg==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199018)(40470700004)(36840700001)(46966006)(7636003)(82740400003)(47076005)(426003)(66574015)(2906002)(1076003)(83380400001)(8936002)(7416002)(36756003)(40480700001)(5660300002)(82310400005)(86362001)(36860700001)(40460700003)(966005)(2616005)(356005)(41300700001)(26005)(186003)(6666004)(7696005)(316002)(54906003)(478600001)(110136005)(107886003)(336012)(70586007)(70206006)(4326008)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 18:25:03.5929
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a56240f-a230-4069-7e5b-08db29706c94
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT085.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6129
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Krzysztof.

Thank you for the ACK on the Memory patches [2-5 & 8].
Rebased the patch series on latest next and added two more patches
for 'memory' in v3. Please review and ACK if fine.
  [Patch v3 10/11] memory: tegra: handle no BWMGR MRQ support in BPMP
  [Patch v3 11/11] memory: tegra186-emc: fix interconnect registration


Hi All,
Requesting for ACK on below remaining patches and please consider for merging
in "6.4".

- Thierry:
   "Memory Interconnect base support" patches are dependent on the bpmp patch.
   [Patch v3 1/9] firmware: tegra: add function to get BPMP data

- Rafael & Viresh: For the CPUFREQ MC Client patches.  
   [Patch v3 06/11] arm64: tegra: Add cpu OPP tables and interconnects property
   [Patch v3 07/11] cpufreq: tegra194: add OPP support and set bandwidth

- Lorenzo, Bjorn & Krzysztof Wilczyński: For the PCIE MC client patch.
   [Patch v3 09/11] PCI: tegra194: add interconnect support in Tegra234

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

The patch series also adds interconnect support in below client drivers:
1) CPUFREQ driver for scaling bandwidth with CPU frequency. For that,
   added per cluster OPP table which will be used in the CPUFREQ driver
   by requesting the minimum BW respective to the given CPU frequency in
   the OPP table of given cluster.
2) PCIE driver to request BW required for different modes.

---
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

Sumit Gupta (11):
  firmware: tegra: add function to get BPMP data
  memory: tegra: add interconnect support for DRAM scaling in Tegra234
  memory: tegra: add mc clients for Tegra234
  memory: tegra: add software mc clients in Tegra234
  dt-bindings: tegra: add icc ids for dummy MC clients
  arm64: tegra: Add cpu OPP tables and interconnects property
  cpufreq: tegra194: add OPP support and set bandwidth
  memory: tegra: make cpu cluster bw request a multiple of mc channels
  PCI: tegra194: add interconnect support in Tegra234
  memory: tegra: handle no BWMGR MRQ support in BPMP
  memory: tegra186-emc: fix interconnect registration race

 arch/arm64/boot/dts/nvidia/tegra234.dtsi   | 276 ++++++++++
 drivers/cpufreq/tegra194-cpufreq.c         | 156 +++++-
 drivers/firmware/tegra/bpmp.c              |  38 ++
 drivers/memory/tegra/mc.c                  |  24 +
 drivers/memory/tegra/mc.h                  |   1 +
 drivers/memory/tegra/tegra186-emc.c        | 118 ++++
 drivers/memory/tegra/tegra234.c            | 599 ++++++++++++++++++++-
 drivers/pci/controller/dwc/pcie-tegra194.c |  40 +-
 include/dt-bindings/memory/tegra234-mc.h   |   5 +
 include/linux/tegra-icc.h                  |  65 +++
 include/soc/tegra/bpmp.h                   |   5 +
 include/soc/tegra/mc.h                     |   8 +-
 12 files changed, 1312 insertions(+), 23 deletions(-)
 create mode 100644 include/linux/tegra-icc.h

[1] https://lore.kernel.org/lkml/20221220160240.27494-1-sumitg@nvidia.com/T/
[2] https://lore.kernel.org/linux-tegra/20230220140559.28289-1-sumitg@nvidia.com/

-- 
2.17.1

