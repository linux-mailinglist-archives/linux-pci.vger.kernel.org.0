Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D62C543E49
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jun 2022 23:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiFHVLz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jun 2022 17:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbiFHVLy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jun 2022 17:11:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776EB26F35A;
        Wed,  8 Jun 2022 14:11:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D9602B82AD5;
        Wed,  8 Jun 2022 21:11:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F4FEC34116;
        Wed,  8 Jun 2022 21:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654722709;
        bh=yo554qkp9+ViKsGeMVX9p0hmZuzPmMJGU71zlQIJowI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=nE1Q+x7KOWBHR9+6CXhNUxheYB5/5aFVs0h9at3qphZkCb/VXdUSbx0jg1eUQVhFM
         EMj3QRk9wCMw8XvRty/5e/H9vrBsdIv25GHKaNJJHezKMl2+6eXUrNqxfaEsuwQX9N
         9TL12mZzw47uJ6duTLIDtadpnIMl9VS+Fq5P2rNrnTct5KEgC9zwvUIchH70pTjMLd
         65MBRNgwgdZ2gbhg729RGIHreQR/61EN59V7tL+NGNXZumMDGBQFbzGdIxYijurc2T
         rDprAsl3Tf45wFrBtFK1LJpRduMbFx+szI5AjIj81JQJjYSQ6b6n2ptU1SKbSJq0GH
         LbuH0CmtsFCLA==
Date:   Wed, 8 Jun 2022 16:11:46 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     linux-kernel@vger.kernel.org, pmladek@suse.com,
        rostedt@goodmis.org, linux-pci@vger.kernel.org,
        Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v3 29/33] PCI/P2PDMA: Convert to printbuf
Message-ID: <20220608211146.GA422296@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220604193042.1674951-30-kent.overstreet@gmail.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Logan, maintainer of p2pdma.c]

On Sat, Jun 04, 2022 at 03:30:38PM -0400, Kent Overstreet wrote:
> This converts from seq_buf to printbuf. We're using printbuf in external
> buffer mode, so it's a direct conversion, aside from some trivial
> refactoring in cpu_show_meltdown() to make the code more consistent.

cpu_show_meltdown() doesn't appear in p2pdma.c.  Leftover from another
patch?  Maybe from 27/33 ("powerpc: Convert to printbuf")?

I'm not opposed to this, but it would be nice to say what the benefit
is.  How is printbuf better than seq_buf?  It's not obvious from the
patch how this is better/safer/shorter/etc.

Even the cover letter [1] is not very clear about the benefit.  Yes, I
see it has something to do with improving buffer management, and I
know from experience that's a pain.  Concrete examples of typical
printbuf usage and bugs that printbufs avoid would be helpful.

I guess "external buffer mode" means we use an existing buffer (on the
stack in this case) instead of allocating a buffer from the heap [2]?
And we do that for performance (i.e., we know the max size) and to
avoid sleeping to alloc?

Are there any other printf-type things in drivers/pci that
could/should be converted?  Is this basically a seq_buf replacement,
so we can find everything with "git grep seq_buf drivers/pci/"?

[1] https://lore.kernel.org/all/20220604193042.1674951-1-kent.overstreet@gmail.com/
[2] https://lore.kernel.org/all/20220604193042.1674951-8-kent.overstreet@gmail.com/

> Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
> Cc: linux-pci@vger.kernel.org
> ---
>  drivers/pci/p2pdma.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index 30b1df3c9d..c40d91912a 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -17,7 +17,7 @@
>  #include <linux/memremap.h>
>  #include <linux/percpu-refcount.h>
>  #include <linux/random.h>
> -#include <linux/seq_buf.h>
> +#include <linux/printbuf.h>
>  #include <linux/xarray.h>
>  
>  enum pci_p2pdma_map_type {
> @@ -281,12 +281,9 @@ static int pci_bridge_has_acs_redir(struct pci_dev *pdev)
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
> @@ -455,13 +452,11 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
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
> @@ -472,7 +467,7 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
>  		dist_b = 0;
>  
>  		if (pci_bridge_has_acs_redir(a)) {
> -			seq_buf_print_bus_devfn(&acs_list, a);
> +			prt_bus_devfn(&acs_list, a);
>  			acs_cnt++;
>  		}
>  
> @@ -501,7 +496,7 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
>  			break;
>  
>  		if (pci_bridge_has_acs_redir(bb)) {
> -			seq_buf_print_bus_devfn(&acs_list, bb);
> +			prt_bus_devfn(&acs_list, bb);
>  			acs_cnt++;
>  		}
>  
> -- 
> 2.36.0
> 
