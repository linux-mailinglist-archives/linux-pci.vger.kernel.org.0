Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC81B6F34
	for <lists+linux-pci@lfdr.de>; Thu, 19 Sep 2019 00:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388369AbfIRWHo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Sep 2019 18:07:44 -0400
Received: from mga07.intel.com ([134.134.136.100]:52979 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388365AbfIRWHo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 18 Sep 2019 18:07:44 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Sep 2019 15:07:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,522,1559545200"; 
   d="scan'208";a="199192940"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.145])
  by orsmga002.jf.intel.com with ESMTP; 18 Sep 2019 15:07:43 -0700
Date:   Wed, 18 Sep 2019 15:07:43 -0700
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Andrew Murray <andrew.murray@arm.com>,
        Steffen Liebergeld <steffen.liebergeld@kernkonzept.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH] PCI: quirks: Fix register location for UPDCR
Message-ID: <20190918220743.GA26982@otc-nc-03>
References: <054ef65b-07de-7625-ebcb-f5ce64bc2726@kernkonzept.com>
 <20190918104213.GD9720@e119886-lin.cambridge.arm.com>
 <8da75cab-d3d4-14aa-1113-087d4a868072@kernkonzept.com>
 <20190918120917.GF9720@e119886-lin.cambridge.arm.com>
 <20190918104651.66535375@x1.home>
 <20190918160454.45857065@x1.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190918160454.45857065@x1.home>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Alex

On Wed, Sep 18, 2019 at 04:04:54PM -0600, Alex Williamson wrote:
> > > > >>
> > > > >> Signed-off-by: Steffen Liebergeld <steffen.liebergeld@kernkonzept.com>    
> > > > > 
> > > > > You may also like to add:
> > > > > 
> > > > > Fixes: d99321b63b1f ("PCI: Enable quirks for PCIe ACS on Intel PCH root ports")
> > > > > Reviewed-by: Andrew Murray <andrew.murray@arm.com>
> > > > > 
> > > > > As well as CC'ing stable.    
> > > > 
> > > > Ok. Thank you.
> > > >     
> > > > > I guess the side effect of this bug is that we claim to have peer
> > > > > isolation when we do not. This fix ensures that we get the advertised
> > > > > isolation.    
> > > > Yes, that is also my understanding. Should I explain that in the commit
> > > > message?    
> > > 
> > > I think something similar to that would be helpful.  
> > 
> > This is unfortunate, but my initial impression is that this may have
> > just been a typo that slipped by everyone.  It's difficult to actually
> > test for isolation.  Maybe someone from Intel could review this.  Also,
> > Steffen discussed this with me prior to posting and I believe this is
> > untested, so while trivial from inspection, it would be preferable to
> > know that some sample of hardware doesn't fall over as a result.
> 
> I've looked at 4 different systems, two 6-series (desktop + laptop), an
> 8-series desktop, and an X79 workstation.  None of the 6/8 series even
> enter the branch where we read the UPDCR register, the value read from
> the BSPR register doesn't require it.  In the case of the X79, using
> 0x1014 for UPDCR, the value read from the register is zero so code
> would not proceed into the inner branch to write the register, but
> using the current 0x1114 address, we read a non-zero value and changing
> it does stick on re-read.  Neither address is defined in the public
> specs for this chipset, we're basing the information on word of mouth
> and ack from Intel as noted in commit 1a30fd0dba77.
> 
> So of these systems, if 0x1014 is the correct UPDCR register address,
> nothing actually changes with respect to isolation other than we're not
> changing the value in mystery register 0x1114.  Intel?  Thanks,

I have asked the chipset folks if the spec has a typo.. waiting for
an answer.. 


