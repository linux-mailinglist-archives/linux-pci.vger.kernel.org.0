Return-Path: <linux-pci+bounces-31651-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FC9AFC216
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 07:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 675D2425DC9
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 05:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CEC4215F5C;
	Tue,  8 Jul 2025 05:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="waYixALk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z2yMPUou"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B20742058;
	Tue,  8 Jul 2025 05:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751953117; cv=none; b=l1fwa6Xmc1G3ZbwEDGXPsDRmFEHIyimrRX8qtGs+To4/dOKf6/qKCQTixpgHp1RisaS+bAkVhrRwtBtT84Q9j1hhQ+xNGYlEw+jvBKqHW3MT0YJMR0dQmK4gAJueI0nAN3DhX2p6Hd2KaYhiEzFAm1pWKZk9aVKG6BuvAlYfYkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751953117; c=relaxed/simple;
	bh=50wPwiif2x2NtdNvunIgqs4/IiKrfgrTdCorrZvve5A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VXXnYsw93fhkxc7osZwQEJS0nbPRmFXz8BcAHstzEPzVnp95pt3pydvJM8WHew26i8B+Nz49gjUf2aCSHzzEBkzfyalDil2QObX71L7TFvskIeAb2vMVm4PfbSUGgPhm5IU6wit+gI3o2Hn4l1wZ9Vmz/IjOzXUMrkjJP3PuIrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=waYixALk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z2yMPUou; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751953112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qGQOt9zJY1AhXD9o4NBc7iKeC5E/hVEdUUotGTlMF60=;
	b=waYixALk8ew3kupKl+Sv0gwYp8se/Dfi/iHjRbrELdra9IIpCHgi6xaxBxrAoBeKmyntIQ
	B44r85YOVVEYiq4QWp2PgXgRtP0wv1ngF/Sgts4eEXk7n6IAvfjXXLhJ0DTySMS1idlZZW
	d+ML2ZTkAsNfmG+LdYZDtUkyEVts4CwTFT3Ei/wo5l8pvPhkbnC/B45UtcD9KHq4krXbWo
	GzQ125bpeaoMgl1AGBCORDgprtqfscQcXHzdr5BwRkQ/hYSCgTiZ27YC+OUyCKZNgQkt4E
	WNe2u7Rmf/QJ1kJNwqFusjZSCv4098CoM2gruTfjjA+kAfIcaMwc5SbEGCqnuw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751953112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qGQOt9zJY1AhXD9o4NBc7iKeC5E/hVEdUUotGTlMF60=;
	b=z2yMPUoun6joogG68ZUVq97zb0wQM4zYXJGzFbNOzQV49MpFFKgy0RitRPkynR5UaQwufD
	/XaMFmlbzDKwoXAg==
To: Thomas Gleixner <tglx@linutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] PCI: iproc: Remove description of 'msi_domain' in struct iproc_msi
Date: Tue,  8 Jul 2025 07:38:25 +0200
Message-Id: <20250708053825.1803409-1-namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The member msi_domain of struct iproc_msi has been removed, but its
description was left behind. Remove the description.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202507080437.HQuYK7x8-lkp@int=
el.com/
Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 drivers/pci/controller/pcie-iproc-msi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-iproc-msi.c b/drivers/pci/controll=
er/pcie-iproc-msi.c
index d0c7f004217f..9ba242ab9596 100644
--- a/drivers/pci/controller/pcie-iproc-msi.c
+++ b/drivers/pci/controller/pcie-iproc-msi.c
@@ -82,7 +82,6 @@ struct iproc_msi_grp {
  * @bitmap_lock: lock to protect access to the MSI bitmap
  * @nr_msi_vecs: total number of MSI vectors
  * @inner_domain: inner IRQ domain
- * @msi_domain: MSI IRQ domain
  * @nr_eq_region: required number of 4K aligned memory region for MSI event
  * queues
  * @nr_msi_region: required number of 4K aligned address region for MSI po=
sted
--=20
2.39.5


