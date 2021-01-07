Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C462C2ED612
	for <lists+linux-pci@lfdr.de>; Thu,  7 Jan 2021 18:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbhAGRwD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Jan 2021 12:52:03 -0500
Received: from mail-dm6nam10on2080.outbound.protection.outlook.com ([40.107.93.80]:54976
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728066AbhAGRwD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Jan 2021 12:52:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cXSBxPqa7RkT9eZ+9VrcKB+u3O352xiObA06KhsjiukdbFD4y5UBYpSzUBCjUh0g+YzsNwQAc1EW8AWf1PWryuYQOfWalJ52bbeg1rmyWqWc1CcTm588oOt3Rhsg/jiuzDLd9tzNNgdhwW0x2QiqHAGo0CkZieqajDWOX0Acohe66Jjt/7n06aicGUcrCUQENU/VO3w6upgNZlRGQ5Y6FlpRroNiJVUaX8ts3VXOI3QB/VP6GrTp99Vi43XH4yKMcJdACAJA0aOWEhkUaTaZZDUrEfaJm+CEf2HS1aBMqWWsztMYSh1YofF8oIhga5VrF8xygl24Adad7aWX0Yxgaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sg/CDzXyze3tWUJxj0mz1HiBNVrEWG7Jo2YIZ4wHVUk=;
 b=lRAbROB/o7M3+hXHDCtR4qjyDcFabWowkDQ42dDDGR5v7mnOrGYceD7m2C00hMPfOtYgJxIBFmCEoRuk980zmdYfR5KtjDVCej4QEwT5TajVXShCoiluWFX6eBIrmm15gA6nb91ygQs2h6tNDQZui2lIzFh/YeC1kdNCeLEjZjVXHSGftSXtKe5nxfHMvnyVxBjEdCcBRf6qfLyhPxOd3TwiSnbGBSxdiKM4TuWji+R9jSiI2vjECE8i0HjGoWlzNy84GFHFbRxswyIVYcjmmVYwoOpUOg47UAWT9Sz4IIiwWnLMH7dOPK32XZFy9eCNgXXVZKObDtXRWxW+X2toPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sg/CDzXyze3tWUJxj0mz1HiBNVrEWG7Jo2YIZ4wHVUk=;
 b=fC9Pd8JQuIWgGTx0qc0tFEvyoP3CgaJ4qKoF97572WQNwYRmi/zpWCe1wkZc66cmo5YrmWAfOekMQZlugs64F7QNRZDljqoC8eLj6+U9KAjyX1bJ89qsAymHzJN42fLvHtQDRcUP/AFr3Ynrm5/Jo/0a3s17e3WESx8Zb9yF64U=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM6PR12MB3066.namprd12.prod.outlook.com (2603:10b6:5:11a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Thu, 7 Jan
 2021 17:50:50 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::f872:3677:28c3:660b]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::f872:3677:28c3:660b%5]) with mapi id 15.20.3721.024; Thu, 7 Jan 2021
 17:50:50 +0000
From:   Nirmoy Das <nirmoy.das@amd.com>
To:     bhelgaas@google.com
Cc:     ckoenig.leichtzumerken@gmail.com, linux-pci@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devspam@moreofthesa.me.uk,
        Nirmoy Das <nirmoy.das@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 2/4] PCI: Add pci_rebar_bytes_to_size()
Date:   Thu,  7 Jan 2021 18:50:15 +0100
Message-Id: <20210107175017.15893-3-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210107175017.15893-1-nirmoy.das@amd.com>
References: <20210107175017.15893-1-nirmoy.das@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [217.86.111.165]
X-ClientProxiedBy: AM0PR03CA0093.eurprd03.prod.outlook.com
 (2603:10a6:208:69::34) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.111.165) by AM0PR03CA0093.eurprd03.prod.outlook.com (2603:10a6:208:69::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend Transport; Thu, 7 Jan 2021 17:50:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1659d772-1a1e-4a33-07b1-08d8b334c536
X-MS-TrafficTypeDiagnostic: DM6PR12MB3066:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3066DD336F5BC4B6F31333308BAF0@DM6PR12MB3066.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:586;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8fZVVfVQKUhK4jHgy0xx2FcF5EODaYXNclS8auonvf6NDsJnnpZhztuNSHp/N6VmU6EAiTBsP9NNZRtdd268f2SnW9Q18Zg1A8MbJUFD0zqtejNYn89P+XLsbnaE/0+JYFJFtjuTWP299mswkTFuw5BNMVgLbCslxytGijBmOakD8tVBeWIaSA2cCSIZrEUBG2uod1zPeO5d5OLlop/5k/TYhkD5U9TWOJalyBlY0+8a0cuOYaRIAOMfboz2xrg7iii62QMe1jCNL6yHfYr1CxnM5Dfc/IYnK3xxLuA8iW9hI10GEpqsQd7oVAFOmDIz087AsxImzn5EAi+pXVZ7gU3bS8lIoYiJgbNzQ/bFIP6W+jLC7OS2NcEWyp2k8qmCyXGFKFur6G2eHzPq+1mWjQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3916.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(376002)(136003)(39860400002)(396003)(4326008)(6916009)(316002)(1076003)(66574015)(83380400001)(478600001)(6486002)(54906003)(36756003)(26005)(66476007)(66556008)(5660300002)(8936002)(66946007)(2616005)(16526019)(44832011)(2906002)(52116002)(6506007)(8676002)(86362001)(6666004)(956004)(6512007)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ajJyWnJpTWpISVpCa2xXYksxUUJqVzFpMHZFN053ZkYzYWFLU29BTjBkUGhF?=
 =?utf-8?B?aGc1WXlzTWkydjNrOGxqdTRocjdpQTNFakFqNFZPeEpWa3VjYmFTc1BlRUJr?=
 =?utf-8?B?YzZ1YUhZMStMWnl4eXFSRFFSMURqdU1GVytmZTJ3UHFkTC9VbE5vb1ZuVXNy?=
 =?utf-8?B?ZThaTzUzVTVmL0NkaE5STjR4a0pHeWhEclpqWkhZcWJTNlRDQUJJbjFMTkFH?=
 =?utf-8?B?MmtweDJlNHczUk5VSW1aZFJ3eU5BRHBJNjkyaG1nTnpJMTV6bWZtSEFmSTdF?=
 =?utf-8?B?RE1LTThBanA2V3NLMk91Z2xkVnc4NlBteTYxY2J6VkIvVXB6QmRWQkJvWWF1?=
 =?utf-8?B?RnlqS25pWjl0TlZSeTJuS3lQT1VWcHNiVUlqWVlicFp4c052UHhXd1Mrek1S?=
 =?utf-8?B?dHpha1lwcEpOMy9OY2UzdWFwVEYvaXE3NWJUZ1kxWDdnTXo0UU9NSUFQVmRh?=
 =?utf-8?B?SEVqOUhRckFzVExaclNTV2JDRHhKUDZNckdnV3BPTFBKQStxc3p5VGFSWlo3?=
 =?utf-8?B?QW5jOHlJWHhrKzllZ3UzZGY1bFZVcFY4K01jK0hZZnU4djVjUGxpUHYyWUdM?=
 =?utf-8?B?TmQ4SDFtcm4xVnk4c1dFM2M0elF4UG91WHZyTFM5V0pWZklYWWFzL2E0L2ZN?=
 =?utf-8?B?dk1YN2tMZlA2WVVDSHlaZFloRW1LbHdtRFIvUC9xZTNyN0pqK1N6djZHc2FT?=
 =?utf-8?B?dHhwQjhJZFQxTkc5WS9GcStTOWp4Q2NBOG1IcTQrbGVrbVlQbUNxcmFhZTRX?=
 =?utf-8?B?c2RzOTNMQ3lmSGhJY1FMODdNOFdLKzRkeHZOSlVCSjZ2OXQvNlNlZGk5Wkc4?=
 =?utf-8?B?c1JoQ2VSYU9UT1g4VjdpSThGSk94bE5CdWNsektNaWlHMEJvNkN3U3FyN1Nh?=
 =?utf-8?B?ejB6OGQ2YWNGRWZOMmNzelpHT2RTSTBWb2pOZlJtdkk3NE5tRFFYdG85dFQ1?=
 =?utf-8?B?NGovMEp3Tnd5UWhFOCticUJmaHdvKzNpYkJWS0RKMmlnRzkwNzIweFR1NXNh?=
 =?utf-8?B?VUhYTE83UGh0dVRLdHpsczB2RW9XcHRNWmtwNmxzb3NWUzZrOHRuYm5icUxY?=
 =?utf-8?B?eERkYUlOTTJmcjNWM3Y3bWMzTy9mbGhIQ1YvTVpuYTJUV3diV1NYb3hjU1FT?=
 =?utf-8?B?a04xNTlOQ3k2Y1dkWHlIYXJjZFUwRk1JcnBFYktLRTJHMHdTai9ZNEpCYSs0?=
 =?utf-8?B?RWVaNmhIbWJvU1kxSDhWYlFsNzhtenZTVko2cWFVajR2eklKRndzKzZuR29h?=
 =?utf-8?B?VzV4RHR6MHI4N0JldXRFODhpam44ZE1BR0ducXVYSEg5R255dE43UHNZUXZJ?=
 =?utf-8?Q?fhHJbS2zEG8yj1EaaIs5IN1PyWt9VdspsN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2021 17:50:50.0039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 1659d772-1a1e-4a33-07b1-08d8b334c536
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cvmwmxmnAHZyZeyNm+GhAqb96CSZkvyjrdQvBLiS+FL7R7PgdhYzE0pXLLBEkidf24ITTHsPCF8xKc2vogT67A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3066
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Users of pci_resize_resource() need a way to calculate bar size
from desired bytes. Add a helper function and export it so that
modular drivers can use it.

Signed-off-by: Darren Salt <devspam@moreofthesa.me.uk>
Signed-off-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/pci/pci.c   | 2 +-
 include/linux/pci.h | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index ef80ed451415..16216186b51c 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1648,7 +1648,7 @@ static void pci_restore_rebar_state(struct pci_dev *pdev)
 		pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
 		bar_idx = ctrl & PCI_REBAR_CTRL_BAR_IDX;
 		res = pdev->resource + bar_idx;
-		size = ilog2(resource_size(res)) - 20;
+		size = pci_rebar_bytes_to_size(resource_size(res));
 		ctrl &= ~PCI_REBAR_CTRL_BAR_SIZE;
 		ctrl |= size << PCI_REBAR_CTRL_BAR_SHIFT;
 		pci_write_config_dword(pdev, pos + PCI_REBAR_CTRL, ctrl);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 9999040cfad9..77fed01523e0 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1226,6 +1226,12 @@ void pci_update_resource(struct pci_dev *dev, int resno);
 int __must_check pci_assign_resource(struct pci_dev *dev, int i);
 int __must_check pci_reassign_resource(struct pci_dev *dev, int i, resource_size_t add_size, resource_size_t align);
 void pci_release_resource(struct pci_dev *dev, int resno);
+static inline int pci_rebar_bytes_to_size(u64 bytes)
+{
+	bytes = roundup_pow_of_two(bytes);
+	return max(ilog2(bytes), 20) - 20;
+}
+
 u32 pci_rebar_get_possible_sizes(struct pci_dev *pdev, int bar);
 int __must_check pci_resize_resource(struct pci_dev *dev, int i, int size);
 int pci_select_bars(struct pci_dev *dev, unsigned long flags);
-- 
2.29.2

