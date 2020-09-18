Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E55B526FB64
	for <lists+linux-pci@lfdr.de>; Fri, 18 Sep 2020 13:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbgIRLYJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Sep 2020 07:24:09 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:41084 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726241AbgIRLYJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Sep 2020 07:24:09 -0400
X-Greylist: delayed 2957 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Sep 2020 07:24:07 EDT
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08IAX737011209;
        Fri, 18 Sep 2020 03:34:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=s/xmnS+mi32b5uMqrnSwThxFErDIjUN1KmCAd5Fa9Rs=;
 b=He4pss+UWtYmHUu71ytiThjqAkVDkWFjntJWpG8sf+yqYfZwXbqZxC3Lg1yiYeHHGIfD
 eov7CK4uGBWZjQc8JAmKOGbHPFD/w/ft+Wx+oyAiiRG4DbyE/DRTbqVgOuCJRaVYrZbo
 ao+SFjEhqKIZd3y+Bi4zCeEzAsdgAgFfO3krUDVYY3ROif6rpDLq8/dxwol6+JW8WiUS
 EQbRqRnhUgH9d5pcJ4CGpHXTt8a3TNebDC/GhV3+ANWnQ9tzrBJELwgmWdhpFNRrO5Qh
 Y4EEWMrdxec4XVZNXJs2CIcuB15hkFuqTv7oeTs1YP8jeqP0iErfJ0SinWS+zwiElfb5 +A== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by mx0b-0014ca01.pphosted.com with ESMTP id 33k5nk3qcy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Sep 2020 03:34:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uw53a2QVAs4/pEacAfYdcXyLWCunH71ncgCsFBhmMPYzc8Jlr0NC+tW/8njTabXF3ibBNJ8Dr8gzwP33/Yn0qAndkBNYZgj1OsxtTRnVmqtO8QQIxz0I/G/nTywHrnX8YrlewoOqiek0FucneTsyYA1TfORFpuY7Z+n7rQYBCHOTxssyCDXi73L1GqtwZmfMkoA8C4rMkVGClTkj0GFBbMZYWp6vKX+50yAfsIM+rGv6BGF3YTRSwRmFqRj3o0/poSx1Vf4Wo4b9LT3z6p18kJlP40j6owUckwEAbS8r6gSY9zuB/04W+1K+p1hK/x7G0IEwuCuVvBZYzXydVs2wXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s/xmnS+mi32b5uMqrnSwThxFErDIjUN1KmCAd5Fa9Rs=;
 b=NXJwe1KRBYYDtsRGjdhmevk8TOhtPYeiDUXYKjPLZ3K8jXYpb81rLlAtcr9m5xD9nQMdc128BH8fPy+aHWCZ9uFXdkZ7DFnCH7ZApkzZa4LAju/wkYC8hsw1Z2/JR7T8/2Z/1kG28Ek4wN3lUSAS1ktvPFE3H+Zt3uUWJ/Oo0Qm9i4MhPZ6N6tfF12x9d2CPZUy4Q5+CdY/gOLX0UdxQ1yp5bhjNEQY1nKQG8uMHx82Oywwtnpk2tmMgjAyY6Pehg/K41w3PfMCqM22QzHp7TJaRRWrM7BY6NrVVNCJI+VogaRYAElPyE46N/S4qC17eUzeJXHfvcFMdHo55Jux0oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s/xmnS+mi32b5uMqrnSwThxFErDIjUN1KmCAd5Fa9Rs=;
 b=iKXhcEyzzrl1OqdXhifvThS8ojbPnRaDX8mVDJMfH9p/HtaZ0N2AeOt3wzd6+nsLVKUfrXW7tHtR31WdN6ccNvt69YK5GbfWau50uI7IwBpXEwV+IW7sxhCmWARTPC+48XjvDJKHVwyMjVvnhVwfSgBN8kGCi/aNPQfmGFEwzXo=
Received: from DM5PR1401CA0020.namprd14.prod.outlook.com (2603:10b6:4:4a::30)
 by MN2PR07MB7024.namprd07.prod.outlook.com (2603:10b6:208:1af::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Fri, 18 Sep
 2020 10:34:38 +0000
Received: from DM6NAM12FT017.eop-nam12.prod.protection.outlook.com
 (2603:10b6:4:4a:cafe::ba) by DM5PR1401CA0020.outlook.office365.com
 (2603:10b6:4:4a::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.13 via Frontend
 Transport; Fri, 18 Sep 2020 10:34:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 DM6NAM12FT017.mail.protection.outlook.com (10.13.178.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.6 via Frontend Transport; Fri, 18 Sep 2020 10:34:38 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 08IAYblV011746
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 18 Sep 2020 06:34:37 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Fri, 18 Sep 2020 12:34:35 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 18 Sep 2020 12:34:35 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 08IAYaKL004827;
        Fri, 18 Sep 2020 12:34:36 +0200
Received: (from nadeem@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 08IAYZXp004821;
        Fri, 18 Sep 2020 12:34:35 +0200
From:   Nadeem Athani <nadeem@cadence.com>
To:     <tjoseph@cadence.com>, <lorenzo.pieralisi@arm.com>,
        <robh@kernel.org>, <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <nadeem@cadence.com>, <mparab@cadence.com>, <sjakhade@cadence.com>
Subject: [PATCH] PCI: Cadence: Add quirk for Gen2 controller to do autonomous speed change.
Date:   Fri, 18 Sep 2020 12:34:29 +0200
Message-ID: <20200918103429.4769-1-nadeem@cadence.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 98bac2d4-eaf8-4788-f90d-08d85bbe71f5
X-MS-TrafficTypeDiagnostic: MN2PR07MB7024:
X-Microsoft-Antispam-PRVS: <MN2PR07MB7024066FC1EEAB6A58BB75FAD83F0@MN2PR07MB7024.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: he7Yd/IMWq1zP7Q9fqyRRYjaNnpF+yoVO37Aj/kHSKBj9lLzKsClZ99Dbs0Od2AhFFZnWzfB9jJavqFAfOzZe+NcddutnQRIlTtSNHM5TNblNTYB879jmkLECmCorAWQhi22fjQusBIntnQ4zHFcTVWmv9p3v0+AfvDmKtGR+lI4jZYDEc9dgBXviEqMd2BTJ3/VGzsKZ0+D3JhFvrtDfJZm60x6pBzlfN8UkJtQUBKg3XfDXaDomuPf8LCkrEXlSlNUukZBXtRhWvUzQ6oY/GqCT8HIDFyIqImYRlbSm5uh2kX019GUPT4shMd2mkJiQ87x0wgmphVUmiAR9WgMTnZUUt4ahYsLhbk8ywoKDT6QspwTlqK/hBguD9Qkf9XbI9Z2VPySvBxc9AT046eFQjBlC5A+cK8DKPw7i46yI3Y=
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(376002)(396003)(39860400002)(346002)(136003)(36092001)(46966005)(316002)(42186006)(8936002)(2616005)(70586007)(82310400003)(1076003)(5660300002)(107886003)(26005)(4326008)(83380400001)(6666004)(47076004)(356005)(2906002)(336012)(8676002)(70206006)(186003)(478600001)(426003)(81166007)(86362001)(110136005)(36906005)(82740400003)(36756003)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2020 10:34:38.6074
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98bac2d4-eaf8-4788-f90d-08d85bbe71f5
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT017.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR07MB7024
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-18_14:2020-09-16,2020-09-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 malwarescore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 phishscore=0 lowpriorityscore=0
 clxscore=1011 priorityscore=1501 suspectscore=0 adultscore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009180086
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Cadence controller will not initiate autonomous speed change if
strapped as Gen2. The Retrain bit is set as a quirk to trigger
this speed change.

Signed-off-by: Nadeem Athani <nadeem@cadence.com>
---
 drivers/pci/controller/cadence/pcie-cadence-host.c |   13 +++++++++++++
 drivers/pci/controller/cadence/pcie-cadence.h      |    6 ++++++
 2 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
index 4550e0d..4cb7f29 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
@@ -83,6 +83,8 @@ static int cdns_pcie_host_init_root_port(struct cdns_pcie_rc *rc)
 	struct cdns_pcie *pcie = &rc->pcie;
 	u32 value, ctrl;
 	u32 id;
+	u32 link_cap = CDNS_PCIE_LINK_CAP_OFFSET;
+	u8 sls, lnk_ctl;
 
 	/*
 	 * Set the root complex BAR configuration register:
@@ -111,6 +113,17 @@ static int cdns_pcie_host_init_root_port(struct cdns_pcie_rc *rc)
 	if (rc->device_id != 0xffff)
 		cdns_pcie_rp_writew(pcie, PCI_DEVICE_ID, rc->device_id);
 
+	/* Quirk to enable autonomous speed change for GEN2 controller */
+	/* Reading Supported Link Speed value */
+	sls = PCI_EXP_LNKCAP_SLS &
+		cdns_pcie_rp_readb(pcie, link_cap + PCI_EXP_LNKCAP);
+	if (sls == PCI_EXP_LNKCAP_SLS_5_0GB) {
+		/* Since this a Gen2 controller, set Retrain Link(RL) bit */
+		lnk_ctl = cdns_pcie_rp_readb(pcie, link_cap + PCI_EXP_LNKCTL);
+		lnk_ctl |= PCI_EXP_LNKCTL_RL;
+		cdns_pcie_rp_writeb(pcie, link_cap + PCI_EXP_LNKCTL, lnk_ctl);
+	}
+
 	cdns_pcie_rp_writeb(pcie, PCI_CLASS_REVISION, 0);
 	cdns_pcie_rp_writeb(pcie, PCI_CLASS_PROG, 0);
 	cdns_pcie_rp_writew(pcie, PCI_CLASS_DEVICE, PCI_CLASS_BRIDGE_PCI);
diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index feed1e3..075c263 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -120,6 +120,7 @@
  */
 #define CDNS_PCIE_RP_BASE	0x00200000
 
+#define CDNS_PCIE_LINK_CAP_OFFSET 0xC0
 
 /*
  * Address Translation Registers
@@ -413,6 +414,11 @@ static inline void cdns_pcie_rp_writew(struct cdns_pcie *pcie,
 	cdns_pcie_write_sz(addr, 0x2, value);
 }
 
+static inline u8 cdns_pcie_rp_readb(struct cdns_pcie *pcie, u32 reg)
+{
+	return readb(pcie->reg_base + CDNS_PCIE_RP_BASE + reg);
+}
+
 /* Endpoint Function register access */
 static inline void cdns_pcie_ep_fn_writeb(struct cdns_pcie *pcie, u8 fn,
 					  u32 reg, u8 value)
-- 
1.7.1

