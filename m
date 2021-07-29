Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6783DA2F2
	for <lists+linux-pci@lfdr.de>; Thu, 29 Jul 2021 14:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236309AbhG2MST (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Jul 2021 08:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236285AbhG2MST (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Jul 2021 08:18:19 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on0622.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe1e::622])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E53C061765;
        Thu, 29 Jul 2021 05:18:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dx1bzjaReuBm8se4BtjH0D2VWmfORFYkDnur8hhS4nPq6BBZ9l7eWUyHdlN+ooqy206tLtppdopZ6C4CwsOys6kBKr5plIee4TSnnyC+oR1p5RpCtR++6G+eKaG6YnOI2c79iCmMMwvj4tGCTDWtYLPGeCedC0FMVw2FEMiGkmB0E8IOCTPng1DfboWJRAmLKt8dBbDKCmbwdCkOnve+typDvieQ/N+N+9nRz3mR7k9o+SrNvUs0qMQdbJg1Mh0QIvoyL08ilpR8sCOZ4r56DQCjB8jQP9d6TIuEulEsR2bVhexU8pCYRCrR6ReVcWEhI3UPSvy0o812PhAet9YvIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=stLs8A2hsS2yZLQZPRDKx405ndwUgm+QSOz2i64ZlAc=;
 b=RnE0wGAmdeRcDRzPCLtE/MqsKYQn13/BitJpi8ySO4LfM7B1A30b2HyasVNJLyVRxCaBUXL5oHyH71er/siW3iiSaTh7BMtEuuXPxS+Qz3AMSBnESyyz9CJAz88oEFxaJMYU87rjYMh+r9dWlxrooepv7yLLaIFSID3zzWqOFapd2joKciRxb9fub+Qb5PrTOjn6JxLul33Rsd647MP+h22ZiubNxc9z5WFA93wD+eEsSuqsV9OGYdh6AHS7bGVWvf/Z718H3mFYXKjgH6/N7KckFZaybIzbn4SL5QE9FxY7vR9GbbY47KYrUSUHnoGEkNJbSyjANpFOebqHzDw4QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=stLs8A2hsS2yZLQZPRDKx405ndwUgm+QSOz2i64ZlAc=;
 b=aD9e7A5tKYQgxACY/YT2A3Z55kpSluhHlTpn6aLWh+Pa4iqQqRVyblfkSsUawnI+T4YQcfJxRfARzJDnS/gd+tweD+Vk6YwDm/bhuL07WgAV3Ig/DmuLaNmDH1sEHs2A32u7SLZhrabfhxhHpS92tstyDMM9Z1Ih43EdoxEXlaE=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB8726.eurprd04.prod.outlook.com (2603:10a6:10:2dd::9)
 by DU2PR04MB8648.eurprd04.prod.outlook.com (2603:10a6:10:2df::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21; Thu, 29 Jul
 2021 12:18:09 +0000
Received: from DU2PR04MB8726.eurprd04.prod.outlook.com
 ([fe80::e50a:234a:7fb7:11d4]) by DU2PR04MB8726.eurprd04.prod.outlook.com
 ([fe80::e50a:234a:7fb7:11d4%9]) with mapi id 15.20.4373.021; Thu, 29 Jul 2021
 12:18:09 +0000
From:   Wasim Khan <wasim.khan@oss.nxp.com>
To:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     V.Sethi@nxp.com, Wasim Khan <wasim.khan@nxp.com>
Subject: [PATCH] PCI: Add ACS quirk for NXP LX2160A and LX2162A
Date:   Thu, 29 Jul 2021 14:17:47 +0200
Message-Id: <20210729121747.1823086-1-wasim.khan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0060.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::40) To DU2PR04MB8726.eurprd04.prod.outlook.com
 (2603:10a6:10:2dd::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lsv05369.swis.nl-cdc01.nxp.com (92.121.36.4) by AM0PR10CA0060.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Thu, 29 Jul 2021 12:18:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc4861d0-c98f-40cf-6028-08d9528aeda5
X-MS-TrafficTypeDiagnostic: DU2PR04MB8648:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DU2PR04MB86487F3FB55C0BB72F2477F2D1EB9@DU2PR04MB8648.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TDUJt5OXlcK5emmBT+VY8MF8nnTw+XZc9clXoIcxAHgJkvh5GvjBmdATYX1Ps2F/frtHbiOVzRtom/sYX4JOfWGpIlQCl81BhImv7Sc4L+8A6JRlTvxSUucwk8BNdsrKlkwaaZt6W4EEmlIMjvbdO1oXsAVSwpAKIvItftqlWitQ9mnUvhimS3zTVFPN0IFWIf/qBLdNlQQNmK/xy0KFBkWkqcYfKNQhxK3WuOO/HCjhpAfCG2cnbKAiPAABIkU1QUQzT9PcjyZeMddUeMvjvobSMMEsglCnMrhPwz7navHqiAKu/VEWRp5v/mJ/n0J4Mx4stg2hPYJ7WJYiikJo8njy26sL3scVZT2rR7CqwYUlRAz6szxwjBMiwEGHEAUztlGpthQst7IWHiB1QgvtediKurPCWzdGuR0q+I056rf5Msgwi+JvE0ikudyKzGRRskv+/YDNyXU9mrsHRuTl2P+EOaxfHgUJYa+AMOyA6Zu6mH64Gtnj8ZcnRyVR23VQ8rlcY5cMXjll8izE7p9Mz5vawxG/5+YVl9NAMPgkdQRjH+ixs/uNTeMwYL0QPfB3V7UMbV3SocAKuyvCcZrjeAvsEIDWdO+yzF7HbkUl/eXUYVuvPjZzMBBgDlCmi8pFddoV2VbXQyBn55S/n7u+OiRgylCRzrAciwDS7jTWDEpZjRF4UCZ9Huo1fr/5tlgLJFIgqY1q/bGbVz2vfiOd7g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8726.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(136003)(39860400002)(376002)(396003)(6486002)(956004)(26005)(186003)(316002)(2616005)(86362001)(44832011)(6666004)(1076003)(4326008)(5660300002)(83380400001)(38350700002)(8676002)(478600001)(2906002)(66556008)(6512007)(8936002)(66476007)(38100700002)(6506007)(52116002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fCe0kUE6qi1pBZadi2e+nAreQ/vSs/EVwaCDBaAijUZCyQpT0aQMxFIjo2GY?=
 =?us-ascii?Q?2Ek50uvgpeDT/D5uwasrPj6uirUU6EWmnbN3cACnyPrro2YInCHSRmp6bFGU?=
 =?us-ascii?Q?VzwQ6FaysXHgJfJguxHdHSCKHJX93Cw8fM7AJPJeRqZv4Ohze/PoAfqXsEHu?=
 =?us-ascii?Q?BAIQtHD6OEoCKgXcvad+AwcPzZ1wnF4uPWjm/dmVoPcHIqCevt1Vh8mof/1c?=
 =?us-ascii?Q?QrkBCEOlB3DGjUEDF4uQjly5UgbHZs0acfzZ65BThdD44KoBr7bhFPcs4IZ/?=
 =?us-ascii?Q?Os0wPAXnhJcjWJpIMz34B1IHzOUIh19StRlw++YmtQooPaW+ls4QHU2s46vU?=
 =?us-ascii?Q?LmF5w40HycAQcHpxAtla5VYCeAFg8AuKxhUXawHj5HbuYnI4aa4b+1evFT7Z?=
 =?us-ascii?Q?8tBqiCIIu1JjfUYDtvHl76I9vt7SryKC8T7RQkvvDN61QCFybz0s42ubnwCK?=
 =?us-ascii?Q?loH2yCZijfzKnI5Y2ATcvSI9isJJ1OwkA3GBJY/b2Z4kIq+06cp5BQOU5ylD?=
 =?us-ascii?Q?84T/wyrzSa1fuTOV8hsc1K73wZ8l0bVh6Bf6eJAF3IoxSDlf8Jd5Bj13H1SJ?=
 =?us-ascii?Q?GGZ3L6JRE5VGohnMnl/F9xG+4uaDdhsemvTEg4riFQGQWti79qZU2JE+5yd9?=
 =?us-ascii?Q?g4Q+zl6Yh+FRmv2YySrGpum+g5nMaSTfsSl2m05mROZ3o8B6XWMN6Qm+YzSR?=
 =?us-ascii?Q?/W4zHQ3WZPcuXuJ3mSMigcTUibWh4AjVLfSxY57CjnENHOoGDsZF6YGWCAGE?=
 =?us-ascii?Q?XnrU9EEB/Hwodva2OK9FD2s2uwmhaWIGzyyXGJQkM5VcxNLWrMEjYZ7IJXLA?=
 =?us-ascii?Q?C/5kQhjUnbSEb2+xzB1HHhSF9oX/RfuWEOuRO5WcQAjExlr5MdnIq3AunbTm?=
 =?us-ascii?Q?wrYjU6z/m8tBTEJIvNjT+dXptgq4ktNybT/XNSv/11FQUL0VvUy2rvFPFJ+6?=
 =?us-ascii?Q?v6Wix/yvJ/UhSNAevqeIjKp5uZg9AQ/MQTsaX8EBhcadoSOhrX+4tNXFIW9b?=
 =?us-ascii?Q?I8sFHSUXx/lCbrnc60jo8cUP8Io4byDRtoAW9eun0zjzBNsvA6fblq1TSGxD?=
 =?us-ascii?Q?VyXX5DL3qTrWdOhc82t4GSxPjJRy0v2GURwFGqRbGc8Mg/6sFHdJQOZS4VS3?=
 =?us-ascii?Q?pId2jkOI9tC+zEqZT6YhMBpEo2qwaEOYzjB164gQhIE1zKM5orhj+qhdcRzv?=
 =?us-ascii?Q?5ce7G+CobH6oiQJShPNXmnExUMavHQVNTFP11XoIF4MzoCpi0xWTN3zqkKzE?=
 =?us-ascii?Q?UrtQz0CIyXAghcCncnDtAgdsJhOuPOnbDQtD7HmpyAj1GPlcPAlBBdAlzDLM?=
 =?us-ascii?Q?lVRNtQ6QlOxJQ+KH8QyasrtO?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc4861d0-c98f-40cf-6028-08d9528aeda5
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8726.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2021 12:18:09.7151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Mc7XlqHXKckqJe1x/+RqgunxQNLaFyqEbFuuMWclc8US8O2sKmub/189bI+gN0OC+P5wacPok31iGt3wMjIvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8648
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Wasim Khan <wasim.khan@nxp.com>

Root Ports in NXP LX2160A and LX2162A where each Root Port
is a Root Complex with unique segment numbers do provide
isolation features to disable peer transactions and
validate bus numbers in requests, but do not provide an
actual PCIe ACS capability.

Add ACS quirk for NXP LX2160A and LX2162A

Signed-off-by: Wasim Khan <wasim.khan@nxp.com>
---
 drivers/pci/quirks.c    | 16 ++++++++++++++++
 include/linux/pci_ids.h |  1 +
 2 files changed, 17 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 653660e3ba9e..24343a76c034 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4527,6 +4527,18 @@ static int pci_quirk_qcom_rp_acs(struct pci_dev *dev, u16 acs_flags)
 		PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF);
 }
 
+/*
+ * These NXP Root Ports with each Root Port is a Root Complex
+ * with unique segment numbers do provide isolation features
+ * to disable peer transactions and validate bus numbers in
+ * requests, but do not provide an actual PCIe ACS capability.
+ */
+static int pci_quirk_nxp_rp_acs(struct pci_dev *dev, u16 acs_flags)
+{
+	return pci_acs_ctrl_enabled(acs_flags,
+		PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF);
+}
+
 static int pci_quirk_al_acs(struct pci_dev *dev, u16 acs_flags)
 {
 	if (pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT)
@@ -4771,6 +4783,10 @@ static const struct pci_dev_acs_enabled {
 	{ PCI_VENDOR_ID_ZHAOXIN, 0x3038, pci_quirk_mf_endpoint_acs },
 	{ PCI_VENDOR_ID_ZHAOXIN, 0x3104, pci_quirk_mf_endpoint_acs },
 	{ PCI_VENDOR_ID_ZHAOXIN, 0x9083, pci_quirk_mf_endpoint_acs },
+	/* NXP root ports */
+	{ PCI_VENDOR_ID_NXP, 0x8d80, pci_quirk_nxp_rp_acs },
+	{ PCI_VENDOR_ID_NXP, 0x8d88, pci_quirk_nxp_rp_acs },
+	{ PCI_VENDOR_ID_NXP, 0x8d89, pci_quirk_nxp_rp_acs },
 	/* Zhaoxin Root/Downstream Ports */
 	{ PCI_VENDOR_ID_ZHAOXIN, PCI_ANY_ID, pci_quirk_zhaoxin_pcie_ports_acs },
 	{ 0 }
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index d8156a5dbee8..9eabf77d043a 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2537,6 +2537,7 @@
 #define PCI_DEVICE_ID_MPC8641		0x7010
 #define PCI_DEVICE_ID_MPC8641D		0x7011
 #define PCI_DEVICE_ID_MPC8610		0x7018
+#define PCI_VENDOR_ID_NXP		0x1957
 
 #define PCI_VENDOR_ID_PASEMI		0x1959
 
-- 
2.25.1

