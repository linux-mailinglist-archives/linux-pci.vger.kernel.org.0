Return-Path: <linux-pci+bounces-31239-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBE1AF1249
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 12:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A07DA1636A6
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 10:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C73825B2E4;
	Wed,  2 Jul 2025 10:47:54 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C4A19AD89
	for <linux-pci@vger.kernel.org>; Wed,  2 Jul 2025 10:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751453274; cv=none; b=BEXYAV/dC9ZOurYck8VpGCX0ZEX7J22p5m4SVRh01gjD7yB4S8EBP1P/SiH2+OZDplKOMFPODbrcd0XTzdwV69NACztF/yyyecvws5zE0bw9tmBQDVzyA9Fc1lpQik+IZWHEe00Ke7Mbql/nBjauTKVtY3QnAibj3hiAEpRf6dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751453274; c=relaxed/simple;
	bh=mueIBmRkHOw7+zKo9vy7t8XK9F21CpXo9FP5gI3LfZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C5vDNb5h65nzBRrPzztPYXsXgIjk6RfJOFPHFo0dWccOHM4P7/N/ZX8FVYYquRXPw5RuUDKLX8Z1K4MXWj4YH3R0b2HUOpxTys4sEHW0joHS6AsrFEjJbDP2q/n5HG1DQf8hOYm2fsFI1Dm8BjN2VaD1CXeD0lqiKPsJ4OKFF3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 4DFB22006F45;
	Wed,  2 Jul 2025 12:47:49 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 47A3C3D6A4C; Wed,  2 Jul 2025 12:47:49 +0200 (CEST)
Date: Wed, 2 Jul 2025 12:47:49 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Ben Hutchings <ben@decadent.org.uk>, David Airlie <airlied@redhat.com>,
	Bjorn Helgaas <helgaas@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Andi Kleen <ak@linux.intel.com>, Ahmed Salem <x0rw3ll@gmail.com>,
	Borislav Petkov <bp@alien8.de>, dri-devel@lists.freedesktop.org,
	iommu@lists.linux.dev, linux-pci@vger.kernel.org
Subject: Re: [PATCH] agp/amd64: Bind to unsupported devices only if AGP is
 present
Message-ID: <aGUOVbmH1bObAF1r@wunner.de>
References: <f8ff40f35a9a5836d1371f60e85c09c5735e3c5e.1750497201.git.lukas@wunner.de>
 <b73fbb3e3f03d842f36e6ba2e6a8ad0bb4b904fd.camel@decadent.org.uk>
 <aFalrV1500saBto5@wunner.de>
 <279f63810875f2168c591aab0f30f8284d12fe02.camel@decadent.org.uk>
 <aFa8JJaRP-FUyy6Y@wunner.de>
 <9077aab5304e1839786df9adb33c334d10c69397.camel@decadent.org.uk>
 <98012c55-1e0d-4c1b-b650-5bb189d78009@redhat.com>
 <aFwIu0QveVuJZNoU@wunner.de>
 <eb98477c-2d5c-4980-ab21-6aed8f0451c9@redhat.com>
 <e0bcd0a8-dbb5-4272-a549-1029f4dd0e41@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0bcd0a8-dbb5-4272-a549-1029f4dd0e41@redhat.com>

On Mon, Jun 30, 2025 at 01:10:24PM +0200, Hans de Goede wrote:
> ping? It would be good to get some consensus on how to
> fix this and move forward with a fix. Either the patch from
> this thread; or my patch:
> 
> https://lore.kernel.org/dri-devel/20250625112411.4123-1-hansg@kernel.org/
> 
> Works for me, the most important thing here is to get this
> regression fixed.

You seem to have a machine where you can trigger the
"Resources present before probing" message.

Would you mind enabling CONFIG_DEBUG_DEVRES=y and adding
"log_devres=1" to the kernel command line so that we
can understand what kind of resource is attached to
the AMD IOMMU, and where that happens.

I don't see invocations of devm_*() in arch/x86/ or
drivers/iommu/amd/ that would explain the error message.

Just so that we get a full understanding of the issue,
independently of the AGP driver probing everything.

Thanks!

Lukas

