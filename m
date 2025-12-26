Return-Path: <linux-pci+bounces-43742-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 45962CDF169
	for <lists+linux-pci@lfdr.de>; Fri, 26 Dec 2025 23:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 078323005193
	for <lists+linux-pci@lfdr.de>; Fri, 26 Dec 2025 22:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24EC226CF7;
	Fri, 26 Dec 2025 22:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b1HEiD2E"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F507E792;
	Fri, 26 Dec 2025 22:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766788321; cv=none; b=pHm6urLVvmdae/i0HfKmLGxi8ETcbfhKk1gn+TNubWYQ3mmL3JSfeyUBHnIraxBKtWe0sRjKIW3OHddlS7x24Co+xzgXseVAHuBZTN5gttyiPOLnFN4b1v8iqnn4M0uYsVpXDI1rx/WT0zUipDXS71XPGzTuvW31eDUc4PbFeCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766788321; c=relaxed/simple;
	bh=J5Jqm5xsdySK6xnw1VOys1NDqCq9XV/QNBpwKwi1/rM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=RKc9dkUjaBCdgHoN/kt2gk1DmNVwbPCPw4YOpM7xmiE2o1OZKjH/zm3T63kJE495FEUXxJCB9mqV/CiyxeanLgtqhnOXKnAYWdrG+NL7JVLUojpPIxTPXnrsKFGNZ3KnY/wXvzh8sGvsj7pOVak9+3r5CFpEBV5VOVncdO2SoiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b1HEiD2E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06D7EC4CEF7;
	Fri, 26 Dec 2025 22:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766788321;
	bh=J5Jqm5xsdySK6xnw1VOys1NDqCq9XV/QNBpwKwi1/rM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=b1HEiD2EHgPf9ffbPpEE6A2XqMeKh/t3qOKgip2nJydL4o3hl5o43AkPq/jBtUmIF
	 478b6PN5m9qR3iMtaxcoWaTX90c/Yqog9RuZBT55YbNj+C4bTYrXtIKMpv9fdC+SXS
	 NY10aMu1C4iiovc9Qh8M0wCPraOdrLjyDbUzKqLIGTP6X8FrjS2An2IMHP5zZ8L36M
	 JHcTs1S61D01i9oLu1Ey7xcj4vVn4r9jVjmeH0V7YIe9tMVH0IRJ5iGgbxgcHDIwVa
	 K5K3TxXbCqnsWRYKvj5+738dMefEX4SZ8ptQoSRdIv7o2EsMk22ECxvJdZh0JApuTe
	 oqJEptSeNxHLA==
Date: Fri, 26 Dec 2025 16:31:59 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	FUKAUMI Naoki <naoki@radxa.com>,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	Damien Le Moal <dlemoal@kernel.org>, stable@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v2 1/6] Revert "PCI: dw-rockchip: Don't wait for link
 since we can detect Link Up"
Message-ID: <20251226223159.GA4143516@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251222064207.3246632-9-cassel@kernel.org>

[+cc Ilpo]

On Mon, Dec 22, 2025 at 07:42:08AM +0100, Niklas Cassel wrote:
> This reverts commit ec9fd499b9c60a187ac8d6414c3c343c77d32e42.
> 
> While this fake hotplugging was a nice idea, it has shown that this feature
> does not handle PCIe switches correctly:
> pci_bus 0004:43: busn_res: can not insert [bus 43-41] under [bus 42-41] (conflicts with (null) [bus 42-41])

Apart from the actual problem you're fixing, it looks like some of our
bus number resource setup is a little deficient here.  The "43-41" and
"42-41" ranges are bogus and "(null)" doesn't tell us anything useful.

> pci_bus 0004:43: busn_res: [bus 43-41] end is updated to 43
> pci_bus 0004:43: busn_res: can not insert [bus 43] under [bus 42-41] (conflicts with (null) [bus 42-41])
> pci 0004:42:00.0: devices behind bridge are unusable because [bus 43] cannot be assigned for them
> pci_bus 0004:44: busn_res: can not insert [bus 44-41] under [bus 42-41] (conflicts with (null) [bus 42-41])
> pci_bus 0004:44: busn_res: [bus 44-41] end is updated to 44
> pci_bus 0004:44: busn_res: can not insert [bus 44] under [bus 42-41] (conflicts with (null) [bus 42-41])
> pci 0004:42:02.0: devices behind bridge are unusable because [bus 44] cannot be assigned for them
> pci_bus 0004:45: busn_res: can not insert [bus 45-41] under [bus 42-41] (conflicts with (null) [bus 42-41])
> pci_bus 0004:45: busn_res: [bus 45-41] end is updated to 45
> pci_bus 0004:45: busn_res: can not insert [bus 45] under [bus 42-41] (conflicts with (null) [bus 42-41])
> pci 0004:42:06.0: devices behind bridge are unusable because [bus 45] cannot be assigned for them
> pci_bus 0004:46: busn_res: can not insert [bus 46-41] under [bus 42-41] (conflicts with (null) [bus 42-41])
> pci_bus 0004:46: busn_res: [bus 46-41] end is updated to 46
> pci_bus 0004:46: busn_res: can not insert [bus 46] under [bus 42-41] (conflicts with (null) [bus 42-41])
> pci 0004:42:0e.0: devices behind bridge are unusable because [bus 46] cannot be assigned for them
> pci_bus 0004:42: busn_res: [bus 42-41] end is updated to 46
> pci_bus 0004:42: busn_res: can not insert [bus 42-46] under [bus 41] (conflicts with (null) [bus 41])
> pci 0004:41:00.0: devices behind bridge are unusable because [bus 42-46] cannot be assigned for them
> pcieport 0004:40:00.0: bridge has subordinate 41 but max busn 46
> 
> During the initial scan, PCI core doesn't see the switch and since the Root
> Port is not hot plug capable, the secondary bus number gets assigned as the
> subordinate bus number. This means, the PCI core assumes that only one bus
> will appear behind the Root Port since the Root Port is not hot plug
> capable.
> 
> This works perfectly fine for PCIe endpoints connected to the Root Port,
> since they don't extend the bus. However, if a PCIe switch is connected,
> then there is a problem when the downstream busses starts showing up and
> the PCI core doesn't extend the subordinate bus number after initial scan
> during boot.

I suppose this is could also be viewed as a resource management
problem.  

Even in the normal hotplug case, we never know what a hot-added
hierarchy will look like, so we hack around it with the compiled-in
DEFAULT_HOTPLUG_BUS_SIZE and the "hpbussize=" kernel parameter.

It would be nice if we could allocate more bus numbers at hot-add (or
link-up) time as needed.  That's hard after drivers have claimed
nearby devices, but in this case there might not be anything nearby.

> The long term plan is to migrate this driver to the pwrctrl framework,
> once it adds proper support for powering up and enumerating PCIe switches.

"Proper" is hiding some important details here.  pwrctrl already
supports powering up and enumerating switches.  I think this refers to
[1], where Mani says the plan is for pwrctrl to power up everything
before the initial bus scan so we can figure out how many buses are
needed.

Bjorn

[1] https://lore.kernel.org/linux-pci/fle74skju2rorxmfdvosmeyrx3g75rysuszov5ofvde2exj4ir@3kfjyfyhczmn/

