Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8A91720140
	for <lists+linux-pci@lfdr.de>; Fri,  2 Jun 2023 14:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235100AbjFBMNi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Jun 2023 08:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234584AbjFBMNh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Jun 2023 08:13:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B94E45;
        Fri,  2 Jun 2023 05:13:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4178064F95;
        Fri,  2 Jun 2023 12:13:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73F44C433D2;
        Fri,  2 Jun 2023 12:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685708008;
        bh=wrlUAYPUsiyFPiAWekNQyVQvjnIRqqk5f7BG+O2tCWU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JEdHLHHqV/PLIHYik3/lbF3A/6VThKt/2mBMPOdYnPyVilS+AmADe5xiE6YjFFJVD
         iHNmXMrI2NJcdDwYVdPNEb0JZVXDO7O72c3ArZmA6YZ/0h5bex/mipXDkdQ1gHkuFV
         Wy2TiFFrAh3h2JHTKoX/4JG/tUdgFHPOnUkqJhl9yNPLAilcl2p370qTYK2cbxq0hA
         J6wo+Mnr7UO+UaBlQf5Egp7+LGVX6yiz0cEWkNpl81Y3mTvjwuwn1h7l0R8g6wM9vM
         UtQm9HjFNeBtOKXd2O8sr7Oj8VC4+2iKYHNPk9xYGl2Jt8JIHsbGsTRquPLw66zEiL
         cN+pDCdgujgiA==
Message-ID: <fdf5ea08-f3a1-3c9f-66a3-1cfa3743dae2@kernel.org>
Date:   Fri, 2 Jun 2023 21:13:25 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v6 2/9] PCI: endpoint: Pass EPF device ID to the probe
 function
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        lpieralisi@kernel.org, kw@linux.com
Cc:     kishon@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20230602114756.36586-1-manivannan.sadhasivam@linaro.org>
 <20230602114756.36586-3-manivannan.sadhasivam@linaro.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230602114756.36586-3-manivannan.sadhasivam@linaro.org>
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

On 6/2/23 20:47, Manivannan Sadhasivam wrote:
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

You prefer keeping this pattern ?

return pci_epf_match_id(driver->id_table, epf) != NULL;

is no much nicer !

Anyway:

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

