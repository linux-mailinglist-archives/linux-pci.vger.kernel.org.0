Return-Path: <linux-pci+bounces-29441-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F9EAD55D0
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 14:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C88701E0DA2
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 12:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12988280CEE;
	Wed, 11 Jun 2025 12:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ajM9eIgy"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DE7253F08;
	Wed, 11 Jun 2025 12:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749645632; cv=none; b=ty+IMirH7+HW0md1l8BbkN2OJXj2dAev5+rflR4m5Fy+VNd0K2YDqqGA4NvjxtkECYDU3OO+XoJN6Sbw6svhxPVzMfNPbALoh54jsF1QPwFgqvQFr+U7KjtleJjs5fxz8isc/kYLcOasfj/KIAjDhsACVK7OjuxOGO29Oc3zQH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749645632; c=relaxed/simple;
	bh=cCmNKZDymkD/C3UGiLtfl5Au5qdLVVJOMBlMf9drRPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Atj4+1zaPNgky80kjwYX2lvT1w2C1Q2j5DTzEmVPdImLMftslSTNnjGFBRmtGtFqGzZlHsjbBSvy7aMXTR6rLdtk9srIa54JhyHoradgZP3XvqUytlBWrzq0prIcE4MkliTfedstCmb+j475Bdeg7JsX1Kv0IoG3nrJbq1he6h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ajM9eIgy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD365C4CEEE;
	Wed, 11 Jun 2025 12:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749645631;
	bh=cCmNKZDymkD/C3UGiLtfl5Au5qdLVVJOMBlMf9drRPw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ajM9eIgy9gtKElLxi/CU+7xzEIPinBlqLXt1WZw0ihjDlX5YbwGA5+4mhJIvcAPm6
	 tqYxs85StPCyWRuKwzgT94g0nfoqGpOi/nCzeh/MFBq/HBYBTGfC1IUXG58MPzp2yj
	 oQ7yUl7lcSWHdcjNLpEJOQ4+M0QcjrpaJ4oXPX8L8ZYZC/xo4Mk+B9iLw2LJO2Xc+h
	 Ov/XHlxQL6ThgsBPfft1WBLwgoKwc2BMFDAp25acKgxzbNYvz2LoBPsQTwhqLU3nay
	 s7bRFQ0RWG9U9MqBNuwZD4jOPXlX6U61VQMtS7jNQ+UC1fmzbhI89IAYPIskoHfa7C
	 7O4o1Ltp3GnUw==
Date: Wed, 11 Jun 2025 18:10:22 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: devicetree@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Bjorn Helgaas <bhelgaas@google.com>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Rob Herring <robh@kernel.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] schemas: pci: bridge: Document clocks
Message-ID: <6guvn6zrhsx2qsaf6w7lxkbcbdi3asqrv36vbgeofqpxe5dkfg@7ivdywaz6c6i>
References: <20250607194353.79124-1-marek.vasut+renesas@mailbox.org>
 <advhonmqnxm4s6r3cl7ll5y3jfc566fcjvetvlzvy7bztzetev@t75xmo5fktde>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <advhonmqnxm4s6r3cl7ll5y3jfc566fcjvetvlzvy7bztzetev@t75xmo5fktde>

On Wed, Jun 11, 2025 at 06:09:27PM +0530, Manivannan Sadhasivam wrote:
> On Sat, Jun 07, 2025 at 09:43:24PM +0200, Marek Vasut wrote:
> > The PCIe slot may have clocks which are explicitly controlled
> > by the OS, describe the clocks property.
> 
> The slot can only have 'REFCLK' as per the spec, not any other random clocks.
> 
> > 
> > Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> 
> With that fixed,
> 
> Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Sorry. Wrong tag. Please take this one:

Acked-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> 
> - Mani
> 
> > ---
> > Related to https://lore.kernel.org/all/CAMuHMdUFHKHKfymqa6jwfNnxZTAuH3kbj5WL+-zN=TR6XGd0eA@mail.gmail.com/
> > ---
> > Cc: Bartosz Golaszewski <brgl@bgdev.pl>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Conor Dooley <conor+dt@kernel.org>
> > Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> > Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> > Cc: Magnus Damm <magnus.damm@gmail.com>
> > Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Cc: Rob Herring <robh@kernel.org>
> > Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > Cc: devicetree@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: linux-pci@vger.kernel.org
> > Cc: linux-renesas-soc@vger.kernel.org
> > ---
> >  dtschema/schemas/pci/pci-bus-common.yaml | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/dtschema/schemas/pci/pci-bus-common.yaml b/dtschema/schemas/pci/pci-bus-common.yaml
> > index ca97a00..3c512cf 100644
> > --- a/dtschema/schemas/pci/pci-bus-common.yaml
> > +++ b/dtschema/schemas/pci/pci-bus-common.yaml
> > @@ -82,6 +82,8 @@ properties:
> >      items:
> >        maximum: 255
> >  
> > +  clocks: true
> > +
> >    external-facing:
> >      description:
> >        When present, the port is externally facing. All bridges and endpoints
> > -- 
> > 2.47.2
> > 
> > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்

