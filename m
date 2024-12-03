Return-Path: <linux-pci+bounces-17558-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1B39E1284
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2024 05:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C40D2832F7
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2024 04:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23E02E64A;
	Tue,  3 Dec 2024 04:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TPNN9vcu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB2D17C68
	for <linux-pci@vger.kernel.org>; Tue,  3 Dec 2024 04:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733201328; cv=none; b=Q5NkdqiZPntpc0RnujkpNRfWTepuguCMIbSwixrqLfzol7N3mp+vdqbuzDrpWxsIq//xeGUV4AqFOfF6fDhdk9c+ndFMyJhHn2sVwD8QtzrKip4m3xEKhKoGr6afOxccpXktVQIslOC7u7XpkBk9+q+h66Lkui4psrpZg66I1pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733201328; c=relaxed/simple;
	bh=amrTVQTixHB1Hoa3sJ4AqsYOKqLe75hPwEZMoJvHMOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a5Bg0Q/1D+scR2Y5PXhBu5fygvN6jsED0yju9Kfh8HSUfHhKiAZ7zYGCDTzkA08CHOPHgtm6Hh4ikwgOJD6DN7diacvzNfE/HyUvl0NcQgtraLjKWa7Mu/2DIfcQ8y2gdPw9VoCMeW7GZW8o8XK59yVvR5oNQH86keHbPIdDW4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TPNN9vcu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C34E9C4CECF;
	Tue,  3 Dec 2024 04:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733201328;
	bh=amrTVQTixHB1Hoa3sJ4AqsYOKqLe75hPwEZMoJvHMOo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TPNN9vcuZYgp7APYOSMfwMc03B0zz4IHVTWEzR9miGkFsc/XertjGHy4Nmkbx6NlH
	 NcEPzEI7hPs1Mn4hb74gFezaZkFDjs8nnRr3n+QpMLemJgMLiVHWsuaSkuJQ8ROA1v
	 n7RfGNjJJZ45M4Q52GUiMT/iS7w5hg+L8+jWuBwJSDYwPkWS7PuKzrW6HBaCZd4ufn
	 GrLXVKIkUjPn5sqopJBEBvQGN1SLNYozSyYlT63tpmUoeCGM6cpD9p/8CCYiMeVLpL
	 716Ot8gqIJ8So6H+WdeO5DzzWHq/0Cdu+OYwY6xm1KXqEz2po6e2AA4mROa0p6eOyw
	 C1XmhCvJIxcrQ==
Date: Tue, 3 Dec 2024 05:48:44 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v2 2/2] misc: pci_endpoint_test: Add support for
 capabilities
Message-ID: <Z06NrM2vcIvulp6B@x1-carbon>
References: <20241121152318.2888179-4-cassel@kernel.org>
 <20241121152318.2888179-6-cassel@kernel.org>
 <20241130082119.44zpza3ehlwf3zct@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241130082119.44zpza3ehlwf3zct@thinkpad>

On Sat, Nov 30, 2024 at 01:51:19PM +0530, Manivannan Sadhasivam wrote:
> >  
> > +static void pci_endpoint_test_get_capabilities(struct pci_endpoint_test *test)
> > +{
> > +	struct pci_dev *pdev = test->pdev;
> > +	struct device *dev = &pdev->dev;
> > +	u32 caps;
> > +	bool ep_can_do_unaligned_access;
> > +
> > +	caps = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_CAPS);
> > +
> > +	ep_can_do_unaligned_access = caps & CAP_UNALIGNED_ACCESS;
> > +	dev_dbg(dev, "CAP_UNALIGNED_ACCESS: %d\n", ep_can_do_unaligned_access);
> 
> IDK if the users really need to know about this flag, nor it will assist in any
> debugging. Otherwise, I'd suggest to drop this debug print and just do:
> 
> 	if (pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_CAPS))
> 		test->alignment = 0;
> 
> - Mani

I do think that there is value in having a debug print that prints the
capabilities, especially if more caps are added in the future.

Let me send a v3 that dumps all caps (as hex) in a single print instead,
i.e. simply:

caps = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_CAPS);
dev_dbg(dev, "PCI_ENDPOINT_TEST_CAPS: %#x\n", caps);


Kind regards,
Niklas

