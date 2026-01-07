Return-Path: <linux-pci+bounces-44140-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE47CFC8F5
	for <lists+linux-pci@lfdr.de>; Wed, 07 Jan 2026 09:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1EBE93012DDB
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jan 2026 08:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145DB2848BA;
	Wed,  7 Jan 2026 08:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f1djI+os"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00DA2571A0;
	Wed,  7 Jan 2026 08:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767773521; cv=none; b=TETHoj3ABl7VQjmoywxu9ly8ZzUXF8iZrN9FCUxlgoJ1vIGO+0g9o3bj6js1QOj+JtqqnuoEYStCOBGrgZ/pFcfmrdL5l+u8udlCp+gvkkt5gji4ly+cm5Qn0TWzG5+PXWcgqVVDbwyd2MwjdWaxrI/KShb8KRfbHmmCUIZGRuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767773521; c=relaxed/simple;
	bh=o9pWIvqMlzb/PHzIzRlxl4DrSd1mVj3lgO+vQNtuY74=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=X4YEiA24CmSa7cHoq2EMCirDV85p0jzWBPhxu64khSw+fXZ73GucaI8HYOAex5d1fj32y7gwzVSLTN7fC8293TElt0ewgm6e9fG1aUzaogr1B8aXv1A8O2s1e79DcyGb5rGG9JwhUK/FPRUSfU0CCNz79RGu/BUBpDYH+K2YSLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f1djI+os; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 76B49C19421;
	Wed,  7 Jan 2026 08:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767773520;
	bh=o9pWIvqMlzb/PHzIzRlxl4DrSd1mVj3lgO+vQNtuY74=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=f1djI+os7+L3WVppHiRgggyqybdMGDTUn/UMaPpaHFypSxQm6YOxDcdFd/A9oa27A
	 faPRLD+FGw+X5z7bVQtyOnMkyy5S8n4yttisr1RnBxIIREa2jDUdM/t/X8yQK1RCbJ
	 9vvkkZYlX99u7dZM4z7AhbLp1BnonIS6aL+FItZeOIA+ZMXkcvbUqap0G6vdJuKk/5
	 fO7LgtU8JHy3dQLOFikw3hCMipjyf3Ov2t/56ALmQclGzIhD9FlVaRqfxeRRqkwnM3
	 6ByZdm5Jmx8SxKAF0m2go9EHhyHVUu2oL3fi8FwLggshryIVTcOSKAdJ/RSFCkB29K
	 6HeN4eHLP9moA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60718CF6BFD;
	Wed,  7 Jan 2026 08:12:00 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Subject: [PATCH v4 0/6] PCI: dwc: Rework the error handling of
 dw_pcie_wait_for_link() API
Date: Wed, 07 Jan 2026 13:41:53 +0530
Message-Id: <20260107-pci-dwc-suspend-rework-v4-0-9b5f3c72df0a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEkVXmkC/4XNSw7CIBCA4as0rMUwPAp15T2MCwRqibZUsFVje
 nepG13YuJnkn2S+eaLkoncJbYonim70yYcuB18VyDS6OzrsbW5ECRUAUOHeeGxvBqch9a6zOLp
 biCesDkSA0EyVskL5uI+u9vc3vNvnbny6hvh4/xlh3v4lR8AEa22BcEWVKOk2pLS+DPpsQtuu8
 0CzPNKPRkEtajRrQksplSlJxfWCxr40RhY1ljVOjOVKSOC1+KFN0/QCXt3C5F8BAAA=
X-Change-ID: 20251119-pci-dwc-suspend-rework-8b0515a38679
To: Jingoo Han <jingoohan1@gmail.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 vincent.guittot@linaro.org, zhangsenchuan@eswincomputing.com, 
 Shawn Lin <shawn.lin@rock-chips.com>, Richard Zhu <hongxing.zhu@nxp.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2748;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=o9pWIvqMlzb/PHzIzRlxl4DrSd1mVj3lgO+vQNtuY74=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpXhVNnNFpj8UPDghdOiSSpSpX3YCWrYv2ZUBJ9
 cKkV/0gk7+JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaV4VTQAKCRBVnxHm/pHO
 9a38B/4z5YcOBkBsZ7y1lk6E/lID3aXAxRJA/h1wexQej17UYQLmOifbj1FEXBlMkpEqmVogflS
 QO/FrQnb0GI5v+W6HnYllgISXCLRh+neQRh/zhiOKmaOvnH8Lk9Y3QqOAztKXD0piAk46tUtwUt
 6GsETJ1ST6znGPo1OdikleRYRowXxpd2nI0nyFeNonUPKcGJbVnojIQ7b156AzB4qMN7AP0UtRz
 PYOar6qI6R7mihXA0mwmpTcQIDizb2fIbPuNTlMK5ihZLkViYcwL3vBDy2NhbaEIu4U1/UN49kA
 WEsbjuR/hMNEBrn5dYrQkLBXy19sGauXYBipaKFmZFq+/yi7
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

Hi,

This series reworks the dw_pcie_wait_for_link() API to allow the callers to
detect the absence of the device on the bus and skip the failure.

Compared to v2, I've reworked the patch 2 to improve the API further and
dropped the patch 1 that got applied (hence changed the subject). I've also
modified the error code based on the feedback in v2 to return -ENODEV if device
is not detected on the bus and -ETIMEDOUT otherwise. This allows the callers to
skip the failure if device is not detected and handle error for other failure.

Testing
=======

Tested this series on Rb3Gen2 board without powering on the PCIe switch. Now the
dw_pcie_wait_for_link() API prints:

	qcom-pcie 1c08000.pcie: Device not found

Instead of the previous log:

	qcom-pcie 1c08000.pcie: Phy link never came up

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
Changes in v4:
- Skipped returning failure during resume as well if no device is found
- Link to v3: https://lore.kernel.org/r/20251230-pci-dwc-suspend-rework-v3-0-40cd485714f5@oss.qualcomm.com

Changes in v3:
- Dropped patch 1 that got appplied
- Reworked the error handling of dw_pcie_wait_for_link() API further
- Link to v2: https://lore.kernel.org/r/20251218-pci-dwc-suspend-rework-v2-0-5a7778c6094a@oss.qualcomm.com

Changes in v2:
- Changed the logic to check for Detect.Quiet/Active states
- Collected tags and rebased on top of v6.19-rc1
- Link to v1: https://lore.kernel.org/r/20251119-pci-dwc-suspend-rework-v1-0-aad104828562@oss.qualcomm.com

---
Manivannan Sadhasivam (6):
      PCI: dwc: Return -ENODEV from dw_pcie_wait_for_link() if device is not found
      PCI: dwc: Rename and move ltssm_status_string() to pcie-designware.c
      PCI: dwc: Rework the error print of dw_pcie_wait_for_link()
      PCI: dwc: Only skip the dw_pcie_wait_for_link() failure if it returns -ENODEV
      PCI: host-common: Add an API to check for any device under the Root Ports
      PCI: dwc: Skip failure during dw_pcie_resume_noirq() if no device is available

 .../pci/controller/dwc/pcie-designware-debugfs.c   | 54 +---------------
 drivers/pci/controller/dwc/pcie-designware-host.c  | 23 +++++--
 drivers/pci/controller/dwc/pcie-designware.c       | 75 +++++++++++++++++++++-
 drivers/pci/controller/dwc/pcie-designware.h       |  2 +
 drivers/pci/controller/pci-host-common.c           | 21 ++++++
 drivers/pci/controller/pci-host-common.h           |  2 +
 6 files changed, 115 insertions(+), 62 deletions(-)
---
base-commit: 68ac85fb42cfeb081cf029acdd8aace55ed375a2
change-id: 20251119-pci-dwc-suspend-rework-8b0515a38679

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>



