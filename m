Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54EB53953C
	for <lists+linux-pci@lfdr.de>; Tue, 31 May 2022 19:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346398AbiEaRHb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 May 2022 13:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346387AbiEaRHa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 May 2022 13:07:30 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532E3813FF;
        Tue, 31 May 2022 10:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654016849; x=1685552849;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NqozLsA3zOu8MYgmMLS1kw8UHYU8GaM+8XImuFdDSWY=;
  b=l8/t4Psq5gzVPs+cT6Ef4aABrAtlUQrRrivdi2T7MduYWGctu7eSCZ8h
   mK6fzMCN7M0EWFRal8jCDZYk+JIRn/RFIUlD2ghy0Es3ak01ZOu8ZVJEe
   7YQYfmEI4oBuFVRqh0I/+Eqvpv4mbkqtdlknu9QaaJnSS0jXlUd4wkt+B
   cGq19fH3mPRc11n6Mee0L8imGjKTCM8dCJDBb+6S8CkHYe/dRtEsGFO3Z
   Tkn3eFDNzWg60GAqHH7FMDcoh79CECBL1QjzMnINB5pzZzJ7lapGoYm9c
   X25D277kS8U2mV4cTheCmYQBTOct/6+YyCVibJjNLWGBhAzHLlHAOw0kT
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10364"; a="335980272"
X-IronPort-AV: E=Sophos;i="5.91,265,1647327600"; 
   d="scan'208";a="335980272"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 10:07:28 -0700
X-IronPort-AV: E=Sophos;i="5.91,265,1647327600"; 
   d="scan'208";a="551880444"
Received: from alison-desk.jf.intel.com (HELO alison-desk) ([10.54.74.41])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 10:07:28 -0700
Date:   Tue, 31 May 2022 10:07:43 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     "Weiny, Ira" <ira.weiny@intel.com>
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
Message-ID: <20220531170743.GA1457068@alison-desk>
References: <20220531152632.1397976-1-ira.weiny@intel.com>
 <20220531152632.1397976-9-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220531152632.1397976-9-ira.weiny@intel.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 31, 2022 at 08:26:31AM -0700, Ira Weiny wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> The CDAT read may fail for a number of reasons but mainly it is possible
> to get different parts of a valid state.  The checksum in the CDAT table
> protects against this.
> 
> Now that the cdat data is validated issue a retries if the CDAT read
> fails.  For now 5 retries are implemented.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---

snip

> +
> +void read_cdat_data(struct cxl_port *port)
> +{
> +	int retries = 5;
> +	int rc;
> +
> +	while (retries--) {
> +		rc = __read_cdat_data(port);
> +		if (!rc)
> +			break;
> +		dev_err(&port->dev,
> +			"CDAT data read error rc=%d (retries %d)\n",
> +			rc, retries);
> +	}

Perhaps dev_dbg() on retries and dev_err() only when retries are exhausted.


>  }
>  EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);
> -- 
> 2.35.1
> 
