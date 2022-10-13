Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A575FE142
	for <lists+linux-pci@lfdr.de>; Thu, 13 Oct 2022 20:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbiJMSb0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Oct 2022 14:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbiJMSbL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Oct 2022 14:31:11 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2060b.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5a::60b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071001911DF;
        Thu, 13 Oct 2022 11:27:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=foU2H+HrFWiQgShbOPtu2Y1Qr1XhPqTwQThBHrQZ4In8Tu0vXa7H1e5UXvdjDLnlLYd8sbuuvCLSEQi4/znsn9DDx2rJJ0A07fZl3/S+VfECZrcsiOVN7mblawXEviTOEhmCWlzX0V+gAJ6/LjNRa8jG6DEO+KlpDxnGM1GA1SvPjnU5X7Ps8hWr/hrNL9rTvO1tjhmF7GxHn9hIcTa5rNJRVyonBwKea6z7pPj8RlRbfXSyMB67xvg815Ekv6nfun/BboC5v1Os2BbtRa995fPWU7zgtvdmyKYlb5wmJNLPTlcyy7iZXp0NI2jSPrbYCrqO2ZfA7PYzioKQUyp97A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kajDMvKrZPOcbuAWso3yKipultWm6z/cLTqJwhIzNK8=;
 b=T21kCnCWppDcQTOwtXERp0pkVj5Y4UezCJOqtoNILJ/Pfy85v/OKBRO/VWwkVkqFFr9NOYZpHwZWO4VA8k51xxbqFt/AwIZD85uMQolhHJNSEZgLDCUHPcUdk005X20+B5FjbhNh7jAKPlzeceAj+Z9Po+16DciUQlaSIBWNQmNR2dNC2X/jddJh2rBSKHupt5pNldqhNJ2IKCNdAugwBVXenytxnCiHEF5K3axfugyM3wnRrJUn692Ws9U+tZx3bHEWO5OyIG20kQRcAX38jUDvQa07aB4Z5jOW3exKLxGHrTiljwSWGeFAvejm6rQx0U98csOQ2/GTyhkeXABqPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kajDMvKrZPOcbuAWso3yKipultWm6z/cLTqJwhIzNK8=;
 b=TQSth9RPLWcp4ZeCmKkMe2uVp5GA1AGOTllzXLFwtEb4w1p3tDE5ICmgzZy+ATMee+TSMuaQBO7W5gsJZkpeNnNXH/eRMbup8VfXzfdLcmL1yj2UQIMX5jgKClu88kEIgVO4H6mFQroZSlKt+zkFWBGLMVodawj6KWuQmouUpwXr+OUr3CK88/WeM3mIFvf5aHcapsP7Vp8sGdbGhh0imoDwyufRwxBfyogOxm46YPslxXJCEkHvAEZ3vi39AXz58fNiR2YlSH3VY7oDUT8xF+ekq3teBG11hFpO+vZbSu1GTzx+n1zuCWrb5VpqTxNcCP0s0P0c/6IOs6/yEwh5cw==
Received: from BN9PR03CA0523.namprd03.prod.outlook.com (2603:10b6:408:131::18)
 by CH0PR12MB5057.namprd12.prod.outlook.com (2603:10b6:610:e0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Thu, 13 Oct
 2022 18:18:36 +0000
Received: from BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:131:cafe::18) by BN9PR03CA0523.outlook.office365.com
 (2603:10b6:408:131::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26 via Frontend
 Transport; Thu, 13 Oct 2022 18:18:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT026.mail.protection.outlook.com (10.13.177.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.20 via Frontend Transport; Thu, 13 Oct 2022 18:18:35 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 13 Oct
 2022 11:18:21 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 13 Oct
 2022 11:18:21 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Thu, 13 Oct 2022 11:18:17 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lpieralisi@kernel.org>, <robh@kernel.org>, <kw@linux.com>,
        <bhelgaas@google.com>, <mani@kernel.org>, <kishon@ti.com>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH V2 0/4] Add DeInit support in the PCIe Endpoint framework
Date:   Thu, 13 Oct 2022 23:48:11 +0530
Message-ID: <20221013181815.2133-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT026:EE_|CH0PR12MB5057:EE_
X-MS-Office365-Filtering-Correlation-Id: 7245356f-5659-44ea-d0f1-08daad475841
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X3fXdeKCoqg8l09c93yfeAaqSMD+00xhDeVr0qYV+TY7LekoLGUO9p4M1QXwYncV1fr10pS8e4ghWYt8EjMgXTGtsLzGojMljiANYKg5U6LspBee359be5hxnpPLGlX4cF+GcOimHHQHDQKWgzDd7MMN4SPNHG9V2NgYsYXEqfooS/mawlO1jRPWqu7llON4lKXJl5V/jjznRDNaOjeJYtC6lLkosWLrXb5tb/O2mGtS+69rPBICzYaDqvVaaLevDqYcrwYb9drpJ/VwQQBN2QOKeKEiYBEW7++wJN8juAAa/Wej7F3bpO5mkR4ixUWHFo9WamS+QU1UjTpo9pbbNNU/XxSuHOvR+olRwlcGx7nF5LvwnuJ3RmKnhw+4KX01OsETU0JKi+yasDJnZWMBeIFb8ZE1cWiZ5uejyYpo9SMU186WZ4suabp2RUpqIww9KWuyvuwnviRs9pS6xXeuzSomoJ8nhMHM2mpXOAWLZrsq2iU2Wfplg74oVK8iVf3NjN8fiVEjH/h8UrZIh2Ru5ICJyYgfc4PjKzlm9ZYaPizv15jk6XyYdPH1Cle0wDPazkMWWlvxtVqhwsgq5qR7++0dzJM066FFvOrum10W1gtE/B53OEorhO4WpSEfbJi8HSuf/NdR8mXcrSScA/XjQf9NT2s+vyW4xa7lKYyOeIbZRjIH55V1wxBCAbL0A6c70t/xCBsJrJnm4+RlJev60QpOzmj7q4+fikL2fxUNyMkCbVvjg+7dSxWXR9Nd2KWZUJRnypp+XjWwPx5zJQKvhaHKz1jW07dlU85CIkwGYFHsj8/APjDpgZkzAZYX4rYSWqA390GoGfpmieKIp/9zz2yLWRfpMq02PQVHHvetRNE=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(6029001)(4636009)(376002)(346002)(39860400002)(136003)(396003)(451199015)(36840700001)(46966006)(40470700004)(26005)(47076005)(356005)(7636003)(83380400001)(36756003)(86362001)(41300700001)(54906003)(110136005)(7696005)(8676002)(4326008)(70206006)(7416002)(70586007)(1076003)(82740400003)(6666004)(426003)(2616005)(2906002)(8936002)(5660300002)(40480700001)(336012)(40460700003)(186003)(316002)(82310400005)(36860700001)(478600001)(966005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2022 18:18:35.9306
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7245356f-5659-44ea-d0f1-08daad475841
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5057
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Endpoint function driver should cleanup its resources which accesses the
hardware during endpoint controller deinitialization. The patches in this
series address this requirement by first adding the callback notification
in the endpoint code driver. This notification is invoked by the controller
driver which is propagated further to the function driver.

This patch series depends on Manivanna's following series.
https://patchwork.ozlabs.org/project/linux-pci/list/?series=321660

V2:
* Reworded commit messages
* Added a new patch for deinit of the function driver

Vidya Sagar (4):
  PCI: endpoint: Add core_deinit() callback support
  PCI: dwc: Add a DWC wrapper to pci_epc_deinit_notify()
  PCI: endpoint: Delete list entry before freeing
  PCI: endpoint: Add deinit in epf test driver

 .../pci/controller/dwc/pcie-designware-ep.c   |  8 +++++
 drivers/pci/controller/dwc/pcie-designware.h  |  5 ++++
 drivers/pci/endpoint/functions/pci-epf-test.c | 30 +++++++++++++++++++
 drivers/pci/endpoint/pci-epc-core.c           | 26 ++++++++++++++++
 drivers/pci/endpoint/pci-epf-core.c           |  5 ++--
 include/linux/pci-epc.h                       |  1 +
 include/linux/pci-epf.h                       |  2 ++
 7 files changed, 75 insertions(+), 2 deletions(-)

-- 
2.17.1

