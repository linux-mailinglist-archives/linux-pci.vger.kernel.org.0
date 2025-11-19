Return-Path: <linux-pci+bounces-41591-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 601A3C6D92D
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 10:04:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 7AE992C063
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 09:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12ACE3321C2;
	Wed, 19 Nov 2025 09:02:54 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C465B2FE57F;
	Wed, 19 Nov 2025 09:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763542974; cv=none; b=L28ZAfO/VtcJn29OtkablxTRGHAV7ZRHPk/3udujPOucGkem6MXVB+6B2eZK9VBFusMaAYUVkflCcKtGhphylurcf9bqz1OOlTj8NlCU5JBxfAq/o4+5ann/KqV3Fvk6CORgAfu+u7UHzUzpmrPNL9nX7epmGEvPeHMYs5d5YqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763542974; c=relaxed/simple;
	bh=khznexja99m3YUAOOMMS1nQluaxouTojtHSeGANLr3k=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:To:Cc; b=JhWvQ5mwOe5NAf/oUTRk61ns/pJMdNewLCbExrBCC8F1pFA6jAb6Nipn2bA6M1++2lYRhBgsviEFPCb1z0T/Tiz80oF4+t133TBUeXyXLoKnk9G7BEf2yMpQpsLXfMraMklD+VF/PiHAlvvQr4Dk9B6cFnaPfA1UMjaxWzHOwN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id CA1C7200803E;
	Wed, 19 Nov 2025 10:02:43 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id C0714E729; Wed, 19 Nov 2025 10:02:43 +0100 (CET)
Message-ID: <fd167945bd7852e1ca08cd4b202130659eea2c2f.1763483367.git.lukas@wunner.de>
In-Reply-To: <cover.1763483367.git.lukas@wunner.de>
References: <cover.1763483367.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Wed, 19 Nov 2025 09:50:02 +0100
Subject: [PATCH v2 2/3] PCI/PM: Stop needlessly clearing state_saved on
 enumeration and thaw
To: Bjorn Helgaas <helgaas@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Riana Tauro <riana.tauro@intel.com>, "Sean C. Dardis" <sean.c.dardis@intel.com>, Farhan Ali <alifm@linux.ibm.com>, Benjamin Block <bblock@linux.ibm.com>, Niklas Schnelle <schnelle@linux.ibm.com>, Alek Du <alek.du@intel.com>, "Mahesh J Salgaonkar" <mahesh@linux.ibm.com>, Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The state_saved flag tells the PCI core whether a driver assumes
responsibility to save Config Space and put the device into a low power
state on suspend.

The flag is currently initialized to false on enumeration, even though it
already is false (because struct pci_dev is zeroed by kzalloc()) and even
though it is set to false before commencing the suspend sequence (the only
code path where it's relevant).

The flag is also set to false in pci_pm_thaw(), i.e. on resume, when it's
no longer relevant.

Drop these two superfluous flag assignments for simplicity.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/pci-driver.c | 2 --
 drivers/pci/probe.c      | 2 --
 2 files changed, 4 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 327b21c48614..7c2d9d596258 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1133,8 +1133,6 @@ static int pci_pm_thaw(struct device *dev)
 		pci_pm_reenable_device(pci_dev);
 	}
 
-	pci_dev->state_saved = false;
-
 	return error;
 }
 
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index c83e75a0ec12..c7c7a3d5ec0f 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2747,8 +2747,6 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
 
 	pci_reassigndev_resource_alignment(dev);
 
-	dev->state_saved = false;
-
 	pci_init_capabilities(dev);
 
 	/*
-- 
2.51.0


