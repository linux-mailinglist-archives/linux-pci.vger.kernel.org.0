Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ADD54E473C
	for <lists+linux-pci@lfdr.de>; Tue, 22 Mar 2022 21:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiCVUMG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Mar 2022 16:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232727AbiCVUMF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Mar 2022 16:12:05 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE6C5EBD6
        for <linux-pci@vger.kernel.org>; Tue, 22 Mar 2022 13:10:32 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id i184so2592966pgc.1
        for <linux-pci@vger.kernel.org>; Tue, 22 Mar 2022 13:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yxRoOuDAQ32T7epvmjmCMUDa2ze+iRE6nt0uAlg4Cn4=;
        b=lmELaTz7WP/HCCZzx81ngJJsBsHi+8NNkFAdHtPQ8AA9Up+PwmmEc27JoRzPCC3bGF
         ypk4x3onyQ3gaTiIYEwIDn5jRK/vCJg3N5JhJf6RAjv4NRF5GENUps0Ntr+1PcidHWaB
         2a6jKQMajECNEYH6nQUEqAFRtx2s1//6L8S/oUjHhiCItaEBkG9fYZMeHRARLVRof+fU
         VeqU2FeJGUYPCNnYajwC2MZNe12kKcEphyLwe+XM0C13pKnxJoNN8QEk0KXf4o5afx/X
         Kq+6r3tYjHYxjwRpkEyKGU0QDVqvlg29oIG0TAs3YSO/LyFvemSnXsoHZLDq+hg0KcvL
         9tcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yxRoOuDAQ32T7epvmjmCMUDa2ze+iRE6nt0uAlg4Cn4=;
        b=dN/rCjGiNkj3a8+QWDwcep81CTJy072xAS+8vnw+WBWbuUBy3/V/FzK8SyavIIJJ/c
         FmIQdTB0rlgtjc6d+tJILn2AjZLYLI1QS97/IMQ1obWErByt6JZMNhN6U0BGZ44gQVgi
         yT9+4O3hM0FLnhT6CdposydGPhAr6M0opHZ0pqQjnHPApfbNeEH+IYQ6BKCg8TO3phnR
         4QygeTBAvjJhzIKMw8wT07MkJXg/d5RZrhyQ3fafBNKRqHWS/xeLyhc2ymOYbPn37r0h
         QneEc+jao32TTSqEGXA98bCQXxANpH9I5dKIYaGzu+PRrmZoXtRysGULihSagrhVe8WR
         ifDQ==
X-Gm-Message-State: AOAM530QyKPh4j2x7PBQhWiH9muDLsE5PVy2lb5WLP0sa92YafVMcxSS
        X5RFuDLdOzzYqm0Nnug0bdN8zXOi5gWjXuERVhpesXE+jzc=
X-Google-Smtp-Source: ABdhPJyiLa4J6HZobaRPPLdsxYqNc7OtUXhU/czFKSJbwUv9zO/SiqHx4I4DyNmue6FaGBfUb/DumAGOIvZe5zD0WZc=
X-Received: by 2002:a63:416:0:b0:386:66e:33d9 with SMTP id 22-20020a630416000000b00386066e33d9mr833745pge.146.1647979831669;
 Tue, 22 Mar 2022 13:10:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220320062907.3272903-1-rajatja@google.com> <YjmQq1DvWnJwUh6R@infradead.org>
 <CAJZ5v0h9TnUELahzkO59Vqoio1QRHfixk58Yxgffa72rmEBgOA@mail.gmail.com>
In-Reply-To: <CAJZ5v0h9TnUELahzkO59Vqoio1QRHfixk58Yxgffa72rmEBgOA@mail.gmail.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Tue, 22 Mar 2022 13:09:55 -0700
Message-ID: <CACK8Z6Fz-TPW1fMpQB09fw11neq8eyn89XB8vy0ioB5zB0Hb9Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] PCI: Rename "pci_dev->untrusted" to "pci_dev->poses_dma_risk"
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>, Len Brown <lenb@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajat Jain <rajatxjain@gmail.com>,
        Dmitry Torokhov <dtor@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Pavel Machek <pavel@denx.de>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
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

On Tue, Mar 22, 2022 at 4:12 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Mar 22, 2022 at 10:02 AM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Sat, Mar 19, 2022 at 11:29:05PM -0700, Rajat Jain wrote:
> > > Rename the field to make it more clear, that the device can execute DMA
> > > attacks on the system, and thus the system may need protection from
> > > such attacks from this device.
> > >
> > > No functional change intended.
> > >
> > > Signed-off-by: Rajat Jain <rajatja@google.com>
> > > ---
> > > v4: Initial version, created based on comments on other patch
> >
> > What a horrible name.  Why not untrusted_dma which captures the
> > intent much better?
>
> FWIW, I like this one much better too.

Sure, no problems. I can change the name to "untrusted_dma".

Mika, can I carry forward your "Reviewed-by" tag with this name change too?

Thanks & Best Regards,

Rajat
