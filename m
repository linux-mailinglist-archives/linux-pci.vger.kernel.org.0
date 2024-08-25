Return-Path: <linux-pci+bounces-12180-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D6D95E40E
	for <lists+linux-pci@lfdr.de>; Sun, 25 Aug 2024 17:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ECD21F21647
	for <lists+linux-pci@lfdr.de>; Sun, 25 Aug 2024 15:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75DBF13E02E;
	Sun, 25 Aug 2024 15:06:07 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC356EB7D;
	Sun, 25 Aug 2024 15:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724598367; cv=none; b=X3eeG9QsrOpqLkXK4tagFVuWqBXJFpebQUCuGR0l50s89Rba80cNEmofq7o394yQvse37aXDjDC0lVHnG+X0/yvEY541mU+Y80uXuVfd9WFnaI+SelOGKq2UhP8TDSKUIx7OtFov9796Q7GSvc6HKfn2gi/bUaRq2xpb1SZEgho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724598367; c=relaxed/simple;
	bh=+YVTh7204SngQT2akyPA2USmN9XLTvizFZxyOqYwioQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tK1WqhcMQXKA6I+LW3Loi+UADQiTUX7x4lOsNmJ6stN+PJ2dWnPbPkJOcR2ln5Xg6Nrxlz4N1i2QPfxQhPFG/amH3zT9JfvlszN0saQpifZEUtartIKB2gR/mlN6KOnkBqS952dsHRaQ36e33o9D8uhQMicl2H9EEh5SX5IKZeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id B7341100D9414;
	Sun, 25 Aug 2024 16:57:03 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 59439356248; Sun, 25 Aug 2024 16:57:03 +0200 (CEST)
Date: Sun, 25 Aug 2024 16:57:03 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Esther Shimanovich <eshimanovich@chromium.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Rajat Jain <rajatja@google.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Detect and trust built-in TBT chips
Message-ID: <ZstGP0EgttNAxjp2@wunner.de>
References: <20240806-trust-tbt-fix-v1-1-73ae5f446d5a@chromium.org>
 <20240806220406.GA80520@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806220406.GA80520@bhelgaas>

On Tue, Aug 06, 2024 at 05:04:06PM -0500, Bjorn Helgaas wrote:
> On Tue, Aug 06, 2024 at 09:39:11PM +0000, Esther Shimanovich wrote:
> > Some computers with CPUs that lack Thunderbolt features use discrete
> > Thunderbolt chips to add Thunderbolt functionality. These Thunderbolt
> > chips are located within the chassis; between the root port labeled
> > ExternalFacingPort and the USB-C port.
> 
> So is this fundamentally a firmware defect?  ACPI says a Root Port is
> an "ExternalFacingPort", but the Root Port is actually connected to an
> internal Thunderbolt chip, not an external connector?

We're the victim of an ambiguity in Microsoft's spec here:

The spec says that ExternalFacingPort is used to identify externally
exposed PCIe hierarchies.  But the spec mandates that the property
shall only exist under the Root Port ACPI device scope.

OEMs follow that spec to a T by specifying ExternalFacingPort below
the Root Port, even though the Root Port itself is not external facing
but connects to a discrete Thunderbolt controller which is soldered down
to the mainboard.  In reality the external facing ports extend from the
discrete controller, but Microsoft's spec doesn't allow marking them
as such.

Here's the relevant spec language:

   "This ACPI object enables the operating system to identify externally
    exposed PCIe hierarchies, such as Thunderbolt. This object must be
    implemented in the Root Port ACPI device scope.

    Note: On systems shipping with Windows 10, version 1803, this object
    should only be implemented on PCIe Root Ports of Thunderbolt hierarchies."

    https://learn.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#identifying-externally-exposed-pcie-root-ports

It's probably safe to assume that Microsoft intended the ExternalFacingPort
property to only be used on SoC-integrated Thunderbolt controllers,
in which case a Root Port is indeed external facing.  But that didn't
stop OEMs from also specifying the property on Root Ports above
soldered-down discrete Thunderbolt controllers.  The spec doesn't
explicitly forbid that.

Thanks,

Lukas

