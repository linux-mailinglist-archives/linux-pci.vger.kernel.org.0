Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11C7A4E3D47
	for <lists+linux-pci@lfdr.de>; Tue, 22 Mar 2022 12:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbiCVLNj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Mar 2022 07:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbiCVLNi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Mar 2022 07:13:38 -0400
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B198021D;
        Tue, 22 Mar 2022 04:12:07 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id y142so32914005ybe.11;
        Tue, 22 Mar 2022 04:12:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eAEB4EkYiyDLjCGXztqi5rjXvrVzYwYiLfT7TEzd0Gg=;
        b=VMu0JthSWwJQzlqBhxdgxeHSTYPHATGBuT280Fwbbki1RMDIuLY78HvQjj4arVnZxW
         qGVKvGVXa8XjjhxQ2GI5vx+6cUauMoOAYWMxqo+ntBCx/GbGBcdLnpM98izP5fcdbyEA
         f90Eo8iVCbIWNet6FOwE/A81cfOr+bCXhGse7YtVPb+qZ8u0PgNGayZVgGPv6IvWnASF
         +4gAx5gq0lxCUzreHCx9jPl0wSb6E34RMe40vtuYM5oTBecyF7CyxJkta16Cb1VygFDa
         D4kwwYYWCB93FlziMMseZhD6dWGQwfM9ZiDxFtri5av8SakrEEp99RG1Apr5A/s5u14i
         cSFQ==
X-Gm-Message-State: AOAM5339LZI2ElCH6pzns412m8gWvP6QE8IZ0xtvgRg5QfOcSpF6wrO/
        HeggixuUxFPvb/1HugZ5CS/VGANecql7sX0vvnk=
X-Google-Smtp-Source: ABdhPJy7J3kPzMh3zGdCCagbfKmYuXjzWcE8v2f7kXswi1R/nTTBK/UC4hqgkaKir+RL0Wu6Iy0fT3HByLTjqEq1cT8=
X-Received: by 2002:a25:fe10:0:b0:625:262f:e792 with SMTP id
 k16-20020a25fe10000000b00625262fe792mr25846281ybe.365.1647947526731; Tue, 22
 Mar 2022 04:12:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220320062907.3272903-1-rajatja@google.com> <YjmQq1DvWnJwUh6R@infradead.org>
In-Reply-To: <YjmQq1DvWnJwUh6R@infradead.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 22 Mar 2022 12:11:54 +0100
Message-ID: <CAJZ5v0h9TnUELahzkO59Vqoio1QRHfixk58Yxgffa72rmEBgOA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] PCI: Rename "pci_dev->untrusted" to "pci_dev->poses_dma_risk"
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Rajat Jain <rajatja@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
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
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 22, 2022 at 10:02 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Sat, Mar 19, 2022 at 11:29:05PM -0700, Rajat Jain wrote:
> > Rename the field to make it more clear, that the device can execute DMA
> > attacks on the system, and thus the system may need protection from
> > such attacks from this device.
> >
> > No functional change intended.
> >
> > Signed-off-by: Rajat Jain <rajatja@google.com>
> > ---
> > v4: Initial version, created based on comments on other patch
>
> What a horrible name.  Why not untrusted_dma which captures the
> intent much better?

FWIW, I like this one much better too.
