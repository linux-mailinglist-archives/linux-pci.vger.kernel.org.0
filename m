Return-Path: <linux-pci+bounces-17211-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC1D9D5F6E
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2024 14:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21C681F21414
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2024 13:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEEBC1D2F78;
	Fri, 22 Nov 2024 13:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JW1OnSWP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE922309B9
	for <linux-pci@vger.kernel.org>; Fri, 22 Nov 2024 13:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732280427; cv=none; b=OEKZc+NoWYZ5k3aIC51LGPatcwRj300WH3ONqiHEki+cpYleFW+UbJmZBg2TCaR+k8yZlZp60MbIGECsnIqQnqHJunGbp1lnm4aa9n15xwH8VhoewdqJzHz1QsFdHB4gmz7YzM2TI2pxNxCeC1ocnQaXsdYSsPWgoN/JQo8IIhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732280427; c=relaxed/simple;
	bh=54w+ycjqxh1KLAcDNWP8671SG0R3CrONRXot3ubzWYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oJmeLinZf2jdQBqbwdX7gFYm0+yjcrwzLhD9hoQc02V4bsUt3tK+PFRP7sFG97dgjeYyxL3vh4i4fq9bbBPqOjx84t4OOcR0wpynvr2xKOEMk5Wa4vvf3ftprUP9d3QG7SvwQKeRndVofSDHW5OtdTDLH3w/6MJuN2i+DR0sTKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JW1OnSWP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEB0FC4CECE;
	Fri, 22 Nov 2024 13:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732280426;
	bh=54w+ycjqxh1KLAcDNWP8671SG0R3CrONRXot3ubzWYw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JW1OnSWPG6AlTKHgV7t6vSjyR0FBbBS/wCnOuX/yCr+5e+4f5m7t13axqmbGQgES5
	 HA5u8SYaj0PrV5UWmkfP3h3QzhwKL/Y/qENxscIeyVBEF863HbdSNSYpAm24tQ1nEz
	 yhgb9xqg85cW8bkn/cPgiznYkUa9qzxRN7YoMMnJPGk7TG/UqX1PsR+FfAgv6Mp3qD
	 hJeBZXHT85S6pq1V7pJSGsgzCyYB6/Lov0oR9gsp7a2OEoQ8Ft8PwmOblK2MjZdV3W
	 GLa0gkNktffyQ/C2FP0ck71XsMeakzACBTks7qHx/aQQklLeLLtgunZbuF5VJLI2gB
	 Stam4KT40HQgA==
Date: Fri, 22 Nov 2024 14:00:21 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>, Jon Mason <jdmason@kudzu.us>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Jesper Nilsson <jesper.nilsson@axis.com>, linux-pci@vger.kernel.org
Subject: Re: DWC PCIe endpoint iATU vs BAR MASK ordering
Message-ID: <Z0CAZZy8U5fMmOYs@ryzen>
References: <ZzxeBrjYRvYgMFdv@ryzen>
 <Zz4eTVyh73SQo60q@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zz4eTVyh73SQo60q@lizhi-Precision-Tower-5810>

On Wed, Nov 20, 2024 at 12:37:17PM -0500, Frank Li wrote:
> Maybe off topic, I think if support combine some segmement address to
> one bar should be wonderful, such as combine MSI ITS address and other
> register to BAR0. It is not worth to waste one bar, which just for
> doorbell.

I was thinking about this as well.

If we want a single BAR to redirect to two different physical memory areas,
then we can no longer use BAR Match Mode.

Sure, we could use two different iATUs and use Address Match Mode.
However, the problem is that the minimum size of an Address Translation
Region (CX_ATU_MIN_REGION_SIZE). E.g. on rk3588 CX_ATU_MIN_REGION_SIZE
is 64k...

So we would need to split the BAR in chunks of CX_ATU_MIN_REGION_SIZE.

If we look at e.g. the NVMe doorbells in BAR0, they are defined to
start at offset 0x1000 (4k).
See "Figure 4: PCI Express Specific Controller Property Definitions" in:
https://nvmexpress.org/wp-content/uploads/NVM-Express-PCI-Express-Transport-Specification-Revision-1.1-2024.08.05-Ratified.pdf

So, since that fixed offset is smaller than CX_ATU_MIN_REGION_SIZE,
we are out of luck... (at least for rk3588).

But.. perhaps the idea is still worth it?
For controllers that have CX_ATU_MIN_REGION_SIZE == 4k,
they could use one iATU for offset 0x-0xfff, and
another iATU for 0x1000-0x1fff.

(And of course, NVMe is just one specification out of many...)

I have no idea how CX_ATU_MIN_REGION_SIZE is set on NXP DWC PCIe
controllers.


Kind regards,
Niklas

