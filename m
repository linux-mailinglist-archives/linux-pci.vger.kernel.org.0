Return-Path: <linux-pci+bounces-14110-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91AAC9976F6
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 22:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E9F2289494
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 20:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF241E25ED;
	Wed,  9 Oct 2024 20:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQCxYEML"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EC91DFDAB;
	Wed,  9 Oct 2024 20:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728507186; cv=none; b=REz/pfsJTAxjNoWJqoHMWoKEfPIrtisGZGLfKOwoT3VANMwbfYBe1a+iB3pBqUw2qVdwbW1sNsswLHFdwsWwKkQK+gDKKTOdBtn3JMK+rU/pOxizH4Xo1dWsi9mlC4XfygeYDzAvqw9NKqqv7gP9zEcLMEsDyEP8yFtl4E+Sj1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728507186; c=relaxed/simple;
	bh=z3NFl3JU4cXkyowzq5opNhTPBloo/S0tofmm6les7ds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QEvKIkvIZOBvtmvdjX+T1nK9PLm5dofgZkTY1ygu0hmFVgD7+pVDptHGwIC4/jnLDe+jOE4XCM+OAQWoHAHKWMnAVOw0jcNAkeLEg+Um3ghXc9nPe89uBHiiYhsuxEUGbZtEDeFXaE2JKi+1/ZuWAABSeSz5l5EftHffoHSsAWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DQCxYEML; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90E87C4CEC3;
	Wed,  9 Oct 2024 20:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728507185;
	bh=z3NFl3JU4cXkyowzq5opNhTPBloo/S0tofmm6les7ds=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DQCxYEMLzlgshGROEYfKV/8alUi36hXQwa0orX8JGwReVH5Ym1TNjOLdR8knjfiH3
	 uHBKqP1xLZD6eN0aZGe5c2Yf6+1QsRBJ250iZdpG1IgO/a/21inaa41shI03t2U+wf
	 8aCUK4DKa2aIdjK7IO8qVDttEaI7fE/7m/rAfuYEVCE5wjfMZTAoj3IvDrnyQgsUot
	 Iycb4fgKZREQU6SO2UdnJ6iwgV9bcHEX02p+PU5PL27oMIZzXib/W1eHDexxpkEWrN
	 2f6fFs/vnpEWsItbdy4xZvrrkpDZzZm0ydj9LGMKKh55+ZH3zs3T4f4cnlf9dhNnHV
	 24KMvDoZS47Yw==
Date: Wed, 9 Oct 2024 15:53:04 -0500
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Wei Fang <wei.fang@nxp.com>, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, vladimir.oltean@nxp.com,
	claudiu.manoil@nxp.com, xiaoning.wang@nxp.com,
	christophe.leroy@csgroup.eu, linux@armlinux.org.uk,
	bhelgaas@google.com, imx@lists.linux.dev, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH net-next 02/11] dt-bindings: net: add i.MX95 ENETC support
Message-ID: <20241009205304.GA615678-robh@kernel.org>
References: <20241009095116.147412-1-wei.fang@nxp.com>
 <20241009095116.147412-3-wei.fang@nxp.com>
 <ZwavhfKthzaOR2R9@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwavhfKthzaOR2R9@lizhi-Precision-Tower-5810>

On Wed, Oct 09, 2024 at 12:29:57PM -0400, Frank Li wrote:
> On Wed, Oct 09, 2024 at 05:51:07PM +0800, Wei Fang wrote:
> > The ENETC of i.MX95 has been upgraded to revision 4.1, and the vendor
> > ID and device ID have also changed, so add the new compatible strings
> > for i.MX95 ENETC. In addition, i.MX95 supports configuration of RGMII
> > or RMII reference clock.
> >
> > Signed-off-by: Wei Fang <wei.fang@nxp.com>
> > ---
> >  .../devicetree/bindings/net/fsl,enetc.yaml    | 23 +++++++++++++++----
> >  1 file changed, 19 insertions(+), 4 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/net/fsl,enetc.yaml b/Documentation/devicetree/bindings/net/fsl,enetc.yaml
> > index e152c93998fe..1a6685bb7230 100644
> > --- a/Documentation/devicetree/bindings/net/fsl,enetc.yaml
> > +++ b/Documentation/devicetree/bindings/net/fsl,enetc.yaml
> > @@ -20,14 +20,29 @@ maintainers:
> >
> >  properties:
> >    compatible:
> > -    items:
> > -      - enum:
> > -          - pci1957,e100
> > -      - const: fsl,enetc
> > +    oneOf:
> > +      - items:
> > +          - enum:
> > +              - pci1957,e100
> > +          - const: fsl,enetc
> > +      - items:
> > +          - const: pci1131,e101
> > +      - items:
> > +          - enum:
> > +              - nxp,imx95-enetc
> > +          - const: pci1131,e101
> 
>     oneOf:
>       - items:
>           - enum:
>               - pci1957,e100
>           - const: fsl,enetc
>       - items:
>           - const: pci1131,e101
>           - enum:
>               - nxp,imx95-enetc

const.

Or maybe just drop it. Hopefully the PCI ID changes with each chip. If 
not, we kind of have the compatibles backwards.

>           minItems: 1

Then why have the fallback?

