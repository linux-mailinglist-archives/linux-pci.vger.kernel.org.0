Return-Path: <linux-pci+bounces-14856-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3519A3F2A
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2024 15:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F8A2284458
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2024 13:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BFC618C34C;
	Fri, 18 Oct 2024 13:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UbfN91Th"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD54E1CD2B;
	Fri, 18 Oct 2024 13:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729256967; cv=none; b=QYFAPHSRqGhoz5D5c+9vNblYvFB6CN2Lx0s68xX9vPlmS11sYomzID6I83I31JNw5Ar78T8hvmH/I3WXxBeOtA+6ucddUViC+rT9PKc/lvr/r45X3qUmh1RTl5zREljw7vthzleKTdv8TiwsvdVpQ2MP4xp8/Xkcw0I+US/i34g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729256967; c=relaxed/simple;
	bh=f8rBGROSLgXNregcpfB3wCWzvZVSp7htP3J+i4I0wZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=do+s9izG6qTLQB3pwI2uaWAX38k3gx1B7uhkssS6gD/xb0uEXgh2ejsD3+pqgj+0gGLKksEvgZzVTex8OUMy1oGyw0N+1LHQ7ndZ8wliSpLXsLxvKWgbGRoxPBduyKX49LmnITGo+wxCT2CMHEMZ+vJgKsodm11Cm2+Nw6SQGR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UbfN91Th; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3660BC4CEC3;
	Fri, 18 Oct 2024 13:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729256967;
	bh=f8rBGROSLgXNregcpfB3wCWzvZVSp7htP3J+i4I0wZ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UbfN91ThmSxeT6kDWXc7oCnCMxV2pscXTk2f8+oKp1TAi26EUjBFab2KzDahG/4BD
	 7BLhb5aLrdyODFMMRNB35teNrMaUuggRt5U/SEP1GYzeRVvlvAfjp8pOEGIIwhL8Hz
	 Lz1RitvzaSWUOX2JO5x5DgB8wy2WXoTjbPZFDvvwbXOrmWpWfVKrbhoq5qpb/bFD0V
	 t79vAUejTP6T005PXbzdAXhvKY4KscgDlsJekkgpHPAm/te4XFLBRwhSwmepRXZl89
	 H3WfWMQhdcvjpFzOncHwJY/7gdcvP4DQjqvzWVWOID1nWXzT2VxyyluY2CGrQnKP1Y
	 tpUpmyZvbrUpg==
Date: Fri, 18 Oct 2024 08:09:26 -0500
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Wei Fang <wei.fang@nxp.com>, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, vladimir.oltean@nxp.com,
	claudiu.manoil@nxp.com, xiaoning.wang@nxp.com,
	christophe.leroy@csgroup.eu, linux@armlinux.org.uk,
	bhelgaas@google.com, horms@kernel.org, imx@lists.linux.dev,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 net-next 02/13] dt-bindings: net: add i.MX95 ENETC
 support
Message-ID: <20241018130926.GA45536-robh@kernel.org>
References: <20241017074637.1265584-1-wei.fang@nxp.com>
 <20241017074637.1265584-3-wei.fang@nxp.com>
 <ZxE56eMyN791RsgK@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxE56eMyN791RsgK@lizhi-Precision-Tower-5810>

On Thu, Oct 17, 2024 at 12:23:05PM -0400, Frank Li wrote:
> On Thu, Oct 17, 2024 at 03:46:26PM +0800, Wei Fang wrote:
> > The ENETC of i.MX95 has been upgraded to revision 4.1, and the vendor
> > ID and device ID have also changed, so add the new compatible strings
> > for i.MX95 ENETC. In addition, i.MX95 supports configuration of RGMII
> > or RMII reference clock.
> >
> > Signed-off-by: Wei Fang <wei.fang@nxp.com>
> > ---
> > v2: Remove "nxp,imx95-enetc" compatible string.
> > v3:
> > 1. Add restriction to "clcoks" and "clock-names" properties and rename
> > the clock, also remove the items from these two properties.
> > 2. Remove unnecessary items for "pci1131,e101" compatible string.
> > ---
> >  .../devicetree/bindings/net/fsl,enetc.yaml    | 22 ++++++++++++++++---
> >  1 file changed, 19 insertions(+), 3 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/net/fsl,enetc.yaml b/Documentation/devicetree/bindings/net/fsl,enetc.yaml
> > index e152c93998fe..e418c3e6e6b1 100644
> > --- a/Documentation/devicetree/bindings/net/fsl,enetc.yaml
> > +++ b/Documentation/devicetree/bindings/net/fsl,enetc.yaml
> > @@ -20,10 +20,13 @@ maintainers:
> >
> >  properties:
> >    compatible:
> > -    items:
> > +    oneOf:
> > +      - items:
> > +          - enum:
> > +              - pci1957,e100
> > +          - const: fsl,enetc
> >        - enum:
> > -          - pci1957,e100
> > -      - const: fsl,enetc
> > +          - pci1131,e101
> >
> >    reg:
> >      maxItems: 1
> > @@ -40,6 +43,19 @@ required:
> >  allOf:
> >    - $ref: /schemas/pci/pci-device.yaml
> >    - $ref: ethernet-controller.yaml
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - pci1131,e101
> > +    then:
> > +      properties:
> > +        clocks:
> > +          maxItems: 1
> > +          description: MAC transmit/receiver reference clock
> > +        clock-names:
> > +          const: ref
> 
> Did you run CHECK_DTBS for your dts file? clocks\clock-names should be
> under top 'properties" firstly. Then use 'if' restrict it. But I am not
> sure for that. only dt_binding_check is not enough because your example
> have not use clocks and clok-names.

That's a manual check, but yes. Define all properties at top level.

Rob

