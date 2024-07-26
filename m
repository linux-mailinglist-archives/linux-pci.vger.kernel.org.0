Return-Path: <linux-pci+bounces-10832-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1DE93D0E9
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jul 2024 12:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B43831C20F22
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jul 2024 10:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94CA149C62;
	Fri, 26 Jul 2024 10:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="d+8QF/5T"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCBC1C286;
	Fri, 26 Jul 2024 10:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721988952; cv=none; b=r2lLovt7iaUf43Q6ENoDFGXiHrV3R3xpUnFPbIKER5ph3z9i4GhNBx/cORZ4jJKp2NiTPvMdjKN+ArDFWDrbcKppgEcZvBqgWKl96ieJSlWYRlonzd2AEVC5gnAj8dZEr6yWwI3cOHGRr7RAQLuXzPCj8HtDl7AZ6Wh4szcAlDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721988952; c=relaxed/simple;
	bh=GsrwJej6TWCTSRQ+vLfnhXQEv6mHn1d6GGyajkUrraA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OH90zIbcLGqXHTuP7aXDflGNlj3Uai3f63+BF1wkHPyXaPZetR7tLHlAxdYqBHkUsEQpc2vzqpfr2LvvXeAr1No95BjTqSiTa/h9uPVNLMf+5BzBiemQXUfA0I49oQAwfA0Fz9UCoIjUiNm5uvt5SYynsAX4NQXCe7hSYtwqi68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=d+8QF/5T; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46QAFIPC128435;
	Fri, 26 Jul 2024 05:15:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1721988918;
	bh=7+5UTq5JTc/Qq3k+J69YHkKoUs00J/g0Hh7qYT4IjYM=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=d+8QF/5T8zvrUDvo3KMY48lCpWRXwO2TVw9XXDHOZn8PG6hv7SLaT+J7G31wmJHgF
	 mCBxDJZn1ZMfDk87oQY1XVMv5Oqvbutc5gFbUrKW1Js6rdlDoxXAb5xahZMR5wBTUI
	 YyWbp3B6JIz9MMzcZfzpMgO53a4keXdJXI81sygs=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46QAFIxj116069
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 26 Jul 2024 05:15:18 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 26
 Jul 2024 05:15:18 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 26 Jul 2024 05:15:18 -0500
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.81])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46QAFHfT059409;
	Fri, 26 Jul 2024 05:15:17 -0500
Date: Fri, 26 Jul 2024 15:45:16 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <lee@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <lpieralisi@kernel.org>, <kw@linux.com>, <bhelgaas@google.com>,
        <vigneshr@ti.com>, <kishon@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>
Subject: Re: [PATCH 3/3] PCI: j721e: Add support for enabling ACSPCIE PAD IO
 Buffer output
Message-ID: <cacb88b1-cab6-4e8b-850a-0477d41f6e80@ti.com>
References: <20240715120936.1150314-4-s-vadapalli@ti.com>
 <20240725211841.GA859405@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240725211841.GA859405@bhelgaas>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Thu, Jul 25, 2024 at 04:18:41PM -0500, Bjorn Helgaas wrote:

Hello Bjorn,

> On Mon, Jul 15, 2024 at 05:39:36PM +0530, Siddharth Vadapalli wrote:
> > The ACSPCIE module is capable of driving the reference clock required by
> > the PCIe Endpoint device. It is an alternative to on-board and external
> > reference clock generators. Enabling the output from the ACSPCIE module's
> > PAD IO Buffers requires clearing the "PAD IO disable" bits of the
> > ACSPCIE_PROXY_CTRL register in the CTRL_MMR register space.
> 
> And I guess this patch actually *does* enable the ACSPCIE PAD IO
> Buffer output?
> 
> This commit log tells me what is *required* to enable the output, but
> it doesn't actually say whether the patch *does* enable the output.
> 
> Similarly, if this patch enables ACSPCIE PAD IO Buffer output, I would
> make the subject be:
> 
>   PCI: j721e: Enable ACSPCIE Refclk output when DT property is present

I will update the commit message and the $subject to clearly indicate
that the patch enables the reference clock output from the ACSPCIE module.

> 
> > Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > ---
> >  drivers/pci/controller/cadence/pci-j721e.c | 33 ++++++++++++++++++++++
> >  1 file changed, 33 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
> > index 85718246016b..2fa0eff68a8a 100644
> > --- a/drivers/pci/controller/cadence/pci-j721e.c
> > +++ b/drivers/pci/controller/cadence/pci-j721e.c

[...]

> > +
> > +	ret = of_parse_phandle_with_fixed_args(node, "ti,syscon-acspcie-proxy-ctrl",
> > +					       1, 0, &args);
> > +	if (!ret) {
> > +		/* PAD Enable Bits have to be cleared to in order to enable output */
> 
> Most of this file fits in 80 columns (printf strings are an exception
> so they're easier to find with grep).  It'd be nice if your new code
> and comments fit in 80 columns as well.

I will wrap the lines to the 80 character limit.

> 
> An easy fix for the comment would be:
> 
>   /* Clear PAD Enable bits to enable output */
> 
> Although it sounds non-sensical to *clear* enable bits to enable
> something, and the commit log talks about clearing PAD IO *disable*
> bits, so maybe you meant this instead?
> 
>   /* Clear PAD IO disable bits to enable output */

Thank you for the suggestion. This is much better and I will update the
comment.

> 
> If the logical operation here is to enable driving Refclk, I think the
> function name and error messages might be more informative if they
> mentioned "refclk" instead of "PAD".

While the Hardware terminology is "PAD", looking at it again, I agree
that using "refclk" will be a better choice for describing the objective
of the function, as well as the outcome in case of a failure.

> 
> > +		val = ~(args.args[0]);
> > +		ret = regmap_update_bits(syscon, 0, mask, val);
> > +		if (ret)
> > +			dev_err(dev, "Enabling ACSPCIE PAD output failed: %d\n", ret);
> > +	} else {
> > +		dev_err(dev, "ti,syscon-acspcie-proxy-ctrl has invalid parameters\n");
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> >  static int j721e_pcie_ctrl_init(struct j721e_pcie *pcie)
> >  {
> >  	struct device *dev = pcie->cdns_pcie->dev;
> > @@ -259,6 +284,14 @@ static int j721e_pcie_ctrl_init(struct j721e_pcie *pcie)
> >  		return ret;
> >  	}
> >  
> > +	/* Enable ACSPCIe PAD IO Buffers if the optional property exists */
> 
> Is the canonical name "ACSPCIE" or "ACSPCIe"?  You used "ACSPCIE"
> above?

It is "ACSPCIE" and I have mentioned it that way consistently at all
places including the dt-bindings patches but have accidentally written
"ACSPCIe" above. I will fix this.

Thank you for reviewing this patch.

Regards,
Siddharth.

