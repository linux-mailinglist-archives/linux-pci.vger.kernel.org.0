Return-Path: <linux-pci+bounces-6349-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E8388A81D2
	for <lists+linux-pci@lfdr.de>; Wed, 17 Apr 2024 13:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEBBC282CD5
	for <lists+linux-pci@lfdr.de>; Wed, 17 Apr 2024 11:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D97813C68E;
	Wed, 17 Apr 2024 11:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XCU3DgYz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1982313C80B;
	Wed, 17 Apr 2024 11:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713352478; cv=none; b=A8ATGn/0PwOirnVPnpVrOvebEL/RyH8PV93QS77KzsRTVO8FO6YJglXmBF8BAAPylT9pUZ8S5WWytQFRKU6nrDODJqKrRYcxh67zF94FBSid5F/+XIm5CJA16rfdfjJInmrk5pUkXrC2+fKodgXuTVoQpvnAGSCydDXZJYgHpFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713352478; c=relaxed/simple;
	bh=fT3fYl303jdSQU2wOrHLkWojdTgxis/f2aI/wa4Ne4g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Yz3UoC80Bw5qMHRu+JWvXwTQD/k/uVBuoOhDU2HY3GWT7f0OX/p7B6Q1NlrQcKI51+f99Oscd/Fc0pyMPdBaQlreBzohKwolXk1B2UkI64lznXJ6VkiyldnGiPzsA+qR2m6TiTbj0M7majsa9Q5gDJTSaaZPJ36/X0ZausrVdAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XCU3DgYz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F3E7C072AA;
	Wed, 17 Apr 2024 11:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713352477;
	bh=fT3fYl303jdSQU2wOrHLkWojdTgxis/f2aI/wa4Ne4g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=XCU3DgYz/jX4ZV3jTocjUICRtT+4xfLATcreV0egGqAKhNZntfx1IXnmTwizis7H7
	 tpaS81VdSiIpWH1LFk99/V7gM71s72GVdw0V97nCbTVVQVQF3HXVv28LP24XmFnKq/
	 0RlMTm6E2z/BmCY0xWdoaIFX4e0FHTpOBoccScNv+MEkt/ODZhFm0rsrg1TO7WjOJ5
	 JJXCKUA8xKszpH4gvheweCAoSly6jDjuyxFCpy7Sn0kJyKUI2zKIgD3odIe3yBS+c4
	 FEoJlxs/sh2hbLaFUKmkSAIe1crrFKxoD+pTUMTNCotjbKYzdqsHUUnAYqv1MHzepF
	 BZxI5Z1xVlNUA==
Date: Wed, 17 Apr 2024 06:14:35 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Frank Li <Frank.Li@nxp.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, imx@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v6 4/5] PCI: Add PCIE_MSG_CODE_PME_TURN_OFF message macro
Message-ID: <20240417111435.GA187921@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240417075655.GF3894@thinkpad>

On Wed, Apr 17, 2024 at 01:26:55PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Apr 16, 2024 at 12:02:42PM -0500, Bjorn Helgaas wrote:
> > On Mon, Apr 15, 2024 at 03:33:28PM -0400, Frank Li wrote:
> > > Add PCIE_MSG_CODE_PME_TURN_OFF macros to enable a PCIe host driver to send
> > > PME_Turn_Off messages.
> > > 
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > >  drivers/pci/pci.h | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > > index 19b4227a8a7e8..1f6d54a5a7cfc 100644
> > > --- a/drivers/pci/pci.h
> > > +++ b/drivers/pci/pci.h
> > > @@ -30,6 +30,8 @@
> > >  #define PCIE_MSG_TYPE_R_LOCAL	4
> > >  #define PCIE_MSG_TYPE_R_GATHER	5
> > >  
> > > +#define PCIE_MSG_CODE_PME_TURN_OFF	0x19
> > 
> > This is defined in PCIe r6.0, sec 2.2.8.2, so move this below the INTx
> > #defines so they're all in the order of the spec sections and add the
> 
> I think it was me who suggested moving this up to keep it sorted in ascending
> order :/

OK, the order you suggested is fine.

> > spec citation to follow the same style as the surrounding #defines,
> > i.e.,
> > 
> >   /* Power Management Messages; PCIe r6.0, sec 2.2.8.2 */
> >   #define PCIE_MSG_CODE_PME_TURN_OFF   0x19
> > 
> > While you're at it, tweak the [1/5] comments to be:
> > 
> >   /* Message Routing (r[2:0]); PCIe r6.0, sec 2.2.8 */
> >   /* INTx Mechanism Messages; PCIe r6.0, sec 2.2.8.1 */
> > 
> > since the "Message Routing See: PCIe ..." comments are run together
> > and need some punctuation between the text and the citation.

But please do add and tweak the comments.

> > With these,
> > 
> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Still fine to add this :)

> > >  /* INTx Mechanism Messages See: PCIe r6.0, sec 2.2.8.1 */
> > >  #define PCIE_MSG_CODE_ASSERT_INTA	0x20
> > >  #define PCIE_MSG_CODE_ASSERT_INTB	0x21
> > > 
> > > -- 
> > > 2.34.1
> > > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்

