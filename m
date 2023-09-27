Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D88B7B0D4C
	for <lists+linux-pci@lfdr.de>; Wed, 27 Sep 2023 22:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjI0UYD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Sep 2023 16:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjI0UYC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Sep 2023 16:24:02 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2139.outbound.protection.outlook.com [40.107.243.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58641114;
        Wed, 27 Sep 2023 13:23:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bRu1oCSWM/p+mFRQ9USlVB3QAh+yJwd0MSioqIUCO8yJyJAXzm0M11D2tvC069NlAaomeZ+jaBIuT3l6ZH98J2OllDzePaS39tmi7ndRkO8CLdv32k0XJ8dJEF3K7bN6iqKhbmOhTcfCKczbG70lNw3ZzuWB++LI9TjURkRxP2g/HFuwVklNHoYpIA7jlsquXfsmq9Df2Cq3qb6qGXFY0gUBJpCrJ69d4osMc1h9IsN3lJKCzL8V4sST759hIGJ2K9ytKuvbzp33fSQ7UTIq37Wl3Yx7r+ZX1ooTLKIoOx5UqfFNCOXz6E27TfAy/cUcRlS37mAkDZhzMo1Qo+oBAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qbKU1GjOLTQDVUIlelhyFEemMAoKzGfyudOdVMGrRb4=;
 b=NsrXYEHl/T1F6ncLSAlaxReaZZj82hT9JFRxWPQH+Tm5sTi9wSdtvu4dkmcPHssmEJL1QySW6GHMYNHg/pnzR2wOcFTXf6Y3XfU5xOV0Qk5HmgBLyzodOeMJev7T4Adv4xTiFTxt1xymxNayGVfkgTfj7+FyfK7/CFzlkF63pAYHpBu+grzC2ChVeSiIb1pEq0iRpkBFoYLHGmNoRM4I5+LxWe0BFpVeAILetZ5nqPPfmlPaUiVPktc6hH/3NJryV61j/zTd+uJrEa1z05usGgN+M/Rq0lCKOPPQXeyxQmA63TiUFt1DWnK2aEWhC/+ValiC5iN3JAsE1l+6Tu3yog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qbKU1GjOLTQDVUIlelhyFEemMAoKzGfyudOdVMGrRb4=;
 b=nNsomyitzxjlfXWJ2ptNnIbGoXUV8RwOwJLZ70bgRAPXThp82AvxVIjGSbOzDb5DCWUFz2Ko8Luud1KY3dBllH8i7MwN2Syg+5bUtW/pep5q1Qkvi68KeFIAL/G62iHaV52AX4xgv/5CQ4QVnObB9QdpjmdwGosQQ+XnuQKC47M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MWHPR0101MB2893.prod.exchangelabs.com (2603:10b6:301:33::25) by
 BY3PR01MB6675.prod.exchangelabs.com (2603:10b6:a03:360::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.28; Wed, 27 Sep 2023 20:23:55 +0000
Received: from MWHPR0101MB2893.prod.exchangelabs.com
 ([fe80::ac16:89d:a480:ed6e]) by MWHPR0101MB2893.prod.exchangelabs.com
 ([fe80::ac16:89d:a480:ed6e%4]) with mapi id 15.20.6813.017; Wed, 27 Sep 2023
 20:23:54 +0000
From:   D Scott Phillips <scott@os.amperecomputing.com>
To:     linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Len Brown <lenb@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Darren Hart <darren@os.amperecomputing.com>,
        patches@amperecomputing.com
Subject: [PATCH] PCI: hotplug: Add extension driver for Ampere Altra hotplug LED control
Date:   Wed, 27 Sep 2023 13:23:47 -0700
Message-ID: <20230927202347.2795170-1-scott@os.amperecomputing.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0349.namprd03.prod.outlook.com
 (2603:10b6:610:11a::33) To MWHPR0101MB2893.prod.exchangelabs.com
 (2603:10b6:301:33::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR0101MB2893:EE_|BY3PR01MB6675:EE_
X-MS-Office365-Filtering-Correlation-Id: d9f63c02-0c63-4587-652f-08dbbf97aa56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3pB/+QU3/8VcxdhaQNnF1wVhIvVO+Yzubz9fP5tBWZjAF3vId8gYtrEQlghx1oNHuEGPoujy9EpcQnDlMXpdctK/qo+PJrt3AcyEsMBovK51rhqaWYFv47QbjFePMa/F7LDDbkU9oTAN2I7fD2tS5s5XOzOwT5FD5ZHTF/hfVLdHUKLtx1qBr8oEipxrzvkPapN2uAkL/BlrwtQDMF/fsdFVAnmzz91e7Wcs6aY6npU7qvgz1ciYP9y0Cbdghle8yxGXnJfDOlE9NvdUUnjvC6Hhrj2tG3Q+v6xIqd9QUn9an4pewIKYqo13XxkV2mZVMCTU3PtLAEtT4xVPGDBywuGXaz2Uo+iFBrEwpGZrVLAevgtifWK5GJfHZ88LaaiRqDYuyidfde3T+EbhiqlQoolgI0rlKnTutbrdnIIehcBoxFGI3IQflvgGe27I+Ubg8082IJC9Qd6QnueWkeTc4hNDDvLWwyupZmmWOWGt5Ii8vhz0T/K49LEy1t97gi+qwpG0gF0AA7+1PXUy6bie8Pkfcb8O8g7VxvwjRvzs1XGlzclZEhBd9AxRm1dU5an/z/AKBrhWWOqnleMDtgCzgr6L6ZVcFjHWUdOfVRIleUeg3MKSkWavO4dISNsG3UYl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR0101MB2893.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(376002)(346002)(136003)(366004)(396003)(230922051799003)(451199024)(186009)(1800799009)(8676002)(8936002)(41300700001)(2906002)(26005)(110136005)(4326008)(478600001)(66476007)(316002)(66946007)(5660300002)(66556008)(6506007)(6666004)(52116002)(6486002)(6512007)(1076003)(2616005)(86362001)(107886003)(83380400001)(38100700002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WTew6im/hpXKLOELe08PHL37DxAjfRMXPrNKGj2RBj9627QbD44rzMhFBgZf?=
 =?us-ascii?Q?VBOyAwkFy5ILk6N3ILOC5wxN7A9PN09SG7sm6o7fIIJpJbfan1qmdvxBituu?=
 =?us-ascii?Q?+6MJH/FcMZm9mM62WRlBN2E4nr9utHNkVRQ4jAUlfQ05In7ilzIbTJoIYClu?=
 =?us-ascii?Q?59M1/dRWLNnf3Ea7Bjmy5r4W0kBZbE2fm6rvj53b306Ue9HIEJqhtCiifxhW?=
 =?us-ascii?Q?yfyW/Fk7V7bnv2Ty1xO7a8FE4O71+kvfJd95RKj9Mf70eL0+8xI7JkECrUgG?=
 =?us-ascii?Q?eDKe0dYM28rhyW68ycUqHBU1crkySvLgKcuGNU6OsmE0N4pTrJxMK/ZpxpGU?=
 =?us-ascii?Q?3O/K875QdNQPFsLXGdEhVSVEDTxNBsx22nlgmSXl1CWHztJQaLFcjCuk4NIX?=
 =?us-ascii?Q?2OBxjzZmtacfPUu8HfsDYwn0dlZIFZ4AmboS6EQCUTArSfzDu2TWdH+mujxb?=
 =?us-ascii?Q?lNkMaMqJ8aINKepgwuXZD3JHdcjF62DLOH3Vv+y8DanIsyDnfieC5UlFDSIR?=
 =?us-ascii?Q?iGYZtTZuW/T8TUF/6JvsKwI9FHK+kCtCij6otyH5uc69RIN4seriz5Rmx2TA?=
 =?us-ascii?Q?hfYeaIh0CKTx2Rmzwas2oLgfitRrlPaBNGDI1wmdDXPd+7LpJGAIhbwLb0n+?=
 =?us-ascii?Q?GCN94FpkRoS/8hH3MlAEbA+Bl6zfVbtXgGZX9ah1ZsjenD1FpUBumb9c3otA?=
 =?us-ascii?Q?mX0FjRNktaU06Wt2zCDSm1sNHBwZICcirri0+yiemIK6moJrzYhVpBrl9VpB?=
 =?us-ascii?Q?ZXm7VeVFKP7sj8QztaKcWNEJg6WjAD8IdjOZ+F+E87PhbFZ+GzWeWg7wUQyL?=
 =?us-ascii?Q?6VEIwfUM7SKtEK7zNIF1Ln1xmH3G2xMfDo2QNihXcOALWYIWJQapA9LUqWdL?=
 =?us-ascii?Q?NJl1yOO46mRANL4/fDdpSVmvPrFi2cMLUGS+8FoSLpRV/Y5LIft57/GCxNlp?=
 =?us-ascii?Q?gDuYhl2Ut9dW17Dchio8cYPd3C4uTZ/pQfwof7LHbXGbYcpQvqtBIUeMDfx8?=
 =?us-ascii?Q?J1tA+4dGUycToc+2VNT2obpv1PHD+M/L9rSSnCMwNNmvstfUCKq4a909PkLD?=
 =?us-ascii?Q?F0q9tLUrlPHEWH7NLcoZIcMpQ6AJkW0cT3bghRmi/d32nIvLit2cEFdGF49e?=
 =?us-ascii?Q?xQ8/YolNYayYa6z78g3+metyNdHxZl+ahPyghcunYS8pN++AipuFsv1lMINJ?=
 =?us-ascii?Q?74uPFpVyoI7kJd5JJfspTPhhf2XTgwvQh6CdM+M1T+tXMrIUzW4rNZOoc3e5?=
 =?us-ascii?Q?pXMoNBx8uANbZwlv1yIgPWg9f3OaTqooicrr1cIvpWUSCP/QE8glhn6Pyg+Z?=
 =?us-ascii?Q?qJ+OyUaZ3IE/DwWKYrMlERT4rQE3BAJVhRUvl4C0h6xtDQIZNdXjWrapyPB8?=
 =?us-ascii?Q?4jN10OR89zvA6IhsHqfZsvRetDWCYH967nRde+nlhvRA+poAzT0IAvxmKF/i?=
 =?us-ascii?Q?64YOC8mPWCuF4EQ0tEahALSnzlu4grUn7QMysgsi/ucFmBy+ZNCDwt1HuIcW?=
 =?us-ascii?Q?IW4XPqTgwt5YACscHZYLwGVHXHP2hiB3xZFuIpovlm7M74jJN26+PF32KkD5?=
 =?us-ascii?Q?sjFAGYRVy63UU6xjZB4uAddh8SFZ+M/arB2RL+7+cepmtC3eTkZaFhDf8Y2Z?=
 =?us-ascii?Q?o1+ZOiYfB3km/RQ+VWfhuzc=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9f63c02-0c63-4587-652f-08dbbf97aa56
X-MS-Exchange-CrossTenant-AuthSource: MWHPR0101MB2893.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 20:23:54.8548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ICicXavpKeHmoCepMIOVIpEkEsdVvAHUXoBSowYwn+dEpd0rt5LppI+CxCvwpzydj+tJFzeEoU5/8LVK7Kvu1KWoT4b7Ls9XcKsNBvqnZdALbz4djop9xj8tVHOLcai
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR01MB6675
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Ampere Altra, PCIe hotplug is handled through ACPI. A side interface is
also present to request system firmware control of attention LEDs. Add an
ACPI PCI Hotplug companion driver to support attention LED control.

Signed-off-by: D Scott Phillips <scott@os.amperecomputing.com>
---
 drivers/pci/hotplug/Kconfig                |  13 ++
 drivers/pci/hotplug/Makefile               |   3 +-
 drivers/pci/hotplug/acpiphp_ampere_altra.c | 141 +++++++++++++++++++++
 3 files changed, 156 insertions(+), 1 deletion(-)
 create mode 100644 drivers/pci/hotplug/acpiphp_ampere_altra.c

diff --git a/drivers/pci/hotplug/Kconfig b/drivers/pci/hotplug/Kconfig
index 48113b210cf93..9fde600a9ad3e 100644
--- a/drivers/pci/hotplug/Kconfig
+++ b/drivers/pci/hotplug/Kconfig
@@ -61,6 +61,19 @@ config HOTPLUG_PCI_ACPI
 
 	  When in doubt, say N.
 
+config HOTPLUG_PCI_ACPI_AMPERE_ALTRA
+	tristate "ACPI PCI Hotplug driver Ampere Altra extensions"
+	depends on HOTPLUG_PCI_ACPI
+	depends on HAVE_ARM_SMCCC_DISCOVERY
+	depends on m
+	help
+	  Say Y here if you have an Ampere Altra system.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called acpiphp_ampere_altra.
+
+	  When in doubt, say N.
+
 config HOTPLUG_PCI_ACPI_IBM
 	tristate "ACPI PCI Hotplug driver IBM extensions"
 	depends on HOTPLUG_PCI_ACPI
diff --git a/drivers/pci/hotplug/Makefile b/drivers/pci/hotplug/Makefile
index 5196983220df6..29d7f6171b305 100644
--- a/drivers/pci/hotplug/Makefile
+++ b/drivers/pci/hotplug/Makefile
@@ -21,8 +21,9 @@ obj-$(CONFIG_HOTPLUG_PCI_RPA_DLPAR)	+= rpadlpar_io.o
 obj-$(CONFIG_HOTPLUG_PCI_ACPI)		+= acpiphp.o
 obj-$(CONFIG_HOTPLUG_PCI_S390)		+= s390_pci_hpc.o
 
-# acpiphp_ibm extends acpiphp, so should be linked afterwards.
+# acpiphp_ibm extend acpiphp, so should be linked afterwards.
 
+obj-$(CONFIG_HOTPLUG_PCI_ACPI_AMPERE_ALTRA)	+= acpiphp_ampere_altra.o
 obj-$(CONFIG_HOTPLUG_PCI_ACPI_IBM)	+= acpiphp_ibm.o
 
 pci_hotplug-objs	:=	pci_hotplug_core.o
diff --git a/drivers/pci/hotplug/acpiphp_ampere_altra.c b/drivers/pci/hotplug/acpiphp_ampere_altra.c
new file mode 100644
index 0000000000000..8692b939dea78
--- /dev/null
+++ b/drivers/pci/hotplug/acpiphp_ampere_altra.c
@@ -0,0 +1,141 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ACPI PCI Hot Plug Ampere Altra Extension
+ *
+ * Copyright (C) 2023 Ampere Computing LLC
+ *
+ */
+
+#define pr_fmt(fmt) "acpiphp_ampere_altra: " fmt
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/pci_hotplug.h>
+
+#include "acpiphp.h"
+
+#define HANDLE_OPEN	0xb0200000
+#define HANDLE_CLOSE	0xb0300000
+#define REQUEST		0xf0700000
+#define LED_CMD		0x00000004
+#define LED_ATTENTION	0x00000002
+#define LED_SET_ON	0x00000001
+#define LED_SET_OFF	0x00000002
+#define LED_SET_BLINK	0x00000003
+
+static const struct acpi_device_id acpi_ids[] = {
+	{"AMPC0008", 0}, {}
+};
+MODULE_DEVICE_TABLE(acpi, acpi_ids);
+
+static u32 led_service_id[4];
+
+static int led_status(u8 status)
+{
+	switch (status) {
+	case 1: return LED_SET_ON;
+	case 2: return LED_SET_BLINK;
+	default: return LED_SET_OFF;
+	}
+}
+
+static int set_attention_status(struct hotplug_slot *slot, u8 status)
+{
+	struct arm_smccc_res res;
+	struct pci_bus *bus;
+	struct pci_dev *root_port;
+	unsigned long flags;
+	u32 handle;
+	int ret = 0;
+
+	bus = slot->pci_slot->bus;
+	root_port = pcie_find_root_port(bus->self);
+	if (!root_port)
+		return -ENODEV;
+
+	local_irq_save(flags);
+	arm_smccc_smc(HANDLE_OPEN, led_service_id[0], led_service_id[1],
+		      led_service_id[2], led_service_id[3], 0, 0, 0, &res);
+	if (res.a0) {
+		ret = -ENODEV;
+		goto out;
+	}
+	handle = res.a1 & 0xffff0000;
+
+	arm_smccc_smc(REQUEST, LED_CMD, led_status(status), LED_ATTENTION,
+		      pci_domain_nr(bus) | ((root_port->devfn >> 3) << 4), 0, 0,
+		      handle, &res);
+	if (res.a0)
+		ret = -ENODEV;
+
+	arm_smccc_smc(HANDLE_CLOSE, handle, 0, 0, 0, 0, 0, 0, &res);
+
+ out:
+	local_irq_restore(flags);
+	return ret;
+}
+
+static int get_attention_status(struct hotplug_slot *slot, u8 *status)
+{
+	return -EINVAL;
+}
+
+static struct acpiphp_attention_info ampere_altra_attn = {
+	.set_attn = set_attention_status,
+	.get_attn = get_attention_status,
+	.owner = THIS_MODULE,
+};
+
+static acpi_status __init get_acpi_handle(acpi_handle handle, u32 level,
+					  void *context, void **return_value)
+{
+	*(acpi_handle *)return_value = handle;
+	return AE_CTRL_TERMINATE;
+}
+
+static int __init acpiphp_ampere_altra_init(void)
+{
+	struct fwnode_handle *fwnode;
+	acpi_handle leds_handle = NULL;
+	struct acpi_device *leds;
+	acpi_status status;
+	int ret;
+
+	status = acpi_get_devices("AMPC0008", get_acpi_handle, NULL,
+				  &leds_handle);
+	if (ACPI_FAILURE(status) || !leds_handle)
+		return -ENODEV;
+	leds = acpi_get_acpi_dev(leds_handle);
+	if (!leds) {
+		pr_err("can't find device\n");
+		return -ENODEV;
+	}
+
+	fwnode = acpi_fwnode_handle(leds);
+	ret = fwnode_property_read_u32_array(fwnode, "uuid", led_service_id, 4);
+	acpi_put_acpi_dev(leds);
+	if (ret) {
+		pr_err("can't find uuid\n");
+		return -ENODEV;
+	}
+
+	if (acpiphp_register_attention(&ampere_altra_attn)) {
+		pr_err("can't register driver\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+module_init(acpiphp_ampere_altra_init);
+
+static void __exit acpiphp_ampere_altra_exit(void)
+{
+	acpiphp_unregister_attention(&ampere_altra_attn);
+}
+
+module_exit(acpiphp_ampere_altra_exit);
+
+MODULE_AUTHOR("D Scott Phillips <scott@os.amperecomputing.com>");
+MODULE_LICENSE("GPL");
-- 
2.41.0

