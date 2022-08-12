Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4414D5916E6
	for <lists+linux-pci@lfdr.de>; Fri, 12 Aug 2022 23:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234256AbiHLVx3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Aug 2022 17:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233805AbiHLVx1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Aug 2022 17:53:27 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2086.outbound.protection.outlook.com [40.107.22.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59D9B2854;
        Fri, 12 Aug 2022 14:53:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NI66fSACgQXKNA4vl3YwE9BkSBUHFsfA2bN3S47jCi9tEMu/rz2QHKmBQ7g5D4MK09AWjwhvE8qWWOmfuswRr/N9Wua8e4S3vjt0kByXUssN5gaUNPtHU58eEFCm9iSR0Jf2T2xDPTFBuAFS4eAoQFvLpzzW5W5KvzZcOiXPFGlgn2rSfID+Jk2AP9bZiNhxeUUjNiHMKHKk+k1l8shy3vLgZFpok5Iba68Do7f4ocJ5CMbLuy/FZc2tUod5T2T0xsnRfGVXdD7fFjaLyLCHwLLcH3XQ5zEVJxopvKqS82YXUd5QKuZ7dVyZfG0SDbcXO1DvqGNfUdEPu4BV7KzpQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g1NdUcLeUXF4fzJDgh+3FCiqhJxBXQ8qbrSj5WgwzKo=;
 b=TXS4SIhdz6uvtMSpEGwcp2cum2jAqKiNIC1QrcGye+poGklJkcvgqHXb2SYJZOqw3N0HLIDaO7wH4K8rsOZwOXY/7j5WYmmqEhnQyifv8WDF2/svAhTqF90+vr5Mj8x3nWH62XX0xIhdsta2NK4Y7FYkn/ryEgsEJX8zG7KN8C0m+MZDQmy9Jkz1Qpw1HnUZkT+iKo9aJRjU+Ad0D80A+3dt+Vfs3B5Hv1Ll8P1aPSokF9ygGWKs45gbNdGKxoUDYO08jA44CGYa8P0kL9SrDpNO4dD+gCm1LJtnFFh4Ar23UFcL4yOyA38ElJEor1yGQifLE14wuGoNTJslLU1bLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1NdUcLeUXF4fzJDgh+3FCiqhJxBXQ8qbrSj5WgwzKo=;
 b=DExiNgjMySEevPKjerBKQzDk3TMPsLrldUgL5oH2vBeS+lwPDQJ2B7BLnWZ986HugzPuYNKPHn2J7ElGUhd6YIe8vnTKy6xygCpjZGvn5maKSgM6234UDW6u/YjF+POmb440B9L/cU9MfKylUCkfBmGPic5b7NTDuNc+cvqYK+I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by GV1PR04MB9087.eurprd04.prod.outlook.com (2603:10a6:150:22::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Fri, 12 Aug
 2022 21:53:23 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c5f1:b708:61db:a004]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c5f1:b708:61db:a004%6]) with mapi id 15.20.5504.023; Fri, 12 Aug 2022
 21:53:23 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     maz@kernel.org, tglx@linutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kw@linux.com, bhelgaas@google.com
Cc:     kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        peng.fan@nxp.com, aisheng.dong@nxp.com, jdmason@kudzu.us,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        kishon@ti.com, lorenzo.pieralisi@arm.com, ntb@lists.linux.dev,
        lznuaa@gmail.com
Subject: [PATCH v4 4/4] pcie: endpoint: pci-epf-vntb: add endpoint MSI support
Date:   Fri, 12 Aug 2022 16:52:42 -0500
Message-Id: <20220812215242.2255824-5-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220812215242.2255824-1-Frank.Li@nxp.com>
References: <20220812215242.2255824-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR06CA0064.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::41) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7bf5f465-c90e-47a2-f90a-08da7cad13a4
X-MS-TrafficTypeDiagnostic: GV1PR04MB9087:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7wMA9gCi2eNtjiYzt490ih+RRsh16spqdjyE4Fzr9zka1vEXcANc/r+ofDMyQaqVJx7gvRJeU5BPJRWDe2ftVkZHO7lR5VwehyhQ5e2CFkOdPZHcAUfY9H2Tfn8PFvN32M7jdFX+Zh7zrDljke78tKVY6dXd3qEjN/jLIOMqGkzRJc6Uoru23BKP/M4C7FMoXZ/tROjnNxSx704lFU7lwCC0WBOHjEhveARteNwG06f5RZGQtDzHekfXWBMBMWtHB5e+eD37N3hl5yczkV9ipwTUTJYKQ5xPXZRdtXAYSNEyL4aYNp4m0ap4+U7RNiWc8uGjVNpodZWGibmjRnDL+AwmiJQ990nuHeTFsaccYI3RNT42MbZY2qyR1JjiEIClDghfhyq/uP8RFkf/WWFrmdCRNgd76j8z+u/2nEBCZcG261vNvYB6O7XXsRuEHQFsPszGUaiRCw6OqLcMYjz2Le0GhOPCVBO99znA6QBLNDIwYCxWmIYstg5i5xEOCGoreKPS870LgxQIuNhHRJ9YpWQAqIAQmza2OCYPdUo1xhNJG6TyhOU+dYzjM7y0hvKDuffmdYhrQQ9abuHYgk9ttNizeYStExayTRoebbuWZqga9Sgz/mGF3KuTM2oM0uUrW1XoHVBQ7dzsZooSPlnUIhj/RC3GyRTY3szwAze7zteTDjv8tpyN6nwAd0V77Nrama52YBlVsZPpExu1csFLWT5moo568Wl187kY4nMTvLQGkptgQgqrKTF39B616qpNV4punMUxzd2jXY/OZrQmGL652R0lTogptIjzBOqGr14=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(346002)(136003)(39860400002)(376002)(1076003)(2616005)(186003)(83380400001)(38100700002)(6486002)(478600001)(38350700002)(316002)(66556008)(41300700001)(6666004)(7416002)(5660300002)(52116002)(2906002)(8936002)(26005)(6512007)(66946007)(8676002)(6506007)(4326008)(66476007)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1o5dG5DWHBsK0JSdllSdFNxTDF5SXhWUTRic0pnVENMTnoyck9KdFNaV24w?=
 =?utf-8?B?REN3WmFSMTgvYUplWm9LU2pkUHlvd0pKQlZjWlZldnNJaU9jaUJoSVpMUVdO?=
 =?utf-8?B?RktWU2hTczlMUlNGQ2Vwd0g3VTQxNlF5WVM3dUR4MytYYWNVYndpME85QkU5?=
 =?utf-8?B?WVlNL0YzSnRFMFNjQ0V2dmIwSFc0QXVreWo1Nno4WjZMQlJqcmhMak1INUM0?=
 =?utf-8?B?VHp2R1lMS3FaU21DR1FzQ1daOG1nM1l2aHFEWktsVnR2clZ6TkJpTExhRFRv?=
 =?utf-8?B?Y2F5dXJ1UzRJaDl2dkRmVXJuVTVXKzBOQjRiSXFxTG82R1c3UWxCWWFQL3lv?=
 =?utf-8?B?REhCaUxZUmdyMEw1dTNxMU4xVlFablpZS09qTFVqaXNpNC9BdXduV3lMeG9C?=
 =?utf-8?B?TGwzWTlvZkxONzVaR3F6RnNhb1BoNlMzd21CNzlSRlE5TSt2T3BuZzZIY3p5?=
 =?utf-8?B?WC9FT2tIODhPc011TC84SmUvV05oWXdmRkVpY2k5YVQzd2NoTTRFRTlZNGhk?=
 =?utf-8?B?ZHZrR1BacHVrMlB3MjVGMlYvU0VjQ3A4UC92WGhrdzJqRWd5WDU3RlhvVHhi?=
 =?utf-8?B?Wk9PN1FaK3d2TDFYS3FUdUI3NTkyZ3Q5QzlrckhSZWowcUN6SG91dnNtaldO?=
 =?utf-8?B?Vktpc1A4bmpTZUQzaG9ZYlBBZDJieU9mUHRZVzMvRmpVTHZQZ2xzcDVNcEZ0?=
 =?utf-8?B?MnM1Tm9DcVNvZnV4U090WjYzbnkvQVBoODY0aElhSXM4NFdEYSt5M1lQSkhV?=
 =?utf-8?B?RFJBbzZGTFRDd296Rit3bUZLVXpSQS8xR0ZWVDVWNVRQcVRFc1Jtbkk4dVJW?=
 =?utf-8?B?SWtWWjQ1WGlseisxZFp3SW92RWNpQmNidjVVM1NWbVBodDNOU1RNdTBBbTVD?=
 =?utf-8?B?bFRIdFQ4RVJ6TnNwU0xDalRxMGUwcHkrRk53bnRxKzJSTDZKNkpIWmtVbmhK?=
 =?utf-8?B?a1NFVkxsNGpXTFNIWFRmVitWK1ZyRmpKRWpkd1NHR0lMRVY5aEdzNENQVzRG?=
 =?utf-8?B?MHRsMGRnLzdSa1B5ZjZnRCtGVlFoWVpLaEIvVDZXSW1VM3FJUk05MERuOTMy?=
 =?utf-8?B?SFpYb2RDVzVXTWJTbFphQS8rOGJRUm9pc0JkSUtUeFM4bzBSek4zTDR1RTJK?=
 =?utf-8?B?ZDNZbjN4ZzZCN0orWTBJSjE0dUQwUm9rVlQ5YU5FUG9Dckg1WjBndDNoaTlS?=
 =?utf-8?B?QWVjd1B4VkFhZFFZVTdpRmJ5ak5RVFI3Y0UzdFIrVVJURzhpUXpWTEoyUFpa?=
 =?utf-8?B?Y2FaZno5OTVlOFExQkpOM1NvK1hPSEszemlqZ0pKaG8zaFhXTHNJTHpEM2J2?=
 =?utf-8?B?VUNJbHFjdHFYZU5mRTBNc0pzNVhTa0VnditvVktoOGpNRjErTEhwd0dBQXJY?=
 =?utf-8?B?QTBPMmRzYkYyRVh4TmRUSTZBU09DQ1RhVGJxa1ViZWtLL1VHa2RxdjA1Tjgx?=
 =?utf-8?B?L1dvVDNvbjlaOEhGTnVKU2hMNzFkK09VN0dvM25Va0FnRktMSC9SVDVMV0ts?=
 =?utf-8?B?eUtmdE5OUnNpcDU5NmgzWHNxdWE5US9BR2RRTHN5Umk4Z3g1cVFYREMwMWRN?=
 =?utf-8?B?ZE0rUSsramFYNWJJc1hmMXF0Zjl0WVk2bWYzVlJXejJKSWJvL0s2N2pGQlFO?=
 =?utf-8?B?UmhpL1ZlQnhDUjhQcTF0M1pJS29TU1VMSExFUVU1WUdJQzJ2T2E4VnpFaitl?=
 =?utf-8?B?dk9TYjc4Zk9qa0QzMkJTT2I3VUd4Nmg4bnp6Y1RDbjBaWlNkTlRtWWNQWWZW?=
 =?utf-8?B?N3h1dlBGUmJHN1FUWkw4eHJCQU5TdVMyMWVVS2h0T3kyVGV2ZnZpZUZlYjRy?=
 =?utf-8?B?MHhsMkl3ODVtVjlKUFJGMExNWGI4eXNMYm1TMkFZZURVVER3UUxsQVdUWDZr?=
 =?utf-8?B?amFlckFRdkFaWEJmYXEvaEhzUGszdkl5TGlibzlzSlZPZlBud1FteGYwQlYv?=
 =?utf-8?B?RXZoZHVQV0VKeWsyVXBwa1ZQQUxYWW9TWXgzRjNDclhBRnc1dlUxRjJmYmdv?=
 =?utf-8?B?MFd0MXllT3dndkNBb1dkRUxweU9YLzl2R0JuMzBLZG1FbjlPTk95bnVYSGFa?=
 =?utf-8?B?Tkh3djhCcG1iSXkyNjRwUk0ySzdzNCsxczhsc2JaRzRrRDJhQ1NIUllNTlNs?=
 =?utf-8?Q?oWQA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bf5f465-c90e-47a2-f90a-08da7cad13a4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2022 21:53:22.9611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qA3t+/egv0/Edliz5LrSyKe2xapLVQmFF0i8QvmCv3BUJqqyfeROXcnMNxfFik8s5lT3b4w+uYbMrpi1pOIO+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9087
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

                        ┌───────┐          ┌──────────┐
                        │       │          │          │
      ┌─────────────┐   │       │          │ PCI Host │
      │ MSI         │◄┐ │       │          │          │
      │ Controller  │ │ │       │          │          │
      └─────────────┘ └─┼───────┼──────────┼─BAR0     │
                        │ PCI   │          │ BAR1     │
                        │ Func  │          │ BAR2     │
                        │       │          │ BAR3     │
                        │       │          │ BAR4     │
                        │       ├─────────►│          │
                        └───────┘          └──────────┘

Linux supports endpoint functions. PCI Host write BAR<n> space like write
to memory. The EP side can't know memory changed by the host driver.

PCI Spec has not defined a standard method to do that. Only define MSI(x)
to let EP notified RC status change.

The basic idea is to trigger an IRQ when PCI RC writes to a memory
address. That's what MSI controller provided. EP drivers just need to
request a platform MSI interrupt, struct msi_msg *msg will pass down a
memory address and data. EP driver will map such memory address to one of
PCI BAR<n>.  Host just writes such an address to trigger EP side irq.

Add MSI support for pci-epf-vntb. pci-epf-vntb driver query if system
have MSI controller. Setup doorbell address according to struct msi_msg.

So PCIe host can write this doorbell address to triger EP side's irq.

If no MSI controller exist, fall back to software polling.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 134 +++++++++++++++---
 1 file changed, 112 insertions(+), 22 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 1466dd1904175..ad4f7ec8a39fc 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -44,6 +44,7 @@
 #include <linux/pci-epc.h>
 #include <linux/pci-epf.h>
 #include <linux/ntb.h>
+#include <linux/msi.h>
 
 static struct workqueue_struct *kpcintb_workqueue;
 
@@ -143,6 +144,8 @@ struct epf_ntb {
 	void __iomem *vpci_mw_addr[MAX_MW];
 
 	struct delayed_work cmd_handler;
+
+	int msi_virqbase;
 };
 
 #define to_epf_ntb(epf_group) container_of((epf_group), struct epf_ntb, group)
@@ -253,7 +256,7 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
 
 	ntb = container_of(work, struct epf_ntb, cmd_handler.work);
 
-	for (i = 1; i < ntb->db_count; i++) {
+	for (i = 1; i < ntb->db_count && !ntb->epf_db_phy; i++) {
 		if (readl(ntb->epf_db + i * 4)) {
 			if (readl(ntb->epf_db + i * 4))
 				ntb->db |= 1 << (i - 1);
@@ -454,11 +457,9 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
 	ctrl->num_mws = ntb->num_mws;
 	ntb->spad_size = spad_size;
 
-	ctrl->db_entry_size = 4;
-
 	for (i = 0; i < ntb->db_count; i++) {
 		ntb->reg->db_data[i] = 1 + i;
-		ntb->reg->db_offset[i] = 0;
+		ntb->reg->db_offset[i] = 4 * i;
 	}
 
 	return 0;
@@ -509,6 +510,28 @@ static int epf_ntb_configure_interrupt(struct epf_ntb *ntb)
 	return 0;
 }
 
+static int epf_ntb_db_size(struct epf_ntb *ntb)
+{
+	const struct pci_epc_features *epc_features;
+	size_t size = 4 * ntb->db_count;
+	u32 align;
+
+	epc_features = pci_epc_get_features(ntb->epf->epc,
+					    ntb->epf->func_no,
+					    ntb->epf->vfunc_no);
+	align = epc_features->align;
+
+	if (size < 128)
+		size = 128;
+
+	if (align)
+		size = ALIGN(size, align);
+	else
+		size = roundup_pow_of_two(size);
+
+	return size;
+}
+
 /**
  * epf_ntb_db_bar_init() - Configure Doorbell window BARs
  * @ntb: NTB device that facilitates communication between HOST and vHOST
@@ -520,35 +543,33 @@ static int epf_ntb_db_bar_init(struct epf_ntb *ntb)
 	struct device *dev = &ntb->epf->dev;
 	int ret;
 	struct pci_epf_bar *epf_bar;
-	void __iomem *mw_addr;
+	void __iomem *mw_addr = NULL;
 	enum pci_barno barno;
-	size_t size = 4 * ntb->db_count;
+	size_t size;
 
 	epc_features = pci_epc_get_features(ntb->epf->epc,
 					    ntb->epf->func_no,
 					    ntb->epf->vfunc_no);
 	align = epc_features->align;
-
-	if (size < 128)
-		size = 128;
-
-	if (align)
-		size = ALIGN(size, align);
-	else
-		size = roundup_pow_of_two(size);
+	size = epf_ntb_db_size(ntb);
 
 	barno = ntb->epf_ntb_bar[BAR_DB];
+	epf_bar = &ntb->epf->bar[barno];
 
-	mw_addr = pci_epf_alloc_space(ntb->epf, size, barno, align, 0);
-	if (!mw_addr) {
-		dev_err(dev, "Failed to allocate OB address\n");
-		return -ENOMEM;
+	if (!ntb->epf_db_phy) {
+		mw_addr = pci_epf_alloc_space(ntb->epf, size, barno, align, 0);
+		if (!mw_addr) {
+			dev_err(dev, "Failed to allocate OB address\n");
+			return -ENOMEM;
+		}
+	} else {
+		epf_bar->phys_addr = ntb->epf_db_phy;
+		epf_bar->barno = barno;
+		epf_bar->size = size;
 	}
 
 	ntb->epf_db = mw_addr;
 
-	epf_bar = &ntb->epf->bar[barno];
-
 	ret = pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no, ntb->epf->vfunc_no, epf_bar);
 	if (ret) {
 		dev_err(dev, "Doorbell BAR set failed\n");
@@ -704,6 +725,74 @@ static int epf_ntb_init_epc_bar(struct epf_ntb *ntb)
 	return 0;
 }
 
+static void epf_ntb_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
+{
+	struct epf_ntb *ntb = dev_get_drvdata(desc->dev);
+	struct epf_ntb_ctrl *reg = ntb->reg;
+	int size = epf_ntb_db_size(ntb);
+	u64 addr;
+
+	addr = msg->address_hi;
+	addr <<= 32;
+	addr |= msg->address_lo;
+
+	reg->db_data[desc->msi_index] = msg->data;
+
+	if (desc->msi_index == 0)
+		ntb->epf_db_phy = round_down(addr, size);
+
+	reg->db_offset[desc->msi_index] = addr - ntb->epf_db_phy;
+}
+
+static irqreturn_t epf_ntb_interrupt_handler(int irq, void *data)
+{
+	struct epf_ntb *ntb = data;
+	int index;
+
+	index = irq - ntb->msi_virqbase;
+	ntb->db |= 1 << (index - 1);
+	ntb_db_event(&ntb->ntb, index);
+
+	return IRQ_HANDLED;
+}
+
+static void epf_ntb_epc_msi_init(struct epf_ntb *ntb)
+{
+	struct device *dev = &ntb->epf->dev;
+	struct irq_domain *domain;
+	int virq;
+	int ret;
+	int i;
+
+	domain = dev_get_msi_domain(ntb->epf->epc->dev.parent);
+	if (!domain)
+		return;
+
+	dev_set_msi_domain(dev, domain);
+
+	if (platform_msi_domain_alloc_irqs(&ntb->epf->dev,
+		ntb->db_count,
+		epf_ntb_write_msi_msg)) {
+		dev_info(dev, "Can't allocate MSI, fall back to poll mode\n");
+		return;
+	}
+
+	dev_info(dev, "vntb use MSI as doorbell\n");
+
+	for (i = 0; i < ntb->db_count; i++) {
+		virq = msi_get_virq(dev, i);
+		ret = devm_request_irq(dev, virq,
+			       epf_ntb_interrupt_handler, 0,
+			       "ntb", ntb);
+
+		if (ret)
+			dev_err(dev, "devm_request_irq() failure\n");
+
+		if (!i)
+			ntb->msi_virqbase = virq;
+	}
+}
+
 /**
  * epf_ntb_epc_init() - Initialize NTB interface
  * @ntb: NTB device that facilitates communication between HOST and vHOST2
@@ -1299,14 +1388,15 @@ static int epf_ntb_bind(struct pci_epf *epf)
 		goto err_bar_alloc;
 	}
 
+	epf_set_drvdata(epf, ntb);
+	epf_ntb_epc_msi_init(ntb);
+
 	ret = epf_ntb_epc_init(ntb);
 	if (ret) {
 		dev_err(dev, "Failed to initialize EPC\n");
 		goto err_bar_alloc;
 	}
 
-	epf_set_drvdata(epf, ntb);
-
 	pci_space[0] = (ntb->vntb_pid << 16) | ntb->vntb_vid;
 	pci_vntb_table[0].vendor = ntb->vntb_vid;
 	pci_vntb_table[0].device = ntb->vntb_pid;
-- 
2.35.1

