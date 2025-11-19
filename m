Return-Path: <linux-pci+bounces-41589-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C8AB9C6D857
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 09:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sto.lore.kernel.org (Postfix) with ESMTPS id 69BDB28B7E
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 08:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BFE307ACB;
	Wed, 19 Nov 2025 08:50:59 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091EB307AC8;
	Wed, 19 Nov 2025 08:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763542259; cv=none; b=p/RKZa4FStqiZ9/puKhBrr7OR+SbvBKvwmT5/6Tb4fioi/PK2uQ9F/lHhlB70fdhF0J1TaMX4uny4HlkhE/riiq4LEd9Q+2h7KOcVb/0UlrkhH+V4wVAZLE04jOw5xNIyt+Gn9eC0wAefUrCmEIf2qA9AFynfLIAnAkx5T7fhbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763542259; c=relaxed/simple;
	bh=mbuL7CvU6IjCUqMZR8b5Woc5ZfnbzyTIB6VR9DehR14=;
	h=Message-ID:From:Date:Subject:To:Cc; b=e367fBXi4Ixf36STnyFrVSUlRuDzGb+KQeUoaj3vcYfBd2VDLVVG0EG5G+9UMFIt6IRZ+/Y5gnfJEg1KLfNE8s9ILUTfPQXGLtnYEd9hmAdGSx3B4jzSLI/90SAybOfC+UDjKlCoC0sUqHYcRiCr2PCpI6vD2NTIjfLqH6X+4O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id CC9BB2C000A8;
	Wed, 19 Nov 2025 09:50:52 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 9A023D56F; Wed, 19 Nov 2025 09:50:52 +0100 (CET)
Message-ID: <cover.1763483367.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Wed, 19 Nov 2025 09:50:00 +0100
Subject: [PATCH v2 0/3] PCI: Universal error recoverability of devices
To: Bjorn Helgaas <helgaas@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Riana Tauro <riana.tauro@intel.com>, "Sean C. Dardis" <sean.c.dardis@intel.com>, Farhan Ali <alifm@linux.ibm.com>, Benjamin Block <bblock@linux.ibm.com>, Niklas Schnelle <schnelle@linux.ibm.com>, Alek Du <alek.du@intel.com>, "Mahesh J Salgaonkar" <mahesh@linux.ibm.com>, Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

This series intends to replace commit 1dc302f7fccc ("PCI: Ensure error
recoverability at all times") on the pci/err topic branch:

https://git.kernel.org/pci/pci/c/1dc302f7fccc

The commit is assigning "dev->state_saved = false" in pci_bus_add_device()
and during review there were requests to explain the assignment more
clearly in a code comment.

However the assignment is (only) necessitated by missing assignments in
pci_legacy_suspend() and pci_pm_freeze(), so I propose to instead add
*those* assignments (patch [1/3]) and thus avoid the need for the
assignment in pci_bus_add_device(), together with its code comment.

Furthermore the commit is *removing* an assignment in pci_device_add().
I am separating that out to new patch [2/3].

So patch [3/3] is identical to the commit, but without the addition
of an assignment in pci_bus_add_device() and without the removal
of an assignment in pci_device_add().

I am looking into improving the documentation on pci_save_state()
in a separate series.

Lukas Wunner (3):
  PCI/PM: Reinstate clearing state_saved in legacy and !pm codepaths
  PCI/PM: Stop needlessly clearing state_saved on enumeration and thaw
  PCI/ERR: Ensure error recoverability at all times

 drivers/pci/bus.c        | 3 +++
 drivers/pci/pci-driver.c | 6 ++++--
 drivers/pci/pci.c        | 3 ---
 drivers/pci/probe.c      | 2 --
 4 files changed, 7 insertions(+), 7 deletions(-)

-- 
2.51.0


