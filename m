Return-Path: <linux-pci+bounces-22618-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3922A493B3
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 09:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C9603A7918
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 08:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACAAC2505A4;
	Fri, 28 Feb 2025 08:37:41 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387968F6B;
	Fri, 28 Feb 2025 08:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740731861; cv=none; b=Bdxo2zlxnhxONBBBPauRRxwYTPdFOO5kr4BibeyU/UC0LhH+1bCPBmJSVkpJHHQRyxXoIPmO8Zhq++bGOrTAuPG9v7s3ZIPRoX3SaCCwFN3nuyZzU2F1qrE+FbXAMaqkeVuNNbV8slh1OFbgKxTZhiWRocgbe/II594mXdfYf4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740731861; c=relaxed/simple;
	bh=t1cC0LN8Hj3VMl6AlaYbedROqrUYclxdgLf/7ja2sbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dZmtx3l32MsPf64o2fJthBdwffMwFTsQKi2cmZbVdwFMq6qjHAq3oRpPdiEWf1mM+Z5dZiMY2z3JXhoOgzTYt7FJFMMZ0AGtY3m6Mlri29YUbNqtMyVfviZg5eXi6p/7Ky4sBOwW2nig66d70C8q4H16209XKbcqoSs9RI0iqVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 0575130008A25;
	Fri, 28 Feb 2025 09:37:36 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id E321343BB02; Fri, 28 Feb 2025 09:37:35 +0100 (CET)
Date: Fri, 28 Feb 2025 09:37:35 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	Joel Mathew Thomas <proxy0@tutamail.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI/bwctrl: Disable PCIe BW controller during reset
Message-ID: <Z8F1z-gyXJDyR6d0@wunner.de>
References: <20250217165258.3811-1-ilpo.jarvinen@linux.intel.com>
 <Z7RL7ZXZ_vDUbncw@wunner.de>
 <14797a5a-6ded-bf8f-aa0c-128668ba608f@linux.intel.com>
 <Z7_4nMod6jWd-Bi1@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7_4nMod6jWd-Bi1@wunner.de>

On Thu, Feb 27, 2025 at 06:31:08AM +0100, Lukas Wunner wrote:
> pcie_bwnotif_irq() accesses the Link Status register without
> acquiring a runtime PM reference on the PCIe port.  This feels
> wrong and may also contribute to the issue reported here.
> Acquiring a runtime PM ref may sleep, so I think you need to
> change the driver to use a threaded IRQ handler.

I've realized we've had a discussion before why a threaded IRQ handler
doesn't make sense...

https://lore.kernel.org/all/Z35qJ3H_8u5LQDJ6@wunner.de/

...but I'm still worried that a Downstream Port in a nested-switch
configuration may be runtime suspended while the hardirq handler
is running.  Is there anything preventing that from happening?

To access config space of a port, it's sufficient if its upstream
bridge is runtime active (i.e. in PCI D0).

So basically the below is what I have in mind.  This assumes that
the upstream bridge is still in D0 when the interrupt handler runs
because in atomic context we can't wait for it to be runtime resumed.
Seems like a fair assumption to me but what do I know...

-- >8 --

diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
index 0a5e7efbce2c..fea8f7412266 100644
--- a/drivers/pci/pcie/bwctrl.c
+++ b/drivers/pci/pcie/bwctrl.c
@@ -28,6 +28,7 @@
 #include <linux/mutex.h>
 #include <linux/pci.h>
 #include <linux/pci-bwctrl.h>
+#include <linux/pm_runtime.h>
 #include <linux/rwsem.h>
 #include <linux/slab.h>
 #include <linux/types.h>
@@ -235,9 +236,13 @@ static irqreturn_t pcie_bwnotif_irq(int irq, void *context)
 	struct pcie_device *srv = context;
 	struct pcie_bwctrl_data *data = srv->port->link_bwctrl;
 	struct pci_dev *port = srv->port;
+	struct device *parent __free(pm_runtime_put) = port->dev.parent;
 	u16 link_status, events;
 	int ret;
 
+	if (parent)
+		pm_runtime_get_noresume(parent);
+
 	ret = pcie_capability_read_word(port, PCI_EXP_LNKSTA, &link_status);
 	if (ret != PCIBIOS_SUCCESSFUL)
 		return IRQ_NONE;
diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index d39dc863f612..038228de773d 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -448,6 +448,8 @@ static inline int pm_runtime_put(struct device *dev)
 	return __pm_runtime_idle(dev, RPM_GET_PUT | RPM_ASYNC);
 }
 
+DEFINE_FREE(pm_runtime_put, struct device *, if (_T) pm_runtime_put(_T))
+
 /**
  * __pm_runtime_put_autosuspend - Drop device usage counter and queue autosuspend if 0.
  * @dev: Target device.

