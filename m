Return-Path: <linux-pci+bounces-27061-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB442AA5C65
	for <lists+linux-pci@lfdr.de>; Thu,  1 May 2025 10:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60B4B1BC46C3
	for <lists+linux-pci@lfdr.de>; Thu,  1 May 2025 08:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0B620E70C;
	Thu,  1 May 2025 08:57:32 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98297B67F;
	Thu,  1 May 2025 08:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746089852; cv=none; b=LyPlyVr4AOOB0BWdfZXuBUbS+Trna0vzGD2d3Vylc9BhiRMmG3qDcQgqpawTnhOsN7oi5Mr8ctDazMDcrnKC7D/+2T+OcosfRpOJQm+RPHH5Gy8ayq8OZSIR7HhLSq0CE+y50MaQQ1BqthaTOX4fky+FzjgCO9DT7ZV1jkjZQvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746089852; c=relaxed/simple;
	bh=NX5JUCt46+4GqNtg8X+ChtfZbEdZgy9OrKqUvWu2n5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d73Sm4bOpQNB9VkZd6/k1nyTgZuhnj+0k1fCmCHqpiQgxQ08SrzRhz/QF75e9qwo5c8sWxpJ9gvQnFzfu98GAPFPfo9dA29eY08lNMHFhZNGp5upKVejz9owt1jL0FmDcKbROtI0SRZznp9AvbLbQnB+zFN3675hSRhAQQs0KB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 2A2BA200AFFC;
	Thu,  1 May 2025 10:57:14 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 277705CCF5; Thu,  1 May 2025 10:57:20 +0200 (CEST)
Date: Thu, 1 May 2025 10:57:20 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] PCI: Add Extended Tag + MRRS quirk for Xeon 6
Message-ID: <aBM3cLA_sw7iWoJf@wunner.de>
References: <20250422130207.3124-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250422130207.3124-1-ilpo.jarvinen@linux.intel.com>

On Tue, Apr 22, 2025 at 04:02:07PM +0300, Ilpo Järvinen wrote:
> When bifurcated to x2, Xeon 6 Root Port performance is sensitive to the
> configuration of Extended Tags, Max Read Request Size (MRRS), and 10-Bit
> Tag Requester (note: there is currently no 10-Bit Tag support in the
> kernel).
[...]
> Add a quirk that disallows enabling Extended Tags and setting MRRS
> larger than 128B for devices under Xeon 6 Root Ports if the Root Port is
> bifurcated to x2. Reject >128B MRRS only when it is going to be written
> by the kernel (this assumes FW configured a good initial value for MRRS
> in case the kernel is not touching MRRS at all).

I note that there's the existing quirk_brcm_5719_limit_mrrs(),
which limits MRRS to 2048 on certain revisions of Broadcom
Ethernet adapters.  This became necessary to work around an
internal FIFO problem, see commit 2c55a3d08ade ("tg3: Scale back
code that modifies MRRS") and commit 0b471506712d ("tg3: Recode
PCI MRRS adjustment as a PCI quirk").

The quirk works by overriding the MRRS which was originally set
on enumeration by pcie_bus_configure_settings().  The overriding
happens at enable time, i.e. when a driver starts to makes use
of the device:

do_pci_enable_device()
  pci_host_bridge_enable_device()
  pcibios_enable_device()
  pci_fixup_device()
    quirk_brcm_5719_limit_mrrs()

Now if you look further above in do_pci_enable_device(), there's
a call to pci_host_bridge_enable_device(), which invokes the
->enable_device() callback in struct pci_host_bridge.
Currently there's only a single host brige driver implementing
that callback, controller/dwc/pci-imx6.c.

One option would be to set that callback on the host bridge
if a Granite Rapids Root Port is found.  And then enforce the
mrrs limit in the callback.  That approach may be more acceptable
upstream than adding a custom "only_128b_mrrs" bit to struct
pci_host_bridge.

Another option would be to amend x86's pcibios_enable_device()
to check whether there's a Granite Rapids Root Port above the
device and enforce the mrrs limit if so.

The only downside I see is that the Broadcom quirk will run
afterwards and increase the MRRS again.  But it's highly unlikely
that one of these old Broadcom chips is used on a present-day
Granite Rapids server, so it may not be a problem in practice.
And the worst thing that can happen is suboptimal performance.

Thanks,

Lukas

