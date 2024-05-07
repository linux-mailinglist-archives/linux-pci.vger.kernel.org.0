Return-Path: <linux-pci+bounces-7208-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA7A8BF346
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 02:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25D44B26D36
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 00:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE26132C17;
	Tue,  7 May 2024 23:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GPtnZcDX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA987EEE7;
	Tue,  7 May 2024 23:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715126132; cv=none; b=Sid2ipUstujhTdRC2C35Jbi04X6AXG6dYlN18+CEvUrwgiaa7f5aMT2Nc55A+Fu656t0qOvHBzfQueDY98jjKTAZjBLSZ199GCdbEan7vFNXfXlk3aUPhgpLQ+5vMV9tKi5FC/80M7/gG4zM9aa+XR6udjvhKaH6ioY8ozjSgz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715126132; c=relaxed/simple;
	bh=/7OZIyJaExPNEEfR8A1MS43PgmAU1yuWmNyB8jGptiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tVhwWSHTpgq4vN+RFGHZP2/zPBXSdEdRE1GG2+iS6vg8upHFYuEWEgVQup8z7dImTYpoxG1Uhq0HZojtlSubcJhKPMp7GliSDu7Xabq58c7rSiSUNdCEhm9Rtkc+m84GBD0NYkdLbTrOcoXYJGVBTEYzPWe5I2gwl6QT7CW4epU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GPtnZcDX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A943CC2BBFC;
	Tue,  7 May 2024 23:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715126131;
	bh=/7OZIyJaExPNEEfR8A1MS43PgmAU1yuWmNyB8jGptiU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GPtnZcDXAURyWK0GXZSG46Ok0NRJy8E+/MnuG/PpWMeTNZsTDYORmAlLkgnnFD0Mf
	 A/hrNWQcq7gDbrb4dehVY15MXfyY/SW8vSul/OJQI/xEgbazDspdoFKDRyE7uWTIar
	 qmOoDPvP0xgvtD+ObFVgctjZ1QbYhrczXYnwwk4MjiJiXSBZwwfRK0hNKQu2Q1YKqb
	 0dlVkx1i8NsnlvCg5uOyAYlBFKkyLg4NGRzkPzZFhgcjOnEDJLKYvo6d9Op63k34uK
	 3Fktw1iizS80J+8ILaGKtcjBuE+VgcJRLVBb85DT1MBmvr4PEqZquIAZ+KeNR/Ry7p
	 Dm2/tVrRH+RYg==
Date: Wed, 8 May 2024 01:55:24 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Damien Le Moal <dlemoal@kernel.org>,
	Jon Lin <jon.lin@rock-chips.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Simon Xue <xxm@rock-chips.com>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 08/14] PCI: dw-rockchip: Add rockchip_pcie_ltssm()
 helper
Message-ID: <Zjq_bEoFe-xR_hww@ryzen.lan>
References: <20240430-rockchip-pcie-ep-v1-v2-0-a0f5ee2a77b6@kernel.org>
 <20240430-rockchip-pcie-ep-v1-v2-8-a0f5ee2a77b6@kernel.org>
 <20240504171346.GE4315@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240504171346.GE4315@thinkpad>

Hello Mani,

On Sat, May 04, 2024 at 10:43:46PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Apr 30, 2024 at 02:01:05PM +0200, Niklas Cassel wrote:
> > Add a rockchip_pcie_ltssm() helper function that reads the LTSSM status.
> > This helper will be used in additional places in follow-up patches.
> > 
> 
> Please don't use 'patches' in commit logs. Once the patches get merged, they
> become commits.

Sure, will fix in V2.


> 
> > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> > ---
> >  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > index 1993c430b90c..4023fd86176f 100644
> > --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > @@ -143,6 +143,11 @@ static int rockchip_pcie_init_irq_domain(struct rockchip_pcie *rockchip)
> >  	return 0;
> >  }
> >  
> > +static inline u32 rockchip_pcie_ltssm(struct rockchip_pcie *rockchip)
> 
> rockchip_pcie_get_ltssm()?

Sure, will fix in V2.


> 
> Also, no inline in C files, please. Compiler will inline functions with or
> without the keyword anyway.

Sure, will fix in V2.


Kind regards,
Niklas

