Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5105F68EDA9
	for <lists+linux-pci@lfdr.de>; Wed,  8 Feb 2023 12:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjBHLTW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Feb 2023 06:19:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbjBHLSS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Feb 2023 06:18:18 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2061f.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8c::61f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5057ED0;
        Wed,  8 Feb 2023 03:17:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kpjzsZtw0h0EbNit/OtJ1mE6nEDK9RCKzt0izQXekIUBDKjB8bDAukK8KYJhbEJTAdCQntLpmKXPSvTVZ5aZ/GAV+FAdMcMYa03x6k5P4rbYBZCgKAMMZSWPZ03cvnX+fKCq3rYcG7XQS4m+aByyeXOjpJC3BMjxrqpJdc6WHEh10opj7WqdJLyfgcLUqMJaukBOgWw5jIIeIsWcfJTRR+LreYtiI4REesDUt06RPOVU9mFp7kpsrVTRlqblzDVeTykzSd0BHN9u2OHbbgatrj4ZKFwpsEfQdjn742NauuLs5f7sCcYVxu0G1+YSflWhnN+nXeNVrJdgtkRzrfv4Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fxV9KLU7PDeYUl2E8lVfRvGiyr+26SP+toU8DYzsGcM=;
 b=WjLow64FrUI6eDYY99qpRf/Eq1pc8ppOfsZylTswO2fzxYwGuXqU9vVkLK6dP65ZE4FrV9ur/ZD9gPTza8y6/OrqtGkYC8JDN7WnKxIjZLyRHDRgr/luj8FdcE02HYe8aH3fpKVzFqzskEBbyilyQUqCrs62Cv+bQTC7ficRamrZcdCKDsJbUCaJApkaEPQESPGbHNy6wlCMVAn+6c5NJk8RGqf0HN45dDUO0DyXfO7fHlvIAD8Z25hIAYUgU8fJGhiJPNdq5aKikbAblKPTU4j/vHGkXrTLay+lxdY/Qo8ab/hBDHtQ4pvikQRg73fkq2PO0bsl0TprowQLdTZ+Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fxV9KLU7PDeYUl2E8lVfRvGiyr+26SP+toU8DYzsGcM=;
 b=jJnTAuj1WpRUgm0QgJCa0tj/n8mkyo+Ci0BmGLaMdPzaJPHcRNc2lY0vfUIpr1+2flaFBJz4v3JlJ4qA6yewq/VW/s/YxrrYm2LM12KaGdlBPcwzfAhOLd9soyP40ZAYrF1j6+xEJbx2avnyTcj25C2lstsPO2mFThdXMB6gGjDolCiz06CWpLuCTgTWhcMfR3YXygNsUjIgZ6GCc2UjpdkY4I7pmrtwvP2d5SbaaZtIQF0OU7zq+rXEpAkB64OarYno1R5HHwgZZ0lDFa6kq9S1ckxCfP/yxUpTgYGBddaUw67NvrfJqQp/gOvkqCd13aUFQdyYTDfrsyIxAJMqhg==
Received: from MW4PR03CA0223.namprd03.prod.outlook.com (2603:10b6:303:b9::18)
 by CH0PR12MB5092.namprd12.prod.outlook.com (2603:10b6:610:bf::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Wed, 8 Feb
 2023 11:17:17 +0000
Received: from CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::c6) by MW4PR03CA0223.outlook.office365.com
 (2603:10b6:303:b9::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36 via Frontend
 Transport; Wed, 8 Feb 2023 11:17:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT034.mail.protection.outlook.com (10.13.174.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.17 via Frontend Transport; Wed, 8 Feb 2023 11:17:16 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 8 Feb 2023
 03:17:08 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 8 Feb 2023
 03:17:07 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Wed, 8 Feb 2023 03:17:01 -0800
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <bhelgaas@google.com>, <thierry.reding@gmail.com>,
        <petlozup@nvidia.com>, <rafael.j.wysocki@intel.com>,
        <lpieralisi@kernel.org>, <robh@kernel.org>,
        <jeffy.chen@rock-chips.com>
CC:     <krzysztof.kozlowski+dt@linaro.org>, <jonathanh@nvidia.com>,
        <dmitry.osipenko@collabora.com>, <viresh.kumar@linaro.org>,
        <gregkh@linuxfoundation.org>, <steven.price@arm.com>,
        <kw@linux.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <vidyas@nvidia.com>, Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [RFC,v14 0/5] Add DT based PCIe wake support in PCI core driver
Date:   Wed, 8 Feb 2023 16:46:40 +0530
Message-ID: <20230208111645.3863534-1-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT034:EE_|CH0PR12MB5092:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bdfcf60-d439-4a7d-7d9c-08db09c60969
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nmDKyr4MU4mczo2vY8Oy/qv/V0PtmyeEiiF6b9yFl2zlVlL4fg0CWKbYQefJ+iM8jt03kY3N0DOWJQI6EFtSyQ54rvcTjFaTxWIOJJzGdIurJSqgNFbhmMEJ637MlOCMK4TdHb8k2H6cYCMH5NIa1raPeg4ONFFAHQWXAOnJZHKIcdMPkKMRODCPwnZyLFhdj8cKrWzcjpjOwWnZp3tqqXpPsZNAqwr+B7iErCwyB9eGD3MZRMK9UHf4h+s3qJZAcA90yM2Cp49jxr1qnqxMET4TPUnzRfnmAl7boktjC770/evXvdwx3YEyV33/0PKA7B2/4iNBCqTIs6SYDtDJZr6sNsXUzfcZgca157BR8lFttgxJp2Gv+ANV91fpCJvWdHKgzO2pUByGxUkS4bSmWMSI82a1iAxdfTWXKidhP/OFxeIWx/SabD4lFxYhxMMaPO/k1jwhl2EiAStW8yp/i82jKeV34kYiZ01IKrAmx3WdULuSJGsAAcJy0TXuowDFrfNW1WEEVxjfy9t/xG6vM2wEedZhZV13qNKMCC2LFzEMh/bOZqkQixCdfp5SkRwz2AiKeH7WKEmHhKQANFNL/BJAmSgGyAbjo7fZ8gB6GLpSIdS5nVh+d4tfjE+m1rTx2KLxhaL71JCAtDqbkPSP34A1peSVR34X9yQje5g18mNEttRN1lz/Q+FFYc4/K1kQ/Z4lmmmKF7zakOGQivtPOD1dvclAM34SmgfpiqBXxO+C1UsYLQCC6IWzEVu0AsyP/CtFgBgK/7wBOh6Rczaqx2EgfIca6sYeGm9GO86wDSQ=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(346002)(39860400002)(136003)(451199018)(46966006)(40470700004)(36840700001)(8936002)(2906002)(41300700001)(7416002)(70586007)(8676002)(70206006)(4326008)(86362001)(316002)(54906003)(110136005)(356005)(7636003)(7696005)(5660300002)(82740400003)(40460700003)(478600001)(83380400001)(6666004)(1076003)(107886003)(36756003)(26005)(2616005)(186003)(82310400005)(36860700001)(40480700001)(966005)(336012)(426003)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2023 11:17:16.8202
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bdfcf60-d439-4a7d-7d9c-08db09c60969
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5092
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Below series [1] attempted to support DT based PCIe wake feature in generic
PCI core driver. This series was left at v13 and final comments are not
addressed. I am continuing this series from v14 by addressing all comments
in v13. I dropped rockchip device tree patch because I don't have hardware
to verify it. Instead, I verified these patches on NVIDIA Jetson AGX Orin
Developer Kit and included its device tree changes in this series.

[1] https://lore.kernel.org/all/20171226023646.17722-1-jeffy.chen@rock-chips.com/

Changes in v14:
Updated commit message for DT bindings patch to reflect that DT properties
are tied to PCI-PCI Bridge.
Addressed review comments on PCI interrupt parsing patch.
Dropped rockchip device tree patch.
Added Jetson AGX OrinDeveloper Kit device tree and Tegra PMC patches.

Changes in v13:
Fix compiler error reported by kbuild test robot <fengguang.wu@intel.com>

Changes in v12:
Only add irq definitions for PCI devices and rewrite the commit message.
Enable the wake irq in noirq stage to avoid possible irq storm.

Changes in v11:
Address Brian's comments.
Only support 1-per-device PCIe WAKE# pin as suggested.
Move to pcie port as Brian suggested.

Changes in v10:
Use device_set_wakeup_capable() instead of device_set_wakeup_enable(),
since dedicated wakeirq will be lost in device_set_wakeup_enable(false).

Changes in v9:
Add section for PCI devices and rewrite the commit message.
Fix check error in .cleanup().
Move dedicated wakeirq setup to setup() callback and use
device_set_wakeup_enable() to enable/disable.
Rewrite the commit message.

Changes in v8:
Add optional "pci", and rewrite commit message.
Add pci-of.c and use platform_pm_ops to handle the PCIe WAKE# signal.
Rewrite the commit message.

Changes in v7:
Move PCIE_WAKE handling into pci core.

Changes in v6:
Fix device_init_wake error handling, and add some comments.

Changes in v5:
Move to pci.txt
Rebase.
Use "wakeup" instead of "wake"

Changes in v3:
Fix error handling.

Changes in v2:
Use dev_pm_set_dedicated_wake_irq.

Jeffy Chen (3):
  dt-bindings: PCI: Add definition of PCIe WAKE# irq and PCI irq
  of/irq: Adjust of_pci_irq parsing for multiple interrupts
  PCI / PM: Add support for the PCIe WAKE# signal for OF

Manikanta Maddireddy (2):
  arm64: tegra: Add PCIe port node with PCIe WAKE# for C1 controller
  soc/tegra: pmc: Add Tegra234 PCIe wake event

 Documentation/devicetree/bindings/pci/pci.txt |  8 +++
 .../nvidia/tegra234-p3737-0000+p3701-0000.dts | 11 ++++
 drivers/pci/of.c                              | 63 ++++++++++++++++++-
 drivers/pci/pci-driver.c                      | 10 +++
 drivers/pci/pci.c                             |  7 +++
 drivers/pci/pci.h                             |  8 +++
 drivers/soc/tegra/pmc.c                       |  1 +
 7 files changed, 105 insertions(+), 3 deletions(-)

-- 
2.25.1

