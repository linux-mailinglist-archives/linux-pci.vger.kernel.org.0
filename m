Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB9953AF2E
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jun 2022 00:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbiFAWKQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Jun 2022 18:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232206AbiFAWKP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Jun 2022 18:10:15 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE17579BB;
        Wed,  1 Jun 2022 15:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654121413; x=1685657413;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/lpCuAoiby3BDlfBda3ngBvjf+tEQMORsxcOdj/4Jw4=;
  b=hPvtkE/8YJDLwmX+dC+qdTKLuEITkI2bu7WqdnacphFAFhwUc9whbakG
   ofoRWELW0SDegsvKntDFvoEfRP+ldmWjMPAKo1wbq5HjBg3U940pcriLH
   wMRxBA4dTCauzSQnGIQdqEbE64MIH7iWJdHHNDKF2UKFZ+sXGuyelg7bC
   qNrbT/WYFckS7Hp+CykxAn4chxlGi0wfC7cYCX8dg4OISr45s/y04Kd3B
   cojyMkdwOeO8RJ3P++YnFwvBjgQ81lv9UU3ksC71OnnjZ0lDB0pB+4mPX
   rEXYsoGctBK1RbwymKPMFrgE5HsEjfpw1ighJfTpLNf+LC6xlu8V4ork3
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="275471734"
X-IronPort-AV: E=Sophos;i="5.91,269,1647327600"; 
   d="scan'208";a="275471734"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 15:10:12 -0700
X-IronPort-AV: E=Sophos;i="5.91,269,1647327600"; 
   d="scan'208";a="530277500"
Received: from cwmurphy-mobl2.amr.corp.intel.com (HELO localhost) ([10.212.32.23])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 15:10:11 -0700
Date:   Wed, 1 Jun 2022 15:10:11 -0700
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
Subject: Re: [PATCH V9 7/9] cxl/port: Introduce cxl_cdat_valid()
Message-ID: <Ypfjw/5xiKZKWWNu@iweiny-desk3>
References: <20220531152632.1397976-1-ira.weiny@intel.com>
 <20220531152632.1397976-8-ira.weiny@intel.com>
 <20220531172146.GB1457068@alison-desk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220531172146.GB1457068@alison-desk>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 31, 2022 at 10:21:46AM -0700, Alison Schofield wrote:
> On Tue, May 31, 2022 at 08:26:30AM -0700, Ira Weiny wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > The CDAT data is protected by a checksum and should be the proper
> > length.
> > 
> > Introduce cxl_cdat_valid() to validate the data.  While at it check and
> > store the sequence number.
> > 
> Store it for ?

To see if a subsequent read shows new data.

> 
> >  
> > +static bool cxl_cdat_valid(struct device *dev, struct cxl_cdat *cdat)
> > +{
> 
> snip
> 
> > +
> > +	seq = FIELD_GET(CDAT_HEADER_DW3_SEQUENCE, table[3]);
> > +	/* Store the sequence for now. */
> > +	if (cdat->seq != seq) {
> > +		dev_info(dev, "CDAT seq change %x -> %x\n", cdat->seq, seq);
> > +		cdat->seq = seq;
> > +	}
> > +
> 
> Wondering when does/will this sequence number come into play?
>

Not until we start reacting to changes in CDAT.

Ira
