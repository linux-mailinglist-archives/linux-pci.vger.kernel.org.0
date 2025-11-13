Return-Path: <linux-pci+bounces-41067-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD8FC5645A
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 09:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 567244E608A
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 08:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D593176E4;
	Thu, 13 Nov 2025 08:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CYi4tvZ6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA0DDDD2;
	Thu, 13 Nov 2025 08:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763022145; cv=none; b=Sa6JzjEll7zaXHEgfWb0r7Yx8a1LQB9PMerSS28zddI9Bne0W8FZTZKZQ3vEXSVIlPqzY7AQnexMrgLebHqYKjWmCtPt/xWFULvBr4bzcosrVB8P2vLfSdToAwKf1GbVPEjhTcHL+DvFhRMVtIZzn6EXAtalaICuRGDQaC+yYJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763022145; c=relaxed/simple;
	bh=d4JnKSMp7EczeZ+X8w53xBnHhnFbumU9Pggc4oQpKbQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=lLS+4WElFknCprJBxH+Pf7/m/Tc0HZAJAdcZfcZ2s4DoYcWwON95cujBcUqjIRNnht489oL7IHb9yeOWtz2MKZT0hzBlLK/o8Da/ZDbv9xK63+PNBCjVDw0RJODTW40cAtvAaSka10IZSBlIPFDFDEoGYOD4OvSSWnPQnawtSE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CYi4tvZ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 093DFC113D0;
	Thu, 13 Nov 2025 08:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763022145;
	bh=d4JnKSMp7EczeZ+X8w53xBnHhnFbumU9Pggc4oQpKbQ=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=CYi4tvZ6cDKihLTFtN9yc/+fc7S12dIzUx/ZvLrI+KPQhrz/UA2oftv68VgVrQN0n
	 Mkjra2BqD5aRS6JEZu8lrHvc6Qzv0KP4rbDa2Ti0F3Giy6mHT4+nTRHM5O09ZNPJoz
	 eaNtVd1m4YP7QcGKX18LbdyZsHqqDNFP61qMzZD7XC4nrgFDiiNYUGOGJv/YX8W+08
	 hYfRLkLZuIhdzfP2/sAfFm9FPttXOmyhJe1BCTg08iFe++LEcoj7LFyEQZDP2KGe97
	 f4XC9RpNyj/DRyoCLfHKG43DvoqfDHuEO6e2D/X7N2vMZ0HUesTaFgFR7ZUCsOjjU/
	 IJ5PVrRHqVPNA==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Nov 2025 19:22:15 +1100
Message-Id: <DE7F6RR1NAKW.3DJYO44O73941@kernel.org>
Subject: Re: [PATCH] samples: rust: fix endianness issue in rust_driver_pci
Cc: "Dirk Behme" <dirk.behme@de.bosch.com>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>, "Marko Turk"
 <mt@markoturk.info>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20251101214629.10718-1-mt@markoturk.info>
 <aRRJPZVkCv2i7kt2@vps.markoturk.info>
 <CANiq72kfy3RvCwxp7Y++fKTMrviP5CqC_Zts_NjtEtNCnpU3Mg@mail.gmail.com>
 <CANiq72=yQ1tn0MmxNHPO4qOiGm7xZzHJAdXFsBBwmFdsC37=ZA@mail.gmail.com>
In-Reply-To: <CANiq72=yQ1tn0MmxNHPO4qOiGm7xZzHJAdXFsBBwmFdsC37=ZA@mail.gmail.com>

On Wed Nov 12, 2025 at 8:56 PM AEDT, Miguel Ojeda wrote:
> I guess we could potentially consider something like returning a
> wrapper to force us to explicitly pick either LE or BE to prevent
> things like this.

In general, the I/O backend (e.g. MMIO, I2C, etc.) is supposed to take care
of endianness.

In the case of MMIO we (currently) always assume that the device is
little-endian; this is also what the C functions used to implement the MMIO
backend (e.g. readl()) assume, i.e. they always convert from little-endian =
to
CPU endianness.

I don't think we should do anything else; the cases where we need to deal w=
ith
big-endian devices for MMIO should be extremely rare -- rare enough that th=
ere
aren't even corresponding *_be() implementations for all architectures.

Given that, I think the proper fix is to drop the existing u32::from_le() c=
all
(that ended up in the sample driver by accident) and properly document the
little-endian assumption of the MMIO backend.

(Currently, this simply is the Io structure, but there is a patch series [1=
]
from Zhi splitting things up, so we can start supporting arbitrary I/O
backends.)

@Marko: Two separate patches for this would be very welcome. :)

[1] https://lore.kernel.org/all/20251110204119.18351-1-zhiw@nvidia.com/

