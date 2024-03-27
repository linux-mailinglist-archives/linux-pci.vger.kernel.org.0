Return-Path: <linux-pci+bounces-5234-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1BE88D9D5
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 10:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E04BB239B4
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 09:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E7C37702;
	Wed, 27 Mar 2024 09:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IcKPRZhz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5129A374EF
	for <linux-pci@vger.kernel.org>; Wed, 27 Mar 2024 09:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711530842; cv=none; b=MilM3RDOKri92x3R2ajJcrlB4TUbtd04wghxqHbRa6IYeE4WqVSptY1FRyYPzFtwdYkpESkrspsMkg/CqrYgmiPjdqNgTq9DXuCe2/M6/WVVC9N3wPJwrGeQqml9kEDZcrO33MkQjvHQaWyNLTDGuY0u1PxXSZRktzfmqdMqeUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711530842; c=relaxed/simple;
	bh=iO9oNvG+QPX6EBHlzWrbZgkGzqEkhIYMPjFQURkQp1E=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tpKlEEJ7wo/eE23ZPWvLYZsMML8u509n/iNzMAyaC5B04DgjyS8bWlJo+QUnUxAVkmcgghIEkr8jHZ2keomkvK5WF4tDxykDJF4cX9GSIfPvzjWcQFqWhSyhzwLpmOk1/qMn6iiKUeJvVgg317QeZgJOA8hRXEGAC9C/0AdE0oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IcKPRZhz; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6e6d063e88bso2018389a34.3
        for <linux-pci@vger.kernel.org>; Wed, 27 Mar 2024 02:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711530839; x=1712135639; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m7YoevRtWoIrX5inKpmhV/jNINZnpRhSbmQj7YxoH3s=;
        b=IcKPRZhzBxsVoMKJCIFCqtYXft62VqgsDo8rX1MvH6oBHhTuLS3xMgKEdynu1A4WE3
         YO5M4nVvUH/f0BsbbrTEeyYFj8XA8YRSEiKRnaECszKP5pG7LllZMgmYl7oZazfsAr+5
         axK5c9ZrBRYH1P6aoZe9Q8Lj9MRLBCUZASOO9bpvDVs1zHmL6DSqRxN6f5JIiEeiJ5GE
         DD13rMf+8klJXI2fKrc5b4gbYazwVm6ixS+1T+RUEODP8he5ltvtYvudzxhGBMnszKfX
         tE5pSuTCBFt+MuWvJHAXon08m1/2Prb6686QGZxybQfI4BfsVDblcyUx13IyZKaANxMy
         nx6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711530839; x=1712135639;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m7YoevRtWoIrX5inKpmhV/jNINZnpRhSbmQj7YxoH3s=;
        b=eT6SAZzSfFTVxPzXWpe4kNjCQBeHU6u8govU87PBG/BFarQQ03Oq8g+MWyZvcI8qNn
         JpnbihMD8Bw57xUSdYcb0nG3UtRyU4c+5pwlE1KX/+UV/PPq8pCgFsr9/u9WDXJH6cEx
         RAFpuojawhA372orK4PlMOybenhdnYs+I+kZXHpkvW2w6PpsgjIYbiYUYdSqyQVut7ZD
         kkGdzb12d0P399Egh8OwwhNn+QM4oa+W0dyTdg69Fr8Miqt37+4SO+04J2E8QoSYdAQU
         Mu1/UWnCSjSQGsHKWbseDlCU0yzd0LJP1zgzagNE0Id7/7PXDzBSuMXBIsaHjEf0QyYJ
         QNEA==
X-Gm-Message-State: AOJu0YzdEFjwiiNlu0dt8w2U1d5qQJFtv/9MZ5bQL6wheVeIS7t78/NW
	zqs09z519SVqsofrPP/Gbq9N4Hu0QfX0fLNl+m8s1GL+CKL3SmqNxcoz1f5BZg==
X-Google-Smtp-Source: AGHT+IHLrC+cElHqEJHgQI6bNudg5V3T5UyMpSvlDNp0VTqd68nwYnF3OIdtHfvbZn/Wx5NtZMwQqQ==
X-Received: by 2002:a9d:4f07:0:b0:6e6:ded0:8a69 with SMTP id d7-20020a9d4f07000000b006e6ded08a69mr5193012otl.31.1711530839288;
        Wed, 27 Mar 2024 02:13:59 -0700 (PDT)
Received: from [127.0.1.1] ([120.60.52.77])
        by smtp.gmail.com with ESMTPSA id h190-20020a6383c7000000b005dc4fc80b21sm8673871pge.70.2024.03.27.02.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 02:13:58 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v12 0/8] PCI: dwc: ep: Fix DBI access failure for drivers
 requiring refclk from host
Date: Wed, 27 Mar 2024 14:43:29 +0530
Message-Id: <20240327-pci-dbi-rework-v12-0-082625472414@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADnjA2YC/3XPS2oDMQyA4asEr+Mgy56Huuo9SheOLSeiYRw8Z
 doS5u71ZNME06UE/yd0UzMX4Vm97G6q8CKz5KkOBvc7Fc5+OrGWWBcKAR0gOn0NouNRdOGvXD7
 0EZnI90gWgqrRtXCS77v49l7ns8yfufzcDyzjtv2XWkYNundhSBFC4t69XmTyJR9yOanNWuivt
 9D2VHuk6KyNRCH6pjfwAJgWMFAF47zrQufJjtwK5kHAoRXM9kPqsKNE0A/2SVjX9ReJR8rQcgE
 AAA==
To: Jingoo Han <jingoohan1@gmail.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Marek Vasut <marek.vasut+renesas@gmail.com>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Vidya Sagar <vidyas@nvidia.com>, 
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
 Srikanth Thokala <srikanth.thokala@intel.com>, 
 Shawn Lin <shawn.lin@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, 
 Kishon Vijay Abraham I <kishon@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
 Niklas Cassel <cassel@kernel.org>, linux-arm-kernel@axis.com, 
 linux-rockchip@lists.infradead.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=6302;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=iO9oNvG+QPX6EBHlzWrbZgkGzqEkhIYMPjFQURkQp1E=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBmA+NIo/FDU1Qzm8K9RhxHEI8Jtmbq4KExhILxr
 h8EcXGlx0SJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZgPjSAAKCRBVnxHm/pHO
 9XMZB/9ZVvwo9sSG/E7aVel5CSG/nMG/jLxOi0rHJgyMN7yji8HK5ajSrTKUXs0jT4mdCTclZ8j
 yGj4IxADoOnlwcHIjiz7NfE8eueVtUlnoWSzqXxWV9FrLNUtwYp98RXIOc3UvpMlvG/0QgbH3uv
 K7YTyqGd4NsP7zM3fHjaWXkw0pB60QsEos4YQLk9lBpRKQxz40KLuAET6DwRV5ZNfua1ew+4L65
 zr+NXa5ghbAqbrbm05gK3xe5iivUEFGH7lu9dMy5+yyytQgKM7Qf1VrUGShOtJKMAPZ0TB5p/5R
 pFm/tz8l8TQYBVCiCxd0wAYH21S9gVFyCpuDBh/w4ikx2xHy
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

Changes in v12:
- Fixed the init_notify() API used in non-dwc drivers (thanks Niklas)
- Dropped Gustavo from CC since his email is bouncing
- Link to v11: https://lore.kernel.org/r/20240327-pci-dbi-rework-v11-0-6f5259f90673@linaro.org

Changes in v11:
- Minor cleanups reported by Niklas
- 'epc->init_complete = false' is set in dw_pcie_ep_cleanup() to avoid
  triggering init complete notification before refclk. This will be moved to EPC
  core in the following series adding deinit notifier.
- Collected review tags.
- Link to v10: https://lore.kernel.org/r/20240314-pci-dbi-rework-v10-0-14a45c5a938e@linaro.org

Changes in v10:
- Reordered the commits by moving the independent fixes/cleanups first (Niklas)
- Addressed several comments from Niklas
- Moved PTM register setting out of dw_pcie_ep_init_non_sticky_registers() (Niklas)
- Addressed the issue that EPF drivers were missing init notification after the
  removal of core_init_notifier (Niklas)
- Dropped a few cleanup patches to be clubbed with the follow up series
- Collected review tags
- Dropped the review tags for patch 8/8 as it got changed
- Link to v9: https://lore.kernel.org/r/20240304-pci-dbi-rework-v9-0-29d433d99cda@linaro.org

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
Manivannan Sadhasivam (8):
      PCI: dwc: ep: Fix DBI access failure for drivers requiring refclk from host
      PCI: dwc: ep: Add Kernel-doc comments for APIs
      PCI: dwc: ep: Remove deinit() callback from struct dw_pcie_ep_ops
      PCI: dwc: ep: Rename dw_pcie_ep_exit() to dw_pcie_ep_deinit()
      PCI: dwc: ep: Introduce dw_pcie_ep_cleanup() API for drivers supporting PERST#
      PCI: dwc: ep: Rename dw_pcie_ep_init_complete() to dw_pcie_ep_init_registers()
      PCI: dwc: ep: Call dw_pcie_ep_init_registers() API directly from all glue drivers
      PCI: endpoint: Remove "core_init_notifier" flag

 drivers/pci/controller/cadence/pcie-cadence-ep.c  |   2 +
 drivers/pci/controller/dwc/pci-dra7xx.c           |   9 +
 drivers/pci/controller/dwc/pci-imx6.c             |  10 +
 drivers/pci/controller/dwc/pci-keystone.c         |  11 +
 drivers/pci/controller/dwc/pci-layerscape-ep.c    |   9 +
 drivers/pci/controller/dwc/pcie-artpec6.c         |  15 +-
 drivers/pci/controller/dwc/pcie-designware-ep.c   | 238 +++++++++++++++-------
 drivers/pci/controller/dwc/pcie-designware-plat.c |  11 +
 drivers/pci/controller/dwc/pcie-designware.h      |  14 +-
 drivers/pci/controller/dwc/pcie-keembay.c         |  18 +-
 drivers/pci/controller/dwc/pcie-qcom-ep.c         |   4 +-
 drivers/pci/controller/dwc/pcie-rcar-gen4.c       |  28 ++-
 drivers/pci/controller/dwc/pcie-tegra194.c        |   5 +-
 drivers/pci/controller/dwc/pcie-uniphier-ep.c     |  15 +-
 drivers/pci/controller/pcie-rcar-ep.c             |   2 +
 drivers/pci/controller/pcie-rockchip-ep.c         |   2 +
 drivers/pci/endpoint/functions/pci-epf-test.c     |  18 +-
 drivers/pci/endpoint/pci-ep-cfs.c                 |   9 +
 drivers/pci/endpoint/pci-epc-core.c               |  22 ++
 include/linux/pci-epc.h                           |   7 +-
 20 files changed, 338 insertions(+), 111 deletions(-)
---
base-commit: 4cece764965020c22cff7665b18a012006359095
change-id: 20240224-pci-dbi-rework-b2e99a62930c

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>


