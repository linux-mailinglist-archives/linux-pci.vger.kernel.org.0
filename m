Return-Path: <linux-pci+bounces-44211-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B116CCFF408
	for <lists+linux-pci@lfdr.de>; Wed, 07 Jan 2026 19:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 44132303C621
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jan 2026 17:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12A3388DB8;
	Wed,  7 Jan 2026 17:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="oXBVpsYP"
X-Original-To: linux-pci@vger.kernel.org
Received: from sg-1-104.ptr.blmpb.com (sg-1-104.ptr.blmpb.com [118.26.132.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE4E3876B2
	for <linux-pci@vger.kernel.org>; Wed,  7 Jan 2026 17:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767808657; cv=none; b=Rdc7v0Cf0YCttwRpkzaXe0plPkoglbf6vcVvv3Ui+mIK2s6vR/tNzlevUQxtFkXiQGU+Y24tFB8MzCijqherRuxt5uI57Zg7UW+9ErwJtq3fxG+sJLcUC5ymB1ELNAbCDtQ0O3brCxX2zPEHvVbYcugbqurljDCO8cq17zz8wbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767808657; c=relaxed/simple;
	bh=b+TZD4bsSQJ/2i+M96EFoDPZ1Q4PSbPM4m0GGIZsXkU=;
	h=To:In-Reply-To:Mime-Version:Message-Id:References:Content-Type:Cc:
	 From:Subject:Date; b=kC5ppD4++gGyCX1Z63JbJ1NqnQCQfKdzjkEnHPJvsWO8vJSC2IhK7wzz8DKeV0rLB3sMnqw4x6whPnztjvhmW2Ck3BRN9DNnJkJ6X9kPitRD2PRLw7R1ljiyKJGMFYqSKNP/YeYL+nhop3hZOFQcbeiPqadetvXdadDB7Cuiibs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=oXBVpsYP; arc=none smtp.client-ip=118.26.132.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1767808649; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=JTt8+yrsjnbVmvLy1n783Eg49SQZIHOAn/X1fUoS2Cg=;
 b=oXBVpsYPJ+oHwZ1aKQq7rPyrtrk8UKIj8XLI5oKChOguzx8X1tsm6ApeCjBBsFoPdCLvAg
 xrIeJrkcNcnZ1clT+0ULJToZfMxxZGIxU7lJDRIfGW70M6KP+BuS+rVfem3YDq+xH7D5V2
 ze8Xy8HWTQMQKxrqn6LjUaJ0phpGifhtr1QoNsGeZjRn9ToCP+HUvj25ZwyFvQfsXyVeFX
 21p6Yk7DzbwEi4Wffdg2I66L7UoMBybUVBTJDAhNQS6K5XpRXMswVH2d2Zwn8eDj/tkUoc
 pfHsA4Ps2IT5GEieZXOGeWv1jPF6Jjrt4duB6lm1kbGDmhFekfmI/0e50o4BcQ==
To: <dakr@kernel.org>, <alexander.h.duyck@linux.intel.com>, 
	<alexanderduyck@fb.com>, <bhelgaas@google.com>, <bvanassche@acm.org>, 
	<dan.j.williams@intel.com>, <gregkh@linuxfoundation.org>, 
	<helgaas@kernel.org>, <rafael@kernel.org>, <tj@kernel.org>
In-Reply-To: <20260107175548.1792-1-guojinhui.liam@bytedance.com>
X-Original-From: Jinhui Guo <guojinhui.liam@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260107175548.1792-3-guojinhui.liam@bytedance.com>
X-Mailer: git-send-email 2.17.1
References: <20260107175548.1792-1-guojinhui.liam@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Cc: <guojinhui.liam@bytedance.com>, <linux-kernel@vger.kernel.org>, 
	<linux-pci@vger.kernel.org>
From: "Jinhui Guo" <guojinhui.liam@bytedance.com>
Subject: [PATCH 2/3] driver core: Add NUMA-node awareness to the synchronous probe path
Date: Thu,  8 Jan 2026 01:55:47 +0800
X-Lms-Return-Path: <lba+2695e9e87+88cf9d+vger.kernel.org+guojinhui.liam@bytedance.com>

Introduce NUMA-node-aware synchronous probing: drivers
can initialize and allocate memory on the device=E2=80=99s local
node without scattering kmalloc_node() calls throughout
the code.

NUMA-aware probing was first added to PCI drivers by
commit d42c69972b85 ("[PATCH] PCI: Run PCI driver
initialization on local node") in 2005 and has benefited
PCI drivers ever since.

The asynchronous probe path already supports NUMA-node-aware
probing via async_schedule_dev() in the driver core. Since
NUMA affinity is orthogonal to sync/async probing, this
patch adds NUMA-node-aware support to the synchronous
probe path.

Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
---
 drivers/base/dd.c | 104 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 101 insertions(+), 3 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 896f98add97d..e1fb10ae2cc0 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -381,6 +381,92 @@ static void __exit deferred_probe_exit(void)
 }
 __exitcall(deferred_probe_exit);
=20
+/*
+ * NUMA-node-aware synchronous probing:
+ * drivers can initialize and allocate memory on the device=E2=80=99s loca=
l
+ * node without scattering kmalloc_node() calls throughout the code.
+ */
+
+/* Generic function pointer type */
+typedef int (*numa_func_t)(void *arg1, void *arg2);
+
+/* Context for NUMA execution */
+struct numa_work_ctx {
+	struct work_struct work;
+	numa_func_t func;
+	void *arg1;
+	void *arg2;
+	int result;
+};
+
+/* Worker function running on the target node */
+static void numa_work_func(struct work_struct *work)
+{
+	struct numa_work_ctx *ctx =3D container_of(work, struct numa_work_ctx, wo=
rk);
+
+	ctx->result =3D ctx->func(ctx->arg1, ctx->arg2);
+}
+
+/*
+ * __exec_on_numa_node - Execute a function on a specific NUMA node synchr=
onously
+ * @node: Target NUMA node ID
+ * @func: The wrapper function to execute
+ * @arg1: First argument (void *)
+ * @arg2: Second argument (void *)
+ *
+ * Returns the result of the function execution, or -ENODEV if initializat=
ion fails.
+ * If the node is invalid or offline, it falls back to local execution.
+ */
+static int __exec_on_numa_node(int node, numa_func_t func, void *arg1, voi=
d *arg2)
+{
+	struct numa_work_ctx ctx;
+
+	/* Fallback to local execution if the node is invalid or offline */
+	if (node < 0 || node >=3D MAX_NUMNODES || !node_online(node))
+		return func(arg1, arg2);
+
+	ctx.func =3D func;
+	ctx.arg1 =3D arg1;
+	ctx.arg2 =3D arg2;
+	ctx.result =3D -ENODEV;
+	INIT_WORK_ONSTACK(&ctx.work, numa_work_func);
+
+	/* Use system_dfl_wq to allow execution on the specific node. */
+	queue_work_node(node, system_dfl_wq, &ctx.work);
+	flush_work(&ctx.work);
+	destroy_work_on_stack(&ctx.work);
+
+	return ctx.result;
+}
+
+/*
+ * DEFINE_NUMA_WRAPPER - Generate a type-safe wrapper for a function
+ * @func_name: The name of the target function
+ * @type1: The type of the first argument
+ * @type2: The type of the second argument
+ *
+ * This macro generates a static function named __wrapper_<func_name> that
+ * casts void pointers back to their original types and calls the target f=
unction.
+ */
+#define DEFINE_NUMA_WRAPPER(func_name, type1, type2)			\
+	static int __wrapper_##func_name(void *arg1, void *arg2)	\
+	{								\
+		return func_name((type1)arg1, (type2)arg2);		\
+	}
+
+/*
+ * EXEC_ON_NUMA_NODE - Execute a registered function on a NUMA node
+ * @node: Target NUMA node ID
+ * @func_name: The name of the target function (must be registered via DEF=
INE_NUMA_WRAPPER)
+ * @arg1: First argument
+ * @arg2: Second argument
+ *
+ * This macro invokes the internal execution helper using the generated wr=
apper.
+ */
+#define EXEC_ON_NUMA_NODE(node, func_name, arg1, arg2)		\
+	__exec_on_numa_node(node, __wrapper_##func_name,	\
+			(void *)(arg1), (void *)(arg2))
+
 /**
  * device_is_bound() - Check if device is bound to a driver
  * @dev: device to check
@@ -808,6 +894,8 @@ static int __driver_probe_device(const struct device_dr=
iver *drv, struct device
 	return ret;
 }
=20
+DEFINE_NUMA_WRAPPER(__driver_probe_device, const struct device_driver *, s=
truct device *)
+
 /**
  * driver_probe_device - attempt to bind device & driver together
  * @drv: driver to bind a device to
@@ -844,6 +932,8 @@ static int driver_probe_device(const struct device_driv=
er *drv, struct device *d
 	return ret;
 }
=20
+DEFINE_NUMA_WRAPPER(driver_probe_device, const struct device_driver *, str=
uct device *)
+
 static inline bool cmdline_requested_async_probing(const char *drv_name)
 {
 	bool async_drv;
@@ -1000,6 +1090,8 @@ static int __device_attach_driver_scan(struct device_=
attach_data *data,
 	return ret;
 }
=20
+DEFINE_NUMA_WRAPPER(__device_attach_driver_scan, struct device_attach_data=
 *, bool *)
+
 static void __device_attach_async_helper(void *_dev, async_cookie_t cookie=
)
 {
 	struct device *dev =3D _dev;
@@ -1055,7 +1147,9 @@ static int __device_attach(struct device *dev, bool a=
llow_async)
 			.want_async =3D false,
 		};
=20
-		ret =3D __device_attach_driver_scan(&data, &async);
+		ret =3D EXEC_ON_NUMA_NODE(dev_to_node(dev),
+					__device_attach_driver_scan,
+					&data, &async);
 	}
 out_unlock:
 	device_unlock(dev);
@@ -1142,7 +1236,9 @@ int device_driver_attach(const struct device_driver *=
drv, struct device *dev)
 	int ret;
=20
 	__device_driver_lock(dev, dev->parent);
-	ret =3D __driver_probe_device(drv, dev);
+	ret =3D EXEC_ON_NUMA_NODE(dev_to_node(dev),
+				__driver_probe_device,
+				drv, dev);
 	__device_driver_unlock(dev, dev->parent);
=20
 	/* also return probe errors as normal negative errnos */
@@ -1231,7 +1327,9 @@ static int __driver_attach(struct device *dev, void *=
data)
 	}
=20
 	__device_driver_lock(dev, dev->parent);
-	driver_probe_device(drv, dev);
+	EXEC_ON_NUMA_NODE(dev_to_node(dev),
+			  driver_probe_device,
+			  drv, dev);
 	__device_driver_unlock(dev, dev->parent);
=20
 	return 0;
--=20
2.20.1

