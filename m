Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 724BC27F12C
	for <lists+linux-pci@lfdr.de>; Wed, 30 Sep 2020 20:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725771AbgI3SR5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Sep 2020 14:17:57 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41151 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgI3SR5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Sep 2020 14:17:57 -0400
Received: by mail-oi1-f196.google.com with SMTP id x69so2726712oia.8;
        Wed, 30 Sep 2020 11:17:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=nyVHCEZSb4xAzOTonu3fC1754/xWgp4JRFM8+C/J4m4=;
        b=oJ8b6SEUln5CUgCVZM9WdFJyp+ISEwHcFRJ2ofBfMe2p9dgWOoj1jzky6D1mpvFCDX
         nKG+fBMxcgglxc49EsgZNIqL5I4UcEI/OmdQHdxtiCWjJrFfJ16MQ2nR0xZ7LEqRuH8I
         lbzM2Ly6jakdMUbRczXL3g3eQWyLONVIL9VRiD8VOOTlScj7VD3zJuDGcUV8chCIfpZr
         VD8Z/4kTmVn6uObjNYeClVWWJCF10pvXWoU5EsY3cQwEZnjGeDBst5q869yTcHf01aTR
         jH0GfG9DbM77bE5S4XsBpCDxsdbZLSHnpZafexwzjT5GSwywVDUppFQFvzozTGU8E0R7
         7ngg==
X-Gm-Message-State: AOAM5335oKPr4Tyfbuhl9MKSgrGPPNQvveqkCcEZjyj7pK8SCevne9bE
        I0nGA89gv2WlGL5pRe2HBA==
X-Google-Smtp-Source: ABdhPJw3WF6ewaZyUPa2K9FB5ROq3VPG9k/hedYrUzbsxjGrH/jCmJv84HB9KQVTHE3M3Y/gLXEwcw==
X-Received: by 2002:aca:f412:: with SMTP id s18mr2181254oih.100.1601489874677;
        Wed, 30 Sep 2020 11:17:54 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m22sm539978otf.52.2020.09.30.11.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 11:17:53 -0700 (PDT)
Received: (nullmailer pid 3170463 invoked by uid 1000);
        Wed, 30 Sep 2020 18:17:53 -0000
Date:   Wed, 30 Sep 2020 13:17:53 -0500
From:   Rob Herring <robh@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Vinod Koul <vkoul@kernel.org>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 2/2] PCI: aardvark: Fix initialization with old Marvell's
 Arm Trusted Firmware
Message-ID: <20200930181753.GA3170411@bogus>
References: <20200902144344.16684-1-pali@kernel.org>
 <20200902144344.16684-3-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200902144344.16684-3-pali@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 02 Sep 2020 16:43:44 +0200, Pali Rohár wrote:
> Old ATF automatically power on pcie phy and does not provide SMC call for
> phy power on functionality which leads to aardvark initialization failure:
> 
> [    0.330134] mvebu-a3700-comphy d0018300.phy: unsupported SMC call, try updating your firmware
> [    0.338846] phy phy-d0018300.phy.1: phy poweron failed --> -95
> [    0.344753] advk-pcie d0070000.pcie: Failed to initialize PHY (-95)
> [    0.351160] advk-pcie: probe of d0070000.pcie failed with error -95
> 
> This patch fixes above failure by ignoring 'not supported' error in
> aardvark driver. In this case it is expected that phy is already power on.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> Fixes: 366697018c9a ("PCI: aardvark: Add PHY support")
> ---
>  drivers/pci/controller/pci-aardvark.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
