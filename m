Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B50F6E3F62
	for <lists+linux-pci@lfdr.de>; Mon, 17 Apr 2023 08:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjDQGHc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Apr 2023 02:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjDQGHb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Apr 2023 02:07:31 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A109C30E8
        for <linux-pci@vger.kernel.org>; Sun, 16 Apr 2023 23:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681711650; x=1713247650;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Op9Dv1EOy3XsQU2t8vbGSjjAlIXOIkStlYuob50A+6c=;
  b=Uf31EHOVi2tOxSCuwLEnlMsE8JD9jGjen/ik4wD6ZN4moScgbgzMpkPl
   adNN1fieO6G/LweNAw7O3ToY7m+f2JDH2QwM+EkM2Upu2BxUF6MofArIa
   60X6pKOh3sumItI2GPCeLf3EjgX8mbpN6IFQcbJ7Kty7m+CRUtmIMRpO1
   4hp9V7RmUqIs1mYpJCaPuv6fx2qRmy5Aq6sqqbAPkp3IQxAFhJd5K6t5m
   j1VrKalDxjrXn96f4W2fxyI74GShM8Rqlcuxi2VoCUlxR+o6i6QNIOGNF
   BPY7qnhgzTd1Nfi2RWga4jRnFEl9zQYq757LVWmEY5mi+9Y3QzNW/1My+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="407704922"
X-IronPort-AV: E=Sophos;i="5.99,203,1677571200"; 
   d="scan'208";a="407704922"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2023 23:07:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="936719752"
X-IronPort-AV: E=Sophos;i="5.99,203,1677571200"; 
   d="scan'208";a="936719752"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 16 Apr 2023 23:07:14 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 82F949F; Mon, 17 Apr 2023 09:07:19 +0300 (EEST)
Date:   Mon, 17 Apr 2023 09:07:19 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>, oohall@gmail.com,
        Chris Chiu <chris.chiu@canonical.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Sheng Bi <windy.bi.enflame@gmail.com>,
        Ravi Kishore Koppuravuri <ravi.kishore.koppuravuri@intel.com>,
        Stanislav Spassov <stanspas@amazon.de>,
        Yang Su <yang.su@linux.alibaba.com>,
        shuo.tan@linux.alibaba.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3] PCI/PM: Bail out early in
 pci_bridge_wait_for_secondary_bus() if link is not trained
Message-ID: <20230417060719.GB66750@black.fi.intel.com>
References: <20230413101642.8724-1-mika.westerberg@linux.intel.com>
 <20230414074238.GA22973@wunner.de>
 <20230414101147.GA66750@black.fi.intel.com>
 <20230416074846.GA14021@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230416074846.GA14021@wunner.de>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Sun, Apr 16, 2023 at 09:48:46AM +0200, Lukas Wunner wrote:
> On Fri, Apr 14, 2023 at 01:11:47PM +0300, Mika Westerberg wrote:
> > To summarize the v4 patch would look something like below. Only compile
> > tested but I will run real testing later today. I think it now includes
> > the 1s optimization and also checking of the active link reporting
> > support for the devices behind slow links. Let me know is I missed
> > something.
> 
> The patch seems to be based on a branch which has the v3 patch applied
> instead of on pci.git/reset, and that makes it slightly more difficult
> to review, but from a first glance it LGTM.

Oops :( I forgot to rebase it. Sorry about that.

> 
> > It is getting rather complex unfortunately :(
> 
> I disagree. :)  Basically the Gen1/Gen2 situation becomes a special case
> because it has specific timing requirements (need to observe a delay
> before accessing the Secondary Bus, instead of waiting for the link)
> and it doesn't necessarily support link active reporting.  So special
> casing it seems fair to me.

OK.

> > -	 * However, 100 ms is the minimum and the PCIe spec says the
> > -	 * software must allow at least 1s before it can determine that the
> > -	 * device that did not respond is a broken device. There is
> > -	 * evidence that 100 ms is not always enough, for example certain
> > -	 * Titan Ridge xHCI controller does not always respond to
> > -	 * configuration requests if we only wait for 100 ms (see
> > -	 * https://bugzilla.kernel.org/show_bug.cgi?id=203885).
> > +	 * However, 100 ms is the minimum and the PCIe spec says the software
> > +	 * must allow at least 1s before it can determine that the device that
> > +	 * did not respond is a broken device. Also device can take longer than
> > +	 * that to respond if it indicates so through Request Retry Status
> > +	 * completions.
> 
> It *might* be worth avoiding the rewrapping of the first 3 lines to
> make the patch smaller, your choice.

Makes sense, will do.

> > +
> > +		/*
> > +		 * If the port supports active link reporting we now check one
> > +		 * more time if the link is active and if not bail out early
> > +		 * with the assumption that the device is not present anymore.
> > +		 */
> 
> Nit:  Drop the "one more time" because it seems this is actually the
> first time the link is checked.

Sure.

> Somewhat tangentially, I note that pcie_wait_for_link_delay() has a
> "if (!pdev->link_active_reporting)" branch right at its top, however
> pci_bridge_wait_for_secondary_bus() only calls the function in the
> Gen3+ (> 5 GT/s) case, which always supports link active reporting.
> 
> Thus the branch is never taken when pcie_wait_for_link_delay() is called
> from pci_bridge_wait_for_secondary_bus().  There's only one other caller,
> pcie_wait_for_link().  So moving the "if (!pdev->link_active_reporting)"
> branch to pcie_wait_for_link() *might* make the code more readable.
> Just a thought.

Indeed, however moving it would make the two functions behave
differently where as before pcie_wait_for_link() is just a common
wrapper on top fo pcie_wait_for_link_delay(). At least if we do this
change, the documentation should be updated too and possibly rename
pcie_wait_for_link_delay() to __pcie_wait_for_link_delay() or so to make
sure it is something internal to that file.
