Return-Path: <linux-pci+bounces-32132-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EED23B05535
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 10:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CCEF1C2291C
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 08:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2367275851;
	Tue, 15 Jul 2025 08:42:52 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719A0275B03
	for <linux-pci@vger.kernel.org>; Tue, 15 Jul 2025 08:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752568972; cv=none; b=s8DySQNthXC9byPmFFlY0pAJigH/+EY3pnp8e8TvpZRQCVvwwLZAP+KEux6jU1ja96pXh3/N7J5im3IvCUQQc5r4TBy7pm0+zZ51IX5b6Ryps9lD3H9O7xujOPwSRDa0GuNvnTEeeq4r7GfW82gs7cNBsEmVUpaVCPE5N4x2dOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752568972; c=relaxed/simple;
	bh=mVzVmrkF0JSuE5ttPZ3Qtmbuc4lHbOO0zQ2M1Uvs7Hk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sVXVMqZzbGorsiIP1NF1QzfuoBYnLBEsYJ66AgioNHfXZw1cBmn/bzUH+0OUh4kMaX9DKasHqjKlmKVGCav1I0lEadIOQtLq78SxWcsvVl40YZHX+nlnqeEMniTm6Wap3f9JD981mQDTot2qhGcjrigZ79GEr0hCdaUh+4MIwNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id CBA822009D01;
	Tue, 15 Jul 2025 10:42:47 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id C2CAC4E81B; Tue, 15 Jul 2025 10:42:47 +0200 (CEST)
Date: Tue, 15 Jul 2025 10:42:47 +0200
From: Lukas Wunner <lukas@wunner.de>
To: dan.j.williams@intel.com, Bjorn Helgaas <helgaas@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-pci@vger.kernel.org, Yaron Avizrat <yaron.avizrat@intel.com>,
	Koby Elbaz <koby.elbaz@intel.com>,
	Konstantin Sinyuk <konstantin.sinyuk@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Jean Delvare <jdelvare@suse.com>,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>,
	Alan Stern <stern@rowland.harvard.edu>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Stuart Hayes <stuart.w.hayes@gmail.com>,
	David Jeffery <djeffery@redhat.com>,
	Jeremy Allison <jallison@ciq.com>
Subject: Re: [PATCH] PCI: Allow drivers to opt in to async probing
Message-ID: <aHYUh7WoDlhHckxd@wunner.de>
References: <53abe6f5ac7c631f95f5d061aa748b192eda0379.1751614426.git.lukas@wunner.de>
 <20250714134502.GB11300@lst.de>
 <aHUSE1Q1V-A-OiUv@wunner.de>
 <20250715061309.GB18672@lst.de>
 <6875f6b72057a_11344100f1@dwillia2-mobl4.notmuch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6875f6b72057a_11344100f1@dwillia2-mobl4.notmuch>

On Mon, Jul 14, 2025 at 11:35:35PM -0700, dan.j.williams@intel.com wrote:
> I too could have swore I see async behavior with cxl_pci. I believe this
> patch is only affecting async behavior when the driver is loaded before
> initial arrival of the PCI device.
> 
> For the typical modular driver case the late arriving driver also
> arranges async probing. Lo and behold on current upstream:
> 
> [   13.002750] __driver_attach: pci 0000:35:00.0: probing driver cxl_pci asynchronously
> 
> ...so this patch is only a change in behavior for built-in drivers
> loaded before PCI initial scan afaics.

Right, thank you!

FWIW, below is a rephrased commit message which seeks to make more
clear that only initial probing of built-in drivers is affected.

In case Bjorn wants to replace the commit on pci/enumeration.
I can also submit this as v2 if desired.  No code changes,
just a rephrased commit message.

-- >8 --

Subject: [PATCH] PCI: Allow built-in drivers to use async initial probing

The PCI core has historically not allowed built-in drivers to opt in to
async initial probing:  Drivers may set "PROBE_PREFER_ASYNCHRONOUS", but
initial probing always happens synchronously.  That's because the PCI core
uses device_attach() instead of device_initial_probe().

Should a driver return -EPROBE_DEFER on initial probe, reprobing later on
does honor the PROBE_PREFER_ASYNCHRONOUS setting.  Modular drivers are
also allowed to probe asynchronously, which is inconsistent.

The choice of device_attach() is likely not deliberate:  It was introduced
in 2013 with commit 58d9a38f6fac ("PCI: Skip attaching driver in
device_add()"), but asynchronous probing was added two years later with
commit 765230b5f084 ("driver-core: add asynchronous probing support for
drivers").

According to the kernel-doc of "enum probe_type", "the end goal is to
switch the kernel to use asynchronous probing by default".  To this end,
use device_initial_probe() to allow asynchronous initial probing.  The
function returns void, making the return value check unnecessary.

Initial PCI probing often takes on the order of seconds even on laptops,
so this may speed up booting significantly.

A small number of PCI drivers already opt in to asynchronous probing.
Their maintainers (who are all cc'ed) should watch out for issues, now
that asynchronous probing is not just allowed for deferred and modular
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
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://patch.msgid.link/53abe6f5ac7c631f95f5d061aa748b192eda0379.1751614426.git.lukas@wunner.de
---
 drivers/pci/bus.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 6904886..b77fd30b 100644
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


