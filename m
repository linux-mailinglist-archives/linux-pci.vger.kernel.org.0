Return-Path: <linux-pci+bounces-38037-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B00B4BD90D2
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 13:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 73F454F1413
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 11:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C0230FC00;
	Tue, 14 Oct 2025 11:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PaU4TmEt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9219530F94E
	for <linux-pci@vger.kernel.org>; Tue, 14 Oct 2025 11:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760441573; cv=none; b=Dhio1GefBlXw2bSiMFtWDLb2dBPD+UUTfQJHyGxFUSKmtblAqrCbnH2+VPNfiBbX41bPFTigrj8ox0esrbq7GddDcH6S1Dfynf+IKeJURnbirWgwJ5+MTizvz7mfkSfks/cWjm1bp11V0HKNlxgNHgkHVPhSljIqK7Jovpm+o/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760441573; c=relaxed/simple;
	bh=HhxulXQwatE6PXjsTOpERvUEfgAFTPUo3nVaCBHQfkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s2A90PXOMdS8IVmGDAtiVvTgMVZj9BSGSjTLDV/yEbG3y0arQFkPeRpcNkoJC14kuuZuuomdw5j6Ry3Zhfv+IkyiYm7ll8tZ51Z6XCDM190Yn3dD688fWNeYIoNkNhgcorhRv1/5Lis07x45kT2+fa1BaFADgzlKs8lifyDe0gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PaU4TmEt; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-781db5068b8so4159184b3a.0
        for <linux-pci@vger.kernel.org>; Tue, 14 Oct 2025 04:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760441570; x=1761046370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CBUWIXVuX9TSH7iwZbReBbw9Y6KDyRcjsjDA5QvkLIc=;
        b=PaU4TmEt4KOBIKsAOesotTtCbsPJNe0uTBzp1QxRhSROJLCFT8q3MLq7fcYGVyz9VP
         wvrGO+gajyrZo5OBt4aa1RMRUjghgq7A34fNjsxs/jXg5xCx0ClBALErQrM7MIAkFKvp
         Rg0Rga+omEoCSAQSLWuMNDnmTLQlzU8uMv7cTvxvErr9lWROseEV+IyurMnBdZ0TRb5e
         B01ek1VIlVQZnTMvGVpH6AXyaVe/YMVQXBnAOriI0szXoSUHtJs5g9X6iXeeTXricn6l
         Lpe3GNz7Raf/+roEOGNnvsyh/NEpTHcrCV0sMwdjYIUAt7N69e4ytH2c13YncqXSr3vN
         KIoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760441570; x=1761046370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CBUWIXVuX9TSH7iwZbReBbw9Y6KDyRcjsjDA5QvkLIc=;
        b=IPuS9OfIWgqOqhxsXzAnDAu0Sa9xMMoUIBN8EM2uRU+iEkDzRrxm1m+CmOOP7mdoPy
         d35d8N4RkeN41u12B7kRmExweehvXBH+722fpAe2xgmDEYd1gvNK/atbBb3K8bi29pu6
         EfzPSeEDPOoy1411WITJG1Psumqla5QUW19gDnqKobTGHGp2DU+CkI/jdMCMAcvcDBnc
         7SktAQHIxpjziYd1r1V5Zh8wSAMZGCarn3AHj8TevQv0gjlc0bMJRX6rvYiDZ4UiYsaj
         wZhNe+7meaYNdjeTjKDP2XkV4v8+7PnsRDLlLj3kg+6lQdsyKnF4ZtUwW9QU+IImbg4t
         R+9A==
X-Forwarded-Encrypted: i=1; AJvYcCXdMnVsKOLhqbNj00OrOTRj83xfvAowiC4MnkYBIz3gHTpOSYRE31Mxpvuo+Ypyo9emVcI2FxSSt4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaaUFT8aVwbg1exms2EJnPY7a6zcnuTBc5S9Fs8ZulNrbC9Bh8
	8Pn8FKO7YLMHTvAUG74pXPyqsioDNPUXYe3vdGniIS7AhdD6R6D31LzL
X-Gm-Gg: ASbGncv8nS+zqK0gTgqrTvjugXkQtbYvtxh3Sa/hG7hqDERdqjvOp77+iiGLrZyUSEp
	YK2MvwIP1CCbs3IulazFDuaHK+WM2vL103phA+OcNYknNPX3N6Yalj+nOqc0BEiHHOxHNdBuHzm
	UTUJ1QtmKJgMBYr0WSBbffg+dvXO/74mWNyDpxtshLKI8F6BXmWFFEO8w8SDH8kBAkaaNy/2YSy
	XQyMYxjUPfldqTlotZQnC+QJYi+QipKD0yl4Y6Wa+rTIJ8+/A8ND45VgDmn4JaCo/gAmpUdWK+0
	XcjzXOF7JevpvctRqo9AqrIjPtRbww6h2m2rlK9hcKYUaJ6bgkxmv48wAtXgO0OjnBplFSdaywR
	V2ncp/9dGUgawBX7CYBxxbUyZ4qmnEdB88hh5RnM=
X-Google-Smtp-Source: AGHT+IHUZvlwK/tHfChIoy9WwwPnZcMKeQjitVT4QrngVrm6V72sz77ULhr0gyxke52yNoTSgqWuAA==
X-Received: by 2002:a05:6a00:c8c:b0:77f:6971:c590 with SMTP id d2e1a72fcca58-79387d0f36amr26600669b3a.22.1760441569783;
        Tue, 14 Oct 2025 04:32:49 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.108])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d0965c3sm14871383b3a.52.2025.10.14.04.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 04:32:49 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-omap@vger.kernel.org (open list:PCI DRIVER FOR TI DRA7XX/J721E),
	linux-pci@vger.kernel.org (open list:PCI DRIVER FOR TI DRA7XX/J721E),
	linux-arm-kernel@lists.infradead.org (moderated list:PCI DRIVER FOR TI DRA7XX/J721E),
	linux-kernel@vger.kernel.org (open list)
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v1 1/3] PCI: j721e: Propagate dev_err_probe return value
Date: Tue, 14 Oct 2025 17:02:27 +0530
Message-ID: <20251014113234.44418-2-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251014113234.44418-1-linux.amoon@gmail.com>
References: <20251014113234.44418-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ensure that the return value from dev_err_probe() is consistently assigned
back to ret in all error paths within j721e_pcie_probe(). This ensures
the original error code are propagation for debugging.

Cc: Siddharth Vadapalli <s-vadapalli@ti.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v1: new patch in this series
---
 drivers/pci/controller/cadence/pci-j721e.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index 5bc5ab20aa6d..9c7bfa77a66e 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -569,20 +569,20 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 	pm_runtime_enable(dev);
 	ret = pm_runtime_get_sync(dev);
 	if (ret < 0) {
-		dev_err_probe(dev, ret, "pm_runtime_get_sync failed\n");
+		ret = dev_err_probe(dev, ret, "pm_runtime_get_sync failed\n");
 		goto err_get_sync;
 	}
 
 	ret = j721e_pcie_ctrl_init(pcie);
 	if (ret < 0) {
-		dev_err_probe(dev, ret, "j721e_pcie_ctrl_init failed\n");
+		ret = dev_err_probe(dev, ret, "j721e_pcie_ctrl_init failed\n");
 		goto err_get_sync;
 	}
 
 	ret = devm_request_irq(dev, irq, j721e_pcie_link_irq_handler, 0,
 			       "j721e-pcie-link-down-irq", pcie);
 	if (ret < 0) {
-		dev_err_probe(dev, ret, "failed to request link state IRQ %d\n", irq);
+		ret = dev_err_probe(dev, ret, "failed to request link state IRQ %d\n", irq);
 		goto err_get_sync;
 	}
 
@@ -599,7 +599,7 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 
 		ret = cdns_pcie_init_phy(dev, cdns_pcie);
 		if (ret) {
-			dev_err_probe(dev, ret, "Failed to init phy\n");
+			ret = dev_err_probe(dev, ret, "Failed to init phy\n");
 			goto err_get_sync;
 		}
 
@@ -611,7 +611,7 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 
 		ret = clk_prepare_enable(clk);
 		if (ret) {
-			dev_err_probe(dev, ret, "failed to enable pcie_refclk\n");
+			ret = dev_err_probe(dev, ret, "failed to enable pcie_refclk\n");
 			goto err_pcie_setup;
 		}
 		pcie->refclk = clk;
@@ -638,7 +638,7 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 	case PCI_MODE_EP:
 		ret = cdns_pcie_init_phy(dev, cdns_pcie);
 		if (ret) {
-			dev_err_probe(dev, ret, "Failed to init phy\n");
+			ret = dev_err_probe(dev, ret, "Failed to init phy\n");
 			goto err_get_sync;
 		}
 
-- 
2.50.1


