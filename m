Return-Path: <linux-pci+bounces-27684-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08BE2AB64B9
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 09:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C06511B637EE
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 07:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51844201004;
	Wed, 14 May 2025 07:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZTzZu+lL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279A21F3B8A;
	Wed, 14 May 2025 07:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747208606; cv=none; b=oOnXN4BxR2nauE1/lf1lgIQhh4NBfVXblwU7KgwFwWm1Wqv+ZIrPZQK9hfEjGYyOciU4rq1pqXLUMFqDN59utPSUqVLJX0VFXCRouKtwYAXNzEiDCAsRvc11yxwtFCc5KyILBh8WHG0uMMofVxijt65Vv3/aXGCiSOh9hx9Yk6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747208606; c=relaxed/simple;
	bh=IlNY+N9xZbP25gW4EGqg6yQNRWjc9oFtjCsewb4Lipc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Iy5Kee8BaPlrOftOQgrZjbLxdqcx+s9mVNc3AsVBG/tQnDML4/1NUycuYpF6ZzMhBfRCzaeokc4ZZ7Tn6tugIfywxb2GWIFuIZ8C34r1e+2g8VNDaYMlzgeBwfZrn8fERpvs037Pp5VxY5Ifqeacz6LnVdwtjHohRB/0UiJgojk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZTzZu+lL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5892CC4CEF0;
	Wed, 14 May 2025 07:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747208605;
	bh=IlNY+N9xZbP25gW4EGqg6yQNRWjc9oFtjCsewb4Lipc=;
	h=From:To:Cc:Subject:Date:From;
	b=ZTzZu+lLM2/EY5NaqE4555dxzcvf9L5+n1Q/AqvAOPJ4l5CNK3mFqBHEdRjHx8QHF
	 Pr700C7l1M2TO+k1PNW8D5/VoiYK6l5SRDWP6dvmPcI/PmDmquobLex6zmBbgU64Hn
	 w8et4LvHFqbZV0//7yP2mp2YROFqdzLUD6CwH2JEQwZeElBnZuOz/7QQwPQMCY2qjC
	 x6POWwDGHOaa0CHcAvZBe19ZB197JnDPwH2d4zNuV+OKH798iWeBngrzQztZpJrM5k
	 iGs2pMt5+CcS2N10zCIhv5NSTOfreZCNGaex9g1Z2Y1E7mcvMFN9n8Ux775y1Q5hpI
	 BREF6ztaRl+Bw==
From: Niklas Cassel <cassel@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Alan Douglas <adouglas@cadence.com>
Cc: Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 0/6] PCI: endpoint: IRQ callback fixes and cleanups
Date: Wed, 14 May 2025 09:43:13 +0200
Message-ID: <20250514074313.283156-8-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1360; i=cassel@kernel.org; h=from:subject; bh=IlNY+N9xZbP25gW4EGqg6yQNRWjc9oFtjCsewb4Lipc=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDJUPCf+XWco1erKs6pN+l7Gp1NrNKoq10le+N4UuLKjS 9W7+d/jjlIWBjEuBlkxRRbfHy77i7vdpxxXvGMDM4eVCWQIAxenAExkxleG/xWmYoVW9l+5t1e+ 3fr01zXeOov4BWwtH2LFJ/f0xX56asDwvzx2gufxZNGYp+vMX81gFu4sTOyJs7L0j/B8I7OJ+5g 7BwA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Hello all,

The first two patches in this series are IRQ callback fixes that should
get backported.

The reason why the bugs existed in the first place is because the APIs
are very confusing. The rest of the patches are cleanups of the APIs.
These cleanups should not get backported.


Changes since v2:
-Reorder patches to have more logical ordering
-Capitalize first letter after prefix (Krzysztof)
-Improved commit message of the cleanup patches (Damien)
-Renamed parameter interrupts to nr_irqs (Damien)
-Picked up tags. Did not pick up tags on patches that changed significantly


Niklas Cassel (6):
  PCI: dwc: ep: Fix broken set_msix() callback
  PCI: cadence-ep: Fix broken set_msix() callback
  PCI: endpoint: Cleanup get_msi() callback
  PCI: endpoint: Cleanup get_msix() callback
  PCI: endpoint: Cleanup set_msi() callback
  PCI: endpoint: Cleanup set_msix() callback

 .../pci/controller/cadence/pcie-cadence-ep.c  | 14 +++++-----
 .../pci/controller/dwc/pcie-designware-ep.c   | 15 ++++++-----
 drivers/pci/controller/pcie-rcar-ep.c         |  8 +++---
 drivers/pci/controller/pcie-rockchip-ep.c     |  9 ++++---
 drivers/pci/endpoint/pci-epc-core.c           | 26 +++++++------------
 include/linux/pci-epc.h                       | 11 ++++----
 6 files changed, 39 insertions(+), 44 deletions(-)

-- 
2.49.0


