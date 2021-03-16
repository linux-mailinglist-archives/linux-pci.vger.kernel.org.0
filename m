Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF86C33DD88
	for <lists+linux-pci@lfdr.de>; Tue, 16 Mar 2021 20:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236980AbhCPT3n (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Mar 2021 15:29:43 -0400
Received: from mail-dm6nam11hn2233.outbound.protection.outlook.com ([52.100.172.233]:32016
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240470AbhCPT3L (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 16 Mar 2021 15:29:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DDl3kssoNzaMkjeCr83749h7cFRGWXv04pBijEeLAhcUY9jwlqDzaEKSNAPEJ7H2qNXfDXVNL+ndJPJ5uR4Gx6V9yWHbIF63ODaVdUEQO6xrt32XRfKKgVYWSsqUiO48o2jdWyFWfvlpt8rA37HpjOEYG78FztvJMorIyozFlH+cJL1M1/7Ks3mzpafqu0H3FFOekZC03vnvm5RwLQWGlwBLTq5mvFoeo64W0cnOE00GY04dQhBgLt3drl7++Zz58fFkILjChRjdFLQ2K0q9ifKkqviDBzL856fqBSm3Gzu6vLjb7JTCJIQeqkSPumGagBxnnIvkBwS7x543MO+Gqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gUBpJiZimd/R8EQmQIFy8stjugOPCZ6GjyY4oUie52w=;
 b=VIZz4L1lo/cFU/IxLlZiM6bjQlRGY4lnbc9nCdsZHOyEgduNvswf/ZlogWGpflkYyxYzRcc/BkiayiSb/BnPuWKTvKgJM0FgDuyKDg+fusa1DRTOlP0VXdu2aGvVVRaqhGlTUm/REBXnsw0BCvruAfam/j1Zzz+WlpusgVnd0rgRFmRasihTPlTECSwrlTsvcbwOyuVoDD1F4v9El88tnh3mHyxV5mL0Voi4SwhNVfhNlLiWpEDj/dr6ornD+6HJ13xKHHNWSSE+e3Og9NDsd1hbPuYO+1q/1ZO2uWCn8C5H1zaLRwkVCrb2Imske83cb+pUAbPd4OQGe25piq89kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gUBpJiZimd/R8EQmQIFy8stjugOPCZ6GjyY4oUie52w=;
 b=qx54ISi7c3XlS/SOGFpZ/ujZSh81aSxFwKm2YqJ4fPjUd7wYCt1BXevkBHhb0SgiaaqDvT6yhfW0T5cDtc1XdpXwFmS9jeaSclCX6lZ6GMLGWBztEjZS088BtgAMa/Wlh6dQ1uTh1SMAAq0xDocmQTJIqEKpMHgXmC+Q3ZWN7os=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4829.namprd12.prod.outlook.com (2603:10b6:208:1b6::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Tue, 16 Mar
 2021 19:29:08 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c%5]) with mapi id 15.20.3933.032; Tue, 16 Mar 2021
 19:29:08 +0000
From:   Alex Deucher <alexander.deucher@amd.com>
To:     amd-gfx@lists.freedesktop.org, linux-pci@vger.kernel.org,
        bhelgaas@google.com, hegel666@gmail.com
Cc:     Prike.Liang@amd.com, Shyam-sundar.S-k@amd.com,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] PCI: quirks: Quirk PCI d3hot delay for AMD xhci
Date:   Tue, 16 Mar 2021 15:28:51 -0400
Message-Id: <20210316192851.286563-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [192.161.79.247]
X-ClientProxiedBy: MN2PR16CA0065.namprd16.prod.outlook.com
 (2603:10b6:208:234::34) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.247) by MN2PR16CA0065.namprd16.prod.outlook.com (2603:10b6:208:234::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31 via Frontend Transport; Tue, 16 Mar 2021 19:29:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7b7c34ab-de44-4af7-aca2-08d8e8b1c479
X-MS-TrafficTypeDiagnostic: MN2PR12MB4829:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB482923C148FE5D8E17EA3239F76B9@MN2PR12MB4829.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:421;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vX8h1U4Fd07HAIL/1OTQ4h5ifw7sscLdhfmPD1ihUDLQY6jahm7E2Y5Dt3iZ?=
 =?us-ascii?Q?BFLmEMTle1QBVMKD7i49g7YPR69B/q8EZVZaiJwRrLxuCNbU2bY2z4yT38Ji?=
 =?us-ascii?Q?BlJxeTHLovASeBLWO5rzSg45NuemVM7V/TcFmK/F8Ar57DnB9Bl+UYkvgY6T?=
 =?us-ascii?Q?/CTG4xXj0qEnhk+6yA5j7lVLoMDIvjgOv0cvq15EC2kb6XoAd2E78Fzz1JMG?=
 =?us-ascii?Q?awCtokmwESmwQhDbQhDFP/9J0mp6Zw2Cge02d4AsqyvO6tL0TPlj4bKdO7+k?=
 =?us-ascii?Q?42Qo9VLqhFiYl0OVrRtoMZAsyYPrdZtJlMk2U+FbrTGpB3o3yM4REuUuT8nY?=
 =?us-ascii?Q?qArgFXlpLzoTXQwKpsrHZeSC50jn9Z5YE7zrFV2OWpE5Z7Q/4n5cQLFl/FfA?=
 =?us-ascii?Q?Fovm0mWVWESkslEqyz6wHgs7xV3z0iyuSmiQenSobTXBnhyevbrFYefwYo1F?=
 =?us-ascii?Q?lnzT2IiABCjiKH7LqBDV6z404+7aAVm1H+9z3Bg8vqJW7mCExU6e8X0Bc42+?=
 =?us-ascii?Q?Jv2+UcR+nOKEu7x+kzZZ/hx/rbMb5KH9GyGfMOEfAu2XMkXPxk5ntVLTRt2G?=
 =?us-ascii?Q?2WGFPA8tFSTTLUUNfi+R23SpkViEgEOSwhwOo1kbJrRqvWxUa2Axsa8rmeWW?=
 =?us-ascii?Q?vm+okf73YFXnkAaPuzskKlfA2kCtDZT3pxfJDp5a0kltR4sCn4Z6PB33HlaW?=
 =?us-ascii?Q?HfJhDMYZF/pO6Jvin8hOPQpAwJx4jJHNvNyvbtWzrD2Vmma28/jsfX5zt6n8?=
 =?us-ascii?Q?q1rF9BHrwBYWfbDQiAtTAJZV4tyvdMJoIFD7rvHN0lxFjUhA0tnOImK/U9kR?=
 =?us-ascii?Q?Isv4sIoy0XYlTM5+djdFoEuaWYeqrlWnJoKMWGrI7qbV5LqL2aUO54JtHx0V?=
 =?us-ascii?Q?fB7m+zcTxxxzk0sCl5geEpt4hYnxcMFHy6lDfFBZmHQPVbdlO3zpav+nCDlA?=
 =?us-ascii?Q?enHonjgc0MYY81YmLsK+1prqYkeDBrqwMcLThjNlgEU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:MN2PR12MB4488.namprd12.prod.outlook.com;PTR:;CAT:OSPM;SFS:(4636009)(39860400002)(346002)(366004)(376002)(396003)(136003)(66946007)(26005)(52116002)(66556008)(66476007)(5660300002)(8676002)(478600001)(186003)(16526019)(2906002)(6506007)(6666004)(6486002)(69590400012)(4326008)(36756003)(956004)(8936002)(4744005)(6512007)(2616005)(1076003)(86362001)(316002)(42413003)(32563001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Qu+85Szk78KlpbuOmUDkea6hlcCbvw8OdrRiCpbXr2Xcm0vCaONeGssGU3+l?=
 =?us-ascii?Q?68JU+U/15q8cpMrDzrsPhn7q/RtSZ5msevoF9cxJ68uPBJMfEUi5ZWBKg/6+?=
 =?us-ascii?Q?D2akWQoiWP9skTKqa3ihxs7iO0AaCEubs4CG09T1ogZoyfD3nKtBkUvsuvio?=
 =?us-ascii?Q?aA7RqiaiS7MGIXBG9PHCPIg9yNXMsdyVh1D8A3Ts3a92Me27/mkeIVDR8HDk?=
 =?us-ascii?Q?hufK7sNGWNl3+y+hBE9uOMslXLtoNHZNMrwMjevqqwLQnJawTFhVbtVYnrKY?=
 =?us-ascii?Q?7sCBiiQhw8Dr6ZC6fT7Vyk9SUskNAkPSBDANUTLEDBATgq981dADVXJI24cj?=
 =?us-ascii?Q?cZt0/Lcfu4EoKZfU+IhqfLenoE3z8Lo5PAMbX2yjArX0rDmi/DYU5LvL4GPF?=
 =?us-ascii?Q?k0fDA3sRBP6G0aG8ohfyeFkr+Hb7VVoqyQ/jMyIwxeNspwEUDbsuwG3FzNRh?=
 =?us-ascii?Q?8CTT06H79auxcHQKeA1DKW3edca8IdAEmKmdNbsiv+Zd3abQj864Yrt7k+2e?=
 =?us-ascii?Q?ehfwCsA78K1+c0yi+QpFfFyipBonVa7sdA/3553nTk9I7moUAKMOdu0hYwWA?=
 =?us-ascii?Q?rSXs12D2kw91OEjZdyXfTRlMmN+6uY3dPYfrSdq/srzIxseSfiLNs3KC6AEY?=
 =?us-ascii?Q?mZ66fgXCqHBeEYC71T+94EVlHRPHq3qp615/SKGMruW3fV1kMZfq4HBfgIB8?=
 =?us-ascii?Q?/E/27WwZ4SONkzP/bhG+e9QMPQqdCWxfQ+HzBNSqaRpVDwDxRX/bvJdQNjtP?=
 =?us-ascii?Q?aPnHB5Gtxrh+7fJISCxoaHKff87RF+W0r5w+nuxbE5FQVwiJpYoKkUGEhzsK?=
 =?us-ascii?Q?wXlfZ1K8E0OEWSFWHmLfPkjPZbQn/ZCH+KYV8GfqgjfO2g6LPblTP4kkWXL1?=
 =?us-ascii?Q?ElME57zh2sQkhrtMS/kMPSNYm1Fm7b5lNNhv0Pbu78HV4VY2mKY8OJVr1Vyk?=
 =?us-ascii?Q?UCv3ahe/EGLeC+/MhPNEYohtb43mQnGRBO+1b0ZyuT34e6aeJILx9ehKMU+Z?=
 =?us-ascii?Q?PFJTBoERZW/gX0dqYfDgxpHgVv/OqlOgRhoCgvOEjUMIQ2KQRfiIKjHdpfOR?=
 =?us-ascii?Q?E5k9R88YiGraiWSIBWKiuu/CnkepwFF+crFSvXnvlCoQ6FlxCRWuJinSPtAS?=
 =?us-ascii?Q?+qTOuvXxjuNrxCRCycYvn1ndxXXhru5zHtRiifRAKZmIR/AAkp0OSjh/qEOz?=
 =?us-ascii?Q?HDD2W/7xaYKZzjpEjVH6IFCs3ZDoF9ugqjcDgQwynNTICftp+FUZ2s9J9Hwp?=
 =?us-ascii?Q?jIQW5Dl2idG5LBTjyN8RlqAb/T4Wv6YrmSM3S1QbOoBvBNnzQl7gERn0ZWXb?=
 =?us-ascii?Q?y8nHNS8xyMkjfwTaDLRULWKc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b7c34ab-de44-4af7-aca2-08d8e8b1c479
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2021 19:29:08.3755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OCGEOAh9W2W4HK6X9ANzVeb9b1QLSx55JWrVT/09RF3iPtRU3hp6UeI35FrwBWvHTGDnn1tv50BHPpczARCDxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4829
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Marcin Bachry <hegel666@gmail.com>

Renoir needs a similar delay.

Signed-off-by: Marcin Bachry <hegel666@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/pci/quirks.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 653660e3ba9e..36e5ec670fae 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -1904,6 +1904,9 @@ static void quirk_ryzen_xhci_d3hot(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x15e0, quirk_ryzen_xhci_d3hot);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x15e1, quirk_ryzen_xhci_d3hot);
+/* Renoir XHCI requires longer delay when transitioning from D0 to
+ * D3hot */
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x1639, quirk_ryzen_xhci_d3hot);
 
 #ifdef CONFIG_X86_IO_APIC
 static int dmi_disable_ioapicreroute(const struct dmi_system_id *d)
-- 
2.30.2

