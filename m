Return-Path: <linux-pci+bounces-18044-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9401C9EB99A
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 19:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82A3A1680FA
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 18:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD6421420C;
	Tue, 10 Dec 2024 18:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m6iSUlYI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D815A1A0B13;
	Tue, 10 Dec 2024 18:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733856443; cv=none; b=MCPJUyIHNU0rpQzru0frjbuEMhb8GTLll18dts1fNj71LWR8/oMjNJY0bYZe9SbApDvJz9cZdflvdj2ce3nFDJfipwfJl8phnZhyD500eCBcWOFv/KSXh2O84tpijOX8DqDmuCMUamED2fmbOYJvhOHUVgRuvIu1Xb76nR2aY/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733856443; c=relaxed/simple;
	bh=VcmvOTsYBBgG250G2walD9rqrMBEKHED9KFe0t9OF7M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ZUuM3u7jQY54ZTotcgLzAdPneFWfY4QpF6CqosbFgR6+bsq7zGyW0pImWGdyFt9OjTXlMq/xid5sXgVuVxSC8XbqwtcGGKMHH13ETTVCt2dfr7m+kAm6yt9sP3AdYcGKOoW4Csp2aTtYSjl2uDgiwy95jrl6HM5wsX+b2k+cO+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m6iSUlYI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 561A6C4CED6;
	Tue, 10 Dec 2024 18:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733856443;
	bh=VcmvOTsYBBgG250G2walD9rqrMBEKHED9KFe0t9OF7M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=m6iSUlYIkd9eLzfFbztqpgWXvEqFNaccftFx6D8fZpbscm02y/nxY6QhBg7o5L4NL
	 cCrbhEJv2gVH6BUCSt4fmtNvDji1YG7aTJBx20nmEyBXVviUPzpLIGWI/H/fma86c3
	 Ra/ZDj7sq8yfQmdO6T/8cmnNqQbDS1zsfo6UobeJRn4Ngl0EyAGwe7dLuUszA1XDeT
	 jGpRfAfr48B3Ko64HD0sJzYN7cdmOY+5K4n89tBcTabQ3YnMaigeaolsboH+eVJ1kO
	 LblYr/jO9Nu02jhULZizc4rZ2hinFqmLOcManSK/zqdf8gy4036FPKO755T8DPmfjf
	 JZ2zk9M4FAPfA==
Date: Tue, 10 Dec 2024 12:47:20 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-coco@lists.linux.dev, Bjorn Helgaas <bhelgaas@google.com>,
	Lukas Wunner <lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, linux-pci@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: Re: [PATCH 08/11] PCI/IDE: Add IDE establishment helpers
Message-ID: <20241210184720.GA3079867@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173343744264.1074769.10935494914881159519.stgit@dwillia2-xfh.jf.intel.com>

On Thu, Dec 05, 2024 at 02:24:02PM -0800, Dan Williams wrote:
> There are two components to establishing an encrypted link, provisioning
> the stream in config-space, and programming the keys into the link layer
> via the IDE_KM (key management) protocol. These helpers enable the
> former, and are in support of TSM coordinated IDE_KM. When / if native
> IDE establishment arrives it will share this same config-space
> provisioning flow, but for now IDE_KM, in any form, is saved for a
> follow-on change.
> 
> With the TSM implementations of SEV-TIO and TDX Connect in mind this
> abstracts small differences in those implementations. For example, TDX
> Connect handles Root Port registers updates while SEV-TIO expects System
> Software to update the Root Port registers. This is the rationale for
> the PCI_IDE_SETUP_ROOT_PORT flag.
> 
> The other design detail for TSM-coordinated IDE establishment is that
> the TSM manages allocation of stream-ids, this is why the stream_id is
> passed in to pci_ide_stream_setup().

s/stream-ids/Stream IDs/ to match spec usage (also several other
places)

> The flow is:
> 
> pci_ide_stream_probe()
>   Gather stream settings (devid and address filters)
> pci_ide_stream_setup()
>   Program the stream settings into the endpoint, and optionally Root Port)
> pci_ide_enable_stream()
>   Run the stream after IDE_KM

Not sure what "devid" is.  Requester ID?  I suppose it's from
PCI_DEVID(), which does turn out to be the PCIe Requester ID.  I don't
think the spec uses a "devid" term, so I'd prefer the term used in the
spec.

> In support of system administrators auditing where platform IDE stream
> resources are being spent, the allocated stream is reflected as a
> symlink from the host-bridge to the endpoint.

s/host-bridge/host bridge/ to match typical usage (also elsewhere)

> +++ b/Documentation/ABI/testing/sysfs-devices-pci-host-bridge
> @@ -0,0 +1,28 @@
> +What:		/sys/devices/pciDDDDD:BB
> +		/sys/devices/.../pciDDDDD:BB
> +Date:		December, 2024
> +Contact:	linux-pci@vger.kernel.org
> +Description:
> +		A PCI host bridge device parents a PCI bus device topology. PCI
> +		controllers may also parent host bridges. The DDDDD:BB format
> +		convey the PCI domain number and the bus number for root ports
> +		of the host bridge.

"Root ports" doesn't seem quite right here; BB is the root bus number,
and makes sense even for conventional PCI.

I know IDE etc is PCIe-specific, but I think saying "the PCI domain
number and root bus number of the host bridge" would be more accurate
since there can be things other than Root Ports on the root bus, e.g.,
conventional PCI devices, RCiEPs, RCECs, etc.

Typical formatting of domain is %04x.

> +What:		pciDDDDD:BB/streamN:DDDDD:BB:DD:F
> +Date:		December, 2024
> +Contact:	linux-pci@vger.kernel.org
> +Description:
> +		(RO) When a host-bridge has established a secure connection,
> +		typically PCIe IDE, between a host-bridge an endpoint, this
> +		symlink appears. The primary function is to account how many
> +		streams can be returned to the available secure streams pool by
> +		invoking the tsm/disconnect flow. The link points to the
> +		endpoint PCI device at domain:DDDDD bus:BB device:DD function:F.

s/host-bridge an endpoint/host bridge and an endpoint/

> + * Retrieve stream association parameters for devid (RID) and resources
> + * (device address ranges)

This and other exported functions probably should have kernel-doc.
Document only the implemented parts.

> +void pci_ide_stream_probe(struct pci_dev *pdev, struct pci_ide *ide)

> +void pci_ide_stream_teardown(struct pci_dev *pdev, struct pci_ide *ide,
> +			     enum pci_ide_flags flags)
> +{
> +	struct pci_host_bridge *hb = pci_find_host_bridge(pdev->bus);
> +	struct pci_dev *rp = pcie_find_root_port(pdev);
> +
> +	__pci_ide_stream_teardown(pdev, ide);
> +	if (flags & PCI_IDE_SETUP_ROOT_PORT)
> +		__pci_ide_stream_teardown(rp, ide);

Looks like this relies on the caller to supply the same flags as they
previously supplied to pci_ide_stream_setup()?  Could/should we
remember the flags to remove the possibility of leaking the RP setup
or trying to teardown RP setup that wasn't done?

> +++ b/include/linux/pci.h
> @@ -601,6 +601,10 @@ struct pci_host_bridge {
>  	int		domain_nr;
>  	struct list_head windows;	/* resource_entry */
>  	struct list_head dma_ranges;	/* dma ranges resource list */
> +#ifdef CONFIG_PCI_IDE			/* track IDE stream id allocation */
> +	DECLARE_BITMAP(ide_stream_ids, PCI_IDE_SEL_CTL_ID_MAX + 1);
> +	struct resource ide_stream_res; /* track ide stream address association */

Seems like overkill to repeat this.  Probably remove the comment on
the #ifdef and s/ide/IDE/ here.

