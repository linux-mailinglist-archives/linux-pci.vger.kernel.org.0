Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC67B5EAF89
	for <lists+linux-pci@lfdr.de>; Mon, 26 Sep 2022 20:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbiIZSVM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Sep 2022 14:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbiIZSU5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Sep 2022 14:20:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47CC14087;
        Mon, 26 Sep 2022 11:16:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 81EEBB80C72;
        Mon, 26 Sep 2022 18:16:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03CC1C433D6;
        Mon, 26 Sep 2022 18:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664216171;
        bh=DvgCiCK329fTQGj9gebY5EY55cLmgK8o5RPjgImGuwM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Sf95KlUwr0s3QhAzUP+UxZ7LchvJbvi8y14ND8Zw+M801b+p695Zct5qoOoOm49p2
         kiGnHok2kLsm5U+azqJ5WsRkNLeZayKXl/8AOnEIBVhKmBSuPYRHA8oEVHqZWiExY9
         6/Mie8DOdk0mSZskxsERxX5TR9KfNysR0AvoUxCU/o0B8390wf+XN10u5/gInHsW9p
         IkS4vWLNPGVdjTaUfl4Tgi7OsaRffFL+mH4g7iiSshw5R3nK7yyKJHuaSsRiKxPFt3
         TF3E9wYA3ChhQ3rRvT++MnlVMu6m5Qm6ryjbkHAW6c1s89zf38Sxaim9fQh4ol/JsG
         uzD8G/QCdnOFQ==
Date:   Mon, 26 Sep 2022 13:16:09 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     lpieralisi@kernel.org, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, kishon@ti.com, vkoul@kernel.org,
        mani@kernel.org, Sergey.Semin@baikalelectronics.ru,
        ffclaire1224@gmail.com, linux-pci@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V2 6/9] PCI: tegra194: Refactor LTSSM state polling on
 surprise down
Message-ID: <20220926181609.GA1612301@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220926115038.24727-7-vidyas@nvidia.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 26, 2022 at 05:20:35PM +0530, Vidya Sagar wrote:
> On surprise down LTSSM state transisition from L0 -> Recovery.RcvrLock ->
> Recovery.RcvrSpeed -> Gen1 Recovery.RcvrLock -> Detect.
> Recovery.RcvrLock and Recovery.RcvrSpeed time is 24 msec and 48 msec
> respectively. It takes ~96 msec to move from L0 to detect state, hence,
> increase the poll time to 120 msec. Disable the LTSSM state after it moves
> to detect to avoid LTSSM toggle between polling and detect.

s/transisition/transition/

>  		err = readl_poll_timeout_atomic(pcie->appl_base + APPL_DEBUG,
>  						data,
>  						((data &
> -						APPL_DEBUG_LTSSM_STATE_MASK) >>
> -						APPL_DEBUG_LTSSM_STATE_SHIFT) ==
> -						LTSSM_STATE_PRE_DETECT,
> -						1, LTSSM_TIMEOUT);
> +						APPL_DEBUG_LTSSM_STATE_MASK) ==
> +						LTSSM_STATE_DETECT_QUIET) ||
> +						((data &
> +						APPL_DEBUG_LTSSM_STATE_MASK) ==
> +						LTSSM_STATE_DETECT_ACT) ||
> +						((data &
> +						APPL_DEBUG_LTSSM_STATE_MASK) ==
> +						LTSSM_STATE_PRE_DETECT_QUIET) ||
> +						((data &
> +						APPL_DEBUG_LTSSM_STATE_MASK) ==
> +						LTSSM_STATE_DETECT_WAIT),
> +						LTSSM_DELAY, LTSSM_TIMEOUT);

I know we usually line up the function parameters with that opening
paren, but I think overall it would be nicer to drop a couple of the
leading tabs so these don't wrap so awkwardly.

> +	ret = readl_poll_timeout(pcie->appl_base + APPL_DEBUG, val,
> +				 ((val & APPL_DEBUG_LTSSM_STATE_MASK) ==
> +				 LTSSM_STATE_DETECT_QUIET) ||
> +				 ((val & APPL_DEBUG_LTSSM_STATE_MASK) ==
> +				 LTSSM_STATE_DETECT_ACT) ||
> +				 ((val & APPL_DEBUG_LTSSM_STATE_MASK) ==
> +				 LTSSM_STATE_PRE_DETECT_QUIET) ||
> +				 ((val & APPL_DEBUG_LTSSM_STATE_MASK) ==
> +				 LTSSM_STATE_DETECT_WAIT) ||
> +				 ((val & APPL_DEBUG_LTSSM_STATE_MASK) ==
> +				 LTSSM_STATE_L2_IDLE),
> +				 LTSSM_DELAY, LTSSM_TIMEOUT);

Ditto.
