Return-Path: <linux-pci+bounces-30291-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1504AAE28F9
	for <lists+linux-pci@lfdr.de>; Sat, 21 Jun 2025 14:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0FB9179CC2
	for <lists+linux-pci@lfdr.de>; Sat, 21 Jun 2025 12:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B016B20371F;
	Sat, 21 Jun 2025 12:29:37 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30870153BD9
	for <linux-pci@vger.kernel.org>; Sat, 21 Jun 2025 12:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750508977; cv=none; b=LdGP1r21w3iaGZFTi38PecPO0nXTiZWphQbcLWTWBWjuPPSgYlTGUkhbc1z25vzH1/7x9Rnqihd+SmByRJmtjMYMXeYshoGtD7CQqVolSgINDhE4rEw8E34LZlhzaE/aYLoOWXDvfPmAIRiUcDen5jmY48mGGSNjdiwL7oQ9veU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750508977; c=relaxed/simple;
	bh=B9/NmsWY3nHQBr0tUcXtW3K/Z0zrpsLFxCripgEsImg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K56QJBXtGrF1KTzOZOUStZws0wgr7F8PJM+jpYKe9l9+YXcdqpW9b0SH9IOOhU5QAl9foOBGzy7IaZMPnfE8NAt7dTw/KHQ4Et96ksT0OPMweSbyZH3rFSCx8yM4+I+iS2xiLQ3uK8sJbBEWY3GAR4uW4QDRQ1JAC1iEfRNsYyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 760EC2C62E1F;
	Sat, 21 Jun 2025 14:29:33 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 58EE73A6357; Sat, 21 Jun 2025 14:29:33 +0200 (CEST)
Date: Sat, 21 Jun 2025 14:29:33 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Ben Hutchings <ben@decadent.org.uk>
Cc: David Airlie <airlied@redhat.com>, Bjorn Helgaas <helgaas@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Andi Kleen <ak@linux.intel.com>, Ahmed Salem <x0rw3ll@gmail.com>,
	Borislav Petkov <bp@alien8.de>, dri-devel@lists.freedesktop.org,
	iommu@lists.linux.dev, linux-pci@vger.kernel.org
Subject: Re: [PATCH] agp/amd64: Bind to unsupported devices only if AGP is
 present
Message-ID: <aFalrV1500saBto5@wunner.de>
References: <f8ff40f35a9a5836d1371f60e85c09c5735e3c5e.1750497201.git.lukas@wunner.de>
 <b73fbb3e3f03d842f36e6ba2e6a8ad0bb4b904fd.camel@decadent.org.uk>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b73fbb3e3f03d842f36e6ba2e6a8ad0bb4b904fd.camel@decadent.org.uk>

On Sat, Jun 21, 2025 at 02:07:40PM +0200, Ben Hutchings wrote:
> On Sat, 2025-06-21 at 11:40 +0200, Lukas Wunner wrote:
> > Since commit 172efbb40333 ("AGP: Try unsupported AGP chipsets on x86-64 by
> > default"), the AGP driver for AMD Opteron/Athlon64 CPUs attempts to bind
> > to any PCI device.
> > 
> > On modern CPUs exposing an AMD IOMMU, this results in a message with
> > KERN_CRIT severity:
> > 
> >   pci 0000:00:00.2: Resources present before probing
> > 
> > The driver used to bind only to devices exposing the AGP Capability, but
> > that restriction was removed by commit 6fd024893911 ("amd64-agp: Probe
> > unknown AGP devices the right way").
> 
> That didn't remove any restriction as the probe function still started
> by checking for an AGP capability.  The change I made was that the
> driver would actually bind to devices with the AGP capability instead of
> starting to use them without binding.

The message above would not be emitted without your change.

The check for the AGP capability in agp_amd64_probe() is too late
to prevent the message.  That's because the message is emitted
before ->probe() is even called.

Thanks,

Lukas

