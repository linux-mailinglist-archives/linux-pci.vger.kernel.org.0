Return-Path: <linux-pci+bounces-16591-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92ED09C6110
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 20:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 577E028313D
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 19:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A71218305;
	Tue, 12 Nov 2024 19:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MoJMKH08"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDCC217F28
	for <linux-pci@vger.kernel.org>; Tue, 12 Nov 2024 19:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731438751; cv=none; b=Pg3zEqjD6MHxWVlquU4XwrLgxd06cRJOoAzGGv8Tc20q2IpiCxvdxilKeE1G6FAqfhR1v36BIhY4s4rDselqQE5k9DCUVePBSKO3hpUZ3N1K76BeB2eE/FQHlacWSAhdrDC0VoP2GshaLS9WP5dmZ1Q4jJ8WmVD/fM/hPmEHNaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731438751; c=relaxed/simple;
	bh=Fu0ANexpGo+9DWxm/f3m2vTEDg7+/2TiJS+tk0Hwnj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FbYYh9g7kQbJBqKC6wlSk5+560u3kWDYdPsFJ+YEiMT6pbFyVJjWNOfGAuy+FyuunkrAMTXYcGrIv35MJux5pujJfzwCLFVKuiRmFPALgNrja1OkX6g3i514MmKnLfjws+mNFZzjrUalS+9aH+tC1MT0aK50y6jwrqfvGs4+ikI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MoJMKH08; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 560C4C4CECD;
	Tue, 12 Nov 2024 19:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731438750;
	bh=Fu0ANexpGo+9DWxm/f3m2vTEDg7+/2TiJS+tk0Hwnj0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MoJMKH08FjpP5YdGLTvDZ+fRSANH3KiI38ZhiNpHabG/PukuhLC64dluI9IZItv1V
	 bIuv+Vm0YTMY55XRvGHxV6sEQxYqRb/CmzeVhEHWgelBijkSwBa4ar4Bx8MpNg6tPa
	 d/VpWbCUpCwr6kaR6E2intNWQRYt7MjVRQt/IRf4yIIc6ZTKkLFAleJfZiSid/c0tD
	 F3QvyzDJX33rr4psro4M6dmBks5lUoupeRbkC8zAE0GUDq8F+OJLmoaRdbvDUC3Ukb
	 y2p+hu7ojfaN23fY1KjxDAlw7L1KL1dDPPSjwa4F0PeMcXLJrXBg9tQqaDt0PQUMCm
	 bl02acLgfohHw==
Date: Tue, 12 Nov 2024 12:12:28 -0700
From: Keith Busch <kbusch@kernel.org>
To: Keith Busch <kbusch@meta.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
	alex.williamson@redhat.com, ameynarkhede03@gmail.com,
	raphael.norwitz@nutanix.com
Subject: Re: [PATCHv2 1/2] pci: provide bus reset attribute
Message-ID: <ZzOonIqvefvUdC6h@kbusch-mbp.dhcp.thefacebook.com>
References: <20241025222755.3756162-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025222755.3756162-1-kbusch@meta.com>

On Fri, Oct 25, 2024 at 03:27:54PM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Resetting a bus from an end device only works if it's the only function
> on or below that bus.
> 
> Provide an attribute on the pci_dev bridge device that can perform the
> secondary bus reset. This makes it possible for a user to safely reset
> multiple devices in a single command using the secondary bus reset
> action.

Hi Bjorn, are we okay with this one? I am trying to get some tooling and
processes in place that rely on this reset capability, but I don't want
to get ahead of myself if the kernel side needs to go a different
direction.

