Return-Path: <linux-pci+bounces-9715-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 401CF92581E
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2024 12:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71A001C25AEC
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2024 10:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B65715CD41;
	Wed,  3 Jul 2024 10:12:58 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707B115DBAE;
	Wed,  3 Jul 2024 10:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720001577; cv=none; b=TB4hhbca3QTKpChJjFE8zBSjgCurTTxNMYf6z6KC3x8y5Khv/mNv4QzI1L47EYP1RAlPZfB3ieN6o7EPsdnh4YKfGDeu1si9euyCPIDM990gxe9kDZddP1Qt1v3/FhbVmvJ1DA3J/jWZzSpS8IDvyQ6Qw8uOgYoObgTxteKWKd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720001577; c=relaxed/simple;
	bh=VAkMMq38BLEp16vE1AIo1HZG4UhT6HnMZCM8w6alvZg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fbfejVgG7rxRsOekYUvJW79YPxJ4L/9WFpBK7A7z9xhTuuISIOOQeXzrTT8+Cz7W1aEft+AHS/rm3fRgwHh1hUIAcd78sYbgzKYege7GKeEc5CnNEY7XZ/q5gEJoIJeGqIJcRHDLOe+T7hAb5oJ2SV7KX4uJuumOM5vVgmpFEPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-IronPort-AV: E=Sophos;i="6.09,181,1716217200"; 
   d="scan'208";a="214108788"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 03 Jul 2024 19:12:48 +0900
Received: from localhost.localdomain (unknown [10.166.13.99])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 88A1C4006DEB;
	Wed,  3 Jul 2024 19:12:48 +0900 (JST)
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
Subject: [PATCH] PCI: rcar-gen4: Add a document about the firmware
Date: Wed,  3 Jul 2024 19:12:43 +0900
Message-Id: <20240703101243.1403231-1-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Renesas R-Car V4H (r8a779g0) has PCIe controller, and it requires
specific firmwre downloading. So, add a document about the firmware
how to get.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 Krzysztof-san suggests writing a document about this [1]. So, I submit
 this patch.

 [1]
 https://lore.kernel.org/linux-pci/20240701204333.GB412915@rocinante/

 .../admin-guide/rcar-pcie-firmware.rst        | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/admin-guide/rcar-pcie-firmware.rst

diff --git a/Documentation/admin-guide/rcar-pcie-firmware.rst b/Documentation/admin-guide/rcar-pcie-firmware.rst
new file mode 100644
index 000000000000..75c0d086dcc5
--- /dev/null
+++ b/Documentation/admin-guide/rcar-pcie-firmware.rst
@@ -0,0 +1,20 @@
+Firmware of PCIe controller for Renesas R-Car V4H
+=================================================
+
+Renesas R-Car V4H (r8a779g0) has PCIe controller, and it requires specific
+firmwre downloading. The firmware file "104_PCIe_fw_addr_data_ver1.05.txt"
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


