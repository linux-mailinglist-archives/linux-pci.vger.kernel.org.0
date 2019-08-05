Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 794AD81B5B
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2019 15:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729583AbfHENOC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Aug 2019 09:14:02 -0400
Received: from mga03.intel.com ([134.134.136.65]:48347 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729938AbfHENN6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 5 Aug 2019 09:13:58 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Aug 2019 06:13:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,350,1559545200"; 
   d="scan'208";a="192417675"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 05 Aug 2019 06:13:07 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 05 Aug 2019 16:13:07 +0300
Date:   Mon, 5 Aug 2019 16:13:06 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Keith Busch <keith.busch@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Frederick Lawler <fred@fredlawl.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Sinan Kaya <okaya@kernel.org>,
        Kai Heng Feng <kai.heng.feng@canonical.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: pciehp: Do not disable interrupt twice on
 suspend
Message-ID: <20190805131306.GQ2640@lahna.fi.intel.com>
References: <20190618125051.2382-1-mika.westerberg@linux.intel.com>
 <20190804195306.gm4livsxkrleaciv@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190804195306.gm4livsxkrleaciv@wunner.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Aug 04, 2019 at 09:53:06PM +0200, Lukas Wunner wrote:
> On Tue, Jun 18, 2019 at 03:50:50PM +0300, Mika Westerberg wrote:
> > @@ -313,10 +332,12 @@ static struct pcie_port_service_driver hpdriver_portdrv = {
> >  	.remove		= pciehp_remove,
> >  
> >  #ifdef	CONFIG_PM
> > +#ifdef	CONFIG_PM_SLEEP
> >  	.suspend	= pciehp_suspend,
> >  	.resume_noirq	= pciehp_resume_noirq,
> > +#endif
> >  	.resume		= pciehp_resume,
> > -	.runtime_suspend = pciehp_suspend,
> > +	.runtime_suspend = pciehp_runtime_suspend,
> >  	.runtime_resume	= pciehp_runtime_resume,
> >  #endif	/* PM */
> >  };
> 
> Hm, why isn't ".resume" part of the "#ifdef CONFIG_PM_SLEEP" section?

Good point. I'll move it there.
