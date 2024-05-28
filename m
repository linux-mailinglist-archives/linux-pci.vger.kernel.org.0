Return-Path: <linux-pci+bounces-7893-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C788D1C0D
	for <lists+linux-pci@lfdr.de>; Tue, 28 May 2024 15:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30EBA1C22CDC
	for <lists+linux-pci@lfdr.de>; Tue, 28 May 2024 13:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CFB516DEA8;
	Tue, 28 May 2024 13:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GXvYWQ8i"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEFC13D61E;
	Tue, 28 May 2024 13:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716901250; cv=none; b=hh8OCWOif2JCZgWOfAHswh5BaeFt3XdYa6KmP2ERXiNolsKadjrxGzctaTHh+9V7AspfWKN/9TeQvvr2GLYUN6u2+ZqEQOXtOSLgTHhlcYmiDWTaN30t2lpzTiEVtfZ7AU3dX/j/2Zs9sPoki0ZYwQmWs5+UGIRd2cdOi0VTTf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716901250; c=relaxed/simple;
	bh=HABINTt9kxGsJQrrW5L33dqrIcuhqyUbsQjoUKDtfTE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EEmlhNLdq0P6tc10cmaGWD0j5iStcrwJ3pQ5Z2JbhB/CLuU72Q8jesS9aJthQo8w49cway30q3SvFuhuYxM0SjEy4vsx/K1/P8IB3yqpj2eUqs/E30eMHyEtx0fB/E+x5WRaooeQ4pTsyr3bs739E1TmF1DmUE09wf+9wk9mTSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GXvYWQ8i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE944C3277B;
	Tue, 28 May 2024 13:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716901249;
	bh=HABINTt9kxGsJQrrW5L33dqrIcuhqyUbsQjoUKDtfTE=;
	h=From:To:Cc:Subject:Date:From;
	b=GXvYWQ8ix2bhRXya9ikgbbM71NM3kkEmNFE+khWCZGOH0U9S3l2buGhJoFOeFORAV
	 FmYFGJXXeF3mmkZYp+gfGRS/CFRro8RJjclHaxPmEzF1IovSNgXsEUX/3jCChEerl4
	 HU9rBKNw5Ms0mGXzigIPNh7d5GT8tlyoRLu7ht8MWxnlA8xhd0A7IL3pqwsCdioDX9
	 wwZAy8S3CkRjc62bT89Edapb72c8ob3w8QBWX93iRifHAWRm0YtkyJg53lpU3aLhMZ
	 1PuCH/B57h6OG2pKvNFbGYIq1xWlWDfxsy6UErHh2pGQH+tKoPDtXYNK6RX4K0+FVf
	 DarUFXeIb/BSA==
From: Niklas Cassel <cassel@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH 0/3] Make pci/endpoint branch build
Date: Tue, 28 May 2024 15:00:36 +0200
Message-ID: <20240528130035.1472871-5-cassel@kernel.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=829; i=cassel@kernel.org; h=from:subject; bh=HABINTt9kxGsJQrrW5L33dqrIcuhqyUbsQjoUKDtfTE=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNJCrxZ7sJgwzLh48lJTRI3yVG3O99qv/j8tkLs7Yd1l2 8hvTolPOkpZGMS4GGTFFFl8f7jsL+52n3Jc8Y4NzBxWJpAhDFycAjCR3naG/yHnDU5u4JZL2nzY TtAl483Wqd8v9PKsdL8bEHzq7Y4NBlcYGU5mXv669NSjeQdOWN5l+LTrZ/GlGRx7VL9vmxE973l x0hcmAA==
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

The pci/next branch has currently not merged the latest pci/endpoint
branch.

Perhaps this delay in creating a new pci/next branch is because the
pci/endpoint branch currently fails to build.

Fix the build error on the pci/endpoint branch such that it will be
possible to queue further patches.


Kind regards,
Niklas

Niklas Cassel (3):
  PCI: dwc: ep: Add dw_pcie_ep_deinit_notify()
  PCI: qcom-ep: Make use of dw_pcie_ep_deinit_notify()
  PCI: tegra194: Make use of dw_pcie_ep_deinit_notify()

 drivers/pci/controller/dwc/pcie-designware-ep.c | 13 +++++++++++++
 drivers/pci/controller/dwc/pcie-designware.h    |  5 +++++
 drivers/pci/controller/dwc/pcie-qcom-ep.c       |  2 +-
 drivers/pci/controller/dwc/pcie-tegra194.c      |  2 +-
 4 files changed, 20 insertions(+), 2 deletions(-)

-- 
2.45.1


