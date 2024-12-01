Return-Path: <linux-pci+bounces-17502-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85AA09DF667
	for <lists+linux-pci@lfdr.de>; Sun,  1 Dec 2024 17:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 300C228177D
	for <lists+linux-pci@lfdr.de>; Sun,  1 Dec 2024 16:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA0B1C9DDB;
	Sun,  1 Dec 2024 16:13:07 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1131A1863E;
	Sun,  1 Dec 2024 16:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733069587; cv=none; b=Ow+jHpgsPGX4tVJMFeGSnGm3HZmQ9A+zI80q1vM3TsDXinIeSzbrKLNw+j5Cy5ku2TYdnInyAOaKBEH/QsF9bNLny3a541l/2jV97Ma3M0Typ/BcpgswpBf+Gnfdnk9v6HqbQNPBkD18BbW6mAOcqdvjWoJ+g+UmrhhsjuRH+hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733069587; c=relaxed/simple;
	bh=7KBB2M+bw/oxibR1Zo2rama2+JMGjlEzXMH3y+PATaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JpZ8qvZDvvG+FWjhZ/JGefoximJgh0SWjXyF8zm7uo+bM/yoyTwg7z/Qz9C+46fZn+tWNlZordDUWs6CCC6TVUAA+sMjekYUF9coHc3dCJMMiKBXj6JtgLVi0YqMSINhTJ7rbJbX8+tdiS5u0YMiDClj0xQNg5tePTRGgGwsA6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 69239100E2012;
	Sun,  1 Dec 2024 17:13:00 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 2234831EAEF; Sun,  1 Dec 2024 17:13:00 +0100 (CET)
Date: Sun, 1 Dec 2024 17:13:00 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Brian Norris <briannorris@chromium.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Wilczy??ski <kwilczynski@kernel.org>,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Jon Hunter <jonathanh@nvidia.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>
Subject: Re: [PATCH 6.13] PCI/pwrctrl: Skip NULL of_node when unregistering
Message-ID: <Z0yLDBMAsh0yKWf2@wunner.de>
References: <20241126210443.4052876-1-briannorris@chromium.org>
 <20241129192811.GA2768738@bhelgaas>
 <20241201082108.qy2reqd56mvrd6ku@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241201082108.qy2reqd56mvrd6ku@thinkpad>

On Sun, Dec 01, 2024 at 01:51:08PM +0530, Manivannan Sadhasivam wrote:
> So we create pwrctl devices starting from PCI bridges. This is because,
> in order for the endpoints to be enumerated, the relevant pwrctl drivers
> need to be probed first (i.e., pci_bus_add_device() will be called for
> the endpoints only when they are detected on the bus, but that cannot
> happen until the relevant pwrctl driver is probed). That's why we have
> the loop in pci_pwrctrl_create_devices() to iterate over the children
> of PCI bridges defined in devicetree.

I think a better approach would be to create a pwrctrl device when
the corresponding PCI device is scanned.

In pci_scan_child_bus_extend(), you'll find this loop:

	/* Go find them, Rover! */
	for (devfn = 0; devfn < 256; devfn += 8)
		pci_scan_slot(bus, devfn);

... where pci_scan_slot() reads the Vendor ID to determine whether
a device is present at the devfn address and then goes on to
create the pci_dev.

I think what you want to do is, just before the Vendor ID is read,
create the pwrctrl device and enable power.  The OF node of the
pwrctrl device can be found by way of the devfn, right?  So you
can just search whether an OF node exists for a given devfn.

Moreover, for multifunction devices I think you may want to use
refcounting so that the pwrctrl device does not cut power unless
the refcount reaches zero.

Thanks,

Lukas

