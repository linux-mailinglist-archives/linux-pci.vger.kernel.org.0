Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B24EE714EC7
	for <lists+linux-pci@lfdr.de>; Mon, 29 May 2023 19:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjE2RKm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 May 2023 13:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjE2RKl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 May 2023 13:10:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295B4B5;
        Mon, 29 May 2023 10:10:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0A97627B8;
        Mon, 29 May 2023 17:10:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F872C433D2;
        Mon, 29 May 2023 17:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685380238;
        bh=icOoIcHZHuyObZGLJmbuGYHHOvu2g465XhkK0FjSWjg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eerBi9kzma/XE4N0Iw4e1qUrw0O4JmkMvxNKAdZCCqFzKWf28HH3XCEiTtCvWj/jY
         zlAsJqicSse/criOMZkHpSzbxSSo0NGHwWRBEGDvnWeFC8EIIRMwQHlQJRcmCv3jUF
         CF2HZkbVl0Z0VVwCM5ri0TjpDrUL//cg09689PNCvAC0hmHjFodVuQ9Z82hA1VRg5+
         sL5EaPwRGUCLu/idxlwZhjchFVeaHeb7NVgsjorrqt2EFNVrA2nKMwTC0Mbrws+q6A
         VaS3yodFTYPoFahIhFOxK6a/0F0aV/kMH4DHL/uE68EmvvkA2k+MNLGRtioiU4r9UN
         b2+MijrfQZSag==
Date:   Mon, 29 May 2023 22:40:24 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        kw@linux.com, kishon@kernel.org, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v4 1/7] PCI: endpoint: Pass EPF device ID to the probe
 function
Message-ID: <20230529171024.GF5633@thinkpad>
References: <20230519144215.25167-1-manivannan.sadhasivam@linaro.org>
 <20230519144215.25167-2-manivannan.sadhasivam@linaro.org>
 <ZHRyA1BzK3KaGUEH@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZHRyA1BzK3KaGUEH@lpieralisi>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 29, 2023 at 11:36:03AM +0200, Lorenzo Pieralisi wrote:
> On Fri, May 19, 2023 at 08:12:09PM +0530, Manivannan Sadhasivam wrote:
> > Currently, the EPF probe function doesn't get the device ID argument needed
> > to correctly identify the device table ID of the EPF device.
> > 
> > When multiple entries are added to the "struct pci_epf_device_id" table,
> > the probe function needs to identify the correct one. And the only way to
> > do so is by storing the correct device ID in "struct pci_epf" during
> > "pci_epf_match_id()" and passing that to probe().
> > 
> > Reviewed-by: Kishon Vijay Abraham I <kishon@kernel.org>
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/pci/endpoint/functions/pci-epf-ntb.c  | 3 ++-
> >  drivers/pci/endpoint/functions/pci-epf-test.c | 2 +-
> >  drivers/pci/endpoint/functions/pci-epf-vntb.c | 2 +-
> >  drivers/pci/endpoint/pci-epf-core.c           | 8 +++++---
> >  include/linux/pci-epf.h                       | 4 +++-
> >  5 files changed, 12 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-ntb.c b/drivers/pci/endpoint/functions/pci-epf-ntb.c
> > index 9a00448c7e61..980b4ecf19a2 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-ntb.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-ntb.c
> > @@ -2075,11 +2075,12 @@ static struct config_group *epf_ntb_add_cfs(struct pci_epf *epf,
> >  /**
> >   * epf_ntb_probe() - Probe NTB function driver
> >   * @epf: NTB endpoint function device
> > + * @id: NTB endpoint function device ID
> >   *
> >   * Probe NTB function driver when endpoint function bus detects a NTB
> >   * endpoint function.
> >   */
> > -static int epf_ntb_probe(struct pci_epf *epf)
> > +static int epf_ntb_probe(struct pci_epf *epf, const struct pci_epf_device_id *id)
> >  {
> >  	struct epf_ntb *ntb;
> >  	struct device *dev;
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> > index 0f9d2ec822ac..d5fcc78a5b73 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> > @@ -980,7 +980,7 @@ static const struct pci_epf_device_id pci_epf_test_ids[] = {
> >  	{},
> >  };
> >  
> > -static int pci_epf_test_probe(struct pci_epf *epf)
> > +static int pci_epf_test_probe(struct pci_epf *epf, const struct pci_epf_device_id *id)
> >  {
> >  	struct pci_epf_test *epf_test;
> >  	struct device *dev = &epf->dev;
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > index b7c7a8af99f4..122eb7a12028 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > @@ -1401,7 +1401,7 @@ static struct pci_epf_ops epf_ntb_ops = {
> >   *
> >   * Returns: Zero for success, or an error code in case of failure
> >   */
> > -static int epf_ntb_probe(struct pci_epf *epf)
> > +static int epf_ntb_probe(struct pci_epf *epf, const struct pci_epf_device_id *id)
> >  {
> >  	struct epf_ntb *ntb;
> >  	struct device *dev;
> > diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
> > index 2036e38be093..924564288c9a 100644
> > --- a/drivers/pci/endpoint/pci-epf-core.c
> > +++ b/drivers/pci/endpoint/pci-epf-core.c
> > @@ -494,11 +494,13 @@ static const struct device_type pci_epf_type = {
> >  };
> >  
> >  static int
> > -pci_epf_match_id(const struct pci_epf_device_id *id, const struct pci_epf *epf)
> > +pci_epf_match_id(const struct pci_epf_device_id *id, struct pci_epf *epf)
> >  {
> >  	while (id->name[0]) {
> > -		if (strcmp(epf->name, id->name) == 0)
> > +		if (strcmp(epf->name, id->name) == 0) {
> > +			epf->id = id;
> >  			return true;
> > +		}
> >  		id++;
> >  	}
> 
> I disagree with this patch's intent. The match function should not
> change the parameters state. We should export this function to drivers
> so that upon probe they can retrieve the matching id themselves,
> as other bus interfaces do IMO.
> 

Ok, if you do not want to change the parameters inside match function, then I
could move the matching part to a separate function and make it to return the
correct pci_epf_device_id pointer. Based on this, the match() function can
return bool if the match is found or not and the pci_epf_device_probe() function
can pass the returned id to the driver's probe function. This is what being done
for PCI driver as well [1].

- Mani

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/pci-driver.c#n415

> Thanks,
> Lorenzo
> 
> > @@ -526,7 +528,7 @@ static int pci_epf_device_probe(struct device *dev)
> >  
> >  	epf->driver = driver;
> >  
> > -	return driver->probe(epf);
> > +	return driver->probe(epf, epf->id);
> >  }
> >  
> >  static void pci_epf_device_remove(struct device *dev)
> > diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
> > index a215dc8ce693..bc613f0df7e3 100644
> > --- a/include/linux/pci-epf.h
> > +++ b/include/linux/pci-epf.h
> > @@ -89,7 +89,7 @@ struct pci_epc_event_ops {
> >   * @id_table: identifies EPF devices for probing
> >   */
> >  struct pci_epf_driver {
> > -	int	(*probe)(struct pci_epf *epf);
> > +	int	(*probe)(struct pci_epf *epf, const struct pci_epf_device_id *id);
> >  	void	(*remove)(struct pci_epf *epf);
> >  
> >  	struct device_driver	driver;
> > @@ -131,6 +131,7 @@ struct pci_epf_bar {
> >   * @epc: the EPC device to which this EPF device is bound
> >   * @epf_pf: the physical EPF device to which this virtual EPF device is bound
> >   * @driver: the EPF driver to which this EPF device is bound
> > + * @id: Pointer to the EPF device ID
> >   * @list: to add pci_epf as a list of PCI endpoint functions to pci_epc
> >   * @lock: mutex to protect pci_epf_ops
> >   * @sec_epc: the secondary EPC device to which this EPF device is bound
> > @@ -158,6 +159,7 @@ struct pci_epf {
> >  	struct pci_epc		*epc;
> >  	struct pci_epf		*epf_pf;
> >  	struct pci_epf_driver	*driver;
> > +	const struct pci_epf_device_id *id;
> >  	struct list_head	list;
> >  	/* mutex to protect against concurrent access of pci_epf_ops */
> >  	struct mutex		lock;
> > -- 
> > 2.25.1
> > 

-- 
மணிவண்ணன் சதாசிவம்
