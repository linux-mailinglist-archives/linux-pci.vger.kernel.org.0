Return-Path: <linux-pci+bounces-32339-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1D3B0808C
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 00:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8FE4A4141E
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 22:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0456E288535;
	Wed, 16 Jul 2025 22:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aiZhwODQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB7027281F;
	Wed, 16 Jul 2025 22:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752705160; cv=none; b=gsccuimgsH3Wns4Dw/AUGBNHCbGngAzmvB4Z6S8K95NQByqSsESmLOWr+XBXkwEPMfwV2EvL71yvB+XMFIm6P12lmBR5shf8SbmUXEFZ1Bwoju/g/uXXFsg8h3RhAZUncmvmX93LrgYimPWekdvQpSB7Z/lsfDYKo5MtiHlf40M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752705160; c=relaxed/simple;
	bh=cJQu79T6Iy48Nz6xtT8dqDiUbb7OcWLQyUQXv74VQC4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=fEHQ06q2Eh61M9pIEaSUxkKcvjXphxz2KabxjHx5i0ZvkaeBzYZWCoKdLDlsJHANnIeyT9UeHjE0/Jua2PfekzNWfi4XXde1DUPoN7L50JjGB0JBW+5J288oBrH+hvOY4QEKlztRQqZfbH/Q8UYDMcL2uu4pUxvNpXwmVjldzNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aiZhwODQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB77DC4CEE7;
	Wed, 16 Jul 2025 22:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752705160;
	bh=cJQu79T6Iy48Nz6xtT8dqDiUbb7OcWLQyUQXv74VQC4=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=aiZhwODQFeDDeyWzQIetIw6HeJ1opsHS1D7dMq5QKloAraC1dGJWWyNNLxZZR70kt
	 tk6BrNWrM7OFLgM43enXZGOapKR1JdNijJhTwhU6rsDZABIRCWY5lo+QbhVWtx/2uv
	 UdDav9qm4XEptDpp0cv3vZCy0dkfZuv23JZa6hfDkuoINY6Ih3CHEtH/CJtZ1UVqeM
	 N6X09axstCmJq0RX8GI8+AYo00G0J5aGasJ94XeVYaTg9Ob4IZ4jndk3ZQS2ZnuPYJ
	 HgB3ZZX98BcKQiKqYRnj8nVa6rnH6Ugnfd4c6VpjozxzrMfQs3h7PFFYj7ZNxydzTa
	 jo5wacpG2jEDw==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 17 Jul 2025 00:32:35 +0200
Message-Id: <DBDU4GLBTS84.8BRMIXVS61ZC@kernel.org>
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
 <DBDO8FVL9NKE.201JEW4MRHS6F@kernel.org>
 <DBDP0BJW9VAZ.5KRU4V4288R8@kernel.org>
 <DBDSFO1LGSYM.VFQKKLN6BX3H@kernel.org>
 <442B2871-4512-4C5B-A394-C9CA14FF4C3C@collabora.com>
In-Reply-To: <442B2871-4512-4C5B-A394-C9CA14FF4C3C@collabora.com>

On Thu Jul 17, 2025 at 12:19 AM CEST, Daniel Almeida wrote:
> I hand-applied this and fixed the issue above. All doctests pass FYI.

Yes, I noticed this in my testing as well, yet it seems I somehow managed t=
o
post the wrong diff. In my branch [1] everything should be correct.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/log/?h=
=3Drust/dma-mask

