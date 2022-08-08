Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D69C58CD0E
	for <lists+linux-pci@lfdr.de>; Mon,  8 Aug 2022 19:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243532AbiHHRv2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Aug 2022 13:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243784AbiHHRv0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Aug 2022 13:51:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BF3AE53;
        Mon,  8 Aug 2022 10:51:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E3A46117C;
        Mon,  8 Aug 2022 17:51:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E904C433C1;
        Mon,  8 Aug 2022 17:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659981084;
        bh=vTbGYaylM7shGWl1jQ9xdtmFNsKG4CvmKO/ubi157C0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=dqNfP+jXwKsui2Zs2v09N7U78wd7FfV5TDKqTgWx0grCbSJy7jkWeTDQMWY9rcz3A
         UBp/gOe1y4ZftYr0oLIZIM+ls0XupoMKShhfpaM5t/GoUzVHu2uBIF8fX9w0EqwrmM
         i6w8i8GwrUs8NjslAhQZ3zrk1TsHEA5F/PJmPUV0WxpE3iTVaaoYFxIOTfYf8opA6j
         svWWpRI3shmPRdO/gFETjTGhrLO7s2K4A8sLzJL4nNNWXPmUba/EVIrFGg5L/lfwen
         8JuuRFH8gmCg+6/jgT/QkTtTFS+IbFPWjqj6p+dghD56HWLbaxM07ZhW7Ck+yK2ClV
         +d5FVdddhhiUw==
Date:   Mon, 8 Aug 2022 12:51:22 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, pmladek@suse.com,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v5 27/32] PCI/P2PDMA: Convert to printbuf
Message-ID: <20220808175122.GA1215280@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220808024128.3219082-28-willy@infradead.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 08, 2022 at 03:41:23AM +0100, Matthew Wilcox (Oracle) wrote:
> From: Kent Overstreet <kent.overstreet@gmail.com>
> 
> This converts from seq_buf to printbuf. We're using printbuf in external
> buffer mode, so it's a direct conversion, aside from some trivial
> refactoring in cpu_show_meltdown() to make the code more consistent.

I don't object to the patch, but it would be nice if the commit log
hinted at what the advantage is.  I assume it's faster/safer/better in
some way, but I have no idea what.

Also, cpu_show_meltdown() doesn't appear in this patch, so maybe
that's relevant to some other patch but not this one?

> Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
> Cc: linux-pci@vger.kernel.org
> ---
>  drivers/pci/p2pdma.c | 21 ++++++++-------------
>  1 file changed, 8 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index 4496a7c5c478..8e29e7cabad3 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -18,7 +18,7 @@
>  #include <linux/memremap.h>
>  #include <linux/percpu-refcount.h>
>  #include <linux/random.h>
> -#include <linux/seq_buf.h>
> +#include <linux/printbuf.h>
>  #include <linux/xarray.h>
>  
>  struct pci_p2pdma {
> @@ -275,12 +275,9 @@ static int pci_bridge_has_acs_redir(struct pci_dev *pdev)
>  	return 0;
>  }
>  
> -static void seq_buf_print_bus_devfn(struct seq_buf *buf, struct pci_dev *pdev)
> +static void prt_bus_devfn(struct printbuf *buf, struct pci_dev *pdev)
>  {
> -	if (!buf)
> -		return;
> -
> -	seq_buf_printf(buf, "%s;", pci_name(pdev));
> +	prt_printf(buf, "%s;", pci_name(pdev));
>  }
>  
>  static bool cpu_supports_p2pdma(void)
> @@ -454,13 +451,11 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
>  	struct pci_dev *a = provider, *b = client, *bb;
>  	bool acs_redirects = false;
>  	struct pci_p2pdma *p2pdma;
> -	struct seq_buf acs_list;
>  	int acs_cnt = 0;
>  	int dist_a = 0;
>  	int dist_b = 0;
>  	char buf[128];
> -
> -	seq_buf_init(&acs_list, buf, sizeof(buf));
> +	struct printbuf acs_list = PRINTBUF_EXTERN(buf, sizeof(buf));
>  
>  	/*
>  	 * Note, we don't need to take references to devices returned by
> @@ -471,7 +466,7 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
>  		dist_b = 0;
>  
>  		if (pci_bridge_has_acs_redir(a)) {
> -			seq_buf_print_bus_devfn(&acs_list, a);
> +			prt_bus_devfn(&acs_list, a);
>  			acs_cnt++;
>  		}
>  
> @@ -500,7 +495,7 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
>  			break;
>  
>  		if (pci_bridge_has_acs_redir(bb)) {
> -			seq_buf_print_bus_devfn(&acs_list, bb);
> +			prt_bus_devfn(&acs_list, bb);
>  			acs_cnt++;
>  		}
>  
> @@ -515,11 +510,11 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
>  	}
>  
>  	if (verbose) {
> -		acs_list.buffer[acs_list.len-1] = 0; /* drop final semicolon */
> +		acs_list.buf[acs_list.pos-1] = 0; /* drop final semicolon */
>  		pci_warn(client, "ACS redirect is set between the client and provider (%s)\n",
>  			 pci_name(provider));
>  		pci_warn(client, "to disable ACS redirect for this path, add the kernel parameter: pci=disable_acs_redir=%s\n",
> -			 acs_list.buffer);
> +			 acs_list.buf);
>  	}
>  	acs_redirects = true;
>  
> -- 
> 2.35.1
> 
