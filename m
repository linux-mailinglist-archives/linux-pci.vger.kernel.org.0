Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7209449E74
	for <lists+linux-pci@lfdr.de>; Mon,  8 Nov 2021 22:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240164AbhKHVyH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Nov 2021 16:54:07 -0500
Received: from mail-dm6nam10on2061.outbound.protection.outlook.com ([40.107.93.61]:10080
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239662AbhKHVyH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 8 Nov 2021 16:54:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kC7tKejtnxNFNE8rwrUZmsnV8q7UB44XsLwaucZJCO52AUB6s3+GEpNh+A9Z0W0g0iYHYmKk9g2UtWcCI4R0cYP9pOZBTSk/FhVglNRLtRsklS6zutmlCp+TNpmp2sy+5EehlrqqeV4oePF84BWyYHDvxRz9GhnN05muSpy4gIrmWRZB7r8U5MjyxW4qW6uG5y1GTUpzY1G+X6DGFffYvAi8kV9/qE/HD1v6c1RM6JyrFhV4i23Ws+YDrPNps/YGeR52UjG0fszhSNz/EcwR1nc9ZvyKrOZzGSEZ3SMWf+C3dvY0X/p0geMBk+T0miiMThyNy/uRkgunyZtW4kpoPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y8yPLsLeQc6vqtVvjFngC7e0CGzeox5NdNHgCY255/s=;
 b=HoMvBssVGq9XMJzdeOKdwWEz/ZPCQaE2h7qxbFL3Z07AjQ7CBEVBBXiJDGEWRmDiZ6ljus5vVscnVW65xvh5CQuEcfve0n7m4dzJc7DVPSqHN1rBhR55aJAbGtkaSvnfi9Msn1xFGUyWEuosaq0RGWVXl0jY4AE5kLxKU3oIUi8efcJNOmgir230Wt4AsHVG+J1eOMvQLEmL9PyyLfPC+Iyrr6u3Hc09YGQfVOjntuh3b+Jx8ph46GzvRGDDvALIwi+9/LOunpkfuEwMjPrqEqF6JDaf3SR76bVPEjRc6xdATqVhqpsw9lcV5QcXaZCXOdjbOkzBwlWnAyHmMI/5sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y8yPLsLeQc6vqtVvjFngC7e0CGzeox5NdNHgCY255/s=;
 b=gGvM+KUmqitSi1wzhDyqd27JBcG/L111xwvY+M1XlnfS1NQBKEhmNPXKDGTKlcyhvFhvTgbKKd+yoigYGfERHBKktfZ9s1Qj/aHOYZChOlyoslY4uMPTvxSMKhCxId0rhplKghx1N3+4IEmgVHDp+b+QXRjfg18sftzNXW3zuQc=
Received: from MW4PR04CA0270.namprd04.prod.outlook.com (2603:10b6:303:88::35)
 by MN2PR12MB3454.namprd12.prod.outlook.com (2603:10b6:208:c8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Mon, 8 Nov
 2021 21:51:19 +0000
Received: from CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:88:cafe::8f) by MW4PR04CA0270.outlook.office365.com
 (2603:10b6:303:88::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.16 via Frontend
 Transport; Mon, 8 Nov 2021 21:51:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT034.mail.protection.outlook.com (10.13.174.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4669.10 via Frontend Transport; Mon, 8 Nov 2021 21:51:18 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 8 Nov 2021
 15:51:15 -0600
Subject: [PATCH 0/3] k10temp/amd_nb: Add support for AMD Family 19h Models
 10h-1Fh and A0h-AFh
From:   Babu Moger <babu.moger@amd.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <clemens@ladisch.de>, <jdelvare@suse.com>, <linux@roeck-us.net>,
        <bhelgaas@google.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-hwmon@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <babu.moger@amd.com>
Date:   Mon, 8 Nov 2021 15:51:14 -0600
Message-ID: <163640820320.955062.9967043475152157959.stgit@bmoger-ubuntu>
User-Agent: StGit/1.1.dev103+g5369f4c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: adacdc63-5e37-4f86-8894-08d9a301e57e
X-MS-TrafficTypeDiagnostic: MN2PR12MB3454:
X-Microsoft-Antispam-PRVS: <MN2PR12MB34541C9032F4D0A530ABCEAF95919@MN2PR12MB3454.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JsEfybIj5g8f9V88+cr52MtXRJ74WRbZ6jFMYF3VA1Ql/ONLOkb/5SPnzPYu+R7Svuj13U4dPG+znrlc39k8C58OJWPJfysZKnQr7Bww0HaAz8QniuPljxICJ9xhSVu/d/IUDf6z490d+fA9TKrAIodO/+VLkcloqXG2IS7xX4lzEtTDT5W6FXPS2YK4uT1D5twJaoYm+soMpXh/c4TMdzARETcOIj4fKLC+rHY9uY2ILhxGbqH76BC5Aslngkjg8bKxFN9yr7wJDygZqOxa54GbPE6I8jPi24+1/0qLISsb5ycSTRjCB8qYRO3xBnjFmvfTG/+WnhSCP6Px4cFt3bMfjhHCW5ekQDsLzTPbq0zNuvGN6rQK261asKyNJqG0TzyyT8MOelmFNJaD2fwLaKB3zP5/sG5Vqmm7m3sKpTFv+NxbliFFvXEZ7Nzn6EyXfSu2589AhZDKQKbFyytT4wd4cb1LoyjHYGNvcEn/KIsoJ5EDglFuVw747+VOMV4bPXD29HU+VKMfWMuVkUNymabY5SHpG5Bz2nhgbm5t+XYazy/JfFz38OUJx2VDxBsdQt5fBQyNbJP10O5TogGJokLBhIE1GbDi88jgY9OGTh+rrp7ch85X4X7dBYqGA4TL1VRk00VgpT9YEIBlrJrxFMSbZ9Qii9wnnMGVchM7Rua/7hltpcBE4cd7FWtIOtyGYZJZ4rMNENHTCC+n33MYC+i34sBOuFSMiuH7Kr+hZ+G1+JYqw6RWqflSpgUevOBdmBoksqgdnBMJXyfWKqBBKg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(7916004)(36840700001)(46966006)(316002)(70586007)(426003)(2906002)(81166007)(508600001)(83380400001)(7416002)(70206006)(5660300002)(356005)(86362001)(103116003)(9686003)(82310400003)(36860700001)(54906003)(4744005)(336012)(16526019)(44832011)(8936002)(110136005)(8676002)(4326008)(26005)(921005)(186003)(16576012)(47076005)(33716001)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2021 21:51:18.8446
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: adacdc63-5e37-4f86-8894-08d9a301e57e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3454
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series updates k10temp and amd_nb drivers to support AMD Family 19h=0A=
Models 10h-1Fh and A0h-AF CPUs.=0A=
---=0A=
=0A=
Babu Moger (2):=0A=
      hwmon: (k10temp) Remove unused definitions=0A=
      hwmon: (k10temp) Add support for AMD Family 19h Models 10h-1Fh and A0=
h-AFh=0A=
=0A=
Yazen Ghannam (1):=0A=
      x86/amd_nb: Add AMD Family 19h Models (10h-1Fh) and (A0h-AFh) PCI IDs=
=0A=
=0A=
=0A=
 arch/x86/kernel/amd_nb.c |  5 +++++=0A=
 drivers/hwmon/k10temp.c  | 23 +++--------------------=0A=
 include/linux/pci_ids.h  |  1 +=0A=
 3 files changed, 9 insertions(+), 20 deletions(-)=0A=
=0A=
--=0A=

