Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B02D971F670
	for <lists+linux-pci@lfdr.de>; Fri,  2 Jun 2023 01:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjFAXQu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Jun 2023 19:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjFAXQt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Jun 2023 19:16:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02745184;
        Thu,  1 Jun 2023 16:16:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82C1C64AB3;
        Thu,  1 Jun 2023 23:16:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C66EDC433EF;
        Thu,  1 Jun 2023 23:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685661407;
        bh=QIfFhx5u+Ra1POnRvDFUKQ2b+lKtqy8Hz4JMbyxum6c=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XMEC7DXqPkUrv0YimB04FP+rf/Fwy9hUXkgFaOJ3X9AAlB9aSul2+I/i+rNtA3dKk
         QSbjOdWlA8GFfgrNmr6/zc86AQSIH2eC9ai1V5eOOHdVHMo58FiMEBjl0Hz6wASbN9
         0Vskax3tZ3i768YEMFEmJjOp3iWGqYGtAE1ClLWYz71XMZqo/o0BxCuL631fT7yEH1
         NJ0C6HM06hCpiyBHcidCWlZb42PvUkFHIeQO6lOvyuCyET/OU0lmqtLAXyl0IOTAsP
         w3nQACQy358biMz4dC3+a8HmIEl5/s0l4t/+sYjJBf2hlYVWgKeDc0Ul9b8ZYDJq5M
         27bmY1bQQALsg==
Message-ID: <65ed4b9f-a153-7c7b-6462-a5c11024a1f6@kernel.org>
Date:   Fri, 2 Jun 2023 08:16:45 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5 3/9] PCI: endpoint: Pass EPF device ID to the probe
 function
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        lpieralisi@kernel.org, kw@linux.com
Cc:     kishon@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20230601145718.12204-1-manivannan.sadhasivam@linaro.org>
 <20230601145718.12204-4-manivannan.sadhasivam@linaro.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230601145718.12204-4-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 6/1/23 23:57, Manivannan Sadhasivam wrote:
> Currently, the EPF probe function doesn't get the device ID argument needed
> to correctly identify the device table ID of the EPF device.
> 
> When multiple entries are added to the "struct pci_epf_device_id" table,
> the probe function needs to identify the correct one. This is achieved by
> modifying the pci_epf_match_id() function to return the match ID pointer
> and passing it to the driver's probe function.
> 
> pci_epf_device_match() function can return bool based on the return value
> of pci_epf_match_id().
> 
> Reviewed-by: Kishon Vijay Abraham I <kishon@kernel.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

[...]

>  static int pci_epf_device_match(struct device *dev, struct device_driver *drv)
> @@ -510,8 +510,12 @@ static int pci_epf_device_match(struct device *dev, struct device_driver *drv)
>  	struct pci_epf *epf = to_pci_epf(dev);
>  	struct pci_epf_driver *driver = to_pci_epf_driver(drv);
>  
> -	if (driver->id_table)
> -		return pci_epf_match_id(driver->id_table, epf);
> +	if (driver->id_table) {
> +		if (pci_epf_match_id(driver->id_table, epf))
> +			return true;
> +		else
> +			return false;

		return pci_epf_match_id(driver->id_table, epf) != NULL;

is simpler. If you do not like this, at least drop the "else" as it is not
necessary at all.

> +	}
>  
>  	return !strcmp(epf->name, drv->name);
>  }
> @@ -520,13 +524,15 @@ static int pci_epf_device_probe(struct device *dev)
>  {
>  	struct pci_epf *epf = to_pci_epf(dev);
>  	struct pci_epf_driver *driver = to_pci_epf_driver(dev->driver);
> +	const struct pci_epf_device_id *id;
>  
>  	if (!driver->probe)
>  		return -ENODEV;
>  
>  	epf->driver = driver;
> +	id = pci_epf_match_id(driver->id_table, epf);

Not sure that the id variable is that useful.

>  
> -	return driver->probe(epf);
> +	return driver->probe(epf, id);
>  }

-- 
Damien Le Moal
Western Digital Research

