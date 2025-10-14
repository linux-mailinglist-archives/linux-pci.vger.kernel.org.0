Return-Path: <linux-pci+bounces-38035-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A37BD9015
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 13:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4AA2B352405
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 11:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF9130F940;
	Tue, 14 Oct 2025 11:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WfRUCQeJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F75C30C626
	for <linux-pci@vger.kernel.org>; Tue, 14 Oct 2025 11:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760441185; cv=none; b=V5jZpEdNnS/VifpdWHJF+P6iZq5vn7zyU28lOGUrgPkf4zpQvL/K7eWduhuHbaCX6UkIizY1rL53N0N4xvikjLc+uP2yVZuDWNvJnqiswUx+6Mo78NWdxsAHbOWYHjOGT37kLbKYr2NfaBqGivYG0R/zOIoe2BmUU22yLDP/n78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760441185; c=relaxed/simple;
	bh=WBNPAOl1IiO5eOs4BLPmth1N0JvusJem9fVKugbEi0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lrlDEUeJFzdZwdZpw2UoyqrtBKdiWa0kw5xYgGUkTyL8zZV+RhMsFzPEcXCqfcDGIqjheXenhiXYXix3ArNUXCW2Z38Be4mze8IKuzb90eoj7tth3LHxaifRyF/aqHQIUXw6h+yU5Naqemwv2bOihJ7B0nwVrpwFdbChigNZLak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WfRUCQeJ; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-46e37d10ed2so48014265e9.2
        for <linux-pci@vger.kernel.org>; Tue, 14 Oct 2025 04:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760441181; x=1761045981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EbYmHynLeWlw8u23NecrRWs1rFP/nnkTB1+gQnuvcng=;
        b=WfRUCQeJz/EQhr0GFi0+c8JpNb5W1PvgyGqLwmPyxI6XKo/Fh21ZWEgYBTEgy8eazz
         XkTsIoivhJzCbrm2BKaCLOUzY6v40vViafiTFxHf/LnJTkmOBy1eQlIIc/uj3Tke27Ev
         R8eSuYCNbGVaVq4b+t4GuRm/20UFZxUl1/UQ9JEsTl0WwMSEh3AuOEujAokfemtHbbCP
         r6Zx+VprRTQU+lSlLzLVaT8JaEiHg6wZBilGITHZViclqJcKGWcfyYrra0SmqZXokS15
         BZ5XmAd2MrSXb0hn/L6q+uSafm3FuHl7V+AhqSisMhU2NFaWMcRthYo/Zbxj+Proj4OD
         JYHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760441181; x=1761045981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EbYmHynLeWlw8u23NecrRWs1rFP/nnkTB1+gQnuvcng=;
        b=alxn7Zxte3tvrM7Webt3GWjOvQdqL9C39yZE5tak2fQ8X14x/EvqzuSeOps5xFAD75
         mj6lmA+iqaBVE4fN/StaXSPekeOWczPpKi7cdiGLlsg3LBj8ysumD/S88X+QR8DKr/yZ
         66U2cRvgm7YNQwOEU7/Gmn0C1opaCUPnvs2Ksr0n67jXyiL3wnb1Vwod1TJU8Byqt15i
         qiLJ3DUJX55YYBaQLqG9iH2+Lyt92HfOeJRjRYvFAL5vrmVSUKmt7Z3QxSAjbwxr+IBZ
         xv+FqZtS9FbwVMblcqPPKsm3K0ejWjz2TYaTn3IkvCLPp6V49+sg7c58OoWbUtyQGctK
         eBbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgngO8e9/s87alPGQZswTEMTui+Hv6DNp16IzRyr1ccjKAYIy9SxCXui84NQ9RkSCFmmS0ug06jF4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh1ipXXuj6vSVCf8lCs1r9UXS9SG2h1Y0M9KSs2V5kPT2lKZFP
	pObWSEm3PcUePeclywLzQaMNIdvxcyWunjHQW9wQp3lWEp5ZA/Vha+A2
X-Gm-Gg: ASbGncs2u4BxkUbWq3fN+jI+ihsNxnxgBmCa8rlet0CND4jsbRO9L4JmdTwYmc3H3xR
	S4wzmuSBc9mwaIRZnfiNj7v+yQ9l8zLQ69qCxsFR7/bkcJFTmwXzcEbRHSbNWsIEKG7a21GLdFi
	HG+X0tCYxHID9o2l803eibqGTIGplbnr8h0GFc7k5qI+8afomYUQfhlt2WL1ippSrGAd0YHotWe
	J4uyzy6a3hmr9CP/J/SIZ8M0euHaWwCLQ3VMOQ7Eb57SpeMY/+sBfrygpsg2OcboVgN6hh+1x4k
	1N4ESRITktSpn/ylWKfz/PDtCbxZwVSydc+PWQ1FppfcjB272y72yxPRLQDUSxIY2ScSN9dQFEU
	OmTvW8W6ZsYQavS7oFKkaMZ9V/2nfG88DV5gXsTQsxhtc7nFGTe/IPBxU0g==
X-Google-Smtp-Source: AGHT+IFO2uKjeUaYUKbnwXbbO+Xo/HgCqYDDA6YUTOMYT5kkkih/xh4BWfPVSZJs7SLyBcg2m31Icw==
X-Received: by 2002:a05:600c:4745:b0:46d:cfc9:1d0f with SMTP id 5b1f17b1804b1-46fa9af30e5mr188941035e9.19.1760441180577;
        Tue, 14 Oct 2025 04:26:20 -0700 (PDT)
Received: from vitor-nb (bl19-170-125.dsl.telepac.pt. [2.80.170.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb492e6ddsm265829845e9.0.2025.10.14.04.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 04:26:20 -0700 (PDT)
From: Vitor Soares <ivitro@gmail.com>
To: Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Vitor Soares <vitor.soares@toradex.com>,
	linux-omap@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	ivitro@gmail.com
Subject: [PATCH v1 2/2] PCI: j721e: Add support for optional regulator supplies
Date: Tue, 14 Oct 2025 12:25:49 +0100
Message-ID: <20251014112553.398845-3-ivitro@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014112553.398845-1-ivitro@gmail.com>
References: <20251014112553.398845-1-ivitro@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vitor Soares <vitor.soares@toradex.com>

Some boards require external regulators to power PCIe endpoints.
Add support for optional 1.5V, 3.3V, and 12V supplies, which may be
defined in the device tree as vpcie1v5-supply, vpcie3v3-supply, and
vpcie12v-supply.

Use devm_regulator_get_enable_optional() to obtain and enable each
supply, so it will be automatically disabled when the driver is
removed.

Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
---
 drivers/pci/controller/cadence/pci-j721e.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index 5bc5ab20aa6d..f29ce2aef04e 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -21,6 +21,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 
 #include "../../pci.h"
 #include "pcie-cadence.h"
@@ -467,6 +468,10 @@ static const struct of_device_id of_j721e_pcie_match[] = {
 };
 MODULE_DEVICE_TABLE(of, of_j721e_pcie_match);
 
+static const char * const j721e_pcie_supplies[] = {
+	"vpcie12v", "vpcie3v3", "vpcie1v5"
+};
+
 static int j721e_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -480,6 +485,7 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 	struct gpio_desc *gpiod;
 	void __iomem *base;
 	struct clk *clk;
+	unsigned int i;
 	u32 num_lanes;
 	u32 mode;
 	int ret;
@@ -565,6 +571,13 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
+	for (i = 0; i < ARRAY_SIZE(j721e_pcie_supplies); i++) {
+		ret = devm_regulator_get_enable_optional(dev, j721e_pcie_supplies[i]);
+		if (ret < 0 && ret != -ENODEV)
+			return dev_err_probe(dev, ret, "can't enable regulator %s\n",
+					     j721e_pcie_supplies[i]);
+	}
+
 	dev_set_drvdata(dev, pcie);
 	pm_runtime_enable(dev);
 	ret = pm_runtime_get_sync(dev);
-- 
2.51.0


