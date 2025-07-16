Return-Path: <linux-pci+bounces-32312-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BBAB07C61
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 19:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D6651C27363
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 17:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D05F28852E;
	Wed, 16 Jul 2025 17:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KcigDzRH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE3828850F;
	Wed, 16 Jul 2025 17:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752688547; cv=none; b=Tphbz13N+EQpAc318a5cI9ktkw1y+POgRuzVS4WQbGYgx4qChZTB8BH9prRudvjXJcyWbIpemz0MUY98wID0h0utAXvQsDtmM1l9lmkb9aCcTpYujmRVl6inSpxRmBu5RVSgkrBBMwLqXg9zNEdh+bJiqGY2ISs3ZB/Np25/P5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752688547; c=relaxed/simple;
	bh=wnQ+6qL0ewVoo3bzjKS3h0tuzgVpvP0pV+2qhh7DPfs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=oLIqF2txu9anVnGqVeFZyAnuP0E7RFz5zd6tnTLdWLgCV0FCBWhrtBIW+bsa716Ii/rXtlNMS10Fk9T6IGYsC+H0hzkiIkIQfoIW9wcZacmJV2qp9ZW2opvs2GrL9Gb/qenM4Ggdj7jgengR+oKsW/wfBXoL/m/XIIcfeWGYJDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KcigDzRH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F1E9C4CEE7;
	Wed, 16 Jul 2025 17:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752688545;
	bh=wnQ+6qL0ewVoo3bzjKS3h0tuzgVpvP0pV+2qhh7DPfs=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=KcigDzRHakxOR91XF51JOqVi2cLKi/4lsv9/UKjIixu3qFHbjrnh8kcYGL4MJEM0Y
	 drc4IUbrEEBdVe0obKunNUKkvwHk04yi9JGN4i079HzeO2FK4Eoxurn9qZnRla2Tl8
	 gOsbxXoGFHrATTKKRjL3QjFZ6jtoCzhsFoLcHtg7bc+AXCgl9s6wYmhKVCnEpuQQU/
	 zj9+qAcA30mx7hU2eO5Tekddgg0Yn9CaBhML8aCL1cuEKx4qotjwiIv0CHTesa6AKr
	 AkLd5d57aGb8VwCre6cNDMKP1UyGOtDr6yIiXtC0TwPfFJULr5UAsgIPbm8lZ6d9/W
	 KocELeOS/kpwA==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 16 Jul 2025 19:55:40 +0200
Message-Id: <DBDO8FVL9NKE.201JEW4MRHS6F@kernel.org>
Subject: Re: [PATCH v2 2/5] rust: dma: add DMA addressing capabilities
Cc: <abdiel.janulgue@gmail.com>, <robin.murphy@arm.com>,
 <a.hindborg@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <aliceryhl@google.com>, <tmgross@umich.edu>,
 <bhelgaas@google.com>, <kwilczynski@kernel.org>,
 <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Daniel Almeida" <daniel.almeida@collabora.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250716150354.51081-1-dakr@kernel.org>
 <20250716150354.51081-3-dakr@kernel.org>
 <0984E8E7-C442-42E6-A8E7-691616304F6F@collabora.com>
In-Reply-To: <0984E8E7-C442-42E6-A8E7-691616304F6F@collabora.com>

On Wed Jul 16, 2025 at 7:32 PM CEST, Daniel Almeida wrote:
> Hi Danilo,
>
>> +    #[inline]
>> +    pub const fn new(n: usize) -> Result<Self> {
>> +        Ok(Self(match n {
>> +            0 =3D> 0,
>> +            1..=3D64 =3D> u64::MAX >> (64 - n),
>> +            _ =3D> return Err(EINVAL),
>> +        }))
>> +    }
>> +
>
> Isn=E2=80=99t this equivalent to genmask_u64(0..=3Dn) ? See [0].

Instead of the match this can use genmask_checked_u64() and convert the Opt=
ion
to a Result, once genmask is upstream.

> You should also get a compile-time failure if n is out of bounds by defau=
lt using
> genmask.

No, we can't use genmask_u64(), `n` is not guaranteed to be known at compil=
e
time, so we'd need to use genmask_checked_u64().

Of course, we could have a separate DmaMask constructor, e.g. with a const
generic -- not sure that's worth though.

