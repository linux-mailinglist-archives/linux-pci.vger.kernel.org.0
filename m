Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4134C6BF1B0
	for <lists+linux-pci@lfdr.de>; Fri, 17 Mar 2023 20:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjCQTbG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Mar 2023 15:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjCQTbG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Mar 2023 15:31:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E77EF82;
        Fri, 17 Mar 2023 12:31:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9C0E9B826AD;
        Fri, 17 Mar 2023 19:30:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33344C433EF;
        Fri, 17 Mar 2023 19:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679081458;
        bh=lnEDqKzb3mX5y3332ZIAEeWNU38nficQPQNsR0UtPlk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=AeqHvmafVW963V9vGxQq4PnUEVGOp9bZgq23HSCkmCRYLAHH0kBU9NbgjGzftlRqc
         iY7eu4LyjvPG6imVHbZcO47U2TBbbR6IuLfU/rU37BkIuGBzNJtS8Rvuzrirg/qeO3
         fLTNJv1XZPanrDEv5EE/qTrRkuT/oJWjbuAlT+7EIyfpd102ILVswCpn5iCerLo+zH
         mkZuPG6U6QRfw76QCf9hWuFENJoykG3Y24YeXXQelObSjn2+OXCPYZTRg9e0B0Pjmd
         7ZH45wUeAW9ZwnTgGRKE90runga5U8bvbvqyF42WklurocVerHX/g8vxifAcXLAApH
         iucVHFd0rw/gQ==
Date:   Fri, 17 Mar 2023 14:30:56 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Grant Grundler <grundler@chromium.org>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Oliver O 'Halloran <oohall@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Rajat Khandelwal <rajat.khandelwal@linux.intel.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Rajat Jain <rajatja@chromium.org>
Subject: Re: [PATCHv2 pci-next 1/2] PCI/AER: correctable error message as
 KERN_INFO
Message-ID: <20230317193056.GA1963022@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd48a3f0-138d-9c48-27d6-a5133f054c96@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 17, 2023 at 11:50:22AM -0700, Sathyanarayanan Kuppuswamy wrote:
> On 3/17/23 10:51 AM, Grant Grundler wrote:
> > Since correctable errors have been corrected (and counted), the dmesg output
> > should not be reported as a warning, but rather as "informational".
> > 
> > Otherwise, using a certain well known vendor's PCIe parts in a USB4 docking
> > station, the dmesg buffer can be spammed with correctable errors, 717 bytes
> > per instance, potentially many MB per day.
> 
> Why don't you investigate why you are getting so many correctable errors?
> Isn't solving the problem preferable to hiding the logs?

I hope there's some effort to find the cause of the errors, too.  But
I do think KERN_INFO is a reasonable level for errors that have
already been corrected.  KERN_ERR seems a little bit too severe to me.

Does changing to KERN_INFO keep the messages out of the dmesg log?  I
don't think it does, because *most* kernel messages are at KERN_INFO.
This may be just a commit log clarification.

I would like to know *which* devices are involved.  Is there some
reason for weasel-wording this?  Knowing which devices are involved
helps in triaging issue reports.  If there are any public reports on
mailing lists, etc, we could also cite those here to help users find
this solution.

> > Given the "WARN" priority, these messages have already confused the typical
> > user that stumbles across them, support staff (triaging feedback reports),
> > and more than a few linux kernel devs. Changing to INFO will hide these
> > messages from most audiences.
> > 
> > Signed-off-by: Grant Grundler <grundler@chromium.org>
> > ---
> >  drivers/pci/pcie/aer.c | 29 +++++++++++++++++++----------
> >  1 file changed, 19 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> > index f6c24ded134c..cb6b96233967 100644
> > --- a/drivers/pci/pcie/aer.c
> > +++ b/drivers/pci/pcie/aer.c
> > @@ -687,23 +687,29 @@ static void __aer_print_error(struct pci_dev *dev,
> >  {
> >  	const char **strings;
> >  	unsigned long status = info->status & ~info->mask;
> > -	const char *level, *errmsg;
> >  	int i;
> >  
> >  	if (info->severity == AER_CORRECTABLE) {
> >  		strings = aer_correctable_error_string;
> > -		level = KERN_WARNING;
> > +		pci_info(dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n",
> > +			info->status, info->mask);
> >  	} else {
> >  		strings = aer_uncorrectable_error_string;
> > -		level = KERN_ERR;
> > +		pci_err(dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n",
> > +			info->status, info->mask);
> >  	}
> >  
> >  	for_each_set_bit(i, &status, 32) {
> > -		errmsg = strings[i];
> > +		const char *errmsg = strings[i];
> > +
> >  		if (!errmsg)
> >  			errmsg = "Unknown Error Bit";
> >  
> > -		pci_printk(level, dev, "   [%2d] %-22s%s\n", i, errmsg,
> > +		if (info->severity == AER_CORRECTABLE)
> > +			pci_info(dev, "   [%2d] %-22s%s\n", i, errmsg,
> > +				info->first_error == i ? " (First)" : "");
> > +		else
> > +			pci_err(dev, "   [%2d] %-22s%s\n", i, errmsg,
> >  				info->first_error == i ? " (First)" : "");

The - 5 lines, + 11 lines diff and repetition of the printk strings
doesn't seem like an improvement compared to the -1, +1 in the v1
patch:

  @@ -692,7 +692,7 @@ static void __aer_print_error(struct pci_dev *dev,

          if (info->severity == AER_CORRECTABLE) {
                  strings = aer_correctable_error_string;
  -               level = KERN_WARNING;
  +               level = KERN_INFO;
          } else {

But maybe there's a reason?

> >  	}
> >  	pci_dev_aer_stats_incr(dev, info);
> > @@ -724,7 +730,7 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
> >  	layer = AER_GET_LAYER_ERROR(info->severity, info->status);
> >  	agent = AER_GET_AGENT(info->severity, info->status);
> >  
> > -	level = (info->severity == AER_CORRECTABLE) ? KERN_WARNING : KERN_ERR;
> > +	level = (info->severity == AER_CORRECTABLE) ? KERN_INFO : KERN_ERR;
> >  
> >  	pci_printk(level, dev, "PCIe Bus Error: severity=%s, type=%s, (%s)\n",
> >  		   aer_error_severity_string[info->severity],
> > @@ -797,14 +803,17 @@ void cper_print_aer(struct pci_dev *dev, int aer_severity,
> >  	info.mask = mask;
> >  	info.first_error = PCI_ERR_CAP_FEP(aer->cap_control);
> >  
> > -	pci_err(dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", status, mask);
> >  	__aer_print_error(dev, &info);
> > -	pci_err(dev, "aer_layer=%s, aer_agent=%s\n",
> > -		aer_error_layer[layer], aer_agent_string[agent]);
> >  
> > -	if (aer_severity != AER_CORRECTABLE)
> > +	if (aer_severity == AER_CORRECTABLE) {
> > +		pci_info(dev, "aer_layer=%s, aer_agent=%s\n",
> > +			aer_error_layer[layer], aer_agent_string[agent]);
> > +	} else {
> > +		pci_err(dev, "aer_layer=%s, aer_agent=%s\n",
> > +			aer_error_layer[layer], aer_agent_string[agent]);
> >  		pci_err(dev, "aer_uncor_severity: 0x%08x\n",
> >  			aer->uncor_severity);
> > +	}
> >  
> >  	if (tlp_header_valid)
> >  		__print_tlp_header(dev, &aer->header_log);
> 
> -- 
> Sathyanarayanan Kuppuswamy
> Linux Kernel Developer
