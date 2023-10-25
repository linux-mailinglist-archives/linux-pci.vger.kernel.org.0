Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE9C7D7218
	for <lists+linux-pci@lfdr.de>; Wed, 25 Oct 2023 19:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjJYRIb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Oct 2023 13:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjJYRIa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Oct 2023 13:08:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A87412F;
        Wed, 25 Oct 2023 10:08:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27B2FC433C7;
        Wed, 25 Oct 2023 17:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698253708;
        bh=HB+n4zKxAkIg+YmsEHyf2pMF18rKQZxGqCKpe+6cdB0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YRj1O1OvYuMJ2at1RMAgFOQmdCCvXJAGqgIhsHm6VEGuljfeV8u/LP+gIX80UNv25
         Ikly2nRHQy0x2uMm4FGshCrVoe7tf0GVw3xIAgxQRWvK5SnOV3HwmljlHIwaBhkZfc
         7wCvOzfKVGW3mggCN4epBBOZx9h2IAdaaFC6KYQoBIxWEUT9Xy0azgFqxdavI2ErGu
         Dy3mVD/mEN90zcN1CUC9fE/t/RncO1wKeAVt41Dy0GE3V7hyQQA6z3S/OC7+4gKHsC
         Sls38dDIrHAs0dsXguli4sImkoSl1f2/OPpqlsby8hrOXxCnAuL100WHuMs0Ttw4PC
         GR6Ne8MAnVupw==
Date:   Wed, 25 Oct 2023 22:38:20 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Siddharth Vadapalli <s-vadapalli@ti.com>
Cc:     lpieralisi@kernel.org, kw@linux.com, mani@kernel.org,
        kishon@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, r-gunasekaran@ti.com,
        srk@ti.com
Subject: Re: [PATCH] misc: pci_endpoint_test: Add deviceID for J721S2 PCIe EP
 device support
Message-ID: <20231025170820.GA103335@thinkpad>
References: <20231020120248.3168406-1-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231020120248.3168406-1-s-vadapalli@ti.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 20, 2023 at 05:32:48PM +0530, Siddharth Vadapalli wrote:
> Add DEVICE_ID for J721S2 and enable support for endpoints configured
> with this DEVICE_ID in the pci_endpoint_test driver.
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/misc/pci_endpoint_test.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index ed4d0ef5e5c3..7e1acc68d435 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -71,6 +71,7 @@
>  #define PCI_DEVICE_ID_TI_AM654			0xb00c
>  #define PCI_DEVICE_ID_TI_J7200			0xb00f
>  #define PCI_DEVICE_ID_TI_AM64			0xb010
> +#define PCI_DEVICE_ID_TI_J721S2		0xb013
>  #define PCI_DEVICE_ID_LS1088A			0x80c0
>  #define PCI_DEVICE_ID_IMX8			0x0808
>  
> @@ -999,6 +1000,9 @@ static const struct pci_device_id pci_endpoint_test_tbl[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_AM64),
>  	  .driver_data = (kernel_ulong_t)&j721e_data,
>  	},
> +	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_J721S2),
> +	  .driver_data = (kernel_ulong_t)&j721e_data,
> +	},
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(pci, pci_endpoint_test_tbl);
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்
