Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A00B26F49DD
	for <lists+linux-pci@lfdr.de>; Tue,  2 May 2023 20:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbjEBSoN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 May 2023 14:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjEBSoM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 May 2023 14:44:12 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7163910C6
        for <linux-pci@vger.kernel.org>; Tue,  2 May 2023 11:44:10 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-517bfdf55c3so2194911a12.2
        for <linux-pci@vger.kernel.org>; Tue, 02 May 2023 11:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683053050; x=1685645050;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E3813KGI1tWgO2KWeGXVFdLmwvad1+wbr7eZs5FXRhY=;
        b=OA6skNPwHZkmFRUb2MSmCmbOT6KIxL+RNz1dhMXoubcE7Y7nL3s6gIvQpAOVSugQI8
         h9eCxO8aXzVfYxBM1gVoHRCsAtllr90CxRa+8OOhTG3BGxp3s9NzQwcWgrLop3D38L5s
         zZIImyH5WQqgh0IbcjokBPqkNeSy/vWlh9L5o8YeJPudIi8AS0OtfYaq/WWw6GItfyvi
         8cAdDqs8lua4YFnyEGWqFS8mdjYkEVCXt24mgPlBse6NoI7Ua4ai77bmJL9ahs7Z+Ll7
         I4ELKuCDfQ5R4+i6EbshO+DGzegeX6EK5oXvJFmJuO3g3+6AZTTo9M6PAoyzu0/dbDtX
         gkdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683053050; x=1685645050;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E3813KGI1tWgO2KWeGXVFdLmwvad1+wbr7eZs5FXRhY=;
        b=DNAg+2huN6XPbYDaxI8a7EvvdhiJFknGWitO0xF+Hlt2C6idPeAXzMKzQsKSdvYbdQ
         8SXBUrWkFhgoBOHFfP3qw9UuVS1QAbk7/6SNsipcTkzzQFireRa3/OtcU2WbHQ/QOnPX
         WARRXgbudjcLby232O6WLRFZR5kBovGzXcdNbNedCNT35LLlYgP/+8T2/M1mww4tR8eL
         cWyaKbgquJhhIcIVgPrNqUcFkNlhvyccUT8QxshGH0nYLLxCh7k2AXMohmWHYJdqomyP
         HS1SMIy0fKSpqHw6NzVREGFIP+XHQA8Zf9y7Wt3ARqP0L49yr5gDk9L5wiOAlSNb6aOJ
         3azQ==
X-Gm-Message-State: AC+VfDwtysRzJ0VX8+Gehm33uQjjn1esxLc1wW6VQ5IP7/Stv/s4QSgn
        0t65JGtTTPhFuH+1QY2N/HknKA==
X-Google-Smtp-Source: ACHHUZ6+nXkGiQRFh0pGgISmySQlpyY4OPziUoIybj44r6e/oG+p5qQJ4KXLZXsuD25FtbWVsreU7A==
X-Received: by 2002:a05:6a21:339f:b0:e9:5b0a:deff with SMTP id yy31-20020a056a21339f00b000e95b0adeffmr23162696pzb.22.1683053049651;
        Tue, 02 May 2023 11:44:09 -0700 (PDT)
Received: from google.com (41.183.143.34.bc.googleusercontent.com. [34.143.183.41])
        by smtp.gmail.com with ESMTPSA id d19-20020a63f253000000b00528da88275bsm4907480pgk.47.2023.05.02.11.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 11:44:09 -0700 (PDT)
Date:   Wed, 3 May 2023 00:14:00 +0530
From:   Ajay Agarwal <ajayagarwal@google.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
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
Message-ID: <ZFFZ8GyLolhPZSC2@google.com>
References: <ZFEJ+rcE0D/rhJnq@google.com>
 <20230502160224.GA682469@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230502160224.GA682469@bhelgaas>
X-Spam-Status: No, score=-14.5 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 02, 2023 at 11:02:24AM -0500, Bjorn Helgaas wrote:
> On Tue, May 02, 2023 at 06:32:50PM +0530, Ajay Agarwal wrote:
> > On Mon, May 01, 2023 at 12:44:39PM -0500, Bjorn Helgaas wrote:
> > > On Tue, Apr 11, 2023 at 04:40:33PM +0530, Ajay Agarwal wrote:
> > > > Currently the aspm driver does not set ASPM_STATE_L1 bit in
> > > > aspm_default when the class driver requests L1SS ASPM state.
> > > > This will lead to pcie_config_aspm_link() not enabling the
> > > > requested L1SS state. Set ASPM_STATE_L1 when class driver
> > > > enables L1ss.
> > > 
> > > Since vmd is currently the only caller of pci_enable_link_state(), and
> > > it supplies PCIE_LINK_STATE_ALL:
> > > 
> > >   #define PCIE_LINK_STATE_ALL (PCIE_LINK_STATE_L0S | PCIE_LINK_STATE_L1 |\
> > >                                PCIE_LINK_STATE_CLKPM | PCIE_LINK_STATE_L1_1 |\
> > >                                PCIE_LINK_STATE_L1_2 | PCIE_LINK_STATE_L1_1_PCIPM |\
> > >                                PCIE_LINK_STATE_L1_2_PCIPM)
> > > 
> > > I don't think this makes any functional difference at this point,
> > > right?
> >
> > Yes, this does not make any functional difference to the vmd driver.
> > ...
> 
> > > > @@ -1170,16 +1170,16 @@ int pci_enable_link_state(struct pci_dev *pdev, int state)
> > > >  	if (state & PCIE_LINK_STATE_L0S)
> > > >  		link->aspm_default |= ASPM_STATE_L0S;
> > > >  	if (state & PCIE_LINK_STATE_L1)
> > > > -		/* L1 PM substates require L1 */
> > > > -		link->aspm_default |= ASPM_STATE_L1 | ASPM_STATE_L1SS;
> > > > +		link->aspm_default |= ASPM_STATE_L1;
> > > > +	/* L1 PM substates require L1 */
> > > >  	if (state & PCIE_LINK_STATE_L1_1)
> > > > -		link->aspm_default |= ASPM_STATE_L1_1;
> > > > +		link->aspm_default |= ASPM_STATE_L1_1 | ASPM_STATE_L1;
> > > 
> > > IIUC, this:
> > > 
> > >   pci_enable_link_state(PCIE_LINK_STATE_L1_1)
> > > 
> > > currently doesn't actually enable L1.1 because the caller didn't
> > > supply "PCIE_LINK_STATE_L1 | PCIE_LINK_STATE_L1_1".
> > > 
> > > I'm not sure that's a problem -- the driver can easily supply both if
> > > it wants both.
> >
> > Consider this: A driver wants to enable L1.1. So it calls:
> >     pci_enable_link_state(PCIE_LINK_STATE_L1 | PCIE_LINK_STATE_L1_1)
> > The current logic will end up enabling L1.2 as well. The driver does
> > not want that.
> 
> Hmmm, I think I see what you mean.  ASPM_STATE_L1SS includes both
> ASPM_STATE_L1_1 and ASPM_STATE_L1_2:
> 
>   #define ASPM_STATE_L1_2_MASK    (ASPM_STATE_L1_2 | ASPM_STATE_L1_2_PCIPM)
>   #define ASPM_STATE_L1SS         (ASPM_STATE_L1_1 | ASPM_STATE_L1_1_PCIPM |\
> 				   ASPM_STATE_L1_2_MASK)
> 
> so this sets ASPM_STATE_L1_1 and ASPM_STATE_L1_2:
> 
>   if (state & PCIE_LINK_STATE_L1)
>     link->aspm_default |= ASPM_STATE_L1 | ASPM_STATE_L1SS;
> 
> which makes it pointless for a caller to supply PCIE_LINK_STATE_L1_1
> or PCIE_LINK_STATE_L1_2:
> 
>   if (state & PCIE_LINK_STATE_L1_1)
>     link->aspm_default |= ASPM_STATE_L1_1;
>   if (state & PCIE_LINK_STATE_L1_2)
>     link->aspm_default |= ASPM_STATE_L1_2;
> 
> > Also, we should be letting the ASPM core driver handle the logic that
> > L1.0 needs to be set for L1.1/L1.2 to happen, instead of putting that
> > responsibility to the caller driver.
> >
> > > For devices that support only L1,
> > > "pci_enable_link_state(PCIE_LINK_STATE_L1_1)" would implicitly enable
> > > L1 even though L1.1 is not supported, which seems a little bit weird.
> > >
> > If L1.1 is not supported, then ASPM_STATE_L1_1 will not be set in
> > `aspm_capable` right? That will not allow L1.1 to be enabled. So, we
> > should be fine.
> 
> It seems like there are two questions here:
> 
>   1) We currently enable L1.2 when the caller didn't request it.  This
>   seems clearly wrong and we should fix it.  If we can make a patch
>   that does just this part, that would be good.
>
Ack. Will do in the next revision.

>   2) Should the PCI core enable L1 if the caller requests only L1.1
>   (or L1.2)?  This one isn't as clear to me, but there's only one
>   caller, and whatever we do won't make a difference to it, so it can
>   go either way.  If we want to make a semantic change here, that's
>   OK, but I'd like to make that its own patch if possible.
>
Ack. Will create a new patch in the next revision.

> > > >  	if (state & PCIE_LINK_STATE_L1_2)
> > > > -		link->aspm_default |= ASPM_STATE_L1_2;
> > > > +		link->aspm_default |= ASPM_STATE_L1_2 | ASPM_STATE_L1;
> > > >  	if (state & PCIE_LINK_STATE_L1_1_PCIPM)
> > > > -		link->aspm_default |= ASPM_STATE_L1_1_PCIPM;
> > > > +		link->aspm_default |= ASPM_STATE_L1_1_PCIPM | ASPM_STATE_L1;
> > > >  	if (state & PCIE_LINK_STATE_L1_2_PCIPM)
> > > > -		link->aspm_default |= ASPM_STATE_L1_2_PCIPM;
> > > > +		link->aspm_default |= ASPM_STATE_L1_2_PCIPM | ASPM_STATE_L1;
> > > >  	pcie_config_aspm_link(link, policy_to_aspm_state(link));
> > > >  
> > > >  	link->clkpm_default = (state & PCIE_LINK_STATE_CLKPM) ? 1 : 0;
> > > > -- 
> > > > 2.40.0.577.gac1e443424-goog
> > > > 
