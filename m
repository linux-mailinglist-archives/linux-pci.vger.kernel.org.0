Return-Path: <linux-pci+bounces-16624-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B45E9C6B1F
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 10:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CC711F25324
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 09:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DCD51BD9D1;
	Wed, 13 Nov 2024 09:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bqbAeIzY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0041AA792;
	Wed, 13 Nov 2024 09:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731488572; cv=none; b=mc1mgFvGLGjGnqQ5qpVuA77XWqKPC80gm3qOUISs99GT3LO0+f1lp+PxTGPLHxC76hxOyJhQvxBpgH7Q48KQ5z8+v/7afEn3V5QlY5bHBPYwAbKYqXp2q0d8cn6fUnXzvGwMJ7FUIMzQGvUTYiw2LEU2+SALT8YeSj8zb62mtA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731488572; c=relaxed/simple;
	bh=MzLQHt+3PfSd3dpTibUH9DS+k1l1DF3kNMz+O6gVQRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MN/amnu62NYFBgQv8NlEq65KajtjPX1lW/HB9ttGO5F30PbDH7U/Q5PfqBbLgHZ3YZ2r6a7Fe83JUiHNBvjV7tOmVMYTz9pEtvO8BVZPnD9FZnh4bh2QtpWNoPyYFGjyezcJja0y0CMFSsayBsNScf45IeLsMevSC1d0w+iYkaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bqbAeIzY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 388C7C4CECD;
	Wed, 13 Nov 2024 09:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731488572;
	bh=MzLQHt+3PfSd3dpTibUH9DS+k1l1DF3kNMz+O6gVQRE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bqbAeIzYcofcVumgxn76QLfoNSKtZtK9yVE0jAT3IhKetTbKxw/jwQfVziUGwd1ga
	 2dv1zvzx4fQxQwMV8TBU4HlYoi8sGZkiKzFgd28d/lpkgB+clwfTNrr+M7q08qJobN
	 ryxPd2ItezUnYliYdmKQuo8T7AGYyXM/zrpNTvaCrql7yPNOdnJAe0WmLP0TdvY5In
	 lxUvL0dPLdNN99CDzt3hT0w7EovxHQb0QzkwLZv7/A8ZCWTHY8nj7QUNqKcljwaLC2
	 cw7EwRqrRjAgRjAHMQpn7PDRLyKo2zk0aih4hDHLB0Lld0aMR63mAzJLkpp31jjRlb
	 BnmXrZEWmfcBQ==
Date: Wed, 13 Nov 2024 10:02:46 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	imx@lists.linux.dev, dlemoal@kernel.org, maz@kernel.org,
	tglx@linutronix.de, jdmason@kudzu.us
Subject: Re: [PATCH v6 3/5] PCI: endpoint: pci-epf-test: Add doorbell test
 support
Message-ID: <ZzRrNvpz25bkWXog@ryzen>
References: <20241112-ep-msi-v6-0-45f9722e3c2a@nxp.com>
 <20241112-ep-msi-v6-3-45f9722e3c2a@nxp.com>
 <ZzO3OcCNtHUfm867@x1-carbon>
 <ZzO8jn6OpgFhl4TN@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzO8jn6OpgFhl4TN@lizhi-Precision-Tower-5810>

On Tue, Nov 12, 2024 at 03:37:34PM -0500, Frank Li wrote:
> >
> > Is there a reason why you chose to not incorporate the helper function
> > that I suggested here:
> > https://lore.kernel.org/linux-pci/ZzMtKUFi30_o6SwL@ryzen/
> >
> > I didn't see any reply from you to that message.
> 
> Oh, you said at
> https://lore.kernel.org/imx/ZzIVzfkZe-hkAb4G@ryzen/T/#mc10e69e0e1e20cc8d8da9a8808177407d22bce06
> 
> I think you give up your idea about helper function, because it is one
> for doorbell_offset, the other is for the atu address. bar's struct is
> difference with reg. even it is similar,

Yes, that is why the helper returns both base addess and offset
(just like .align_addr()).


> Do you means add help function, which wrap epc's .align_addr()? I know you
> make some improvement about EP's alignment, but I have not realized that
> related this thread at all.

Look at the suggested helper that I wrote in:
https://lore.kernel.org/linux-pci/ZzMtKUFi30_o6SwL@ryzen/

If you think that the code is cleaner, feel free to incorporate it in your
next version, no need to add my SoB.

.align_addr() is not related at all.
(.align_addr() is for alignment for outbound PCI address, and theoretically
the alignment requirement for outbound could be different from inbound
address alignment requirement (which is defined in epc->features->align).

The only relation is that both my suggested helper, and .align_addr() both
return a base address and an offset.


> May "I now see why you did this.
> One function is using the db offset, and the other is using the db base."
> mis-lead me.

Yes, I can see that this sentence can be misunderstood.


> If I understand correct here, I can add wrap function for epc's
> .align_addr(). at next version.

Please do not wrap .align_addr(). Kishon has been very clear that he wants
outbound and inbound translation requirements to not depend on each other.


Kind regards,
Niklas

