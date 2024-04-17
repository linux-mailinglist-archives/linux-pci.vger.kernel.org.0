Return-Path: <linux-pci+bounces-6356-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE7D8A8719
	for <lists+linux-pci@lfdr.de>; Wed, 17 Apr 2024 17:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E99831F22BED
	for <lists+linux-pci@lfdr.de>; Wed, 17 Apr 2024 15:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A471411E0;
	Wed, 17 Apr 2024 15:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mXN+IYIh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DD4146A6B;
	Wed, 17 Apr 2024 15:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713366608; cv=none; b=gvTlO3Y1gN+Mfa+CV3U2HmfuG/bUfQJX/WOKJkXpVlV0EHX/NMVsvWjK0IkEMfP5ppOyCREVIuw0J/YBmZdXQi4vYLtMVhHpAvMqAeOJocpefTsRiyqufp6qLR+7pi0KLR0DgvUNzwaFXv/lzQwUvpLbl+7ou7IIGdwq0bl25wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713366608; c=relaxed/simple;
	bh=2iH29Kr9a60rYZ7alX/OpeMmfoox0uyeGvUK0iNJJpY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Qy0R6D/38k6IKOH2pEChB1PjEQJdVz2fY5YYci50PsZ+itY0WvoWVsRAuzBmgc3i0y385755uX4RjBp9q0WXEEo3CPiOhuk/SqW1Q+OyN2teyfDo7g9PUq7GF/3wrUVTxEkeZMoAom3aUGpkh0Md294ZePSh+/pC0UWbSPMXl24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mXN+IYIh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CB22C072AA;
	Wed, 17 Apr 2024 15:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713366607;
	bh=2iH29Kr9a60rYZ7alX/OpeMmfoox0uyeGvUK0iNJJpY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=mXN+IYIha8UjXHnSux0XtuNr2JVta+xWLsBARh9PMKPDNcRGFyYlHheo/cFBsQezS
	 /H4F3RT6okPPgwNvH14/E7r46v0wjeZOX68dMgyu/E5NPFiPMR3rSSgl6Yh+vljx/t
	 +G0Pg3nDnB7IxIXp7h+NlPHtcQvebKZTj3e+TN9C3WfoL3p5jFpyxv+WtieZmWkbtk
	 nqM+FQInNEPtd6E1Im6irNC9RiRHtcWF60V58+ureU+JalQGjfLAkPfm8BpYTxZFgD
	 ECaO/usrliaX8vMJM5k+BJu31IKiJKJlMcP2F+zyGgRQrLBXsy1vBTkT7l+UJwkyoI
	 d3vGQizUBIEJA==
Date: Wed, 17 Apr 2024 10:10:04 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, imx@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v6 5/5] PCI: dwc: Add generic MSG TLP support for sending
 PME_Turn_Off when system suspend
Message-ID: <20240417151004.GA202039@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zh/ezLdct9sisvhc@lizhi-Precision-Tower-5810>

On Wed, Apr 17, 2024 at 10:38:04AM -0400, Frank Li wrote:
> On Wed, Apr 17, 2024 at 03:49:44PM +0530, Manivannan Sadhasivam wrote:
> > On Mon, Apr 15, 2024 at 03:33:29PM -0400, Frank Li wrote:
> > > +	/*
> > > +	 * Allocate the resource for MSG TLP before programming the iATU outbound window in
> > > +	 * dw_pcie_setup_rc(). Since the allocation depends on the value of 'region_align', this has
> > > +	 * to be done after dw_pcie_iatu_detect().
> > 
> > Please wrap the comments to 80 columns.
> 
> New code style is 100 columns. does comments still stick to 80 columns?

I care more about files being consistent internally than I do about
adhering to a new 100 column rule.

With very few exceptions, pcie-designware-host.c fits in 80 columns.
I think there's no point in adding a comment using 100 columns.  That
leadds to either a window sized to accommodate 100 columns, where 20
columns are wasted for all the existing code and comments, or a window
sized for 80 columns, where the new comment looks ugly.  Neither is
attractive.

Bjorn

