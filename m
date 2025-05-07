Return-Path: <linux-pci+bounces-27366-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66282AADC3D
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 12:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2E8916DE99
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 10:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEEDC202981;
	Wed,  7 May 2025 10:09:57 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988CD76410;
	Wed,  7 May 2025 10:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746612597; cv=none; b=EMNNU8x/ZAuUNlVkRFIjcO5Q1kjNyoGht6fMKd4JHtrgW9iEzBqRYX4ykEjVyy9zcJ946gQ0K9H6kYMW4PEdFHRNqg48Pzl3lxsMxSuRbN1P6JdJDhSgyJDoGceli1ALkd3GM7TH/M/TgezYpGkcGzO0rNEo/HGcnvAuiQBaE6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746612597; c=relaxed/simple;
	bh=4h0ZeCeRObeEAP2gy15U8n700pgijptTrEPrSHg8fNo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TG0ToKVwyqi6llmU4na6xHLqNG0rg++h4O1aGquReTFN/7RE0fzlmFSyM6k1czLscTC8t9+I0lwUzbsGN+wAVWVm6HmSY+xp4eBeDilbp6R2flcQQFQvPXTvW1I5ZOdjbAwHsCH3VRROt9d46NYknxaFc9qlGtOnEsLCfL7VJuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: HPPRNoxiQEO/pXOmyEem9w==
X-CSE-MsgGUID: 5Sfs3iE3RGi42CsSmcvoqw==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 07 May 2025 19:09:52 +0900
Received: from localhost.localdomain (unknown [10.166.13.99])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id E53BD401A459;
	Wed,  7 May 2025 19:09:52 +0900 (JST)
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: bhelgaas@google.com,
	corbet@lwn.net
Cc: manivannan.sadhasivam@linaro.org,
	marek.vasut+renesas@gmail.com,
	linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v4] PCI: rcar-gen4: Add a document about the firmware
Date: Wed,  7 May 2025 19:09:47 +0900
Message-Id: <20250507100947.608875-1-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Renesas R-Car V4H (r8a779g0) has PCIe controller, and it requires
specific firmware downloading. So, add a document about the firmware
how to get.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
Changes from v3:
https://lore.kernel.org/linux-pci/20241024120525.291885-1-yoshihiro.shimoda.uh@renesas.com/
 - Rebase on v6.15-rc1.
 - Revise some descriptions (reviewed from Manivannan Sadhasivam).
 - Add the doc file entry into the MAINTAINER.

Changes from v2:
https://lore.kernel.org/linux-pci/20240703102937.1403905-1-yoshihiro.shimoda.uh@renesas.com/
 - Rebase on v6.12-rc1.
 - Move the document file on Documentation/PCI/.
 - Add SPDX-License-Identifier.

 Documentation/PCI/rcar-pcie-firmware.rst | 24 ++++++++++++++++++++++++
 MAINTAINERS                              |  1 +
 2 files changed, 25 insertions(+)
 create mode 100644 Documentation/PCI/rcar-pcie-firmware.rst

diff --git a/Documentation/PCI/rcar-pcie-firmware.rst b/Documentation/PCI/rcar-pcie-firmware.rst
new file mode 100644
index 0000000000000..0e285c4a7cd72
--- /dev/null
+++ b/Documentation/PCI/rcar-pcie-firmware.rst
@@ -0,0 +1,24 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=================================================
+Firmware of PCIe controller for Renesas R-Car V4H
+=================================================
+
+Renesas R-Car V4H (r8a779g0) has PCIe controller, and it requires specific
+firmware downloading. The firmware file "104_PCIe_fw_addr_data_ver1.05.txt"
+is available in the datasheet as a text file. But, Renesas is not able to
+distribute the firmware freely. So, it is required to convert the text file
+to a binary, and the binary should be placed in /lib/firmware before
+the driver runs by using the following script:
+
+.. code-block:: sh
+
+   $ awk '/^\s*0x[0-9A-Fa-f]{4}\s+0x[0-9A-Fa-f]{4}/ \
+   { print substr($2,5,2) substr($2,3,2) }' \
+   104_PCIe_fw_addr_data_ver1.05.txt | xxd -p -r > \
+   rcar_gen4_pcie.bin
+
+   $ sha1sum rcar_gen4_pcie.bin
+
+   # Example output of the sha1sum:
+   1d0bd4b189b4eb009f5d564b1f93a79112994945  rcar_gen4_pcie.bin
diff --git a/MAINTAINERS b/MAINTAINERS
index 1ccb83716bf28..9ad5c565595d5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18531,6 +18531,7 @@ M:	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
 L:	linux-pci@vger.kernel.org
 L:	linux-renesas-soc@vger.kernel.org
 S:	Maintained
+F:	Documentation/PCI/rcar-pcie-firmware.rst
 F:	Documentation/devicetree/bindings/pci/*rcar*
 F:	drivers/pci/controller/*rcar*
 F:	drivers/pci/controller/dwc/*rcar*
-- 
2.25.1


