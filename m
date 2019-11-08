Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77F41F4450
	for <lists+linux-pci@lfdr.de>; Fri,  8 Nov 2019 11:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbfKHKSV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Nov 2019 05:18:21 -0500
Received: from foss.arm.com ([217.140.110.172]:39902 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726180AbfKHKSV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 Nov 2019 05:18:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B1D3B31B;
        Fri,  8 Nov 2019 02:18:18 -0800 (PST)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 16B073F719;
        Fri,  8 Nov 2019 02:18:17 -0800 (PST)
Date:   Fri, 8 Nov 2019 10:18:16 +0000
From:   Andrew Murray <andrew.murray@arm.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>
Subject: Re: [PATCH v1] PCI: pciehp: Refactor infinite loop in pcie_poll_cmd()
Message-ID: <20191108101815.GE43905@e119886-lin.cambridge.arm.com>
References: <20191011090230.81080-1-andriy.shevchenko@linux.intel.com>
 <20191107223726.GA23651@redsun51.ssa.fujisawa.hgst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191107223726.GA23651@redsun51.ssa.fujisawa.hgst.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 08, 2019 at 07:37:26AM +0900, Keith Busch wrote:
> On Fri, Oct 11, 2019 at 12:02:30PM +0300, Andy Shevchenko wrote:
> > No functional changes implied.
> 
> [snip] 
> 
> > -	while (true) {
> > +	do {
> >  		pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
> >  		if (slot_status == (u16) ~0) {
> >  			ctrl_info(ctrl, "%s: no response from device\n",
> > @@ -81,11 +81,9 @@ static int pcie_poll_cmd(struct controller *ctrl, int timeout)
> >  						   PCI_EXP_SLTSTA_CC);
> >  			return 1;
> >  		}
> > -		if (timeout < 0)
> > -			break;
> >  		msleep(10);
> >  		timeout -= 10;
> > -	}
> > +	} while (timeout > 0);
> >  	return 0;	/* timeout */
> >  }
> 
> If you really want to ensure no funcitonal change, I think the end of
> the loop needs to be 'while (timeout >= 0);'

With this suggested change, you can add:

Reviewed-by: Andrew Murray <andrew.murray@arm.com>

I can't get too excited by coding styles, however I find this more
readable now, due to the fact that the loop is clearly bounded.
