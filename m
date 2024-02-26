Return-Path: <linux-pci+bounces-4058-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9612C86825C
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 22:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9377A1C24C79
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 21:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C219E130E53;
	Mon, 26 Feb 2024 21:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o8gO2b+o"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C6012C7F6;
	Mon, 26 Feb 2024 21:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708981474; cv=none; b=G+pvtH7Ms25tAsze56GJM8v+uyFSAQEbOqnBbHMN5MSORmgqny4krAdfcIE9k+5O7K4XYglcSgpfNKKv9vVP2yLX2ab+0bRiDnkvDatkQS4RaS1DNVLhJU3qY0aXmaZUuuynNQPlClDRWWEL/mKSNDkUp9l5kBfyEE4Fc9M8HWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708981474; c=relaxed/simple;
	bh=89RnyZ57cMkcYSYLt3A7/IVdi02DlIjRAcYRcaIerqw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=i+I/bRLB+B/EwJYQLhWQdxLprJhM6n9Z9Y1HRePes54ZEpCHf4kLjJy1Z32ZfK5ppplJWVMXtZVfPcCu3R8e1a2ljarWkGbvpcHvZKbg+sT6nAQ7zsia5KRjvisPyfxaJIRhigQ5P7Iweemu+O3Fuc6bzYiO10ycNS2R+jufNLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o8gO2b+o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3AC8C433F1;
	Mon, 26 Feb 2024 21:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708981474;
	bh=89RnyZ57cMkcYSYLt3A7/IVdi02DlIjRAcYRcaIerqw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=o8gO2b+otZg0ftsCFVyeLT15vXnNIarCBV7vkeqNY3sUQgL7gfJyYNUSBAVDkQbef
	 6aiZYhW5TwvtMxc5VwHnNqtbUh+5BobuJo54/aZbAtTRVtgzJiAObnzdtqAr33tDbm
	 zpcBBIQo6FZFnLFrK3iOKUJVKfn6KGAuXqT5X94kEFeLc9yv2X8Xwy24zcA1lWPfdX
	 Xg88eb0yWcm9CylwRhdzlt9hTo/E6iHcai8fin57wZM+86KzLlGIcfta2bGOveAzlk
	 TqUoGyInlPG+QRFX55y4ZpwEzxLk3dtio5wIlVhytPp9bK2pQH8zRXGwRnFlbXfXUK
	 qBpYS6z5cqbcA==
Date: Mon, 26 Feb 2024 15:04:32 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"David E . Box" <david.e.box@linux.intel.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Tasev Nikola <tasev.stefanoska@skynet.be>,
	Mark Enriquez <enriquezmark36@gmail.com>,
	Thomas Witt <kernel@witt.link>,
	Werner Sembach <wse@tuxedocomputers.com>,
	Vidya Sagar <vidyas@nvidia.com>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Ricky Wu <ricky_wu@realtek.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v7 2/5] PCI/ASPM: Always build aspm.c
Message-ID: <20240226210432.GA211055@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1ff16a1-bf7e-4704-93b8-4122b739583f@linux.intel.com>

On Sun, Feb 25, 2024 at 10:44:14PM -0800, Kuppuswamy Sathyanarayanan wrote:
> On 2/23/24 12:58 PM, Bjorn Helgaas wrote:
> > From: "David E. Box" <david.e.box@linux.intel.com>
> >
> > Some ASPM-related tasks, such as save and restore of LTR and L1SS
> > capabilities, still need to be performed when CONFIG_PCIEASPM is not
> > enabled. To prepare for these changes, wrap the current code in aspm.c
> > with an #ifdef and always build the file.
> 
> Since save/restore needs to be called even if CONFIG_PCIEASPM is
> not set, why not just leave it in pci.c?

We could do that, but we're accumulating various bits of ASPM-related
suspend/resume functionality (LTR, L1SS, etc) that seem like they fit
better in aspm.c.

Bjorn

