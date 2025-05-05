Return-Path: <linux-pci+bounces-27157-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C96A7AA95BB
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 16:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C20A17A4B0
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 14:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C51425D902;
	Mon,  5 May 2025 14:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fZdBaito"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FAE25D206
	for <linux-pci@vger.kernel.org>; Mon,  5 May 2025 14:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746455099; cv=none; b=fOph61zIJS8V7hqfx/KXuq+ZkUIuqBig32RSPvvxEufhIviHs6gcKp7dv2ZIx0oBd+M/XY+X6XKrIJainBj8GUYq8CR5R2KQLhSJwoQa+A9C/QQTAPi3odK0/n2Dd2bvCCbaegbIU01264YK6Wji6qlUuc9PcMHsFjkoiR6eRag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746455099; c=relaxed/simple;
	bh=13t0G+6cETyYOm4qxRCTFv0cuGZG4Jm1bu/20N6Ac+E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uw0K3/1825Om1OZ4Ke3YPf0NKoVzc6DQSuHO6RwXMNtcVHO2+m95/ZQEysvjxSGJ0flJD4VODTfsJdbCqCGFMm7gmpe6YjzQ2nh4zt2F9kWEzURIS98Lvuda6nuH3dTF3bj8zGN8CMUBZ8RBrZe3jscJ79S1i4zKi5rkjRxUTuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fZdBaito; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2240b4de12bso71844055ad.2
        for <linux-pci@vger.kernel.org>; Mon, 05 May 2025 07:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746455097; x=1747059897; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Hs+DElq3FESieGx8paocjJpcUpxIsb2z1UnlatNE9M=;
        b=fZdBaito5ZE0zv/8IrdLhmPZWmh4p6y6s6G5fKCMqudwzmsmHozYPX+PeIHD6tdE6t
         U+OLFX1qgUX6a6brWpnV3twt5jrGK7GkGj1ovuGzv5sOfT1Rbyk4DVyS5h6RA2ZYVzm0
         87QpMfG7tM+Foo1g+QV2NScD++GuHtaFbOj/Zs5YXJxUVzC2zvTEEtgdzVd53bwOx0Zg
         CTeoEd310lHzRX5OXgaAmNLvKCf3k7QohYoDyxLwo9Ab9ZFR2JDnaLcPvg2iMclluZGJ
         GaJVeGxWkcQs/uyd9Qx2VXZk43moQRFcue1qsZf0/en2iPXMFgvbs8ljNACWzWJWCOKO
         Lxkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746455097; x=1747059897;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Hs+DElq3FESieGx8paocjJpcUpxIsb2z1UnlatNE9M=;
        b=EEuE4QJ/Urny6eOrO+O4Atpu57lSgp3aMuoxiVg4OW18YliuQcXKPDWit5h5eW09GC
         nMNX8xbRMfPDztLYC4HzzdG7JnY/EwygfpA52ywmnFCYJcDVYNpApG04pZoYn+0gyNp8
         2z3i2eob2rvOnHlLPDZQhZO2rPqsGkc9OG/4bW46SWVOQwSfOYpKgFHjqLeowCMG2iiX
         v916Mk01g0uIis/ZddDYfWHG3CxawdpdyOaIRMe4wM4N9Yv0w5hURkPUYzYsMWqN5YKw
         3+SaDYMqh9SVuOC1KAiSUNy9zbJYI7ev+gfD45sXL6M0MIe9y5Q8lZqi2AfFnqRbWNHd
         0xQQ==
X-Gm-Message-State: AOJu0YycNz5g7gSGFhME4GPDTiHNrp1mV9UDEENLi4n9HsOQOBgfAS9Q
	RHrqfQZD+OmJ71QF9ofWvzTvZkhPWU7Q3zqYGXi++PmjBi3Gq5VXVR/FUkCpBQ==
X-Gm-Gg: ASbGncssb8Yzw9RZqZYeWe3HqrWk/kcPEWcHvE7XRpGjTWX5kI/7QOpVHIpbcHHD6CS
	8KDmeWCqNDWXWp3d960xHMB9+tIdPzKUV/FCW5Jlni49J3I5xpCBtRvaX4a5YFEqmyZo+lmDD9Q
	wSVhPiNCKt2jlu8jimHqLf6Pzz7NE1Qt7D0+ebvRRyb53IfiPpezpPd4oUm9z/PhijcgcGVHZyQ
	fSehu9V9PRenqPk2NJUxwS+2CLSfDmoaAb5Hoomy2iLQYrGKvpicHI+9ExDfz7bk5E//SCGX0Zb
	dg8MTLvaJsjlTuz2sXA9ltHGj+pxG2Tp0EAyPz+RWTIod9HkS4H7L0A=
X-Google-Smtp-Source: AGHT+IHdWlxDvs8371dw8iIibUZwg5NFmTvGoIMCtT/qDinJycePFjkAEDaFHMsXbrbdZE+ta8ZWwg==
X-Received: by 2002:a17:903:240a:b0:227:e6fe:2908 with SMTP id d9443c01a7336-22e1eab75b9mr140043085ad.48.1746455096656;
        Mon, 05 May 2025 07:24:56 -0700 (PDT)
Received: from [127.0.1.1] ([120.60.48.235])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e1522ef9bsm55387685ad.217.2025.05.05.07.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 07:24:56 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Mon, 05 May 2025 19:54:40 +0530
Subject: [PATCH v4 2/4] PCI: dwc: Pass DWC PCIe mode to
 dwc_pcie_debugfs_init()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250505-pcie-ptm-v4-2-02d26d51400b@linaro.org>
References: <20250505-pcie-ptm-v4-0-02d26d51400b@linaro.org>
In-Reply-To: <20250505-pcie-ptm-v4-0-02d26d51400b@linaro.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Jingoo Han <jingoohan1@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3666;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=13t0G+6cETyYOm4qxRCTFv0cuGZG4Jm1bu/20N6Ac+E=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBoGMouk6oLnFeqy0OQNd3RGK527cJPG1+NToMXz
 Nw1faIeRGGJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaBjKLgAKCRBVnxHm/pHO
 9TsyB/0Y0hs92h1l3TemgX/ALjp3uixaxiHo5J3xkUj9aEpT74QCx/xXHB0LxjXAQ4QHCnR2QFR
 nR04c/yfN7917XxUiIfwi7Wsxw07tpbyc/oaU8uITSeLGX1pwT/QPPqD5G0LNPvJMRN98hV5f0G
 BnpLrxV7N6nxMszSXZxYe2LNel2nzjXxrXLiXFpn94tZmlK/mjeilYsSY007nOBqwWgQch6nBrQ
 DwbjQznAqSMxuKZhFTkwjuZ4Ya+8+NtdjhRZ8OQboO5WiJBF1hNvh/nRLbAPaXWvq35YAATUpY5
 7YsCnKWwlHgy3+3xTBC0b76Tg6MiZqGrbUiuVywfQQ/D9KtV
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

Upcoming PTM debugfs interface relies on the DWC PCIe mode to expose the
relevat debugfs attributes to userspace. So pass the mode to
dwc_pcie_debugfs_init() API from host and ep drivers and save it in
'struct dw_pcie::mode'.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-designware-debugfs.c | 4 +++-
 drivers/pci/controller/dwc/pcie-designware-ep.c      | 2 +-
 drivers/pci/controller/dwc/pcie-designware-host.c    | 2 +-
 drivers/pci/controller/dwc/pcie-designware.h         | 6 ++++--
 4 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-debugfs.c b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
index 9e6f4d00f26298077c976c9e74d8616544f20ddb..896c387450ca45d979f6baa04e6b3ae3e4be167e 100644
--- a/drivers/pci/controller/dwc/pcie-designware-debugfs.c
+++ b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
@@ -651,7 +651,7 @@ void dwc_pcie_debugfs_deinit(struct dw_pcie *pci)
 	debugfs_remove_recursive(pci->debugfs->debug_dir);
 }
 
-void dwc_pcie_debugfs_init(struct dw_pcie *pci)
+void dwc_pcie_debugfs_init(struct dw_pcie *pci, enum dw_pcie_device_mode mode)
 {
 	char dirname[DWC_DEBUGFS_BUF_MAX];
 	struct device *dev = pci->dev;
@@ -674,4 +674,6 @@ void dwc_pcie_debugfs_init(struct dw_pcie *pci)
 			err);
 
 	dwc_pcie_ltssm_debugfs_init(pci, dir);
+
+	pci->mode = mode;
 }
diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 1a0bf9341542eabc4d28070e3a2d6a8b0b444578..6ee14694372c70783c83c2c7483310f4cbfda078 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -1013,7 +1013,7 @@ int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep)
 
 	dw_pcie_ep_init_non_sticky_registers(pci);
 
-	dwc_pcie_debugfs_init(pci);
+	dwc_pcie_debugfs_init(pci, DW_PCIE_EP_TYPE);
 
 	return 0;
 
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index ecc33f6789e32cd022a5e5fb487bdec5d7759880..17c78a3346512bef8319af2ff7b8c412d41394a5 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -567,7 +567,7 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 	if (pp->ops->post_init)
 		pp->ops->post_init(pp);
 
-	dwc_pcie_debugfs_init(pci);
+	dwc_pcie_debugfs_init(pci, DW_PCIE_RC_TYPE);
 
 	return 0;
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 56aafdbcdacaff6b738800fb03ae60eb13c9a0f2..7f58c94b5b1e9a590692474d5efa80c5b5ed9b8d 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -503,6 +503,7 @@ struct dw_pcie {
 	struct gpio_desc		*pe_rst;
 	bool			suspended;
 	struct debugfs_info	*debugfs;
+	enum			dw_pcie_device_mode mode;
 
 	/*
 	 * If iATU input addresses are offset from CPU physical addresses,
@@ -871,10 +872,11 @@ dw_pcie_ep_get_func_from_ep(struct dw_pcie_ep *ep, u8 func_no)
 #endif
 
 #ifdef CONFIG_PCIE_DW_DEBUGFS
-void dwc_pcie_debugfs_init(struct dw_pcie *pci);
+void dwc_pcie_debugfs_init(struct dw_pcie *pci, enum dw_pcie_device_mode mode);
 void dwc_pcie_debugfs_deinit(struct dw_pcie *pci);
 #else
-static inline void dwc_pcie_debugfs_init(struct dw_pcie *pci)
+static inline void dwc_pcie_debugfs_init(struct dw_pcie *pci,
+					 enum dw_pcie_device_mode mode)
 {
 }
 static inline void dwc_pcie_debugfs_deinit(struct dw_pcie *pci)

-- 
2.43.0


