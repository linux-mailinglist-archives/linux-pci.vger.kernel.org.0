Return-Path: <linux-pci+bounces-29252-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C52FAD24E8
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 19:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EF573AEEA8
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 17:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624AF215F4B;
	Mon,  9 Jun 2025 17:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=r26.me header.i=@r26.me header.b="Sp/sfUli"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-24420.protonmail.ch (mail-24420.protonmail.ch [109.224.244.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BD08633F;
	Mon,  9 Jun 2025 17:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749489407; cv=none; b=Q3ETqzmAvBjGSxdQEuWVXcbLOuWlzXL39fpc4yEtlOxmsXGJJoUMmN8zVyMBJHU1HIHRSpdBIp8cv9PYdcTsPNmXLLLpEQV6o4fN/BFuX7O+K2eGfb/r2DwI/oexx+798rEgfTOCrS7E4+Swm0N0nyA1zWWiSIt8dvfvWbXql40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749489407; c=relaxed/simple;
	bh=Mmv4D6m6HZ+ZCvrc/3Fib8VNrQQAmGDeQVCJzexSH1o=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GdsfY+80XBJr4oo3Uw3hHSzV4XGgSAauS8wMkv5EiFqYjOAmEOascAQXNBs/8MMpjEWFwY4Tz4DcZof5cyJpjWxtc/oSZ2VK5iqRaWXuDZTfYsKrER+OnPgHRz19nfSsnqVWlEvGHC3v4V54ET4Fpt0ledmN8kg+eoieFwLisyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=r26.me; spf=pass smtp.mailfrom=r26.me; dkim=pass (2048-bit key) header.d=r26.me header.i=@r26.me header.b=Sp/sfUli; arc=none smtp.client-ip=109.224.244.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=r26.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=r26.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=r26.me;
	s=protonmail3; t=1749489401; x=1749748601;
	bh=Mmv4D6m6HZ+ZCvrc/3Fib8VNrQQAmGDeQVCJzexSH1o=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=Sp/sfUliJPKaIXzhyIwSNHr07c8lSllRGAfnv0Us/I1R4BXWlM5ppZHIGf2APhns5
	 O6Py5r5qNTtNW2Dz6scY3VF0+7pP7uJuCjTUaa0rwNRaBaXiPMbCCV52KX0aILwaCq
	 D4ZGm3ocDCTL0wIcRUYmp3TsIVyoX0isX6388SfHO8Y3wHhgTPrPBYqMWsm/KSYuX6
	 9u8seYphZwyoSn1z5LghRI34dIUzY12awr1f7Yp4gdKm+5nrx1s59tH5Hs5KatvHea
	 EO4h3CtqlqwWijy8CRWy5YSupjkaNB1ULt+R4o7zjuA0kMJJ6uJ1j1oTf9JKvTDHE/
	 IUwP6lsLmdN2g==
Date: Mon, 09 Jun 2025 17:16:37 +0000
To: =?utf-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
From: Rio Liu <rio@r26.me>
Cc: Bjorn Helgaas <bhelgaas@google.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "regressions@lists.linux.dev" <regressions@lists.linux.dev>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [REGRESSION] amdgpu fails to load external RX 580 since PCI: Allow relaxed bridge window tail sizing for optional resources
Message-ID: <onf2nAzOEySlZFoS5IQLCqqJAtiw3K7HmeH7CAghzunYBhYB8NqDT8UAfHHkpG_gWUbQp4flZFWsNyot9HGMELLXeM1oVu71lLB3GKL1AZY=@r26.me>
In-Reply-To: <21d41e66-d019-31c7-1e73-fed80cf54965@linux.intel.com>
References: <o2bL8MtD_40-lf8GlslTw-AZpUPzm8nmfCnJKvS8RQ3NOzOW1uq1dVCEfRpUjJ2i7G2WjfQhk2IWZ7oGp-7G-jXN4qOdtnyOcjRR0PZWK5I=@r26.me> <7a7a3619-902c-06ee-6171-6d8ec2107f97@linux.intel.com> <w3gGcmhWNmeGetzLnhgkjfx0JTEyIOKN5sDu-uShZ_7JWthMgGP6plgDuhDbkYyaA7vtGbdl1WbMTZ5zM80OyJoqUa69krqDpuhqDangkLY=@r26.me> <21d41e66-d019-31c7-1e73-fed80cf54965@linux.intel.com>
Feedback-ID: 77429777:user:proton
X-Pm-Message-ID: cff81bdc5bf1b863859f55e89e5955fe24437d45
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Monday, June 9th, 2025 at PM 1:07, Ilpo J=C3=A4rvinen <ilpo.jarvinen@lin=
ux.intel.com> wrote:

>
>
> Great, thanks for testing.
>
> If you want, you can give your Tested-by tag so I can include it into the
> official submission of the fix.
>
> --
> i.

That sounds good, thanks!

