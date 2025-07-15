Return-Path: <linux-pci+bounces-32192-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A627B06893
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 23:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28A2E4E2021
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 21:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C21026FA4C;
	Tue, 15 Jul 2025 21:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b="Vg3Bzzfm"
X-Original-To: linux-pci@vger.kernel.org
Received: from raptorengineering.com (mail.raptorengineering.com [23.155.224.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852CEDF76;
	Tue, 15 Jul 2025 21:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.155.224.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752615125; cv=none; b=fRiLvu+tqtwXXfifLEDT65cHwG1J8WQMW6JAknM3LMTB2g+NgEw/or7+EonNkjUhexc6vGLTo0fCBy85Cb0YP/l5UD21yS5yCKGrki4rR1x+VYv8FD/1nvqCxXJWKsn0w+U+iCibSDg6791ya3w08svIFAIXupkQ6TxOY2S6TiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752615125; c=relaxed/simple;
	bh=RmW89GK9pnmFOIxELKgju/62ROmTX+YH6Rf+TJ9kdg4=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type; b=ruv6VQKLPLcnQjqrr3DVMr7JgdxLwNEZrCWobqqjAcJpZkE3Nar82/6fhEa/igR2L2go4kGclVEuEm6tKKJpQtcWq+cvFBo44e7xROxL/ypRZT5N1Chfep1VqcQ7kWCVbV1SkzOu1A/eZDQUaUADgMjRpNAbxZRK22MQY/UM+EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com; spf=pass smtp.mailfrom=raptorengineering.com; dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b=Vg3Bzzfm; arc=none smtp.client-ip=23.155.224.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raptorengineering.com
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 431558287698;
	Tue, 15 Jul 2025 16:31:54 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id HoGop4iZv_d7; Tue, 15 Jul 2025 16:31:53 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 79A28828832D;
	Tue, 15 Jul 2025 16:31:53 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com 79A28828832D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
	t=1752615113; bh=pCmOltlEYd6S50ZKZ9a1KSNaWOyP6XSx2ggNDbtS3qY=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=Vg3Bzzfm5Xh1QPI3DWetWQCB1+4tffLZ9HAlb5Dfyu/JuU172d23HcSwwIp3xtrq8
	 eMGZ145VKXy2v62+pZ96KzelnKgbIOSvbmuzc3BkwOOAgAIgfQbIYmZXywI0fbMCcM
	 d001tj2jbFpckzg2w7fSLFhZSctJMKoD4XS80jdI=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id svjTAW6EvY7k; Tue, 15 Jul 2025 16:31:53 -0500 (CDT)
Received: from vali.starlink.edu (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 2BC788287698;
	Tue, 15 Jul 2025 16:31:53 -0500 (CDT)
Date: Tue, 15 Jul 2025 16:31:49 -0500 (CDT)
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
Message-ID: <1268570622.1359844.1752615109932.JavaMail.zimbra@raptorengineeringinc.com>
Subject: [PATCH v3 0/6] PowerNV PCIe Hotplug Driver Fixes
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.5.0_GA_3042 (ZimbraWebClient - GC138 (Linux)/8.5.0_GA_3042)
Thread-Index: XyF2OaMn/3q+H+nwsGaxXLVF4U4PFw==
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
  PCI: pnv_php: Properly clean up allocated IRQs on unplug
  PCI: pnv_php: Work around switches with broken presence detection

Timothy Pearson (4):
  powerpc/eeh: Export eeh_unfreeze_pe()
  powerpc/eeh: Make EEH driver device hotplug safe
  PCI: pnv_php: Fix surprise plug detection and recovery
  PCI: pnv_php: Enable third attention indicator state

 arch/powerpc/kernel/eeh.c         |   1 +
 arch/powerpc/kernel/eeh_driver.c  |  48 ++++--
 arch/powerpc/kernel/eeh_pe.c      |  10 +-
 arch/powerpc/kernel/pci-hotplug.c |   3 +
 drivers/pci/hotplug/pnv_php.c     | 244 +++++++++++++++++++++++++++---
 5 files changed, 263 insertions(+), 43 deletions(-)

-- 
2.39.5

