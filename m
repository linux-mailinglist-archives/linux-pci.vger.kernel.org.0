Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35EC2725003
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jun 2023 00:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239219AbjFFWhw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Jun 2023 18:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240075AbjFFWhc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Jun 2023 18:37:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C97172E;
        Tue,  6 Jun 2023 15:36:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3AFF1638A4;
        Tue,  6 Jun 2023 22:36:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69DD6C433EF;
        Tue,  6 Jun 2023 22:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686090975;
        bh=BooVQxUHoch08PI32IhTPEi6alvADV2vunjk76rkxVA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=GuGJPVi6pknz+WmZETWPSVs6G7l/ERhlSrTmFt6D6rc2/zc2lDxdZg/lpeicXpsKH
         2kfWo/7Vj28EjMfQTBIQNXILm4go9ZnNqUuTs7nbqe3PwrpXyoZmrzLHmJATq/Yotd
         a75H9JfhkvFBMfvh9HCJOG/UQLDJDNvqj/OfPSHg5pxdCzHtRnaloDi1gW2RE8jQs1
         WmTw/cqsnrE8aNz/NQayXuJPa1TefyQj6dufrCMNIn4C7306XpomcLnBNzbbh0uT4/
         7XaM/vtRuGD4zrbwVi1wfYw7Yij1JrwcgdX8m27HBGqlHfNRICGDjksOMunFd5bSjb
         jp5fa/ki+eMDQ==
Date:   Tue, 6 Jun 2023 17:36:13 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ross Lagerwall <ross.lagerwall@citrix.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Release coalesced resource
Message-ID: <20230606223613.GA1147805@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230525153248.712779-1-ross.lagerwall@citrix.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 25, 2023 at 04:32:48PM +0100, Ross Lagerwall wrote:
> When contiguous windows are coalesced, the resource is invalidated and
> consequently not added to the bus. However, it remains in the resource
> hierarchy:
> 
> ...
>   ef2fff00-ef2fffff : 0000:00:13.2
>     ef2fff00-ef2fffff : ehci_hcd
> 00000000-00000000 : PCI Bus 0000:00
> f0000000-f3ffffff : PCI MMCONFIG 0000 [bus 00-3f]
>   f0000000-f3ffffff : Reserved
> ...

I assume the "00000000-00000000 : PCI Bus 0000:00" is the problematic
part?  Is there anything in dmesg that shows the resources before they
were coalesced?

Is there an error message we could include here to link the problem
with the solution?

> In some cases (e.g. the Xen scratch region), this causes future calls to
> allocate_resource() to choose an inappropriate location which the caller
> cannot handle. Fix by releasing the resource and removing from the
> hierarchy.
> 
> Fixes: 7c3855c423b1 ("PCI: Coalesce host bridge contiguous apertures")

7c3855c423b1 appeared in v5.16, so we may need a stable tag?

> Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
> ---
>  drivers/pci/probe.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 0b2826c4a832..00ed20ac0dd6 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -997,8 +997,10 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
>  	resource_list_for_each_entry_safe(window, n, &resources) {
>  		offset = window->offset;
>  		res = window->res;
> -		if (!res->flags && !res->start && !res->end)
> +		if (!res->flags && !res->start && !res->end) {
> +			release_resource(res);
>  			continue;
> +		}
>  
>  		list_move_tail(&window->node, &bridge->windows);
>  
> -- 
> 2.31.1
> 
