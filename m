Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 245E21C9D93
	for <lists+linux-pci@lfdr.de>; Thu,  7 May 2020 23:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbgEGVmi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 May 2020 17:42:38 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35839 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbgEGVmi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 May 2020 17:42:38 -0400
Received: by mail-ot1-f66.google.com with SMTP id k110so5878101otc.2;
        Thu, 07 May 2020 14:42:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qvVDuz4bfLO8NL9oGVG+1PPxD5bGC8ddxE9BQ+2L6xQ=;
        b=biKKekN9vqZyy33L1EtC8rmHSlPi5HXKswIrhmBiVkhoj7hGE89ZCA8F2Z4wa8zkZF
         qD4fiXlHdeCgikDUkehbVgdDJCqJBDKkCwT97bB/GjFmhPotFPnGjmHx4M0O4rUk4yhI
         wHiEIThhiIG3vTDpBWXpJ1IN62Btu5Nc93ZopPwWrAnsBMwVPIdkvZmIHLHKOnHPPLep
         VBhyslbFLsM/zyQ1T9PaP9APUovV3TbivCi7f0KmJMpa8WxMFnqhnxpM726h0yS1sh3U
         p8swabAARdxzMvPQ7ic9msy6kuN2mvO1VAtRN83wbkgblQBC8rdLW7o6R7ftCl43tokb
         NCmg==
X-Gm-Message-State: AGi0PuZNF7LtZqFN7eI0168lpk9+n5uJRNaobJto+E7yJTkHzn6GWhKK
        MeYLv8wont8OVjqD/4IE0w==
X-Google-Smtp-Source: APiQypIcUGO6HMXtlRrpBNnCJJewagIFAx0MZuDrS3bZb2IzqHQra/dhxokzIcicZ1CdJ+jhasN36g==
X-Received: by 2002:a05:6830:1dc9:: with SMTP id a9mr12235682otj.264.1588887756226;
        Thu, 07 May 2020 14:42:36 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q12sm1625569otn.57.2020.05.07.14.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 14:42:35 -0700 (PDT)
Received: (nullmailer pid 21913 invoked by uid 1000);
        Thu, 07 May 2020 21:42:34 -0000
Date:   Thu, 7 May 2020 16:42:34 -0500
From:   Rob Herring <robh@kernel.org>
To:     Alan Mikhak <alan.mikhak@sifive.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kishon@ti.com, lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        ulf.hansson@linaro.org, sebott@linux.ibm.com, efremov@linux.com,
        vidyas@nvidia.com, paul.walmsley@sifive.com
Subject: Re: [PATCH] PCI: endpoint: functions/pci-epf-test: Enable picking
 DMA channel by name
Message-ID: <20200507214234.GA5449@bogus>
References: <1588350008-8143-1-git-send-email-alan.mikhak@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588350008-8143-1-git-send-email-alan.mikhak@sifive.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 01, 2020 at 09:20:08AM -0700, Alan Mikhak wrote:
> From: Alan Mikhak <alan.mikhak@sifive.com>
> 
> Modify pci_epf_test_init_dma_chan() to call dma_request_channel() with a
> filter function to pick DMA channel by name, if desired.
> 
> Add a new filter function pci_epf_test_pick_dma_chan() which takes a name
> string as an optional parameter. If desired name is specified, the filter
> function checks the name of each DMA channel candidate against the desired
> name. If no match, the filter function rejects the candidate channel.
> Otherwise, the candidate channel is accepted. If optional name parameter
> is null or an empty string, filter function picks the first DMA channel
> candidate, thereby preserving the existing behavior of pci-epf-test.
> 
> Currently, pci-epf-test picks the first suitable DMA channel. Adding a
> filter function enables a developer to modify the optional parameter
> during debugging by providing the name of a desired DMA channel. This is
> useful during debugging because it allows different DMA channels to be
> exercised.
> 
> Adding a filter function also takes one step toward modifying pcitest to
> allow the user to choose a DMA channel by providing a name string at the
> command line when issuing the -d parameter for DMA transfers.

This mostly looks fine, but needs to be part of a series giving it a 
user.

> Signed-off-by: Alan Mikhak <alan.mikhak@sifive.com>
> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 60330f3e3751..043916d3ab5f 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -149,10 +149,26 @@ static int pci_epf_test_data_transfer(struct pci_epf_test *epf_test,
>  }
>  
>  /**
> - * pci_epf_test_init_dma_chan() - Function to initialize EPF test DMA channel
> - * @epf_test: the EPF test device that performs data transfer operation
> + * pci_epf_test_pick_dma_chan() - Filter DMA channel based on desired criteria
> + * @chan: the DMA channel to examine
>   *
> - * Function to initialize EPF test DMA channel.
> + * Filter DMA channel candidates by matching against an optional desired name.
> + * Pick first candidate channel if desired name is not specified.
> + * Reject candidate channel if its name does not match the desired name.
> + */
> +static bool pci_epf_test_pick_dma_chan(struct dma_chan *chan, void *name)
> +{
> +	if (name && strlen(name) && strcmp(dma_chan_name(chan), name))

Doesn't this cause warning with 'name' being void*?


> +		return false;
> +
> +	return true;
> +}
> +
> +/**
> + * pci_epf_test_init_dma_chan() - Helper to initialize EPF DMA channel
> + * @epf: the EPF device that has to perform the data transfer operation
> + *
> + * Helper to initialize EPF DMA channel.
>   */
>  static int pci_epf_test_init_dma_chan(struct pci_epf_test *epf_test)
>  {
> @@ -165,7 +181,7 @@ static int pci_epf_test_init_dma_chan(struct pci_epf_test *epf_test)
>  	dma_cap_zero(mask);
>  	dma_cap_set(DMA_MEMCPY, mask);
>  
> -	dma_chan = dma_request_chan_by_mask(&mask);
> +	dma_chan = dma_request_channel(mask, pci_epf_test_pick_dma_chan, NULL);
>  	if (IS_ERR(dma_chan)) {
>  		ret = PTR_ERR(dma_chan);
>  		if (ret != -EPROBE_DEFER)
> -- 
> 2.7.4
> 
