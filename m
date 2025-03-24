Return-Path: <linux-pci+bounces-24512-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83CD7A6D800
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 11:04:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 043F116D2C9
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 10:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF30C25DAF4;
	Mon, 24 Mar 2025 10:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="air3YVQ8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1711136988;
	Mon, 24 Mar 2025 10:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742810678; cv=none; b=XtB7oJiLCx6KC0Jr9wUYZgZDTd037A4DDMyzE+BZ8smQhmU3x9j4a29nFYS8V2oMQ3d9vo9mvKc8Omo4S4RNYNdVJVMIIaFbVpiJ50Ib5HzWTn+oknhxFhB7BY50dQ6YkJDdiATczb3W6+btCBwVOrnOKKX4TaRK7wGpGrtWhE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742810678; c=relaxed/simple;
	bh=tFMGfw5P2Zzx9Mq2scZrMcZwQMbl6eBHv+dDOU7FTek=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l0bdLdgiqch+Xn0pR4ueOs8O6X+1/tj99bw2jwLDC7xGruJwhwiugFEF5dZhCbnDmBJQ7upsc3JNODO7jQA3Jxjtt2PaIFHETb+/kZqsSXxPxpGTIefdZPxI67edAXyA/Rrw3N+3A7Ygd50XVIc4JHC5cmDBnQCOKPb22ykBUjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=air3YVQ8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2FA74C4CEED;
	Mon, 24 Mar 2025 10:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742810678;
	bh=tFMGfw5P2Zzx9Mq2scZrMcZwQMbl6eBHv+dDOU7FTek=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=air3YVQ8BKc7vQQIwRx73TJwEyDytmYRvhKioMXPY21986+nYZyizZBgnPOp+kFwT
	 wFjdwk5tqfOZPj76kh3ZQzUSD8viWx9DxpJRVY79ooRiotwqjxe/FQMg0uLqmOmq7d
	 Yjylv9M6LWTz2YVJWw0hyd0kExRZRGExrFDELF9oEqBGY8v57ObOyWsXGjc9DYlled
	 zEVB0SZvq3vS5oEwllgWsD05tyG2pW4IfMZA6Agna2cpqlih5U7FPVyZY+0p1U1P18
	 i9mDjTJZAEjkUr1HbsuxuGkQJIM9fqGB1rkayytcBhBE+kF1f5qVBNU0Lw+np6TOty
	 8q5WDxrZVYooQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE30C3600C;
	Mon, 24 Mar 2025 10:04:38 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Mon, 24 Mar 2025 15:34:35 +0530
Subject: [PATCH v2 1/3] PCI: Add sysfs support for exposing PTM context
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250324-pcie-ptm-v2-1-c7d8c3644b4a@linaro.org>
References: <20250324-pcie-ptm-v2-0-c7d8c3644b4a@linaro.org>
In-Reply-To: <20250324-pcie-ptm-v2-0-c7d8c3644b4a@linaro.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Jingoo Han <jingoohan1@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=14688;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=zezY3dQQZG9zcCyHsgrmPX2/nGvny3C7hcw/qPf1FvI=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBn4S4zON2kO+RMzKhuoFyMVxaiWoVISY6DtnKXN
 nTq9j/tkc2JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZ+EuMwAKCRBVnxHm/pHO
 9fV7CACT2jZT2NRmMrydFWQKno4ChWtij80L/6dPxufzh3YabwitzSsFYsabHVox6PNWIUB9xxp
 Psk6N/c98TPS5AlydjotpoVAAngywkpWpETh9xX/T7IoPOMx1ZEC8xl4h/aC/+MkOOECqmo3ehq
 1+Flno6RddqfqHD5fq+5vvXJAyToETWTF1Pvc3Dxvrq+MITMZvdpOg/jd2mAxx6CxSkACBilpGi
 GejAAIYplxv11hh/qZnoRAnMZD+FViqyhsxKdZkVQpUqBkxKque5EoQvovkyPm7omZLGjt9xGnu
 qu8QC8ufmNAotGSYmoGefG7BqYYtmyiQK5YbJCQ3SE78ndcb
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@linaro.org/default with auth_id=185
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reply-To: manivannan.sadhasivam@linaro.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Precision Time Management (PTM) mechanism defined in PCIe spec r6.0,
sec 6.22 allows precise coordination of timing information across multiple
components in a PCIe hierarchy with independent local time clocks.

PCI core already supports enabling PTM in the root port and endpoint
devices through PTM Extended Capability registers. But the PTM context
supported by the PTM capable components such as Root Complex (RC) and
Endpoint (EP) controllers were not exposed as of now.

Hence, add the sysfs support to expose the PTM context to userspace from
both PCIe RC and EP controllers. Controller drivers are expected to call
pcie_ptm_create_sysfs() to create the sysfs attributes for the PTM context
and call pcie_ptm_destroy_sysfs() to destroy them. The drivers should also
populate the relevant callbacks in the 'struct pcie_ptm_ops' structure
based on the controller implementation.

Below PTM context are exposed through sysfs:

PCIe RC
=======

1. PTM Local clock
2. PTM T2 timestamp
3. PTM T3 timestamp
4. PTM Context valid

PCIe EP
=======

1. PTM Local clock
2. PTM T1 timestamp
3. PTM T4 timestamp
4. PTM Master clock
5. PTM Context update

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/ABI/testing/sysfs-platform-pcie-ptm |  70 ++++++
 MAINTAINERS                                       |   1 +
 drivers/pci/pcie/ptm.c                            | 268 ++++++++++++++++++++++
 include/linux/pci.h                               |  35 +++
 4 files changed, 374 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-platform-pcie-ptm b/Documentation/ABI/testing/sysfs-platform-pcie-ptm
new file mode 100644
index 0000000000000000000000000000000000000000..010c3e32e2b8eaf352a8e1aad7420d8a3e948dae
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-platform-pcie-ptm
@@ -0,0 +1,70 @@
+What:		/sys/devices/platform/*/ptm/local_clock
+Date:		February 2025
+Contact:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+Description:
+		(RO) PTM local clock in nanoseconds. Applicable for both Root
+		Complex and Endpoint controllers.
+
+What:		/sys/devices/platform/*/ptm/master_clock
+Date:		February 2025
+Contact:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+Description:
+		(RO) PTM master clock in nanoseconds. Applicable only for
+		Endpoint controllers.
+
+What:		/sys/devices/platform/*/ptm/t1
+Date:		February 2025
+Contact:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+Description:
+		(RO) PTM T1 timestamp in nanoseconds. Applicable only for
+		Endpoint controllers.
+
+What:		/sys/devices/platform/*/ptm/t2
+Date:		February 2025
+Contact:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+Description:
+		(RO) PTM T2 timestamp in nanoseconds. Applicable only for
+		Root Complex controllers.
+
+What:		/sys/devices/platform/*/ptm/t3
+Date:		February 2025
+Contact:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+Description:
+		(RO) PTM T3 timestamp in nanoseconds. Applicable only for
+		Root Complex controllers.
+
+What:		/sys/devices/platform/*/ptm/t4
+Date:		February 2025
+Contact:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+Description:
+		(RO) PTM T4 timestamp in nanoseconds. Applicable only for
+		Endpoint controllers.
+
+What:		/sys/devices/platform/*/ptm/context_update
+Date:		February 2025
+Contact:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+Description:
+		(RW) Control the PTM context update mode. Applicable only for
+		Endpoint controllers.
+
+		Following values are supported:
+
+		* auto = PTM context auto update trigger for every 10ms
+
+		* manual = PTM context manual update. Writing 'manual' to this
+			   file triggers PTM context update (default)
+
+What:		/sys/devices/platform/*/ptm/context_valid
+Date:		February 2025
+Contact:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+Description:
+		(RW) Control the PTM context validity (local clock timing).
+		Applicable only for Root Complex controllers. PTM context is
+		invalidated by hardware if the Root Complex enters low power
+		mode or changes link frequency.
+
+		Following values are supported:
+
+		* 0 = PTM context invalid (default)
+
+		* 1 = PTM context valid
diff --git a/MAINTAINERS b/MAINTAINERS
index b4d09d52a750b320f689c1365791cdfa6e719fde..f1bac092877df739328347481bd14f6701a7df19 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18213,6 +18213,7 @@ Q:	https://patchwork.kernel.org/project/linux-pci/list/
 B:	https://bugzilla.kernel.org
 C:	irc://irc.oftc.net/linux-pci
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git
+F:	Documentation/ABI/testing/sysfs-platform-pcie-ptm
 F:	Documentation/devicetree/bindings/pci/
 F:	drivers/pci/controller/
 F:	drivers/pci/pci-bridge-emul.c
diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
index 7cfb6c0d5dcb6de2a759b56d6877c95102b3d10f..bfa632b76a87ad304e966a8edfb5dba14d58a23c 100644
--- a/drivers/pci/pcie/ptm.c
+++ b/drivers/pci/pcie/ptm.c
@@ -10,6 +10,8 @@
 #include <linux/pci.h>
 #include "../pci.h"
 
+struct device *ptm_device;
+
 /*
  * If the next upstream device supports PTM, return it; otherwise return
  * NULL.  PTM Messages are local, so both link partners must support it.
@@ -252,3 +254,269 @@ bool pcie_ptm_enabled(struct pci_dev *dev)
 	return dev->ptm_enabled;
 }
 EXPORT_SYMBOL(pcie_ptm_enabled);
+
+static ssize_t context_update_store(struct device *dev,
+			      struct device_attribute *attr,
+			      const char *buf, size_t count)
+{
+	struct pcie_ptm *ptm = dev_get_drvdata(dev);
+	int ret;
+
+	if (!ptm->ops->context_update_store)
+		return -EOPNOTSUPP;
+
+	ret = ptm->ops->context_update_store(ptm->pdata, buf);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static ssize_t context_update_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	struct pcie_ptm *ptm = dev_get_drvdata(dev);
+
+	if (!ptm->ops->context_update_show)
+		return -EOPNOTSUPP;
+
+	return ptm->ops->context_update_show(ptm->pdata, buf);
+}
+
+static ssize_t context_valid_store(struct device *dev,
+			      struct device_attribute *attr,
+			      const char *buf, size_t count)
+{
+	struct pcie_ptm *ptm = dev_get_drvdata(dev);
+	unsigned long arg;
+	int ret;
+
+	if (kstrtoul(buf, 0, &arg) < 0)
+		return -EINVAL;
+
+	if (!ptm->ops->context_valid_store)
+		return -EOPNOTSUPP;
+
+	ret = ptm->ops->context_valid_store(ptm->pdata, !!arg);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static ssize_t context_valid_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	struct pcie_ptm *ptm = dev_get_drvdata(dev);
+
+	if (!ptm->ops->context_valid_show)
+		return -EOPNOTSUPP;
+
+	return ptm->ops->context_valid_show(ptm->pdata, buf);
+}
+
+static ssize_t local_clock_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	struct pcie_ptm *ptm = dev_get_drvdata(dev);
+
+	if (!ptm->ops->local_clock_show)
+		return -EOPNOTSUPP;
+
+	return ptm->ops->local_clock_show(ptm->pdata, buf);
+}
+
+static ssize_t master_clock_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	struct pcie_ptm *ptm = dev_get_drvdata(dev);
+
+	if (!ptm->ops->master_clock_show)
+		return -EOPNOTSUPP;
+
+	return ptm->ops->master_clock_show(ptm->pdata, buf);
+}
+
+static ssize_t t1_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	struct pcie_ptm *ptm = dev_get_drvdata(dev);
+
+	if (!ptm->ops->t1_show)
+		return -EOPNOTSUPP;
+
+	return ptm->ops->t1_show(ptm->pdata, buf);
+}
+
+static ssize_t t2_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	struct pcie_ptm *ptm = dev_get_drvdata(dev);
+
+	if (!ptm->ops->t2_show)
+		return -EOPNOTSUPP;
+
+	return ptm->ops->t2_show(ptm->pdata, buf);
+}
+
+static ssize_t t3_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	struct pcie_ptm *ptm = dev_get_drvdata(dev);
+
+	if (!ptm->ops->t3_show)
+		return -EOPNOTSUPP;
+
+	return ptm->ops->t3_show(ptm->pdata, buf);
+}
+
+static ssize_t t4_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	struct pcie_ptm *ptm = dev_get_drvdata(dev);
+
+	if (!ptm->ops->t4_show)
+		return -EOPNOTSUPP;
+
+	return ptm->ops->t4_show(ptm->pdata, buf);
+}
+
+static DEVICE_ATTR_RW(context_update);
+static DEVICE_ATTR_RW(context_valid);
+static DEVICE_ATTR_RO(local_clock);
+static DEVICE_ATTR_RO(master_clock);
+static DEVICE_ATTR_RO(t1);
+static DEVICE_ATTR_RO(t2);
+static DEVICE_ATTR_RO(t3);
+static DEVICE_ATTR_RO(t4);
+
+static struct attribute *pcie_ptm_attrs[] = {
+	&dev_attr_context_update.attr,
+	&dev_attr_context_valid.attr,
+	&dev_attr_local_clock.attr,
+	&dev_attr_master_clock.attr,
+	&dev_attr_t1.attr,
+	&dev_attr_t2.attr,
+	&dev_attr_t3.attr,
+	&dev_attr_t4.attr,
+	NULL
+};
+
+static umode_t pcie_ptm_attr_visible(struct kobject *kobj, struct attribute *attr,
+				int n)
+{
+	struct device *dev = container_of(kobj, struct device, kobj);
+	struct pcie_ptm *ptm = dev_get_drvdata(dev);
+
+	if ((attr == &dev_attr_t1.attr && ptm->ops->t1_visible &&
+	     ptm->ops->t1_visible(ptm->pdata)) ||
+	    (attr == &dev_attr_t2.attr && ptm->ops->t2_visible &&
+	     ptm->ops->t2_visible(ptm->pdata)) ||
+	    (attr == &dev_attr_t3.attr && ptm->ops->t3_visible &&
+	     ptm->ops->t3_visible(ptm->pdata)) ||
+	    (attr == &dev_attr_t4.attr && ptm->ops->t4_visible &&
+	     ptm->ops->t4_visible(ptm->pdata)) ||
+	    (attr == &dev_attr_local_clock.attr &&
+	     ptm->ops->local_clock_visible &&
+	     ptm->ops->local_clock_visible(ptm->pdata)) ||
+	    (attr == &dev_attr_master_clock.attr &&
+	     ptm->ops->master_clock_visible &&
+	     ptm->ops->master_clock_visible(ptm->pdata)) ||
+	    (attr == &dev_attr_context_update.attr &&
+	     ptm->ops->context_update_visible &&
+	     ptm->ops->context_update_visible(ptm->pdata)) ||
+	    (attr == &dev_attr_context_valid.attr &&
+	     ptm->ops->context_valid_visible &&
+	     ptm->ops->context_valid_visible(ptm->pdata)))
+		return attr->mode;
+
+	return 0;
+}
+
+static const struct attribute_group pcie_ptm_attr_group = {
+	.attrs = pcie_ptm_attrs,
+	.is_visible = pcie_ptm_attr_visible,
+};
+
+static const struct attribute_group *pcie_ptm_attr_groups[] = {
+	&pcie_ptm_attr_group,
+	NULL,
+};
+
+static void pcie_ptm_release(struct device *dev)
+{
+	struct pcie_ptm *ptm = container_of(dev, struct pcie_ptm, dev);
+
+	kfree(ptm);
+}
+
+/*
+ * pcie_ptm_create_sysfs() - Create sysfs entries for the PTM context
+ * @dev: PTM capable component device
+ * @pdata: Private data of the PTM capable component device
+ * @ops: PTM callback structure
+ *
+ * Create sysfs entries for exposing the PTM context of the PTM capable
+ * components such as Root Complex and Endpoint controllers.
+ */
+int pcie_ptm_create_sysfs(struct device *dev, void *pdata,
+			  struct pcie_ptm_ops *ops)
+{
+	struct pcie_ptm *ptm;
+	int ret;
+
+	/* Caller must provide check_capability() callback */
+	if (!ops->check_capability)
+		return -EINVAL;
+
+	/* Check for PTM capability before creating sysfs attrbutes */
+	ret = ops->check_capability(pdata);
+	if (!ret) {
+		dev_dbg(dev, "PTM capability not present\n");
+		return -ENODATA;
+	}
+
+	ptm = kzalloc(sizeof(*ptm), GFP_KERNEL);
+	if (!ptm)
+		return -ENOMEM;
+
+	ptm->pdata = pdata;
+	ptm->ops = ops;
+
+	device_initialize(&ptm->dev);
+	ptm->dev.groups = pcie_ptm_attr_groups;
+	ptm->dev.release = pcie_ptm_release;
+	ptm->dev.parent = dev;
+	dev_set_drvdata(&ptm->dev, ptm);
+	device_set_pm_not_required(&ptm->dev);
+
+	ret = dev_set_name(&ptm->dev, "ptm");
+	if (ret)
+		goto err_put_device;
+
+	ret = device_add(&ptm->dev);
+	if (ret)
+		goto err_put_device;
+
+	ptm_device = &ptm->dev;
+
+	return 0;
+
+err_put_device:
+	put_device(&ptm->dev);
+
+	return ret;
+}
+EXPORT_SYMBOL(pci_ptm_init);
+
+/*
+ * pcie_ptm_destroy_sysfs() - Destroy sysfs entries for the PTM context
+ */
+void pcie_ptm_destroy_sysfs(void)
+{
+	if (ptm_device) {
+		device_unregister(ptm_device);
+		ptm_device = NULL;
+	}
+}
+EXPORT_SYMBOL(pcie_ptm_destroy_sysfs);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 47b31ad724fa5bf7abd7c3dc572947551b0f2148..42bb3cf0212e96fd65a1f01410ef70c82491c9eb 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1857,16 +1857,51 @@ static inline bool pci_aer_available(void) { return false; }
 
 bool pci_ats_disabled(void);
 
+struct pcie_ptm_ops {
+	int (*check_capability)(void *drvdata);
+	int (*context_update_store)(void *drvdata, const char *buf);
+	ssize_t (*context_update_show)(void *drvdata, char *buf);
+	int (*context_valid_store)(void *drvdata, bool valid);
+	ssize_t (*context_valid_show)(void *drvdata, char *buf);
+	ssize_t (*local_clock_show)(void *drvdata, char *buf);
+	ssize_t (*master_clock_show)(void *drvdata, char *buf);
+	ssize_t (*t1_show)(void *drvdata, char *buf);
+	ssize_t (*t2_show)(void *drvdata, char *buf);
+	ssize_t (*t3_show)(void *drvdata, char *buf);
+	ssize_t (*t4_show)(void *drvdata, char *buf);
+
+	bool (*context_update_visible)(void *drvdata);
+	bool (*context_valid_visible)(void *drvdata);
+	bool (*local_clock_visible)(void *drvdata);
+	bool (*master_clock_visible)(void *drvdata);
+	bool (*t1_visible)(void *drvdata);
+	bool (*t2_visible)(void *drvdata);
+	bool (*t3_visible)(void *drvdata);
+	bool (*t4_visible)(void *drvdata);
+};
+
+struct pcie_ptm {
+	struct device dev;
+	struct pcie_ptm_ops *ops;
+	void *pdata;
+};
+
 #ifdef CONFIG_PCIE_PTM
 int pci_enable_ptm(struct pci_dev *dev, u8 *granularity);
 void pci_disable_ptm(struct pci_dev *dev);
 bool pcie_ptm_enabled(struct pci_dev *dev);
+int pcie_ptm_create_sysfs(struct device *dev, void *pdata, struct pcie_ptm_ops *ops);
+void pcie_ptm_destroy_sysfs(void);
 #else
 static inline int pci_enable_ptm(struct pci_dev *dev, u8 *granularity)
 { return -EINVAL; }
 static inline void pci_disable_ptm(struct pci_dev *dev) { }
 static inline bool pcie_ptm_enabled(struct pci_dev *dev)
 { return false; }
+static inline int pcie_ptm_create_sysfs(struct device *dev, void *pdata,
+				 struct pcie_ptm_ops *ops)
+{ return 0; }
+static inline void pcie_ptm_destroy_sysfs(void) { }
 #endif
 
 void pci_cfg_access_lock(struct pci_dev *dev);

-- 
2.43.0



