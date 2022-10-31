Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEE161314F
	for <lists+linux-pci@lfdr.de>; Mon, 31 Oct 2022 08:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbiJaHkM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Oct 2022 03:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiJaHjy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Oct 2022 03:39:54 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1287650;
        Mon, 31 Oct 2022 00:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667201986; x=1698737986;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KunlMGY2/up5IfEsZKl1WSD35WH5qKwT2d8FLbQiDMc=;
  b=kgoShoEO8pwJlXTG2Xg/BCP7RqFinXEhUET0AYEPHgY9jNT7I1Y7y55d
   wcb7aAVwMKrStifsAXfVjFnD5y3LTuqZqJynY18NIYVOld+/b/JT4Zc5A
   NnAt0NLFKJS8f+K6u3UszpFDliFq9rFtq6YizwS15zB37ngo/zvVNFItf
   kT50dUDNFzoOHlVxyOPtzyIs/IY6eoZn6AgYrGbh8pEexZbKeTSbp/GFX
   Cmhdew7JJdidtQsLYnCiB/YlyTr5WOlvayzBELW5yCEFrxA2lxOkrOCh3
   CSDV0zb1haT35RcxuosNTRxPuXyZr9Na1yQv7vlOx6t8CLj6At0CMx1H6
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10516"; a="373049496"
X-IronPort-AV: E=Sophos;i="5.95,227,1661842800"; 
   d="scan'208";a="373049496"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2022 00:39:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10516"; a="758749258"
X-IronPort-AV: E=Sophos;i="5.95,227,1661842800"; 
   d="scan'208";a="758749258"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 31 Oct 2022 00:39:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 76B54155; Mon, 31 Oct 2022 09:40:06 +0200 (EET)
Date:   Mon, 31 Oct 2022 09:40:06 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Chris Chiu <chris.chiu@canonical.com>,
        linux-pci@vger.kernel.org, regressions@lists.linux.dev,
        linux-cxl@vger.kernel.org, linuxarm@huawei.com
Subject: Re: Regression: Re: [PATCH v2 4/6] PCI: Distribute available
 resources for root buses too
Message-ID: <Y1971qnaq6BJObDl@black.fi.intel.com>
References: <20220905080232.36087-1-mika.westerberg@linux.intel.com>
 <20220905080232.36087-5-mika.westerberg@linux.intel.com>
 <20221014124553.0000696f@huawei.com>
 <Y0lkeieF3WNV3P3Q@black.fi.intel.com>
 <20221014154858.000079f2@huawei.com>
 <Y1ZzRmi9fL9yHf7I@black.fi.intel.com>
 <Y1Z2GGgfZyzC2d1N@black.fi.intel.com>
 <Y1fYNsjmUFZsvteT@black.fi.intel.com>
 <Y1fjT6eyV8KVlNRp@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1fjT6eyV8KVlNRp@smile.fi.intel.com>
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Andy,

On Tue, Oct 25, 2022 at 04:23:27PM +0300, Andy Shevchenko wrote:
> On Tue, Oct 25, 2022 at 03:36:06PM +0300, Mika Westerberg wrote:
> > On Mon, Oct 24, 2022 at 02:25:12PM +0300, Mika Westerberg wrote:
> 
> Just for the record in case this code will formally go out
> 
> ...
> 
> > +			for (i = 0; i < PCI_ROM_RESOURCE; i++) {
> > +				const struct resource *dev_res = &dev->resource[i];
> 
> I believe this is a good candidate to have
> 
> #define for_each_pci_dev_resource(dev, res)			\
> 	for (unsigned int i = 0;				\
> 	     res = &(dev)->resource[i], i < PCI_ROM_RESOURCE;	\
> 	     i++)
> 
> Since we have many places in the kernel with such a snippet.

Sure makes sense, but I think that should be a separate patch series.
