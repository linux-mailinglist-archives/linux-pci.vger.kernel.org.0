Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4F2E3DDCCE
	for <lists+linux-pci@lfdr.de>; Mon,  2 Aug 2021 17:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234551AbhHBPum (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Aug 2021 11:50:42 -0400
Received: from mail-eopbgr40040.outbound.protection.outlook.com ([40.107.4.40]:10144
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230131AbhHBPul (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 2 Aug 2021 11:50:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G+8vJUQsxqvpjcD/Vf2LVnVUJp6CNTxZsHFTGf8u55j0FRiID+4oJpMPq4wbQ+qvsI1vLpdsrv9mqfPaoLCkrDVCuPNsM2Osi4gfB3sJ5rAG9TQsO3aVqRI0pIUTKJKl7r6FhdeNjwgT6L23RVZb+k/QPCw7bGzOZ9GPQlcfOS0BsEwnhEY/tOvxQ7JWnh3SBQVdvb+PH+HaMzmrOfXcI7lHbAyKWtkGaXC8iUf1H36RzZF++rZMOJIN6pQYSpAijC+Sa9g06Eez1+ZvvkQ4vJ1V9uY18YZ0lDbwyaqusanxgUvZu1UOZWThnfZbXwTTItWvD+9M6L/pzuS+jV/Jcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNF28ECHk/+npK8Q2YCrXqaS/bZNuRU6l5x1yya3y0g=;
 b=QYJrPS8Zq8bBoSSztdnGxGknI95U18Mo4v7U4wyAC1tsl4+g2VPYsjenEAbArjBoijZ+ogfVu/V/fBMKOTVd9/7PUBAMgl+40N1rLp3pNc9G1O/Ly69F+fqjVPdBB1lLX5Dt+i/OGDSv82pY0braVTDdfalgSN/J8pu5gE2yZSL+OqAWRnIZpu2NTaA9EX5SuxJfBOIFpPdA+cYfCctFa5aHQsg/ZfH9QEC/A74XRKTvNaFUT/i4Eu/yexlijWTMHWhlkhhdQFRraEdgZnU8id3a6pscSiYKO8K1BxlmmeGFoOe6oNEkxmSkOxU5sI13+X4keaQyB88+vpyALCEwRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNF28ECHk/+npK8Q2YCrXqaS/bZNuRU6l5x1yya3y0g=;
 b=ChneX7g+9zhnjtxCDn8ZGbjQBOQLkkAouCJtCHUdTfMWtPMM7T019DIepCnfWhWEKZC3vl+9BnF/pImeLAfdJgX2agsuOWFs0gnWDM6Vjh1fGl08f71ARpxiO/2DCDZcg8dnWoNkTlfjJmhQRu9laII0dY8MIZAfSzBVD8qV1nw=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB8726.eurprd04.prod.outlook.com (2603:10a6:10:2dd::9)
 by DU2PR04MB8871.eurprd04.prod.outlook.com (2603:10a6:10:2e2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21; Mon, 2 Aug
 2021 15:50:30 +0000
Received: from DU2PR04MB8726.eurprd04.prod.outlook.com
 ([fe80::e50a:234a:7fb7:11d4]) by DU2PR04MB8726.eurprd04.prod.outlook.com
 ([fe80::e50a:234a:7fb7:11d4%9]) with mapi id 15.20.4373.026; Mon, 2 Aug 2021
 15:50:30 +0000
From:   Wasim Khan <wasim.khan@oss.nxp.com>
To:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     V.Sethi@nxp.com, Wasim Khan <wasim.khan@nxp.com>
Subject: [PATCH] PCI: Add ACS quirk for NXP LX2160 and LX2162 C/E/N platforms
Date:   Mon,  2 Aug 2021 17:50:18 +0200
Message-Id: <20210802155018.3089428-1-wasim.khan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0128.eurprd04.prod.outlook.com
 (2603:10a6:208:55::33) To DU2PR04MB8726.eurprd04.prod.outlook.com
 (2603:10a6:10:2dd::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lsv05369.swis.nl-cdc01.nxp.com (92.121.36.4) by AM0PR04CA0128.eurprd04.prod.outlook.com (2603:10a6:208:55::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Mon, 2 Aug 2021 15:50:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 240fa95d-edf5-4c2e-f433-08d955cd4133
X-MS-TrafficTypeDiagnostic: DU2PR04MB8871:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DU2PR04MB8871211893360C57B00FFD0DD1EF9@DU2PR04MB8871.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ua3YwyUxQUEqUDDS7GJ9FLhM0KHcU7SQC/4WfaQdByZBp5Y4mmnMUEVybGvM2idJOpD4jwAyCgnYSN8+S8qsNFvTiphT09Yb6B1lNs+Ve7O8t1O/d1DzUGKz1pxB8v6p/wK+bMKkARb0sFQ0gIcER2GCpbvKqg5VgPYu+zYbWDIyaO4wsOLxzZVKLP/AXWq82wQ39wt5h0PLxd7Cy5SBd0ig54pxBgncdAHbehRURDLZaBRacS+HzZqDZu8fE3jHwwokaIP8PWQlFoSd1g/SOQKZZ2nCnjiokPuh7WssxvmWEaEoTiJYolUsnshCuHj0kD2j7YSbXbH5wo+snp2zF/p7fbfjDehWoyBDJPVBfHF+UwYNj1l6jQCqhYUe4IphTmKrU7C4DVOlYiaXAg5u9K48qP/K//zlaNAgwtUc58hw6m6Un/9tkricCGmxe/pg+WI8vBNCPaj18Lae0oYXSrhKwuQVgy+Dq+EHxJKLwb+nQxwRrZFpKDHt0cE93ZcDybqh61LFTnNm01AQ3oTq0VKqcRB3splvibcLcDzk6aEXUDHgohcLZ3Al+oKOVhhDx/9m8Uc1I9f/Ebk9dDAM8oG5VwGfAPny4oTD9EeAAwk5+FzzuCn++1Osw0DspcWpeDpLzb/f9mzCc6Gylm5vTIlQGUzVgH3y/29YLma3L8NpjPVF97zWUltIWyZBeZEpFHLOFFXQKwWbu1ii7Tjc0w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8726.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(39850400004)(396003)(136003)(8676002)(8936002)(2616005)(4326008)(66946007)(2906002)(1076003)(44832011)(478600001)(956004)(66476007)(6506007)(6512007)(6666004)(83380400001)(66556008)(52116002)(6486002)(26005)(186003)(86362001)(38350700002)(38100700002)(5660300002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qh2mVcf0Qads6ZMhxFW61uLMufbeLOqpMYSKPrTtTsc8xvHg7sNjt8tp6XJP?=
 =?us-ascii?Q?X9xl8boAkvb2Ae4pSywR5DwwZZHFmQ8fq74PiCUCcQKXCguCm+8lk6dDOpui?=
 =?us-ascii?Q?BNvzqhEc/5Q82YoOMrNkWVDGOzH4l3CSm1tM5sOxgd4g38UNEGtHkCiWM32L?=
 =?us-ascii?Q?G6gp0Kpf20n9jUo+DUrrspHEKtMuRTCi9H8CaMRUprpPIFdNtzbR+6c8sqkY?=
 =?us-ascii?Q?XqMlBQaqaupEm798A8IhsfYNN+6N09CdURFvNaT1Ko2EjjaVIuqVOrdnQkWN?=
 =?us-ascii?Q?CxcoCtYz2nVjnPy35QPbh9ZGihwIKj7/svmZ9gSt0RiaEwrX4pZq95BNbpco?=
 =?us-ascii?Q?hVyMDjdgTr0SKmqEITqIcE7MV8Ogty2RBjKwmqI0GU9sGSMfFzuTaritnVwq?=
 =?us-ascii?Q?CH3YvTNfaciYzqpKCqM/Nmzu6oa89UxDVd+9DBKsMeQzP9ZOIgWrPIkr65+t?=
 =?us-ascii?Q?OmkRkf6Tz3hrO9g9xsoT94WcYc//09mvKMSH8YPm9bEXlgbjUsd+TAdebbTO?=
 =?us-ascii?Q?6CG3f87hlL6nMk8bLRmPg5hYzy7kjr/1100v54FHWmLrLQb+iQGL9FlFtMcu?=
 =?us-ascii?Q?H+Rirpuun5c16ODg1bHeZRrQqCrDHwiDuZqb2AcnlyWlosWNfzJO6u4lAlVC?=
 =?us-ascii?Q?02CCPEDeB8ODVKOdSx/ZuwSd+Dn/p+x6Txcu1oPZPYpDZjGAm5m7TS7kZGDx?=
 =?us-ascii?Q?T2ID2b6fs0fvAPgI9wgJJT+2mFjyQvw6Ouu/BE30JGrqk4sM+SuTEHh460lC?=
 =?us-ascii?Q?TxEEmkbC4wlNm764N89dW6CL1Xp57OfqGzu+psvTq/oKnkaDqBC5kGBI4lJO?=
 =?us-ascii?Q?uhDCYPNVRppRaDe65jaR3hDoh/Uo/e5Yi+9fh6WGv9iVfbxgW3lKeupiPOqe?=
 =?us-ascii?Q?3nD65QBPbrVniAAQWopkozsJZyaRRiJNUAoPibIy1VG31dMCQmWCbJ4jBVT/?=
 =?us-ascii?Q?VG0sbEgY5S8f+Ecm65hGDusG7hlBoCBA8cvIJDNu2faqX5OmSdUvBshZHr1Y?=
 =?us-ascii?Q?YtCz9kLi52WMUhTXzHIKtYWWIKM+evD9Br7/5v1tn7PgQlpRFhO4uc5vlwap?=
 =?us-ascii?Q?RVeXYS1mQpXB5WmL2vpptsyujXBTN40QlomwsMY8PTGi2yjQo91Rq9KHG7On?=
 =?us-ascii?Q?lsKD2m4Vk7OVtfai5fN9JPf77wb4W+0T5dA7pfYyJsSVWR7Vbn2SeLfmcGy0?=
 =?us-ascii?Q?UGkPazzbQp8sAoBb2fIUTUO9RfTrL0ycwcaVJ4lS0vkYX4z1haiUkhL/UP+O?=
 =?us-ascii?Q?ujkAwc0LTvb76n1nhOwyhfmmYgbaEehRRvmOpN5B5qjaBm0IsIVOcgD15rMz?=
 =?us-ascii?Q?Mv+omCJovIAMb640zFBrxZJp?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 240fa95d-edf5-4c2e-f433-08d955cd4133
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8726.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2021 15:50:30.2217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ne7O47fOiwvONwL4Js9ayfg6BbJS64JfodPkGXc8MQWzByJnDt0D6FSvLW37TGhTVPeaPSJJ7oqIpRqEYDel5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8871
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Wasim Khan <wasim.khan@nxp.com>

LX2160C : security features + CAN-FD
LX2160E : security features + CAN
LX2160N : without security features + CAN
LX2162C : security features + CAN-FD
LX2162E : security features + CAN
LX2162N : without security features + CAN

Root Ports in NXP LX2160 and LX2162 where each Root Port
is a Root Complex with unique segment numbers do provide
isolation features to disable peer transactions and
validate bus numbers in requests, but do not provide an
actual PCIe ACS capability.

Enable ACS quirk for NXP LX2160C/E/N and LX2162C/E/N platforms

Signed-off-by: Wasim Khan <wasim.khan@nxp.com>
---
 drivers/pci/quirks.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 24343a76c034..cef003685860 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4787,6 +4787,25 @@ static const struct pci_dev_acs_enabled {
 	{ PCI_VENDOR_ID_NXP, 0x8d80, pci_quirk_nxp_rp_acs },
 	{ PCI_VENDOR_ID_NXP, 0x8d88, pci_quirk_nxp_rp_acs },
 	{ PCI_VENDOR_ID_NXP, 0x8d89, pci_quirk_nxp_rp_acs },
+	{ PCI_VENDOR_ID_NXP, 0x8d90, pci_quirk_nxp_rp_acs },
+	{ PCI_VENDOR_ID_NXP, 0x8d80, pci_quirk_nxp_rp_acs },
+	{ PCI_VENDOR_ID_NXP, 0x8d91, pci_quirk_nxp_rp_acs },
+	{ PCI_VENDOR_ID_NXP, 0x8da1, pci_quirk_nxp_rp_acs },
+	{ PCI_VENDOR_ID_NXP, 0x8db0, pci_quirk_nxp_rp_acs },
+	{ PCI_VENDOR_ID_NXP, 0x8d92, pci_quirk_nxp_rp_acs },
+	{ PCI_VENDOR_ID_NXP, 0x8d82, pci_quirk_nxp_rp_acs },
+	{ PCI_VENDOR_ID_NXP, 0x8d93, pci_quirk_nxp_rp_acs },
+	{ PCI_VENDOR_ID_NXP, 0x8da0, pci_quirk_nxp_rp_acs },
+	{ PCI_VENDOR_ID_NXP, 0x8db1, pci_quirk_nxp_rp_acs },
+	{ PCI_VENDOR_ID_NXP, 0x8d88, pci_quirk_nxp_rp_acs },
+	{ PCI_VENDOR_ID_NXP, 0x8d99, pci_quirk_nxp_rp_acs },
+	{ PCI_VENDOR_ID_NXP, 0x8d8a, pci_quirk_nxp_rp_acs },
+	{ PCI_VENDOR_ID_NXP, 0x8d9b, pci_quirk_nxp_rp_acs },
+	{ PCI_VENDOR_ID_NXP, 0x8da8, pci_quirk_nxp_rp_acs },
+	{ PCI_VENDOR_ID_NXP, 0x8db9, pci_quirk_nxp_rp_acs },
+	{ PCI_VENDOR_ID_NXP, 0x8d98, pci_quirk_nxp_rp_acs },
+	{ PCI_VENDOR_ID_NXP, 0x8db8, pci_quirk_nxp_rp_acs },
+	{ PCI_VENDOR_ID_NXP, 0x8d9a, pci_quirk_nxp_rp_acs },
 	/* Zhaoxin Root/Downstream Ports */
 	{ PCI_VENDOR_ID_ZHAOXIN, PCI_ANY_ID, pci_quirk_zhaoxin_pcie_ports_acs },
 	{ 0 }
-- 
2.25.1

