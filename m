Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A59714A9EFD
	for <lists+linux-pci@lfdr.de>; Fri,  4 Feb 2022 19:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358087AbiBDS3J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Feb 2022 13:29:09 -0500
Received: from mail-mw2nam12on2073.outbound.protection.outlook.com ([40.107.244.73]:21746
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232631AbiBDS3I (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Feb 2022 13:29:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gDhvAAv5ceTxl+YN2QnBESgzpl36e+uN1q+Cd3uc0j3xgXAEtVMZ5NgsARniZwGnO+6GZ+4/87ZOT40Q+jpxfqeejQWA3uuH36uGk2m5uLKuFZo6A/UAnu9aZK27BMkpSrvqO+/H8sAbjhpmRDDu3Cai4rN+avm/JJv6/UB4Zt4wLfHGONSnm24mbQqafqi/40m3qM1x620RCRVsVgBS1sW33PoUXfIhfeeIbpLnNXaV0lT+wXuAfNsWDzYWq8F/mXs3DdERH5Yl7TkByIa9esQ3s6IJxwlYUu8XlOFFNZ6axQXA2yU3uOr9Tz5kpLi1bSO7CDhfXOEGoCsi0cHXFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Qa6WK3Er2Z/YhNzhDaSlcfJIHa7GMjF+sBWMVsC6v8=;
 b=Usx03N6cjtqBni6D+EJYZ5yy4nG3nSIVqSoNahxJKpkpd4UXH1RBZmAKTBaj8V/IT2ntWZkra+VdEWxXpTq3AKcmXaLllRKotc3xmrjT3ZeN6k9k4k4iw8HY8e1EhOGOPW63gpJ7UShfqGzVRkP/oyfw85PPdQkxGaDfsU3UNEOUxXaSDS5T87QDd//q5L8UgP2pHj8YZvwQKz4c4+Mytm/wOzaH0dph+eaWtiM3mLQPB1AHAphMXojUZf3c90AEzRESmlFzkS0CGPH7OHnGV0u+fV5XLHCiyF6/RKjkmTanFhbdwlu4vy0uWIti5JQ8pAf994ybNpBLTw2ks/68rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Qa6WK3Er2Z/YhNzhDaSlcfJIHa7GMjF+sBWMVsC6v8=;
 b=01Qh6vvItKA5I92Ev+74+sJPQbRK18LAOax0OcS7DC3m/yY9AqrisEEBa2ACe4fg0fxyDAmBdaDmIPaJEvbSvvvHOhnEuyNg8y58R1rkSZp6zMJ3omlUSaOi/Ch1GMzRcbVqH8ceGYEeRKHhZL9QGY4m87btFrVM1SM9y0dlG4k=
Received: from BN9PR03CA0792.namprd03.prod.outlook.com (2603:10b6:408:13f::17)
 by DM6PR12MB4909.namprd12.prod.outlook.com (2603:10b6:5:1ba::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 4 Feb
 2022 18:29:07 +0000
Received: from BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13f:cafe::6a) by BN9PR03CA0792.outlook.office365.com
 (2603:10b6:408:13f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Fri, 4 Feb 2022 18:29:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT047.mail.protection.outlook.com (10.13.177.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Fri, 4 Feb 2022 18:29:07 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 4 Feb
 2022 12:29:06 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        "open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>
CC:     Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        <Alexander.Deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 0/2] Mark USB4 controllers as is_thunderbolt
Date:   Fri, 4 Feb 2022 12:28:18 -0600
Message-ID: <20220204182820.130339-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3595629-6700-40c1-8405-08d9e80c3acb
X-MS-TrafficTypeDiagnostic: DM6PR12MB4909:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4909BDBD33850E080678BB4CE2299@DM6PR12MB4909.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t3a4RgskK+UCOIF7/XUn3uPlNd4CPL2Jv6KTIiZHW/UCuerUznxAVpHyem+LJaMqdq/EGTHz0LDpg/Y4NeIvb5XRwI3Qs3rL1vpy9lzgXdAE1XlIptPY1KKkZSjzsotiXv88yuTBxG4UP0G0z+NGdTdRXCehiI3dhd3aN5LgjQ+YpC8dBEhx8B1neEDsF3vKq/hSo+o8pcrf9rwU7yw9PzjHrUtScNvsHlB3T7SKiPdFCh/b+T6Qd59t0pei3oS5o48oFz8SasvXunZuF9o2YpimlEY6qSiWBQqHKgtL+wM4gEPL3ennbedmoSNv3UymeKmOKg3I6R6ZzHSmbrTHrEEvw0KlBTN9YLuLGdcwir/fFEeR2RtTs+rr238hT0NJXzYLGr758K96Y1eCNWPgUP9DE58dW0Y9niEmJjb9awtHhZqVBOAobUgBal33iVw4DRTWlC/aUKuolqgO9jYMGaqhqIlmCH2O65MYOwkyjfeVoKMwWTNj+YgAbst+8Wgh1/uwStnuPZY5stJvzxfHolJOY3yEWlXmHOAXjDgkkSnaVWFZnbXQjnEK6Ujxv0IM0OKVuGk5oyckmAEkkdIdiE+k1p1BeKsXVEnd81oNSvbwFWQTCqz5k368O8u0cvFNz/d/wjtuuZ/XW02B7M16kVN20e1rd1GEId6x6z9aLzCmRmmhSU7CnupGgEHUKHOTbFBjqyeHdudjMS0eF3zX0w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(54906003)(316002)(36860700001)(4744005)(110136005)(508600001)(8676002)(16526019)(426003)(336012)(86362001)(70206006)(47076005)(82310400004)(83380400001)(2616005)(186003)(1076003)(70586007)(26005)(6666004)(2906002)(44832011)(356005)(81166007)(8936002)(40460700003)(36756003)(5660300002)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 18:29:07.2209
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3595629-6700-40c1-8405-08d9e80c3acb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4909
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Various drivers in the kernel use `pci_is_thunderbolt_attached` to
designate behaving differently from a device that is internally in
the machine. This function relies upon the `is_thunderbolt` designation
which checks for a specific capability only set on Intel controllers.

Non-Intel USB4 designs should also match this designation so that they
can be treated the same regardless of the host they're connected to.

Mario Limonciello (2):
  thunderbolt: move definition of PCI_CLASS_SERIAL_USB_USB4
  pci: mark USB4 devices as "is_thunderbolt"

 drivers/pci/probe.c       | 4 ++--
 drivers/thunderbolt/nhi.h | 2 --
 include/linux/pci_ids.h   | 1 +
 3 files changed, 3 insertions(+), 4 deletions(-)

-- 
2.34.1

