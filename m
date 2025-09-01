Return-Path: <linux-pci+bounces-35280-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99ECAB3EAE4
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 17:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C082C202179
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 15:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36AAB2E6CAD;
	Mon,  1 Sep 2025 15:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZHPFTbci"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE462E6CA3;
	Mon,  1 Sep 2025 15:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756740295; cv=none; b=ismooE30NqCm2wQbnva/Wlp3NZIQv3pFDZGkTRZZnY3E5A7vli67r78vz0QCcbqyvVzY6Ws06eTO1/ewQPT16CfU+o6oqopaO5mjxrfRVRLV8Zm6R2L8Y1+AwutiXWYKOew4LxOq7HqmQryZ1ERJvDKTD0u9lRlU3RwKo7jEbvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756740295; c=relaxed/simple;
	bh=LUZzXor2dAsq0biAH6H2qGV+yMsSF2E2Io0tWwOnVw4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=NqFnPMLBKZ/DWrEZemrcN/8dfm3RJzpJn3EDHSzvcVGjWYHDIg24iydppDoOIZFuUinDriHIKR3KniNOkQtC2H0ytyAu9pSEHiOD/QZpmHjdPtwSlv25RdS+XOHu0+duk6hUAoE/pzlDyioyV1hEXHSVh0P7ddZv9NWB6PEvXMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZHPFTbci; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5325AC4CEF0;
	Mon,  1 Sep 2025 15:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756740294;
	bh=LUZzXor2dAsq0biAH6H2qGV+yMsSF2E2Io0tWwOnVw4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ZHPFTbciP55OFqeBHNlER97nbR+Jj65p5DTTnkYm5eDkPu7zJzb4NdYYw40OgrNF/
	 wsf9u1Z1McjMQYlPwfJkaQXLczkJv+vp1DTWTkGzllE0x9pYFHJaFlZnzaYbeau45B
	 N/LO1O1DyCZikDslsNe+v5AkgYGdjTi9kT816zvCds5ikYQmlVfXAMlfTlWIwuK+uD
	 12TgnYXPtJyw2Yv9lHlq9sPu1vrF7VwsZRBnZR6hFxGQUjaiDwzeYxQnUg/YHmMtn6
	 pye3nTgITLiEkFJ71Qe8JY0/JBTAhDC5/bDoghWK9qo95eYxW5xqLv8LijkxH/plHr
	 DQCye7nMgWYFw==
Date: Mon, 1 Sep 2025 10:24:52 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mark Brown <broonie@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Inochi Amaoto <inochiama@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Marc Zyngier <maz@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Anders Roxell <anders.roxell@linaro.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Longbin Li <looong.bin@gmail.com>,
	Linux Kernel Functional Testing <lkft@linaro.org>
Subject: Re: [PATCH] PCI/MSI: Check MSI_FLAG_PCI_MSI_MASK_PARENT in
 cond_[startup|shutdown]_parent()
Message-ID: <20250901152452.GA1114741@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c07c5bc-1b02-4b18-89b6-da13c16d62ab@sirena.org.uk>

[cc->to: Thomas]

On Mon, Sep 01, 2025 at 01:35:17PM +0100, Mark Brown wrote:
> On Wed, Aug 27, 2025 at 02:29:07PM +0800, Inochi Amaoto wrote:
> > For msi controller that only supports MSI_FLAG_PCI_MSI_MASK_PARENT,
> > the newly added callback irq_startup() and irq_shutdown() for
> > pci_msi[x]_templete will not unmask/mask the interrupt when startup/
> > shutdown the interrupt. This will prevent the interrupt from being
> > enabled/disabled normally.
> > 
> > Add the missing check for MSI_FLAG_PCI_MSI_MASK_PARENT in the
> > cond_[startup|shutdown]_parent(). So the interrupt can be normally
> > unmasked/masked if it does not support MSI_FLAG_PCI_MSI_MASK_PARENT.
> 
> Tested-by: Mark Brown <broonie@kernel.org>
> 
> This is causing multiple platforms to fail to boot in -next, it'd be
> great if we could get it merged to fix them.

It looks like you merged 54f45a30c0d0 ("PCI/MSI: Add startup/shutdown
for per device domains"), Thomas.  I assume you'll merge this fix too?

Let me know if you'd prefer that I take it.  Looks like a candidate
for v6.17.

Bjorn

