Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8643F4DDFAA
	for <lists+linux-pci@lfdr.de>; Fri, 18 Mar 2022 18:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239532AbiCRRPE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Mar 2022 13:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239160AbiCRRPD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Mar 2022 13:15:03 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B1D2BC7
        for <linux-pci@vger.kernel.org>; Fri, 18 Mar 2022 10:13:43 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id z16so10025078pfh.3
        for <linux-pci@vger.kernel.org>; Fri, 18 Mar 2022 10:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g/GutwBJVZBDT4ZVpQlKfjM8i6ASlMzT8ih0C1p3e3k=;
        b=blpcAdIPW3F08OxKyQJJrpHUC2s+UYBMU5vzcrkGgac39jt6Ud4Hk0Gt5irraCU6ob
         w8GN4C9ctPWo10eE1jofVkgGgZSTFoCGzJAREiw6AKRL9NnqseojQwCTh1gjfqizOP7f
         abpIDzqYsILDAFuGO5DKl2u8kFDLfS1lcmwrkaBdh+1ZTnLu8St7Kj8GYQXd2KGn7beJ
         LbGAUzJpfilO6hobiI5OAuokwNI0YCQFafSOHO8A732+gkZ6aj0hC7lzKskHTneuCxpn
         XYt+j+fUIwnkhFge1DotlDdIcQPkO9TcZ7M8yAakzw0t719UzI247KdN36stiqYsa0ye
         40KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g/GutwBJVZBDT4ZVpQlKfjM8i6ASlMzT8ih0C1p3e3k=;
        b=WzYhasGO0mk7GtMsN1hFx8vZam4QgGpsRIA5UE+IfV79ybNMLFDXDthWGSi9JHfmlU
         EOhskuky8mpmn+5wZbOrUezCBjQg70sQ4LcXA70Vfc0y5XFKKaxuVTGLFadQ39zs3i4A
         4OZJB+d2POxd3fHC/c2TQHCP7dXkc59KwS0qXE+ngfCb+8LB/fmDcIaQsgtzB6CoPoHh
         hhEWak4iprsSP0txe/VpXLsgTPvf1eqID73Jhsi/4yeulgvz2hOhG+y94ObPFWg7nAWs
         myWMyuWpdOLreuSiYbUZVasvs+Fj0MwtWMa55yfCFXs0ra4brkaKCAmrP/7YRIhrdhU4
         SotA==
X-Gm-Message-State: AOAM532r8vnhKqD77tjOycLuxIZBowyaWM/9/B3LtCMm6qDIhwUjz8uc
        3eo4IpCespIAddXkZcY3Mpx50jecDUac+3kTWcHEKQ==
X-Google-Smtp-Source: ABdhPJxH0FGfFKt283r5GUdkvrdhnVUMzxTWmOGe9MV0ft0KmCjPEMJnALJmM7RuLWZAjhy5nyVCk5mYcOk9jMhNEkc=
X-Received: by 2002:a63:5c53:0:b0:381:309e:e72c with SMTP id
 n19-20020a635c53000000b00381309ee72cmr8673934pgm.40.1647623623502; Fri, 18
 Mar 2022 10:13:43 -0700 (PDT)
MIME-Version: 1.0
References: <164740402242.3912056.8303625392871313860.stgit@dwillia2-desk3.amr.corp.intel.com>
 <164740403286.3912056.2514975283929305856.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20220317100757.00005f2b@Huawei.com>
In-Reply-To: <20220317100757.00005f2b@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 18 Mar 2022 10:13:33 -0700
Message-ID: <CAPcyv4iEMw7pd2ZdYEK48Pj-Er72thkcKCUmCoBOTzcg_rZrcw@mail.gmail.com>
Subject: Re: [PATCH 2/8] cxl/pci: Cleanup cxl_map_device_regs()
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 17, 2022 at 3:08 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Tue, 15 Mar 2022 21:13:52 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
>
> > Use a loop to reduce the duplicated code in cxl_map_device_regs(). This
> > is in preparation for deleting cxl_map_regs().
> >
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Trivial style comments inline.  Otherwise LGTM
>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> > ---
> >  drivers/cxl/core/regs.c |   51 ++++++++++++++++++-----------------------------
> >  1 file changed, 20 insertions(+), 31 deletions(-)
> >
> > diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> > index bd6ae14b679e..bd766e461f7d 100644
> > --- a/drivers/cxl/core/regs.c
> > +++ b/drivers/cxl/core/regs.c
> > @@ -211,42 +211,31 @@ int cxl_map_device_regs(struct pci_dev *pdev,
> >                       struct cxl_device_regs *regs,
> >                       struct cxl_register_map *map)
> >  {
> > +     resource_size_t phys_addr =
> > +             pci_resource_start(pdev, map->barno) + map->block_offset;
>
> I'm not totally convinced by this refactoring as it's ugly either
> way...  Still your code, and I don't care that strongly ;)

Fair enough, but isn't there intrinsic beauty in a diff that deletes
more code than it adds?

The cleaner aspect to me is that the RAS Capability Structure support
can be added with a one line change rather than a new if block in
cxl_map_component_regs().

>
> >       struct device *dev = &pdev->dev;
> > -     resource_size_t phys_addr;
> > -
> > -     phys_addr = pci_resource_start(pdev, map->barno);
> > -     phys_addr += map->block_offset;
> > -
> > -     if (map->device_map.status.valid) {
> > -             resource_size_t addr;
> > +     struct mapinfo {
> > +             struct cxl_reg_map *rmap;
> > +             void __iomem **addr;
> > +     } mapinfo[] = {
> > +             { .rmap = &map->device_map.status, &regs->status, },
>
> Combining c99 style .rmap for first parameter and then not doing it
> for the second is a bit odd looking.  Was there a strong reason for
> doing this?  I'd just drop the ".rmap =" as it's not as though
> we need to look far to see what it's setting.

Good catch, yeah, not sure why I typed it that way, will fix.
