Return-Path: <linux-pci+bounces-29997-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D24FADE245
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 06:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FE0D1899721
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 04:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C171C5496;
	Wed, 18 Jun 2025 04:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b="ee/cpHd0"
X-Original-To: linux-pci@vger.kernel.org
Received: from raptorengineering.com (mail.raptorengineering.com [23.155.224.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EC923A9;
	Wed, 18 Jun 2025 04:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.155.224.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750220485; cv=none; b=ZDMwV9k8Y/SUiMSWVFJ999cV/jvuJa/zhd0P/z5XdH0RhbtD0kA3bz0LCNST0/oZJEvmIpVcMonQdnjMc8yu3rDf0kum7w13vId6qjCXtlgLXwJq364ikRrAFEKMbVkzQlFXaENjdZQkdZ9v/pcudg6jGd0MrpZ1dXKXUTiQRBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750220485; c=relaxed/simple;
	bh=ttUWxnOPsj1wH58g8SY5eUP5jJTbSwomk5rwycGlWw8=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type; b=R36JlrVNZZQwCm+UXeoEFOwl3v8CgmRbDavPsq0P64kpKnYMrJTp/Dpdkd3fFApaTZKelDHJrNRUudH+5s9F2pqkYWV7b7JT2yCZMOx3itBqHinNoeaJl+5W2+GermPBfde0kCP1H4wsTNTU5qvojqTEWRVhq6DpIPzCWGpYUWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com; spf=pass smtp.mailfrom=raptorengineering.com; dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b=ee/cpHd0; arc=none smtp.client-ip=23.155.224.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raptorengineering.com
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 6F3FE8288748;
	Tue, 17 Jun 2025 23:21:21 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id gVFMjTkUT-DX; Tue, 17 Jun 2025 23:21:20 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 0423E828742D;
	Tue, 17 Jun 2025 23:21:20 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com 0423E828742D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
	t=1750220480; bh=TXK4nvk3hVRfTyVxrU16zW6M8nI8oDPJzdJIGj8kYsc=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=ee/cpHd0gCNVtqZnV+ywntrlr58zRVI9VRxMIRLxcPWOVw8+Ax1k5uUCWzxNHk79m
	 hNpMWOTs+tqTvjn/a9Aqz9CtrPbMj3JDPpVqY61tRkLCmR25a2emu+HpK2fnJNOmKA
	 SriNg5ixLNGMH0Ygt62s3IWJLtAL75bc+cYPiGRM=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id D7TPnMqQcNQJ; Tue, 17 Jun 2025 23:21:19 -0500 (CDT)
Received: from vali.starlink.edu (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id C33CC8286D0C;
	Tue, 17 Jun 2025 23:21:19 -0500 (CDT)
Date: Tue, 17 Jun 2025 23:21:17 -0500 (CDT)
From: Timothy Pearson <tpearson@raptorengineering.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	tpearson@raptorengineering.com, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Naveen N Rao <naveen@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, 
	Shawn Anastasio <sanastasio@raptorengineering.com>
Message-ID: <1970833911.1309763.1750220477118.JavaMail.zimbra@raptorengineeringinc.com>
Subject: [PATCH 0/6] PowerNV PCIe Hotplug Driver Fixes
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.5.0_GA_3042 (ZimbraWebClient - GC137 (Linux)/8.5.0_GA_3042)
Thread-Index: 8lRcUti9WpN8CCZCIBC2nXslZWbhGA==
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

