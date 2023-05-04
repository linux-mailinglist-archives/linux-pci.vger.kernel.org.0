Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA32F6F678D
	for <lists+linux-pci@lfdr.de>; Thu,  4 May 2023 10:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbjEDIdQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 May 2023 04:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbjEDIdA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 May 2023 04:33:00 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E355FFF
        for <linux-pci@vger.kernel.org>; Thu,  4 May 2023 01:30:24 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-64384c6797eso209041b3a.2
        for <linux-pci@vger.kernel.org>; Thu, 04 May 2023 01:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683189023; x=1685781023;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rV+tL/t9XDmkYZFeTCNc6jxUo89DNeAKM8MKsntt6io=;
        b=O3tuAyPEt5tUwj9nA2TUeBdZq1qchspc7HK5TV/39GBLSh0w5JHKrIFPJiVTSxszCF
         XFQ83tV4Ggp6hR7M+phqs7y/vX4jqMAU4iNBnl5TRrlntDDsV/dZktBpaIPMXhIxfCju
         xF2aL947OVKMUtQ1Mi1Mrz4RB/6PmzdSzK4BeV6BSy/KfxFC3zvg08KxMT9V5U8oZUJ/
         wLQ/H9ueoc2SFGmwYom0kX2IMdNBo9u+UdaLCDhGhc74pYde4iKtzpRPombvUx+Pm8UE
         j9tz5xMDmHwAB97Xzmz+Y5SH8iD90RVk5LlHRBk2O+ZBtzo5vRWuNF4lPydTmtBGxUrZ
         VvdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683189023; x=1685781023;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rV+tL/t9XDmkYZFeTCNc6jxUo89DNeAKM8MKsntt6io=;
        b=aTwaSeNp+TTKVpiMoQjRXjS2h1XMAjMYMhP0zu8TmPMPpTJxe1P7lgUtkK6GzWAVJB
         47JvUA4w7fAnVPjW07ifztNzjLsB5zHN25iXHMJ7bHNbjfDaCs3JEQrlQ4KdOF06ve2T
         +vDKY0pEZmbMR/zoU489KoM4ur1MYCoZInga6v3KXBN+ISmF7qBBZ7+/uMxiYX/rZaBh
         /I271Fbvr99+Paqup914wOpbu8dfScVEYhEVuEwY3bkXkNdXnKg/O+Bp2lMGgTm8+mda
         SYIPJGSj6mH0QB1yHHGFdrJdmTxvTH3vgMcSB80H9aOWd5kh+4HgC+sqSPECO92wYYtV
         D/vg==
X-Gm-Message-State: AC+VfDyh/yuzTLQOnofufbcnexrGNso+Crw64Ljqs7grJ83icUJHw2SH
        9ph+sL0e3/lLhKtcfDV/61PQ9w==
X-Google-Smtp-Source: ACHHUZ4+Wuqf3NyKSSspIPIleEd/7Dks6u0AsJDkaHp8eLfUdruPWjU4d3jVoeGXSF2ndiLLK8N3tg==
X-Received: by 2002:a05:6a00:1884:b0:643:7c69:f561 with SMTP id x4-20020a056a00188400b006437c69f561mr2067225pfh.31.1683189023201;
        Thu, 04 May 2023 01:30:23 -0700 (PDT)
Received: from google.com (41.183.143.34.bc.googleusercontent.com. [34.143.183.41])
        by smtp.gmail.com with ESMTPSA id m9-20020a629409000000b00639eae8816asm24773444pfe.130.2023.05.04.01.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 01:30:22 -0700 (PDT)
Date:   Thu, 4 May 2023 14:00:14 +0530
From:   Ajay Agarwal <ajayagarwal@google.com>
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Nikhil Devshatwar <nikhilnd@google.com>,
        Manu Gautam <manugautam@google.com>,
        "David E. Box" <david.e.box@linux.intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Michael Bottini <michael.a.bottini@linux.intel.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 2/5] PCI/ASPM: Set ASPM_STATE_L1 only when driver
 enables L1.0
Message-ID: <ZFNtFsirHTNZgBhP@google.com>
References: <20230502193140.1062470-1-ajayagarwal@google.com>
 <20230502193140.1062470-3-ajayagarwal@google.com>
 <156efde9-06e5-bb5a-d9e3-8a29ade0a719@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <156efde9-06e5-bb5a-d9e3-8a29ade0a719@linux.intel.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 02, 2023 at 06:17:31PM -0700, Sathyanarayanan Kuppuswamy wrote:
> 
> 
> On 5/2/23 12:31 PM, Ajay Agarwal wrote:
> > Currently the core driver sets ASPM_STATE_L1 as well as
> 
> I think you can use the term ASPM driver uniformly.
>
Ack. Will change in the next version.

> > ASPM_STATE_L1SS when the caller wants to enable just L1.0.
> 
> L1?
> 
Ack. Will change in the next version.

> > This is incorrect. Fix this by setting the ASPM_STATE_L1 bit
> > only when the caller wishes to enable L1.0.
> > 
> > Signed-off-by: Ajay Agarwal <ajayagarwal@google.com>
> > ---
> 
> Otherwise, looks fine.
> 
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> > Changelog since v1:
> >  - Break down the L1 and L1ss handling into separate patches
> > 
> >  drivers/pci/pcie/aspm.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > index 5765b226102a..4ad0bf5d5838 100644
> > --- a/drivers/pci/pcie/aspm.c
> > +++ b/drivers/pci/pcie/aspm.c
> > @@ -1170,8 +1170,7 @@ int pci_enable_link_state(struct pci_dev *pdev, int state)
> >  	if (state & PCIE_LINK_STATE_L0S)
> >  		link->aspm_default |= ASPM_STATE_L0S;
> >  	if (state & PCIE_LINK_STATE_L1)
> > -		/* L1 PM substates require L1 */
> > -		link->aspm_default |= ASPM_STATE_L1 | ASPM_STATE_L1SS;
> > +		link->aspm_default |= ASPM_STATE_L1;
> >  	if (state & PCIE_LINK_STATE_L1_1)
> >  		link->aspm_default |= ASPM_STATE_L1_1;
> >  	if (state & PCIE_LINK_STATE_L1_2)
> 
> -- 
> Sathyanarayanan Kuppuswamy
> Linux Kernel Developer
