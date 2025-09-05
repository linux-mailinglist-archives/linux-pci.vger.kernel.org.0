Return-Path: <linux-pci+bounces-35532-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E61B457CC
	for <lists+linux-pci@lfdr.de>; Fri,  5 Sep 2025 14:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81F4B7B188C
	for <lists+linux-pci@lfdr.de>; Fri,  5 Sep 2025 12:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF0534AB04;
	Fri,  5 Sep 2025 12:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S0BtVcNo"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C45296BA6;
	Fri,  5 Sep 2025 12:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757075270; cv=none; b=Wi2kxHCxgl1OZI3/5XRb7Xrl6HZ4+Grz+/+vRmBgNGRn4V4A0D4n+R/vJ2ZIFmsDYpjtvTg83EkZNaOE1s16MOjPPTMsDW/StPa3RFk0GFE9Odhp0aKjAGdS3cZSD+56ypOmcngp+6niLROR5Ii10+sO9tWJ5LzJf5IcBYASheg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757075270; c=relaxed/simple;
	bh=hs2wGhylTyIy0X36FRj9qqYUOR3jDXcVE8sGtRSOJ5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tw6dZ4E1/9PJoPfzUzN28Z+ff6RN7YhPeVHQIZvN0G9Or+NaeM4hBEQm/M4Bl2lrnlv0rLi4NLotaR+yn/wpanrmrbWK06A0qTg9NNRjn4/HKaFIhksmS3JcEVdj2IMOvxwFnB1LGeQ51iGvQnVxyVDmBFYYWywRsTVBUGqvxLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S0BtVcNo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66157C4CEF1;
	Fri,  5 Sep 2025 12:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757075270;
	bh=hs2wGhylTyIy0X36FRj9qqYUOR3jDXcVE8sGtRSOJ5o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S0BtVcNoioES+xZ0HEiEQfNrSLx7dEEmVvwbCk7hVetNfv6Wud4hyfn7fYSaiwsSb
	 WCl+3Y+uQb9MY9sCNsO3Rz79SSDkEe+Qn6055GkwU8bYeq3IEockSyGwroYcbYyRff
	 QCbnSjCbL9aOkTSvJoqMEUASa7qQnuZN5BwL4/Xs95+zeEd+DQ9sl9A3OKCZjuWdZd
	 myNOr7Cni5wGulkU+j+AazFcaG5I9ELIrKz65GbdV4Jv7gLS+eYBh0/LSrqJAhnIh2
	 AS2785REvycLTlG4sYrm1P0kbSbz2xBT9uqkFzqOx8epgpelT06jlTzvCG76q+PC8F
	 ZbtNGChYM5V0w==
Date: Fri, 5 Sep 2025 14:27:44 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-pci@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Wang Jiang <jiangwang@kylinos.cn>, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2] PCI: endpoint: pci-epf-test: Limit PCIe BAR size for
 fixed BARs
Message-ID: <aLrXQGzYBB8JVE0Z@ryzen>
References: <20250905121259.9378-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905121259.9378-1-marek.vasut+renesas@mailbox.org>

On Fri, Sep 05, 2025 at 02:12:43PM +0200, Marek Vasut wrote:
> Currently, the test allocates BAR sizes according to fixed table
> bar_size[] = { 512, 512, 1024, 16384, 131072, 1048576 } . This
> does not work with controllers which have fixed size BARs, like
> Renesas R-Car V4H PCIe controller, which has BAR4 size limited
> to 256 Bytes, which is much less than 131072 currently requested
> by this test.

Perhaps rephase this to more clearly state that:
This does not work with controllers with have fixed size BARs that is
smaller than the requested BAR size.

(Since a lot of controllers drivers in-tree have fixed size BARs,
and they do work perfectly fine, but it is only because their fixed
size is larger than the size requested by pci-epf-test.c)


> 
> Adjust the test such, that in case a fixed size BAR is detected
> on a controller, minimum of requested size and fixed size BAR
> size is used during the test instead.

This sentence needs to be updated, since you no longer take the minimum
of requested size and fixed size BAR.

Perhaps simply:
"Adjust the test such that in case a fixed size BAR is detected,
the fixed BAR size is used, as that is the only possibly option."


With that:
Reviewed-by: Niklas Cassel <cassel@kernel.org>


> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index e091193bd8a8a..2418add64104a 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -1050,7 +1050,12 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
>  		if (bar == test_reg_bar)
>  			continue;
>  
> -		base = pci_epf_alloc_space(epf, bar_size[bar], bar,
> +		if (epc_features->bar[bar].type == BAR_FIXED)
> +			test_reg_size = epc_features->bar[bar].fixed_size;
> +		else
> +			test_reg_size = bar_size[bar];
> +
> +		base = pci_epf_alloc_space(epf, test_reg_size, bar,
>  					   epc_features, PRIMARY_INTERFACE);
>  		if (!base)
>  			dev_err(dev, "Failed to allocate space for BAR%d\n",
> -- 
> 2.50.1
> 

