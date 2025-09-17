Return-Path: <linux-pci+bounces-36329-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2077AB7D440
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 14:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EE11169DDD
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 08:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81DCA30CDB8;
	Wed, 17 Sep 2025 08:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XoBk9H9/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FF630C34F;
	Wed, 17 Sep 2025 08:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758098571; cv=none; b=A8++vMTTRBYYVU1b264/iT9Rszddfe95dK+lMu/NKemHhI9h1Kwtp7wh/RaHSm/RWg9XrytL5jaL+8KQrGeI1i3nzE6rA3XwewxsITmRVWk8yersVOHwXxPc0Ghf1JXe/dyJOnUtusXWIzOFq460ZgTufJNrzEbCQNLsZP5zFro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758098571; c=relaxed/simple;
	bh=CMm0HgNBKMoHaAJh86JjHiEwTFlQgqebNAVg0nJ9CEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jNA9asDb0uxEAwAadMckUGTnki6hk/9rbuJVQgSMfXGm6+ON4qUA4qnIEv3hj0wRpOz5Bp11sqowiv8xaQZ46w6t2ADAbVitsGoWfGNYtYiuAdx2Kcm0Gefv/LZv8D0+0QYBHlj9fNGufkrsqJDTKRVWQ961Hh7k82bSEW/bbj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XoBk9H9/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9EB6C4CEF5;
	Wed, 17 Sep 2025 08:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758098570;
	bh=CMm0HgNBKMoHaAJh86JjHiEwTFlQgqebNAVg0nJ9CEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XoBk9H9/fk3hEvvn+gAJu80NKRXPfW8GtIar0Vpe65NqcQI0fOFTf6+Ni4y4mQA6v
	 uvy1/nwUiDDy754G6J1W3BifeTN6slbPxx++cVkO2M1G2ZAhmhRmaEy5aBMlnviDj0
	 H5vOuebJLQVHpm6NBS9qLds5Lb+/OsKf0TcaOIGRvmxkeb55LAnq/PfCuz4tRCrNrw
	 02Wc1kIXqFgn7Domq1qtNXu/90UOdKtL8VeTojPXYQ15DopqoMceKwQqh8d9J2lRQN
	 b+Wy2Wj3gbqEiogu6BbIWJ0IRNug8dyHcCBfxchaxyrjagH9A0hCWX3A1SaP+9maaE
	 KjAQcfOIBWRBg==
Date: Wed, 17 Sep 2025 10:42:44 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: chester62515@gmail.com, mbrugger@suse.com,
	ghennadi.procopciuc@oss.nxp.com, s32@nxp.com, lpieralisi@kernel.org,
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, Ionut.Vicovan@nxp.com,
	larisa.grigore@nxp.com, Ghennadi.Procopciuc@nxp.com,
	ciprianmarian.costea@nxp.com, bogdan.hamciuc@nxp.com,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: pcie: Add the NXP PCIe controller
Message-ID: <aMp0hNnBUwTV5cbp@ryzen>
References: <20250912141436.2347852-1-vincent.guittot@linaro.org>
 <20250912141436.2347852-2-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912141436.2347852-2-vincent.guittot@linaro.org>

Hello Vincent,

Nice to see you sending some PCIe patches :)

Quite different from the scheduler and power management patches that you
usually work on :)

(snip)

> +  nxp,phy-mode:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description: Select PHY mode for PCIe controller
> +    enum:
> +      - crns  # Common Reference Clock, No Spread Spectrum
> +      - crss  # Common Reference Clock, Spread Spectrum
> +      - srns  # Separate reference Clock, No Spread Spectrum
> +      - sris  # Separate Reference Clock, Independent Spread Spectrum

This does not seem to be anything NXP specific, so I really think that this
should be some kind of generic property.


Note that I tried to add a similar property, but for the PCIe endpoint side
rather that the PCIe root complex side:
https://lore.kernel.org/linux-pci/20250425092012.95418-2-cassel@kernel.org/

However, due to shifting priorities, I haven't been able to follow up with
a new version/proposal.

My problem is not exactly the same, but even for a root complex, the PCI
specification allows the endpoint side to provide the common clock, which
means that the root complex would source the refclk from the PCIe slot,
so I would say that our problems are quite similar.

Rob Herring suggested to use the clock binding rather than an enum.
I can see his point of view, but personally I'm not convinced that his
suggestion of not having a clock specified means "source the refclock from
the slot" is better than a simple enum.

To me, it seems way clearer to explicitly specify the mode in device tree,
rather than the mode implictly being set if a "clk" phandle is there or not.
That approach seems way easier to misunderstand, as the user would need to
know that the clocking mode is inferred from a "clk" phandle being there or
not.


I also note that Rob Herring was not really a fan of having separate spread
spectrum options. Instead, it seems like he wanted a separate way to define
if SSC was used or not.

I have seen the following patch merged:
https://github.com/devicetree-org/dt-schema/pull/154
https://github.com/devicetree-org/dt-schema/commit/d7c9156d46bd287f21a5ed3303bea8a4d66d452a

So I'm not sure if that is the intended way they want SSC to be defined or
not.


I apologize for bringing up my own problem in this discussion, but at least
it is clear to me that we cannot continue with each PCIe driver adding their
own vendor specific properties (with completely different names) for this.
Some kind of generic solution is needed, at least for new drivers.


Kind regards,
Niklas

