Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ACC6336B35
	for <lists+linux-pci@lfdr.de>; Thu, 11 Mar 2021 05:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbhCKEl7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Mar 2021 23:41:59 -0500
Received: from mail-mw2nam12on2081.outbound.protection.outlook.com ([40.107.244.81]:30145
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230462AbhCKEl7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 Mar 2021 23:41:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T3SDdaPMUICdJYhvTwkKUb9s3Wgbo1kCUsWe2K1uZs8rpyz0NryGa4T69H1xDTVgOFd9gKjOqnI5+BC0Q0w4T4rrTM9xYEoFHoE/XUcCkN6IFxaJmjODl1eeV/aK532GBuTBp5/C4Bk9aMqxRiPIZ1WBDU57CFpIaU1yg8vwue0yU5bd2wazSSUrkhXMls4grBhZxzukrMvoliM7bMpIUqnybKVGiZUko5SJCXhCI5LtF/doBnLvVtQjUrQ3gYbdO4ujjYCJnzvmI9Y5Ol5fhjJDO7M3V/J307v8ff+53VkLH0hVAv+DfZknEOXB5JqujpEv5NK/rqrcs56mIoYnPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o0OnuqORNc6sP2wrmNiq8O4zzycpCg3R9mqfgEcRiNE=;
 b=WGjQTegkNwGurm38o7d8LB9ccEX8ZIYZKv50CRU6NwlBvqyjLz1ZvjaDq0YIRReDYb7rz0DEuRQSrSRfT8tjcMcPnS6Gu70bXZGnGaeFAsYX9y5O3wFexzpWqGLUGNf0bzfPk+2pFUZp5/xOjmwkNU5W1AntsgzHOr1Hu+IYKjMgIKWarmLZQ5XRzmOyu6UJEoHzhuRNh/TK0rkd3I/qO966vg94Ug2aBvvpjDC2Hb54Rt0fdQ/tUaUOtjFhSqylads6WvQLtwOaTuv1JjJj70MMA6jmxTM9MhOD7sIPHIowhfEzMPLT9rjtsjgDA/KUqyVFo0Ji6e8xetLPLbIYUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o0OnuqORNc6sP2wrmNiq8O4zzycpCg3R9mqfgEcRiNE=;
 b=q9x9ZiqfuUfKoh5gtuDGKr15zJdVBKy/NwBzzs+NK5qOAdtFrHcNtM1gBNdtahYbI4RDlOlgPZOf+iw9qcB6UPyBq018xtCxEpZbGFWyg/5Sn7Y7mi247g+Tx2C+GkPb6OlwUL8S9JN6NwIGFPr0WtQmwDkF3vbnJNpmAwS3UtY=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB4885.namprd12.prod.outlook.com (2603:10b6:a03:1de::20)
 by BYAPR12MB3143.namprd12.prod.outlook.com (2603:10b6:a03:a8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.30; Thu, 11 Mar
 2021 04:41:57 +0000
Received: from BY5PR12MB4885.namprd12.prod.outlook.com
 ([fe80::7c8b:b3e8:be0d:e84a]) by BY5PR12MB4885.namprd12.prod.outlook.com
 ([fe80::7c8b:b3e8:be0d:e84a%9]) with mapi id 15.20.3912.030; Thu, 11 Mar 2021
 04:41:57 +0000
From:   Shirish S <shirish.s@amd.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Julian Schroeder <julian.schroeder@amd.com>
Subject: [PATCH] PCI: Add AMD RV2 based APUs, such as 3015Ce, to D3hot to D3 quirk table.
Date:   Thu, 11 Mar 2021 10:11:35 +0530
Message-Id: <20210311044135.119942-1-shirish.s@amd.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [165.204.156.251]
X-ClientProxiedBy: MAXPR0101CA0048.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:d::34) To BY5PR12MB4885.namprd12.prod.outlook.com
 (2603:10b6:a03:1de::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from amd-WhiteHaven.amd.com (165.204.156.251) by MAXPR0101CA0048.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:d::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Thu, 11 Mar 2021 04:41:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d9fb9ce2-4e4d-4d11-db0c-08d8e4480092
X-MS-TrafficTypeDiagnostic: BYAPR12MB3143:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB31432C7E8362176507B56E23F2909@BYAPR12MB3143.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:252;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jh+UxFIJ+U3LTQcVGJkGe7gOiIw4Yz2tPuPNOhCsXJER3b5EG1V6gfuKLHsno+ekj7RiZGRaqGDrQ5lWd4uNJwygW2XnbB3pmdpWP4CfckmrxAiARqIp72eljBP40IwoHzyNYnwe8ufZbqD0o0zXjhrh35ltgel7kC23tkGd0aJm9i3bpnQ8WkPoQHkGp1YKZHSR9/xouk4MAv7IKHgWHiGBvMDNVLKvfLF+LrJu/rHYC9O7q9Wgvvl7ivl5U246jrZVZGx+a2NosMi8bD7RMy7k8rcXG9AaEkDi0KsRDJVQ1oEzygysZYlXUd8f3xhS3tfJSyGfSwSb2z2By3J8T/QOP6/m4zCq4nRFm9vBH8gnjbC48srR4R3Hqj+1YhRniLKYI+T1srR8vzzfY+IgxWn0vn9CePhRXLpSbk/DEdQaHG9JcniXbjGTzvTjPkPB9ndeak1o4TgmyCBoSiICQ08tu2hbTIctqkHra3KzXPa2mYEeiVXLkk93IgHV8gXkv2bUNxAlCTPvg+7CiC3Gyp1YO++nwubYXJ3+VMtQbYzsYVLGtPceGNa62BooUdCj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4885.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(366004)(396003)(346002)(66946007)(66556008)(8676002)(316002)(26005)(2906002)(7696005)(66476007)(86362001)(52116002)(5660300002)(186003)(36756003)(6486002)(478600001)(4326008)(16526019)(6666004)(8936002)(1076003)(2616005)(956004)(4744005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?OtGC5zQzZsu1+v/pdtTRZaqdXyTN2ric5i8Bo09QBn1pljE6HeIgDQw8QXBJ?=
 =?us-ascii?Q?nrjtuYaYkikTthwXNUcsScuaWwP21ZJVy+5Yj+feUWYNmNu/oymSQuS7MhVL?=
 =?us-ascii?Q?OCnuUmAX0R1makcbyBNqoScFwvybBtZaaO/vEKO0BrNOeJ8xh+dX4n3dM1rQ?=
 =?us-ascii?Q?VCrPdjEuGezG68f4HJ+jt4ljPNYdP+hsBMjHtVxAxQwT7CHoCPAENTiDVJMZ?=
 =?us-ascii?Q?xUqkjHI7gNUnOTPr8id9jJPN9LpMZVBjTG5K50mit/ZGpihiDOdrntp/sTZf?=
 =?us-ascii?Q?7gsTiVGJc5IbIGMRjvDEhsdiriAg4urIGdZBG6rAmkUAp/1wxwzN7Nf0LLKc?=
 =?us-ascii?Q?2EtacktLU0xdnWfXOQ5ULewjAlQGLxNUM8d7lEOgcDz+rIfGnS3NlB3YjDPU?=
 =?us-ascii?Q?prRmxFDuRm6ZS0HI4zo6cyO9GIFm1bpYcra+ysqNz3ZC94u9iQIeQ/dI1XSJ?=
 =?us-ascii?Q?SLEVaoN9Uumi0Km3sDMUwbVX33D8IPXbrarcf5iXsOZzBa6V8LwvQTCqwQCB?=
 =?us-ascii?Q?0JVYJiWTfU5IOfnPP+YkzWGWMmTuov5x17HY4DXUlY45n3Cc68Yb45lDCkbB?=
 =?us-ascii?Q?drD4djzJ6PV3p3D9FbDjti4jKJZ+kx1csJP8qnxW4bQ0BfXGfXp2cDVJHGDc?=
 =?us-ascii?Q?6o74LfPSdRBalWogVlBSOD5OT/qCpyGWeBRy3N3N4MaU5ntvKihFUSCQx5my?=
 =?us-ascii?Q?tiV/upnhNPKmeHoYKRjWeiYhHFuBd36kPHxltVYqDGPq7Iaen7T5RrpiIJyX?=
 =?us-ascii?Q?QTMHT+HR561NqqZQYo8pTDrkGL2Y9GvUSo6UAswlK/NLE8ZGLPBeWkMBgTg1?=
 =?us-ascii?Q?pLfJ191EsC4ca5wbPz9TA56Sg1A36maJZzs3fjOqYMEWpGd8CO4PcU/SkPlG?=
 =?us-ascii?Q?0unvbL4UHc1GZ2fS7zcFAmi9ik5i8NGELcip73JhuwYmm0aq7wTTybEBID5p?=
 =?us-ascii?Q?eU/RigoQwU6dQ8He9L1mAfqvS7wkXMDRJLS8+ExlAPz5oVGV8BBiOd6Sy5PG?=
 =?us-ascii?Q?wiencDm7hmNcJN16ov2WRUT4x9G7QvShR+UVFMt3WIXEwQivUO0U64OtRHzN?=
 =?us-ascii?Q?/zx1noKUdNsIWyw4hlpu8CiHAzE5d6bq9XUhxfypfeSF0BsTZHvHYQQ/5Q96?=
 =?us-ascii?Q?8JI5O/tRoiA1bFOhMCQy/DHvc6ZKr9/X6qAIHQ+xBDNfHjEmqHPrqbVPqnv4?=
 =?us-ascii?Q?+VYjCs/AW+CiwHpf1q8h1dAl7r1/s6go7QUTXxEAPpzsgGvzNTBxXRtYcpHp?=
 =?us-ascii?Q?9Bdv6NlM6wNIG6PjnHfsTfq+i+HWAiZj3UOUhmB3c2hfx0Z1LgbBdnbG5XIC?=
 =?us-ascii?Q?2WIJx/ey/YOXnvd87yTZu9fr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9fb9ce2-4e4d-4d11-db0c-08d8e4480092
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4885.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2021 04:41:57.5698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gSvOK14+SylyBkM5CNVz/Ci/uirMs0IetfpSrVvR4z2h6N8OGdUcworKFEvWuVkmL41c6fdUFoStT7M6hzx4lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3143
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Julian Schroeder <julian.schroeder@amd.com>

This allows for an extra 10ms for the state transition.
Currently only AMD PCO based APUs are covered by this table.
WIP. Working on commit to kernel.org.

Signed-off-by: Julian Schroeder <julian.schroeder@amd.com>
---
 drivers/pci/quirks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 653660e3ba9e..7d8f52524ada 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -1904,6 +1904,7 @@ static void quirk_ryzen_xhci_d3hot(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x15e0, quirk_ryzen_xhci_d3hot);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x15e1, quirk_ryzen_xhci_d3hot);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x15e5, quirk_ryzen_xhci_d3hot);
 
 #ifdef CONFIG_X86_IO_APIC
 static int dmi_disable_ioapicreroute(const struct dmi_system_id *d)
-- 
2.17.1

