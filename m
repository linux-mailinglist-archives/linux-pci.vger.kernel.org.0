Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52EEB14F55C
	for <lists+linux-pci@lfdr.de>; Sat,  1 Feb 2020 01:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbgBAAX3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 31 Jan 2020 19:23:29 -0500
Received: from mail-mw2nam12on2057.outbound.protection.outlook.com ([40.107.244.57]:6123
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726262AbgBAAX3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 31 Jan 2020 19:23:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QTS5dNTDAzXb3mivaJURRnH2xBG2ibbTkIcufHFSICOSGFerjoc4B9mpus+pB/LDZXsIxZBO5sKwU/8ofPbcsBz5gUd6vRW+CywZsGgzHpKQ+j4vAyg883mxP0lV79gCGGoiObzJyzWLzjxMEgHunI+pK0jH5ysxH1CQPj48RhBDue9Ja/NTo95AvhgYOXYrHavoXT7XqqMdX/Rvpp/Nesc4mHUiQXXeCYMMs+LiJ6vlWez7mFVZCfUtXtOCNRbyOFF/sckwv8XDs3FZx63v/dtvBfM1vr6uig+ILPGgqOKhvFTmrud1d0QLFYm4kIuaH30dqv4BKWtJ4vMaboMPqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pt6TMUNR42pW8ad933jaw0ZQRojw37a9WnJiyYyzc/Y=;
 b=F7DMRtcQWYV5ArlJ28IOsGxednriIrz0kGcwlpEBoZagXcIlA/m8TY+ZCI8jyb4IRX6U9mez+BH6QmihRsAGSv+Rn5nkooFBDmUjvxCmAvyxhEGSOmlAw5PMjrIvX5GNFuya2IGNpvQCXnqc7IJZmde120frVBM8iIwkc4zYYacFX8e4CGr6o4HQZR2i9jo1j5y2or8155llFKrZiQoMtadrjWc0v/fxt+W7+3qXKc2SdKHpLW6bMuX+f6zE39rnpxcthpphLbxZ4d17DgUsavpgqvYcb+rtFskGAIV4Uv4P9xJ6eK8MyTNK++h7Lvx0EL1QgdmZpxnT2yqDASLGKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eideticom.com; dmarc=pass action=none
 header.from=eideticom.com; dkim=pass header.d=eideticom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=eideticcom.onmicrosoft.com; s=selector2-eideticcom-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pt6TMUNR42pW8ad933jaw0ZQRojw37a9WnJiyYyzc/Y=;
 b=ZztYkBJYNDLafSeYhQR0kqcDJOwMDI077gppd9Dx/zV7jlp0EeYaz51avUDMkIC/Gco5LUFU1OfrJ9+gPkiQwKeUVpqEZfhH+zqVO33djxL1hiljaZo6EL6+rcMYlVb3iBE1TXRKoX/Rto7RY1zQ02Mn/0DFe9W0uWtws+WDyMk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=andrew.maier@eideticom.com; 
Received: from MWHPR19MB1103.namprd19.prod.outlook.com (10.173.120.23) by
 MWHPR19MB1488.namprd19.prod.outlook.com (10.175.8.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.29; Sat, 1 Feb 2020 00:23:25 +0000
Received: from MWHPR19MB1103.namprd19.prod.outlook.com
 ([fe80::1df3:7110:c934:6549]) by MWHPR19MB1103.namprd19.prod.outlook.com
 ([fe80::1df3:7110:c934:6549%8]) with mapi id 15.20.2686.030; Sat, 1 Feb 2020
 00:23:25 +0000
From:   Andrew Maier <andrew.maier@eideticom.com>
To:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     logang@deltatee.com, Andrew Maier <andrew.maier@eideticom.com>
Subject: [PATCH] PCI/P2PDMA: Add the Intel Sky Lake-E root ports to the whitelist
Date:   Fri, 31 Jan 2020 17:23:07 -0700
Message-Id: <20200201002307.4520-1-andrew.maier@eideticom.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: MWHPR22CA0062.namprd22.prod.outlook.com
 (2603:10b6:300:12a::24) To MWHPR19MB1103.namprd19.prod.outlook.com
 (2603:10b6:300:9a::23)
MIME-Version: 1.0
Received: from odin.eideticom.local (70.73.163.230) by MWHPR22CA0062.namprd22.prod.outlook.com (2603:10b6:300:12a::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.27 via Frontend Transport; Sat, 1 Feb 2020 00:23:24 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [70.73.163.230]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dfdd0c16-a6ff-421f-d253-08d7a6acf3af
X-MS-TrafficTypeDiagnostic: MWHPR19MB1488:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR19MB1488D46DDD9E5B6EC0B5787393060@MWHPR19MB1488.namprd19.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-Forefront-PRVS: 03008837BD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(366004)(396003)(39830400003)(189003)(199004)(4744005)(6666004)(52116002)(316002)(2616005)(44832011)(81166006)(81156014)(6506007)(66556008)(66476007)(2906002)(5660300002)(86362001)(66946007)(8936002)(956004)(1076003)(4326008)(6512007)(186003)(508600001)(26005)(16526019)(6486002)(8676002)(36756003)(107886003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR19MB1488;H:MWHPR19MB1103.namprd19.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: eideticom.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x99ujoywkdzcCQ83O96IDP1AK3MqXCR1okOYhqXVoZ9yoYVykcUIb490QK+5/SR2FReZWIB0SJ8Dz5RfOmHkc7ZooyDviEvEe0O+BTfs1auW0sZ7T+IeM99FgNgA/8uhYBXxZ0ibkDaGteFkXV0gZezC18G1olhAQl46cBHWKu5PMf28YWKUfhNO/EvoeCkKKaQxEEhW1iZgz2t6Z1yP+r6VaxBxy0aSGpdRT1ojb1nnXsdg/B1ydOtjHtUGCQvi4W3my8EQ0Wo1gh6VmQeiah8vjVD5ulTV5OSbcZSz1MmOHWX55mxn6SSJO18hzTdgAlj+W93w5oM41a32XZQcFYzWP4Z+9LeDa6mevbCNczqcJHGNulsmiao7lRVfXaDkoMn7t+BITSqb+5D61Qen2Gqa/tZ4A+qw3Q25dH3jOFwJC83xnkkZqDoYFo3hfUH7
X-MS-Exchange-AntiSpam-MessageData: g+DsQcvi4GLUaoaKUdeo7nvg2q43Dc94EpiPjnyOs99vydsuZarI3C3QLVtdMdnJmrKMnUF3Su+WyALZtRqOD5Ix7D2du2IQBl/iF8Poy5DyjR6T134GAg5Ecq9WET81ooSLoJECxwWgeBHCGAzhxg==
X-OriginatorOrg: eideticom.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfdd0c16-a6ff-421f-d253-08d7a6acf3af
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2020 00:23:25.1435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3490cd4b-0360-4377-abb1-15f8c5af8fc2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LbuPcAanGJaMrPRgAga5pnMzcxFVeJYeCBlt7t1MziWlEavsV619+i1pLp8ihj2SjUilKxDUBSsilBM1VDDhvlNnW0Sf0gqztSamWxHMtgU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR19MB1488
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add the four Intel Sky Lake-E host root ports to the whitelist of
p2pdma.

P2P has been tested and is working on this system.

Signed-off-by: Andrew Maier <andrew.maier@eideticom.com>
---
 drivers/pci/p2pdma.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 6d6c64415087..d7601a49eb3e 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -325,6 +325,11 @@ static const struct pci_p2pdma_whitelist_entry {
 	/* Intel Xeon E7 v3/Xeon E5 v3/Core i7 */
 	{PCI_VENDOR_ID_INTEL,	0x2f00, REQ_SAME_HOST_BRIDGE},
 	{PCI_VENDOR_ID_INTEL,	0x2f01, REQ_SAME_HOST_BRIDGE},
+	/* Intel Sky Lake-E */
+	{PCI_VENDOR_ID_INTEL,	0x2030, REQ_SAME_HOST_BRIDGE},
+	{PCI_VENDOR_ID_INTEL,	0x2031, REQ_SAME_HOST_BRIDGE},
+	{PCI_VENDOR_ID_INTEL,	0x2032, REQ_SAME_HOST_BRIDGE},
+	{PCI_VENDOR_ID_INTEL,	0x2033, REQ_SAME_HOST_BRIDGE},
 	{}
 };
 
-- 
2.17.1

