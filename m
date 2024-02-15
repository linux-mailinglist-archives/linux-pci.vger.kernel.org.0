Return-Path: <linux-pci+bounces-3533-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD39856A7A
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 18:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98FECB27648
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 17:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE8013248C;
	Thu, 15 Feb 2024 17:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J7HEMHyI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642AD1754B;
	Thu, 15 Feb 2024 17:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708016580; cv=none; b=kUdKSkZTEWHQJUCoa+Ua2xQdkmXsaDI+6zWKFLUArJWm/obB5AqznJsFcEu/bpLwCZOgXhyehRmaes7qtjJiDKUTOmweDMb3leYSmeGj9/ilZG0zJ5MuvVGiHFvlk7gYCdBRL++irHxMpWTXMxW9Kve/LrFqfFjddJPkWCkf5Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708016580; c=relaxed/simple;
	bh=N1m0kPjc7D24yEHh5GCbtG5RxZ9QtaO4otDQYDmi8rE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=d1ofM9+Zn/7QqDpBYBCY1qGMEG4rQV4SXmyyLroZpsre6MDCY/44vd2rMIYO6305vsbN+5ByzVHNxWnL1MHsqA3+dy4Op/fuOEMEF4NwQK40mlronK+8+NWJWAQnd5q3SmSb3ugfhnOBUDpF2VkE50GTTGd+ESwLwh5z9oMihiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J7HEMHyI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E2BDC433F1;
	Thu, 15 Feb 2024 17:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708016579;
	bh=N1m0kPjc7D24yEHh5GCbtG5RxZ9QtaO4otDQYDmi8rE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=J7HEMHyICW+lND9f9nL4zGh4EuhNKxyu1pocmvfWJJJ41LXKdStLT7I4cpsU/oGGf
	 U1XYFWSwlYncng5/yRVzAS3VJy/k3BkLT2u75gOwk5lRhOx7r/9ezkKYPe+bLTtsJy
	 juTBxqB3UvitOk2fmthh37dWaznvCbCKomD5X1QqoZsntIaWIjm9jgBlou1aGXLUhc
	 uosFTdmdeekyQbJiTMg7hbChm1ZIxN0L3hiJRAH38bK2Fl5rCS8c8LUjmElxC6dQc1
	 nKoBWHBddKeTd6zfad9lxr0YUytYEmJ3ZbyAR2+20SyK2sPGfpewTvoyX6/ybb9dSh
	 8fluJ185PiChw==
Date: Thu, 15 Feb 2024 11:02:58 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH] PCI: dwc: Use the correct sleep function in wait_for_link
Message-ID: <20240215170258.GA1292702@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7611f6f9-a021-4bbd-bc71-5363af3d9391@intel.com>

On Thu, Feb 15, 2024 at 02:35:13PM +0100, Alexander Lobakin wrote:
> From: Konrad Dybcio <konrad.dybcio@linaro.org>
> Date: Thu, 15 Feb 2024 11:39:31 +0100
> 
> > According to [1], msleep should be used for large sleeps, such as the
> > 100-ish ms one in this function. Comply with the guide and use it.
> > 
> > [1] https://www.kernel.org/doc/Documentation/timers/timers-howto.txt
> > 
> > Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> > ---
> > Tested on Qualcomm SC8280XP CRD
> > ---
> >  drivers/pci/controller/dwc/pcie-designware.c | 2 +-
> >  drivers/pci/controller/dwc/pcie-designware.h | 3 +--
> >  2 files changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > index 250cf7f40b85..abce6afceb91 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > @@ -655,7 +655,7 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
> >  		if (dw_pcie_link_up(pci))
> >  			break;
> >  
> > -		usleep_range(LINK_WAIT_USLEEP_MIN, LINK_WAIT_USLEEP_MAX);
> > +		msleep(LINK_WAIT_MSLEEP_MAX);
> 
> Just use fsleep(LINK_WAIT_USLEEP_MAX) and let the kernel decide which
> function to pick.

Odd.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/timers/timers-howto.rst?id=v6.7#n114
mentions fsleep() (with no real guidance about when to use it), but
https://www.kernel.org/doc/Documentation/timers/timers-howto.txt 
seems to be a stale copy from 2017, before fsleep() was added.  I
emailed helpdesk@kernel.org to see if the stale content can be
removed.

I do think fsleep() should be more widely used.

> >  /* Parameters for the waiting for link up routine */
> >  #define LINK_WAIT_MAX_RETRIES		10
> > -#define LINK_WAIT_USLEEP_MIN		90000
> > -#define LINK_WAIT_USLEEP_MAX		100000
> > +#define LINK_WAIT_MSLEEP_MAX		100

Since you're touching this anyway, it would be helpful to include the
units on the timeout.

USLEEP/MSLEEP is definitely a hint, but I think the "SLEEP" part
suggests something about atomic/non-atomic context and isn't relevant
to the time interval itself, and something like "TIMEOUT" would be
better.

I think an explicit "_US" or "_MS" would better indicate the units.

This is turning into a long tangent, but I'm not a huge fan of the
LINK_WAIT_* pattern where I have to look up the code that uses
LINK_WAIT_MAX_RETRIES and LINK_WAIT_USLEEP_MAX and do the math to see
what the actual timeout is.  Obviously not fodder for *this* patch.

Bjorn

