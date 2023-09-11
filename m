Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2DE579C183
	for <lists+linux-pci@lfdr.de>; Tue, 12 Sep 2023 03:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233689AbjILBPY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Sep 2023 21:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbjILBPJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Sep 2023 21:15:09 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on0602.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0c::602])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA22174387;
        Mon, 11 Sep 2023 18:02:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hpMb7IX+7oA73X33ItmyizZ43fdwVOyJLgNjpD9prLE7PKTUI2yDnxoy2AcEyP80dkwNd6TE+nVQiNfkMZGyFAMRij395U45XYwY+hrJMlJXSDN1PeAkpJDPt813bAoGkBqIN2ZTHPcOPr/ydQjQ1K3y5RtA+mjcX1FJtSIlVVtqit/wjbWtqJVmED9ojU2TuRN5zaY0mAzBsxUaPXQgBl9kPHXMrCPD1kFlB/1txj/ZZurXDLwOZ9Cw+wQrn1ROFoOptZdHy5dczZvJTDgb1xB8eJeAewiSQxMX8H4A6xOo0xZNhgLz7vlseJ5gswdQfYI6BeKgu11zAdZspCvQrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g+bjztS/6vJwT0O0RAzLFlqabXhUpXXiyiK6O/MCCdA=;
 b=KcPV/darBv8kD/G+b8NDEZaXkOgY7xHdxRR+NrsdYi7OUs8umVUSV4ookgt7BmH2oeg1fgIo55xnVcKaMuHoGHIU45P+vtlAB+yJ53629icQYbBNquR/hVeOZZLJAL8b4zj23pXamHilElO/axMfv9y/R0Ik0ubwb+VQUL/gQIjSrQ+K8iaxH5fFtwQP2HfhQvbB8icN8wT/AMH9LeoEpYf7UQ+lKnh9iwZ3BIUNNzd5ymYS36zpZJ90GBAq4WQWnfvm79alcvWacKkiq0zZwYXc6AIUC95+rDyM+Pll8YkyaqO9aGee0bMAyT2zmlhrtZrZ0KeuHRy7C0ARJFs1IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g+bjztS/6vJwT0O0RAzLFlqabXhUpXXiyiK6O/MCCdA=;
 b=sTahCCtK5S+nZDllaajvvbsYPQg3PRMMqUZF6K+4exkhQcqRW6wNWq0z5IsyRFOqXm0TgZpCP8EWqVTcRcmWZcNk34J0lH3ROa0nSoauLRYM03SdQAKWGqSegyl18EutGI3iTDxRJ8o+EnTVoO0QRb/yEaixEldegvilZ4/rXs0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB8125.eurprd04.prod.outlook.com (2603:10a6:102:1cc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Mon, 11 Sep
 2023 22:09:48 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::aa90:117d:c1d0:346a]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::aa90:117d:c1d0:346a%3]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 22:09:47 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     manivannan.sadhasivam@linaro.org
Cc:     Frank.li@nxp.com, aisheng.dong@nxp.com, bhelgaas@google.com,
        devicetree@vger.kernel.org, festevam@gmail.com,
        imx@lists.linux.dev, jdmason@kudzu.us, kernel@pengutronix.de,
        kishon@kernel.org, kw@linux.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com, lpieralisi@kernel.org, maz@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org, tglx@linutronix.de
Subject: [PATCH v2 1/5] PCI: endpoint: Add RC-to-EP doorbell support using platform MSI controller
Date:   Mon, 11 Sep 2023 18:09:16 -0400
Message-Id: <20230911220920.1817033-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230911220920.1817033-1-Frank.Li@nxp.com>
References: <20230911220920.1817033-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0010.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::23) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PAXPR04MB8125:EE_
X-MS-Office365-Filtering-Correlation-Id: defeff76-23ec-4301-9d8d-08dbb313cfef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lprMpiLy3lfhuL9aWimIP0hW31Rd7stM6KetKarLdtW8i7Ex/N5pM1o5/hh4c5hx0GQOjEn/A6cTfrUR3POD3jzeHRmtyJLJf2lMYxSaLRIth01USa16LKQ2lethX32lJfbmM4nP0+UGjn+VZRXJS1pD5dQNOYHkB16KBRswIdTYalSG9W9zS3ksEzNuy3yCe+0WloUjw1VkmvTc3nyKUvUOqzYBxDrjdBrhiX8EJjQzP5ErwytKMYEsJVS881KN1bBcDhDqg5Q0k6upAENOU4hM1AlrO7F/aE2GPS8XTOEelUpTWAoJxOuCqT3CgJ/lxhVJR6iU7QsAZUPAg3byAlCE9i9LLh6f+7ZH2NE54FzkzRm3K14f9NY58QTdwAvdTRPf5dQBKKQnQjyyViJKkexXXmYl6CYQxCjy2v3BjX7W68gDFK/cxtIw/hnAyDpw4VP19jFYi2wEYewC4cTaee1O6Y8CGzen+XssWojzHgrIS2+37PKAyBQHZuZPXv1FLGt+RkS8nJD4lzvnSPB/Bhu8/YMQlatnoHdv2cNqLltm6qX6PAHEgQThsRyvOEHKq5BMGK6y4c7Hi9qcrfj0G2Vnu2sCRr6yuGIp5mJGOLeBAX+lMffOsOjaWAr+KPP4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(136003)(396003)(346002)(1800799009)(186009)(451199024)(6512007)(26005)(1076003)(86362001)(30864003)(2906002)(83380400001)(6486002)(2616005)(52116002)(6506007)(6666004)(7416002)(38350700002)(478600001)(38100700002)(36756003)(5660300002)(8676002)(8936002)(66476007)(66556008)(4326008)(6916009)(316002)(66946007)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RHPr7vHg0qxX3txC6ASjwmwVtiJG9pff8fCyTdV6R/71sNPe7OSH7onXrvvV?=
 =?us-ascii?Q?1zXtj4bVEYwQ5zYTrRRW+qQ58GAMbMxAgGajjD7WF5p20o4QPyLp0ImrtN6Z?=
 =?us-ascii?Q?J8bZGj14KpwSgvgYVPlnxYLqhPPwmoC4Sb/XXMTjVjO8irwj3XFamUUbIyrk?=
 =?us-ascii?Q?qdpqLscbO2n87j9XKYN+KYzmPOnj+zojmQHi8FuxGquikSd3J1VwBaTcMxrp?=
 =?us-ascii?Q?CUUykVPakmj01UqXjiaZ2xhNWJMdS3GgF9cFnPxVq1y8Vg8jj5q5vqopBQBa?=
 =?us-ascii?Q?ldHPJ4m8B+pzeWkw5dXqWKcHH8dCdDsL1Ba8/6YaMJHxFAyfIaB0p50NKoaA?=
 =?us-ascii?Q?OndzpuaOWflp0mWvnVYS/pluh37hQeIX6hd+y1jbiPl853iE3OExZfrDSyUQ?=
 =?us-ascii?Q?hrys7zItFPs1s8kEuJvT8tveObN+eUbq+bJ7I4OuX7c38dy04dGhRMMlv1RO?=
 =?us-ascii?Q?La8LuCmx+z07TjYJmGkC8wTj0is63uKrbh9uFc5TkVJjNSRGLkCSZlNF2TW8?=
 =?us-ascii?Q?EIo/WG/+LR6MXnteG6nEgtWxHmn2UaN1HMkAjNlZcRLV7OKBeukZZ2gHN8Dn?=
 =?us-ascii?Q?IZDsFU07cmURtMzjLEFnum9RJPc5FcRLRcq1qN6lrzMuT9qJiXYEM/CFod43?=
 =?us-ascii?Q?H8AqETV55dLq+DqDAxkwHIXXqP8nRfVrzt2dX/FsMJblUk3iauLjmR18qA8u?=
 =?us-ascii?Q?UpX4aL9HhTwl99EMEnzm6mfXQ3OfHXz/VzHsEH8HMb9WLHyjVXwqbhsgBqxJ?=
 =?us-ascii?Q?MMq1ZkgRWXzHqPCSTQ1FWeh/dZKQxp874wC14fvCOXrb/68Ko9c6qIBF99b8?=
 =?us-ascii?Q?36IXvvqEFwhqJ1pgS8gzjBhkBWJWWPF0L3s8avqcBDpuIDBmkoa92KkrG5L3?=
 =?us-ascii?Q?jV5mnJaQPSlc71UzxxaJ4kOr2n9b1QTKx5wfLYrLz72cVUis1SAIKTHB8svE?=
 =?us-ascii?Q?Rf4JYpg8INLZl2hqLHGcQzfLe09kJiwlJVp8tvcSyCEfiKSKi0YvnAiaKRIB?=
 =?us-ascii?Q?Ch9Som2y9epLNoyt9SYyWfYcksNMD+VaCbGnomiTMitsgm9YACLPGeaMSHeS?=
 =?us-ascii?Q?v/r2OnjGEWlQohQmuaut3O/AJkLBRPNqLfYfzFyCxsqgACr14qcZLmkJw3jn?=
 =?us-ascii?Q?lWpn8EgkY6jL6ST1sefvDcm5a/On4qk/zmHlezAi1+ydEtr79FjqF+Npq/z6?=
 =?us-ascii?Q?u/MzmuFPKDprLqKQzpBhH6PV2TjNJUBkW9ntlqUovYx+O9tZxzZDWFYnzqyZ?=
 =?us-ascii?Q?58Ml032W6Ysl6oGsiJMqMhP6fk8Vc2EcHOdJ/ySABeb9zd7fBW6Tjs8fctEb?=
 =?us-ascii?Q?t/1YvRsyJ5W/BznqJbr4fsXV5jnrKoQLYfLvkET3sIP8DROS9J2sT5ZOTfSD?=
 =?us-ascii?Q?IhsgBetlCRBSxM77kOVX7z8r5zRKjRWCaGm/q5/3IhYu6mGtOFM6JxptWfJv?=
 =?us-ascii?Q?OItZQyCVEV9aBsZ5QFOgDoVezkjOJwwwsAK99oegzUzHU9IVwrotMT1jEtX/?=
 =?us-ascii?Q?hUg/KzMidx4GovftQI0lNTOpgoqTBZlnw6XZkHkn5EZqjjcAZX1TYNySdfyj?=
 =?us-ascii?Q?9JTi/x4PjjeM9UF5Di2274FNJkHH+5YK+eUQ3KtV?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: defeff76-23ec-4301-9d8d-08dbb313cfef
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 22:09:47.8851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jRuUPpgkwk9/49haExCk5Z66DgNC8GcGERZpdDwm0JFvOsi605XaMGJhpy8x+RrYyoc6yyPhB3km+ta2RMLUtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8125
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,T_SPF_PERMERROR autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This commit introduces a common method for sending messages from the Root
Complex (RC) to the Endpoint (EP) by utilizing the platform MSI interrupt
controller, such as ARM GIC, as an EP doorbell. Maps the memory assigned
for the BAR region by the PCI host to the message address of the platform
MSI interrupt controller in the PCI EP. As a result, when the PCI RC writes
to the BAR region, it triggers an IRQ at the EP. This implementation serves
as a common method for all endpoint function drivers.

However, it currently supports only one EP physical function due to
limitations in ARM MSI/IMS readiness.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/endpoint/pci-epc-core.c | 192 ++++++++++++++++++++++++++++
 drivers/pci/endpoint/pci-epf-core.c |  44 +++++++
 include/linux/pci-epc.h             |   6 +
 include/linux/pci-epf.h             |   7 +
 4 files changed, 249 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 5a4a8b0be6262..d336a99c6a94f 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -10,6 +10,7 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 
+#include <linux/msi.h>
 #include <linux/pci-epc.h>
 #include <linux/pci-epf.h>
 #include <linux/pci-ep-cfs.h>
@@ -783,6 +784,197 @@ void pci_epc_bme_notify(struct pci_epc *epc)
 }
 EXPORT_SYMBOL_GPL(pci_epc_bme_notify);
 
+/**
+ * pci_epc_alloc_doorbell() - alloc an address space to let RC trigger EP side IRQ by write data to
+ *			      the space.
+ *
+ * @epc: the EPC device that need doorbell address and data from RC.
+ * @func_no: the physical endpoint function number in the EPC device.
+ * @vfunc_no: the virtual endpoint function number in the physical function.
+ * @num_msgs: the total number of doorbell messages
+ *
+ * Return: 0 success, other is failure
+ */
+int pci_epc_alloc_doorbell(struct pci_epc *epc, u8 func_no, u8 vfunc_no, int num_msgs)
+{
+	int ret;
+
+	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
+		return -EINVAL;
+
+	if (vfunc_no > 0 && (!epc->max_vfs || vfunc_no > epc->max_vfs[func_no]))
+		return -EINVAL;
+
+	if (!epc->ops->alloc_doorbell)
+		return 0;
+
+	mutex_lock(&epc->lock);
+	ret = epc->ops->alloc_doorbell(epc, func_no, vfunc_no, num_msgs);
+	mutex_unlock(&epc->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pci_epc_alloc_doorbell);
+
+/**
+ * pci_epc_free_doorbell() - free resource allocated by pci_epc_alloc_doorbell()
+ *
+ * @epc: the EPC device that need doorbell address and data from RC.
+ * @func_no: the physical endpoint function number in the EPC device.
+ * @vfunc_no: the virtual endpoint function number in the physical function.
+ *
+ * Return: 0 success, other is failure
+ */
+void pci_epc_free_doorbell(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
+{
+	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
+		return;
+
+	if (vfunc_no > 0 && (!epc->max_vfs || vfunc_no > epc->max_vfs[func_no]))
+		return;
+
+	if (!epc->ops->free_doorbell)
+		return;
+
+	mutex_lock(&epc->lock);
+	epc->ops->free_doorbell(epc, func_no, vfunc_no);
+	mutex_unlock(&epc->lock);
+}
+EXPORT_SYMBOL_GPL(pci_epc_free_doorbell);
+
+static irqreturn_t pci_epf_generic_doorbell_handler(int irq, void *data)
+{
+	struct pci_epf *epf = data;
+
+	if (epf->event_ops && epf->event_ops->doorbell)
+		epf->event_ops->doorbell(epf, irq - epf->virq_base);
+
+	return IRQ_HANDLED;
+}
+
+static void pci_epc_generic_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
+{
+	struct pci_epc *epc = NULL;
+	struct class_dev_iter iter;
+	struct pci_epf *epf;
+	struct device *dev;
+
+	class_dev_iter_init(&iter, pci_epc_class, NULL, NULL);
+	while ((dev = class_dev_iter_next(&iter))) {
+		if (dev->parent != desc->dev)
+			continue;
+
+		epc = to_pci_epc(dev);
+
+		class_dev_iter_exit(&iter);
+		break;
+	}
+
+	if (!epc)
+		return;
+
+	/* Only support one EPF for doorbell */
+	epf = list_first_entry_or_null(&epc->pci_epf, struct pci_epf, list);
+
+	if (!epf)
+		return;
+
+	if (epf->msg && desc->msi_index < epf->num_msgs)
+		epf->msg[desc->msi_index] = *msg;
+}
+
+
+/**
+ * pci_epc_generic_alloc_doorbell() - Common help function. Allocate address space from MSI
+ *                                    controller
+ *
+ * @epc: the EPC device that need doorbell address and data from RC.
+ * @func_no: the physical endpoint function number in the EPC device.
+ * @vfunc_no: the virtual endpoint function number in the physical function.
+ * @num_msgs: the total number of doorbell messages
+ *
+ * Remark: use this function only if EPC driver just register one EPC device.
+ *
+ * Return: 0 success, other is failure
+ */
+int pci_epc_generic_alloc_doorbell(struct pci_epc *epc, u8 func_no, u8 vfunc_no, int num_msgs)
+{
+	struct pci_epf *epf;
+	struct device *dev;
+	int virq, last;
+	int ret;
+	int i;
+
+	if (IS_ERR_OR_NULL(epc))
+		return -EINVAL;
+
+	/* Currently only support one func and one vfunc for doorbell */
+	if (func_no || vfunc_no)
+		return -EINVAL;
+
+	epf = list_first_entry_or_null(&epc->pci_epf, struct pci_epf, list);
+	if (!epf)
+		return -EINVAL;
+
+	dev = epc->dev.parent;
+	ret = platform_msi_domain_alloc_irqs(dev, num_msgs, pci_epc_generic_write_msi_msg);
+	if (ret) {
+		dev_err(dev, "Failed to allocate MSI\n");
+		return -ENOMEM;
+	}
+
+	last = -1;
+	for (i = 0; i < num_msgs; i++) {
+		virq = msi_get_virq(dev, i);
+		if (i == 0)
+			epf->virq_base = virq;
+
+		ret = request_irq(virq, pci_epf_generic_doorbell_handler, 0,
+				  kasprintf(GFP_KERNEL, "pci-epc-doorbell%d", i), epf);
+
+		if (ret) {
+			dev_err(dev, "Failed to request doorbell\n");
+			goto err_free_irq;
+		}
+		last = i;
+	}
+
+	return 0;
+
+err_free_irq:
+	for (i = 0; i < last; i++)
+		kfree(free_irq(epf->virq_base + i, epf));
+	platform_msi_domain_free_irqs(dev);
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(pci_epc_generic_alloc_doorbell);
+
+/**
+ * pci_epc_generic_free_doorbell() - Common help function. Free resource created by
+ *				     pci_epc_generic_alloc_doorbell()
+ *
+ * @epc: the EPC device that need doorbell address and data from RC.
+ * @func_no: the physical endpoint function number in the EPC device.
+ * @vfunc_no: the virtual endpoint function number in the physical function.
+ * @num_msgs: the total number of doorbell messages
+ */
+void pci_epc_generic_free_doorbell(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
+{
+	struct pci_epf *epf;
+	int i;
+
+	epf = list_first_entry_or_null(&epc->pci_epf, struct pci_epf, list);
+	if (!epf)
+		return;
+
+	for (i = 0; i < epf->num_msgs; i++)
+		kfree(free_irq(epf->virq_base + i, epf));
+
+	platform_msi_domain_free_irqs(epc->dev.parent);
+}
+EXPORT_SYMBOL_GPL(pci_epc_generic_free_doorbell);
+
 /**
  * pci_epc_destroy() - destroy the EPC device
  * @epc: the EPC device that has to be destroyed
diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index 2c32de6679377..eab82c6b0119a 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -10,6 +10,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/slab.h>
 #include <linux/module.h>
+#include <linux/msi.h>
 
 #include <linux/pci-epc.h>
 #include <linux/pci-epf.h>
@@ -300,6 +301,49 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
 }
 EXPORT_SYMBOL_GPL(pci_epf_alloc_space);
 
+int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_msgs)
+{
+	struct pci_epc *epc;
+	struct device *dev;
+	int ret;
+
+	epc = epf->epc;
+	dev = &epc->dev;
+
+	epf->msg = kcalloc(num_msgs, sizeof(struct msi_msg), GFP_KERNEL);
+	if (!epf->msg)
+		return -ENOMEM;
+
+	epf->num_msgs = num_msgs;
+
+	ret = pci_epc_alloc_doorbell(epc, epf->func_no, epf->vfunc_no, num_msgs);
+	if (ret)
+		goto err_free_mem;
+
+	return ret;
+
+err_free_mem:
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
+
+	epc = epf->epc;
+	pci_epc_free_doorbell(epc, epf->func_no, epf->vfunc_no);
+
+	kfree(epf->msg);
+	epf->msg = NULL;
+	epf->num_msgs = 0;
+}
+EXPORT_SYMBOL_GPL(pci_epf_free_doorbell);
+
 static void pci_epf_remove_cfs(struct pci_epf_driver *driver)
 {
 	struct config_group *group, *tmp;
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index 5cb6940310729..605fb0debd6bc 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -88,6 +88,8 @@ struct pci_epc_ops {
 	void	(*stop)(struct pci_epc *epc);
 	const struct pci_epc_features* (*get_features)(struct pci_epc *epc,
 						       u8 func_no, u8 vfunc_no);
+	int	(*alloc_doorbell)(struct pci_epc *epc, u8 func_no, u8 vfunc_no, int num_msgs);
+	void	(*free_doorbell)(struct pci_epc *epc, u8 func_no, u8 vfunc_no);
 	struct module *owner;
 };
 
@@ -251,4 +253,8 @@ void __iomem *pci_epc_mem_alloc_addr(struct pci_epc *epc,
 				     phys_addr_t *phys_addr, size_t size);
 void pci_epc_mem_free_addr(struct pci_epc *epc, phys_addr_t phys_addr,
 			   void __iomem *virt_addr, size_t size);
+int pci_epc_alloc_doorbell(struct pci_epc *epc, u8 func_no, u8 vfunc_no, int num_msgs);
+void pci_epc_free_doorbell(struct pci_epc *epc, u8 func_no, u8 vfunc_no);
+int pci_epc_generic_alloc_doorbell(struct pci_epc *epc, u8 func_no, u8 vfunc_no, int num_msgs);
+void pci_epc_generic_free_doorbell(struct pci_epc *epc, u8 func_no, u8 vfunc_no);
 #endif /* __LINUX_PCI_EPC_H */
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index 3f44b6aec4770..485c146a5efe2 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -79,6 +79,7 @@ struct pci_epc_event_ops {
 	int (*link_up)(struct pci_epf *epf);
 	int (*link_down)(struct pci_epf *epf);
 	int (*bme)(struct pci_epf *epf);
+	int (*doorbell)(struct pci_epf *epf, int index);
 };
 
 /**
@@ -180,6 +181,9 @@ struct pci_epf {
 	unsigned long		vfunction_num_map;
 	struct list_head	pci_vepf;
 	const struct pci_epc_event_ops *event_ops;
+	struct msi_msg *msg;
+	u16 num_msgs;
+	int virq_base;
 };
 
 /**
@@ -223,4 +227,7 @@ int pci_epf_bind(struct pci_epf *epf);
 void pci_epf_unbind(struct pci_epf *epf);
 int pci_epf_add_vepf(struct pci_epf *epf_pf, struct pci_epf *epf_vf);
 void pci_epf_remove_vepf(struct pci_epf *epf_pf, struct pci_epf *epf_vf);
+int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 nums);
+void pci_epf_free_doorbell(struct pci_epf *epf);
+
 #endif /* __LINUX_PCI_EPF_H */
-- 
2.34.1

