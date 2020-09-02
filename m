Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6643D25B3F6
	for <lists+linux-pci@lfdr.de>; Wed,  2 Sep 2020 20:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbgIBSml (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Sep 2020 14:42:41 -0400
Received: from mail-bn8nam12on2061.outbound.protection.outlook.com ([40.107.237.61]:44544
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726821AbgIBSmk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Sep 2020 14:42:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N6OQTgF7xlhq0xRGiYXgQEyeodYABp8HHvQo7CUSXGpPA3/t/ZjeeagZfzmfmDMtATTBJ65l5yHEclt6RuaxM2cFZIsB2ff6ivmp12uOMqUezIidgHTuRHmgv/+E3VRXom/+aA50kP4lqTS4X5WZq6+63bIsPerpagTWbDVAnIPrsICMPSN2ISJTPXSfQr2wbXlQ0fMWKKZ+BnR9hOi7RkHBRdPv+O7pkfixo1ycMR2P2/qHUYrb2CIExTknGEaJrNWsjLHQSKxOP4f4ifY2GNgrDd5/ZXSxpdMzCi16ftTMFYM510QAPaaO1yQh8m683TCdgmmSfKX/O1nqOAn1KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EEq8BsLpjSmQdREee45OvrsAE/IfaZQkxmehI6ZK/uA=;
 b=jOrpkAs37CiMBkOe2PBsf+8dZQhrDFzcZU+Tau8oI3RpbGuhdNwRPSCcbEtqzOYWPtIh1yxoiZ2jaXm2Dk08rDTAkgp/thx+TUDjn60PtxbevXkbywt0V3erq8F1HNDgrg26I9Qa31IjiYfRvpoTGbfPNf6WvCRCNVyJimu0w+jP9J78g3mawyVjn4c5FTRlJJUJvxd+01UeRmjm8t6gvfnJe/nee4PVfU/pF5RElNWit0b1bxxPJ5v/pjGHKkF87Igmufv5YtWF1idW+O9rYgRItfxwVTrXXrVhwh634A6ioSF4QsGE5eAkIm/KQAFaOMbA7dD/fnRUHKxSDeM8Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EEq8BsLpjSmQdREee45OvrsAE/IfaZQkxmehI6ZK/uA=;
 b=IDnsXWyBDsmlO/Qhnz8xsQ9SXvwgbNkLCcdhqU9JWQxbdA2rDConLS1CPkFMEvuB0Szq4TeD8wabqOeulthizJGyNXyT0Idf4zavtc83l/0P/wSTa/wXTnBPQ8vVUQMklraQYCNwu/F7p4umoAXtCk+IMODPlzGXaRWpsVsXO0g=
Received: from BN6PR06CA0012.namprd06.prod.outlook.com (2603:10b6:404:10b::22)
 by BYAPR12MB3637.namprd12.prod.outlook.com (2603:10b6:a03:da::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.24; Wed, 2 Sep
 2020 18:42:37 +0000
Received: from BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:10b:cafe::c6) by BN6PR06CA0012.outlook.office365.com
 (2603:10b6:404:10b::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend
 Transport; Wed, 2 Sep 2020 18:42:37 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT047.mail.protection.outlook.com (10.13.177.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3326.19 via Frontend Transport; Wed, 2 Sep 2020 18:42:36 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 2 Sep 2020
 13:42:36 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 2 Sep 2020
 13:42:36 -0500
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Wed, 2 Sep 2020 13:42:35 -0500
From:   Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To:     <amd-gfx@lists.freedesktop.org>,
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        <linux-pci@vger.kernel.org>
CC:     <alexander.deucher@amd.com>, <nirmodas@amd.com>,
        <Dennis.Li@amd.com>, <christian.koenig@amd.com>,
        <luben.tuikov@amd.com>, <bhelgaas@google.com>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Subject: [PATCH v4 0/8] Implement PCI Error Recovery on Navi12
Date:   Wed, 2 Sep 2020 14:42:02 -0400
Message-ID: <1599072130-10043-1-git-send-email-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 985e993c-bb25-44bd-9c36-08d84f6ff687
X-MS-TrafficTypeDiagnostic: BYAPR12MB3637:
X-Microsoft-Antispam-PRVS: <BYAPR12MB36379FFAD8A03C805166CAE5EA2F0@BYAPR12MB3637.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:813;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r+kcD54r1T6QFRhtFzZLaUj7lYWFZ9/BNp11U6ueEZ3eLR1+aMj+MiSSJA78m6FsAFAW2jrKH0jL7umV2FEnPb7gbYfmcTYHqLnAuP0mouFpUj7s4Dl30n+KAwJmxgI6QghTZWxR9YFa1O6xHbJC9Z7D4uXYyhIbnp/DIQGLmOuHC3tTDkYjw9aLSMDskTxbV2slw9SiWrKeQE+L8TmGaoRtbezJQmboIfIDcCaZTRF6QgPXqquAJGPyQoUqvQKkl1n0QLdf/DLrsHAjk/liK8KH59dvAP6H4RalZnbwAk59PwqaE05w/OzpefggJK8np0u33oa/N5rxApviDheO+DytrOVnDX6+YeklQZzo7BtJr2lldQWXl1oUkwprXrorklDzmaU5lxBnFjvfxcpadvxh9LitmCxzSq5uMSngME7IIDTBOlQw560D2RFfez8SVuKo4PgYg5ougl/bwgR7IZct4rjB9WCNwiUKCMRL4EY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB01.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(136003)(39860400002)(396003)(376002)(346002)(46966005)(316002)(478600001)(47076004)(110136005)(82740400003)(36756003)(5660300002)(356005)(81166007)(83380400001)(8936002)(54906003)(8676002)(82310400003)(426003)(86362001)(70586007)(70206006)(966005)(336012)(6666004)(186003)(7696005)(44832011)(2616005)(26005)(4326008)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2020 18:42:36.8552
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 985e993c-bb25-44bd-9c36-08d84f6ff687
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3637
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Many PCI bus controllers are able to detect a variety of hardware PCI errors on the bus, 
such as parity errors on the data and address buses,  A typical action taken is to disconnect 
the affected device, halting all I/O to it. Typically, a reconnection mechanism is also offered, 
so that the affected PCI device(s) are reset and put back into working condition. 
In our case the reconnection mechanism is facilitated by kernel Downstream Port Containment (DPC) 
driver which will intercept the PCIe error, remove (isolate) the faulting device after which it 
will call into PCIe recovery code of the PCI core. 
This code will call hooks which are implemented in this patchset where the error is 
first reported at which point we block the GPU scheduler, next DPC resets the 
PCI link which generates HW interrupt which is intercepted by SMU/PSP who 
start executing mode1 reset of the ASIC, next step is slot reset hook is called 
at which point we wait for ASIC reset to complete, restore PCI config space and run 
HW suspend/resume sequence to resinit the ASIC. 
Last hook called is resume normal operation at which point we will restart the GPU scheduler.

More info on PCIe error handling and DPC are here:
https://www.kernel.org/doc/html/latest/PCI/pci-error-recovery.html
https://patchwork.kernel.org/patch/8945681/

v4:Rebase to 5.9 kernel and revert PCI error recovery core commit which breaks the feature.

Andrey Grodzovsky (8):
  drm/amdgpu: Avoid accessing HW when suspending SW state
  drm/amdgpu: Block all job scheduling activity during DPC recovery
  drm/amdgpu: Fix SMU error failure
  drm/amdgpu: Fix consecutive DPC recovery failures.
  drm/amdgpu: Trim amdgpu_pci_slot_reset by reusing code.
  drm/amdgpu: Disable DPC for XGMI for now.
  drm/amdgpu: Minor checkpatch fix
  Revert "PCI/ERR: Update error status after reset_link()"

 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 247 +++++++++++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    |   6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    |   6 +
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     |  18 ++-
 drivers/gpu/drm/amd/amdgpu/nv.c            |   4 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c         |   4 +-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c     |   3 +
 drivers/pci/pcie/err.c                     |   3 +-
 10 files changed, 222 insertions(+), 79 deletions(-)

-- 
2.7.4

