Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87B5340FDCC
	for <lists+linux-pci@lfdr.de>; Fri, 17 Sep 2021 18:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241383AbhIQQXc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Sep 2021 12:23:32 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3842 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbhIQQXc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Sep 2021 12:23:32 -0400
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4H9zgV4FD9z67flB;
        Sat, 18 Sep 2021 00:19:50 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Fri, 17 Sep 2021 18:22:07 +0200
Received: from localhost (10.227.96.57) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 17 Sep
 2021 17:22:07 +0100
Date:   Fri, 17 Sep 2021 17:22:05 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>
CC:     <keyrings@vger.kernel.org>, <dan.j.williams@intel.com>,
        Chris Browy <cbrowy@avery-design.com>, <linuxarm@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Jeremy Kerr <jk@codeconstruct.com.au>
Subject: Re: [RFC PATCH 3/4] PCI/CMA: Initial support for Component
 Measurement and Authentication ECN
Message-ID: <20210917172205.00000684@huawei.com>
In-Reply-To: <20210804161839.3492053-4-Jonathan.Cameron@huawei.com>
References: <20210804161839.3492053-1-Jonathan.Cameron@huawei.com>
        <20210804161839.3492053-4-Jonathan.Cameron@huawei.com>
Organization: Huawei tech. R&D (UK)  Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.227.96.57]
X-ClientProxiedBy: lhreml718-chm.china.huawei.com (10.201.108.69) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 5 Aug 2021 00:18:38 +0800
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> This currently very much a PoC.  Currently the SPDM library only provides
> a single function to allow a challenge / authentication of the PCI EP.
> 
> SPDM exchanges must occur in one of a small set of valid squences over
> which the message digest used in authentication is built up.
> Placing that complexity in the SPDM library seems like a good way
> to enforce that logic, without having to do it for each transport.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This is far more likely to work if I actually include the missing drivers/pci/cma.c
I'll send a v2 next week, but in the meantime it should look like this.

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <jonathan.cameron@huawei.com>
Subject: [PATCH] pci/cma: Missing file
Date: Sat, 18 Sep 2021 00:16:00 +0800
X-Mailer: git-send-email 2.19.1

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/pci/cma.c | 102 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/drivers/pci/cma.c b/drivers/pci/cma.c
new file mode 100644
index 000000000000..58fef73674fe
--- /dev/null
+++ b/drivers/pci/cma.c
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Component Measurement and Authentication was added as an ECN to the
+ * PCIe r5.0 spec.
+ *
+ * Copyright (C) 2021 Huawei
+ *     Jonathan Cameron <Jonathan.Cameron@huawei.com>
+ */
+
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/pci-cma.h>
+#include <linux/pci-doe.h>
+#include <linux/spdm.h>
+
+/* Keyring that userspace can poke certs into */
+static struct key *cma_keyring;
+
+static int cma_spdm_ex(void *priv, struct spdm_exchange *spdm_ex)
+{
+	size_t request_padded_sz, response_padded_sz;
+	struct pci_doe_exchange ex = {
+		.vid = PCI_VENDOR_ID_PCI_SIG,
+		.protocol = PCI_DOE_PROTOCOL_CMA,
+	};
+	struct pci_doe *doe = priv;
+	int rc;
+
+	/* DOE requires that response and request are padded to a multiple of 4 bytes */
+	request_padded_sz = ALIGN(spdm_ex->request_pl_sz, sizeof(u32));
+	if (request_padded_sz != spdm_ex->request_pl_sz) {
+		ex.request_pl = kzalloc(request_padded_sz, GFP_KERNEL);
+		if (!ex.request_pl)
+			return -ENOMEM;
+		memcpy(ex.request_pl, spdm_ex->request_pl, spdm_ex->request_pl_sz);
+		ex.request_pl_sz = request_padded_sz;
+	} else {
+		ex.request_pl = (u32 *)spdm_ex->request_pl;
+		ex.request_pl_sz = spdm_ex->request_pl_sz;
+	}
+
+	response_padded_sz = ALIGN(spdm_ex->response_pl_sz, sizeof(u32));
+	if (response_padded_sz != spdm_ex->response_pl_sz) {
+		ex.response_pl = kzalloc(response_padded_sz, GFP_KERNEL);
+		if (!ex.response_pl) {
+			rc = -ENOMEM;
+			goto err_free_req;
+		}
+		ex.response_pl_sz = response_padded_sz;
+	} else {
+		ex.response_pl = (u32 *)spdm_ex->response_pl;
+		ex.response_pl_sz = spdm_ex->response_pl_sz;
+	}
+
+	rc = pci_doe_exchange_sync(doe, &ex);
+	if (rc < 0)
+		goto err_free_rsp;
+
+	if (response_padded_sz != spdm_ex->response_pl_sz)
+		memcpy(spdm_ex->response_pl, ex.response_pl, spdm_ex->response_pl_sz);
+
+err_free_rsp:
+	if (response_padded_sz != spdm_ex->response_pl_sz)
+		kfree(ex.response_pl);
+err_free_req:
+	if (request_padded_sz != spdm_ex->request_pl_sz)
+		kfree(ex.request_pl);
+
+	return rc;
+}
+
+void pci_cma_init(struct pci_doe *doe, struct spdm_state *spdm_state)
+{
+	memset(spdm_state, 0, sizeof(*spdm_state));
+	spdm_state->transport_ex = cma_spdm_ex;
+	spdm_state->transport_priv = doe;
+	spdm_state->dev = &doe->pdev->dev;
+	spdm_state->root_keyring = cma_keyring;
+}
+EXPORT_SYMBOL_GPL(pci_cma_init);
+
+int pci_cma_authenticate(struct spdm_state *spdm_state)
+{
+	return spdm_authenticate(spdm_state);
+}
+EXPORT_SYMBOL_GPL(pci_cma_authenticate);
+
+__init static int cma_keyring_init(void)
+{
+	cma_keyring = keyring_alloc("_cma",
+				    KUIDT_INIT(0), KGIDT_INIT(0),
+				    current_cred(),
+				    (KEY_POS_ALL & ~KEY_POS_SETATTR) |
+				    KEY_USR_VIEW | KEY_USR_READ | KEY_USR_WRITE | KEY_USR_SEARCH,
+				    KEY_ALLOC_NOT_IN_QUOTA | KEY_ALLOC_SET_KEEP, NULL, NULL);
+	if (IS_ERR(cma_keyring))
+		pr_err("Could not allocate cma keyring\n");
+
+	return 0;
+}
+device_initcall(cma_keyring_init);
+MODULE_LICENSE("GPL v2");
-- 
2.19.1



> ---
>  drivers/pci/Kconfig     | 9 +++++++++
>  drivers/pci/Makefile    | 1 +
>  drivers/pci/doe.c       | 2 --
>  include/linux/pci-doe.h | 2 ++
>  4 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index a30c59cf5e27..43e3b0d5e8cd 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -198,6 +198,15 @@ config PCI_DOE
>  	  used by a number of different protocols.
>  	  DOE is defined in the Data Object Exchange ECN to the PCIe r5.0 spec.
>  
> +config PCI_CMA
> +	tristate
> +	select PCI_DOE
> +	select ASN1_ENCODER
> +	select SPDM
> +	help
> +	  This enables library support for the PCI Component Measurement and
> +	  Authentication ECN. This uses DMTF SPDM 1.1
> +
>  choice
>  	prompt "PCI Express hierarchy optimization setting"
>  	default PCIE_BUS_DEFAULT
> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> index 1b61c1a1c232..3f6b3543d565 100644
> --- a/drivers/pci/Makefile
> +++ b/drivers/pci/Makefile
> @@ -29,6 +29,7 @@ obj-$(CONFIG_PCI_PF_STUB)	+= pci-pf-stub.o
>  obj-$(CONFIG_PCI_ECAM)		+= ecam.o
>  obj-$(CONFIG_PCI_P2PDMA)	+= p2pdma.o
>  obj-$(CONFIG_PCI_DOE)		+= doe.o
> +obj-$(CONFIG_PCI_CMA)		+= cma.o
>  obj-$(CONFIG_XEN_PCIDEV_FRONTEND) += xen-pcifront.o
>  
>  # Endpoint library must be initialized before its users
> diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> index 2d20f59e42c6..f6aaeed01010 100644
> --- a/drivers/pci/doe.c
> +++ b/drivers/pci/doe.c
> @@ -20,8 +20,6 @@
>  /* Maximum number of DOE instances in the system */
>  #define PCI_DOE_MAX_CNT 65536
>  
> -#define PCI_DOE_PROTOCOL_DISCOVERY 0
> -
>  #define PCI_DOE_BUSY_MAX_RETRIES 16
>  #define PCI_DOE_POLL_INTERVAL (HZ / 128)
>  
> diff --git a/include/linux/pci-doe.h b/include/linux/pci-doe.h
> index bdc5f15f14ab..1347c124ed70 100644
> --- a/include/linux/pci-doe.h
> +++ b/include/linux/pci-doe.h
> @@ -19,6 +19,8 @@ struct pci_doe_prot {
>  	u8 type;
>  };
>  
> +#define PCI_DOE_PROTOCOL_DISCOVERY 0
> +#define PCI_DOE_PROTOCOL_CMA 1
>  struct workqueue_struct;
>  
>  enum pci_doe_state {

