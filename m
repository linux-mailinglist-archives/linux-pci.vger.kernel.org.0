Return-Path: <linux-pci+bounces-9600-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E502A9244B7
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2024 19:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A00BE28153D
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2024 17:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C53515B0FE;
	Tue,  2 Jul 2024 17:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hgRdN42D"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441C11BE233;
	Tue,  2 Jul 2024 17:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719940442; cv=none; b=HR48Jr+R7lx0ge37riajauZuqQLFF+CSrvt9ycHsVsVlFv0xYQwNjAaLTVxTtUfsREqPaXxFjrGbidja7PjHYmTJUOC7mb5wll6/00axM4gzXFYPzvuiIvmyCybs/B6lf8gVXSAzAGsqMhNEEQy3pCXxNNaKkmdIgfXu28SH2cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719940442; c=relaxed/simple;
	bh=2ITM9L2abJMkHRfx87O8Fll+X5i0cyQsu39c7p/wz6g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=KehDpnAWyQZjaRXmUPEq/psjtS0uLUAegixtZkTLsUbIwOyj+/bHS8+SBG0yloX8HARAQSeEfFoTzybCjiH4iOvL+QLCLry8rRekxkIKK8PMp+gTs54Gqeo396cneihWPtxsMMVnBqMHqEQBjuOpZIRvXoK3nrGDRZRkxRszySw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hgRdN42D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5F7BC4AF0A;
	Tue,  2 Jul 2024 17:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719940442;
	bh=2ITM9L2abJMkHRfx87O8Fll+X5i0cyQsu39c7p/wz6g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=hgRdN42Dq5MlV5rvOF3z0uhqvcuvakRyvTjXsAuT5e3RI83ce6ZT8wO6sZOpmnr2T
	 uOthuR6e2cvohaFvKvRLQa5ooerilKNC58NTAOcD3M8pKFyDP3Pp0Si44glaVBPvO/
	 ocUtZw7lsDlsx5RVq0dsGFaCSEq3/ItW7XpKXEjEWMV7YyTzG+kgIdYOB/MDQI9iPJ
	 j9FMq5B91M51ldJISeq+Co6yjZPoMLXgsd7jKxIevXOIm5MK95GkyAEObc4hTUBlye
	 53bAH/hpdHix0zoIQAD2jPrrb94af41uUzVeU7ftyAt/fCSq9Ms2QvuaTQOh/r3by9
	 BP/JYIjMRHL3A==
Date: Tue, 2 Jul 2024 12:14:00 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, jingoohan1@gmail.com, mani@kernel.org,
	marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v9 4/5] PCI: rcar-gen4: Add support for r8a779g0
Message-ID: <20240702171400.GA25366@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611125057.1232873-5-yoshihiro.shimoda.uh@renesas.com>

On Tue, Jun 11, 2024 at 09:50:56PM +0900, Yoshihiro Shimoda wrote:
> Add support for r8a779g0 (R-Car V4H).
> 
> This driver previously supported r8a779f0 (R-Car S4-8). PCIe features
> of both r8a779f0 and r8a779g0 are almost all the same. For example:
>  - PCI Express Base Specification Revision 4.0

This item is too general to be really useful.  I don't think it means
the device supports every feature described in the r4.0 spec.  I
suspect it means it supports the 16.0 GT/s transfer rate that was
added in r4.0?  *That* would be useful information here.  Perhaps also
the number of lanes it supports.

