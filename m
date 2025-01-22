Return-Path: <linux-pci+bounces-20232-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2EA6A18F40
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jan 2025 11:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C05F27A0523
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jan 2025 10:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559731F63C4;
	Wed, 22 Jan 2025 10:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cNOLhoPV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26ABD16BE3A;
	Wed, 22 Jan 2025 10:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737540460; cv=none; b=TDHa9/Bz92VuPH+hpzJUC4Sgw/EkxFsD8lcV63tqluyzoqTaIx99tjoiPrxXQSpeXK/Rec6SpylOUGrzZg18DNVfAeuv27FhYAsQ4RX2m1GEdF5xy7n82JR7Y2+v78nl3wBTkLaObTU538EtmsBrfMvmv16J4q1141myRzdBcjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737540460; c=relaxed/simple;
	bh=C/dBrxanwzEJU+y06gfznEINZAyiXaRZr7A4a7UOCQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HWdtC8q1+PrsyWb4WkMAAt/OVkX3L/IWx6JPvNSpazhT7UQ1xV4JP+HH4iF6FHlx/tUztTQ7lxxYyfVhpclst3XD2j6AgFFio6EbFv9NWv/axIcPLdnP/0osxMmIX9evzVKRw0rJRMi/Xa2EHfnP8wV9Y4LLRFa39FZvngfVRAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cNOLhoPV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A548C4CED6;
	Wed, 22 Jan 2025 10:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737540459;
	bh=C/dBrxanwzEJU+y06gfznEINZAyiXaRZr7A4a7UOCQk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cNOLhoPVvcJ6aDaZKWy25Cd++B2QEV6GXneFgORVu1dss6s+nwBJlmRnhi8bp/Hqk
	 0uJmmouensagy5xt+wp4PJ2Bio6jgL7rYk0fnsV8M5x3Fz8ViAryqRwkR8giRl5F5a
	 n7sNDZnTh3vrPPTJCmU/8UGc0TbzVuEGvS244Bx5pF28m+rViYzYmS/wVHTMMf97wD
	 A4vsDHH6TS7BjzfPtW8i8Va5ZaskiyRZey9qMvIQuJG/oU/DhyXKD+IiG4FFY+ta4M
	 dBkJ3OVjBcwEngPw4OOTEtCp4h94VBI6GMtD7yolI2WeFlKUb+l0jTxQ1I9S/lMjfg
	 o0X9CWrplwLvA==
Date: Wed, 22 Jan 2025 11:07:34 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Hans Zhang <18255117159@163.com>, manivannan.sadhasivam@linaro.org,
	kw@linux.com, kishon@kernel.org, gregkh@linuxfoundation.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	rockswang7@gmail.com,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [v11 2/2] misc: pci_endpoint_test: Fix overflow of bar_size
Message-ID: <Z5DDZnRX3H7RZR5S@ryzen>
References: <20250109094556.1724663-1-18255117159@163.com>
 <20250109094556.1724663-3-18255117159@163.com>
 <7474af29-2995-48f6-830b-a23dad2d2bd1@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7474af29-2995-48f6-830b-a23dad2d2bd1@nvidia.com>

On Tue, Jan 21, 2025 at 05:46:43PM +0000, Jon Hunter wrote:
> > diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> > index f78c7540c52c..0f6291801078 100644
> > --- a/drivers/misc/pci_endpoint_test.c
> > +++ b/drivers/misc/pci_endpoint_test.c
> > @@ -280,10 +280,11 @@ static int pci_endpoint_test_bar_memcmp(struct pci_endpoint_test *test,
> >   static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
> >   				  enum pci_barno barno)
> >   {
> > -	int j, bar_size, buf_size, iters;
> > +	int j, buf_size, iters;
> >   	void *write_buf __free(kfree) = NULL;
> >   	void *read_buf __free(kfree) = NULL;
> >   	struct pci_dev *pdev = test->pdev;
> > +	resource_size_t bar_size;
> >   	if (!test->bar[barno])
> >   		return false;
> > @@ -307,7 +308,7 @@ static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
> >   	if (!read_buf)
> >   		return false;
> > -	iters = bar_size / buf_size;
> > +	iters = div_u64(bar_size, buf_size);
> >   	for (j = 0; j < iters; j++)
> >   		if (pci_endpoint_test_bar_memcmp(test, barno, buf_size * j,
> >   						 write_buf, read_buf, buf_size))
> 
> 
> This change breaks building the kernel with GCC v7 and I see ...
> 
> ERROR: modpost: "__aeabi_uldivmod" [drivers/misc/pci_endpoint_test.ko]
> undefined!
> ERROR: modpost: "__aeabi_ldivmod" [drivers/misc/pci_endpoint_test.ko]
> undefined!
> 
> I know that this is an old GCC version, but this is a farm builder and the
> kernel still indicates that GCC v5.1 is still supported [0].

Arnd,

do you have any idea what is going on here?

I'm a bit puzzled, since looking at other reports of this error,
e.g.:
https://lore.kernel.org/all/20241018151016.3496613-1-arnd@kernel.org/

using div_u64() is usually the solution for this problem (for things that
are not performance critical), not the cause of it... any ideas?


Kind regards,
Niklas

