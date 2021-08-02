Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51F883DE27D
	for <lists+linux-pci@lfdr.de>; Tue,  3 Aug 2021 00:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbhHBWb6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Aug 2021 18:31:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:39748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231126AbhHBWb6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 2 Aug 2021 18:31:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 06B1C60EC0;
        Mon,  2 Aug 2021 22:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627943508;
        bh=ub1WP7VKs33qlRegeyvmX5DMKy6PXncsku/5B1mOaxY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ooGY6oROmzxQaNgkXGQrQ+ra96/RNX+FSqjVId77VXnKJm53eMgIZchGaMdant/XN
         /Mklv+7YMvI9NQiADcIJHGTgDrwMzP4oSX5K8bSbHqpvYtXwfl1xkaSF5NQ8JEdpJZ
         RXLbxwr51E9wWlpmfIpeo9xsHnh32NMSKrWbAtCroAIKsqqSMtBbz4+RNS4irGbe2K
         xf5bDt4+GQeXTu4rm2y0VBJExFj+UOGZcZojTfG2f9OSsdo03ZB7FryBVt6gFwVceF
         tAT+zSyEqbL8OjV92i3mlbrwF/R8Acrtb6HovgSrUeYwK7Iu5/92L3lxTOwpaV3UrZ
         3uCg+1NcV8xIQ==
Date:   Mon, 2 Aug 2021 17:31:46 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI/VPD: Treat tag 0xff as indicator for missing VPD
 EPROM
Message-ID: <20210802223146.GA1470658@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8de8c906-9284-93b9-bb44-4ffdc3470740@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 15, 2021 at 10:41:08AM +0200, Heiner Kallweit wrote:
> First tag being read as 0xff indicates a missing VPD EPROM, same as 0x00.
> The latter case we handle properly already, so let's handle 0x00 here too.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Applied to pci/vpd for v5.15 with small tweak so the error message can
be shared with other errors, thanks!

> ---
>  drivers/pci/vpd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
> index 26bf7c877..6a32d938d 100644
> --- a/drivers/pci/vpd.c
> +++ b/drivers/pci/vpd.c
> @@ -78,8 +78,8 @@ static size_t pci_vpd_size(struct pci_dev *dev, size_t old_size)
>  	while (off < old_size && pci_read_vpd(dev, off, 1, header) == 1) {
>  		unsigned char tag;
>  
> -		if (!header[0] && !off) {
> -			pci_info(dev, "Invalid VPD tag 00, assume missing optional VPD EPROM\n");
> +		if ((!header[0] || header[0] == 0xff) && !off) {
> +			pci_info(dev, "Invalid VPD tag 00/FF, assume missing optional VPD EPROM\n");
>  			return 0;
>  		}
>  
> -- 
> 2.32.0
> 
