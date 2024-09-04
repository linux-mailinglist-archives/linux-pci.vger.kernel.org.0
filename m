Return-Path: <linux-pci+bounces-12718-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A0C96B275
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 09:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50AE9B25DC8
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 07:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592F8145FEB;
	Wed,  4 Sep 2024 07:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FnRwcbBO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2257083CA3;
	Wed,  4 Sep 2024 07:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725433922; cv=none; b=If82lOvlQjZpRQeEc5EO9jzGOazW/lfQxGEHuup7CPuP/YlOBBueXUDRWqnni31vJBbVKV/adGFD64ryhGC7uE5e9d96OCoUaKp7jnRqC0WyOqQjKzMHPQLPC+h1B6plwxUOs6o3wbJK9DHp8k0rjgYJBZj5Ew1o1RLf2l/5MzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725433922; c=relaxed/simple;
	bh=cLb2NYLXwStX/LKCjvnBpOqyb4PG6V2tb9fd5zD3pBU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=k/FD6cwmDCaRINPpmsaDmb5/tyi+hgMvd4igt5ksbNPywjG/NhwQos8a91gzilbYNWIp2/qAhyoVgEN1QwojUQc42Mtl0UVjPOyk4GH/jO4+d7ygf8uOy+XnzC2kDFjuN8GjbACAn4JTl33cr61ceeHnVu758toGDAjz8d+Fi+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FnRwcbBO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D62EDC4CEC8;
	Wed,  4 Sep 2024 07:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725433921;
	bh=cLb2NYLXwStX/LKCjvnBpOqyb4PG6V2tb9fd5zD3pBU=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=FnRwcbBO4efSleljAkNSmQi1LC5M8d4zWKC0RG/Q27KGaSkGyodJ6cKG3CpdKsOIk
	 /YDToeGOoyVHdQMa+YJIyspFgawDMeV6dGIxaocEqM39c9qfhbF4I7tdCmUrpjKd4m
	 JpNS6bh7yoTMvM/7hHc8RULo4aGUcTmFDpWGpG0KLxyKJzFYUPyl6CeDFCdvMP2o9r
	 BuS3R88yGeXpa2czuGxdEoEsj5qfoXDTxv3xNW7e/Iic6CbtrKuUHagIBfW1IRIgB8
	 MWZlC+1oTibAUsTiF40APdpECEBnvGB4XYDLq/bvrWwTS6w2EgGxFfJxttH930Q9sP
	 vym3NL4vZmx9g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB5ACD3431;
	Wed,  4 Sep 2024 07:12:01 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Subject: [PATCH v6 0/4] PCI: qcom: Add 16.0 GT/s equalization and margining
 settings
Date: Wed, 04 Sep 2024 12:41:56 +0530
Message-Id: <20240904-pci-qcom-gen4-stability-v6-0-ec39f7ae3f62@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADwI2GYC/x3MQQqDMBBG4avIrDsQQoy0VykuYvy1A23UJIgiu
 buhy2/x3kUJUZDo1VwUsUuSJVTYR0P+48IMlrGatNJGPZXh1QtvfvnxjGA4ZTfIV/LJSsPb1nW
 wMFTrNWKS439+96Xccvbe6WkAAAA=
To: Richard Zhu <hongxing.zhu@nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Jingoo Han <jingoohan1@gmail.com>, 
 Chuanhua Lei <lchuanhua@maxlinear.com>, 
 Marek Vasut <marek.vasut+renesas@gmail.com>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 abel.vesa@linaro.org, johan+linaro@kernel.org, 
 Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2406;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=cLb2NYLXwStX/LKCjvnBpOqyb4PG6V2tb9fd5zD3pBU=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBm2Ag+yXw76QSloqji0A8dUGvbGecOjKDwzo19V
 gChmcyzYReJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZtgIPgAKCRBVnxHm/pHO
 9QBoB/40W7x6SSRfFEQvwB1+Lx05sntI/Ecem96LKwXC0adZ62tG7DZcnlrBOHu/Yv/gMxxLb4K
 hr2epksRdMTtqaQ0nDTXn+3oiwA0Q9WEzst3bydA7yMtYLRcJa0+BfLsc28z58fEHTA2Zojogcg
 kaCDyFsjo6vwzuD+eE7PWgFtMJGMAjXfb2XcMnolL9RJirnLZ1bZfZjW/5AJ2iwHPkCUsMvqaFP
 n6ibN4qXxgfXODKqbUrvqbDUDQWcbYJvfqQxMt8nn0QaaxmgmJrIKXBapriYTb4bY+xkQczG8Ih
 Rds1yh9PZCYFNVq++7Z/H/svXcvpMEk0K9hOzny43boAID1f
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@linaro.org/default with auth_id=185
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reply-To: manivannan.sadhasivam@linaro.org

Hi,

This series adds 16.0 GT/s specific equalization and RX lane margining settings
to the Qcom RC and EP drivers. This series is mandatory for the stable operation
of the PCIe link at 16.0 GT/s on the Qcom platforms.

NOTE:
=====

I've taken over the series from Shashank based on the discussion [1]. In order
to apply the equalization/margining settings properly in the Qcom driver, I
added the first 2 patches to the series which inevitably touches other vendor
drivers also.

- Mani

Changes in v6:

- Dropped the code refactoring patch as suggested by Johan
- Added 2 patches to fix the caching of maximum supported link speed value that
  is needed to apply the equalization/margining settings
- Updated the commit message of patch 3 as per Bjorn's suggestion

For previous changelogs, please refer [2]

[1] https://lore.kernel.org/linux-pci/af65b744-7538-4929-9ab4-8ee42e17b8d1@quicinc.com/
[2] https://lore.kernel.org/linux-pci/20240821170917.21018-1-quic_schintav@quicinc.com/

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
Manivannan Sadhasivam (2):
      PCI: dwc: Rename 'dw_pcie::link_gen' to 'dw_pcie::max_link_speed'
      PCI: dwc: Always cache the maximum link speed value in dw_pcie::max_link_speed

Shashank Babu Chinta Venkata (2):
      PCI: qcom: Add equalization settings for 16.0 GT/s
      PCI: qcom: Add RX margining settings for 16.0 GT/s

 MAINTAINERS                                   |  4 +-
 drivers/pci/controller/dwc/Kconfig            |  5 ++
 drivers/pci/controller/dwc/Makefile           |  1 +
 drivers/pci/controller/dwc/pci-imx6.c         |  8 +--
 drivers/pci/controller/dwc/pcie-designware.c  | 22 +++++---
 drivers/pci/controller/dwc/pcie-designware.h  | 32 ++++++++++-
 drivers/pci/controller/dwc/pcie-intel-gw.c    |  4 +-
 drivers/pci/controller/dwc/pcie-qcom-common.c | 76 +++++++++++++++++++++++++++
 drivers/pci/controller/dwc/pcie-qcom-common.h |  9 ++++
 drivers/pci/controller/dwc/pcie-qcom-ep.c     |  6 +++
 drivers/pci/controller/dwc/pcie-qcom.c        |  6 +++
 drivers/pci/controller/dwc/pcie-rcar-gen4.c   |  6 +--
 12 files changed, 162 insertions(+), 17 deletions(-)
---
base-commit: 47ac09b91befbb6a235ab620c32af719f8208399
change-id: 20240904-pci-qcom-gen4-stability-02ec65a7e6e4

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>



