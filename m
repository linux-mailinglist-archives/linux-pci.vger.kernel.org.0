Return-Path: <linux-pci+bounces-28825-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7478EACBCA8
	for <lists+linux-pci@lfdr.de>; Mon,  2 Jun 2025 23:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48FD93A1E3B
	for <lists+linux-pci@lfdr.de>; Mon,  2 Jun 2025 21:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282FB1AAA1D;
	Mon,  2 Jun 2025 21:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IfLj37KI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E885A1519B8;
	Mon,  2 Jun 2025 21:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748899187; cv=none; b=pgSDcCOvBtHooVgbmMrpIeRCMl45m0PRrAFjUy7nV1Mjk18Cx/tCSJtjGZ2m4OsBIf5gUb+kS0rGL2Pb2UhmLy3R8WVCiguWxpGbgtr24nxv3o4n4ZSCnnX/Auf9WGwThVXhJX/ISWHk2MPlrj9E3U4tG9UKpsBhfco0nQexm4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748899187; c=relaxed/simple;
	bh=6mj/BlYXhWA2zqQmobSnww4HV6I3qNHM38OyJ0T6thY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=mwUkFrxkSGacY/BX//Bgd+qLZ97EHK+pgZqbwQD3vQwz56yXhrUu2Do4SxWexiX4XSlMMYNxl0hiaWhTq6Jng8wmjJ9wK6H5Q1VW/mxKQHk5lWHzcCIBvWarzJS3Dd7k10umaTm/TnEjAkre9bOWYRjePqFGCpQ0POTYiCuzMd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IfLj37KI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3319DC4CEEB;
	Mon,  2 Jun 2025 21:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748899186;
	bh=6mj/BlYXhWA2zqQmobSnww4HV6I3qNHM38OyJ0T6thY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=IfLj37KIEU0Jy+o62Y0/R/gpmCidEqsAZWzdxwnL5HG85g62rUbIrFSLo1ASjyW0E
	 y087JbYvyqH6P0sxoL5Qky0xSKuJSHtn/j8nE76kFXO/pv8Yvty3tt8qc7yiB5Xyfw
	 oR7816Es3kjDy+NpaxUuATsG/9yz3l6s0Mcf5TX3TWFDvUxPJHfYJve1DpFDrl5/TD
	 aTidwE3xAY+YwOXO+C4kxAEjuR3zzU0LFIplBOpp/6XKnqvxU1wpzdPOrFATsTLkVs
	 9KPt/oUZvn0rRo5D+EdjpdLuaozVtiIt7kB8psup46KAwCEAani/+R9Zz46DS9un6V
	 bN+Em+YzTa7Vg==
Date: Mon, 2 Jun 2025 16:19:44 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Zhou Wang <wangzhou1@hisilicon.com>,
	Will Deacon <will@kernel.org>, Robert Richter <rric@kernel.org>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Marc Zyngier <maz@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>, dingwei@marvell.com,
	cassel@kernel.org, Lukas Wunner <lukas@wunner.de>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 4/5] PCI: host-common: Add link down handling for host
 bridges
Message-ID: <20250602211944.GA150795@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508-pcie-reset-slot-v4-4-7050093e2b50@linaro.org>

On Thu, May 08, 2025 at 12:40:33PM +0530, Manivannan Sadhasivam wrote:
> The PCI link, when down, needs to be recovered to bring it back. But that
> cannot be done in a generic way as link recovery procedure is specific to
> host bridges. So add a new API pci_host_handle_link_down() that could be
> called by the host bridge drivers when the link goes down.

IIUC you plumbed this into the reset path so the standard entries
(pci_reset_function() and the sysfs "reset" files) work can now work
for Root Ports on DT systems just like they do for ACPI systems
(assuming the ACPI systems supply an _RST method for the ports).  That
all sounds good.

> The API will iterate through all the slots and calls the pcie_do_recovery()
> function with 'pci_channel_io_frozen' as the state. This will result in the
> execution of the AER Fatal error handling code. Since the link down
> recovery is pretty much the same as AER Fatal error handling,
> pcie_do_recovery() helper is reused here. First the AER error_detected
> callback will be triggered for the bridge and the downstream devices. Then,
> pci_host_reset_slot() will be called for the slot, which will reset the
> slot using 'reset_slot' callback to recover the link. Once that's done,
> resume message will be broadcasted to the bridge and the downstream devices
> indicating successful link recovery.

We have standard PCIe mechanisms to learn about "link down" events,
e.g., AER Surprise Down error reporting and the Data Link Layer State
Changed events for hot-plug capable ports.

How does this controller-specific "link down" notification relate to
those?  Is this for controllers that don't support those AER or
hotplug mechanisms?  Or is this a different scenario that wouldn't be
covered by them?

If AER is enabled, do we get both the AER interrupt and the controller
"link down" interrupt?

> In case if the AER support is not enabled in the kernel, only
> pci_bus_error_reset() will be called for each slots as there is no way we
> could inform the drivers about link recovery.

