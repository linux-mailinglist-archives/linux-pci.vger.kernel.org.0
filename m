Return-Path: <linux-pci+bounces-42542-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CECD6C9DC1B
	for <lists+linux-pci@lfdr.de>; Wed, 03 Dec 2025 05:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DF853A671E
	for <lists+linux-pci@lfdr.de>; Wed,  3 Dec 2025 04:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83DC1EF36C;
	Wed,  3 Dec 2025 04:49:43 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192A71DE8AE;
	Wed,  3 Dec 2025 04:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764737383; cv=none; b=rimEstLbt+f3wOGW6Dk+A/PSoIRZ6A11Sc7uD9a9n9BFArMzPJ0EERo4InMMb5Lj/mEdL6TQ+/hNmAegYA+yfZc8kZrowO1Z9eknEMdszqQjswinB8dfcEgO14Pc4w4eBTA6n1vJPkO6Of1vPC6zDD/iyWrM0EeqYzQmHkAkHIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764737383; c=relaxed/simple;
	bh=XV6l3ZQhcW7s/5YbQBfN7Aj2Wu+PsvCzhHJE2Q/1fss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ppWz7qMCgor8lqGGBOgkYVwycbKi1hvZq8MiwDpW+9z+pT77oUF3szvD9fjwzHvemBHnSTZ4e5nIjobTgsCrU70iotOGBrdFldw+kHFux+WMnFRZdA3PFrxeaQYbmpOBPJHKc+aT7+izM7rpl/0z8H02ioHysx1a9Ed+8Uw85CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id CB0602006F7B;
	Wed,  3 Dec 2025 05:49:37 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id ADF1B18B2F; Wed,  3 Dec 2025 05:49:37 +0100 (CET)
Date: Wed, 3 Dec 2025 05:49:37 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Brian Norris <briannorris@chromium.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	=?iso-8859-1?Q?Ren=E9?= Rebe <rene@exactco.de>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Riccardo Mottola <riccardo.mottola@libero.it>,
	Manivannan Sadhasivam <mani@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] PCI: Fix PCI bridges not to go to D3Hot on older RISC
 systems
Message-ID: <aS_BYeSApI2XuPcD@wunner.de>
References: <20251202.174007.745614442598214100.rene@exactco.de>
 <20251202172837.GA3078292@bhelgaas>
 <aS9f-K_MN0uYUCYx@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aS9f-K_MN0uYUCYx@google.com>

[cc += Mika]

On Tue, Dec 02, 2025 at 01:54:00PM -0800, Brian Norris wrote:
> I wonder if we could take a different approach that helps straddle the
> uncertain boundary here a bit:
[...]
>  2) be less aggressive about default-enabling runtime suspend / D3
>  (i.e., only call pm_runtime_allow() in drivers/pci/pcie/portdrv.c in
>  limited circumstances).
[...]
> So instead of portdrv.c calling pm_runtime_allow(), we'd leave that
> decision to user space (i.e., udev or similar). That will help limit the
> impact of getting #1 "wrong." And it's possible the bad systems didn't
> really want aggressive PM anyway, so it's not worth much trouble.

I think runtime PM support in the PCIe port driver was primarily
motivated by the need to power down Thunderbolt controllers when
they're not in use.

A Thunderbolt controller exposes a PCIe switch.  Daisy-chained
Thunderbolt devices are thus visible to the OS as nested switches.
If we followed the approach you're suggesting, users would have to
manually allow runtime PM on every Switch Upstream and Downstream Port
as well as the Root Port and they'd have to do that upon hotplugging
a device.  Yes, yes, users could add a udev rule to allow runtime PM
automatically by default, but that's exactly the policy we have hardcoded
in the kernel right now, so why the change?

I expect massive power regressions for users (not least Chromebook
users) if we made that change.

The discrete Thunderbolt controller in my machine consumes 1.5W
when nothing is attached.  Some laptops have multiple of these.
Recent CPUs with integrated Thunderbolt/USB4 may fail to transition
the package to a low power state unless the Thunderbolt ports go
to D3hot.

So I don't think this approach is a viable option.

Thanks,

Lukas

