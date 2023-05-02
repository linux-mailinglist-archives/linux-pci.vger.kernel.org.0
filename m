Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E92C6F44A8
	for <lists+linux-pci@lfdr.de>; Tue,  2 May 2023 15:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233286AbjEBNHV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 May 2023 09:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233271AbjEBNHU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 May 2023 09:07:20 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F7B4C2B
        for <linux-pci@vger.kernel.org>; Tue,  2 May 2023 06:07:19 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1aaebed5bd6so19912565ad.1
        for <linux-pci@vger.kernel.org>; Tue, 02 May 2023 06:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683032838; x=1685624838;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rmxm9dPnYS1OOciEzkPHW++3QwoZ94DZtGpau69MAZA=;
        b=FoDC1YUXDETlEfzYj22ZWQx/bpFLO5YiPb6o7WiywxvseKlxSNziQgdTDRTQnyzzr0
         dZWOv61c3zUshLPkqtmEJ9tWDJUNqhhAPn1u5LIVYXVNMTBDP6FCoShiMbEqELrQNs2R
         vrG9TzVkZvSghHEPUo8SAtkUx/Juk7V6/tsN8CekH1a2iHpLv7h/EtOMup3HzZ1fm6P3
         oT6YscxWQ23sjCgkPx13d+BomK/+Pq5whifRcVT8Qgl4eIsM0HmM7kDaJQ4irwpq/hrD
         Qol6fs3uQFnSoqxaaMFbmiOahegrnNLbJV7wmnUjjj5OQtDDT8zI6x9sKwZrvSJ4ChsL
         Rnpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683032838; x=1685624838;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rmxm9dPnYS1OOciEzkPHW++3QwoZ94DZtGpau69MAZA=;
        b=V9cqA4t3rSKS1f7CcAGpA8ReDvMTjNyrLLELz7Rz15FO0ACiGXbgtrZuAjtq5QZPQr
         WNcdsab+hZWFq6uZM/I9dYds48+s20/ja19I4MxyRrjpqT1TxE4WilS4PE0Ko1UPgaan
         Isa2jALAyuLvVDrubpWWNaHHbsabSwD5tWUMJ0TW6sGED/gw16RwRPH7iuXzQ0Q9/kZL
         NVsKSAyIB9UxJrCpDEfuuAdGLD4LGWPQIFftWePH9d373hzKUa+dfhgT/+7ahIuNecFl
         u4G2Am0y8xaHkK1dhhFOmFzghwjnV2wW9zwX1a5BoT8J3jfgHybGGBd9XnnUw2/wM1Ea
         Va0w==
X-Gm-Message-State: AC+VfDx1SArkt3AjVMYl2+jTL8jY04a/LvUF0GFID2aQ73tuM83D9q86
        jFaDcpVo6l7WzdRyvytkbiNjfw==
X-Google-Smtp-Source: ACHHUZ60sXbcw2Fp+1XFY6J4iuGq5jzP0qbKz8B3AxIQ5nJcdF1z51FA6zhdKfkPvriQiiDpLY01Pg==
X-Received: by 2002:a17:902:ec87:b0:1a9:bb48:2aae with SMTP id x7-20020a170902ec8700b001a9bb482aaemr19748395plg.52.1683032838419;
        Tue, 02 May 2023 06:07:18 -0700 (PDT)
Received: from google.com (41.183.143.34.bc.googleusercontent.com. [34.143.183.41])
        by smtp.gmail.com with ESMTPSA id n4-20020a1709026a8400b001a69b28f5c5sm19651992plk.222.2023.05.02.06.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 06:07:17 -0700 (PDT)
Date:   Tue, 2 May 2023 18:37:09 +0530
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
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 3/3] PCI/ASPM: Remove unnecessary ASPM_STATE_L1SS check
Message-ID: <ZFEK/TVIfKDKzpm3@google.com>
References: <20230411111034.1473044-4-ajayagarwal@google.com>
 <20230501175518.GA594484@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230501175518.GA594484@bhelgaas>
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

On Mon, May 01, 2023 at 12:55:18PM -0500, Bjorn Helgaas wrote:
> On Tue, Apr 11, 2023 at 04:40:34PM +0530, Ajay Agarwal wrote:
> > Currently the driver checks if ASPM_STATE_L1SS is supported
> > before calling aspm_calc_l1ss_info(), only for this function to
> > return if ASPM_STATE_L1_2_MASK is not supported. Simplify the
> > logic by directly checking for L1.2 mask.
> > 
> > Signed-off-by: Ajay Agarwal <ajayagarwal@google.com>
> > ---
> >  drivers/pci/pcie/aspm.c | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> > 
> > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > index 7c9935f331f1..8c45835e8016 100644
> > --- a/drivers/pci/pcie/aspm.c
> > +++ b/drivers/pci/pcie/aspm.c
> > @@ -481,9 +481,6 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
> >  	u32 pctl1, pctl2, cctl1, cctl2;
> >  	u32 pl1_2_enables, cl1_2_enables;
> >  
> > -	if (!(link->aspm_support & ASPM_STATE_L1_2_MASK))
> > -		return;
> > -
> >  	/* Choose the greater of the two Port Common_Mode_Restore_Times */
> >  	val1 = (parent_l1ss_cap & PCI_L1SS_CAP_CM_RESTORE_TIME) >> 8;
> >  	val2 = (child_l1ss_cap & PCI_L1SS_CAP_CM_RESTORE_TIME) >> 8;
> > @@ -616,7 +613,7 @@ static void aspm_l1ss_init(struct pcie_link_state *link)
> >  	if (parent_l1ss_ctl1 & child_l1ss_ctl1 & PCI_L1SS_CTL1_PCIPM_L1_2)
> >  		link->aspm_enabled |= ASPM_STATE_L1_2_PCIPM;
> >  
> > -	if (link->aspm_support & ASPM_STATE_L1SS)
> > +	if (link->aspm_support & ASPM_STATE_L1_2_MASK)
> >  		aspm_calc_l1ss_info(link, parent_l1ss_cap, child_l1ss_cap);
> 
> I think the reason it was this way is because several of the relevant
> names use "l1ss":
> 
>   ASPM_STATE_L1SS
>   aspm_calc_l1ss_info
>   calc_l1ss_pwron
> 
> But everything in aspm_calc_l1ss_info() is L1.2-specific, so I think
> it would make sense to use your patch, and at the same time, rename
> aspm_calc_l1ss_info() and calc_l1ss_pwron() to aspm_calc_l12_info()
> and calc_l12_pwron() to match.
> 
> Bjorn
Sure, will incorporate your suggestions in the next version.
