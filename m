Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 957806EFBB3
	for <lists+linux-pci@lfdr.de>; Wed, 26 Apr 2023 22:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjDZUfO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Apr 2023 16:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236226AbjDZUfI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Apr 2023 16:35:08 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2050.outbound.protection.outlook.com [40.107.7.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA480213B;
        Wed, 26 Apr 2023 13:35:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MHU19jNkW6Xp34HL+AzA40uZvz79f5TGCK2Ij146Bz9yGN3pi7rGkqG5cj2ea7wMQLJnNMTxKvtHB4e3jgIjyqHR1/hNJ201s5H0jrO89e/Up6MBHxZ90IPUT6SQrS8b/g9YqrsWi1qDKwLMVOCuu+EbkhRgMslTpV1ARHK6LDJDqmQ6ScEdS/9bSUzjvfljHwvo6THhKozJzkTH9J/jJ1fI1Cr8jErCzURJE4ptgAPdqN5D2hdnDOiCD6+FTEh/7uznEkTv1Ie8w6lNNV4AFMtkov/O1JS6yzu4VergC5a40ZPMNhBh7qUzPudPpac6e+JZBAYydTAEjZUTFvGX5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kbOvwRQjUthcS7fAnYmsKAe1AJ9NOnZtXvjw14q7T+w=;
 b=KJiyd0JD+GJAwZ2P7+djD36GgjmtrrVG9OWPFeT2keZEIp5jFINgAMjzgDFR6ExCIm5qHnDi9c3KCEBQ2qcBm7Wq9swMcE+lgSuCpmTdl2mvzv+bzjQw5PbzbQCA1Oadjq0XPC243qtWUJukDUtc6V/kK1DmSZye1PlJy9eoGZXOK5q4FFs8J/5O01jq0YwoDtGnHmh+XHYwHBPz1G/WryabSz62OsZ63kVVX/uSJGXhrZCe+iU/pq57S2IldWQQwgt1zN8UkdvjosBbY/XAUhl2Y8SAhF6KEgGLpne+BcSOJh9YZtJSrTekOYrbHTNvEz7cehWuyHuL+C/B+GJN8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kbOvwRQjUthcS7fAnYmsKAe1AJ9NOnZtXvjw14q7T+w=;
 b=kxvaaBL7b4YtQuEbQiy0elcwvpj0Ogw8GGNaPbTlm6ew8eQr0z7ZssOQEdXRfb8eclAwltmcxE5WkTQbfOWV26xBVZ1ghNXbgmU/I8OaQiWWOzXKIoEpnl1cte0SedDAyOVniN9cSsqVbwNcKOh7nvtYYfTJs6pdpUcWIOzHV5Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB9PR04MB8477.eurprd04.prod.outlook.com (2603:10a6:10:2c3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22; Wed, 26 Apr
 2023 20:35:02 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::f1d6:f05f:b8c6:4353]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::f1d6:f05f:b8c6:4353%7]) with mapi id 15.20.6340.021; Wed, 26 Apr 2023
 20:35:02 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     tglx@linutronix.de
Cc:     aisheng.dong@nxp.com, bhelgaas@google.com,
        devicetree@vger.kernel.org, festevam@gmail.com, frank.li@nxp.com,
        imx@lists.linux.dev, jdmason@kudzu.us, kernel@pengutronix.de,
        kishon@ti.com, krzysztof.kozlowski+dt@linaro.org, kw@linux.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com, lpieralisi@kernel.org,
        manivannan.sadhasivam@linaro.org, maz@kernel.org,
        ntb@lists.linux.dev, peng.fan@nxp.com, robh+dt@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org
Subject: [PATCH 1/3] PCI: endpoint: Add RC-to-EP doorbell support using platform MSI controller
Date:   Wed, 26 Apr 2023 16:34:34 -0400
Message-Id: <20230426203436.1277307-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230426203436.1277307-1-Frank.Li@nxp.com>
References: <20230426203436.1277307-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0030.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::35) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DB9PR04MB8477:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cce41bb-81f3-4db1-13b6-08db4695b5ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AZfG622uZUYh7GIYSsiACYIwzZiw5n4ylK50xOvUpor0U8R1ShcwMil8Vh/BL4iq2/TQWqm9ufNbxtM+5DKb8ePXY7v3jTx0JwjLK0rIckhlX+E6l3E7HqCoOCV5XK9Dgl/pcKm6JSyTRtk916w6jm37wEynt9QvMLgfR++QEFKgBrfLf8vNdipNwBVWo9gq275DvYIL57UzwbhyK2S1wPLY8hOhJyinXeI2MydqmJnnQ1bijoPgK3K649EwTKcEXcJz++syjoxJ+1yBJfdbgK/Wh9awLoNuqOd5u1VMZhV6bb9HK5kL2R3oTqXCtph/OHjAT62k1/DdmF2j6KkjP1cVLVGvVOztsjQIKZWCL6Ht2JqOrEJJhrcfRyCBRvbP6ET7kCsCm7WECXi9OhNbIuMfcL+vXzOykxetQ36TtyxfBJYL2Jo80st8UvOfyYF2+1JOnuqQcnV/csRxbAyVx6jajRrY25KTgiWw8YSJBHGqGHhqLzfTgy8c2Z/0oaKE/eHzRID195uj286Gu6Es1lm32KLIcw8A1JnFZPDjcBmyx+3fYSpbF8EZUVsHX3p9vSauUW4KzWyUUnk0N+jwOK2GcP5Lb5My6MSj8QPcdCVMmWgoahSkjWczsAl64Mpb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(39860400002)(136003)(346002)(396003)(451199021)(38350700002)(38100700002)(26005)(1076003)(6506007)(6512007)(186003)(2616005)(83380400001)(7416002)(2906002)(8676002)(8936002)(5660300002)(36756003)(86362001)(6666004)(478600001)(52116002)(6486002)(66476007)(66556008)(66946007)(41300700001)(4326008)(6916009)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IYwq8pj/UaQUBJE4AnF8MO5r3SqeDCThbP55L+gL9YtLZHfnGRCWKFkxHkJZ?=
 =?us-ascii?Q?XH1VfoAIRC2LNdmoG+Xi79KrOLHMwJHsuKMnvbnNrKBfAdtNMYfhYScSrGF6?=
 =?us-ascii?Q?g7i2j4DrzQvva5sVUApY7aW7pAFM27M+L9mKgenSlgwfHJeCjpcj5qrnc9ZE?=
 =?us-ascii?Q?OXDa13tpVzpZX95cc/mka8r/qoEz1xpIIvtDTlTqki/oNYYkMazOFVeZLppF?=
 =?us-ascii?Q?EHflnaFt7AScq3JvSrDhIkEHxaD3pcPkr13v+fPv/7PGuMTsDwapokOq2A0D?=
 =?us-ascii?Q?xK2AdxQVdPA2CDdZVnw9br20ci9ZKDLQZcZ2l+8PQc4WCQWG4WNxpG20TOFF?=
 =?us-ascii?Q?3k175KKxnOgkkR6lbRkfIamMp9UXbDEqsB32gP/JB+6uil+dnBGb1hWUnpzK?=
 =?us-ascii?Q?T7SHzkKqFdk/4biGHXomoKEbi9pFZI76b+EKbNslX1TPJ5lN91GUv9KvyvEp?=
 =?us-ascii?Q?KOnno/nuhPYy3xDtarVQEoAKqdIhSxSMUJ4JOLUgn0PLS/IGzdTt12CV7fj1?=
 =?us-ascii?Q?iu+duVz95LkpMI4pNyngIptY1ALQANlYcSarLlSImq0HPQgegkPFxeU3qNTq?=
 =?us-ascii?Q?rujGsLjK7xFQbHq/aUqjsc5UYHCyu02/d9tsgIBCGFCVsvVkeHfkV8R3zTzW?=
 =?us-ascii?Q?UwV9PXULhHM0Px9wAz91HWpyI+8JZjVz0DUfrJy8VfRTvs8oPjHF1WRqopt8?=
 =?us-ascii?Q?MSsLmch/4dYkF3XUU30dnSxZvjnshJT5HbYLUw3HYjs/blA7BFbVrP/g8Mb7?=
 =?us-ascii?Q?ZwVKobEnKQGIgt0vAzNiXDK31RzyuBIs2XkYkEJdmOlse3KqdZb7CgZffxPs?=
 =?us-ascii?Q?0xRH7on/RgRRwR+nf0jlMFl9svOX0Y6D9mWWy836M6QrwMVB2Khq4/yUTJrB?=
 =?us-ascii?Q?UHBo6ol2//UTaKg7G3O1k+h0UeunoINXcDdaMpTmm5z3Z4xOSsEmH4ki/9P2?=
 =?us-ascii?Q?Egnyz9/Pvupte5G1YRg1vE9cANqeQLVYZOhZI17LI0fthyry9NOVWrG9mBKa?=
 =?us-ascii?Q?R+p8RIJZCMNLcbAMAaNgRt8z/iQRU6HkSBbrQp8Hod99xUCRnpGtLfk0ck4I?=
 =?us-ascii?Q?6lfHK78OADiQHQdW45T1BfUfBqTTuKumidwSu7xiTcx7D/7FQ4/Xtr2vEZn2?=
 =?us-ascii?Q?2lnSmkMPjnJE2ajV9e4gD8KBVFTNFmMKds+mNoFkc5Yn3uYDky0RdDgOp+wq?=
 =?us-ascii?Q?3coO96XU9omnVN/2xjRSv2BRKt2nMBAnMQxM6gcwgZA1QDLAjg0Hk0OZfSeu?=
 =?us-ascii?Q?L2hC9v0vQtqfCjL2keY/9E4T9mOvKEmYYmDGCnYPKQUuBOw6sAs51f6+uFdu?=
 =?us-ascii?Q?TFA4jQwxjwxYMborqXKTLuroB6Eeb7NuJNHVfDI1pkVbCwl+KktMwb8sQhUa?=
 =?us-ascii?Q?eT/+/6omckRher1iaDgYEMH2zh0ZLDK6kq/DU0DZLc0hGi+k9i7RuEg3sYEs?=
 =?us-ascii?Q?8waxguJAkUOtTb2q197PEsIAqOhDp449BQbiLI1ppElDRge2f1Y7+ka1zQWa?=
 =?us-ascii?Q?0D6J5aHpixfkUfIxRrUqd9POQQUcRrugyqIeRIpeEX/WMMCgkxIOZVBG2iTU?=
 =?us-ascii?Q?iMf5ei6qD8oqtKzvzDRySIh99y3ZoZIkPMvFsyq0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cce41bb-81f3-4db1-13b6-08db4695b5ff
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 20:35:02.2523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N3hDsVvmL0HexsKzXR1EZVQdZESu62Iu1u65PdTA53F/elAhLbbs+SrGXCPgFmEMpxaOl7pcSt65g+m4ZboLSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8477
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This commit introduces a common method for sending messages from the Root Complex
(RC) to the Endpoint (EP) by utilizing the platform MSI interrupt controller,
such as ARM GIC, as an EP doorbell. Maps the memory assigned for the BAR region
by the PCI host to the message address of the platform MSI interrupt controller
in the PCI EP. As a result, when the PCI RC writes to the BAR region, it triggers
an IRQ at the EP. This implementation serves as a common method for all endpoint
function drivers.

However, it currently supports only one EP physical function due to limitations
in ARM MSI/IMS readiness.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/endpoint/pci-epf-core.c | 109 ++++++++++++++++++++++++++++
 include/linux/pci-epf.h             |  16 ++++
 2 files changed, 125 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index 355a6f56fcea..94ac82bf84c5 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -6,10 +6,12 @@
  * Author: Kishon Vijay Abraham I <kishon@ti.com>
  */
 
+#include <linux/irqreturn.h>
 #include <linux/device.h>
 #include <linux/dma-mapping.h>
 #include <linux/slab.h>
 #include <linux/module.h>
+#include <linux/msi.h>
 
 #include <linux/pci-epc.h>
 #include <linux/pci-epf.h>
@@ -300,6 +302,113 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
 }
 EXPORT_SYMBOL_GPL(pci_epf_alloc_space);
 
+static enum irqreturn pci_epf_interrupt_handler(int irq, void *data)
+{
+	struct pci_epf *epf = data;
+
+	if (epf->event_ops && epf->event_ops->doorbell)
+		epf->event_ops->doorbell(epf, irq - epf->virq_base);
+
+	return IRQ_HANDLED;
+}
+
+static void pci_epf_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
+{
+	struct pci_epc *epc = container_of(desc->dev, struct pci_epc, dev);
+	struct pci_epf *epf;
+
+	/* Todo: Need check correct epf if multi epf supported */
+	list_for_each_entry(epf, &epc->pci_epf, list) {
+		if (epf->msg && desc->msi_index < epf->num_msgs)
+			epf->msg[desc->msi_index] = *msg;
+	}
+}
+
+int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_msgs)
+{
+	struct irq_domain *domain;
+	struct pci_epc *epc;
+	struct device *dev;
+	int virq;
+	int ret;
+	int i;
+
+	epc = epf->epc;
+	dev = &epc->dev;
+
+	/*
+	 * Current only support 1 function.
+	 * PCI IMS(interrupt message store) ARM support have not been
+	 * ready yet.
+	 */
+	if (epc->function_num_map != 1)
+		return -EOPNOTSUPP;
+
+	domain = dev_get_msi_domain(dev->parent);
+	if (!domain)
+		return -EOPNOTSUPP;
+	dev_set_msi_domain(dev, domain);
+
+	/* use parent of_node to get device id information */
+	dev->of_node = dev->parent->of_node;
+
+	epf->msg = kcalloc(num_msgs, sizeof(struct msi_msg), GFP_KERNEL);
+	if (!epf->msg)
+		return -ENOMEM;
+
+	epf->num_msgs = num_msgs;
+
+	ret = platform_msi_domain_alloc_irqs(dev, num_msgs, pci_epf_write_msi_msg);
+	if (ret) {
+		dev_err(dev, "Can't allocate MSI from system MSI controller\n");
+		goto err_mem;
+	}
+
+	for (i = 0; i < num_msgs; i++) {
+		virq = msi_get_virq(dev, i);
+		if (i == 0)
+			epf->virq_base = virq;
+
+		ret = request_irq(virq, pci_epf_interrupt_handler, 0,
+				  "pci-epf-doorbell", epf);
+
+		if (ret) {
+			dev_err(dev, "Failure request doorbell IRQ\n");
+			goto err_irq;
+		}
+	}
+
+	epf->num_msgs = num_msgs;
+	return ret;
+
+err_irq:
+	platform_msi_domain_free_irqs(dev);
+err_mem:
+	kfree(epf->msg);
+	epf->msg = NULL;
+	epf->num_msgs = 0;
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pci_epf_alloc_doorbell);
+
+void pci_epf_free_doorbell(struct pci_epf *epf)
+{
+	struct pci_epc *epc;
+	int i;
+
+	epc = epf->epc;
+
+	for (i = 0; i < epf->num_msgs; i++)
+		free_irq(epf->virq_base + i, epf);
+
+	platform_msi_domain_free_irqs(&epc->dev);
+	kfree(epf->msg);
+	epf->msg = NULL;
+	epf->num_msgs = 0;
+}
+EXPORT_SYMBOL_GPL(pci_epf_free_doorbell);
+
 static void pci_epf_remove_cfs(struct pci_epf_driver *driver)
 {
 	struct config_group *group, *tmp;
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index b8441db2fa52..e187e3ee48d2 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -75,6 +75,7 @@ struct pci_epf_ops {
 struct pci_epc_event_ops {
 	int (*core_init)(struct pci_epf *epf);
 	int (*link_up)(struct pci_epf *epf);
+	int (*doorbell)(struct pci_epf *epf, int index);
 };
 
 /**
@@ -173,6 +174,9 @@ struct pci_epf {
 	unsigned long		vfunction_num_map;
 	struct list_head	pci_vepf;
 	const struct pci_epc_event_ops *event_ops;
+	struct msi_msg *msg;
+	u16 num_msgs;
+	int virq_base;
 };
 
 /**
@@ -216,4 +220,16 @@ int pci_epf_bind(struct pci_epf *epf);
 void pci_epf_unbind(struct pci_epf *epf);
 int pci_epf_add_vepf(struct pci_epf *epf_pf, struct pci_epf *epf_vf);
 void pci_epf_remove_vepf(struct pci_epf *epf_pf, struct pci_epf *epf_vf);
+int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 nums);
+void pci_epf_free_doorbell(struct pci_epf *epf);
+
+static inline struct msi_msg *epf_get_msg(struct pci_epf *epf)
+{
+	return epf->msg;
+}
+
+static inline u16 epf_get_msg_num(struct pci_epf *epf)
+{
+	return epf->num_msgs;
+}
 #endif /* __LINUX_PCI_EPF_H */
-- 
2.34.1

