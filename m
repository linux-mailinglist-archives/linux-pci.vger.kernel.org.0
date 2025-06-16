Return-Path: <linux-pci+bounces-29888-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4BDADB960
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 21:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 704523B2F76
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 19:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F7D2868A5;
	Mon, 16 Jun 2025 19:14:11 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C301C7017
	for <linux-pci@vger.kernel.org>; Mon, 16 Jun 2025 19:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750101250; cv=none; b=FCuThf0iU34CDAURWzCg1CkSmYG2qccFbGtMfwq82rtsa4e+2GObHgYZCCgZvR1H2JXm0rI0G/lp0rMD81F7juPw3FE+l8ZAMINkn9Gs+FIX2g2cnVS6ckciTtCrC58l1ShgJRCMKi72PbK3Colw8n/GeeJBfwpY3bHxautGzRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750101250; c=relaxed/simple;
	bh=UErcKVYGP80ixGw8/mROyZVwFW4XAcQq2rmjBnWil3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eqc1V0v59gStCvhm6bzVwmHrYBr+u7HU+aJCaKnH6v+Sj7vPKdK8/xCDtdFno70+PHNCK0Aex15M4KSgaXPz68oSmgQML2w47xcXUKW1XVp7seP+nnuRadVSLrMymvnTOUKP5tGeY72GFQiYqSuUfc5FL6XmJnjDu/NflHXpt9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 0F1FB2C06665;
	Mon, 16 Jun 2025 21:14:05 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id EAEF8325ABB; Mon, 16 Jun 2025 21:14:04 +0200 (CEST)
Date: Mon, 16 Jun 2025 21:14:04 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Daniel Dadap <ddadap@nvidia.com>
Cc: Mario Limonciello <superm1@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	mario.limonciello@amd.com, bhelgaas@google.com,
	Thomas Zimmermann <tzimmermann@suse.de>, linux-pci@vger.kernel.org,
	Hans de Goede <hansg@kernel.org>
Subject: Re: [PATCH] PCI/VGA: Look at all PCI display devices in VGA arbiter
Message-ID: <aFBs_PyM0XAZPb2z@wunner.de>
References: <20250613203130.GA974345@bhelgaas>
 <5ae2fa88-7144-4dd3-9ac6-58f155b2bc36@kernel.org>
 <aEycaB9Hq5ZLMVaO@ddadap-lakeline.nvidia.com>
 <aE0fFIxCmauAHtNM@wunner.de>
 <aFAyzETfBySFRhQC@ddadap-lakeline.nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFAyzETfBySFRhQC@ddadap-lakeline.nvidia.com>

On Mon, Jun 16, 2025 at 10:05:48AM -0500, Daniel Dadap wrote:
> On Sat, Jun 14, 2025 at 09:04:52AM +0200, Lukas Wunner wrote:
> > On Fri, Jun 13, 2025 at 04:47:20PM -0500, Daniel Dadap wrote:
> > > Ideally we'd be able to actually query which GPU is connected to
> > > the panel at the time we're making this determination, but I don't
> > > think there's a uniform way to do this at the moment. Selecting the
> > > integrated GPU seems like a reasonable heuristic, since I'm not
> > > aware of any systems where the internal panel defaults to dGPU
> > > connection, since that would defeat the purpose of having a hybrid
> > > GPU system in the first place
> > 
> > Intel-based dual-GPU MacBook Pros boot with the panel switched to the
> > dGPU by default.  This is done for Windows compatibility because Apple
> > never bothered to implement dynamic GPU switching on Windows.
> > 
> > The boot firmware can be told to switch the panel to the iGPU via an
> > EFI variable, but that's not something the kernel can or should depend on.
> > 
> > MacBook Pros introduced since 2013/2014 hide the iGPU if the panel is
> > switched to the dGPU on boot, but the kernel is now unhiding it since
> > 71e49eccdca6.
> 
> This is good to know. Is vga_switcheroo initialized by the time the code
> in this patch runs? If so, maybe we should query switcheroo to determine
> the GPU which is connected to the panel and favor that one, then fall
> back to the "iGPU is probably right" heuristic otherwise.

Right now vga_switcheroo doesn't seem to provide a function to query the
current mux state.

The driver for the mux on MacBook Pros, apple_gmux.c, can be modular,
so may be loaded fairly late.

Personally I'm booting my MacBook Pro via EFI, so the GPU in use is
whatever efifb is talking to.  However it is possible to boot these
machines in a legacy CSM mode and I don't know what the situation
looks like in that case.

Thanks,

Lukas

