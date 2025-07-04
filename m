Return-Path: <linux-pci+bounces-31510-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D86DAF89F5
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jul 2025 09:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92E3D1681E5
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jul 2025 07:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68E428504B;
	Fri,  4 Jul 2025 07:49:06 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE65284B33
	for <linux-pci@vger.kernel.org>; Fri,  4 Jul 2025 07:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751615346; cv=none; b=Bk8KhAan8OOcC+Az/oh6uyaWiJ4f9KP1Grj+THhLzqPDomcl/lR3ilCmCWanKs7ZDOeQZX47q8UoRPLIG0txYVk3tsp6B863G9ZXrXx4y7fxtuWWUhd5cAMIqSaW/md89RR4fs7KrEqPQV/aCwxDrr2iZHhlJoYpFZeC3rCsKks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751615346; c=relaxed/simple;
	bh=d+xlcVC8qM2JhvOfg7gIEkYGcdbcCX/dUslbPbSSM04=;
	h=Message-ID:From:Date:Subject:To:Cc; b=Dvf8vFdCS0LH24U90kGSEvQr2/F8xxYpgj07IjM2jNtU7j8PxopAUDXj2h2gph1USzVP8T+yqbcEBeBy2UedKCAg9FRN5NP/fVAzxr3H9g9tbEtdFG0h6ArZtqt4rVgxVCkmHR2hJAjhXqxV2ILp4xf8ZwtZDQAsCyQQOZSgZIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by mailout2.hostsharing.net (Postfix) with UTF8SMTPS id 0AA322C1E4C8;
	Fri,  4 Jul 2025 09:38:50 +0200 (CEST)
Received: from localhost (unknown [89.246.108.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by h08.hostsharing.net (Postfix) with UTF8SMTPSA id C81BD61AD92E;
	Fri,  4 Jul 2025 09:38:49 +0200 (CEST)
X-Mailbox-Line: From 53abe6f5ac7c631f95f5d061aa748b192eda0379 Mon Sep 17 00:00:00 2001
Message-ID: <53abe6f5ac7c631f95f5d061aa748b192eda0379.1751614426.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Fri, 4 Jul 2025 09:38:33 +0200
Subject: [PATCH] PCI: Allow drivers to opt in to async probing
To: Bjorn Helgaas <helgaas@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-pci@vger.kernel.org
Cc: Yaron Avizrat <yaron.avizrat@intel.com>, Koby Elbaz <koby.elbaz@intel.com>, Konstantin Sinyuk <konstantin.sinyuk@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>, Even Xu <even.xu@intel.com>, Xinpeng Sun <xinpeng.sun@intel.com>, Jean Delvare <jdelvare@suse.com>, Alexander Usyskin <alexander.usyskin@intel.com>, Adrian Hunter <adrian.hunter@intel.com>, Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Alan Stern <stern@rowland.harvard.edu>, "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Stuart Hayes <stuart.w.hayes@gmail.com>, David Jeffery <djeffery@redhat.com>, Jeremy
  Allison <jallison@ciq.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The PCI core has historically not allowed drivers to opt in to async
probing:  Even though drivers may set "PROBE_PREFER_ASYNCHRONOUS", initial
probing always happens synchronously.  That's because the PCI core uses
device_attach() instead of device_initial_probe().

Should a driver return -EPROBE_DEFER on initial probe, reprobing later on
does honor the PROBE_PREFER_ASYNCHRONOUS setting, which is inconsistent.

The choice of device_attach() is likely not deliberate:  It was introduced
in 2013 with commit 58d9a38f6fac ("PCI: Skip attaching driver in
device_add()"), but asynchronous probing was added two years later with
commit 765230b5f084 ("driver-core: add asynchronous probing support for
drivers").

According to the kernel-doc of "enum probe_type", "the end goal is to
switch the kernel to use asynchronous probing by default".  To this end,
use device_initial_probe() to allow asynchronous probing.  The function
returns void, making the return value check unnecessary.

Initial PCI probing often takes on the order of seconds even on laptops,
so this may speed up booting significantly.

Curiously, a small number of PCI drivers already opt in to asynchronous
probing.  Their maintainters (who are all cc'ed) should watch out for
issues, now that asynchronous probing is not just allowed for deferred
probing, but also initial probing:

hl_pci_driver        drivers/accel/habanalabs/common/habanalabs_drv.c
cxl_pci_driver       drivers/cxl/pci.c
quicki2c_driver      drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
quickspi_driver      drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
i801_driver          drivers/i2c/busses/i2c-i801.c
mei_me_driver        drivers/misc/mei/pci-me.c
mei_vsc_drv          drivers/misc/mei/platform-vsc.c
sdhci_driver         drivers/mmc/host/sdhci-pci-core.c
nvme_driver          drivers/nvme/host/pci.c
ehci_pci_driver      drivers/usb/host/ehci-pci.c
hvfb_pci_stub_driver drivers/video/fbdev/hyperv_fb.c

All other driver maintainers may test asynchronous probing by specifying
the command line parameter "driver_async_probe=drv_name1,drv_name2,...",
and on success setting "probe_type = PROBE_PREFER_ASYNCHRONOUS" in the
pci_driver struct.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/bus.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 69048869ef1c..b77fd30bbfd9 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -341,7 +341,6 @@ void pci_bus_add_device(struct pci_dev *dev)
 {
 	struct device_node *dn = dev->dev.of_node;
 	struct platform_device *pdev;
-	int retval;
 
 	/*
 	 * Can not put in pci_device_add yet because resources
@@ -372,9 +371,7 @@ void pci_bus_add_device(struct pci_dev *dev)
 	if (!dn || of_device_is_available(dn))
 		pci_dev_allow_binding(dev);
 
-	retval = device_attach(&dev->dev);
-	if (retval < 0 && retval != -EPROBE_DEFER)
-		pci_warn(dev, "device attach failed (%d)\n", retval);
+	device_initial_probe(&dev->dev);
 
 	pci_dev_assign_added(dev);
 }
-- 
2.47.2


