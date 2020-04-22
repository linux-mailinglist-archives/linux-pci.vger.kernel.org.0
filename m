Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C60301B4D5F
	for <lists+linux-pci@lfdr.de>; Wed, 22 Apr 2020 21:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbgDVTaB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Apr 2020 15:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725935AbgDVTaA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Apr 2020 15:30:00 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF30C03C1A9;
        Wed, 22 Apr 2020 12:29:59 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id a2so2883646oia.11;
        Wed, 22 Apr 2020 12:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hGficyrZ4sebWDfX+hwwWhlXqmUAh4bJFNFxwgCc5Eo=;
        b=D8o49ScrY7NLNMFAFIwnzcxywXle16BkKRYYFPamPiL1A5Y28OsEGTb1XDc4fn2N4r
         vqOcSW2MJ7SWMkvFuSOK9szCbpGI7LhpBDstOPRwaobjEJqsQLEFOE+ZTT0wkM8d5ACE
         vZPIVfKRgSA14d1Wgw3kG2Tf5bJxy74HDc71maU+4PPw9vk1UsaCKnKHXNSwolW7DTCm
         TFHwT4fJF26184kwM0BejI7th1rPnipq4i8M8J13vPEFnvufCbLshWVm4yn16XHGCzmn
         rw00DobnF94u6tP041vKYm4UpI9cFctKTp4hGV2h3RxTpSPEQedzCf1S9O7goT3EJb3R
         vrqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hGficyrZ4sebWDfX+hwwWhlXqmUAh4bJFNFxwgCc5Eo=;
        b=QPh8SpeizrgmzzphBgczqMnVbqTMZr9UipWzqlufegI0qvpn+04T0oBda7mLNa/tsK
         i5FaB10tD0OvQNCsU+1Qw05KkK/lqi0tPgTxhXpBVTIH1twmFAu4/znXX/Qbgx/kjgJ4
         wedS93ZeGdZvf28LRu/uIOl1nvlsbACsuQbn7Rx+p37qHwDYQHzRN/g2jeQqnwqktI+U
         DWXH3cHgkBCaB2LiMwHARGGcsf2nn2AmIp/VitJtGAZNszLVDapUCSWQQlT/UUvebE8s
         W1+hbwM+tBHgZoFB6/vIWbq+YgQwFe8cBoXZOvD5rpzf8Y0y8NC7FFJAROMD8tvVCBNR
         y1yw==
X-Gm-Message-State: AGi0PuZ056C3KbtK8DgljIOpGFCJInAEwQXabvpeMyPl7apSflJpvjaE
        XHuQs7eAEz/gkX9DL9oT9w==
X-Google-Smtp-Source: APiQypID6N0FltxN8PtBLSw2l+eD9zcQ9ni2qkgCcvwCIAMCk3D8FqLC4TRtP5Vc6aFhC2FhsbS+8w==
X-Received: by 2002:a05:6808:3d4:: with SMTP id o20mr390469oie.47.1587583798838;
        Wed, 22 Apr 2020 12:29:58 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c81sm35623oib.35.2020.04.22.12.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 12:29:58 -0700 (PDT)
From:   Rob Herring <robherring2@gmail.com>
X-Google-Original-From: Rob Herring <rob@rob-hp-laptop.gmail.com>
Received: (nullmailer pid 22790 invoked by uid 1000);
        Wed, 22 Apr 2020 19:29:57 -0000
Date:   Wed, 22 Apr 2020 14:29:57 -0500
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH 1/4] PCI: dra7xx: Don't select CONFIG_PCI_DRA7XX_HOST by
 default
Message-ID: <20200422192957.6lwr3aig4a3dcynr@rob-hp-laptop>
References: <20200415001244.144623-1-helgaas@kernel.org>
 <20200415001244.144623-2-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415001244.144623-2-helgaas@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 14, 2020 at 07:12:41PM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Drivers should not be selected by default because that bloats the kernel
> for people who don't need them.
> 
> Remove the "default y" for CONFIG_PCI_DRA7XX_HOST.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: linux-omap@vger.kernel.org
> ---
>  drivers/pci/controller/dwc/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index 03dcaf65d159..ea335ee7ca8e 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -26,7 +26,6 @@ config PCI_DRA7XX_HOST
>  	depends on OF && HAS_IOMEM && TI_PIPE3
>  	select PCIE_DW_HOST
>  	select PCI_DRA7XX
> -	default y

Perhaps 'default y if SOC_DRA7XX'?

>  	help
>  	  Enables support for the PCIe controller in the DRA7xx SoC to work in
>  	  host mode. There are two instances of PCIe controller in DRA7xx.
> -- 
> 2.26.0.110.g2183baf09c-goog
> 
