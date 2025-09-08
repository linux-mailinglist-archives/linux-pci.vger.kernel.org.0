Return-Path: <linux-pci+bounces-35696-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0F9B49C4B
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 23:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21033165410
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 21:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B902DECD6;
	Mon,  8 Sep 2025 21:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FTWdOjbY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D7520C004;
	Mon,  8 Sep 2025 21:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757367787; cv=none; b=GyTJDOdVaqfT6aeEO0cva0Knoaoq3Uda9PkNiinv/8yP+jv7VtwDQ1tjRgt6hV9LX89njoWjTHr78GfIA1MVlOwXcsk2yKmldeCRw0A9xc3K6qaf5gYCp2YXtHw9THl5uf3WRlHeaAE8wBLFL43CgNPMoHImrYJWdPOL6Nrlh/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757367787; c=relaxed/simple;
	bh=84k4JDUXxNpDLTZlejsaeNIruzeP+rMx+BBesQrg90w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S9AeM9E29uWpGujlAH/AIICtjKAC+9t1ly7xCdvpDtY35Ftv4iXTAa1eNejX5e+fVsmF9eVEkQCG1IahmotFCP8khGnzs7iFUWS77Y9hqGgkVyJi0D5oubueF1sul9EHUhSLSDDQ8ZwgzHQ1WzWodYVzskfU8DGmVodcf9Q9T7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FTWdOjbY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83EAEC4CEF1;
	Mon,  8 Sep 2025 21:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757367786;
	bh=84k4JDUXxNpDLTZlejsaeNIruzeP+rMx+BBesQrg90w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FTWdOjbYqnZovfYFh2G+eVGinRJ3PM9ePxSIgimEzzQOlq6RXZsJ1A9UN2dEYvmdr
	 Q/kXBNTV5biGP4mC94pFzPHSK8li7JPYu0OAhaKSrnWPf2gGdEws4tUCKPfFJCgG7d
	 +zG1dKwhsuUio9RSbO7stWIspRobWl3XPP1QmTwqnVZDjIZ1945fT3diqyA+f7abfq
	 m4XcopGdLv+Ee3P/L+7azk0WtRqWEAw5WARMYIlP1FFcWuGjBL0yhyVROXDvMkcLLm
	 W8yo22w/UODq+MNPIXYqEOimdcPzJtLvZa4WayRumevBNMmXYctE/Yd/8W4hzyhnAB
	 oMkc5WleWlRYQ==
Date: Mon, 8 Sep 2025 14:43:06 -0700
From: Kees Cook <kees@kernel.org>
To: Anders Roxell <anders.roxell@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Linux Kernel Functional Testing <lkft@linaro.org>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	lkft-triage@lists.linaro.org,
	Linux Regressions <regressions@lists.linux.dev>,
	Arnd Bergmann <arnd@arndb.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Ben Copeland <benjamin.copeland@linaro.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] PCI: Test for bit underflow in pcie_set_readrq()
Message-ID: <202509081440.526A41768@keescook>
References: <20250905052836.work.425-kees@kernel.org>
 <CADYN=9Kd9w0pAMJJD1jq4RSum5+Xzk04yPZiQxi9tmEBtHPEMA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADYN=9Kd9w0pAMJJD1jq4RSum5+Xzk04yPZiQxi9tmEBtHPEMA@mail.gmail.com>

On Fri, Sep 05, 2025 at 10:16:33AM +0200, Anders Roxell wrote:
> > -       v = FIELD_PREP(PCI_EXP_DEVCTL_READRQ, ffs(rq) - 8);
> > +       firstbit = ffs(rq);
> > +       if (firstbit < 8)
> > +               return -EINVAL;
> > +       v = FIELD_PREP(PCI_EXP_DEVCTL_READRQ, firstbit - 8);
> 
> Hi Kees,
> 
> Thank you for looking into this.
> 
> These warnings are not a one time thing.  the later versions of gcc
> can figure it
> out that firstbit is at least 8 based on the "rq < 128" (i guess), so
> we're adding
> bogus code.  maybe we should just disable the check for gcc-8.

I think the issue is that GCC thinks it knows the range for ffs is not
the entire [0..UINT_MAX], but it _doesn't_ know how "rq" affects the
outcome. (The range checker warnings kick in when it's not the whole
range of a given type.) But I am just guessing, based on what how I've
seen in behave in the past.

> Maybe something like this:
> 
> diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
> index 5355f8f806a9..4716025c98c7 100644
> --- a/include/linux/bitfield.h
> +++ b/include/linux/bitfield.h
> @@ -65,9 +65,20 @@
>                 BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask),          \
>                                  _pfx "mask is not constant");          \
>                 BUILD_BUG_ON_MSG((_mask) == 0, _pfx "mask is zero");    \
> -               BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?           \
> -                                ~((_mask) >> __bf_shf(_mask)) &        \
> -                                       (0 + (_val)) : 0,               \
> +               /* Value validation disabled for gcc < 9 due to
> __attribute_const__ issues.
> +                */ \
> +               BUILD_BUG_ON_MSG(__GNUC__ >= 9 &&
> __builtin_constant_p(_val) ?  \
> +                                ~((_mask) >> __bf_shf(_mask)) &
>          \
> +                                       (0 + (_val)) : 0,
>          \
>                                  _pfx "value too large for the field"); \
>                 BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >     \
>                                  __bf_cast_unsigned(_reg, ~0ull),       \
> 
> I found similar patterns with ffs and FIELD_PREP here
> drivers/dma/uniphier-xdmac.c row 156 and 165
> drivers/gpu/drm/i915/display/intel_cursor_regs.h row 17

You got warnings for these?

-- 
Kees Cook

