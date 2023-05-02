Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51FB6F43F3
	for <lists+linux-pci@lfdr.de>; Tue,  2 May 2023 14:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234182AbjEBMi2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 May 2023 08:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233865AbjEBMiZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 May 2023 08:38:25 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC1C526E
        for <linux-pci@vger.kernel.org>; Tue,  2 May 2023 05:38:24 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-517c01edaaaso2447176a12.3
        for <linux-pci@vger.kernel.org>; Tue, 02 May 2023 05:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683031104; x=1685623104;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KLFMAJA7tZA0luP4td16iaiCfPDTEGjHwudS7SeZToc=;
        b=bTAArmkVfvnxRc2zR4dpUJ9wamh0MQA6OZrmIRCj6QRlQBLlAhpI4tsRqAML9mKIFp
         d3JDpCk9LeAERxqMml9nM0XUjj0BU1WXxHly77BFtuHeQSUSS3KH3yXv9rhkcxis1c+z
         ulqhf0qFBu1SbqXPXGD6Lf0uib7NVbIMSFm2q9wyLYmhDIp81UygaGIxaKLmFvm/Lecc
         taJYoCY8j9jbDzGygYIKcnSp2bNmKueyv8P80mdcITBb5+p/usqnLdyXZWb4F6fG038k
         n2IrxcORUjJ8V6zRcM6CcXmJumf7d/hKPpVYPY19Ovze/0FavteAOUw5xD0fn4Xlq/SO
         aJAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683031104; x=1685623104;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KLFMAJA7tZA0luP4td16iaiCfPDTEGjHwudS7SeZToc=;
        b=JJraqJV7amkV14xXPSlSSpHj4FQK/ux5QLp9dqgXHvDCPTEAlatjR6v/82+wN4278R
         y2fAdQwPw5QULmGU8NB3+/VGf1CST0RhX4dNGxGzo5YpWI0vpTFt8NAepBShia9Rjn8z
         6O9Ogyzqc/2myRQMpA5rsDBYDoxHp+CVYCYEekDDB02tzK+V1pBpJVfojAlsjHPFWYBr
         N7FxYAV9eom1VE9YdsbdU6xrB7CaBcg61sPp8cB1/eXuVB9IL2DQExfqeZWOnvjVE0aJ
         hvMwfcED5AzFzim0LzlLt9ZdHuQoIO9/OjGApbY6VZvqkSzT2rCD6bKX858GMuCKrfqq
         KOeA==
X-Gm-Message-State: AC+VfDxLfekvuew79zPasa3RBowQcn7sajZpEMr5pxbWySNk0wGV0qf/
        4JSiRATVU2+7euQqueuDvocoJg==
X-Google-Smtp-Source: ACHHUZ6E7C2TjCRZZP1yVExXD28WMJU52GmvAgzRWSMrnjRj2vxM6Ll3rXRs/EdC9NbM2hyYo0ApoQ==
X-Received: by 2002:a17:903:4d:b0:1aa:dba2:d155 with SMTP id l13-20020a170903004d00b001aadba2d155mr9687452pla.48.1683031103648;
        Tue, 02 May 2023 05:38:23 -0700 (PDT)
Received: from google.com (41.183.143.34.bc.googleusercontent.com. [34.143.183.41])
        by smtp.gmail.com with ESMTPSA id bf9-20020a170902b90900b001a245b49731sm19680165plb.128.2023.05.02.05.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 05:38:22 -0700 (PDT)
Date:   Tue, 2 May 2023 18:08:13 +0530
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
Subject: Re: [PATCH 1/3] PCI/ASPM: Disable ASPM_STATE_L1 only when class
 driver disables L1 ASPM
Message-ID: <ZFEENUdnDPCvwtVS@google.com>
References: <20230411111034.1473044-2-ajayagarwal@google.com>
 <20230501172114.GA591899@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230501172114.GA591899@bhelgaas>
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

On Mon, May 01, 2023 at 12:21:14PM -0500, Bjorn Helgaas wrote:
> On Tue, Apr 11, 2023 at 04:40:32PM +0530, Ajay Agarwal wrote:
> > Currently the aspm driver sets ASPM_STATE_L1 as well as
> > ASPM_STATE_L1SS bits when the class driver disables L1.
> 
> I would have said just "driver" -- do you mean something different by
> using "class driver"?  The callers I see are garden-variety drivers
> for individual devices like hci_bcm4377, xillybus_pcie, e1000e, jme,
> etc.
No, I do not mean anything different by "class driver". I just wanted
to name the caller drivers of the ASPM APIs as something other than
just "driver". Do you want me to change this to "driver" ?
> 
> > pcie_config_aspm_link takes care that L1ss ASPM is not enabled
> > if L1 is disabled. ASPM_STATE_L1SS bits do not need to be
> > explicitly set. The sysfs node store() function, which also
> > modifies the aspm_disable value, does not set these bits either
> > when only L1 ASPM is disabled by the user.
> 
> Right.  It'd be nice to combine __pci_disable_link_state() and
> aspm_attr_store_common() so they use the same logic for this, but
> that's not really trivial to do.
> 
Ack.
> > Disable ASPM_STATE_L1 only when class driver disables L1 ASPM.
> 
> So IIUC, this is a cleanup and should not fix any actual function
> bugs, right?  If it *does* fix a bug, we should add a Fixes: tag and a
> description of the bug.
> 
Yes, this is just a cleanup.
> > Signed-off-by: Ajay Agarwal <ajayagarwal@google.com>
> > ---
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
> > -- 
> > 2.40.0.577.gac1e443424-goog
> > 
