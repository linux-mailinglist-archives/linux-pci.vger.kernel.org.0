Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD4E6449E79
	for <lists+linux-pci@lfdr.de>; Mon,  8 Nov 2021 22:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240654AbhKHVyT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Nov 2021 16:54:19 -0500
Received: from mail-dm3nam07on2087.outbound.protection.outlook.com ([40.107.95.87]:26496
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240622AbhKHVyS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 8 Nov 2021 16:54:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ntGjJOXQ9IfMIPLkTw8h8f9VAaohAc2U5L8xqE3AAHuILz5eVgeiK6dFl5WEdIysyaUQtgUrzwTPLZMSiryALzWpa43RBQCDG5cRD+ugBGZpRel68MKD/sCYJKa6L77Prysbr1RSbfkxkVLxO1Qi/DQQKLb3X4uHjRiBTewOmPPxE8suNAqiBB5wjfXjqXDJyb941RmOPlfFf2ILyJ0qv1aTJ0wR85bjRrF8VVuh746404cGQ5Oj9ODqqV76XnUofTeDmw1XG7E2beJl2IZPUWKLGRPBMuZRhgnH+fdRjwYlsh37wqJ5nImIWikz1IO6lEczGkkOJcnwWokyRALpTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HcwJe37vXM01ovdSSqBC2LqkFpsfh2N6LkhxZLdSMYA=;
 b=D/LOj2Ok3DWAq2eMBBJ0FoPf7XYB3p2OouY+pVLfw0jLAKoQeRXRHT+m8EgLp+vfkso/mwp4n43dkwWwzEvqlV+yppGl1VNng/AjTZYuV1OvisjnSswNH650ywFSJU6c9XiW6QoWmy/WO1e6JGnz3TSVpEwreBjNs3BQrTNFvioajEmDvWAxKGHz2+2xeMBAihgVo+UttKK+tBrmy9cSBN5raAP3BUaEkNGlcqbg7BBAMTRpOs9HFwZlmESjjsPBKtVjBgWlYEoPHRxWs3XRPymELd2RFG7p+XGiUlEyGjZxNRNigpcG25yzaACvhKCjjAcHasdEM6EQd1sXXXNo9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HcwJe37vXM01ovdSSqBC2LqkFpsfh2N6LkhxZLdSMYA=;
 b=zcyGERZOTT6V2vaY17Ytb5Phn6DU2yRbeRq04K+hw+flgVNU4Y6Y8X2MgKKDmkT4NqKhuYvs+cd1fJ9KUNU5MtYNBWhNwqE8ovZcCLCRquctFOaW8I/8MbWzY92E1L0XD1CFzjZHyojB96UqFF99LLgOrluW36pKCe5wDjpq9g0=
Received: from MWHPR11CA0025.namprd11.prod.outlook.com (2603:10b6:300:115::11)
 by BN9PR12MB5306.namprd12.prod.outlook.com (2603:10b6:408:103::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Mon, 8 Nov
 2021 21:51:30 +0000
Received: from CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:115:cafe::b6) by MWHPR11CA0025.outlook.office365.com
 (2603:10b6:300:115::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend
 Transport; Mon, 8 Nov 2021 21:51:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT068.mail.protection.outlook.com (10.13.175.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4669.10 via Frontend Transport; Mon, 8 Nov 2021 21:51:30 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 8 Nov 2021
 15:51:28 -0600
Subject: [PATCH 2/3] hwmon: (k10temp) Remove unused definitions
From:   Babu Moger <babu.moger@amd.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <clemens@ladisch.de>, <jdelvare@suse.com>, <linux@roeck-us.net>,
        <bhelgaas@google.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-hwmon@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <babu.moger@amd.com>
Date:   Mon, 8 Nov 2021 15:51:27 -0600
Message-ID: <163640828776.955062.15863375803675701204.stgit@bmoger-ubuntu>
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
X-MS-Office365-Filtering-Correlation-Id: 727b0057-6155-47f7-4986-08d9a301ec28
X-MS-TrafficTypeDiagnostic: BN9PR12MB5306:
X-Microsoft-Antispam-PRVS: <BN9PR12MB5306519D56D13378A2C10C9695919@BN9PR12MB5306.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:262;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qrp75MpMdklErfl0Ll4T7F855o1OqaQBfZZznDWhEN1Xe6WwQZVNeLPIIYWOqgOanREAfjFaqdszEgIgRoyOnEQQPUobDqGGvy6y2d9L4fpth0nI2jQ/AuBZmMfDHBbHss/Z5gOcIzzDYVjv05IdhIt7UW9J6oTDn0aKwNpYOeRxVhxB5Yk0pIcqE0VajiF8bp9s041jv9KinKKEwgo9p7OEK/MtJIKKp0x14W0x651umvmL0szCK+sHff3YOSMZyNObDJ2MHs0TSJAITuduqa22AMslYzhO8NP/UUzCdQo6yEFHgksNm7dpWcOBnm/CyBT4qXFcIjQ5YuOhTf614w5n5rr7Q+YiQalDClJz+Cnm0s3tSKRG/pnqRlhVr7mvF1aOZC/GVZPmigpAHF3KCSKyU7W4pnh8tFwFtxBWY0tYw77DJGNLD7seOg4QYtT+weQsma3PE9bdCuCquARPIs81DVsGMrOKKO5feGNqOuTZAqQvpzZAOpzxgqLvPCnr6M9Xy09Pk8YT6l5bRt1h6ur2wLKiAHC+1GpWBouQTpkZWCzoFf5bnYT6UoZg/ZPNDBDGF2EvAVD5Rn7fBiPqmeIqRwmkVQ0suC8Eph5Ej6egf0M038nBnUa9EPiV+vtlNPpWO7UstlXgKxjUToTMM2RKuiJf2lj2j61IoUdlviG6OEd81UQ2kcX6OdF+i8XqI6PL1CB1Gl7E4F9a82vtHm+TXkf4u8j3eYXshQSaW6GnBLdnpIngtY35mGcqVCO5XNSo9RN/Zr4bjQgfFJI9RQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(7916004)(46966006)(36840700001)(36860700001)(33716001)(356005)(336012)(26005)(508600001)(8676002)(16576012)(9686003)(110136005)(426003)(54906003)(8936002)(186003)(16526019)(103116003)(2906002)(4326008)(316002)(921005)(81166007)(83380400001)(47076005)(82310400003)(70206006)(86362001)(7416002)(70586007)(44832011)(5660300002)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2021 21:51:30.0414
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 727b0057-6155-47f7-4986-08d9a301ec28
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5306
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Usage of these definitions were removed after the commit 0a4e668b5d52=0A=
("hwmon: (k10temp) Remove support for displaying voltage and current on Zen=
 CPUs").=0A=
So, cleanup them up.=0A=
=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
---=0A=
 drivers/hwmon/k10temp.c |   20 --------------------=0A=
 1 file changed, 20 deletions(-)=0A=
=0A=
diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c=0A=
index 3618a924e78e..662bad7ed0a2 100644=0A=
--- a/drivers/hwmon/k10temp.c=0A=
+++ b/drivers/hwmon/k10temp.c=0A=
@@ -76,26 +76,6 @@ static DEFINE_MUTEX(nb_smu_ind_mutex);=0A=
 #define ZEN_CUR_TEMP_SHIFT			21=0A=
 #define ZEN_CUR_TEMP_RANGE_SEL_MASK		BIT(19)=0A=
 =0A=
-#define ZEN_SVI_BASE				0x0005A000=0A=
-=0A=
-/* F17h thermal registers through SMN */=0A=
-#define F17H_M01H_SVI_TEL_PLANE0		(ZEN_SVI_BASE + 0xc)=0A=
-#define F17H_M01H_SVI_TEL_PLANE1		(ZEN_SVI_BASE + 0x10)=0A=
-#define F17H_M31H_SVI_TEL_PLANE0		(ZEN_SVI_BASE + 0x14)=0A=
-#define F17H_M31H_SVI_TEL_PLANE1		(ZEN_SVI_BASE + 0x10)=0A=
-=0A=
-#define F17H_M01H_CFACTOR_ICORE			1000000	/* 1A / LSB	*/=0A=
-#define F17H_M01H_CFACTOR_ISOC			250000	/* 0.25A / LSB	*/=0A=
-#define F17H_M31H_CFACTOR_ICORE			1000000	/* 1A / LSB	*/=0A=
-#define F17H_M31H_CFACTOR_ISOC			310000	/* 0.31A / LSB	*/=0A=
-=0A=
-/* F19h thermal registers through SMN */=0A=
-#define F19H_M01_SVI_TEL_PLANE0			(ZEN_SVI_BASE + 0x14)=0A=
-#define F19H_M01_SVI_TEL_PLANE1			(ZEN_SVI_BASE + 0x10)=0A=
-=0A=
-#define F19H_M01H_CFACTOR_ICORE			1000000	/* 1A / LSB	*/=0A=
-#define F19H_M01H_CFACTOR_ISOC			310000	/* 0.31A / LSB	*/=0A=
-=0A=
 struct k10temp_data {=0A=
 	struct pci_dev *pdev;=0A=
 	void (*read_htcreg)(struct pci_dev *pdev, u32 *regval);=0A=
=0A=

