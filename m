Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096394A8D34
	for <lists+linux-pci@lfdr.de>; Thu,  3 Feb 2022 21:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245080AbiBCU2L (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Feb 2022 15:28:11 -0500
Received: from mga02.intel.com ([134.134.136.20]:26035 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234566AbiBCU2K (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Feb 2022 15:28:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643920090; x=1675456090;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tB1HUyQO+nYJafkdVgFOWJU/qrAWAD/qIqDemUlXcmw=;
  b=Ig+Fydl95U4qgkPd5rGKioFwlq97gvZ4JcmbGpzhtvw2GV2emKikCQR7
   //zY9uJvAniyuYd3CcOfuBIZyrSwxMkBHnYdHUxWTP/4oBESXD916Qb4E
   57PuRATvrFN2R/VE6e9hlHuCr8ykUjPZU9AQyak/ol1PNNJbyY98WNquo
   8odWnwLkswQVhn9DnbgIXdY2C0jIw84gFhwlXAeYX6aOn9yfE9y12W48S
   JCo3F36ViBxZlG5oXvYAgOUa8RNuXJALL50lsUrN6qawg7GKC7z2ugIEw
   oYroElvuox5qSNQ3+od49kfTpDawkBEKGNPcNRZIdyn1+Iiz2q/vCQMCI
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10247"; a="235646203"
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="235646203"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 12:28:10 -0800
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="524069910"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 12:28:10 -0800
Date:   Thu, 3 Feb 2022 12:28:10 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH V6 01/10] PCI: Add vendor ID for the PCI SIG
Message-ID: <20220203202810.GX785175@iweiny-DESK2.sc.intel.com>
Mail-Followup-To: Bjorn Helgaas <helgaas@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>, linux-kernel@vger.kernel.org,
        linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
References: <20220201071952.900068-2-ira.weiny@intel.com>
 <20220203171112.GA103601@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220203171112.GA103601@bhelgaas>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 03, 2022 at 11:11:12AM -0600, Bjorn Helgaas wrote:
> On Mon, Jan 31, 2022 at 11:19:43PM -0800, ira.weiny@intel.com wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > This ID is used in DOE headers to identify protocols that are defined
> > within the PCI Express Base Specification.
> > 
> > Specified in Table 7-x2 of the Data Object Exchange ECN (approved 12 March
> > 2020) available from https://members.pcisig.com/wg/PCI-SIG/document/14143
> 
> Please update this citation to PCIe r6.0, sec 6.30.1.1, table 6-32.

Done.

Thanks,
Ira

> 
> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  include/linux/pci_ids.h | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> > index 011f2f1ea5bb..849f514cd7db 100644
> > --- a/include/linux/pci_ids.h
> > +++ b/include/linux/pci_ids.h
> > @@ -149,6 +149,7 @@
> >  #define PCI_CLASS_OTHERS		0xff
> >  
> >  /* Vendors and devices.  Sort key: vendor first, device next. */
> > +#define PCI_VENDOR_ID_PCI_SIG		0x0001
> >  
> >  #define PCI_VENDOR_ID_LOONGSON		0x0014
> >  
> > -- 
> > 2.31.1
> > 
