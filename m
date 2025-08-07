Return-Path: <linux-pci+bounces-33588-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0645DB1DF64
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 00:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A27ED726F40
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 22:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71720228C99;
	Thu,  7 Aug 2025 22:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lx9BsPJU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A33B3FE7;
	Thu,  7 Aug 2025 22:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754606321; cv=none; b=K4lAroJ3MDu2jDXWyjyeTZ1TOIPbsvZjohptdCKZTQ3mR8Mqi2MN7gfhNk3zjRpBtXx4hgcqT2LKq7HhQdSj0ADrNZq+yC8U6hnG0ocOulMQm84IX57H7gLSlqE7aWc2coRv7VsCjuG9PiUjnmD40BTO+3WwNGFQVou2cnLglyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754606321; c=relaxed/simple;
	bh=NOsDruw0Hrz6Kt/5+gvfuu03OMeApF667kTdIazO3r8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=nrnoffTSfFtRu3SiOp5cugjSMgyiKB1wbRaUHjj7G4sqFhK9F2W6hOPUNgK/uVbxSLLOZM2rt8ZA6dO4LQ750kCP1IEqsLHfwkGM359RND9SZzbXZ15h/hh4uQNAxOJ6CCnUJZTtxz20VXMKL/s1rTFuo/nPwF2hhnklAb5ofwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lx9BsPJU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93F7DC4CEEB;
	Thu,  7 Aug 2025 22:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754606320;
	bh=NOsDruw0Hrz6Kt/5+gvfuu03OMeApF667kTdIazO3r8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Lx9BsPJU7VeqFedWtDr0pxSFPwZ9fcYOOUqq3NmEkYVHyfEHbvIO5UFNcvnmx16cs
	 G4UVmUNIQLa7h/9ttMQ+qx51bf9bJCOS95KeyQnTXOLCXHbe8IWR95EaWvI0K0gr15
	 1j8R4FsK8+XXfDtzLUAE+ftG0maOWU6tRpOZrXgAMsCJ3rCWkClq/Xiu5Nou43kQAd
	 fDK5G9+EoW80YrpkwJYqLfvzXFLOHW3/pm5uXzXYIMW1gywO16nv8KB6uQcgLAIbqj
	 Ct49U33h4AftbLwoen22tnCjdujptxnPwoFZ1T3fkexQnyoyijRZ0pu3Io4APaQ/NS
	 DzP3KW3QTb6+g==
Date: Thu, 7 Aug 2025 17:38:39 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-coco@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, bhelgaas@google.com, aik@amd.com,
	lukas@wunner.de, Samuel Ortiz <sameo@rivosinc.com>,
	Yilun Xu <yilun.xu@linux.intel.com>
Subject: Re: [PATCH v4 07/10] PCI/IDE: Add IDE establishment helpers
Message-ID: <20250807223839.GA65567@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717183358.1332417-8-dan.j.williams@intel.com>

On Thu, Jul 17, 2025 at 11:33:55AM -0700, Dan Williams wrote:
> There are two components to establishing an encrypted link, provisioning
> the stream in Partner Port config-space, and programming the keys into
> the link layer via IDE_KM (IDE Key Management). This new library,
> drivers/pci/ide.c, enables the former. IDE_KM, via a TSM low-level
> driver, is saved for later.
> 
> With the platform TSM implementations of SEV-TIO and TDX Connect in mind
> this library abstracts small differences in those implementations. For
> example, TDX Connect handles Root Port register setup while SEV-TIO
> expects System Software to update the Root Port registers. This is the
> rationale for fine-grained 'setup' + 'enable' verbs.
> 
> The other design detail for TSM-coordinated IDE establishment is that
> the TSM may manage allocation of Stream IDs, this is why the Stream ID
> value is passed in to pci_ide_stream_setup().
> 
> The flow is:
> 
> pci_ide_stream_alloc()
>   Allocate a Selective IDE Stream Register Block in each Partner Port
>   (Endpoint + Root Port), and reserve a host bridge / platform stream
>   slot. Gather Partner Port specific stream settings like Requester ID.
> pci_ide_stream_register()
>   Publish the stream in sysfs after allocating a Stream ID. In the TSM
>   case the TSM allocates the Stream ID for the Partner Port pair.
> pci_ide_stream_setup()
>   Program the stream settings to a Partner Port. Caller is responsible
>   for optionally calling this for the Root Port as well if the TSM
>   implementation requires it.
> pci_ide_stream_enable()
>   Try to run the stream after IDE_KM.

IIUC this patch doesn't actually add this as a "flow"; it adds these
interfaces, and I guess it's up to callers to use them in a way that
establishes this flow.

Maybe indent a couple spaces and add blank lines between them?

> In support of system administrators auditing where platform, Root Port,
> and Endpoint IDE stream resources are being spent, the allocated stream
> is reflected as a symlink from the host bridge to the endpoint with the
> name:
> 
>     stream%d.%d.%d
> 
> Where the tuple of integers reflects the allocated platform, Root Port,
> and Endpoint stream index (Selective IDE Stream Register Block) values.

> +++ b/Documentation/ABI/testing/sysfs-devices-pci-host-bridge
> +What:		pciDDDD:BB/streamH.R.E
> +Contact:	linux-pci@vger.kernel.org
> +Description:
> +		(RO) When a platform has established a secure connection, PCIe
> +		IDE, between two Partner Ports, this symlink appears. The
> +		primary function is to account the stream slot / resources
> +		consumed in each of the (H)ost bridge, (R)oot Port and
> +		(E)ndpoint that will be freed when invoking the tsm/disconnect
> +		flow. The link points to the endpoint PCI device in the
> +		Selective IDE Stream. "R" and "E" represent the assigned
> +		Selective IDE Stream Register Block in the Root Port and
> +		Endpoint, and "H" represents a platform specific pool of stream
> +		resources shared by the Root Ports in a host bridge. See
> +		/sys/devices/pciDDDD:BB entry for details about the DDDD:BB
> +		format.

s/tsm/TSM/
s/endpoint/Endpoint/

For "(H)ost bridge", "(R)oot Port",

  - Could use "Host bridge (H)", etc, which makes spell checkers work
    better (trivial, I know)

  - What's the format of these parts?  From the patch (and the commit
    log), it looks like they're decimal stream index values?  (I don't
    know enough to know what stream index values are, but presumably
    users will.)

> +++ b/drivers/pci/ide.c
> +int pci_ide_domain(struct pci_dev *pdev)
> +{
> +	if (pdev->fm_enabled)
> +		return pci_domain_nr(pdev->bus);
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pci_ide_domain);

Not mentioned in commit log.  Maybe it doesn't need to be.  The only
call I see is in this file, so it looks like it could even be static.

> +/**
> + * pci_ide_stream_enable() - try to enable a Selective IDE Stream

Do or do not.  There is no try.

> + * @pdev: PCIe device object for either a Root Port or Endpoint Partner Port
> + * @ide: registered and setup IDE settings descriptor
> + *
> + * Activate the stream by writing to the Selective IDE Stream Control
> + * Register, report whether the state successfully transitioned to
> + * secure mode. Note that the state may go "insecure" at any point after
> + * this check, but that is handled via asynchronous error reporting.

Maybe recast this as "Return:" instead of "report whether ..."  At
least, I assume this reporting is done via the return value.

> + */
> +int pci_ide_stream_enable(struct pci_dev *pdev, struct pci_ide *ide)
> +{
> +	struct pci_ide_partner *settings = pci_ide_to_settings(pdev, ide);
> +	int pos;
> +	u32 val;
> +
> +	if (!settings)
> +		return -ENXIO;
> +
> +	pos = sel_ide_offset(pdev, settings);
> +
> +	set_ide_sel_ctl(pdev, ide, pos, true);
> +
> +	pci_read_config_dword(pdev, pos + PCI_IDE_SEL_STS, &val);
> +	if (FIELD_GET(PCI_IDE_SEL_STS_STATE_MASK, val) !=
> +	    PCI_IDE_SEL_STS_STATE_SECURE) {
> +		set_ide_sel_ctl(pdev, ide, pos, false);
> +		return -ENXIO;
> +	}
> +
> +	settings->enable = 1;
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pci_ide_stream_enable);

> +++ b/include/linux/pci-ide.h
> + * struct pci_ide_partner - Per port pair Selective IDE Stream settings
> + * @rid_start: Partner Port Requester ID range start
> + * @rid_start: Partner Port Requester ID range end
> + * @stream_index: Selective IDE Stream Register Block selection
> + * @setup: flag to track whether to run pci_ide_stream_teardown for this parnter slot

Wrap to fit in 80 columns like the rest of the file.  Add "()" after
function name (below too).  Jonathan mentioned the "parnter".

> + * @enable: flag whether to run pci_ide_stream_disable for this parnter slot


