Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D976E1305
	for <lists+linux-pci@lfdr.de>; Thu, 13 Apr 2023 19:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbjDMRBk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Apr 2023 13:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjDMRBh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Apr 2023 13:01:37 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3E1AD36;
        Thu, 13 Apr 2023 10:01:27 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Py5Rs3LFVz67M1H;
        Fri, 14 Apr 2023 01:00:25 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 13 Apr
 2023 18:01:24 +0100
Date:   Thu, 13 Apr 2023 18:01:22 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Terry Bowman <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
        <rrichter@amd.com>, <linux-kernel@vger.kernel.org>,
        <bhelgaas@google.com>, "Oliver O'Halloran" <oohall@gmail.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v3 6/6] PCI/AER: Unmask RCEC internal errors to enable
 RCH downstream port error handling
Message-ID: <20230413180122.00007471@Huawei.com>
In-Reply-To: <20230412212901.GA81099@bhelgaas>
References: <20230411180302.2678736-7-terry.bowman@amd.com>
        <20230412212901.GA81099@bhelgaas>
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

On Wed, 12 Apr 2023 16:29:01 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Tue, Apr 11, 2023 at 01:03:02PM -0500, Terry Bowman wrote:
> > From: Robert Richter <rrichter@amd.com>
> > 
> > RCEC AER corrected and uncorrectable internal errors (CIE/UIE) are
> > disabled by default.  
> 
> "Disabled by default" just means "the power-up state of CIE/UIC is
> that they are masked", right?  It doesn't mean that Linux normally
> masks them.
> 
> > [1][2] Enable them to receive CXL downstream port
> > errors of a Restricted CXL Host (RCH).
> > 
> > [1] CXL 3.0 Spec, 12.2.1.1 - RCH Downstream Port Detected Errors
> > [2] PCIe Base Spec 6.0, 7.8.4.3 Uncorrectable Error Mask Register,
> >     7.8.4.6 Correctable Error Mask Register
> > 
> > Co-developed-by: Terry Bowman <terry.bowman@amd.com>
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> > Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> > Cc: "Oliver O'Halloran" <oohall@gmail.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
> > Cc: linuxppc-dev@lists.ozlabs.org
> > Cc: linux-pci@vger.kernel.org
> > ---
> >  drivers/pci/pcie/aer.c | 73 ++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 73 insertions(+)
> > 
> > diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> > index 171a08fd8ebd..3973c731e11d 100644
> > --- a/drivers/pci/pcie/aer.c
> > +++ b/drivers/pci/pcie/aer.c
> > @@ -1000,7 +1000,79 @@ static void cxl_handle_error(struct pci_dev *dev, struct aer_err_info *info)
> >  		pcie_walk_rcec(dev, cxl_handle_error_iter, info);
> >  }
> >  
> > +static bool cxl_error_is_native(struct pci_dev *dev)
> > +{
> > +	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
> > +
> > +	if (pcie_ports_native)
> > +		return true;
> > +
> > +	return host->native_aer && host->native_cxl_error;
> > +}
> > +
> > +static int handles_cxl_error_iter(struct pci_dev *dev, void *data)
> > +{
> > +	int *handles_cxl = data;
> > +
> > +	*handles_cxl = is_cxl_mem_dev(dev) && cxl_error_is_native(dev);
> > +
> > +	return *handles_cxl;
> > +}
> > +
> > +static bool handles_cxl_errors(struct pci_dev *rcec)
> > +{
> > +	int handles_cxl = 0;
> > +
> > +	if (!rcec->aer_cap)
> > +		return false;
> > +
> > +	if (pci_pcie_type(rcec) == PCI_EXP_TYPE_RC_EC)
> > +		pcie_walk_rcec(rcec, handles_cxl_error_iter, &handles_cxl);
> > +
> > +	return !!handles_cxl;
> > +}
> > +
> > +static int __cxl_unmask_internal_errors(struct pci_dev *rcec)
> > +{
> > +	int aer, rc;
> > +	u32 mask;
> > +
> > +	/*
> > +	 * Internal errors are masked by default, unmask RCEC's here
> > +	 * PCI6.0 7.8.4.3 Uncorrectable Error Mask Register (Offset 08h)
> > +	 * PCI6.0 7.8.4.6 Correctable Error Mask Register (Offset 14h)
> > +	 */  
> 
> Unmasking internal errors doesn't have anything specific to do with
> CXL, so I don't think it should have "cxl" in the function name.
> Maybe something like "pci_aer_unmask_internal_errors()".

This reminds me.  Not sure we resolved earlier discussion on changing
the system wide policy to turn these on 
https://lore.kernel.org/linux-cxl/20221229172731.GA611562@bhelgaas/
which needs pretty much the same thing.

Ira, I think you were picking this one up?
https://lore.kernel.org/linux-cxl/63e5fb533f304_13244829412@iweiny-mobl.notmuch/

Thanks,

Jonathan


> 
> This also has nothing special to do with RCECs, so I think we should
> refer to the device as "dev" as is typical in this file.
> 
> I think this needs to check pcie_aer_is_native() as is done by
> pci_aer_clear_nonfatal_status() and other functions that write the AER
> Capability.
> 
> With the exception of this function, this patch looks like all CXL
> code that maybe could be with other CXL code.  Would require making
> pcie_walk_rcec() available outside drivers/pci, I guess.
> 
> > +	aer = rcec->aer_cap;
> > +	rc = pci_read_config_dword(rcec, aer + PCI_ERR_UNCOR_MASK, &mask);
> > +	if (rc)
> > +		return rc;
> > +	mask &= ~PCI_ERR_UNC_INTN;
> > +	rc = pci_write_config_dword(rcec, aer + PCI_ERR_UNCOR_MASK, mask);
> > +	if (rc)
> > +		return rc;
> > +
> > +	rc = pci_read_config_dword(rcec, aer + PCI_ERR_COR_MASK, &mask);
> > +	if (rc)
> > +		return rc;
> > +	mask &= ~PCI_ERR_COR_INTERNAL;
> > +	rc = pci_write_config_dword(rcec, aer + PCI_ERR_COR_MASK, mask);
> > +
> > +	return rc;
> > +}
> > +
> > +static void cxl_unmask_internal_errors(struct pci_dev *rcec)
> > +{
> > +	if (!handles_cxl_errors(rcec))
> > +		return;
> > +
> > +	if (__cxl_unmask_internal_errors(rcec))
> > +		dev_err(&rcec->dev, "cxl: Failed to unmask internal errors");
> > +	else
> > +		dev_dbg(&rcec->dev, "cxl: Internal errors unmasked");
> > +}
> > +
> >  #else
> > +static inline void cxl_unmask_internal_errors(struct pci_dev *dev) { }
> >  static inline void cxl_handle_error(struct pci_dev *dev,
> >  				    struct aer_err_info *info) { }
> >  #endif
> > @@ -1397,6 +1469,7 @@ static int aer_probe(struct pcie_device *dev)
> >  		return status;
> >  	}
> >  
> > +	cxl_unmask_internal_errors(port);
> >  	aer_enable_rootport(rpc);
> >  	pci_info(port, "enabled with IRQ %d\n", dev->irq);
> >  	return 0;
> > -- 
> > 2.34.1
> >   

