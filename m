Return-Path: <linux-pci+bounces-19982-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5679A13E07
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 16:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 634EA16B41F
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 15:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93F822B8D7;
	Thu, 16 Jan 2025 15:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZjayvIUa"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894781DE881;
	Thu, 16 Jan 2025 15:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737042175; cv=none; b=SiQwdpabCXWp32QoS8l10RgtQM1fNsbIpkhjZEjDmIJ8QJtPcFmSgZExDXz1EZcvPWcfptlsJwIJ+i0Dsomlnv7P6p6280b6Fi1kcnY3QEI/kQzSGsNedpIjRilqt8ONt85hA+dUVX0ajg8DJYh40Klgdj1O3LOmUQW4i1D7a18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737042175; c=relaxed/simple;
	bh=nD0X0oy3la4gXRSkQ8W320ykisHeMxZjcoEa/f28P/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=JpPV4c3mBhbhjCEi4amjdKM15CS9R/aeLBRNcv0Rp8dK9Yuyd4LFzdyiffA6/0TgMh+TqNGhuW0uns2irl98nGcBXYbKW54YtkVv6ObM53u7EERgblN6htMz2h2RVrRwErQ3apxcJbbefK541nHDzMuFd1IY9EEsquV/5fP+2v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZjayvIUa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6C28C4CED6;
	Thu, 16 Jan 2025 15:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737042175;
	bh=nD0X0oy3la4gXRSkQ8W320ykisHeMxZjcoEa/f28P/Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ZjayvIUaZR9UjvX27UNiGpuUWHbmuwwZJhz7zm5gsFBLM/l0XXzwxjZtqEM4tpITT
	 FABzM8rLFoBC1Db/z1uqsy0XFiqpCMHXVHeNo7dJX7qJoE1D81HBT+vIugSbBEB6nM
	 IB8mdmWsDuHwhQ3YW47fY3lAMNRWV3Gw3aMoKTjp5MuXg9pm4HEr7Fe546hIo98Byy
	 5oKfsb0XgoThFnFxDwHm3Aklod4Tkce0kpnNVFlml0YESnigMhzk+MC1fq4XFkeukP
	 HMiVKMMqGMRFYEU+RyAmzG4pg6NscdKgoWxzFBUttKtFX5Op1JBGHRb9TBbnBvbNi9
	 ENKpHKwowW4nQ==
Date: Thu, 16 Jan 2025 09:42:53 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: daire.mcnamara@microchip.com
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	conor.dooley@microchip.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ilpo.jarvinen@linux.intel.com,
	kevin.xie@starfivetech.com
Subject: Re: [PATCH v10 1/3] PCI: microchip: Fix outbound address translation
 tables
Message-ID: <20250116154253.GA584488@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115001309.GA508227@bhelgaas>

On Tue, Jan 14, 2025 at 06:13:10PM -0600, Bjorn Helgaas wrote:
> On Fri, Oct 11, 2024 at 03:00:41PM +0100, daire.mcnamara@microchip.com wrote:
> > From: Daire McNamara <daire.mcnamara@microchip.com>
> > 
> > On Microchip PolarFire SoC (MPFS) the PCIe Root Port can be behind one of
> > three general-purpose Fabric Interface Controller (FIC) buses that
> > encapsulate an AXI-M interface. That FIC is responsible for managing
> > the translations of the upper 32-bits of the AXI-M address. On MPFS,
> > the Root Port driver needs to take account of that outbound address
> > translation done by the parent FIC bus before setting up its own
> > outbound address translation tables.  In all cases on MPFS,
> > the remaining outbound address translation tables are 32-bit only.
> > 
> > Limit the outbound address translation tables to 32-bit only.
> 
> I don't quite understand what this is saying.  It seems like the code
> keeps only the low 32 bits of a PCI address and throws away any
> address bits above the low 32.
> 
> If that's what the FIC does, I wouldn't describe the FIC as
> "translating the upper 32 bits" since it sounds like the translation
> is just truncation.
> 
> I guess it must be more complicated than that?  I assume you can still
> reach BARs that have PCI addresses above 4GB using CPU loads/stores?
> 
> The apertures through the host bridge for MMIO access are described by
> DT ranges properties, so this must be something that can't be
> described that way?

Ping?  I'd really like to understand this before the v6.14 merge
window opens on Sunday.

Bjorn

