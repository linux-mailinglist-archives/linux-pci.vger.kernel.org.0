Return-Path: <linux-pci+bounces-4953-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0C48810FA
	for <lists+linux-pci@lfdr.de>; Wed, 20 Mar 2024 12:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1F7E1C219CD
	for <lists+linux-pci@lfdr.de>; Wed, 20 Mar 2024 11:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F143D57A;
	Wed, 20 Mar 2024 11:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dFNWOVtr"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49913D566
	for <linux-pci@vger.kernel.org>; Wed, 20 Mar 2024 11:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710934332; cv=none; b=sbNo6D9x1w8z992ZFi98sI+NNXEZepQbfvBE/9yee7oak8blgYkqwKSFp1X8ayBobLRgQ5tkRsxyN9nOKpmHRUfeBCHO+RGJI1qicVznxLNZCVHK8uW/Mn6VRq0Eow9a9UToTOJhHBGi3+hM5zC2hLW2oX3r5tL4KMeeYslfxgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710934332; c=relaxed/simple;
	bh=tzgUpmABMb7wWge/LeYF3xODAAn0nytvaA+gThVT5y0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D6BejPR/eb2GrRKS9cgBoMs1vA6MytVa/5N2/PVQLFTUG/K9y2cUXmwDHs3gKviCBfzKAm/loEnKrH5q4aZEdwBj+lGTHlcD3Xh5NosVFLsQ0DcsmOz6u3Bu8aBSqEDVaaAXU/TVoAvSNfGbUtTWtJQ3EIsWHyWWMUk4mroIMPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dFNWOVtr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 268A0C433F1;
	Wed, 20 Mar 2024 11:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710934332;
	bh=tzgUpmABMb7wWge/LeYF3xODAAn0nytvaA+gThVT5y0=;
	h=From:To:Cc:Subject:Date:From;
	b=dFNWOVtrneTf+vbM/gl3vvwz2QOwiLHuJNmqN33YsSyuqudWO9FtfAImQ95XkhlnO
	 4V5kwHb9w0W62sQOeJBB6mI87oZWSeL6hKbgyxjuhkfIl/nLlcRi7e79W5RVcyp0TU
	 s4GFrMIak5yH9BOuwkwA591uKRFB6xQDaaOS4A6NjiHBoBoSt8ZQm/jvpeaYbDDC00
	 KMKwDGkH4VRWo2fVaapSNTS83L4K818g3xmWlW/uJqBy6KdwFZexBGmbkFa6KRlCZV
	 YE83u3MHIo2w3ytOPyPTDKqDNZiGqyQuRhUqsL5xS0HtmEhPTDE+DLY19CKcB8u3kW
	 fsau7LgzDB7Uw==
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
Subject: [PATCH v4 0/7] minor PCI endpoint cleanups
Date: Wed, 20 Mar 2024 12:31:47 +0100
Message-ID: <20240320113157.322695-1-cassel@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello all,

This series used to be called:
"PCI: endpoint: set prefetchable bit for 64-bit BARs"

However, since after discussions with Arnd and Mani, that patch has been
dropped, however, the other cleanups are still worth including IMO, thus
the series has been renamed.


Changes since v3:
-Picked up tags from Mani.
-Fixed minor comments from Mani.
-Dropped patch [PATCH v3 1/9] PCI: endpoint: pci-epf-test: Fix incorrect
 loop increment.
-Dropped patch [PATCH v3 9/9] PCI: endpoint: Set prefetch when allocating
 memory for 64-bit BARs.
-Reordered some of the patches to have a more logical ordering.


Niklas Cassel (7):
  PCI: endpoint: pci-epf-test: Simplify pci_epf_test_alloc_space() loop
  PCI: endpoint: Allocate a 64-bit BAR if that is the only option
  PCI: endpoint: pci-epf-test: Remove superfluous code
  PCI: endpoint: pci-epf-test: Simplify pci_epf_test_set_bar() loop
  PCI: endpoint: pci-epf-test: Clean up pci_epf_test_unbind()
  PCI: cadence: Set a 64-bit BAR if requested
  PCI: rockchip-ep: Set a 64-bit BAR if requested

 .../pci/controller/cadence/pcie-cadence-ep.c  |  5 +-
 drivers/pci/controller/pcie-rockchip-ep.c     |  2 +-
 drivers/pci/endpoint/functions/pci-epf-test.c | 62 +++++--------------
 drivers/pci/endpoint/pci-epf-core.c           |  9 ++-
 4 files changed, 23 insertions(+), 55 deletions(-)

-- 
2.44.0


