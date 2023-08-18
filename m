Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5873C7803F4
	for <lists+linux-pci@lfdr.de>; Fri, 18 Aug 2023 04:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357313AbjHRCwX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Aug 2023 22:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241065AbjHRCvv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Aug 2023 22:51:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9A71706;
        Thu, 17 Aug 2023 19:51:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9DCD7633A4;
        Fri, 18 Aug 2023 02:51:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07365C433C7;
        Fri, 18 Aug 2023 02:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692327109;
        bh=UR+lY8xC12md9n4dIqbiWSk5fT24wBQROEj2tL/rHwg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=uaovqjC95i/W8Y5I5lfK/hAJ6uPby6+aeWC+52XJIxi3ZcmMFS3Bag0oxvttVAJcz
         9syXSyE171bgvjbzM0UPIWk0Nwn83RZDUZjbJgP3YSjEYrQebu4zSBvywaYoX1Uvjt
         mNKCXQGCgnYFQ7nlKiPnO5teihGVIS4GxJlSP27p+R7QmMLBm3SXOBqlYGFtSlsRIa
         CzUClolLkt36fQcffV/D7aDgUj3fiA3CaT8Zl6p9qsVMFL356j45icQJASKq2UtC5r
         dLyio0h/SvCTrqk9xPIL2rbOFzlfwHzWo5LDmcaLwNAVXG1nep/1lfVm8OlU2+hqLa
         61fUb80bcm0hQ==
Message-ID: <a6ce7776-68c7-3fd2-32ed-3981da4bf33b@kernel.org>
Date:   Fri, 18 Aug 2023 11:51:46 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH] PCI: endpoint: Return error code when callback is not
 implemented
Content-Language: en-US
To:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        rick.wertenbroek@heig-vd.ch
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230817133341.212747-1-rick.wertenbroek@gmail.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230817133341.212747-1-rick.wertenbroek@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2023/08/17 22:33, Rick Wertenbroek wrote:
> Return an error code when the callback for an endpoint controller
> function is not implemented (is null). Among all the functions, only
> map_msi_irq() had an error returned if the callback was null. Extend
> this error handling to other functions as well.
> 
> Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>

We should check for the mandatory ops definition in pci_epf_register_driver()
for function drivers and in __pci_epc_create() for controller drivers.

> ---
>  drivers/pci/endpoint/pci-epc-core.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index 5a4a8b0be626..14f4256b9410 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -196,7 +196,7 @@ int pci_epc_start(struct pci_epc *epc)
>  		return -EINVAL;
>  
>  	if (!epc->ops->start)
> -		return 0;
> +		return -EINVAL;
>  
>  	mutex_lock(&epc->lock);
>  	ret = epc->ops->start(epc);
> @@ -228,7 +228,7 @@ int pci_epc_raise_irq(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  		return -EINVAL;
>  
>  	if (!epc->ops->raise_irq)
> -		return 0;
> +		return -EINVAL;

ENOTSUPP ?

>  
>  	mutex_lock(&epc->lock);
>  	ret = epc->ops->raise_irq(epc, func_no, vfunc_no, type, interrupt_num);
> @@ -340,7 +340,7 @@ int pci_epc_set_msi(struct pci_epc *epc, u8 func_no, u8 vfunc_no, u8 interrupts)
>  		return -EINVAL;
>  
>  	if (!epc->ops->set_msi)
> -		return 0;
> +		return -EINVAL;

ENOTSUPP ?

>  
>  	encode_int = order_base_2(interrupts);
>  
> @@ -408,7 +408,7 @@ int pci_epc_set_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  		return -EINVAL;
>  
>  	if (!epc->ops->set_msix)
> -		return 0;
> +		return -EINVAL;

ENOTSUPP ?

>  
>  	mutex_lock(&epc->lock);
>  	ret = epc->ops->set_msix(epc, func_no, vfunc_no, interrupts - 1, bir,
> @@ -469,7 +469,7 @@ int pci_epc_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  		return -EINVAL;
>  
>  	if (!epc->ops->map_addr)
> -		return 0;
> +		return -EINVAL;

This one is definitely mandatory and should always be defined. So check in
__pci_epc_create() ?

>  
>  	mutex_lock(&epc->lock);
>  	ret = epc->ops->map_addr(epc, func_no, vfunc_no, phys_addr, pci_addr,
> @@ -537,7 +537,7 @@ int pci_epc_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  		return -EINVAL;
>  
>  	if (!epc->ops->set_bar)
> -		return 0;
> +		return -EINVAL;

Same.

>  
>  	mutex_lock(&epc->lock);
>  	ret = epc->ops->set_bar(epc, func_no, vfunc_no, epf_bar);
> @@ -575,7 +575,7 @@ int pci_epc_write_header(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  		return -EINVAL;
>  
>  	if (!epc->ops->write_header)
> -		return 0;
> +		return -EINVAL;

Same.

>  
>  	mutex_lock(&epc->lock);
>  	ret = epc->ops->write_header(epc, func_no, vfunc_no, header);

-- 
Damien Le Moal
Western Digital Research

