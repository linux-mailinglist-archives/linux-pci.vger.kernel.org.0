Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B566F6796
	for <lists+linux-pci@lfdr.de>; Thu,  4 May 2023 10:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbjEDIeV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 May 2023 04:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbjEDIeC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 May 2023 04:34:02 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345953C3A
        for <linux-pci@vger.kernel.org>; Thu,  4 May 2023 01:31:36 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-24eab83867dso245095a91.3
        for <linux-pci@vger.kernel.org>; Thu, 04 May 2023 01:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683189091; x=1685781091;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xLyNv2BB6eWTAvKPZkrEam6NtDpY2Y4MwpHODk63Uk8=;
        b=dNfFr1mSphmY7fwuOg0J3uYQ6NSuEiqgDppju4O3cYwntS0EaR/fxWMZykz0OeFbBA
         FXwFcfG97KDBezPhagKE6TC4c6NEFuf7Ze92LxsqBD9YiVdCEla4am0e6l+ozt90/c9E
         J+uknuqAOOvt/XThD6djbzsNFm4R2/md2d+sG/uU2955JKL2KAkjjbNx/cF2Uha58W0w
         Lu85XsuuhCh3hkLlbZoW5A81m0JlAdOTHXR0Of+XDYn2GBSv+GvLi6QG2DrqQYMJILL2
         CnW4eBUjxSjEHVBiJIU2mmsFZA3FNpJD5SO0HZdMQe00Q/1bjutWd7SdqAdqKOM6WSp+
         QPMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683189091; x=1685781091;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xLyNv2BB6eWTAvKPZkrEam6NtDpY2Y4MwpHODk63Uk8=;
        b=eJ2aPvNgyexX92/3ueuWi91f8dW5CUWNedtqMJcrEukP4LcqnPp5IgWUmhO/8dXF/p
         0L+jagdcDcMWq6hn2BdxyXl/Em/nyniQzATIkLCe/0djKmtRP2V4iZuxZcXM76Mxgkuf
         sFwKHKfyvjsRY3+7RGcvTzv2KbGv95kj+OKhvnnsa5EMD5mzlS+kZ9C52PODgRB4Qf/W
         ktsqFbUol7Pfs+luYh1IwxbV4Hig9lx6b1N6wt+0GIeJR3SND2V1krLRK5m7dtQVZS2E
         /CCqQBpj7PNcJOwVGOrLzGOCBs0YgitGV2ExuCpessgMaCHm+RygVCPqZMx+csnI/9wz
         39Lg==
X-Gm-Message-State: AC+VfDxkXCinX2MEv9kwHAK27zGTdwMdu/Q6rHB2AdyOPV6Jw3U3TMZ5
        bWlINkRrfEpXnROTuT0IA9y1hA==
X-Google-Smtp-Source: ACHHUZ6jVJknq76i9Dg4cU/Zt9IiQ+UK2zkerlL67IU16yXJNRXxcriKKZYDmRu/lOWVORq/3xXVPw==
X-Received: by 2002:a17:90b:3a81:b0:23f:81c0:eadd with SMTP id om1-20020a17090b3a8100b0023f81c0eaddmr1223570pjb.47.1683189090926;
        Thu, 04 May 2023 01:31:30 -0700 (PDT)
Received: from google.com (41.183.143.34.bc.googleusercontent.com. [34.143.183.41])
        by smtp.gmail.com with ESMTPSA id q22-20020a63e956000000b005033e653a17sm21396910pgj.85.2023.05.04.01.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 01:31:30 -0700 (PDT)
Date:   Thu, 4 May 2023 14:01:22 +0530
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
Subject: Re: [PATCH v2 3/5] PCI/ASPM: Set ASPM_STATE_L1 when driver enables
 L1ss
Message-ID: <ZFNtWkEPzKPeWqGj@google.com>
References: <20230502193140.1062470-1-ajayagarwal@google.com>
 <20230502193140.1062470-4-ajayagarwal@google.com>
 <7749ee33-04a4-e119-48fc-d78da77fe667@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7749ee33-04a4-e119-48fc-d78da77fe667@linux.intel.com>
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

On Tue, May 02, 2023 at 06:18:56PM -0700, Sathyanarayanan Kuppuswamy wrote:
> 
> 
> On 5/2/23 12:31 PM, Ajay Agarwal wrote:
> > Currently the aspm driver does not set ASPM_STATE_L1 bit in
> > aspm_default when the caller requests L1SS ASPM state. This will
> > lead to pcie_config_aspm_link() not enabling the requested L1SS
> > state. Set ASPM_STATE_L1 when driver enables L1ss.
> > 
> 
> Is there a bug associated with this issue?
> 
There is no bug associated. I found this through my dry run of the code.

> > Signed-off-by: Ajay Agarwal <ajayagarwal@google.com>
> > ---
> > Changelog since v1:
> >  - Break down the L1 and L1ss handling into separate patches
> > 
> >  drivers/pci/pcie/aspm.c | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > index 4ad0bf5d5838..7c9935f331f1 100644
> > --- a/drivers/pci/pcie/aspm.c
> > +++ b/drivers/pci/pcie/aspm.c
> > @@ -1171,14 +1171,15 @@ int pci_enable_link_state(struct pci_dev *pdev, int state)
> >  		link->aspm_default |= ASPM_STATE_L0S;
> >  	if (state & PCIE_LINK_STATE_L1)
> >  		link->aspm_default |= ASPM_STATE_L1;
> > +	/* L1 PM substates require L1 */
> >  	if (state & PCIE_LINK_STATE_L1_1)
> > -		link->aspm_default |= ASPM_STATE_L1_1;
> > +		link->aspm_default |= ASPM_STATE_L1_1 | ASPM_STATE_L1;
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
> 
> -- 
> Sathyanarayanan Kuppuswamy
> Linux Kernel Developer
