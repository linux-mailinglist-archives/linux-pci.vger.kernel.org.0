Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3A96E4585
	for <lists+linux-pci@lfdr.de>; Mon, 17 Apr 2023 12:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjDQKqz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Apr 2023 06:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjDQKqy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Apr 2023 06:46:54 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14457173B;
        Mon, 17 Apr 2023 03:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681728361; x=1713264361;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Zl3T2zPqgisxE4JmoP0kazuc2BiWOAtj0xIgW3CbnOg=;
  b=VoMF3nlEURTAvqBk8NoA7Ngh0gXuj9WT5GHv62TXu0W6lW1C7cWT4ceP
   9pYg5gBn0ErlPhCJx2SM7NoFfFMv/okt67gy12ije8RXvqVwkD47K130A
   E3N1YGAy44auQ3cIRL0aKVqjOIhFCIIED9MSO26742RbGd1DGz8Bl1z2X
   Azxx5NTRoo8sIiATzxwB4YvL8Kn0RSNMtapTw6fJOlGgWLOApeYyguZBK
   epvZf2Nmsr6W2KrLMr0CwsKEKUEXxeZCw35V9wvk5r9XxmUBlBRRU/wlK
   6SvDXl1fu3uc/kdL1kN2UqqRabQpKeZoFuVtNaJsBnlxdgVmQe/x9nDND
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="343615272"
X-IronPort-AV: E=Sophos;i="5.99,203,1677571200"; 
   d="scan'208";a="343615272"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 03:45:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="780024740"
X-IronPort-AV: E=Sophos;i="5.99,203,1677571200"; 
   d="scan'208";a="780024740"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Apr 2023 03:45:13 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1poMMB-0012zB-2w;
        Mon, 17 Apr 2023 13:45:11 +0300
Date:   Mon, 17 Apr 2023 13:45:11 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v1 1/1] PCI: of: Propagate firmware node
Message-ID: <ZD0jNxUjLIjyiiy/@smile.fi.intel.com>
References: <ZDgnGuycE5S6rlZk@smile.fi.intel.com>
 <20230414185545.GA206084@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230414185545.GA206084@bhelgaas>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 14, 2023 at 01:55:45PM -0500, Bjorn Helgaas wrote:
> On Thu, Apr 13, 2023 at 07:00:26PM +0300, Andy Shevchenko wrote:
> > On Wed, Apr 12, 2023 at 11:02:53AM -0500, Bjorn Helgaas wrote:
> > > On Wed, Apr 12, 2023 at 04:15:20PM +0300, Andy Shevchenko wrote:

...

> > > > Propagate firmware node by using a specific API call, i.e. device_set_node().
> > > 
> > > Can you add a line or two about *why* we should do this, e.g., is this
> > > headed toward some goal?
> > 
> > Because dereferencing the fwnode in struct device is preventing us from
> > modifications of how fwnode looks like in the future.
> 
> How do you want to express this in the commit log?  Something like
> this?
> 
>   Insulate pci_set_of_node() and pci_set_bus_of_node() from possible
>   changes to fwnode_handle implementation by using device_set_node()
>   instead of open-coding dev->dev.fwnode assignments.

Sounds good to me, thanks for the draft. I will do it in v2 this way.

-- 
With Best Regards,
Andy Shevchenko


