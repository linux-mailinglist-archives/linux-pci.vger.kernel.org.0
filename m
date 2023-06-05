Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0759722886
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jun 2023 16:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjFEOPc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Jun 2023 10:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234335AbjFEOOg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Jun 2023 10:14:36 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303B51FCB;
        Mon,  5 Jun 2023 07:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685974427; x=1717510427;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GfKziZD35fNJ09mFCN3tpjRPym+2PZlHeYnbNWOYIPk=;
  b=mnn3+rKRZafWO++ql4/Y1y1NY6o/FZaj58QZz5QLJRek+K3RVAjxFUp8
   eP+vQD71YeSLaNYQznO/mJXpCttwy9nPovdSuN9YcWjZ+txnpQAyNqer7
   gfBGHAb5+dFErp2TDgptb/DQFao5/1R5HOs1U+4B0XeJdYj21fvWEmSC4
   qNcLKSafgaEgI9Oa5PmiRMcXzKOOwW3Zcb+yFKmRVokp56vJgB7KfouDr
   ocKZQVqvBGsxgv9p3nDkpVVuJYxvKYk2BuXliYmLCoAGbbvwCamfjy2kR
   1R5Mf9rUDNsC37r+RbaHTtdNEPXv/vq6oLvsGgcJjFcrRYToFFHxdBYI9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="422202924"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="422202924"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 07:13:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="798456293"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="798456293"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Jun 2023 07:13:28 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q6Axb-001OG5-0A;
        Mon, 05 Jun 2023 17:13:27 +0300
Date:   Mon, 5 Jun 2023 17:13:26 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rob Herring <robh@kernel.org>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v3 1/1] PCI: of: Propagate firmware node by calling
 device_set_node()
Message-ID: <ZH3thu1rk3H3BmVd@smile.fi.intel.com>
References: <20230421100939.68225-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421100939.68225-1-andriy.shevchenko@linux.intel.com>
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

On Fri, Apr 21, 2023 at 01:09:39PM +0300, Andy Shevchenko wrote:
> Insulate pci_set_of_node() and pci_set_bus_of_node() from possible
> changes to fwnode_handle implementation by using device_set_node()
> instead of open-coding dev->dev.fwnode assignments.

Any news on this change? Should I do anything?

-- 
With Best Regards,
Andy Shevchenko


