Return-Path: <linux-pci+bounces-36187-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E4BB58385
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 19:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A24920473D
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 17:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF280279DBA;
	Mon, 15 Sep 2025 17:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nUl0N/rk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB51224AF9;
	Mon, 15 Sep 2025 17:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757957054; cv=none; b=KfPP5IYJz1JydVcfY8szgVNDtibehxdaUEPRtYSV3VT/EqU1KlsZmFPD4e1xTGsLlfDIIBio5nbKb2G6XQNx3w9y0BqBPw4HTH1PCE6Lk++zA1myKCeYzLrK90ilj5aic/mG9adbV+CyEvEZkhRXVAmKv/eEjw7NGMoiBOlPm3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757957054; c=relaxed/simple;
	bh=7STYzWbQMVyC09sCCmmsDxZCpqXzbEGrpzMTDgjvMt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ln6sr3IZvu3pdPST1WWfsOWux1VdtV7Ce3SGWJjePFNcoZirDJseGBcZ16jhJyYFNK4ZqUh2MPf1Qoz5EIC+M2ACkTYQc8Bwo0SOXb64aILbwS8jOlyeuuNiZeEeOo/plnUzrFlVDTzNvjQHBJ3xiicYcgM6NPoLlj2Ja/yw7G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nUl0N/rk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80165C4CEF1;
	Mon, 15 Sep 2025 17:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757957053;
	bh=7STYzWbQMVyC09sCCmmsDxZCpqXzbEGrpzMTDgjvMt4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nUl0N/rkG1GQQYgyQ5VHxpycUsA8D0xkIG8GEI4aZk9JtnwwBIDZF1LykQJfl5Hf5
	 AvyLiPWW0c+tqIdNVBrw7xeCnYJl2KDsmddVWtSNi/7dw9p9+BMvmekRupn63JvtjP
	 m9Zmk7lfsrFtS5kMcV1ocJCLicp97ZrEgdearK/ZqRmNXyb+FwjB5+0rpu+2IQ034k
	 lPtetQX3+awv5YeY/4LkrPIzxYn4UkG9M8EE/+0xAnCevrovPaUWbTKcXf7qv/5/gx
	 8HCm22TyEZeGirF4axBMINzViIlvkEb4yxYpkaajm3SpIApk+Ect6v1RHNDB4dPHC3
	 GLZyfksGi8vzA==
Date: Mon, 15 Sep 2025 19:24:10 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
	=?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>, Alex Deucher <alexander.deucher@amd.com>, 
	amd-gfx@lists.freedesktop.org, David Airlie <airlied@gmail.com>, 
	dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Lucas De Marchi <lucas.demarchi@intel.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Simona Vetter <simona@ffwll.ch>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, 
	?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, "Michael J . Ruhl" <mjruhl@habana.ai>, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 06/11] drm/i915/gt: Use pci_rebar_size_supported()
Message-ID: <ewypjj64siaswcfvfzgxihwrflb6k6pz2mrfuu4ursdldwnqlm@ignlhd73keck>
References: <20250915091358.9203-1-ilpo.jarvinen@linux.intel.com>
 <20250915091358.9203-7-ilpo.jarvinen@linux.intel.com>
 <b918053f6ac7b4a27148a1cbf10eb8402572c6c9@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b918053f6ac7b4a27148a1cbf10eb8402572c6c9@intel.com>

Hi,

On Mon, Sep 15, 2025 at 03:42:23PM +0300, Jani Nikula wrote:
> On Mon, 15 Sep 2025, Ilpo Järvinen <ilpo.jarvinen@linux.intel.com> wrote:
> > PCI core provides pci_rebar_size_supported() that helps in checking if
> > a BAR Size is supported for the BAR or not. Use it in
> > i915_resize_lmem_bar() to simplify code.
> >
> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > Acked-by: Christian König <christian.koenig@amd.com>
> 
> Reviewed-by: Jani Nikula <jani.nikula@intel.com>
> 
> and
> 
> Acked-by: Jani Nikula <jani.nikula@intel.com>

Just for some random noise on commit log's bureaucracy: why do we
need both Ack and R-b? I think R-b covers Ack making it
redundant. Right?

Andi

