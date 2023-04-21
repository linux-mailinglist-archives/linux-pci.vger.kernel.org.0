Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36A3A6EA7B6
	for <lists+linux-pci@lfdr.de>; Fri, 21 Apr 2023 11:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjDUJ7I (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Apr 2023 05:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbjDUJ7H (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Apr 2023 05:59:07 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D65FAD0B;
        Fri, 21 Apr 2023 02:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682071146; x=1713607146;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rAFsYIkaIU7P/XAdE8H660r0J/Gv+OzxiWnAIJBjL0Q=;
  b=jTypmE8KVHIk85mijDvlcoQEs9nP/67rMSAW6cAjZeUegqdF8iFUe8pi
   hSq1sFg72Sc1jkVCygeJkuPppQ60XK/bnp7EXWbnmenOv/igpnsFCMbgp
   EKLUDMuizVVYiqLvw16337PVi1bkAcMEOe1nz1bdVdMayoFNvQqVhJbd/
   8rP8lbjw4X9xTQFbI3vaQgjPHkuEhtSQvWtjVulWZ1+wLYSsLVThNk8lG
   NMaBD0G34eaR8Wlpwh8G+H9QHL/iOx8zj9GHSgeZq0puw8Q4NQnqTLGwk
   xfIuugly9/jzkpCyqAiB3D47lPzc9sBQEsVW98f3OLnD6hcTnCa/Om/H+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="334834622"
X-IronPort-AV: E=Sophos;i="5.99,214,1677571200"; 
   d="scan'208";a="334834622"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2023 02:59:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="803680543"
X-IronPort-AV: E=Sophos;i="5.99,214,1677571200"; 
   d="scan'208";a="803680543"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 21 Apr 2023 02:59:04 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ppnXi-003652-2Y;
        Fri, 21 Apr 2023 12:59:02 +0300
Date:   Fri, 21 Apr 2023 12:59:02 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rob Herring <robh@kernel.org>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 1/1] PCI: of: Propagate firmware node by calling
 device_set_node()
Message-ID: <ZEJeZh8CCPc7xqr9@smile.fi.intel.com>
References: <20230421092945.66176-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421092945.66176-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 21, 2023 at 12:29:45PM +0300, Andy Shevchenko wrote:
> Insulate pci_set_of_node() and pci_set_bus_of_node() from possible
> changes to fwnode_handle implementation by using device_set_node()
> instead of open-coding dev->dev.fwnode assignments.

Sorry, this version needs to be discarded. It has a non-squashed change and
hence can't be compiled.


-- 
With Best Regards,
Andy Shevchenko


