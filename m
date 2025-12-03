Return-Path: <linux-pci+bounces-42587-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F920CA1675
	for <lists+linux-pci@lfdr.de>; Wed, 03 Dec 2025 20:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 785C13001E17
	for <lists+linux-pci@lfdr.de>; Wed,  3 Dec 2025 19:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232683195E7;
	Wed,  3 Dec 2025 19:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="XsOLNtM7"
X-Original-To: linux-pci@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB154313520;
	Wed,  3 Dec 2025 19:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764790333; cv=none; b=gpcTKnDJFaM+PVL+67xFziLhy0vUCd2IDbMVzS7uW3p2YNvwDSlriCLSrEBPd9zcEkncyni3j9nCgWEJhbjXB0El/7tI4prq91vXfDPdOQMvUyMK+vhrMGNKqq8Mk+LnNR8aCYVgBPh/hxrVXF+icvMTheBEdrpTXrCinGKb9DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764790333; c=relaxed/simple;
	bh=7J/haEe2jPPMVlIHeBdGanxkBTGlWiOxCDuYgzMUSBc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VAKhCy9JJ5XpVJU5YMsl58AZZV5dbYNWtG04321JxsTgdHarimTJbF2jkStDMEjJLCo9o+6aZbvkt04mFzFM0IJVM4qvy1n6k1SLM1Em7p5MkXIM7vvPMu6JxK5y+UV/6exRoipzOzmHR/uoZfRU3aBstJJWi6XoFUcAB+PPIR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=XsOLNtM7; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=dzM2gFSTUC6PerhL0LOCMcH+hd/QgK8jHLRfEBNVN6E=; t=1764790330;
	x=1765395130; b=XsOLNtM7oHdTa3x9lvR5vqi1DNsR78xezyd1N6G+Ma/Jvb6ymzDAUuwViPWB1
	+LVBdyBTPHwhjHoQ0vMVxtzwF0NNFOm2vgaE2Ab9yShMkacbXlx0zi3IcGEwJtAWCMsrHPjWa+hel
	kwaDXi216mfytBeqlOiLlKvOq29SGZUWLGA8nM0drSbHnJvVazQskWU3EdvIpxsKfHFPdbfLCS7yJ
	c6Z0sE9+4LD9A0o+40Ewz7vGJ8tq5kDa80BKxoegweFGtokx3Qmt07XKbzLa+VZDYbPLAHcgyfJNf
	ZX0TaoCZDb1ZiFoYEXS945PR8YuDWeaIXOD0Ltecdpo3HXzvQQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1vQsZz-00000000qwa-2fD8; Wed, 03 Dec 2025 20:31:59 +0100
Received: from p5b13aa34.dip0.t-ipconnect.de ([91.19.170.52] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1vQsZz-00000002fsv-1XeK; Wed, 03 Dec 2025 20:31:59 +0100
Message-ID: <541bb4f91ab1d4145a2bd2891546649a9ed3ec4d.camel@physik.fu-berlin.de>
Subject: Re: [PATCH V2] PCI: Fix PCI bridges not to go to D3Hot on SPARC64
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: =?ISO-8859-1?Q?Ren=E9?= Rebe <rene@exactco.de>, linux-pci@vger.kernel.org
Cc: rafael@kernel.org, mika.westerberg@linux.intel.com, lukas@wunner.de, 
	briannorris@chromium.org, helgaas@kernel.org, linux-kernel@vger.kernel.org,
 	riccardo.mottola@libero.it, mani@kernel.org, mario.limonciello@amd.com
Date: Wed, 03 Dec 2025 20:31:58 +0100
In-Reply-To: <20251203.200526.1986895588669292863.rene@exactco.de>
References: <20251203.200526.1986895588669292863.rene@exactco.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Rene,

On Wed, 2025-12-03 at 20:05 +0100, Ren=C3=A9 Rebe wrote:
> Commit a5fb3ff63287 ("PCI: Allow PCI bridges to go to D3Hot on all
> non-x86") was bisected to break some SPARC64 systems, see two oopses
> below. Fix by not allowing D3Hot on sparc64 while this is being
> further analyzed.

I think your summary is still misleading as at least to me it sounds
like you are providing a patch that fixes the D3Hot state on SPARC64
while in reality you're actually blacklisting the D3 power state on
the platform.

I suggest something like:

"pci: Don't allow D3 power state on sparc64"

This would also match the description of pci_bridge_d3_possible():

/**
 * pci_bridge_d3_possible - Is it possible to put the bridge into D3
 * @bridge: Bridge to check
 *
 * Currently we only allow D3 for some PCIe ports and for Thunderbolt.
 *
 * Return: Whether it is possible to move the bridge to D3.
 *
 * The return value is guaranteed to be constant across the entire lifetime
 * of the bridge, including its hot-removal.
 */

The function pci_bridge_d3_possible() determines whether D3 is allowed
on a certain platform and by adding CONFIG_SPARC64 to the list, you are
explicitly disallowing the use of this power state.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

