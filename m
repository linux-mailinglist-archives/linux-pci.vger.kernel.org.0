Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D48227226DF
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jun 2023 15:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjFENHH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Jun 2023 09:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbjFENHG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Jun 2023 09:07:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6570F3;
        Mon,  5 Jun 2023 06:07:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6AB8162436;
        Mon,  5 Jun 2023 13:07:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8E01C433D2;
        Mon,  5 Jun 2023 13:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685970422;
        bh=MdnA0TEI1LhjxzWTzMSKxbRUxbALBBBQJBq1qX98PJA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N4ovtdykBuMV2sbhetK9hHefmZTqyVfAIDO2waa6gWMaIv+R03iGJuwiklCTQ+qYF
         dlcW90MOWfi0AEbtGMr+axpe5m1te/ltOWjK3ufzc9f9Rr68RNJwligLJuRcJkoCDp
         9+Z9tmHqS3JS/qZQltQIveIAixhr9LDit/aDxlW7WsooYA2lB3HfxMfZ6TrOfSPtoH
         z2bdihjZzLRS8t8KD4FfyiBC0rrSKNt+uSphAjTnA6fgUto8OP4MJaKkxeyqu/Iz+J
         Xu7W6WQcQe+0skQQDRhAQVyoK4iInW3+DoyqhdwCCP45yTMCxDXpRUlPAqIkvCQYyn
         unPpc79BPPr6g==
Date:   Mon, 5 Jun 2023 15:06:57 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     kw@linux.com, kishon@kernel.org, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, dlemoal@kernel.org
Subject: Re: [PATCH v6 2/9] PCI: endpoint: Pass EPF device ID to the probe
 function
Message-ID: <ZH3d8S1V3u8ppM62@lpieralisi>
References: <20230602114756.36586-1-manivannan.sadhasivam@linaro.org>
 <20230602114756.36586-3-manivannan.sadhasivam@linaro.org>
 <ZH2qbS1I25lIMOPi@lpieralisi>
 <20230605115746.GD5536@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230605115746.GD5536@thinkpad>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 05, 2023 at 05:27:46PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Jun 05, 2023 at 11:27:09AM +0200, Lorenzo Pieralisi wrote:
> > On Fri, Jun 02, 2023 at 05:17:49PM +0530, Manivannan Sadhasivam wrote:
> > > Currently, the EPF probe function doesn't get the device ID argument needed
> > > to correctly identify the device table ID of the EPF device.
> > > 
> > > When multiple entries are added to the "struct pci_epf_device_id" table,
> > > the probe function needs to identify the correct one. This is achieved by
> > > modifying the pci_epf_match_id() function to return the match ID pointer
> > > and passing it to the driver's probe function.
> > > 
> > > pci_epf_device_match() function can return bool based on the return value
> > > of pci_epf_match_id().
> > > 
> > > Reviewed-by: Kishon Vijay Abraham I <kishon@kernel.org>
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > ---
> > >  drivers/pci/endpoint/functions/pci-epf-ntb.c  |  3 ++-
> > >  drivers/pci/endpoint/functions/pci-epf-test.c |  2 +-
> > >  drivers/pci/endpoint/functions/pci-epf-vntb.c |  2 +-
> > >  drivers/pci/endpoint/pci-epf-core.c           | 18 +++++++++++-------
> > >  include/linux/pci-epf.h                       |  4 +++-
> > >  5 files changed, 18 insertions(+), 11 deletions(-)
> > > 
> > > diff --git a/drivers/pci/endpoint/functions/pci-epf-ntb.c b/drivers/pci/endpoint/functions/pci-epf-ntb.c
> > > index 9a00448c7e61..980b4ecf19a2 100644
> > > --- a/drivers/pci/endpoint/functions/pci-epf-ntb.c
> > > +++ b/drivers/pci/endpoint/functions/pci-epf-ntb.c
> > > @@ -2075,11 +2075,12 @@ static struct config_group *epf_ntb_add_cfs(struct pci_epf *epf,
> > >  /**
> > >   * epf_ntb_probe() - Probe NTB function driver
> > >   * @epf: NTB endpoint function device
> > > + * @id: NTB endpoint function device ID
> > >   *
> > >   * Probe NTB function driver when endpoint function bus detects a NTB
> > >   * endpoint function.
> > >   */
> > > -static int epf_ntb_probe(struct pci_epf *epf)
> > > +static int epf_ntb_probe(struct pci_epf *epf, const struct pci_epf_device_id *id)
> > >  {
> > >  	struct epf_ntb *ntb;
> > >  	struct device *dev;
> > > diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> > > index 0f9d2ec822ac..d5fcc78a5b73 100644
> > > --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> > > +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> > > @@ -980,7 +980,7 @@ static const struct pci_epf_device_id pci_epf_test_ids[] = {
> > >  	{},
> > >  };
> > >  
> > > -static int pci_epf_test_probe(struct pci_epf *epf)
> > > +static int pci_epf_test_probe(struct pci_epf *epf, const struct pci_epf_device_id *id)
> > >  {
> > >  	struct pci_epf_test *epf_test;
> > >  	struct device *dev = &epf->dev;
> > > diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > > index b7c7a8af99f4..122eb7a12028 100644
> > > --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > > +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > > @@ -1401,7 +1401,7 @@ static struct pci_epf_ops epf_ntb_ops = {
> > >   *
> > >   * Returns: Zero for success, or an error code in case of failure
> > >   */
> > > -static int epf_ntb_probe(struct pci_epf *epf)
> > > +static int epf_ntb_probe(struct pci_epf *epf, const struct pci_epf_device_id *id)
> > >  {
> > >  	struct epf_ntb *ntb;
> > >  	struct device *dev;
> > > diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
> > > index 2036e38be093..ea6e0aef0bb3 100644
> > > --- a/drivers/pci/endpoint/pci-epf-core.c
> > > +++ b/drivers/pci/endpoint/pci-epf-core.c
> > > @@ -493,16 +493,16 @@ static const struct device_type pci_epf_type = {
> > >  	.release	= pci_epf_dev_release,
> > >  };
> > >  
> > > -static int
> > > -pci_epf_match_id(const struct pci_epf_device_id *id, const struct pci_epf *epf)
> > > +static const struct pci_epf_device_id
> > > +*pci_epf_match_id(const struct pci_epf_device_id *id, const struct pci_epf *epf)
> > >  {
> > >  	while (id->name[0]) {
> > >  		if (strcmp(epf->name, id->name) == 0)
> > > -			return true;
> > > +			return id;
> > >  		id++;
> > >  	}
> > >  
> > > -	return false;
> > > +	return NULL;
> > >  }
> > >  
> > >  static int pci_epf_device_match(struct device *dev, struct device_driver *drv)
> > > @@ -510,8 +510,12 @@ static int pci_epf_device_match(struct device *dev, struct device_driver *drv)
> > >  	struct pci_epf *epf = to_pci_epf(dev);
> > >  	struct pci_epf_driver *driver = to_pci_epf_driver(drv);
> > >  
> > > -	if (driver->id_table)
> > > -		return pci_epf_match_id(driver->id_table, epf);
> > > +	if (driver->id_table) {
> > > +		if (pci_epf_match_id(driver->id_table, epf))
> > > +			return true;
> > > +		else
> > > +			return false;
> > > +	}
> > >  
> > >  	return !strcmp(epf->name, drv->name);
> > >  }
> > > @@ -526,7 +530,7 @@ static int pci_epf_device_probe(struct device *dev)
> > >  
> > >  	epf->driver = driver;
> > >  
> > > -	return driver->probe(epf);
> > > +	return driver->probe(epf, pci_epf_match_id(driver->id_table, epf));
> > 
> > I don't think we should do it this way. If we are probing a driver that
> > means that we have got a driver that matches a device id. The device id
> > is a property of the device, there is no reason why we should pass it
> > to the probe function, it has got to be stored somewhere at device
> > creation stage (well, not in the match function - since that's what
> > we changed), probe() should retrieve it from the device structure.
> > 
> 
> Device id defined by the drivers will only be known during the match() stage as
> that's when the drivers are queried for match of the device. During device
> creation stage, there is no way for the EPF core to fetch the ids.
> 
> And, passing id during probe() is not new. For most of the non-platform devices,
> the bus driver will pass the id. The PCI core itself is doing the same for the
> client drivers as well and I'd like to keep it same for EPF also:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/pci.h#n921

Right - I mixed things up (driver->probe() vs bus->probe), apologies,
it makes sense.

Lorenzo

> 
> - Mani
> 
> > Thanks,
> > Lorenzo
> > 
> > >  }
> > >  
> > >  static void pci_epf_device_remove(struct device *dev)
> > > diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
> > > index a215dc8ce693..bc613f0df7e3 100644
> > > --- a/include/linux/pci-epf.h
> > > +++ b/include/linux/pci-epf.h
> > > @@ -89,7 +89,7 @@ struct pci_epc_event_ops {
> > >   * @id_table: identifies EPF devices for probing
> > >   */
> > >  struct pci_epf_driver {
> > > -	int	(*probe)(struct pci_epf *epf);
> > > +	int	(*probe)(struct pci_epf *epf, const struct pci_epf_device_id *id);
> > >  	void	(*remove)(struct pci_epf *epf);
> > >  
> > >  	struct device_driver	driver;
> > > @@ -131,6 +131,7 @@ struct pci_epf_bar {
> > >   * @epc: the EPC device to which this EPF device is bound
> > >   * @epf_pf: the physical EPF device to which this virtual EPF device is bound
> > >   * @driver: the EPF driver to which this EPF device is bound
> > > + * @id: Pointer to the EPF device ID
> > >   * @list: to add pci_epf as a list of PCI endpoint functions to pci_epc
> > >   * @lock: mutex to protect pci_epf_ops
> > >   * @sec_epc: the secondary EPC device to which this EPF device is bound
> > > @@ -158,6 +159,7 @@ struct pci_epf {
> > >  	struct pci_epc		*epc;
> > >  	struct pci_epf		*epf_pf;
> > >  	struct pci_epf_driver	*driver;
> > > +	const struct pci_epf_device_id *id;
> > >  	struct list_head	list;
> > >  	/* mutex to protect against concurrent access of pci_epf_ops */
> > >  	struct mutex		lock;
> > > -- 
> > > 2.25.1
> > > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்
