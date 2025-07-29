Return-Path: <linux-pci+bounces-33101-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C6C8B14B90
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jul 2025 11:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2CBC16C9EB
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jul 2025 09:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A6B217F23;
	Tue, 29 Jul 2025 09:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RxaY5tbG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59981CA52;
	Tue, 29 Jul 2025 09:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753782337; cv=none; b=YCjYhVGLmMcYlXB6IPcZ+UuaNiZLlgoNm64UC9LwnIdcdaxg7W8ep5vWk1+uSbf1SOQic6wK2iFYU+POF0SNx3Hs3J6+8KXgr4Ch+QKyAVtAfwmFzga61fLymuJVmEqmM3wplU2Ew4fikd5XTsXRF0nSRARnGLs3h06+xwrS83U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753782337; c=relaxed/simple;
	bh=9ViO2+HRYeOb/MJUgHd97uhWtRPt8a8vyaQZUU2dRl4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=qPxrBUG4m/XlrXXkyCRuKQ9249HSDaVCzBIVRrDDy4kCJDVEm99JyuKHDlk1/7xS0rCGMpPo97odr9eC6UZfWMhnHoD/9uzbi7qz6ypyeHccWZwJTsmNjZ9VHg2VCXoPjwHsUO5wy5ZAELDgzy8nrZDWcqEj/jQ5hp+kzw0to+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RxaY5tbG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B3D6C4CEEF;
	Tue, 29 Jul 2025 09:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753782334;
	bh=9ViO2+HRYeOb/MJUgHd97uhWtRPt8a8vyaQZUU2dRl4=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=RxaY5tbG9KGhE1zasC2c0FFJAlSeRp9Dib5H4E0T7ziisaTapLlhPuQC4x+P8cWrJ
	 Dm/RbmWB9dIKqLcPfMP5lVGVHtad7yjKqNQldJIR6LegGveKVhXQbHh59ThpIXUnQo
	 8BgTxxHtTC/KA4QfGLCpXPuWDZWNcMUJKe5adteL5PIagCuF3b/6/zNS8UIqys8zjd
	 nlhasqgI3CTmYOSRaxy9eBu9UkxCHCWZzZUqA8UAuAAdvbd5PtLaIpxbgsy6vaD4Th
	 uKfu6XcFlj/MkYuibyjnYb3HxfePy8o8W8jSyNZ2Iz5qVKFYqBOV6+6cxATJyEHiLX
	 VtpmfxvjhwjaQ==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 29 Jul 2025 11:45:30 +0200
Message-Id: <DBOFY80IDMWJ.627ZOACP7KK5@kernel.org>
Cc: <bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>, <linux-pci@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: "herculoxz" <abhinav.ogl@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH] rust: pci: use c_* types via kernel prelude
References: <20250729002941.7643-1-abhinav.ogl@gmail.com>
In-Reply-To: <20250729002941.7643-1-abhinav.ogl@gmail.com>

Hi Abhinav,

On Tue Jul 29, 2025 at 2:29 AM CEST, herculoxz wrote:
> From: Abhinav Ananthu <abhinav.ogl@gmail.com>
>
>  Update PCI FFI callback signatures to use  from the ,
>  instead of accessing it via . This aligns with the Rust-for-Linux coding
>  guidelines and ensures ABI correctness when interfacing with C code.

Something seems to be odd with the commit message, it seems some parts are
missing.

Can you please fix this and send a v2? It's enough to send it after -rc1 is=
 out.

Thanks,
Danilo

