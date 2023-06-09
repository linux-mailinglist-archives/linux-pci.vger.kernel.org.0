Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECB4672A581
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jun 2023 23:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbjFIVph (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Jun 2023 17:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbjFIVpg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Jun 2023 17:45:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC552210E;
        Fri,  9 Jun 2023 14:45:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80CC261009;
        Fri,  9 Jun 2023 21:45:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B11E0C433D2;
        Fri,  9 Jun 2023 21:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686347131;
        bh=w4Rko8t5NngLCBrPdmtaTBBcrrBr+GzCI1/lAM3v0Qw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=IcvoFCRto4D68U0l4/J3xDf8bWGm8p2VQz4fqfPOhyvqpcNtwc/71LXdk/ARlV1Cn
         Ks6c7CSkkb005FJZdwqCQJdOMoWwcwjNGh+Yj04Ht1s0zGj0XsoKMgnSh/D3fuUSE5
         5G+CrRcqQ8jNm94MgNYR9KN7QQmAGGnelpCUANoKpxAmLWQQwzIYmJhmL8n31wa41K
         K1U4ayxDFRDB6wcuAIVmcsOZmhH9zo318vKeyXAcUvAZXaOPEvartXJzhTebp57GyQ
         f4+G/XORFm4/h2owVzYOptwTFW1Syz16fLEXJy/fVFF0pwsgpmPPPq/ctDxZcfF8/X
         c0jKzYUxnrmFw==
Date:   Fri, 9 Jun 2023 16:45:30 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ross Lagerwall <ross.lagerwall@citrix.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Release coalesced resource
Message-ID: <20230609214530.GA1262596@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230525153248.712779-1-ross.lagerwall@citrix.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
> 
> In some cases (e.g. the Xen scratch region), this causes future calls to
> allocate_resource() to choose an inappropriate location which the caller
> cannot handle. Fix by releasing the resource and removing from the
> hierarchy.
> 
> Fixes: 7c3855c423b1 ("PCI: Coalesce host bridge contiguous apertures")
> Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>

Applied to pci/resource for v6.5 with the commit log updated as below,
thanks!

Please let me know if I missed something, which is quite possible
because I don't know how to make the example in the commit log above
fit with the example in [1]:

  fec00000-fec7ffff : PCI Bus 0000:00
    fec00000-fec003ff : IOAPIC 0
  fec80000-fecbffff : PCI Bus 0000:00
    fec80000-fec803ff : IOAPIC 1
    fec90000-fec93fff : pnp 00:06

But maybe that's just because they're from different systems or
something.

Bjorn

[1] https://lore.kernel.org/r/DM6PR03MB53722DA6DF0E5D4E43C40753F051A@DM6PR03MB5372.namprd03.prod.outlook.com

    PCI: Release resource invalidated by coalescing
    
    When contiguous windows are coalesced by pci_register_host_bridge(), the
    second resource is expanded to include the first, and the first is
    invalidated and consequently not added to the bus. However, it remains in
    the resource hierarchy.  For example, these windows:
    
      fec00000-fec7ffff : PCI Bus 0000:00
      fec80000-fecbffff : PCI Bus 0000:00
    
    are coalesced into this, where the first resource remains in the tree with
    start/end zeroed out:
    
      00000000-00000000 : PCI Bus 0000:00
      fec00000-fecbffff : PCI Bus 0000:00
    
    In some cases (e.g. the Xen scratch region), this causes future calls to
    allocate_resource() to choose an inappropriate location which the caller
    cannot handle.
    
    Fix by releasing the zeroed-out resource and removing it from the resource
    hierarchy.
    
    [bhelgaas: commit log]
    Fixes: 7c3855c423b1 ("PCI: Coalesce host bridge contiguous apertures")
    Link: https://lore.kernel.org/r/20230525153248.712779-1-ross.lagerwall@citrix.com
    Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Cc: stable@vger.kernel.org	# v5.16+

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
