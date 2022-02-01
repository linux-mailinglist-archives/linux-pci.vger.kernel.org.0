Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50FD54A6805
	for <lists+linux-pci@lfdr.de>; Tue,  1 Feb 2022 23:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241196AbiBAWcA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Feb 2022 17:32:00 -0500
Received: from mga14.intel.com ([192.55.52.115]:9959 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234823AbiBAWcA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 1 Feb 2022 17:32:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643754720; x=1675290720;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VfsPPIa+HxLve6T7db4qBLlpdJ1WsNzzpYMJWjKmpdQ=;
  b=NHVCqOzg5FQ7DCOJibuxndoM/yz4Ha076PCJzl+PkebvNQOYvZU9qqXL
   kf0++v7MAErmbHQnJQtUFX2TVDYrdB5BdEWOwLIYYLlbucmNTZKO7830M
   idFZw7tQXOPlSf+SSPskIeTammbiN8c7tbr8gDM3pZ2ngjlJ/1mW1bAJH
   5bJh+tpA1n9Qq4ExXHOdHslAk0cXGtSt3rURoTed3W3jvn/in8/PEnhiR
   Pn/6wZKLzd3fq2rxecvMi9oaB8jcRrjnNhH9RWx96909iCH/pmtr+iF0Z
   CMmMuKhD3tfRX8xw6SWu8lTc8h012vkmk3ha192IsoO31S0HCNbkqCOLO
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10245"; a="248030450"
X-IronPort-AV: E=Sophos;i="5.88,335,1635231600"; 
   d="scan'208";a="248030450"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 14:32:00 -0800
X-IronPort-AV: E=Sophos;i="5.88,335,1635231600"; 
   d="scan'208";a="523233826"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 14:31:59 -0800
Date:   Tue, 1 Feb 2022 14:31:59 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH V6 09/10] cxl/mem: Retry reading CDAT on failure
Message-ID: <20220201223159.GQ785175@iweiny-DESK2.sc.intel.com>
Mail-Followup-To: Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org
References: <20220201071952.900068-1-ira.weiny@intel.com>
 <20220201071952.900068-10-ira.weiny@intel.com>
 <20220201185928.ffdgvnn6mcmo7by7@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220201185928.ffdgvnn6mcmo7by7@intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 01, 2022 at 10:59:28AM -0800, Widawsky, Ben wrote:
> On 22-01-31 23:19:51, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > The CDAT read may fail for a number of reasons but mainly it is possible
> > to get different parts of a valid state.  The checksum in the CDAT table
> > protects against this.
> > 
> > Now that the checksum is validated issue a retry if the CDAT read fails.
> > For now 2 retries are implemented.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > 
> > ---
> > NOTE: Is 2 enough?  Should this just be delayed until the time when the
> > data is actually needed and not there?
> 
> I can't speak to retries at all, but one small issue below. It might make sense
> if we keep this to make it a modparam.

Not a bad idea.

> 
> > 
> > Changes from V5:
> > 	New patch -- easy to push off or drop.
> > ---
> >  drivers/cxl/core/memdev.c | 17 ++++++++++++++++-
> >  1 file changed, 16 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> > index a01068e98333..11d721c56f08 100644
> > --- a/drivers/cxl/core/memdev.c
> > +++ b/drivers/cxl/core/memdev.c
> > @@ -356,7 +356,8 @@ static const struct file_operations cxl_memdev_fops = {
> >  	.llseek = noop_llseek,
> >  };
> >  
> > -static int read_cdat_data(struct cxl_memdev *cxlmd, struct cxl_dev_state *cxlds)
> > +static int __read_cdat_data(struct cxl_memdev *cxlmd,
> > +			    struct cxl_dev_state *cxlds)
> >  {
> >  	struct device *dev = &cxlmd->dev;
> >  	size_t cdat_length;
> > @@ -371,6 +372,20 @@ static int read_cdat_data(struct cxl_memdev *cxlmd, struct cxl_dev_state *cxlds)
> >  	return cxl_mem_cdat_read_table(cxlds, &cxlmd->cdat);
> >  }
> >  
> > +static int read_cdat_data(struct cxl_memdev *cxlmd,
> > +			  struct cxl_dev_state *cxlds)
> > +{
> > +	int retries = 2;
> > +	int rc;
> > +
> > +	while (--retries) {
> 
> You either want retries--, or retries = 3...

Opps yea.

Thanks,
Ira

> 
> > +		rc = __read_cdat_data(cxlmd, cxlds);
> > +		if (!rc)
> > +			break;
> > +	}
> > +	return rc;
> > +}
> > +
> >  struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
> >  {
> >  	struct cxl_memdev *cxlmd;
> > -- 
> > 2.31.1
> > 
