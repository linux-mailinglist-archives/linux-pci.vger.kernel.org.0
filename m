Return-Path: <linux-pci+bounces-17543-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA35A9E06B0
	for <lists+linux-pci@lfdr.de>; Mon,  2 Dec 2024 16:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9FC12824EC
	for <lists+linux-pci@lfdr.de>; Mon,  2 Dec 2024 15:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27EDA209F55;
	Mon,  2 Dec 2024 15:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KlP7mxwd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC221D545;
	Mon,  2 Dec 2024 15:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733152334; cv=none; b=bKHqqh30G52DfjZ6qNG2EYyj+pxkcJqLLfFH1HA9r18/oPQ9m+894QeSw6aINwLvNJfR93gN8XAR+QQdFddfPyO+CTPRBE3CVHTmCiz0zIB7jBz/EXTSQv5bdxk8qpyjcpc/fJ2GBSQVbHm60Mfl/0qB1gONM4Ja/pnNeN1E4HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733152334; c=relaxed/simple;
	bh=SRYFXxrW4YznYwcW9FUcExbIpXBDmP/q9nh/Pa9GfEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ernHUsuFYUqYQ44GNko5htDrMdGA3zEOe6XKeqiNpRhVY7yCfhsdz+5p5BKA+Nj2bX82VyKWo6H7Qtbqd8xvWPAnuZrnBJvk6jk31C0tH6z7VF2eG3YbOZA1SHR8Jz4nwBPqMV4E12pj5ete2jhHogNq7UtzGxayOgeavN2GOJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KlP7mxwd; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2154e3af730so21804905ad.3;
        Mon, 02 Dec 2024 07:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733152332; x=1733757132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aSE1oYmswp4nZQvrKL5VAYP4YbLQSL+PfB27DrayTI4=;
        b=KlP7mxwdmV3f0+meIsbfb/Q8DPBJ2Pc8zJibTX/wPEsPbWA9HspqCJ0oRqYaOuzUhM
         l+/C/yOnYPy6u8jEdEpP0pMWEG8BOzkWJcaw94sw+h9dKe18k3NH/BvsRmkziKn4T9tA
         8JjwYJy1zSVd6X/1iwJ2XaJWvXXDGtPmujhuSYZ7xACzCRqz37I5OOhGmmGRHEVL/66J
         aZIWHmbZqJqI/hRjSwG3o2ZvWUO+Mp0cwzEFw5ecYTuJHLdoqvKzUqQLzBs61T53uSaO
         KbmGTcKWog6Q/EiylkCHnyGTEohvt5+GYsjk/1PuZZksCLUB0RFr7Ajp+uWH111d4P86
         s8aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733152332; x=1733757132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aSE1oYmswp4nZQvrKL5VAYP4YbLQSL+PfB27DrayTI4=;
        b=GdPZJl2C74x/6c68zvry6hN3972rbzbEWAx8fP0kSQRq8lRjtcchGveH4sgp8VNBKb
         LH8/Q3gzttLTf3hSsWqqgcItbgsmjpA6kVbc2zUwTJe8PvfeGlT3jLbTr4mLKYE43XhA
         7kAjHzU2Ow9VWZ5fH6rQezFbw+RXGNb3XS5QB8Trm99v9sRx/J7nBhENAy/sByXOTi8g
         WbrNMno4lV6NrHLuZpJb0dyq+taaC7CxO6Ch8cDdS6WgpHtU/aFL2fhwbVtWaBMleSl7
         bbswo/IZ8bMzKilBJagjaXGYkcT5ksp0VThoHDoZbZQ0rc9/bnFqzshaH6rND4wx+Uqj
         IS0Q==
X-Forwarded-Encrypted: i=1; AJvYcCURG7Wp1Ho91vjR0GEiKqLMPluOPA0DDBfRZKYLxNpgoFkQjXnrFlYoL5GReniwbuLrGRsTiXvUHmZlGPo=@vger.kernel.org, AJvYcCWDycN35bgHVNo0OlucXBF8j/yKniYmumOtEUoACcq01OK/Lg8tUsVEOr9r3DWzuOnYBCPeU3DyTSK/@vger.kernel.org
X-Gm-Message-State: AOJu0YxWjHCaHnoUoAppg0Z301IIaL6BHep8SehMYoQrSbU5Vxovinnk
	QvtPXwd2q2xcvHEFM4pPS7ukLd+PzVK5Atx+0ELk5Oe3LrH0fHQE
X-Gm-Gg: ASbGncvAJJjV/sMjFd+r2kipoF5wkEyzOe/+iYzn21aYcYB9j8jJevIxa+n0xLLt4Fg
	0vIJJ/6puQopWhh4+rNkGvQKYss6sdJDJiMp2iIuD7oTh3xiZTsH+l5C1sC6/+FngQCEqkdOzT5
	6Fu7pH3lXecA7MelPtm5QNxI2uD2qkHX0l99/llsD1AeCb1Ecg1rj6N3SmW901QknZIqFo52V9s
	dq1yZ6nqTQTEjZU8PzvjBiaRuufJUKxSetPtj7KF2IzSuOH7ZkpB6qYqgdp5UECVQ==
X-Google-Smtp-Source: AGHT+IGJGsBN5Bz9z/jmVRFG5EPn8EbineRclxV2mlzSvVxPBgKVWQ30c1kjlQPr/eERQsBmU2EONA==
X-Received: by 2002:a17:903:440f:b0:215:a7e4:8475 with SMTP id d9443c01a7336-215a7e48795mr33777685ad.24.1733152331602;
        Mon, 02 Dec 2024 07:12:11 -0800 (PST)
Received: from localhost.localdomain ([113.30.217.223])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215218f1da4sm78524955ad.12.2024.12.02.07.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 07:12:10 -0800 (PST)
From: Anand Moon <linux.amoon@gmail.com>
To: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Anand Moon <linux.amoon@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v11 1/3] PCI: rockchip: Simplify clock handling by using clk_bulk*() function
Date: Mon,  2 Dec 2024 20:41:42 +0530
Message-ID: <20241202151150.7393-2-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241202151150.7393-1-linux.amoon@gmail.com>
References: <20241202151150.7393-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the driver acquires clks and prepare enable/disable unprepare
the clks individually thereby making the driver complex to read.
But this can be simplified by using the clk_bulk*() APIs.
Use devm_clk_bulk_get_all() API to acquire all the clks and use
clk_bulk_prepare_enable() to prepare enable clks
and clk_bulk_disable_unprepare() APIs disable unprepare them in bulk.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
V11: None
V10: None
v9: Re write the commmit message.
v8: Improve the description of the code changes in commit messagee.
    Add Rb: Manivannan
v7: Update the functional change in commmit message.
v6: None.
v5: switch to use use devm_clk_bulk_get_all()? gets rid of hardcoding the
       clock names in driver.
v4: use dev_err_probe for error patch.
v3: Fix typo in commit message, dropped reported by.
v2: Fix compilation error reported by Intel test robot.
---
 drivers/pci/controller/pcie-rockchip.c | 65 +++-----------------------
 drivers/pci/controller/pcie-rockchip.h |  7 ++-
 2 files changed, 10 insertions(+), 62 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/controller/pcie-rockchip.c
index b9ade7632e11..53aaba03aca6 100644
--- a/drivers/pci/controller/pcie-rockchip.c
+++ b/drivers/pci/controller/pcie-rockchip.c
@@ -129,29 +129,9 @@ int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
 		return dev_err_probe(dev, PTR_ERR(rockchip->perst_gpio),
 				     "failed to get PERST# GPIO\n");
 
-	rockchip->aclk_pcie = devm_clk_get(dev, "aclk");
-	if (IS_ERR(rockchip->aclk_pcie)) {
-		dev_err(dev, "aclk clock not found\n");
-		return PTR_ERR(rockchip->aclk_pcie);
-	}
-
-	rockchip->aclk_perf_pcie = devm_clk_get(dev, "aclk-perf");
-	if (IS_ERR(rockchip->aclk_perf_pcie)) {
-		dev_err(dev, "aclk_perf clock not found\n");
-		return PTR_ERR(rockchip->aclk_perf_pcie);
-	}
-
-	rockchip->hclk_pcie = devm_clk_get(dev, "hclk");
-	if (IS_ERR(rockchip->hclk_pcie)) {
-		dev_err(dev, "hclk clock not found\n");
-		return PTR_ERR(rockchip->hclk_pcie);
-	}
-
-	rockchip->clk_pcie_pm = devm_clk_get(dev, "pm");
-	if (IS_ERR(rockchip->clk_pcie_pm)) {
-		dev_err(dev, "pm clock not found\n");
-		return PTR_ERR(rockchip->clk_pcie_pm);
-	}
+	rockchip->num_clks = devm_clk_bulk_get_all(dev, &rockchip->clks);
+	if (rockchip->num_clks < 0)
+		return dev_err_probe(dev, err, "failed to get clocks\n");
 
 	return 0;
 }
@@ -375,39 +355,11 @@ int rockchip_pcie_enable_clocks(struct rockchip_pcie *rockchip)
 	struct device *dev = rockchip->dev;
 	int err;
 
-	err = clk_prepare_enable(rockchip->aclk_pcie);
-	if (err) {
-		dev_err(dev, "unable to enable aclk_pcie clock\n");
-		return err;
-	}
-
-	err = clk_prepare_enable(rockchip->aclk_perf_pcie);
-	if (err) {
-		dev_err(dev, "unable to enable aclk_perf_pcie clock\n");
-		goto err_aclk_perf_pcie;
-	}
-
-	err = clk_prepare_enable(rockchip->hclk_pcie);
-	if (err) {
-		dev_err(dev, "unable to enable hclk_pcie clock\n");
-		goto err_hclk_pcie;
-	}
-
-	err = clk_prepare_enable(rockchip->clk_pcie_pm);
-	if (err) {
-		dev_err(dev, "unable to enable clk_pcie_pm clock\n");
-		goto err_clk_pcie_pm;
-	}
+	err = clk_bulk_prepare_enable(rockchip->num_clks, rockchip->clks);
+	if (err)
+		return dev_err_probe(dev, err, "failed to enable clocks\n");
 
 	return 0;
-
-err_clk_pcie_pm:
-	clk_disable_unprepare(rockchip->hclk_pcie);
-err_hclk_pcie:
-	clk_disable_unprepare(rockchip->aclk_perf_pcie);
-err_aclk_perf_pcie:
-	clk_disable_unprepare(rockchip->aclk_pcie);
-	return err;
 }
 EXPORT_SYMBOL_GPL(rockchip_pcie_enable_clocks);
 
@@ -415,10 +367,7 @@ void rockchip_pcie_disable_clocks(void *data)
 {
 	struct rockchip_pcie *rockchip = data;
 
-	clk_disable_unprepare(rockchip->clk_pcie_pm);
-	clk_disable_unprepare(rockchip->hclk_pcie);
-	clk_disable_unprepare(rockchip->aclk_perf_pcie);
-	clk_disable_unprepare(rockchip->aclk_pcie);
+	clk_bulk_disable_unprepare(rockchip->num_clks, rockchip->clks);
 }
 EXPORT_SYMBOL_GPL(rockchip_pcie_disable_clocks);
 
diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
index a51b087ce878..f79c0a1cbbd0 100644
--- a/drivers/pci/controller/pcie-rockchip.h
+++ b/drivers/pci/controller/pcie-rockchip.h
@@ -11,6 +11,7 @@
 #ifndef _PCIE_ROCKCHIP_H
 #define _PCIE_ROCKCHIP_H
 
+#include <linux/clk.h>
 #include <linux/kernel.h>
 #include <linux/pci.h>
 #include <linux/pci-ecam.h>
@@ -321,10 +322,8 @@ struct rockchip_pcie {
 	struct	reset_control *pm_rst;
 	struct	reset_control *aclk_rst;
 	struct	reset_control *pclk_rst;
-	struct	clk *aclk_pcie;
-	struct	clk *aclk_perf_pcie;
-	struct	clk *hclk_pcie;
-	struct	clk *clk_pcie_pm;
+	struct  clk_bulk_data *clks;
+	int	num_clks;
 	struct	regulator *vpcie12v; /* 12V power supply */
 	struct	regulator *vpcie3v3; /* 3.3V power supply */
 	struct	regulator *vpcie1v8; /* 1.8V power supply */
-- 
2.47.0


