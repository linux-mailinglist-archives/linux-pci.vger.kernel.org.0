Return-Path: <linux-pci+bounces-13188-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC2C9785DA
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2024 18:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB902B21B56
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2024 16:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F8C7441F;
	Fri, 13 Sep 2024 16:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E4DSdGA4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176C4768E7;
	Fri, 13 Sep 2024 16:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726245290; cv=none; b=fR9TYnS3vuuzoF/fwkzZt/Om+3Mbw9t/4o7H2iwZ5i4PlAiWGUbmloglv0P1eo6J86jQvIvfV9WvGJSmg2yzJFp//gDBIpv6BjLvCrC79TH1ElKk0bGFiRNemrwkmZLdr0sPAlrqYNerFoaR/+j+4WwgiZ3XnfMfgiVU4kTjlsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726245290; c=relaxed/simple;
	bh=vQPP56yjuxWhcrtvbKIVij85Q+raOMGX7VA2/Cu0qZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=caay4ixwwfYFtK/V7Qtjc2466XlBjHYdFnQ1uX71tbcdE4oO5ttVXbSC2iS1oNJtxO5CCgxC6ZlOeF8Wc/IaG2nNvFt0sPE5er9LgyInHkRC4SS7LJ9+RqZrAAxvROVi222A5ccsht6voDMqoTvrKvhYHJR+uDsthYVhP6VuHKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E4DSdGA4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1E69C4CEC0;
	Fri, 13 Sep 2024 16:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726245289;
	bh=vQPP56yjuxWhcrtvbKIVij85Q+raOMGX7VA2/Cu0qZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E4DSdGA4neBDM5y/bpTOa4HxApLTXmHPmAkE6p+G/m2KgkHgAHSz5hFTWv1n0I3LN
	 mn2W147OnPLO23C/6qQmOp5xPf0ou4qeIqZUXESwRBzYHqxnTnp8YCcVqejoNk1Lm2
	 /Vw7tMO0/jYg7ExksW6xAxnAUo1LXUMnw+qoNOGd4HRE8C/amth9ZfPSXGhcUmXVgD
	 X/lsx+592fQvC8mKqDwPih6VYYfBI8GmdiGYl0JRkIO2/Q/CMJFkwABOKphdbyWwwE
	 RUa0SaVWR+G6nQLna3JDEj2XjPCmFm6ExJxosgblap2cs+p1SOag8Mj7Dulk/6a/5B
	 PvOP2+1GGt8eQ==
Date: Fri, 13 Sep 2024 10:34:46 -0600
From: Keith Busch <kbusch@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	jonathan.derrick@linux.dev, acelan.kao@canonical.com,
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, kaihengfeng@gmail.com
Subject: Re: [PATCH] PCI: vmd: Delay interrupt handling on MTL VMD controller
Message-ID: <ZuRppgocLShsfafm@kbusch-mbp>
References: <CAAd53p4EWEuu-V5hvOHtKZQxCJNf94+FOJT+_ryu0s2RpB1o-Q@mail.gmail.com>
 <ZtciXnbQJ88hjfDk@kbusch-mbp>
 <CAAd53p4cyOvhkorHBkt227_KKcCoKZJ+SM13n_97fmTTq_HLuQ@mail.gmail.com>
 <20240904062219.x7kft2l3gq4qsojc@thinkpad>
 <CAAd53p5ox-CiNd6nHb4ogL-K2wr+dNYBtRxiw8E6jf7HgLsH-A@mail.gmail.com>
 <20240912104547.00005865@linux.intel.com>
 <CAAd53p698eNQdZqPFHCmpPQ7pkDoyT4_C9ERXJ4X=V_8QFO8pQ@mail.gmail.com>
 <20240913111142.4cgrmirofhhgrbqm@thinkpad>
 <ZuRZLRFrCjXlrd4w@kbusch-mbp>
 <20240913161447.7irp2p5a2sjpobf3@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913161447.7irp2p5a2sjpobf3@thinkpad>

On Fri, Sep 13, 2024 at 09:44:47PM +0530, Manivannan Sadhasivam wrote:
> 
> For the workaround, does it make sense to have a platform specific quirk in the
> NVMe driver? Because, reading the NVMe device register from VMD driver doesn't
> look plausible to me.

I don't know.

Does the breakage really need a register read on the device that
dispatched the original MSI? The VMD driver has no idea which device
sent it. If you really need to query every single device in the domain,
your performance is going to tank. It's bad enough issuing just a single
read in the IRQ handler, but to all of them?

