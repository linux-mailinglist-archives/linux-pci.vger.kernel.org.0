Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 381D22E7DDA
	for <lists+linux-pci@lfdr.de>; Thu, 31 Dec 2020 04:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgLaD1d (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Dec 2020 22:27:33 -0500
Received: from mail-bn8nam08on2063.outbound.protection.outlook.com ([40.107.100.63]:4449
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726322AbgLaD1d (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 Dec 2020 22:27:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RAFQjYLxHuslNQiDucCR8ZcwiswRj3SVNOfYV0FP8hyTYndY7T6bYoEwEsQjdFtwTkjLhha9ocGrzEsoWuSPlAOy+/TpfEpnTGLwA16kJfWtffJoq0FwIv4BfmAkNGhsVCNCpjnpQIeL9t5r6RNptuw8y/uAxMTptbKR2UqZRr4dS2KRVqswo0qnrAirZBFGdPOOwNvBeZ1rfOKI45vf0GNAhCvBRobg7Tm8QpF82x9kb0su4kUOQivFB3a8q6dSAUlecb0JtbEB6bqEfWw62Zp0P/RRg3/CYCvsGUkXjE3vjV2lc9n8ncENNb5EKFZTGHod+qWWMpXZacUEEBROYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s1JMoEyJZACECzw+eaig2YlN7Q7EVA5CrpghoPw+GYQ=;
 b=b36Unr483vIUOHpoGAcXAryZrfBuHiTzSnHETrBtIVtswS4gQYx92HDaWEiA+2Qfd/NdrlrkNGuc88E8IJSNe5dfhRS+FL9AXXEQvyxYkj9+d2bFBkZ+IvEUA9DklYMKiTL1VdPjLc479dcdu16pxoOgCUHPp5Qkn9hxd8vmc32apjuX7E2BIQnYph2v9BJfdVQixqhlzuGLssBXHWpgLx1fqfBxfmj/dKSMf7FWbWy+dtgPN0UMIyyZqISOYpTqmmQ7q/VOV13aJpsqXYVe0Y4S6QJSME8mMC/KJJ3Rn5i0vngx8Kxsq8Vgb9po3oqxFnQq/O/MjKwnQx1Pk+U3Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=microsemi.com
 smtp.mailfrom=srdcmail.amd.com; dmarc=fail (p=none sp=none pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s1JMoEyJZACECzw+eaig2YlN7Q7EVA5CrpghoPw+GYQ=;
 b=p///5hLgVKz8N+vIbox5OY0ABCvQaj/kfJBu8VrjsSBTzKf0SvxJP+QQZPAOasLXmZoJe5txNDIegOH0CGGNo8aVl04rLrAsdcHrAmgYlQZBvzPE8t6dbTg6ATzGH8nhjL68+K+qYIFLI5xg82zZvb8AuIHQzGsHY6kedseefO0=
Received: from MWHPR04CA0049.namprd04.prod.outlook.com (2603:10b6:300:6c::11)
 by MW3PR12MB4571.namprd12.prod.outlook.com (2603:10b6:303:5c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.28; Thu, 31 Dec
 2020 03:26:36 +0000
Received: from CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:6c:cafe::f2) by MWHPR04CA0049.outlook.office365.com
 (2603:10b6:300:6c::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.20 via Frontend
 Transport; Thu, 31 Dec 2020 03:26:36 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=srdcmail.amd.com; microsemi.com; dkim=none (message not signed)
 header.d=none;microsemi.com; dmarc=fail action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: srdcmail.amd.com does not
 designate permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT022.mail.protection.outlook.com (10.13.175.199) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3700.29 via Frontend Transport; Thu, 31 Dec 2020 03:26:34 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 30 Dec
 2020 21:26:33 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 30 Dec
 2020 21:26:32 -0600
Received: from atlvmail01.amd.com (10.180.10.61) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Wed, 30 Dec 2020 21:26:32 -0600
Received: from srdcmail.amd.com (srdcmail.amd.com [10.237.16.23])
        by atlvmail01.amd.com (8.14.4/8.14.4) with ESMTP id 0BV3QgeN030168;
        Wed, 30 Dec 2020 22:26:43 -0500
Received: from srdcws824.amd.com (srdcws824.amd.com [10.237.59.99])
        by srdcmail.amd.com (8.14.7/8.13.8) with ESMTP id 0BV3QSNL031410;
        Thu, 31 Dec 2020 11:26:28 +0800
Received: (from weisheng@localhost)
        by srdcws824.amd.com (8.14.7/8.14.7/Submit) id 0BV3QP70026511;
        Thu, 31 Dec 2020 11:26:25 +0800
From:   Wesley Sheng <wesley.sheng@amd.com>
To:     <lorenzo.pieralisi@arm.com>, <robh@kernel.org>,
        <bhelgaas@google.com>, <gustavo.pimentel@synopsys.com>,
        <andriy.shevchenko@intel.com>, <treding@nvidia.com>,
        <vidyas@nvidia.com>, <eswara.kota@linux.intel.com>,
        <hayashi.kunihiko@socionext.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <wesleyshenggit@sina.com>, <wesley.sheng@microchip.com>,
        <wesley.sheng@amd.com>, <wesley.sheng@microsemi.com>
Subject: [PATCH] PCI:tegra:Correct typo for PCIe endpoint mode in Tegra194
Date:   Thu, 31 Dec 2020 11:25:39 +0800
Message-ID: <20201231032539.22322-1-wesley.sheng@amd.com>
X-Mailer: git-send-email 2.16.2
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 423507ea-f59d-46d8-9c6b-08d8ad3bdfd7
X-MS-TrafficTypeDiagnostic: MW3PR12MB4571:
X-Microsoft-Antispam-PRVS: <MW3PR12MB4571A65B339AF44415A84004F0D60@MW3PR12MB4571.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uwr16mtHI1GmKGsvfM52yxO/nO/n0ErNgkQO/2qlfJhe/76hnM5lbMG5wdexpN7RgNSInGtWivV4rulP/6mhJ86Fz+Vpje0k2NiK9xry/1NGOhq2ZC0Vsy8SNy+AV4ZckG8r6y9l4KlbKEmrv8JJn7oHtluZO7mBmEU5ignlTa4+ASpCPp4rHia29joHPjHK+SVVKQDyXO0pWEKneZPOX5eIpIQ2SjX8Wl8Ee/nqO72oAJ409UPesoMXAKmsh3HUFycJD55QgrKUXRSOg7mV3u2wO0eylWvt/XnRnkX1LcXfjcvuqZ8P2GXxhuyE65Is7+vJXAortwL7OPIliRVPNQ3q/bdHvhAVfVftpqu7P7k3vgvc7ux24cjHxHPpVZ5XOwkPaY3aUx6HvE/aYhHjViRoqdBeUUfYwEjGkx9GfUeUZRTjN28NOmV8YD7iizfgf20I3OW4Z3VAtKi6bp/wvJFLUKCqKZTVu+mYdRMhQ8dLRiqzFl8rve9H5QqCqWFX
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB01.amd.com;PTR:ErrorRetry;CAT:NONE;SFS:(4636009)(346002)(396003)(39860400002)(136003)(376002)(46966006)(110136005)(356005)(2906002)(82310400003)(6666004)(2616005)(921005)(8676002)(498600001)(82740400003)(35950700001)(1076003)(5660300002)(426003)(83170400001)(42186006)(47076005)(4744005)(336012)(4326008)(8936002)(44832011)(81166007)(70586007)(70206006)(26005)(316002)(7416002)(54906003)(83380400001)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2020 03:26:34.1311
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 423507ea-f59d-46d8-9c6b-08d8ad3bdfd7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4571
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In config PCIE_TEGRA194_EP the mode incorrectly referred to
host mode.

Signed-off-by: Wesley Sheng <wesley.sheng@amd.com>
---
 drivers/pci/controller/dwc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 044a3761c44f..6960babe6161 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -273,7 +273,7 @@ config PCIE_TEGRA194_EP
 	select PCIE_TEGRA194
 	help
 	  Enables support for the PCIe controller in the NVIDIA Tegra194 SoC to
-	  work in host mode. There are two instances of PCIe controllers in
+	  work in endpoint mode. There are two instances of PCIe controllers in
 	  Tegra194. This controller can work either as EP or RC. In order to
 	  enable host-specific features PCIE_TEGRA194_HOST must be selected and
 	  in order to enable device-specific features PCIE_TEGRA194_EP must be
-- 
2.16.2

