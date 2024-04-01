Return-Path: <linux-pci+bounces-5484-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89208893D37
	for <lists+linux-pci@lfdr.de>; Mon,  1 Apr 2024 17:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1441D1F22E30
	for <lists+linux-pci@lfdr.de>; Mon,  1 Apr 2024 15:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355354779E;
	Mon,  1 Apr 2024 15:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p8easuU4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8802B47A7C
	for <linux-pci@vger.kernel.org>; Mon,  1 Apr 2024 15:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711986653; cv=none; b=lyTeGArGoZzmXqhYNWON7uHZMg0dPL22p6PeGpdOR/QCbt0H8gtPmqNRW4gu38zSi/VYpjEStc7H2jLUHLUfcr+bYtBFHedSyqybIkOxVAVBmqO/NY3nqmKVfeIadX431enPNyWT7WTU8UhZPssOXNoSqMZ/CA9fL718AJS4L2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711986653; c=relaxed/simple;
	bh=hRAyyHM9jBq8z5BMXGzXE9hXwapt0pAaABlLaIcw+Rc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sqR7KwmnlhzyfkM0k6TqMgY46zcjHPiacNVG1Lp7pd6L0ZqqMOs6cCou1bd+glae8+NV24uPJzdVQVCAMQ5j+MowjmqyW5kbrDzUa1hzsMESA/+umqgN3cjlA6W5vefNCohl4U6c3f1eRpLegAIOspo6ZS2Bi1VJgsHJ2aVyKeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p8easuU4; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e0bec01232so31801195ad.3
        for <linux-pci@vger.kernel.org>; Mon, 01 Apr 2024 08:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711986651; x=1712591451; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rKFY3ONj6P8dLgleToMrlio096mf81VdCaDAeiGZl+g=;
        b=p8easuU4hh7CnuhZBT0gfYkYLFyWLfaMlA1xG5KBM9xxEICVOYcDSHpFgXXtyS7q8b
         x+sU8nZWMAvnE4Qt52juwPCO4x1HyCnjmnNFM/Qb2kxbWKrkIUQMXWVR2L0OLO+or5t8
         zTXgveEbQYdG6/msTrxKqhBGOYucsAlipIAQ7kWGY7gfyMVPNnrbQ943ytjlL9QuPq8v
         2McH0dAfcJ2lLSarGbQpxtrFdOQqAaejm0sbbHf00izfsq/K7yL8K/06JVmcF09aFCbN
         KFoA8TA7Aqy866I9Qo69S5ydkWyyi/c8+tUQTlkGcILmrVkp7KlsyCBWZfI5GSbK9Fhu
         FfDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711986651; x=1712591451;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rKFY3ONj6P8dLgleToMrlio096mf81VdCaDAeiGZl+g=;
        b=fVB+Eq1CEazdLJPft5/CAllZW/n9vHxLw6y00JI6UHfuDNs6cKaVMNpGBes4ANe6K7
         1oFVVMrwYh6UZzJsa+00qHpF4aktIpnDHm3dCgBAR3F37Pw1bc1r2IomX1UGx5OT/dh0
         DnCsbJrrxu186Mc1ZoRsF7S5rZ6IcWgghoEu3aneL/9L0EN8LhoK3RgvhLOXVIalGcRS
         KSXxdE6+yBqis1+AdXjyZc03KY+Rr+/xaC+FQ2XtEciyP2GRH7b/dhETPycklo6ULJlk
         G6oaat/R+GLM+vU+T24l1eII5og27lT0qToxxp5DJpm7P0m/od6949QhelpEcOiwIzTB
         HJ7A==
X-Gm-Message-State: AOJu0YyqQaSwyJW7uPl4thXQkVwNnC40H6J7wf9hXU1OkV/ZicJeq+Wl
	qZ5XXcLJ6jv2sfd6muzDAbnsQDlgp8sg/DWkefQaRtImz4uXFmhczRdwZv8MoidA6MAflfxiZFk
	=
X-Google-Smtp-Source: AGHT+IHjQVp2YsswY1rd/h434HWpRi61fl0VGLxl2sFtnlWT09pNMTZniJ+NIoncudnLHDW/kTickQ==
X-Received: by 2002:a17:902:7847:b0:1e0:e650:5bd with SMTP id e7-20020a170902784700b001e0e65005bdmr8261630pln.45.1711986650660;
        Mon, 01 Apr 2024 08:50:50 -0700 (PDT)
Received: from [127.0.1.1] ([103.28.246.102])
        by smtp.gmail.com with ESMTPSA id kh6-20020a170903064600b001e21957fecdsm8949076plb.246.2024.04.01.08.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 08:50:50 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 00/10] PCI: endpoint: Make host reboot handling more
 robust
Date: Mon, 01 Apr 2024 21:20:26 +0530
Message-Id: <20240401-pci-epf-rework-v2-0-970dbe90b99d@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMLXCmYC/3XMQQ6CMBCF4auQWTumA7UGV9zDsKgwwERDm6lBD
 eHuVvYu/5e8b4XEKpzgUqygvEiSMOcoDwV0k59HRulzQ2lKayqyGDtBjgMqv4Le0Tt2pxuZyp9
 ryKeoPMh7B69t7knSM+hn9xf6rX+phdCgo8qy66i3NTUPmb2GY9AR2m3bvrkeMDWtAAAA
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Jingoo Han <jingoohan1@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, mhi@lists.linux.dev, 
 linux-tegra@vger.kernel.org, Niklas Cassel <cassel@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2712;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=hRAyyHM9jBq8z5BMXGzXE9hXwapt0pAaABlLaIcw+Rc=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBmCtfTf7aNZNHSAcCrTEEK8X7g1dcGqfxMorvtY
 CkRgMCnuOiJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZgrX0wAKCRBVnxHm/pHO
 9TbyB/4sZtMS4Y03NcUAGDf0XzMHg3hBKVNV3iuprXrozKDhO2hHn2E062aAslNK9JnpNRwscjf
 qnkGAt8bvR+f5dGh4F68jvBss3gYG/3IeDqzv/uqJGruc3MznxErSQHjYrKGlfpN/d4iijGITZ8
 S7cBkXp2IlzF3MBZQQ/BwgasmNSdJx2naEOFydF6kz28QJJpADObCIL6bK7fvv/wXsWZqmS3Rs0
 BstYijy0Q64WSSC7WGSD472hBbZCNK6A0iSvKMpYwFIlEoPTv4I6eott7cVLq9g+biR2r+VWv5o
 T4UKMmAWoY9e4VZgw3zf87CqqfYf2tW98xv1LTeqaZM/Zfn6
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

Hello,

This is the follow up series of [1], to improve the handling of host reboot in
the endpoint subsystem. This involves refining the PERST# and Link Down event
handling in both the controller and function drivers.

Testing
=======

This series is tested on Qcom SM8450 based development board with both MHI_EPF
and EPF_TEST function drivers.

Dependency
==========

This series depends on [1] and [2].

- Mani

[1] https://lore.kernel.org/linux-pci/20240314-pci-dbi-rework-v10-0-14a45c5a938e@linaro.org/
[2] https://lore.kernel.org/linux-pci/20240320113157.322695-1-cassel@kernel.org/

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
Changes in v2:
- Dropped the {start/stop}_link rework patches
- Incorporated comments from Niklas
- Collected review tags
- Rebased on top of v6.9-rc1 and https://lore.kernel.org/linux-pci/20240320113157.322695-1-cassel@kernel.org/
- Link to v1: https://lore.kernel.org/r/20240314-pci-epf-rework-v1-0-6134e6c1d491@linaro.org

---
Manivannan Sadhasivam (10):
      PCI: qcom-ep: Disable resources unconditionally during PERST# assert
      PCI: endpoint: Decouple EPC and PCIe bus specific events
      PCI: endpoint: Rename core_init() callback in 'struct pci_epc_event_ops' to init()
      PCI: epf-test: Refactor pci_epf_test_unbind() function
      PCI: epf-{mhi/test}: Move DMA initialization to EPC init callback
      PCI: endpoint: Introduce EPC 'deinit' event and notify the EPF drivers
      PCI: dwc: ep: Add a generic dw_pcie_ep_linkdown() API to handle Link Down event
      PCI: qcom-ep: Use the generic dw_pcie_ep_linkdown() API to handle Link Down event
      PCI: epf-test: Handle Link Down event
      PCI: qcom: Implement shutdown() callback to properly reset the endpoint devices

 drivers/pci/controller/dwc/pcie-designware-ep.c |  99 ++++++++++++++---------
 drivers/pci/controller/dwc/pcie-designware.h    |   5 ++
 drivers/pci/controller/dwc/pcie-qcom-ep.c       |   9 +--
 drivers/pci/controller/dwc/pcie-qcom.c          |   8 ++
 drivers/pci/controller/dwc/pcie-tegra194.c      |   1 +
 drivers/pci/endpoint/functions/pci-epf-mhi.c    |  47 ++++++++---
 drivers/pci/endpoint/functions/pci-epf-test.c   | 103 +++++++++++++++++-------
 drivers/pci/endpoint/pci-epc-core.c             |  53 ++++++++----
 include/linux/pci-epc.h                         |   1 +
 include/linux/pci-epf.h                         |  27 +++++--
 10 files changed, 248 insertions(+), 105 deletions(-)
---
base-commit: e6377605ca734126533a0f8e4de2b4bac881f076
change-id: 20240314-pci-epf-rework-a6e65b103a79

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>


