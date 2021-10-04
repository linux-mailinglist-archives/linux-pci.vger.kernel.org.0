Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F277B420FE8
	for <lists+linux-pci@lfdr.de>; Mon,  4 Oct 2021 15:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237797AbhJDNjM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Oct 2021 09:39:12 -0400
Received: from mail-dm3nam07on2046.outbound.protection.outlook.com ([40.107.95.46]:63713
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237777AbhJDNgu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 Oct 2021 09:36:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WmhiKwZV3TbDCWx0mQep8TRSfnHa1+vu4wpKu6vqBNNfKUCEFSSVQnMCd/VusHpMnqO44IM7I4PPbkZPyGWUqcBWjnWD5GaQlVb0vt0IEbK1vXg01dY4HQXuPMEZXZNJtGa2KxQhSUceR8pjBmLVdl9omFq3e8IVOMvuJOcYoZMG2f2rhrktig9C1FhF6KrFqE+qbKgwLfOe43zJTj0aH0LCC66PtauJFUilIV2etcl4az2hSAhmiOABAtaK9RMluJ8lslZcHF4pJWw/NykxJ6H09Ei4nE+ZPH1ACe/gRVfse1C1oHNWk2jkRDOfvJQ1ZVK02N2rFlbksIhpxP0GYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XXcIVea1o13qrb0O4CPv5uRDyJhKAEkDvnNPz8xNytU=;
 b=fzsx1jD3MaVERL1PIhadhZa8rrYfq9IVS+oXBepDl2dtou8awmP/ncUIiHymFNaH2PnLOC7pCd9MPJn/H+gKmIjNHyXaBEiEud2FT79YfHTP2CxbF02/yZJBgO2GR2VlI33N6iTpasul2wUO3rHlCrpFnwrEtvujEqXwHzZ1DpMUtbYO2nA6GY1GNGa80pJr/d2rRQT+IbqrVwqjK1KwdnY+lMzRv7+yaSF74GI49Umw3+RkrUxDkexN9wqNy1TT1+6A62gHyUZHQ/iC7PN+esizsqoXANP45XmAcsGtONtPA7PGiAWencX8rNb8FyEliEgKFdq1byChyfw8GHatBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XXcIVea1o13qrb0O4CPv5uRDyJhKAEkDvnNPz8xNytU=;
 b=lR68xbYGHtnEGhC7+r6OhnDxAVpso3YclMSoyIoGBfZ5DMNbyL0gmo0iWWncC8kIzr22jE5chUF+dA9av6tnbVT0rwtpvA5YbEu49Q6tA3ZmYV3gdXVS1B6MyUWX5lJ84a5MT9pOy1T4ibep1RMLphoppcWwr+KwNpAI5Kw6SiBlTq4qYzi+1aLOj4QcDjB1IIQaWRgBVZSjLAtRK4klUOjvvFv6gES6SwtB1EAE8djX0k9ED3WhK92n+hJQUCNrQ8BYZqwqVVIw9jtF3OR8nSeiyZxIyikHRppD8Z0386eTVOuxFadkzOODVvjtuu+whBlMZk9L0zuhHiHy8yeA3Q==
Received: from CO2PR04CA0126.namprd04.prod.outlook.com (2603:10b6:104:7::28)
 by DM6PR12MB4713.namprd12.prod.outlook.com (2603:10b6:5:7d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22; Mon, 4 Oct
 2021 13:35:00 +0000
Received: from CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:7:cafe::b3) by CO2PR04CA0126.outlook.office365.com
 (2603:10b6:104:7::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15 via Frontend
 Transport; Mon, 4 Oct 2021 13:34:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 CO1NAM11FT026.mail.protection.outlook.com (10.13.175.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4566.14 via Frontend Transport; Mon, 4 Oct 2021 13:34:59 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 4 Oct
 2021 13:34:59 +0000
Received: from r-arch-stor03.mtr.labs.mlnx (172.20.187.6) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Mon, 4 Oct 2021 13:34:57 +0000
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
To:     <hch@infradead.org>, <linux-kernel@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <linux-pci@vger.kernel.org>,
        <bhelgaas@google.com>
CC:     <stefanha@redhat.com>, <oren@nvidia.com>, <kw@linux.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH v3 2/2] PCI/sysfs: use NUMA_NO_NODE macro
Date:   Mon, 4 Oct 2021 16:34:53 +0300
Message-ID: <20211004133453.18881-2-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20211004133453.18881-1-mgurtovoy@nvidia.com>
References: <20211004133453.18881-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a72f98b8-2c20-4d6d-e21e-08d9873bc336
X-MS-TrafficTypeDiagnostic: DM6PR12MB4713:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4713C00CF8CABD7CC8C98F9DDEAE9@DM6PR12MB4713.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bB4MJgDFFeogyrmuyJJYhWHJ6GSUpigsz2x4hSU50zwZYlM2r42R7OmrrFLGNZxaRW3OuDdbzVtg8D5LOa9Ty8xWVJ+eW3n35sJ5xVwI7pfJMph3sMuI0OptYz2BeWH2TQ6xbo3kLx8F6H32Aa5KezBhD7nTDpk3CuZvlEVzhhuozDMEOn8edGORb3l8NmuYNHjoR4tfk6vHKylYGn77C5adf/AF+ZaTrG6KGwyJR5vrR8+1ObsyguiXm0QRaZ1h2yHBWUtCkLu1TMWWqm+6Ozw0R+QUouMkTEfU849HCInVrOBu1gSbpSG3USfAIwu2yQDeuXqM8Ogh3XmZR8e6o0GNLwrYP882Tsq8EcjqiimpmhZHwZj5VI5uCcSehBJwmFDR2c2FT2h3vRKtVK6907HXsl9xrSuMBuhfDKCYiR+Eu9uF1Sgno1oqmFIs19B7t0b85cu+i6xhv4g3d929WLqWv5f+OdnyRwLQaVYISYfX7+gsBzfM/ZMT9QGF7ggiTG204f08ORxi1IDPDd6LEKK+RAbCMSc+Lw7xt6m2LCzMIxavJORVYwxHeXDsVLaFUL2REgz/oxnvhPdbejODrK2vSUgIOMqne666SCB4mfAfA6ISOA0iWepPKRx6rVzmdlEU/Q2qUP2Wf6tE1oz+hkIvPUt7OYYopXvQFlZXODJFu8SlUw5btWfkCMXoHvNhttF4jqB/SOui5t25Cc2pjg==
X-Forefront-Antispam-Report: CIP:216.228.112.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid05.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(107886003)(2616005)(316002)(36906005)(336012)(426003)(356005)(110136005)(4326008)(8676002)(70586007)(86362001)(8936002)(7636003)(6666004)(36756003)(47076005)(36860700001)(54906003)(2906002)(186003)(4744005)(508600001)(82310400003)(70206006)(26005)(83380400001)(5660300002)(1076003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2021 13:34:59.6410
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a72f98b8-2c20-4d6d-e21e-08d9873bc336
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.36];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4713
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use the proper macro instead of hard-coded (-1) value.

Suggested-by: Krzysztof Wilczyński <kw@linux.com>
Reviewed-by: Krzysztof Wilczyński <kw@linux.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/pci/pci-sysfs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 7fb5cd17cc98..f807b92afa6c 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -81,8 +81,10 @@ static ssize_t pci_dev_show_local_cpu(struct device *dev, bool list,
 	const struct cpumask *mask;
 
 #ifdef CONFIG_NUMA
-	mask = (dev_to_node(dev) == -1) ? cpu_online_mask :
-					  cpumask_of_node(dev_to_node(dev));
+	if (dev_to_node(dev) == NUMA_NO_NODE)
+		mask = cpu_online_mask;
+	else
+		mask = cpumask_of_node(dev_to_node(dev));
 #else
 	mask = cpumask_of_pcibus(to_pci_dev(dev)->bus);
 #endif
-- 
2.18.1

