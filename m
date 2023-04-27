Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2C66F0462
	for <lists+linux-pci@lfdr.de>; Thu, 27 Apr 2023 12:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243620AbjD0KpA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Apr 2023 06:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243606AbjD0Koz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Apr 2023 06:44:55 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4043D559E
        for <linux-pci@vger.kernel.org>; Thu, 27 Apr 2023 03:44:51 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-63b67a26069so10434579b3a.0
        for <linux-pci@vger.kernel.org>; Thu, 27 Apr 2023 03:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20221208.gappssmtp.com; s=20221208; t=1682592290; x=1685184290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jlK6/FmkNNZlMZq+BvSUnyB2WIdcX0Lfwqu93Kq+c+Y=;
        b=OrS5RfBRVwwxPdst8pbet162L6RgP+a63G4agFWciWPpHYfQQLCTqWQc2UZ9nzmzQY
         ny2LjUZgudcJl0GE3+ZC+fjbOQxrCkVfSLzct8Z+xt955Q3xYWon44H9djBOctPd24eA
         BZvB0qnZKdbOQ/oWQr3n/Jr3VgVdO+LvYbv/dbYo3fLLglLBnXzn4Cl8n4+uVdAMmuEK
         41gnbmVIlY4pKTj+ZATFuZZYEBLYLiQBIf4ZanrV7RAe1CaE5VzEf6Ef0H+rA3fqTfMz
         h3TixyCTpDRkKvgz9RGxaIvroMdbvekw5Zq37we+giD28JQ30lk7ZHGaJNO91BuVCuTH
         iynw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682592290; x=1685184290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jlK6/FmkNNZlMZq+BvSUnyB2WIdcX0Lfwqu93Kq+c+Y=;
        b=dq3k5pfZjdTrkLyIrujga/ht1hkCEitONhrOoclJOJPOX54P8VLLdbsKBauIdXcArO
         NIy+5aTRuwrWu6b2O9EKMASMChKsc/Dgb1mdilpXPAwQsCeWOOzDYhO3C5H+8t9DIoKm
         rJD2fqhAvZKixYU620isnQvU8pGHBos36ZvQg3avqFbEq2LlMNZlSdCtoJ516G30SDLO
         5AaOMRjwKb0CXPaCH8BGi26a8Bulry5yfCukKjzNWvHWVrLWz4Rabqb6AcCwAx9rAsYS
         U1a/amx6hiFNdhDeWc4NQF1FlTeHx9S/sta7tGg3tX9hAMFaB4qKl4Wl9BePs6hXGvvA
         W35Q==
X-Gm-Message-State: AC+VfDxaBM3YjappH4WeqLVAQTedeQNrOdICD2ErcZI0uLZJzWCRHTH+
        Q41lOqLkGWe/aFpaQSY33qtXCA==
X-Google-Smtp-Source: ACHHUZ49zgh+JgUZMFaClUTOZqVqjCpn44VsqiGE6SAhDGrQfjGogOhEGaP4Tm8G+0k/GA4cSbBHjw==
X-Received: by 2002:a05:6a20:8f08:b0:f0:ec64:f3de with SMTP id b8-20020a056a208f0800b000f0ec64f3demr1491263pzk.25.1682592290547;
        Thu, 27 Apr 2023 03:44:50 -0700 (PDT)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id b3-20020a631b03000000b0050f93a3586fsm11029042pgb.37.2023.04.27.03.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 03:44:50 -0700 (PDT)
From:   Shunsuke Mie <mie@igel.co.jp>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Shunsuke Mie <mie@igel.co.jp>, Frank Li <Frank.Li@nxp.com>,
        Jon Mason <jdmason@kudzu.us>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ren Zhijie <renzhijie2@huawei.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [RFC PATCH v2 3/3] PCI: endpoint: Add EP function driver to provide virtio-console functionality
Date:   Thu, 27 Apr 2023 19:44:28 +0900
Message-Id: <20230427104428.862643-4-mie@igel.co.jp>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230427104428.862643-1-mie@igel.co.jp>
References: <20230427104428.862643-1-mie@igel.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add a new PCIe endpoint function driver that works as a pci virtio-console
device. The console connect to endpoint side console. It enables to
communicate PCIe host and endpoint.

Architecture is following:

 ┌────────────┐         ┌──────────────────────┬────────────┐
 │virtioe     │         │                      │virtio      │
 │console drv │         ├───────────────┐      │console drv │
 ├────────────┤         │(virtio console│      ├────────────┤
 │ virtio bus │         │ device)       │◄────►│ virtio bus │
 ├────────────┤         ├---------------┤      └────────────┤
 │            │         │ pci ep virtio │                   │
 │  pci bus   │         │  console drv  │                   │
 │            │  pcie   ├───────────────┤                   │
 │            │ ◄─────► │  pci ep Bus   │                   │
 └────────────┘         └───────────────┴───────────────────┘
   PCIe Root              PCIe Endpoint

This driver has two roles. The first is as a PCIe endpoint virtio console
function, which is implemented using the PCIe endpoint framework and PCIe
EP virtio helpers. The second is as a virtual virtio console device
connected to the virtio bus on PCIe endpoint Linux.

Communication between the two is achieved by copying the virtqueue data
between PCIe root and endpoint, respectively.

This is a simple implementation and does not include features of
virtio-console such as MULTIPORT, EMERG_WRITE, etc. As a result, each
virtio console driver only displays /dev/hvc0.

As an example of usage, by setting getty to /dev/hvc0, it is possible to
login to another host.

Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
---
Changes from v2:
- Change to use copy functions between kiovs of pci-epf-virtio.

 drivers/pci/endpoint/functions/Kconfig        |  12 +
 drivers/pci/endpoint/functions/Makefile       |   1 +
 drivers/pci/endpoint/functions/pci-epf-vcon.c | 596 ++++++++++++++++++
 3 files changed, 609 insertions(+)
 create mode 100644 drivers/pci/endpoint/functions/pci-epf-vcon.c

diff --git a/drivers/pci/endpoint/functions/Kconfig b/drivers/pci/endpoint/functions/Kconfig
index fa1a6a569a8f..9ce2698b67e1 100644
--- a/drivers/pci/endpoint/functions/Kconfig
+++ b/drivers/pci/endpoint/functions/Kconfig
@@ -44,3 +44,15 @@ config PCI_EPF_VIRTIO
 	select VHOST_RING_IOMEM
 	help
 	  Helpers to implement PCI virtio Endpoint function
+
+config PCI_EPF_VCON
+	tristate "PCI Endpoint virito-console driver"
+	depends on PCI_ENDPOINT
+	select VHOST_RING
+	select PCI_EPF_VIRTIO
+	help
+	  PCIe Endpoint virtio-console function implementatino. This module
+	  enables to show the virtio-console as pci device to PCIe host side, and
+	  another virtual virtio-console device registers to endpoint system.
+	  Those devices are connected virtually and can communicate each other.
+
diff --git a/drivers/pci/endpoint/functions/Makefile b/drivers/pci/endpoint/functions/Makefile
index a96f127ce900..b4056689ce33 100644
--- a/drivers/pci/endpoint/functions/Makefile
+++ b/drivers/pci/endpoint/functions/Makefile
@@ -7,3 +7,4 @@ obj-$(CONFIG_PCI_EPF_TEST)		+= pci-epf-test.o
 obj-$(CONFIG_PCI_EPF_NTB)		+= pci-epf-ntb.o
 obj-$(CONFIG_PCI_EPF_VNTB) 		+= pci-epf-vntb.o
 obj-$(CONFIG_PCI_EPF_VIRTIO)		+= pci-epf-virtio.o
+obj-$(CONFIG_PCI_EPF_VCON)		+= pci-epf-vcon.o
diff --git a/drivers/pci/endpoint/functions/pci-epf-vcon.c b/drivers/pci/endpoint/functions/pci-epf-vcon.c
new file mode 100644
index 000000000000..31f4247cd10f
--- /dev/null
+++ b/drivers/pci/endpoint/functions/pci-epf-vcon.c
@@ -0,0 +1,596 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCI Endpoint function driver to impliment virtio-console device
+ * functionality.
+ */
+#include <linux/pci-epf.h>
+#include <linux/virtio_ids.h>
+#include <linux/virtio_pci.h>
+#include <linux/virtio_console.h>
+#include <linux/virtio_ring.h>
+
+#include "pci-epf-virtio.h"
+
+static int virtio_queue_size = 0x100;
+module_param(virtio_queue_size, int, 0444);
+MODULE_PARM_DESC(virtio_queue_size, "A length of virtqueue");
+
+struct epf_vcon {
+	/* To access virtqueues on remote host */
+	struct epf_virtio evio;
+	struct vringh_kiov *rdev_iovs;
+
+	/* To register a local virtio bus */
+	struct virtio_device vdev;
+
+	/* To access virtqueus of local host driver */
+	struct vringh *vdev_vrhs;
+	struct vringh_kiov *vdev_iovs;
+	struct virtqueue **vdev_vqs;
+
+	/* For transportation and notification */
+	struct workqueue_struct *task_wq;
+	struct work_struct raise_irq_work, rx_work, tx_work;
+
+	/* To retain virtio features. It is commonly used local and remote. */
+	u64 features;
+
+	/* To show a status whether this driver is ready and the remote is connected */
+	bool connected;
+};
+
+enum {
+	VCON_VIRTQUEUE_RX,
+	VCON_VIRTQUEUE_TX,
+	// Should be end of enum
+	VCON_VIRTQUEUE_NUM
+};
+
+static struct epf_vcon *vdev_to_vcon(struct virtio_device *vdev)
+{
+	return container_of(vdev, struct epf_vcon, vdev);
+}
+
+static unsigned int epf_vcon_get_nvq(struct epf_vcon *vcon)
+{
+	/* This is a minimum implementation. Doesn't support any features of
+	 * virtio console. It means driver and device use just 2 virtuque for tx
+	 * and rx.
+	 */
+	return VCON_VIRTQUEUE_NUM;
+}
+
+static void epf_vcon_rx_handler(struct work_struct *work)
+{
+	struct epf_vcon *vcon = container_of(work, struct epf_vcon, rx_work);
+	struct epf_virtio *evio = &vcon->evio;
+	struct vringh *dvrh;
+	struct vringh_kiov *siov, *diov;
+	int ret;
+
+	if (unlikely(!vcon->connected))
+		return;
+
+	dvrh = &vcon->vdev_vrhs[VCON_VIRTQUEUE_RX];
+	siov = &vcon->rdev_iovs[VCON_VIRTQUEUE_TX];
+	diov = &vcon->vdev_iovs[VCON_VIRTQUEUE_RX];
+
+	do {
+		u16 shead, dhead;
+		size_t total_len;
+
+		ret = epf_virtio_getdesc(evio, VCON_VIRTQUEUE_TX, siov, NULL,
+					 &shead);
+		if (ret <= 0)
+			continue;
+
+		ret = vringh_getdesc_kern(dvrh, NULL, diov, &dhead, GFP_KERNEL);
+		if (ret <= 0) {
+			epf_virtio_abandon(evio, VCON_VIRTQUEUE_TX, 1);
+			continue;
+		}
+
+		total_len = vringh_kiov_length(siov);
+
+		ret = epf_virtio_memcpy_kiov2kiov(evio, siov, diov,
+						  DMA_DEV_TO_MEM);
+		if (ret < 0)
+			continue;
+
+		epf_virtio_iov_complete(evio, VCON_VIRTQUEUE_TX, shead,
+					total_len);
+		vringh_complete_kern(dvrh, dhead, total_len);
+
+	} while (ret > 0);
+
+	vring_interrupt(0, vcon->vdev_vqs[VCON_VIRTQUEUE_RX]);
+}
+
+static void epf_vcon_tx_handler(struct work_struct *work)
+{
+	struct epf_vcon *vcon = container_of(work, struct epf_vcon, tx_work);
+	struct epf_virtio *evio = &vcon->evio;
+	struct vringh *svrh;
+	struct vringh_kiov *siov, *diov;
+	int ret;
+
+	if (unlikely(!vcon->connected))
+		return;
+
+	svrh = &vcon->vdev_vrhs[VCON_VIRTQUEUE_TX];
+	siov = &vcon->vdev_iovs[VCON_VIRTQUEUE_TX];
+	diov = &vcon->rdev_iovs[VCON_VIRTQUEUE_RX];
+
+	do {
+		u16 shead, dhead;
+		size_t total_len;
+
+		ret = vringh_getdesc_kern(svrh, siov, NULL, &shead, GFP_KERNEL);
+		if (ret <= 0)
+			continue;
+
+		ret = epf_virtio_getdesc(evio, VCON_VIRTQUEUE_RX, NULL, diov,
+					 &dhead);
+		if (ret <= 0) {
+			vringh_abandon_kern(svrh, 1);
+			continue;
+		}
+
+		total_len = vringh_kiov_length(siov);
+
+		ret = epf_virtio_memcpy_kiov2kiov(evio, siov, diov,
+						  DMA_MEM_TO_DEV);
+		if (ret < 0)
+			continue;
+
+		vringh_complete_kern(svrh, shead, total_len);
+		epf_virtio_iov_complete(evio, VCON_VIRTQUEUE_RX, dhead,
+					total_len);
+
+	} while (ret > 0);
+
+	queue_work(vcon->task_wq, &vcon->raise_irq_work);
+}
+
+static void epf_vcon_raise_irq_handler(struct work_struct *work)
+{
+	struct epf_vcon *vcon =
+		container_of(work, struct epf_vcon, raise_irq_work);
+	struct pci_epf *epf = vcon->evio.epf;
+
+	pci_epc_raise_irq(epf->epc, epf->func_no, epf->vfunc_no,
+			  PCI_EPC_IRQ_INTX, 0);
+}
+
+static int epf_vcon_setup_common(struct epf_vcon *vcon)
+{
+	vcon->features = 0;
+	vcon->connected = false;
+
+	vcon->task_wq =
+		alloc_workqueue("pci-epf-vcon/task-wq",
+				WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_UNBOUND, 0);
+	if (!vcon->task_wq)
+		return -ENOMEM;
+
+	INIT_WORK(&vcon->rx_work, epf_vcon_rx_handler);
+	INIT_WORK(&vcon->tx_work, epf_vcon_tx_handler);
+	INIT_WORK(&vcon->raise_irq_work, epf_vcon_raise_irq_handler);
+
+	return 0;
+}
+
+static void epf_vcon_cleanup_common(struct epf_vcon *vcon)
+{
+	/* Should do first to stop polling in other kernel thread */
+	vcon->connected = false;
+
+	flush_work(&vcon->raise_irq_work);
+	flush_work(&vcon->tx_work);
+	flush_work(&vcon->rx_work);
+
+	destroy_workqueue(vcon->task_wq);
+}
+
+static void epf_vcon_qnotify_callback(void *param)
+{
+	struct epf_vcon *vcon = param;
+
+	queue_work(vcon->task_wq, &vcon->rx_work);
+}
+
+static void epf_vcon_initialize_complete(void *param)
+{
+	struct epf_vcon *vcon = param;
+
+	pr_debug("Remote host has connected\n");
+
+	vcon->connected = true;
+
+	/* send filled buffer */
+	queue_work(vcon->task_wq, &vcon->tx_work);
+}
+
+static struct pci_epf_header epf_vcon_pci_header = {
+	.vendorid = PCI_VENDOR_ID_REDHAT_QUMRANET,
+	.deviceid = VIRTIO_TRANS_ID_CONSOLE,
+	.subsys_vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET,
+	.subsys_id = VIRTIO_ID_CONSOLE,
+	.revid = 0,
+	.baseclass_code = PCI_BASE_CLASS_COMMUNICATION,
+	.interrupt_pin = PCI_INTERRUPT_PIN,
+};
+
+static int epf_vcon_setup_ep_func(struct epf_vcon *vcon, struct pci_epf *epf)
+{
+	int err;
+	struct epf_virtio *evio = &vcon->evio;
+	unsigned int nvq = epf_vcon_get_nvq(vcon);
+
+	vcon->rdev_iovs =
+		kmalloc_array(nvq, sizeof(vcon->rdev_iovs[0]), GFP_KERNEL);
+	if (!vcon->rdev_iovs)
+		return -ENOMEM;
+
+	for (int i = 0; i < nvq; i++)
+		vringh_kiov_init(&vcon->rdev_iovs[i], NULL, 0);
+
+	evio->epf = epf;
+	evio->features = vcon->features;
+	evio->nvq = nvq;
+	evio->vqlen = virtio_queue_size;
+
+	evio->qn_callback = epf_vcon_qnotify_callback;
+	evio->qn_param = vcon;
+
+	evio->ic_callback = epf_vcon_initialize_complete;
+	evio->ic_param = vcon;
+
+	err = epf_virtio_init(evio, &epf_vcon_pci_header, 0);
+	if (err)
+		goto err_cleanup_kiov;
+
+	err = epf_virtio_launch_bgtask(evio);
+	if (err)
+		goto err_virtio_final;
+
+	return 0;
+
+err_virtio_final:
+	epf_virtio_final(evio);
+
+err_cleanup_kiov:
+	for (int i = 0; i < nvq; i++)
+		vringh_kiov_cleanup(&vcon->rdev_iovs[i]);
+
+	kfree(vcon->rdev_iovs);
+
+	return err;
+}
+
+static void epf_vcon_cleanup_ep_func(struct epf_vcon *vcon)
+{
+	epf_virtio_terminate_bgtask(&vcon->evio);
+
+	epf_virtio_final(&vcon->evio);
+
+	kfree(vcon->rdev_iovs);
+}
+
+/*
+ * Functions for local virtio device operation
+ */
+static u64 epf_vcon_vdev_get_features(struct virtio_device *vdev)
+{
+	struct epf_vcon *vcon = vdev_to_vcon(vdev);
+
+	return vcon->features;
+}
+
+static int epf_vcon_vdev_finalize_features(struct virtio_device *vdev)
+{
+	struct epf_vcon *vcon = vdev_to_vcon(vdev);
+
+	return vdev->features != vcon->features;
+}
+
+static void epf_vcon_vdev_get_config(struct virtio_device *vdev,
+				     unsigned int offset, void *buf,
+				     unsigned int len)
+{
+	/* There is no config for virtio console because this console device
+	 * doesn't any support features
+	 */
+	memset(buf, 0x00, len);
+}
+
+static void epf_vcon_vdev_set_config(struct virtio_device *vdev,
+				     unsigned int offset, const void *buf,
+				     unsigned int len)
+{
+	/* Do nothing because this console device doesn't any support features */
+}
+
+static u8 epf_vcon_vdev_get_status(struct virtio_device *vdev)
+{
+	return 0;
+}
+
+static void epf_vcon_vdev_set_status(struct virtio_device *vdev, u8 status)
+{
+	if (status & VIRTIO_CONFIG_S_FAILED)
+		pr_debug("driver failed to setup this device\n");
+}
+
+static void epf_vcon_vdev_reset(struct virtio_device *vdev)
+{
+	struct epf_vcon *vcon = vdev_to_vcon(vdev);
+
+	epf_virtio_reset(&vcon->evio);
+}
+
+static bool epf_vcon_vdev_vq_notify(struct virtqueue *vq)
+{
+	struct epf_vcon *vcon = vdev_to_vcon(vq->vdev);
+
+	switch (vq->index) {
+	case VCON_VIRTQUEUE_RX:
+	case VCON_VIRTQUEUE_TX:
+		queue_work(vcon->task_wq, &vcon->tx_work);
+		break;
+	default:
+		return false;
+	}
+
+	return true;
+}
+
+static int epf_vcon_vdev_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
+				  struct virtqueue *vqs[],
+				  vq_callback_t *callback[],
+				  const char *const names[], const bool *ctx,
+				  struct irq_affinity *desc)
+{
+	struct epf_vcon *vcon = vdev_to_vcon(vdev);
+	int err;
+	int qidx, i;
+
+	if (nvqs > epf_vcon_get_nvq(vcon))
+		return -EINVAL;
+
+	for (qidx = 0, i = 0; i < nvqs; i++) {
+		struct virtqueue *vq;
+		const struct vring *vring;
+
+		if (!names[i]) {
+			vqs[i] = NULL;
+			continue;
+		}
+
+		vq = vring_create_virtqueue(qidx++, virtio_queue_size,
+					    VIRTIO_PCI_VRING_ALIGN, vdev, true,
+					    false, ctx ? ctx[i] : false,
+					    epf_vcon_vdev_vq_notify,
+					    callback[i], names[i]);
+		if (!vq) {
+			err = -ENOMEM;
+			goto err_del_vqs;
+		}
+
+		vqs[i] = vq;
+		vcon->vdev_vqs[i] = vq;
+
+		vring = virtqueue_get_vring(vq);
+		err = vringh_init_kern(&vcon->vdev_vrhs[i], vcon->features,
+				       virtio_queue_size, false, vring->desc,
+				       vring->avail, vring->used);
+		if (err) {
+			pr_err("failed to init vringh for vring %d\n", i);
+			goto err_del_vqs;
+		}
+	}
+
+	return 0;
+
+err_del_vqs:
+	for (; i >= 0; i--) {
+		if (!names[i])
+			continue;
+
+		if (!vqs[i])
+			continue;
+
+		vring_del_virtqueue(vqs[i]);
+	}
+	return err;
+}
+
+static void epf_vcon_vdev_del_vqs(struct virtio_device *vdev)
+{
+	struct epf_vcon *vcon = vdev_to_vcon(vdev);
+
+	for (int i = 0; i < epf_vcon_get_nvq(vcon); i++) {
+		if (!vcon->vdev_vqs[i])
+			continue;
+
+		vring_del_virtqueue(vcon->vdev_vqs[i]);
+	}
+}
+
+static const struct virtio_config_ops epf_vcon_vdev_config_ops = {
+	.get_features = epf_vcon_vdev_get_features,
+	.finalize_features = epf_vcon_vdev_finalize_features,
+	.get = epf_vcon_vdev_get_config,
+	.set = epf_vcon_vdev_set_config,
+	.get_status = epf_vcon_vdev_get_status,
+	.set_status = epf_vcon_vdev_set_status,
+	.reset = epf_vcon_vdev_reset,
+	.find_vqs = epf_vcon_vdev_find_vqs,
+	.del_vqs = epf_vcon_vdev_del_vqs,
+};
+
+static void epf_vcon_vdev_release(struct device *dev)
+{
+	/* Do nothing, because the struct virtio_device will be reused. */
+}
+
+static int epf_vcon_setup_vdev(struct epf_vcon *vcon, struct device *parent)
+{
+	int err;
+	struct virtio_device *vdev = &vcon->vdev;
+	const unsigned int nvq = epf_vcon_get_nvq(vcon);
+
+	vcon->vdev_vrhs =
+		kmalloc_array(nvq, sizeof(vcon->vdev_vrhs[0]), GFP_KERNEL);
+	if (!vcon->vdev_vrhs)
+		return -ENOMEM;
+
+	vcon->vdev_iovs =
+		kmalloc_array(nvq, sizeof(vcon->vdev_iovs[0]), GFP_KERNEL);
+	if (!vcon->vdev_iovs) {
+		err = -ENOMEM;
+		goto err_free_vrhs;
+	}
+
+	for (int i = 0; i < nvq; i++)
+		vringh_kiov_init(&vcon->vdev_iovs[i], NULL, 0);
+
+	vcon->vdev_vqs =
+		kmalloc_array(nvq, sizeof(vcon->vdev_vrhs[0]), GFP_KERNEL);
+	if (!vcon->vdev_vqs) {
+		err = -ENOMEM;
+		goto err_cleanup_kiov;
+	}
+
+	vdev->dev.parent = parent;
+	vdev->dev.release = epf_vcon_vdev_release;
+	vdev->config = &epf_vcon_vdev_config_ops;
+	vdev->id.vendor = PCI_VENDOR_ID_REDHAT_QUMRANET;
+	vdev->id.device = VIRTIO_ID_CONSOLE;
+
+	err = register_virtio_device(vdev);
+	if (err)
+		goto err_free_vdev_vqs;
+
+	return 0;
+
+err_free_vdev_vqs:
+	kfree(vcon->vdev_vqs);
+
+err_cleanup_kiov:
+	for (int i = 0; i < nvq; i++)
+		vringh_kiov_cleanup(&vcon->vdev_iovs[i]);
+
+	kfree(vcon->vdev_iovs);
+
+err_free_vrhs:
+	kfree(vcon->vdev_vrhs);
+
+	return err;
+}
+
+static void epf_vcon_cleanup_vdev(struct epf_vcon *vcon)
+{
+	unregister_virtio_device(&vcon->vdev);
+	/* Cleanup struct virtio_device that has kobject, otherwise error occures when
+	 * reregister the virtio device.
+	 */
+	memset(&vcon->vdev, 0x00, sizeof(vcon->vdev));
+
+	kfree(vcon->vdev_vqs);
+
+	for (int i = 0; i < epf_vcon_get_nvq(vcon); i++)
+		vringh_kiov_cleanup(&vcon->vdev_iovs[i]);
+
+	kfree(vcon->vdev_iovs);
+	kfree(vcon->vdev_vrhs);
+}
+
+static int epf_vcon_bind(struct pci_epf *epf)
+{
+	struct epf_vcon *vcon = epf_get_drvdata(epf);
+	int err;
+
+	err = epf_vcon_setup_common(vcon);
+	if (err)
+		return err;
+
+	err = epf_vcon_setup_ep_func(vcon, epf);
+	if (err)
+		goto err_cleanup_common;
+
+	err = epf_vcon_setup_vdev(vcon, epf->epc->dev.parent);
+	if (err)
+		goto err_cleanup_ep_func;
+
+	return 0;
+
+err_cleanup_common:
+	epf_vcon_cleanup_common(vcon);
+
+err_cleanup_ep_func:
+	epf_vcon_cleanup_ep_func(vcon);
+
+	return err;
+}
+
+static void epf_vcon_unbind(struct pci_epf *epf)
+{
+	struct epf_vcon *vcon = epf_get_drvdata(epf);
+
+	epf_vcon_cleanup_common(vcon);
+	epf_vcon_cleanup_ep_func(vcon);
+	epf_vcon_cleanup_vdev(vcon);
+}
+
+static struct pci_epf_ops epf_vcon_ops = {
+	.bind = epf_vcon_bind,
+	.unbind = epf_vcon_unbind,
+};
+
+static const struct pci_epf_device_id epf_vcon_ids[] = {
+	{ .name = "pci_epf_vcon" },
+	{}
+};
+
+static int epf_vcon_probe(struct pci_epf *epf)
+{
+	struct epf_vcon *vcon;
+
+	vcon = devm_kzalloc(&epf->dev, sizeof(*vcon), GFP_KERNEL);
+	if (!vcon)
+		return -ENOMEM;
+
+	epf_set_drvdata(epf, vcon);
+
+	return 0;
+}
+
+static struct pci_epf_driver epf_vcon_drv = {
+	.driver.name = "pci_epf_vcon",
+	.ops = &epf_vcon_ops,
+	.id_table = epf_vcon_ids,
+	.probe = epf_vcon_probe,
+	.owner = THIS_MODULE,
+};
+
+static int __init epf_vcon_init(void)
+{
+	int err;
+
+	err = pci_epf_register_driver(&epf_vcon_drv);
+	if (err)
+		pr_err("Failed to register PCI EP virtio-console function\n");
+
+	return 0;
+}
+module_init(epf_vcon_init);
+
+static void epf_vcon_exit(void)
+{
+	pci_epf_unregister_driver(&epf_vcon_drv);
+}
+module_exit(epf_vcon_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Shunsuke Mie <mie@igel.co.jp>");
-- 
2.25.1

