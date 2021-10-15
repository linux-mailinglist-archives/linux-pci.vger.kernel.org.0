Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED6F042F9A7
	for <lists+linux-pci@lfdr.de>; Fri, 15 Oct 2021 19:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242047AbhJORIP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Oct 2021 13:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242018AbhJORIK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Oct 2021 13:08:10 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71917C061570;
        Fri, 15 Oct 2021 10:06:04 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id j190so2400539pgd.0;
        Fri, 15 Oct 2021 10:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fgXRhIDv4avAhYWPVKqD4fihMIZxTJmiPhjtzsC9r0g=;
        b=blvEzhzRWWIU/TZxsMK2Eh5RErZ/DFjMxSPdwQiUQELylPvjitlEA2KS+l/0PNDtzr
         gFi1fmsOpzzU4aeTXv4XEqxpYH9pDazJwktWCjuz0XjRoxCe5EyjCehBOyrKoPrpPNOf
         bzow4Pf69nfg6Gx5qGYdFuBJREmLyx7HNBAh+kT7f+VBGrADy6E4wkuRwy45RVEVVqzz
         BQdC2+yD2vCj0tKEqeqjsiv2EFoP2VOmUfPwTklwkp0Qjytc5RA9so9uZMXn8TImDK4M
         zKRA+NbzDx8cfy76+2szt6uqCWVJcGZn0Ob4I7HnaZfoCou6N6B6jJ2eqNZcbEPMnXJZ
         5PPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fgXRhIDv4avAhYWPVKqD4fihMIZxTJmiPhjtzsC9r0g=;
        b=SRz+hpFFfLUC0iBsU2oqHImg2LBtdAiMJIKwY6g3VdVnyxGWTwmtO86nFRuX754i8V
         in/OgoKrfRGyvKglrrUVYKF2oCqZv3LLykmvE7pXTkcbRlwErf3bf2Y2/3v0/2CTGXw1
         9AFCPL0hQAzhEmoojTun3acy0TIZyCdsRsoMQThBYDjJ6jW+Kf7+zVJ6msOCgxg6yMYm
         oow4fly1Rl+SoXGAVUgiPCWmfQhmMUmK5+VnlZOPo6hvZ23G9cSu6Wfd958XQjUsSnuj
         lO8iiPVfvQkMIohPE0RhIqsAqWbBBbUD30VyzxTWNAVjGGCqPc226L8+raSYdtCp4dYP
         P3sw==
X-Gm-Message-State: AOAM531RnSSD4vYASq/VBb+j9NUy9iUs19lQqZdPwJv+NymLYMGKVzVB
        QHo1sDeN6XZiv7i5A2GK9jg=
X-Google-Smtp-Source: ABdhPJwm9rJNVdj0Qh6+rCPdEpEM9SAT0p+nmVQMRFCjROXihNP69pqeyY8uGOfEu5PUiAhQgGi4Hw==
X-Received: by 2002:a63:1a1b:: with SMTP id a27mr9985068pga.220.1634317563746;
        Fri, 15 Oct 2021 10:06:03 -0700 (PDT)
Received: from theprophet ([2406:7400:63:4806:ba0d:a155:7e81:f0b2])
        by smtp.gmail.com with ESMTPSA id m22sm5376221pfo.71.2021.10.15.10.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 10:06:03 -0700 (PDT)
Date:   Fri, 15 Oct 2021 22:35:52 +0530
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     Ray Jui <ray.jui@broadcom.com>
Cc:     bhelgaas@google.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        "maintainer:BROADCOM IPROC ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "moderated list:BROADCOM IPROC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 06/24] PCI: iproc: Remove redundant error fabrication
 when device read fails
Message-ID: <20211015170552.kl2unzbynygvw3lv@theprophet>
References: <cover.1634306198.git.naveennaidu479@gmail.com>
 <71757601a719e2ff6ca27615183e322a7709ff65.1634306198.git.naveennaidu479@gmail.com>
 <a3f9ab4e-094b-437e-5c7b-7f72c50b3ff5@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3f9ab4e-094b-437e-5c7b-7f72c50b3ff5@broadcom.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 15/10, Ray Jui wrote:
> 
> 
> On 10/15/2021 7:38 AM, Naveen Naidu wrote:
> > An MMIO read from a PCI device that doesn't exist or doesn't respond
> > causes a PCI error. There's no real data to return to satisfy the
> > CPU read, so most hardware fabricates ~0 data.
> > 
> > The host controller drivers sets the error response values (~0) and
> > returns an error when faulty hardware read occurs. But the error
> > response value (~0) is already being set in PCI_OP_READ and
> > PCI_USER_READ_CONFIG whenever a read by host controller driver fails.
> > 
> > Thus, it's no longer necessary for the host controller drivers to
> > fabricate any error response.
> > 
> > This helps unify PCI error response checking and make error check
> > consistent and easier to find.
> > 
> > Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
> > ---
> >  drivers/pci/controller/pcie-iproc.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
> > index 30ac5fbefbbf..e3d86416a4fb 100644
> > --- a/drivers/pci/controller/pcie-iproc.c
> > +++ b/drivers/pci/controller/pcie-iproc.c
> > @@ -659,10 +659,8 @@ static int iproc_pci_raw_config_read32(struct iproc_pcie *pcie,
> >  	void __iomem *addr;
> >  
> >  	addr = iproc_pcie_map_cfg_bus(pcie, 0, devfn, where & ~0x3);
> > -	if (!addr) {
> > -		*val = ~0;
> > +	if (!addr)
> >  		return PCIBIOS_DEVICE_NOT_FOUND;
> > -	}
> >  
> >  	*val = readl(addr);
> >  
> > 
> 
> I think it would be helpful if you include us in the review of the PCI
> core code change (pci.h and access.c) so we get the right context to
> review this change at the individual driver level.
>

I apologize for the rookie mistake ^^', I'll see to it from next time 
that I always add proper recepients to the patches so that everyone 
gets enough context.

> The driver change looks fine to me, as long as the change in the core is
> reviewed and approved.
> 

Thank you very much for taking the time to review it.

> Thanks,
> 
> Ray


