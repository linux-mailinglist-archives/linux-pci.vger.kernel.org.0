Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B987B722224
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jun 2023 11:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjFEJ1S (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Jun 2023 05:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjFEJ1R (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Jun 2023 05:27:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6CD9A7;
        Mon,  5 Jun 2023 02:27:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C1AC611AA;
        Mon,  5 Jun 2023 09:27:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77195C433EF;
        Mon,  5 Jun 2023 09:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685957234;
        bh=4h2WQXfCpkoJoJVHphZHv2Ei0DS5DsnSmeNwFvDAVaE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=saGSIKqEydR1raQNRLzmf/VtTQSopt9VDwv94L+uuXqjdqJYkja1NkoGEPrMUtnVi
         gkDNQkdBGRyMNk7kxf9/5nOyM+9R6HANxSiJ+Mbg2B/6db9AoUGUR6Wb+HLV1R/r8R
         DDe8hXdj4PErKbiBxrj0znHjRQvaRs2qUWujE1OMiy4az9BQr4s7Evm6fim7Xn0XLq
         SiDeRG0Wh+Hpdn0e+TMwtgqrmO25I3layVX8Lsny0WJu68us0q3X2L2yLrxsjkyo/j
         b7yAET9Nkvs81AHWWcXuMp+2jI+IgkDj1qrbktV6DXXKEvb+69l2dod/end7PwBwkh
         VMBKo6ijRnu4A==
Date:   Mon, 5 Jun 2023 11:27:09 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     kw@linux.com, kishon@kernel.org, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, dlemoal@kernel.org
Subject: Re: [PATCH v6 2/9] PCI: endpoint: Pass EPF device ID to the probe
 function
Message-ID: <ZH2qbS1I25lIMOPi@lpieralisi>
References: <20230602114756.36586-1-manivannan.sadhasivam@linaro.org>
 <20230602114756.36586-3-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230602114756.36586-3-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 02, 2023 at 05:17:49PM +0530, Manivannan Sadhasivam wrote:
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
> ---
>  drivers/pci/endpoint/functions/pci-epf-ntb.c  |  3 ++-
>  drivers/pci/endpoint/functions/pci-epf-test.c |  2 +-
>  drivers/pci/endpoint/functions/pci-epf-vntb.c |  2 +-
>  drivers/pci/endpoint/pci-epf-core.c           | 18 +++++++++++-------
>  include/linux/pci-epf.h                       |  4 +++-
>  5 files changed, 18 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-ntb.c b/drivers/pci/endpoint/functions/pci-epf-ntb.c
> index 9a00448c7e61..980b4ecf19a2 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-ntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-ntb.c
> @@ -2075,11 +2075,12 @@ static struct config_group *epf_ntb_add_cfs(struct pci_epf *epf,
>  /**
>   * epf_ntb_probe() - Probe NTB function driver
>   * @epf: NTB endpoint function device
> + * @id: NTB endpoint function device ID
>   *
>   * Probe NTB function driver when endpoint function bus detects a NTB
>   * endpoint function.
>   */
> -static int epf_ntb_probe(struct pci_epf *epf)
> +static int epf_ntb_probe(struct pci_epf *epf, const struct pci_epf_device_id *id)
>  {
>  	struct epf_ntb *ntb;
>  	struct device *dev;
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 0f9d2ec822ac..d5fcc78a5b73 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -980,7 +980,7 @@ static const struct pci_epf_device_id pci_epf_test_ids[] = {
>  	{},
>  };
>  
> -static int pci_epf_test_probe(struct pci_epf *epf)
> +static int pci_epf_test_probe(struct pci_epf *epf, const struct pci_epf_device_id *id)
>  {
>  	struct pci_epf_test *epf_test;
>  	struct device *dev = &epf->dev;
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index b7c7a8af99f4..122eb7a12028 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -1401,7 +1401,7 @@ static struct pci_epf_ops epf_ntb_ops = {
>   *
>   * Returns: Zero for success, or an error code in case of failure
>   */
> -static int epf_ntb_probe(struct pci_epf *epf)
> +static int epf_ntb_probe(struct pci_epf *epf, const struct pci_epf_device_id *id)
>  {
>  	struct epf_ntb *ntb;
>  	struct device *dev;
> diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
> index 2036e38be093..ea6e0aef0bb3 100644
> --- a/drivers/pci/endpoint/pci-epf-core.c
> +++ b/drivers/pci/endpoint/pci-epf-core.c
> @@ -493,16 +493,16 @@ static const struct device_type pci_epf_type = {
>  	.release	= pci_epf_dev_release,
>  };
>  
> -static int
> -pci_epf_match_id(const struct pci_epf_device_id *id, const struct pci_epf *epf)
> +static const struct pci_epf_device_id
> +*pci_epf_match_id(const struct pci_epf_device_id *id, const struct pci_epf *epf)
>  {
>  	while (id->name[0]) {
>  		if (strcmp(epf->name, id->name) == 0)
> -			return true;
> +			return id;
>  		id++;
>  	}
>  
> -	return false;
> +	return NULL;
>  }
>  
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
> +	}
>  
>  	return !strcmp(epf->name, drv->name);
>  }
> @@ -526,7 +530,7 @@ static int pci_epf_device_probe(struct device *dev)
>  
>  	epf->driver = driver;
>  
> -	return driver->probe(epf);
> +	return driver->probe(epf, pci_epf_match_id(driver->id_table, epf));

I don't think we should do it this way. If we are probing a driver that
means that we have got a driver that matches a device id. The device id
is a property of the device, there is no reason why we should pass it
to the probe function, it has got to be stored somewhere at device
creation stage (well, not in the match function - since that's what
we changed), probe() should retrieve it from the device structure.

Thanks,
Lorenzo

>  }
>  
>  static void pci_epf_device_remove(struct device *dev)
> diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
> index a215dc8ce693..bc613f0df7e3 100644
> --- a/include/linux/pci-epf.h
> +++ b/include/linux/pci-epf.h
> @@ -89,7 +89,7 @@ struct pci_epc_event_ops {
>   * @id_table: identifies EPF devices for probing
>   */
>  struct pci_epf_driver {
> -	int	(*probe)(struct pci_epf *epf);
> +	int	(*probe)(struct pci_epf *epf, const struct pci_epf_device_id *id);
>  	void	(*remove)(struct pci_epf *epf);
>  
>  	struct device_driver	driver;
> @@ -131,6 +131,7 @@ struct pci_epf_bar {
>   * @epc: the EPC device to which this EPF device is bound
>   * @epf_pf: the physical EPF device to which this virtual EPF device is bound
>   * @driver: the EPF driver to which this EPF device is bound
> + * @id: Pointer to the EPF device ID
>   * @list: to add pci_epf as a list of PCI endpoint functions to pci_epc
>   * @lock: mutex to protect pci_epf_ops
>   * @sec_epc: the secondary EPC device to which this EPF device is bound
> @@ -158,6 +159,7 @@ struct pci_epf {
>  	struct pci_epc		*epc;
>  	struct pci_epf		*epf_pf;
>  	struct pci_epf_driver	*driver;
> +	const struct pci_epf_device_id *id;
>  	struct list_head	list;
>  	/* mutex to protect against concurrent access of pci_epf_ops */
>  	struct mutex		lock;
> -- 
> 2.25.1
> 
