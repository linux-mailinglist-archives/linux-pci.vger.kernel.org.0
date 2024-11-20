Return-Path: <linux-pci+bounces-17122-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A50089D41AE
	for <lists+linux-pci@lfdr.de>; Wed, 20 Nov 2024 18:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3ED6DB26024
	for <lists+linux-pci@lfdr.de>; Wed, 20 Nov 2024 17:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1F51531C0;
	Wed, 20 Nov 2024 17:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DIdX3kqg"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE23B1474B8
	for <linux-pci@vger.kernel.org>; Wed, 20 Nov 2024 17:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732123068; cv=none; b=nhG4zt0ovsyEhRUthhRiQebiRpCnPTFlsVh9M0yO/Gy0BD5sgEw1wG4ePqsHiA5NukAnNpCXy4Uqh2DOFmuzJurY0xWxeZRcVQ85LK0UgFDQcg44G4Vx9wp0jGke+AEhevCOCt9yt99GaVfdV/+DuaLyGTdKmrHKcsZ3gKK8gbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732123068; c=relaxed/simple;
	bh=nxLpO5yYMRopyL7QBWBHttVvLNnROu3C28TFOCY3oh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fh0PkQotlOeR0XmbbzD4mXGHuBlPKVzaY5HwIYxRNqVWMY8bTyx/4xRxJYyRuPZPvsSk701rfp0KI9oYlzpVX3ILlVWhZW+ExLuQqcI7IN08oSvoqylj+nwlVMLHnrng+70piN3aEsO9Yp2YogX3LdKty5qKX7cljRgIWG+3oac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DIdX3kqg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12838C4CECD;
	Wed, 20 Nov 2024 17:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732123067;
	bh=nxLpO5yYMRopyL7QBWBHttVvLNnROu3C28TFOCY3oh8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DIdX3kqgrETcBOaEGqteJa3NGdx70yvLKA5GFme44KuNbqh74j9A9vVOAKbp7pjRZ
	 Cd+ADv17y3p2DdgNm47s1bwrO6h0AskJB5qpwVRMZVvxlmzAziRg/Z5aGPDWiqxUPd
	 0iEAT/2kwF7scw3C1UeTjJAlx6h03LHHftt32elvQHVQEcnXAjDIoi2oDqb7hhlq+Y
	 swafEgjj0zPD/qAp3yIZF3/s/8xBYxYk3Qe31P2Uk3j7+zFAGZ9rvJ9ChwnYnjt1kK
	 WeLJNjJWlV2xN0CzJ5vlG/XQTteFPfc/tLMOVJQpE/ZTIizixDSG+YWQa7pz/n8kKK
	 5mVldJ851dDQg==
Date: Wed, 20 Nov 2024 18:17:43 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/2] misc: pci_endpoint_test: Add support for capabilities
Message-ID: <Zz4Zt26_Bmd74SWu@ryzen>
References: <20241120155730.2833836-4-cassel@kernel.org>
 <20241120155730.2833836-6-cassel@kernel.org>
 <Zz4UCX3bl8MHae5u@lizhi-Precision-Tower-5810>
 <Zz4W26SFMohbvsN-@ryzen>
 <Zz4Yk+GoLoaRRSLJ@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zz4Yk+GoLoaRRSLJ@lizhi-Precision-Tower-5810>

On Wed, Nov 20, 2024 at 12:12:51PM -0500, Frank Li wrote:
> On Wed, Nov 20, 2024 at 06:05:31PM +0100, Niklas Cassel wrote:
> > On Wed, Nov 20, 2024 at 11:53:29AM -0500, Frank Li wrote:
> > > On Wed, Nov 20, 2024 at 04:57:33PM +0100, Niklas Cassel wrote:
> > > > If running pci_endpoint_test.c (host side) against a version of
> > > > pci-epf-test.c (EP side), we will not see any capabilities being set.
> > > >
> > > > For now, only add the CAP_HAS_ALIGN_ADDR capability.
> > > >
> > > > If the CAP_HAS_ALIGN_ADDR is set, that means that the EP side supports
> > > > reading/writing to an address without any alignment requirements.
> > > >
> > > > Thus, if CAP_HAS_ALIGN_ADDR is set, make sure that we do not add any
> > > > specific padding to the buffers that we allocate (which was only made
> > > > in order to get the buffers to satisfy certain alignment requirements).
> > > >
> > > > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> > > > ---
> > > >  drivers/misc/pci_endpoint_test.c | 21 +++++++++++++++++++++
> > > >  1 file changed, 21 insertions(+)
> > > >
> > > > diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> > > > index 3aaaf47fa4ee..ab2b322410fb 100644
> > > > --- a/drivers/misc/pci_endpoint_test.c
> > > > +++ b/drivers/misc/pci_endpoint_test.c
> > > > @@ -69,6 +69,9 @@
> > > >  #define PCI_ENDPOINT_TEST_FLAGS			0x2c
> > > >  #define FLAG_USE_DMA				BIT(0)
> > > >
> > > > +#define PCI_ENDPOINT_TEST_CAPS			0x30
> > > > +#define CAP_HAS_ALIGN_ADDR			BIT(0)
> > > > +
> > > >  #define PCI_DEVICE_ID_TI_AM654			0xb00c
> > > >  #define PCI_DEVICE_ID_TI_J7200			0xb00f
> > > >  #define PCI_DEVICE_ID_TI_AM64			0xb010
> > > > @@ -805,6 +808,22 @@ static const struct file_operations pci_endpoint_test_fops = {
> > > >  	.unlocked_ioctl = pci_endpoint_test_ioctl,
> > > >  };
> > > >
> > > > +static void pci_endpoint_test_get_capabilities(struct pci_endpoint_test *test)
> > > > +{
> > > > +	struct pci_dev *pdev = test->pdev;
> > > > +	struct device *dev = &pdev->dev;
> > > > +	u32 caps;
> > > > +	bool has_align_addr;
> > > > +
> > > > +	caps = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_CAPS);
> > >
> > > I worry about if there are problem if EP have not such register. for
> > > example, if reg's space size is 64, but host try to read pos 68. I think it
> > > is original design problem, it should have one 'version' or 'size' in
> > > register list.
> >
> > Hello Frank,
> >
> > The test BAR is allocated using pci_epf_alloc_space(), which allocates the
> > backing memory using dma_alloc_coherent(), which will return zeroed memory
> > regardless of __GFP_ZERO was set or not.
> >
> > This means that running a new version of pci-endpoint-test.c (host side)
> > with and old version of pci-epf-test.c (EP side) will not see any
> > capabilities being set (as intended), so this is backwards compatible.
> >
> >
> > And as you probably know, pci-epf-test will always allocate at least 128
> 
> Can you add such information to commit message?

This text is there in patch 1/2, but I can add it to patch 2/2 as well,
and add the text that test BAR reg is always at least 128 bytes.

Will do this in V2, thanks!


Kind regards,
Niklas

