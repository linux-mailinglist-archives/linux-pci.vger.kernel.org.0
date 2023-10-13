Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BEF57C8451
	for <lists+linux-pci@lfdr.de>; Fri, 13 Oct 2023 13:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjJMLXe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Oct 2023 07:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjJMLXd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Oct 2023 07:23:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2D1B7;
        Fri, 13 Oct 2023 04:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697196212; x=1728732212;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ME/oRHw2UDo7p8d79rwOR+AK04ZLM8U3uHQ8v/0iAIo=;
  b=Mhl17MK9LUeCPnXpk4FsNnWF1DcO24cTJ0e27Ef9RVAzcowe8Fn2b3JP
   iVUiF7ZGjn3niEILDgj9VB4mqptOW+udB9N0ryTziw59EYv0zmy0IdNpq
   AhL+3BhpkDQ7lxIxSjl/Buhf2RN/bEZK/M1dMvoCHjQIq9prwNnyIk4WZ
   dxzh11R2vLBXem3KXl0+8pe9eAQihjXo+y/3P0skdjkbcj2OVO+A22x5I
   N4xAU6J/No6b5+PWXVhE2cWiTuvP0fuaJYs4dd7UiR57LRXotfVr/LY0r
   ICWOUno1HoHUFjdBy5qWDyo9yUg0rcCkiWppgpzVNtPPYmPZKt4N1D1MR
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="388010361"
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="388010361"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 04:23:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="878507198"
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="878507198"
Received: from ttmerile-mobl1.ger.corp.intel.com (HELO rploss-MOBL.ger.corp.intel.com) ([10.249.37.202])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 04:23:29 -0700
Date:   Fri, 13 Oct 2023 14:23:26 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
cc:     linux-pci@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 06/10] PCI/DPC: Use FIELD_GET()
In-Reply-To: <dc2ef6fc-e7a7-33db-6fe5-875c7cd338a@linux.intel.com>
Message-ID: <7ff36495-f2d8-b6b6-5a11-c4385e211685@linux.intel.com>
References: <20231010204436.1000644-1-helgaas@kernel.org> <20231010204436.1000644-7-helgaas@kernel.org> <dc2ef6fc-e7a7-33db-6fe5-875c7cd338a@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1568889013-1697196211=:2026"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1568889013-1697196211=:2026
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Wed, 11 Oct 2023, Ilpo Järvinen wrote:

> On Tue, 10 Oct 2023, Bjorn Helgaas wrote:
> 
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > Use FIELD_GET() to remove dependences on the field position, i.e., the
> > shift value.  No functional change intended.
> > 
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > ---
> >  drivers/pci/pcie/dpc.c        | 9 +++++----
> >  drivers/pci/quirks.c          | 2 +-
> >  include/uapi/linux/pci_regs.h | 1 +
> >  3 files changed, 7 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> > index 3ceed8e3de41..6e551f34ec63 100644
> > --- a/drivers/pci/pcie/dpc.c
> > +++ b/drivers/pci/pcie/dpc.c
> > @@ -8,6 +8,7 @@
> >  
> >  #define dev_fmt(fmt) "DPC: " fmt
> >  
> > +#include <linux/bitfield.h>
> >  #include <linux/aer.h>
> >  #include <linux/delay.h>
> >  #include <linux/interrupt.h>
> > @@ -202,7 +203,7 @@ static void dpc_process_rp_pio_error(struct pci_dev *pdev)
> >  
> >  	/* Get First Error Pointer */
> >  	pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &dpc_status);
> > -	first_error = (dpc_status & 0x1f00) >> 8;
> > +	first_error = FIELD_GET(PCI_EXP_DPC_STATUS_FIRST_ERR, dpc_status);
> >  
> >  	for (i = 0; i < ARRAY_SIZE(rp_pio_error_string); i++) {
> >  		if ((status & ~mask) & (1 << i))
> > @@ -270,8 +271,8 @@ void dpc_process_error(struct pci_dev *pdev)
> >  	pci_info(pdev, "containment event, status:%#06x source:%#06x\n",
> >  		 status, source);
> >  
> > -	reason = (status & PCI_EXP_DPC_STATUS_TRIGGER_RSN) >> 1;
> > -	ext_reason = (status & PCI_EXP_DPC_STATUS_TRIGGER_RSN_EXT) >> 5;
> > +	reason = FIELD_GET(PCI_EXP_DPC_STATUS_TRIGGER_RSN, status);
> > +	ext_reason = FIELD_GET(PCI_EXP_DPC_STATUS_TRIGGER_RSN_EXT, status);
> >  	pci_warn(pdev, "%s detected\n",
> >  		 (reason == 0) ? "unmasked uncorrectable error" :
> >  		 (reason == 1) ? "ERR_NONFATAL" :
> 
> BTW, it seems we're doing overlapping work here with many of these 
> patches. It takes some time to think these through one by one, I don't 
> just autorun through them with coccinelle so I've not posted my changes
> yet.
> 
> I went to a different direction here and named all the reasons too with 
> defines and used & to get the reason in order to be able to compare with 
> the named reasons.
> 
> You also missed convering one 0xfff4 to use define (although I suspect it 
> never was your goal to go beyond FIELD_GET() here).

I posted my approach onto the list so you can see what it looks like:
  https://lore.kernel.org/linux-pci/20231013112004.4239-1-ilpo.jarvinen@linux.intel.com/T/#t

(It will obviously conflict with this patch so both cannot be applied as 
is).

-- 
 i.

--8323329-1568889013-1697196211=:2026--
