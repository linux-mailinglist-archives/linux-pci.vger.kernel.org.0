Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9DB5951DA
	for <lists+linux-pci@lfdr.de>; Tue, 16 Aug 2022 07:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233059AbiHPFSd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Aug 2022 01:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232302AbiHPFSQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Aug 2022 01:18:16 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10089.outbound.protection.outlook.com [40.107.1.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C580203683;
        Mon, 15 Aug 2022 14:40:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U09tWjYbMbWPGFcg5jArO5SZsOgWn5vakCtu8ypzSC080QdWvMwJGVtHynGeKz+WYsAZf29BDHfkC7/yqlEEPoG9pvDtyM3sEa1tn2Z6sc24zWvtfXxE0I8cRGUyK3z6m799YVcDSWVo3HfiWHH5RKTNSXsCegT3C29iHccX8uW5ps4GTlSu0ZQ3L7tRQyAmcdYfF2pDOOKkq1CC0yPYiPBSLyl0PZs+rKZ5wZfUIYRSUu0+t45feMdeoz0DDFT0OfYiWIt95wJgfzeRpQHKPuzNZ6XeAWeOVoqJHe0vDD+5FX+KtgzbQ4sr7ugMTzz6R6aOrNAYnpQUlMWuLHl5nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g1NdUcLeUXF4fzJDgh+3FCiqhJxBXQ8qbrSj5WgwzKo=;
 b=dGVSt0ORMMQ8NlpzeOimNs2SxkM+lexFGeXAxFpxhTQQOpP7wXJXEZdb8G5nVSa7a1raK/Vh8rAX/Zp488koC2Z1iHSBhl9Y8ihm32rDh2tcbC4OUl/zZnFsJuDTIFY58GreAG6bCFCo1OfvQIaAcbF7qlwzmXiixRn7yBFUotAKdXR04/q9QzuuTd8sZ4y274/NLXiM/j//HVEs1Hb+RVi/PHzC30ETwK1jxUAaFmCjObnN8DClIGhZHwBS5CkLNfwPgUtKTzJqzZXtKClXTjtUxs34aGPQBfI2yc1K9JPKyrQ6xzA+btm+SIstVwH9nHOp7m+lzmhf3qWu0cdNFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1NdUcLeUXF4fzJDgh+3FCiqhJxBXQ8qbrSj5WgwzKo=;
 b=XAJEEZbIfZfKGnXX6DjsKPWHY0IowbDPhiRP1WEF/BAGwKldnSYG4FHlhM9zWUySUWBT/kauJ5E+drFd3EEtf0Ifu8qe+P/yr6fGZ5CweVNHLWnwGmgJ0r3uBgntOp4ugHeFMtpzvW0KS9HHOSpNjT9TJBYyqt9h8hETPmb6EcI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by AM5PR0401MB2580.eurprd04.prod.outlook.com (2603:10a6:203:38::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Mon, 15 Aug
 2022 21:40:16 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c5f1:b708:61db:a004]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c5f1:b708:61db:a004%5]) with mapi id 15.20.5504.028; Mon, 15 Aug 2022
 21:40:16 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     maz@kernel.org, tglx@linutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kw@linux.com, bhelgaas@google.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        peng.fan@nxp.com, aisheng.dong@nxp.com, jdmason@kudzu.us,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        kishon@ti.com, lorenzo.pieralisi@arm.com, ntb@lists.linux.dev,
        lznuaa@gmail.com
Subject: [PATCH v5 4/4] pcie: endpoint: pci-epf-vntb: add endpoint MSI support
Date:   Mon, 15 Aug 2022 16:39:36 -0500
Message-Id: <20220815213936.2380439-5-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220815213936.2380439-1-Frank.Li@nxp.com>
References: <20220815213936.2380439-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CY5PR15CA0006.namprd15.prod.outlook.com
 (2603:10b6:930:14::9) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a71fac6-145d-49f3-ae68-08da7f06be15
X-MS-TrafficTypeDiagnostic: AM5PR0401MB2580:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WiXYlFO/TrmjrcBxVAI9xpchPGoyQAV0JN7pE3UPK1X1jJ1+e/+MCL8oP3Y1qR3J8AIq+heUiZte1DtXI5zTL10+kcE7Kvf2Ybc7kGK53NbOamIEymAjh2+p8m3hT9HDstJXo/6q1vIN8x2QTilXWgh1kPFKTGBeFmNSYNyNgTdFRIyDHC3fBQ6fDH7hLv3YrnBg8YS5P6+DCNXZctd2Pv+Y24n7LsqFxxiL8+76iYR4ZI1j2bqzljnir1wT9RjmVggwi0FMsjCt+gmNRLu4d6Yf/RydNGjZf93c42qYW1iGQXmTvZnbYFEwj/dhRJj8carf8fhCRRWldQW494/dEXleAhEFmzv/QrOWJ810bedluNWJnNe2OfoVNq58p0Z83BNgHhkNumSg8ClMiB+s6i0D04ELBB5k/jp3TaxIW9HKy5XvvF4LLQTa40APlInXYDkl+ELCdIXX6K3yVH9mcAaSkikTT9OKpWa35qCMW9rKHOzT39ipsZ1DMiARPIZuskxYdLu1l6M6SZmji4yBfi+ZyiGhQrtcQHISpZtBtmJf9t0tEQNBtq3cgnloOtAqvO7CJuVpSkrvg4A34pm9XXr7rEuF5NmOkfn+3M+EcmSQLT9Wy3amNzMQV9IaQry/Fg3kdM4TiClXJrG8vWLoNFvHA9kod1EoKBMyRbBlCQ7mtZWj/bN3pfRYZgO+3SX/RrPBrb8P7PTPNunhoW2m0C7/dpQdGSFcSacnqkDvhRRj3+9Ds94jIK4iZ6447bKY9Mo/PIO8ewAh/VUOxPyHz2PGBhDdTvWPc/abkKjq5Bw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(136003)(39860400002)(396003)(346002)(83380400001)(478600001)(5660300002)(1076003)(36756003)(186003)(6486002)(2616005)(38350700002)(8936002)(86362001)(41300700001)(316002)(7416002)(6666004)(4326008)(8676002)(66476007)(38100700002)(66556008)(6506007)(6512007)(52116002)(2906002)(66946007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHViSzI1SXoxbU4xbHZtSC9BTU9kK2dBUVlQNkhJS21WOGFFN0lKc2s2Zytk?=
 =?utf-8?B?SCt0QVJQWEp1MVJhNzJPeGxmcG5TRDdxY0hGYVI4VDlXODd1YU54dkIvRldL?=
 =?utf-8?B?UUhnYWVuNDgwM2VhYklqcENkSHJlaXNxWWlTSG0wN3FTcGd3a0xtSXowdFpZ?=
 =?utf-8?B?ZitqWHMyYlMzWEc0OGtsekh5M244M3hrUkVGQXFEbWtya0dmQkREeXBXeExp?=
 =?utf-8?B?TXdQNU5rU0xIUy90UndiOHkrSy9NUHlvbWw0ZEMyeFVjcDdYb1R0NTdmYVhF?=
 =?utf-8?B?STdlalFPV1UzenJneEJ1OG01Rk9MVmY4eVNPODBqQWNlSndlbTJ4QVpVNlB1?=
 =?utf-8?B?dkVFZm01R2p3TStUN1huZHdHeXg5OEh2b1JLU0FseHhHUXgvemVuMkd4SFJj?=
 =?utf-8?B?N2s0UWhQSlFMZ0xHN0lNYUl1cWtJaTlZNTlmRThUWXEzUk5DVFhlNFdEOUxX?=
 =?utf-8?B?aWt4VHM4U2VYUUlHcitBSmVzdk5uNFVVRlF6cnlOUWY1ZW92RzIralNrSFB3?=
 =?utf-8?B?TExscmxIRVJTUGRSVEc2aXRvdGJNOUw5RU9FbzJDcVZ6VDJBZy9UM0VseU5v?=
 =?utf-8?B?cVZBWlQ3MkNidm5CZlh2QVVoTG0vMHhzUHR1TFEvbHMzc0dDekFwR1hFdlRT?=
 =?utf-8?B?dkRoeCtwWENWYkVobEUxR25WZU9hQm1DRVJLMjAwbWlZU1g4VTdNaDh4UFZt?=
 =?utf-8?B?bFJCdWdYUm9rUzNxekJWd2VnMDhZZHU4aVBXcFNHRkVYdCs3eU1Fckh4d01W?=
 =?utf-8?B?eFVVbWdabEZscmhzS3dJNjRjeHNXZ3ZLaEFLZGZjcHMwOTE4SE5kTjRyOFpT?=
 =?utf-8?B?VW1maDVucE1kL2Z0eTBIRWNJLzcyNDVVV0FjSUVCSmI5QURDdkc4T3BWZDNL?=
 =?utf-8?B?UmlZc0JVNnU0QlgwRDYvRVNhSllreVVlZktmWVg0MU5hVjNaWFNpMmloNG8x?=
 =?utf-8?B?RVFscS84bG0ya2VoaWFGNkViR2RBK0o5NmlHTmtLaEZpdXNsbFVuMVJtZEx0?=
 =?utf-8?B?QWNQWWNDUjc5aTUwZXRKb1ZLc2NjcGswMHA4OFVXczRVMWV0RGJ1V09aVE1X?=
 =?utf-8?B?ajRhTy9vMlNCQmgrcWM4WHU1VXd1M0VmV21DalMrQW5YWnZiaDZOSFNRcUh1?=
 =?utf-8?B?T0tFRGlvTEc0SndEbmxUZElDT0tqd3NuR25ua2RUVmcycUF0MFhkYXc5Nmdx?=
 =?utf-8?B?Z1FVaExzZFhuUjhnR0pxRHI3UEt3TGVSM29wVFh0NXlrTmdQK2wzTjNnMTRB?=
 =?utf-8?B?QXUxT29vQ2dpNVhmREZMUDFXU05QVGh1aEozM1FMbDJYMVVWZ1FIZk1kUytx?=
 =?utf-8?B?VkZDMm5iYWRmbmxlWWlFQld3RzF2aTlpUGlBWDgyMHZXWHRsc210cStYNzRy?=
 =?utf-8?B?ZVhCbFBtMmtvUlVjdE9abGVhR2ovS05wd2xqRzZMZVU2cjkvNzdWNlBSaUR2?=
 =?utf-8?B?WFRRT1Z1WXdVTHJacmVuTFlPVkpOSW1ubG1mbmVKdnFOSHJQWXNyOUt6ajBF?=
 =?utf-8?B?ZGVROGIrWGRjUVcrYkd2eHBjckUzMFBnNnU4eE02YkQ1RWtPM3FUZmV4Lzhv?=
 =?utf-8?B?MmVsVWxUV3hiTi85cTNaKzJQU3ZMVE5WcWMxanJUTTdUdGJGbU5WWm1SZm9M?=
 =?utf-8?B?MXJSQ0tlYU4xOEZXL21zS254Um5lODNibnJoSGxiNEtLQkhBSjRRekUzejJB?=
 =?utf-8?B?dVMvQnk4SFFzTHJ1ZVY5eWgwL1N2ZVFKWDVrQXgrdDVGOThqUnZJa2J5OERi?=
 =?utf-8?B?VkRlWGpSZlNQWjNxNkh0ajhtcFZYM2VGbDdONnluQmRnLzV4NnYyQ2I5YUVT?=
 =?utf-8?B?VEg5YUtudUtHbFMzZTcwVlZoTUpVdlNIQk5yK2doTjlMZnJIOVBvY3Q0WjN2?=
 =?utf-8?B?Z1ZLOUh2L0JCWFF4blpyOThRb0R4ZFczRGZnNGlzOEhsbjFwS0ZCN1ZWMDlJ?=
 =?utf-8?B?VFczWjhrSm5DcEtYNnkwOEgxcXIvMjJQZHZOQUhTdkhDeDkrL28zaEg2a0l2?=
 =?utf-8?B?OUI1SCt0b0NPYVRmMmxUa1NWemJxdVRKV01qcEZKdHB2a2V5NnpxcER2TTVp?=
 =?utf-8?B?Sk5BazZscG5mZGIzZkpDaGJzaWNDZDhZcEQyTVVIY08xbmFHYTN3SksyUnQv?=
 =?utf-8?Q?qJYzz6UxdMV3KFkYwTGDOmmq6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a71fac6-145d-49f3-ae68-08da7f06be15
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2022 21:40:16.3844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P/q4EVnQonnJtPAk6029ZoC4uMQ7z6LggR7Ps1GogxJTnrZo9PgyCfKl713xxHC1POuaBzeSElHSr7duHPneow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0401MB2580
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

