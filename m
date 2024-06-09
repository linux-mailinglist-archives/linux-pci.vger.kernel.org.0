Return-Path: <linux-pci+bounces-8502-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 874F49015C6
	for <lists+linux-pci@lfdr.de>; Sun,  9 Jun 2024 12:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D03FBB210C9
	for <lists+linux-pci@lfdr.de>; Sun,  9 Jun 2024 10:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87BA52374C;
	Sun,  9 Jun 2024 10:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bOlOidA7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C957AAD23;
	Sun,  9 Jun 2024 10:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717930581; cv=none; b=E5aJNymhTxXUmHEzQgby0PZT5PF3Fy2FKDD2IRQ0Ux7wVOJkGUsoxqXi8o3a/41Srn+aFhcv8ItKBfm3OW9YkLnR/YEHEXiajGdbwRR/nWqk9ZaWeM4GEEHnmydGt4JATmwpIKEvaw6EqfUbOVtjN7q54joN6arV6/xTvx+lMbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717930581; c=relaxed/simple;
	bh=G2hg/LZavyIG1ablJTpUBbyufDXTz4RIOIjygW/UaMI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jZDCKcQlyeBiHAM8v6cmlKxVIDdWuF+x3y4ZEcAEg6lvyXdVcVlgGQ8eYwWnSNbqOD3YpKsvDUZCy9BEYkVdvZTtsjyzQ9G97vk1KKykwHi1bRi1EisBKjShH0f0yP5biXYyYJ9hjKLLLMSjv/R2gMWlzSOXAe9zGJRXUcDS2z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bOlOidA7; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-57c6d3e6606so1384213a12.0;
        Sun, 09 Jun 2024 03:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717930578; x=1718535378; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3voIYlOeB5mX7nvtdxB8Eo8oV2RJtvlVRRCS4qN4heM=;
        b=bOlOidA7eEa6ehlGJ+Aokoek03JgneOOmB39sIO8dh5c3wopT05cN/XLC9Rv5czesq
         e5H+64/DErx7dd3Bt1Wd+NAAgeEMb0lp6BV1KcPyuXzxo5tG4syjStKi0HlQC1aADeG4
         LlsfZRWxEumZiBDHE1TtNPxkzAi6MuUvdEr0D7Uqywk64bEFjo+W2aGVwR/zeFwUOh9o
         f5ZnStawwK2QuadospjsAdGT4uixKrKb2OdWbiGF6AGxXdbhXL+hTO0v5L1hmQ/OHGk0
         VLhVZOI2+aLtBTxUUYhsn/HL5jN9qWkv5ehI8O+S01q10xeTfhBY8Tmrje07cSyaZQWZ
         Bb6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717930578; x=1718535378;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3voIYlOeB5mX7nvtdxB8Eo8oV2RJtvlVRRCS4qN4heM=;
        b=SCCsSDe5KSdFbhMoPjebpk+29Es/PypNhJBVcg9r4iZt9cYLL8fd8iUVCeFeVO/Yzk
         Rw9tV4unMkiKyVRlXfdeQXre/2HPtjhtbbZmIryVVBjR7C/MhsKP0OMcbrbpEfipG0K+
         S34p9z1Mg3nP2LWawWxgMMebd5m/gHoZ//nSwujqLIZH6nOy6S7ZhWGhwqt9WRXU5SF0
         JNGxVBh48ChNlw/X+qat6/5ooyFzs4SeQKf8jjNCiyXRK4HQ2R5KCDarT1BNJaNugkvu
         oqfLVkM5r6BuioqYrJTM9oXqdehpgeN4AQMD15wV9cYDF+a+M+mNzZkgy3wYrmlwsmGq
         Z8ug==
X-Forwarded-Encrypted: i=1; AJvYcCU/bklpCoTkuwh3eidrHc0So+aZHfhY/+o2o01UOQuYDyK8ViBLjoQfOOfOLHJNFTtRvNVOJinG3eCISoPszMgeNeRg/TU2aZXMRkLoD8zGrw6UdlreOBD+fC/ZXIpK9qLx/3MLPNLH
X-Gm-Message-State: AOJu0YxIcyR/e51x3MNwywrAUPhuBvw5AXF+qRF70Inz2JUVju64z+55
	yOpc50bI8i+n7F85LvZT7hvFgKbNTVI4xQHHTyHWa/st0mtjK2cI8n1rdGkh
X-Google-Smtp-Source: AGHT+IELzm18zyq4qhBV75a1rqArcHYbNYokUk+XmpYTl0v52J/I42rnvlVqNi/AIYndB2LgF5LtEg==
X-Received: by 2002:a17:906:d157:b0:a6f:1f67:9816 with SMTP id a640c23a62f3a-a6f1f67988cmr168666b.22.1717930577461;
        Sun, 09 Jun 2024 03:56:17 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-920c-9ce8-de2d-a8c4.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:920c:9ce8:de2d:a8c4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6ef83ac0c4sm265066466b.74.2024.06.09.03.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 03:56:17 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Sun, 09 Jun 2024 12:56:14 +0200
Subject: [PATCH] PCI: kirin: fix memory leak in kirin_pcie_parse_port()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240609-pcie-kirin-memleak-v1-1-62b45b879576@gmail.com>
X-B4-Tracking: v=1; b=H4sIAE2KZWYC/x3MQQqAIBBA0avErBtwMqK6SrQQm2owLRQiCO+et
 HyL/19IHIUTjNULkW9JcoYCqiuwuwkboyzF0KimVZ0a8LLC6CRKQM/+YOOQettro2khIijhFXm
 V559Oc84f/5jGc2QAAAA=
To: Xiaowei Song <songxiaowei@hisilicon.com>, 
 Binghui Wang <wangbinghui@hisilicon.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Linus Walleij <linus.walleij@linaro.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717930575; l=3241;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=G2hg/LZavyIG1ablJTpUBbyufDXTz4RIOIjygW/UaMI=;
 b=c3Buu8bg1iHrzkibMddFmjoGudOBKupj0yF2OvphWiI0D/tc9U+3hfHjevgKSLj7GALrBAK0H
 teL1tPLgOKqD7uDeH4I8T+bSnPjZ+sA1JCqeRxZSbexz2Kx12JK9cqe
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The conversion of this file to use the agnostic GPIO API has introduced
a new early return where the refcounts of two device nodes (parent and
child) are not decremented.

Given that the device nodes are not required outside the loops where
they are used, and to avoid potential bugs every time a new error path
is introduced to the loop, the _scoped() versions of the macros have
been applied. The bug was introduced recently, and the fix is not
relevant for old stable kernels that might not support the scoped()
variant.

Fixes: 1d38f9d89f85 ("PCI: kirin: Convert to use agnostic GPIO API")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
This bug was found while analyzing the code and I don't have hardware to
validate it beyond compilation and static analysis. Any test with real
hardware to make sure there are no regressions is always welcome.

The dev_err() messages have not been converted into dev_err_probe() to
keep the current format, but I am open to convert them if preferred.
---
 drivers/pci/controller/dwc/pcie-kirin.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
index d1f54f188e71..0a29136491b8 100644
--- a/drivers/pci/controller/dwc/pcie-kirin.c
+++ b/drivers/pci/controller/dwc/pcie-kirin.c
@@ -403,11 +403,10 @@ static int kirin_pcie_parse_port(struct kirin_pcie *pcie,
 				 struct device_node *node)
 {
 	struct device *dev = &pdev->dev;
-	struct device_node *parent, *child;
 	int ret, slot, i;
 
-	for_each_available_child_of_node(node, parent) {
-		for_each_available_child_of_node(parent, child) {
+	for_each_available_child_of_node_scoped(node, parent) {
+		for_each_available_child_of_node_scoped(parent, child) {
 			i = pcie->num_slots;
 
 			pcie->id_reset_gpio[i] = devm_fwnode_gpiod_get_index(dev,
@@ -424,14 +423,13 @@ static int kirin_pcie_parse_port(struct kirin_pcie *pcie,
 			pcie->num_slots++;
 			if (pcie->num_slots > MAX_PCI_SLOTS) {
 				dev_err(dev, "Too many PCI slots!\n");
-				ret = -EINVAL;
-				goto put_node;
+				return -EINVAL;
 			}
 
 			ret = of_pci_get_devfn(child);
 			if (ret < 0) {
 				dev_err(dev, "failed to parse devfn: %d\n", ret);
-				goto put_node;
+				return ret;
 			}
 
 			slot = PCI_SLOT(ret);
@@ -439,10 +437,8 @@ static int kirin_pcie_parse_port(struct kirin_pcie *pcie,
 			pcie->reset_names[i] = devm_kasprintf(dev, GFP_KERNEL,
 							      "pcie_perst_%d",
 							      slot);
-			if (!pcie->reset_names[i]) {
-				ret = -ENOMEM;
-				goto put_node;
-			}
+			if (!pcie->reset_names[i])
+				return -ENOMEM;
 
 			gpiod_set_consumer_name(pcie->id_reset_gpio[i],
 						pcie->reset_names[i]);
@@ -450,11 +446,6 @@ static int kirin_pcie_parse_port(struct kirin_pcie *pcie,
 	}
 
 	return 0;
-
-put_node:
-	of_node_put(child);
-	of_node_put(parent);
-	return ret;
 }
 
 static long kirin_pcie_get_resource(struct kirin_pcie *kirin_pcie,

---
base-commit: d35b2284e966c0bef3e2182a5c5ea02177dd32e4
change-id: 20240609-pcie-kirin-memleak-18c83a31d111

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


