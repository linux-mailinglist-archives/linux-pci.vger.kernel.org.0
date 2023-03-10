Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7DB66B4B5B
	for <lists+linux-pci@lfdr.de>; Fri, 10 Mar 2023 16:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbjCJPnB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Mar 2023 10:43:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234330AbjCJPmc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Mar 2023 10:42:32 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4010F14160E;
        Fri, 10 Mar 2023 07:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678462164; x=1709998164;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3XSpOFc2N8uycFyIyyMF2nNKSk2B9zbzciio0Myk218=;
  b=aDs8Tcbz550y4ECPr6ZKYT2c0gHexCdj44Eh11V4jAStiWY1fN5M/y1G
   8kcWce7GPAosfOuLqd9iJAzlolyt849185nw4a1qGLP6Vu4bmmfZshoRA
   GvPqzd+gzXaoAvevBxvVeFHKwy8rQQ9hrmuXsm49fp5csAJ7rDhkclp3q
   v6IUqXPSOBGg37AFvP8yS5iZbBpzmNEnQikACcr6CGt/FPKuI3iE/TI61
   x7Y0qr5TFn9lHYxu4P8uIreCA34Ek8tPcW24oZlXbfQNTtyQIF5s6X0yM
   tB75xmw59KQmSFKtbNRdAEMtF5cf0GHA5w0GL/cCUX65p2dpfjX/v0uqo
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="320600887"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="320600887"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 07:28:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="671107387"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="671107387"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 10 Mar 2023 07:28:29 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1paefT-000zxW-1k;
        Fri, 10 Mar 2023 17:28:27 +0200
Date:   Fri, 10 Mar 2023 17:28:27 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Xiaowei Song <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v1 1/1] PCI: dwc: Convert to agnostic GPIO API
Message-ID: <ZAtMmwSYvgeMBuGN@smile.fi.intel.com>
References: <20230213180735.42117-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230213180735.42117-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 13, 2023 at 08:07:35PM +0200, Andy Shevchenko wrote:
> The of_gpio.h is going to be removed. In preparation of that convert
> the driver to the agnostic API.

Anybody to comment or even test this on real hardware?

-- 
With Best Regards,
Andy Shevchenko


