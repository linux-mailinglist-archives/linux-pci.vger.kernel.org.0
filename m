Return-Path: <linux-pci+bounces-34949-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D56DB38EF5
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 01:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70C847AD749
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 23:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F4930F935;
	Wed, 27 Aug 2025 23:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SvxspZqQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA112F067F;
	Wed, 27 Aug 2025 23:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756336253; cv=none; b=pXgLzL2XAkIOiODzIGap7Q46DlyYaYtgX6nluQ+/AUpFOYwv2RzXjo1ozYLr0qCKANdOi+/SfPwD0V5Mcy3NOdKNGEc1gschHihrptHkrLJWbcvWAy2Wgh8/vOTuhePJRvLGTKBLdTDCVBuaeWmOAwZL2BvhrqRMvgM28CyDs6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756336253; c=relaxed/simple;
	bh=D1uBYeI6yyHG//TIoDOYhr9aTlJxFP7mh06RYuz+MwM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tiD3V88qvFYevoYgQXG4wtco3gIBR8coMDmuslMSU7+nKDGFUq/xXlcw9t0YLxkmcSydOiiaZ80N/6FzHDxQdIkg61+6EdAWWdAk2pnos9tCvw5lXP9DOl2TPRcueay6tkN8VeggjHZhEuAk7bOv1e52eT8G0epX60ylIZyS6NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SvxspZqQ; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b47175d02dcso361087a12.3;
        Wed, 27 Aug 2025 16:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756336251; x=1756941051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hpTGX6D+zEWo2TDoU/huOakyARg4JVK9BfIYOBFF8Fo=;
        b=SvxspZqQeXxL+hI0FLdUOBM6A7NaO6pMsTxHo5xveRJ1iSiWPWxHlHBlA2gIVPKJbi
         GuOryZGRAtTIhMo8on4cfIMj6rQ4VsXRnbOEM7YUqgQmfJ0bx4bidz8ir+595xsxoSzL
         2ULuTQlC6qOELRfDyEfe2IRvwJlmdmxXJECv6aX69pZPylfVxj+oY8sQjv+M0G69jbNl
         REQrTlbmSkojyFAkf50TnHBusz8FMFHZZAOErk3Vv4D2DfXg1ZAI4huzYXueo8Ldx/BP
         LzROzcpmig7BC4y3qV6jzCsFb/OEzLmiZH8g3IIQbBn5z3mIpMck7ZMoIh28AnOJHry3
         TuFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756336251; x=1756941051;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hpTGX6D+zEWo2TDoU/huOakyARg4JVK9BfIYOBFF8Fo=;
        b=sJEuW3Z8iC0KHj7Jj8KvZEsCH5Y1oUe66cCMyDYzX/rKAD1ZwsqbwRKsfuZTQYNl7s
         japYuJZEtJwWbrlz7XxatLF/lmxDAK/ysXsX6pwqkSiNI9Uiuc4uWOUsLlWsBgv7GbG/
         eq0u3gZ5EVsIvTcNhV8NGJY9nnyhWqYXsx5WT83WON6YFoHPWIh92rgy6gTEF5jm6A9d
         Yoe0GRLvRK7gooSq46XLTb2UWYz0QCHBdFgJfmEnX42RRipTe6M94hmk0Gymy9Ax6Y8u
         M9r3GusCht8speTtWfW0oCyYVMnTXsSb5h20zCrJvSRSDoOoim+kyPMvrQydNBWdHIK8
         MiAg==
X-Forwarded-Encrypted: i=1; AJvYcCVsyJTYLCEF+kI2viv3Iny20iXmZqt2v9tkGLiJfAtF6ylmxK73IPb5IyBzo6A3fxZItiGAsRx/SqFfECI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW8fybucuonKS8pMtJo+G7r+KoPPBSLNspxOVMmi2SOqPUDmC5
	US5kQPF07W9kzhFsZJnptHt0zbxr6NbzPyjP48ckY1mp0uw6FPXwmE9u
X-Gm-Gg: ASbGncuofRBka4S9OIQefEshSUJsoP2pfGKXr2i3N3nCkHssQhqlDuufiOYks6PAYzj
	bXd7u1VVZ6SjeTfEusxGjippGw4oxEsRvvHQPs0/mtzvkPslwyS39VRTXP4hR98yxXbd9nBWKHH
	KYN8Gto8FDRrExZUG/0N9LHBRV+cpApIPsPDrdnh+8pO31iZWAUOtk8G6pf7uBJabxU/0kzNkyG
	0IYp5dGvAH61DzV4T2l2V5/rpspH0iwgCFKJLSkJko1LlnbNkJCjnR7nUblK0bonUVCau8YohTL
	4uJxLMVcsP94TNEql7SUUv2VPB+xIj375Fn/UgJ0H/qGz7ncgRZ1qDvP8TWoDWKTmqByQQSuqXl
	mt6sjmIgS3vuxuxFDFuBefF3ohb/0GVxe
X-Google-Smtp-Source: AGHT+IHxryo3kJsFVbI54HWkyx4jlhELnk+fiqRoyjgbrqoKw8bic27qXRHW7BIUKUhVzP25dhDVqQ==
X-Received: by 2002:a17:90b:4c02:b0:31e:ec02:229b with SMTP id 98e67ed59e1d1-32515eabb9bmr27912917a91.20.1756336250903;
        Wed, 27 Aug 2025 16:10:50 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-327ab0dbeecsm332644a91.19.2025.08.27.16.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 16:10:50 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Marc Zyngier <maz@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Inochi Amaoto <inochiama@gmail.com>,
	Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Chen Wang <unicorn_wang@outlook.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>,
	Linux Kernel Functional Testing <lkft@linaro.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Wei Fang <wei.fang@nxp.com>,
	Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH v2] PCI/MSI: Check MSI_FLAG_PCI_MSI_MASK_PARENT in cond_[startup|shutdown]_parent()
Date: Thu, 28 Aug 2025 07:09:42 +0800
Message-ID: <20250827230943.17829-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For msi controller that only supports MSI_FLAG_PCI_MSI_MASK_PARENT,
the newly added callback irq_startup() and irq_shutdown() for
pci_msi[x]_template will not unmask/mask the interrupt when startup/
shutdown the interrupt. This will prevent the interrupt from being
enabled/disabled normally.

Add the missing check for MSI_FLAG_PCI_MSI_MASK_PARENT in the
cond_[startup|shutdown]_parent(). So the interrupt can be normally
unmasked/masked if it does not support MSI_FLAG_PCI_MSI_MASK_PARENT.

Fixes: 54f45a30c0d0 ("PCI/MSI: Add startup/shutdown for per device domains")
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Closes: https://lore.kernel.org/regressions/aK4O7Hl8NCVEMznB@monster/
Reported-by: Nathan Chancellor <nathan@kernel.org>
Closes: https://lore.kernel.org/regressions/20250826220959.GA4119563@ax162/
Reported-by: Wei Fang <wei.fang@nxp.com>
Closes: https://lore.kernel.org/all/20250827093911.1218640-1-wei.fang@nxp.com/
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
Change from v1:
- https://lore.kernel.org/all/20250827062911.203106-1-inochiama@gmail.com/
1. Apply Tested-by, Reported-by and Tested-by from original post [1].
2. update mistake in the comments.

[1] https://lore.kernel.org/regressions/aK4O7Hl8NCVEMznB@monster/
---
 drivers/pci/msi/irqdomain.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
index e0a800f918e8..b11b7f63f0d6 100644
--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -154,6 +154,8 @@ static void cond_shutdown_parent(struct irq_data *data)

 	if (unlikely(info->flags & MSI_FLAG_PCI_MSI_STARTUP_PARENT))
 		irq_chip_shutdown_parent(data);
+	else if (unlikely(info->flags & MSI_FLAG_PCI_MSI_MASK_PARENT))
+		irq_chip_mask_parent(data);
 }

 static unsigned int cond_startup_parent(struct irq_data *data)
@@ -162,6 +164,9 @@ static unsigned int cond_startup_parent(struct irq_data *data)

 	if (unlikely(info->flags & MSI_FLAG_PCI_MSI_STARTUP_PARENT))
 		return irq_chip_startup_parent(data);
+	else if (unlikely(info->flags & MSI_FLAG_PCI_MSI_MASK_PARENT))
+		irq_chip_unmask_parent(data);
+
 	return 0;
 }

--
2.51.0


