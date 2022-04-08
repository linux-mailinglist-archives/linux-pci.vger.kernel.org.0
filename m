Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E274F8F1F
	for <lists+linux-pci@lfdr.de>; Fri,  8 Apr 2022 09:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbiDHGxL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Apr 2022 02:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiDHGxD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Apr 2022 02:53:03 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E1522BD6F
        for <linux-pci@vger.kernel.org>; Thu,  7 Apr 2022 23:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649400423; x=1680936423;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=c/mtXKY0WuiI49Yi0zPymafFgRaSDpQNz+CyEPoMxFE=;
  b=lNUJaj1DgWx+5gq/heiaGB9RTJxYJSTyyNSG8+x1W+CeWXEACyyOkx+1
   86TMvU6KrKTWVjp0G8m4APSQ+GQ2OOMntZKN+oawyQmH6L4mDXU9Al5cL
   /OVhDozsbusqXTXGu96wI7GCxSCvqbCIbu8ZIJVEdGjfhSmt/ezKqjjo/
   MPguOeMCpXy45v609mqVusw/92dNa1O2VtniRSZHnNtt6sd2Ug9wCEoSA
   b8Zmpoe+aYtPlOGIJL+OjhWcs82MRI7eLqi6QIjqpZkTg7E4muySlIYUb
   W1sqwyYAOIMcXFB4qSeLCjG3GuEiMZ5fOvxo+X7l0ZZuY4dzafJmPPSQd
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="260359413"
X-IronPort-AV: E=Sophos;i="5.90,244,1643702400"; 
   d="scan'208";a="260359413"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 23:47:03 -0700
X-IronPort-AV: E=Sophos;i="5.90,244,1643702400"; 
   d="scan'208";a="609633472"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 23:47:00 -0700
Received: by lahna (sSMTP sendmail emulation); Fri, 08 Apr 2022 09:44:46 +0300
Date:   Fri, 8 Apr 2022 09:44:46 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Quirk Intel DG2 ASPM L1 acceptable latency to be
 unlimited
Message-ID: <Yk/Z3kKxdV2slC4k@lahna>
References: <20220405093810.76613-1-mika.westerberg@linux.intel.com>
 <20220407170655.GA249049@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407170655.GA249049@bhelgaas>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 07, 2022 at 12:06:55PM -0500, Bjorn Helgaas wrote:
> On Tue, Apr 05, 2022 at 12:38:10PM +0300, Mika Westerberg wrote:
> > Intel DG2 discrete graphics PCIe endpoints hard-code their acceptable L1
> > ASPM latency to be < 1us even though the hardware actually supports
> > higher latencies (> 64 us) just fine. In order to allow the links to go
> > into L1 and save power, quirk the acceptable L1 ASPM latency for these
> > endpoints to be unlimited.
> > 
> > Note this does not have any effect unless the user requested the kernel
> > to enable ASPM in the first place (by default we don't enable it). This
> > is done with "pcie_aspm=force pcie_aspm.policy=powersupsersave" command
> > line parameters.
> > 
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> I wordsmithed as below and applied to pci/aspm for v5.19, thanks!

Thanks!

> Please double-check that I didn't screw up the FIELD_GET/PREP usage.

Looks good to me. I did not even know we have such macros, thanks for
pointing that out :)
