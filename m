Return-Path: <linux-pci+bounces-31194-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFD5AF00E2
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 18:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DCC97AC7E3
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 16:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10C727CCC4;
	Tue,  1 Jul 2025 16:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k3cAUR1c"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E762798FA;
	Tue,  1 Jul 2025 16:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751389056; cv=none; b=WnQfVeUNhyKxa+pg8tMa+DLt/o/7mQM/GjQrVZb0zeNthwqhAeK27xESBeO+6gEYBxwYJTIAvbo3bLwSM2dmlJXh6TTGoMUDtja8ltI1prWA8p2OWS7IYvICVqIPzmAlJXA6JLYJDCylLXb5D1GTOKqZOcAZgvnbWSpR/cSrlxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751389056; c=relaxed/simple;
	bh=yt/kc/jTaSiC0j9rC9eyESiUppBPRZhs+YZzLBzzs2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=uGORp0qhAiRfn661sM9dgmnobVe6ppZ48we8mU5kbfkn5eoVPhGumAXhmdiCdx79imOPAddOyXYJrsG7fDCu7KSN5IJ5QyYQFn8eXrJlb/jbYx7mjsFjmVvYGm19wBf51cX3Bsuq61qcuc4gWR2j6f7oy5UaW12hog2DAdOtzJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k3cAUR1c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3601C4CEEB;
	Tue,  1 Jul 2025 16:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751389056;
	bh=yt/kc/jTaSiC0j9rC9eyESiUppBPRZhs+YZzLBzzs2Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=k3cAUR1cwKTtg4sD128wLSlwJY88qu3T8AwGwte1udkUcUr3rKs7T6494qFObHT3B
	 JTrodUx32RfXmXcNfG9GLlbH7Hv0sRG4CaLCPx0sd/i9FgvVUS06xnNt78wV/DcoOW
	 YZD84F4eISrgrOurB154lqR8dX8fNxi3VqtMT67f+pxlua1FKRWSDMH5Zi5BQELAKU
	 jRdwCi+sEZLy4Ds/xihdLxowlVRqTOkn6NUD+ZIuAz1phRiYvAx5s724BmTAiRVJeP
	 QUQt/PRY4OOWRarBMjZsbQ/3HCYM0A0EbeQBGSiU75BNmWLRI8XMP2GnoUsfYoNV3c
	 N7xUf38+SJ8iQ==
Date: Tue, 1 Jul 2025 11:57:34 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shradha Todi <shradha.t@samsung.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-fsd@tesla.com, mani@kernel.org,
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, jingoohan1@gmail.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, alim.akhtar@samsung.com, vkoul@kernel.org,
	kishon@kernel.org, arnd@arndb.de, m.szyprowski@samsung.com,
	jh80.chung@samsung.com, pankaj.dubey@samsung.com
Subject: Re: [PATCH v2 09/10] PCI: exynos: Add support for Tesla FSD SoC
Message-ID: <20250701165734.GA1839534@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02b101dbea79$d7e086c0$87a19440$@samsung.com>

On Tue, Jul 01, 2025 at 04:48:13PM +0530, Shradha Todi wrote:
> > -----Original Message-----
> > From: Bjorn Helgaas <helgaas@kernel.org>
> > Sent: 28 June 2025 01:01
> > To: Shradha Todi <shradha.t@samsung.com>
> > Cc: linux-pci@vger.kernel.org; devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> linux-
> > samsung-soc@vger.kernel.org; linux-kernel@vger.kernel.org; linux-phy@lists.infradead.org; linux-
> > fsd@tesla.com; manivannan.sadhasivam@linaro.org; lpieralisi@kernel.org; kw@linux.com;
> > robh@kernel.org; bhelgaas@google.com; jingoohan1@gmail.com; krzk+dt@kernel.org;
> > conor+dt@kernel.org; alim.akhtar@samsung.com; vkoul@kernel.org; kishon@kernel.org;
> > arnd@arndb.de; m.szyprowski@samsung.com; jh80.chung@samsung.com; pankaj.dubey@samsung.com
> > Subject: Re: [PATCH v2 09/10] PCI: exynos: Add support for Tesla FSD SoC

Would be good if your mailer could support the usual quote mechanism,
e.g. the "On Wed, Jun 25, 2025 at 10:22:28PM +0530, Shradha Todi
wrote:" line below.  No need for all the header duplication above.

> > On Wed, Jun 25, 2025 at 10:22:28PM +0530, Shradha Todi wrote:
> > > Add host and endpoint controller driver support for FSD SoC.

> > This would be a little nicer if you added soc_variant and device_mode
> > and the code that sets and tests them for exynos_5433 first in a
> > separate patch.  Then it would be more obvious that the new FSD parts
> > don't affect exynos_5433 since this patch would only be *adding*
> > FSD-specific things.
> 
> Sure,  I have no issues in splitting the patches further. Though
> unfortunately, I or anyone I know does not possess a board which has
> Exynos 5433 chipset.  Therefore, I'm unable to verify these changes
> for Exynos chipset. I took care to not disturb the exynos flow
> functionally but would be great if someone could test this and
> confirm that it works well on Exynos 5433 after the changes.

Yeah, that's a common situation, and there's no problem with adding
this functionality.  But in the unlikely event there's a mistake that
relates to Exynos 5433, it will be easier for someone with that board
to analyze the problem if the changes that affect exynos_5433 are
split out into a patch that doesn't include any FSD-related changes.

> > >  static const struct samsung_pcie_pdata exynos_5433_pcie_rc_pdata = {
> > >  	.dwc_ops		= &exynos_dw_pcie_ops,
> > >  	.pci_ops		= &exynos_pci_ops,
> > >  	.host_ops		= &exynos_pcie_host_ops,
> > >  	.res_ops		= &exynos_res_ops_data,
> > > +	.soc_variant		= EXYNOS_5433,
> > > +	.device_mode		= DW_PCIE_RC_TYPE,
> > >  };
> > 
> > >  static const struct of_device_id exynos_pcie_of_match[] = {
> > > @@ -449,6 +756,14 @@ static const struct of_device_id exynos_pcie_of_match[] = {
> > >  		.compatible = "samsung,exynos5433-pcie",
> > >  		.data = (void *) &exynos_5433_pcie_rc_pdata,
> > >  	},
> 

