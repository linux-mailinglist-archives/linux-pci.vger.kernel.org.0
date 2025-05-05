Return-Path: <linux-pci+bounces-27156-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD852AA95B7
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 16:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 068B0189C338
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 14:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8529B25B677;
	Mon,  5 May 2025 14:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BZl+NFMS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F7825C81E
	for <linux-pci@vger.kernel.org>; Mon,  5 May 2025 14:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746455097; cv=none; b=fBVq19Grtsb63v21jTDKTwtS2cna8F1hL5UWLUpnSDSm76qijH8uTGc7UsWINlKNuKPsbuuntReB9/XO1+zlB4ZICWHqdoohjVvl5hjFi8KyjtC2nKosPre1JTJPxJUYEeh8roTcrLzWn4TVUYEUaPT+IZgAuvU8vj+Tqvox04I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746455097; c=relaxed/simple;
	bh=PIJJuIo0WWiuIyDDRXq9UASTpe1jw1llrrNtGuVW11s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SNxntXKTq/PVnByVRD8RKUxb8WDdfpBy66TUQRlDbLmkqK194HEVRtyCLmph9A8oYosUXoz+g9GYtvtoTGH+knTw9pnxAVETQ7nPRh/AM68q0NHtIWo611+EB05cVEzTII/3WwXqTtGaYBQQgZQTzekE8NIfOil/vn2SQkCA1yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BZl+NFMS; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-309f3bf23b8so5926445a91.3
        for <linux-pci@vger.kernel.org>; Mon, 05 May 2025 07:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746455094; x=1747059894; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=751W6HsTSqKy70Fw8gN5BRp8NNTJrOdqpNG0Ub+APL0=;
        b=BZl+NFMSyLJMtqQPNwSzWyG57V4fnO/3fxw2pVY0P3XxHLGSY2eUMNdLeT5Fvuu6wO
         tK/drtzQvZQuqjxTK5HXPVVNy9/f9AixacRWvphNFbcu3AAfV9PfElq578w7G/Kyoei3
         YFjPmD4jO+DW7kCb8GmuGa9pgj7dxlKKBRwEfb50QTOBIZ8K8IhPm67J/F+sg6VH9AAb
         OG1K6WzaBgcWY2F9uQTX9bfKQAxXZUf44XnJK7GiXF5WCMLGqO517D9YEzryLaBAaigl
         Bx49yaUul4YgvxFb6+8rdB75IA/5i48zv4FXRhu5EvBrjOGoAifYAB4EXq1gBztTlN6c
         oo8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746455094; x=1747059894;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=751W6HsTSqKy70Fw8gN5BRp8NNTJrOdqpNG0Ub+APL0=;
        b=sWjenL1vQe9eGbxCyrq/uGDx2bwr8YKVTIztJw3fpRBP5Ig12O0gAGuXAwdxahKu2J
         ZXeRQoyyNCsEJfCg1gt1raFaShSGw174LSBHNe8unv9UF1rexbe2+4EAg1LIGmEoMQW/
         Vi9mKD7HKjdLpwOHwWU/kL8b926VNsXmW4VsUna1AjpVlxuZhobxO7Fd+SVCJ9H7bbQD
         XTK78CgF02PZw/DdPQYe3CunXpPHGOM6wA+8EUsxGWJHjMHTJrxcdJKbapFEnl/i62nk
         J1DnO6eVQFq0cwcPj1lthkmA9lOWG31L5ExTNndDplSpzyLLw5LEpZyZLwaSUG8WbmrT
         1OQw==
X-Gm-Message-State: AOJu0Yzlwzu8nm7bf3MaouTC/2E1AE1OP8Rf0kgAJwaBNaWKLz4JJPzw
	8rGQR0wEbo28DLt0qaRYqsQkDfLjjjKdzg103ZSaF2mE+7poz2mxRWBoYMVfVQ==
X-Gm-Gg: ASbGncuRGum9LUQODn9NDFCJo8mvjI0fQc26Yr2BiyOXs0Ip1XLwKsf+UF0CgQ1v9sr
	QhkBK89YwuAMKs7bGEy4ctHXVsVO5qyLlaNZ85ABJ91rB/SmoWgR3AQsofPhJ6RQeD+dnEzhW0v
	ylYri7xK2XN+FSsJ3xTCbjPT5XDKYIaZ86QD15WxwoVfsF1BDo2uTIJ+xO2aChOZojpasUBqXpY
	lZojSDkKHO3hBSFwlmgBF9vPaJjFMuGclMCN+5EeqZSyZpF3ln26n9tDZLDuZbavUrCruPwcKvW
	lFWylUhrlNFTWg/1b7kfrbOFLCBD55YZ53ueOHg1Z8QgxzRqXOKsdvAu82oVWUacwA==
X-Google-Smtp-Source: AGHT+IFRf94VasIfY3J7SLyeV72qkoDIxXw9ivAE4Fxae2PfnhrGPBvWm8n1EwZv6SKmLbfdyL/VRg==
X-Received: by 2002:a17:90b:350d:b0:2ee:b2e6:4276 with SMTP id 98e67ed59e1d1-30a61a2802cmr10348556a91.27.1746455093539;
        Mon, 05 May 2025 07:24:53 -0700 (PDT)
Received: from [127.0.1.1] ([120.60.48.235])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e1522ef9bsm55387685ad.217.2025.05.05.07.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 07:24:53 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Mon, 05 May 2025 19:54:39 +0530
Subject: [PATCH v4 1/4] PCI: Add debugfs support for exposing PTM context
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250505-pcie-ptm-v4-1-02d26d51400b@linaro.org>
References: <20250505-pcie-ptm-v4-0-02d26d51400b@linaro.org>
In-Reply-To: <20250505-pcie-ptm-v4-0-02d26d51400b@linaro.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Jingoo Han <jingoohan1@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=15285;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=PIJJuIo0WWiuIyDDRXq9UASTpe1jw1llrrNtGuVW11s=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBoGMouRfVhCBo0Qd2X0PfoDlLhAZc/rF9BWM2Ig
 2o5wANDD4GJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaBjKLgAKCRBVnxHm/pHO
 9b5GCACXGA5HAx82lNMYLtDKqHJcQxhzGgTVlVzO3gQprsaUb/Pvj7FoTkZrmVj1norVH6mPeWR
 yZTU4drUsZxW4EATTcW4pdQiuzwZlA/wSDhhsWvQCPkpTfLF3Yf4rkxFOB98oZcLsgMcNhcO4eZ
 pA+Nup1qc/WagrdXWdrkAx+6TcBHemTSHAIbwZadc0+IvwS4VMfq8bTQ1LKC2TwowoH0NUsM3ow
 P6A3NSS1t+dM5h5C8XIK6VouOuMDh8xSlNFkon70u88HnE8bwqRJNrSaCM4GNEjN5efeIRR05kN
 PHSBAkHCIxctyXe3HfQJ6a/zX7IsIqzRmImGkN7WraIhv2rG
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

Precision Time Management (PTM) mechanism defined in PCIe spec r6.0,
sec 6.21 allows precise coordination of timing information across multiple
components in a PCIe hierarchy with independent local time clocks.

PCI core already supports enabling PTM in the root port and endpoint
devices through PTM Extended Capability registers. But the PTM context
supported by the PTM capable components such as Root Complex (RC) and
Endpoint (EP) controllers were not exposed as of now.

Hence, add the debugfs support to expose the PTM context to userspace from
both PCIe RC and EP controllers. Controller drivers are expected to call
pcie_ptm_create_debugfs() to create the debugfs attributes for the PTM
context and call pcie_ptm_destroy_debugfs() to destroy them. The drivers
should also populate the relevant callbacks in the 'struct pcie_ptm_ops'
structure based on the controller implementation.

Below PTM context are exposed through debugfs:

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
 Documentation/ABI/testing/debugfs-pcie-ptm |  70 +++++++
 MAINTAINERS                                |   1 +
 drivers/pci/pcie/ptm.c                     | 300 +++++++++++++++++++++++++++++
 include/linux/pci.h                        |  45 +++++
 4 files changed, 416 insertions(+)

diff --git a/Documentation/ABI/testing/debugfs-pcie-ptm b/Documentation/ABI/testing/debugfs-pcie-ptm
new file mode 100644
index 0000000000000000000000000000000000000000..602d413635711022f09f5807b49509d2b7c70e74
--- /dev/null
+++ b/Documentation/ABI/testing/debugfs-pcie-ptm
@@ -0,0 +1,70 @@
+What:		/sys/kernel/debug/pcie_ptm_*/local_clock
+Date:		May 2025
+Contact:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+Description:
+		(RO) PTM local clock in nanoseconds. Applicable for both Root
+		Complex and Endpoint controllers.
+
+What:		/sys/kernel/debug/pcie_ptm_*/master_clock
+Date:		May 2025
+Contact:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+Description:
+		(RO) PTM master clock in nanoseconds. Applicable only for
+		Endpoint controllers.
+
+What:		/sys/kernel/debug/pcie_ptm_*/t1
+Date:		May 2025
+Contact:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+Description:
+		(RO) PTM T1 timestamp in nanoseconds. Applicable only for
+		Endpoint controllers.
+
+What:		/sys/kernel/debug/pcie_ptm_*/t2
+Date:		May 2025
+Contact:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+Description:
+		(RO) PTM T2 timestamp in nanoseconds. Applicable only for
+		Root Complex controllers.
+
+What:		/sys/kernel/debug/pcie_ptm_*/t3
+Date:		May 2025
+Contact:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+Description:
+		(RO) PTM T3 timestamp in nanoseconds. Applicable only for
+		Root Complex controllers.
+
+What:		/sys/kernel/debug/pcie_ptm_*/t4
+Date:		May 2025
+Contact:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+Description:
+		(RO) PTM T4 timestamp in nanoseconds. Applicable only for
+		Endpoint controllers.
+
+What:		/sys/kernel/debug/pcie_ptm_*/context_update
+Date:		May 2025
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
+What:		/sys/kernel/debug/pcie_ptm_*/context_valid
+Date:		May 2025
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
index 96b82704950184bd71623ff41fc4df31e4c7fe87..cecd5141b0ce699d73d54575a17b5d6e49b7b4a0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18641,6 +18641,7 @@ Q:	https://patchwork.kernel.org/project/linux-pci/list/
 B:	https://bugzilla.kernel.org
 C:	irc://irc.oftc.net/linux-pci
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git
+F:	Documentation/ABI/testing/debugfs-pcie-ptm
 F:	Documentation/devicetree/bindings/pci/
 F:	drivers/pci/controller/
 F:	drivers/pci/pci-bridge-emul.c
diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
index 7cfb6c0d5dcb6de2a759b56d6877c95102b3d10f..a184675b6562dee2235fa10c591be83cc8c96202 100644
--- a/drivers/pci/pcie/ptm.c
+++ b/drivers/pci/pcie/ptm.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/debugfs.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/pci.h>
@@ -252,3 +253,302 @@ bool pcie_ptm_enabled(struct pci_dev *dev)
 	return dev->ptm_enabled;
 }
 EXPORT_SYMBOL(pcie_ptm_enabled);
+
+static ssize_t context_update_write(struct file *file, const char __user *ubuf,
+			     size_t count, loff_t *ppos)
+{
+	struct pci_ptm_debugfs *ptm_debugfs = file->private_data;
+	char buf[7];
+	int ret;
+	u8 mode;
+
+	if (!ptm_debugfs->ops->context_update_write)
+		return -EOPNOTSUPP;
+
+	if (count < 1 || count > sizeof(buf))
+		return -EINVAL;
+
+	ret = copy_from_user(buf, ubuf, count);
+	if (ret)
+		return -EFAULT;
+
+	buf[count] = '\0';
+
+	if (sysfs_streq(buf, "auto"))
+		mode = PCIE_PTM_CONTEXT_UPDATE_AUTO;
+	else if (sysfs_streq(buf, "manual"))
+		mode = PCIE_PTM_CONTEXT_UPDATE_MANUAL;
+	else
+		return -EINVAL;
+
+	mutex_lock(&ptm_debugfs->lock);
+	ret = ptm_debugfs->ops->context_update_write(ptm_debugfs->pdata, mode);
+	mutex_unlock(&ptm_debugfs->lock);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static ssize_t context_update_read(struct file *file, char __user *ubuf,
+			     size_t count, loff_t *ppos)
+{
+	struct pci_ptm_debugfs *ptm_debugfs = file->private_data;
+	char buf[8]; /* Extra space for NULL termination at the end */
+	ssize_t pos;
+	u8 mode;
+
+	if (!ptm_debugfs->ops->context_update_read)
+		return -EOPNOTSUPP;
+
+	mutex_lock(&ptm_debugfs->lock);
+	ptm_debugfs->ops->context_update_read(ptm_debugfs->pdata, &mode);
+	mutex_unlock(&ptm_debugfs->lock);
+
+	if (mode == PCIE_PTM_CONTEXT_UPDATE_AUTO)
+		pos = scnprintf(buf, sizeof(buf), "auto\n");
+	else
+		pos = scnprintf(buf, sizeof(buf), "manual\n");
+
+	return simple_read_from_buffer(ubuf, count, ppos, buf, pos);
+}
+
+static const struct file_operations context_update_fops = {
+	.open = simple_open,
+	.read = context_update_read,
+	.write = context_update_write,
+};
+
+static int context_valid_get(void *data, u64 *val)
+{
+	struct pci_ptm_debugfs *ptm_debugfs = data;
+	bool valid;
+	int ret;
+
+	if (!ptm_debugfs->ops->context_valid_read)
+		return -EOPNOTSUPP;
+
+	mutex_lock(&ptm_debugfs->lock);
+	ret = ptm_debugfs->ops->context_valid_read(ptm_debugfs->pdata, &valid);
+	mutex_unlock(&ptm_debugfs->lock);
+	if (ret)
+		return ret;
+
+	*val = valid;
+
+	return 0;
+}
+
+static int context_valid_set(void *data, u64 val)
+{
+	struct pci_ptm_debugfs *ptm_debugfs = data;
+	int ret;
+
+	if (!ptm_debugfs->ops->context_valid_write)
+		return -EOPNOTSUPP;
+
+	mutex_lock(&ptm_debugfs->lock);
+	ret = ptm_debugfs->ops->context_valid_write(ptm_debugfs->pdata, !!val);
+	mutex_unlock(&ptm_debugfs->lock);
+
+	return ret;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(context_valid_fops, context_valid_get,
+			 context_valid_set, "%llu\n");
+
+static int local_clock_get(void *data, u64 *val)
+{
+	struct pci_ptm_debugfs *ptm_debugfs = data;
+	u64 clock;
+	int ret;
+
+	if (!ptm_debugfs->ops->local_clock_read)
+		return -EOPNOTSUPP;
+
+	ret = ptm_debugfs->ops->local_clock_read(ptm_debugfs->pdata, &clock);
+	if (ret)
+		return ret;
+
+	*val = clock;
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(local_clock_fops, local_clock_get, NULL, "%llu\n");
+
+static int master_clock_get(void *data, u64 *val)
+{
+	struct pci_ptm_debugfs *ptm_debugfs = data;
+	u64 clock;
+	int ret;
+
+	if (!ptm_debugfs->ops->master_clock_read)
+		return -EOPNOTSUPP;
+
+	ret = ptm_debugfs->ops->master_clock_read(ptm_debugfs->pdata, &clock);
+	if (ret)
+		return ret;
+
+	*val = clock;
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(master_clock_fops, master_clock_get, NULL, "%llu\n");
+
+static int t1_get(void *data, u64 *val)
+{
+	struct pci_ptm_debugfs *ptm_debugfs = data;
+	u64 clock;
+	int ret;
+
+	if (!ptm_debugfs->ops->t1_read)
+		return -EOPNOTSUPP;
+
+	ret = ptm_debugfs->ops->t1_read(ptm_debugfs->pdata, &clock);
+	if (ret)
+		return ret;
+
+	*val = clock;
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(t1_fops, t1_get, NULL, "%llu\n");
+
+static int t2_get(void *data, u64 *val)
+{
+	struct pci_ptm_debugfs *ptm_debugfs = data;
+	u64 clock;
+	int ret;
+
+	if (!ptm_debugfs->ops->t2_read)
+		return -EOPNOTSUPP;
+
+	ret = ptm_debugfs->ops->t2_read(ptm_debugfs->pdata, &clock);
+	if (ret)
+		return ret;
+
+	*val = clock;
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(t2_fops, t2_get, NULL, "%llu\n");
+
+static int t3_get(void *data, u64 *val)
+{
+	struct pci_ptm_debugfs *ptm_debugfs = data;
+	u64 clock;
+	int ret;
+
+	if (!ptm_debugfs->ops->t3_read)
+		return -EOPNOTSUPP;
+
+	ret = ptm_debugfs->ops->t3_read(ptm_debugfs->pdata, &clock);
+	if (ret)
+		return ret;
+
+	*val = clock;
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(t3_fops, t3_get, NULL, "%llu\n");
+
+static int t4_get(void *data, u64 *val)
+{
+	struct pci_ptm_debugfs *ptm_debugfs = data;
+	u64 clock;
+	int ret;
+
+	if (!ptm_debugfs->ops->t4_read)
+		return -EOPNOTSUPP;
+
+	ret = ptm_debugfs->ops->t4_read(ptm_debugfs->pdata, &clock);
+	if (ret)
+		return ret;
+
+	*val = clock;
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(t4_fops, t4_get, NULL, "%llu\n");
+
+#define pcie_ptm_create_debugfs_file(pdata, mode, attr)			\
+	do {								\
+		if (ops->attr##_visible && ops->attr##_visible(pdata))	\
+			debugfs_create_file(#attr, mode, ptm_debugfs->debugfs, \
+					    ptm_debugfs, &attr##_fops);	\
+	} while (0)
+
+/*
+ * pcie_ptm_create_debugfs() - Create debugfs entries for the PTM context
+ * @dev: PTM capable component device
+ * @pdata: Private data of the PTM capable component device
+ * @ops: PTM callback structure
+ *
+ * Create debugfs entries for exposing the PTM context of the PTM capable
+ * components such as Root Complex and Endpoint controllers.
+ *
+ * Return: Pointer to 'struct pci_ptm_debugfs' if success, NULL otherwise.
+ */
+struct pci_ptm_debugfs *pcie_ptm_create_debugfs(struct device *dev, void *pdata,
+			  const struct pcie_ptm_ops *ops)
+{
+	struct pci_ptm_debugfs *ptm_debugfs;
+	char *dirname;
+	int ret;
+
+	/* Caller must provide check_capability() callback */
+	if (!ops->check_capability)
+		return NULL;
+
+	/* Check for PTM capability before creating debugfs attrbutes */
+	ret = ops->check_capability(pdata);
+	if (!ret) {
+		dev_dbg(dev, "PTM capability not present\n");
+		return NULL;
+	}
+
+	ptm_debugfs = kzalloc(sizeof(*ptm_debugfs), GFP_KERNEL);
+	if (!ptm_debugfs)
+		return NULL;
+
+	dirname = devm_kasprintf(dev, GFP_KERNEL, "pcie_ptm_%s", dev_name(dev));
+	if (!dirname)
+		return NULL;
+
+	ptm_debugfs->debugfs = debugfs_create_dir(dirname, NULL);
+	ptm_debugfs->pdata = pdata;
+	ptm_debugfs->ops = ops;
+	mutex_init(&ptm_debugfs->lock);
+
+	pcie_ptm_create_debugfs_file(pdata, 0644, context_update);
+	pcie_ptm_create_debugfs_file(pdata, 0644, context_valid);
+	pcie_ptm_create_debugfs_file(pdata, 0444, local_clock);
+	pcie_ptm_create_debugfs_file(pdata, 0444, master_clock);
+	pcie_ptm_create_debugfs_file(pdata, 0444, t1);
+	pcie_ptm_create_debugfs_file(pdata, 0444, t2);
+	pcie_ptm_create_debugfs_file(pdata, 0444, t3);
+	pcie_ptm_create_debugfs_file(pdata, 0444, t4);
+
+	return ptm_debugfs;
+}
+EXPORT_SYMBOL_GPL(pcie_ptm_create_debugfs);
+
+/*
+ * pcie_ptm_destroy_debugfs() - Destroy debugfs entries for the PTM context
+ * @ptm_debugfs: Pointer to the PTM debugfs struct
+ */
+void pcie_ptm_destroy_debugfs(struct pci_ptm_debugfs *ptm_debugfs)
+{
+	if (!ptm_debugfs)
+		return;
+
+	mutex_destroy(&ptm_debugfs->lock);
+	debugfs_remove_recursive(ptm_debugfs->debugfs);
+}
+EXPORT_SYMBOL_GPL(pcie_ptm_destroy_debugfs);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 0e8e3fd77e96713054388bdc82f439e51023c1bf..01a29076604ffd7261f94e1dc32dde063ae605d8 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1856,6 +1856,39 @@ static inline bool pci_aer_available(void) { return false; }
 
 bool pci_ats_disabled(void);
 
+#define PCIE_PTM_CONTEXT_UPDATE_AUTO 0
+#define PCIE_PTM_CONTEXT_UPDATE_MANUAL 1
+
+struct pcie_ptm_ops {
+	int (*check_capability)(void *drvdata);
+	int (*context_update_write)(void *drvdata, u8 mode);
+	int (*context_update_read)(void *drvdata, u8 *mode);
+	int (*context_valid_write)(void *drvdata, bool valid);
+	int (*context_valid_read)(void *drvdata, bool *valid);
+	int (*local_clock_read)(void *drvdata, u64 *clock);
+	int (*master_clock_read)(void *drvdata, u64 *clock);
+	int (*t1_read)(void *drvdata, u64 *clock);
+	int (*t2_read)(void *drvdata, u64 *clock);
+	int (*t3_read)(void *drvdata, u64 *clock);
+	int (*t4_read)(void *drvdata, u64 *clock);
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
+struct pci_ptm_debugfs {
+	struct dentry *debugfs;
+	const struct pcie_ptm_ops *ops;
+	struct mutex lock;
+	void *pdata;
+};
+
 #ifdef CONFIG_PCIE_PTM
 int pci_enable_ptm(struct pci_dev *dev, u8 *granularity);
 void pci_disable_ptm(struct pci_dev *dev);
@@ -1868,6 +1901,18 @@ static inline bool pcie_ptm_enabled(struct pci_dev *dev)
 { return false; }
 #endif
 
+#if IS_ENABLED(CONFIG_DEBUG_FS) && IS_ENABLED(CONFIG_PCIE_PTM)
+struct pci_ptm_debugfs *pcie_ptm_create_debugfs(struct device *dev, void *pdata,
+						const struct pcie_ptm_ops *ops);
+void pcie_ptm_destroy_debugfs(struct pci_ptm_debugfs *ptm_debugfs);
+#else
+static inline struct pci_ptm_debugfs
+*pcie_ptm_create_debugfs(struct device *dev, void *pdata,
+			 const struct pcie_ptm_ops *ops) { return NULL; }
+static inline void
+pcie_ptm_destroy_debugfs(struct pci_ptm_debugfs *ptm_debugfs) { }
+#endif
+
 void pci_cfg_access_lock(struct pci_dev *dev);
 bool pci_cfg_access_trylock(struct pci_dev *dev);
 void pci_cfg_access_unlock(struct pci_dev *dev);

-- 
2.43.0


