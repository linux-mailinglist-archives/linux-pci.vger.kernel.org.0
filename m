Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C356539560
	for <lists+linux-pci@lfdr.de>; Tue, 31 May 2022 19:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344312AbiEaRVz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 May 2022 13:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242921AbiEaRVy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 May 2022 13:21:54 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5145BE5B;
        Tue, 31 May 2022 10:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654017713; x=1685553713;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=R5JfpM7H4eup/6oG0EDoqUqrbb8Ht/9aCZoxZVszKps=;
  b=BRW4cyutBEpFzeXbC4E65vOXGWRIdG9PGI2ybmcjQmhrRncUYAlM5CI0
   Eb/CaMeCZvL5IveeyrRvJB3xyI88z6+/AwOfAE+4xiLWKhpLh0V7xLHj4
   fBHOsMzFSMLgefhDdxShDKhVMLzGfy/2tEIkBVsNFvO3QK6Edeo3z4V0o
   4m5KpZH/RJmVkQF3oe7ZUWYbMjnDzY/OQvNDYV+aNEv+vstzFbrQAwsGM
   +YVKk9RNK2QBN4ZgxBm5K0HEMMAzJqRsA8fbn2KFbDiPBUYDz6of4Bo4A
   jIRQZJL+haIYOzjNNjc7G34P6Wy/KJtwq9NlsITaBZgcMuz9W7DD/BLsm
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10364"; a="262961166"
X-IronPort-AV: E=Sophos;i="5.91,265,1647327600"; 
   d="scan'208";a="262961166"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 10:21:31 -0700
X-IronPort-AV: E=Sophos;i="5.91,265,1647327600"; 
   d="scan'208";a="576504827"
Received: from alison-desk.jf.intel.com (HELO alison-desk) ([10.54.74.41])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 10:21:31 -0700
Date:   Tue, 31 May 2022 10:21:46 -0700
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
Subject: Re: [PATCH V9 7/9] cxl/port: Introduce cxl_cdat_valid()
Message-ID: <20220531172146.GB1457068@alison-desk>
References: <20220531152632.1397976-1-ira.weiny@intel.com>
 <20220531152632.1397976-8-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220531152632.1397976-8-ira.weiny@intel.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 31, 2022 at 08:26:30AM -0700, Ira Weiny wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> The CDAT data is protected by a checksum and should be the proper
> length.
> 
> Introduce cxl_cdat_valid() to validate the data.  While at it check and
> store the sequence number.
> 
Store it for ?

>  
> +static bool cxl_cdat_valid(struct device *dev, struct cxl_cdat *cdat)
> +{

snip

> +
> +	seq = FIELD_GET(CDAT_HEADER_DW3_SEQUENCE, table[3]);
> +	/* Store the sequence for now. */
> +	if (cdat->seq != seq) {
> +		dev_info(dev, "CDAT seq change %x -> %x\n", cdat->seq, seq);
> +		cdat->seq = seq;
> +	}
> +

Wondering when does/will this sequence number come into play?

> 
