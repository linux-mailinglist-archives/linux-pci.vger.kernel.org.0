Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96D2665ED81
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jan 2023 14:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjAENnD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Jan 2023 08:43:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233384AbjAENnB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Jan 2023 08:43:01 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABBE93726B
        for <linux-pci@vger.kernel.org>; Thu,  5 Jan 2023 05:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672926180; x=1704462180;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kIEXQCByY6Q78c4ODeYJKCEQoeUQjlV1WZZjm/t5PE8=;
  b=YsjgHLBSGmxMN4tQnYPdMcsvDc7bsPDVQ2NGa16EnCjxrxJay023X0T4
   OqhkYFq03XglFXolhcdLnF8bPRg7CD/LPJyJMDdh7aGECClNcDYE6fe72
   oZb51hcDbI9buh7cmPucGKEFhFTM3hA+eEfncVbiV9Z/m1iHfJz434Mlv
   BJcmu4Qg/EqYor/BL1h6D07QiBrB2UNGGgOc3iAZIQgioAVQq4RQI6UTQ
   bJ6yGkzdBqGQNwQkbt8xRWx8i0q0FcpknSDWOO4319X/dWFIabJUGRVFw
   I/J7Iq74TgrftJeJEFjYL2zvX/4GMDu+fHaOtoDvoteA6NRuzNGyR+WhZ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="386637257"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="386637257"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 05:42:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="718829709"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="718829709"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 05 Jan 2023 05:42:56 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 5A78A162; Thu,  5 Jan 2023 15:43:29 +0200 (EET)
Date:   Thu, 5 Jan 2023 15:43:29 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lukas Wunner <lukas@wunner.de>,
        Chris Chiu <chris.chiu@canonical.com>,
        Alexander Motin <mav@ixsystems.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 1/2] PCI: Take other bus devices into account when
 distributing resources
Message-ID: <Y7bUAaxt6viswdXV@black.fi.intel.com>
References: <20230104091635.63331-2-mika.westerberg@linux.intel.com>
 <20230104224809.GA1094900@bhelgaas>
 <Y7aUa/xVSEXUiovm@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y7aUa/xVSEXUiovm@black.fi.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Thu, Jan 05, 2023 at 11:12:11AM +0200, Mika Westerberg wrote:
> > What happens in a topology like this:
> > 
> >   10:00.0 non-hotplug bridge to [bus 20-3f]
> >   10:01.0 non-hotplug bridge to [bus 40]
> >   20:00.0 hotplug bridge
> >   40:00.0 NIC
> > 
> > where we're distributing space on "bus" 10, hotplug_bridges == 0 and
> > normal_bridges == 2?  Do we give half the extra space to bus 20 and
> > the other half to bus 40, even though we could tell up front that bus
> > 20 is the only place that can actually use any extra space?
> 
> Yes we split it into half.

Forgot to reply also that would it make sense here to look at below the
non-hotplug bridges and if we find hotplug bridges, distribute the space
equally between those or something like that?
