Return-Path: <linux-pci+bounces-26705-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45315A9B376
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 18:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3811C7A4D0B
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 16:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF279280A50;
	Thu, 24 Apr 2025 16:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kgFmSeCm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56777284678
	for <linux-pci@vger.kernel.org>; Thu, 24 Apr 2025 16:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745510866; cv=none; b=og2yZ9GR8fei/9Aa0SzdDcc7zzQ2RILWAO7yM9fwS9e+O+mgjraShIfpvzJUEy+HMsgNNxHwLnjGW+Mp7Qo1p4mIyXZofGdiwFkGDXFiclAh7/U/8oYXrHA20jm6LLVZmTeakB+JmILNFZGep+y8UPU7XepU1NFpZJyzCj9bQEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745510866; c=relaxed/simple;
	bh=t1yw/3IQY04ascExMYNkywVMbYb9sD04RFjXDUub5p0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hJrfQfZnpEsCOVmzdeTMu3THxTU/Rn2arawoSnvct/o7lw8z6GTugME97O9HCX8h+G4n8QaKTHKQXFKg7CSZBizsU3kpafwa0F4p073YAetigndNlp83FsCwqcZr1N/SnxPPxsfH67g4o1WVLf0iQrRhyVSZ6EyBEGPeW1N5ov4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kgFmSeCm; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2295d78b45cso19366335ad.0
        for <linux-pci@vger.kernel.org>; Thu, 24 Apr 2025 09:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745510865; x=1746115665; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KJu9k3uxYD0x67A2WlM7JrSR4XKb1B7H+/wMYgcPKG4=;
        b=kgFmSeCmj77PlfxuwEKWnaZNRxDUzuYEKsgYjGDDrQwBd0YKLADe6Riu+wepmYmQzl
         jw9TQwyZ4PywvFyQU7ARZ5iM0rYd6EXU3ANiRveTK1FEg9XmxmzcAS4DW/P6G/9bPifK
         qTsi7hZByrO+hzQbQLbETQnBuHu/3t2fBP8RX3puXro7H4mWFxqPidyAEKVknnaHfdsW
         y2gNhVuUgKXqFwWLkoNdT+qFy8ftD9kWoAUc9D2TJhYBomVaeBvkwk6Wd746HZ8KIU3p
         k7HawLY8fl274y1c+IWLGWSXh56/+jcVZDfsUkPlKyZFjFKDVhE4RLwdD7+9DjanfFkK
         POxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745510865; x=1746115665;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KJu9k3uxYD0x67A2WlM7JrSR4XKb1B7H+/wMYgcPKG4=;
        b=vXnO5afdEs/k14S5lOzCduZIvnUknC18/mkN6zlEn3vPWyJsnZAal6zVas5/NnflmH
         B3dpqdDiqau4gXHoUib0FVw3Chi6HYp2Xqha/3XEgk5pTSjqLyFxtarGF3v0B0qQo43u
         2AcsEp6ci1PGxNwEmhd/u0LKCKbKFFEwmDJfrXRgCmObudt0V8wFILkfjRmB7CsmJ33m
         GGGGCphlj4AzBsWpsVSTiCROFNcb3W5E58pZO6aY4JmYdCN9nKz4INxTkXW5gppmdJxi
         c6Q1ojP68iHH4a3ZdbKCBLrBxDLEo+YSEXkPCwkn54C6YI8vMtOHLpQKGICvFC6QM3gx
         qDrQ==
X-Gm-Message-State: AOJu0YzJd7FwEIl4Pv0Pnb9vkOL5OucG766K3REj7++AS6v4nb7yPS1S
	69ZxAJz2o/eMtQ1p4yQVIzE7uUrRKt/3rYiNBuyvk1xqpA4tV8HkkBxjDwTp9w==
X-Gm-Gg: ASbGnct7tmefBstJqUZO544OQprs5OvyFlchuHRSm4faTKuBhT9SUYrmWo1WtgU87Mi
	/1b6NyOAqpCRxufy4EIMVFKQfzFxViRVc+g4lUdczHM3qbj/S7ElKxSt+pDQT1EpzW7+4yICgb/
	FwvRbHySXC3hYPSOHUILaOTFyxvROJBprh/Fv93su3FSZ2xHblTUXFjeW5OkMB7dJ2fDricL6y/
	q1nJJySxCSSbCnGo+M6HhhcuXdlMKXwN30mlTPsRJkwz+trvy66LWjEqqvxBOlR0/p+r+YDIw6h
	wOS2aitSe5bXhTmQRyw/G18yLNwRbX3dplBp8ZMH4Z9FuRZStzLKVdQ=
X-Google-Smtp-Source: AGHT+IF+cEnqtVqlvNmtgTBPOgGaQFGH2iL8KVeET2542DBGluS4OFgyWPgBX3nQcjgRsk8niFLIJA==
X-Received: by 2002:a17:902:e742:b0:223:f928:4553 with SMTP id d9443c01a7336-22dbd478a8dmr446915ad.44.1745510864595;
        Thu, 24 Apr 2025 09:07:44 -0700 (PDT)
Received: from [127.0.1.1] ([120.60.77.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db5221656sm15262275ad.252.2025.04.24.09.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 09:07:44 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Thu, 24 Apr 2025 21:37:19 +0530
Subject: [PATCH v3 4/4] PCI: qcom-ep: Mask PTM_UPDATING interrupt
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250424-pcie-ptm-v3-4-c929ebd2821c@linaro.org>
References: <20250424-pcie-ptm-v3-0-c929ebd2821c@linaro.org>
In-Reply-To: <20250424-pcie-ptm-v3-0-c929ebd2821c@linaro.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Jingoo Han <jingoohan1@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1764;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=t1yw/3IQY04ascExMYNkywVMbYb9sD04RFjXDUub5p0=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBoCmG/edV1s5zz7dUXotOLnVSoJ9f/l51DOl3bM
 CHdo33fe6eJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaAphvwAKCRBVnxHm/pHO
 9QhXB/9KUDzr7Mex0zOAHucAJbxPOHMb886ePHgYIhd/So41Wf78Zzi0EOcvoPVe3FHikLzMWZG
 b8G76iKhkbFK0LHcOQFVWtQE/3blacVpV7/mNNoOwwVm+MaFxqE5S3dy3pHENBL4Kpvs2Rj8Z85
 rz3zTQX88e89h1dQGLXnp0C42qOVC3aHeC0YwZFJ0ktiFF0kfzoSar2gm9ShTdj0SohZWQxkrjC
 Y9Yw+VKhtSJRvtsMQTt0ph4pdeExmYq8ThjLYx6r9SeuuZMideNEup+clZ53bWBpbinqZv0HvDu
 pP3226Y5UReU1SB6zqCv42FKelMwz34UaMmmmjY8NZ3x4Wxo
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

When PTM is enabled, PTM_UPDATING interrupt will be fired for each PTM
context update, which will be once every 10ms in the case of auto context
update. Since the interrupt is not strictly needed for making use of PTM,
mask it to avoid the overhead of processing it.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 46b1c6d19974a5161c8567ece85750c7b0a270b4..9270429501ae1fbff7ece155af7c735216b61e1d 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -60,6 +60,7 @@
 #define PARF_DEVICE_TYPE			0x1000
 #define PARF_BDF_TO_SID_CFG			0x2c00
 #define PARF_INT_ALL_5_MASK			0x2dcc
+#define PARF_INT_ALL_3_MASK			0x2e18
 
 /* PARF_INT_ALL_{STATUS/CLEAR/MASK} register fields */
 #define PARF_INT_ALL_LINK_DOWN			BIT(1)
@@ -132,6 +133,9 @@
 /* PARF_INT_ALL_5_MASK fields */
 #define PARF_INT_ALL_5_MHI_RAM_DATA_PARITY_ERR	BIT(0)
 
+/* PARF_INT_ALL_3_MASK fields */
+#define PARF_INT_ALL_3_PTM_UPDATING		BIT(4)
+
 /* ELBI registers */
 #define ELBI_SYS_STTS				0x08
 #define ELBI_CS2_ENABLE				0xa4
@@ -497,6 +501,10 @@ static int qcom_pcie_perst_deassert(struct dw_pcie *pci)
 		writel_relaxed(val, pcie_ep->parf + PARF_INT_ALL_5_MASK);
 	}
 
+	val = readl_relaxed(pcie_ep->parf + PARF_INT_ALL_3_MASK);
+	val &= ~PARF_INT_ALL_3_PTM_UPDATING;
+	writel_relaxed(val, pcie_ep->parf + PARF_INT_ALL_3_MASK);
+
 	ret = dw_pcie_ep_init_registers(&pcie_ep->pci.ep);
 	if (ret) {
 		dev_err(dev, "Failed to complete initialization: %d\n", ret);

-- 
2.43.0


