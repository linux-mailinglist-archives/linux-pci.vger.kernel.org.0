Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC55A779506
	for <lists+linux-pci@lfdr.de>; Fri, 11 Aug 2023 18:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjHKQrC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Aug 2023 12:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbjHKQqz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Aug 2023 12:46:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A785F30E6
        for <linux-pci@vger.kernel.org>; Fri, 11 Aug 2023 09:46:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E62D64BAF
        for <linux-pci@vger.kernel.org>; Fri, 11 Aug 2023 16:46:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 698E9C433C8;
        Fri, 11 Aug 2023 16:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691772408;
        bh=Nxah1DBosO7rZyUgyrog746Zi3/9NzGbKgD+98wpNj8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=CUh97WHfO5pxneX1uUD/Pi1Y+MMPquHCJxeadIn6MVdvLj7zB8Epr+PzhxqmGhPmi
         4iW8Vc7mFo2twEam8MEvIOBNKbrCLmwh1uvWnaV52IMv/zSiofyLO6lQhKOX8cRqLo
         DogXvyEi9WsvC8MEVt75P8YdtZIwC8p17zCVsy33BPraJWIhjA3f2eqhINfi2Bwt3R
         v7p1AbGZTii7Y5r5wFCNRbqBjWQP3Ww4pmwGHm30J6/OFTHq3gFUI53mAOmfcvZUhE
         obVze+EoXA0t6id9yZHSapOo+kxfKDnwOWHoyh7VYJGIhmmyoZPc76hnaklkOVsRc/
         waw1EqIjPqw/A==
Date:   Fri, 11 Aug 2023 11:46:47 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Zheng Zengkai <zhengzengkai@huawei.com>
Cc:     bhelgaas@google.com, logang@deltatee.com,
        linux-pci@vger.kernel.org, wangxiongfeng2@huawei.com
Subject: Re: [PATCH -next] PCI/P2PDMA: Use pci_dev_id() to simplify the code
Message-ID: <20230811164647.GA76340@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811111057.31900-1-zhengzengkai@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 11, 2023 at 07:10:57PM +0800, Zheng Zengkai wrote:
> PCI core API pci_dev_id() can be used to get the BDF number for a pci
> device. We don't need to compose it manually. Use pci_dev_id() to
> simplify the code a little bit.
> 
> Signed-off-by: Zheng Zengkai <zhengzengkai@huawei.com>

Applied to pci/misc for v6.6, thanks!

> ---
>  drivers/pci/p2pdma.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index 6cd98ffca198..ec04d0ed157b 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -532,8 +532,7 @@ static bool host_bridge_whitelist(struct pci_dev *a, struct pci_dev *b,
>  
>  static unsigned long map_types_idx(struct pci_dev *client)
>  {
> -	return (pci_domain_nr(client->bus) << 16) |
> -		(client->bus->number << 8) | client->devfn;
> +	return (pci_domain_nr(client->bus) << 16) | pci_dev_id(client);
>  }
>  
>  /*
> -- 
> 2.20.1
> 
