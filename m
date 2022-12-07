Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34B2C64625C
	for <lists+linux-pci@lfdr.de>; Wed,  7 Dec 2022 21:29:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiLGU30 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Dec 2022 15:29:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiLGU30 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Dec 2022 15:29:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1144724BC1;
        Wed,  7 Dec 2022 12:29:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8DB76B820C2;
        Wed,  7 Dec 2022 20:29:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FE7EC433C1;
        Wed,  7 Dec 2022 20:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670444962;
        bh=15f9nwrtK1BIJkRYRpnWxXqwzSLkIVykiGrI/xeb2+o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=VjsrNYtTI3A2LTyBPyy///78zr2qVjr32MoJT8Usll8xpunByHygzDiZl0C/fgWud
         gskY077REW3nS/ZOkr91CDK+HEZO9yeQ0xk9w4Lzh3KDuMq0suzdb36E6WJ4uuIxfn
         nMWnGISTD2/xq7hnv7xEMyyYwnSKwj++0VIzGtXhKuspgtI6TNRgvCy7znA8JNMPQQ
         1Tq4UMDK0QYYzHipGnG16l2T8OzOXKu3QrmqpuDcflyC7uotSYGl+U+Iw/zWEPhKMz
         3OZckVChA1RxwQ18aUYxQpH50tLM4+78jmlW0NZy2CmcBgZqjUH/uLtUU98YIuvSIR
         mtGjH0+9h/LZw==
Date:   Wed, 7 Dec 2022 14:29:20 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Terry Bowman <terry.bowman@amd.com>
Cc:     Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org, dan.j.williams@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, Jonathan.Cameron@huawei.com,
        bhelgaas@google.com
Subject: Re: [v6 11/11 PATCH] cxl/pci: Add callback to log AER correctable
 error
Message-ID: <20221207202920.GA1468863@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59c6e507-f67a-6ae5-4b3d-d836d86d5c0d@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Terry,

On Wed, Dec 07, 2022 at 02:04:17PM -0600, Terry Bowman wrote:
> On 11/30/22 18:02, Dave Jiang wrote:
> > Add AER error handler callback to read the RAS capability structure
> > correctable error (CE) status register for the CXL device. Log the
> > error as a trace event and clear the error. For CXL devices, the driver
> > also needs to write back to the status register to clear the
> > unmasked correctable errors.
> > 
> > See CXL spec rev3.0 8.2.4.16 for RAS capability structure CE Status
> > Register.
> > 
> > Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> > ---
> > 
> > v6:
> > - Update commit log to point to RAS capability structure. (Bjorn)
> > - Change cxl_correctable_error_logging() to cxl_cor_error_detected().
> >   (Bjorn)
> > 
> >  drivers/cxl/pci.c |   20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> > 
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > index 11f842df9807..02342830b612 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/pci.c
> > @@ -622,10 +622,30 @@ static void cxl_error_resume(struct pci_dev *pdev)
> >  		 dev->driver ? "successful" : "failed");
> >  }
> >  
> > +static void cxl_cor_error_detected(struct pci_dev *pdev)
> > +{
> > +	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> > +	struct cxl_memdev *cxlmd = cxlds->cxlmd;
> > +	struct device *dev = &cxlmd->dev;
> > +	void __iomem *addr;
> > +	u32 status;
> > +
> > +	if (!cxlds->regs.ras)
> > +		return;
> > +
> > +	addr = cxlds->regs.ras + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
> > +	status = le32_to_cpu(readl(addr));
> > +	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
> > +		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
> > +		trace_cxl_aer_correctable_error(dev_name(dev), status);
> > +	}
> > +}
> > +
> 
> This will log PCI AER CEs only if there is also a RAS CE. My
> understanding (could be the problem) is AER CE's are normally
> reported. Will this be inconsistent with other error AER CE
> handling?

I can't quite parse this, so let me ramble and see if we accidentally
converge on some understanding :)

cxl_cor_error_detected() is the .cor_error_detected handler, which is
called by the AER code in the PCI core.  So IIUC, we'll only get here
if that PCI core AER code is invoked via an AER interrupt, AER
polling, or an event from the ACPI APEI framework.

So I would expect "this will only log CXL RAS CEs if there is a PCI
AER CE", which is the opposite of what you said.  But I have no idea
at all about how CXL RAS CEs work.

It looks like aer_enable_rootport() sets PCI_ERR_ROOT_CMD_COR_EN, so I
would expect that AER CEs normally cause interrupts and would be
discovered that way.

> >  static const struct pci_error_handlers cxl_error_handlers = {
> >  	.error_detected	= cxl_error_detected,
> >  	.slot_reset	= cxl_slot_reset,
> >  	.resume		= cxl_error_resume,
> > +	.cor_error_detected	= cxl_cor_error_detected,
> >  };
> >  
> >  static struct pci_driver cxl_pci_driver = {
> > 
> > 
> 
