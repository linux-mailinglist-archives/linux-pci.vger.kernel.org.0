Return-Path: <linux-pci+bounces-12403-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D719639E2
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2024 07:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADED51C2163C
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2024 05:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD8113C81B;
	Thu, 29 Aug 2024 05:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BRMcqT+G"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650B650A63;
	Thu, 29 Aug 2024 05:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724909477; cv=none; b=u8l88B8CjdYpZx0hp5zNWzgOSY/Ou1sKkLdJh4VnN8KDvOR1+fIFFkUi5AvR8RUI6RfRpoU7QnSr5Wf8xIuEcKpuOzHq3Cz3eU+T+QrrgDfHS4FC7SpRe38/IN4flqRTRecRFF8SWmY9VFzPWF40uUBKqkEN9WNQOfEsmsot4lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724909477; c=relaxed/simple;
	bh=tU53d3Zz3bM/dhVBI3QGvA0eOuMFk1tkdx0X0vtd28g=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VH7H/O/albsNwJ/YoN44oK1w6ZX8KmevtvQqH8aGn7uHp6QnEuFbzpuR1hqYHwYpBreNXjKzQe4ak480rQ29Vgazpe0AdAEkrIIehFo7mSdsOrGGTb+F1FDMFiaamGkmT3Byc7+zFZYn2AT1mNhj+CzNRaj8e43rfr7zmBaS1sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=BRMcqT+G; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47T5V2Ed098558;
	Thu, 29 Aug 2024 00:31:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724909462;
	bh=fo2xYcjr2pHkeY4HV+MN41M6scsudZXeANUulYj2JVg=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=BRMcqT+GnwHgbIFpYZdyLkNMMxJeDvHlX6I6lrr5CXpXA19K9Zh+1sfRr6qLaGDf+
	 WFuUhzdaIZ2jD0b8AspWWOoYCd2qOQsmeD16OVln//K2ljx1Xuy81jygaQx9tp8ESs
	 Rlwg3ima5BGFnyw+Dn60bEWoX5HyDTd0KHZqAMJ8=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47T5V2xm019752
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 29 Aug 2024 00:31:02 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 29
 Aug 2024 00:31:01 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 29 Aug 2024 00:31:01 -0500
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.81])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47T5V0kr064991;
	Thu, 29 Aug 2024 00:31:01 -0500
Date: Thu, 29 Aug 2024 11:00:59 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <bhelgaas@google.com>,
        <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <vigneshr@ti.com>,
        <kishon@kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>
Subject: Re: [PATCH v3 2/2] PCI: j721e: Enable ACSPCIE Refclk if
 "ti,syscon-acspcie-proxy-ctrl" exists
Message-ID: <99e1b482-0a54-4a33-9c59-f9851ef2c1b6@ti.com>
References: <20240827055548.901285-3-s-vadapalli@ti.com>
 <20240828211906.GA38267@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240828211906.GA38267@bhelgaas>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Wed, Aug 28, 2024 at 04:19:06PM -0500, Bjorn Helgaas wrote:

Hello Bjorn,

> On Tue, Aug 27, 2024 at 11:25:48AM +0530, Siddharth Vadapalli wrote:
> > The ACSPCIE module is capable of driving the reference clock required by
> > the PCIe Endpoint device. It is an alternative to on-board and external
> > reference clock generators. Enabling the output from the ACSPCIE module's
> > PAD IO Buffers requires clearing the "PAD IO disable" bits of the
> > ACSPCIE_PROXY_CTRL register in the CTRL_MMR register space.
> > 
> > Add support to enable the ACSPCIE reference clock output using the optional
> > device-tree property "ti,syscon-acspcie-proxy-ctrl".
> > 
> > Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > ---
> > 

[...]

> > +
> > +	ret = of_parse_phandle_with_fixed_args(node,
> > +					       "ti,syscon-acspcie-proxy-ctrl",
> > +					       1, 0, &args);
> > +	if (!ret) {
> > +		/* Clear PAD IO disable bits to enable refclk output */
> > +		val = ~(args.args[0]);
> > +		ret = regmap_update_bits(syscon, 0, mask, val);
> > +		if (ret)
> > +			dev_err(dev, "failed to enable ACSPCIE refclk: %d\n",
> > +				ret);
> > +	} else {
> > +		dev_err(dev,
> > +			"ti,syscon-acspcie-proxy-ctrl has invalid arguments\n");
> > +	}
> 
> I should have mentioned this the first time, but this would be easier
> to read if structured as:
> 
>   ret = of_parse_phandle_with_fixed_args(...);
>   if (ret) {
>     dev_err(...);
>     return ret;
>   }
> 
>   /* Clear PAD IO disable bits to enable refclk output */
>   val = ~(args.args[0]);
>   ret = regmap_update_bits(syscon, 0, mask, val);
>   if (ret) {
>     dev_err(...);
>     return ret;
>   }
> 
>   return 0;

Yes, this removes the nested IF conditions and is definitely a cleaner
approach. I will update this in the next version of the patch.

> 
> > +	return ret;
> > +}
> > +
> >  static int j721e_pcie_ctrl_init(struct j721e_pcie *pcie)
> >  {
> >  	struct device *dev = pcie->cdns_pcie->dev;
> > @@ -259,6 +288,15 @@ static int j721e_pcie_ctrl_init(struct j721e_pcie *pcie)
> >  		return ret;
> >  	}
> >  
> > +	/* Enable ACSPCIE refclk output if the optional property exists */
> > +	syscon = syscon_regmap_lookup_by_phandle_optional(node,
> > +						"ti,syscon-acspcie-proxy-ctrl");
> > +	if (syscon) {
> > +		ret = j721e_enable_acspcie_refclk(pcie, syscon);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> >  	return 0;
> 
> Not as dramatic here, but I think the following would be a little
> simpler since the final "return" isn't used for two purposes
> ((1) syscon property absent, (2) syscon present and refclk
> successfully enabled):
> 
>   syscon = syscon_regmap_lookup_by_phandle_optional(...);
>   if (!syscon)
>     return 0;
> 
>   return j721e_enable_acspcie_refclk(...);

Sure. I will implement the above in the next patch. Thank you for
reviewing this patch and sharing your feedback.

Regards,
Siddharth.

