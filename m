Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5F7E33997A
	for <lists+linux-pci@lfdr.de>; Fri, 12 Mar 2021 23:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235513AbhCLWMV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Mar 2021 17:12:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:51018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235511AbhCLWMH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Mar 2021 17:12:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5F19464F29;
        Fri, 12 Mar 2021 22:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615587126;
        bh=I0I7UX/BgYaMQNdTNR8RoovB7eQTZ94C1CyahHLLTUM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=b156G0jLwffWsRQi+TB9rqgoAX0AAxo7xmuTVVJnnDwJhf+VVdm5yoMtmyJU6WxIf
         yYcStep1Gt6LzLcySwVhgUpE7mlBqjv42YwzstXdpk5n/GaPG9/UUK5ZS/F1EByQlY
         hxhRQLbIAdsZ7GFPlvuGSMMwLUE7iuHh+6YRq6qIXQxol5LOlQfpxBobFkVd57PTl0
         Mmyz2KiALy3nzxImLOrx+S6iiM7/1/n8sJDiwtnsDrDO21pr7GOErT8nzight3wFTg
         A5xPb/bAgn5rFXo7Y3bAVwXXH0DGj5NNrrQ2Ey9bkqC0zshZ4W6fcu7UBBrTMEK8dT
         hy3zZ1rDYNWRg==
Date:   Fri, 12 Mar 2021 16:12:05 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 03/44] PCI: remove synclink entries from pci_ids
Message-ID: <20210312221205.GA2296747@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210302062214.29627-3-jslaby@suse.cz>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 02, 2021 at 07:21:33AM +0100, Jiri Slaby wrote:
> The drivers were removed in a1f714b44e34 (tty: Remove redundant synclink
> driver) and 3d608a591b2b (tty: Remove redundant synclinkmp driver).
> 
> So remove also the PCI ID entries.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>

Applied with Krzysztof's reviewed-by to pci/misc for v5.13, thanks!

> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> ---
>  include/linux/pci_ids.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index a76ccb697bef..8a18517696c1 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2065,8 +2065,6 @@
>  #define PCI_DEVICE_ID_EXAR_XR17V358	0x0358
>  
>  #define PCI_VENDOR_ID_MICROGATE		0x13c0
> -#define PCI_DEVICE_ID_MICROGATE_USC	0x0010
> -#define PCI_DEVICE_ID_MICROGATE_SCA	0x0030
>  
>  #define PCI_VENDOR_ID_3WARE		0x13C1
>  #define PCI_DEVICE_ID_3WARE_1000	0x1000
> -- 
> 2.30.1
> 
