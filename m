Return-Path: <linux-pci+bounces-35705-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4111B49C79
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 23:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 758A63A8E45
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 21:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD08A2E427C;
	Mon,  8 Sep 2025 21:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OUDWHdrv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5CB1DDC3F;
	Mon,  8 Sep 2025 21:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757368648; cv=none; b=i34ivfTWVhdYATdX9VKwGV9s1i2YcS6/8aknmTBBISDMQ5GD8hpSVp6xtKizq0JrgTsEvB5mq6ZrP+uy4cszi6zNJdQZExfnTwGdLE7vbEkiRRiOmzEZSTnpq/cgTB/hArBXnCqKU05AekFQB4Z8lRZ63ZPsCdi/+2aVNwzSnmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757368648; c=relaxed/simple;
	bh=VgArNmPKMSrg6/XYZxYG/sx1QQ930i8IKyjIw9VoiNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=obY7NX0SmUuogD4U8hjc1Nl/ckxLghLFN/WZ5npNEPibFlXzz82er1hr0iT9WOgN83ws4VnceZKrGfspH7J9V+Lp+JpD75gj149MWRV4hsCqbhyKbnIc9ykaO6RaJEiBLmZhFdcTpogwuVAf8GLBoUJXdRUFkjzOGnCjKer4bKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OUDWHdrv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C216C4CEF1;
	Mon,  8 Sep 2025 21:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757368648;
	bh=VgArNmPKMSrg6/XYZxYG/sx1QQ930i8IKyjIw9VoiNk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OUDWHdrvt0AobPF9H+Rhe3F8soG4rkEU5WUKwDve0ebIwb1NSyuDHGIpO4cWG0VHn
	 DoSjf16aP6O1F4wmOIgQODnx9BlPltRDQzLgHTnEIVg0x53fSTurjARakobtErNKpX
	 ie/YQCtsOwJ7K+0HwIlO05XyIjAHpG4UpuEwXPVg+ZxUL/B0OvRmACfz994t39SyeD
	 3znsgYdnYl7D0Ksa8vSKQxolk+nyOi/r4oHbi0PRehPZRqdEWL5ZD+I5em6H/htu9c
	 vlRu2vIzYNudQJLkGuH/D3rg7enuI/1X5zAUMm4GICqwXX447rHIZm1O5HrBkk/RVd
	 F8X3CCEy9WsXg==
Date: Mon, 8 Sep 2025 14:57:27 -0700
From: Kees Cook <kees@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Linux Kernel Functional Testing <lkft@linaro.org>,
	Anders Roxell <anders.roxell@linaro.org>,
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
Message-ID: <202509081457.B5A99815E@keescook>
References: <20250905052836.work.425-kees@kernel.org>
 <20250908215142.GA1467111@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908215142.GA1467111@bhelgaas>

On Mon, Sep 08, 2025 at 04:51:42PM -0500, Bjorn Helgaas wrote:
> On Thu, Sep 04, 2025 at 10:28:41PM -0700, Kees Cook wrote:
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
> > include/linux/compiler_types.h:572:38: error: call to '__compiletime_assert_471' declared with attribute error: FIELD_PREP: value too large for the field
> > ...
> > drivers/pci/pci.c:5896:6: note: in expansion of macro 'FIELD_PREP'
> >   v = FIELD_PREP(PCI_EXP_DEVCTL_READRQ, ffs(rq) - 8);
> >       ^~~~~~~~~~
> > 
> > If the result of the ffs() is bounds checked before being used in
> > FIELD_PREP(), the value tracker seems happy again. :)
> > 
> > Fixes: cbc654d18d37 ("bitops: Add __attribute_const__ to generic ffs()-family implementations")
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > Closes: https://lore.kernel.org/linux-pci/CA+G9fYuysVr6qT8bjF6f08WLyCJRG7aXAeSd2F7=zTaHHd7L+Q@mail.gmail.com/
> > Signed-off-by: Kees Cook <kees@kernel.org>
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> Would be great if you included this as part of your series, thanks!

Okay, thanks! :)

-Kees


-- 
Kees Cook

