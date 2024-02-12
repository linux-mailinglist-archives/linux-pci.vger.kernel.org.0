Return-Path: <linux-pci+bounces-3362-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55229851C51
	for <lists+linux-pci@lfdr.de>; Mon, 12 Feb 2024 18:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0BD51F23031
	for <lists+linux-pci@lfdr.de>; Mon, 12 Feb 2024 17:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9363FB1D;
	Mon, 12 Feb 2024 17:56:37 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F328D3FB01;
	Mon, 12 Feb 2024 17:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707760597; cv=none; b=WEssJSmY/dIE7fgWMzW1h1v+RLL4CJW+7RrbyDW1Db1Dy4PpDW0GgkxrrUNtSdUG9O9b9BJD+cwZhT//pnD+Ceni995qVm5H1IUlPgrNhxJSTgsiB4B9wx7+cJtMlYlKyAVR3/vdYFoXVREh7qcI1q9plBhv+/F3F9mzEnHi54w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707760597; c=relaxed/simple;
	bh=I3MvNd9GG3UHQ1Uxe5i0qiVgl2rcA++mX9gcx6ezgTA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=tFOPY06ZcFlNAAeNvKmJwWiBDn7dWVMqL6DL5/G8PQorM9hv6LY+7u8w3rF4FzYz6SH/0WyE1zTzElrNVSlQ8neYghdviO3M22SKUgY+f9h5WQL6QghHHGCMGI2LlEvKqzROiYsh5pTSLh0gvG0UpC5WthGN8yUVo4dCxAHOxi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 47C1592009D; Mon, 12 Feb 2024 18:56:26 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 4452592009B;
	Mon, 12 Feb 2024 17:56:26 +0000 (GMT)
Date: Mon, 12 Feb 2024 17:56:26 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 1/2] PCI: Clear LBMS on resume to avoid Target Speed
 quirk
In-Reply-To: <alpine.DEB.2.21.2402011800320.15781@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2402121745300.2376@angie.orcam.me.uk>
References: <20240129184354.GA470131@bhelgaas> <aa2d1c4e-9961-d54a-00c7-ddf8e858a9b0@linux.intel.com> <alpine.DEB.2.21.2401301537070.15781@angie.orcam.me.uk> <a7ff7695-77c5-cf5a-812a-e24b716c3842@linux.intel.com> <d5f14b8f-f935-5d5e-e098-f2e78a2766c6@linux.intel.com>
 <alpine.DEB.2.21.2402011800320.15781@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 1 Feb 2024, Maciej W. Rozycki wrote:

> > > There's always an option to store it into pci_dev for later use when the 
> > > quirk is found to be working for the first time if other solutions don't 
> > > work.
> 
>  Indeed there is.

 On second thoughts there is not.

 The thing is if we handle a situation where the downstream device can be 
replaced while in suspend (which I infer from the discussion that we do), 
then it could be that one device will require the quirk while the other 
one will not.

 So any previous results have to be considered irrelevant and the whole 
dance with the quirk has to be repeated every time at resume or hot-plug.

  Maciej

