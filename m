Return-Path: <linux-pci+bounces-36186-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03DF9B58388
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 19:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 091CA4C28BA
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 17:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D48D27A12B;
	Mon, 15 Sep 2025 17:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VjDqza8j"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B6F2264DB;
	Mon, 15 Sep 2025 17:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757956962; cv=none; b=Nek8c37oCjWbK5nEUYTp+mtAFGvSmND6+V/3goughETrU5qhUeTHy3DTjEIKmzDQUdlWZEfv4CD9DFKTnTeczzzNNWQXQojk+W/ItTspC2RWR94IG9pA8SwzvYiafN3fIJZqTs2860+5nbEzzIM7FRvsZDDJwtDx9E0pgvS6XCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757956962; c=relaxed/simple;
	bh=MwPTWHMVS1a2WpMTOzVZuU4xM9Y5h1sGMnVe69pXgjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s3KkoGsxd8dLeqPng053SU9aGSwjwwnFXXG43ALI4uVskWt146sMfepjYdp+gktfLA1SDrI4Gc02kn/tjXyfQeqlu08RUDyUdqPS4ok24LaUUyEnsbq+jtATLKAxfN+kOF5jx85ypUKYo4NIunXiHAGE4eK9buxeI6nOkVa2mpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VjDqza8j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 117F2C4CEF1;
	Mon, 15 Sep 2025 17:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757956961;
	bh=MwPTWHMVS1a2WpMTOzVZuU4xM9Y5h1sGMnVe69pXgjg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VjDqza8jv0gA0NJzp1Vlgkr2sR1NKkLU/5WdofDyBASVSIFQgpoEiIxs5PesEGi1y
	 2o2BytLlFLV/gOAGMcy9dUVP0PSrSEA1AkV2XG3ZauUz5qTmhQZUH0mx4ONdOh3poV
	 9NUAnIizt9aFOCrfNNmKAuK+JHUtFMzB5wm2Hm0B0DfGEU/Os281Q3jthCbhJw6+uH
	 snOxqCkLry2LmLMNaO4fZUbKjqKmGxUn6cLMVz+T1mFZaJX9mdjiNP1Rcnafh93S+C
	 8V3sFrkj+O5vvR+384HssSuJHcgUcCg6j+M2aH1DIj3kWPXR8uNWorXrWPIAD6lkdc
	 mrrE1BhrJo1hA==
Date: Mon, 15 Sep 2025 19:22:38 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
	=?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>, Alex Deucher <alexander.deucher@amd.com>, 
	amd-gfx@lists.freedesktop.org, David Airlie <airlied@gmail.com>, 
	dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
	Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
	Lucas De Marchi <lucas.demarchi@intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Simona Vetter <simona@ffwll.ch>, Tvrtko Ursulin <tursulin@ursulin.net>, 
	?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, "Michael J . Ruhl" <mjruhl@habana.ai>, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 06/11] drm/i915/gt: Use pci_rebar_size_supported()
Message-ID: <e6t3dzohiyz36jfe4xjcjgm3zi4h2ln5ocxbvgv3gqt6oipb6h@p2j3o6jeqj45>
References: <20250915091358.9203-1-ilpo.jarvinen@linux.intel.com>
 <20250915091358.9203-7-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250915091358.9203-7-ilpo.jarvinen@linux.intel.com>

Hi Ilpo,

On Mon, Sep 15, 2025 at 12:13:53PM +0300, Ilpo Järvinen wrote:
> PCI core provides pci_rebar_size_supported() that helps in checking if
> a BAR Size is supported for the BAR or not. Use it in
> i915_resize_lmem_bar() to simplify code.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Acked-by: Christian König <christian.koenig@amd.com>

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

Thanks,
Andi

