Return-Path: <linux-pci+bounces-27948-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7C3ABBA30
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 11:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 947837A6BF1
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 09:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37DD33086;
	Mon, 19 May 2025 09:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ifr4TaPb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA47D72639;
	Mon, 19 May 2025 09:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747647863; cv=none; b=ryc5NjRb1FqmGMiLMa3je6usrZq41Q8TTRmb1bRCPOVMuEOPpkckmcZyvIshMRYJT3AWx+TlhkG/EbdGpm5cX9T9euPobel7sdABWx85eUMbifVx5xkIQ8UKki/96ZW2C95uOkwuApR6ANTjNmatNm0IbFBwhEwYDZmBjXq+jGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747647863; c=relaxed/simple;
	bh=2/LB0JgJrsL1rxN13GlzeiLNUAj6gCH+jyeYbsdhuck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W6aG680Ph4xfekNfguicS9TUC/trUKF1YFb9BgUXATWHTirqnwS6lfa6EA0Hax4Z9q9BoUQ40A1pn7vsfjLvNdpXfbrS+lEfCPhf6RrJe73w0mSSubVoEWVjIPhwhCyoysge5VCsJI/fCrQd4IruSpOx3aQEEwqntaeQ4hI8tuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ifr4TaPb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC6F8C4CEE4;
	Mon, 19 May 2025 09:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747647863;
	bh=2/LB0JgJrsL1rxN13GlzeiLNUAj6gCH+jyeYbsdhuck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ifr4TaPbvbw62JQOtExEmw1IyI1IOF+9geyhvsnXDtMH9tur9SwdU4nJxzJlW0s5K
	 8t4tA1HjujMJR7Wnvk6yCM6VIBqJ6Kx+XQoOscpejlUffUY4/fnR44hAy14rNgNlq4
	 V4HWYr/p3VorRqmx2d/Ew26Y3GKHsyTh1OWrqccnmadj2NfWQY5kMa9z5zO9B9cGyr
	 GjMIobnOR74y9yoBSEwAe+YeBY5vgutPpvDZ4JWqE5b+EmJ+4RnjrMgJf1+XQjK0S3
	 9nlrA3409bdrzjdvo1rcqgijnxNjKIUNyTiCBibS0eBTg4g5XtREDkY1ytVFqmEd/l
	 MKzmSwRETwJMQ==
Date: Mon, 19 May 2025 11:44:17 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Laszlo Fiat <laszlo.fiat@proton.me>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Hans Zhang <18255117159@163.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>,
	"linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH v2 0/4] PCI: dwc: Link Up IRQ fixes
Message-ID: <aCr9cYhtcBJZ-9Fj@ryzen>
References: <20250506073934.433176-6-cassel@kernel.org>
 <7zcrjlv5aobb22q5tyexca236gnly6aqhmidx6yri6j7wowteh@mylkqbwehak7>
 <aCNSBqWM-HM2vX7K@ryzen>
 <fCMPjWu_crgW5GkH4DJd17WBjnCAsb363N9N_h6ld1i8NqNNGR9PTpQWAO9-kwv4DUL6um48dwP0GJ8GmdL4uQf-WniBepwuxTEhjmbBnug=@proton.me>
 <aCcMrtTus-QTNNiu@ryzen>
 <5l0eAX7zaDMDMp1vJhvB9MVKXSPn3Ra0ZiP5e2q1E4rwmADBB6MlREZO9cuD_zvclAOhhBE0-NFthVbOajeSCfYjchT-83OgLbjclOgx3T4=@proton.me>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5l0eAX7zaDMDMp1vJhvB9MVKXSPn3Ra0ZiP5e2q1E4rwmADBB6MlREZO9cuD_zvclAOhhBE0-NFthVbOajeSCfYjchT-83OgLbjclOgx3T4=@proton.me>

On Fri, May 16, 2025 at 06:48:59PM +0000, Laszlo Fiat wrote:
> 
> I have compiled a vanilla 6.12.28, that booted fine, as expeced. Then compiled a  version with the patch directly above.
> 
> >  We expect the link to come up, but that you will not be able to mount rootfs.
> >  
> 
> That is exactly what happened. 
> 
> >  If that is the case, we are certain that the this patch series is 100% needed
> >  for your device to have the same functional behavior as before.
> 
> That is the case.

Laszlo,

Thank you for verifying!

> 
> Bye,
> 
> Laszlo Fiat 

Mani, Krzysztof,

It does indeed seem like the reason for this regression is that this weird
NVMe drive requires some additional time after link up to be ready.

This series does re-add a similar delay, but in the 'link up' IRQ thread,
so even with this series, things are nicer than before (where we had an
unconditional delay after starting the link).

Do you require any additional changes?

Otherwise, I think it would be nice if we could get this queued up before
the merge window.


Kind regards,
Niklas

