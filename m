Return-Path: <linux-pci+bounces-8581-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E015903C32
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2024 14:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CA16284F6C
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2024 12:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1241E86F;
	Tue, 11 Jun 2024 12:51:10 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61EC717C20C;
	Tue, 11 Jun 2024 12:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718110270; cv=none; b=fNIcOQmGTaXAIPKvRTfLs1szIjD4VJB8HEH2kPjx5uuunKRKSHFEFStysPGbOwAUKMDNgTkF1dzXltk0cmX6sG+bXuYvnBiSaPsFtLvJ1GTEHG4WLT+eTXIPzKgEs/t/YEh2Ve+f3W45c7VXyoYi3T4v2ZAqYtipspKaE8ltdk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718110270; c=relaxed/simple;
	bh=U/Ie7iZqgHKR8zcfnLGW1zlv0d/KYGgoe1QRnrRuN5w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cWsXmUQakq6rvG2EWbjn2suO0+rtEWwyrD/q6UIkp9TVD0VLd+ZBLEIBft5ELNrgvZH5fgjYbNw2+i6LOO6LfkT0Ru6QXgGa/mlGIN9biO1QmBHhCeiubz82B0G90oiIudOxI+aYvpD86C5jCZfRADe+vzr2y9G94yhR2W/YiUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-IronPort-AV: E=Sophos;i="6.08,230,1712588400"; 
   d="scan'208";a="211455257"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 11 Jun 2024 21:51:05 +0900
Received: from localhost.localdomain (unknown [10.166.13.99])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id BE3A740104EA;
	Tue, 11 Jun 2024 21:51:05 +0900 (JST)
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
Subject: [PATCH v9 0/5] PCI: rcar-gen4: Add R-Car V4H support
Date: Tue, 11 Jun 2024 21:50:52 +0900
Message-Id: <20240611125057.1232873-1-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pcie-rcar-gen4 driver can reuse other R-Car Gen4 support like
r8a779g0 (R-Car V4H) and r8a779h0 (R-Car V4M). However, some
initializing settings differ between R-Car S4-8 (r8a779f0) and
others. The R-Car S4-8 will be minority about the setting way. So,
R-Car V4H will be majority and this is generic initialization way
as "renesas,rcar-gen4-pcie{-ep}" compatible.

About the firmware binary, please refer to the following patch
descirption:
  PCI: rcar-gen4: Add support for r8a779g0

For now, I tested both R-Car S4-8 and R-Car V4H on this driver.
I'll support one more other SoC (R-Car V4M) in the future.

Changes from v8:
https://lore.kernel.org/linux-pci/20240520074300.125969-1-yoshihiro.shimoda.uh@renesas.com/
- Add Reviewed-by in the patch 3/5.
- Revise commit description in the patch [2345]/5.
- Some minor updates of the code in the patch 4/5.

Changes from v7:
https://lore.kernel.org/linux-pci/20240415081135.3814373-1-yoshihiro.shimoda.uh@renesas.com/
- Since the following patches are merged into pci.git / dt-bindings branch,
  drop them from this patch series:
   dt-bindings: PCI: rcar-gen4-pci-host: Add R-Car V4H compatible
   dt-bindings: PCI: rcar-gen4-pci-ep: Add R-Car V4H compatible
- Add Reviewed-by in the patch [25]/5.
- Add a condition to avoid automated tools report in the patch 2/5.
- Change the new function which adds an "enable" flag in the patch 3/5.
  So, change the commit description and move some functions' places.
- Revise the commit description and add firmware information in detail in
  the patch 4/5.
- Use the offset directly instead of definitions in the patch 4/5.
- Add comments for some magical offsets/values in the patch 4/5.
- Change error message when request_firmware() failed in the patch 4/5.

Changes from v6:
https://lore.kernel.org/linux-pci/20240410004832.3726922-1-yoshihiro.shimoda.uh@renesas.com/
- Add Manivannan's Reviewed-by in patch [37]/7.
- Rename a struct from "platdata" to "drvdata" in patch [4/7].
- Revise the commit descriptions in patch [456]/7.
- Rename some functions in patch 6/7.
- Fix the return value of an error path in patch 6/7.

Yoshihiro Shimoda (5):
  PCI: dwc: Add PCIE_PORT_{FORCE,LANE_SKEW} macros
  PCI: rcar-gen4: Add rcar_gen4_pcie_drvdata
  PCI: rcar-gen4: Add .ltssm_control() for other SoC support
  PCI: rcar-gen4: Add support for r8a779g0
  misc: pci_endpoint_test: Document a policy about adding pci_device_id

 drivers/misc/pci_endpoint_test.c             |   4 +
 drivers/pci/controller/dwc/pcie-designware.h |   6 +
 drivers/pci/controller/dwc/pcie-rcar-gen4.c  | 313 +++++++++++++++++--
 3 files changed, 289 insertions(+), 34 deletions(-)

-- 
2.25.1


