Return-Path: <linux-pci+bounces-25845-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 993B6A886C4
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 17:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5424016B784
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 15:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6AD523D2BB;
	Mon, 14 Apr 2025 15:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TS5UHBQz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917CB42A92
	for <linux-pci@vger.kernel.org>; Mon, 14 Apr 2025 15:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744643671; cv=none; b=dCS1ORkCQ8dmQ2T6YcUhLEmYlwWSGxQvSRDePMtCzX38ZUvskVXZ1D99eumSnCfs3T1b+ZAs75Vg/wBHIy6TXGoWP2r0fxIn97Et+uh8TwcAcOzgKweeuVWvamrD2O/hIJYnNPxs03AGu67eKrhNK4JG8IfoUTdWjxtRi94ViLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744643671; c=relaxed/simple;
	bh=ITfm8Yp2mpWG3vQeYCNTqTmfAHGo7zrVzPaA1KhEA64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kuQhbp4yckebOfRoiL5dPM65ek43oTTW5/8iea9OaEqcUsTwIixUVn9lZD3sWHUUUe9E/6IRKVmNATDVSm1Z7Xu4Y9I/GO49Ur4HCCvSd1Ebyw54pV52dfTMnejXBZqSryGTg0AlTlxfaTeeZCWbjtixGqi4CxmXgSkvRDrQF2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TS5UHBQz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52C0AC4CEE2;
	Mon, 14 Apr 2025 15:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744643670;
	bh=ITfm8Yp2mpWG3vQeYCNTqTmfAHGo7zrVzPaA1KhEA64=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TS5UHBQz34s744vnCqRuKMNVKUErml7JBYKNtA9VpFZbKfX8ImY38eM7i3B7oi3y2
	 mbxGb/7f6AJryntjwrP+VU/kyY5GOeTJjr8+md305/VcYokp36gSGPkUq7RQYNT2AE
	 c7gkKIW6h5HqeJEpkJbea6EstonzNiJeXcJOh0ELMWT6pM5nQrxYeRfF5dYWUny0D/
	 wzb2lQEjIJrB3sWEUvBaTlw/Z3qqJsbGDRxgOfkVcVUVn27arW9HUWw1Pm5YywL9iU
	 TI7XQJhq8QWo75rv4dU2Cd/hqrWjEM85ot50eI4jMnLQqnTqoT4phGl+l5+s7bpXm0
	 ozQI33D0DRZ4g==
Date: Mon, 14 Apr 2025 17:14:26 +0200
From: Niklas Cassel <cassel@kernel.org>
To: bhelgaas@google.com, kw@linux.com, manivannan.sadhasivam@linaro.org
Cc: Frank Li <Frank.Li@nxp.com>, linux-pci@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: Re: [PATCH] misc: pci_endpoint_test: Defer IRQ allocation until
 ioctl(PCITEST_SET_IRQTYPE)
Message-ID: <Z_0mUhHzGqNrMBGg@ryzen>
References: <20250402085659.4033434-2-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402085659.4033434-2-cassel@kernel.org>

On Wed, Apr 02, 2025 at 10:57:00AM +0200, Niklas Cassel wrote:
> Commit a402006d48a9 ("misc: pci_endpoint_test: Remove global 'irq_type'
> and 'no_msi'") changed so that the default IRQ vector requested by
> pci_endpoint_test_probe() was no longer the module param 'irq_type',
> but instead test->irq_type. test->irq_type is by default
> IRQ_TYPE_UNDEFINED (until someone calls ioctl(PCITEST_SET_IRQTYPE)).
> 
> However, the commit also changed so that after initializing test->irq_type
> to IRQ_TYPE_UNDEFINED, it also overrides it with driver_data->irq_type, if
> the PCI device and vendor ID provides driver_data.
> 
> This causes a regression for PCI device and vendor IDs that do not provide
> driver_data, and the driver now fails to probe on such platforms.
> 
> Considering that the pci endpoint selftests and the old pcitest always
> call ioctl(PCITEST_SET_IRQTYPE) before performing any test that requires
> IRQs, simply remove the allocation of IRQs in pci_endpoint_test_probe(),
> and defer it until ioctl(PCITEST_SET_IRQTYPE) has been called.
> 
> A positive side effect of this is that even if the endpoint controller has
> issues with IRQs, the user can do still do all the tests/ioctls() that do
> not require working IRQs, e.g. PCITEST_BAR and PCITEST_BARS.
> 
> This also means that we can remove the now unused irq_type from
> driver_data. The irq_type will always be the one configured by the user
> using ioctl(PCITEST_SET_IRQTYPE). (A user that does not know, or care
> which irq_type that is used, can use PCITEST_IRQ_TYPE_AUTO. This has
> superseded the need for a default irq_type in driver_data.)
> 
> Fixes: a402006d48a9c ("misc: pci_endpoint_test: Remove global 'irq_type' and 'no_msi'")
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Considering that e.g. NXP platforms are currently broken without this,
this should go into v6.15 IMHO.


Kind regards,
Niklas

