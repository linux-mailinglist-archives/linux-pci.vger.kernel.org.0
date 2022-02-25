Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 159284C4BA7
	for <lists+linux-pci@lfdr.de>; Fri, 25 Feb 2022 18:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243424AbiBYRKV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Feb 2022 12:10:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237751AbiBYRKV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Feb 2022 12:10:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816F31FED96;
        Fri, 25 Feb 2022 09:09:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E86761CA5;
        Fri, 25 Feb 2022 17:09:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57CC3C340E7;
        Fri, 25 Feb 2022 17:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645808986;
        bh=pfsSeunGbYdy2xtChHl6wxqKd0NM1HCTb8v7YAEz93Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=SgkvroyE4REeIcoC+9m+Hin3Zid0Z+2OFpZG1YQBDd+KSYy3twIlnbJpy54bWxpzP
         ibHl6AwYnzMbTAwylH8hrjl3Pic41JHYO+F17D/cwejouTrJKug54nxCAzLyye8hu3
         VE2+b2/s67oe0qK16qyxVTA0WEEGIqcpAJby58URrVmeulp3MvQ9KdIKv3uhQ6L5XR
         Cu/etSAQr2b1ERVAh3U09WHGS5BzlywVjbHJwrbGvAp/jEaP6+z2+Y+D1nBlPI5+3i
         KXe3m38DMKLO4NsPa0b1YdQ1fIQoLgAdB31vpZ1+yCvHytc8jTFNgrCshJfMM+OwqM
         eNlZzXh4XUXHQ==
Date:   Fri, 25 Feb 2022 11:09:44 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Michael J. Ruhl" <michael.j.ruhl@intel.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, logang@deltatee.com, dan.j.williams@intel.com
Subject: Re: [PATCH] PCI/P2PDMA: Update device table with 3rd gen Xeon
 platform information
Message-ID: <20220225170944.GA364325@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209162801.7647-1-michael.j.ruhl@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 09, 2022 at 11:28:01AM -0500, Michael J. Ruhl wrote:
> In order to do P2P communication the bridge ID of the platform
> must be in the P2P device table.
> 
> Update the P2P device table with a device id for the 3rd Gen
> Intel Xeon Scalable Processors.
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Michael J. Ruhl <michael.j.ruhl@intel.com>

Updated the commit log to match previous similar patches and applied
as below to pci/p2pdma for v5.18, thanks!

Device ID 0x09a2 doesn't appear at https://pci-ids.ucw.cz/read/PC/8086
which means "lspci" won't be able to display a human-readable name for
these devices.  You can easily add a name at that same URL.

Bjorn


  commit feaea1fe8b36 ("PCI/P2PDMA: Add Intel 3rd Gen Intel Xeon Scalable Processors to whitelist")
  Author: Michael J. Ruhl <michael.j.ruhl@intel.com>
  Date:   Wed Feb 9 11:28:01 2022 -0500

    PCI/P2PDMA: Add Intel 3rd Gen Intel Xeon Scalable Processors to whitelist
    
    In order to do P2P communication the bridge ID of the platform must be in
    the P2P device table.
    
    Update the P2P device table with a device ID for the 3rd Gen Intel Xeon
    Scalable Processors.
    
    Link: https://lore.kernel.org/r/20220209162801.7647-1-michael.j.ruhl@intel.com
    Signed-off-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Reviewed-by: Dan Williams <dan.j.williams@intel.com>

> ---
>  drivers/pci/p2pdma.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index 1015274bd2fe..30b1df3c9d2f 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -321,6 +321,7 @@ static const struct pci_p2pdma_whitelist_entry {
>  	{PCI_VENDOR_ID_INTEL,	0x2032, 0},
>  	{PCI_VENDOR_ID_INTEL,	0x2033, 0},
>  	{PCI_VENDOR_ID_INTEL,	0x2020, 0},
> +	{PCI_VENDOR_ID_INTEL,	0x09a2, 0},
>  	{}
>  };
>  
> -- 
> 2.31.1
> 
