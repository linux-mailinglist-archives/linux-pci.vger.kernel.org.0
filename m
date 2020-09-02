Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD42B25B406
	for <lists+linux-pci@lfdr.de>; Wed,  2 Sep 2020 20:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbgIBSm4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Sep 2020 14:42:56 -0400
Received: from mail-dm6nam11on2071.outbound.protection.outlook.com ([40.107.223.71]:20001
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728083AbgIBSmw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Sep 2020 14:42:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J84yK9jfxcxFAMl75cvJHeRdH6yCb13Gt5t57kKIu4vR+BaAQWzG6MI4lAwA/djxdw41scvPoBwy9N6hkYU1x89NV9TBcuzGKOvKXFgQFLB+cZGCoqVfHuIF45PGMu7zRlgx2LCffOo5okOtbDJgnsPX43NwE6IYaVLTpddTsYNGnlzlLwtbuosvy1of+Bg5VwBRlrzS9KO7KeoqlYgTpQWp1nzvgYjDkGgD5d9jaB7e2GcU/1R004CGM/wNBIm2Ar0Z+ZlcZtE8bOmTMMMTCs8lBajnzVwjc63pplgfhNL/ccMp8gHVyp9IQ+dmxSy0Xbc4SFp2egsh2S70sBpJMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oYkafzZtZql9EMHE6JVbCEySmbXFmYAYmYbnZ3D6Usg=;
 b=N+Ac/Rz06Nl6TjAR4tEd8VUJBcesPISm8QPZ0X3xFcnLxZG8/zYtqvpres1ZoJ0HpFFAfzdr+LhdwKo2hW2Jxf5rFvIqifwf/vz5w3PIMqDFv/AUDo/F5OYROJd/JGk9YPM0jpi/Pr+p2uUH+L3nk1DzCGBGvAH6Rx5r87MPUjXD34SDG5v3OrJanQ6pZ5KBwi6YjzEsHTk/3zUuaEckAmSxqQQuyYSwGixsbUBROiTc+gAyUGDn2v7yJZttk7nUI/4uaclrFiDmTs/t0laRmrovBB+P3rywZyFSCujFUR+1WfO8LX8HS3BT5grOAukhoEHMrE+AErdNz8hOAXhS0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oYkafzZtZql9EMHE6JVbCEySmbXFmYAYmYbnZ3D6Usg=;
 b=yVmu1vOF1uTqFL9g5QwQPBf0gjDkWPEaYQ0p9MqANnRk+LzZ+5f6zOGTymYJnD09mMjJD9u0CBnOOODyCs2dVruoMhT8t3jBUGtepTQFLTVypo0xwqhmtQ8ux7oLLxT0eQmX4S0HkuHhsBX5t5dLXQXRtTdDR5r1kmZiqcvuIpk=
Received: from BN6PR22CA0026.namprd22.prod.outlook.com (2603:10b6:404:37::12)
 by BN6PR12MB1555.namprd12.prod.outlook.com (2603:10b6:405:5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Wed, 2 Sep
 2020 18:42:46 +0000
Received: from BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:37:cafe::c2) by BN6PR22CA0026.outlook.office365.com
 (2603:10b6:404:37::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend
 Transport; Wed, 2 Sep 2020 18:42:46 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT053.mail.protection.outlook.com (10.13.177.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3326.19 via Frontend Transport; Wed, 2 Sep 2020 18:42:46 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 2 Sep 2020
 13:42:46 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 2 Sep 2020
 13:42:45 -0500
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Wed, 2 Sep 2020 13:42:45 -0500
From:   Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To:     <amd-gfx@lists.freedesktop.org>,
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        <linux-pci@vger.kernel.org>
CC:     <alexander.deucher@amd.com>, <nirmodas@amd.com>,
        <Dennis.Li@amd.com>, <christian.koenig@amd.com>,
        <luben.tuikov@amd.com>, <bhelgaas@google.com>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Subject: [PATCH v4 7/8] drm/amdgpu: Minor checkpatch fix
Date:   Wed, 2 Sep 2020 14:42:09 -0400
Message-ID: <1599072130-10043-8-git-send-email-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599072130-10043-1-git-send-email-andrey.grodzovsky@amd.com>
References: <1599072130-10043-1-git-send-email-andrey.grodzovsky@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8dbddbb-ad01-4652-07a0-08d84f6ffc4f
X-MS-TrafficTypeDiagnostic: BN6PR12MB1555:
X-Microsoft-Antispam-PRVS: <BN6PR12MB15556A4F2861D9FCB41DC53FEA2F0@BN6PR12MB1555.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SLWsbw86KDWBpnu8Kkc2fjNIQkz67es/7oKtAq0UthIxzHlGi2SZasLPf56/Lb+DgEPiPntjgqgxBoD1JyO92INtYp2bUe2JcGQyRZy7egIVrItqIDk8axPdDesoqUcX0wUbLAi5jvoT3fL9H35Drx0l8RGTemY8hSIJqYWDXFrWglhRCm+n9FoRa778rgx+wQxetAzrVlaClQE0LSBhhODWZyaNBZAPq7F8d53NqfWolqe8ueH1CHjDUvj1QMdUX3UyysoqRsJyDC3O3OiUWMShz33/WoZ/th5KfjzAW4ki2ii04rlw+oxTnCVlMzF6skPFv2ubmxc7nsT5AzHl87WlaC8R7QjFU+SG0i16/U9HrPEUWYBWabt/4z1MHpvW+ZAlAfZwZ5yeQu3DlVUStA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB02.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(136003)(396003)(39860400002)(346002)(376002)(46966005)(5660300002)(186003)(83380400001)(81166007)(336012)(82310400003)(8676002)(26005)(478600001)(426003)(2616005)(70206006)(7696005)(6666004)(44832011)(8936002)(4326008)(110136005)(36756003)(2906002)(70586007)(82740400003)(47076004)(86362001)(356005)(54906003)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2020 18:42:46.5427
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8dbddbb-ad01-4652-07a0-08d84f6ffc4f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1555
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 4d4fc67..3748bef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -353,7 +353,8 @@ uint32_t amdgpu_mm_rreg(struct amdgpu_device *adev, uint32_t reg,
  *
  * Returns the 8 bit value from the offset specified.
  */
-uint8_t amdgpu_mm_rreg8(struct amdgpu_device *adev, uint32_t offset) {
+uint8_t amdgpu_mm_rreg8(struct amdgpu_device *adev, uint32_t offset)
+{
 	if (adev->in_pci_err_recovery)
 		return 0;
 
@@ -377,7 +378,8 @@ uint8_t amdgpu_mm_rreg8(struct amdgpu_device *adev, uint32_t offset) {
  *
  * Writes the value specified to the offset specified.
  */
-void amdgpu_mm_wreg8(struct amdgpu_device *adev, uint32_t offset, uint8_t value) {
+void amdgpu_mm_wreg8(struct amdgpu_device *adev, uint32_t offset, uint8_t value)
+{
 	if (adev->in_pci_err_recovery)
 		return;
 
-- 
2.7.4

