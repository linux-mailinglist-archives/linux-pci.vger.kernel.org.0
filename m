Return-Path: <linux-pci+bounces-20548-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02893A221E1
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2025 17:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 644EF1887232
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2025 16:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D9919EEC2;
	Wed, 29 Jan 2025 16:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iTnqnlG3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986032FB6;
	Wed, 29 Jan 2025 16:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738168765; cv=none; b=pISQ+1w90HdeH+fj+bhygP4gY0k1UM4s6Ai1cocX/klSlzu8+V9T/4RAVUQVnBSTf7fDH6krjRX7wXGeNt8Kf0cc1SkCmxxBOt0x7getk4knMnpM2YDIgZg08bSxP+ycj1W58uve+SvnFy8MBOzBEDHx9CIVgObQK6C8FXatqFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738168765; c=relaxed/simple;
	bh=Ah4vFnZwz/yZYDSuu8dtBEFULNvuptTD7Yx7PbHXAxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tkKmu2vsDNIMd+ooH2o9mvhtXx/1c+gbqdgeoHVI24I71IHK/kbIub3AJkZwp3L96ofn+yjD/GHNTgjcjrbc+U92VCKxKAWKmOtSc1zakrKch6MIcriu4+zECYRRfXY6UcH3Mx+fAG1AsHxJHFeoMGpBLa/AdFXFNPdNTGcd5r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iTnqnlG3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E3BDC4CED1;
	Wed, 29 Jan 2025 16:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738168765;
	bh=Ah4vFnZwz/yZYDSuu8dtBEFULNvuptTD7Yx7PbHXAxQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iTnqnlG3+7YHKkHl0AKhQ4j0QCf1CqR4SYyHC+K5JQ17Ztjajn3FWmHT6+TggVeeA
	 ROt86ZitHHnWESUKMRQnUTmot8RyI3/Hc7DcqR/IpBhG+pPwt/DHfTJOI4rJZXeLub
	 DtWBWeV0wSU1n2LBxKn0rYgHcNAlpZpFqNGwtoCZlCvlyftJh+xmmkgxTF1SevIXRX
	 Zn/dbczsl5xpjlJ+dcYNbjphdUTeJqBehOpZDJt4ojjjlOfYYoWTVuROBbvxjDm//q
	 9On77OOIUHWyUzfozR12JD8NqQXaYP5/OtDGe6OmVYJ6AWoZHTkjASi0lkcuawFIpR
	 8RiI1H3ndLOeA==
Date: Wed, 29 Jan 2025 17:39:18 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev
Subject: Re: [PATCH v9 0/7] PCI: dwc: opitimaze RC Host/EP pci_fixup_addr()
Message-ID: <Z5pZtsa4FFKq0AZD@ryzen>
References: <20250128-pci_fixup_addr-v9-0-3c4bb506f665@nxp.com>
 <Z5n_VrN8HUmdVPUq@ryzen>
 <Z5pJF9MGENNDqq/O@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5pJF9MGENNDqq/O@lizhi-Precision-Tower-5810>

Hello Frank,

On Wed, Jan 29, 2025 at 10:28:23AM -0500, Frank Li wrote:
> On Wed, Jan 29, 2025 at 11:13:42AM +0100, Niklas Cassel wrote:
> >
> > Please don't shoot the messenger, but I don't see any reply to (what I
> > assume is the biggest reason why Bjorn did not merge this series):
> >
> > ""
> > .cpu_addr_fixup() is a generic problem that affects dwc (dra7xx, imx6,
> > artpec6, intel-gw, visconti), cadence (cadence-plat), and now
> > apparently microchip.
> >
> > I deferred these because I'm hoping we can come up with a more generic
> > solution that's easier to apply across all these cases.  I don't
> > really want to merge something that immediately needs to be reworked
> > for other drivers.
> > ""
> >
> > It should probably state in the cover letter how v9 addresses Bjorn's
> > concern when it comes to other PCI controller drivers, especially those
> > that are not DWC based.
> 
> Thank you for your reminder, I forget mentions this in cover letter. I
> create new patch to figure out this Bjorn's problem.
> 
> PCI: Add parent_bus_offset to resource_entry

I see.

If you are solving this problem in a generic way, then it would make sense
if the generic patch comes first in the series, and then the driver (DWC)
specific patches come after that.

Your cover letter, including the subject is also written in a DWC specific
manner.

If you are solving a generic problem, then describe first how you solve
the generic problem, followed by DWC specific details.

See e.g. my cover letter here:
https://lore.kernel.org/linux-pci/20250119050850.2kogtpl5hatpp2tv@thinkpad/T/#t


Kind regards,
Niklas

