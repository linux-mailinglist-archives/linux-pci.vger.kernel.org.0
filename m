Return-Path: <linux-pci+bounces-36309-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE44B7E1B0
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 14:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D4DF325A19
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 22:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0187529BD88;
	Tue, 16 Sep 2025 22:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJiJZ+uF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB514292B2E;
	Tue, 16 Sep 2025 22:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758062158; cv=none; b=QHIbw8vEGZyV1z9e7WrKLkj3M5sVQQSzfXXazp2TitP8YpEf97cB3n2Tl/zRzCWLhyBnzhGxCcVpq2RcfhzBMutoSd05bBQDvRJ+/9pho1Oxr8YiNkQnE4IBmuIf6mwTFXez9kGn4Bt1FN4Olu+IOBcLBNlxgzdQk7OLNCR976k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758062158; c=relaxed/simple;
	bh=l0E8v9W0wXbu+8pAbt59haAcRrr7gOctSVelRsyJceY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=szVDpWgPqpFMdI1546cwYyH3t6/LzQRIw3huuFlwzHOek+Ok0cbH95c5LBlqBdtcUqSoVMEsiY47HyLNMT/ORcis6KOjqnxTlNhJpw2qfpLYXRu9AO67otrKpCv/pA6j403kYROICnB5AJSMlE+rDyc87A6+9uQyDRiNMcDf9NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gJiJZ+uF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46678C4CEEB;
	Tue, 16 Sep 2025 22:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758062158;
	bh=l0E8v9W0wXbu+8pAbt59haAcRrr7gOctSVelRsyJceY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gJiJZ+uFOszg2pFjCy0mQEorYpZdmPG2saAVXEvOBXZZJa3Cpiwh8pzexVYLKDa/G
	 fZr4+Lv0rZjaizcCO9grSzvYbx6NfCpqbJ6Y4OBZ/FdYuGI4K4be7saQcX23mzm3D7
	 T/wFkMCcBa+UPJYgOlJ6HuIkjMilg9oN+xUNtPEPgb2XNIoO6U1/t8dTbbE2LTMVBf
	 sHa8tBZbm6Y3zuyYu60RqpaV06HeOTCxVM/RoZATYrZfHAmu5QpPDXAz9DrR2dPMg3
	 3OxC9BsTVfyFj3sUiI+5+SvIb/75Q1meBHzE4I1rnSxrd346cpRDcRLIOraQVTDp/O
	 JuBTRcvk+XkDQ==
Date: Tue, 16 Sep 2025 16:35:56 -0600
From: Keith Busch <kbusch@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Matthew Wood <thepacketgeek@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mario Limonciello <superm1@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [RESEND PATCH v7 1/1] PCI/sysfs: Expose PCIe device serial number
Message-ID: <aMnmTMsUWwTwnlWV@kbusch-mbp>
References: <20250821232239.599523-2-thepacketgeek@gmail.com>
 <20250915193904.GA1756590@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915193904.GA1756590@bhelgaas>

On Mon, Sep 15, 2025 at 02:39:04PM -0500, Bjorn Helgaas wrote:
> > @@ -660,6 +677,7 @@ static struct attribute *pcie_dev_attrs[] = {
> >  	&dev_attr_current_link_width.attr,
> >  	&dev_attr_max_link_width.attr,
> >  	&dev_attr_max_link_speed.attr,
> > +	&dev_attr_serial_number.attr,
> 
> I can see that the PCI r3.0 (conventional PCI) spec doesn't include
> the Device Serial Number Capability and the PCIe spec does include it,
> but this seems like it would fit better in the pci_dev_dev_attrs[],
> and the visibility check would be parallel to the
> dev_attr_boot_vga.attr check there.

I'm not sure I agree. The pci_dev_dev_attrs apply to all pci devices,
but DSN only exists in PCIe Extended Capability space. Conventional pci
config requests couldn't even describe it, so seems okay to fence it off
using the PCI-Express attribute group that already has that visibility
barrier.

I also don't like Krzysztof's suggestion to make it visible even if we
know you can't read it. The exisiting attributes that behave that way
shouldn't do that, IMO. It's a waste of resources to provide a handle
just to say the capability doesn't exist when the handle could just not
exist instead.

