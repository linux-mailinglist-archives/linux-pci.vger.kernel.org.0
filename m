Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 021386F6789
	for <lists+linux-pci@lfdr.de>; Thu,  4 May 2023 10:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjEDIcD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 May 2023 04:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjEDIbt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 May 2023 04:31:49 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD532CA
        for <linux-pci@vger.kernel.org>; Thu,  4 May 2023 01:28:41 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-24e015fcf3dso204304a91.3
        for <linux-pci@vger.kernel.org>; Thu, 04 May 2023 01:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683188920; x=1685780920;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tEjDezjLNMz6Q+bhSt6ddNpZhrqfjSa5FXwnRa54oUo=;
        b=UZKJFgLyfeqJ8O+Hw6VnClHclg9WzVnplYalXaBRYqy002OGhaj5DaQBZPnHyU0XpW
         qpwxFJPbe8d3g/7fZl7MmvLr6xEaBKHb5D8neL/cnQgGjJVOvckN4ewa0VytYbuM4SFJ
         ulL2eNZyum/NkMwN9D+aKyCPdHA26gkC8OWTteCGRbxM/guy1rfRkLSU8tBlnafF6zQ3
         QffzKeVf0a2J8IxJcAGOsEpMCm2cNowZRtXqTmXv9VDoiy29xJZ41tKHje9G0RKfGoIj
         HMTRmbY5mQfAjOcg0OgBXtVxUO2K1ttQum7NcywW1leZ5rsrnImUyNLHWxXrkiz8plRU
         iaCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683188920; x=1685780920;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tEjDezjLNMz6Q+bhSt6ddNpZhrqfjSa5FXwnRa54oUo=;
        b=eDk/azL4QMWNY24uihHzX5/VxVDPiFGokDWU5AqwbvfrLCN7eC5kwVF2vD49xRBlPn
         Pcanl/UWSk/B1oyzyUJsD9tKwWwYMz4gqiIFOwSAhj1OqeUnWXxvAUtHf0cayayRqaPP
         nht2GrIvx5RDFkvj2RPMRwe3JQOQF0lK2zfsBy6Br/CeEvU1Nn0tDzr2PzjMyZjApiji
         XnTosgVa1TPM8pGsVVqkBv9qbcIGNy+06z8CCBmyKCd599Mod6/8asnxXtolpQnbuC9A
         ynh94R/02ibgyDNi6QMSBEqlpX3xPZSGxmLes5Mujw2xrTy3hXivu6d0iZW21bA2eguH
         3/Wg==
X-Gm-Message-State: AC+VfDwtMVSZxKRyX79JD/Kg3Q7rCO6lpg7ErMMab2g4PaHR5PaIdDOy
        c/jllvB2JPn3EKlJzGfCLt51Kg==
X-Google-Smtp-Source: ACHHUZ7N7AqHamlaEvLALqq1Yt4NT8ULB44KLqjpHKR5FGR3yHKBHKGVJBrT3ctClHCCYw3eAATvGg==
X-Received: by 2002:a17:90a:bb03:b0:24e:b7:d17e with SMTP id u3-20020a17090abb0300b0024e00b7d17emr1452304pjr.43.1683188920168;
        Thu, 04 May 2023 01:28:40 -0700 (PDT)
Received: from google.com (41.183.143.34.bc.googleusercontent.com. [34.143.183.41])
        by smtp.gmail.com with ESMTPSA id o3-20020a17090ad24300b0024e47fbe731sm2719613pjw.24.2023.05.04.01.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 01:28:39 -0700 (PDT)
Date:   Thu, 4 May 2023 13:58:30 +0530
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
Subject: Re: [PATCH v2 1/5] PCI/ASPM: Disable ASPM_STATE_L1 only when class
 driver disables L1 ASPM
Message-ID: <ZFNsroiBpwCd82bT@google.com>
References: <20230502193140.1062470-1-ajayagarwal@google.com>
 <20230502193140.1062470-2-ajayagarwal@google.com>
 <993c522a-04e6-6125-8d22-663bd414220f@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <993c522a-04e6-6125-8d22-663bd414220f@linux.intel.com>
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

On Tue, May 02, 2023 at 06:10:21PM -0700, Sathyanarayanan Kuppuswamy wrote:
> 
> 
> On 5/2/23 12:31 PM, Ajay Agarwal wrote:
> > Currently the aspm driver sets ASPM_STATE_L1 as well as
> > ASPM_STATE_L1SS bits in aspm_disable when the caller disables L1.
> > pcie_config_aspm_link takes care that L1ss ASPM is not enabled
> > if L1 is disabled. ASPM_STATE_L1SS bits do not need to be
> > explicitly set. The sysfs node store() function, which also
> > modifies the aspm_disable value, does not set these bits either
> > when only L1 ASPM is disabled by the user.
> > 
> > Disable ASPM_STATE_L1 only when the caller disables L1 ASPM.
> 
> Maybe you can add something like, No functional changes intended.
> 
Ack. Will do in the next version.

> Otherwise, looks good.
> 
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> > 
> > Signed-off-by: Ajay Agarwal <ajayagarwal@google.com>
> > ---
> > Changelog since v1:
> >  - Better commit message
> > 
> >  drivers/pci/pcie/aspm.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > index 66d7514ca111..5765b226102a 100644
> > --- a/drivers/pci/pcie/aspm.c
> > +++ b/drivers/pci/pcie/aspm.c
> > @@ -1095,8 +1095,7 @@ static int __pci_disable_link_state(struct pci_dev *pdev, int state, bool sem)
> >  	if (state & PCIE_LINK_STATE_L0S)
> >  		link->aspm_disable |= ASPM_STATE_L0S;
> >  	if (state & PCIE_LINK_STATE_L1)
> > -		/* L1 PM substates require L1 */
> > -		link->aspm_disable |= ASPM_STATE_L1 | ASPM_STATE_L1SS;
> > +		link->aspm_disable |= ASPM_STATE_L1;
> >  	if (state & PCIE_LINK_STATE_L1_1)
> >  		link->aspm_disable |= ASPM_STATE_L1_1;
> >  	if (state & PCIE_LINK_STATE_L1_2)
> 
> -- 
> Sathyanarayanan Kuppuswamy
> Linux Kernel Developer
