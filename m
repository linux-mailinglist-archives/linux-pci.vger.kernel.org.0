Return-Path: <linux-pci+bounces-30068-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B18ADEFE7
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 16:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0F8E3BF1AA
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 14:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619C623A9B3;
	Wed, 18 Jun 2025 14:39:11 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAA02E8DE3
	for <linux-pci@vger.kernel.org>; Wed, 18 Jun 2025 14:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750257551; cv=none; b=R3XQL2U53KINejoP4+Q7+vrWBFcNPx9ZsiFJCw+AgEB81pfkaXYuU9LsYY/h1WvCrlyqI3ZtOvFur+sOKke0N6zZPno7bahBd6z8mg7oc96pi+rRU9cegdMQ/SM+RjhgBoCy4N8Q6++HRn0aMHuVUQruG6qXwbxHipKYmrXK+Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750257551; c=relaxed/simple;
	bh=o1On76AlzHDuKiOVENt4uW3/RfGWYq2ibifjz0OHjpU=;
	h=Message-Id:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=dx81tTTFdFO2X+tcD5t6ADmY2LHeabgOaQLc9Q5Gx3mBTadDLmH42zFkYdZSEcDKWePWHutSwMxSXDjqaPwcelbvqyRRmf8/9ZY971GhNxB11T2eMTwswqvbmVglt/Y9MnHfLhsU/+Q3WU3j2KiA/88BFYECAq380uhGXeOfeDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id A737E20091A0;
	Wed, 18 Jun 2025 16:39:04 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 9390439FF50; Wed, 18 Jun 2025 16:39:04 +0200 (CEST)
Message-Id: <d9c4286a16253af7e93eaf12e076e3ef3546367a.1750257164.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Wed, 18 Jun 2025 16:38:25 +0200
Subject: [PATCH for-linus] PCI: pciehp: Ignore belated Presence Detect Changed
 caused by DPC
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, "Joel Mathew Thomas" <proxy0@tutamail.com>, tcm4095@gmail.com, linux-pci@vger.kernel.org

Commit c3be50f7547c ("PCI: pciehp: Ignore Presence Detect Changed caused
by DPC") sought to ignore Presence Detect Changed events occurring as a
side effect of Downstream Port Containment.

The commit awaits recovery from DPC and then clears events which occurred
in the meantime.  However if the first event seen after DPC is Data Link
Layer State Changed, only that event is cleared and not Presence Detect
Changed.  The object of the commit is thus defeated.

That's because pciehp_ist() computes the events to clear based on the
local "events" variable instead of "ctrl->pending_events".  The former
contains the events that had occurred when pciehp_ist() was entered,
whereas the latter also contains events that have accumulated while
awaiting DPC recovery.

In practice, the order of PDC and DLLSC events is arbitrary and the delay
in-between can be several milliseconds.

So change the logic to always clear PDC events, even if they come after an
initial DLLSC event.

Fixes: c3be50f7547c ("PCI: pciehp: Ignore Presence Detect Changed caused by DPC")
Reported-by: Lương Việt Hoàng <tcm4095@gmail.com>
Reported-by: Joel Mathew Thomas <proxy0@tutamail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219765#c165
Tested-by: Lương Việt Hoàng <tcm4095@gmail.com>
Tested-by: Joel Mathew Thomas <proxy0@tutamail.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/hotplug/pciehp_hpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index ebd342b..91d2d92 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -771,7 +771,7 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
 		u16 ignored_events = PCI_EXP_SLTSTA_DLLSC;
 
 		if (!ctrl->inband_presence_disabled)
-			ignored_events |= events & PCI_EXP_SLTSTA_PDC;
+			ignored_events |= PCI_EXP_SLTSTA_PDC;
 
 		events &= ~ignored_events;
 		pciehp_ignore_link_change(ctrl, pdev, irq, ignored_events);
-- 
2.47.2


