Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F96630B0D8
	for <lists+linux-pci@lfdr.de>; Mon,  1 Feb 2021 20:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232814AbhBATw6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Feb 2021 14:52:58 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:40460 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232747AbhBATwz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Feb 2021 14:52:55 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 111Jpsb0021812;
        Mon, 1 Feb 2021 13:51:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1612209114;
        bh=A9Ut7QjzdlWMCcgbKHeUR2PvD/GrnwvCX5Ls0QhaezU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=LG8HA72/M6wLUbAyXElsGIDwnEGNTUzEPpHJb0Cf1xVDA5KIA0uppe0f4aydUZPQC
         26PnAG9kesmisifkF3H11XD5TX+dCXDJTTjxcKnS0MktVy2r1JAgyETvSVEBlFtjsd
         oAf/gX9gWH+YxEKY630FzgwvZuu/oegVwNRf9AHU=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 111JpsVu064584
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 1 Feb 2021 13:51:54 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 1 Feb
 2021 13:51:54 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 1 Feb 2021 13:51:53 -0600
Received: from [10.250.235.118] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 111JppZl102050;
        Mon, 1 Feb 2021 13:51:52 -0600
Subject: Re: [PATCH] PCI: endpoint: Explain NTB in PCI_EPF_NTB help text
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210129130721.2653990-1-geert+renesas@glider.be>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <a2457927-370b-1e71-9c8a-5033cea3035e@ti.com>
Date:   Tue, 2 Feb 2021 01:21:50 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210129130721.2653990-1-geert+renesas@glider.be>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Geert,

On 29/01/21 6:37 pm, Geert Uytterhoeven wrote:
> The help text for the PCI_EPF_NTB config symbol uses the acronym "NTB".
> However, this acronym is not explained there.
> Expand the acronym to make it easier for users to decide if they need to
> enable the PCI_EPF_NTB option or not.
> 
> Fixes: 7dc64244f9e90b7b ("PCI: endpoint: Add EP function driver to provide NTB functionality")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Since I have to send the series one more time, I'll squash this in the
original patch and keep your signed-off-by.

Thanks
Kishon

> ---
>  drivers/pci/endpoint/functions/Kconfig | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/Kconfig b/drivers/pci/endpoint/functions/Kconfig
> index 24bfb2af65a10c42..ba1c7b8ab6df2f0c 100644
> --- a/drivers/pci/endpoint/functions/Kconfig
> +++ b/drivers/pci/endpoint/functions/Kconfig
> @@ -17,10 +17,10 @@ config PCI_EPF_NTB
>  	tristate "PCI Endpoint NTB driver"
>  	depends on PCI_ENDPOINT
>  	help
> -	  Select this configuration option to enable the NTB driver
> -	  for PCI Endpoint. NTB driver implements NTB controller
> -	  functionality using multiple PCIe endpoint instances. It
> -	  can support NTB endpoint function devices created using
> +	  Select this configuration option to enable the Non-Transparent
> +	  Bridge (NTB) driver for PCI Endpoint. NTB driver implements NTB
> +	  controller functionality using multiple PCIe endpoint instances.
> +	  It can support NTB endpoint function devices created using
>  	  device tree.
>  
>  	  If in doubt, say "N" to disable Endpoint NTB driver.
> 
