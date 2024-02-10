Return-Path: <linux-pci+bounces-3315-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 292F38501BA
	for <lists+linux-pci@lfdr.de>; Sat, 10 Feb 2024 02:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E3431C27E2D
	for <lists+linux-pci@lfdr.de>; Sat, 10 Feb 2024 01:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC36720F1;
	Sat, 10 Feb 2024 01:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uP/nY3bJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992A94414;
	Sat, 10 Feb 2024 01:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707528418; cv=none; b=nUuOmwtlP+w395itsfv62kr5MFbkE6A1SAQK1yMO7J7GX4AlprLapSmCQe/7LcHNFK8SJj4457MGiG48Zy3pO1AOj+WjjtNfIAXn5bWwP6XZpHlJ8VRqtqF6yehKTW6wpNYJvRyHtWBjU1srKxrRa6+6j5q8ddlQ9AOxERc7y0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707528418; c=relaxed/simple;
	bh=ZbSoZXx/9HDBf8DsNqbS8trxVTS30KxSnV3BsPNQp3k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZFMaxO+f8Y6iO1uFcdXNHFxBI8Ud8vWzgUiC1Vo3n2BIAFVtKZwh7818Q5kp7BP1eo1xS8XtAeZpFO+ma3kEqotubkimdV/VwK9rDjSw1e+b3cOfmXmknbmfzxhrB8i3pJltUEgtPIoKS7DVjmk1EBKi47pYn5kamFYbw3k5HvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uP/nY3bJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B8D5C433C7;
	Sat, 10 Feb 2024 01:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707528418;
	bh=ZbSoZXx/9HDBf8DsNqbS8trxVTS30KxSnV3BsPNQp3k=;
	h=From:To:Cc:Subject:Date:From;
	b=uP/nY3bJB+/VTamjus0HHPCwu+bMefQIk78SOUwKphz3+gWiLnNZ4DakrWJNSDx2O
	 VTaU1OxpBh4Fd/KtZ/2pjL1q+TKDtJUf8zOpHrKnjwejf9chfYQoZVkUAXZhKzAIfu
	 SDsy166t5sAGJfNCF1XfXPzm5tVktGrse6iCTgqRp5bo3wt8aQePan4sr1nAzLc/uc
	 edCfP+fu0w8DPgThvXuOXR80kthoHTXbhU40CJP3tCwQNP/qI51uex6hw93abDldML
	 HebBcWwW1alYdWU39xT8wSx8JXVAASlK1C5I7HzfBtF8ISK3R54aY/5uWJ0lpqRKAd
	 onWTuotlmiQIQ==
From: Niklas Cassel <cassel@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Minghuan Lian <minghuan.Lian@nxp.com>,
	Mingkai Hu <mingkai.hu@nxp.com>,
	Roy Zang <roy.zang@nxp.com>,
	Srikanth Thokala <srikanth.thokala@intel.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-renesas-soc@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH 0/2] PCI endpoint BAR hardware description cleanup
Date: Sat, 10 Feb 2024 02:26:24 +0100
Message-ID: <20240210012634.600301-1-cassel@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The series is based on top of:
https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=endpoint


Hello all,

This series cleans up the hardware description for PCI endpoint BARs.

The problems with the existing hardware description:
-The documentation is lackluster.
-Some of the names are confusingly similar, e.g. fixed_64bit and
 fixed_size, even though these are for completely unrelated things.
-The way that the BARs are defined in the endpoint controller drivers
 is messy, because the left hand side is not a BAR, so you can mark a
 BAR as e.g. both fixed size and reserved.

This series tries to address all the problems above.

Personally, I think that the code is more readable, both the endpoint
controller drivers, but also pci-epc-core.c.

(Oh, and as you can probably guess, I will be sending out a patch series
that adds BAR_RESIZABLE to enum pci_epc_bar_type in the coming week(s).)


Kind regards,
Niklas


Niklas Cassel (2):
  PCI: endpoint: Clean up hardware description for BARs
  PCI: endpoint: Drop only_64bit on reserved BARs

 drivers/pci/controller/dwc/pci-imx6.c         |  3 +-
 drivers/pci/controller/dwc/pci-keystone.c     | 12 +++---
 .../pci/controller/dwc/pci-layerscape-ep.c    |  5 ++-
 drivers/pci/controller/dwc/pcie-keembay.c     |  8 +++-
 drivers/pci/controller/dwc/pcie-rcar-gen4.c   |  4 +-
 drivers/pci/controller/dwc/pcie-tegra194.c    | 10 +++--
 drivers/pci/controller/dwc/pcie-uniphier-ep.c | 15 ++++++--
 drivers/pci/controller/pcie-rcar-ep.c         | 14 ++++---
 drivers/pci/endpoint/functions/pci-epf-ntb.c  |  4 +-
 drivers/pci/endpoint/functions/pci-epf-test.c |  8 ++--
 drivers/pci/endpoint/functions/pci-epf-vntb.c |  2 +-
 drivers/pci/endpoint/pci-epc-core.c           | 25 +++++-------
 drivers/pci/endpoint/pci-epf-core.c           | 15 ++++----
 include/linux/pci-epc.h                       | 38 ++++++++++++++++---
 14 files changed, 105 insertions(+), 58 deletions(-)

-- 
2.43.0


