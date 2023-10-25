Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E03E7D6872
	for <lists+linux-pci@lfdr.de>; Wed, 25 Oct 2023 12:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234590AbjJYK2P (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Oct 2023 06:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234404AbjJYK2O (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Oct 2023 06:28:14 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4262EB0;
        Wed, 25 Oct 2023 03:28:12 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-507b18cf2e1so7480494e87.3;
        Wed, 25 Oct 2023 03:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698229690; x=1698834490; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yNP27PAMmqvkFQ64RZOWcZ2pYsOHLuDyPEFDZaios5Q=;
        b=OW/w/lzjeWnZk1b2xGLtOIyUCGEByZbTWxH/ywIxQsLvlJss60vwD9oH0Hd9O78Chz
         e/+Rzv9nj8oL8m2abz3y2JvMQRH8ccC8XVQDjuGHWLGQtHNcFF4/cjtDxhIfhZQ3iunb
         kz3TBLGQaamKS6Mcy06cWWGSm2GLx59GrXMo2jMS+ivRCZNLSQ7x8O9zKxTrGffQbl3u
         JBjw2XUhLXFie6j1zj2Ep81MLVwquz1ub9Vv1qbRyHpT9ubeLxvWlE2sw2iiM7M2l75i
         uZ96H1RL7IkHxKBZOPUqbXjd8H53trPa50T1Gqce3IZacu4YlOqxROoO1aeVBAzGfwNs
         gKsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698229690; x=1698834490;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yNP27PAMmqvkFQ64RZOWcZ2pYsOHLuDyPEFDZaios5Q=;
        b=Fw3tewzKRqxQFs+WjYSRK/0HcDvQuzAJVPgzJ/OiSlyK7xSNBs9hHmepSWHP0DJQMQ
         FL3MROaIpjlgm1hf+EG/jn6xO4drmsmg5rW3CJUUkzP/9sdwZywmIWl1sBnY3ZStRq1N
         /JiUJXWjzwRzav/KEmlvanBMzeehslAm3LcVQ2AD3Ji3fQCIxVFzklnkBb5bTdXUIspn
         q/K8iOGQgjW3DeeejEuWBE5QFAncVXIpbAyvwlPh520j2/rihTYIs4T5iVyBYqE8v1Vw
         dplfrFVannSAHgPGogbaGu65G7hKYijPAdV/2Eb1ROPba0baLYN9pxUYjXFhNi6/zuVO
         jPow==
X-Gm-Message-State: AOJu0YyChlMqZmoSHUiNvW5Kf95vqIgiTvbs/1J3DXZpWpjft5YejkZE
        uONEsLBs5y9S4y7oFOFgdFc=
X-Google-Smtp-Source: AGHT+IGa0sx4vMhOBXKsVh6AK+7GQbCC9qKBI94rsACPSthJpOiG2QMloF5w8HyaD2Wee9O22Gp0iA==
X-Received: by 2002:ac2:599a:0:b0:503:7dd:7ebd with SMTP id w26-20020ac2599a000000b0050307dd7ebdmr10284199lfn.24.1698229690140;
        Wed, 25 Oct 2023 03:28:10 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id g14-20020a19ee0e000000b00507cd390141sm2495159lfb.140.2023.10.25.03.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 03:28:09 -0700 (PDT)
Date:   Wed, 25 Oct 2023 13:28:07 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Siddharth Vadapalli <s-vadapalli@ti.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        bhelgaas@google.com, lpieralisi@kernel.org, robh@kernel.org,
        kw@linux.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        r-gunasekaran@ti.com, srk@ti.com
Subject: Re: [PATCH v3] PCI: keystone: Fix pci_ops for AM654x SoC
Message-ID: <3szgydgz7ege5h75mwdket5lniwy4oe52dq2uqehf74il5hc5j@oaqcbmfuf6de>
References: <20231023212628.GA1627567@bhelgaas>
 <c7851172-f474-42f3-9730-1f323f9e6c73@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7851172-f474-42f3-9730-1f323f9e6c73@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Siddharth, Bjorn

On Wed, Oct 25, 2023 at 10:32:50AM +0530, Siddharth Vadapalli wrote:
> Hello Bjorn,
> 
> On 24/10/23 02:56, Bjorn Helgaas wrote:
> > On Mon, Oct 23, 2023 at 05:05:30PM +0530, Siddharth Vadapalli wrote:
> >> On 23/10/23 16:12, Serge Semin wrote:
> >>
> >> ...
> >>
> >>> Siddharth, if it won't be that much bother and you have an access to
> >>> the v3.65-based Keystone PCIe device, could you please have a look
> >>> whether it's possible to implement what Bjorn suggested?
> >>
> >> Unfortunately I don't have any SoC/Device with me that has the v3.65 PCIe
> >> controller, so I will not be able to test Bjorn's suggestion.
> > 
> > Huh.  57e1d8206e48 ("MAINTAINERS: move Murali Karicheri to credits")
> > removed the maintainer for pci-keystone.c, so the driver hasn't had a
> > maintainer for over two years.
> > 
> > Given the fact that there's no maintainer, I'm more than happy to take
> > a patch to move this code to somewhere in the host_init() callback,
> > even if you don't have the hardware to test it.
> 
> Sure, I can work on a patch for it. The execution flow with the existing code is
> as follows:
> 
> ks_pcie_probe()
>     dw_pcie_host_init()
>         pci_host_probe()
>             ks_pcie_v3_65_add_bus()
> 
> So I assume that as long as ks_pcie_v3_65_add_bus() is invoked after
> pci_host_probe(), it should be acceptable. With this understanding, I plan to
> move it immediately after the invocation to dw_pcie_host_init() within
> ks_pcie_probe() conditionally (based on the is_am6 flag). The new call trace
> with this change will look like:
> 

> ks_pcie_probe()
>     dw_pcie_host_init()
>         pci_host_probe()
>     ks_pcie_v3_65_add_bus()

I guess what Bjorn implied was to add the ks_pcie_v3_65_add_bus()
invocation to the host_init() callback, i.e. in ks_pcie_host_init().
Moreover initializing the BARs/MSI after all the PCIe hierarchy has
been probed will eventually cause problems since MSI's won't work
until the ks_pcie_v3_65_add_bus() is called.

> 
> Since the .add_bus() method will be removed following this change, I suppose
> that the patch I post for it can be applied instead of this v3 patch which fixes
> pci_ops.
> 

> The patch I plan to post as a replacement for the current patch which shall also
> remove the ks_pcie_v3_65_add_bus() and the .add_bus() method is:

Just a note. Seeing the Bjorn's suggestion may cause a regression on
the Keystone PCIe Host v3.65 I would suggest to merge in the original
fix as is and post an additional cleanup patch, like below with proper
modifications, on top of it. Thus we'll minimize a risk to break
things at least on the stable kernels.

-Serge(y)

> 
> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> index 0def919f89fa..3933e857ecaa 100644
> --- a/drivers/pci/controller/dwc/pci-keystone.c
> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> @@ -447,44 +447,10 @@ static struct pci_ops ks_child_pcie_ops = {
>  	.write = pci_generic_config_write,
>  };
> 
> -/**
> - * ks_pcie_v3_65_add_bus() - keystone add_bus post initialization
> - * @bus: A pointer to the PCI bus structure.
> - *
> - * This sets BAR0 to enable inbound access for MSI_IRQ register
> - */
> -static int ks_pcie_v3_65_add_bus(struct pci_bus *bus)
> -{
> -	struct dw_pcie_rp *pp = bus->sysdata;
> -	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> -	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
> -
> -	if (!pci_is_root_bus(bus))
> -		return 0;
> -
> -	/* Configure and set up BAR0 */
> -	ks_pcie_set_dbi_mode(ks_pcie);
> -
> -	/* Enable BAR0 */
> -	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, 1);
> -	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, SZ_4K - 1);
> -
> -	ks_pcie_clear_dbi_mode(ks_pcie);
> -
> -	 /*
> -	  * For BAR0, just setting bus address for inbound writes (MSI) should
> -	  * be sufficient.  Use physical address to avoid any conflicts.
> -	  */
> -	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, ks_pcie->app.start);
> -
> -	return 0;
> -}
> -
>  static struct pci_ops ks_pcie_ops = {
>  	.map_bus = dw_pcie_own_conf_map_bus,
>  	.read = pci_generic_config_read,
>  	.write = pci_generic_config_write,
> -	.add_bus = ks_pcie_v3_65_add_bus,
>  };
> 
>  /**
> @@ -1270,6 +1236,29 @@ static int ks_pcie_probe(struct platform_device *pdev)
>  		ret = dw_pcie_host_init(&pci->pp);
>  		if (ret < 0)
>  			goto err_get_sync;
> +
> +		if (!ks_pcie->is_am6) {
> +			/*
> +			 * For v3.65 DWC PCIe Controllers, setup BAR0 to enable
> +			 * inbound access for MSI_IRQ register.
> +			 */
> +
> +			/* Configure and set up BAR0 */
> +			ks_pcie_set_dbi_mode(ks_pcie);
> +
> +			/* Enable BAR0 */
> +			dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, 1);
> +			dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, SZ_4K - 1);
> +
> +			ks_pcie_clear_dbi_mode(ks_pcie);
> +
> +			 /*
> +			  * For BAR0, just setting bus address for inbound writes (MSI) should
> +			  * be sufficient.  Use physical address to avoid any conflicts.
> +			  */
> +			dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, ks_pcie->app.start);
> +		}
> +
>  		break;
>  	case DW_PCIE_EP_TYPE:
>  		if (!IS_ENABLED(CONFIG_PCI_KEYSTONE_EP)) {
> 
> Please review and let me know if this looks fine. If so, I will post the patch for it.
> 
> -- 
> Regards,
> Siddharth.
