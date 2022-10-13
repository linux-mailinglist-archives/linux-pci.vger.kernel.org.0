Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28F25FE1C6
	for <lists+linux-pci@lfdr.de>; Thu, 13 Oct 2022 20:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbiJMSoK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Oct 2022 14:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232201AbiJMSni (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Oct 2022 14:43:38 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on20606.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e89::606])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9D4786FF;
        Thu, 13 Oct 2022 11:41:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CbGOtxfIKjblZY9w6t+3wdlhy1ViJZ97qVNYMssRbar4fA2pxyLQU6PQpKrb1Pwu+ZCAvakmKX7ewC6YPHi61QgTmFXgAwWIcJWPwc7bgL6AG585r/0Tu3kbVFB/EBEMwIFju+A6UY8VmmEuqxEL05uyKTJXBe4RZvfC1wrzZ29XFPfkxUaz8n/GhZL175IrLtW/qX345mOTOs70eN0xu/HmQx70ULWx00o/GhEiuSyS4uLXU/Ct1r5Uvnr98m8MeZj5xs/hvWrrZx5CiJOI/UhDZi841CL5J/Vp9b+NlhpTjX27sBSEZDonpzuPIYIWL4DGZc++2BxRYQ3Ej9R4jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T9y8LOnq54r3hVY4gU2YFAX39OX7oDRTKUOHceIjFYA=;
 b=eaHtCEdM8Ucj1VhfkrCnBAXjDjSYlE6OrhSNsLMua6grfi5orpTjQ+0G7jTYwaS7NxjA5HONGh/oQqpUTHcQmD7tBfYDCwauQI/e8v/sTBqnNBIxCe/eub1Oa8xefDNykfzUDDDVlOlLNpThZ2jjxM9l0z6iOyR57CohyThWTV+GP09NMrBgsD4WeADVSbk7rQAWytdjJyd3FEFwiQaNyeDZrTtG2Ewv2kvYjSXj4hk8BtQUzCog6XDNqIYiIprgVcECRC9UkoW1fbvOJ0FHKbR9j7nPkz3c/wP6IqGgPfpXnIC5LhmOvAhxyYXfsShmWK0nfkN7w8N49ouv99nBPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T9y8LOnq54r3hVY4gU2YFAX39OX7oDRTKUOHceIjFYA=;
 b=KuP81ARSY9n4TkwcJz/zvfBuCHk8j6HjZa67F+7lcsjA4/2yj8Ykja5JpqS6BLvYOBJLrtzN3FrhOyLzbrDZbstWpWUfcbSuxoSRAX7PtpjmsWNfsyWoa3NmCsmTHlBfFOnFMevcL97bRktQEzWbKWvGgop5BywkGlx/OYQ/Qd72QVE3uMo1bVtw6K3CTv8m5KKFYznAKOMU2gC9NNN7K5jDstII13qDqkeqZDmcCfckpQz1MaacjZ1Un3t92F3UgGbEh5rtCCY6h2Y0aR0vM7tsPc4PqnNJR41+Lh31h7RpHgP2kGJOpnY3QhB5wunrVDJVjnEBxjkGMoj2seznmA==
Received: from BN1PR14CA0026.namprd14.prod.outlook.com (2603:10b6:408:e3::31)
 by MN0PR12MB6103.namprd12.prod.outlook.com (2603:10b6:208:3c9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.22; Thu, 13 Oct
 2022 18:39:15 +0000
Received: from BN8NAM11FT108.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e3:cafe::60) by BN1PR14CA0026.outlook.office365.com
 (2603:10b6:408:e3::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21 via Frontend
 Transport; Thu, 13 Oct 2022 18:39:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN8NAM11FT108.mail.protection.outlook.com (10.13.176.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.20 via Frontend Transport; Thu, 13 Oct 2022 18:39:15 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 13 Oct
 2022 11:39:04 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 13 Oct 2022 11:39:03 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Thu, 13 Oct 2022 11:38:59 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <lpieralisi@kernel.org>, <robh@kernel.org>, <kw@linux.com>,
        <bhelgaas@google.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <kishon@ti.com>, <vkoul@kernel.org>,
        <mani@kernel.org>, <Sergey.Semin@baikalelectronics.ru>,
        <ffclaire1224@gmail.com>
CC:     <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH V3 00/21] Enhancements to pcie-tegra194 driver
Date:   Fri, 14 Oct 2022 00:08:33 +0530
Message-ID: <20221013183854.21087-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT108:EE_|MN0PR12MB6103:EE_
X-MS-Office365-Filtering-Correlation-Id: fd245d28-8fa2-437d-9234-08daad4a3b22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FnugxFfod2wsuJBpvo2enQtQsz2FDdYCXqYjs+Tj7++0EYxgdKEKNZA3uk5Oztjix7nexvEYlx0ceWB2twdcdCPamUSzawj5so5UxAv7lKLBxIR3lwBxE8OFDB2sv7m04G02I9dRuKpegZc0pWXlvul1IbsKczhlpGIIvNcD71nzKXbtH37uc7uR33ER+v8VP3eXPOlu5uqIr8ZiKI9zdk96MWvF7QJgrOhZj8pio8NHRk9pklE/e1BFzP1z04o9BeF/ZnHgFy1BVsgtOj6CnH8KNOTK42I4V9WoLLyAR+n3s+fd8lzNYZL7eK6dDpoHUZ6A7E92uL+yh4OIzhfOwgW9ZC6T3eYrAVFnuveQir2IdIMgoup2gxzRWlmP2h66qEtCr4Rqa8eA7SsAgrH8vGOBvlD5VB0bgvtgylkFLlxPVrjJHyUalSS3bSXGNC1+gcDE/iHMQyWVlBBepSrvsaH+AIWD2p7nzS55DhSzIiFxtyn+YZmkAI3Np2OIUpA7SbdgXv16Ay1xgzSLMobtHys/Y1J8VBfAE+jgpLR0sroApZ/iSPcbCQRs+uRpdm8FGkCT504B9vy4NamPf+2wRtoL86Cj5Kf82xXiMcc15oSpA5CJgK1X+ICOlacperisue0HtxKIA0hkhO6ZCoUDKemaXU9iM3dMzVPxSxUTMy9C7CNh74V6Xr3QlL6FoTz03U9//hTcu7qt30UNMMfS96/6qyxClLxY7bE6GjFaWKuyBiBEJtdrO3Weo2ET/0L4Zp3jnZvMQjFsTNnFYLVn0OkfcMLtirO0HgNZhcVOnPxMl6R5aIdg4aKyx19Fc3BbFC1gDRiH4zfYDts18Q/yoD4kt9KBEs8xsR+Ue+Gg2LQmPAYiLXGhhL1/uokF2Vec7Ky+6e/PBWrAP9MxoUsXPyfOOTDPwjA8mkDUUulw7iw=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(39860400002)(346002)(376002)(451199015)(40470700004)(46966006)(36840700001)(36860700001)(40460700003)(86362001)(40480700001)(36756003)(921005)(82740400003)(356005)(7636003)(316002)(8676002)(4326008)(70206006)(110136005)(70586007)(54906003)(2906002)(426003)(8936002)(5660300002)(7416002)(41300700001)(47076005)(186003)(1076003)(2616005)(82310400005)(83380400001)(336012)(966005)(6666004)(478600001)(26005)(7696005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2022 18:39:15.5778
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd245d28-8fa2-437d-9234-08daad4a3b22
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT108.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6103
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch series contains enhancements to the pcie-tegra194.c driver
that works for both Tegra194 and Tegra234 SoCs and for both RootPort
and Endpoint modes.

This patch series depends on the following series in the same order

PCI: designware-ep: Fix DBI access before core init
https://patchwork.ozlabs.org/project/linux-pci/list/?series=322681

PCI: endpoint: Rework the EPC to EPF notification
https://patchwork.kernel.org/project/linux-pci/list/?series=683493

Add DeInit support in the PCIe Endpoint framework
https://patchwork.kernel.org/project/linux-pci/list/?series=685157

V3:
* Addressed review comments from Bjorn
* Added new patches to the series

V2:
* Addressed review comments from test bot and Vinod

Vidya Sagar (21):
  PCI: tegra194: Use devm_gpiod_get_optional() to parse
    "nvidia,refclk-select"
  PCI: tegra194: Drive CLKREQ signal low explicitly
  PCI: tegra194: Fix polling delay for L2 state
  PCI: tegra194: Handle errors in BPMP response
  PCI: tegra194: Apply pinctrl settings for both PCIe RP and EP
  PCI: tegra194: Refactor LTSSM state polling on surprise down
  PCI: tegra194: Disable direct speed change for EP
  phy: tegra: p2u: Set ENABLE_L2_EXIT_RATE_CHANGE in calibration
  PCI: tegra194: Calibrate P2U for endpoint mode
  PCI: tegra194: Free resources during controller deinitialization
  PCI: tegra194: Remove IRQF_ONESHOT flag during Endpoint interrupt
    registration
  PCI: tegra194: Enable DMA interrupt
  PCI: tegra194: Enable hardware hot reset mode in Endpoint
  PCI: tegra194: Allow system suspend when the Endpoint link is not up
  PCI: tegra194: Disable L1.2 capability of Tegra234 EP
  PCI: tegra194: Set LTR message request before PCIe link up
  PCI: tegra194: Reduce AXI slave timeout value
  PCI: tegra194: Don't force the device into the D0 state before L2
  PCI: tegra194: Free up EP resources during remove()
  dt-bindings: PCI: tegra194: Add monitor clock support
  PCI: tegra194: Add core monitor clock support

 .../bindings/pci/nvidia,tegra194-pcie-ep.yaml |   6 +-
 .../bindings/pci/nvidia,tegra194-pcie.yaml    |   6 +-
 drivers/pci/controller/dwc/pcie-tegra194.c    | 261 ++++++++++++------
 drivers/phy/tegra/phy-tegra194-p2u.c          |  14 +
 4 files changed, 194 insertions(+), 93 deletions(-)

-- 
2.17.1

