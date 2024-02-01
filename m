Return-Path: <linux-pci+bounces-2933-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F27A2845C3E
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 16:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2376E1C2A75E
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 15:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A860015A486;
	Thu,  1 Feb 2024 15:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="wGwm7gwu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7256A626B3
	for <linux-pci@vger.kernel.org>; Thu,  1 Feb 2024 15:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706802949; cv=none; b=kvSLk9zuiWP2Cfigy0XO06bTnkrtHTXQibq7wq7OWpYwVffl+HBi5BRjewPOUpI6OYW2Qjx1EJcXZ+BXufiSTaf358Iyv+Ycw6qbAMlnaGwnOescZ6dw7bdqD8QNOzefAc3nlPBINCW2SGRGKQGFDund9fAtf2lFah/N8Dfvd2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706802949; c=relaxed/simple;
	bh=HGSCSkG775OjrB68wNnu+LDZG1e/YBxKF9hpfLPUJtQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l2Ecey1byt3juFcwQPNYGQYY/8G9dTLp1vNdcl9qV6svQmYsnXscdn0rgJ1DF34TiIWzk1oHB4x4uh+AFdNJ1P/eOUqGj0cz9xdXwdUEjl/f6tUyENci+o3Db0IFkjJznt9rXUXKKx+wa7Cu/oGcEb3KsC4fev5Bz8SIeBIh9KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=wGwm7gwu; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40eacb4bfa0so9457185e9.1
        for <linux-pci@vger.kernel.org>; Thu, 01 Feb 2024 07:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1706802944; x=1707407744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yw1J65h6p5XOSdrT7WKHycBFrHw6YoqtyWZ1wq8uXPg=;
        b=wGwm7gwuXsuNTHF4Uw75nakTJ3TGucIblPfPVDM4yDsHJw/OvEXNjWNZSvduoK6+r6
         1EVJ2czxIt9n9coWHoCdHRb5HD85L6A512ULzjNYa7espaI4K4cXMQPILidg9g+9FX34
         EaBW2U3KoKIk5EkfO0/LNxOOwc9hu+i1gmhZ/IJ8L7pg3h/FsVvTeIZNJtulWoz2S1kW
         y4jI+/qUnl5oA2zTVreswg5ur17ZbqV9P1vlu0n/9GuOR4jbr4biS5v7VnTGummFVjW1
         93q414IbYq70ncxt4I6APHewQMboxpl/UAu2nwgWIo/ZmgYlMJOLCBHktgkMVmMpBDms
         vKWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706802944; x=1707407744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yw1J65h6p5XOSdrT7WKHycBFrHw6YoqtyWZ1wq8uXPg=;
        b=N/nR0JbCBT2j1ivgnbFFCMlE7Pg486BsRxV2bIkL1UJdGBvROogwYbK7Nwk52K7TGY
         fjO5k6pjyCNjyG/mWRnnm2QsRXnfv36TlcoXax0+d7f+5QpfHNh/4RP8eYnptehJCFmV
         0ibzggLLXrZQzOQeLpKMdCi8/LTvzcxgkDrovpoBq7Iw8cIrDH7tFGxY+7YSPCL3yijK
         MqO73PSmFp04l6m0XjuetgNml5hRrejC6ab8gRw9858OQxOwnEJn7DMWLEaGacYpHBlR
         ee+IOc6XLce0m/Y/iKaZV4PI+EPaAGCo6BrCk+9JFbfYJt7K29GKJnsOIirOLf35oHSO
         xRJw==
X-Gm-Message-State: AOJu0YwVkLZJqVNeLvJ/kzgn8aCinhkdKKOVSuQaWj9au0rX4bg8ybg5
	BVXqyVKiO8Te0cQJIhQ+qWVF1+WdWNRlp+SKe0lpek74Fyoj3fkv0ulAuYBBx6U=
X-Google-Smtp-Source: AGHT+IHj4RxNr7NccfGnqcw2wKxJYo0zaJefMkRu7PNahtJvI1eki2FCCTXjUL4PvFiL8KAw1klipg==
X-Received: by 2002:adf:a45d:0:b0:33a:e6f0:ee05 with SMTP id e29-20020adfa45d000000b0033ae6f0ee05mr1595431wra.45.1706802944103;
        Thu, 01 Feb 2024 07:55:44 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWmHt2LuAPIpBst6IhLMW/XF6HczuhRzUvWcG6qVxTX574E5XrzgKhsNDFD2MXzJ8MYAaWybaZigmml9/1SP7uFPiS65ma68AE0KEPIt2FZsInN2UndzFsAvkvUcSoxFC1uqsxiiDXmjB2gIEzUKiqcCaF8qheJyaiCg4WfE7wySi2PswMSnGrTXWV4sB7o29EEliTcrV1grLtQ9OPSVeil1n6wuFCAgxkXpu/mvNdA0JBqUrEu9Ji4RLRzqxrpwaY41LkpuwOGooCObkriXJg7caGDh5VWqdNdPIeq42EFsuLGqw8q+yVlv9SI2VzPla3ZrygHW9q+IBx6z+M8W+viPDB6zKRqhGwYQQleddJbvpPdcxU4uZBfGvBNtjN5ReIbjnXViGNhjVIKJAPE6ukY2ZEaaCq04Cl3/GRZi23QfHYqWHD7ecaQ4AvyiAZMSYuM0F0oWelcdaHoWjvUzdaTtR+QNQ+73ZIKyJQt3fcaOtR5dfjyQOVouIK8jP+HY01XJyyrpxJcd3F72buliOVKTJCZE0rNuBuR9o190qkHgR6NYLaG3VQ/zK4nfhXzhGL4RIjBoRvg8jApS4V2I0VJpLciS8bYeLG82Ei57bSU8OYGuRShhbS8MEl4LfM+XcXDdLTZN9MZe7Ix/VhXeb4DPzN7eK38+eYRiZBZZMJ2PLZtZxD9rHCX2o0l6P2LzrqqHWGG0yLq
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:dd01:5dec:43e3:b607])
        by smtp.gmail.com with ESMTPSA id ce2-20020a5d5e02000000b0033af4848124sm9650318wrb.109.2024.02.01.07.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 07:55:43 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Alex Elder <elder@linaro.org>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Abel Vesa <abel.vesa@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lukas Wunner <lukas@wunner.de>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [RFC 3/9] power: sequencing: new subsystem
Date: Thu,  1 Feb 2024 16:55:26 +0100
Message-Id: <20240201155532.49707-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240201155532.49707-1-brgl@bgdev.pl>
References: <20240201155532.49707-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Implement the power sequencing subsystem allowing devices to share
complex powering-up and down procedures. It's split into the consumer
and provider parts but does not implement any new DT bindings so that
the actual power sequencing is never revealed in the DT representation.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/power/Kconfig             |   1 +
 drivers/power/Makefile            |   1 +
 drivers/power/sequencing/Kconfig  |  12 +
 drivers/power/sequencing/Makefile |   4 +
 drivers/power/sequencing/core.c   | 482 ++++++++++++++++++++++++++++++
 include/linux/pwrseq/consumer.h   |  53 ++++
 include/linux/pwrseq/provider.h   |  41 +++
 7 files changed, 594 insertions(+)
 create mode 100644 drivers/power/sequencing/Kconfig
 create mode 100644 drivers/power/sequencing/Makefile
 create mode 100644 drivers/power/sequencing/core.c
 create mode 100644 include/linux/pwrseq/consumer.h
 create mode 100644 include/linux/pwrseq/provider.h

diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
index 696bf77a7042..9a8e44ca9ae4 100644
--- a/drivers/power/Kconfig
+++ b/drivers/power/Kconfig
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 source "drivers/power/reset/Kconfig"
+source "drivers/power/sequencing/Kconfig"
 source "drivers/power/supply/Kconfig"
diff --git a/drivers/power/Makefile b/drivers/power/Makefile
index effbf0377f32..962a2cd30a51 100644
--- a/drivers/power/Makefile
+++ b/drivers/power/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_POWER_RESET)	+= reset/
+obj-$(CONFIG_POWER_SEQUENCING)	+= sequencing/
 obj-$(CONFIG_POWER_SUPPLY)	+= supply/
diff --git a/drivers/power/sequencing/Kconfig b/drivers/power/sequencing/Kconfig
new file mode 100644
index 000000000000..ba5732b1dbf8
--- /dev/null
+++ b/drivers/power/sequencing/Kconfig
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+menuconfig POWER_SEQUENCING
+	tristate "Power Sequencing support"
+	help
+	  Say Y here to enable the Power Sequencing subsystem.
+
+	  This subsystem is designed to control power to devices that share
+	  complex resources and/or require specific power sequences to be run
+	  during power-up.
+
+	  If unsure, say no.
diff --git a/drivers/power/sequencing/Makefile b/drivers/power/sequencing/Makefile
new file mode 100644
index 000000000000..dcdf8c0c159e
--- /dev/null
+++ b/drivers/power/sequencing/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_POWER_SEQUENCING)		+= pwrseq-core.o
+pwrseq-core-y				:= core.o
diff --git a/drivers/power/sequencing/core.c b/drivers/power/sequencing/core.c
new file mode 100644
index 000000000000..f035caed0e4e
--- /dev/null
+++ b/drivers/power/sequencing/core.c
@@ -0,0 +1,482 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 Linaro Ltd.
+ */
+
+#include <linux/bug.h>
+#include <linux/cleanup.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/export.h>
+#include <linux/idr.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/property.h>
+#include <linux/pwrseq/consumer.h>
+#include <linux/pwrseq/provider.h>
+#include <linux/rwsem.h>
+
+static DEFINE_IDA(pwrseq_ida);
+/*
+ * Protects the device list on the bus from concurrent modifications but allows
+ * simultaneous read-only access.
+ */
+static DECLARE_RWSEM(pwrseq_sem);
+
+/**
+ * struct pwrseq_device - Private power sequencing data.
+ * @dev: Device struct associated with this sequencer.
+ * @id: Device ID.
+ * @owner: Prevents removal of active power sequencing providers.
+ * @pwrup_count: Keeps track of power state change requests.
+ * @sem: Protects the device against being unregistered while in use.
+ * @drvdata: Provider driver private data.
+ * @match: Power sequencer matching callback.
+ * @power_on: Power-on callback.
+ * @power_off: Power-off callback.
+ */
+struct pwrseq_device {
+	struct device dev;
+	int id;
+	struct module *owner;
+	unsigned int pwrup_count;
+	struct rw_semaphore dev_sem;
+	struct mutex state_lock;
+	void *drvdata;
+	pwrseq_match_func match;
+	pwrseq_power_state_func power_on;
+	pwrseq_power_state_func power_off;
+};
+
+/**
+ * struct pwrseq_desc - Wraps access to the pwrseq_device and ensures that one
+ *                      user cannot break the reference counting for others.
+ * @pwrseq: Reference to the power sequencing device.
+ * @powered_up: Power state set by the holder of the descriptor (not necessarily
+ * corresponding to the actual power state of the device).
+ */
+struct pwrseq_desc {
+	struct pwrseq_device *pwrseq;
+	bool powered_up;
+};
+
+static struct pwrseq_device *to_pwrseq_device(struct device *dev)
+{
+	return container_of(dev, struct pwrseq_device, dev);
+}
+
+static struct pwrseq_device *pwrseq_device_get(struct pwrseq_device *pwrseq)
+{
+	get_device(&pwrseq->dev);
+
+	return pwrseq;
+}
+
+static void pwrseq_device_put(struct pwrseq_device *pwrseq)
+{
+	put_device(&pwrseq->dev);
+}
+
+static struct bus_type pwrseq_bus = {
+	.name = "pwrseq",
+};
+
+static void pwrseq_release(struct device *dev)
+{
+	struct pwrseq_device *pwrseq = to_pwrseq_device(dev);
+
+	mutex_destroy(&pwrseq->state_lock);
+	ida_free(&pwrseq_ida, pwrseq->id);
+	kfree(pwrseq);
+}
+
+static const struct device_type pwrseq_device_type = {
+	.name = "power_sequencer",
+	.release = pwrseq_release,
+};
+
+/**
+ * pwrseq_device_register() - Register a new power sequencer.
+ * @config: Configuration of the new power sequencing device.
+ *
+ * The config structure is only used during the call and can be freed after
+ * the function returns. The config structure *must* have the parent device
+ * as well as the match(), power_on() and power_off() callbacks registered.
+ *
+ * Returns:
+ * Returns the address of the new pwrseq device or ERR_PTR() on failure.
+ */
+struct pwrseq_device *pwrseq_device_register(struct pwrseq_config *config)
+{
+	struct pwrseq_device *pwrseq;
+	int ret;
+
+	/*
+	 * Power sequencer must have a parent device and at least the power-on,
+	 * power-off and match callbacks.
+	 */
+	if (!config->parent || !config->match || !config->power_on ||
+	    !config->power_off)
+		return ERR_PTR(-EINVAL);
+
+	pwrseq = kzalloc(sizeof(*pwrseq), GFP_KERNEL);
+	if (!pwrseq)
+		return ERR_PTR(-ENOMEM);
+
+	pwrseq->dev.type = &pwrseq_device_type;
+	pwrseq->dev.bus = &pwrseq_bus;
+	pwrseq->dev.parent = config->parent;
+	device_set_node(&pwrseq->dev, dev_fwnode(config->parent));
+
+	pwrseq->id = ida_alloc(&pwrseq_ida, GFP_KERNEL);
+	if (pwrseq->id < 0) {
+		kfree(pwrseq);
+		return ERR_PTR(pwrseq->id);
+	}
+
+	/*
+	 * From this point onwards the device's release() callback is
+	 * responsible for freeing resources.
+	 */
+	device_initialize(&pwrseq->dev);
+
+	ret = dev_set_name(&pwrseq->dev, "pwrseq.%d", pwrseq->id);
+	if (ret)
+		goto err_put_pwrseq;
+
+	pwrseq->owner = config->owner ?: THIS_MODULE;
+	pwrseq->drvdata = config->drvdata;
+	pwrseq->match = config->match;
+	pwrseq->power_on = config->power_on;
+	pwrseq->power_off = config->power_off;
+
+	init_rwsem(&pwrseq->dev_sem);
+	mutex_init(&pwrseq->state_lock);
+
+	scoped_guard(rwsem_write, &pwrseq_sem) {
+		ret = device_add(&pwrseq->dev);
+		if (ret)
+			goto err_put_pwrseq;
+	}
+
+	return pwrseq;
+
+err_put_pwrseq:
+	pwrseq_device_put(pwrseq);
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL_GPL(pwrseq_device_register);
+
+/**
+ * pwrseq_device_unregister() - Unregister the power sequencer.
+ * @pwrseq: Power sequencer to unregister.
+ */
+void pwrseq_device_unregister(struct pwrseq_device *pwrseq)
+{
+	struct device *dev = &pwrseq->dev;
+
+	scoped_guard(mutex, &pwrseq->state_lock) {
+		WARN_ONCE(pwrseq->pwrup_count > 0,
+			  "%s: UNREGISTERING POWER SEQUENCER WITH ACTIVE USERS\n",
+			  dev_name(&pwrseq->dev));
+
+		scoped_guard(rwsem_write, &pwrseq_sem) {
+			scoped_guard(rwsem_write, &pwrseq->dev_sem)
+				device_del(dev);
+		}
+	}
+
+	pwrseq_device_put(pwrseq);
+}
+EXPORT_SYMBOL_GPL(pwrseq_device_unregister);
+
+static void devm_pwrseq_device_unregister(void *data)
+{
+	struct pwrseq_device *pwrseq = data;
+
+	pwrseq_device_unregister(pwrseq);
+}
+
+/**
+ * devm_pwrseq_device_register() - Managed variant of pwrseq_device_register().
+ * @dev: Managing device.
+ * @config: Configuration of the new power sequencing device.
+ *
+ * Returns:
+ * Returns the address of the new pwrseq device or ERR_PTR() on failure.
+ */
+struct pwrseq_device *
+devm_pwrseq_device_register(struct device *dev, struct pwrseq_config *config)
+{
+	struct pwrseq_device *pwrseq;
+	int ret;
+
+	pwrseq = pwrseq_device_register(config);
+	if (IS_ERR(pwrseq))
+		return pwrseq;
+
+	ret = devm_add_action_or_reset(dev, devm_pwrseq_device_unregister,
+				       pwrseq);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return pwrseq;
+}
+EXPORT_SYMBOL_GPL(devm_pwrseq_device_register);
+
+/**
+ * pwrseq_device_get_data() - Get the driver private data associated with this
+ *                            sequencer.
+ * @pwrseq: Power sequencer object.
+ *
+ * Returns:
+ * Address of the private driver data.
+ */
+void *pwrseq_device_get_data(struct pwrseq_device *pwrseq)
+{
+	return pwrseq->drvdata;
+}
+EXPORT_SYMBOL_GPL(pwrseq_device_get_data);
+
+struct pwrseq_match_data {
+	struct pwrseq_device *matched;
+	struct device *dev;
+};
+
+static int pwrseq_match_device(struct device *pwrseq_dev, void *data)
+{
+	struct pwrseq_device *pwrseq = to_pwrseq_device(pwrseq_dev);
+	struct pwrseq_match_data *match_data = data;
+	int ret;
+
+	guard(rwsem_read)(&pwrseq->dev_sem);
+	if (!device_is_registered(&pwrseq->dev))
+		return 0;
+
+	ret = pwrseq->match(pwrseq, match_data->dev);
+	if (ret <= 0)
+		return ret;
+
+	match_data->matched = pwrseq;
+
+	return 1;
+}
+
+/**
+ * pwrseq_get() - Get the power sequencer associated with this device.
+ * @dev: Device for which to get the sequencer.
+ *
+ * Returns:
+ * New power sequencer descriptor for use by the consumer driver or ERR_PTR()
+ * on failure.
+ */
+struct pwrseq_desc *pwrseq_get(struct device *dev)
+{
+	struct pwrseq_match_data match_data;
+	struct pwrseq_device *pwrseq;
+	int ret;
+
+	struct pwrseq_desc *desc __free(kfree) = kzalloc(sizeof(*desc),
+							 GFP_KERNEL);
+	if (!desc)
+		return ERR_PTR(-ENOMEM);
+
+	match_data.matched = NULL;
+	match_data.dev = dev;
+
+	guard(rwsem_read)(&pwrseq_sem);
+
+	ret = bus_for_each_dev(&pwrseq_bus, NULL, &match_data,
+			       pwrseq_match_device);
+	if (ret < 0)
+		return ERR_PTR(ret);
+	if (ret == 0)
+		/* No device matched. */
+		return ERR_PTR(-EPROBE_DEFER);
+
+	pwrseq = match_data.matched;
+
+	if (!try_module_get(pwrseq->owner))
+		return ERR_PTR(-EPROBE_DEFER);
+
+	desc->pwrseq = pwrseq_device_get(pwrseq);
+
+	return no_free_ptr(desc);
+}
+EXPORT_SYMBOL_GPL(pwrseq_get);
+
+/**
+ * pwrseq_put() - Release the power sequencer descriptor.
+ * @desc: Descriptor to release.
+ */
+void pwrseq_put(struct pwrseq_desc *desc)
+{
+	struct pwrseq_device *pwrseq;
+
+	if (!desc)
+		return;
+
+	pwrseq = desc->pwrseq;
+
+	if (desc->powered_up)
+		pwrseq_power_off(desc);
+
+	kfree(desc);
+	module_put(pwrseq->owner);
+	pwrseq_device_put(pwrseq);
+}
+EXPORT_SYMBOL_GPL(pwrseq_put);
+
+static void devm_pwrseq_put(void *data)
+{
+	struct pwrseq_desc *desc = data;
+
+	pwrseq_put(desc);
+}
+
+/**
+ * devm_pwrseq_get() - Managed variant of pwrseq_get().
+ * @dev: Device for which to get the sequencer and which also manages its
+ *       lifetime.
+ *
+ * Returns:
+ * New power sequencer descriptor for use by the consumer driver or ERR_PTR()
+ * on failure.
+ */
+struct pwrseq_desc *devm_pwrseq_get(struct device *dev)
+{
+	struct pwrseq_desc *desc;
+	int ret;
+
+	desc = pwrseq_get(dev);
+	if (IS_ERR(desc))
+		return desc;
+
+	ret = devm_add_action_or_reset(dev, devm_pwrseq_put, desc);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return desc;
+}
+EXPORT_SYMBOL_GPL(devm_pwrseq_get);
+
+/**
+ * pwrseq_power_on() - Issue a power-on request on behalf of the consumer
+ *                     device.
+ * @desc: Descriptor referencing the power sequencer.
+ *
+ * This function tells the power sequencer that the consumer wants to be
+ * powered-up. The sequencer may already have powered-up the device in which
+ * case the function returns 0. If the power-up sequence is already in
+ * progress, the function will block until it's done and return 0. If this is
+ * the first request, the device will be powered up.
+ *
+ * Returns:
+ * 0 on success, negative error number on failure.
+ */
+int pwrseq_power_on(struct pwrseq_desc *desc)
+{
+	struct pwrseq_device *pwrseq;
+	int ret;
+
+	might_sleep();
+
+	if (!desc || desc->powered_up)
+		return 0;
+
+	pwrseq = desc->pwrseq;
+
+	guard(rwsem_read)(&pwrseq->dev_sem);
+	if (!device_is_registered(&pwrseq->dev))
+		return -ENODEV;
+
+	guard(mutex)(&pwrseq->state_lock);
+
+	pwrseq->pwrup_count++;
+	if (pwrseq->pwrup_count != 1) {
+		desc->powered_up = true;
+		return 0;
+	}
+
+	ret = pwrseq->power_on(pwrseq);
+	if (!ret)
+		desc->powered_up = true;
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pwrseq_power_on);
+
+/**
+ * pwrseq_power_off() - Issue a power-off request on behalf of the consumer
+ *                      device.
+ * @desc: Descriptor referencing the power sequencer.
+ *
+ * This undoes the effects of pwrseq_power_on(). It issues a power-off request
+ * on behalf of the consumer and when the last remaining user does so, the
+ * power-down sequence will be started. If one is in progress, the function
+ * will block until it's complete and then return.
+ *
+ * Returns:
+ * 0 on success, negative error number on failure.
+ */
+int pwrseq_power_off(struct pwrseq_desc *desc)
+{
+	struct pwrseq_device *pwrseq;
+	int ret;
+
+	might_sleep();
+
+	if (!desc || !desc->powered_up)
+		return 0;
+
+	pwrseq = desc->pwrseq;
+
+	guard(rwsem_read)(&pwrseq->dev_sem);
+	if (!device_is_registered(&pwrseq->dev))
+		return -ENODEV;
+
+	guard(mutex)(&pwrseq->state_lock);
+
+	if (pwrseq->pwrup_count == 0) {
+		WARN_ONCE(1, "Unmatched power-off\n");
+		return -EBUSY;
+	}
+
+	pwrseq->pwrup_count--;
+	if (pwrseq->pwrup_count != 0) {
+		desc->powered_up = false;
+		return 0;
+	}
+
+	ret = pwrseq->power_off(pwrseq);
+	if (!ret)
+		desc->powered_up = false;
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pwrseq_power_off);
+
+static int __init pwrseq_init(void)
+{
+	int ret;
+
+	ret = bus_register(&pwrseq_bus);
+	if (ret) {
+		pr_err("Failed to register the power sequencer bus\n");
+		return ret;
+	}
+
+	return 0;
+}
+subsys_initcall(pwrseq_init);
+
+static void __exit pwrseq_exit(void)
+{
+	bus_unregister(&pwrseq_bus);
+}
+module_exit(pwrseq_exit);
+
+MODULE_AUTHOR("Bartosz Golaszewski <bartosz.golaszewski@linaro.org>");
+MODULE_DESCRIPTION("Power Sequencing subsystem core");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/pwrseq/consumer.h b/include/linux/pwrseq/consumer.h
new file mode 100644
index 000000000000..f207b8b2864d
--- /dev/null
+++ b/include/linux/pwrseq/consumer.h
@@ -0,0 +1,53 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2024 Linaro Ltd.
+ */
+
+#ifndef __POWER_SEQUENCING_CONSUMER_H__
+#define __POWER_SEQUENCING_CONSUMER_H__
+
+#include <linux/err.h>
+
+struct device;
+struct pwrseq_desc;
+
+#if IS_ENABLED(CONFIG_POWER_SEQUENCING)
+
+struct pwrseq_desc * __must_check pwrseq_get(struct device *dev);
+void pwrseq_put(struct pwrseq_desc *desc);
+
+struct pwrseq_desc * __must_check devm_pwrseq_get(struct device *dev);
+
+int pwrseq_power_on(struct pwrseq_desc *desc);
+int pwrseq_power_off(struct pwrseq_desc *desc);
+
+#else /* CONFIG_POWER_SEQUENCING */
+
+static inline struct pwrseq_desc * __must_check pwrseq_get(struct device *dev)
+{
+	return ERR_PTR(-ENOSYS);
+}
+
+static inline void pwrseq_put(struct pwrseq_desc *desc)
+{
+}
+
+static inline struct pwrseq_desc * __must_check
+devm_pwrseq_get(struct device *dev)
+{
+	return ERR_PTR(-ENOSYS);
+}
+
+static inline int pwrseq_power_on(struct pwrseq_desc *desc)
+{
+	return -ENOSYS;
+}
+
+static inline int pwrseq_power_off(struct pwrseq_desc *desc)
+{
+	return -ENOSYS;
+}
+
+#endif /* CONFIG_POWER_SEQUENCING */
+
+#endif /* __POWER_SEQUENCING_CONSUMER_H__ */
diff --git a/include/linux/pwrseq/provider.h b/include/linux/pwrseq/provider.h
new file mode 100644
index 000000000000..8696a89afa43
--- /dev/null
+++ b/include/linux/pwrseq/provider.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2024 Linaro Ltd.
+ */
+
+#ifndef __POWER_SEQUENCING_PROVIDER_H__
+#define __POWER_SEQUENCING_PROVIDER_H__
+
+struct device;
+struct module;
+struct pwrseq_device;
+
+typedef int (*pwrseq_power_state_func)(struct pwrseq_device *);
+typedef int (*pwrseq_match_func)(struct pwrseq_device *, struct device *);
+
+/**
+ * struct pwrseq_config - Configuration used for registering a new provider.
+ * @parent: Parent device for the sequencer.
+ * @owner: Module providing this device.
+ * @drvdata: Private driver data.
+ * @match: Provider callback used to match the consumer device to the sequencer.
+ * @power_on: Callback running the power-on sequence.
+ * @power_off: Callback running the power-off sequence.
+ */
+struct pwrseq_config {
+	struct device *parent;
+	struct module *owner;
+	void *drvdata;
+	pwrseq_match_func match;
+	pwrseq_power_state_func power_on;
+	pwrseq_power_state_func power_off;
+};
+
+struct pwrseq_device *pwrseq_device_register(struct pwrseq_config *config);
+void pwrseq_device_unregister(struct pwrseq_device *pwrseq);
+struct pwrseq_device *
+devm_pwrseq_device_register(struct device *dev, struct pwrseq_config *config);
+
+void *pwrseq_device_get_data(struct pwrseq_device *pwrseq);
+
+#endif /* __POWER_SEQUENCING_PROVIDER_H__ */
-- 
2.40.1


