Return-Path: <linux-pci+bounces-30095-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C19ADF32D
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 18:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A08BD188C236
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 16:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E052FEE13;
	Wed, 18 Jun 2025 16:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b="B0EFl+B5"
X-Original-To: linux-pci@vger.kernel.org
Received: from raptorengineering.com (mail.raptorengineering.com [23.155.224.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6681C2FEE11;
	Wed, 18 Jun 2025 16:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.155.224.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750265676; cv=none; b=IPIOYgyISdRGxuzTKFNYPSph4JvZyK2T4oyUVP8AkPlR6mH8lAj/xwZQxax/7pJ3vVjEsyUWhiJzKLTh4A8gTHtOoUAJWJHPCNFrbbeQdk+VJR5KrjYZchhdAtNZiqNcR67C7ihAkOeIv7Qdr16dE7GAKs4zUtOBpW0dxw5hAx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750265676; c=relaxed/simple;
	bh=ttUWxnOPsj1wH58g8SY5eUP5jJTbSwomk5rwycGlWw8=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type; b=EGN2+WZk4pv3+HoD7+pEFKDMTT62clTtHQSCEbui354gZWE5qPunm6sQh/Dk7RsyHzQkQLMQpbDj6rRsGcBizFSjrpkKMhy6gnNaA3sm2MdO0sZBblTB45Vp/DQ31DmVpePOaCsgZkZoVtACOktSZNV6eUd1yM1MzOTH7qblPHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com; spf=pass smtp.mailfrom=raptorengineering.com; dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b=B0EFl+B5; arc=none smtp.client-ip=23.155.224.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raptorengineering.com
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 0AE7282879F3;
	Wed, 18 Jun 2025 11:54:33 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id ueuYGyDCQRzD; Wed, 18 Jun 2025 11:54:31 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id F0DEF8286F81;
	Wed, 18 Jun 2025 11:54:30 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com F0DEF8286F81
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
	t=1750265671; bh=TXK4nvk3hVRfTyVxrU16zW6M8nI8oDPJzdJIGj8kYsc=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=B0EFl+B5U0qK16MIf1a72t4z5arjFFgr3ibazQtLKE8gz+ZjP6wwrA/8vIGSqI4UP
	 mZCG4AypeO9Wf+/6bCjH9n4uNcUxoWWLVwzwXXl1AKJjeRkR6miLLoBO2HDO6Biki7
	 tc1l1CTz7SIzYj7E9r78PlC6LjhfcgP8N3f4BC6k=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id sxi47ZWzGdik; Wed, 18 Jun 2025 11:54:30 -0500 (CDT)
Received: from vali.starlink.edu (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id A84778286AE2;
	Wed, 18 Jun 2025 11:54:30 -0500 (CDT)
Date: Wed, 18 Jun 2025 11:54:28 -0500 (CDT)
From: Timothy Pearson <tpearson@raptorengineering.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-pci <linux-pci@vger.kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, 
	christophe leroy <christophe.leroy@csgroup.eu>, 
	Naveen N Rao <naveen@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, 
	Shawn Anastasio <sanastasio@raptorengineering.com>
Message-ID: <581463409.1310624.1750265668004.JavaMail.zimbra@raptorengineeringinc.com>
Subject: [PATCH v2 0/6] PowerNV PCIe Hotplug Driver Fixes
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.5.0_GA_3042 (ZimbraWebClient - GC137 (Linux)/8.5.0_GA_3042)
Thread-Index: 7ViWVrejj338yZQm64sXoMCfdWvE4A==
Thread-Topic: PowerNV PCIe Hotplug Driver Fixes

Hello all,

This series includes several fixes for bugs in the PowerNV PCIe hotplug
driver that were discovered in testing with a Microsemi Switchtec PM8533
PFX 48xG3 PCIe switch on a PowerNV system, as well as one workaround for
PCIe switches that don't correctly implement slot presence detection
such as the aforementioned one. Without the workaround, the switch works
and downstream devices can be hot-unplugged, but the devices never come
back online after being plugged in again until the system is rebooted.
Other hotplug drivers (like pciehp_hpc) use a similar workaround.

Also included are fixes for the EEH driver to make it hotplug safe,
and a small patch to enable all three attention indicator states per
the PCIe specification.

Thanks,

Shawn Anastasio (2):
  pci/hotplug/pnv_php: Properly clean up allocated IRQs on unplug
  pci/hotplug/pnv_php: Work around switches with broken presence
    detection

Timothy Pearson (5):
  powerpc/pseries/eeh: Export eeh_unfreeze_pe() and eeh_ops
  powerpc/eeh: Make EEH driver device hotplug safe
  pci/hotplug/pnv_php: Fix surprise plug detection and recovery
  pci/hotplug/pnv_php: Enable third atetntion indicator state

 arch/powerpc/kernel/eeh.c                    |   2 +
 arch/powerpc/kernel/eeh_driver.c             |  48 ++++--
 arch/powerpc/kernel/eeh_pe.c                 |  10 +-
 arch/powerpc/kernel/pci-hotplug.c            |   3 +
 arch/powerpc/platforms/powernv/eeh-powernv.c |   1 +
 drivers/pci/hotplug/pciehp.h                 |   1 -
 drivers/pci/hotplug/pciehp_ctrl.c            |   2 +-
 drivers/pci/hotplug/pciehp_hpc.c             |  33 +---
 drivers/pci/hotplug/pnv_php.c                | 172 ++++++++++++++++---
 drivers/pci/pci.c                            |  31 +++-
 drivers/pci/pci.h                            |   1 +
 11 files changed, 228 insertions(+), 76 deletions(-)

-- 
2.39.5

