Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E20AC6E6DDD
	for <lists+linux-pci@lfdr.de>; Tue, 18 Apr 2023 23:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232837AbjDRVFw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Apr 2023 17:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232834AbjDRVFs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Apr 2023 17:05:48 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409179EC6;
        Tue, 18 Apr 2023 14:05:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MOfmHt8dJFdnfmnRJHbjIqdGr15IrOZOZG30neTl3rAwd8jqvpi6Ur5AYLakNOpOPSDqmLZ8vKCr+NqW2BrmV+6X/H6FPkBUFOJZ1cWv6WItVAb6KHEm6q7Eo8udGeIi9iA5O+I34AenCIrMoEV8zLP7720v5Bhwq99l5i0sW5goIpoBzR+ddM80TaBWMB0CuVIPWpLqvv0392dJNCw/saO8cuhiB8NPUtF4iTe9vYzXxqveRL0vfFHudE3bbCZOxlSaYVTI6ZYTbgIkJf8a0Pe6nT4ip5xlDjg21AB8uBWMCuopMLbxxzAUuUROcUZBhtaICuuitTNffQ3nw9Q+zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QtePaqksZc8XoaO/o8KDI+VRfVhOhKrJ0skPy4eEXPQ=;
 b=NfQR5IrZ9yZMFQvFHccDYJy0HocVZjPNBcexTkoNwsf6w6yCIRSVETsow7ML2Ua8B899x6Jq/3yZGOuONXR84Y8OMCg+YMYdWhfxjs+ND294GvyP6Adm+kUdNLjfreOLBCOrVUC+DrbZLNXPFU3gDG9TXqbCDRCdE1dw9cW7/sZ50hpWnalIGjF5rxkgLkpzCpZDG1RB4t0rVTIMWbvW8Ty9ULre7c9R1gzqDIwh/PCZU11U/1D9IlIM5VC6Nm1GeFgkJtdQ4X3XuHSCdNjmvJ8xEe8aHkxDIQo+67ifinGq4Yg5UqetgtsRuyrXKKX/+jHBpboUD4CBwzIC1jBByQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QtePaqksZc8XoaO/o8KDI+VRfVhOhKrJ0skPy4eEXPQ=;
 b=tcdbBRjjxcJwNIG8kmLywb1SizIzdV2IRWAfWxS3lG07rySPL4AU5zYzYb/v/Ap2mpDRDJg+aag/eVGaLHo88cXVDkEeYw6UZHFgo9yfqYfa27VE58S6+KhH1rRw4iMfr2lfj65KE20v8DQEMR+yvq1rSJN7N/yMyzu55hDS7Q0=
Received: from MW4PR03CA0238.namprd03.prod.outlook.com (2603:10b6:303:b9::33)
 by BN9PR12MB5145.namprd12.prod.outlook.com (2603:10b6:408:136::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Tue, 18 Apr
 2023 21:05:44 +0000
Received: from CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::1f) by MW4PR03CA0238.outlook.office365.com
 (2603:10b6:303:b9::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.46 via Frontend
 Transport; Tue, 18 Apr 2023 21:05:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT003.mail.protection.outlook.com (10.13.175.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.20 via Frontend Transport; Tue, 18 Apr 2023 21:05:43 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 18 Apr
 2023 16:05:42 -0500
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>, <oohall@gmail.com>,
        "Mahesh J Salgaonkar" <mahesh@linux.ibm.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Kuppuswamy Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Fontenot Nathan <Nathan.Fontenot@amd.com>,
        "Smita Koralahalli" <Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH v2 2/2] PCI: pciehp: Clear the optional capabilities in DEVCTL2 on a hot-plug
Date:   Tue, 18 Apr 2023 21:05:26 +0000
Message-ID: <20230418210526.36514-3-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230418210526.36514-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20230418210526.36514-1-Smita.KoralahalliChannabasappa@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT003:EE_|BN9PR12MB5145:EE_
X-MS-Office365-Filtering-Correlation-Id: c7e506fb-1fd5-49f0-84c8-08db4050ac9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p+VVOXLQ6VEx9+q+2rnEAWn9PvSL+mB4SBk23H1O9lkf/lxXf+cw4Zgn1TDySlDFaVHz34GSVxdvYTCwP8Hhx8aFPo4xZQJY3PN2DvLW9UtCMKKXnlwc2+z/hgxvYzoVoNJfvX8cJW8rmiIG4vNj2T915umx//HXbaVl7xy58BLRCV21E6BBgIHjfNUu9t8H6kIrUFP6IXAlZQNNHXDhKuOcGo1NQ3WkzIOAmDZJKyXOoAvOP/mDgVEtGIBYd+93ex6Yhg3IsVo2vX/O4Qtjzjo1boaxIJ5sI2R5FKxyC386v8wFB64DJ+2Tjb9Hiy4mkTDr5BFEcsWWf1zGj6AygSk6eiH9ZB4Ax0tAvJbfyXBbR+0Ea7woHiATXEk3aB9fuFOsSzaq9jAdDKRnAbcDhF57tpCxBZx0nJ2znwcqrQR5XlmDGczCOHFTjw6xz36vVWau4Pfc/YLVeogR6SpSRuPzgme8CemJUujaXhoLHfZ4WS7+/yqdt7L56zvjuIZH4l9n8BPiuFF77Pwbs2V8c/aBsChJ6Qywfz7Og6aaasHuinDHDCEvYtK7pvb6gt5jfJs8fX4kH4EuY2icvGu/ZBzTyQxO+At/i5kqTbcAbo61NHPK6jFZUE5yQOjS6kOh42eX8Z8oUYwvcNiUCQ6qORtJ/dtFj4n4Al1x+2GXPhj4GFPtlUHSE3y1cBqqOotCRB5bkWsD3uGDCcuYIK6ZgoxaZt//iV2ND6wBioiGqys=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(39860400002)(136003)(451199021)(40470700004)(36840700001)(46966006)(36860700001)(2616005)(54906003)(110136005)(26005)(1076003)(478600001)(82740400003)(70586007)(70206006)(47076005)(316002)(83380400001)(7696005)(6666004)(186003)(966005)(16526019)(336012)(4326008)(426003)(8676002)(8936002)(2906002)(41300700001)(5660300002)(356005)(82310400005)(81166007)(36756003)(40460700003)(40480700001)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2023 21:05:43.7744
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7e506fb-1fd5-49f0-84c8-08db4050ac9c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5145
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Clear all capabilities in Device Control 2 register as they are optional
and it is not determined whether the next device inserted will support
these capabilities. Moreover, Section 6.13 of the PCIe Base
Specification [1], recommends clearing the ARI Forwarding Enable bit on
a hot-plug event as its not guaranteed that the newly added component
is in fact an ARI device.

[1] PCI Express Base Specification Revision 6.0, Dec 16 2021.
    https://members.pcisig.com/wg/PCI-SIG/document/16609

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
v2:
	Clear all optional capabilities in Device Control 2 register
	instead of individually clearing ARI Forwarding Enable,
	AtomicOp Requestor Enable and 10-bit Tag Requestor Enable.
---
 drivers/pci/hotplug/pciehp_pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pciehp_pci.c
index d17f3bf36f70..aabf7884ff30 100644
--- a/drivers/pci/hotplug/pciehp_pci.c
+++ b/drivers/pci/hotplug/pciehp_pci.c
@@ -104,6 +104,7 @@ void pciehp_unconfigure_device(struct controller *ctrl, bool presence)
 	list_for_each_entry_safe_reverse(dev, temp, &parent->devices,
 					 bus_list) {
 		pci_dev_get(dev);
+		pcie_capability_clear_word(dev, PCI_EXP_DEVCTL2, 0xffff);
 		pci_stop_and_remove_bus_device(dev);
 		/*
 		 * Ensure that no new Requests will be generated from
-- 
2.17.1

