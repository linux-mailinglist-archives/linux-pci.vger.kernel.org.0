Return-Path: <linux-pci+bounces-38234-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B840DBDF546
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 17:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2484519C764D
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 15:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242632FB610;
	Wed, 15 Oct 2025 15:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m56r7RMK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A112FBE1A;
	Wed, 15 Oct 2025 15:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760541809; cv=none; b=MO814qEK871Y6SaPhFp8FHrGhSODuqCPBxafzQaXLb9VcNQLgzNB0jma8REcVjaUFEwyK/CIiSTYeoofZEeibzQZkdYHZAAOfjlp8dKORqG0TT97TgQFfQZP1+wRQtrn0I8hEQJLcWySCevMXm07K/IiLHt6tqAeSobLeZh0ZsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760541809; c=relaxed/simple;
	bh=l6kPATXhIfK9tJGsY5Si9o4/LJ8jrOYvZVE72ylEkQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oj3Kw32+Cw/7EnJrIiHGq38KjkVYF+gI5FQZltgVEr9gvx1Tt6uTxW/HigDnkEUD+xAu0r07blHrTrs7kXI8b7ByUcctQijeEJbi2kxs3fT6x7uviEDJQ/qOnS/Q0OH1LfG9Mvb8dbfDQsEapo5eW9NfyXYMkxA7np9Uy9XUf+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m56r7RMK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BA51C4CEF8;
	Wed, 15 Oct 2025 15:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760541808;
	bh=l6kPATXhIfK9tJGsY5Si9o4/LJ8jrOYvZVE72ylEkQ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m56r7RMKJqSqhNWNldofgC9LBpvSoO9uy0ccsWg+V9BC3NJhuu5N5FVlHjHi02vl9
	 Q5O4dn1PUTlgoJnAecjyynFt18RZenLAQ2F7bD3F3+M8lNYItYO1HUd19ZGZvFMBFd
	 NfAuH8olcN61gpWJJtHkNB3/hgCPuYMHDXC5f0KJuoVsHjPFKAB1E9STJg08bkiggE
	 /KBhLX6YoJGe8EgODNQm8rtxNndVVYLUJrkvN/GQt9X+yzunFmfzPf+18jliilGcgK
	 AN8YKNhxnYZ34QJFDaECcPJ5MCNMwagbbYW56rcau3UGCLGmVpEVj+2ML23MhbDB2q
	 w31CY1wFk0vQw==
Date: Wed, 15 Oct 2025 17:23:21 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	manivannan.sadhasivam@oss.qualcomm.com,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	"David E. Box" <david.e.box@linux.intel.com>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Chia-Lin Kao <acelan.kao@canonical.com>,
	Dragan Simic <dsimic@manjaro.org>,
	linux-rockchip@lists.infradead.org, regressions@lists.linux.dev,
	FUKAUMI Naoki <naoki@radxa.com>
Subject: Re: [PATCH v2 1/2] PCI/ASPM: Override the ASPM and Clock PM states
 set by BIOS for devicetree platforms
Message-ID: <aO-8aeJdvApesEqi@ryzen>
References: <22594781424C5C98+22cb5d61-19b1-4353-9818-3bb2b311da0b@radxa.com>
 <20251014184905.GA896847@bhelgaas>
 <5ivvb3wctn65obgqvnajpxzifhndza65rsoiqgracfxl7iiimt@oym345d723o2>
 <823262AB21C8D981+8c1b9d50-5897-432b-972e-b7bb25746ba5@radxa.com>
 <7ugvxl3g5szxhc5ebxnlfllp46lhprjvcg5xp75mobsa44c6jv@h2j3dvm5a4lq>
 <a9ca7843-b780-45aa-9f62-3f443ae06eee@rock-chips.com>
 <aO9tWjgHnkATroNa@ryzen>
 <ud72uxkobylkwy5q5gtgoyzf24ewm7mveszfxr3o7tortwrvw5@kc3pfjr3dtaj>
 <aO-Q3QsxPBXbFieG@ryzen>
 <7df0bf91-8ab1-4e76-83fa-841a4059c634@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7df0bf91-8ab1-4e76-83fa-841a4059c634@rock-chips.com>

On Wed, Oct 15, 2025 at 09:00:41PM +0800, Shawn Lin wrote:
> For now, this is a acceptable option if default ASPM policy enable L1ss
> w/o checking if the HW could supports it... But how about adding
> supports-clkreq stuff to upstream host driver directly? That would help
> folks enable L1ss if the HW is ready and they just need adding property
> to the DT.

I like your idea, if you have time, please send a patch.

However, adding (working) support for L1 substates (via 'supports-clkreq')
is new code, and should thus be queued for next release instead of v6.18.

For now, pcie-dw-rockchip.c is broken for a lot of PCIe devices, so the
fix should be minimal and target v6.18, i.e. something like:
https://lore.kernel.org/linux-pci/20251015123142.392274-2-cassel@kernel.org/

Support for L1 substates via 'supports-clkreq' can be added on top of that
patch (while targeting v6.19).


Kind regards,
Niklas

