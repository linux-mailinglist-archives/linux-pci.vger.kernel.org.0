Return-Path: <linux-pci+bounces-6669-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3FB98B25BB
	for <lists+linux-pci@lfdr.de>; Thu, 25 Apr 2024 17:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE0DE1C20B13
	for <lists+linux-pci@lfdr.de>; Thu, 25 Apr 2024 15:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D8914BFB1;
	Thu, 25 Apr 2024 15:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A1dxq/Og"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050501CF8A;
	Thu, 25 Apr 2024 15:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714060485; cv=none; b=UjKrviqaqzlUbTjKJTh9/6HFCuCF7n/56b/PtOf6wjfuc06lhw/62hOuD/XS0rwq+/L550gOOm/Dre8wBpIfMYQalj3I/PcsU8HBYwNmv3XmcfETd8mFJQxGd80/9Ee0XOvTiYnZqN0241CM8IJFevsHVp3t1h7HSxxTt5IB3Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714060485; c=relaxed/simple;
	bh=Dn/pRh2oUukCj1ggIH8ve2cqjZLV2z01dMU5qi0dgxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AlyLCXTAEdRvkzCtWf2oDfjrSrtxJfxNgQZxoUwoTSakDX1Nu1wJEX//8iX1hzGGS3XmCX0c/mGHhKJ8UdsoU8tSWzh0biDiiMDNJT7rR2icAnFl3q3Pzhhfj+UUyi6cg4BqdjXG7KWsYWDViyW/4J+F0ok8lS7JXm1wnuh6V/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A1dxq/Og; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E7EFC113CC;
	Thu, 25 Apr 2024 15:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714060484;
	bh=Dn/pRh2oUukCj1ggIH8ve2cqjZLV2z01dMU5qi0dgxU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A1dxq/OgCC+6mzUVThmVD6yMrnhKwzacu/+ovRKNx6/GDPwp0T0LGvLjgNyXup2/8
	 vZWV2GpoJArP40L8RXGwDSgAfv5fiyd7iACo58m85wksuI8LxafwB1SCA4LjXZS7Rh
	 RTa4ZnELoNNL79hYqMsPstAokBKdSGCPaIeI4hZyA9K521DuvZfuxcmsGgaJxkW/3C
	 54kvsYhDmxy30qUjwY77Q1TxXbNbo41q3F7iy9PqbwTxihdpBHgc6h8g3Rtu7B8r5A
	 tk3ahS5J1tvQB6NRpW4lkwoy7UFKpv0ql5pMxQEU5dvFEq2/nBJzO3RWypqca/zhx5
	 Gi5Qj669RS+Cg==
Date: Thu, 25 Apr 2024 10:54:42 -0500
From: Rob Herring <robh@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Damien Le Moal <dlemoal@kernel.org>,
	Jon Lin <jon.lin@rock-chips.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Simon Xue <xxm@rock-chips.com>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 01/12] dt-bindings: PCI: snps,dw-pcie-ep: Add vendor
 specific reg-name
Message-ID: <20240425155442.GA2610968-robh@kernel.org>
References: <20240424-rockchip-pcie-ep-v1-v1-0-b1a02ddad650@kernel.org>
 <20240424-rockchip-pcie-ep-v1-v1-1-b1a02ddad650@kernel.org>
 <20240425154928.GA2600809-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425154928.GA2600809-robh@kernel.org>

On Thu, Apr 25, 2024 at 10:49:28AM -0500, Rob Herring wrote:
> On Wed, Apr 24, 2024 at 05:16:19PM +0200, Niklas Cassel wrote:
> > Considering that some drivers (e.g. pcie-dw-rockchip.c) already use the
> > reg-name "apb" for the device tree binding in Root Complex mode
> > (snps,dw-pcie.yaml), it doesn't make sense that those drivers should use a
> > different reg-name when running in Endpoint mode (snps,dw-pcie-ep.yaml).
> > 
> > Therefore, since "apb" is already defined in snps,dw-pcie.yaml, add it
> > also for snps,dw-pcie-ep.yaml.
> > 
> > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
> > index bbdb01d22848..00dec01f1f73 100644
> > --- a/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
> > +++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
> > @@ -100,7 +100,7 @@ properties:
> >              for new bindings.
> >            oneOf:
> >              - description: See native 'elbi/app' CSR region for details.
> > -              enum: [ link, appl ]
> > +              enum: [ apb, link, appl ]
> 
> This section is for existing bindings. IOW, don't use or add to them 
> for new users. New users should "See native 'elbi/app' CSR region".

Err, I guess this is an existing user for the most part.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

