Return-Path: <linux-pci+bounces-44146-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D4ADACFC8B5
	for <lists+linux-pci@lfdr.de>; Wed, 07 Jan 2026 09:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5302430011BD
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jan 2026 08:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41942701DC;
	Wed,  7 Jan 2026 08:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1LICu/u"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C2127FB26
	for <linux-pci@vger.kernel.org>; Wed,  7 Jan 2026 08:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767773695; cv=none; b=LWDIYjdmvrsX5BT4FnS8ahqi0QKgk4TUa6yovBR7d6vTB/0MC2Egot/yqYkaGpPMwYoEbrsMAUWYF/r7JlaeGI2kDuIeSR3UF/tI5CFmAXFxfM2ZfY6MpCjDWhJ80yF9xlImO3s99jEnwzBv3FbIiL6WMk/hD7Tgtc7j/njM8J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767773695; c=relaxed/simple;
	bh=KDj106qciwLowDj4mUAUGHujSOR3nPmg0elS/LP/TXM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D60yuc5cZb0ceRFE5Whv/MuPcXw9RYy5AWj/66FuZPH7M8GC8bRgEwzmM7pdn6nFNx+qS0HeuZjT/as7KWcR6JUXYrQAtcLRrMnHfC7W6tUyKLtDEca/1vHzrokR7gs3SUCnaVgmMY/32r7XTcxHDXWmw/nH0cQHRsmXkGIaUTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a1LICu/u; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a0f3f74587so18157605ad.2
        for <linux-pci@vger.kernel.org>; Wed, 07 Jan 2026 00:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767773694; x=1768378494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bskqrEZI3mWJPk0/2+jknOdH1/nKT2h7hO8FoQ5vtvY=;
        b=a1LICu/uO2HEBQBb5x4V20Ikhimw3F500m7QXtF88BVPf47sKg63t2QWOjQSlNmS29
         JSUxxGbjdqibAesMH9MYqcJP9asFX54mOVhBdqUowlDAnncZz6VEkYzYJCknA/4Og8GZ
         N4B/zx0xZGFxfURIdYpvZHZWCm5T+CLCIW62XnWZ+KchBF2CmA7f3eEiPwH5dBcCvOSq
         CHVjA73QlWj234U5OCOwBuzLPr9YGRsfTyuW0ShaRST+JDFBlTzVDywcpreoq1eZTteU
         VOEvReMDB1LuTtbeb5Kx9hw9yOttF9Noc4h8pXt+uiy1KXqabAHt4OCtdcW7dNitM7mS
         BYag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767773694; x=1768378494;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bskqrEZI3mWJPk0/2+jknOdH1/nKT2h7hO8FoQ5vtvY=;
        b=J2fNzafpbXG/W043POgOBmbLQaXQm5gZn+lUHIhm0sTbhPnt4R8cqYLKWVdTK/TCaU
         SQzqKJzcp/A8S1DSlGhr0+5/whZ0qeuLQbQnsXndDTKj3pK0K4Q700ANfoFYZFvLEOPk
         XMvkzIQZUtDcoS0gx/BlxNLmiM1hOBjPdxaRdhSQlxBWlGogHVgYerLZTlqHL3inznKm
         cdnEQV44iQo6V/tzYJLrXqhmDVOxJkhWC3/BdhOvhDnAS2La7mxCWxhNwUF58/eGckHf
         8z7GK1Rfx4dugqXvLc1ma6buJSLdT8FGUDYSVoQ3c5Aq0z0wAj/Bi3lVMAER5st4IXqf
         kEcw==
X-Forwarded-Encrypted: i=1; AJvYcCUtCtJzPxnw77yT9udpe1QVQ+pVVFVlDQnVp1HHukPyw8Y+Xh522S77X98ZsyiY5XaebLUGCtDiU6E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV3sHO15RqN6Uv9MA/Nwhq8STqBRuWyzo5PJd4N+nojuYOulqj
	ORfOCYVBcN1Q0jniNE9MmFMuN3NgUS+ECw4iDK1wY1xMKfUYUOUrbCo=
X-Gm-Gg: AY/fxX5o05ggRZHyfTQuTaO+crd/prHbbnqNZn3rdj3r2VAitKI4xR6KES3KfxOXSTL
	lN5ZO7rvXFPJ+lzFvIit7kVLwUKwkDxBHWCPTZiQ8stwMudmss3MdFoByynJGRpq1wbz8pdaJiw
	jPVHwn6pLSwFMA7ObjGgOi5k4gpkdVWjCESBAZed4AQje8Tiek6d7pJQAXbuqnuXr2n83PQv9fj
	Xsj+0ou444Ua06+sKz0gKFzDDrOb9uCDAldLqEW6aXe43lgk201d6cHpO/6WuhnfW+55dkbQJ6w
	D8X/UgKVcWJmASNHnrf/Y3i8ky7qqGIS4WLtu7BRBTh6e270zZqLofWvi1mIMZ/p5FlsPCHx4zk
	luFhbz/adSUTeEW64We5fJ23skepiQRLe6M1fNbIuoSizoLyjaUSv3fBH0JN0qh7O7h1xecZ/Ti
	53+W6chYhgqp8ACuM=
X-Google-Smtp-Source: AGHT+IEVoP6pHkawjtR7Y9FSmOyxuGs7jEFf4OAW54GqLy+VY1n5OQILdfH/RXZEFEu7/SXDZastkQ==
X-Received: by 2002:a17:902:e806:b0:2a0:ba6d:d0ff with SMTP id d9443c01a7336-2a3ee452490mr16514365ad.16.1767773693586;
        Wed, 07 Jan 2026 00:14:53 -0800 (PST)
Received: from at.. ([171.61.166.195])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cd2acdsm42335445ad.89.2026.01.07.00.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 00:14:53 -0800 (PST)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: 
Cc: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	"Oliver O'Halloran" <oohall@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lukas Wunner <lukas@wunner.de>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] PCI/portdev: Disable AER for Titan Ridge 4C 2018
Date: Wed,  7 Jan 2026 08:14:35 +0000
Message-ID: <20260107081445.1100-1-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since v1:
	Transferred logic to drivers/pci/quicks.c

Disable AER for Intel Titan Ridge 4C 2018
(used in T2 iMacs, where the warnings appear)
that generate continuous pcieport warnings. such as:

pcieport 0000:00:1c.4: AER: Correctable error message received from 0000:07:00.0
pcieport 0000:07:00.0: PCIe Bus Error: severity=Correctable, type=Data Link Layer, (Receiver ID)
pcieport 0000:07:00.0:   device [8086:15ea] error status/mask=00000080/00002000
pcieport 0000:07:00.0:    [ 7] BadDLLP

(see: https://bugzilla.kernel.org/show_bug.cgi?id=220651)

macOS also disables AER for Thunderbolt devices and controllers in their drivers.

Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
---
 drivers/pci/pcie/aer.c     | 3 +++
 drivers/pci/pcie/portdrv.c | 2 +-
 drivers/pci/quirks.c       | 9 +++++++++
 include/linux/pci.h        | 1 +
 4 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index e0bcaa896803..45604564ce6f 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -389,6 +389,9 @@ void pci_aer_init(struct pci_dev *dev)
 {
 	int n;
 
+	if (dev->no_aer)
+		return;
+
 	dev->aer_cap = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
 	if (!dev->aer_cap)
 		return;
diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index 38a41ccf79b9..ab904a224296 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -240,7 +240,7 @@ static int get_port_device_capability(struct pci_dev *dev)
 	if ((pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
              pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC) &&
 	    dev->aer_cap && pci_aer_available() &&
-	    (pcie_ports_native || host->native_aer))
+	    (pcie_ports_native || host->native_aer) && !dev->no_aer)
 		services |= PCIE_PORT_SERVICE_AER;
 #endif
 
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index b9c252aa6fe0..d36dd3f8bbf6 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6340,4 +6340,13 @@ static void pci_mask_replay_timer_timeout(struct pci_dev *pdev)
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9750, pci_mask_replay_timer_timeout);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9755, pci_mask_replay_timer_timeout);
+
+static void pci_disable_aer(struct pci_dev *pdev)
+{
+	pdev->no_aer = 1;
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x15EA, pci_disable_aer);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x15EB, pci_disable_aer);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x15EC, pci_disable_aer);
+
 #endif
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 864775651c6f..f447f86c6bdf 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -440,6 +440,7 @@ struct pci_dev {
 	unsigned int	multifunction:1;	/* Multi-function device */
 
 	unsigned int	is_busmaster:1;		/* Is busmaster */
+	unsigned int	no_aer:1;		/* May not use AER */
 	unsigned int	no_msi:1;		/* May not use MSI */
 	unsigned int	no_64bit_msi:1;		/* May only use 32-bit MSIs */
 	unsigned int	block_cfg_access:1;	/* Config space access blocked */
-- 
2.43.0


