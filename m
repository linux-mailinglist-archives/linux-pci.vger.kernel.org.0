Return-Path: <linux-pci+bounces-6025-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0D589F2E9
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 14:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A95ACB22B0E
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 12:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9206216F0F5;
	Wed, 10 Apr 2024 12:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="yJ+2cRDh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E08B16DEA5
	for <linux-pci@vger.kernel.org>; Wed, 10 Apr 2024 12:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712753230; cv=none; b=gx25tGnqV05g4Gzb6UlkVFRshiBsqKMIjGoA1VPUQiJ4yjYv789ss9YC0jmCtNSYQCQv4xAfcb0scAhknIwguoTAyKqdrDzAU1vYV/bcqg8UM8aBu3uH03VGFNZ+6AUoMoknqOEdYMISre5PnaSC6kVHQYSjhr9MJK9uaDiuRyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712753230; c=relaxed/simple;
	bh=iWQpZyVUYNR0FgdTLJWWfXolJLly1aZ0q2sdWcfiADU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TyfctuRs9XatAzzG9i7Rpt3pOoMN2uOFE5FZ0ofwcJUF3PoEmGhyIzOqlRDyvIFw/djrl8EL4QqdlB9r9h7Z33WzaqWHSL/L/fCywTMPzU7oK5cJsrtNkWF70yHKs3csY4cscz1smONwjEuft7FyOyEBsECfw0LvDFB9t427A0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=yJ+2cRDh; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-41650ee55ffso23939285e9.0
        for <linux-pci@vger.kernel.org>; Wed, 10 Apr 2024 05:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1712753225; x=1713358025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VPKtETY44L+sLLhmL3uaX4nFnllKG+8eyvkbzTNtgX4=;
        b=yJ+2cRDhM8SYEcwNo18IZzI5FMBWN0Weuq80hH7gC1b60LUQaNNZ+6AFxfoJS7jHvu
         VY+bykXPg5BtG28sxBziM7ByiC3t/sMhEpnGGpnM68UCK4oC5e6ccFX8VJ73qRXAPBaU
         TqCho7cZhmkrf+bXoj0fI74CrQa7vD3SdlWXSeGcQ8JtaHdLLqchriVXpfSs/NML/6L5
         jr87pX+RfQWXxwPH04uizRAn5tbI3DaoJcaTnqQD3awCS7wuRH73oIdJs0rHs3gQIgOP
         7mtmODY9Jtyoxtv4+PGTlh96Kj11Y0sZM5z18Wmsh8yaVvcys/6rjdZP5qXlAe7yJyFb
         oIGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712753225; x=1713358025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VPKtETY44L+sLLhmL3uaX4nFnllKG+8eyvkbzTNtgX4=;
        b=q5yzbPezs1JUqvD/5GB57pV5Gp5wRHZG3x/tm3YrUitTkGgHaQrYMybVUg2lWZZuNg
         +NVLMOSdFk1SfmQr7UkzOgbMeVgzWSG5CuD/g4FnfyhIlsX5wZj6LW6vUHCkDZJDM/+t
         3nsrapgMqZcHq96xpvDOsoKxCYMQy8DjN1ZYxgIoG6Taw9YGyu8Nthv5Z/ECYZdv9ppE
         VpMt8f9scG1Tuk5klPREfEIxUEAqhv245GIiIYexj/pahNzzP56vH0zb/mpI+3RcwMwN
         AoptTzWyDJ/vIwzs/HNgA2wKXRgIBqZ/SqROdtHxdxrTA6cV2be4I8mBs3qj/N6VSBZ8
         BNYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqx9BZq4Iwo3tzme+v4Om1mZCWYo6AdyHuRewIalqUiV+3Q8yByUt4x5arep3seSQoJxjJQv03sy+PXd8s3f8EfGeNHXOhbnLX
X-Gm-Message-State: AOJu0Yypy9R81AZ8HLtDlRPYfdnGaj73/yhXZYxHGSSobKNPd+BzucHO
	qWuc2J9YQCkfmT94DQ0QRNau2gENcsp+OC+EVLszEhCN2JRnIuerGIBMuwjD15k=
X-Google-Smtp-Source: AGHT+IEJEixdHehBfMp+jzL2CRJ1R/XZVbko53cUIaZrL4a3OQkcOBk74DAFhpPjF+7rdj1jqQT+Wg==
X-Received: by 2002:a05:600c:1913:b0:416:9c95:b712 with SMTP id j19-20020a05600c191300b004169c95b712mr1689271wmq.20.1712753225367;
        Wed, 10 Apr 2024 05:47:05 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:75a:e000:6908:7e99:35c9:d585])
        by smtp.gmail.com with ESMTPSA id v13-20020a05600c444d00b0041663450a4asm2150929wmn.45.2024.04.10.05.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 05:47:05 -0700 (PDT)
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
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Amit Pundir <amit.pundir@linaro.org>,
	Xilin Wu <wuxilin123@gmail.com>
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
Subject: [PATCH v7 10/16] PCI/pwrctl: reuse the OF node for power controlled devices
Date: Wed, 10 Apr 2024 14:46:22 +0200
Message-Id: <20240410124628.171783-11-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240410124628.171783-1-brgl@bgdev.pl>
References: <20240410124628.171783-1-brgl@bgdev.pl>
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


