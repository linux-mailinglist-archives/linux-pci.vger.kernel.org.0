Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F90C7CAD17
	for <lists+linux-pci@lfdr.de>; Mon, 16 Oct 2023 17:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjJPPO0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Oct 2023 11:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232003AbjJPPOZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Oct 2023 11:14:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF071D9;
        Mon, 16 Oct 2023 08:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697469264; x=1729005264;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=gs4N9ezRLhxjgM2cEbP+/lHkLMb/1pEd3Idtpkl5xQo=;
  b=HG5SS6l1NHM/aycsBs+jqmZZXIBUM7Q+MftYMBU/IFIwZyRyTQzVtRci
   gGa751C8AdSxels7f9VsfCMYJ89qIHTHisKfbFy+CUivtl0GmiNLo138j
   MDJysWzEQoNIorSbFeIUDvbVT0aREpqtyC06GI2Mv954VsikHhbBbslCG
   NysIrfR77HGiAqenIiARYWjIiaUSbaBwNy5nuAMmGzL7Cd1DQfQeRLby+
   +TmqyjlqtyXv+kFZSl+EBum29311AJIue7RpGQa0rxHW4spCsssV1YBiF
   3FsSRR7pkLgIHLExFHbfdaZRpv31ywgtxOVxC/13ToUYeno0yRAUZigRs
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="7117848"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="7117848"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 08:14:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="879460578"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="879460578"
Received: from rhaeussl-mobl.ger.corp.intel.com ([10.252.59.103])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 08:14:15 -0700
Date:   Mon, 16 Oct 2023 18:14:13 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
cc:     linux-pci@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 06/10] PCI/DPC: Use FIELD_GET()
In-Reply-To: <524d1789-6b57-aae-17b7-bf7ae49719dc@linux.intel.com>
Message-ID: <8ca2ad3-da7d-c82c-cbdf-b5363760444e@linux.intel.com>
References: <20231013200249.GA1123559@bhelgaas> <3df6c8ea-888e-faa-5bae-e26b1f446ab3@linux.intel.com> <524d1789-6b57-aae-17b7-bf7ae49719dc@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2130236667-1697469257=:1986"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2130236667-1697469257=:1986
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Mon, 16 Oct 2023, Ilpo Järvinen wrote:

> On Mon, 16 Oct 2023, Ilpo Järvinen wrote:
> 
> > On Fri, 13 Oct 2023, Bjorn Helgaas wrote:
> > 
> > > On Wed, Oct 11, 2023 at 02:01:13PM +0300, Ilpo Järvinen wrote:
> > > > On Tue, 10 Oct 2023, Bjorn Helgaas wrote:
> > > > > From: Bjorn Helgaas <bhelgaas@google.com>
> > > > > 
> > > > > Use FIELD_GET() to remove dependences on the field position, i.e., the
> > > > > shift value.  No functional change intended.
> > > > > 
> > > > > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > > > > ---
> > > > >  drivers/pci/pcie/dpc.c        | 9 +++++----
> > > > >  drivers/pci/quirks.c          | 2 +-
> > > > >  include/uapi/linux/pci_regs.h | 1 +
> > > > >  3 files changed, 7 insertions(+), 5 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> > > > > index 3ceed8e3de41..6e551f34ec63 100644
> > > > > --- a/drivers/pci/pcie/dpc.c
> > > > > +++ b/drivers/pci/pcie/dpc.c
> > > > > @@ -8,6 +8,7 @@
> > > > >  
> > > > >  #define dev_fmt(fmt) "DPC: " fmt
> > > > >  
> > > > > +#include <linux/bitfield.h>
> > > > >  #include <linux/aer.h>
> > > > >  #include <linux/delay.h>
> > > > >  #include <linux/interrupt.h>
> > > > > @@ -202,7 +203,7 @@ static void dpc_process_rp_pio_error(struct pci_dev *pdev)
> > > > >  
> > > > >  	/* Get First Error Pointer */
> > > > >  	pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &dpc_status);
> > > > > -	first_error = (dpc_status & 0x1f00) >> 8;
> > > > > +	first_error = FIELD_GET(PCI_EXP_DPC_STATUS_FIRST_ERR, dpc_status);
> > > > >  
> > > > >  	for (i = 0; i < ARRAY_SIZE(rp_pio_error_string); i++) {
> > > > >  		if ((status & ~mask) & (1 << i))
> > > > > @@ -270,8 +271,8 @@ void dpc_process_error(struct pci_dev *pdev)
> > > > >  	pci_info(pdev, "containment event, status:%#06x source:%#06x\n",
> > > > >  		 status, source);
> > > > >  
> > > > > -	reason = (status & PCI_EXP_DPC_STATUS_TRIGGER_RSN) >> 1;
> > > > > -	ext_reason = (status & PCI_EXP_DPC_STATUS_TRIGGER_RSN_EXT) >> 5;
> > > > > +	reason = FIELD_GET(PCI_EXP_DPC_STATUS_TRIGGER_RSN, status);
> > > > > +	ext_reason = FIELD_GET(PCI_EXP_DPC_STATUS_TRIGGER_RSN_EXT, status);
> > > > >  	pci_warn(pdev, "%s detected\n",
> > > > >  		 (reason == 0) ? "unmasked uncorrectable error" :
> > > > >  		 (reason == 1) ? "ERR_NONFATAL" :
> > > > 
> > > > BTW, it seems we're doing overlapping work here with many of these 
> > > > patches. It takes some time to think these through one by one, I don't 
> > > > just autorun through them with coccinelle so I've not posted my changes
> > > > yet.
> > > >
> > > > I went to a different direction here and named all the reasons too with 
> > > > defines and used & to get the reason in order to be able to compare with 
> > > > the named reasons.
> > > > 
> > > > You also missed convering one 0xfff4 to use define (although I suspect it 
> > > > never was your goal to go beyond FIELD_GET() here).
> > > 
> > > Pure FIELD_GET() and FIELD_PREP() was my goal.
> > > 
> > > If you have patches you prefer, I'll drop mine.  I did these about a
> > > year ago and it seemed like the time to do something with them since
> > > you did the PCI_EXP_LNKSTA_NLW ones and to try to prevent overlapping
> > > work.  Since we've started, I'd like to get as much of it done this
> > > cycle as possible.
> > 
> > Okay, I suggest you keep your FIELD_GET/PREP() patch since mine is getting 
> > more and more complicated. I can build a nice set of small changes about 
> > what remains to do in DPC on top of your patch.
> 
> Err, actually, there's still the naming of the define, should _FEP be used 
> for First Error Pointer for consistency? You should make that small change 
> into your patch if you think _FEP is better because of consistency.

There's also #include order so it seems you should just drop the patch, I 
can handle this along my series.

-- 
 i.

--8323329-2130236667-1697469257=:1986--
