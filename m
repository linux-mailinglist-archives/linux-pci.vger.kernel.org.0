Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A94079443D
	for <lists+linux-pci@lfdr.de>; Wed,  6 Sep 2023 22:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbjIFUEn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Sep 2023 16:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244146AbjIFUEl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Sep 2023 16:04:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF05919A8;
        Wed,  6 Sep 2023 13:04:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51AA1C433C8;
        Wed,  6 Sep 2023 20:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694030676;
        bh=NqO7EMRitHxu9HJnG/FEp0686atDEPSglDqpszUAXs8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=soR3gx/wbFb5PwDIpMqNqLYpm5bxeT/4wZJNEEY9Ym5pgZser/GSMxsthMvfDN5Mm
         6XmR62guxLgggnJTle0dAxqjjIMeRaHwzifWU/lIPl/ki01OCjGDZJOMX7Zon92xlf
         YhOqgURvhBxpr92ItRB9PuhKTfm8SfMCt+W0sEYAaajSoB89tIzEBx6vk+G9pmi4JK
         1l2R9Djpg3yMWWTciRmSGTT+SjNy7VICXWrYHLZR0L3FqjXX5j/bKYsV4YjkVbswai
         PDutF/ecvTy66YWGB5bJY4cC7yOvY2IkSRV7D0KkyfqzPhq7wNdqEBCy0+a6m5ZNni
         SoDiBupwJoiNQ==
Date:   Wed, 6 Sep 2023 15:04:34 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ross Lagerwall <ross.lagerwall@citrix.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Kalle Valo <kvalo@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] PCI: Free released resource
Message-ID: <20230906200434.GA231687@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906110846.225369-1-ross.lagerwall@citrix.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 06, 2023 at 12:08:46PM +0100, Ross Lagerwall wrote:
> release_resource() doesn't actually free the resource or resource list
> entry so free the resource list entry to avoid a leak.
> 
> Fixes: e54223275ba1 ("PCI: Release resource invalidated by coalescing")
> Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
> Reported-by: Kalle Valo <kvalo@kernel.org>
> Closes: https://lore.kernel.org/r/878r9sga1t.fsf@kernel.org/
> Tested-by: Kalle Valo <kvalo@kernel.org>
> Cc: stable@vger.kernel.org      # v5.16+

Applied to for-linus for v6.6-rc1.

> ---
>  drivers/pci/probe.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index ab2a4a3a4c06..795534589b98 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -997,6 +997,7 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
>  		res = window->res;
>  		if (!res->flags && !res->start && !res->end) {
>  			release_resource(res);
> +			resource_list_destroy_entry(window);
>  			continue;
>  		}
>  
> -- 
> 2.41.0
> 
