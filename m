Return-Path: <linux-pci+bounces-34003-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D1FB25787
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 01:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A828B5A7C8C
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 23:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C44283695;
	Wed, 13 Aug 2025 23:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FBvhMnW7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C8E30146B;
	Wed, 13 Aug 2025 23:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755127772; cv=none; b=my0vqv4E+tYhIarha686D1XPjbLNKnHBKAfFO/TUofgQ7g5xkCuH4aV2UmWsyz7tQUhIu8FqGcSgVt1qljAKWFDp05BvkRJZF56dHWN7DmBhdbOKEyuOCp5/XpQkO1UxUNJM5RvUJjvxhdpqSWHSjf5D9so0HEinJjmThmyNa7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755127772; c=relaxed/simple;
	bh=ed3arknTW4S1DxdT7tAxpumGNo7mNYDrUWMNAZEVL3o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KHykq6SORS6P2KsZOkHAaKQHwOgdFlBS4Er5KdVMDa7cDQaQtcjlGqZZyPtsZwlEFGbZAPW0LKiBC6bXXE7yhhWf5TCPwjgrlj8vUrFLh7u9pnRoY/HsnIBkcdi8iZwwXaa7NJnS/Ny0CKeBfTApJG1r2aCP7iMR8x3DddHJYlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FBvhMnW7; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-55ce5277b8eso327672e87.2;
        Wed, 13 Aug 2025 16:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755127768; x=1755732568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=azItONdasKBb+zhr8mY+bP2pgb1alO7DSpf9mIconrk=;
        b=FBvhMnW716FRyOpqBZbpAUJooNacp8vrTD6knjnPd3n2e+2VbU4sdVFRMY6uQXZ63/
         dUo+Ko2Pin6WLGPG2hCcNTGWqT5EA7LfKHqpC+h8nfPDFWHZJUTaY0X6K8N+E4MNHtOD
         5lCjYasBbUt0NR9qLlcVLKq/XsITOHmPDzgjwpSn999BVnZo/6WIL4otCciEjnHujO8e
         IDWl3oc1J4434JfyaNbZ8+DChS/efVjDzODkIJkbofVIgdaX8qDTBevFQXHQzY/FXMVe
         f/MZUy5rSWW4l194G5zyCYgUvilulFCKVZmTOi739J7cXzVNdYXiKZGsQ+4jBupyyKrs
         m3Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755127768; x=1755732568;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=azItONdasKBb+zhr8mY+bP2pgb1alO7DSpf9mIconrk=;
        b=JwdGqkKKMGWYOLtG3bcG1VMq1Rk81bjUwOowFMJiRoKJgNxRtI4HfVqS+98W5wKDBz
         NjLEYQZJxBpJXnS2AIsRqyYcdA2w08E0TOXf/qmrB4rGeyklOMqTcxwA4mBkJBluzD/n
         Z7qIDt5Q2Fc6BKpbxXA7IpYqdFgWEoRJsfHef5f7vjCHuQdoWZj03Oj/NvPJHlK8NRk+
         woVVJabH1Fv/NtXxWveb17xJ67EPqlqn9M15MXByElL+20+Ai/wL+DE9IestC0b+HoMn
         MOylb4SBzJMNmF6mxVEQlcIJ6ihH+ERBRmXSnZEYtZpJMSlSadvF2gavlIAoTkf0Hnyf
         0TtA==
X-Forwarded-Encrypted: i=1; AJvYcCVkE3wsSIi09JyJGi2aK3U6TrwewUtz1yan6Zlb66H0wSNnc/upSqxUqoSIWtNuxAfvuwGiYt3XOA8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxshhk6WYdl9BoU92dJYyo5PXAJhAX/3FFQ3kVUUwd59z5yGbQN
	Z9A9HToCdzst7eGBrv5SMvEWVVUc+ccHQAvBZtVj6A6cMGm68fJJR+y/gByVAP8B
X-Gm-Gg: ASbGncu3JTyiWnmzSxbCJcCjo8OZ2cOJILf/RRQ94HaagM0Qy6tXdte7mFTz2ym+5Wv
	aeNBKDpRzBWFXZHnhiPoCVBiPFEWrH9OzJ0qxyEzEeaMj7M1GRAfs18GM/xk0TZliX40tU1/H+m
	F1VkPaUB4LYSj+7I8i5enGKuBVpRn6aZAhUZtgWXU659uC5/s2VKXAl4uxuWsGQ6pe/3xOKUkbe
	LxVP00+mgbYgAfIrbhntcjCklc1559PC9O7jpBOxYUwWdnqF4ymHYDa37aMgQoexvGdBPzpPfd8
	LMPHQBpkTbxEOOwIZ6XWZqgF8vH2cRMArZ/QffTc6q7Q+MHhKPnSw8imXmL1Jj/DXvATfIIDG3u
	ghG98N6EmfOAPmBAYRiU5rzuKbDIopdji
X-Google-Smtp-Source: AGHT+IEKKlvZP1xwv1HEMJur5csvxWIycSq+wMsxuKO3H+3kW9A5/TeAFVl8Nhii4m0V+mWcJfiyBQ==
X-Received: by 2002:a05:6512:3347:b0:553:da39:37d with SMTP id 2adb3069b0e04-55ce4ffd488mr324077e87.1.1755127768121;
        Wed, 13 Aug 2025 16:29:28 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id 2adb3069b0e04-55b88c9aeafsm5315459e87.109.2025.08.13.16.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 16:29:27 -0700 (PDT)
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
Subject: [PATCH v2 0/4] irqchip/sg2042-msi: Fix broken affinity setting
Date: Thu, 14 Aug 2025 07:28:30 +0800
Message-ID: <20250813232835.43458-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When using NVME on SG2044, the NVME always complains "I/O tag XXX
(XXX) QID XX timeout, completion polled", which is caused by the
broken handler of the sg2042-msi driver.

As PLIC driver can only setting affinity when enabling, the sg2042-msi
does not properly handled affinity setting previously and enable irq in
an unexpected executing path.

Add irq_startup/irq_shutdown support to the PCI template domain,
then set irq_chip_[startup/shutdown]_parent for irq_startup/
irq_shutdown of the sg2042-msi driver. So the irq can be started
properly.

Change from v1:
1. patch 1: Fix comment format problem, and structure the changelog.
2. patch 2: Improve the comment title and body, add describtion about
            the fact the PLIC is used as parent chip.
3. patch 2: Remove __always_inline for cond_[shutdown/startup]_parent().
4. patch 3: Update the align of the "XXX_MSI_FLAGS_XXX" macro.
5. patch 4: Claim the fact that the added flag is used by the negotiation
            of MSI controller driver and PCIe device driver, and can be
	    only used when both of them support this flag.

Inochi Amaoto (4):
  genirq: Add irq_chip_(startup/shutdown)_parent()
  PCI/MSI: Add startup/shutdown for per device domains
  irqchip/sg2042-msi: Fix broken affinity setting
  irqchip/sg2042-msi: Set MSI_FLAG_MULTI_PCI_MSI flags for SG2044

 drivers/irqchip/irq-sg2042-msi.c | 19 +++++++++---
 drivers/pci/msi/irqdomain.c      | 52 ++++++++++++++++++++++++++++++++
 include/linux/irq.h              |  2 ++
 include/linux/msi.h              |  2 ++
 kernel/irq/chip.c                | 37 +++++++++++++++++++++++
 5 files changed, 107 insertions(+), 5 deletions(-)

--
2.50.1


