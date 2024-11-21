Return-Path: <linux-pci+bounces-17159-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A05749D4C8B
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 13:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55A161F2272E
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 12:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634EA1D362B;
	Thu, 21 Nov 2024 12:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CyCL/lC7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1091A3BC8
	for <linux-pci@vger.kernel.org>; Thu, 21 Nov 2024 12:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732190955; cv=none; b=XRtOEFkkFlqLhCRrRXFWxsPIXXY4T2kfNIFLm3ccuA1LTGlQUqS/O4HH0WHQmmqAqZglD/IQQDKmXmoTznPIC/Mlr2OxKHYhr+5whAR94iejIzl5BypmAjA/pyxmphC0Ea0Wb4uK66cjvna8IQoM/MbjkctdstVblnbtGw2q0jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732190955; c=relaxed/simple;
	bh=4/MAAU4SXbEXmjQ+k6fIGqwgiNJ0KndbueG4QNxL2K8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aVQ+Q5/6IOmujjxv+6XG54ssGAQ1EGNTYBvEWsncXKsVJ2/3mTHz7Qn6xb1ja2q1o9yy4zUeMa8HalpMGvEt/kcoqUxo+iOjTkUJTMoTQiPz7JgkNtJ8McUfTtTKRaCkLjMWz6dX0RbQKQhveyaJ7XknsCb6RGrkZvWB2GZSPGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CyCL/lC7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E950C4CECD;
	Thu, 21 Nov 2024 12:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732190954;
	bh=4/MAAU4SXbEXmjQ+k6fIGqwgiNJ0KndbueG4QNxL2K8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CyCL/lC7UrQvDQ8A0aBSLpgQkUslLbKOCp2Qinlh7vT9+j9IJq7eGIJp9m2+tn5FX
	 EuVkXr90AFU7KroxPr2Y0j7/nKj0nKGrbgmz1Xjkb8ROEjHMFl2AluIibwIT3/vEhK
	 ZN4SlkHxa9eaCX4FUKviKXFce+kT4upW/buhScHmYdyiePPdAUpiJHV71dyRvv40bu
	 G8rhenj/jLF4l8llu70CausOXvKfH3IpWG1zz1pHuvQqX/jEPoXvg65LRgVNRgfwZt
	 06OGQ015cQ145q6/3E2lvWffMPgQ0KsCnIPl//cvGadEKReleyY/0vSZobHprfSkAu
	 bavYiiprsRu7A==
Date: Thu, 21 Nov 2024 13:09:10 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-pci@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH 2/2] misc: pci_endpoint_test: Add support for capabilities
Message-ID: <Zz8i5hoCuTgEVyag@x1-carbon>
References: <20241120155730.2833836-4-cassel@kernel.org>
 <20241120155730.2833836-6-cassel@kernel.org>
 <00f1303d-7ab8-4cea-9491-5f689cbc423b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00f1303d-7ab8-4cea-9491-5f689cbc423b@kernel.org>

Hello Damien,

On Thu, Nov 21, 2024 at 11:54:48AM +0900, Damien Le Moal wrote:
> On 11/21/24 00:57, Niklas Cassel wrote:
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
> > +
> > +	has_align_addr = caps & CAP_HAS_ALIGN_ADDR;
> > +	dev_dbg(dev, "CAP_HAS_ALIGN_ADDR: %d\n", has_align_addr);
> > +
> > +	if (has_align_addr)
> 
> Shouldn't this be "if (!has_align_addr)" ?

Nope. Check patch 1/2 in this series.

+	if (epc->ops->align_addr)
+		caps |= CAP_HAS_ALIGN_ADDR;

i.e. if the EP implements the addr_align callback, then we know for sure
that the EP read/write anywhere.


However, if even you as the author of the .addr_align callback get confused
by this, then perhaps we should rename things.

How about:

ep_has_align_addr_cb = caps & CAP_HAS_ALIGN_ADDR_CB;
if (ep_has_align_addr_cb)
	test->alignment = 0;

or

ep_can_do_unaligned_access = caps & CAP_HAS_UNALIGNED_ACCESS;
if (ep_can_do_unaligned_access)
	test->alignment = 0;


Do you have any better suggestion?


Kind regards,
Niklas

