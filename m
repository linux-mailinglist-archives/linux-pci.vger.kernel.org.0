Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D303879D0C6
	for <lists+linux-pci@lfdr.de>; Tue, 12 Sep 2023 14:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235001AbjILMLm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Sep 2023 08:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235002AbjILMLk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Sep 2023 08:11:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2AFE10DC;
        Tue, 12 Sep 2023 05:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694520696; x=1726056696;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=s4B/T6itIbA12r0ps1vdM+hwzQ3jFlRsKTz0S71M4xM=;
  b=hwtoEnJR5EfzmX98bQxlv1bznBa8ylqnlE+eQ0dFBRt/1m/H60eHp/Gu
   knxeqThyXGaRp+efZySOA/y4Oy9ASg1zcQMmswxM/TWcsU+PQaewCWZ0k
   36ZBxzLxjr2As124+JFHqj9yDDb9wFtVlClheZfABmi1HaACwoq4+9XDS
   tzbnt7fOTvnl2AOyDLhL9gt9Gz5gAeCO6f3ONrFX4ZvJmCQoYlsjWK/7+
   5MeINApRn/jXljyZKuTFphN51V+Eb/QvrDQgXKkIawCNNHDMVzrMlNgyP
   ldOnescqcqDLhfsBsViyLAVtLwV0Z1oX1fFPGVykI0dWlJPayWGqqyXS8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="378267951"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="378267951"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 05:11:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="833886306"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="833886306"
Received: from npejicx-mobl.ger.corp.intel.com ([10.251.217.90])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 05:11:30 -0700
Date:   Tue, 12 Sep 2023 15:11:28 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        intel-wired-lan@lists.osuosl.org, Netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/8] igb: Use FIELD_GET() to extract Link Width
In-Reply-To: <20230912113403.00006c39@Huawei.com>
Message-ID: <942077c8-a44a-5831-55b-afceb4412c2@linux.intel.com>
References: <20230911121501.21910-1-ilpo.jarvinen@linux.intel.com> <20230911121501.21910-4-ilpo.jarvinen@linux.intel.com> <20230912113403.00006c39@Huawei.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-525986759-1694519782=:2125"
Content-ID: <70baab3-03e-d377-677-c25fa8176a57@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-525986759-1694519782=:2125
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <e51e5bf7-e092-ac4f-59c9-117fbfcad42f@linux.intel.com>

On Tue, 12 Sep 2023, Jonathan Cameron wrote:

> On Mon, 11 Sep 2023 15:14:56 +0300
> Ilpo Järvinen <ilpo.jarvinen@linux.intel.com> wrote:
> 
> > Use FIELD_GET() to extract PCIe Negotiated Link Width field instead of
> > custom masking and shifting.
> > 
> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> >  drivers/net/ethernet/intel/igb/e1000_mac.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/igb/e1000_mac.c b/drivers/net/ethernet/intel/igb/e1000_mac.c
> > index caf91c6f52b4..5a23b9cfec6c 100644
> > --- a/drivers/net/ethernet/intel/igb/e1000_mac.c
> > +++ b/drivers/net/ethernet/intel/igb/e1000_mac.c
> > @@ -1,6 +1,7 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  /* Copyright(c) 2007 - 2018 Intel Corporation. */
> >  
> > +#include <linux/bitfield.h>
> >  #include <linux/if_ether.h>
> >  #include <linux/delay.h>
> >  #include <linux/pci.h>
> > @@ -50,9 +51,8 @@ s32 igb_get_bus_info_pcie(struct e1000_hw *hw)
> >  			break;
> >  		}
> >  
> > -		bus->width = (enum e1000_bus_width)((pcie_link_status &
> > -						     PCI_EXP_LNKSTA_NLW) >>
> > -						     PCI_EXP_LNKSTA_NLW_SHIFT);
> > +		bus->width = (enum e1000_bus_width)FIELD_GET(PCI_EXP_LNKSTA_NLW,
> > +							     pcie_link_status);
> 
> This cast is a bit ugly given it takes the values 0, 1, 2, 3 and
> we extra a field that the spec says contains 1, 2, 4, 8 etc
> Hence it only works because only 1 and 2 are used I think...  Not nice.

Not perfect but I guess the enum definition could use 
PCI_EXP_LNKSTA_NLW_X* to ensure at least the PCIe ones match.

> Also, whilst looking at this I note that e1000e has it's own defines
> for PCIE_LINK_WIDTH_MASK and PCIE_LINK_WIDTH_SHIFT 
> 
> Looks like those should be changed to use the standard defines.

Yes, thanks. I added a patch to address those duplicated defines and 
I also noticed it had a duplicated copy for PCI_EXP_LNKSTA which I also 
converted.

I'll send v2 which has most of your suggestions taken into account once 
the build bot has done its thing.

> For extra giggles there are two e1000_bus_width enum definitions in different
> headers.

No, there are actually 3 if one looks carefully, and many more if the 
ones named according to the driver are also counted all following this 
same "not nice" pattern. ;-)

That's 3 different drivers though which just happen to be similarly named 
so it's not entirely fair as it would be same as saying drivers x, y, and 
z have something with the same name. It's pretty obviously those come from 
copy paste though which usually means some common code might have been 
handy.

> Actual patch is good - just 'interesting' stuff noticed whilst looking 
> at it :) 

Yeah, I've plenty of 'interesting' stuff I've noticed while looking around 
on my todo list. I even thought I had that general PCI_EXP_* FIELD_GET() 
cleanup on it as I recall eyeing what it would take to find all of them 
but it seems I never added that there (now it is).

But then I was taking a look at these Link Width ones and there was just 
so much low-hanging fruit (some of which are like you put it, an 
excellent example of good cleanup) so I went to do that right away 
without considering all the other fields.

Thanks a lot for taking a look.


-- 
 i.
--8323329-525986759-1694519782=:2125--
