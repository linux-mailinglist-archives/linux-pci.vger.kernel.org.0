Return-Path: <linux-pci+bounces-44114-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52CEECFA257
	for <lists+linux-pci@lfdr.de>; Tue, 06 Jan 2026 19:28:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 56F99305CCD1
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jan 2026 18:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB5D3590AE;
	Tue,  6 Jan 2026 18:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FqRPi+e3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC28358D30
	for <linux-pci@vger.kernel.org>; Tue,  6 Jan 2026 18:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767723642; cv=none; b=tz2VHwKTcIVNMaVNgIObI+XNKEEWC3lri3z+o+vcCmfxcmeb2MaX8s6VbfWFTpOesD65Y3hJigJHHPbghryxAcf6p1jF5pVl+YLY+1N4ZBRwLY5mQxa+PEbMv3tAQs1niXm3wG86KaCBQE7qfDHhdATx9mmwBxZnmZjcbndfSSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767723642; c=relaxed/simple;
	bh=PYVDMgK9PnbUxrY5jOMkOM5fSIfNtKfNd7u/6DrGtEI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T5HibOwJBaPmJovLGpq7NitGV+25wOYkvYUNsYx8NmGx7xCi20yW+5/zMJQDgvx5Y45IMd8VYUM8RqGP/wHzAmPFTIZ/iBlFXxJezrLw2NtG8YYNhWumioCDq1y7GCErJXv3/wj2uMeKxyyn+YBONv/dFsnQYg1knJUrUT75Qmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FqRPi+e3; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-34e90f7b49cso986416a91.3
        for <linux-pci@vger.kernel.org>; Tue, 06 Jan 2026 10:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767723640; x=1768328440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y79iG+X89x7oGE6QkgwnvNyCXJZJjw2YsZ5ydR8skMs=;
        b=FqRPi+e3homt4Yc1Ob/j9+dM9foDKuPdS69n1KFFMvIfmQGkGM+8mUj1MO2PHUIYnQ
         6TM8TFtuyL8Ck0c7JUmDOpforVvRq7ZSY87fGrm8Ub0oAda2mF57T8/KYudtxy1PGYws
         qUzI48pzLZo29NoBU1k172osHA8h1xAygeNhzbhr7r3r7EC+G9Yst6WY6xc11zOK+782
         l/9r9ZWnFgnyGBoLmWJNJayi2Me4TcBp+oTlyZCl8BfB7ZN5Mtuy345DPWn1Wjkb87jQ
         PLVjTWK4MjW2/MNHyZH2yVgXBIrMmMpekzGI5n3i/zPLqwSmAypkvjknZxmsl8mG47qS
         r6/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767723640; x=1768328440;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y79iG+X89x7oGE6QkgwnvNyCXJZJjw2YsZ5ydR8skMs=;
        b=xUq8gKdoueMwI9o3ueMTf4nRI3rO9XSdI455PUX5WEWvOgV+Y5pd7viux5doAwxnU4
         dTJst52WEfJv5gXgFOlg2uyYXNgix3caJ+FDZthNUd2wdSX+bv+6zd+a+I7HYCLd4cxU
         v7iVxTFVqGCwbW5Bh71TVQaxXhwAgBEdNBLPmTl4WvzfplDj/Ct5AAae1bMLNEoNLrRe
         ir81wvj1Qn8jYY1UTji1RS0VdU/iIqwmKWoqj27iRlBIeP9kFx2KoKMWyDfPH/nfXl8e
         cqFGftn86hfK8EMGDWFl+NuFcJjOrMP7BqxpRfv5thaAMjtk+gU4zwT2dO8tSvpPajE+
         0Xsg==
X-Forwarded-Encrypted: i=1; AJvYcCUmaCj5PQmSdmYqMvHPwRXs1GfZ1ZxOvAPuzdOL7+4NIIGfpU+WhdFUhnwpD8Z8VsJ+4tcV7LZW4WM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRj0n2PTMbgSWT8nJnosPVc6iPgrvJ2qOShmOmFCkyH+zQwOTX
	HtpV7XApdWPjy049aycUjvxnp6QSjhOY4QyuyONvCSciStQvu3c4eRM=
X-Gm-Gg: AY/fxX4dUbHHwTtfCtViv2plU0yp1r9c98kJIwND4eFUqSugyje0CJynrP+dCn0Ea+P
	YBHPz+M3W0s4kPFtLXD511QWwDwMEnU0e82/f0TeoiSj64B0fEEmI0aWmoVbuGPm21Y2YQcat7f
	DFZ1xA70NTb+wHZV82zOnJzI/K9J5LFckOavFGfsxfps4nkr7Ur5jGlQ57d8TktsTovQnuuLxDs
	FzIjcksee+tnmpZPbRCay7vM7x+vkc7QdLMT1JKRxvTZpf7xdZbzfwI+MKHSjBUETAStYEvkHNq
	QFCuCKBdzhk06Z277PHoQCJ5u4ebdPfq8SB4g0Jdt2VFvbu/VfcK9cwMdzTX+Vke+FbEzXHv8H5
	4UKxgV4n9ZGVhjyPGOq+qOLeH1Ydiyyk41TYLVECCTQsdWcIYZxwbMROEPJ/7yqr7p0koS50sXL
	+YhZ1/hJHYHX+Yob0=
X-Google-Smtp-Source: AGHT+IF6+dzdqBGaXuV1HrFq0ot5ApXe2M8k3DsdfKzrYrSPDGymNkSMI++shckX43lJSnmzbAdHWQ==
X-Received: by 2002:a17:90b:1e0a:b0:34c:e5fc:faec with SMTP id 98e67ed59e1d1-34f68c3367fmr49421a91.2.1767723639805;
        Tue, 06 Jan 2026 10:20:39 -0800 (PST)
Received: from at.. ([171.61.166.195])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cbf28f678sm2986227a12.3.2026.01.06.10.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 10:20:38 -0800 (PST)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: 
Cc: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lukas Wunner <lukas@wunner.de>,
	Dave Jiang <dave.jiang@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PCI/portdev: Disable AER for Titan Ridge 4C 2018
Date: Tue,  6 Jan 2026 18:20:17 +0000
Message-ID: <20260106182025.1398-1-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Disable AER for Intel Titan Ridge 4C 2018
(used in T2 iMacs, where the warnings appear)
that generates continuous pcieport warnings. such as:

pcieport 0000:00:1c.4: AER: Correctable error message received from 0000:07:00.0
pcieport 0000:07:00.0: PCIe Bus Error: severity=Correctable, type=Data Link Layer, (Receiver ID)
pcieport 0000:07:00.0:   device [8086:15ea] error status/mask=00000080/00002000
pcieport 0000:07:00.0:    [ 7] BadDLLP

(see: https://bugzilla.kernel.org/show_bug.cgi?id=220651)

macOS also disables AER for Thunderbolt devices and controllers in their drivers.

Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
---
 drivers/pci/pcie/portdrv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index 38a41ccf79b9..5330a679fcff 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -240,7 +240,9 @@ static int get_port_device_capability(struct pci_dev *dev)
 	if ((pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
              pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC) &&
 	    dev->aer_cap && pci_aer_available() &&
-	    (pcie_ports_native || host->native_aer))
+	    (pcie_ports_native || host->native_aer) &&
+	    !(dev->vendor == PCI_VENDOR_ID_INTEL &&
+		    (dev->device >= 0x15EA && dev->device <= 0x15EC)))
 		services |= PCIE_PORT_SERVICE_AER;
 #endif
 
-- 
2.43.0


