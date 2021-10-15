Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58BA342F988
	for <lists+linux-pci@lfdr.de>; Fri, 15 Oct 2021 19:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241912AbhJORC4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Oct 2021 13:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241913AbhJORCz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Oct 2021 13:02:55 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF1BC061762
        for <linux-pci@vger.kernel.org>; Fri, 15 Oct 2021 10:00:49 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id c29so8897108pfp.2
        for <linux-pci@vger.kernel.org>; Fri, 15 Oct 2021 10:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jF4jHoYzXRfAp0AFeX4Tm5QMnIONmjbOZG0j/mO6PpA=;
        b=tHgr7ztCtICyAqlWDKF/9WPJIMWOtDlufRYsILD9zwTCoqMyxTiR7/N/iy7LJqEfLO
         39MoBsXkJJ1FB2ITk68xUjAV2RELD7Og5kK3VEpQPadTU1JaW/clKUJu4ZY6OOErbtmJ
         ePvdg49Jb4NFDmKFCUGmV1bkJTbnvv0LjvmkX7CieLlXT9Tc6+cMZ6l9J2CN92e1TR8X
         QvHcOonuoqqN93XQhpej53e38h5yGBQuI0B92tLfcVvrEJNI8sjjRTqpsDfCFesVU0h4
         dBVlqD0XGthStZtBBVpfGWNfcGSgycSTKLQ9WlvHhNrCIqk2bLmIaZAYvhfaIhkT4AuC
         Ofjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jF4jHoYzXRfAp0AFeX4Tm5QMnIONmjbOZG0j/mO6PpA=;
        b=0WQQbfcScyJeKZB7QEtnTTzL03w/Eh/9IfyjbhpCUSjBTNnVZjfsSrqg40zMbnXXKh
         CkSCl1jsvcaEQ28PTTAhEgyGtytnHDtJ7e5jzsCYZkBdrQ8oM0/PK41WQCQKI2HZC9RX
         319c0+zCwH/BfSYYoJjq23Z4FF1Odg5WzgVgGrQGFFtFuZx4yzGs7ltddZB27BxnqOmr
         f5D2CjvOO7k6QnpIGKh1GqcZx4R5DMPKIYFywdQuRtu4xN80a/h1HMr1E+2W6cD7HlPW
         NqfU1D6wctLds++QOkude3bLuETUp8skQvvNKNSQwteq3rM6JyjzP/xL8cE41znMQQjn
         3g3g==
X-Gm-Message-State: AOAM531v4RJv7MSDMO5/q88ulevXTlUWf5WhPa0unVWVG/JrBMssyO0o
        hktCGRE4YjuiFs1VSI0XJmRLv3GI8EkZgYHZJHmg6nqtU4R82w==
X-Google-Smtp-Source: ABdhPJxm6XOBVS2DLDFuWRQ3Jj2/R5KOCBDTtJpAU5GbLzbinkgRN+Sb/AR0rE9FfKaKYcvX0c7LbT9DSozPQS+rQHc=
X-Received: by 2002:a63:6bc2:: with SMTP id g185mr5128723pgc.356.1634317248490;
 Fri, 15 Oct 2021 10:00:48 -0700 (PDT)
MIME-Version: 1.0
References: <163379783658.692348.16064992154261275220.stgit@dwillia2-desk3.amr.corp.intel.com>
 <163379787433.692348.2451270397309803556.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20211015174433.0000368a@Huawei.com>
In-Reply-To: <20211015174433.0000368a@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 15 Oct 2021 10:00:39 -0700
Message-ID: <CAPcyv4jro2amDzsgZM6i9Ukh_SuZ0x+Yk1c6JmxxNfoYQO5rOQ@mail.gmail.com>
Subject: Re: [PATCH v3 07/10] cxl/pci: Split cxl_pci_setup_regs()
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 15, 2021 at 9:44 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Sat, 9 Oct 2021 09:44:34 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
>
> > From: Ben Widawsky <ben.widawsky@intel.com>
> >
> > In preparation for moving parts of register mapping to cxl_core, split
>
> Ah. Guess this planned move is why the naming change in the earlier patch.
> Fair enough, but perhaps call it out there as well as here.
>
> No comments to add to this one.
>
> > cxl_pci_setup_regs() into a helper that finds register blocks,
> > (cxl_find_regblock()), and a generic wrapper that probes the precise
> > register sets within a block (cxl_setup_regs()).
> >
> > Move the actual mapping (cxl_map_regs()) of the only register-set that
> > cxl_pci cares about (memory device registers) up a level from the former
> > cxl_pci_setup_regs() into cxl_pci_probe().
> >
> > With this change the unused component registers are no longer mapped,
> > but the helpers are primed to move into the core.
> >
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > [djbw: rebase on the cxl_register_map refactor]
> > [djbw: drop cxl_map_regs() for component registers]
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> > ---
> >  drivers/cxl/pci.c |   73 +++++++++++++++++++++++++++--------------------------
> >  1 file changed, 37 insertions(+), 36 deletions(-)
> >
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > index b42407d067ac..b6bc8e5ca028 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/pci.c
> > @@ -433,72 +433,69 @@ static void cxl_decode_regblock(u32 reg_lo, u32 reg_hi,
> >  }
> >
> >  /**
> > - * cxl_pci_setup_regs() - Setup necessary MMIO.
> > - * @cxlm: The CXL memory device to communicate with.
> > + * cxl_find_regblock() - Locate register blocks by type
> > + * @pdev: The CXL PCI device to enumerate.
> > + * @type: Register Block Indicator id
> > + * @map: Enumeration output, clobbered on error
> >   *
> > - * Return: 0 if all necessary registers mapped.
> > + * Return: 0 if register block enumerated, negative error code otherwise
> >   *
> > - * A memory device is required by spec to implement a certain set of MMIO
> > - * regions. The purpose of this function is to enumerate and map those
> > - * registers.
> > + * A CXL DVSEC may additional point one or more register blocks, search
>
> may point to one or more...
> (perhaps - I'm not quite sure of the intended meaning)

Yeah, that looks like it should be:

s/may additional point one/may point to one/

I'll clean that up.
