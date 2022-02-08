Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D95A4AD258
	for <lists+linux-pci@lfdr.de>; Tue,  8 Feb 2022 08:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348423AbiBHHh6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Feb 2022 02:37:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346472AbiBHHh6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Feb 2022 02:37:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96248C0401F4;
        Mon,  7 Feb 2022 23:37:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25AC0615DC;
        Tue,  8 Feb 2022 07:37:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D15AEC340ED;
        Tue,  8 Feb 2022 07:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644305876;
        bh=jCqEF148ccWzh0I4aTqkCNTCIq5H5g9nqJjNydsQbQ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uN9p3WazGl53qw4M9VNwJO8ZRkgkySxIicVKaGBLXUeXK86MhKCG6J/ThjV6oubzY
         R4yk5KKIXmf3ad7kE4UB6L9T+k1HPwQDEOt/xTbWZ4ME/B7p4rq1owyeB7cTAPVn+n
         8kC3lY7qWJKFK5d991L6XEoK9/nrECqWnAxbyLYU=
Date:   Tue, 8 Feb 2022 08:37:52 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Neal Liu <neal_liu@aspeedtech.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Tao Ren <rentao.bupt@gmail.com>, BMC-SW@aspeedtech.com
Subject: Re: [PATCH] usb: ehci: add pci device support for Aspeed platforms
Message-ID: <YgId0AhvRAmIcEA0@kroah.com>
References: <20220208062927.3527137-1-neal_liu@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208062927.3527137-1-neal_liu@aspeedtech.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 08, 2022 at 02:29:27PM +0800, Neal Liu wrote:
> Enable Aspeed quirks in commit 7f2d73788d90 ("usb: ehci:
> handshake CMD_RUN instead of STS_HALT") to support Aspeed
> ehci-pci device.
> 
> Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> ---
>  drivers/usb/host/ehci-pci.c | 6 ++++++
>  include/linux/pci_ids.h     | 3 +++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/drivers/usb/host/ehci-pci.c b/drivers/usb/host/ehci-pci.c
> index e87cf3a00fa4..a91b25d216ae 100644
> --- a/drivers/usb/host/ehci-pci.c
> +++ b/drivers/usb/host/ehci-pci.c
> @@ -222,6 +222,12 @@ static int ehci_pci_setup(struct usb_hcd *hcd)
>  			ehci->has_synopsys_hc_bug = 1;
>  		}
>  		break;
> +	case PCI_VENDOR_ID_ASPEED:
> +		if (pdev->device == PCI_DEVICE_ID_ASPEED_EHCI) {
> +			ehci_info(ehci, "applying Aspeed HC workaround\n");
> +			ehci->is_aspeed = 1;
> +		}
> +		break;
>  	}
>  
>  	/* optional debug port, normally in the first BAR */
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index aad54c666407..410b395fe56c 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -3096,4 +3096,7 @@
>  
>  #define PCI_VENDOR_ID_NCUBE		0x10ff
>  
> +#define PCI_VENDOR_ID_ASPEED		0x1a03
> +#define PCI_DEVICE_ID_ASPEED_EHCI	0x2603

Please read the top of this file, this does not need to be added here.

thanks,

greg k-h
