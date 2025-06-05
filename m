Return-Path: <linux-pci+bounces-29029-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F18BDACEF35
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jun 2025 14:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A206616C236
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jun 2025 12:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB78214813;
	Thu,  5 Jun 2025 12:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g2s7MXZr"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5742147ED
	for <linux-pci@vger.kernel.org>; Thu,  5 Jun 2025 12:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749126528; cv=none; b=pzdV71Vm5fLlKrauFd2iM2ffTDVEAw0OQKgUcii7rGUlxcjiv/LTh/PIl1Ay6TLrAOWAJY203GMiPkIm4SdkwMwbfm5uAS9PqUH7Nc95qiZklusVNxX8doTtAF+MHVkTQl6KwJsen6AMNfQpaV+bGsRqg9JuaP68ziHppqUxH14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749126528; c=relaxed/simple;
	bh=OsTzD+oORNTzhAZmxmT/ueCMxPcm05WUBUz9VWZM/PI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nd60pUIFbVfEufSW2bfZqBR2PigZcqHhn0L1k3auSBTvzbJutgtll7A43vLQlNlLPSwUWXW/8IyXF1yZVzaXav+ltV19PxKTs4oKv8hLtFfyRPkEy58cCS4raPWxbSXM4DN2Y/WDefCpFaDfWlOWbHqio1xWWodmpHdEdYMzYT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g2s7MXZr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80FADC4CEE7;
	Thu,  5 Jun 2025 12:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749126527;
	bh=OsTzD+oORNTzhAZmxmT/ueCMxPcm05WUBUz9VWZM/PI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g2s7MXZrn6Og/9t2StYKytwNqM8xht9QkdPBaXhclk+Rpfm8jYQGfNh+/87G9Z7Aj
	 bUjNTQDxBwTbexMFcNXzCn/g2ap8mMmhubkmnKRIcFwa7OM2PqvMrSk+Cb5DhL05VG
	 RUNxClMieuWFyzVnIeyEAYVQVdGLK1B33ObOk+791RlcHnjPIbuKqV+TU7+ghzBphh
	 BS/IkXrrg40u2+6oU3XMvhlPhqFNhgW7EwLTg3XwTJq+IDQPbJixpzZCQmwoPv528A
	 /98ac8Rix/Iw+xCS0pULxLA1GOPJnaZCWjLb12W3cq0O7Q1ODGUZHPfWTnUfC9KkDR
	 8jNrzYlOgItEg==
Date: Thu, 5 Jun 2025 14:28:41 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
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
Message-ID: <aEGNefEgf56P-mBM@ryzen>
References: <rrtrcwajj4vjvbqzosskdnroqnijzaafncgckoh2dlk3c4njvs@twop3vyidmh7>
 <20250604184445.GA567382@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250604184445.GA567382@bhelgaas>

On Wed, Jun 04, 2025 at 01:44:45PM -0500, Bjorn Helgaas wrote:
> On Wed, Jun 04, 2025 at 10:40:09PM +0530, Manivannan Sadhasivam wrote:
> 
> > > If we add a 100 ms sleep after wait_for_link(), then I suggest that we
> > > also reduce LINK_WAIT_SLEEP_MS to something shorter.
> > 
> > No. The 900ms sleep is to make sure that we wait 1s before erroring out
> > assuming that the device is not present. This is mandated by the spec. So
> > irrespective of the delay we add *after* link up, we should try to detect the
> > link up for ~1s.
> 
> I think it would be sensible for dw_pcie_wait_for_link() to check for
> link up more frequently, i.e., reduce LINK_WAIT_SLEEP_MS and increase
> LINK_WAIT_MAX_RETRIES.
> 
> If LINK_WAIT_SLEEP_MS * LINK_WAIT_MAX_RETRIES is for the 1.0s
> mentioned in sec 6.6.1, seems like maybe we should make a generic
> #define for it so we could include the spec reference and use it
> across all drivers.  And resolve the question of 900ms vs 1000ms.

Like Bjorn mentioned, when I wrote reduce LINK_WAIT_SLEEP_MS,
I simply meant that we should poll for link up more frequently.

But yes, if we reduce LINK_WAIT_SLEEP_MS we should bump
LINK_WAIT_MAX_RETRIES to not change the current max wait time.


Bjorn, should I send something out after -rc1, or did you want
to work on this yourself?


Kind regards,
Niklas

