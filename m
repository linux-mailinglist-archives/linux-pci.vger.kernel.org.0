Return-Path: <linux-pci+bounces-3751-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C97E685B83D
	for <lists+linux-pci@lfdr.de>; Tue, 20 Feb 2024 10:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6948B1F2766B
	for <lists+linux-pci@lfdr.de>; Tue, 20 Feb 2024 09:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A26604DD;
	Tue, 20 Feb 2024 09:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i3/G5uUE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71B65C5E0;
	Tue, 20 Feb 2024 09:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708422687; cv=none; b=jufAr6i5jnw1WGybefj189QUyABpJ3aszY0ce5NxdXn9dMNuw6XFHX9BbyR9dBQCKQq+7i7CK5DdsPgvbCZO9soW8EZM/AuiocxTLGnztN0ZQfF0vg1SGSJ0vDgNtudAqJonrvOvAknWUj9T6g35lZ3r3JgXRuReIdswdigz+9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708422687; c=relaxed/simple;
	bh=yDxhCM2YS8Q8iXNgzOUk2+9cgtV+kXn+jRue04kUuVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QVYnIxuNQeeFXc4jYdrnC05cXkmgBJnZuFzj+jWaOIrwBLPJq/qAcaDkVENE3lBMRzcfKwGOwxLWURmfyI3XPathddUHyulR3NO6R8TjzOZuq4ttXQS3fuUS6utEe3W9RlZCiw/wT94DmWewmGakq3tCVKU6y+xgSNYQmFwEDSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i3/G5uUE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AED6EC433F1;
	Tue, 20 Feb 2024 09:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708422687;
	bh=yDxhCM2YS8Q8iXNgzOUk2+9cgtV+kXn+jRue04kUuVo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i3/G5uUE84InpD/s92gGB4Qn1ZV+5peqepCh2De85eeXtuV1SSKSxkZDt4ySVLHfv
	 VbfEaQGDWsz/uW5vZG7unMcBDyUlIM6EJDhUxA67I9e64733WUq+eheBr+lbcyjnyS
	 DSv82w8W5ek+QhHwE8vlYXHJCPR7jpOTUpjDU7gi5cwQ1R01UPtyDb1y2GJvhi0Is5
	 fHBt+pbfofEdKhvyzo3ym3M5jlDfBP5xXyMO75tDQ7mvS/19JaVIUQ4rndppsSDQ7V
	 sCf8a00JrgfXo+6cWth/VPSn/kiEbUd3sqSmZjBNecviq4+dip7G2AmYhxSfLVGJgn
	 XBsekjWjyndpg==
Date: Tue, 20 Feb 2024 10:51:17 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	lpieralisi@kernel.org, bhelgaas@google.com, conor+dt@kernel.org,
	devicetree@vger.kernel.org, festevam@gmail.com, helgaas@kernel.org,
	hongxing.zhu@nxp.com, imx@lists.linux.dev, kernel@pengutronix.de,
	krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
	kw@linux.com, l.stach@pengutronix.de,
	linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	robh@kernel.org, s.hauer@pengutronix.de, shawnguo@kernel.org
Subject: Re: [PATCH v10 00/14] PCI: imx6: Clean up and add imx95 pci support
Message-ID: <ZdR2FRQ9Fe8hhK9I@x1-carbon>
References: <20240205173335.1120469-1-Frank.Li@nxp.com>
 <ZdNvsdao8jbB/52L@lizhi-Precision-Tower-5810>
 <20240219161208.GE3281@thinkpad>
 <ZdN/OyNpw0Xa7qXG@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdN/OyNpw0Xa7qXG@lizhi-Precision-Tower-5810>

On Mon, Feb 19, 2024 at 11:18:03AM -0500, Frank Li wrote:
> On Mon, Feb 19, 2024 at 09:42:08PM +0530, Manivannan Sadhasivam wrote:
> > On Mon, Feb 19, 2024 at 10:11:45AM -0500, Frank Li wrote:
> > > On Mon, Feb 05, 2024 at 12:33:21PM -0500, Frank Li wrote:
> > > > first 6 patches use drvdata: flags to simplify some switch-case code.
> > > > Improve maintaince and easy to read code.
> > > > 
> > > 
> > > @Lorenzo Pieralisi:
> > > 
> > > 	Do you have chance to look other patches?
> > > 	Mani's apply EP side change. 
> > 
> > Even though the controller is for the endpoint, it is still a controller
> > driver. So all the patches should go through Lorenzo.
> > 
> > I only merge patches under drivers/pci/endpoint. Hope this clarifies.
> 
> Sorry. It confused everyone. My means was that Mani applied Niklas Cassel's
> patches, which cause my 14th patch build failure.

Hello Frank,

Patch 14, which adds this:

+static const struct pci_epc_features imx95_pcie_epc_features = {
+       .msi_capable = true,
+       .bar_fixed_size[1] = SZ_64K,
+       .align = SZ_4K,
+};


Should, after rebasing on Mani's pci/endpoint branch, instead look like this:

+static const struct pci_epc_features imx95_pcie_epc_features = {
+       .msi_capable = true,
+       .bar[BAR_1] = { .type = BAR_FIXED, .fixed_size = SZ_64K, },
+       .align = SZ_4K,
+};


> 
> I asked if I need update my 14th patch or applied 1-13 only. 

I see, you want the maintainers to apply 1-13, and simply drop patch 14
instead of you sending out a rebased series.

I assume that the maintainers will be fine with your suggested approach.


Kind regards,
Niklas

