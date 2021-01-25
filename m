Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0A6A302C43
	for <lists+linux-pci@lfdr.de>; Mon, 25 Jan 2021 21:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732060AbhAYUJg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Jan 2021 15:09:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:34388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732265AbhAYT5o (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 25 Jan 2021 14:57:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 13F5D206DC;
        Mon, 25 Jan 2021 19:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611604623;
        bh=ETSriY70PmSdz7CV66kryAqZ+pG/PLJthIcum+ti7ko=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=g1L3hIt93ui4c5At4h5UovgstCsAcRLG48Kw4xGIzrPGCJf4jtE/PZ49er+jvs3W8
         R9DEsHlosG4IO/jKaAhPhC6T76mh0YIi2AF3JPshzFTTLkAn3zTtQIoMyKTYQ9wpho
         UHyLzycOQo5NKwdxPGKVHl9Ft6Iyp1Q4la+vjsp26n9X2MxKYZ3cb6+w9L4zSRl6MK
         iybKHFb53eZPr2gPpwYpm5RC12JSee7NtSSjuqSkj1IrPYV6C+C0pYIIzmTHDLXAab
         SdL7Mng3+fo8PTUY4uQF30QRVcQKkOe2296JAdrTIg6WiocXIjHfWzNG/cUkHlRvHx
         J7sqXrAWifZSg==
Date:   Mon, 25 Jan 2021 13:57:00 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: Fix handling of pci user accessor return codes in
 syscalls
Message-ID: <20210125195700.GA2818097@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1220314-e518-1e18-bf94-8e6f8c703758@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Jan 24, 2021 at 04:39:32PM +0100, Heiner Kallweit wrote:
> Referenced commit changed the user accessors to return negative errno's
> on error, seems this wasn't reflected in all users. Here it doesn't
> really make a difference because the effective check is the same.
> 
> Fixes: 34e3207205ef ("PCI: handle positive error codes")
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Applied to pci/misc for v5.11, thanks!

> ---
>  drivers/pci/syscall.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/syscall.c b/drivers/pci/syscall.c
> index 31e39558d..8b003c890 100644
> --- a/drivers/pci/syscall.c
> +++ b/drivers/pci/syscall.c
> @@ -20,7 +20,7 @@ SYSCALL_DEFINE5(pciconfig_read, unsigned long, bus, unsigned long, dfn,
>  	u16 word;
>  	u32 dword;
>  	long err;
> -	long cfg_ret;
> +	int cfg_ret;
>  
>  	if (!capable(CAP_SYS_ADMIN))
>  		return -EPERM;
> @@ -46,7 +46,7 @@ SYSCALL_DEFINE5(pciconfig_read, unsigned long, bus, unsigned long, dfn,
>  	}
>  
>  	err = -EIO;
> -	if (cfg_ret != PCIBIOS_SUCCESSFUL)
> +	if (cfg_ret)
>  		goto error;
>  
>  	switch (len) {
> @@ -105,7 +105,7 @@ SYSCALL_DEFINE5(pciconfig_write, unsigned long, bus, unsigned long, dfn,
>  		if (err)
>  			break;
>  		err = pci_user_write_config_byte(dev, off, byte);
> -		if (err != PCIBIOS_SUCCESSFUL)
> +		if (err)
>  			err = -EIO;
>  		break;
>  
> @@ -114,7 +114,7 @@ SYSCALL_DEFINE5(pciconfig_write, unsigned long, bus, unsigned long, dfn,
>  		if (err)
>  			break;
>  		err = pci_user_write_config_word(dev, off, word);
> -		if (err != PCIBIOS_SUCCESSFUL)
> +		if (err)
>  			err = -EIO;
>  		break;
>  
> @@ -123,7 +123,7 @@ SYSCALL_DEFINE5(pciconfig_write, unsigned long, bus, unsigned long, dfn,
>  		if (err)
>  			break;
>  		err = pci_user_write_config_dword(dev, off, dword);
> -		if (err != PCIBIOS_SUCCESSFUL)
> +		if (err)
>  			err = -EIO;
>  		break;
>  
> -- 
> 2.30.0
> 
