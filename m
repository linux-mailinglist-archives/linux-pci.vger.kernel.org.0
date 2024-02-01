Return-Path: <linux-pci+bounces-2949-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EDF3845EF1
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 18:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 270A11C24CD0
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 17:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B4C7C6EA;
	Thu,  1 Feb 2024 17:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EGk/ElPD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728357C6D7;
	Thu,  1 Feb 2024 17:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706809996; cv=none; b=bITKmfJlrh04zec9CZ1KsS7Eo5YKwG3tLd9nvrWSzFDbED6rbpSwZ1wPdfV+48HmjIdmtoQeCNdcYamMGSvi5aCyiud7vSQ4HRBxu/fWRvc4+SXSZkdqp0YzFg2fkvCTCR5AFa62Cex3yVp0HLKCiWw80VxM8Dl5wD+wlKhk6jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706809996; c=relaxed/simple;
	bh=1KYxgr9o1ratY9lp3ssW0x8kI1CSjAd9LYfS2K9oLK4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=dc9cmpo1qs8rLO7X3J11yNbEIq5JQ7kgvFQ2bLk3jt2IwhWcGNv0k4mmuSs4YEiaUsfr00EqjKETuwZmhy5Xuanbdg9PRofHtwB5yK3l8j7QLiiPK5Bpk+7y4LwrFYC5Hl4pYXbrh/RROOwgrIcWV97QnusLEZw21jg+0WtvQSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EGk/ElPD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14D1CC43390;
	Thu,  1 Feb 2024 17:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706809994;
	bh=1KYxgr9o1ratY9lp3ssW0x8kI1CSjAd9LYfS2K9oLK4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=EGk/ElPD1Rngo2t5Fea3WJgs3oOw3dFABk2KXVs9k0spSKDDD6tWXwsUWIV+djEWw
	 ydzkwWPkNoEkxTCJLDERyFbNlRPkss3WMzoAlf9sGG1FYEO5fQ3325NxAxrHRTtfEt
	 f9NpjAyHt7a3wN3aK4hyCTo9avMkZiSxxRCxQYl0rsKwRc0u2chEQH1p9j5iRBe4q3
	 dnmC0u4Lk6ilJLIWWoRC/1iuwZ8pi9z6bbz/r0MV+bE8qUucoT8Rrmj24TbNqIuduW
	 55xYKXsJbm7wmion1MlVfvdih7xTkc1QccaUdaf4Q/jcLgXMCqOmD+YzY5YH0jcsYu
	 2EWhv46jGyc4A==
Date: Thu, 1 Feb 2024 11:53:12 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, imx@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH 1/6] PCI: Add INTx Mechanism Messages macros
Message-ID: <20240201175312.GA640762@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131153748.GA586693@bhelgaas>

On Wed, Jan 31, 2024 at 09:37:48AM -0600, Bjorn Helgaas wrote:
> On Tue, Jan 30, 2024 at 07:45:26PM -0500, Frank Li wrote:
> ...

> With these updates:
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Sorry, I should have mentioned that there were more comments below.

> > ---
> >  drivers/pci/pci.h | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> > 
> > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > index 2336a8d1edab2..fe42f5d10b010 100644
> > --- a/drivers/pci/pci.h
> > +++ b/drivers/pci/pci.h
> > @@ -22,6 +22,24 @@
> >   */
> >  #define PCIE_PME_TO_L2_TIMEOUT_US	10000
> >  
> > +/* Message Routing (r[2:0]) */
> 
> Add citation to the comment: "PCIe r6.0, sec 2.2.8"
> 
> > +#define PCI_MSG_TYPE_R_RC	0
> 
> I think I would prefix all these with "PCIE" instead of "PCI", since
> they are specific to PCIe and we already use "PCIE" for some of the
> PCIe-specific timeouts.
> 
> > +#define PCI_MSG_TYPE_R_ADDR	1
> > +#define PCI_MSG_TYPE_R_ID	2
> > +#define PCI_MSG_TYPE_R_BC	3
> > +#define PCI_MSG_TYPE_R_LOCAL	4
> > +#define PCI_MSG_TYPE_R_GATHER	5
> > +
> > +/* INTx Mechanism Messages */
> 
> Add "PCIe r6.0, sec 2.2.8.1"
> 
> > +#define PCI_MSG_CODE_ASSERT_INTA	0x20
> > +#define PCI_MSG_CODE_ASSERT_INTB	0x21
> > +#define PCI_MSG_CODE_ASSERT_INTC	0x22
> > +#define PCI_MSG_CODE_ASSERT_INTD	0x23
> > +#define PCI_MSG_CODE_DEASSERT_INTA	0x24
> > +#define PCI_MSG_CODE_DEASSERT_INTB	0x25
> > +#define PCI_MSG_CODE_DEASSERT_INTC	0x26
> > +#define PCI_MSG_CODE_DEASSERT_INTD	0x27
> > +
> >  extern const unsigned char pcie_link_speed[];
> >  extern bool pci_early_dump;
> >  
> > 
> > -- 
> > 2.34.1
> > 

