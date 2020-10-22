Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46BB82957A6
	for <lists+linux-pci@lfdr.de>; Thu, 22 Oct 2020 07:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507775AbgJVFIS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Oct 2020 01:08:18 -0400
Received: from mail-eopbgr60055.outbound.protection.outlook.com ([40.107.6.55]:15490
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2507770AbgJVFIR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Oct 2020 01:08:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nHh9E8FTGR/NJ5YR0fHuWzn1o3OAfEV+JZOB1Ms/n01o/oIO0Gdn9LPA3XjBnwKhZLbHoBTEv79b0vfCHyB3mgDINQ3qBTXRgXQa3p3g+UWHZwAyvPbsctTh5cp0jd1dOeoFC1ybGCMcBzMmgQBvQbYNJFKt7MelmJqMIg0zyf8+ExI1cp551P08dWxNaMvjRNKF+UhPtaMC57i10YHZR2IMrJgovgXA1U2bJM1R74FrlBfk9r8lCvq1t9/7zEixbEY+CRQwS1TtdykxWlHiL5k1AntM/Nk8ZHFZJuXAkC80/nKvsLVRm2KAQWDODyN6Y0bx0+MEnfOuZTqv+qJ50A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tgj1fgckGFRLCOi1qs+Wi4Pq/S2ukfQc8lpfJoqHwNI=;
 b=ltFzcnH6XrRE+H+LoN9WN/4epYHdIvxWHu1ik0/cekBLh7NPhJRNzXKdmTiyJE2Gb8w+m0dyguPlJx9PNWO1dE3q5vCvmUplzqjE4nRcPvLG2wh82oJkJ2PSIuYlY2QRTgroxa/5FzmHO65ZL+1Vk+nyGqx9I/lGJPX7wlTDwGDP1+hAkjwbgVth1HbFmZcXVZWO/cv/1z2HwInGWUKM9A/KDlV+HEwcyzj90xWsZCQUDl3zxHzPZ9wi6wsy/4ras8Z+xfPd2rvmvDvVJumPIMRYTtOuKZ3XbyCrwK8cH08R1g9EO7PDLFiZ3i58H5N3xqkP/RahE4fQmN0OHdV3nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tgj1fgckGFRLCOi1qs+Wi4Pq/S2ukfQc8lpfJoqHwNI=;
 b=HGbECRq2rgowOqOGQA4xTpgJH5TYb33SUP+S0KNF1/LPVrxFyyNKEK2a4IzbomXSUDRz0h7REq4GBPiBNojojoTXJZk5fhT0jalYNuNH76zK+m70ueNgy3FVIzxDxuuk1aq3IL5bDg1Lqe68MM9+QWpWLzu+BmTvPC4zkfYc4gE=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com (2603:10a6:803:57::21)
 by VI1PR0402MB3358.eurprd04.prod.outlook.com (2603:10a6:803:11::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.28; Thu, 22 Oct
 2020 05:08:12 +0000
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6]) by VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6%3]) with mapi id 15.20.3477.028; Thu, 22 Oct 2020
 05:08:12 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     hch@infradead.org, sudeep.dutt@intel.com, ashutosh.dixit@intel.com,
        arnd@arndb.de, gregkh@linuxfoundation.org, kishon@ti.com,
        lorenzo.pieralisi@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH V3 4/4] misc: vop: mapping kernel memory to user space as noncached
Date:   Thu, 22 Oct 2020 13:06:38 +0800
Message-Id: <20201022050638.29641-5-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201022050638.29641-1-sherry.sun@nxp.com>
References: <20201022050638.29641-1-sherry.sun@nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR0601CA0012.apcprd06.prod.outlook.com (2603:1096:3::22)
 To VI1PR04MB4960.eurprd04.prod.outlook.com (2603:10a6:803:57::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from nxp.ap.freescale.net (119.31.174.71) by SG2PR0601CA0012.apcprd06.prod.outlook.com (2603:1096:3::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Thu, 22 Oct 2020 05:08:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c0098e4f-b13e-4d2f-9dbe-08d87648799c
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3358:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0402MB335877B3655F79E8201EAE6A921D0@VI1PR0402MB3358.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EVKzBmj0JFVvcezBR6LY1poYVJPS1RyUNo1GhjpxUXDZwjZQ9PV8GnQeFNtF/KV6f++7RrcIUlQV+IFcFzB9Rld/51PFG75iKB7udoPMWD0pvU7FaZK/6SM0N4iUe4n74yO4MHHEcaBEd/oFnfiSFOKdTcO6/HD/KkUnWu4x2PkrLI2Mtvzhe8qYQwefZXA9Bl3V0wjuenCAgyN/qF4plEQaqsSzSzrrL2iTI0bJwlZCAKq56EGFvpOYxYrz1ZtX3ZB79TLo5FQMV/PAff+FF/aTVBnbELW22YC/QkFjyFyH8kcYtSQeCmY8TDOePawvkpIf4u6TOWUlE05SmCqtfQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4960.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(396003)(136003)(346002)(39860400002)(6486002)(6506007)(44832011)(2906002)(66476007)(66946007)(4326008)(83380400001)(86362001)(6512007)(316002)(2616005)(66556008)(956004)(1076003)(4744005)(186003)(26005)(16526019)(478600001)(6666004)(8676002)(36756003)(52116002)(5660300002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: KZI1723ouipAxTm10T94PHPWHaOnaex7EFGgiHrLGbXy/YO7jfMwKOGANRj0B7rffXM4jHdb1KEeAwCwhweb6rhp57PKN++g0we4LeSOrjw+mo5iV6pB/2XhG+xEzQudJtmk/N89UR3BJ0IxtnrDMKr7sJRqWYQEKrq7jmpkuLqsmd3W53XphcVU7e5yg68UFxeVuyKbZYpp3uZiN1Va3QruKVtXXFD2PLCblV1PrmCPzCRLPgPX36YoeSazkNvdG7FlfK3tAs+DRb//nhbYU0RUDxmb8YbcoiALL+bs7ZOTuh630d3HSgLGG3iUsLFKaM39wckJJln7mMAvJJdj68NoMGcRkLdOgUWsKwBmlPH61lsajdLomVOoVOxQ2MP/YopNBavIOcgNt1t8B9py6wNvlHPxrz/9ZGi5yG8Y3HvRgp6GXD/PuqLUXVXvoWO99MVR8HyDJXyWnoeeiuwGI7pZclFjF7tCOlUIm/ARn+S3QN9iJrzJ7Y74khUMSNtwhvo4RmZQzzc/XqP94AVCUjIZuZ48e6S2W/J9DaO2JpuWpK3lXVT3o1cG3Zt6p7+0W2PCc6DkfdNN2kofhgGUJinX38KU4cmflFP23TVV5b9SLMTWBigqcjHoxygVPc10udMCrheB1sDWtjZol1ECiA==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0098e4f-b13e-4d2f-9dbe-08d87648799c
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4960.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2020 05:08:12.6203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3VZikJOg6LurjXvgv1TYVR7E51WsucdVE0gF/0pRuZmnuK455ABNyzugUXbEKZ9oW2tx35GLxqw9dsHI98cqEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3358
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Mapping kernel space memory to user space as noncached, since user space
need check the updates of avail_idx and device page flags timely.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/misc/mic/vop/vop_vringh.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/mic/vop/vop_vringh.c b/drivers/misc/mic/vop/vop_vringh.c
index b5612183dcb8..b75c2b713a3b 100644
--- a/drivers/misc/mic/vop/vop_vringh.c
+++ b/drivers/misc/mic/vop/vop_vringh.c
@@ -1058,7 +1058,7 @@ static int vop_mmap(struct file *f, struct vm_area_struct *vma)
 		}
 		err = remap_pfn_range(vma, vma->vm_start + offset,
 				      pa >> PAGE_SHIFT, size,
-				      vma->vm_page_prot);
+				      pgprot_noncached(vma->vm_page_prot));
 		if (err)
 			goto ret;
 		size_rem -= size;
-- 
2.17.1

