Return-Path: <linux-pci+bounces-35445-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B18CDB43B98
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 14:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A51F566C46
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 12:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9C32EBDD0;
	Thu,  4 Sep 2025 12:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rf8A+Q/h"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6832EB871;
	Thu,  4 Sep 2025 12:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756988938; cv=none; b=UaHC3sn8vHV7RHEKXkmYMw7bZRVjMek8JiLZdq/uU2K0eyWcQxpcyRCdIJ0dGKtcbxeYC7TiuRVjUMUcwP+zfbmn544I5n9j49U5wO3h1Uj7FGHgkRABdgkTr2S5ha0L5vfnzfvBloMP8pYgfFNEbsorz2KVN2F+XLgZP55hLHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756988938; c=relaxed/simple;
	bh=Hxa1aMEFLaONCF/Z4hf/tCWlMBHGKFUBQC+vB4D1feU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TDf1/bBNyT/ST4mI4Tpq5rBNRJLd8nGhERYxtkeTuO1uOcFoO/TNPE8//RJwFMHSdVSquMcpQ1KmrGirecMfs70FVFAOEnDk8tJPIIpcdFDwFSYdYM57ST7SIo8Css+icq3lqyLMcJ5S8HLXPSw8lZfoCLunOV1gTwqyAmLfnW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rf8A+Q/h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C19FC4CEF4;
	Thu,  4 Sep 2025 12:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756988938;
	bh=Hxa1aMEFLaONCF/Z4hf/tCWlMBHGKFUBQC+vB4D1feU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rf8A+Q/hq0H5TXLZc6VFkn0MLRiZETdXvxGb+qtgOIXgW1VpXpSFhc4EcN0B/Bkep
	 z7sLJcwhIfZBGN5SmE77IaO/fqeexboclGtAt5EWykQKtR+RLhs/PdtodgJI2dm3Tt
	 j3zKA0jRHNHnjpeLs445vMJNcsEWoa12ZNrPozUxocKPDZBE+xf0omZlSXdhfVsK6r
	 aQz5IuyUBumMOMMaI8ahc9GDv7GmDZfry88DeFDoGJZZrajQtpsRuvVAt5CsFdTPMU
	 4YlRmGmq4TKnGmSvmmTuntQ4vf8ctasLdaIkoLzs/lx8IvnXbsbpD1oKU912OI1Hoy
	 m3349uZv5lflw==
Date: Thu, 4 Sep 2025 14:28:53 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	linux-pci@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Wang Jiang <jiangwang@kylinos.cn>, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH] PCI: endpoint: pci-epf-test: Limit PCIe BAR size for
 fixed BARs
Message-ID: <aLmGBYOVevP5hH0X@ryzen>
References: <20250904023753.494147-1-marek.vasut+renesas@mailbox.org>
 <b3d5773d-c573-4491-b799-90405a8af6a9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b3d5773d-c573-4491-b799-90405a8af6a9@kernel.org>

On Thu, Sep 04, 2025 at 11:40:15AM +0900, Damien Le Moal wrote:
> On 9/4/25 11:37 AM, Marek Vasut wrote:
> > Currently, the test allocates BAR sizes according to fixed table
> > bar_size[] = { 512, 512, 1024, 16384, 131072, 1048576 } . This
> > does not work with controllers which have fixed size BARs, like
> > Renesas R-Car V4H PCIe controller, which has BAR4 size limited
> > to 256 Bytes, which is much less than 131072 currently requested
> > by this test.
> > 
> > Adjust the test such, that in case a fixed size BAR is detected
> > on a controller, minimum of requested size and fixed size BAR
> > size is used during the test instead.
> > 
> > This helps with test failures reported as follows:
> > "
> > pci_epf_test pci_epf_test.0: requested BAR size is larger than fixed size
> > pci_epf_test pci_epf_test.0: Failed to allocate space for BAR4
> > "
> > 
> > Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> > ---
> > Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Damien Le Moal <dlemoal@kernel.org>
> > Cc: Frank Li <Frank.Li@nxp.com>
> > Cc: Kishon Vijay Abraham I <kishon@kernel.org>
> > Cc: Manivannan Sadhasivam <mani@kernel.org>
> > Cc: Niklas Cassel <cassel@kernel.org>
> > Cc: Wang Jiang <jiangwang@kylinos.cn>
> > Cc: linux-kernel@vger.kernel.org
> > Cc: linux-pci@vger.kernel.org
> > Cc: linux-renesas-soc@vger.kernel.org
> > ---
> >  drivers/pci/endpoint/functions/pci-epf-test.c | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> > index e091193bd8a8a..d9c950d4c9a9e 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> > @@ -1022,7 +1022,8 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
> >  	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
> >  	enum pci_barno bar;
> >  	const struct pci_epc_features *epc_features = epf_test->epc_features;
> > -	size_t test_reg_size;
> > +	size_t test_reg_size, test_bar_size;
> > +	u64 bar_fixed_size;
> >  
> >  	test_reg_bar_size = ALIGN(sizeof(struct pci_epf_test_reg), 128);
> >  
> > @@ -1050,7 +1051,13 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
> >  		if (bar == test_reg_bar)
> >  			continue;
> >  
> > -		base = pci_epf_alloc_space(epf, bar_size[bar], bar,
> > +		test_bar_size = bar_size[bar];
> > +
> > +		bar_fixed_size = epc_features->bar[bar].fixed_size;
> > +		if (epc_features->bar[bar].type == BAR_FIXED && bar_fixed_size)
> > +			test_bar_size = min(bar_size[bar], bar_fixed_size);
> 
> I think this can be simplified to:
> 
> 		if (epc_features->bar[bar].type == BAR_FIXED)
> 			test_bar_size = epc_features->bar[bar].fixed_size;
> 		else
> 			test_bar_size = bar_size[bar];

+1

> 
> because if the bar type is BAR_FIXED, then the size of the bar can only be its
> fixed size.

Correct, see:
f015b53d634a ("PCI: endpoint: Add size check for fixed size BARs in pci_epc_set_bar()")

Actually, Jerome Brunet was also using this weird Renesas R-Car V4H PCIe
controller where BAR4 is a really small fixed-size BAR.

(Even smaller than the iATU minimum alignment requirement for that same
controller.)

See:
793908d60b87 ("PCI: endpoint: Retain fixed-size BAR size as well as aligned size")

But he only appears to have used the vntb epf driver.

Jerome, I suppose that you never ran with the pci-epf-test driver?


pci_epf_alloc_space() works like this:
If the user requests a BAR size that is smaller than the fixed-size BAR,
it will allocate space matching the fixed-size.

As in most cases, having a BAR larger than needed by an EPF driver is
still acceptable.

However, if the user requests a size larger than the fixed-size BAR,
as in your case, we will return an error, as we cannot fulfill the
user's request.

I don't see any alternative other than your/Damien's proposal above.

Unfortunately, all EPF drivers would probably need this same change.


Kind regards,
Niklas

