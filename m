Return-Path: <linux-pci+bounces-3595-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F70E857DF3
	for <lists+linux-pci@lfdr.de>; Fri, 16 Feb 2024 14:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFD35B264E4
	for <lists+linux-pci@lfdr.de>; Fri, 16 Feb 2024 13:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D4112BEA5;
	Fri, 16 Feb 2024 13:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="auOWFVNc"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B904A12BEA7;
	Fri, 16 Feb 2024 13:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708091141; cv=none; b=Uvl4r9FVZED+CbqBZwlkm87He2aZWFRVmpptUduwnH1/QtPo/yfhcT7JPqRV4JzLrHU124jbA0L2z9SpF8gd2W3N1SklD5ayILSUlbWRwpHmB/cByTAt1w/TZAQHE8yEIjrReouq/fdK1nUuCSfcRUxGU79ivlI+sSZLMn/yUIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708091141; c=relaxed/simple;
	bh=3+uLhQPpkXwAKjU+MV8grUAf3CHFA4l3wtq8PHKqC6U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kxtLF6DXv2YuIWeCoq0hRF0kL5+DaCBZZeS55E/Xt9DODZedqu+Tqxa0C/HyF3UddR5JjZuHnefVUgR/ZzRU0qgwGiVEHK0L3NE0VNQm/95NiUGXn/ZUAi8C+AJWudBEpc2vuKJ60PzvVc2ckMrbHHs/WICjHpLkN2prMlfZAA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=auOWFVNc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B345DC43390;
	Fri, 16 Feb 2024 13:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708091141;
	bh=3+uLhQPpkXwAKjU+MV8grUAf3CHFA4l3wtq8PHKqC6U=;
	h=From:To:Cc:Subject:Date:From;
	b=auOWFVNcECCiHJDP5ntf+mZ4HtcqIODShCx6lpTdy5HBAsp/avpL9P6wsFYRSigVC
	 tym7z2E3dfs2VpGnZBQJqicT+6Wgi8EmmvCklxbIgA9JeG/zRejrliD4yaUFarTj0j
	 YTnP/nkVz3JsDv7zGy4QO08SHLCt2mpaO9OlMGf2+cNwWcAE9o2n+OyLJagZOzdhxF
	 fmdiirhjrmrPaH+lPn40vxk3oBiWr2imQZdYEttiRADZSPYml9z6Mr/hK4dDzeIe/A
	 ngX+i8P54dQsugqIrf/0+0Xu5A2isII+EePZJ4DPzjbeVphUyDMtUvk6/9aZ6EsuSV
	 lvy/KYHkC7Nrg==
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
Subject: [PATCH v2 0/2] PCI endpoint BAR hardware description cleanup
Date: Fri, 16 Feb 2024 14:45:13 +0100
Message-ID: <20240216134524.1142149-1-cassel@kernel.org>
X-Mailer: git-send-email 2.43.1
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

(I will be sending out a patch series that adds BAR_RESIZABLE to enum
pci_epc_bar_type in the coming week.)


Kind regards,
Niklas


Changes since V1:
-Picked up tags from Kishon and Mani.
-Improved commit message for patch 1/2 as suggested by Mani.
-Improved kdoc in patch 2/2 as suggested by Mani.


Niklas Cassel (2):
  PCI: endpoint: Clean up hardware description for BARs
  PCI: endpoint: Drop only_64bit on reserved BARs

 drivers/pci/controller/dwc/pci-imx6.c         |  3 +-
 drivers/pci/controller/dwc/pci-keystone.c     | 12 +++---
 .../pci/controller/dwc/pci-layerscape-ep.c    |  5 ++-
 drivers/pci/controller/dwc/pcie-keembay.c     |  8 +++-
 drivers/pci/controller/dwc/pcie-rcar-gen4.c   |  4 +-
 drivers/pci/controller/dwc/pcie-tegra194.c    | 10 +++--
 drivers/pci/controller/dwc/pcie-uniphier-ep.c | 15 +++++--
 drivers/pci/controller/pcie-rcar-ep.c         | 14 ++++---
 drivers/pci/endpoint/functions/pci-epf-ntb.c  |  4 +-
 drivers/pci/endpoint/functions/pci-epf-test.c |  8 ++--
 drivers/pci/endpoint/functions/pci-epf-vntb.c |  2 +-
 drivers/pci/endpoint/pci-epc-core.c           | 25 +++++-------
 drivers/pci/endpoint/pci-epf-core.c           | 15 +++----
 include/linux/pci-epc.h                       | 39 ++++++++++++++++---
 14 files changed, 106 insertions(+), 58 deletions(-)

-- 
2.43.1


