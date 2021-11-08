Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4595C449E7D
	for <lists+linux-pci@lfdr.de>; Mon,  8 Nov 2021 22:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240672AbhKHVy0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Nov 2021 16:54:26 -0500
Received: from mail-mw2nam10on2074.outbound.protection.outlook.com ([40.107.94.74]:10721
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240666AbhKHVyZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 8 Nov 2021 16:54:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GQtdFKr7X2tnTVmU7A/rn9rEEuIyvH4k4MVPv4sff7QpVx2BywxfcebVXJ9wnepTYFcTd51khd1U/hx9gwU7LbnpeCU3Et/JvZRjyCdIwB69DGk1twCGMiyvst5bG2k/7JcYCsDNxJZ9Od4IkCXNh7Yfl7eD3gezbFsYe53ZZKPVsPtTOHGLnBQOmX2LYXlo7W7+lNCDHSSE9kMObpT7P+AxxFn9OZQhHVUNzQUze7tPTB9aI1uNM8QV/mI1OxqSw1UXc0TJa9n6aKcpVDUl/7tk+DjA637x1SkZ+NEtlqIwyMhF/LT6XZ6CkVau1xp6fqmtJBOasL7e9F5BgFVaiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=drXItMepaRaYBHAO1OM1uUvZnxZYdjavDo571gBs5xI=;
 b=Qm/0YUFjh6IWp9fTVcfCdY84qEGYVmiliAv9iH3gr2Ussy8vUfoW7cL4ae+EhXj5FAmOd+NjAEWmWmD6fXLE4l2rQYoiQso/RZaPYY92lkpcD1U16es3Nj34Q5bp3ff7geyHBwEbL+F3ojNsjpn4aS0QPtlVhNE0OuxhXTrHsnpgsjJFRMRj/ZKH4BmFQt9gRTCUaJrOlxKUHGfPYyJ1TwSx6Spj/Qhaenk/Irnbt5Ydt2TZUqzmnBe/9G5FRsbk56uwLlsnMCQ0OySJOulnGESX0vq5ipXVuMCpiO7ilr7mC9InMcbXOIVGerpOS5nZnLu5roCl+79lyg2Q+uMGXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drXItMepaRaYBHAO1OM1uUvZnxZYdjavDo571gBs5xI=;
 b=n/iXeaTmrRIjsNWE+iJcq/8+aKV1+jQFtz1ONR0W9Wnl5txEqdhwbjoFHkjjgxuFzkJrwQhiR0Cs4fSLivqs72vlMdMT/hp15o1tn5MKDNM4edTaa1LqVl0Byfm8pcvSBx2mJhmtAnPaA0aN73xAv4Es6oRPmPhXZuWgOQHTs4Q=
Received: from MW2PR2101CA0020.namprd21.prod.outlook.com (2603:10b6:302:1::33)
 by DM6PR12MB2986.namprd12.prod.outlook.com (2603:10b6:5:39::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.16; Mon, 8 Nov
 2021 21:51:37 +0000
Received: from CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::4c) by MW2PR2101CA0020.outlook.office365.com
 (2603:10b6:302:1::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.3 via Frontend
 Transport; Mon, 8 Nov 2021 21:51:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT011.mail.protection.outlook.com (10.13.175.186) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4669.10 via Frontend Transport; Mon, 8 Nov 2021 21:51:36 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 8 Nov 2021
 15:51:34 -0600
Subject: [PATCH 3/3] hwmon: (k10temp) Add support for AMD Family 19h Models
 10h-1Fh and A0h-AFh
From:   Babu Moger <babu.moger@amd.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <clemens@ladisch.de>, <jdelvare@suse.com>, <linux@roeck-us.net>,
        <bhelgaas@google.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-hwmon@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <babu.moger@amd.com>
Date:   Mon, 8 Nov 2021 15:51:34 -0600
Message-ID: <163640829419.955062.12539219969781039915.stgit@bmoger-ubuntu>
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
X-MS-Office365-Filtering-Correlation-Id: c8514862-7293-4391-94fa-08d9a301f00a
X-MS-TrafficTypeDiagnostic: DM6PR12MB2986:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2986B0B56454973EE11452AA95919@DM6PR12MB2986.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bTgKkYZ1uRh0m1fnXlj4YpECwC0WLSm7TgwdxKazvDWCoOLsr/Bf8bsyBIGifaFeTDn26lTo/WE7E7MyRP6KVTSRR930MWL1AmMdJtrR+N/wzCpQG6B+B0xPFvQIiPEgA+YWbR0CL89doO8JxmAajU6V+WjJ4S7fY4cD4LtcidMhKXTDtliLBuPrRte6ibPfP1gH/JiiW5au/2Q8tOAcZegpcbd474f3mZXAWOTyiz7jFZLIRqQXqfXlcl4ETiGF9RXKIzFSsidwqAer/q0jBnuDCgQ3vQRKrtjui+3trdPwM8Y1hWxGZVR6vX3FAFrorWTgtYRy604byyp3Sn2Xv9dl7019r1JSYpNn/Y3B4wlV/UEWHBcaC1Pg6R3cW9mJhXtcQNi0wZO0Wp1OUB7+JvMgHavsliCldvQmpbfydXgAwGEoK6MDUf1duNPhnt0YdIOisMOwpUE36pzqRIHWqdhTaZhDaOmg6tLEfJ2xoPutRh/K96sKROZn+Lh2pVkX7u/yFDCbzGER+q4l3rP7/5awYmUqTpyspXdKgIvHg3/jJqrfvgyczjp1MChJ/Gd5VJNqKGFGyKasklBNcge/dSHE28lSG0a68lhHjuYfJiSwOZ1EGlmmASnqvbn7SCi6+mpXhH7KTGuMRf8qbZgF/59wUQ0GdG0GNuN81fbQGLwMlXOAIarqEkERi29zVF3whKuvv4fUvp4tdG5YKEfdpblRX6dbI5IS35kY/5lgS9ssE2Cr3gKxu9VjIENgFVKvNaHTE9piRuo+npc0pTn0ag==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(7916004)(4636009)(46966006)(36840700001)(103116003)(5660300002)(16576012)(110136005)(16526019)(2906002)(8676002)(8936002)(4326008)(921005)(44832011)(316002)(26005)(7416002)(54906003)(508600001)(47076005)(82310400003)(186003)(426003)(81166007)(33716001)(70206006)(86362001)(356005)(9686003)(70586007)(336012)(36860700001)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2021 21:51:36.5396
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8514862-7293-4391-94fa-08d9a301f00a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2986
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add thermal info support for AMD Family 19h Models 10h-1Fh and A0h-AFh.=0A=
Thermal info is supported via a new PCI device ID at offset 0x300h.=0A=
=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
---=0A=
 drivers/hwmon/k10temp.c |    3 +++=0A=
 1 file changed, 3 insertions(+)=0A=
=0A=
diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c=0A=
index 662bad7ed0a2..880990fa4795 100644=0A=
--- a/drivers/hwmon/k10temp.c=0A=
+++ b/drivers/hwmon/k10temp.c=0A=
@@ -433,7 +433,9 @@ static int k10temp_probe(struct pci_dev *pdev, const st=
ruct pci_device_id *id)=0A=
 			data->ccd_offset =3D 0x154;=0A=
 			k10temp_get_ccd_support(pdev, data, 8);=0A=
 			break;=0A=
+		case 0x10 ... 0x1f:=0A=
 		case 0x40 ... 0x4f:	/* Yellow Carp */=0A=
+		case 0xa0 ... 0xaf:=0A=
 			data->ccd_offset =3D 0x300;=0A=
 			k10temp_get_ccd_support(pdev, data, 8);=0A=
 			break;=0A=
@@ -477,6 +479,7 @@ static const struct pci_device_id k10temp_id_table[] =
=3D {=0A=
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_M60H_DF_F3) },=0A=
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_M70H_DF_F3) },=0A=
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_DF_F3) },=0A=
+	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_M10H_DF_F3) },=0A=
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_M40H_DF_F3) },=0A=
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_M50H_DF_F3) },=0A=
 	{ PCI_VDEVICE(HYGON, PCI_DEVICE_ID_AMD_17H_DF_F3) },=0A=
=0A=

