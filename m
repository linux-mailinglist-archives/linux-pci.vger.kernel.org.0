Return-Path: <linux-pci+bounces-9720-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BA79258CA
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2024 12:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9034028DB78
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2024 10:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB91175560;
	Wed,  3 Jul 2024 10:29:41 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B466E17B4F2;
	Wed,  3 Jul 2024 10:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720002581; cv=none; b=j+KPlKS9jPae+Lp81uiHbVHtoyEZaFCKQz4+uCMEd8i4+WXHh65uEtwi41f2WsltQg/rIsYwx1pWWi4LgGWQj6tL6pXUH3Un2owvgJeCUDNNcSTj8P67ezxEXFkMOgWKsgfZ7JElEzIstK9Be4MbBWDSKYTjv3OFmFmN2s+zk6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720002581; c=relaxed/simple;
	bh=QSJdiEcW5SXGKcznPl0H1vIMPw7Qdbdg4AMWz2sBPmo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sYUKQUPyO20EIdDG3IHSTNtwI+/b9jwjI9qTyANRnZqC+HRvzV/DCTHik75nz6ZWcpoms8zRzx9iLRX6JPkN1JGbviH5UkNvFMSkSgzuo/S3SS5YsrzlTMUNOYWoT4VLm1+qYRsqklsy8hoAMybjRlPgwwYeQvgwZDQYBNK8wGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-IronPort-AV: E=Sophos;i="6.09,181,1716217200"; 
   d="scan'208";a="214110077"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 03 Jul 2024 19:29:38 +0900
Received: from localhost.localdomain (unknown [10.166.13.99])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 979D542EE34C;
	Wed,  3 Jul 2024 19:29:38 +0900 (JST)
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: lpieralisi@kernel.org,
	kw@linux.com,
	robh@kernel.org,
	bhelgaas@google.com,
	jingoohan1@gmail.com,
	mani@kernel.org
Cc: marek.vasut+renesas@gmail.com,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v2] PCI: rcar-gen4: Add a document about the firmware
Date: Wed,  3 Jul 2024 19:29:37 +0900
Message-Id: <20240703102937.1403905-1-yoshihiro.shimoda.uh@renesas.com>
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
 Changes from v1:
 https://lore.kernel.org/linux-pci/20240703101243.1403231-1-yoshihiro.shimoda.uh@renesas.com/
 - Fix typos in both the commit description and the document.

 .../admin-guide/rcar-pcie-firmware.rst        | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/admin-guide/rcar-pcie-firmware.rst

diff --git a/Documentation/admin-guide/rcar-pcie-firmware.rst b/Documentation/admin-guide/rcar-pcie-firmware.rst
new file mode 100644
index 000000000000..425ad5b7e4ad
--- /dev/null
+++ b/Documentation/admin-guide/rcar-pcie-firmware.rst
@@ -0,0 +1,20 @@
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


