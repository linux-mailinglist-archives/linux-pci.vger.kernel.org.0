Return-Path: <linux-pci+bounces-15583-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB7C9B613D
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 12:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA2121F22C81
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 11:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCB21E47BF;
	Wed, 30 Oct 2024 11:17:40 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A231E47BB;
	Wed, 30 Oct 2024 11:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730287060; cv=none; b=G/5Uv+1FNdmVwE+NCo4EcsfnlLm65gz9kH8HD/qDPVVeJFtEJ6aSV4cD4CXwbr3rG5Lw06xFfLteMK6e9ddctfRTU7zekJ6Kv/Aa684VF7yJ+g14bHgL7bQCeJhkkIQ+ag/Utfac5zq/oKSq/uYJ2EY5ODW90zG7N0oP16SRi40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730287060; c=relaxed/simple;
	bh=przTDjQYYTgJs6OmbMeksLnt9utBBFTAptOHzRDnJrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EJWuPfufRtA/23U9+skmQLoU335T8wDsPs18L0Xay5PLmeHsYHwZwrL6R0nznAW2XMqPSWD60Rwp52fl3qiruSbZqgN/Q5MKBqF+LK76n8QNRITusXEQTuJleZvJilasWe8XxyJvrvKldyULtxz0yu3wV3UIUStfpBIqwXHw6CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 4F0E130008206;
	Wed, 30 Oct 2024 12:11:33 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 36BFF22CE34; Wed, 30 Oct 2024 12:11:33 +0100 (CET)
Date: Wed, 30 Oct 2024 12:11:33 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Esther Shimanovich <eshimanovich@chromium.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Rajat Jain <rajatja@google.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	iommu@lists.linux.dev,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] PCI: Detect and trust built-in Thunderbolt chips
Message-ID: <ZyIUZfFuUdAbVf25@wunner.de>
References: <20240910-trust-tbt-fix-v5-1-7a7a42a5f496@chromium.org>
 <20241030001524.GA1180712@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030001524.GA1180712@bhelgaas>

On Tue, Oct 29, 2024 at 07:15:24PM -0500, Bjorn Helgaas wrote:
> I asked on the v4 patch whether we really need to make all this
> ACPI specific, and I'm still curious about that, since we don't
> actually use any ACPI interfaces directly.

The patch works around a deficiency in a Microsoft spec which is
specifically for ACPI-based systems, not devicetree-based systems:

   "ACPI Interface: Device Specific Data (_DSD) for PCIe Root Ports
    In Windows 10 (Version 1803), new ACPI _DSD methods have been added
    to support Modern Standby and PCI hot plug scenarios."

    https://learn.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports

The deficiency is that Microsoft says the ExternalFacingPort property
must be below the Root Port...

   "This ACPI object enables the operating system to identify externally
    exposed PCIe hierarchies, such as Thunderbolt. This object must be
    implemented in the Root Port ACPI device scope."

...but on the systems in question, external-facing ports do not
originate from the Root Port, but from Downstream Ports.
So there's the Root Port (with the external facing property),
below that an Upstream Port and below that a Downstream Port
(which is the actual external facing port).

I'm not sure if Windows on ARM systems use ACPI or devicetree.
I'm also not sure whether the Qualcomm SnapDragon SoCs they use
have Thunderbolt built-in, in which case they won't need a
discrete Thunderbolt controller.  If they don't use discrete
Thunderbolt controllers or if they don't use ACPI, they can't
exhibit the problem.

In any case I haven't heard of any Windows on ARM systems being
affected by the issue.

So it boils down to:  Should we compile the quirk in just in case
ARM-based ACPI systems with discrete Thunderbolt controllers and
problematic ACPI tables show up, or should we constrain it to x86,
which is the only known architecture that actually needs it right now.

My recommendation would be the latter because it's easy to move
code around in the tree, should other arches become affected,
but in the meantime we save memory and compile time on anything
not x86.

Thanks,

Lukas

