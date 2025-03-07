Return-Path: <linux-pci+bounces-23142-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D09A56F8B
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 18:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EB8916FF36
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 17:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA5F23C8B5;
	Fri,  7 Mar 2025 17:48:47 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AFF21A43C;
	Fri,  7 Mar 2025 17:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741369727; cv=none; b=cnZfo7CmSUJJl2AMI4MIzYm2AodmxKQWjL6ktkUUxEFQGN9Y7a7zP9o/0O2OjMO/Twv8ICkWky3vS05CkQGYLScM0bY7SlOCglcpDSr3tCsW7eK0oOcEBO0hQaEA/X79tX3IFg3Nbyo9Azn0pOdbEW0WY+mhvoYjXsOohYjrWwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741369727; c=relaxed/simple;
	bh=IGX1jXp6GaD5P6XDsYKv44SwlpPvu2KMqx/rzpswewc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NFU/OC+AHE+Qjkdb5ljl+6kxGRj03yOpI7HcoDPADrsuoOJyeeHPRwWRY8lgtIyF1R8E1Wgo7W2DE3h1QqWFfeG1P6ccGoBvltc6cVJ0nJ/FmflkdtPJfbC+rgOpPbERm5zOtGAQf7qR5lBVS+/t4pnntyDe2g8MojaEn/fJGxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46DACC4CEE2;
	Fri,  7 Mar 2025 17:48:43 +0000 (UTC)
Date: Fri, 7 Mar 2025 23:18:39 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bo Sun <Bo.Sun.CN@windriver.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Kexin.Hao@windriver.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Will Deacon <will@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Vidya Sagar <vidyas@nvidia.com>
Subject: Re: [PATCH] PCI: controller: Restore PCI_REASSIGN_ALL_BUS when
 PCI_PROBE_ONLY is enabled
Message-ID: <20250307174839.7nd7mhc5ebmokumu@thinkpad>
References: <20250117082428.129353-1-Bo.Sun.CN@windriver.com>
 <20250210103707.c5ubeaowk7xwt6p5@thinkpad>
 <df5d3c54-d436-43bb-8b40-665c020d6bb5@windriver.com>
 <20250214170057.o3ffoiuxn4hxqqqe@thinkpad>
 <55a33534-bff0-488c-a2a2-2898d54bd62f@windriver.com>
 <20250305060607.ygsafql53h2ujwjp@thinkpad>
 <416a2d7d-eeb6-4163-8805-3178476f5a8d@windriver.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <416a2d7d-eeb6-4163-8805-3178476f5a8d@windriver.com>

On Fri, Mar 07, 2025 at 06:14:26PM +0800, Bo Sun wrote:

[...]

> > > So, I propose the following solution as a workaround to handle these edge
> > > cases.
> > > 
> > > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > > index 82b21e34c545..af8efebc7e7d 100644
> > > --- a/drivers/pci/quirks.c
> > > +++ b/drivers/pci/quirks.c
> > > @@ -6181,6 +6181,13 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1536,
> > > rom_bar_overlap_defect);
> > >   DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1537,
> > > rom_bar_overlap_defect);
> > >   DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1538,
> > > rom_bar_overlap_defect);
> > > 
> > > +static void quirk_marvell_cn96xx_cn10xxx_reassign_all_busnr(struct pci_dev
> > > *dev)
> > > +{
> > > +       if (!pci_has_flag(PCI_PROBE_ONLY))
> > > +               pci_add_flags(PCI_REASSIGN_ALL_BUS);
> > > +}
> > > +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_CAVIUM, 0xa002,
> > > quirk_marvell_cn96xx_cn10xxx_reassign_all_busnr);
> > > +
> > 
> > LGTM. Please add a comment about this quirk too.
> 
> OK, I'll add the comment. Should I send the v2 patch?
> 

Yes, ofc. You should send v2 with the quirk change.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

