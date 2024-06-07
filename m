Return-Path: <linux-pci+bounces-8443-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D786F900156
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 12:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34AF9B21CFE
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 10:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DCB018628B;
	Fri,  7 Jun 2024 10:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vx3CjFUy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450601862BB
	for <linux-pci@vger.kernel.org>; Fri,  7 Jun 2024 10:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717757898; cv=none; b=WGjLPb+5DVG5idIW7w9GbLbWQxvlcuZnxE/ie/zZbaonb68CCwtW0Dz0FSEBiJAM0u6S0SoZ3ulKzffiUmniPBprJHpVEvdH+gk9S6eY6yNKJ7zZD7AtcjIWdMPgC0q2UGgKurRJcm0AQSf5i3/ghPXWMcDr3ADg5RJEmjVEcRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717757898; c=relaxed/simple;
	bh=XeqHKq7C6ItKeEGvPXNfkHtkfptWdfLnGM+VX6C608c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=chDWo901CLNyYZjnT5E4tpBgCk8G2mDRkyvSAnzFpsd9RlzoeyW8KimWGcY3qkTOc5Ni/n5bJK5srw7g+IkdMmgECg7cp7wmMJCiPo9sIE1NxxTgUx3SRsAhWvVQEZQstHeueLxj76Dokg8etiz7AjeSRPN80i63z2JDaYsHOZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vx3CjFUy; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52bc1acb9f0so243760e87.2
        for <linux-pci@vger.kernel.org>; Fri, 07 Jun 2024 03:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717757895; x=1718362695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MDcq5k/0ttuhuW1s9eNFA8PIx5mHSgVIL61fKi53/Ns=;
        b=vx3CjFUy6iNmAa9XgGwbj7NxdRkyWeyMnkZQQ5H3PnI4O8trS68j0XYZDQ9Or43fgk
         Z83cmumdKPwsyjNL5rvV0DBwhdnqJb61ufahI2jZXZXjYdKD05JYaWTAmzLc/2gPJ6S+
         sJjGB7+YIf+0wJuyYHd8p0uRKTFlAhvzEnfo4A9wEbOFLCBF64eKdKUliNCY5U4DajWA
         j59LO+FxrTF+8tM9hMP1iS6Ukze1ikv3x20H7a/cIR04ee6uX18YOchga7qqc7fwCeMu
         aMqC9ziA2s5fu+auwzMBdlbTXYhVxlawsfCDfW+0YiZOCm+YoQhw1E5W23+0jlWvH6V6
         6Fjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717757895; x=1718362695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MDcq5k/0ttuhuW1s9eNFA8PIx5mHSgVIL61fKi53/Ns=;
        b=mn9vUqmHtORe7nd4cLPzNtIsvA2tnQlTR4rmvhBDWrJ9mfi71zGxo5R5Hk1DkY1v3S
         KKLzJGZr3zuD7KWI3L2wSqyGFu6fy6S8u3PhgZkSI6yaP5WWSe5Bx0tU4WW4IyXIIUma
         O41liruVKpxK7QJHZ36QC6JEqv5BguN2YEndN7MbfWchGE1P+c9frvA5il9KNnZEaEXF
         sywYdmuxKExcO7rXGumDeGtukVTyYPu7yCYKphLOcpevXbw7VXZV63lRrgi7tCOoqYkn
         ZpS+cgdMWDdEv6Fqwayp5MzcEkiVctHEfy32ScJi4lvOrtXB7PECl+nz224QMR48ufdg
         eg1w==
X-Forwarded-Encrypted: i=1; AJvYcCVXlsLeUI07QcFY4fuiROMgOgA+Sehj64+kd1U+ooWwxO7BUdiC0LoBOhzhCK8P/UtNlWA9kmrDjmw/Ih7UDuiQmKmd8kUwGxkW
X-Gm-Message-State: AOJu0YzGoqQapi6YC3WrgdwgB6ZeYpWQ/dYzhDOfOwxw5lJIh4+LlDiY
	zf0QpkHvwH2Br//C8PFIYkSHTa/bni2url4+1NC6nFToA8MkGXCi9Wub72GNjzs=
X-Google-Smtp-Source: AGHT+IFKBOo5vF96Rp1eu8L7oXMzKFGJxvSnCqz7HcFftnGZ/GajF1ZZWz5V+BiNnKs89U3LBYWGnw==
X-Received: by 2002:ac2:52b5:0:b0:52b:b173:7490 with SMTP id 2adb3069b0e04-52bb9fea373mr1207405e87.68.1717757894609;
        Fri, 07 Jun 2024 03:58:14 -0700 (PDT)
Received: from localhost.localdomain ([2.221.137.100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5fd1c5fsm3739485f8f.113.2024.06.07.03.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 03:58:14 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: will@kernel.org,
	lpieralisi@kernel.org,
	kw@linux.com,
	robh@kernel.org,
	bhelgaas@google.com,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	liviu.dudau@arm.com,
	sudeep.holla@arm.com,
	joro@8bytes.org
Cc: robin.murphy@arm.com,
	nicolinc@nvidia.com,
	ketanp@nvidia.com,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v2 2/3] iommu/of: Support ats-supported device-tree property
Date: Fri,  7 Jun 2024 11:54:15 +0100
Message-ID: <20240607105415.2501934-4-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240607105415.2501934-2-jean-philippe@linaro.org>
References: <20240607105415.2501934-2-jean-philippe@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Device-tree declares whether a PCI root-complex supports ATS by setting
the "ats-supported" property. Copy this flag into device fwspec to let
IOMMU drivers quickly check if they can enable ATS for a device.

Tested-by: Ketan Patil <ketanp@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/of_iommu.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 3afe0b48a48db..082b94c2b3291 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -105,6 +105,14 @@ static int of_iommu_configure_device(struct device_node *master_np,
 		      of_iommu_configure_dev(master_np, dev);
 }
 
+static void of_pci_check_device_ats(struct device *dev, struct device_node *np)
+{
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+
+	if (fwspec && of_property_read_bool(np, "ats-supported"))
+		fwspec->flags |= IOMMU_FWSPEC_PCI_RC_ATS;
+}
+
 /*
  * Returns:
  *  0 on success, an iommu was configured
@@ -147,6 +155,7 @@ int of_iommu_configure(struct device *dev, struct device_node *master_np,
 		pci_request_acs();
 		err = pci_for_each_dma_alias(to_pci_dev(dev),
 					     of_pci_iommu_init, &info);
+		of_pci_check_device_ats(dev, master_np);
 	} else {
 		err = of_iommu_configure_device(master_np, dev, id);
 	}
-- 
2.45.2


