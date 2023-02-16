Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B316991DA
	for <lists+linux-pci@lfdr.de>; Thu, 16 Feb 2023 11:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjBPKkc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Feb 2023 05:40:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbjBPKkb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Feb 2023 05:40:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1AC4C6F8
        for <linux-pci@vger.kernel.org>; Thu, 16 Feb 2023 02:40:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DEF9961F69
        for <linux-pci@vger.kernel.org>; Thu, 16 Feb 2023 10:39:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FDB4C433D2;
        Thu, 16 Feb 2023 10:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676543961;
        bh=K0fO68U4DWgFRKJOgoDkkujS0azyEvtD9aEbUF1PKvo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RPfz5uU3R7GZvoS8/xgh8OyaK9ghWMnGQfw6AsPkW2ILcIs2eHJ29K8HZ6aKiWXO2
         dl4GVwwdybdfmeQcAFyb353CaGcMUwKlyaXR/daUZBKqtbE6Kh9bLOolumMfZIDaxb
         YpG+ExUofNOquZzlyNFhx0VPSZJjP7+C9ufhGkpuCyJ6XsZnYHVy4cVkaYoXNypCew
         z6ICct71FHDEl4tOGXADs9eyi0rK9DM5Lz34/iTtZacnX0n6UQvDOBITZmvVe82okk
         0JkF+EQ9/whPpkp2LKV0Hjs8H4kAX3x5Ep4cph6lRfEzw6JCRseUEO1qAD2OZu9P6A
         pBmBa4QTWATtw==
Date:   Thu, 16 Feb 2023 16:09:08 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 06/12] pci: epf-test: Simplify transfers result print
Message-ID: <20230216103908.GH2420@thinkpad>
References: <20230215032155.74993-1-damien.lemoal@opensource.wdc.com>
 <20230215032155.74993-7-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230215032155.74993-7-damien.lemoal@opensource.wdc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 15, 2023 at 12:21:49PM +0900, Damien Le Moal wrote:
> In pci_epf_test_print_rate(), instead of open coding a reduction loop to
> allow for a disivision by a 32-bits ns value, simply use div64_u64() to
> calculate the rate. To match the printed unit of KB/s, this calculation
> divides the rate by 1000 instead of 1024 (that would be KiB/s unit).
> 
> The format of the results printed by pci_epf_test_print_rate() is also
> changed to be more compact without the double new line. dev_info() is
> used instead of pr_info().
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Thanks,
Mani

> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 42 ++++++++-----------
>  1 file changed, 17 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index e07868c99531..f630393e8208 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -297,34 +297,23 @@ static void pci_epf_test_clean_dma_chan(struct pci_epf_test *epf_test)
>  	return;
>  }
>  
> -static void pci_epf_test_print_rate(const char *ops, u64 size,
> +static void pci_epf_test_print_rate(struct pci_epf_test *epf_test,
> +				    const char *op, u64 size,
>  				    struct timespec64 *start,
>  				    struct timespec64 *end, bool dma)
>  {
> -	struct timespec64 ts;
> -	u64 rate, ns;
> -
> -	ts = timespec64_sub(*end, *start);
> -
> -	/* convert both size (stored in 'rate') and time in terms of 'ns' */
> -	ns = timespec64_to_ns(&ts);
> -	rate = size * NSEC_PER_SEC;
> -
> -	/* Divide both size (stored in 'rate') and ns by a common factor */
> -	while (ns > UINT_MAX) {
> -		rate >>= 1;
> -		ns >>= 1;
> -	}
> -
> -	if (!ns)
> -		return;
> +	struct timespec64 ts = timespec64_sub(*end, *start);
> +	u64 rate = 0, ns;
>  
>  	/* calculate the rate */
> -	do_div(rate, (uint32_t)ns);
> +	ns = timespec64_to_ns(&ts);
> +	if (ns)
> +		rate = div64_u64(size * NSEC_PER_SEC, ns * 1000);
>  
> -	pr_info("\n%s => Size: %llu bytes\t DMA: %s\t Time: %llu.%09u seconds\t"
> -		"Rate: %llu KB/s\n", ops, size, dma ? "YES" : "NO",
> -		(u64)ts.tv_sec, (u32)ts.tv_nsec, rate / 1024);
> +	dev_info(&epf_test->epf->dev,
> +		 "%s => Size: %llu B, DMA: %s, Time: %llu.%09u s, Rate: %llu KB/s\n",
> +		 op, size, dma ? "YES" : "NO",
> +		 (u64)ts.tv_sec, (u32)ts.tv_nsec, rate);
>  }
>  
>  static int pci_epf_test_copy(struct pci_epf_test *epf_test, bool use_dma)
> @@ -400,7 +389,8 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test, bool use_dma)
>  		kfree(buf);
>  	}
>  	ktime_get_ts64(&end);
> -	pci_epf_test_print_rate("COPY", reg->size, &start, &end, use_dma);
> +	pci_epf_test_print_rate(epf_test, "COPY", reg->size, &start, &end,
> +				use_dma);
>  
>  err_map_addr:
>  	pci_epc_unmap_addr(epc, epf->func_no, epf->vfunc_no, dst_phys_addr);
> @@ -481,7 +471,8 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test, bool use_dma)
>  		ktime_get_ts64(&end);
>  	}
>  
> -	pci_epf_test_print_rate("READ", reg->size, &start, &end, use_dma);
> +	pci_epf_test_print_rate(epf_test, "READ", reg->size, &start, &end,
> +				use_dma);
>  
>  	crc32 = crc32_le(~0, buf, reg->size);
>  	if (crc32 != reg->checksum)
> @@ -567,7 +558,8 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test, bool use_dma)
>  		ktime_get_ts64(&end);
>  	}
>  
> -	pci_epf_test_print_rate("WRITE", reg->size, &start, &end, use_dma);
> +	pci_epf_test_print_rate(epf_test, "WRITE", reg->size, &start, &end,
> +				use_dma);
>  
>  	/*
>  	 * wait 1ms inorder for the write to complete. Without this delay L3
> -- 
> 2.39.1
> 

-- 
மணிவண்ணன் சதாசிவம்
