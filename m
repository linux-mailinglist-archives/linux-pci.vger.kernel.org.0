Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 311E93CAE8B
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jul 2021 23:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbhGOVex (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Jul 2021 17:34:53 -0400
Received: from mail-bn7nam10on2081.outbound.protection.outlook.com ([40.107.92.81]:40970
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229591AbhGOVex (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Jul 2021 17:34:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VWOamikFG05vbH8YpGywf6JylN73h6WSNK25bgbWUjcCKW0nXMqVLm1F+Fs4U4d0vma9g35bYxPSF9TgVg59Wk9j2sEMDQgLzKFOTMOUwayLts1InyyQ+UmmdH3r8SXO5HNhuvCk3pyWN57+CZoU2joG+F0Qu7McioafxqZdNzAEJb0wdChHHKzlBf7RBDCEmlTMEsQwSmbe+E4ND0Y9NOmDnYOrhW+yYSdIP75RSq3jPVCj14K5IijNUp28vM9hA8JNewvUmqK9DLVj4FGVp0H1iCZoLkCn93HwA8bDju/QA3l/bhifJREH/+OQiQPodo4IkQk2jmnRrCNWNtMlqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b0M2AZ025wOZcjxvmm+z1A39NkclVkTFbr4SxDTmWpo=;
 b=Iq7osIngsatru4G5dv+E2STA7YANgGBs61WN8ufVm+BSBfUqsKVSnqGsR7yAL5krcz+rhNgtO8l+Zo2MiF/Fi6HpfrkyP9j4R53v+EcM1Wif+E4NA2wq341OY4reHm4Eek84Lu+ViOL7wztyGBIUTKvxt0giW9nBL6jj+Q2vnxqEh6scnh/YxHRDrCxwHitQ0n42HAEGI3M/fu42x0u42866r3SPvLqJUDiZV1uUoxG8f8htpyH9bsDJodLym9XKjU9I/M2k+sKDAbKtqFfcwlh6srMDDLuMUu/0QV10KS8YNVjPf8Re5q4mynASzjzD0Tdl+FuWCBou8axu+PEJgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=rjwysocki.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b0M2AZ025wOZcjxvmm+z1A39NkclVkTFbr4SxDTmWpo=;
 b=dXltwKYYzvpbkOKQVEzHXCpfXSg0Rcdi2aETWxYKRtmO9zqsepmiqpEmREGbFECotTxn3fR1pNWWFLGeIWJHLPd2O7B531muAoolK1HfLrMHaETKGJiYjpZo0hNEvxh0Hb8Ie1apQk3dMfHitS7GCKvhKA7UsVZvaj+FY1HHgrhR5eeTvEynBYGbZvTS6EvRfWnZMVJhUGlXpTGZSc6QJOiLDtUkArRSgjO1VqfWPtX7R9wXObxmJO/3dHzZqrT8SuDZ2F5hVFagJ5anN8ahjAqiNX37rjmo36sUx8VG844+1izKnj5FYIxDWJUzSsQHw79sL6Ph+lHl4nSsZ4DGyQ==
Received: from BN6PR22CA0031.namprd22.prod.outlook.com (2603:10b6:404:37::17)
 by CY4PR1201MB0231.namprd12.prod.outlook.com (2603:10b6:910:24::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.23; Thu, 15 Jul
 2021 21:31:57 +0000
Received: from BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:37:cafe::9f) by BN6PR22CA0031.outlook.office365.com
 (2603:10b6:404:37::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Thu, 15 Jul 2021 21:31:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; rjwysocki.net; dkim=none (message not signed)
 header.d=none;rjwysocki.net; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT056.mail.protection.outlook.com (10.13.177.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4331.21 via Frontend Transport; Thu, 15 Jul 2021 21:31:57 +0000
Received: from SDONTHINENI-DESKTOP.nvidia.com (172.20.187.6) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 15 Jul 2021 21:31:54 +0000
From:   Shanker Donthineni <sdonthineni@nvidia.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
CC:     Alex Williamson <alex.williamson@redhat.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kw@linux.com>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sinan Kaya <okaya@kernel.org>,
        "Amey Narkhede" <ameynarkhede03@gmail.com>,
        Shanker Donthineni <sdonthineni@nvidia.com>
Subject: [PATCH v11 0/8] PCI: Add support for ACPI _RST reset method
Date:   Thu, 15 Jul 2021 16:30:52 -0500
Message-ID: <20210715213100.11539-1-sdonthineni@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47bf100c-e473-41a4-c05f-08d947d7f93b
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0231:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0231E2D4F0B3BB44E495D7E8C7129@CY4PR1201MB0231.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IzduDG5VGMtIOA4nMoKR5idY4IlQDmbkoAZCuYLRaQ+9Kh5Gg5v4Bu1jX4zwlcJap8R05bDNw2sMmRQDutkTCihO7+PIxoZzgNJTjvXUcl5vdmJwFeYrudKvbGQmz6P8V13Sz9gu0cnWm/82uZihrv2ZYJBPFU1Hgi9XfPOnokwICt0rBvwVjphZ1l+wAk0YszOO5UjXeYhtDzeUtVp3IAHR81G6KLXU7IypRcYp0eJiZ+W91vt19gDdyCf4KAPZLgWJ0ZuemDdkfIq/uDC55OB+yTgDevrJkJZ1IntW2qI5cpqKfHN1JbwZXvbpPqmawSBe5QDD9ZBsQYUWIqp3ub52uWWA51XfFnL2Uh3XaxvSKTV9D5PxVTjRIt57+2M7PlwzoOaP7vx3tuz0Heda46eXbBRP6qLNm1IT7Z407nmHbFYHZlrVmFVqEAGvbhoYKWmp5qrd5fZx6czyvHtMwJMirk2owl9G4MqXeL7g/RgfRmyiHmoFGQLs3JpVoiBxsbHRlRzQ3E7e/D6RIAvrLDWG+tMgibKh4ozCPBvVAsud/qICdwsu7Ju02Dk66PNjdWoi0YW3aeA0GjH+xlD5g+TYiTjw++EE4Af4iFFL2KSsl8N9Vr8dwtjsPxJhMGwPoo52YF0OmvwJyr2Vkw+QWNqXOcNDzM0JtwnvGJA261S6OSpMxlFHbYauTPyxHA6IBO5+mMGkk3hDEg5GaiwlQUJVV50jy59AbCwIX5eal+o=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(376002)(346002)(396003)(136003)(36840700001)(46966006)(70206006)(54906003)(70586007)(82740400003)(86362001)(2906002)(426003)(336012)(2616005)(186003)(478600001)(16526019)(6916009)(36906005)(4326008)(82310400003)(34020700004)(36756003)(26005)(36860700001)(316002)(107886003)(7696005)(356005)(83380400001)(8676002)(7636003)(8936002)(47076005)(1076003)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 21:31:57.2170
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47bf100c-e473-41a4-c05f-08d947d7f93b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0231
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

