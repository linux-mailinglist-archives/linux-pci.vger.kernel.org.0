Return-Path: <linux-pci+bounces-29425-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA9EAD5318
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 13:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38B0E3A5862
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 11:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56922E611C;
	Wed, 11 Jun 2025 10:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rNmCopHT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4302E611A;
	Wed, 11 Jun 2025 10:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749639112; cv=none; b=lRXi5vJtKwzhr7VAw2tPtfnbLd1PORbdVAuQeItOcwKEMvqijBf2lrypVfD9uTai6j417PUM0TQ3zzjw9282HYhceSNUPVYZBo+GmhyN12yAvrqENa5yvLSxkkRKZ9Ylq4j39pcss1kZF51JxY7imKEMIOcZFnuamTZJKjudsTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749639112; c=relaxed/simple;
	bh=z0f/Wl+RIL7QWDaLPnNb/sYLDEt+cxVqTNutC/oQKZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HjhUoNKM9NoAQifBLVM4k1ha7VbJef48ML0HmKmJMeGzdPn+OWO/ffQwfsSKgkoBzcDhytxIuDUBtjcyk3At1Crizg7zxr/mhVl51NtH12NbkUW1gthIl6AsMeVj4ENSngI/x5X0cPeEIcZmOlLIUZQ/tQHT2MHo2cH4LsAvUVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rNmCopHT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D312BC4CEEE;
	Wed, 11 Jun 2025 10:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749639112;
	bh=z0f/Wl+RIL7QWDaLPnNb/sYLDEt+cxVqTNutC/oQKZ8=;
	h=From:To:Cc:Subject:Date:From;
	b=rNmCopHTHN4je/LVKOBaApYhwDFxkotPQAy76zchHZCEZ2c/Prph0G1CfR7hCkpoZ
	 lvnXKfkUZfarXm2zOY6F3DXBge++Ih5a4uHUr6pYySjdmDMYE0VXBOIQbKutFgbK+5
	 t4LemLolrVwRPQR+Ery6bhgFDjbz/RMBua/9JpQBIyLQw1gsuJR2cGlYHLJ9gXWocl
	 TDKFmDTmXtsmSS5PyxkwrRP2Ok9LC+gE8znzFMVFRvTDxBfIiYuzjUe37T9gBnRBla
	 d4u/+RGOqe9TfxmGy2HrXO2QPWQ5szxGbGuWFO466TPp6IteWh/ffnWXrIAszz85RB
	 DSR5602ZZsKYw==
From: Niklas Cassel <cassel@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Niklas Cassel <cassel@kernel.org>,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Laszlo Fiat <laszlo.fiat@proton.me>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-msm@vger.kernel.org
Subject: [PATCH 0/4] PCI: dwc: Do not enumerate bus before endpoint devices are ready
Date: Wed, 11 Jun 2025 12:51:41 +0200
Message-ID: <20250611105140.1639031-6-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1032; i=cassel@kernel.org; h=from:subject; bh=z0f/Wl+RIL7QWDaLPnNb/sYLDEt+cxVqTNutC/oQKZ8=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDI84/d8v9pfETT/yp57mUp7fxjsW6J4bssB9hdKjzTWR 9jxGLdP6ChlYRDjYpAVU2Tx/eGyv7jbfcpxxTs2MHNYmUCGMHBxCsBEhOUYGabv4/c+wnz8l8L/ HbM1DvyP52Sv0Lvwz/e0fP//hxNYNNkZGW5ulbV69i1ps5B1cLWNSOK+P3ySC1hFZ3xncDWIe3/ WmhkA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Hello all,

The DWC PCIe controller driver currently does not follow the PCIe
specification with regards to the delays after link training, before
sending out configuration requests. This series fixes this.

At the same time, PATCH 1/4 addresses a regression where a Plextor
NVMe drive fails to be configured correctly. With this series, the
Plextor NVMe drive works once again.


Kind regards,
Niklas


Niklas Cassel (4):
  PCI: dw-rockchip: Do not enumerate bus before endpoint devices are
    ready
  PCI: qcom: Do not enumerate bus before endpoint devices are ready
  PCI: dwc: Ensure that dw_pcie_wait_for_link() waits 100 ms after link
    up
  PCI: dwc: Reduce LINK_WAIT_SLEEP_MS

 drivers/pci/controller/dwc/pcie-designware.c  | 13 ++++++++++++-
 drivers/pci/controller/dwc/pcie-designware.h  | 11 ++++++++---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c |  7 +++++++
 drivers/pci/controller/dwc/pcie-qcom.c        |  7 +++++++
 4 files changed, 34 insertions(+), 4 deletions(-)

-- 
2.49.0


