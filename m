Return-Path: <linux-pci+bounces-3640-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 809BC858729
	for <lists+linux-pci@lfdr.de>; Fri, 16 Feb 2024 21:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39479289F5E
	for <lists+linux-pci@lfdr.de>; Fri, 16 Feb 2024 20:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6451534EB;
	Fri, 16 Feb 2024 20:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="0H0mj5jr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9E4151CD8
	for <linux-pci@vger.kernel.org>; Fri, 16 Feb 2024 20:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708115614; cv=none; b=Mks4TPT0CG++8EbOMwHwMqWFGHCV3uC2TOrAtIG+pIV4aexvnxDD2zo20JEXZBfZNWhs5IE2OdwOoZo/+K7EBnFtRh7sGJEHB/pTQp9ftRTM+amThA0Q1oaZlEbFq5tG/mHoJXEytWUOgq3Pwp0/jX4smYuSjVqjTb+bn0Xdtuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708115614; c=relaxed/simple;
	bh=ItVOWrm+zmPgwU0jiuXsWbAoFc6imFhaKj9fNGvBoW8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TNxDKTJlvXg3c5cekoVAim2F0yqVfqYQv4K1GeZuI+ocK7Qj6/iYOpZrsBKgzxXRpEsdaUn5GEUV2/88o3bse9VbWUadHMtF7VGU3M9mS6hvTNoK12TjSUt4gqeuDjHNoTJ+gv5u0EnxBl5pdcJD6nP8Zqw0w+EFN8X3HIfCjMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=0H0mj5jr; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-412345cca4eso11207335e9.2
        for <linux-pci@vger.kernel.org>; Fri, 16 Feb 2024 12:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708115610; x=1708720410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cLRQo0XRS8LZDKEz8aQDPJI24t7vYnPhkxLETHKtHpE=;
        b=0H0mj5jr4OKi3HUByCC09hQ4mHsGgmT/ol2rT5sRBJo4LXMsR509dnLVPQj88to99o
         IvqXfP2wG1BMwPRHq9dOyb5uujUUvdqwYww2Ol+fK5o9d0SD6VzxvwVyXRX/UGtD3jXZ
         GU/wPJDv2XuKlHN7RGhU+1dL8pJo7zo4od3kKv8e2Ln2UAuVJK7Lbnw6GIYyo9RN1D/x
         f/48r2Iv0iIrjniwH/1YwJ5PnazRK64E7v5y/huSURRtDQihH2H9SzQGZXPPjP1pTUF1
         A8+pS7wbNNt9pofbY8fr6k0026ZmPd68kOn4wYRIXruRmkBFGxaW4TE2kXqzPfZIllRD
         RFcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708115610; x=1708720410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cLRQo0XRS8LZDKEz8aQDPJI24t7vYnPhkxLETHKtHpE=;
        b=YQihT7U7Fh4ZRnypYhwEl4oZSo7jsuumTzgr61aRv11U9U9/Owp3KmgmwrxC78WLVv
         9S6M9fsjdCA3YUSXfmYcsuONSAhrEIUzz0OY4pIE8lF7ty7Fu+hTKw8NZxfH2F44Zcey
         RfC8JHVPeMLj+NwBTwxZq/sxu2KsVMh0pL2MJ4rXamSSu7inEyAs6L5qg3oLmj2K76hI
         t5GghDxtB8iQFiyzgI4d0wTXWTK+jp9sXJ9YHB0lsvF48J3NzBM5tIN2IakGYjJ88CZn
         JYjXolmoTpslSeA9I/JW0mIsVT209oBnedlQIH0Ko12NVtV3EiOC+DY49gMIKHU3Pwdc
         D7nQ==
X-Forwarded-Encrypted: i=1; AJvYcCXi/C8pN3MqJdUJ74tTLKLZ7PqVx79rRt0/2k/xOIIM3GkcTNx2qiFl7Q+inKK1+EWomyyLO693M73EIx+k41urOzLYNzmeC9c2
X-Gm-Message-State: AOJu0YxlO0g3jiDzOpIbwRaiZGVjDPtVx7Y9Uwdk4oj1c9YhhP+rZGYk
	b4y94itIosAEaFYIC0a9Gq1J/pd8poyeLHWLcdZq/FnyAI3obOnZHRxgBjIsAhs=
X-Google-Smtp-Source: AGHT+IEIxZ+2uB3UEcdhGVTyTJDaWzytlIE0jDJvcLHgbNngP62RD3/E1pF6wGg8FGrlRiGNZ99JNg==
X-Received: by 2002:a05:600c:3c8a:b0:411:9508:e237 with SMTP id bg10-20020a05600c3c8a00b004119508e237mr4998629wmb.19.1708115610266;
        Fri, 16 Feb 2024 12:33:30 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:7758:12d:16:5f19])
        by smtp.gmail.com with ESMTPSA id m5-20020a05600c4f4500b0041253d0acd6sm1420528wmq.47.2024.02.16.12.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 12:33:29 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kalle Valo <kvalo@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Saravana Kannan <saravanak@google.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Arnd Bergmann <arnd@arndb.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Alex Elder <elder@linaro.org>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v5 12/18] PCI/pwrctl: create platform devices for child OF nodes of the port node
Date: Fri, 16 Feb 2024 21:32:09 +0100
Message-Id: <20240216203215.40870-13-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240216203215.40870-1-brgl@bgdev.pl>
References: <20240216203215.40870-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

In preparation for introducing PCI device power control - a set of
library functions that will allow powering-up of PCI devices before
they're detected on the PCI bus - we need to populate the devices
defined on the device-tree.

We are reusing the platform bus as it provides us with all the
infrastructure we need to match the pwrctl drivers against the
compatibles from OF nodes.

These platform devices will be probed by the driver core and bound to
the PCI pwrctl drivers we'll introduce later.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/pci/bus.c    | 9 ++++++++-
 drivers/pci/remove.c | 2 ++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 826b5016a101..17ab41094c4e 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -12,6 +12,7 @@
 #include <linux/errno.h>
 #include <linux/ioport.h>
 #include <linux/of.h>
+#include <linux/of_platform.h>
 #include <linux/proc_fs.h>
 #include <linux/slab.h>
 
@@ -342,8 +343,14 @@ void pci_bus_add_device(struct pci_dev *dev)
 	 */
 	pcibios_bus_add_device(dev);
 	pci_fixup_device(pci_fixup_final, dev);
-	if (pci_is_bridge(dev))
+	if (pci_is_bridge(dev)) {
 		of_pci_make_dev_node(dev);
+		retval = of_platform_populate(dev->dev.of_node, NULL, NULL,
+					      &dev->dev);
+		if (retval)
+			pci_err(dev, "failed to populate child OF nodes (%d)\n",
+				retval);
+	}
 	pci_create_sysfs_dev_files(dev);
 	pci_proc_attach_device(dev);
 	pci_bridge_d3_update(dev);
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index d749ea8250d6..fc9db2805888 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/pci.h>
 #include <linux/module.h>
+#include <linux/of_platform.h>
 #include "pci.h"
 
 static void pci_free_resources(struct pci_dev *dev)
@@ -22,6 +23,7 @@ static void pci_stop_dev(struct pci_dev *dev)
 		device_release_driver(&dev->dev);
 		pci_proc_detach_device(dev);
 		pci_remove_sysfs_dev_files(dev);
+		of_platform_depopulate(&dev->dev);
 		of_pci_remove_node(dev);
 
 		pci_dev_assign_added(dev, false);
-- 
2.40.1


