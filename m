Return-Path: <linux-pci+bounces-6986-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5308B96C2
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2024 10:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4949B285690
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2024 08:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5409751C45;
	Thu,  2 May 2024 08:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/Ljw0n0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB345647F
	for <linux-pci@vger.kernel.org>; Thu,  2 May 2024 08:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714639656; cv=none; b=Wgc+r4ZAfX/i7B0tarvtpYpSykHnhhcTlsPNQc9VPNTwn8LYD31LKBd/Qrii/4eXFCykW7sxUwqKHFIonzZbHOmaKSaXzFOcUUbva4H4AyHn0B/ESamX4FTad717LXXpQ8cIIaKDjoauk6sCeEKs0CB+XnQ5wMPfcJbEAeufUzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714639656; c=relaxed/simple;
	bh=LH9lrSL6PXw2t9ptaHLkuvpE25WjkpgeOMt/MKvmDJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m0ljjo8eI1XSoVoJx6g2fuHStLoZRbyCU4OunzAUhYXtEHm/uJvL9hqFm4G9DfAdErQDw9BKTNtd3dFQpmZtTorl6khHRrtdcJmqmZXYU8/2ZBLsUh1mQq7L3oLs5yD9AzSvFlQepwDWr6Jgf5LCeUDcdxRn+XhH2pglqnMyUME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/Ljw0n0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2254EC4AF49;
	Thu,  2 May 2024 08:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714639655;
	bh=LH9lrSL6PXw2t9ptaHLkuvpE25WjkpgeOMt/MKvmDJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J/Ljw0n0pR5tJaUPqlw6BBN+/KS757Dr7MhHpN+WEBWh1pgt5Ky6j4ABm6ZyETAjv
	 w9eMLUQsZ2FdW1KAkigHG3sxQAVPBTdq1is1kI/ViCXWf6aR3Pti5s8fqnMDgi2GT3
	 4u8PYXK0sBX3NwnDsuYQGr4LdcNAyTevPFNtdbD8cI0kXWTBFY7q6fS452K94SAdyX
	 ama/7+46i78wMVnDoVjE2lTgCCAd7LOIVARHClNKjn/vZG5PEYEYhLdG4V9pzaVvSn
	 buODvA/aKm5BD8VcJVJWHy26Y8FaInSGIxWk9BQult/NC1uGzpNrvx9beg4v5ZXpeG
	 dhAtUvifLbHnA==
Date: Thu, 2 May 2024 09:47:31 +0100
From: Keith Busch <kbusch@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, linux-pci@vger.kernel.org,
	Suganath Prabu S <suganath-prabu.subramani@broadcom.com>,
	Peter Delevoryas <pdel@meta.com>, Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH] pci: fix broadcom secondary bus reset handling
Message-ID: <ZjNTI1E3DnGy59Iu@kbusch-mbp.dhcp.thefacebook.com>
References: <20240501145118.2051595-1-kbusch@meta.com>
 <20240501195534.GA853546@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501195534.GA853546@bhelgaas>

On Wed, May 01, 2024 at 02:55:34PM -0500, Bjorn Helgaas wrote:
> On Wed, May 01, 2024 at 07:51:18AM -0700, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > After a link reset, the Broadcom / LSI PEX890xx PCIe Gen 5 Switch in synth
> > mode will temporarily insert a fake place-holder device, 1000 02b2, before
> > the link is actually active for the expected downstream device. Confirm
> > the device's identifier matches what we expect before moving forward.
> > Otherwise, the pciehp driver may unmask hotplug notifications before
> > the link is actually active, which triggers an undesired device removal.
> 
> Is this a Switch that doesn't conform to the PCIe spec, or is there
> something wrong with the way we're looking for a CRS completion?
> 
> In the absence of a device defect, I would not expect to need a
> Broacom-specific comment in this code.

Yeah, you're right. I started off quirking specific devices, then it
evolved to the more generic handling this turned into, but didn't update
the commit log or comments accordingly.

