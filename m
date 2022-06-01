Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E76C539C63
	for <lists+linux-pci@lfdr.de>; Wed,  1 Jun 2022 06:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242164AbiFAEys (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Jun 2022 00:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241589AbiFAEyr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Jun 2022 00:54:47 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F29B9D06A;
        Tue, 31 May 2022 21:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654059286; x=1685595286;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aKg84/s6yFHRdNM0DCpugLBZclSxYw6qIlvYCF8pQgo=;
  b=A9fIvJ/YIe6IGmu0ItXBGPw9IJCf1uKTu/1VJU7z1l6XZboI9fTBLbbG
   fkS+tmB5lx5L2c9wenRTGYuYy15WboAUUfhTOsmc/3heMPJ+RgzGlu6Jk
   BBduOA2U7EruRLcQpVaAZxvSCVM8TUGcsZv11ktG6t2afN8fejOj1VVfe
   1hv5y3P5AGPVu+epRpHl5qG1eSVa/wDVQhXjtq/rMbSAI9S8vXaqMpRdM
   8O4wuRQDJJdVplbotW/yvjlkdsMj0b+OeRHqfNnqcY7G5F8bJbPo52Mp4
   bqrukeNmWUNFuREukBYitvIJC7JvAoKsRa9+4a1gPJDhodtlRJfgj/beb
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10364"; a="275481349"
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; 
   d="scan'208";a="275481349"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 21:54:45 -0700
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; 
   d="scan'208";a="645329689"
Received: from mdossant-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.154.135])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 21:54:45 -0700
Date:   Tue, 31 May 2022 21:54:44 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Alison Schofield <alison.schofield@intel.com>
Cc:     "Williams, Dan J" <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Verma, Vishal L" <vishal.l.verma@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Ben Widawsky <ben@bwidawsk.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V9 8/9] cxl/port: Retry reading CDAT on failure
Message-ID: <YpbxFL4hhZMT2eIW@iweiny-desk3>
References: <20220531152632.1397976-1-ira.weiny@intel.com>
 <20220531152632.1397976-9-ira.weiny@intel.com>
 <20220531170743.GA1457068@alison-desk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220531170743.GA1457068@alison-desk>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 31, 2022 at 10:07:43AM -0700, Alison Schofield wrote:
> On Tue, May 31, 2022 at 08:26:31AM -0700, Ira Weiny wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > The CDAT read may fail for a number of reasons but mainly it is possible
> > to get different parts of a valid state.  The checksum in the CDAT table
> > protects against this.
> > 
> > Now that the cdat data is validated issue a retries if the CDAT read
> > fails.  For now 5 retries are implemented.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > 
> > ---
> 
> snip
> 
> > +
> > +void read_cdat_data(struct cxl_port *port)
> > +{
> > +	int retries = 5;
> > +	int rc;
> > +
> > +	while (retries--) {
> > +		rc = __read_cdat_data(port);
> > +		if (!rc)
> > +			break;
> > +		dev_err(&port->dev,
> > +			"CDAT data read error rc=%d (retries %d)\n",
> > +			rc, retries);
> > +	}
> 
> Perhaps dev_dbg() on retries and dev_err() only when retries are exhausted.

Yes thanks!
Ira

> 
> 
> >  }
> >  EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);
> > -- 
> > 2.35.1
> > 
