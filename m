Return-Path: <linux-pci+bounces-15195-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B8D9AE461
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 14:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 522A028487F
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 12:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781581C9B87;
	Thu, 24 Oct 2024 12:05:53 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E3F1D1729;
	Thu, 24 Oct 2024 12:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729771553; cv=none; b=o9c7a5JG7SoYjObOytPe9YhpGl4HbCKt+zmeMNfxEIwVGeB3k7t84bz1GOlr2FmIVysuMktHKx4RU+j+O8FxFJ8X8JtNUhB3YkTlm22WdC4KcIzK/a98ZqAGrk8dLaycWr1tj/z+GZsvC/yT5CbUcS/X/6XBj9mliPPiRq84/GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729771553; c=relaxed/simple;
	bh=OVZGWlryFFcfxKdnhUmLDS5/atu4GdzNMq13xRAxjok=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rHL8I5sD0tpgOBkXidOaNdGkBlRV6uEGinKfhn/dA3t4Rt51vIl3uSWSmQRjHdTUncxJXRoSi8dRG7W7Vg4pBUfwaJoMaS2OCM8FajY7K23GaSGeXjymLyLU+LNJuwb6JVv/bgHmm9TEbvg0wqLFnWhnGtZwDqZVMhRZBEYPDJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-IronPort-AV: E=Sophos;i="6.11,229,1725289200"; 
   d="scan'208";a="222891426"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 24 Oct 2024 21:05:41 +0900
Received: from localhost.localdomain (unknown [10.166.13.99])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 98BFD400855B;
	Thu, 24 Oct 2024 21:05:30 +0900 (JST)
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: bhelgaas@google.com,
	jingoohan1@gmail.com
Cc: linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v3] PCI: rcar-gen4: Add a document about the firmware
Date: Thu, 24 Oct 2024 21:05:25 +0900
Message-Id: <20241024120525.291885-1-yoshihiro.shimoda.uh@renesas.com>
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
Changes from v2:
https://lore.kernel.org/linux-pci/20240703102937.1403905-1-yoshihiro.shimoda.uh@renesas.com/
 - Rebase on v6.12-rc1.
 - Move the document file on Documentation/PCI/.
 - Add SPDX-License-Identifier.

Changes from v1:
https://lore.kernel.org/linux-pci/20240703101243.1403231-1-yoshihiro.shimoda.uh@renesas.com/
 - Fix typos in both the commit description and the document.

 
 Documentation/PCI/rcar-pcie-firmware.rst | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/PCI/rcar-pcie-firmware.rst

diff --git a/Documentation/PCI/rcar-pcie-firmware.rst b/Documentation/PCI/rcar-pcie-firmware.rst
new file mode 100644
index 000000000000..0d8a87ce9aa9
--- /dev/null
+++ b/Documentation/PCI/rcar-pcie-firmware.rst
@@ -0,0 +1,23 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=================================================
+Firmware of PCIe controller for Renesas R-Car V4H
+=================================================
+
+Renesas R-Car V4H (r8a779g0) has PCIe controller, and it requires specific
+firmware downloading. The firmware file "104_PCIe_fw_addr_data_ver1.05.txt"
+is available in the datasheet as a text file. But, Renesas is not able to
+distribute the firmware freely. So, we require converting the text file to
+a binary before the driver runs by using the following script:
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
-- 
2.25.1


