Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 474773DDCEB
	for <lists+linux-pci@lfdr.de>; Mon,  2 Aug 2021 17:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbhHBP5I (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Aug 2021 11:57:08 -0400
Received: from mail-eopbgr70054.outbound.protection.outlook.com ([40.107.7.54]:19294
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235184AbhHBP5I (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 2 Aug 2021 11:57:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SqUUrtM7I+bixh/5pxYdCRG8lS3F+i233yVlRF2NCi6Xl+Knf5cjTIWDNkWl2GTvwlEfyl/7DNPRKYUtbLaa1i+lHxWhS5+cmKCEUTJNMNnOfhDG9F0VVSUdqLe4lVDfPYZg3PRzKARkkX/lB2iK3BaQrRCP3jYe5D04JxueqUUaiKqqoNRAmz5G8621+VFXEBzFDaR8K7mnybdE/jKLtoIF4advhrg0fBlblYg0X4RtDyAVXmuIQqbs0UzQ8msJB71TzbP13qkOsjUuKXskJrA00BOfhAFHXUmLEkyjSQ93+4+vBbX6q1wByPsf7OoTuHHEceRNOTdVh9afQ9mnOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q1v84FML+3OI0VzShc1UQIjNmsWEs2idyJ3wQy2hdLo=;
 b=aLXCAoPZCzYKlMzxFaon8qFqJoDQJZ6CkoPCUGosxxbfDegyWNgcVvCuhh8Nn+LSfKvHbGR87WbbMK7awbz2LmS5ZcgRhgJDlWoe2SmnjVbOeRm8aPCRM6tQxcw5yqM0E4Fj/egtfahrM3u33MPD6A7VpJ8Dy70MxsyB4ZHfwR3kNCrFHY/ob0tPPksP29UJxaqHGIgR9fyjzhvfuWUy6pyMBLNZXEu832WZAX6EdqYoLjDw37wwzh04sGCD+NmIepsXubml3jNT4RdzSnyJNqteLhrR0sV96RbNaCYwiqXfT8yRzM4AFPVrDUYl+hcsGgRHN4okt7Qr1cTrtW2vzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q1v84FML+3OI0VzShc1UQIjNmsWEs2idyJ3wQy2hdLo=;
 b=JI0H8hBuVvojGSRrrvxXbG2aPx9v8TZdJjDWIUTqkNmt6HYwClYq79P+7r4cdh0cqsgsmgbNVVx405NOHqAxP4O/MhfcOkOAM7lQaIUmHb0bU0yJRKKmRnJwZNTGuEtXJFX7NWbG8zXrF/214MiELP7gTk4kN7I5p609YzD3aY0=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB8726.eurprd04.prod.outlook.com (2603:10a6:10:2dd::9)
 by DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Mon, 2 Aug
 2021 15:56:56 +0000
Received: from DU2PR04MB8726.eurprd04.prod.outlook.com
 ([fe80::e50a:234a:7fb7:11d4]) by DU2PR04MB8726.eurprd04.prod.outlook.com
 ([fe80::e50a:234a:7fb7:11d4%9]) with mapi id 15.20.4373.026; Mon, 2 Aug 2021
 15:56:56 +0000
From:   Wasim Khan <wasim.khan@oss.nxp.com>
To:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     V.Sethi@nxp.com, Wasim Khan <wasim.khan@nxp.com>
Subject: [PATCH v2] PCI: Add ACS quirk for NXP LX2160 and LX2162 C/E/N platforms
Date:   Mon,  2 Aug 2021 17:56:44 +0200
Message-Id: <20210802155644.3089929-1-wasim.khan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR05CA0009.eurprd05.prod.outlook.com (2603:10a6:205::22)
 To DU2PR04MB8726.eurprd04.prod.outlook.com (2603:10a6:10:2dd::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lsv05369.swis.nl-cdc01.nxp.com (92.121.36.4) by AM4PR05CA0009.eurprd05.prod.outlook.com (2603:10a6:205::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Mon, 2 Aug 2021 15:56:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9663dc29-87fa-4d3c-3570-08d955ce2772
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DU2PR04MB8951708570EF09C10BC78AECD1EF9@DU2PR04MB8951.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WMEH6ndflaznHJb6Z3ZBqKC0gA1zPcB1Ofcql1WFoxlxINstIixvRIWjEhxgx/mbsO6F47t1VNdAGTlJ362aOuCbad+tldwRqpY3zrcmvuItgmkb47qHmQtXVhnffmWdxCzrjLwi6zw/Ou43CTEeWVfJ3SNIh/TWztfmZgcdQbNXpE7FneqUvRC2oqZwM43PJ3Pr7MOxpUFRPFbnLSjqRsbV3Lh+UMXf1qT19z6PVZ91PblGKZejsR9HnSN3tH9s9N4eSWFnmVlEoHgmVBFUwY7SoVFXWYD11y3+ywm9b6ca5NhE+brCzatX0zNgo3eOkqurRk9/4JQXNcD/x3SXC2UyVytT2k+m4hyjXJaD8vwK3INGlmqhLbEJh0yUfcNOE+MNzbd460mDtyVD0pPMsGRHwAUeEVxg6o8mF78Z/mkn5FxdnDaC8zbl3+xY3uMo0MuCSr+g5ZDvooqI3G1zPzGxZeTSqn0JPnbWChYbQwyXBwa8zcVuV9LyfBH+v1KAEt6721Zgxw5JC1xm92VhtKD7VN28DffbbdL+r8h9unQcZQbOzuWVIMxwKhyyn/ATko0AtKlXaEXqnQ78g7dHgQNKfAhryZPQJeo8vwb6BnUIITpGjr7ZrNJT4gYw58+ucq2PyRRBKrP81unkjTLbO8Xavjawx8HU5/kCj5abqsLXbsx4t4Gx5pbpqVF0zF0JoLYnxZPBVU5iF00IaY0tXA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8726.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(396003)(39850400004)(346002)(366004)(6486002)(186003)(8676002)(8936002)(956004)(5660300002)(52116002)(478600001)(2616005)(6506007)(2906002)(26005)(38100700002)(66556008)(66476007)(86362001)(316002)(4326008)(83380400001)(44832011)(1076003)(66946007)(38350700002)(6666004)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OIxEJRG/h27ch+pbIkeuykEfRN1LcRXuzr3CDqKVzRsdBoPcKmfQD79lmqcs?=
 =?us-ascii?Q?QAriyQClzP7eMyM5S2RN38VeTnaW6kijDHdms58r0S1TwIKKdPmJz1hENf6B?=
 =?us-ascii?Q?eiM5lPWZvEgdfgOsL/Z9UlA+eJ9vEjHixrZYdyUtsCM75rXbx+2wAGo9IEia?=
 =?us-ascii?Q?xe4yiWch06chZKclhA53wtPrNwBLz7O/3ha0SsUDXqC3Bo+w7IQshXqxFewQ?=
 =?us-ascii?Q?r2qTyhxT98CdvQ795qJsxbxh0ryUTHV8rQn6i0Jg8rry8i3JCxYecw9prjMD?=
 =?us-ascii?Q?OjN91paKj/3kroIpRhGsxJzoGZ07Rr+enC4YtCTaaV1+Pt/s6ogSQP/79Lds?=
 =?us-ascii?Q?/tMvjq7PkMSvhzl0tNzAv7lZi8enAn2+8B/oKGCus53PUTQPXx4VI2bJmhmU?=
 =?us-ascii?Q?JCdrVKtaxETPYAwSaQFyiRlYv/AFWvQZw5kUcCjB1XeuxnJOf0Ix2rzBxuhQ?=
 =?us-ascii?Q?O9JEhoQmkilf4sbbJi7CK1HbbZZwRE36pdKIv3hainy6Iul+r00QvhPgWg6f?=
 =?us-ascii?Q?SFfpx7W9KggrvFe5b3NbZgFZTh2KMee28lMENv7DI/lKlJ8cOvx7mMiq2SUI?=
 =?us-ascii?Q?97S+GcI8ATSKD8mI+a1SPYV78YShAAKZOZA+blVm5xkTdo8bWUjzubR0pZRW?=
 =?us-ascii?Q?DoIOIHI+pjuvn8UQCXzyTtbwTuE6MeeRtvXd7hdasG8BBl6HxiNw1t2BNKe2?=
 =?us-ascii?Q?zakhIqhLKC1vvJLiosL76IKqFN7sFEKurdXXxEJ55jEi5PVVB45q0nJQAZLR?=
 =?us-ascii?Q?Mg1B5s3MsBMEL3bG/YiosISnn0Ma5fsCK7O34kyGEnScqPs3CzNId50zhIxZ?=
 =?us-ascii?Q?01dgFIju5dOFZyddzgNz72lLqX5fjmOMqq/uAXpOLUOly+plcjyu13oioVpg?=
 =?us-ascii?Q?uFk2+jQl+R83ws/jQxkJ21wQsWwTAPcO8T1av+PV8jOVTZciAQGtB71mW1Zu?=
 =?us-ascii?Q?copE0X6VX9gAgJt3EXL9BMVbRwH1SyJ0dcLZhtRv4QDcrlm+leWYB+TRu9Ub?=
 =?us-ascii?Q?OjuyDu6etVYVK33CqvNCdl0sqtCP2GhX1lTg9nCcxhbVBvaDe49/2Wblgq3G?=
 =?us-ascii?Q?/qi6gOVONK8dp8dy/vViYybHcpckJBfwMs0wuWt2SwtCSzVaPzOpV0krCvP1?=
 =?us-ascii?Q?HQvn0Nj1OHNfKBqdqHxQVn9TikW2bND0T64+3XoM+tpoYHMrrnV3bl3rq7rX?=
 =?us-ascii?Q?dvKYvRxnppgocGVldDV1mCCpElm5b/L5JvjsFt83+wz5WRDp9Hk6RDzWn2vE?=
 =?us-ascii?Q?FuGTa3YCn6F5bKPsVaDChaTHlXX4umAKdSGbVuTK9QLqH475I1OmjjHUg2Es?=
 =?us-ascii?Q?elVsTezM9RXndmhMER/29kGC?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9663dc29-87fa-4d3c-3570-08d955ce2772
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8726.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2021 15:56:56.4001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R7pjxjFgHMmBOXNA4spBI97vh/Tti/JsAr9hfKxhWyp6X4HkGeA1bJjPMgcODZz2zibNHj+74vndBB77MlQ5rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8951
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
Changes in v2:
- removed duplicate entry of 0x8d80 and 0x8d88

 drivers/pci/quirks.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 24343a76c034..1ad158066d39 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4787,6 +4787,23 @@ static const struct pci_dev_acs_enabled {
 	{ PCI_VENDOR_ID_NXP, 0x8d80, pci_quirk_nxp_rp_acs },
 	{ PCI_VENDOR_ID_NXP, 0x8d88, pci_quirk_nxp_rp_acs },
 	{ PCI_VENDOR_ID_NXP, 0x8d89, pci_quirk_nxp_rp_acs },
+	{ PCI_VENDOR_ID_NXP, 0x8d90, pci_quirk_nxp_rp_acs },
+	{ PCI_VENDOR_ID_NXP, 0x8d91, pci_quirk_nxp_rp_acs },
+	{ PCI_VENDOR_ID_NXP, 0x8da1, pci_quirk_nxp_rp_acs },
+	{ PCI_VENDOR_ID_NXP, 0x8db0, pci_quirk_nxp_rp_acs },
+	{ PCI_VENDOR_ID_NXP, 0x8d92, pci_quirk_nxp_rp_acs },
+	{ PCI_VENDOR_ID_NXP, 0x8d82, pci_quirk_nxp_rp_acs },
+	{ PCI_VENDOR_ID_NXP, 0x8d93, pci_quirk_nxp_rp_acs },
+	{ PCI_VENDOR_ID_NXP, 0x8da0, pci_quirk_nxp_rp_acs },
+	{ PCI_VENDOR_ID_NXP, 0x8db1, pci_quirk_nxp_rp_acs },
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

