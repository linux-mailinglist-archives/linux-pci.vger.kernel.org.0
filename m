Return-Path: <linux-pci+bounces-7530-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C7F8C6D68
	for <lists+linux-pci@lfdr.de>; Wed, 15 May 2024 22:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E14FE1F22721
	for <lists+linux-pci@lfdr.de>; Wed, 15 May 2024 20:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFCC15ADBE;
	Wed, 15 May 2024 20:51:56 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD336FBF;
	Wed, 15 May 2024 20:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715806315; cv=none; b=gm2NZvT0PX4mJugwaBQQubR4C8k3eKxQhwBA3+EKvXfnEzctJNKzy/APc6v+/i7qTohloEClxn6/NulrXuPDIS/guolkqqkumi5T75nWsy6tUsjPncLSOCZzoILo0i7b0oufTM3dHdkZFIHUjcfy+B+o+5TzMj+XjJ9Rp3EUJIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715806315; c=relaxed/simple;
	bh=RvC8rMcOQQcghqpvTEPFxoT3BZyVRRFgWASfSUmPyzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bIQqffKE7BZn4daZ4eiPJgUC/dflhL4/8wlZLITwYB2TMosCsN3kh/rvCy/z5YX5TT+8fRXebBTwY6O8pI0n+7KwcYv6TFg8KAst3cW2NHptD7JTGtT5yBLMTiv742QtnyNAqOIh25xG/xgPniKpqEoZ6GUqxR9yF7lFMcerAUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id C418C30010C93;
	Wed, 15 May 2024 22:51:43 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id B02AD1F580; Wed, 15 May 2024 22:51:43 +0200 (CEST)
Date: Wed, 15 May 2024 22:51:43 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Esther Shimanovich <eshimanovich@chromium.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Rajat Jain <rajatja@google.com>
Subject: Re: [PATCH v4] PCI: Relabel JHL6540 on Lenovo X1 Carbon 7,8
Message-ID: <ZkUgX_bslFMbL5c-@wunner.de>
References: <CA+Y6NJFyi6e7ype6dTAjxsy5aC80NdVOt+Vg-a0O0y_JsfwSGg@mail.gmail.com>
 <Zi0VLrvUWH6P1_or@wunner.de>
 <CA+Y6NJE8hA+wt+auW1wJBWA6EGMc6CGpmdExr3475E_Yys-Zdw@mail.gmail.com>
 <ZjsKPSgV39SF0gdX@wunner.de>
 <20240510052616.GC4162345@black.fi.intel.com>
 <CA+Y6NJF2Ex6Rwxw0a5V1aMY2OH4=MP5KTtat9x9Ge7y-JBdapw@mail.gmail.com>
 <20240511043832.GD4162345@black.fi.intel.com>
 <20240511054323.GE4162345@black.fi.intel.com>
 <CA+Y6NJF+sJs_zQEF7se5QVMBAhoXJR3Y7x0PHfnBQZyCBbbrQg@mail.gmail.com>
 <ZkUcihZR_ZUUEsZp@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkUcihZR_ZUUEsZp@wunner.de>

On Wed, May 15, 2024 at 10:35:22PM +0200, Lukas Wunner wrote:
> On Wed, May 15, 2024 at 02:53:54PM -0400, Esther Shimanovich wrote:
> > On Wed, May 8, 2024 at 1:23???AM Lukas Wunner <lukas@wunner.de> wrote:
> > > On Wed, May 01, 2024 at 06:23:28PM -0400, Esther Shimanovich wrote:
> > > > On Sat, Apr 27, 2024 at 3:17AM Lukas Wunner <lukas@wunner.de> wrote:
> > > > That is correct, when the user-visible issue occurs, no driver is
> > > > bound to the NHI and XHCI. The discrete JHL chip is not permitted to
> > > > attach to the external-facing root port because of the security
> > > > policy, so the NHI and XHCI are not seen by the computer.
> > >
> > > Could you rework your patch to only rectify the NHI's and XHCI's
> > > device properties and leave the bridges untouched?
> > 
> > So I tried a build with that patch, but it never reached the
> > tb_pci_fixup function

Hm, re-reading your e-mail I'm irritated that you're referring to
"that patch" (singular).  You need at least these five commits:

  thunderbolt: Move struct tb_cm to tb.h
  thunderbolt: Obtain PCIe Device/Function number from DROM
  thunderbolt: Obtain PCIe Device/Function number via Router Operation
  thunderbolt: Associate PCI devices with PCIe Adapters
  thunderbolt: Mark PCIe Adapters on root switch as non-removable

on this branch:

  https://github.com/l1k/linux/commits/thunderbolt_associate_v1

Thanks,

Lukas

