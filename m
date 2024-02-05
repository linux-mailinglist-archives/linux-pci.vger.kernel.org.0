Return-Path: <linux-pci+bounces-3110-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC4384A26A
	for <lists+linux-pci@lfdr.de>; Mon,  5 Feb 2024 19:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 249E8B24923
	for <lists+linux-pci@lfdr.de>; Mon,  5 Feb 2024 18:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682961E890;
	Mon,  5 Feb 2024 18:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g8GiVAHt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205551E88B;
	Mon,  5 Feb 2024 18:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707157852; cv=none; b=gLaNfbbPMXNUsLB2oIL0mBdKhHgqAE4aoUvVzLTbo+ZaWhsy0uABVuQqHBwnAkNILWtALWpGB0GvDKOuRwx5jvpDXIDiPg1l8vJ7HiMEfkm9U17P+gKj1iLNhNY2kdlv6f29Gu/2SIBsLK15zq+0tfZRxEG73Nfhp+oTnF2SJ58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707157852; c=relaxed/simple;
	bh=tQLjJ7izoNh38t86eYr7yDXLCYcWj85o+UbAqKSJqPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mNovr4oKzJu6rsXa8MyiX/uXzIIOjgBsMmtMrj+33se5G1fgixknRzjkqvdZf5gGqWs88iLyVlYp20fMtmOe+vEBaiItiMFgCfhVw+1nGTpe0F6oal0Kq3xXIJp2YOSvHenIVC58GDtA6SG1+6VJSNkTzr8qsvzMyOH4ZmHGX/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g8GiVAHt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24D41C433C7;
	Mon,  5 Feb 2024 18:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707157851;
	bh=tQLjJ7izoNh38t86eYr7yDXLCYcWj85o+UbAqKSJqPA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g8GiVAHtPR0y9nSHr7sXVb5tJVZCrlCzwyoyGORiC03yywrb5TQ57IoBiCBfvdelY
	 i7gU1NNv2XHN/i1rAS8tUG0ZWJw0AB2Osf0CuWMScDUZChM5vrJ9JeT7FHtQhX1ruI
	 5smnEkDAjCkaIU3yO1ARCl54UZci07ZBoo+5+BRG97Ux6zbxUN//Oycn2JAH9kgTH/
	 Hmo7ZRtLhK194ATstLvnA23V30su11nNSiRmgwV1pk/UUYFo36MDhKwGAoj9FUP3gd
	 kCzMCZV9U/tthvV2gli8XL3R8ZQ7Gk83MJY9pyZxSetHNVbNRDShYX+zQDV59HsICU
	 FPnKh3ryQRAYA==
Date: Mon, 5 Feb 2024 18:30:48 +0000
From: Rob Herring <robh@kernel.org>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Frank Li <Frank.Li@nxp.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, imx@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 5/6] dt-bindings: PCI: dwc: Add 'msg' register region
Message-ID: <20240205183048.GA3818249-robh@kernel.org>
References: <20240202-pme_msg-v3-0-ff2af57a02ad@nxp.com>
 <20240202-pme_msg-v3-5-ff2af57a02ad@nxp.com>
 <eg7wrjp5ebz43g37fvebr44nwkoh4rptbtyu76nalbmgbbnqke@4zugpgwesyqd>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eg7wrjp5ebz43g37fvebr44nwkoh4rptbtyu76nalbmgbbnqke@4zugpgwesyqd>

On Sat, Feb 03, 2024 at 01:44:31AM +0300, Serge Semin wrote:
> On Fri, Feb 02, 2024 at 10:11:27AM -0500, Frank Li wrote:
> > Add an outbound iATU-capable memory-region which will be used to send PCIe
> > message (such as PME_Turn_Off) to peripheral. So all platforms can use
> > common method to send out PME_Turn_Off message by using one outbound iATU.
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> > index 022055edbf9e6..25a5420a9ce1e 100644
> > --- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> > +++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> > @@ -101,6 +101,10 @@ properties:
> 
> >              Outbound iATU-capable memory-region which will be used to access
> >              the peripheral PCIe devices configuration space.
> >            const: config
> > +        - description:
> > +            Outbound iATU-capable memory-region which will be used to send
> > +            PCIe message (such as PME_Turn_Off) to peripheral.
> > +          const: msg
> 
> Note there is a good chance Rob won't like this change. AFAIR he
> already expressed a concern regarding having the "config" reg-name
> describing a memory space within the outbound iATU memory which is
> normally defined by the "ranges" property. Adding a new reg-entry with
> similar semantics I guess won't receive warm welcome.

I do think it is a bit questionable. Ideally, the driver could 
just configure this on its own. However, since we don't describe all of 
the CPU address space (that's input to the iATU) already, that's not 
going to be possible. I suppose we could fix that, but then config space 
would have to be handled differently too.

Rob

