Return-Path: <linux-pci+bounces-17557-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 586BB9E1280
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2024 05:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF7D9B2079B
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2024 04:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CADA957CBE;
	Tue,  3 Dec 2024 04:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tF+Hp87U"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A612F3398B
	for <linux-pci@vger.kernel.org>; Tue,  3 Dec 2024 04:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733200994; cv=none; b=pQ5045esPlxalWjXu5/HIPG4rl3obJDJaYsUPkXpts9rhE/YEZrIOWvT2RBOWHt6N3NbnKTOsBczmRbNISMKUCpFB4GNib6MxCxNMCtcjzphEJKa7H7b+Z3HxQ+kXcs29E8ho3/hfgY3NQzMzkIHTpvEg2DxgkQhbg260iRThRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733200994; c=relaxed/simple;
	bh=cKOxT6qnr18ddJasqXiVSZmz2RrQrNoSER9FEShbRIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GMqhmU6G0A4nuTDyx+2062xMuMB12rXs80OScHu2pI7JkX9p89WHT3AFsa5TK5MwlP4FHPhM9D9XOLrthzLjGldlESae2RtMw9jmB3gI+aBb1HeUH8UgVnlCwsaNWXzCgxZ4+6mrDW2uTjN7rctDz7Kq7kTIB4AKns/zlMlyKWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tF+Hp87U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF0FCC4CECF;
	Tue,  3 Dec 2024 04:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733200994;
	bh=cKOxT6qnr18ddJasqXiVSZmz2RrQrNoSER9FEShbRIM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tF+Hp87UAv9+prGo5ovGE2s1+J/yQv+/xOluSGCLm5Fo7lQiq+m4tafpOhz8RQEOg
	 NWZ5xiwdZF1CSc/SC2dWHoMFYWhFP+lgcTZSTVopMmPaQEjI6i7maKkszZCSAyUw91
	 JEeGOQFuD3n+QWrtuU8bsO3y6zVhsqB90Grutwpg34JUJByCqNEpyt6yxBW/8vti+9
	 gAlTBUaEf67mXMuyLgy7rYmQbxv7jyzLg2HKbfOissA39ue62AwXLx6j34JkN2DZwe
	 17mbBPbrIqHOcRJkGa7CuhB4FxVxQcHqPZKtnZxfvWj1EgqO0XTZcsij69fD7dRsT8
	 JxEYl9lbjPxZw==
Date: Tue, 3 Dec 2024 05:43:10 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v2 1/2] PCI: endpoint: pci-epf-test: Add support for
 capabilities
Message-ID: <Z06MXj2K4dcWMZff@x1-carbon>
References: <20241121152318.2888179-4-cassel@kernel.org>
 <20241121152318.2888179-5-cassel@kernel.org>
 <20241130081245.2gjrw26d5cbbsde5@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241130081245.2gjrw26d5cbbsde5@thinkpad>

Hello Mani,

On Sat, Nov 30, 2024 at 01:42:45PM +0530, Manivannan Sadhasivam wrote:
> >  
> >  struct pci_epf_test {
> > @@ -74,6 +76,7 @@ struct pci_epf_test_reg {
> >  	u32	irq_type;
> >  	u32	irq_number;
> >  	u32	flags;
> > +	u32	caps;
> 
> Can we rename the 'magic' register? It is not used since the beginning and I
> don't know if we will ever have a usecase for it.

It is actually used!

When doing PCITEST_BAR (pci_endpoint_test_bar()),
and barno == test->test_reg_bar, we are only filling the first 4 bytes,
rather than filling the whole BAR:
https://github.com/torvalds/linux/blob/v6.13-rc1/drivers/misc/pci_endpoint_test.c#L293-L294

These first 4 bytes are stored in the magic register.

I do agree that the magic register name is slightly misleading, but that
seems completely unrelated to this patch.

If you can come up with a better name, send a patch and you shall have
my Reviewed-by tag :)


Kind regards,
Niklas

