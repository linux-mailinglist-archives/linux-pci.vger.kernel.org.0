Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02CA26E9C5F
	for <lists+linux-pci@lfdr.de>; Thu, 20 Apr 2023 21:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbjDTTSZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Apr 2023 15:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbjDTTSX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Apr 2023 15:18:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920F72717;
        Thu, 20 Apr 2023 12:18:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27C5264B75;
        Thu, 20 Apr 2023 19:18:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46701C433EF;
        Thu, 20 Apr 2023 19:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682018301;
        bh=k1WHMbq/+PNaNuKbd8Q0jEepdVEj1y3YL4mMyUO9cd8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=gvA7Ouzsp4ch+Y4IsdLamcgHUr5x0L/M0XEkjAM0UE68irldnAoN77dBAp+JVQw/q
         Jztw3bYCZk5gVYI8958TDTtr6w8J/ZFzLAn9dBUhKaJrMYiPQXp9VJpZ+bumXDfbdD
         BF25FBe0uEUqHVJVywfS3oL2Gf7tgaIZ/5EmO8uoTe4rTa9rNLRCvycpFHdxG4Evtj
         Jaojl3ujYbbyfhbNSBfciwUT1i5gqm3A9NkyRsqzO8iWmdswJOMxq1hJES0R+d6hSd
         9hrJvnnLncbhpmrh7k4j+NAyd9kZqd1rJ31ob7jhicc0wz7lKG6vVK5USvCpkVgXVR
         iy0tDpk4MTjZw==
Date:   Thu, 20 Apr 2023 14:18:19 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jean Delvare <jdelvare@suse.de>
Cc:     linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH RESEND] PCI: xilinx: Drop obsolete dependency on
 COMPILE_TEST
Message-ID: <20230420191819.GA316943@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230407190843.529caf19@endymion.delvare>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 07, 2023 at 07:08:43PM +0200, Jean Delvare wrote:
> Since commit 0166dc11be91 ("of: make CONFIG_OF user selectable"), it
> is possible to test-build any driver which depends on OF on any
> architecture by explicitly selecting OF. Therefore depending on
> COMPILE_TEST as an alternative is no longer needed.
> 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: "Krzysztof Wilczyński" <kw@linux.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>

Thanks, Jean, applied to pci/controller/kconfig for v6.4.

> ---
> Resending as the context changed so my original submission no longer
> applies cleanly.
> 
>  drivers/pci/controller/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-6.0.orig/drivers/pci/controller/Kconfig
> +++ linux-6.0/drivers/pci/controller/Kconfig
> @@ -98,7 +98,7 @@ config PCI_HOST_GENERIC
>  
>  config PCIE_XILINX
>  	bool "Xilinx AXI PCIe host bridge support"
> -	depends on OF || COMPILE_TEST
> +	depends on OF
>  	depends on PCI_MSI
>  	help
>  	  Say 'Y' here if you want kernel to support the Xilinx AXI PCIe
> 
> 
> -- 
> Jean Delvare
> SUSE L3 Support
