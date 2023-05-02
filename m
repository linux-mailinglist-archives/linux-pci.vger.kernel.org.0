Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD4496F449D
	for <lists+linux-pci@lfdr.de>; Tue,  2 May 2023 15:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234394AbjEBNEb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 May 2023 09:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233991AbjEBNEP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 May 2023 09:04:15 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC5659D0
        for <linux-pci@vger.kernel.org>; Tue,  2 May 2023 06:03:02 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1aaf706768cso18377565ad.0
        for <linux-pci@vger.kernel.org>; Tue, 02 May 2023 06:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683032580; x=1685624580;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cNyO1iMknzvpnbGm+JuQU1OxPDjlrsScqp8yqRHcKUU=;
        b=YMTKtMDmYWw9+BRVVx4oGZ3Z+20hc/fiDNbXg/0JWskWRdCgJVcKMhrkle1qQjqy3J
         bA5GU1sBsHD3bSaOY5Jah8jnBT0x2/U8NfLd9FapTT7WUkWue8HN/4FzfFEB9ILCax8/
         haaFiINwSj0yBkKW27+seZxHe6o4Qqr5gOiOxmRWoAd1+DRXMufI/WeYnYNqgRRbPCW3
         jKqp+BazEYeYPGX//hOoVzNbV12iV3Pu3iP0oO4TSdTb1Gk2zVO6XslkzKGssogf11cv
         oNT4aEJ1ofBPhqPptlA4fHfRErKouuNWVNV/QnmKSQ7KhsRmVtzYqE5kMdSwS1gD1XlA
         /yiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683032580; x=1685624580;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cNyO1iMknzvpnbGm+JuQU1OxPDjlrsScqp8yqRHcKUU=;
        b=Kxca0pXyRbAkqMvIM428kYU6dW6WWgEiagBFY7F+vX+K4QI4+cki4sGhyIy/WQ2qTm
         5pdfe47MQ/DgvliSpQUqfTzd/3AJAYf+YuDoPDlM8kzJzXEWaruSDxDW4pfqrVN1RwVX
         B6qrJVP0xDXD8f9YocRmmyEWGPxSSJ6rGoQZ/S1P/Ift0oj9OfTa4VYPB6nv5H5jpw5+
         gqInEoshrwxG1DHldUXd27WabVq+tVasgR9v83iPzZuO4fwBqFitMxryxfaa9q3u8meJ
         CkQVLm3dwm9z+wBAHQLLYlJw0IKqcOjKzxwP3d6sa3TBUmSLEsH3tIwuEzk89NFwWA8t
         AVVQ==
X-Gm-Message-State: AC+VfDz1awBje8tOxhkdMXrl8nd49YJ7XYVKk+sD3KGCiNLEoU0ygWMU
        qo9/gp76fjs1LzTn2djBLJ4Wqg==
X-Google-Smtp-Source: ACHHUZ4523m2mQv5tR3LEZsmnuHOs5f63tIFT6yCFR/4G1HqNqwxC0c6cHVdNLy31lbsGu1VGC6HsQ==
X-Received: by 2002:a17:902:d505:b0:1a9:98ae:5970 with SMTP id b5-20020a170902d50500b001a998ae5970mr22418579plg.23.1683032579819;
        Tue, 02 May 2023 06:02:59 -0700 (PDT)
Received: from google.com (41.183.143.34.bc.googleusercontent.com. [34.143.183.41])
        by smtp.gmail.com with ESMTPSA id jj21-20020a170903049500b001a69e002c7esm19765318plb.178.2023.05.02.06.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 06:02:59 -0700 (PDT)
Date:   Tue, 2 May 2023 18:32:50 +0530
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
Message-ID: <ZFEJ+rcE0D/rhJnq@google.com>
References: <20230411111034.1473044-3-ajayagarwal@google.com>
 <20230501174439.GA592767@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230501174439.GA592767@bhelgaas>
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

On Mon, May 01, 2023 at 12:44:39PM -0500, Bjorn Helgaas wrote:
> [+cc Nirmal, Jonathan, since vmd is the only caller of
> pci_enable_link_state()]
> 
> On Tue, Apr 11, 2023 at 04:40:33PM +0530, Ajay Agarwal wrote:
> > Currently the aspm driver does not set ASPM_STATE_L1 bit in
> > aspm_default when the class driver requests L1SS ASPM state.
> > This will lead to pcie_config_aspm_link() not enabling the
> > requested L1SS state. Set ASPM_STATE_L1 when class driver
> > enables L1ss.
> 
> Since vmd is currently the only caller of pci_enable_link_state(), and
> it supplies PCIE_LINK_STATE_ALL:
> 
>   #define PCIE_LINK_STATE_ALL (PCIE_LINK_STATE_L0S | PCIE_LINK_STATE_L1 |\
>                                PCIE_LINK_STATE_CLKPM | PCIE_LINK_STATE_L1_1 |\
>                                PCIE_LINK_STATE_L1_2 | PCIE_LINK_STATE_L1_1_PCIPM |\
>                                PCIE_LINK_STATE_L1_2_PCIPM)
> 
> I don't think this makes any functional difference at this point,
> right?
>
Yes, this does not make any functional difference to the vmd driver.
> > Signed-off-by: Ajay Agarwal <ajayagarwal@google.com>
> > ---
> >  drivers/pci/pcie/aspm.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > index 5765b226102a..7c9935f331f1 100644
> > --- a/drivers/pci/pcie/aspm.c
> > +++ b/drivers/pci/pcie/aspm.c
> > @@ -1170,16 +1170,16 @@ int pci_enable_link_state(struct pci_dev *pdev, int state)
> >  	if (state & PCIE_LINK_STATE_L0S)
> >  		link->aspm_default |= ASPM_STATE_L0S;
> >  	if (state & PCIE_LINK_STATE_L1)
> > -		/* L1 PM substates require L1 */
> > -		link->aspm_default |= ASPM_STATE_L1 | ASPM_STATE_L1SS;
> > +		link->aspm_default |= ASPM_STATE_L1;
> > +	/* L1 PM substates require L1 */
> >  	if (state & PCIE_LINK_STATE_L1_1)
> > -		link->aspm_default |= ASPM_STATE_L1_1;
> > +		link->aspm_default |= ASPM_STATE_L1_1 | ASPM_STATE_L1;
> 
> IIUC, this:
> 
>   pci_enable_link_state(PCIE_LINK_STATE_L1_1)
> 
> currently doesn't actually enable L1.1 because the caller didn't
> supply "PCIE_LINK_STATE_L1 | PCIE_LINK_STATE_L1_1".
> 
> I'm not sure that's a problem -- the driver can easily supply both if
> it wants both.
> 
Consider this: A driver wants to enable L1.1. So it calls:
    pci_enable_link_state(PCIE_LINK_STATE_L1 | PCIE_LINK_STATE_L1_1)
The current logic will end up enabling L1.2 as well. The driver does
not want that.

Also, we should be letting the ASPM core driver handle the logic that
L1.0 needs to be set for L1.1/L1.2 to happen, instead of putting that
responsibility to the caller driver.
> For devices that support only L1,
> "pci_enable_link_state(PCIE_LINK_STATE_L1_1)" would implicitly enable
> L1 even though L1.1 is not supported, which seems a little bit weird.
>
If L1.1 is not supported, then ASPM_STATE_L1_1 will not be set in
`aspm_capable` right? That will not allow L1.1 to be enabled. So, we
should be fine.
> >  	if (state & PCIE_LINK_STATE_L1_2)
> > -		link->aspm_default |= ASPM_STATE_L1_2;
> > +		link->aspm_default |= ASPM_STATE_L1_2 | ASPM_STATE_L1;
> >  	if (state & PCIE_LINK_STATE_L1_1_PCIPM)
> > -		link->aspm_default |= ASPM_STATE_L1_1_PCIPM;
> > +		link->aspm_default |= ASPM_STATE_L1_1_PCIPM | ASPM_STATE_L1;
> >  	if (state & PCIE_LINK_STATE_L1_2_PCIPM)
> > -		link->aspm_default |= ASPM_STATE_L1_2_PCIPM;
> > +		link->aspm_default |= ASPM_STATE_L1_2_PCIPM | ASPM_STATE_L1;
> >  	pcie_config_aspm_link(link, policy_to_aspm_state(link));
> >  
> >  	link->clkpm_default = (state & PCIE_LINK_STATE_CLKPM) ? 1 : 0;
> > -- 
> > 2.40.0.577.gac1e443424-goog
> > 
