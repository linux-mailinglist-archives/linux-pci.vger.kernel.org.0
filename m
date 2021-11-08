Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67300449E77
	for <lists+linux-pci@lfdr.de>; Mon,  8 Nov 2021 22:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240624AbhKHVyM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Nov 2021 16:54:12 -0500
Received: from mail-bn8nam11on2088.outbound.protection.outlook.com ([40.107.236.88]:48513
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240622AbhKHVyL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 8 Nov 2021 16:54:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FkihcrRvay73wTYdSzC1f2hBT8kgMl61DcVLaDm5gf4cquWdDq142rCJBLWYFBzzIwTuzOIzSjvaUIxqHKWseRMte1o/JqEjoxz6SFXFUKzgYX4JUvXsCITete+8dfHgbA/S6m+0oUtTyXOaZ+VSB5Km68KdGwFIkXvGwqIsijhEDUv/edz+4QvD2PCP0i1bGkQC57eR5QXLZWfCzliClXulOq4EG6xUKaq/k0SAFI88jBIZH8h5DlSFkyRD8sYiLkHEE1JPiQ1y3VMful+gWCNVT7jv8x1ac+6CxeHwXPzCggXsIJAtsk9NfUUU/UeB6dToQrCHWF1JRBUfOjlJxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gCFxtZHioBgTxS7xbEdfHMhcDf400HVw7Pips6zhBt4=;
 b=TR4dtSh6v16T0nzQ68o3wlDzFGa9JlAyT0JVa+ip6V0Tji0g8AgiGSeX8SXMfCaz2YitD+opAjIAhe/JLM0DELr0I8HEdvY1cQgoMA8A0lKGaPlP5VJapf2uBEbNFnRwP38B3bjcu0krNv5+iyN42iKcQ8q+1Nw0ehFYjnZ0MmifdAtWXqa5EEvjoZq+dQUHCPHwzls5X7Y/ZLARrbpNDjmbvfNCSpFyXCQ5VYZe1ZcpZ75cmVC8erAYgTKwz3C/l8Sswqj7cD4vJFrZW27W0IFXiPxEdSk/SaMqPz0kbp3/185SB7XfEuU2B0BQ2yuDDr5wnl7sbBFmS2DrOKI4iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gCFxtZHioBgTxS7xbEdfHMhcDf400HVw7Pips6zhBt4=;
 b=mZLo5tQS+q7VF9jif0HCgQDD2pF0v0iINbrZv4Lp1u5licGharwlqFTGUlqWTX1M/JFCM3WCRKR4z5eGJeimysDQ9wV5HPsE5Vz7LjBMuw7IrX+yG5hSzlRY6F5hSEtktbyWcLI37zACFxDlF/UgIE8F9enPmZYh9MD8d9OaiuM=
Received: from CO2PR04CA0096.namprd04.prod.outlook.com (2603:10b6:104:6::22)
 by BL1PR12MB5318.namprd12.prod.outlook.com (2603:10b6:208:31d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Mon, 8 Nov
 2021 21:51:24 +0000
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:6:cafe::d9) by CO2PR04CA0096.outlook.office365.com
 (2603:10b6:104:6::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend
 Transport; Mon, 8 Nov 2021 21:51:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT009.mail.protection.outlook.com (10.13.175.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4669.10 via Frontend Transport; Mon, 8 Nov 2021 21:51:23 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 8 Nov 2021
 15:51:21 -0600
Subject: [PATCH 1/3] x86/amd_nb: Add AMD Family 19h Models (10h-1Fh) and
 (A0h-AFh) PCI IDs
From:   Babu Moger <babu.moger@amd.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <clemens@ladisch.de>, <jdelvare@suse.com>, <linux@roeck-us.net>,
        <bhelgaas@google.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-hwmon@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <babu.moger@amd.com>
Date:   Mon, 8 Nov 2021 15:51:21 -0600
Message-ID: <163640828133.955062.18349019796157170473.stgit@bmoger-ubuntu>
In-Reply-To: <163640820320.955062.9967043475152157959.stgit@bmoger-ubuntu>
References: <163640820320.955062.9967043475152157959.stgit@bmoger-ubuntu>
User-Agent: StGit/1.1.dev103+g5369f4c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e88f544-b9de-4406-6b91-08d9a301e85a
X-MS-TrafficTypeDiagnostic: BL1PR12MB5318:
X-Microsoft-Antispam-PRVS: <BL1PR12MB53183865344D4511142AA04595919@BL1PR12MB5318.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:935;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JjNX8/usQS2CXwXzER5AtI6lawepzQOuTcr0jqlVBFCmN0lyCi/uaZxc+2+YeI3MjFMnH/SOW42pFG7iQHgc4gM8CewlG/hrnuRBn4Ar2CXTPx+NKpuRfTiqu1T0vinv2n779e5vwSKNMJZPTX11PBbOsrz797wJlLwPqD0a9aQrSf3olvRV5P2FfCzmgQVVteEqNR9NMnE7miL8fF5QhbkmvoZMnvLIOl8heNqbnaMT4oxeQFG4WyR7AAXm1X1dJzWy7zej6L3fW288zXExa3QR67tJ5BnGdWeZElsd425brhcWU6Xa+g6joAPAcnrwJ0RC1NpGB3FazSM+fb89ctd7c0bNaZwFJjUXOKi3mtm8ZHNhY40tcXLkgEi03HYHi8NUfD7IJsvFOBrqyjOQubvfY3APlQvU6I0GHAhdWqZdMReLSl4rul5pMJzDK8bZgXyHbJIjASGNXLbNymInzpY4iD6u0tr9KVYp1e9Qo9g1NQWi7gg/OVl0fNmzeWIkQfNsnK1loBhdsip75Py8+RtBODsJHxC0d0U8YGioZjT2H7WJMuscuqQTxBTSnf8Dqz8c+zlnRuzTIVFv5aikGCXiXHc3atije4Vq1c+9z79bVaKJAp8ClS3XvQ+99oMm1QTQznGI/AWJl38L70oZIs5hExaIWxgUHnXPT4ibB4lijqjXyxPULIF661KjzCvPyl2j6ObQSfTPPgUeMbsc3sycry8M4G5SbRaHNPe/4fFWr5j3vjDfL7r61Vizvwowm08GFYArVstQX+p3Pkqptw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(7916004)(46966006)(36840700001)(70206006)(70586007)(82310400003)(8936002)(16526019)(36860700001)(336012)(26005)(47076005)(103116003)(2906002)(8676002)(921005)(4326008)(356005)(508600001)(110136005)(9686003)(81166007)(316002)(7416002)(426003)(54906003)(16576012)(44832011)(86362001)(5660300002)(33716001)(186003)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2021 21:51:23.6591
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e88f544-b9de-4406-6b91-08d9a301e85a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5318
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>=0A=
=0A=
Add the new PCI Device IDs to support new generation of AMD 19h family of=
=0A=
processors.=0A=
=0A=
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
---=0A=
 arch/x86/kernel/amd_nb.c |    5 +++++=0A=
 include/linux/pci_ids.h  |    1 +=0A=
 2 files changed, 6 insertions(+)=0A=
=0A=
diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c=0A=
index c92c9c774c0e..f3e885f3dd0f 100644=0A=
--- a/arch/x86/kernel/amd_nb.c=0A=
+++ b/arch/x86/kernel/amd_nb.c=0A=
@@ -19,12 +19,14 @@=0A=
 #define PCI_DEVICE_ID_AMD_17H_M10H_ROOT	0x15d0=0A=
 #define PCI_DEVICE_ID_AMD_17H_M30H_ROOT	0x1480=0A=
 #define PCI_DEVICE_ID_AMD_17H_M60H_ROOT	0x1630=0A=
+#define PCI_DEVICE_ID_AMD_19H_M10H_ROOT	0x14a4=0A=
 #define PCI_DEVICE_ID_AMD_17H_DF_F4	0x1464=0A=
 #define PCI_DEVICE_ID_AMD_17H_M10H_DF_F4 0x15ec=0A=
 #define PCI_DEVICE_ID_AMD_17H_M30H_DF_F4 0x1494=0A=
 #define PCI_DEVICE_ID_AMD_17H_M60H_DF_F4 0x144c=0A=
 #define PCI_DEVICE_ID_AMD_17H_M70H_DF_F4 0x1444=0A=
 #define PCI_DEVICE_ID_AMD_19H_DF_F4	0x1654=0A=
+#define PCI_DEVICE_ID_AMD_19H_M10H_DF_F4 0x14b1=0A=
 #define PCI_DEVICE_ID_AMD_19H_M40H_ROOT	0x14b5=0A=
 #define PCI_DEVICE_ID_AMD_19H_M40H_DF_F4 0x167d=0A=
 #define PCI_DEVICE_ID_AMD_19H_M50H_DF_F4 0x166e=0A=
@@ -39,6 +41,7 @@ static const struct pci_device_id amd_root_ids[] =3D {=0A=
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M10H_ROOT) },=0A=
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M30H_ROOT) },=0A=
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M60H_ROOT) },=0A=
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M10H_ROOT) },=0A=
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M40H_ROOT) },=0A=
 	{}=0A=
 };=0A=
@@ -61,6 +64,7 @@ static const struct pci_device_id amd_nb_misc_ids[] =3D {=
=0A=
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F3) },=0A=
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M70H_DF_F3) },=0A=
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_DF_F3) },=0A=
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M10H_DF_F3) },=0A=
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M40H_DF_F3) },=0A=
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M50H_DF_F3) },=0A=
 	{}=0A=
@@ -78,6 +82,7 @@ static const struct pci_device_id amd_nb_link_ids[] =3D {=
=0A=
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M60H_DF_F4) },=0A=
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M70H_DF_F4) },=0A=
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_DF_F4) },=0A=
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M10H_DF_F4) },=0A=
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M40H_DF_F4) },=0A=
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M50H_DF_F4) },=0A=
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F4) },=0A=
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h=0A=
index 011f2f1ea5bb..b5248f27910e 100644=0A=
--- a/include/linux/pci_ids.h=0A=
+++ b/include/linux/pci_ids.h=0A=
@@ -555,6 +555,7 @@=0A=
 #define PCI_DEVICE_ID_AMD_17H_M60H_DF_F3 0x144b=0A=
 #define PCI_DEVICE_ID_AMD_17H_M70H_DF_F3 0x1443=0A=
 #define PCI_DEVICE_ID_AMD_19H_DF_F3	0x1653=0A=
+#define PCI_DEVICE_ID_AMD_19H_M10H_DF_F3 0x14b0=0A=
 #define PCI_DEVICE_ID_AMD_19H_M40H_DF_F3 0x167c=0A=
 #define PCI_DEVICE_ID_AMD_19H_M50H_DF_F3 0x166d=0A=
 #define PCI_DEVICE_ID_AMD_CNB17H_F3	0x1703=0A=
=0A=

