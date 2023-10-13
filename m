Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17FCC7C8E11
	for <lists+linux-pci@lfdr.de>; Fri, 13 Oct 2023 22:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbjJMUCy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Oct 2023 16:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbjJMUCy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Oct 2023 16:02:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928F1B7;
        Fri, 13 Oct 2023 13:02:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE1F5C433C7;
        Fri, 13 Oct 2023 20:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697227371;
        bh=YPysSJ75Z66PNMuLGBGQnsEDjA0/a98d1E2F+Hgg2jI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=i2rbxOItdbYJ2r5QKG1SbRRH0Zs90cDrBVIEpDUhE9zdiFpsn/waLZiov7mEpgQcL
         Bz+GjG8334uvOwlyUo83kwih7ef58WvPPY2CoIVBNmxSwGOSfwk0S7Ho8+2bgEcU7z
         nYD78sqFH6cUQLZ9aUcAzFpKTc0okAdmovI1jZsmJiESJzI1UU6BmYssNV+sUXPaG7
         OThHxlex/Jcj/PiEf/Z56KIlyoBasUm9iWl6r/VPdWLj+/clGwl7JGtOhbSx42ITEj
         OvcKjkDjsM7gmVeK+YIdZ7bYzqpf5oA1/Z6bb0/TPe5iS78eKHsPPMeF1hR3CMbGk7
         VHP9lcff9Dxwg==
Date:   Fri, 13 Oct 2023 15:02:49 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-pci@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 06/10] PCI/DPC: Use FIELD_GET()
Message-ID: <20231013200249.GA1123559@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dc2ef6fc-e7a7-33db-6fe5-875c7cd338a@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 11, 2023 at 02:01:13PM +0300, Ilpo Järvinen wrote:
> On Tue, 10 Oct 2023, Bjorn Helgaas wrote:
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

Pure FIELD_GET() and FIELD_PREP() was my goal.

If you have patches you prefer, I'll drop mine.  I did these about a
year ago and it seemed like the time to do something with them since
you did the PCI_EXP_LNKSTA_NLW ones and to try to prevent overlapping
work.  Since we've started, I'd like to get as much of it done this
cycle as possible.

Bjorn
