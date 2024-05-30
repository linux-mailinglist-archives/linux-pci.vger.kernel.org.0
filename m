Return-Path: <linux-pci+bounces-8073-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 515D08D4788
	for <lists+linux-pci@lfdr.de>; Thu, 30 May 2024 10:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99A9CB23B7A
	for <lists+linux-pci@lfdr.de>; Thu, 30 May 2024 08:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BA16F305;
	Thu, 30 May 2024 08:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="lHmUVFpd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208816F2F1;
	Thu, 30 May 2024 08:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717059182; cv=none; b=qBj0py0L8UGOe8t76Optf7590mCy1qn0ojmKOhAfUBRXQXMA1dmHwOdknUD5Md8u3y1S2RgtyZ9sN1GVqZ2XLUkRz89nkJW1j7VMmQnPrICOvof6ZFuq9DmPL/x8lpcC0pGLF1BXcqs9g+U/+iu4dLpCkQJOg0d/RYDGzgG5iQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717059182; c=relaxed/simple;
	bh=3owwtopJBW27l7XF9REOmZ/I2S3ZXl+g+EoVFffOiKg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y7NbSZILfy78a8vmqSeP2Usn16YT0cJXUKJESwfC/WLK0bDRnosbzHNXLi4JRktdyYjH03zoRu35PMQb/vqMYE6ucKDmnrYSsNNjibXHquqG9CfD/MdHz7ifWuZbw0e++VJd1iuV0DcpOYbyqWWu7n5cfMq58uVKE0eY3V9yH4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=lHmUVFpd; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from localhost.localdomain (1.general.khfeng.us.vpn [10.172.68.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 12EA83F2EC;
	Thu, 30 May 2024 08:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1717059177;
	bh=Tpe+gbzS1kOJ94iIq6BFHuIaYZPa70nw/0E6K7KjDPE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=lHmUVFpdxuGlwzSOUKDLcRdFurA+k4cyVgQiBhpd6mJaVhGTRBsco6Ldp0ks3lnJP
	 qugM2VVpkx0Ki3JOuX0O5YhzfQMn9045eMH2gTY6cJDIlCu74YO5++OODW5g471lHD
	 IlxI0+v8ATzoHs568WWR+av2sODkOOspilQPEZRQQ6PZCqdQwP2vl4khP+7hH8Pz+9
	 JbD9MPgOICwIRanxFrJ3IzBIGscIW+k72Wwvb9IqWJ4bLeafWQaNnk/KAdAv62BL8d
	 Swh6Ci1utEpk1FZ8TvX9FFnrZNYRqQkv0wtpL+vrVg7UkPH+raqeEIuPWUTpOE+cdC
	 sbntk1M5/G4EQ==
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nirmal.patel@linux.intel.com,
	jonathan.derrick@linux.dev,
	ilpo.jarvinen@linux.intel.com,
	david.e.box@linux.intel.com,
	Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH 1/2] PCI: ASPM: Allow OS to configure ASPM where BIOS is incapable of
Date: Thu, 30 May 2024 16:52:26 +0800
Message-ID: <20240530085227.91168-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit f492edb40b54 ("PCI: vmd: Add quirk to configure PCIe ASPM
and LTR"), ASPM is configured for NVMe devices enabled in VMD domain.

However, that doesn't cover the case when FADT has ACPI_FADT_NO_ASPM
set.

So add a new attribute to bypass aspm_disabled so OS can configure ASPM.

Fixes: f492edb40b54 ("PCI: vmd: Add quirk to configure PCIe ASPM and LTR")
Link: https://lore.kernel.org/linux-pm/218aa81f-9c6-5929-578d-8dc15f83dd48@panix.com/
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/pci/pcie/aspm.c | 8 ++++++--
 include/linux/pci.h     | 1 +
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index cee2365e54b8..e719605857b1 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1416,8 +1416,12 @@ static int __pci_enable_link_state(struct pci_dev *pdev, int state, bool locked)
 	 * the _OSC method), we can't honor that request.
 	 */
 	if (aspm_disabled) {
-		pci_warn(pdev, "can't override BIOS ASPM; OS doesn't have ASPM control\n");
-		return -EPERM;
+		if (aspm_support_enabled && pdev->aspm_os_control)
+			pci_info(pdev, "BIOS can't program ASPM, let OS control it\n");
+		else {
+			pci_warn(pdev, "can't override BIOS ASPM; OS doesn't have ASPM control\n");
+			return -EPERM;
+		}
 	}
 
 	if (!locked)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index fb004fd4e889..58cbd4bea320 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -467,6 +467,7 @@ struct pci_dev {
 	unsigned int	no_command_memory:1;	/* No PCI_COMMAND_MEMORY */
 	unsigned int	rom_bar_overlap:1;	/* ROM BAR disable broken */
 	unsigned int	rom_attr_enabled:1;	/* Display of ROM attribute enabled? */
+	unsigned int	aspm_os_control:1;	/* Display of ROM attribute enabled? */
 	pci_dev_flags_t dev_flags;
 	atomic_t	enable_cnt;	/* pci_enable_device has been called */
 
-- 
2.43.0


