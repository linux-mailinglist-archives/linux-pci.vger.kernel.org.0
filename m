Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1F36321B4
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 13:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbiKUMRb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 07:17:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiKUMRa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 07:17:30 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2EBED4D;
        Mon, 21 Nov 2022 04:17:28 -0800 (PST)
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NG5qg1rZPz6H6rs;
        Mon, 21 Nov 2022 20:12:31 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 21 Nov 2022 13:17:23 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 21 Nov
 2022 12:17:23 +0000
Date:   Mon, 21 Nov 2022 12:17:20 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <rostedt@goodmis.org>, <terry.bowman@amd.com>,
        <bhelgaas@google.com>
Subject: Re: [PATCH v3 10/11] PCI/AER: Add optional logging callback for
 correctable error
Message-ID: <20221121121720.0000541d@Huawei.com>
In-Reply-To: <20221121120527.0000608e@Huawei.com>
References: <166879123216.674819.3578187187954311721.stgit@djiang5-desk3.ch.intel.com>
        <166879134199.674819.15564186577122699358.stgit@djiang5-desk3.ch.intel.com>
        <20221121120527.0000608e@Huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 21 Nov 2022 12:05:27 +0000
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Fri, 18 Nov 2022 10:09:02 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
> > Some new devices such as CXL devices may want to record additional error
> > information on a corrected error. Add a callback to allow the PCI device
> > driver to do additional logging and/or error handling.  
> 
> Probably want to be a little careful about talking about error handling for
> corrected errors.  It does make sense if you are doing stats based offlining
> of flaky parts of devices (we do this on some of our crypto and similar
> accelerators), but that isn't really 'error handling'.

Ah I'd also forgotten the mess of 'correctable' in PCIE (6.2.2.1 in PCIe r6.0 base)
Reality is that complex text means that the hardware can correct it without
intervention (though it may be other hardware, and it may not correct it, in which
case the source of the AER error should then issue an uncorrectable error message.)

Basic point stands but language is tricky around this.

Jonathan


> 
> Agreed with other review that it might warrant some documentation but as
> said their, Bjorn's call to make!
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> > 
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> > ---
> >  drivers/pci/pcie/aer.c |    8 +++++++-
> >  include/linux/pci.h    |    3 +++
> >  2 files changed, 10 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> > index e2d8a74f83c3..af1b5eecbb11 100644
> > --- a/drivers/pci/pcie/aer.c
> > +++ b/drivers/pci/pcie/aer.c
> > @@ -961,8 +961,14 @@ static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
> >  		if (aer)
> >  			pci_write_config_dword(dev, aer + PCI_ERR_COR_STATUS,
> >  					info->status);
> > -		if (pcie_aer_is_native(dev))
> > +		if (pcie_aer_is_native(dev)) {
> > +			struct pci_driver *pdrv = dev->driver;
> > +
> > +			if (pdrv && pdrv->err_handler &&
> > +			    pdrv->err_handler->cor_error_log)
> > +				pdrv->err_handler->cor_error_log(dev);
> >  			pcie_clear_device_status(dev);
> > +		}
> >  	} else if (info->severity == AER_NONFATAL)
> >  		pcie_do_recovery(dev, pci_channel_io_normal, aer_root_reset);
> >  	else if (info->severity == AER_FATAL)
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index 575849a100a3..54939b3426a9 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -844,6 +844,9 @@ struct pci_error_handlers {
> >  
> >  	/* Device driver may resume normal operations */
> >  	void (*resume)(struct pci_dev *dev);
> > +
> > +	/* Allow device driver to record more details of a correctable error */
> > +	void (*cor_error_log)(struct pci_dev *dev);
> >  };
> >  
> >  
> > 
> >   
> 

