Return-Path: <linux-pci+bounces-211-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 579EC7FB3C1
	for <lists+linux-pci@lfdr.de>; Tue, 28 Nov 2023 09:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 896EC1C20F47
	for <lists+linux-pci@lfdr.de>; Tue, 28 Nov 2023 08:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB343171DA;
	Tue, 28 Nov 2023 08:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PnNpAEzk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B414A168BA;
	Tue, 28 Nov 2023 08:15:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54D89C433CB;
	Tue, 28 Nov 2023 08:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701159324;
	bh=e1PcYzYbTNGpVaCcrOSsdIFbJOZYRYBf4r0j5u1WFhE=;
	h=From:To:Cc:Subject:Date:From;
	b=PnNpAEzkB5uqEBeZm9QHP9op3cULwxXdOCDWsdgloE72TTyngsnpeQaqHd4ea6/wt
	 rBPumlRF9D3096Yp4PlPDqbmZ6lrflrLcD+r44/0TwQ8xl/OZ1O4j//pRgMFOMCL6s
	 m+csegl+47y24fwx5C5bo3vzd8Z7Y7OxMXuIAyjoc+9EHVkc5y7CTh4IVAfsFfwt0M
	 dFz+LYyFTZh7Y5xSXgiZpn7uYwL9jBBIJKr8sjUb0A7IVHFfW97Wuy9Mtk1TfpJ0uT
	 uJ0Gf3jDknuXwjEsGwu/6kDsabz0txTwpNLrBJ6YR+s3WbwQXDO+236Ab+EXckBvTQ
	 AlGGVsNA8QdnQ==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan+linaro@kernel.org>)
	id 1r7tG3-00053n-2I;
	Tue, 28 Nov 2023 09:15:52 +0100
From: Johan Hovold <johan+linaro@kernel.org>
To: "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	"Bjorn Helgaas" <bhelgaas@google.com>
Cc: Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v2 0/6] PCI: Fix deadlocks when enabling ASPM
Date: Tue, 28 Nov 2023 09:15:06 +0100
Message-ID: <20231128081512.19387-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pci_enable_link_state() helper is currently only called from
pci_walk_bus(), something which can lead to a deadlock as both helpers
take a pci_bus_sem read lock.

Add a new locked helper which can be called with the read lock held and
fix up the two current users (the second is new in 6.7-rc1).

Note that there are no users left of the original unlocked variant after
this series, but I decided to leave it in place for now (e.g. to mirror
the corresponding helpers to disable link states).

Included are also a couple of related cleanups.

Johan


Changes in v2
 - fix up the function name in a kernel doc comment as reported by the
   kernel test robot <lkp@intel.com>


Johan Hovold (6):
  PCI/ASPM: Add locked helper for enabling link state
  PCI: vmd: Fix deadlock when enabling ASPM
  PCI: qcom: Fix deadlock when enabling ASPM
  PCI: qcom: Clean up ASPM comment
  PCI/ASPM: Clean up disable link state parameter
  PCI/ASPM: Add lockdep assert to link state helper

 drivers/pci/controller/dwc/pcie-qcom.c |  7 ++-
 drivers/pci/controller/vmd.c           |  2 +-
 drivers/pci/pcie/aspm.c                | 65 +++++++++++++++++++-------
 include/linux/pci.h                    |  3 ++
 4 files changed, 56 insertions(+), 21 deletions(-)

-- 
2.41.0


