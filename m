Return-Path: <linux-pci+bounces-41069-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BA35AC5654E
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 09:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1F3D14E3FF3
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 08:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E46C332EBF;
	Thu, 13 Nov 2025 08:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aScoYiCc"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418F1332EA5;
	Thu, 13 Nov 2025 08:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763023014; cv=none; b=V58f1//tNDQOjGTB+VDCES8n58jvIlr1iV5g6RT4+GcGT4bL/QrNsZTJ5z6HiYqz+72fYVihWDDtgigsgfDjc3OP6rZ9i/rbzlvtI4GjdiJvj+3NbiM+auJ7yNBZYDBF5J4wMJa87bv0syMR0dqMeTrzxPtiFuuDo03ctmId/xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763023014; c=relaxed/simple;
	bh=9EJM89dqS8V7H2HgA9yh7GOCyNrBNciwpjIAAoGDgfw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=jflmgpLm93/rczoN+5898sgIYEev9kNprZvkM4Pkr5Z6Jqtynh7pJcm6Ww07MVwp+0aS59obiCkMP2T5zkqhP/WTCFRezQ8BMVCIRaSsT/X4ghBqtWtWKanaG8yjMEmIOEunKuSJAyx1N27A8RSblC/Nj2a9Kra3H0KFc8F88MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aScoYiCc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94EDBC4CEF5;
	Thu, 13 Nov 2025 08:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763023013;
	bh=9EJM89dqS8V7H2HgA9yh7GOCyNrBNciwpjIAAoGDgfw=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=aScoYiCcFo/WXTh8dWelB49gVEU72Pywt6yw3q+S+gtnIv3/oTQPeWWgw1hRLiTrM
	 /1VHMidNrv9nwaA2sdADvwNdDGrdGgrKGeLnz3Ygsjp6ATh6vdzJVi2oWQYj478SNO
	 f5vtn3kWvLGi3nvc8PozFi2DhaNnQ+ecRzswnTk4vUyBt/uyqbDQ+B3xFMHS7NUKed
	 OIBM1HIVIlIZBZL5ByMp/EBECq74y+/uzak77btDS0mPnRuJ1ydvDb+jcjqsn1vTtr
	 4nDczPT68KZ6O2rhWj3ZtmQ3y9A9JmdGboefJKigNoGcWnYKZu+VhTVbszhrSxci+B
	 HbpjCDdq99S+w==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Nov 2025 19:36:43 +1100
Message-Id: <DE7FHUVN5QE0.3ECM9JKXUNWFW@kernel.org>
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
 <DE7F6RR1NAKW.3DJYO44O73941@kernel.org>
In-Reply-To: <DE7F6RR1NAKW.3DJYO44O73941@kernel.org>

On Thu Nov 13, 2025 at 7:22 PM AEDT, Danilo Krummrich wrote:
> On Wed Nov 12, 2025 at 8:56 PM AEDT, Miguel Ojeda wrote:
>> I guess we could potentially consider something like returning a
>> wrapper to force us to explicitly pick either LE or BE to prevent
>> things like this.
>
> In general, the I/O backend (e.g. MMIO, I2C, etc.) is supposed to take ca=
re
> of endianness.
>
> In the case of MMIO we (currently) always assume that the device is
> little-endian; this is also what the C functions used to implement the MM=
IO
> backend (e.g. readl()) assume, i.e. they always convert from little-endia=
n to
> CPU endianness.

I.e. if we'd support a big-endian architecture in Rust

	u32::from_le(bar.read32())

would be a bug.

> I don't think we should do anything else; the cases where we need to deal=
 with
> big-endian devices for MMIO should be extremely rare -- rare enough that =
there
> aren't even corresponding *_be() implementations for all architectures.
>
> Given that, I think the proper fix is to drop the existing u32::from_le()=
 call
> (that ended up in the sample driver by accident) and properly document th=
e
> little-endian assumption of the MMIO backend.
>
> (Currently, this simply is the Io structure, but there is a patch series =
[1]
> from Zhi splitting things up, so we can start supporting arbitrary I/O
> backends.)
>
> @Marko: Two separate patches for this would be very welcome. :)
>
> [1] https://lore.kernel.org/all/20251110204119.18351-1-zhiw@nvidia.com/

