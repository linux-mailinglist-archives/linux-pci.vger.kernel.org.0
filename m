Return-Path: <linux-pci+bounces-5096-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A986788A742
	for <lists+linux-pci@lfdr.de>; Mon, 25 Mar 2024 16:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD4861C3E199
	for <lists+linux-pci@lfdr.de>; Mon, 25 Mar 2024 15:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DF01494DE;
	Mon, 25 Mar 2024 13:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="cUbS4nGT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AE414B06B
	for <linux-pci@vger.kernel.org>; Mon, 25 Mar 2024 13:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711372637; cv=none; b=TBnAZRF8+QxWMQ4MRZtbse7yNj0+RqahRI68q0wUQW1ogkqLDGcICM+dfw3B7JE9l3gm1t4pxXf7Znk+93oCy9Ze9JUkOvN/3XHHkxjE6pW1WZluN5DybtCBTp7JZ5xVSTY5uogVMAOhBSml+sziW3zKfNx5Zsm1YVi2v7ij7NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711372637; c=relaxed/simple;
	bh=iWQpZyVUYNR0FgdTLJWWfXolJLly1aZ0q2sdWcfiADU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=thpCrRcCfW6cN18euRkDfYZ9LxVd4UgKc4u3gapUYzK26gSlRwatRvj9LeRHfwvTrLWwGmz+44rPwiwZr06uVmRzSpbTCrKEYULNQnFJOXPeKxT3yy2Vpe6dYQPOKzchyUgKmnRELvdW/48ygtILnmDgPzpLqdwNMVnXAuwGj48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=cUbS4nGT; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4148c6af2d3so375185e9.1
        for <linux-pci@vger.kernel.org>; Mon, 25 Mar 2024 06:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1711372632; x=1711977432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VPKtETY44L+sLLhmL3uaX4nFnllKG+8eyvkbzTNtgX4=;
        b=cUbS4nGT0+lfRnrunIb/YNFs5x5KjLBB5tZj58rqQZ7yj/oqsNqHDCkLnoS6eAcE3p
         gsyW+n+o3iwItVVdhcFdeenW8F1X5Zt3O/JWzE37VCVkAFHXC8C8FnbosWgnOOP9C+01
         mhG2DfaImEHlzrhbgbnliOF2Xe6PQzer30VhTpSvo9gydkqSBz3w+wqTbWeyNBwgkeqb
         VaocQURcHNwf9IiMy9cyCF2mMu3uwlcIcd9bFMW6hIMA32tf9SVptNUb0H6rESyOwQHK
         OXHdbOdnZFO0PnOCjWAH0Z2FaSVX1LU9+/EefNDKZsGMxv6Kqlm9cqyHLPM6gPRaOHty
         Mzhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711372632; x=1711977432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VPKtETY44L+sLLhmL3uaX4nFnllKG+8eyvkbzTNtgX4=;
        b=v5mQx2FiBVaJXM358iT4uR+gLj+Dfi7Klu1S8iaqmWMOM8A5+wEtBttXOXlL3lYaeW
         kDngtaYQb2gg1O+glBUBEEvM+g1DWVL2O5kF62zs1rUzaJ13HA2iszyl7FD5V/G29ioy
         t0DD3weykdYs2QFL0I0fcMxutr1Un9zHWPu9MY652fuEB37HhBHG7jwNBHNtm7Q/JTaQ
         amjwzNeUyvyQ/jFO2EQUfz9gqdF4y/NPohcXR+P1PYrJUL59EjRcVq/mQ55JUXh4T6NO
         klcnpY/KoYiYz4y0mPqdyiVMER4Yqqn+9MmoeHU17xxPMOExnWqldQjF+tSRqfjxS6bh
         YC0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVpWs90kP4HbMCMBopyGMkrAE96jjP88V+ibExfDP+s5XtSh4zA/haIfuJwKtdjLPAUWARcWqkxdR/TM0DDFW6LnIMtcSA88JWm
X-Gm-Message-State: AOJu0YzH3utQFUwwOLvplGGN9vlYKCeyPMYhM+qAq+xM3web1jabyOZD
	UFl64roNulxUVPLt9wow8jjJaESfv+WnO+RDJIxm6IwabJFLs/CF/TdXnjXbBUU=
X-Google-Smtp-Source: AGHT+IE8S1Cqc4BSl1gj1NJjC/8Phc5hQVnSu5kD3rjt0a7CtT1C9cZCCiVYJzGQ4RLrhpqJ51Qh5g==
X-Received: by 2002:a5d:4bd1:0:b0:33d:b2d7:6264 with SMTP id l17-20020a5d4bd1000000b0033db2d76264mr4900718wrt.51.1711372632066;
        Mon, 25 Mar 2024 06:17:12 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:75a:e000:861d:8b72:a859:4ce9])
        by smtp.gmail.com with ESMTPSA id p11-20020a056000018b00b0033e75e5f280sm9485245wrx.113.2024.03.25.06.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 06:17:11 -0700 (PDT)
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
Subject: [PATCH v6 10/16] PCI/pwrctl: reuse the OF node for power controlled devices
Date: Mon, 25 Mar 2024 14:16:18 +0100
Message-Id: <20240325131624.26023-11-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240325131624.26023-1-brgl@bgdev.pl>
References: <20240325131624.26023-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

With PCI power control we deal with two struct device objects bound to
two different drivers but consuming the same OF node. We must not bind
the pinctrl twice. To that end: before setting the OF node of the newly
instantiated PCI device, check if a platform device consuming the same
OF node doesn't already exist on the platform bus and - if so - mark the
PCI device as reusing the OF node.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/pci/of.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 51e3dd0ea5ab..b908fe1ae951 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -6,6 +6,7 @@
  */
 #define pr_fmt(fmt)	"PCI: OF: " fmt
 
+#include <linux/cleanup.h>
 #include <linux/irqdomain.h>
 #include <linux/kernel.h>
 #include <linux/pci.h>
@@ -13,6 +14,7 @@
 #include <linux/of_irq.h>
 #include <linux/of_address.h>
 #include <linux/of_pci.h>
+#include <linux/platform_device.h>
 #include "pci.h"
 
 #ifdef CONFIG_PCI
@@ -25,16 +27,20 @@
  */
 int pci_set_of_node(struct pci_dev *dev)
 {
-	struct device_node *node;
-
 	if (!dev->bus->dev.of_node)
 		return 0;
 
-	node = of_pci_find_child_device(dev->bus->dev.of_node, dev->devfn);
+	struct device_node *node __free(device_node) =
+		of_pci_find_child_device(dev->bus->dev.of_node, dev->devfn);
 	if (!node)
 		return 0;
 
-	device_set_node(&dev->dev, of_fwnode_handle(node));
+	struct device *pdev __free(put_device) =
+		bus_find_device_by_of_node(&platform_bus_type, node);
+	if (pdev)
+		dev->bus->dev.of_node_reused = true;
+
+	device_set_node(&dev->dev, of_fwnode_handle(no_free_ptr(node)));
 	return 0;
 }
 
-- 
2.40.1


