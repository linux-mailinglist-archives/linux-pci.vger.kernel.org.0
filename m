Return-Path: <linux-pci+bounces-30434-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE57AE4BBE
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 19:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 160F83BB028
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 17:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307F4262FFC;
	Mon, 23 Jun 2025 17:23:15 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668B42F24;
	Mon, 23 Jun 2025 17:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750699395; cv=none; b=kTnrsr9b19ly3lGa7+wuOf6vVvcRRo1eqvZ0sUkisSFZ55yN/W8r40Drb+VAhtYuJDPlolzWABWcmaRQ7WCuLcv0uDfrsNBSVpWigso5kU1f1MdyrPT9Y+vhZMv5xtaApns34nRbVDV/zTAEHMsSFImMcxOFRZC30euRvW8rYDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750699395; c=relaxed/simple;
	bh=HxcG78SHmlT0H+i4Hokk04ZJXasBVKuLuR3M0MPUMCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bi9UZDOo+xDfKD8NmbQ28F/rMkb9byAOw8MeAUU4+wU4YYRm9w7XttEv3iCqQeHxlur8LpW3I9d7GrpJKNJYw1PIKLVY1YxPGWUks2bRAmV1pF4Uc7u6nBe/gwVoHvm5NHVBEHijJKza0wP5319DjhKKmOdJn8fSkP56GGQK24A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 5C5602C0666B;
	Mon, 23 Jun 2025 19:23:10 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 56F4117FCC; Mon, 23 Jun 2025 19:23:10 +0200 (CEST)
Date: Mon, 23 Jun 2025 19:23:10 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Mario Limonciello <superm1@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
	linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Mika Westerberg <westeri@kernel.org>
Subject: Re: [PATCH v3 2/2] PCI: Fix runtime PM usage count underflow on
 device unplug
Message-ID: <aFmNfkIWaIA1mq52@wunner.de>
References: <20250620025535.3425049-3-superm1@kernel.org>
 <aFcCaw_IZr-JuUYY@wunner.de>
 <8d4d98b6-fec5-466f-bd2c-059d702c7860@kernel.org>
 <aFeJ83O9PRUrM2Ir@wunner.de>
 <295bf182-7fed-4ffd-93a4-fb5ddf5f1bb4@kernel.org>
 <aFj3jUAM42lSyfpe@wunner.de>
 <aFkEI2jXg7YiwL7b@wunner.de>
 <aFkm8njX-NEIiTcv@wunner.de>
 <CAJZ5v0jfuAjhskbwG1XHByGpdgP1pSHwVSMnz3jcOy7VDyjnRQ@mail.gmail.com>
 <7dde3873-4239-4be8-801a-dcf37472664d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7dde3873-4239-4be8-801a-dcf37472664d@kernel.org>

[cc += Mika]

On Mon, Jun 23, 2025 at 06:37:33AM -0500, Mario Limonciello wrote:
> On 6/23/25 5:11 AM, Rafael J. Wysocki wrote:
> > On Mon, Jun 23, 2025 at 12:05 PM Lukas Wunner <lukas@wunner.de> wrote:
> > > pcie_portdrv_probe() and pcie_portdrv_remove() both call
> > > pci_bridge_d3_possible() to determine whether to use runtime power
> > > management.  The underlying assumption is that pci_bridge_d3_possible()
> > > always returns the same value because otherwise a runtime PM reference
> > > imbalance occurs.
> > > 
> > > That assumption falls apart if the device is inaccessible on ->remove()
> > > due to hot-unplug:  pci_bridge_d3_possible() calls pciehp_is_native(),
> > > which accesses Config Space to determine whether the device is Hot-Plug
> > > Capable.   An inaccessible device generally returns "all ones" for such
> > > Config Read Requests.  Hence the device may seem Hot-Plug Capable on
> > > ->remove() even though it wasn't on ->probe().
> > > 
> > > Use the cached copy of the Hot-Plug Capable bit to avoid the Config Space
> > > access and the resulting runtime PM ref imbalance.
> > > 
> > > Signed-off-by: Lukas Wunner <lukas@wunner.de>
> > 
> > Reviewed-by: Rafael J. Wysocki <rafael@kernel.org>
> 
> Tested-by: Mario Limonciello <mario.limonciello@amd.com>>

I ended up changing the patch significantly, so I did not include
Rafael's Reviewed-by and Mario's Tested-by in the final patch.
My apologies for this!

Looking at the commit which introduced the Config Space read,
5352a44a561d, I got the impression that Mika may have deliberately
avoided using the is_hotplug_bridge flag.  Notably, is_hotplug_bridge
is also set by check_hotplug_bridge() in acpiphp_glue.c, and his
intention was probably to avoid matching those bridges in
pciehp_is_native().

So I decided to err on the side of caution and keep the Config Space
read if pciehp_is_native() is called from hotplug_is_native().
Just to avoid any potential regressions since the fix is tagged for
stable.

I also searched lore for occurrences of the keywords...

  pcieport Runtime PM usage count underflow

...and did find quite a few reports, but this error message was just
a side effect and the reports were about completely different issues.
It does prove though that this bug has existed for a while!

Thanks Laurent for the report and Mario for root-causing this!

Lukas

