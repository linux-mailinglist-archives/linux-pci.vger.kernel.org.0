Return-Path: <linux-pci+bounces-4398-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA64586FD2B
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 10:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA336B221E6
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 09:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD8620DD2;
	Mon,  4 Mar 2024 09:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WDG0c5kS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA061DA5E
	for <linux-pci@vger.kernel.org>; Mon,  4 Mar 2024 09:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709544167; cv=none; b=MsFIu5k+x/4FZXrthyturZhBtYAlbeNDtwmEZopAX+oKNEQfb5yopTFjDjtBO5LMuwgxFOWGKxa9pPlNVyZficSZYp+r4kXf3MTo8BQf+f+AIGd/612GjdkGjlk2V4/nmCkSJGNO0kh9dzWTB3mfMDMF9l00PtBnm4N/pFLV/vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709544167; c=relaxed/simple;
	bh=D3YxXRPRe/3m7ipJEy7IuH10sCTvtxb4RmlKqvHI6fk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KiEbPu9NrFU9g4EtHtg1B6+Gex2l2L3LARKllrhaO5xrhFJAI91918bzEKmmai9MHBP9ZNJnroqNz2hTP0IA2npwn+jslYOsHDtnOe1G1rl0axyYjizTBUkoAIUNUEu75gKRLuo5Y7VO2geVe3YEtSPiqlaXrYYU29xqRdGj4mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WDG0c5kS; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1dcad814986so37869145ad.0
        for <linux-pci@vger.kernel.org>; Mon, 04 Mar 2024 01:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709544164; x=1710148964; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b5AjmCqAyBy5sBCmGJ+0z6aZbOBdyU67G5MoGkYfj10=;
        b=WDG0c5kSzWoQebBMJW+M81vv5SY90uU6k3CpR8hU3Q8LIL7eBSKsvIHufHiXZK1TSJ
         yGOdSUAN+wl88NMOzYSyd7tG9yyjHfk4zKs5dr4rVTPKHEHDlM5b9nW1Wkb7DJR3Ey+n
         2hZpBcQuVdN8eheZFgUB07j7g2cbyboagQ+NgQSbQ0jF/QeNCWZ8HfyBgewhPgxiPLbL
         wYJAkeZHB1CDIRogLJ66omaV7fqQthNykSRGo+i/bWQvGVlufqrhaI4rpqdM9Lx4JXLU
         8HOY8Rtz9rWuQk+HD/P2OFYcgCudZeHf/gqqQD4UhRQmpzp74fnT5F8IQ2iuBHM0nMkc
         E/HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709544164; x=1710148964;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b5AjmCqAyBy5sBCmGJ+0z6aZbOBdyU67G5MoGkYfj10=;
        b=HsyrDrqEWN4FVIgOo6orYPlsciegRU/MjLuYEP55bK5AoDrLgnBmXLKOLVtQUGIM5k
         Z0h5IPPwxklaS/+tW+6jw9fadKwM1nDtEtFZZhcs0VfALQVRI0h0cq4OZ5jMeAG82wbI
         +a4jU2WnVUkhY6fDrgyIj6H9Jo2oae3FxZrwSuii2Ul2NHm8c9rgOqYkgJDfQRNEEY/t
         QYL/0OyDU6jRXENQGbqAGpJLQtLoeIxD/SLlDtQYYGV+ItkT0bNzkfYiNFX+T/iwr/iw
         eV5sFkc39GC0UYYjwkfleRJlUKTKQ2yDSrBD2GAiOqjbrF7qHWrVuU05dGnLq2A88W6F
         SmRg==
X-Gm-Message-State: AOJu0YyUyv0qqPteeQ02yeNWVBqw5LYBmb4yXgf5XXk2QtPIJodQ/LI7
	iVRKRmhBN3qDRXqhqjgrgDAkBnFMPk/XMMlTKQw+qBfKYM5C4SeJ+JTyHPX1Dw==
X-Google-Smtp-Source: AGHT+IFEMqv/PNpBYCEoYo/h2XH4t1cKfax+0MKorjDLCgK9bQh90oXT16Gx94SYuPDhwrgchBsFVQ==
X-Received: by 2002:a17:902:c947:b0:1dc:3e49:677d with SMTP id i7-20020a170902c94700b001dc3e49677dmr12360994pla.26.1709544164262;
        Mon, 04 Mar 2024 01:22:44 -0800 (PST)
Received: from [127.0.1.1] ([117.202.187.165])
        by smtp.gmail.com with ESMTPSA id c5-20020a170902c1c500b001dbb06b6138sm7996648plc.252.2024.03.04.01.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 01:22:43 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v9 00/10] PCI: dwc: ep: Fix DBI access failure for drivers
 requiring refclk from host
Date: Mon, 04 Mar 2024 14:52:12 +0530
Message-Id: <20240304-pci-dbi-rework-v9-0-29d433d99cda@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMSS5WUC/3XMQQrCMBCF4auUWTsSYoiNK+8hXbTJpB2UpkykK
 iV3N3bv8n/wvg0yCVOGS7OB0MqZ01zDHRrwUz+PhBxqg1baKK0NLp4xDIxCryR3HDQ511vtTsp
 DPS1Ckd87eOtqT5yfST67v7a/9S+1tqjQGn+OQflI1lwfPPeSjklG6EopX6+X1jOtAAAA
To: Jingoo Han <jingoohan1@gmail.com>, 
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Marek Vasut <marek.vasut+renesas@gmail.com>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Kishon Vijay Abraham I <kishon@ti.com>, Vidya Sagar <vidyas@nvidia.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Richard Zhu <hongxing.zhu@nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, 
 Minghuan Lian <minghuan.Lian@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>, 
 Roy Zang <roy.zang@nxp.com>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Jesper Nilsson <jesper.nilsson@axis.com>, 
 Srikanth Thokala <srikanth.thokala@intel.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
 Niklas Cassel <cassel@kernel.org>, linux-arm-kernel@axis.com, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=4945;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=D3YxXRPRe/3m7ipJEy7IuH10sCTvtxb4RmlKqvHI6fk=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBl5ZLSO+6vhj5ArwA31w+B+o7UQMvERN5xNXL/0
 h2DiyttWXGJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZeWS0gAKCRBVnxHm/pHO
 9Xu0B/492E11+2fPEOd04mokl2I361P6hUg/guPNdBEZ1eaP5WIIZZXghxxFFQXh2pBybkGWve5
 NGWpyXTm/UUE+ZCLJge/wavfoSVqY3QTZjwk7gwY5uhr0xW+CuHREVnuLW/1urQqbrJ+bwizlg1
 Js/NCMoC8iYWCZQK4GSSIeZKbduzezX6jqdGvCGZepii4PpknDxs0lXB4I227sEohHIpg3JcyWq
 yVZCY0SChP7O7w8qztldIqASdi1LXKQZsJa1BZNc4a3Avii2kWwEO/S+t5kXX6f5PzZhjIXzZ0f
 PgpnOg1/MlDJo1n4e0xCc9lLWFfZR3b+wFO1ip3sARxQDuxG
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

Hello,

This series is the continuation of previous work by Vidya Sagar [1] to fix the
issues related to accessing DBI register space before completing the core
initialization in some EP platforms like Tegra194/234 and Qcom EP.

Since Vidya is busy, I took over the series based on his consent (off-list
discussion).

NOTE
====

Based on the comments received in v7 [2], I've heavily modified the series
to fix several other issues reported by Bjorn and Niklas. One noticeable
change is getting rid of the 'core_init_notifer' flag added to differentiate
between glue drivers requiring refclk from host and drivers getting refclk
locally.

By getting rid of this flag, now both the DWC EP driver and the EPF drivers
can use a single flow and need not distinguish between the glue drivers.

We can also get rid of the 'link_up_notifier' flag in the future by following
the same convention.

Testing
=======

I've tested the series on Qcom SM8450 based dev board that depends on refclk
from host with EPF_MHI driver. It'd be good to test this series on platforms
that generate refclk locally and also with EPF_TEST driver.

- Mani

[1] https://lore.kernel.org/linux-pci/20221013175712.7539-1-vidyas@nvidia.com/
[2] https://lore.kernel.org/linux-pci/20231120084014.108274-1-manivannan.sadhasivam@linaro.org/

Changes in v9:
- Incorporated changes for missing drivers (Niklas)
- Reworded the dw_pcie_ep_cleanup() API kdoc (Niklas)
- Reworded the description of patch 6/10 (Frank)
- Collected reviews
- Link to v8: https://lore.kernel.org/r/20240224-pci-dbi-rework-v8-0-64c7fd0cfe64@linaro.org

Changes in v8:

- Rebased on top of v6.8-rc1
- Removed the deinit callback from struct dw_pcie_ep_ops
- Renamed dw_pcie_ep_exit() to dw_pcie_ep_deinit()
- Introduced dw_pcie_ep_cleanup() API for drivers supporting PERST#
- Renamed dw_pcie_ep_init_complete() to dw_pcie_ep_init_registers()
- Called dw_pcie_ep_init_registers() API directly from all glue drivers
- Removed "core_init_notifier" flag
- Added a generic dw_pcie_ep_linkdown() API to handle LINK_DOWN event and used
  it in qcom driver
- Added Kernel-doc comments for DWC EP APIs

Changes in v7:

- Rebased on top of v6.7-rc1
- Kept the current dw_pcie_ep_init_complete() API instead of renaming it to
  dw_pcie_ep_init_late(), since changing the name causes a slight ambiguity.
- Splitted the change that moves pci_epc_init_notify() inside
  dw_pcie_ep_init_notify() to help bisecting and also to avoid build issue.
- Added a new patch that moves pci_epc_init_notify() inside
  dw_pcie_ep_init_notify().
- Took over the authorship and dropped the previous Ack as the patches are
  heavily modified.

Changes in v6:

- Rebased on top of pci/next (6e2fca71e187)
- removed ep_init_late() callback as it is no longer necessary

For previous changelog, please refer [1].

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
Manivannan Sadhasivam (10):
      PCI: dwc: ep: Remove deinit() callback from struct dw_pcie_ep_ops
      PCI: dwc: ep: Rename dw_pcie_ep_exit() to dw_pcie_ep_deinit()
      PCI: dwc: ep: Introduce dw_pcie_ep_cleanup() API for drivers supporting PERST#
      PCI: dwc: ep: Fix DBI access failure for drivers requiring refclk from host
      PCI: dwc: ep: Rename dw_pcie_ep_init_complete() to dw_pcie_ep_init_registers()
      PCI: dwc: ep: Call dw_pcie_ep_init_registers() API directly from all glue drivers
      PCI: dwc: ep: Remove "core_init_notifier" flag
      PCI: dwc: ep: Add a generic dw_pcie_ep_linkdown() API to handle LINK_DOWN event
      PCI: qcom-ep: Use the generic dw_pcie_ep_linkdown() API to handle LINK_DOWN event
      PCI: dwc: ep: Add Kernel-doc comments for APIs

 drivers/pci/controller/dwc/pci-dra7xx.c           |   9 +
 drivers/pci/controller/dwc/pci-imx6.c             |  10 +
 drivers/pci/controller/dwc/pci-keystone.c         |  11 +
 drivers/pci/controller/dwc/pci-layerscape-ep.c    |   9 +
 drivers/pci/controller/dwc/pcie-artpec6.c         |  15 +-
 drivers/pci/controller/dwc/pcie-designware-ep.c   | 309 +++++++++++++++-------
 drivers/pci/controller/dwc/pcie-designware-plat.c |  11 +
 drivers/pci/controller/dwc/pcie-designware.h      |  19 +-
 drivers/pci/controller/dwc/pcie-keembay.c         |  18 +-
 drivers/pci/controller/dwc/pcie-qcom-ep.c         |   6 +-
 drivers/pci/controller/dwc/pcie-rcar-gen4.c       |  28 +-
 drivers/pci/controller/dwc/pcie-tegra194.c        |   5 +-
 drivers/pci/controller/dwc/pcie-uniphier-ep.c     |  15 +-
 drivers/pci/endpoint/functions/pci-epf-test.c     |  18 +-
 include/linux/pci-epc.h                           |   3 -
 15 files changed, 354 insertions(+), 132 deletions(-)
---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20240224-pci-dbi-rework-b2e99a62930c

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>


