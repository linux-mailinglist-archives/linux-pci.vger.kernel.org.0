Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2434EB6BF
	for <lists+linux-pci@lfdr.de>; Wed, 30 Mar 2022 01:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiC2X3x (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Mar 2022 19:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiC2X3w (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Mar 2022 19:29:52 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D792D186F8A
        for <linux-pci@vger.kernel.org>; Tue, 29 Mar 2022 16:28:08 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id y16so6199894pju.4
        for <linux-pci@vger.kernel.org>; Tue, 29 Mar 2022 16:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fumKJ517NWCBVyjN2meVqb1HuI+Id6ZlkDRB9tEmcTk=;
        b=2zKTrFVO0nPiUFWP78YpFBL46t3sRAgjtrrIF7HTGDsWcd0PdjnWQ9eDyLfkUv8F9/
         mKPnIOtu6Xax9zg5PdkCrtz7Uhn4xxPOL1EyqPTtFHQHrOKNJzwGsfDyCoes6UJYvZ7t
         wJVyQhPyekARlB0pSimoimrHmXYIIx3Bd9InX4bJ8tr2CUab0tITb/NF93ixw0vT3l59
         aaHGQsgdadf2MxAWfIPZ+3fZ5VJnOb6KvNRMO1h6FXXJNq0jBqLRmp+XoDo3WlMWwc5S
         w7lViG+aDpmXvwrMvoHwMJltS2I91lD42BSxitsyb4wj4HQdFfOOQpcMO1d7+V+ZOJY4
         gDOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fumKJ517NWCBVyjN2meVqb1HuI+Id6ZlkDRB9tEmcTk=;
        b=lYkUp4SgYfovt2TODl6QokahUPWsMVJ3ZZVhvQiMxgfcRBBvWQOXMTHOLgLHH87wo4
         qfeKx+DTomZSW+SaOGI3w2NHQUbiXz6/Aq4FcKnhzboCYtmBsJMyziJE1uv0hxefQals
         HAMUJRYOSDSjYbN9AjdMT5aJmIeZaVRRQ8mRtW/YsxQoD1pV5/UeVXS6Bbw/MnjDGZnD
         F94Si5dlfMfXl7fFPyry0MLXXbZYV+RCTPwFTZ+Df7Z5Sm8gf6OX0HwZLtKwdHFLaRxc
         RL8ibKAarfMkqs+k9109uqOlXyAswIjzMaT+9AIr//E/ZcN2l+NEo21L9i6mDus2Q3P0
         CZ2Q==
X-Gm-Message-State: AOAM533FaHX3rl7bDb3yTCJ+0WFS4NKjIB5qXaPPgdixMQm+fihL437J
        Jd1OzW7Szs48tWc0slytau761D3TD2zYNZ0H3LQtiQ==
X-Google-Smtp-Source: ABdhPJy2eG1kgcrctpwFc4ZE+JOAMU0NLxfMFUI03K3yJ8wC0uNWggng71O2nvEJMyG91UEXAqZlkUX144MfajXhLOI=
X-Received: by 2002:a17:90a:c083:b0:1c6:a164:fd5d with SMTP id
 o3-20020a17090ac08300b001c6a164fd5dmr1669554pjs.8.1648596488391; Tue, 29 Mar
 2022 16:28:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220316155103.8415-1-nirmal.patel@intel.com> <6b2b0c52-4b01-db11-1c89-ab291ae633b3@linux.intel.com>
In-Reply-To: <6b2b0c52-4b01-db11-1c89-ab291ae633b3@linux.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 29 Mar 2022 16:27:57 -0700
Message-ID: <CAPcyv4hUVZEXyEW0C5rU5rkyMwBYbc4-Pq7A7aMz0GQr8d7NoA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] PCI: vmd: Assign VMD IRQ domain before enumeration
To:     "Patel, Nirmal" <nirmal.patel@linux.intel.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Jon Derrick <jonathan.derrick@linux.dev>,
        Nirmal Patel <nirmal.patel@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 29, 2022 at 3:48 PM Patel, Nirmal
<nirmal.patel@linux.intel.com> wrote:
>
> On 3/16/2022 8:51 AM, Nirmal Patel wrote:
> > From: Nirmal Patel <nirmal.patel@linux.intel.com>
> >
> > VMD creates and assigns a separate IRQ domain only when MSI remapping is
> > enabled. For example VMD-MSI. But VMD doesn't assign IRQ domain when
> > MSI remapping is disabled resulting child devices getting default
> > PCI-MSI IRQ domain. Now when interrupt remapping is enabled by
> > intel-iommu all the PCI devices are assigned INTEL-IR-MSI domain
> > including VMD endpoints. But devices behind VMD get PCI-MSI IRQ domain
> > when VMD create a root bus and configures child devices.
> >
> > As a result DMAR errors were observed when interrupt remapping was
> > enabled on Intel Icelake CPUs. For instance:
> >
> >   DMAR: DRHD: handling fault status reg 2
> >   DMAR: [INTR-REMAP] Request device [0xe2:0x00.0] fault index 0xa00 [fault reason 0x25] Blocked a compatibility format interrupt request
> >
> > Acked-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
> > ---
> >  drivers/pci/controller/vmd.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> > index cc166c683638..3a6570e5b765 100644
> > --- a/drivers/pci/controller/vmd.c
> > +++ b/drivers/pci/controller/vmd.c
> > @@ -853,6 +853,8 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
> >       vmd_attach_resources(vmd);
> >       if (vmd->irq_domain)
> >               dev_set_msi_domain(&vmd->bus->dev, vmd->irq_domain);
> > +     else
> > +             dev_set_msi_domain(&vmd->bus->dev, dev_get_msi_domain(&vmd->dev->dev));
> >
> >       vmd_acpi_begin();
> >
>
> Gentle ping!

It helps to be explicit when you send a patch and a follow-up ping.
Are you asking Lorenzo to take this? Is this urgent such that Bjorn
should consider taking it directly? The changelog notes what happens,
but not the severity of end user visible impact. The merge window is
presently open so the natural inclination is to just wait until that
closes to circle back to outstanding patches.
