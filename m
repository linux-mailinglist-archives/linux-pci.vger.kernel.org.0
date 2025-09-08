Return-Path: <linux-pci+bounces-35697-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 592FFB49C51
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 23:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 069593AFF0F
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 21:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001402E03F1;
	Mon,  8 Sep 2025 21:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N4Mx90Fc"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17ED28E7;
	Mon,  8 Sep 2025 21:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757368019; cv=none; b=sY/KzR8n0/cDmnjT7L2IIeeCT/8Kf9bXmwApAgFtvmGxoEDAumVfXzOnGUJEKII27Iz3n8peFoAjJp/A4GdBbzWaIHzJIzWoaRAYomsnCAMXTnh4AcVcj9ctncSOzNCphk8xOP4UPqXHLnKRjxjm6Zs6mgg+1JoBplMpFY/zQbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757368019; c=relaxed/simple;
	bh=GtYtcqjyTm01Zg3MsicjQqYbIhcdI5XwEduWwlTykt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nkmQy0gOxwh/tXCjnXoaioX3k1nqYLy8uRCaxkO8uleA5gwBrk7jmbdqjft62mQDqxyj1VtU+tnMpPtj2uwR4zAgIxf2FjeFB8fVQtloXzXmsV9uNGTJGZnQh7arG+FsgIAyHxU+NqSbFbd23xmzSNuK8CfypCZY4OITefRPRvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N4Mx90Fc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DF7EC4CEF1;
	Mon,  8 Sep 2025 21:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757368019;
	bh=GtYtcqjyTm01Zg3MsicjQqYbIhcdI5XwEduWwlTykt4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N4Mx90FcOsmbOcDj2TlD+/LpW+09llJW5ByruAenjVEiuW8LypaFPIFBF9Wp2e9bX
	 hwhfjdLOCpWOy/sJS52umy+aOdDbL+25OrninGbGhP4vzP6c7uiKZJlOXRs9+9q7uJ
	 dzbsZOmiFxNRsNUEdtYWSiy4JJrfvmY90FQ3r6vYdp4TAeU7aEFHL5jIe7bVAwo3FN
	 JEqJfmzzrUxUWMdKqs1wRHf1pq+KyPnRB1WL2EXYfLKUB5TBJWYCTMIfcLMdCHH18X
	 BE2E8J6nuelOPwT2y08kjzDTnEy7N9V+tPpMeU/Vb/Aelm8t9ujOWpGWZFY0EXhDAh
	 kj7B7Xc3aDGJQ==
Date: Mon, 8 Sep 2025 14:46:58 -0700
From: Kees Cook <kees@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Linaro Kernel Functional Testing <lkft@linaro.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	lkft-triage@lists.linaro.org,
	Linux Regressions <regressions@lists.linux.dev>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Benjamin Copeland <benjamin.copeland@linaro.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] PCI: Test for bit underflow in pcie_set_readrq()
Message-ID: <202509081444.D73219849@keescook>
References: <20250905052836.work.425-kees@kernel.org>
 <d430f9ac-153c-41da-9cbe-53aa2f9d0fc3@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d430f9ac-153c-41da-9cbe-53aa2f9d0fc3@app.fastmail.com>

On Fri, Sep 05, 2025 at 10:25:49AM +0200, Arnd Bergmann wrote:
> On Fri, Sep 5, 2025, at 07:28, Kees Cook wrote:
> > After commit cbc654d18d37 ("bitops: Add __attribute_const__ to generic
> > ffs()-family implementations"), which allows GCC's value range tracker
> > to see past ffs(), GCC 8 on ARM thinks that it might be possible that
> > "ffs(rq) - 8" used here:
> >
> > 	v = FIELD_PREP(PCI_EXP_DEVCTL_READRQ, ffs(rq) - 8);
> >
> > could wrap below 0, leading to a very large value, which would be out of
> > range for the FIELD_PREP() usage:
> >
> > drivers/pci/pci.c: In function 'pcie_set_readrq':
> > include/linux/compiler_types.h:572:38: error: call to 
> > '__compiletime_assert_471' declared with attribute error: FIELD_PREP: 
> > value too large for the field
> > ...
> > drivers/pci/pci.c:5896:6: note: in expansion of macro 'FIELD_PREP'
> >   v = FIELD_PREP(PCI_EXP_DEVCTL_READRQ, ffs(rq) - 8);
> >       ^~~~~~~~~~
> >
> > If the result of the ffs() is bounds checked before being used in
> > FIELD_PREP(), the value tracker seems happy again. :)
> >
> > Fixes: cbc654d18d37 ("bitops: Add __attribute_const__ to generic 
> > ffs()-family implementations")
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > Closes: 
> > https://lore.kernel.org/linux-pci/CA+G9fYuysVr6qT8bjF6f08WLyCJRG7aXAeSd2F7=zTaHHd7L+Q@mail.gmail.com/
> > Signed-off-by: Kees Cook <kees@kernel.org>
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> This looks good to me individually, however I have now tried to
> do more randconfig tests with the __attribute_const change
> and gcc-8.5.0, and so far found two other files with the
> same issue:
> 
> In file included from <command-line>:
> In function 'mtk_dai_etdm_out_configure.constprop',
>     inlined from 'mtk_dai_etdm_configure' at sound/soc/mediatek/mt8188/mt8188-dai-etdm.c:2168:3:
> include/linux/compiler_types.h:575:38: error: call to '__compiletime_assert_416' declared with attribute error: FIELD_PREP: value too large for the field
> sound/soc/mediatek/mt8188/mt8188-dai-etdm.c:2065:10: note: in expansion of macro 'FIELD_PREP'
>    val |= FIELD_PREP(ETDM_OUT_CON4_FS_MASK, get_etdm_fs_timing(rate));
> sound/soc/mediatek/mt8188/mt8188-dai-etdm.c:1971:10: note: in expansion of macro 'FIELD_PREP'
>    val |= FIELD_PREP(ETDM_IN_CON3_FS_MASK, get_etdm_fs_timing(rate));
> 
> drivers/mmc/host/meson-gx-mmc.c: In function 'meson_mmc_start_cmd':
> drivers/mmc/host/meson-gx-mmc.c:811:14: note: in expansion of macro 'FIELD_PREP'
>    cmd_cfg |= FIELD_PREP(CMD_CFG_TIMEOUT_MASK,

I can't see how these are related to ffs()...

> This is fairly rare, but over time there are likely going to be
> others like them. I see three possible ways forward here:
> 
> a) fix them individually as we run into them, hoping for the best

I think they are valid warnings, so my instinct would be to fix them as
they appear. (e.g. "0 - 8" isn't something FIELD_PREP can do anything
about.)

-Kees

-- 
Kees Cook

