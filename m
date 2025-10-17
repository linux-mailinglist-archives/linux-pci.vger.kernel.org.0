Return-Path: <linux-pci+bounces-38453-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8C4BE842A
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 13:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 147C43A6F54
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 11:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14FA322740;
	Fri, 17 Oct 2025 11:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJbVcIe5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DC32BE03B;
	Fri, 17 Oct 2025 11:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760699521; cv=none; b=kt/pzfsG6QEAMTY9dYoI0hqjJs9UnaKDte4dTa0bIePAVZjMW9BgGwG5RwKEsNluTqaTAiufAVTIWgw1ZFfbXIJRVJldgeAc9Z0kqNvf42rUCgcHAmhnKG2NhEqjN9gbppYE4p/1MshXsvF7HnTn0+irBGA7MoKITVWFsILzuVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760699521; c=relaxed/simple;
	bh=ncrXZRdjnegwC1tCZqNrti5BjJkwd5j1aJR1aarvJhY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=mgVSFY+yEn2oe1GNRf4xwWY1H6EDi7iFyS19Yiitl+HbSWY3zv5lcNIHlpz3Ae1gXW/cpvXQvAa7GTA5wcQJmYTtfUGtWoUteDNr4TSPk9z8fIm3DVImPdQCpogtZbWItKFRtkTYk8JcqR9unRq/zJfukxDSL0midJstoQnRs5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJbVcIe5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2330AC4CEE7;
	Fri, 17 Oct 2025 11:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760699520;
	bh=ncrXZRdjnegwC1tCZqNrti5BjJkwd5j1aJR1aarvJhY=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=UJbVcIe5RRfvaKFPR4sBIgBQopg4lPddzojEs5zd42r67lvTSkk/uu/0upISJ5Rwg
	 q3Zue9DNm2UdIXZep//MaRY1/AQuAH71H9se4fWMp6K7fZfdtYvflhYn6nunJTKlCI
	 6vcMFFFyjeve0J+edd/5iBeLvvOPXWJ7u5jnmoD2Dfnxp4Em9OGvffjsP/cnXWweQJ
	 Bk0ODaJUcznRLiDwHFB6MHpLrQweC1B1NaHwmAiImwmahCsePDRMRN+huZMhTKMni7
	 RY9XKr6RHe2SwXh8DfRjrFo+9wHMODl6f921RcyaZ0JPL9a1DzxZOmiUzffKfw89GZ
	 hb6FCmIWsTuzQ==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Oct 2025 13:11:54 +0200
Message-Id: <DDKJVYLSARXE.13S98Z9259AN4@kernel.org>
Subject: Re: [PATCH v2 5/5] nova-core: test configuration routine.
Cc: <rust-for-linux@vger.kernel.org>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
 <tmgross@umich.edu>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <cjia@nvidia.com>, <smitra@nvidia.com>,
 <ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <zhiwang@kernel.org>, <acourbot@nvidia.com>,
 <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>, <markus.probst@posteo.de>
To: "Zhi Wang" <zhiw@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20251016210250.15932-1-zhiw@nvidia.com>
 <20251016210250.15932-6-zhiw@nvidia.com>
 <20251017075522.6f662300.zhiw@nvidia.com>
In-Reply-To: <20251017075522.6f662300.zhiw@nvidia.com>

On Fri Oct 17, 2025 at 6:55 AM CEST, Zhi Wang wrote:
> On Thu, 16 Oct 2025 21:02:50 +0000
> Zhi Wang <zhiw@nvidia.com> wrote:
>
> Hi guys:
>
> To avoid misunderstanding, this is just meant for folks to test, not for
> merging. I will drop this one in the next re-spin.

I suggest adding it to samples/rust/rust_driver_pci.rs instead. :)

