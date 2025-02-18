Return-Path: <linux-pci+bounces-21699-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B09E3A3969E
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 10:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D4C57A4B2B
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 09:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C468C22DF8A;
	Tue, 18 Feb 2025 09:08:34 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F3C7E1;
	Tue, 18 Feb 2025 09:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739869714; cv=none; b=p/i4OAbp+WcqgSxEZNpdtzHu3wzNfLdylmlm4H5lGovHHN4nlmXV4Ct7fnO3tt3sK+Pkzt14BX0eRD9gVbwlNvbbkhp8vkDkjUopir2K8jWgcXABDHherdya8oDC6+qD/yXtNiKgjI2mNltwZSatxyRfdh/35tCclMVxy/PvtWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739869714; c=relaxed/simple;
	bh=dlIRbXNG/mhbn9FYZEriTMHgLPOctd1yhUg4bqvJgwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jsKrrxZAG2Eiuh3NMGgOED+mC6YURTdsHQr9j1Q4YWXSqg8yWGLEDS2QYmzjR4sgcQXDgTr0tjOHjhJbIG7W3+7LBYdNe7op6O6zXljd3Gzsdgp5NnTRGUY0fktdpColWmE8jq9jLBiwTgh3CEid6BvzAOlFsx/15YAD0Py9QJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id CFD6B2800B4BB;
	Tue, 18 Feb 2025 09:59:25 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id C8BC76FD5F3; Tue, 18 Feb 2025 09:59:25 +0100 (CET)
Date: Tue, 18 Feb 2025 09:59:25 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Joel Mathew Thomas <proxy0@tutamail.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI/bwctrl: Disable PCIe BW controller during reset
Message-ID: <Z7RL7ZXZ_vDUbncw@wunner.de>
References: <20250217165258.3811-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250217165258.3811-1-ilpo.jarvinen@linux.intel.com>

On Mon, Feb 17, 2025 at 06:52:58PM +0200, Ilpo Järvinen wrote:
> PCIe BW controller enables BW notifications for Downstream Ports by
> setting Link Bandwidth Management Interrupt Enable (LBMIE) and Link
> Autonomous Bandwidth Interrupt Enable (LABIE) (PCIe Spec. r6.2 sec.
> 7.5.3.7).
> 
> It was discovered that performing a reset can lead to the device
> underneath the Downstream Port becoming unavailable if BW notifications
> are left enabled throughout the reset sequence (at least LBMIE was
> found to cause an issue).

What kind of reset?  FLR?  SBR?  This needs to be specified in the
commit message so that the reader isn't forced to sift through a
bugzilla with dozens of comments and attachments.

The commit message should also mention the type of affected device
(Nvidia GPU AD107M [GeForce RTX 4050 Max-Q / Mobile]).  The Root Port
above is an AMD one, that may be relevant as well.


> While the PCIe Specifications do not indicate BW notifications could not
> be kept enabled during resets, the PCIe Link state during an
> intentional reset is not of large interest. Thus, disable BW controller
> for the bridge while reset is performed and re-enable it after the
> reset has completed to workaround the problems some devices encounter
> if BW notifications are left on throughout the reset sequence.

This approach won't work if the reset is performed without software
intervention.  E.g. if a DPC event occurs, the device likewise undergoes
a reset but there is no prior system software involvement.  Software only
becomes involved *after* the reset has occurred.

I think it needs to be tested if that same issue occurs with DPC.
It's easy to simulate DPC by setting the Software Trigger bit:

setpci -s 00:01.1 ECAP_DPC+6.w=40:40

If the issue does occur with DPC then this fix isn't sufficient.


> Keep a counter for the disable/enable because MFD will execute
> pci_dev_save_and_disable() and pci_dev_restore() back to back for
> sibling devices:
> 
> [   50.139010] vfio-pci 0000:01:00.0: resetting
> [   50.139053] vfio-pci 0000:01:00.1: resetting
> [   50.141126] pcieport 0000:00:01.1: PME: Spurious native interrupt!
> [   50.141133] pcieport 0000:00:01.1: PME: Spurious native interrupt!
> [   50.441466] vfio-pci 0000:01:00.0: reset done
> [   50.501534] vfio-pci 0000:01:00.1: reset done

So why are you citing the PME messages here?  Are they relevant?
Do they not occur when the bandwidth controller is disabled?
If they do not, they may provide a clue what's going on.
But that's not clear from the commit message.


> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5166,6 +5167,9 @@ static void pci_dev_save_and_disable(struct pci_dev *dev)
>  	 */
>  	pci_set_power_state(dev, PCI_D0);
>  
> +	if (bridge)
> +		pcie_bwnotif_disable(bridge);
> +
>  	pci_save_state(dev);

Instead of putting this in the PCI core, amend pcie_portdrv_err_handler
with ->reset_prepare and ->reset_done callbacks which call down to all
the port service drivers, then amend bwctrl.c to disable/enable
interrupts in these callbacks.


> +	port->link_bwctrl->disable_count--;
> +	if (!port->link_bwctrl->disable_count) {
> +		__pcie_bwnotif_enable(port);
> +		pci_dbg(port, "BW notifications enabled\n");
> +	}
> +	WARN_ON_ONCE(port->link_bwctrl->disable_count < 0);

So why do you need to count this?  IIUC you get two consecutive
disable and two consecutive enable events.

If the interrupts are already disabled, just do nothing.
Same for enablement.  Any reason this simpler approach
doesn't work?

Thanks,

Lukas

