Return-Path: <linux-pci+bounces-26702-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DCEA9B36B
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 18:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB47B1751B5
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 16:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0720280A57;
	Thu, 24 Apr 2025 16:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NqVQLA/B"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2A5280CE0
	for <linux-pci@vger.kernel.org>; Thu, 24 Apr 2025 16:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745510857; cv=none; b=HYN2kz31eRE8KgC+y5PALJL+4XV7DfcCmcRcac8Kh0ubQ/aqKQ/Av3kRFgZyh5d/UoT2hS3/GZL8rG7ghqJXiSegJI9AzqHUbWSUKPgPe0Ikzrl1F5uZRXzBgbp6kNUze+nLHZCvEZyhgTN3XPOyujBnDTj/vPwY5R0AcLzkCuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745510857; c=relaxed/simple;
	bh=WUAfTwFUNnyfQCSzuigMCZoJl7xePyKjvBTV5qJsnqc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qGDwET4x57M03pUQhyyeOTeUUKPAeGVdRPCN4rRlATn/qVQ2oBjBXFTF7iUHujk7EUTpMixXLD95j9fVe7WtRCKkfKCP7rX3dhfIhzCxog53q/nfASGoUeUWlGlzTH+ePJXd0OXrCP7TQhjxzAlS/fCpd2SBdvvL/iZuGhxbbhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NqVQLA/B; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2295d78b433so14548145ad.2
        for <linux-pci@vger.kernel.org>; Thu, 24 Apr 2025 09:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745510855; x=1746115655; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JZMl0XpIBTjbaJhjqDrVGn97W9rnEYdGFkUgv91EycY=;
        b=NqVQLA/By9Azq3Bz5bpDMY3AACTkcTVrHPS8vdAOx/cPoQp6BnkzHTmzsjV+ZdqaEy
         8qlYf96fc+3EH+0zKs1nx4SVlSLdZIzhPDnJOSEWNB9CpD4J7sW7OoGLyrStHSrG+a5a
         av44su7gDMVGCrfZzSqRH0k6rTZp+1xBajwTltOD1lSuphP3V3jAGtEQITyBojLaMCI4
         o6jUnytoV2FJBP8RTBdDJwrPhrJmG8n+/PWIunuMb6WAl4hKnmgFIF5sKKoYPizmHJK0
         wVyQl0qjrXG6Vr1jDqclsvK5vG7/a5OlkIn4Q9eDv68D8Lv5Ws5t/eVv7nfVNIJyd/Fh
         L1rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745510855; x=1746115655;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JZMl0XpIBTjbaJhjqDrVGn97W9rnEYdGFkUgv91EycY=;
        b=ehZff3i0Vx11fQit+4jwUlQYxOgPGg7kPoonYqzJuuM4r84s1akZaVHOEaNED0251/
         y+drjFKkYDj0H79Gz1GJuaHO/Gb5AwnL+pzdDizQly0b7zLAAar/xTqavuFb6d0e4wob
         QyuuKGukBdXpsAjFzHSkc2zff95muE0Awxvfxoxx22wHRoJnTGKByW07/8uiA+LENmuY
         fmbjCrBaG0QuGGLt2ZeGgR85v94Z9LLhBlx4pa+4CGF93XsvghnhuEJaF3nCcTrBD8oO
         wRt6ro/viEnBs13YY1KQHu52GJC31GLpAp7NC6d5THM1H5qqGsQFE/icxuY2PdRrH5bN
         D94A==
X-Gm-Message-State: AOJu0Yz97OuC2beozgC847/w7eLfMZ+rUhWYiXDqBNyRyCa7cmcG8Vzl
	c1LS55Vrc5/C0c3OctGxaTU/e4lH7dasUNx7OIF/vMSQy/XrTxg2ICYEiY2SDA==
X-Gm-Gg: ASbGnctzQJMdLb6Qt9r9JLGQsb3rAogUlx+5NNJ3Dqrm1iHSoNRDgJ/kSRZ+f7jGSdv
	IGLdxfuBeVZNVF1qpTiR1zpwKFR2eifxMIaU3G5VZc1onG0m5PvzVzjVsq2j2+xjcgyAns4hqRe
	oXDxtHqIDRBBoS5SZFu6Mv04V8hU6F/Aug0U5+T5X1kaemUBvKmKEF3oER6tvC3+Pnj2En3yFjV
	Km9Q0i4F23L2s+zx+UepFcO0WJqbuOB83v+yKTJYRv0jqKDR4SNyRkHYWQqUS430iPs0Km8b87H
	TYzTaYgeKV4P+m6/tRUIrviI/cAC4IJT2QZh5Dzs3dA5Uov/Bi9Vm3U=
X-Google-Smtp-Source: AGHT+IG/bzlc9njDJehwCzOxlmqYn67vb4Gxu1BwU9Oi13uFjvlW4Kjk/w8uL5w8+bycAoLboGZXIQ==
X-Received: by 2002:a17:902:ce0d:b0:21f:3e2d:7d42 with SMTP id d9443c01a7336-22dbd422451mr549735ad.23.1745510854438;
        Thu, 24 Apr 2025 09:07:34 -0700 (PDT)
Received: from [127.0.1.1] ([120.60.77.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db5221656sm15262275ad.252.2025.04.24.09.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 09:07:34 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Thu, 24 Apr 2025 21:37:16 +0530
Subject: [PATCH v3 1/4] PCI: Add debugfs support for exposing PTM context
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250424-pcie-ptm-v3-1-c929ebd2821c@linaro.org>
References: <20250424-pcie-ptm-v3-0-c929ebd2821c@linaro.org>
In-Reply-To: <20250424-pcie-ptm-v3-0-c929ebd2821c@linaro.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Jingoo Han <jingoohan1@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=15288;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=WUAfTwFUNnyfQCSzuigMCZoJl7xePyKjvBTV5qJsnqc=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBoCmG+OmLSj6Zk4gNzRtoXzQ6W/XMMajV+nzlND
 /KO0irc8TiJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaAphvgAKCRBVnxHm/pHO
 9ZQ6B/43G/eUraHS590lm3JyKf7IaNyJYrH3pmav7y0YERxLC/YMC74glGgElNtbLmkGR5FJruL
 xVhpxZv9lKp9syrewKiMwXGI8VrCyFw5rpSdkPPJ89xRHD5UvIx/1OezbwYx3LIsb+kizfnIr+s
 eqSeq+33b7fwh4gb1Auc0cn03TTyzTEZfvAFookT0ZGrEdsQ4dW9MLw8lbaViCTgzajy/q57VV2
 50y2gVsHqI0eAaBcURNCAXkDLWm4Ggu64nFkG3npayhH/X5CYCoPe3Hsz/rueu8c+8FN59n8Tzw
 qBrM2SDFN3hPDxxUAzJKwQikyayyTVrM+shgWrjvHhTt7cGX
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
index 0000000000000000000000000000000000000000..8bb63b5fb3883775ab320d9e268e5b16f78b59b2
--- /dev/null
+++ b/Documentation/ABI/testing/debugfs-pcie-ptm
@@ -0,0 +1,70 @@
+What:		/sys/kernel/debug/pcie_ptm_*/local_clock
+Date:		April 2025
+Contact:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+Description:
+		(RO) PTM local clock in nanoseconds. Applicable for both Root
+		Complex and Endpoint controllers.
+
+What:		/sys/kernel/debug/pcie_ptm_*/master_clock
+Date:		April 2025
+Contact:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+Description:
+		(RO) PTM master clock in nanoseconds. Applicable only for
+		Endpoint controllers.
+
+What:		/sys/kernel/debug/pcie_ptm_*/t1
+Date:		April 2025
+Contact:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+Description:
+		(RO) PTM T1 timestamp in nanoseconds. Applicable only for
+		Endpoint controllers.
+
+What:		/sys/kernel/debug/pcie_ptm_*/t2
+Date:		April 2025
+Contact:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+Description:
+		(RO) PTM T2 timestamp in nanoseconds. Applicable only for
+		Root Complex controllers.
+
+What:		/sys/kernel/debug/pcie_ptm_*/t3
+Date:		April 2025
+Contact:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+Description:
+		(RO) PTM T3 timestamp in nanoseconds. Applicable only for
+		Root Complex controllers.
+
+What:		/sys/kernel/debug/pcie_ptm_*/t4
+Date:		April 2025
+Contact:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+Description:
+		(RO) PTM T4 timestamp in nanoseconds. Applicable only for
+		Endpoint controllers.
+
+What:		/sys/kernel/debug/pcie_ptm_*/context_update
+Date:		April 2025
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
+Date:		April 2025
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
index 0e8e3fd77e96713054388bdc82f439e51023c1bf..55c00b3407f1512af0b1e165a3ac8d0bb62c2eed 100644
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
+			 const struct pcie_ptm_ops *ops) { }
+static inline void
+pcie_ptm_destroy_debugfs(struct pci_ptm_debugfs *ptm_debugfs) { }
+#endif
+
 void pci_cfg_access_lock(struct pci_dev *dev);
 bool pci_cfg_access_trylock(struct pci_dev *dev);
 void pci_cfg_access_unlock(struct pci_dev *dev);

-- 
2.43.0


