Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64C633CB9B4
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jul 2021 17:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240282AbhGPP1X (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Jul 2021 11:27:23 -0400
Received: from mail-co1nam11on2076.outbound.protection.outlook.com ([40.107.220.76]:7367
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237326AbhGPP1W (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 16 Jul 2021 11:27:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ix2BoJ55nbqVL2Rjuco7JTiws6+Xg65mL4eZr3DKCSxkMueVvc/u3OKwT7s8BmcLTbVmMWBdQqnu7tIMGZcJreLh/i6E/NIKpUcFjT4+hHfI+nr+e02RWZ1CAlWlCaKCLVPxkusNbc5GdB5Vo5JoXlk5ZhxS7WWEDNOgXmla/yT18RYDbd1zZgy3Ht7T6ELp54Ck2UzfQ9VfP/R4eRuu7vVmzxRnAlIoz6RU4R8bLIyEeuxESfatGu89Muan5vllXxy0ZblqCMJlSOrA14oeRxQR0MwdHy6IaYTvo1UYbvIJ5Vr3Bk1pGxeXNw8b+siiGb8NqRcmjk0XL1vKUcXEOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RmA+RxawcPgZzqionGf+v8VkG9QnDd971BMkCX6gr/4=;
 b=hBk0qm69SP2icNo3HE7+CnEXAo8AUqYufELDDXTO6WrGxHxa9+jRC6Suir8lRATg9MvaGGQDg77HarXPgV6w7sm687xXxcaW70ow7X9tsSjPOaA1Yqy09xHp3/hNOwhzt34LiM/tnn6RbRBxg7w/1mghwtemhmyy6xDN/JLpjAWuysq/EcMI9bNtb5QJCcKA4RnYHdp147MGyy5J1H0JefDUvEtOanSaF6hzt0cgG4a+9T7ZBDYI6XxbJ38hkgQMUqG+USQTi03vYOCzVS9ayxYb9EJFBDzVyZA97ZC+FZVms20vLs+J9B3bVk/oXNiYAMkgrf6j1ntr3MdrNmFt0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=rjwysocki.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RmA+RxawcPgZzqionGf+v8VkG9QnDd971BMkCX6gr/4=;
 b=JfUJOEe1WUu6r2OBTsPags8hQvgn+I0DUiEuNUPgCbeEHNHEsnqTPOXsfpp6jy7Pbp5Qn0esZhbEaM7kENVXekrMVGd3dr48To3rLr78YsmkV+rhYWXzQ24hZDVaIoNAOYE4FVSTgSPOm6yfIVFdAQSjj7ry1rblLa+mESeX5gh8ht0G7eKWMae+I5R8+zPC1JpXwqs7MCqMge9vSN3/ZGdYBn+eWPoMugpVpG8j/Y+6bGFVGdug2zHdEHAwXggLB1U+wfxGofr+y0hJFrI+P7biim5zUIQ3s6FJm81ux5YhfAwze7sI+uwZlPC2Swg/r8w2b96pCrdK3jHk+pjo+w==
Received: from BN6PR13CA0035.namprd13.prod.outlook.com (2603:10b6:404:13e::21)
 by MN2PR12MB3566.namprd12.prod.outlook.com (2603:10b6:208:cc::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Fri, 16 Jul
 2021 15:24:26 +0000
Received: from BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:13e:cafe::15) by BN6PR13CA0035.outlook.office365.com
 (2603:10b6:404:13e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.10 via Frontend
 Transport; Fri, 16 Jul 2021 15:24:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; rjwysocki.net; dkim=none (message not signed)
 header.d=none;rjwysocki.net; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT058.mail.protection.outlook.com (10.13.177.58) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4331.21 via Frontend Transport; Fri, 16 Jul 2021 15:24:25 +0000
Received: from SDONTHINENI-DESKTOP.nvidia.com (172.20.187.6) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 16 Jul 2021 15:24:23 +0000
From:   Shanker Donthineni <sdonthineni@nvidia.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
CC:     Alex Williamson <alex.williamson@redhat.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kw@linux.com>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sinan Kaya <okaya@kernel.org>,
        "Amey Narkhede" <ameynarkhede03@gmail.com>,
        Shanker Donthineni <sdonthineni@nvidia.com>
Subject: [PATCH v12 0/8] PCI: Expose and manage PCI device reset
Date:   Fri, 16 Jul 2021 10:19:38 -0500
Message-ID: <20210716151946.690-1-sdonthineni@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 924bc87c-908d-4e86-3e8c-08d9486dcc0a
X-MS-TrafficTypeDiagnostic: MN2PR12MB3566:
X-Microsoft-Antispam-PRVS: <MN2PR12MB356684FF25F7820E09B0F86EC7119@MN2PR12MB3566.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T39dloRwcYk3rRs1ssljsYw0odfR2yZS1SU+xMTyLVOkEJDLEwAv80kFC6wis1RXr7UvnDOJ/TCPL/RB/LxunUkKNBK3EGNOGfRmyBhnF0nw3Mo84Sah1C+uJ8EN4tnaLrmOYOgLgZVqgwg6PHtvct8AsZBXnuzSfEdsKUgtjOeRSsKgNeP5abLmDqTGoe6c66b6WEHc4RnDaOchnqKerq5UMlNnu5+CVTBOxnhZDOSXcRhxWaAfQy/FRfDNef8mMcL3vUMiQ0xVsLEGUfP2gu59R4rAnFVT/kn4GGQi/pgmgng4bnLj0ePqO8AYQ77VnLfMc1jG5ReeBtrdTVwYa3Bgcf864hP9HcIplonNxE9G0pB8yKAFleFvn7H2pmuoy3qjAZMtUbNzj4mICNvK+uCyPqI74y6qjubAiUdB4dn6HB3K+VACWyqtVYcHAx+lvTBe02StbJ3NTJw9f+xqjsT9yell2cM+kmJtHKByNOVCqt0LVA9ll9c267Agf566CfA7kTEgWmC3yX1mobXfbe+WnjZrDRj9fcXFS3g8btqMCGl/me9v/2t7In1P2WqwZeylBvl1BjZ+V0CTTJOTYUbVLn6UrDAyih65CxXw0FPO6GQ2PgedoNlzG9yldqjs81o4fahm/hhYOZr/nDDEBiqZyhuh92Mr4hh/cmsiLZZyX+fZxQDlbmIlD82pMt5oShgQoJNUyi1IS0Ys5kXk6rPc3SNuG+rpRz2Za6YX8ik=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(346002)(136003)(39860400002)(376002)(36840700001)(46966006)(16526019)(186003)(26005)(4326008)(36756003)(70206006)(8676002)(2616005)(426003)(336012)(6916009)(36906005)(8936002)(2906002)(47076005)(54906003)(7696005)(316002)(70586007)(82740400003)(107886003)(5660300002)(1076003)(34020700004)(6666004)(82310400003)(356005)(7636003)(36860700001)(478600001)(86362001)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 15:24:25.9745
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 924bc87c-908d-4e86-3e8c-08d9486dcc0a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3566
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCI and PCIe devices may support a number of possible reset mechanisms
for example Function Level Reset (FLR) provided via Advanced Feature or
PCIe capabilities, Power Management reset, bus reset, or device specific reset.
Currently the PCI subsystem creates a policy prioritizing these reset methods
which provides neither visibility nor control to userspace.

Expose the reset methods available per device to userspace, via sysfs
and allow an administrative user or device owner to have ability to
manage per device reset method priorities or exclusions.
This feature aims to allow greater control of a device for use cases
as device assignment, where specific device or platform issues may
interact poorly with a given reset method, and for which device specific
quirks have not been developed.

Changes in v12:
        - Corrected subject in 0/8 (cover letter).

Changes in v11:
        - Alex's suggestion fallback back to other resets if the ACPI RST
          fails. Fix "s/-EINVAL/-ENOTTY/" in 7/8 patch.

Changes in v10:
        - Fix build error on ppc as reported by build bot

Changes in v9:
        - Renamed has_flr bitfield to has_pcie_flr and restored
          use of PCI_DEV_FLAGS_NO_FLR_RESET in quirk_no_flr()
        - Cleaned up sysfs code

Changes in v8:
        - Added has_flr bitfield to struct pci_dev to cache flr
          capability
        - Updated encoding scheme used in reset_methods array as per
          Bjorn's suggestion
        - Updated Shanker's ACPI patches

Changes in v7:
        - Fix the pci_dev_acpi_reset() prototype mismatch
          in case of CONFIG_ACPI=n

Changes in v6:
        - Address Bjorn's and Krzysztof's review comments
        - Add Shanker's updated patches along with new
          "PCI: Setup ACPI_COMPANION early" patch

Changes in v5:
        - Rebase the series over pci/reset branch of
          Bjorn's pci tree to avoid merge conflicts
          caused by recent changes in existing reset
          sysfs attribute

Changes in v4:
        - Change the order or strlen and strim in reset_method_store
          function to avoid extra strlen call.
        - Use consistent terminology in new
          pci_reset_mode enum and rename the probe argument
          of reset functions.

Changes in v3:
        - Dropped "PCI: merge slot and bus reset implementations" which was
          already accepted separately
        - Grammar fixes
        - Added Shanker's patches which were rebased on v2 of this series
        - Added "PCI: Change the type of probe argument in reset functions"
          and additional user input sanitization code in reset_method_store
          function per review feedback from Krzysztof

Changes in v2:
        - Use byte array instead of bitmap to keep track of
          ordering of reset methods
        - Fix incorrect use of reset_fn field in octeon driver
        - Allow writing comma separated list of names of supported reset
          methods to reset_method sysfs attribute
        - Writing empty string instead of "none" to reset_method attribute
          disables ability of reset the device

Amey Narkhede (5):
  PCI: Add pcie_reset_flr to follow calling convention of other reset
    methods
  PCI: Add new array for keeping track of ordering of reset methods
  PCI: Remove reset_fn field from pci_dev
  PCI/sysfs: Allow userspace to query and set device reset mechanism
  PCI: Change the type of probe argument in reset functions

Shanker Donthineni (3):
  PCI: Define a function to set ACPI_COMPANION in pci_dev
  PCI: Setup ACPI fwnode early and at the same time with OF
  PCI: Add support for ACPI _RST reset method

 Documentation/ABI/testing/sysfs-bus-pci       |  19 ++
 drivers/crypto/cavium/nitrox/nitrox_main.c    |   4 +-
 .../ethernet/cavium/liquidio/lio_vf_main.c    |   2 +-
 drivers/pci/hotplug/pciehp.h                  |   2 +-
 drivers/pci/hotplug/pciehp_hpc.c              |   4 +-
 drivers/pci/hotplug/pnv_php.c                 |   4 +-
 drivers/pci/pci-acpi.c                        |  38 +++-
 drivers/pci/pci-sysfs.c                       | 107 ++++++++-
 drivers/pci/pci.c                             | 215 ++++++++++--------
 drivers/pci/pci.h                             |  23 +-
 drivers/pci/pcie/aer.c                        |  12 +-
 drivers/pci/probe.c                           |  17 +-
 drivers/pci/quirks.c                          |  42 ++--
 drivers/pci/remove.c                          |   1 -
 include/linux/pci.h                           |  17 +-
 include/linux/pci_hotplug.h                   |   2 +-
 16 files changed, 363 insertions(+), 146 deletions(-)

-- 
2.25.1

