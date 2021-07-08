Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E19D03C1A83
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jul 2021 22:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbhGHU1m (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Jul 2021 16:27:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55063 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230238AbhGHU1m (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Jul 2021 16:27:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625775898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6amVMDUb/Hi3saNiHAOx2mrfmfmrxj1UyTOgCVIlUVE=;
        b=YGb7803PcnrLwnxCEIkEgXgvUNOG44Kqrn+1aoqEHwzfMgDu8N8gLM9ZQ20FWzgiPoqjTT
        IvoZv48qZF1gDy7jkJzvcub1BeibZ+tzfSAxGPlK5aSJ5fK/aHriJMMTjsGsNNRDoycCyN
        6hTvsCN49xad3Zqyki7Ow4NdBav2gmo=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-111-n9fryyJpMqK-XMSZJldQug-1; Thu, 08 Jul 2021 16:24:57 -0400
X-MC-Unique: n9fryyJpMqK-XMSZJldQug-1
Received: by mail-oi1-f198.google.com with SMTP id n84-20020acaef570000b029022053bcedd7so5180105oih.17
        for <linux-pci@vger.kernel.org>; Thu, 08 Jul 2021 13:24:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6amVMDUb/Hi3saNiHAOx2mrfmfmrxj1UyTOgCVIlUVE=;
        b=EUQYYTcMbDf5JGBRzIUbWIT0NIuKFYilLemz4AaAJRPYZMwLUY8klDfMje7rPGdLth
         IZOxU3q8aAWwu6bvqOSTwpVJ0YPFP7MzeLnlXEX+w0CvKbVZDq7HClSfd6Nowl/7Hoop
         +5RkcRAJ4EAdZOfUplH1/DMD7YRD5BJYGBfS8YPIQ+dsQE9Yz20JkQuhKTNjo/oOF46s
         /sE0gJkXFW0Zo1wAQth/pRVZoMne3uRsk4MKUynsu73Sd1xl22fstU4jIrxFED8NLDvs
         Pq7TX6FEVzx7m/nwlT47OABzrLdEglDC5oXcfIuYsLRLcFIe3eA0iYLNeUU0RJ4lsiuQ
         VWrw==
X-Gm-Message-State: AOAM533ixmHurLSDgn+bA68iam60Fz+L5j2YDChstVKdzXy+o+huElad
        DIF3MjOVxoc+2olrsgAoXp8AO9X2po86jmcxSalINXqIGyqOB25aE3Ic03nPXnjdRGyjXMn7K2r
        1ZPe+rfz2hfJQ2CeLr77N
X-Received: by 2002:a9d:491:: with SMTP id 17mr16534520otm.184.1625775896750;
        Thu, 08 Jul 2021 13:24:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyNNYCOTyh0Fp/3tdG3l31BTtUlQpSQlmvr+WIJaq7RUYUYmACs73ASFB4mE1t+QQ3TNMSp9A==
X-Received: by 2002:a9d:491:: with SMTP id 17mr16534500otm.184.1625775896494;
        Thu, 08 Jul 2021 13:24:56 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id i16sm695741otp.7.2021.07.08.13.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 13:24:56 -0700 (PDT)
Date:   Thu, 8 Jul 2021 14:24:54 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Amey Narkhede <ameynarkhede03@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v9 1/8] PCI: Add pcie_reset_flr to follow calling
 convention of other reset methods
Message-ID: <20210708142454.566608c1.alex.williamson@redhat.com>
In-Reply-To: <20210705143739.nghgqghnskp7emai@archlinux>
References: <20210705142138.2651-1-ameynarkhede03@gmail.com>
        <20210705142138.2651-2-ameynarkhede03@gmail.com>
        <20210705143739.nghgqghnskp7emai@archlinux>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 5 Jul 2021 20:07:39 +0530
Amey Narkhede <ameynarkhede03@gmail.com> wrote:

> On 21/07/05 07:51PM, Amey Narkhede wrote:
> > Add has_pcie_flr bitfield in struct pci_dev to indicate support for PCIe
> > FLR to avoid reading PCI_EXP_DEVCAP multiple times.
> >
> > Currently there is separate function pcie_has_flr() to probe if PCIe FLR
> > is supported by the device which does not match the calling convention
> > followed by reset methods which use second function argument to decide
> > whether to probe or not. Add new function pcie_reset_flr() that follows
> > the calling convention of reset methods.
> >
> > Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
> > ---
> >  drivers/crypto/cavium/nitrox/nitrox_main.c |  4 +-
> >  drivers/pci/pci.c                          | 59 +++++++++++-----------
> >  drivers/pci/pcie/aer.c                     | 12 ++---
> >  drivers/pci/probe.c                        |  6 ++-
> >  drivers/pci/quirks.c                       |  9 ++--
> >  include/linux/pci.h                        |  3 +-
> >  6 files changed, 45 insertions(+), 48 deletions(-)
> >
> > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c  
> [...]
> > index 3a62d09b8..a95252113 100644
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -1487,6 +1487,7 @@ void set_pcie_port_type(struct pci_dev *pdev)
> >  {
> >  	int pos;
> >  	u16 reg16;
> > +	u32 reg32;
> >  	int type;
> >  	struct pci_dev *parent;
> >
> > @@ -1497,8 +1498,9 @@ void set_pcie_port_type(struct pci_dev *pdev)
> >  	pdev->pcie_cap = pos;
> >  	pci_read_config_word(pdev, pos + PCI_EXP_FLAGS, &reg16);
> >  	pdev->pcie_flags_reg = reg16;
> > -	pci_read_config_word(pdev, pos + PCI_EXP_DEVCAP, &reg16);
> > -	pdev->pcie_mpss = reg16 & PCI_EXP_DEVCAP_PAYLOAD;
> > +	pci_read_config_dword(pdev, pos + PCI_EXP_DEVCAP, &reg32);
> > +	pdev->pcie_mpss = reg32 & PCI_EXP_DEVCAP_PAYLOAD;
> > +	pdev->has_pcie_flr = reg32 & PCI_EXP_DEVCAP_FLR ? 1 : 0;  
> On the side note, removing ternary here as Alex suggested doesn't work
> for some reason.

Probably I'm just incorrectly extrapolating boolean behavior to
bitfields, but indeed it doesn't work that way.  The other option is to
use the !! trick, ie. has_pcie_flr = !!(reg32 & PCI_EXP_DEVCAP_FLR),
but both solutions are used elsewhere in this file.

Reviewed-by: Alex Williamson <alex.williamson@redhat.com>

