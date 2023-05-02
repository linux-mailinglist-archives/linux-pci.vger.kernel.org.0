Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFBD6F47E5
	for <lists+linux-pci@lfdr.de>; Tue,  2 May 2023 18:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjEBQCa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 May 2023 12:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjEBQC2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 May 2023 12:02:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23AD26AC
        for <linux-pci@vger.kernel.org>; Tue,  2 May 2023 09:02:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8BE4662630
        for <linux-pci@vger.kernel.org>; Tue,  2 May 2023 16:02:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9349C433EF;
        Tue,  2 May 2023 16:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683043345;
        bh=F6INMunzyO3L4GZXfQTNJWSQpvK9guG1xwYpn5xxaXM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=lKTe2tZPuTup5GtlG9gyqXlFF88n5Br/Oz0YggWQMYoJ9rw4TlUiKgkrbhYT5SgQ8
         8yAN6Og8soLk65Q7dRWkGDifnH6JJ6YveC46MmyhQcw1YeipJLwyA+hijtewPcSMw2
         P+gSbWP2ElKqU13KLOZ7ftNwTd2x2pE519vi/4bBd+cn0nYIt31YHmGrotBrQb01rF
         5Yo2NNx9nF3tP49gzlr1YKciaBG3K7XLMFGNC+dLreCiERX9HrDt8xF+2s19MSknxH
         XHZQrFW6uYraRlEwz2m/YJrgo4e57BB3rS/6t/MSbqiT5MdortzzBfnkIjfj7nB/1G
         6f+99TSUfNFGA==
Date:   Tue, 2 May 2023 11:02:24 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ajay Agarwal <ajayagarwal@google.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Nikhil Devshatwar <nikhilnd@google.com>,
        Manu Gautam <manugautam@google.com>,
        "David E. Box" <david.e.box@linux.intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Michael Bottini <michael.a.bottini@linux.intel.com>,
        linux-pci@vger.kernel.org,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>
Subject: Re: [PATCH 2/3] PCI/ASPM: Set ASPM_STATE_L1 when class driver
 enables L1ss
Message-ID: <20230502160224.GA682469@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFEJ+rcE0D/rhJnq@google.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 02, 2023 at 06:32:50PM +0530, Ajay Agarwal wrote:
> On Mon, May 01, 2023 at 12:44:39PM -0500, Bjorn Helgaas wrote:
> > On Tue, Apr 11, 2023 at 04:40:33PM +0530, Ajay Agarwal wrote:
> > > Currently the aspm driver does not set ASPM_STATE_L1 bit in
> > > aspm_default when the class driver requests L1SS ASPM state.
> > > This will lead to pcie_config_aspm_link() not enabling the
> > > requested L1SS state. Set ASPM_STATE_L1 when class driver
> > > enables L1ss.
> > 
> > Since vmd is currently the only caller of pci_enable_link_state(), and
> > it supplies PCIE_LINK_STATE_ALL:
> > 
> >   #define PCIE_LINK_STATE_ALL (PCIE_LINK_STATE_L0S | PCIE_LINK_STATE_L1 |\
> >                                PCIE_LINK_STATE_CLKPM | PCIE_LINK_STATE_L1_1 |\
> >                                PCIE_LINK_STATE_L1_2 | PCIE_LINK_STATE_L1_1_PCIPM |\
> >                                PCIE_LINK_STATE_L1_2_PCIPM)
> > 
> > I don't think this makes any functional difference at this point,
> > right?
>
> Yes, this does not make any functional difference to the vmd driver.
> ...

> > > @@ -1170,16 +1170,16 @@ int pci_enable_link_state(struct pci_dev *pdev, int state)
> > >  	if (state & PCIE_LINK_STATE_L0S)
> > >  		link->aspm_default |= ASPM_STATE_L0S;
> > >  	if (state & PCIE_LINK_STATE_L1)
> > > -		/* L1 PM substates require L1 */
> > > -		link->aspm_default |= ASPM_STATE_L1 | ASPM_STATE_L1SS;
> > > +		link->aspm_default |= ASPM_STATE_L1;
> > > +	/* L1 PM substates require L1 */
> > >  	if (state & PCIE_LINK_STATE_L1_1)
> > > -		link->aspm_default |= ASPM_STATE_L1_1;
> > > +		link->aspm_default |= ASPM_STATE_L1_1 | ASPM_STATE_L1;
> > 
> > IIUC, this:
> > 
> >   pci_enable_link_state(PCIE_LINK_STATE_L1_1)
> > 
> > currently doesn't actually enable L1.1 because the caller didn't
> > supply "PCIE_LINK_STATE_L1 | PCIE_LINK_STATE_L1_1".
> > 
> > I'm not sure that's a problem -- the driver can easily supply both if
> > it wants both.
>
> Consider this: A driver wants to enable L1.1. So it calls:
>     pci_enable_link_state(PCIE_LINK_STATE_L1 | PCIE_LINK_STATE_L1_1)
> The current logic will end up enabling L1.2 as well. The driver does
> not want that.

Hmmm, I think I see what you mean.  ASPM_STATE_L1SS includes both
ASPM_STATE_L1_1 and ASPM_STATE_L1_2:

  #define ASPM_STATE_L1_2_MASK    (ASPM_STATE_L1_2 | ASPM_STATE_L1_2_PCIPM)
  #define ASPM_STATE_L1SS         (ASPM_STATE_L1_1 | ASPM_STATE_L1_1_PCIPM |\
				   ASPM_STATE_L1_2_MASK)

so this sets ASPM_STATE_L1_1 and ASPM_STATE_L1_2:

  if (state & PCIE_LINK_STATE_L1)
    link->aspm_default |= ASPM_STATE_L1 | ASPM_STATE_L1SS;

which makes it pointless for a caller to supply PCIE_LINK_STATE_L1_1
or PCIE_LINK_STATE_L1_2:

  if (state & PCIE_LINK_STATE_L1_1)
    link->aspm_default |= ASPM_STATE_L1_1;
  if (state & PCIE_LINK_STATE_L1_2)
    link->aspm_default |= ASPM_STATE_L1_2;

> Also, we should be letting the ASPM core driver handle the logic that
> L1.0 needs to be set for L1.1/L1.2 to happen, instead of putting that
> responsibility to the caller driver.
>
> > For devices that support only L1,
> > "pci_enable_link_state(PCIE_LINK_STATE_L1_1)" would implicitly enable
> > L1 even though L1.1 is not supported, which seems a little bit weird.
> >
> If L1.1 is not supported, then ASPM_STATE_L1_1 will not be set in
> `aspm_capable` right? That will not allow L1.1 to be enabled. So, we
> should be fine.

It seems like there are two questions here:

  1) We currently enable L1.2 when the caller didn't request it.  This
  seems clearly wrong and we should fix it.  If we can make a patch
  that does just this part, that would be good.

  2) Should the PCI core enable L1 if the caller requests only L1.1
  (or L1.2)?  This one isn't as clear to me, but there's only one
  caller, and whatever we do won't make a difference to it, so it can
  go either way.  If we want to make a semantic change here, that's
  OK, but I'd like to make that its own patch if possible.

> > >  	if (state & PCIE_LINK_STATE_L1_2)
> > > -		link->aspm_default |= ASPM_STATE_L1_2;
> > > +		link->aspm_default |= ASPM_STATE_L1_2 | ASPM_STATE_L1;
> > >  	if (state & PCIE_LINK_STATE_L1_1_PCIPM)
> > > -		link->aspm_default |= ASPM_STATE_L1_1_PCIPM;
> > > +		link->aspm_default |= ASPM_STATE_L1_1_PCIPM | ASPM_STATE_L1;
> > >  	if (state & PCIE_LINK_STATE_L1_2_PCIPM)
> > > -		link->aspm_default |= ASPM_STATE_L1_2_PCIPM;
> > > +		link->aspm_default |= ASPM_STATE_L1_2_PCIPM | ASPM_STATE_L1;
> > >  	pcie_config_aspm_link(link, policy_to_aspm_state(link));
> > >  
> > >  	link->clkpm_default = (state & PCIE_LINK_STATE_CLKPM) ? 1 : 0;
> > > -- 
> > > 2.40.0.577.gac1e443424-goog
> > > 
