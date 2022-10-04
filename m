Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3B05F4B2C
	for <lists+linux-pci@lfdr.de>; Tue,  4 Oct 2022 23:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiJDVvC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Oct 2022 17:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiJDVvB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Oct 2022 17:51:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839473642B;
        Tue,  4 Oct 2022 14:51:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B35E61514;
        Tue,  4 Oct 2022 21:51:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B6BEC433C1;
        Tue,  4 Oct 2022 21:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664920259;
        bh=6boUdhJngz/cXDcozyutWrj0ul8v1+j8KBsEbBhdJ8c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bJMyBFBK5upyLNQ6AL/7utlLnwZvpbEXnmbgOX9tzrJFX6Fnv6wtRLLbnE30XMfCV
         49x1xwg5TtAsvN+N1g0JCykz0ROGyrWk2natizRqWLedf42Dm3x5euiaya1HvYBr6M
         ZuIZNWARGGBcYXFahgu/xf0GH7sdNAKKSVGysS+qnXbs2OnuhnK7kiMVWVJg5Tu5mW
         t/l+4v3ztcz2/grzSa4aCh4cyMjt751lL5J6+Afyvt1mPApDH4LRTOvzI3r/2MzD6P
         Ug85FqJciJbwzmOsvPWvAGcD8nWuiMM+JFyehDOEl3ep7CEFRQ8IFJsapX53ssIzlI
         FOwj1ITDmhmvA==
Received: by mail-vk1-f178.google.com with SMTP id w19so1128113vkm.3;
        Tue, 04 Oct 2022 14:50:59 -0700 (PDT)
X-Gm-Message-State: ACrzQf0pii738KhykggDOQs+XHy/KMIbKVjbArEXTyfDb6WWdaEFUOza
        cPgik5JbQmZFOTTcCc1mLEegio9SMrBVfT4JdA==
X-Google-Smtp-Source: AMsMyM5k1UcSbUyFyaAh6XpxFNX3CnpVl20p///vTw93Ej31fIyVeKGKbFs1a1aqQHwYz3nZoql2XDGaDcmh1D6Jpv8=
X-Received: by 2002:a1f:9e44:0:b0:39e:e4ff:1622 with SMTP id
 h65-20020a1f9e44000000b0039ee4ff1622mr12561716vke.15.1664920258513; Tue, 04
 Oct 2022 14:50:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220919143123.28250-1-vidyas@nvidia.com> <20220926111923.22487-1-vidyas@nvidia.com>
In-Reply-To: <20220926111923.22487-1-vidyas@nvidia.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 4 Oct 2022 16:50:48 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ1qLC7zEL=hhgvsdimgcxxkPhN9LCJy3DnYZ8K8LJkLQ@mail.gmail.com>
Message-ID: <CAL_JsqJ1qLC7zEL=hhgvsdimgcxxkPhN9LCJy3DnYZ8K8LJkLQ@mail.gmail.com>
Subject: Re: [PATCH V2] PCI: dwc: Fix n_fts[] array overrun
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 26, 2022 at 6:19 AM Vidya Sagar <vidyas@nvidia.com> wrote:
>
> commit aeaa0bfe89654 ("PCI: dwc: Move N_FTS setup to common setup")
> incorrectly uses pci->link_gen in deriving the index to the
> n_fts[] array also introducing the issue of accessing beyond the
> boundaries of array for greater than Gen-2 speeds. This change fixes
> that issue.
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

Reviewed-by: Rob Herring <robh@kernel.org>
