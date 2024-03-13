Return-Path: <linux-pci+bounces-4774-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA3887A63C
	for <lists+linux-pci@lfdr.de>; Wed, 13 Mar 2024 11:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38773282E49
	for <lists+linux-pci@lfdr.de>; Wed, 13 Mar 2024 10:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E1A3D38F;
	Wed, 13 Mar 2024 10:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="So0Emeg6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEEF3B798
	for <linux-pci@vger.kernel.org>; Wed, 13 Mar 2024 10:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710327501; cv=none; b=csxzBm11u5Si7OEXfYVSmS0gcJ4ppVkSh1lesWWMG2tAL54o2IuSX0rLLbFSeijASlISCBSsa+im+XjC0wep06c2M1mDG/UwX1zpri8hUc1I8zTaYKPbDBlkrkUJaxZQyzrDi8bsEXHim267myx/deIDHCpYlzRUI95L+75kMwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710327501; c=relaxed/simple;
	bh=efgaR6TNaNFKA/8FNZRnotQOnzQaqJy11AVx/5XfNjM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tokyk+4Et9Fm1B+YYVJ2wHDPqBeWKYqeREzSgz4jtWgO17b5lKVmX7h9n2LYan0kO6KvaOprIC1vY/EBmLUK/nktE3nl1CF6tykmY/N2zKyCzbSrtOuYHXRm/F2rHSpfEQzO+QBHT2x/gh23eNAXm5I3WrfKtmg4TEn/mEltNGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=So0Emeg6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43DE3C433C7;
	Wed, 13 Mar 2024 10:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710327501;
	bh=efgaR6TNaNFKA/8FNZRnotQOnzQaqJy11AVx/5XfNjM=;
	h=From:To:Cc:Subject:Date:From;
	b=So0Emeg6esGCvCNTWNaNGRtFW2MxuVmp0sn9jbg1DwUgWbAbnwPxe4Shj+b3Shk5q
	 JNcxc5mbRuch61sqYA0qXBMv4Oas1taoMLafc29LlhOixGD93ohlR3DUwdYNP3d4IL
	 dG7L4svrRcTXx89OHFM+TU9ftL127FLZnmNgZVawkVdWV5MZRJBbMQy8e8CDMCQdSW
	 PfpFnB4/rGIz/XiL4OaHy7FOXHodsnJl5sT/MGYVQv55MBEpjikPSYAvHjKJF1orTL
	 IAcasDbvQD7vAzh5lNMyC7LokZLdfsMlEB/rEtDOWsM0Mlq38xINoOCSMApmxlmUId
	 xNuVPDPp3ZpSw==
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Shradha Todi <shradha.t@samsung.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 0/9] PCI: endpoint: set prefetchable bit for 64-bit BARs
Date: Wed, 13 Mar 2024 11:57:52 +0100
Message-ID: <20240313105804.100168-1-cassel@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Shradha Todi wanted to add prefetchable BAR support by adding more things
to epc_features:
https://lore.kernel.org/linux-pci/20240228134448.56372-1-shradha.t@samsung.com/T/#t

The series starts off with some generic cleanups and fixes which was needed
to make the implementation of the actual feature easier.

The final patch in the series sets the prefetchable bit for all backing memory
that the EPF core allocates for a 64-bit BAR.


Kind regards,
Niklas


Changes since V2:
-Fixed warning when building with W=1 reported by kernel test robot.


Niklas Cassel (9):
  PCI: endpoint: pci-epf-test: Fix incorrect loop increment
  PCI: endpoint: Allocate a 64-bit BAR if that is the only option
  PCI: endpoint: pci-epf-test: Remove superfluous code
  PCI: endpoint: pci-epf-test: Simplify pci_epf_test_alloc_space() loop
  PCI: endpoint: pci-epf-test: Simplify pci_epf_test_set_bar() loop
  PCI: endpoint: pci-epf-test: Clean up pci_epf_test_unbind()
  PCI: cadence: Set a 64-bit BAR if requested
  PCI: rockchip-ep: Set a 64-bit BAR if requested
  PCI: endpoint: Set prefetch when allocating memory for 64-bit BARs

 .../pci/controller/cadence/pcie-cadence-ep.c  |  5 +-
 drivers/pci/controller/pcie-rockchip-ep.c     |  2 +-
 drivers/pci/endpoint/functions/pci-epf-test.c | 70 +++++++------------
 drivers/pci/endpoint/pci-epf-core.c           | 10 ++-
 4 files changed, 33 insertions(+), 54 deletions(-)

-- 
2.44.0


