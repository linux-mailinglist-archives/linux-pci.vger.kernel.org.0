Return-Path: <linux-pci+bounces-31233-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0013AF1063
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 11:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8248C1891439
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 09:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D8D254AF4;
	Wed,  2 Jul 2025 09:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DbUyKpea"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922D9253F30
	for <linux-pci@vger.kernel.org>; Wed,  2 Jul 2025 09:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751449398; cv=none; b=HG8+sjCz5SUhzoAahp6Na7BVkElr2qHMiDZMhrmzCqcRGEbk7891HM51KgzcIj7Ma+0Y3cjJaHwTRnibLQIqwVRBbWDOVWshTTiZqUUrCi62LeXkp0ET/gcYlNu6TdLVGnEWco7N/9rhYpWC8vLjA6u4dgYfNWOg8t/aTBJQqzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751449398; c=relaxed/simple;
	bh=FfU8UyZIqVtwRXpjwrqKk4UczlJR9TMeUtOPhhfHZt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QjsGgXQXGNRxtrP5mNyy3aIm1C1sCxREOoZlqyQcQTODm426ZcYA4B/MZHb+YSTYOrv0YpDvWljV8adII4ttIfJdIJiwAFd8OjWVzhwHfn1k83G35jfr9rBv7vZrodEX2Ee22rdkncWoBiOofra+Vgr6fAchOetPwjlbLKl09KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DbUyKpea; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D03DEC4CEED;
	Wed,  2 Jul 2025 09:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751449396;
	bh=FfU8UyZIqVtwRXpjwrqKk4UczlJR9TMeUtOPhhfHZt0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DbUyKpeaExUOp4PLcUGvmBO5LSMS59EEqGtLR44uulLrH/yQWC8sKonsf5+qnh8aJ
	 wcr/P3tiSKTn2RtPJdWgLItEx3lOPtgdAcs4BBT6FZz4veTSVYWoKFdBff3ewgMCuK
	 esWwI3OTcr6FmokupVB4BC+B/8t3qqA6CAhDBQ/8t6MSpBboVrKhuC+YBGmLJvby+f
	 84y+AuJl/pa6EGvSKLCk9JiFQWrRzLmYMyRX7IaEAPN9zSK8CYT+sskH+3SdNDJAXm
	 j0L29z5B28/I4ngmtZAtq1dMOaglcIZwbuMmXZMFWsxI0x5lAMeh4TSj9u6PhMCEOu
	 A9Dc+zLlE6iRg==
Date: Wed, 2 Jul 2025 11:43:11 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Laszlo Fiat <laszlo.fiat@proton.me>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 5/7] PCI: dwc: Ensure that dw_pcie_wait_for_link()
 waits 100 ms after link up
Message-ID: <aGT_L_hglVBP6yzB@ryzen>
References: <hcjcvo4sokncindwqhhmsx5g25ovj5n5zghemeujw7f4kqiaia@hbefzblsrhqx>
 <20250701163844.GA1836602@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701163844.GA1836602@bhelgaas>

On Tue, Jul 01, 2025 at 11:38:44AM -0500, Bjorn Helgaas wrote:
> > 
> > No. The PERST# delay should be handled by the glue drivers since
> > they are the ones controlling the PERST# line. Doing an
> > unconditional wait for both the cases in DWC core, seems wrong to
> > me.
> 
> It ends up being a little bit weird that the delay is in the DWC core
> (dw_pcie_wait_for_link()) for ports that support fast links, and in
> the glue drivers otherwise.  It would be easier to verify and maintain
> if the delay were always in the DWC core.
> 
> If we had a dw_pcie_host_ops callback for PERST# deassertion, the
> delay could be in the DWC core, but I don't know if there's enough
> consistency across drivers for that to be practical.

Currently, there is not much consistency between the glue drivers, so
adding a DWC core API to assert/deassert PERST# sounds like a good idea
to me. The callback could even be supplied a struct gpio_desc pointer.

Like I mentioned in my previous email:
https://github.com/torvalds/linux/blob/v6.16-rc4/drivers/pci/controller/dwc/pci-imx6.c#L885
https://github.com/torvalds/linux/blob/v6.16-rc4/drivers/pci/controller/dwc/pcie-qcom.c#L294
https://github.com/torvalds/linux/blob/v6.16-rc4/drivers/pci/controller/dwc/pcie-keembay.c#L89

these drivers seem to have a 100 ms delay after PERST# has been deasserted,
but there are of course more glue drivers, so a lot of them will not have a
100 ms wait _after_ PERST# is deasserted. (All glue drivers seem to have a
delay between asserting and deasserting PERST#.)

Right now, e.g. qcom will have a 100 ms delay both after deasserting PERST#
and after link up. (However, based on the supported link speed, only one of
the delays should be needed.)

However, my main concern is not that qcom waits twice, it is those drivers
that do not have a 100 ms delay after PERST# has been deasserted, because
before commit 470f10f18b48 ("PCI: Reduce PCIE_LINK_WAIT_SLEEP_MS"), those
drivers might have been "saved" by the ridiculously long
PCIE_LINK_WAIT_SLEEP_MS.

However, now when we sleep less in each iteration when polling for link up,
those drivers that do not have a 100 ms delay after PERST# has been
deasserted might actually see regressions, because (the now reduced)
PCIE_LINK_WAIT_SLEEP_MS time is no longer "saving" them.

If we don't want to make the PCIE_RESET_CONFIG_WAIT_MS wait unconditional
(not care about the supported link speed), then perhaps we should drop
470f10f18b48 ("PCI: Reduce PCIE_LINK_WAIT_SLEEP_MS") from pci/next ?


Kind regards,
Niklas

