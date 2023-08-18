Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F78780A71
	for <lists+linux-pci@lfdr.de>; Fri, 18 Aug 2023 12:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359248AbjHRKsC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Aug 2023 06:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376400AbjHRKri (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Aug 2023 06:47:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4283B2D4A;
        Fri, 18 Aug 2023 03:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692355654; x=1723891654;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=L2/7zFIPzogzojCzxiEemOdNcaZD2rn/kxBFrZ8q7nU=;
  b=IBIw2dafAEzWQM8dqUC65zaJG5rSbZXqG7ulCI2pQ/1YwlbJibuDme0K
   IwG9qRn9HoKTxzNW37iNibjflVocwfzW7gF1Z1hk6ikb5cEIZBih1GAm0
   rEoqo6bmD4/y3C4J/Wx/V65lSNG08NJW7KDC4/QQfnbP9b5xunSKE1Ebu
   tkSTQly1KbbE+Q/azZIbz1jEA4vdu7oWBBPGDE4L2c1DFs4/x9WQCvMGr
   wuaVlahyhvgx8p76xsj8pT2/2gqE0d/icGY06cw7ZtIWw7I6uFpl1SHHW
   5jqCzPwOosLapl15UJtHJwn5RLiHwBq3/K7PVayT0QdVLAsvAeZ/Wy+uK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="352663329"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="352663329"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 03:47:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="684861769"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="684861769"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 18 Aug 2023 03:47:30 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qWx0q-004LO4-0z;
        Fri, 18 Aug 2023 13:47:28 +0300
Date:   Fri, 18 Aug 2023 13:47:28 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Iain Lane <iain@orangesquash.org.uk>,
        Shyam-sundar S-k <Shyam-sundar.S-k@amd.com>
Subject: Re: [PATCH v13 09/12] ACPI: x86: s2idle: Add a function to get
 constraints for a device
Message-ID: <ZN9MQMjcNZK+Ul9z@smile.fi.intel.com>
References: <20230818051319.551-1-mario.limonciello@amd.com>
 <20230818051319.551-10-mario.limonciello@amd.com>
 <CAJZ5v0heB1yGcEzJCA88tyEhFi_LDWcHAF6xsrEFgH4j-DmT7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0heB1yGcEzJCA88tyEhFi_LDWcHAF6xsrEFgH4j-DmT7Q@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 18, 2023 at 10:31:03AM +0200, Rafael J. Wysocki wrote:
> On Fri, Aug 18, 2023 at 7:15 AM Mario Limonciello
> <mario.limonciello@amd.com> wrote:

...

> > +int acpi_get_lps0_constraint(struct device *dev)
> 
> I think that some overhead would be reduced below if this were taking
> a struct acpi_device pointer as the argument.

Hmm... Either you need a pointer to handle, which involves pointer arithmetics
or something else. I would believe if you tell that ACPI handle should be passed,
but current suggestion is not obvious to me how it may help.

> > +{
> > +       struct lpi_constraints *entry;
> > +
> > +       for_each_lpi_constraint(entry) {
> > +               if (!device_match_acpi_handle(dev, entry->handle))

Here we retrieve handle...

> > +                       continue;
> > +               acpi_handle_debug(entry->handle,
> > +                                 "ACPI device constraint: %d\n", entry->min_dstate);
> > +               return entry->min_dstate;
> > +       }

> > +       dev_dbg(dev, "No ACPI device constraint specified\n");

...and here we are using dev directly (otherwise acpi_handle_dbg() should be used).

> > +       return -ENODEV;
> 
> ACPI_STATE_UNKNOWN?
> 
> > +}

-- 
With Best Regards,
Andy Shevchenko


