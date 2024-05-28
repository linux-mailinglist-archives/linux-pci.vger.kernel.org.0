Return-Path: <linux-pci+bounces-7924-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2C98D2430
	for <lists+linux-pci@lfdr.de>; Tue, 28 May 2024 21:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5364E282FE5
	for <lists+linux-pci@lfdr.de>; Tue, 28 May 2024 19:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF03181D0C;
	Tue, 28 May 2024 19:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="xLT42iQZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2119418131C
	for <linux-pci@vger.kernel.org>; Tue, 28 May 2024 19:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716923053; cv=none; b=FLIieVAkoOBES5xaxO5ibJbM5DHDvdk2FEDA7rNvrFGBSL5dZAuRlnXxghYj0pQ815GlnEHcjtCvTK5SMKiXUYm6/o+jB8gr2bVQ3hkXDyED3Z7oCADoxoGkr+RuNVZXdI4D0OX7IIsL+8w6/g/0s7WvlYrebGhY1B2qSO7knTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716923053; c=relaxed/simple;
	bh=3r2pVqN/+sHLQ4OSYerfs9CNKSL3i2KwEG+Umh+aH7w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mpTeNN6g0Z9lQ44G1z1JxbKZiTyyGkf7FwsdFNLWGFe3f8SB1Jo2W9+m5/ICQbI1go6oIjTqxDJ9+hkH7YOVv5vwCNgBIfiOI2GsdWyj46/pP4NSoUzoIk1/DccUIxFSor1EetstcyVYM7OB5BXNsl6Qu0LSp81i53kncnWqro0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=xLT42iQZ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4202ca70289so10060365e9.1
        for <linux-pci@vger.kernel.org>; Tue, 28 May 2024 12:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1716923047; x=1717527847; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZIAqX/A7cyBOqcNtjCtgW6nW/To9B5cWPZdLS8273K0=;
        b=xLT42iQZqoKFX1HgSinFagmmF6KcjyBTeVFcZV/3bqqRJr/OJACcUahsd0daNn55aj
         j+h7YhkGtkD4qhEJiogkRQ3G5FAsO6/C3CriwP2KYKlDj7JvbSIRO3hhe2CkTSCj4Awp
         c9fCV79+x4kUJhppHrMhcqOKJlIJvb83EnaoNfZhngu7HI3xSsKO8watAxxosJmpoB3d
         zxO6XWy7XWyaEx6XleZ5QeT0NU9E9qcThBQQph48t4m5YH4B+NxhuU/gg5zBAbFgA0j6
         N3yjtLVW7TiGZ6E+wCIyCaJs6SiYsvgoId+pYEv9d4XKsst60GRWkL8Rj247uIWD8G6Z
         ZjRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716923047; x=1717527847;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZIAqX/A7cyBOqcNtjCtgW6nW/To9B5cWPZdLS8273K0=;
        b=jPiG3AGsG3HBEqDbOEYC9Gq2Qu1lvdRWpdhLsbulv9zov/GbeN/aB+XiSR0Fb+j82l
         Ap7DBaLX3e6bI6QK3E4eEJSx3bcU/8nzVHVq6XqWwqEyVk1nrAdALoGfCYlrKWgFLxeS
         y3Om1XHUsWr7lBEhEXF92R6iS5lgXMnC1d8C2rRJRPO/lTJii75HaebtA5Z057PyPtE+
         ynwFsXKbEdrrPuzAfB7UDLhmJMGmPVvr2vYgXslMz+yz7MchkLWHou0HwHM0atefzWBo
         /ICVCT3Li+S9rHkzW+2yjUDDGir0l1yDXJcMqIpy6i/MhTx900nqZEZnxTHkjNJc4cO/
         Zx+w==
X-Forwarded-Encrypted: i=1; AJvYcCXWgpC2weDBl8P+y29xMXzAP1M4N+S6oPqRd/njnkFSoxdryzp0zN/0RkWU3o++V2W9f8Kt5lKK8FhlCNFeoae8PAADrI1R1ZNu
X-Gm-Message-State: AOJu0Ywg7uzVUb18JkeHRPEdozD1F+QpKS1NxKOKC7fbmGE5EzoSab2s
	EgddaH2be0pCVvmJDA62vZbWx+JHoAzUXPWX7JEirA2lIiwJCD72CPD/FGQlTW0=
X-Google-Smtp-Source: AGHT+IHz0lkGSUV61P5eSq7TShjaoltPA0/QAdOG/j0o1z0ZCy0AcWo0waox12rHLA8DHj/vEX/Bzw==
X-Received: by 2002:a05:600c:46c4:b0:41a:e995:b924 with SMTP id 5b1f17b1804b1-42108a0b91dmr82051805e9.33.1716923046905;
        Tue, 28 May 2024 12:04:06 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:75a:e000:93eb:927a:e851:8a2f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100ee954bsm183895415e9.4.2024.05.28.12.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 12:04:06 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 28 May 2024 21:03:22 +0200
Subject: [PATCH v8 14/17] PCI/pwrctl: create platform devices for child OF
 nodes of the port node
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240528-pwrseq-v8-14-d354d52b763c@linaro.org>
References: <20240528-pwrseq-v8-0-d354d52b763c@linaro.org>
In-Reply-To: <20240528-pwrseq-v8-0-d354d52b763c@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, 
 Rocky Liao <quic_rjliao@quicinc.com>, Kalle Valo <kvalo@kernel.org>, 
 Jeff Johnson <jjohnson@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Bjorn Helgaas <bhelgaas@google.com>, 
 Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
 Elliot Berman <quic_eberman@quicinc.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Alex Elder <elder@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 netdev@vger.kernel.org, linux-wireless@vger.kernel.org, 
 ath11k@lists.infradead.org, Jeff Johnson <quic_jjohnson@quicinc.com>, 
 ath12k@lists.infradead.org, linux-pm@vger.kernel.org, 
 linux-pci@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, kernel@quicinc.com, 
 Amit Pundir <amit.pundir@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2188;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=JjTaqS3wTDZBLouvY0ZN3GdR/yNW7FaquCkQXG8PeWA=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBmViqQjRkZ9uZOgI/9NbVSvh6khAK880XtupTre
 fVqi1WIceiJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZlYqkAAKCRARpy6gFHHX
 cmNaEACVAeQ8jz+bWQVF+5dvErJuYBGMqjrtYZBxIdGU7EEGgixkfvwFd0AQFhVe8FqHHJWKs4M
 N06NxP7um7vj/xY0SfElsVbf+NXxYsM/OsZkE5qf3kbBQLhacRowt34vhWGfcUsx5+XxzhS7Rpp
 ZC/AmPx6sldLAcNvvUYEhb3WuryaMZO9/NLnNJN/zXoWSCAeQ4MkYMER3sGq/OCEL+BRb3yXK6L
 +A/foR6+Bv4ztyECvXpNXmtr9ObiJT+48LDRaVfwS45XtSUXzS5GHthSGZdDwT0A1ZtqcXIKKmY
 QSyNKVJtljr5mhnonYU/9zmEVtnqMieZAEtXNkgHGNaNeronuzQJX1sKQgB6Qndnq0YIM3asebV
 xNjkBK1Rh0jpTCyCmiZvkJjPIc5oImwGBOemuaCf52tUlJliwsQeVRHE0L1ZFz/F+XHu0wIYpPQ
 NTvkWV6EnUUhJnNGnFqu8fYCf/Fv8WNUhsV6dBrkdryH5PbhY2mXT6diVfTMtgqF20al/woinO6
 tOD/o3bSvczc/u8MisHsUmc/Ld9q5YcMsEIMHkZoj8HGHfVzuQEIaRoHV9uux0vxqEHswcwN6xG
 3nwdBlbptcXMcK3gE/GtdGmeQHOFv2XgC1fQBmKkzyGQfTERVXvRfFnKII7vGfrEBNhWiqtTKwe
 GoKcrXlo0l1BGgw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

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

Tested-by: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/pci/bus.c    | 9 +++++++++
 drivers/pci/remove.c | 3 ++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 826b5016a101..3e3517567721 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -12,6 +12,7 @@
 #include <linux/errno.h>
 #include <linux/ioport.h>
 #include <linux/of.h>
+#include <linux/of_platform.h>
 #include <linux/proc_fs.h>
 #include <linux/slab.h>
 
@@ -354,6 +355,14 @@ void pci_bus_add_device(struct pci_dev *dev)
 		pci_warn(dev, "device attach failed (%d)\n", retval);
 
 	pci_dev_assign_added(dev, true);
+
+	if (pci_is_bridge(dev)) {
+		retval = of_platform_populate(dev->dev.of_node, NULL, NULL,
+					      &dev->dev);
+		if (retval)
+			pci_err(dev, "failed to populate child OF nodes (%d)\n",
+				retval);
+	}
 }
 EXPORT_SYMBOL_GPL(pci_bus_add_device);
 
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index d749ea8250d6..910387e5bdbf 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/pci.h>
 #include <linux/module.h>
+#include <linux/of_platform.h>
 #include "pci.h"
 
 static void pci_free_resources(struct pci_dev *dev)
@@ -18,7 +19,7 @@ static void pci_stop_dev(struct pci_dev *dev)
 	pci_pme_active(dev, false);
 
 	if (pci_dev_is_added(dev)) {
-
+		of_platform_depopulate(&dev->dev);
 		device_release_driver(&dev->dev);
 		pci_proc_detach_device(dev);
 		pci_remove_sysfs_dev_files(dev);

-- 
2.43.0


