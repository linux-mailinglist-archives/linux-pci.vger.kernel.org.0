Return-Path: <linux-pci+bounces-2441-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EE583729F
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jan 2024 20:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E3551F25EF2
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jan 2024 19:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6586F3DB86;
	Mon, 22 Jan 2024 19:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQV39dII"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E693D553
	for <linux-pci@vger.kernel.org>; Mon, 22 Jan 2024 19:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705951970; cv=none; b=sfrlB6AauEJjnc6B9m+wpHfv1BRhXdq85dNOWvTDTKh9RZo0x6lSbBaOZZITaGsWRDseqkcR7YEVWcF7/WASdlZPFRY4nt04hMXFYo5T2Xaf6mrl+ix+dD6csSSLE7nK7LwwYsJ8qY0Uqc+BwzokPy6tZ6qSBjPD8JeUlMQGiHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705951970; c=relaxed/simple;
	bh=+CTqE86ejFEzDh3C0eu1DjjD3DcSFQOo3Rginwp5CRo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=rdACIlvCfhfSE9y0yKQZ8lp/IiQ48CT1+RufTGZ44TLdUvuj0Njn2xgqZA15CT9BvpixaVcnDBTyJY60DiDp3vcZmiBl7X/EpGk2zsSI9s4Fir+cDxDYLshHZ9aHSFwB1PEEkIqx2z0doth0LuQnf2uiOA02u+uBhXJ+jqQit84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FQV39dII; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9028EC433C7;
	Mon, 22 Jan 2024 19:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705951969;
	bh=+CTqE86ejFEzDh3C0eu1DjjD3DcSFQOo3Rginwp5CRo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=FQV39dIIOXff94BG/dmg/7tnJehNsy91U603HyUS9Yy8ch8Jtzgrwx6Wqga+dCUCr
	 rPjGy7oNB4HSuaoi6DR0ZxwSdU61CqzNMkAwlIjCiQPqufze7rEMkGDg02GJmOXoRW
	 7SBACZSlTGlivY7cMR+UPO/UdwyuK4IRLJ85dkGtpP5vISEK54plRmKoVNXCpRAKQS
	 KlXMclKms/DQ3M9lbIWuwA2RrVjzFNhynlgVc/jTG72dKqH7SUFQKw0bDAWi51PKG5
	 UwKQRxqMRkv+LsjLulBPzBJFRgV31xvPUn14ONaxEIRQECWF4tbxBqRRS2HU7xn2bW
	 oqWLFW48pIMUQ==
Date: Mon, 22 Jan 2024 13:32:47 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Matthew W Carlis <mattc@purestorage.com>
Cc: sathyanarayanan.kuppuswamy@linux.intel.com, bhelgaas@google.com,
	kbusch@kernel.org, linux-pci@vger.kernel.org, lukas@wunner.de,
	mika.westerberg@linux.intel.com
Subject: Re: [PATCH 1/1] PCI/portdrv: Allow DPC if the OS controls AER
 natively.
Message-ID: <20240122193247.GA278696@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109001508.32359-1-mattc@purestorage.com>

On Mon, Jan 08, 2024 at 05:15:08PM -0700, Matthew W Carlis wrote:
> A small part is probably historical; we've been using DPC on PCIe
> switches since before there was any EDR support in the kernel. It
> looks like there was a PCIe DPC ECN as early as Feb 2012, but this
> EDR/DPC fw ECN didn't come in till Jan 2019 & kernel support for ECN
> was even later. Its not immediately clear I would want to use EDR in
> my newer architecures & then there are also the older architecures
> still requiring support. When I submitted this patch I came at it
> with the approach of trying to keep the old behavior & still support
> the newer EDR behavior. Bjorns patch from Dec 28 2023 would seem to
> change the behavior for both root ports & switch ports, requiring
> them to set _OSC Control Field bit 7 (DPC) and _OSC Support Field
> bit 7 (EDR) or a kernel command line value. I think no matter what,
> we want to ensure that PCIe Root Ports and PCIe switches arrive at
> the same policy here.

Is there an approved DPC ECN to the PCI Firmware spec that adds DPC
control negotiation, but does *not* add the EDR requirement?

I'm looking at
https://members.pcisig.com/wg/PCI-SIG/document/previewpdf/12888, which
seems to be the final "Downstream Port Containment Related
Enhancements" ECN, which is dated 1/28/2019 and applies to the PCI
Firmware spec r3.2.

It adds bit 7, "PCI Express Downstream Port Containment Configuration
control", to the passed-in _OSC Control field, which indicates that
the OS supports both "native OS control and firmware ownership models
(i.e. Error Disconnect Recover notification) of Downstream Port
Containment."

It also adds the dependency that "If the OS sets bit 7 of the Control
field, it must set bit 7 of the Support field, indicating support for
the Error Disconnect Recover event."

So I'm trying to figure out if the "support DPC but not EDR" situation
was ever a valid place to be.  Maybe it's a mistake to have separate
CONFIG_PCIE_DPC and CONFIG_PCIE_EDR options.

CONFIG_PCIE_EDR depends on CONFIG_ACPI, so the situation is a little
bit murky on non-ACPI systems that support DPC.

Bjorn

