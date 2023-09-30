Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9197B3D31
	for <lists+linux-pci@lfdr.de>; Sat, 30 Sep 2023 02:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233862AbjI3AUu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Sep 2023 20:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232410AbjI3AUt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Sep 2023 20:20:49 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2111.outbound.protection.outlook.com [40.107.92.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5441A7;
        Fri, 29 Sep 2023 17:20:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=awM++BIVz7tya9x/q3/t5LUVHdDix/A3rSFfJbfOgYqOw5imoHOH3XmJZFXgvAjRNNOrLEFYcGueDlXfouRaaz5CX/3PwhFbXXUGbJ633edmrkgwaLFv3yEk/9BVcx1X/JxP7VhwMrRImx8eXgT6ELUHzcCB5hicej/05A/cWlYM4GUuyy4ZiAkHGScaXzlL0pVxEY2L9GEGZARVBdLaVjQxNrzMqysdpZ/E/ObSxmN3hR6gfychprKr9lWbsUt4Bgf4v8Vkn1IP0HpSFjE4mivWDEn5ezfBBNTQrcw/i+1QuOge/sohezFGCpEhVTUGzTVc5At6VuEZY9kAIRSUnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y25IT5lecX6hScJkoBx/p8DjppIwug3qEDDixapGhNA=;
 b=VFl8agkepFuvJpjNVXomBYUgtap/is3pYhGcF2ktB+DYIN8Nym3jElSjCpfoUeqZU7/qgxmrRkRH8e3CnMDk84jN5efPapWXdZfr5NHdUcGaM9KDGzxOrgOfOVIPdoNFFmMEbKm+UOBkczLup1p1LyQDJd3K2GMfBL4P95aZ0aY6SmZKdvM8SqSmm9KXKuo40ugG3fSrDifi5N8qoOlx20kMs7Ly3bJu3wq4DeVi3lW6lOhRirUGtUNKYXXNOVTJ2QAfi9Ds6UojDWUJIEfrzmRWe9Ub7gqDhnMH1Bkx614+cBAmmZBwzAFUFuwKxFX0sRutA4N+UJMpSBGaMuyvsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y25IT5lecX6hScJkoBx/p8DjppIwug3qEDDixapGhNA=;
 b=Xkt6A+gnZhr8+2xvyYJrJZ40iGctgqLR1oHVTfklSGJOzLo3Rl71QzVlZUC7pRUw70x44DpUfI/sNiHVsXgo3Qp3PlHHE5aZd2g94RoGmRnxWySe1pPfeBQurqoNRabVTGF65+bsKFQrpOcdmc82KpinMVQmFZpI23lLa6xIEPE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MWHPR0101MB2893.prod.exchangelabs.com (2603:10b6:301:33::25) by
 BL1PR01MB7553.prod.exchangelabs.com (2603:10b6:208:384::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.23; Sat, 30 Sep 2023 00:20:43 +0000
Received: from MWHPR0101MB2893.prod.exchangelabs.com
 ([fe80::ac16:89d:a480:ed6e]) by MWHPR0101MB2893.prod.exchangelabs.com
 ([fe80::ac16:89d:a480:ed6e%4]) with mapi id 15.20.6813.017; Sat, 30 Sep 2023
 00:20:43 +0000
From:   D Scott Phillips <scott@os.amperecomputing.com>
To:     linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>,
        Darren Hart <darren@os.amperecomputing.com>,
        patches@amperecomputing.com
Subject: [PATCH v2 2/2] PCI: hotplug: Add extension driver for Ampere Altra hotplug LED control
Date:   Fri, 29 Sep 2023 17:20:36 -0700
Message-ID: <20230930002036.6491-2-scott@os.amperecomputing.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230930002036.6491-1-scott@os.amperecomputing.com>
References: <20230930002036.6491-1-scott@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0P221CA0047.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11d::28) To MWHPR0101MB2893.prod.exchangelabs.com
 (2603:10b6:301:33::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR0101MB2893:EE_|BL1PR01MB7553:EE_
X-MS-Office365-Filtering-Correlation-Id: 24fb7b0d-e445-4e63-33e3-08dbc14b15d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IMOtCFTcih9u8EVGLJwL9OLkZoHlcXfSneB1cMRx1Zft0sXrf8vnReHn9JZl0R0ql3A1fExvd+aRUU/kdpxhEsyDI4ykJQOaiaU3DAAQ+pIThWXfs3OPrRWPO9E/yPasUE6LSWXkRcPWWpWCj0Qsntl+G4wVqHq2NEI/syirCH5JZkMmDr5iKv6Kgsba5LcIsRNOsdJMfgvFNgApzPLLS7VhAOBFwx5wCSAMyAHTuR5n6ATAMGtbYHQSRw8EVlw3cnnOA4AW0dHUjUlFlOR3+KJy1qKsHPMlmZjqWIeeok6/oaoKCYiAfgk8XUsQ/ZVdd7diOtVl7CKZnl6fdGwWrV0U0mOeAILYNZ+VTIPvG97+atsln4htNuSO96bIMa3JVSWaB8ptkYJRyh17OOjxbB9WMqlIqB8KgVjwwZEXNEwhb/Vi/VWaAmptn0wIuqLzOjWqfUCb/i/GGoP2K6zHz3soOscUFIl3NyUecvFP+POohv48SsEiSNgEZR+O2IjlwZxTjaBXHq5iist/bucxYTePK8QY5Af4HWt+xfvQK/iSI9q2AZGI1SNmz1U1muTg1TnIhs0xnMCq2l8s0DVqpqmyWhvEAuWdCYSWUKLFaZLX8joJHsqRfjm9yXngJlc3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR0101MB2893.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39850400004)(136003)(366004)(376002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(2906002)(38100700002)(38350700002)(86362001)(110136005)(66946007)(6486002)(2616005)(66556008)(4326008)(41300700001)(478600001)(66476007)(54906003)(52116002)(8676002)(6666004)(5660300002)(316002)(83380400001)(6506007)(6512007)(8936002)(107886003)(1076003)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BrGeh39pVwRown9vj0co9VoZTuBo0BCMBbrgzQ6eM+MvLWtnRzzwiOUCLDKl?=
 =?us-ascii?Q?dzSgHHYA1sDp7hOvlxgd+mx3ile1A/5wWBX+guDPMdgRXBXZn4p5CqOcZqoj?=
 =?us-ascii?Q?7gb+8APRUksU0VhIIWSZ+l5nr1DL9WhhU1+CWdGiGG9L+CWq8UPeuDVSPsco?=
 =?us-ascii?Q?4CVtNrmJfh8aTTsdLsPy2GaF1rdQIuIM8T4QzuhGZYXHSARO6d0M0zciEx/z?=
 =?us-ascii?Q?iMO3t+bidAGMqhuIIYFZpqsfmXt95Okw4kqtWQWY2dZk/cAHWo878nmBjXNV?=
 =?us-ascii?Q?9bH6x+UzSVt8nV2+J70oc4qFS+V/O5357hLUKtF73w8TePZqi3QvEaPGMoBZ?=
 =?us-ascii?Q?uBT/IjyirlkukrVz5rsVlT2ZvHPnRW+s1QYaaYOSFluxgG+dXTSdSSt9Nm3P?=
 =?us-ascii?Q?mdKDllWe0nMmgsc40Dj2M+nDRq63QA1f5DZzRjffFSaYGUp0urqVB4Xyy2pU?=
 =?us-ascii?Q?q1E5bXAlZyLn5BBHu6p3522UqJqcIZ/Uq9szR9cV0zUIR0y3KTVmp6rN75KW?=
 =?us-ascii?Q?Aq5vYCYoOMyiz5kR/AQNOIf2kdSKI1N+d1XGeQPcM+n6zmggYGCsqETCZPPW?=
 =?us-ascii?Q?HmrlwzZmsVhj4BxAJjJrLV8ZgLnmundpsbl61LZ/YuWMOd8K15LBbLlwvrQl?=
 =?us-ascii?Q?/aW/j2fFeiqCKppPfSLRVR0UHRx9iL1vo7xwctjY9VhX5xTBv9eyt9qI4CQu?=
 =?us-ascii?Q?Eer0SM4RajU7xWQDy80RXyHqk6ydzkyjk8Wn/CQvrGAFbwX+FdbUzUsntYwl?=
 =?us-ascii?Q?nNGRP0Rzry3kNIKSyVD7gfY3HFy+X33VJP8MkpQUsiLTlObf06TnHQZ+ApVS?=
 =?us-ascii?Q?oyWxd0KTVLjTugrC9AGCry6xGjt5p3B8M/2aAaddbl8bnEqAd772QgKRrDCl?=
 =?us-ascii?Q?QYG7GdYlF9d4h3slObeeKR8SkJ0sJ+dB/MlD/TbE6ea/H86IFalZNTZBmawM?=
 =?us-ascii?Q?+q0gfFzNsikl3uqbwtp/vUaA5ntOUhwGK+vBsz9DFLIOtLpicfAEhKMSyHxj?=
 =?us-ascii?Q?qyE3dDi98cTZhJYAV5TvAYsfO0FKtouBeRiTUmqemawicua9Ojcp5U26MCBW?=
 =?us-ascii?Q?cDGjleDLqF22JQN8qrbCcrrrixhvtJqn3l6r25ABA0OaK0v/Yh9lf6G+UHLx?=
 =?us-ascii?Q?YYZLlfnSdln/c6PcL681dMsy2FMoo7b3tdcgu6IQJG2Du/MBjhDigSxMaTT/?=
 =?us-ascii?Q?jxQO3UpptiapUgA5O80P2DFkDEjaGo4BQdPmWdf/Ago5KXai1T83hmU84Kjc?=
 =?us-ascii?Q?WWg8GIpnlAxL+iNProXI1X+3VFkrVbeBfw4YFw2LoCeulvxr+U3Y8dUUprgl?=
 =?us-ascii?Q?qF0BaohsvBJt0nKgA29D3dWFLBDxFylVlE1+P74SR4p1RGSyIKmWm8Mzuz31?=
 =?us-ascii?Q?oXFz7YlHpqPV+HvjOSzcJXv9lGONCOiOuBrQFSgPzuJLVcRwqeqpdE+jcokc?=
 =?us-ascii?Q?Ipzms5fzcfuuYwf+OKbRM29CjvyPj6OPac2+vbhdIC6zF+kwJXGOMH31TB+D?=
 =?us-ascii?Q?J/EANk/qI0cnce4ikqPsPCGx7jOrZvi7ZXcLDVoaRoy8upN8dYbf5k4ob99z?=
 =?us-ascii?Q?RT1mf4qnzPGUrmRyTr1f9w5iXDbYvm63MCOvBJ24nZQU1F2cH+pw/hWdBm4D?=
 =?us-ascii?Q?w9ZPV80XiAB8nngsicxl3II=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24fb7b0d-e445-4e63-33e3-08dbc14b15d2
X-MS-Exchange-CrossTenant-AuthSource: MWHPR0101MB2893.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2023 00:20:43.8312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hw5bJ/fnDB+gsiVtoqsYSZXeM3oSb65nLA0q3p+bItqV4VHGyFtWUjSjECyOjcOUlu6E6leUSq4lU2ybChCJI4Ef7zK/P/JPANjOmilsXfIA41JIhFaM3OkwElo+iHNx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR01MB7553
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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
Changes since v1:
- remove build-as-module restriction
- add some more description
- don't open code PCI_SLOT()
- convert to a platform driver

 drivers/pci/hotplug/Kconfig                |  12 ++
 drivers/pci/hotplug/Makefile               |   1 +
 drivers/pci/hotplug/acpiphp_ampere_altra.c | 127 +++++++++++++++++++++
 3 files changed, 140 insertions(+)
 create mode 100644 drivers/pci/hotplug/acpiphp_ampere_altra.c

diff --git a/drivers/pci/hotplug/Kconfig b/drivers/pci/hotplug/Kconfig
index 48113b210cf93..1472aef0fb812 100644
--- a/drivers/pci/hotplug/Kconfig
+++ b/drivers/pci/hotplug/Kconfig
@@ -61,6 +61,18 @@ config HOTPLUG_PCI_ACPI
 
 	  When in doubt, say N.
 
+config HOTPLUG_PCI_ACPI_AMPERE_ALTRA
+	tristate "ACPI PCI Hotplug driver Ampere Altra extensions"
+	depends on HOTPLUG_PCI_ACPI
+	depends on HAVE_ARM_SMCCC_DISCOVERY
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
index 5196983220df6..240c99517d5e9 100644
--- a/drivers/pci/hotplug/Makefile
+++ b/drivers/pci/hotplug/Makefile
@@ -23,6 +23,7 @@ obj-$(CONFIG_HOTPLUG_PCI_S390)		+= s390_pci_hpc.o
 
 # acpiphp_ibm extends acpiphp, so should be linked afterwards.
 
+obj-$(CONFIG_HOTPLUG_PCI_ACPI_AMPERE_ALTRA)	+= acpiphp_ampere_altra.o
 obj-$(CONFIG_HOTPLUG_PCI_ACPI_IBM)	+= acpiphp_ibm.o
 
 pci_hotplug-objs	:=	pci_hotplug_core.o
diff --git a/drivers/pci/hotplug/acpiphp_ampere_altra.c b/drivers/pci/hotplug/acpiphp_ampere_altra.c
new file mode 100644
index 0000000000000..1b1fe5d6a3fbf
--- /dev/null
+++ b/drivers/pci/hotplug/acpiphp_ampere_altra.c
@@ -0,0 +1,127 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ACPI PCI Hot Plug Extension for Ampere Altra. Allows control of
+ * attention LEDs via requests to system firmware.
+ *
+ * Copyright (C) 2023 Ampere Computing LLC
+ */
+
+#define pr_fmt(fmt) "acpiphp_ampere_altra: " fmt
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/pci_hotplug.h>
+#include <linux/platform_device.h>
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
+		      pci_domain_nr(bus) | (PCI_SLOT(root_port->devfn) << 4), 0, 0,
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
+static int altra_led_probe(struct platform_device *pdev)
+{
+	struct fwnode_handle *fwnode = dev_fwnode(&pdev->dev);
+	int ret;
+
+	ret = fwnode_property_read_u32_array(fwnode, "uuid", led_service_id, 4);
+	if (ret) {
+		dev_err(&pdev->dev, "can't find uuid\n");
+		return ret;
+	}
+
+	ret = acpiphp_register_attention(&ampere_altra_attn);
+	if (ret) {
+		dev_err(&pdev->dev, "can't register driver\n");
+		return ret;
+	}
+	return 0;
+}
+
+static void altra_led_remove(struct platform_device *pdev)
+{
+	acpiphp_unregister_attention(&ampere_altra_attn);
+}
+
+static const struct acpi_device_id altra_led_ids[] = {
+	{ "AMPC0008", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, altra_led_ids);
+
+static struct platform_driver altra_led_driver = {
+	.driver = {
+		.name = "ampere-altra-leds",
+		.acpi_match_table = altra_led_ids,
+	},
+	.probe = altra_led_probe,
+	.remove_new = altra_led_remove,
+};
+module_platform_driver(altra_led_driver);
+
+MODULE_AUTHOR("D Scott Phillips <scott@os.amperecomputing.com>");
+MODULE_LICENSE("GPL");
-- 
2.41.0

