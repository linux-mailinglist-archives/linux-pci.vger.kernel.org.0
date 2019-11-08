Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45B77F456D
	for <lists+linux-pci@lfdr.de>; Fri,  8 Nov 2019 12:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729896AbfKHLK3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Nov 2019 06:10:29 -0500
Received: from mga06.intel.com ([134.134.136.31]:22690 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbfKHLK3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 Nov 2019 06:10:29 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Nov 2019 03:10:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,281,1569308400"; 
   d="scan'208";a="377737564"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga005.jf.intel.com with ESMTP; 08 Nov 2019 03:10:27 -0800
Received: from andy by smile with local (Exim 4.93-RC1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iT29q-0002JJ-9c; Fri, 08 Nov 2019 13:10:26 +0200
Date:   Fri, 8 Nov 2019 13:10:26 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andrew Murray <andrew.murray@arm.com>
Cc:     Keith Busch <kbusch@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>
Subject: Re: [PATCH v1] PCI: pciehp: Refactor infinite loop in pcie_poll_cmd()
Message-ID: <20191108111026.GD32742@smile.fi.intel.com>
References: <20191011090230.81080-1-andriy.shevchenko@linux.intel.com>
 <20191107223726.GA23651@redsun51.ssa.fujisawa.hgst.com>
 <20191108101815.GE43905@e119886-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191108101815.GE43905@e119886-lin.cambridge.arm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 08, 2019 at 10:18:16AM +0000, Andrew Murray wrote:
> On Fri, Nov 08, 2019 at 07:37:26AM +0900, Keith Busch wrote:
> > On Fri, Oct 11, 2019 at 12:02:30PM +0300, Andy Shevchenko wrote:
> > > No functional changes implied.
> > 
> > [snip] 
> > 
> > > -	while (true) {
> > > +	do {
> > >  		pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
> > >  		if (slot_status == (u16) ~0) {
> > >  			ctrl_info(ctrl, "%s: no response from device\n",
> > > @@ -81,11 +81,9 @@ static int pcie_poll_cmd(struct controller *ctrl, int timeout)
> > >  						   PCI_EXP_SLTSTA_CC);
> > >  			return 1;
> > >  		}
> > > -		if (timeout < 0)
> > > -			break;
> > >  		msleep(10);
> > >  		timeout -= 10;
> > > -	}
> > > +	} while (timeout > 0);
> > >  	return 0;	/* timeout */
> > >  }
> > 
> > If you really want to ensure no funcitonal change, I think the end of
> > the loop needs to be 'while (timeout >= 0);'
> 
> With this suggested change, you can add:
> 
> Reviewed-by: Andrew Murray <andrew.murray@arm.com>
> 
> I can't get too excited by coding styles, however I find this more
> readable now, due to the fact that the loop is clearly bounded.

Thank you, Keith and Andrew, I'll submit v2 soon.

-- 
With Best Regards,
Andy Shevchenko


