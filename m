Return-Path: <linux-pci+bounces-33743-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 634A4B20B94
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 16:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B75171881B4D
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 14:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7721FE461;
	Mon, 11 Aug 2025 14:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ItHHJlfj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1132170A26;
	Mon, 11 Aug 2025 14:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754921813; cv=none; b=K/7Y3Ze33sAkSa4zrEvwJd6PzVxW+f57zbMYDJd8mWCP4xwJavsH5A/W7Ccq27yx3RIJbSTPwgyCebJYCqSttfFkWol5tT0SWzU9LQv89CCHrueZo4ONVp2t3+jdq3S4S8E/w1qB5AIY9AS01285+9+Hsod5V1fNWBICSYqzqks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754921813; c=relaxed/simple;
	bh=HyGKP4aY1hXadx5XsLIniKyUXkI3COPhu/nzmDSgxQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aubr/hivuiYCOgBcqj7DvjGXqTxDQh3o9XioQ/IyanotmwEnRVQjWTeqOZVkzAJkXSklhXM1VKFdayso1pZNGP9HKg8xWHF0b6ZkJQcxOX9woKxxrt2qyJtR2vIs9FsVQRUqEVk+OvK8yjPngfwy9ZcDKNkvwHP+dUx2Uthbx20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ItHHJlfj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 084AAC4CEED;
	Mon, 11 Aug 2025 14:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754921813;
	bh=HyGKP4aY1hXadx5XsLIniKyUXkI3COPhu/nzmDSgxQo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ItHHJlfjKvHxionfRyG/rHhVxx33kInqnSMz7Pu266fMWV7pwMOrJw623IQOzYD0T
	 r6IQZ4PiooHbd5mKsxqMg6gEXbdaizQDcjuNE2x2qegh0fMrHJlTUxvYMGOw4AR0bY
	 EarJjmL7hNlWCDui6o6GVfTz4ouz3+JsqXYo/Vv+vW24GsakcUBecdzPZ1DwSzO8Xf
	 2MmEPQX38ElYCtM13YPN7f36F9vRVwJXLXUOi8gNJ1HKvKvzK4HvwxnWta2bC3t6oc
	 f/8kjVUooYMpP2LQQdcgQl4WSCQ/Boi1SxUO3itf638Wd/fXKvS3Y4phcPWzk/ycDZ
	 Oum+v14h4NIhw==
Date: Mon, 11 Aug 2025 19:46:41 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Ray Jui <ray.jui@broadcom.com>, Scott Branden <scott.branden@broadcom.com>, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: Add missing "#address-cells" to
 interrupt controllers
Message-ID: <6hbyofiaop3e5yeo4trypwquwoseowwrqxo776jo3uknhf4rna@3lf3paulyvtr>
References: <20250801200728.3252036-2-robh@kernel.org>
 <175490917553.10504.5537940155167451079.b4-ty@kernel.org>
 <CAL_JsqL_jiOZcydPF6LXVKu6_z6Bp32g+wXWkNgrLocrg-xgrg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqL_jiOZcydPF6LXVKu6_z6Bp32g+wXWkNgrLocrg-xgrg@mail.gmail.com>

On Mon, Aug 11, 2025 at 08:07:31AM GMT, Rob Herring wrote:
> On Mon, Aug 11, 2025 at 5:46 AM Manivannan Sadhasivam
> <manivannan.sadhasivam@oss.qualcomm.com> wrote:
> >
> >
> > On Fri, 01 Aug 2025 15:07:27 -0500, Rob Herring (Arm) wrote:
> > > An interrupt-controller node which is the parent provider for
> > > "interrupt-map" needs an "#address-cells" property. This fixes
> > > "interrupt_map" warnings in new dtc.
> > >
> > >
> >
> > Applied, thanks!
> >
> > [1/1] dt-bindings: PCI: Add missing "#address-cells" to interrupt controllers
> >       commit: ddb81c5c911227f0c2ef4cc94a106ebfb3cb2d56
> 
> Please read the commit message.
> 
> I've already applied this to my tree.
> 

Sorry, didn't notice it. Dropped the patch from PCI tree now.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

