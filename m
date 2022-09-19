Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 362955BD4F5
	for <lists+linux-pci@lfdr.de>; Mon, 19 Sep 2022 20:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbiISSzt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Sep 2022 14:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiISSzt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Sep 2022 14:55:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536853206E;
        Mon, 19 Sep 2022 11:55:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB11661645;
        Mon, 19 Sep 2022 18:55:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F31F2C433C1;
        Mon, 19 Sep 2022 18:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663613747;
        bh=fxrYj+SlLB8t+pk8TjlywB7jE7G0jb9b3YEkADAG/Ec=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=OixGiX1zzOPN6mg3SiNe/k4cJRLOWMGwkieahZOLsfsrCkX4AX8ynTYtSeFmCP1YV
         ULh+5dCXo7x8HesmJd+khwvtQjWAazHTShDy8f39YCgtl/rRW5L4V6l2mruz8EHihR
         xsL5+HdBLLodjHVIqj2Wn3ae4Nq4olM2qX1YIjcab6vtMlplW3esnBDffyLnqE0BIj
         MrtPpt5o+Vs60Lf3i/hQh5WJ9AVw/RDuHdKNsb5nfzRrjqbhLf0d+l9UmbvdWJCrJw
         Q4A5+O2yy+Tc3OZj7V+NceumqmbVeFkaESP36M36Q0dDPj/+s7Uz3W3LCP17QYSiC1
         43xrkM7aciy5A==
Date:   Mon, 19 Sep 2022 13:55:45 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Shunsuke Mie <mie@igel.co.jp>
Cc:     Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, ntb@lists.linux.dev,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: pci-epf-{,v}ntb: fix a check for no epc
 alignment constraint
Message-ID: <20220919185545.GA1022691@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220916075651.64957-1-mie@igel.co.jp>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 16, 2022 at 04:56:51PM +0900, Shunsuke Mie wrote:
> Some pci endpoint controllers has not alignment constraint, and the

s/pci/PCI/
s/has not/have no/
s/constraint/constraints/

> epc_features->align becomes 0. In this case, IS_ALIGNED() in
> epf_ntb_config_spad_bar_alloc() doesn't work well. So this patch adds the 0
> checking before the IS_ALIGNED().

s/So this patch adds .../Check for this before IS_ALIGNED()/

> Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
> ---
>  drivers/pci/endpoint/functions/pci-epf-ntb.c  | 2 +-
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-ntb.c b/drivers/pci/endpoint/functions/pci-epf-ntb.c
> index 9a00448c7e61..f74155ee8d72 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-ntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-ntb.c
> @@ -1021,7 +1021,7 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb,
>  	peer_size = peer_epc_features->bar_fixed_size[peer_barno];
>  
>  	/* Check if epc_features is populated incorrectly */
> -	if ((!IS_ALIGNED(size, align)))
> +	if (align && (!IS_ALIGNED(size, align)))
>  		return -EINVAL;
>  
>  	spad_count = ntb->spad_count;
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index 0ea85e1d292e..5e346c0a0f05 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -418,7 +418,7 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
>  	size = epc_features->bar_fixed_size[barno];
>  	align = epc_features->align;
>  
> -	if ((!IS_ALIGNED(size, align)))
> +	if (align && !IS_ALIGNED(size, align))
>  		return -EINVAL;
>  
>  	spad_count = ntb->spad_count;
> -- 
> 2.17.1
> 
