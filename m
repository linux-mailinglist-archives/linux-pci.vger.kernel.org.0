Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89C8A5EEB69
	for <lists+linux-pci@lfdr.de>; Thu, 29 Sep 2022 04:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbiI2CFE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Sep 2022 22:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234212AbiI2CFB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Sep 2022 22:05:01 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195EDEF0BB;
        Wed, 28 Sep 2022 19:04:57 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id hy2so30642534ejc.8;
        Wed, 28 Sep 2022 19:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=v56R6ozn9q0ShnaO5327dkMUaY03iBdWNwkUdp5+pNU=;
        b=Vr/vfiNFyosA7T3lBgXmweMqBqifds0+z/yursP4mblTuxS2iWuoRjLyZOpugFMVVF
         Fb1a7PnwyFndyXGYodG2VGbo2lzIy4Ea2jb5WL3CXvK4PaZNXfrJCQbekiw8QUIDDcgN
         6UTZjw1Lmgy6AvFsn7ATkSEs6jK79zG1Srf7Ewb20IanGWi2IPlnUrHVKfXMS+Hivjt3
         0PHF25UM2N+WKlK74SuytVDuyhJPDFrPzhHdcVa0IknuErFzF0mTOZLWyt1/vRZvT7t9
         abcXCDVYmILIoRr6KYbr3HLaITVeHFE9RArElhBadESrQHU/AoGcvOyYPhXX5leKyEWC
         3juw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=v56R6ozn9q0ShnaO5327dkMUaY03iBdWNwkUdp5+pNU=;
        b=Bw5bvnRQ1Fw3k6Y1Ebxfy0svegulEz0fv0vTwhc7Tn7FgLXefH6oOg+bo8iEgVSmMV
         DiVwZzwyWda/oRohFmKTTpLoBZoCN5tTIkaThT+dP2bGb1GFLHc+XPVNukgCqszPCVH7
         TL6WGJY93x7TX00pytNlMavV0uGlGapn9VzMBWFJD1lggvXo6hPB/2S03neXYuyO1p+r
         KGhgr5y6uBWlTaLzTHectecuTYbOsPFyb3AtuTZJu7ckCkXI9M6uEVjTGqGaShTCAGqd
         16CL7BMy4+8vEIlt5n5OkjNsJmxt7JNgPt1fINSVvoZJhQ2Uppm2vOlcq7F5yspWU++x
         Qtlw==
X-Gm-Message-State: ACrzQf01JznTKMClWdZG/PtHsjgWhYHq3H5TxadOwdxI39yCv/FnHzBQ
        zEUTCkYP2zCw7YRJVHR8/wQl/M7r6ccGlbh/r0A=
X-Google-Smtp-Source: AMsMyM5Io3rpFF/Gqd9iUXJ4k6i1pcFJCGiBIYhHZ+OQ5eyMvTiNJdZb3Vv8mCGqC9lOuz0LVQ4ghpud0yUey6JWOtU=
X-Received: by 2002:a17:907:270b:b0:77b:17b3:f446 with SMTP id
 w11-20020a170907270b00b0077b17b3f446mr658557ejk.415.1664417095783; Wed, 28
 Sep 2022 19:04:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220919143123.28250-1-vidyas@nvidia.com> <20220926111923.22487-1-vidyas@nvidia.com>
In-Reply-To: <20220926111923.22487-1-vidyas@nvidia.com>
From:   Han Jingoo <jingoohan1@gmail.com>
Date:   Wed, 28 Sep 2022 19:04:44 -0700
Message-ID: <CAPOBaE5X8iUTQW5QqTKFN78U=jnVvCzCj2mb4HG5S4uxBaCN1Q@mail.gmail.com>
Subject: Re: [PATCH V2] PCI: dwc: Fix n_fts[] array overrun
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     gustavo.pimentel@synopsys.com, lpieralisi@kernel.org,
        robh@kernel.org, kw@linux.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 26, 2022, Vidya Sagar <vidyas@nvidia.com> wrote:
>
> commit aeaa0bfe89654 ("PCI: dwc: Move N_FTS setup to common setup")
> incorrectly uses pci->link_gen in deriving the index to the
> n_fts[] array also introducing the issue of accessing beyond the
> boundaries of array for greater than Gen-2 speeds. This change fixes
> that issue.

Dear Vidya,

I am just ok with this patch. By the way, do we need another patch to generalize
this setting? Currently, this code targets only Gen1 and Gen2. But, in
my opinion,
it is possible that this driver can be  used for more than Gen2,
later. PCIe Gen6
standard is available and Synopsys has their solution for Gen6. So, would you
send a new patch to generalize this thing, later?
Thank you.

Best regards,
Jingoo Han

>
> Fixes: aeaa0bfe8965 ("PCI: dwc: Move N_FTS setup to common setup")
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> Acked-by: Jingoo Han <jingoohan1@gmail.com>
> ---
> V2:
> * Addressed review comments from Bjorn
> * Added "Acked-by: Jingoo Han <jingoohan1@gmail.com>"
>
>  drivers/pci/controller/dwc/pcie-designware.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 650a7f22f9d0..3df687667f27 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -649,7 +649,7 @@ void dw_pcie_setup(struct dw_pcie *pci)
>         if (pci->n_fts[1]) {
>                 val = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
>                 val &= ~PORT_LOGIC_N_FTS_MASK;
> -               val |= pci->n_fts[pci->link_gen - 1];
> +               val |= pci->n_fts[1];
>                 dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
>         }
>
> --
> 2.17.1
>
