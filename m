Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09BFF6EB9C4
	for <lists+linux-pci@lfdr.de>; Sat, 22 Apr 2023 16:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjDVOvq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 22 Apr 2023 10:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDVOvq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 22 Apr 2023 10:51:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A221723;
        Sat, 22 Apr 2023 07:51:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD990617ED;
        Sat, 22 Apr 2023 14:51:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91B0BC433EF;
        Sat, 22 Apr 2023 14:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682175104;
        bh=KeQQKkot+tXQJMDWgdwmy79BKsRWMCpyn3+/1yDukH4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y1EDmmXkMHXvJ0cctvCcimDFMWMc3juo4kjBCSxUO78Yv0tJuMix6SDgtqNhkOe1K
         BghfL5F833QEQdqXjyByDszuMAj/KTLotiPxukUnAEF28TE+4koGHBIHU8jgmGoNX6
         MwGKi8nTToou4+XHus0Qxx1Ud/XAmkziTrbW7L2KSymtZB19QWwKCZnBWTklZal+cn
         QNp1ky3FmQapJjscBJ5I7TV2+8qILk8++7ixlTa12l+ZHkTtmiWKBylPrCCNznL+Qk
         TVvcfdneoflf1/njm0RUXrcCIAU9HEclXyVw9hSfF0hrAZi83T59VISPjsLGPdXTAW
         4Ewe5UR8UtR9w==
Date:   Sat, 22 Apr 2023 20:21:36 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        fancer.lancer@gmail.com, lpieralisi@kernel.org, robh+dt@kernel.org,
        kw@linux.com, bhelgaas@google.com, kishon@kernel.org,
        marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v13 22/22] misc: pci_endpoint_test: Add Device ID for
 R-Car S4-8 PCIe controller
Message-ID: <20230422145136.GS4769@thinkpad>
References: <20230418122403.3178462-1-yoshihiro.shimoda.uh@renesas.com>
 <20230418122403.3178462-23-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230418122403.3178462-23-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 18, 2023 at 09:24:03PM +0900, Yoshihiro Shimoda wrote:
> Add Renesas R8A779F0 in pci_device_id table so that pci-epf-test
> can be used for testing PCIe EP on R-Car S4-8.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Acked-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
>  drivers/misc/pci_endpoint_test.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index a7244de081ec..1d8f72b42c0a 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -81,6 +81,7 @@
>  #define PCI_DEVICE_ID_RENESAS_R8A774B1		0x002b
>  #define PCI_DEVICE_ID_RENESAS_R8A774C0		0x002d
>  #define PCI_DEVICE_ID_RENESAS_R8A774E1		0x0025
> +#define PCI_DEVICE_ID_RENESAS_R8A779F0		0x0031
>  
>  static DEFINE_IDA(pci_endpoint_test_ida);
>  
> @@ -993,6 +994,9 @@ static const struct pci_device_id pci_endpoint_test_tbl[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A774B1),},
>  	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A774C0),},
>  	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A774E1),},
> +	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A779F0),
> +	  .driver_data = (kernel_ulong_t)&default_data,
> +	},
>  	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_J721E),
>  	  .driver_data = (kernel_ulong_t)&j721e_data,
>  	},
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்
