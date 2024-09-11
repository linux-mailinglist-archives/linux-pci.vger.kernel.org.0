Return-Path: <linux-pci+bounces-13045-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 139ED975703
	for <lists+linux-pci@lfdr.de>; Wed, 11 Sep 2024 17:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97EDA1F23F3C
	for <lists+linux-pci@lfdr.de>; Wed, 11 Sep 2024 15:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CCB61ABED4;
	Wed, 11 Sep 2024 15:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tgZUt2Gp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA45C1AB6C6;
	Wed, 11 Sep 2024 15:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726068390; cv=none; b=ubngfCwidDzcL0Jp6dIs05luyvIOI7Jc8jvKEheMHTMWKjAfXZ3J6MasW+AxLU6E+FAUQbSsIr3+MlffOznnmgbEIOGNtIY8F6+0HEI8tJQlg80BzKHnf1bheZ7J57w4ioXUXgxUUiSDTNGjuvBIBbHCOI4DM38tzs5NUMkP7QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726068390; c=relaxed/simple;
	bh=ySbiEt3ATot0IO6ukCbLnsXhtNtXL/Guqo5EQ5kc+vU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=V5hdBfanY3JNEr7Of8JPFs3lOCxQHUz46qZlZ/21OFWD5m/DdlazxYUIxyshaGL6JNWeSJVMAUP9hvYiRpxA2U8XXIuk5ZC5zW4K6Ovxep7DDXLM4XqSzodmZbrqymuPwxk7dMTqHNquzT0oxPrHDxUw8d+ixc5d1Yln6tpD9Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tgZUt2Gp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3B91EC4CEC0;
	Wed, 11 Sep 2024 15:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726068390;
	bh=ySbiEt3ATot0IO6ukCbLnsXhtNtXL/Guqo5EQ5kc+vU=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=tgZUt2GpwqvGKS8TVUDJgwk2znhaYjDppzRhhC1rESibZwxWXWmC/9K8la/KxGTgs
	 PQJFV88220I30DP3gUnlDe+DQ5ZuSqQqzZp9849QAT6ewKpQfTiZHfUBwIhqzsIGVv
	 jkvHNRImk1gFNC4PXrHrMyTAjbipQWpvKzPRZ7qiEmkSjznJr+/PDUVNgBo5VlbjHF
	 0QfYnA3nMkYNwZqX9ZBN6JafRdKL3TDsmVJe+Px+csnzJajmRmYsCWsnGnFHDqygoQ
	 RQmX1T9e25Jt0L8v5FQ1GSxPCOgO3LbHfIfKIIH3uv2ejmNdr+0fq1xa8mlfWulQG2
	 4NMtby9jeU7FQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E02FEE0213;
	Wed, 11 Sep 2024 15:26:30 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Subject: [PATCH v7 0/4] PCI: qcom: Add 16.0 GT/s equalization and margining
 settings
Date: Wed, 11 Sep 2024 20:56:25 +0530
Message-Id: <20240911-pci-qcom-gen4-stability-v7-0-743f5c1fd027@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKG24WYC/4WNQQ7CIBBFr9LM2jGEIk1deQ/TBeJAJ6lQgTQ2T
 e8u9gIu30v++xtkSkwZrs0GiRbOHEOF7tSAHU3whPysDFJIJXqhcLaMbxtf6CkozMU8eOKyopB
 k9cV0pElBXc+JHH+O8n2oPHIuMa3H0aJ/9n9z0SiQbNu7zlDrtLxNHEyK55g8DPu+fwGZ1S6ev
 wAAAA==
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
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 Pratyush Anand <pratyush.anand@gmail.com>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 abel.vesa@linaro.org, johan+linaro@kernel.org, 
 Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>, 
 linux-tegra@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2886;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=ySbiEt3ATot0IO6ukCbLnsXhtNtXL/Guqo5EQ5kc+vU=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBm4baiuGrwKvXu8Vn7676IMqAa3SnFAiqeGWP15
 rRv9Ot+Y++JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZuG2ogAKCRBVnxHm/pHO
 9UAfB/wJn1xjr7gpcV5/74TYwbz4d8AOHHZh693NV+oSlBCpL1toQgQA6Abx1BqGLKNL0IlJY/L
 rKzJQhYDg8Dfz/eoLnJzC+bJmxV9Wtj8pbu2tmzKMCT8OrsclFUjUQVzr5JfOB3XHP2YmrUj0iw
 OiIhvy8iI7GZ2Ju8zl9rz8boWOjblFZ/gsk29ZJHdsJNprELyoa9F/PXGYb8piL6/7GqidWpwGY
 UboBRSx/kcLZVbCcPVI6TC/NYBpy7puAdX28RpatQCTJ3KL1164J9ColLZfAdepBd+PgFan4SiB
 mzDQ73C3/r3ohaO47FhOVVKgNaYDfuKWy45U2RZLtyJRJPtC
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

Changes in v7:
- Fixed the build issue reported by Kbuild bot in patch 1/4
- Changed the logic to check invalid max_link_speed in patch 2/4
- Cleanups to patches 3/4 and 4/4 as suggested by Johan
- Added include header guard to pci-qcom-common.h
- Link to v6: https://lore.kernel.org/r/20240904-pci-qcom-gen4-stability-v6-0-ec39f7ae3f62@linaro.org

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
      PCI: qcom: Add RX lane margining settings for 16.0 GT/s

 MAINTAINERS                                   |  4 +-
 drivers/pci/controller/dwc/Kconfig            |  5 ++
 drivers/pci/controller/dwc/Makefile           |  1 +
 drivers/pci/controller/dwc/pci-imx6.c         |  8 +--
 drivers/pci/controller/dwc/pcie-designware.c  | 22 +++++---
 drivers/pci/controller/dwc/pcie-designware.h  | 33 +++++++++++-
 drivers/pci/controller/dwc/pcie-intel-gw.c    |  4 +-
 drivers/pci/controller/dwc/pcie-qcom-common.c | 78 +++++++++++++++++++++++++++
 drivers/pci/controller/dwc/pcie-qcom-common.h | 14 +++++
 drivers/pci/controller/dwc/pcie-qcom-ep.c     |  6 +++
 drivers/pci/controller/dwc/pcie-qcom.c        |  6 +++
 drivers/pci/controller/dwc/pcie-rcar-gen4.c   |  6 +--
 drivers/pci/controller/dwc/pcie-spear13xx.c   |  2 +-
 drivers/pci/controller/dwc/pcie-tegra194.c    | 19 +++----
 14 files changed, 178 insertions(+), 30 deletions(-)
---
base-commit: 47ac09b91befbb6a235ab620c32af719f8208399
change-id: 20240904-pci-qcom-gen4-stability-02ec65a7e6e4

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>



