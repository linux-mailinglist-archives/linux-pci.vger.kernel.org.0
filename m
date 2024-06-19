Return-Path: <linux-pci+bounces-8963-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F0B90E815
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 12:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98EB12830E0
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 10:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4535A824B2;
	Wed, 19 Jun 2024 10:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dohXgO9b"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85022B9AB;
	Wed, 19 Jun 2024 10:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718792136; cv=none; b=p8RGZAY8TqKbAuq4/zoK4dacN7JBGO8+O8OVd4jTdXs7Fa2770F8U+Hf0qV3LMNTWahWEBi/KQiUO/kfc+ATjUwpdmHqjfpBqTpGTukrNN676zc+5Cw2+sggod747FKjngNuqDxFyCRC9Y2YRROS1yMGj7pBGpca8UlPqvtXBY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718792136; c=relaxed/simple;
	bh=oEET+vcMZKMqEubCxQY+kRINnUNZ9uw+rF9qxN+rVwo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AKJEt836bUpdFdTJlSAOIkgE0/flGngXR2WiCU3Vye0F5tRBOl7+BkN8CcOf4PDKqIeHGdpj0+qdjOvxN4RQ82WrsVneE+c69vXDvwa4VnXYG3rkUKoiRJv7hwBQhkwOdsR8MqLxUQ1pGAkPVnD59Yaaao4SHDZGHiSt/KSVpnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dohXgO9b; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9157CE0004;
	Wed, 19 Jun 2024 10:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718792125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FQCg7ZLsvGDRPgsO29VZPaQFDsB2sckQAqQKVR+hlT8=;
	b=dohXgO9b9n8BNyf6kX/KWV99QZlenLSjwYpTmQimpV1gCUd8Dgkdnnjp+DWnwVkJJnpvyx
	Cvq5WnsiOrq7853+XJTdNqkj5VKsDOBmrgflQ6rsSU+of7pXp6EQIkEbft5+5OObXi+LMS
	bRviNZkZf6qMz7z5OKKebcVPCMJtUbC7ty2pe1wF/3fAlVpdxFQfLm/Fgjsy8Em7xxtFcY
	QyShmSPU+pwy9bBsZklCgu/wB82fq0pFOcQVjljEQvWwjZ9Iu2dHhFINMKsTsHMpEQtaXG
	50Xmec1YZwCZ/PjNvOHDt1rJ4tA9t8p4RjoTmdNWi2x/st09kxtxBO8PVwFldg==
From: Thomas Richard <thomas.richard@bootlin.com>
Subject: [PATCH v7 0/7] Add suspend to ram support for PCIe on J7200
Date: Wed, 19 Jun 2024 12:15:08 +0200
Message-Id: <20240102-j7200-pcie-s2r-v7-0-a2f9156da6c3@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAKyvcmYC/33Ny07EIBQG4FeZsBYDh1vryvcwLrgcLMYpE2gaz
 aTvLszONLL8z+X776RiSVjJy+VOCu6ppry2YJ4uxC92/UCaQssEGEjGGdBPA4zRm09IKxSK3nE
 7mxmFMqQ9OVuRumJXv/S3q60blr64FYzp+9H09t7ykuqWy8+jeOd9+m/Hzimjk0SlglXthL26n
 LevtD77fCUd22EMQAdQRhMAJvRwBsQYEA1QHlBaEa3n8QzIMSAboCOPSoiZ+UmdATUGVAOkm7z
 UhvOA4QzoMaA7oJXGqFEHrf8Cx3H8AjpikcwMAgAA
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: gregory.clement@bootlin.com, theo.lebrun@bootlin.com, 
 thomas.petazzoni@bootlin.com, u-kumar1@ti.com, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Thomas Richard <thomas.richard@bootlin.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>
X-Mailer: b4 0.12.0
X-GND-Sasl: thomas.richard@bootlin.com

This adds suspend to ram support for the PCIe (RC mode) on J7200 platform.

In this 7th iteration, the i2c and mux patches were moved to dedicated
series ([1] and [2]).
The patch for the gpio-pca953x driver was removed. It will be sent
separately for further testing and discussion.

No merge conflict with 6.10-rc4.

[1]: https://lore.kernel.org/all/20240613-i2c-omap-wakeup-controller-during-suspend-v1-0-aab001eb1ad1@bootlin.com/
[2]: https://lore.kernel.org/all/20240613-mux-mmio-resume-support-v1-0-4525bf56024a@bootlin.com/

Regards,

Thomas

Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
---
Changes in v7:
- all: series rebased on Linux 6.10-rc4.
- i2c: patches moved to a dedicated series.
- mux: patches moved to a dedicated series.
- gpio-pca953x: patch removed, will be sent separately.
- Link to v6: https://lore.kernel.org/r/20240102-j7200-pcie-s2r-v6-0-4656ef6e6d66@bootlin.com

Changes in v6:
- i2c-omap: add a patch to remove __maybe_unused attribute of
  omap_i2c_runtime_suspend() and omap_i2c_runtime_resume()
- i2c-omap: fix compile issue if CONFIG_PM_SLEEP is not set
- Link to v5: https://lore.kernel.org/r/20240102-j7200-pcie-s2r-v5-0-4b8c46711ded@bootlin.com

Changes in v5:
- all: series rebased on Linux 6.9-rc1
- pinctrl-single: patch removed (already applied to the pinctrl tree)
- phy: patches moved to a dedicated series.
- pci: add T_PERST_CLK_US macro.
- pci-j721e: update the comments about T_PERST_CLK_US.
- Link to v4: https://lore.kernel.org/r/20240102-j7200-pcie-s2r-v4-0-6f1f53390c85@bootlin.com

Changes in v4:
- all: use SoB/Co-developed-by for patches initially developed by Théo
  Lebrun.
- pinctrl-single: squash the two commits.
- i2c-omap: fix line lenghts of the comment in omap_i2c_suspend().
- mux: mux_chip_resume() return 0 or at the first error.
- phy-j721e-wiz: clean code around dev_err_probe().
- phy-j721e-wiz: use REF_CLK_100MHZ macros.
- pci: fix subject line for all PCI patches.
- pci-cadence: use fsleep() instead of usleep_range().
- pci-cadence: remove cdns_torrent_clk_cleanup() call in
  cdns_torrent_phy_resume_noirq().
- pci-j721e: add a patch to use dev_err_probe() instead of dev_err() in the probe().
- pci-j721e: fix unordered header files.
- pci-j721e: remove some log spammers.
- pci-j721e: add a missing clock disable in j721e_pcie_resume_noirq().
- pci-j721e: simplify the patch "Add reset GPIO to struct j721e_pcie"
- Link to v3: https://lore.kernel.org/r/20240102-j7200-pcie-s2r-v3-0-5c2e4a3fac1f@bootlin.com

Changes in v3:
- pinctrl-single: split patch in two parts, a first patch to remove the
  dead code, a second to move suspend()/resume() callbacks to noirq.
- i2c-omap: add a comments above the suspend_noirq() callback.
- mux: now mux_chip_resume() try to restores all muxes, then return 0 if
  all is ok or the first failure.
- mmio: fix commit message.
- phy-j721e-wiz: add a patch to use dev_err_probe() instead of dev_err() in
  the wiz_clock_init() function.
- phy-j721e-wiz: remove probe boolean for the wiz_clock_init(), rename the
  function to wiz_clock_probe(), extract hardware configuration part in a
  new function wiz_clock_init().
- phy-cadence-torrent: use dev_err_probe() and fix commit messages
- pcie-cadence-host: remove probe boolean for the cdns_pcie_host_setup()
  function and extract the link setup part in a new function
  cdns_pcie_host_link_setup().
- pcie-cadence-host: make cdns_pcie_host_init() global.
- pci-j721e: use the cdns_pcie_host_link_setup() cdns_pcie_host_init()
  functions in the resume_noirq() callback.
- Link to v2: https://lore.kernel.org/r/20240102-j7200-pcie-s2r-v2-0-8e4f7d228ec2@bootlin.com

Changes in v2:
- all: fix commits messages.
- all: use DEFINE_NOIRQ_DEV_PM_OPS and pm_sleep_ptr macros.
- all: remove useless #ifdef CONFIG_PM.
- pinctrl-single: drop dead code
- mux: add mux_chip_resume() function in mux core.
- mmio: resume sequence is now a call to mux_chip_resume().
- phy-cadence-torrent: fix typo in resume sequence (reset_control_assert()
  instead of reset_control_put()).
- phy-cadence-torrent: use PHY instead of phy.
- pci-j721e: do not shadow cdns_pcie_host_setup return code in resume
  sequence.
- pci-j721e: drop dead code.
- Link to v1: https://lore.kernel.org/r/20240102-j7200-pcie-s2r-v1-0-84e55da52400@bootlin.com

---
Thomas Richard (5):
      PCI: cadence: Extract link setup sequence from cdns_pcie_host_setup()
      PCI: cadence: Set cdns_pcie_host_init() global
      PCI: j721e: Use dev_err_probe() in the probe() function
      PCI: Add T_PERST_CLK_US macro
      PCI: j721e: Use T_PERST_CLK_US macro

Théo Lebrun (2):
      PCI: j721e: Add reset GPIO to struct j721e_pcie
      PCI: j721e: Add suspend and resume support

 drivers/pci/controller/cadence/pci-j721e.c         | 121 ++++++++++++++++++---
 drivers/pci/controller/cadence/pcie-cadence-host.c |  44 +++++---
 drivers/pci/controller/cadence/pcie-cadence.h      |  12 ++
 drivers/pci/pci.h                                  |   3 +
 4 files changed, 146 insertions(+), 34 deletions(-)
---
base-commit: 7510725e693fb5e4b4cd17086cc5a49a7a065b9c
change-id: 20240102-j7200-pcie-s2r-ecb1a979e357

Best regards,
-- 
Thomas Richard <thomas.richard@bootlin.com>


