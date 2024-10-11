Return-Path: <linux-pci+bounces-14271-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7DF99A0EE
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 12:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D13671C22696
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 10:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00EB210C03;
	Fri, 11 Oct 2024 10:12:45 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAA1210C02
	for <linux-pci@vger.kernel.org>; Fri, 11 Oct 2024 10:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728641565; cv=none; b=Tov18OzQheATDYBGDGniY0kZh2Hr0JTUBwgZaCGaS8Q133yldvIuLJfRyDNVCuiBHJSaGvOAqZN/0TELXK/Q3KbhdJvlY328aUolE7jQIrnnzFE69vq190K1nX0vfrj6yYqvg3tbJ6vT2P7lRSEqiPUxuqywsfGLb9sWvbxBFpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728641565; c=relaxed/simple;
	bh=/dQczJZbtRPZnXfYQLETebiNAkck5yrp8R/8FJYTYio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oxfB0QzArUiJdS4kiXK4PJPPi90L+AFVmj6ZvHwVOZeW4U/1HQ2RNbT+mYUkX0kM7EGRV+WMVyidJIcV+iO4Upsnk1XkDDy2fbf4We4iYkWr4Hq0PcWb1vSYkDs1MByLpfmMEHB04CKQJX7Z4xHOtdlcZtgApwZIGwijfu0WRQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id AA0D02800B6FE;
	Fri, 11 Oct 2024 12:12:39 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 930371FCD0D; Fri, 11 Oct 2024 12:12:39 +0200 (CEST)
Date: Fri, 11 Oct 2024 12:12:39 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Dennis Wassenberg <Dennis.Wassenberg@secunet.com>,
	Rafael Wysocki <rafael@kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	linux-pci@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Mathias Krause <minipli@grsecurity.net>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: Re: [PATCH] PCI: Fix use-after-free of slot->bus on hot remove
Message-ID: <Zwj6Fycjyp6jlgY5@wunner.de>
References: <4bfd4c0e976c1776cd08e76603903b338cf25729.1728579288.git.lukas@wunner.de>
 <20241011054115.GG275077@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011054115.GG275077@black.fi.intel.com>

On Fri, Oct 11, 2024 at 08:41:15AM +0300, Mika Westerberg wrote:
> On Thu, Oct 10, 2024 at 07:10:34PM +0200, Lukas Wunner wrote:
> > Dennis reports a boot crash on recent Lenovo laptops with a USB4 dock.
> > 
> > Since commit 0fc70886569c ("thunderbolt: Reset USB4 v2 host router") and
> > commit 59a54c5f3dbd ("thunderbolt: Reset topology created by the boot
> > firmware"), USB4 v2 and v1 Host Routers are reset on probe of the
> > thunderbolt driver.
> > 
> > The reset clears the Presence Detect State and Data Link Layer Link Active
> > bits at the USB4 Host Router's Root Port and thus causes hot removal of
> > the dock.
> 
> Can't this happen also simply unplug at some part of the PCIe topology?
> I don't think this is specific to TB/USB4.

The crash seems to occur because the boot-time invocation of
pci_bus_add_devices() races with pciehp's pci_stop_and_remove_bus_device().

In principle, yes, on a non-USB4 system you could unplug the dock exactly
when pci_bus_add_devices() is running and cause the same crash, even though
the Host Router is not reset.  But that's very hard to reproduce.
You need to unplug at just the right moment.

In this case however the reset of the Host Router seems to reliably
reproduce the conditions to cause the crash, so I thought it's worth
calling that out explicitly.  USB4 Host Routers are readily available
in the field and becoming more and more commonplace, so chances that
users experience the crash are high -- specifically if they're booting
a USB4 system with attached Thunderbolt devices.

Thanks,

Lukas

