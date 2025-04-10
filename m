Return-Path: <linux-pci+bounces-25631-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F011A847EB
	for <lists+linux-pci@lfdr.de>; Thu, 10 Apr 2025 17:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F0A29A7E38
	for <lists+linux-pci@lfdr.de>; Thu, 10 Apr 2025 15:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F771E9B07;
	Thu, 10 Apr 2025 15:27:23 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC01D1E990B;
	Thu, 10 Apr 2025 15:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744298843; cv=none; b=GwT9BYfD95k4KKRO1+dTg/VJP31Z/d3Xhpjt0znd8G4NnVL9DHngCPpVykW1Ydws2ax3P1Dk0fk2RTMAZhIOs2ITB0+5t6WBpmvbeE6mIU8Qcn5OwX2s+Uqn/eFC8piStPEnd3h7GJBKKujySpisVPkZGomyGfnmFTjPnySRLMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744298843; c=relaxed/simple;
	bh=LoA9dG34NuTnVhgXjjJeURo/eSXtyrmMFX2VFZ1UiOk=;
	h=Message-Id:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=dE6o9Y41iJVoRtyBUyBP0rI9H/7aQIhXFUST2NdDLa8SyvWPmSNjgo0P8ptkE3HKPWBCfkGKqM8hEIlTvm7RDxaSF0LFhdR7wFTyT3Tq9WCbI1PTtFlr8ZDooLjR/YSSfyME6IV6MoUv0VnPCCI9WXLfucpodoP0ocgO6AJtRkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 774D22C05254;
	Thu, 10 Apr 2025 17:27:03 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id A5EB34E72E; Thu, 10 Apr 2025 17:27:10 +0200 (CEST)
Message-Id: <cover.1744298239.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Thu, 10 Apr 2025 17:27:10 +0200
Subject: [PATCH 0/2] Ignore spurious PCIe hotplug events
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Keith Busch <kbusch@kernel.org>, Yicong Yang <yangyicong@hisilicon.com>, linux-pci@vger.kernel.org, Stuart Hayes <stuart.w.hayes@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, "Joel Mathew Thomas" <proxy0@tutamail.com>, Russ Weight <russ.weight@linux.dev>, Matthew Gerlach <matthew.gerlach@altera.com>, Yilun Xu <yilun.xu@intel.com>, linux-fpga@vger.kernel.org, Moshe Shemesh <moshe@nvidia.com>, Shay Drory <shayd@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, Alex Williamson <alex.williamson@redhat.com>

Trying to kill several birds with one stone here:

First of all, PCIe hotplug is deliberately ignoring link events occurring
as a side effect of Downstream Port Containment.  But it's not yet ignoring
Presence Detect Changed events.  These can happen if a hotplug bridge uses
in-band presence detect.  Reported by Keith Busch, patch [1/2] seeks to
fix it.

Second, PCIe hotplug is deliberately ignoring link events and Presence
Detect Changed events occurring as a side effect of a Secondary Bus Reset.
But that's no longer working properly since the introduction of bandwidth
control in v6.13-rc1.  Actually it never worked properly, but bandwidth
control is now mercilessly exposing the issue.  VFIO is thus broken,
it resets the device on passthrough.  Reported by Joel Mathew Thomas.

Third, link or presence events can not only occur as a side effect of DPC
or SBR, but also because of suspend to D3cold, a firmware update or FPGA
reconfiguration.  In particular, Altera engineers report that the link
goes down as a side effect of FPGA reconfiguration and the PCIe hotplug
driver responds by disabling slot power.  Obviously not what you'd want
while the FPGA is being reconfigured!

This leads me to believe that we need a generic mechanism to tell hotplug
drivers that spurious link changes are ongoing which need to be ignored.
Patch [2/2] introduces an API for it and the first user is SBR handling
in PCIe hotplug.  This fixes the issue exposed by bandwidth control.
It also aligns DPC and SBR handling in the PCIe hotplug driver such that
they use the same code path.

The API pci_hp_ignore_link_change() / pci_hp_unignore_link_change() is
initially not exported.  It can be once the first modular user shows up.

Although these are technically fixes, they're slightly intrusive, so it
would be good to let them simmer in linux-next for a while.  One option
would be to apply for v6.16 and let Greg & Sasha do the backporting.
Another would be to apply to the for-linus branch for v6.15 but wait
maybe 4 weeks before a pull request is sent.

Please review and test.  Thanks!

Lukas Wunner (2):
  PCI: pciehp: Ignore Presence Detect Changed caused by DPC
  PCI: pciehp: Ignore Link Down/Up caused by Secondary Bus Reset

 drivers/pci/hotplug/pci_hotplug_core.c | 69 ++++++++++++++++++++++++++++++
 drivers/pci/hotplug/pciehp.h           |  1 +
 drivers/pci/hotplug/pciehp_core.c      | 29 -------------
 drivers/pci/hotplug/pciehp_hpc.c       | 78 ++++++++++++++++++++++------------
 drivers/pci/pci.h                      |  3 ++
 include/linux/pci.h                    |  8 ++++
 6 files changed, 132 insertions(+), 56 deletions(-)

-- 
2.43.0


