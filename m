Return-Path: <linux-pci+bounces-34004-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5208B25789
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 01:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4DEF5A7C09
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 23:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56FF2FC875;
	Wed, 13 Aug 2025 23:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aF+mJyYD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70F02FC89A;
	Wed, 13 Aug 2025 23:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755127777; cv=none; b=kJtWck31xeHYFA9Q40yPQRi2Ct+vUanS/KSedtcQ1Ya789s5l1O2hzb1Zgj80GIWNyDvpEqfyo5EeTvanLEFIAvPdlg47OcaZgYg2qMiOJZ/Wh2JXtAj4FLCvEkg5vq5wI4hSbgOKhECAoIRX8agONo7ua6q48leKeRH5AtgeyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755127777; c=relaxed/simple;
	bh=2MmKPQRRLLDGsp3Wq8ECREZn7dai/L6RAFeAckRn+sQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l9G+nIXrp2eaZbox7IonehWL9hmV6tAUs33yzlqXIRppip7TtlTa5tEt46azEZCGutHbt32tbZaw9uoUXSaI5uJOVGv/tP7jLxNP/rmAr+QtDDZjaI5iIdDOwPjVlI1q9XLdKBBlCSNEkptBOLXmfEYOfIgTyJrwpvsuoFPlCD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aF+mJyYD; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-55ce521f77bso325872e87.1;
        Wed, 13 Aug 2025 16:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755127773; x=1755732573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vu9NW93raMKYIDH7OJ5SABXxZXwUbKYAWJtRYayncyA=;
        b=aF+mJyYDm4olgk8sKXr+UH3/P9UL9it/fdUp1H/zOloq7p3IfXHiLCJPIo2HQIqw2g
         asYJQ8HzbJRNEm7tfQupt+AHXFUXh+sGufAegokvoRnjYMM2YAsqjQE5+a5vrguKREDY
         W2sPsvC6KK/YNRD72LIwzDnKR0+cYq5PuKaTtf5WqhLa6YhtuffWbVI+dgLzYy+uYvze
         Q/ju/uQk4DCMrwQwNlTlwq877QL6yWjtu3rZC0pbMGeK/QTXQIAtaL3egl3MsAFzxfGJ
         NW8416988Db2Z01uZ2CYS+q4DXDpdI7fZX25wECfkExVlm8Rp2FcQtPc9jmuf0Gk9BxG
         EsGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755127773; x=1755732573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vu9NW93raMKYIDH7OJ5SABXxZXwUbKYAWJtRYayncyA=;
        b=s/kiVWh+hscmsQyNPJUz/yM4Fr1IJ8MlD/cLTeYl3PzeME2MLvCR8+Qz+xpPIzvZI7
         Ktf7FXmqvEVylpjFc7QxBABKP8XhFYMfnAsEiazBhRjif41ej94VMWfBovLCyJFexsLk
         qdTluWhiKKUjrvPud4G2u06RDjfEzXR/yPQk4H2PgtU0807PyGERRMscWV7C3qB6IULy
         qidEVV9sZZrUSjoP1DtJhNaA94zRo5fKQGO0268vtjOIbGOaTP/jCCHmDln533RKclip
         uOg2h2h5O2L1qFQT+4ENgEsISKOV6CvSmw7Y3jO7Q1rDrPZ+p+HdYNCdKBlN7SLw38lc
         bGzw==
X-Forwarded-Encrypted: i=1; AJvYcCV2uiZo70mIRr4apMgsZp752Lp+bteJY3TfXclpeqTT6gCabCowGgxS/Hjv2AB94rX/7SYFH3U1MQw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTctBukzeParG0+wXMZv+ZBYyEl93WNjvj4qEgaVC9vViJ9Y4Y
	N+ZZOQ81QeNbTY5Guut1xGIZDsmR1xKfH7jXUgPX8ItFlgEOcv7Jq5nD
X-Gm-Gg: ASbGncsBX5djh+brojr59OXO1Audqucu2GJIdkS4ooT9Txf1vg7tiaIsxQw9yKGKhmA
	vPjPWKnTN9uVIod3oqRZ0it5dZshSlA7cQgSW0DX934LhAg/6vQfrE9nRV/BZkHMlWrJQ6fetnn
	vDghRsJOZWMUSpHRPJ52+X0GV7WfYM5ojKiyHyK4HRtPApszZL4soZPnOg3F8yQN2Upurig9t4q
	F7tYXTTg0mR0qQioKDUKVfgQvlYnFDyaPWcObcRVLOAVsU6B+Xc6rGx3/jI2IuTXZfWdQ/Ycu1Z
	RUn0hEIA2LfsJoI2N7osQ5wRng1LFqdfh09qE7yelaZN0HSbB44E1JPG7YLUkLgKQJ1Qhauct5R
	BZn74qT0M9givBYXW3ne9DBgQUrPzDTWc
X-Google-Smtp-Source: AGHT+IFk82gtySYMZ78b1QobGTryGttVWJif+BbfnvegmfDV65YkOKAt+gDBnxKxaghEsxr4CCNZMg==
X-Received: by 2002:a05:6512:318b:b0:55b:87a8:6021 with SMTP id 2adb3069b0e04-55ce631732emr157843e87.37.1755127773132;
        Wed, 13 Aug 2025 16:29:33 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id 2adb3069b0e04-55b8898bfdcsm5527992e87.1.2025.08.13.16.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 16:29:32 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Marc Zyngier <maz@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huwei.com>,
	Juergen Gross <jgross@suse.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Chen Wang <unicorn_wang@outlook.com>
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH v2 1/4] genirq: Add irq_chip_(startup/shutdown)_parent()
Date: Thu, 14 Aug 2025 07:28:31 +0800
Message-ID: <20250813232835.43458-2-inochiama@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250813232835.43458-1-inochiama@gmail.com>
References: <20250813232835.43458-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As the MSI controller on SG2044 uses PLIC as the underlying interrupt
controller, it needs to call the irq_enable() and irq_disable() to
startup/shutdown irqs. Otherwise, the MSI interrupt can not be startup
correctly and will not respond any incoming interrupt.

Introduce helper irq_chip_startup_parent() and irq_chip_shutdown_parent()
to allow the interrupt controller to call the irq_startup() or
irq_shutdown() of the parent interrupt chip. In case irq_startup() or
irq_shutdown() is not implemented for the parent interrupt chip, which
will fallback to irq_chip_enable_parent() or irq_chip_disable_parent().

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 include/linux/irq.h |  2 ++
 kernel/irq/chip.c   | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 1d6b606a81ef..890e1371f5d4 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -669,6 +669,8 @@ extern int irq_chip_set_parent_state(struct irq_data *data,
 extern int irq_chip_get_parent_state(struct irq_data *data,
 				     enum irqchip_irq_state which,
 				     bool *state);
+extern void irq_chip_shutdown_parent(struct irq_data *data);
+extern unsigned int irq_chip_startup_parent(struct irq_data *data);
 extern void irq_chip_enable_parent(struct irq_data *data);
 extern void irq_chip_disable_parent(struct irq_data *data);
 extern void irq_chip_ack_parent(struct irq_data *data);
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 0d0276378c70..3ffa0d80ddd1 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -1259,6 +1259,43 @@ int irq_chip_get_parent_state(struct irq_data *data,
 }
 EXPORT_SYMBOL_GPL(irq_chip_get_parent_state);
 
+/**
+ * irq_chip_shutdown_parent - Shutdown the parent interrupt
+ * @data:	Pointer to interrupt specific data
+ *
+ * Invokes the irq_shutdown() callback of the parent if available or falls
+ * back to irq_chip_disable_parent().
+ */
+void irq_chip_shutdown_parent(struct irq_data *data)
+{
+	struct irq_data *parent = data->parent_data;
+
+	if (parent->chip->irq_shutdown)
+		parent->chip->irq_shutdown(parent);
+	else
+		irq_chip_disable_parent(data);
+}
+EXPORT_SYMBOL_GPL(irq_chip_shutdown_parent);
+
+/**
+ * irq_chip_startup_parent - Startup the parent interrupt
+ * @data:	Pointer to interrupt specific data
+ *
+ * Invokes the irq_startup() callback of the parent if available or falls
+ * back to irq_chip_enable_parent().
+ */
+unsigned int irq_chip_startup_parent(struct irq_data *data)
+{
+	struct irq_data *parent = data->parent_data;
+
+	if (parent->chip->irq_startup)
+		return parent->chip->irq_startup(parent);
+
+	irq_chip_enable_parent(data);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(irq_chip_startup_parent);
+
 /**
  * irq_chip_enable_parent - Enable the parent interrupt (defaults to unmask if
  * NULL)
-- 
2.50.1


