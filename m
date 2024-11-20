Return-Path: <linux-pci+bounces-17120-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A73589D40C8
	for <lists+linux-pci@lfdr.de>; Wed, 20 Nov 2024 18:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53FDF1F248DF
	for <lists+linux-pci@lfdr.de>; Wed, 20 Nov 2024 17:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2FD213A3ED;
	Wed, 20 Nov 2024 17:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZBuVbbD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDB624B28
	for <linux-pci@vger.kernel.org>; Wed, 20 Nov 2024 17:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732122335; cv=none; b=MfjHIr3m3v6LNN18+YrCK02nlkT3B1cJY91JQvjV0ReBTcfJMNVRpyq3e9CUyD74nwWQeENI4k6SRUSRO5pYDRnkCdnYmMC8/0/GK5DmEVDsWuhoGv6uEi86zxGFwMDJW8+lSSAl8sElvdHyBalExRO6cyiIJet3sqiNA8S7LRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732122335; c=relaxed/simple;
	bh=8ng+zhPWEX9GJjPsLwFwtfpLpsQlyw3gU3O6k87fQlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TJyoagTUc/ukQ4LeUeLPE4JF1EQUjlkA/akk1jojtpvpDLVQdrV98C0j14BxZvOkbDRxXzFWYsNLnSmwqCnjncx0Nh27e0PQX3vEn9RHLdD0yUNXfTqxCqrStLbhtBPFAVj04F+r9KEbGtRFBTKwsd0hOsVLcW7Ya/eYFIDIOXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SZBuVbbD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC8C5C4CECD;
	Wed, 20 Nov 2024 17:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732122335;
	bh=8ng+zhPWEX9GJjPsLwFwtfpLpsQlyw3gU3O6k87fQlc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SZBuVbbDybyc7PhCdBNueTlA2g+YYEAu1WQ/WDnL2i4/2PkFbO+zqI4/RqHU46jaT
	 7SVlxecwc/2/uYRzCjVqPhmOceHJATrYIa67aeH+37gsxsevKJGlld1qiZJYld6SzT
	 d7I/c2vtDNxpIMBpwxzUSSCV6qCztvWsazaZT0Pwz5Y9759RV0x/uzWsxHsQlsGZfF
	 /Dl4Axk4r3Hp6hj8DZEd0w7NXoT3qhLgomuBOgjPjVbMvw6AyVuT3kZgJKjARbEXhT
	 6j78tfQLR1HBxaLgXQv5QZSZLjU5TeBsg2mj4L3u4sNa8aB2FI3keDx3sweKI0ZhKo
	 DgouEgxxsSetg==
Date: Wed, 20 Nov 2024 18:05:31 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/2] misc: pci_endpoint_test: Add support for capabilities
Message-ID: <Zz4W26SFMohbvsN-@ryzen>
References: <20241120155730.2833836-4-cassel@kernel.org>
 <20241120155730.2833836-6-cassel@kernel.org>
 <Zz4UCX3bl8MHae5u@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zz4UCX3bl8MHae5u@lizhi-Precision-Tower-5810>

On Wed, Nov 20, 2024 at 11:53:29AM -0500, Frank Li wrote:
> On Wed, Nov 20, 2024 at 04:57:33PM +0100, Niklas Cassel wrote:
> > If running pci_endpoint_test.c (host side) against a version of
> > pci-epf-test.c (EP side), we will not see any capabilities being set.
> >
> > For now, only add the CAP_HAS_ALIGN_ADDR capability.
> >
> > If the CAP_HAS_ALIGN_ADDR is set, that means that the EP side supports
> > reading/writing to an address without any alignment requirements.
> >
> > Thus, if CAP_HAS_ALIGN_ADDR is set, make sure that we do not add any
> > specific padding to the buffers that we allocate (which was only made
> > in order to get the buffers to satisfy certain alignment requirements).
> >
> > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> > ---
> >  drivers/misc/pci_endpoint_test.c | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> >
> > diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> > index 3aaaf47fa4ee..ab2b322410fb 100644
> > --- a/drivers/misc/pci_endpoint_test.c
> > +++ b/drivers/misc/pci_endpoint_test.c
> > @@ -69,6 +69,9 @@
> >  #define PCI_ENDPOINT_TEST_FLAGS			0x2c
> >  #define FLAG_USE_DMA				BIT(0)
> >
> > +#define PCI_ENDPOINT_TEST_CAPS			0x30
> > +#define CAP_HAS_ALIGN_ADDR			BIT(0)
> > +
> >  #define PCI_DEVICE_ID_TI_AM654			0xb00c
> >  #define PCI_DEVICE_ID_TI_J7200			0xb00f
> >  #define PCI_DEVICE_ID_TI_AM64			0xb010
> > @@ -805,6 +808,22 @@ static const struct file_operations pci_endpoint_test_fops = {
> >  	.unlocked_ioctl = pci_endpoint_test_ioctl,
> >  };
> >
> > +static void pci_endpoint_test_get_capabilities(struct pci_endpoint_test *test)
> > +{
> > +	struct pci_dev *pdev = test->pdev;
> > +	struct device *dev = &pdev->dev;
> > +	u32 caps;
> > +	bool has_align_addr;
> > +
> > +	caps = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_CAPS);
> 
> I worry about if there are problem if EP have not such register. for
> example, if reg's space size is 64, but host try to read pos 68. I think it
> is original design problem, it should have one 'version' or 'size' in
> register list.

Hello Frank,

The test BAR is allocated using pci_epf_alloc_space(), which allocates the
backing memory using dma_alloc_coherent(), which will return zeroed memory
regardless of __GFP_ZERO was set or not.

This means that running a new version of pci-endpoint-test.c (host side)
with and old version of pci-epf-test.c (EP side) will not see any
capabilities being set (as intended), so this is backwards compatible.


And as you probably know, pci-epf-test will always allocate at least 128
bytes for the test BAR:
https://github.com/torvalds/linux/blob/v6.12/drivers/pci/endpoint/functions/pci-epf-test.c#L833

This patch uses:
#define PCI_ENDPOINT_TEST_CAPS                     0x30

0x30 == 48, so we are currently only using 49 bytes.

So we should be good.


Kind regards,
Niklas

