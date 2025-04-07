Return-Path: <linux-pci+bounces-25362-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB6FA7D603
	for <lists+linux-pci@lfdr.de>; Mon,  7 Apr 2025 09:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE3D7165797
	for <lists+linux-pci@lfdr.de>; Mon,  7 Apr 2025 07:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E5722ACD3;
	Mon,  7 Apr 2025 07:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="lq3Af87W"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7194C227B95;
	Mon,  7 Apr 2025 07:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744010621; cv=none; b=SCeCJUazsTvBh0MlptzxYNBsLwOrLk+8xytb5YF07JT/jUSMgSbF0JNE1rRFx6KZTIJfivZNx5EUNFN7EVwkMapypScCSib8VSnD2EON8iHwV/WS69ahayztdmTY04NYkqJKbS/p3V2d+1Jsf01g+NHfkZQaww3y6kBprwkhjEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744010621; c=relaxed/simple;
	bh=B75HXc0thdOwdIF/EGzdkMXXWZJN8Y18zVZgbubkOnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=thaT58J90RUHXJ5nUH1bAiHxxo766/WM/+jPB7F/uZf1ES++kKzqOlMAEKePMYGFsnU5AYlIFYAMhFDjPUHvcI9y8YEJDptIa6NcCWC3I1WEhpcI0jKvFHcDOD16BUb+ZR008qKoy4w1h/Fpjkdg1VnYg5Xw7VlzvCtmVQ+1W0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=lq3Af87W; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 6320B1F91A;
	Mon,  7 Apr 2025 09:23:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1744010608;
	bh=zX3SXc9F5y9akHBalpx7JJ69F5zZLipJTmxPwy4j2uA=;
	h=Received:From:To:Subject;
	b=lq3Af87W53fGWbfZKcvotScickDanNLw7phSBvWfVDpC6qnYeKFfSeyzAwajL5VSK
	 P2EZYKKQ+aUOzSMnx3ZS7cwPbLj3yupC+QdfPUbd/vOYUsliKLl3l7K/HSFpDYb0HM
	 Zmblnh85Ule4w24dU3wpwgQPOlBnxErplu970LypcB3adKqJaPgJ7kkGW3tSA8FHWo
	 DPWkayO7avEgjDY30vN5JT7Yf69yC8eHcindRRgMOjfZNM8yr6HxtBR+HEkLLmU6u9
	 Z3o/oqtlKT45GG+pLjLqmyiNY0ozlycr9FBk7QaB7TwTxFD2UqXoErLlQHSW5PV/dX
	 vBB6ZXYAVRxXw==
Received: by gaggiata.pivistrello.it (Postfix, from userid 1000)
	id 1F94E7F8D5; Mon,  7 Apr 2025 09:23:28 +0200 (CEST)
Date: Mon, 7 Apr 2025 09:23:28 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Sherry Sun <sherry.sun@nxp.com>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Hongxing Zhu <hongxing.zhu@nxp.com>,
	"l.stach@pengutronix.de" <l.stach@pengutronix.de>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>,
	dl-linux-imx <linux-imx@nxp.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 2/4] dt-bindings: imx6q-pcie: Add wake-gpios property
Message-ID: <Z_N9cO64FZwONcK9@gaggiata.pivistrello.it>
References: <20231213092850.1706042-1-sherry.sun@nxp.com>
 <20231213092850.1706042-3-sherry.sun@nxp.com>
 <20250404094130.GA35433@francesco-nb>
 <DB9PR04MB8429588E7CF00BDC9CDA863F92AA2@DB9PR04MB8429.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB9PR04MB8429588E7CF00BDC9CDA863F92AA2@DB9PR04MB8429.eurprd04.prod.outlook.com>

On Mon, Apr 07, 2025 at 07:18:32AM +0000, Sherry Sun wrote:
> 
> 
> > -----Original Message-----
> > From: Francesco Dolcini <francesco@dolcini.it>
> > Sent: Friday, April 4, 2025 5:42 PM
> > To: Sherry Sun <sherry.sun@nxp.com>
> > Cc: Hongxing Zhu <hongxing.zhu@nxp.com>; l.stach@pengutronix.de;
> > lpieralisi@kernel.org; kw@linux.com; robh@kernel.org;
> > bhelgaas@google.com; krzysztof.kozlowski+dt@linaro.org;
> > conor+dt@kernel.org; shawnguo@kernel.org; s.hauer@pengutronix.de;
> > kernel@pengutronix.de; festevam@gmail.com; dl-linux-imx <linux-
> > imx@nxp.com>; linux-pci@vger.kernel.org; linux-arm-
> > kernel@lists.infradead.org; devicetree@vger.kernel.org; linux-
> > kernel@vger.kernel.org
> > Subject: Re: [PATCH V2 2/4] dt-bindings: imx6q-pcie: Add wake-gpios property
> > 
> > Hello
> > 
> > On Wed, Dec 13, 2023 at 05:28:48PM +0800, Sherry Sun wrote:
> > > Add wake-gpios property that can be used to wakeup the host processor.
> > >
> > > Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> > > Reviewed-by: Richard Zhu <hongxing.zhu@nxp.com>
> > > ---
> > >  Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> > > b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> > > index 81bbb8728f0f..fba757d937e1 100644
> > > --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> > > +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> > > @@ -72,6 +72,12 @@ properties:
> > >        L=operation state) (optional required).
> > >      type: boolean
> > >
> > > +  wake-gpios:
> > > +    description: If present this property specifies WAKE# sideband signaling
> > > +      to implement wakeup functionality. This is an input GPIO pin for the
> > Root
> > > +      Port mode here. Host drivers will wakeup the host using the IRQ
> > > +      corresponding to the passed GPIO.
> > > +
> > 
> > From what I know it is possible to share the same WAKE# signal for multiple
> > root ports. Is this going to work fine with this binding? Same question on the
> > driver.
> > 
> > We do have design exactly like that, so it's not a theoretical question.
> > 
> The current design doesn't support such case, maybe some changes in the
> driver could achieve that (mark the wake-gpio as GPIOD_FLAGS_BIT_NONEXCLUSIVE
> and the interrupt as IRQF_SHARED, etc.).

Can you consider implementing this?

> But usually each RC has its own WAKE# pin assigned. We have not come across a
> case where multiple RC share the same WAKE# pin.

We do have such design, with an NXP iMX95 SoC, available now.

Francesco


