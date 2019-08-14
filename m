Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C88368DDC5
	for <lists+linux-pci@lfdr.de>; Wed, 14 Aug 2019 21:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728976AbfHNTJG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Aug 2019 15:09:06 -0400
Received: from mail-eopbgr800097.outbound.protection.outlook.com ([40.107.80.97]:42124
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728773AbfHNTJG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 14 Aug 2019 15:09:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WiKK2MJFeo9m9sQLAbf/q4/p8OWVOwArIZ0L4bvaVugHnjbUcIAa1t2xFa4ZLsXgp0lHdKfOnWeyObMzISZ7xbX9nqNGApg+1+XSxe9ih2XMdqGgjG0URNu8wvwteP8b1i4ck5FVqP0iXUXSTyG6XTpxRGlVoLYyzlk2U2Q//CAFe4pTP65WlPxHgV+wOfS7qmgcI47OobEAS7dHGgpCVIhZvsLS3PDO6rPDxKMy5Wj33c3FGxvwxWCNBFgjl+Xkpd2YP6saSQ68ua7NnsYcSPObrKLVgQd7/Xci0UXssBQ7VYfHKlfrBkIDOJy9KgzobccXvxcUo1jsHqYCdLJ2VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eW1eikBVYvq9db/ly7py2Z6YmLH53zbxipiJ9c0wX14=;
 b=FX8KNPmRDVIObkDUlTfv/XnUtbnOaHXcnkZCjEorkyxHIlSJXYmE2/AH7emie6UUQQarMGrvk8NqHxa2GvOflvEW7ozt0SOYj/R5Qr+E5E709N1IwXjlEbkqRg2KTrfGw5tVIHjt21R6gtTNtPVBneyMWDK3FD2qUU1M4a1ZgQCVZoeF87N1YiQZ1/g1eFWVipQWIqAz3UEUDUXzd1hjOeqdRZQ9wVk+m+yyAxg6p8QPyT9qAen1CPyx2Zh+CyRAycbe+ojWLhDAAxvtgDV0pxoAUmjrTx1fkKEVS6T762z+p73M2i4YrbxVv8un0GDkS5nSgzALzOkE+2pmAlxzKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eW1eikBVYvq9db/ly7py2Z6YmLH53zbxipiJ9c0wX14=;
 b=k3ENHH9CrSPeLOtrgrj8T47N189GHBCZOxZm3XPDD2H8O6aMTGd7GvLBPXZyLlQQGwyPhwiLFXM8db6ke7hBH7ClD3S/AEthTZgVw3HPQwGZTW0L7WMURT9t2Li8POJyuNRBtOq9jV4wOJf5nFjh9BnRfRbdJkPU8yolzNwxToQ=
Received: from DM6PR21MB1242.namprd21.prod.outlook.com (20.179.50.86) by
 DM6PR21MB1338.namprd21.prod.outlook.com (20.179.53.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.6; Wed, 14 Aug 2019 19:08:55 +0000
Received: from DM6PR21MB1242.namprd21.prod.outlook.com
 ([fe80::ddd:8e5b:2930:6726]) by DM6PR21MB1242.namprd21.prod.outlook.com
 ([fe80::ddd:8e5b:2930:6726%9]) with mapi id 15.20.2178.006; Wed, 14 Aug 2019
 19:08:55 +0000
From:   Haiyang Zhang <haiyangz@microsoft.com>
To:     "sashal@kernel.org" <sashal@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "saeedm@mellanox.com" <saeedm@mellanox.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "eranbe@mellanox.com" <eranbe@mellanox.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next, 2/6] PCI: hv: Add a Hyper-V PCI mini driver for
 software backchannel interface
Thread-Topic: [PATCH net-next, 2/6] PCI: hv: Add a Hyper-V PCI mini driver for
 software backchannel interface
Thread-Index: AQHVUtO3Aa5ZNhht3k+GwnmN//OdcQ==
Date:   Wed, 14 Aug 2019 19:08:55 +0000
Message-ID: <1565809632-39138-3-git-send-email-haiyangz@microsoft.com>
References: <1565809632-39138-1-git-send-email-haiyangz@microsoft.com>
In-Reply-To: <1565809632-39138-1-git-send-email-haiyangz@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR05CA0107.namprd05.prod.outlook.com
 (2603:10b6:104:1::33) To DM6PR21MB1242.namprd21.prod.outlook.com
 (2603:10b6:5:169::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=lkmlhyz@microsoft.com; 
x-ms-exchange-messagesentrepresentingtype: 2
x-mailer: git-send-email 1.8.3.1
x-originating-ip: [13.77.154.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0a9b04cf-67b1-4113-0e09-08d720eada38
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600158)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM6PR21MB1338;
x-ms-traffictypediagnostic: DM6PR21MB1338:|DM6PR21MB1338:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR21MB133896BBF8B021735E03F95CACAD0@DM6PR21MB1338.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 01294F875B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(39860400002)(366004)(346002)(396003)(376002)(189003)(199004)(6486002)(110136005)(6392003)(54906003)(4326008)(10090500001)(26005)(14454004)(256004)(2906002)(53936002)(6116002)(66066001)(6436002)(3846002)(6512007)(7416002)(66476007)(66446008)(76176011)(66556008)(2201001)(64756008)(66946007)(8936002)(22452003)(71200400001)(7736002)(71190400001)(50226002)(102836004)(5660300002)(81166006)(4720700003)(446003)(316002)(478600001)(305945005)(7846003)(186003)(99286004)(2501003)(36756003)(81156014)(8676002)(25786009)(476003)(11346002)(52116002)(6506007)(2616005)(486006)(10290500003)(386003)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR21MB1338;H:DM6PR21MB1242.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Fswhx158o4Gd+YQArlsDkxj8ISabbnDqmM3MWOzpNpW722VQhE6MeHdeuq/7iSAzjQ47wQr8MtllyuzRoIvGHRY0rlFSwEzUU9ZZbRu8db0lSBY/3/6I/Q6lI+t0DGb7vzgH91s6i9MHZpqxnvh/XUZsU+1skpFpD3IS5VFcca8nSaYs1FLcBi/QLAFC7D2XAvryf+zRaIJ/E0qrDZlJoaW3nO1yRLT2h0ETSIX+YUi0ANl3ph0UKetSHOXwUlnPqArPlbgNlVhJFniveFNzPjVdX3d3lW1dUGQ3FxUBwQvJggrBACxAtmpNmxoO7+RnuIL0BsNd18GXpY4bVl2eHN3s0m3D/Y1gxj42UkIoy66xsiHYerNzrRKSzqWPoVLpfmxWHlq5F1C170DaqnObWpPn4CAia0fb4LdyDsdd8qg=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a9b04cf-67b1-4113-0e09-08d720eada38
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2019 19:08:55.2946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yWSx/5Tdt9DoD76xAetgUv9p6HeKwZdwHFZJdHlG0LYM7+4YoBSLTOKxuv6NGrk9W5qa14lg5tLrd5H7PnAlJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1338
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This mini driver is a helper driver allows other drivers to
have a common interface with the Hyper-V PCI frontend driver.

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
---
 MAINTAINERS                              |  1 +
 drivers/pci/Kconfig                      |  1 +
 drivers/pci/controller/Kconfig           |  7 ++++
 drivers/pci/controller/Makefile          |  1 +
 drivers/pci/controller/pci-hyperv-mini.c | 70 ++++++++++++++++++++++++++++=
++++
 drivers/pci/controller/pci-hyperv.c      | 12 ++++--
 include/linux/hyperv.h                   | 30 ++++++++++----
 7 files changed, 111 insertions(+), 11 deletions(-)
 create mode 100644 drivers/pci/controller/pci-hyperv-mini.c

diff --git a/MAINTAINERS b/MAINTAINERS
index e352550..c4962b9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7453,6 +7453,7 @@ F:	drivers/hid/hid-hyperv.c
 F:	drivers/hv/
 F:	drivers/input/serio/hyperv-keyboard.c
 F:	drivers/pci/controller/pci-hyperv.c
+F:	drivers/pci/controller/pci-hyperv-mini.c
 F:	drivers/net/hyperv/
 F:	drivers/scsi/storvsc_drv.c
 F:	drivers/uio/uio_hv_generic.c
diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 2ab9240..bb852f5 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -182,6 +182,7 @@ config PCI_LABEL
 config PCI_HYPERV
         tristate "Hyper-V PCI Frontend"
         depends on X86 && HYPERV && PCI_MSI && PCI_MSI_IRQ_DOMAIN && X86_6=
4
+	select PCI_HYPERV_MINI
         help
           The PCI device frontend driver allows the kernel to import arbit=
rary
           PCI devices from a PCI backend to support PCI driver domains.
diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfi=
g
index fe9f9f1..8e31cba 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -281,5 +281,12 @@ config VMD
 	  To compile this driver as a module, choose M here: the
 	  module will be called vmd.
=20
+config PCI_HYPERV_MINI
+	tristate "Hyper-V PCI Mini"
+	depends on X86 && HYPERV && PCI_MSI && PCI_MSI_IRQ_DOMAIN && X86_64
+	help
+	  The Hyper-V PCI Mini is a helper driver allows other drivers to
+	  have a common interface with the Hyper-V PCI frontend driver.
+
 source "drivers/pci/controller/dwc/Kconfig"
 endmenu
diff --git a/drivers/pci/controller/Makefile b/drivers/pci/controller/Makef=
ile
index d56a507..77e0132 100644
--- a/drivers/pci/controller/Makefile
+++ b/drivers/pci/controller/Makefile
@@ -4,6 +4,7 @@ obj-$(CONFIG_PCIE_CADENCE_HOST) +=3D pcie-cadence-host.o
 obj-$(CONFIG_PCIE_CADENCE_EP) +=3D pcie-cadence-ep.o
 obj-$(CONFIG_PCI_FTPCI100) +=3D pci-ftpci100.o
 obj-$(CONFIG_PCI_HYPERV) +=3D pci-hyperv.o
+obj-$(CONFIG_PCI_HYPERV_MINI) +=3D pci-hyperv-mini.o
 obj-$(CONFIG_PCI_MVEBU) +=3D pci-mvebu.o
 obj-$(CONFIG_PCI_AARDVARK) +=3D pci-aardvark.o
 obj-$(CONFIG_PCI_TEGRA) +=3D pci-tegra.o
diff --git a/drivers/pci/controller/pci-hyperv-mini.c b/drivers/pci/control=
ler/pci-hyperv-mini.c
new file mode 100644
index 0000000..9b6cd1c
--- /dev/null
+++ b/drivers/pci/controller/pci-hyperv-mini.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) Microsoft Corporation.
+ *
+ * Author:
+ *   Haiyang Zhang <haiyangz@microsoft.com>
+ *
+ * This mini driver is a helper driver allows other drivers to
+ * have a common interface with the Hyper-V PCI frontend driver.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/hyperv.h>
+
+struct hyperv_pci_block_ops hvpci_block_ops;
+EXPORT_SYMBOL(hvpci_block_ops);
+
+int hyperv_read_cfg_blk(struct pci_dev *dev, void *buf, unsigned int buf_l=
en,
+			unsigned int block_id, unsigned int *bytes_returned)
+{
+	if (!hvpci_block_ops.read_block)
+		return -EOPNOTSUPP;
+
+	return hvpci_block_ops.read_block(dev, buf, buf_len, block_id,
+					  bytes_returned);
+}
+EXPORT_SYMBOL(hyperv_read_cfg_blk);
+
+int hyperv_write_cfg_blk(struct pci_dev *dev, void *buf, unsigned int len,
+			 unsigned int block_id)
+{
+	if (!hvpci_block_ops.write_block)
+		return -EOPNOTSUPP;
+
+	return hvpci_block_ops.write_block(dev, buf, len, block_id);
+}
+EXPORT_SYMBOL(hyperv_write_cfg_blk);
+
+int hyperv_reg_block_invalidate(struct pci_dev *dev, void *context,
+				void (*block_invalidate)(void *context,
+							 u64 block_mask))
+{
+	if (!hvpci_block_ops.reg_blk_invalidate)
+		return -EOPNOTSUPP;
+
+	return hvpci_block_ops.reg_blk_invalidate(dev, context,
+						  block_invalidate);
+}
+EXPORT_SYMBOL(hyperv_reg_block_invalidate);
+
+static void __exit exit_hv_pci_mini(void)
+{
+	pr_info("unloaded\n");
+}
+
+static int __init init_hv_pci_mini(void)
+{
+	pr_info("loaded\n");
+
+	return 0;
+}
+
+module_init(init_hv_pci_mini);
+module_exit(exit_hv_pci_mini);
+
+MODULE_DESCRIPTION("Hyper-V PCI Mini");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/p=
ci-hyperv.c
index 57adeca..9c93ac2 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -983,7 +983,6 @@ int hv_read_config_block(struct pci_dev *pdev, void *bu=
f, unsigned int len,
 	*bytes_returned =3D comp_pkt.bytes_returned;
 	return 0;
 }
-EXPORT_SYMBOL(hv_read_config_block);
=20
 /**
  * hv_pci_write_config_compl() - Invoked when a response packet for a writ=
e
@@ -1070,7 +1069,6 @@ int hv_write_config_block(struct pci_dev *pdev, void =
*buf, unsigned int len,
=20
 	return 0;
 }
-EXPORT_SYMBOL(hv_write_config_block);
=20
 /**
  * hv_register_block_invalidate() - Invoked when a config block invalidati=
on
@@ -1101,7 +1099,6 @@ int hv_register_block_invalidate(struct pci_dev *pdev=
, void *context,
 	return 0;
=20
 }
-EXPORT_SYMBOL(hv_register_block_invalidate);
=20
 /* Interrupt management hooks */
 static void hv_int_desc_free(struct hv_pci_dev *hpdev,
@@ -3045,10 +3042,19 @@ static int hv_pci_remove(struct hv_device *hdev)
 static void __exit exit_hv_pci_drv(void)
 {
 	vmbus_driver_unregister(&hv_pci_drv);
+
+	hvpci_block_ops.read_block =3D NULL;
+	hvpci_block_ops.write_block =3D NULL;
+	hvpci_block_ops.reg_blk_invalidate =3D NULL;
 }
=20
 static int __init init_hv_pci_drv(void)
 {
+	/* Initialize PCI block r/w interface */
+	hvpci_block_ops.read_block =3D hv_read_config_block;
+	hvpci_block_ops.write_block =3D hv_write_config_block;
+	hvpci_block_ops.reg_blk_invalidate =3D hv_register_block_invalidate;
+
 	return vmbus_driver_register(&hv_pci_drv);
 }
=20
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 9d37f8c..2afe6fd 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -1579,18 +1579,32 @@ struct vmpacket_descriptor *
 	    pkt =3D hv_pkt_iter_next(channel, pkt))
=20
 /*
- * Functions for passing data between SR-IOV PF and VF drivers.  The VF dr=
iver
+ * Interface for passing data between SR-IOV PF and VF drivers. The VF dri=
ver
  * sends requests to read and write blocks. Each block must be 128 bytes o=
r
  * smaller. Optionally, the VF driver can register a callback function whi=
ch
  * will be invoked when the host says that one or more of the first 64 blo=
ck
  * IDs is "invalid" which means that the VF driver should reread them.
  */
 #define HV_CONFIG_BLOCK_SIZE_MAX 128
-int hv_read_config_block(struct pci_dev *dev, void *buf, unsigned int buf_=
len,
-			 unsigned int block_id, unsigned int *bytes_returned);
-int hv_write_config_block(struct pci_dev *dev, void *buf, unsigned int len=
,
-			  unsigned int block_id);
-int hv_register_block_invalidate(struct pci_dev *dev, void *context,
-				 void (*block_invalidate)(void *context,
-							  u64 block_mask));
+
+int hyperv_read_cfg_blk(struct pci_dev *dev, void *buf, unsigned int buf_l=
en,
+			unsigned int block_id, unsigned int *bytes_returned);
+int hyperv_write_cfg_blk(struct pci_dev *dev, void *buf, unsigned int len,
+			 unsigned int block_id);
+int hyperv_reg_block_invalidate(struct pci_dev *dev, void *context,
+				void (*block_invalidate)(void *context,
+							 u64 block_mask));
+
+struct hyperv_pci_block_ops {
+	int (*read_block)(struct pci_dev *dev, void *buf, unsigned int buf_len,
+			  unsigned int block_id, unsigned int *bytes_returned);
+	int (*write_block)(struct pci_dev *dev, void *buf, unsigned int len,
+			   unsigned int block_id);
+	int (*reg_blk_invalidate)(struct pci_dev *dev, void *context,
+				  void (*block_invalidate)(void *context,
+							   u64 block_mask));
+};
+
+extern struct hyperv_pci_block_ops hvpci_block_ops;
+
 #endif /* _HYPERV_H */
--=20
1.8.3.1

