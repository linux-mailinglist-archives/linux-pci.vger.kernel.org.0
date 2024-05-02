Return-Path: <linux-pci+bounces-6987-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C4A8B96F7
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2024 10:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D5F01F22270
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2024 08:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50CF45025A;
	Thu,  2 May 2024 08:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ex0ezDMV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3874F895
	for <linux-pci@vger.kernel.org>; Thu,  2 May 2024 08:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714640206; cv=none; b=uOFVHhPK7Rl5TH00Q2h8r2XMPw3lWgf9ORMfADpbiD1wscR5b6G76qLfFdU43plMDlPvWDl/pk+of00cGonMVlpOSMZdyx+oAjqgpwCzgaU2oEYgT3Efx0jxc6Y7ylB+/sUtyKmmsbmbMX8qNbd1Uq4fSittz7ozeJBRX1b/QqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714640206; c=relaxed/simple;
	bh=H1g7kyzP/wVp5EdlOyCCF1WHmSNmHMydS3flSnjyvWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qWxAbQlx9Y2fznAvdvZ6DBeec/8nZtPdCG2PXhHghJVGFhbx60R+HGxVImtp8b38CKx5ifk5CEkY33u8L0M7IrBC96gN+cKgu0MhR5UkTokrGdUUDbgpPX6XYOdUh4V4CZq0YvAYnOMriFK9tSDf4++x45jTzwjeWneRjCpD8Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ex0ezDMV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C2A8C113CC;
	Thu,  2 May 2024 08:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714640205;
	bh=H1g7kyzP/wVp5EdlOyCCF1WHmSNmHMydS3flSnjyvWU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ex0ezDMVcxaDiKCUPAtHNFXAShGkOLjiyB78Exq8eiY4eIqbrMgQh5BLs6h1HXvDT
	 OdBPMeDHOuIargl99FSjNkBqSiiQfGsSuuw2ZUuAKPVIwZ6ny4s4mjVTOIWb6odv4X
	 cKjMY+rvEH+axCVDSg1mcz72BCamBlxO8ch3U5d0S5zNfncomKWpi3YWDIU3W6Q5bl
	 TpxRn8n4gL9ckVlO9GxKwxtJlX6qKgR/TDxwjh+5k2H1wv8phhe8hTlNJq4HU1MK3e
	 hCmU0qBbL/KzVzItwg0lztZxS16ALmxLbgWS/Pay/AePhHUT54qKhXphGc2QJsE8lR
	 SUzWCtaKABFPw==
Date: Thu, 2 May 2024 09:56:39 +0100
From: Keith Busch <kbusch@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Keith Busch <kbusch@meta.com>, linux-pci@vger.kernel.org,
	Suganath Prabu S <suganath-prabu.subramani@broadcom.com>,
	Peter Delevoryas <pdel@meta.com>
Subject: Re: [PATCH] pci: fix broadcom secondary bus reset handling
Message-ID: <ZjNVRzZpPjoG2p3E@kbusch-mbp.dhcp.thefacebook.com>
References: <20240501145118.2051595-1-kbusch@meta.com>
 <ZjK5N_313fwR5YWd@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjK5N_313fwR5YWd@wunner.de>

On Wed, May 01, 2024 at 11:50:47PM +0200, Lukas Wunner wrote:
> On Wed, May 01, 2024 at 07:51:18AM -0700, Keith Busch wrote:
> > After a link reset, the Broadcom / LSI PEX890xx PCIe Gen 5 Switch in synth
> > mode will temporarily insert a fake place-holder device, 1000 02b2, before
> > the link is actually active for the expected downstream device. Confirm
> > the device's identifier matches what we expect before moving forward.
> > Otherwise, the pciehp driver may unmask hotplug notifications before
> > the link is actually active, which triggers an undesired device removal.
> 
> This won't work if the device was hot-swapped with a different one
> and thus correctly returns a different Vendor/Device ID.  We'd wait
> for the device to report the previous device's Vendor/Device ID,
> which doesn't make sense.
> 
> It would be possible to raise d3cold_delay in struct pci_dev for
> children of affected Broadcom switches.  Have you considered that
> as a potential solution?

Good point, there's more paths I need to consider here. The path this is
addressing is through pciehp's reset_slot handling, which temporarily
disables the link change and presence detection. In the error scenario,
the secondary bus reset completes too quickly, which re-enables the
pciehp events before the downstream device has settled. Once it settles,
that triggers a Link Change/PDC event, then we lose our device.

I briefly considered a quirk for d3cold_delay, but I was hoping for
something more programatic than adding an arbitrary delay. That might be
okay though.

