Return-Path: <linux-pci+bounces-23065-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86DBAA551C3
	for <lists+linux-pci@lfdr.de>; Thu,  6 Mar 2025 17:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 055493A55C9
	for <lists+linux-pci@lfdr.de>; Thu,  6 Mar 2025 16:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734E8256C76;
	Thu,  6 Mar 2025 16:45:31 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AD6254AFD;
	Thu,  6 Mar 2025 16:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741279531; cv=none; b=ess6mMMtXu72P4ur4k+QeJ36CFd0HJNsVNlXVhEcddE2ezOkxJwAX/inzcM0m/TsKxQRzecJRefDNjBHUb6ERH36xbTfzDNVNV/w1aspBTcde1a83Vw7xbFiRbrvyFktsvEK1vHMrImH90Gh40NZyzF0uxFY9JkeQhA0lH/c6Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741279531; c=relaxed/simple;
	bh=7UuuaaVSz9RlMCDVG+AMp+rHVx/CzDpvcvHma9J+E3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LdhsHk7/MvLEzrd4reZcZscvYTsu2kVr9goV7n6a8tYYh8sYErK0q+N/IfgLqZcnwhw9AE+YyJv+A9UKwe17fZNaUjlFD+aHG5pKObEoUwJOBOrV4IVAzs3L+v6jaPkvugochVUbNtuGDJ8x2hNjNvmsuzAXl+tyBWncN24WGtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 186F6300115FC;
	Thu,  6 Mar 2025 17:45:24 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id EC69F1D3C2; Thu,  6 Mar 2025 17:45:23 +0100 (CET)
Date: Thu, 6 Mar 2025 17:45:23 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Kenneth Crudup <kenny@panix.com>, Bjorn Helgaas <helgaas@kernel.org>,
	ilpo.jarvinen@linux.intel.com, Bjorn Helgaas <bhelgaas@google.com>,
	Jian-Hong Pan <jhp@endlessos.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nikl??vs Ko??es??ikovs <pinkflames.linux@gmail.com>,
	Andreas Noever <andreas.noever@gmail.com>,
	Michael Jamet <michael.jamet@intel.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>, linux-usb@vger.kernel.org
Subject: Re: diagnosing resume failures after disconnected USB4 drives (Was:
 Re: PCI/ASPM: Fix L1SS saving (linus/master commit 7507eb3e7bfac))
Message-ID: <Z8nRI6xjGl3frMe5@wunner.de>
References: <83d9302a-f743-43e4-9de2-2dd66d91ab5b@panix.com>
 <20250213135911.GG3713119@black.fi.intel.com>
 <a8d6ca75-8f50-4c46-8c67-fcf20d870dcc@panix.com>
 <20250214162948.GJ3713119@black.fi.intel.com>
 <661459dd-67d0-4e1c-bb28-9adf1417f660@panix.com>
 <20250226084404.GM3713119@black.fi.intel.com>
 <Z77ak-4YsdAKXbHr@wunner.de>
 <20250226091958.GN3713119@black.fi.intel.com>
 <Z8YKXC1IXYXctQrZ@wunner.de>
 <20250304082314.GE3713119@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304082314.GE3713119@black.fi.intel.com>

On Tue, Mar 04, 2025 at 10:23:14AM +0200, Mika Westerberg wrote:
> Unfortunately I still see the same hang. I double checked, with revert the
> problem goes a way and with this patch I still see it.
> 
> Steps:
> 
> 1. Boot the system, nothing connected.
> 2. Connect TBT 4 dock to the host.
> 3. Connect TBT 3 NVMe to the TBT4 doc.
> 4. Authorize both PCIe tunnels, verify devices are there.
> 5. Enter s2idle.
> 6. Unplug the TBT 4 dock from the host.
> 7. Exit s2idle.

Thanks for testing.  Would you mind giving the below a spin?

I've realized this can likely be solved in a much easier way:

The ->resume_noirq callback is invoked while traversing down
the hierarchy and the topmost slot which detects device replacement
already marks everything below as disconnected.  Hence any nested
hotplug ports can just skip the replacement check because they're
disconnected as well.

-- >8 --

diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index ff458e6..997841c 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -286,9 +286,12 @@ static int pciehp_suspend(struct pcie_device *dev)
 
 static bool pciehp_device_replaced(struct controller *ctrl)
 {
-	struct pci_dev *pdev __free(pci_dev_put);
+	struct pci_dev *pdev __free(pci_dev_put) = NULL;
 	u32 reg;
 
+	if (pci_dev_is_disconnected(ctrl->pcie->port))
+		return false;
+
 	pdev = pci_get_slot(ctrl->pcie->port->subordinate, PCI_DEVFN(0, 0));
 	if (!pdev)
 		return true;

