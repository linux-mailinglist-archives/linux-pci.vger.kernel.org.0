Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC0E274DB5D
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jul 2023 18:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjGJQp2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Jul 2023 12:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjGJQp1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Jul 2023 12:45:27 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5FFE3
        for <linux-pci@vger.kernel.org>; Mon, 10 Jul 2023 09:45:27 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b9de2bd0abso6523705ad.0
        for <linux-pci@vger.kernel.org>; Mon, 10 Jul 2023 09:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689007526; x=1691599526;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vu7Yg8GYxufqJqFeQd4o+bg5ETHogrH2FQCB/fqooZM=;
        b=VwmX7QhSu+2TpyagprnG2hJwT0tRcLctUxBwm/O22zd3G1I9PLArZ5Ui+/7urncOL7
         BPOHNTnmRbzSvq6axv7mdadK5l6fZ/DnliIPpZoSOGuJkZpGaqW0t17OxmmSspXM9L+s
         gZlGWB0mx3VuyogIxC6J8DKr9kjm+c/g+WdghlU2Ra+Tt9giK5dLZ9BtxBEwhX1T3Z8B
         X1nVOODieDzi7IYczJlni5VJtwnwfaqW2Q4RUXTN96iQ83wIGHHRMXaSQjv2jwEFGa9F
         Agql9lCyPQqpqsEoupCp4C5GtTrX15gzTMweRy9Yv43csWm0i9FJ59Yzo4c5gjZ45bUO
         3WWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689007526; x=1691599526;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vu7Yg8GYxufqJqFeQd4o+bg5ETHogrH2FQCB/fqooZM=;
        b=UzkRz8i4I8lZnIUITdIooIWa9THdSukCpP123XqPrRKL1J4fwhDg7HlrA5VNnFbqKD
         DEiYAuezHlOtMleYB6spynk9pPSgicI97erDGeVqQgCYbYl6YMttlUcmqzqap1apZXiy
         VBUxBCIjCTk7BwW7jn8acBDTJMX3GCy1r8nyA9+pPRNkrxXFdc3zJcpWI9GFvkIxdNfq
         2NdgBhr7gdhGzLskuM2OK5F1bVajjq+8HAmbqLwrD0UtaX4Nvc17Xh/dWqX7CSoDvfXW
         QLwaEPXfqpKy+sD5Igm1nYfMEMEbwFbnx1aP/+6mIUk4zumAPBfWcqBisTCdXOIKk/dE
         IvZg==
X-Gm-Message-State: ABy/qLZnbEOvZMWmt4P/hIvXHUbcxkvya6IbLVyx89H0uJHI1s7Ufxr1
        +YG3t5KHkKCdgUBXtRl7sB+CTg==
X-Google-Smtp-Source: APBJJlEwR1ZV4gaRO46xx3MaWPZZeOqiReQnSp8KxK0uTHKCKyyrwuEhdaqZds20wYBN3lIuMDCzPA==
X-Received: by 2002:a17:902:b713:b0:1b2:a63:9587 with SMTP id d19-20020a170902b71300b001b20a639587mr9307898pls.36.1689007526394;
        Mon, 10 Jul 2023 09:45:26 -0700 (PDT)
Received: from google.com (41.183.143.34.bc.googleusercontent.com. [34.143.183.41])
        by smtp.gmail.com with ESMTPSA id i6-20020a170902eb4600b001b7ebb6a2d4sm118123pli.163.2023.07.10.09.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 09:45:26 -0700 (PDT)
Date:   Mon, 10 Jul 2023 22:15:16 +0530
From:   Ajay Agarwal <ajayagarwal@google.com>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     bhelgaas@google.com, robh@kernel.org, lpieralisi@kernel.org,
        hongxing.zhu@nxp.com, broonie@kernel.org,
        linux-pci@vger.kernel.org, kw@linux.com,
        gustavo.pimentel@synopsys.com, jingoohan1@gmail.com,
        sdalvi@google.com, Fabio Estevam <festevam@denx.de>
Subject: Re: [PATCH] PCI: dwc: Do not fail to probe when link is down
Message-ID: <ZKw1nLF72/vg2rln@google.com>
References: <20230704122635.1362156-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704122635.1362156-1-festevam@gmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 04, 2023 at 09:26:35AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
> 
> Since commit da56a1bfbab5 ("PCI: dwc: Wait for link up only if link is
> started") the following probe error is observed when the PCI link is down:
> 
> imx6q-pcie 33800000.pcie: Phy link never came up
> imx6q-pcie: probe of 33800000.pcie failed with error -110
> 
> The intention of commit 886a9c134755 ("PCI: dwc: Move link handling into
> common code") was to standardize the behavior of link down as explained
> in its commit log:
>     
> "The behavior for a link down was inconsistent as some drivers would fail
> probe in that case while others succeed. Let's standardize this to
> succeed as there are usecases where devices (and the link) appear later
> even without hotplug. For example, a reconfigured FPGA device."
> 
> Restore the original behavior by ignoring the error from
> dw_pcie_wait_for_link().
> 
> Fixes: da56a1bfbab5 ("PCI: dwc: Wait for link up only if link is started")
> Signed-off-by: Fabio Estevam <festevam@denx.de>
Reviewed-by: Ajay Agarwal <ajayagarwal@google.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index cf61733bf78d..af6a7cd060b1 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -492,11 +492,8 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  		if (ret)
>  			goto err_remove_edma;
>  
> -		if (pci->ops && pci->ops->start_link) {
> -			ret = dw_pcie_wait_for_link(pci);
> -			if (ret)
> -				goto err_stop_link;
> -		}
> +		if (pci->ops && pci->ops->start_link)
> +			dw_pcie_wait_for_link(pci);
>  	}
>  
>  	bridge->sysdata = pp;
> -- 
> 2.34.1
> 
LGTM.
