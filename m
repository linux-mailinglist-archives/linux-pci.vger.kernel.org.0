Return-Path: <linux-pci+bounces-4735-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 700D3878A98
	for <lists+linux-pci@lfdr.de>; Mon, 11 Mar 2024 23:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EB301C20AEF
	for <lists+linux-pci@lfdr.de>; Mon, 11 Mar 2024 22:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE4B5730A;
	Mon, 11 Mar 2024 22:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EW6u1sT/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D044206B;
	Mon, 11 Mar 2024 22:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710195220; cv=none; b=Vuq7BwzB8KdE2hJqhzt2NfN+Ej0HwrZjHue5/vAX/WIiaJCrUJpuyjW8rdi03YwjJk8kE+ZXzfxfLdLmXqsAi603/WohgHWapMRmnsvk4+cQAFonZGH1yKPZC3ZI5YnUCoL76VwD3jdSxi4jeuyx1hX7HDlBui5P8u7v/YCfZwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710195220; c=relaxed/simple;
	bh=wyNMcjJsj+gtID9qrHH+Nva1VMmxIw4E18MjM2eWoOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=IGxFohrdBnMfzSZvaUFGs4NLEZoO9a8v/1oTHunu5r2cnjJ8m2z/zlJRx7M4fT9SaDCFkaqG5pgjvXFbJ5HQSOTvoeW3OcQQfuo+G0B6yjgL6c1xaZ6bNKcqf3u9kyfdADjE64QaQa1owDJ+PqQSjBGjsAy/SnrKQ/pq6J85wDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EW6u1sT/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59979C433C7;
	Mon, 11 Mar 2024 22:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710195219;
	bh=wyNMcjJsj+gtID9qrHH+Nva1VMmxIw4E18MjM2eWoOQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=EW6u1sT/Othn2NJqcELmkKbqXS7m5AyMi55MTNLBsU85Bs8LgKfT4zPPxGxlcQf3K
	 4Y1vW0z/11Bu2ISrdWtdysTn/guoLZQzBPke3Z2tlbWCSQU5nnmAGhHq5qC5zqqs1c
	 ueNO1ngGPcfOPgg+zVFyegRoO0D9t/EF74OAugN1s5uhQFk5yYaUQalTi/AkWLd3kJ
	 MxnFQIorLx+1ka8BiikJ4CBs/k5D/CD0lkuOB2Yksvso7pwoQsLK3WYnvvbEzOdiCi
	 8V3BS0OW5qEVToMWnM8866WPzKO3T44sGeITtsk4c3OGhjnUPITErcuiSJWbgsZ2Tb
	 gFGz3g2NaloMg==
Date: Mon, 11 Mar 2024 17:13:37 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
Cc: linux-pci@vger.kernel.org, linux-leds@vger.kernel.org,
	Lukas Wunner <lukas@wunner.de>,
	Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: Re: [PATCH 2/2] PCI/NPEM: Add Native PCIe Enclosure Management
 support
Message-ID: <20240311221337.GA819923@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240311104750.00000c24@linux.intel.com>

On Mon, Mar 11, 2024 at 10:47:50AM +0100, Mariusz Tkaczyk wrote:
> On Wed, 6 Mar 2024 16:40:08 -0600
> Bjorn Helgaas <helgaas@kernel.org> wrote:
>  
> > > +	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_NPEM);
> > > +	if (pos == 0)
> > > +		return;
> > > +
> > > +	if (pci_read_config_dword(dev, pos + PCI_NPEM_CAP, &cap) != 0 ||
> > > +	    (cap & PCI_NPEM_CAPABLE) == 0)
> > > +		return;
> > > +
> > > +	/*
> > > +	 * OS should use the DSM for LED control if it is available
> > > +	 * PCI Firmware Spec r3.3 sec 4.7.
> > > +	 */
> > > +	if (npem_has_dsm(dev))
> > > +		return;  
> > 
> > Does Linux have support for this _DSM?  I don't see any, and I guess
> > this check means that if we have a device that supports NPEM on a
> > platform that supplies this _DSM, we can't use NPEM.
> 
> No, Linux doesn't support _DSM. It was proposed in previous
> iterations by Stuart but I dropped it. We decided that it need to be
> strongly rebuild because "pci/pcie" is not right place for ACPI code
> so we cannot register _DSM driver instead of NPEM as it was proposed
> and I don't have _DSM capable hardware to test it.
> 
> > The stated intent of the _DSM (from the Feb 12, 2020 ECN at
> > https://members.pcisig.com/wg/PCI-SIG/document/14025) is to provide
> > NPEM-like functionality via an abstraction layer on top of NPEM, SES,
> > or other implementations.
> > 
> > The _DSM also gives the platform a chance to intercept and change or
> > reject indications requested by OSPM, although that isn't mentioned as
> > part of the intent.
> > 
> > I'm interested in your thoughts about this.  One possibility would be
> > to omit this check for now and add it back when the _DSM is supported,
> > so we could use NPEM directly when advertised by a device.  Or we
> > could keep this as-is and prohibit use of NPEM if the _DSM exists,
> > even though we know how to operate it.
> 
> I decided to implement it 2nd way because I don't know if I can use
> NPEM if _DSM is implemented, I mean that hardware may do not
> response on NPEM requests.  I choose safer approach, I have no
> opinion.

I think your point is that if the _DSM is supported, the platform
itself might be using NPEM internally, and maybe that would conflict
with an OS that uses NPEM directly, which is a good question.

There is no ownership negotiation, e.g., via _OSC, so my assumption is
that the OS owns NPEM by default, and the platform should not touch a
PCI device to operate NPEM after booting the OS.  I guess the platform
must take ownership of the NPEM Capability if the OS uses the _DSM,
although the spec isn't very explicit about this.

One concern here is that if the OS avoids use of NPEM when the _DSM is
present, NPEM will work on the OS we ship today (with NPEM but no _DSM
support), but it will break as soon as a new platform or new firmware
release adds the _DSM, and users will have no way to fix it.

Bjorn

