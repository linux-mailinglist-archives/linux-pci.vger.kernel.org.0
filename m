Return-Path: <linux-pci+bounces-15013-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D77F29AB09B
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 16:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FE3EB23605
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 14:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6669139CE9;
	Tue, 22 Oct 2024 14:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g8G65PK+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91607328B6
	for <linux-pci@vger.kernel.org>; Tue, 22 Oct 2024 14:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729606592; cv=none; b=faQkMCy2juHMExoMRB5aDLXEGyPjjIWCQW0ZDG6aZd4QOtP5on2xVSNqDB8L1T8CU5+o/lVfu7J+Ds0u8BCVfxUCFjmGnzQOMDLg0SFPQNME3m1+w6IzqqkoLF9sccYS8yaubiq/D9c8fKk6jWbkJSS0xzwbRivsVBgOVhlBN10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729606592; c=relaxed/simple;
	bh=ul1Yk6VUC5h+y27HGrrShBEIOFTbFxb0c7H57rX8jmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=opeilQ9Ho1ljElZl93hrO4w4gifNBvsKaP5LPY65gFcnCVn0iAfXbgMu1CsQuvoRxnAxjH5Jo+Sy3nVEYx14o3PdoPb0YPLKuGTsqB2Lc02H8rovQQFlQWgVRa5ZwlA+Ha5X+z+ggsBu32BBQ72RVcNH3D9Jok7+kmsqJzaUCmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g8G65PK+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC264C4CEC3;
	Tue, 22 Oct 2024 14:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729606591;
	bh=ul1Yk6VUC5h+y27HGrrShBEIOFTbFxb0c7H57rX8jmU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g8G65PK+wpVdQlBiJpMpz+UxqifofGGNKN0iI6BWdy+O9O2rP6jQxJcA0GwxyUrTH
	 aZmeMvODyiseIV5B1x+uxmkhM9ZI7wnJWG/kwggakoaraS3uTe1Cu1usu5DlW6qOGO
	 eVxcQrdt/CkqJjnnmBoHT3Oi5fK1CUAhOGkO1JC6wpLuHNY7r3uAxmR7BeSZcAuRvZ
	 ycYt8K/9ArmGN/FqjSlcgw8XH8iw3FwYovjoCWM0nObloJzLffAImwppy869XjsJa7
	 l8Y9p/W29fVt92lrOSQl/tP3lBhbNzCCUR6gyg2J+2HNl7isjysBVVBBTQvIO1QAmB
	 EduKBKyG1j+jw==
Date: Tue, 22 Oct 2024 16:16:24 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>
Subject: Re: [PATCH v6 0/6] Improve PCI memory mapping API
Message-ID: <ZxezuNnmJesC3IG9@x1-carbon.wireless.wdc>
References: <20241021221956.GA851955@bhelgaas>
 <848f676b-afce-472e-872d-53a32af094c1@kernel.org>
 <ZxdkopcSp9/P4f6k@x1-carbon.wireless.wdc>
 <20241022135631.a6ux4jzb47v7jvqr@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022135631.a6ux4jzb47v7jvqr@thinkpad>

On Tue, Oct 22, 2024 at 07:26:31PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Oct 22, 2024 at 10:38:58AM +0200, Niklas Cassel wrote:
> > On Tue, Oct 22, 2024 at 10:51:53AM +0900, Damien Le Moal wrote:
> > > On 10/22/24 07:19, Bjorn Helgaas wrote:
> > > > On Sat, Oct 12, 2024 at 08:32:40PM +0900, Damien Le Moal wrote:
> 
> > However, if you think about a generic DMA controller, e.g. an ARM primecell
> > pl330, I don't see how it that DMA controller will be able to perform
> > transfers correctly if there is not an iATU mapping for the region that it
> > is reading/writing to.
> > 
> 
> I don't think the generic DMA controller can be used to read/write to remote
> memory. It needs to be integrated with the PCIe IP so that it can issue PCIe
> transactions.

I'm not an expert, so I might of course be misunderstanding how things work.

When the CPU performs an AXI read/write to a MMIO address within the PCIe
controller (specifically the PCIe controller's outbound memory window),
the PCIe controller translates that incoming read/write to a read/write on the
PCIe bus.

(The PCI address of the generated PCIe transaction will depend on how the iATU
has been configured, which determines how reads/writes to the PCIe controller's
outbound memory window should be translated to PCIe addresses.)

If that is how it works when the CPU does the AXI read/write, why wouldn't
things work the same if it is an generic DMA controller performing the AXI
read/write to the MMIO address targeting the PCIe controller's outbound memory
window?


Kind regards,
Niklas

