Return-Path: <linux-pci+bounces-26623-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A221A99B92
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 00:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7138E1B80AD9
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 22:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4766E1FECBD;
	Wed, 23 Apr 2025 22:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g/ZDUlll"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123731E32D5;
	Wed, 23 Apr 2025 22:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745447788; cv=none; b=Qw8GSeJ+jmXHjigQeZIvsfpydggteeukEj3rmuT5+INIPvxZqie4lOn6DS7tkiMjCTP/BHMaq6h6qbKKq+d9FKnt5OMzRelguoviigY08BcMZBoSP+VUgi5r3XYoJJX6fslVw6T2rrNMrzBAD3seDbscmGHkHILBlud9xTvmwWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745447788; c=relaxed/simple;
	bh=BwWGHTaXVHl3VuDngynvTOc6nh/DwTjuEj5r8iOOtyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=LkLdjgku6QozjSh5Y1yAEyKT3CIoKGy57ou75d2NMltnXtlLxwjqPPTwhaqY3VGxhj2zu3cNSnDtDLePATrsluF6iyY2/bs0qKsamnhg8jEK9h3SSgGSIL9q7+UTHI1KQBWkX/w13oth/w8trjDX62nieUgInmbI5/5/S0ReFog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g/ZDUlll; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50E75C4CEE2;
	Wed, 23 Apr 2025 22:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745447787;
	bh=BwWGHTaXVHl3VuDngynvTOc6nh/DwTjuEj5r8iOOtyQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=g/ZDUlllBa27BiaVXP+jeFCQLf7rJCrPpkKdPxEnq7UQ/oAUouszDpMq11R3oYPx/
	 FKW1nqJ7FmgkbzoxdEWsfmFvDS8rtpVXe4384eR9ZabBmhduCaRSGqIDIfn1bCqDLh
	 h7UPgbLCCp9HQRrrJXrVtZvGfIeiZl0Op+L0BwmVTXOemxcCWPt8b4H9Wk/EasAfmd
	 WMqU/pf/OSZP6S1TWIjumkikzwaspLg3jZzfYo2Et9zz2najo407xrckYE4BuS2V/r
	 hZv1IeNN9h6VCgj+6APl1HUM+e1MrBvYrbAHTFBotcvwraNqqTiwsBEOYnzxlLRx+S
	 mTCJxzDNmE42A==
Date: Wed, 23 Apr 2025 17:36:25 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Vidya Sagar <vidyas@nvidia.com>, Frank Li <Frank.li@nxp.com>,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH] dt-bindings: PCI: Remove obsolete .txt docs
Message-ID: <20250423223625.GA460759@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqLS8qfRRRQ-FEirqo6FGWD4ypU5_=uc1mVu_U_Voga1=w@mail.gmail.com>

On Wed, Apr 23, 2025 at 08:02:04AM -0500, Rob Herring wrote:
> On Tue, Apr 22, 2025 at 12:18 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Fri, Apr 04, 2025 at 05:15:57PM -0500, Rob Herring (Arm) wrote:
> > > The content in these files has been moved to the schemas in dtschema.
> > > pci.txt is covered by pci-bus-common.yaml and pci-host-bridge.yaml.
> > > pci-iommu.txt is covered by pci-iommu.yaml. pci-msi.txt is covered in
> > > msi-map property in pci-host-bridge.yaml.
> >
> > I guess "dtschema" refers to
> > https://github.com/devicetree-org/dt-schema?
> 
> Yes.
> 
> > I kinda wish there was some direct link from the Linux kernel source
> > to dt-schema where all this information now lives (Requester ID
> > format, iommu-map, msi-map, linux,pci-domain, reg (and reference to
> > IEEE Std 1275-1994), interrupt mapping info, external-facing, etc).
> > Being a DT neophyte, I need all the help I can get ;)
> 
> Links to each property wouldn't really scale. Might as well copy all
> the common schemas into the kernel tree at that point.

Right.  In my ignorance, I found it useful to just grep the Linux
source for these properties, but that doesn't work any more.

> > There are a few dangling references to pci.txt:
> >
> >   Documentation/devicetree/bindings/pci/aardvark-pci.txt: - max-link-speed: see pci.txt
> >   Documentation/devicetree/bindings/pci/aardvark-pci.txt: - reset-gpios: see pci.txt
> >   Documentation/devicetree/bindings/pci/v3-v360epc-pci.txt:- bus-range: see pci.txt
> >   Documentation/devicetree/bindings/pci/v3-v360epc-pci.txt:  1275-1994 (see pci.txt) with the following restriction:
> 
> If no one cares enough to convert these, then I don't think the link matters.

I guess the descriptions of these now live at
https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/pci/pci-bus-common.yaml

There are a few Documentation/devicetree/bindings/ files that include
URLs like that, but maybe that's not considered a canonical source?

Bjorn

