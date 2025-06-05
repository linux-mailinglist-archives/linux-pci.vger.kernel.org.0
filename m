Return-Path: <linux-pci+bounces-29055-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D71F8ACF7FA
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jun 2025 21:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 145F53B0441
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jun 2025 19:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C42927CB28;
	Thu,  5 Jun 2025 19:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lk92OT84"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F2F27CB1B
	for <linux-pci@vger.kernel.org>; Thu,  5 Jun 2025 19:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749151680; cv=none; b=LXuY7IwwvRxF4J7qvfgeMeFNvdvYBFBQR+M8jOPPX7N7k+82GO/B0Gpza8v7JIRSr+/hPYtxwwg/xZEQA5Xkp1fijtGrxHxWEkMOKa0LURcs4kVDJJRbBb6HuiNaRCTkXSotVF45evAlQ7YeszNIMeo2fW0BMZ9Nn7J+PCZaqe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749151680; c=relaxed/simple;
	bh=L08Z+c86rt+7Uew7RNlKjl+fcB40BUMD0TL4zqIMrEU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=S3HE1/fqmaR+fynEktO+vr8GwNPgMxzpbPuBAupdaYMIs+HJGJITeGxgT2UGNMjwzfMj95xPbsqWy0m8Ca0uhk22R7Z3tb+InfihDI9m1NgSx3JepPivMCrzwpBye3/MIM64qHaw0CeUY9neBs3YtGBIsjH61NySWepZ4+mgsXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lk92OT84; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A07F9C4CEE7;
	Thu,  5 Jun 2025 19:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749151679;
	bh=L08Z+c86rt+7Uew7RNlKjl+fcB40BUMD0TL4zqIMrEU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=lk92OT84u8fE1CrfvOVMIyfSH1us3TkX1bnAlMhfHe9ioRSKeSoG40ZxKGzNftNXP
	 H6C27vxmEKD4MXvOjLJsf3zSBYp+zdlS/zmX5sUgjOPIHNPM71mv07CcbUqyPA1pJi
	 diUDfKebgiSQ39Mdo2sT15lzynBVESgGJ54txwHIoXIpnaYGOzb3SvYF5XpoJ78Ruv
	 GUk0bh2AQH1fEwt67fW0NPYFLj672t/uhGgi9HSJ+TX2IKsQFBXBXccoR9V6hUsYtz
	 pB6GE6uYVcYAG/5CW5J+RB5IbayIIrJyl6w7jfMVGvzd7lBK3ZcD2Qr9Trq543pgwD
	 Ma5PLN4cDZk7Q==
Date: Thu, 5 Jun 2025 14:27:58 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Hans Zhang <18255117159@163.com>,
	Laszlo Fiat <laszlo.fiat@proton.me>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 1/4] PCI: dw-rockchip: Do not enumerate bus before
 endpoint devices are ready
Message-ID: <20250605192758.GA622022@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEGNefEgf56P-mBM@ryzen>

On Thu, Jun 05, 2025 at 02:28:41PM +0200, Niklas Cassel wrote:
> On Wed, Jun 04, 2025 at 01:44:45PM -0500, Bjorn Helgaas wrote:
> > On Wed, Jun 04, 2025 at 10:40:09PM +0530, Manivannan Sadhasivam wrote:
> > 
> > > > If we add a 100 ms sleep after wait_for_link(), then I suggest that we
> > > > also reduce LINK_WAIT_SLEEP_MS to something shorter.
> > > 
> > > No. The 900ms sleep is to make sure that we wait 1s before erroring out
> > > assuming that the device is not present. This is mandated by the spec. So
> > > irrespective of the delay we add *after* link up, we should try to detect the
> > > link up for ~1s.
> > 
> > I think it would be sensible for dw_pcie_wait_for_link() to check for
> > link up more frequently, i.e., reduce LINK_WAIT_SLEEP_MS and increase
> > LINK_WAIT_MAX_RETRIES.
> > 
> > If LINK_WAIT_SLEEP_MS * LINK_WAIT_MAX_RETRIES is for the 1.0s
> > mentioned in sec 6.6.1, seems like maybe we should make a generic
> > #define for it so we could include the spec reference and use it
> > across all drivers.  And resolve the question of 900ms vs 1000ms.
> 
> Like Bjorn mentioned, when I wrote reduce LINK_WAIT_SLEEP_MS,
> I simply meant that we should poll for link up more frequently.
> 
> But yes, if we reduce LINK_WAIT_SLEEP_MS we should bump
> LINK_WAIT_MAX_RETRIES to not change the current max wait time.
> 
> 
> Bjorn, should I send something out after -rc1, or did you want
> to work on this yourself?

Yes, please post something after -rc1.  Given the number of drivers
and the much smaller number of msleep() calls, I suspect lots of
drivers have similar problems.

Bjorn

