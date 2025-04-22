Return-Path: <linux-pci+bounces-26419-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 211FEA97404
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 19:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2932B1B61812
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 17:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2C528FFF1;
	Tue, 22 Apr 2025 17:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RFDUeYUU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADAD19F42C
	for <linux-pci@vger.kernel.org>; Tue, 22 Apr 2025 17:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745344401; cv=none; b=nORmJK8Bq9LVVi4oNQMjxDLx59VaGn17ibTW+jyF6OQncfbVBwQK85NNyZioJPim/dYHXgR1oLoyzm1RvTz8xdz3m9rS513Z2hd0UjU++Q0g5CjAG92kbuhQ5MoD1XHsAVBKjPYNGUjEpyRTgUM5VLzu2cGjtvlSHPBWh2iHGAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745344401; c=relaxed/simple;
	bh=o9Xryt4WwSkId/sswJVfPGkYcQPPaUVMZJnKfvsLbc8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=eLb/DRMF0TwR8iv53QOt7sWjOQZwcx9H1+WG6dL0mXnQvbnTQ7GdeowfJi/rnogXzhz/R8idvEFNI3KxfTuTlY+wFFVDYG4KU8wmI6EGRluK1YxuUVVCPcBP3x4JtSzaUpeQMh4qXefFI/QvkEjFS40BsIg6JZ6+uY14Y7ijIq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RFDUeYUU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 979B2C4CEE9;
	Tue, 22 Apr 2025 17:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745344400;
	bh=o9Xryt4WwSkId/sswJVfPGkYcQPPaUVMZJnKfvsLbc8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=RFDUeYUUsBLrvTeU/t/hwsGND30PJ7FsAeY3YQxoQE6lKFO+RhtbqiAQk9Gy/Vlpp
	 j/fzTmFYGph4KWE2rcLY3RuNkoi86S6TkkyymZx9cPyc7l1Ny36mwMHppeX5L7FxUf
	 0gORYZO3jEAx0/alzpNgIXxAg2UIRnni/evLwDa8rZlTmlsGRUuuPnFDoRphziV1nt
	 hEkYjLHSqgWj/k5I6NLPw/OqSkEhBvpV87CUBsfS/WVo5EXJpJz8UlupCyODpBX+a3
	 zcuAYJKs5vJUSamW1SNkQL/hw9Co5moqsVGvj5DmWiAtHo2xyvbJXTiqTP/SgzuRmc
	 33QJgFzfNC9Mw==
Date: Tue, 22 Apr 2025 12:53:19 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: bhelgaas@google.com, kw@linux.com, Niklas Cassel <cassel@kernel.org>,
	Frank Li <Frank.Li@nxp.com>, linux-pci@vger.kernel.org,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: Re: [PATCH RESEND] misc: pci_endpoint_test: Defer IRQ allocation
 until ioctl(PCITEST_SET_IRQTYPE)
Message-ID: <20250422175319.GA373387@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174512170695.5723.16265162524139108187.b4-ty@linaro.org>

On Sun, Apr 20, 2025 at 09:31:46AM +0530, Manivannan Sadhasivam wrote:
> On Wed, 16 Apr 2025 16:28:26 +0200, Niklas Cassel wrote:
> > Commit a402006d48a9 ("misc: pci_endpoint_test: Remove global 'irq_type'
> > and 'no_msi'") changed so that the default IRQ vector requested by
> > pci_endpoint_test_probe() was no longer the module param 'irq_type',
> > but instead test->irq_type. test->irq_type is by default
> > IRQ_TYPE_UNDEFINED (until someone calls ioctl(PCITEST_SET_IRQTYPE)).
> > 
> > However, the commit also changed so that after initializing test->irq_type
> > to IRQ_TYPE_UNDEFINED, it also overrides it with driver_data->irq_type, if
> > the PCI device and vendor ID provides driver_data.
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/1] misc: pci_endpoint_test: Defer IRQ allocation until ioctl(PCITEST_SET_IRQTYPE)
>       commit: 9d564bf7ab67ec326ec047d2d95087d8d888f9b1

a402006d48a9c ("misc: pci_endpoint_test: Remove global 'irq_type' and
'no_msi'") appeared in v6.15-rc1, and apparently caused a regression
that some driver fails to probe on such platforms.

Since a402006d48a9c caused a regression and hasn't appeared in a
release yet, this sounds like a candidate for v6.15 via pci/for-linus?

I can move it if you agree.  I *would* like to have a little more
detail about the regression, e.g., the affected driver, so I can
justify merging this after the merge window.

Bjorn

